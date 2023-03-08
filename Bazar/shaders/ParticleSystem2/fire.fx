#include "common/TextureSamplers.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/softParticles.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

Texture3D	fireTex;

float4x4	World;
float2		params0;

#define		vertSpeedMin	params0.x
#define		vertSpeedMax	params0.y

static const float zFeather = 1.0 / 0.2;

static const float3 fireTint = float3(1.0, 0.655, 0.4455);
static const float3 fireTintCold = float3(1.0, 0.4655, 0.3355);

TEXTURE_SAMPLER(fireTex, MIN_MAG_MIP_LINEAR, MIRROR, CLAMP);

struct VS_OUTPUT
{
	float4 pos		: POSITION0;
	float4 params	: TEXCOORD0; // UV, transparency
	float3 speed	: TEXCOORD1;
};

struct PS_INPUT
{
	float4 pos		 : SV_POSITION0;
	float4 projPos	 : TEXCOORD0;
	float4 TextureUV : TEXCOORD1; // UV, transparency, cloudsTransparency
};

VS_OUTPUT VS(float4 params		: TEXCOORD0,
			 float4 params1		: TEXCOORD1,
			 float  lifetime	: TEXCOORD2)
{
	float3 RAND				= params.xyz;
	float AGE				= params.w; //время жизни партикла в секундах
	float3 WIND				= params1.xyz;
	float scale				= params1.w;
	
	WIND.xz *= 0.3;

	float3 sphereRand = normalize(float3(RAND.y-0.5, noise1D(RAND.x)-0.5, RAND.z-0.5)) * 0.5;//рандом в единичной сфере
	float nDist = saturate(1-length(sphereRand.xz)*2);

	VS_OUTPUT o;
	o.pos.xyz = mul(float4(sphereRand, 0), World) - worldOffset;
	o.pos.y += (vertSpeedMax-vertSpeedMin) * (AGE * nDist);
	o.pos.xyz += WIND * AGE;
	
	//вычисляем угол, на который надо довернуть плашку, штобы она была ориентирована по вектору скорости
	float2 velScreenProj = mul(-WIND, VP).xy;
	o.pos.w = atan2(velScreenProj.y, velScreenProj.x) - halfPI; //angle
	o.params = float4(AGE / lifetime, step(0.5, RAND.x), scale*(1+1*nDist), RAND.x);

    return o;
}


// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream, uniform bool bClouds)
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

	float4x4 mBillboard = billboard(posOffset, scaleBase, angle);
	
	mBillboard = mul(mBillboard, VP);

	[unroll]
	for (int i = 0; i < 4; i++)
	{
		o.TextureUV.xy = float2(staticVertexData[i].z + Rand, staticVertexData[i].w);

		float4 vPos = {staticVertexData[i].x, staticVertexData[i].y - 0.28, 0, 1};

		o.projPos = o.pos = mul(vPos, mBillboard);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 PS(PS_INPUT i) : SV_TARGET0
{
	// return 1;
	float4 clr = TEX3D(fireTex,  i.TextureUV);	clip(clr.a-0.04);

	clr.rgb *= lerp(fireTintCold*fireTintCold, fireTint*fireTint, min(1, clr.a*1.5)) * 1.0;
	clr *= i.TextureUV.w;
	// clr.a *= depthAlpha(i.projPos, zFeather);

	return clr;
}

VertexShader	vsCompiled = CompileShader(vs_4_0, VS());
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
