#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/context.hlsl"
#include "common/random.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"

static const float LODdistance = 1200;

float	scaleBase;
float4	smokeColor; 	// color of smoke, w - opacity
float	effectLifetime; // current time of lifetime	 

#define opacityMax smokeColor.w

float4x4 World;

TEXTURE_SAMPLER(tex, MIN_MAG_MIP_LINEAR, MIRROR, CLAMP);

struct VS_OUTPUT
{
    float4 pos	: POSITION;
    float4 params:TEXCOORD0; // UV, transparency, alphaMult
};

struct PS_INPUT
{
    float4 pos		 : SV_POSITION;
    float3 TextureUV : TEXCOORD0; // UV, transparency, alphaMult
	nointerpolation float3 sunDirM : TEXCOORD1;
	nointerpolation float3 sunColor: TEXCOORD2;
};

VS_OUTPUT VS(float4 params		: TEXCOORD0, // UV, random[0..1], age
			 float4 params2		: TEXCOORD1,
			 float4 params3		: TEXCOORD2) //
{
	#define lifetime params2.w
	#define DIR params2.xyz
	#define DIST params.x
	#define ANGLE params.y
	#define RAND params.z
	#define birthtime params.w
	#define speedValue params3.w
	#define ORIGIN params3.xyz

	float AGE = effectLifetime - birthtime;
	const float nAge = abs(AGE / lifetime);	

	const float deceleration = 1.0;
	
	float2 rnd = noise2(float2(RAND, RAND+3.267812384))*0.5+0.5;

	//     XZ
	float _sin, _cos;
	sincos(ANGLE*PI2, _sin, _cos );

	//     Y
	const float ageCap = min(AGE, speedValue/deceleration);

	float3 posOffset = DIR * ((speedValue - 0.5*deceleration*ageCap)*ageCap - (RAND-0.5)*2*scaleBase);
	posOffset += ORIGIN - worldOffset;

	// random change of y position
	const float yMaxOffset = 0.8;
	posOffset.y += nAge*nAge * (0.5+rnd.x*0.5) * yMaxOffset;

	posOffset += DIST * float3(0, _sin, _cos) * nAge*nAge;

	float scaleFactor = 1 + (3 + rnd.y*0.5 + rnd.x*1 + DIST*5) * pow(nAge, 3);
	float scale = scaleBase * scaleFactor;

	VS_OUTPUT o;
	o.pos = float4(posOffset, PI * 2 * RAND);
	o.params.xy = float2(scale, RAND);

	const float startOpacity = saturate(4*nAge) * opacityMax;
	// opacity depends on the change of original scale - because of reducing density of material
	o.params.w = startOpacity / (scaleFactor * scaleFactor);
	o.params.w *= 1.0 - pow(nAge, 2);
	o.params.z = nAge;
	return o;
}

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	#define posOffset input[0].pos.xyz
	#define angle input[0].pos.w
	#define scale input[0].params.x
	#define Rand input[0].params.y
	#define nAge input[0].params.z

	PS_INPUT o;
	o.TextureUV.z = input[0].params.w; 

	float4 uvOffsetScale = getTextureFrameUV16x8(Rand, 25);

	float4x4 mBillboard = mul(billboard(posOffset, scale, angle), VP);

	// gets sun info
	o.sunColor = getPrecomputedSunColor(0);
	o.sunDirM = -getSunDirInNormalMapSpace(rotMatrix2x2(angle));

	[unroll]
	for (int i = 0; i < 4; i++)
	{
		o.TextureUV.xy = float2(staticVertexData[i].z, staticVertexData[i].w);
		o.TextureUV.xy *= uvOffsetScale.xy;
		o.TextureUV.xy += uvOffsetScale.zw;	

		float4 vPos = {staticVertexData[i].x, staticVertexData[i].y, 0, 1};
		o.pos = mul(vPos, mBillboard);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();                          
}

float4 PS(PS_INPUT i) : SV_TARGET0
{
	#define OPACITY i.TextureUV.z 
	float4 data = TEX2D(tex, i.TextureUV).rgba;  // normal + alpha
	data.xyz = data.xyz * 2 - 1.0;// convert from compressed format [0, 255] -> [-1.0, 1.0]

	data.a *= OPACITY;
	clip(data.a - 0.001);

	float NoL = saturate(dot(data.xyz, i.sunDirM.xyz)*0.4+0.6);

	float3 finalColor = shading_AmbientSun(smokeColor, AmbientTop, i.sunColor*NoL/PI);

	return float4(applyPrecomputedAtmosphere(finalColor, 0), data.a);
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

float4 PS_FLIR(PS_INPUT i) : SV_TARGET0
{
	#define OPACITY i.TextureUV.z 
	float4 data = TEX2D(tex, i.TextureUV).rgba;  // normal + alpha
	data.xyz = data.xyz * 2 - 1.0;// convert from compressed format [0, 255] -> [-1.0, 1.0]

	data.a *= OPACITY;
	clip(data.a - 0.001);

	float l = luminance(applyPrecomputedAtmosphere(smokeColor, 0));
	return float4(l, l, l, data.a);

}

float4  PS_solid(PS_INPUT i) : SV_TARGET0
{
	return float4(i.TextureUV.z, i.TextureUV.z, i.TextureUV.z, 0.2);
}

technique10 Textured
{
	pass P0
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PS()) 
	}

		pass P0FLir
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PS_FLIR()) 
	}
}
