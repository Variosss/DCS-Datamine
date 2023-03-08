#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/stencil.hlsl"

#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/noiseSimplex.hlsl"

Texture3D	texFoam;
float4		uParams;

#define speedMin			uParams.x
#define speedMax			uParams.y
#define power				uParams.z
#define effectLifetimeInv	uParams.w

static const float nPower = power/4.0;

struct VS_OUTPUT
{
	float4 pos:		POSITION0;
	float4 speed:	TEXCOORD1;//speed dir and scalar
	float2 params:	TEXCOORD0; // UV, transparency, alphaMult
};

struct PS_INPUT
{
	float4 pos:							SV_POSITION0;
	float2 uv:							TEXCOORD0; // UV, transparency, alphaMult
	nointerpolation float4 params2:		TEXCOORD1;
	nointerpolation float3 sunColor: 	TEXCOORD2;
};

VS_OUTPUT VS(float4 params:		TEXCOORD0, //startSpeedDir, startSpeedValue
			 float3 params2:	TEXCOORD1) // ��������� ������� �������� � ������� ��
{
	float RAND1		= params2.x;
	float RAND2		= params2.y;
	float AGE		= params2.z;

	float _sin, _cos; 
	sincos(RAND2*PI2*14.32, _sin, _cos );

	float3 startPos = float3(_sin, 0, _cos)*RAND2*power;
	
	VS_OUTPUT o;
	o.pos = float4(startPos - worldOffset, AGE);
	o.speed = params;
	o.params.x = AGE * effectLifetimeInv;
	o.params.y = RAND1;
	return o;
}

//main
#define particlesCount 10
#define GSname gsMain
#include "waterExplosion.hlsl"
#undef GSname
#undef particlesCount
//lod
#define LOD
#define particlesCount 3
#define GSname gsLod
#include "waterExplosion.hlsl"

float4 psWaterExplosion(PS_INPUT i, uniform bool bLod): SV_TARGET0
{
	float	_sin		= i.params2.x;
	float	_cos		= i.params2.y;
	float	OPACITY 	= i.params2.w;
	float	LERP_FACTOR = i.params2.z;
	
	float4 norm = tex.Sample(ClampLinearSampler, i.uv);
	clip(norm.a-0.1);

	norm.xyz = norm.xyz*2-1;
	norm.z *= 0.5;
	if(!bLod)
		norm.xy = float2( norm.x*_cos - norm.y*_sin, norm.x*_sin + norm.y*_cos );

	float light = dot(normalize(norm.xyz), gSunDirV.xyz)*0.5+0.5;

	float4 color = 1;
	color.a = norm.a * lerp(1, texFoam.Sample(gTrilinearWrapSampler, float3(i.uv, LERP_FACTOR)).r, LERP_FACTOR) * OPACITY;

	color.rgb = shading_AmbientSun(0.8, AmbientAverage, i.sunColor * max(0, light) / PI);

	return color;
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

float4 psFlir(PS_INPUT i): SV_TARGET0
{
	float	_sin		= i.params2.x;
	float	_cos		= i.params2.y;
	float	OPACITY 	= i.params2.w;
	float	LERP_FACTOR = i.params2.z;
	
	float4 norm = tex.Sample(ClampLinearSampler, i.uv);
	clip(norm.a-0.1);

	float light = dot(normalize(norm.xyz), gSunDirV.xyz)*0.5+0.5;


	float4 color = 1;
	color.a = norm.a * lerp(1, texFoam.Sample(gTrilinearWrapSampler, float3(i.uv, LERP_FACTOR)).r, LERP_FACTOR) * OPACITY;

	color.rgb *= float3(0.53, 0.72, 0.93);
	float l = luminance(color)/4.0;
	return float4(l, l, l, color.a);
}

technique10 Textured
{
	pass main
	{
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(gsMain())
		PIXEL_SHADER(psWaterExplosion(false))
	}
	pass lod
	{
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(gsLod())
		PIXEL_SHADER(psWaterExplosion(true))
	}
	pass flir
	{
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(gsLod())
		PIXEL_SHADER(psFlir())
	}

	pass flir_lod
	{
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(gsLod())
		PIXEL_SHADER(psFlir())
	}
}
