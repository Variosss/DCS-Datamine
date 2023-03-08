#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "common/softParticles.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

float4x4 World;
float gPower;
float3 fireTint;
float4 exhaustDir;
float curTime; // particle system current time
float3 fireTintCold;

Texture3D fireTex;

static const float zFeather = 1.0 / 0.2;

TEXTURE_SAMPLER(fireTex, MIN_MAG_MIP_LINEAR, MIRROR, CLAMP);

struct VS_OUTPUT
{
	float4 pos	: POSITION;
	float4 params: TEXCOORD0; // UV, transparency
};

struct PS_INPUT
{
	float4 pos		 : SV_POSITION;
	float4 projPos	 : TEXCOORD0;
	float4 TextureUV : TEXCOORD1; // UV, transparency, cloudsTransparency
};

VS_OUTPUT VS(float4 params		: TEXCOORD0, // UV, random[0..1], age
			 float4 startPos	: TEXCOORD1, 
			 float4 startSpeedIn: TEXCOORD2, 
			 float3 params2		: TEXCOORD3, 
			 float3 addSpeed	: TEXCOORD4,
			 uniform bool bExhaustPipe = false)
{
	float BIRTH_TIME = params.x;
	float lifetime = params.y;
	float POWER = params.z;
	float ANGLE = params.w;
	float RAND				= startSpeedIn.w;
	float3 WIND				= params2.xyz;
	float convectionSpeed	= params2.y;
	float AGE = curTime - BIRTH_TIME;
	float relativeTmpSpeed = length(startSpeedIn.xyz + addSpeed - float3(WIND.x, 0, WIND.y));
	const float nConv = 1-saturate(relativeTmpSpeed*3.6/60);
	WIND.y *= nConv;

	float3 emitterSpeedTrue = startSpeedIn.xyz;
	float3 emitterSpeedRelative = startSpeedIn.xyz - WIND;
	float3 particleSpeedRelative = emitterSpeedRelative + addSpeed;
	float  speedValueRelative = length(particleSpeedRelative);
	float  addSpeedValue = length(addSpeed);
	float3 exhaustSpeed = exhaustDir * (0.4 + 0.25 * POWER) * (1 + addSpeedValue*0.1);

	float translation = 0;
	if(bExhaustPipe)
		translation = speedValueRelative * AGE;	
	else
	{
		 float deceleration = lerp(25,400, speedValueRelative/555.5);
		const float ageCap = min(AGE, speedValueRelative/deceleration);
		translation = (speedValueRelative - 0.5*deceleration*ageCap)*ageCap;
	}

	float3 sphereRand = normalize(float3(RAND-0.5, noise1D(ANGLE)-0.5, noise1D(RAND)-0.5))*0.5;
	sphereRand = 0;

	VS_OUTPUT o;
	o.pos.xyz = startPos.xyz +normalize(particleSpeedRelative)*translation + mul(float4(sphereRand*1.15, 0), World) + WIND*AGE - worldOffset  ;
	
	if(bExhaustPipe)
	 	o.pos.xyz += exhaustSpeed * sqrt(AGE);


	//float2 speedScreenProj = mul(-emitterSpeedTrue, VP).xy;
	float2 speedScreenProj;
	 //= mul(emitterSpeedTrue-addSpeed-WIND - (bExhaustPipe? exhaustSpeed : 0), VP).xy;
	//float2 speedScreenProj = mul(emitterSpeedTrue, VP).xy;
	if (bExhaustPipe)
		speedScreenProj = mul(-exhaustDir, VP);
	else 
		speedScreenProj = mul(emitterSpeedTrue-addSpeed-WIND - (bExhaustPipe? exhaustSpeed : 0), VP).xy;

	//o.pos.w = atan2(speedScreenProj.y, speedScreenProj.x) - halfPI; //angle
	o.pos.w = atan2(speedScreenProj.y, speedScreenProj.x) - halfPI; //angle
	o.params = float4(AGE / lifetime, step(0.5, RAND), startPos.w, POWER);

    return o;
}


// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream, uniform bool bClouds, uniform bool bExhaustPipe = false)
{
	float3 posOffset = input[0].pos.xyz;
	float angle		 = input[0].pos.w;
	float age		 = input[0].params.x;
	float Rand		 = input[0].params.y;
	float scaleBase	 = input[0].params.z;
	float power	 	 = input[0].params.w;

	PS_INPUT o;
	o.TextureUV.z = sqrt(age);
	o.TextureUV.w = bClouds ? getAtmosphereTransmittance(0).r : 1;
	if(bExhaustPipe)
		o.TextureUV.w *= min(1, power) * saturate((1.2-power*0.15));
	//scaleBase = 0.1;
	float4x4 mBillboard = mul(billboard(posOffset, scaleBase, angle), VP);
	//float4x4 mBillboard = mul(billboardOverSpeed(posOffset, exhaustDir, scaleBase), VP);
	float2x2 Mrot = rotMatrix2x2(1.5);

	[unroll]
	for (int i = 0; i < 4; i++)
	{
		o.TextureUV.xy = float2(staticVertexData[i].z + Rand, staticVertexData[i].w);

		float4 vPos = {staticVertexData[i].x, staticVertexData[i].y - 0.28, 0, 1};
		//vPos.xy = mul(vPos.xy, Mrot);
		o.projPos = o.pos = mul(vPos, mBillboard);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 PS(PS_INPUT i) : SV_TARGET0
{
	float4 clr = TEX3D(fireTex,  i.TextureUV);	
	clip(clr.a-0.04);

	clr.rgb *= lerp(fireTintCold, fireTint, min(1, clr.a*1.5)) *1.5 * gPower;
	clr *= i.TextureUV.w;
	clr.a *= depthAlpha(i.projPos, zFeather)*2;

	return clr;
}

float4  PS_solid(PS_INPUT i) : SV_TARGET0
{
	return float4(i.TextureUV.z, i.TextureUV.z, i.TextureUV.z, 0.2);
}

VertexShader	vsCompiled = CompileShader(vs_4_0, VS());
VertexShader	vsPipeCompiled = CompileShader(vs_4_0, VS(true));
PixelShader		psCompiled = CompileShader(ps_4_0, PS());

technique10 Textured
{
	pass main
	{
		SetVertexShader(vsCompiled);
		GEOMETRY_SHADER(GS(false))
		SetPixelShader(psCompiled);
		
		ENABLE_RO_DEPTH_BUFFER;
		ADDITIVE_ALPHA_BLEND;
		DISABLE_CULLING;
	}
	pass withClouds
	{
		SetVertexShader(vsCompiled);
		GEOMETRY_SHADER(GS(true))
		SetPixelShader(psCompiled);
		
		ENABLE_RO_DEPTH_BUFFER;
		ADDITIVE_ALPHA_BLEND;
		DISABLE_CULLING;
	}
}

technique10 PipeFireTech
{
	pass main
	{
		SetVertexShader(vsPipeCompiled);
		GEOMETRY_SHADER(GS(false, true))
		SetPixelShader(psCompiled);
		
		ENABLE_RO_DEPTH_BUFFER;
		ADDITIVE_ALPHA_BLEND;
		DISABLE_CULLING;
	}
	pass withClouds
	{
		SetVertexShader(vsPipeCompiled);
		GEOMETRY_SHADER(GS(true, true))
		SetPixelShader(psCompiled);
		
		ENABLE_RO_DEPTH_BUFFER;
		ADDITIVE_ALPHA_BLEND;
		DISABLE_CULLING;
	}
}

