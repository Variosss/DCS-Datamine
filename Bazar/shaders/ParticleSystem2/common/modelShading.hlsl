#ifndef _MODEL_SHADING_HLSL_
#define _MODEL_SHADING_HLSL_

#define MAT_FLAG_DIFFUSE_MAP		0
#define MAT_FLAG_SPECULAR_MAP		1
#define MAT_FLAG_NORMAL_MAP			2
#define MAT_FLAG_DITHERING			4
#define MAT_FLAG_CLIP_IN_COCKPIT	8
#define MAT_FLAG_CASCADE_SHADOWS	16

#define MAT_FLAGS_DEFAULT			(/*MAT_FLAG_DIFFUSE_MAP |*/ MAT_FLAG_DITHERING | MAT_FLAG_CLIP_IN_COCKPIT)
#define MAT_FLAGS_ALL_MAPS			(MAT_FLAGS_DEFAULT | MAT_FLAG_SPECULAR_MAP | MAT_FLAG_NORMAL_MAP)

#include "common/constants.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/dithering.hlsl"

#include "deferred/GBuffer.hlsl"
#include "deferred/atmosphere.hlsl"
#include "deferred/shading.hlsl"
#include "deferred/shadows.hlsl"

Texture2D texDiffuse;
Texture2D texSpecular;
Texture2D texNormal;

struct MODEL_PS_INPUT
{
	float4 pos: 	SV_POSITION0;
	float4 wPos: 	POSITION0;
	float4 projPos:	POSITION1;
#ifdef USE_PREV_POS
	float4 prevProjPos:	POSITION2;
#endif
	float3 normal: 	NORMAL0;
	float3 tangent:	TANGENT0;
	float2 uv:		TEXCOORD0;
#ifdef MODEL_SHADING_OPACITY_CONTROL
	float opacity:	TEXCOORD1;
#endif
};


void dither8x8(float2 pixel, float input)
{
	if(dither_ordered8x8(pixel) >= input)
		discard;
}

float3 ScreenSpaceDither( float2 vScreenPos )
{
	// Iestyn's RGB dither (7 asm instructions) from Portal 2 X360, slightly modified for VR
	float3 vDither = dot( float2( 171.0, 231.0 ), vScreenPos.xy + gModelTime ).xxx;
	vDither.rgb = frac( vDither.rgb / float3( 103.0, 71.0, 97.0 ) ) - float3( 0.5, 0.5, 0.5 );
	return ( vDither.rgb / 255.0 ) * 0.375;
}

float3 getNormalFromTangentSpace(float3 normal, float3 tangent, float2 uv)
{
	float3x3 tangentSpace = {-normalize(tangent), -normalize(cross(normal, tangent)), normalize(normal)};		
	float3 normMap = texNormal.Sample(gAnisotropicClampSampler, uv).rgb * 2.0 - 1.0;
	return normalize(mul(normMap, tangentSpace));
}

float applyShadow(in float4 pos, float3 normal, uniform bool usePCF = true, uniform bool useNormalBias = true, uniform bool useFirstMap = false)
{
	return SampleShadowCascade(pos.xyz, pos.w, normal, usePCF, useNormalBias, false, 32, useFirstMap); // mover from deferred/shadows.hlsl
}

#endif // _DEBRIS_HLSL_

#ifndef MODEL_PS_SHADER_NAME
	#define MODEL_PS_SHADER_NAME			psModel
#endif

#ifndef MODEL_FORWARD_PS_SHADER_NAME
	#define MODEL_FORWARD_PS_SHADER_NAME	psModelForward
#endif



struct MaterialParams
{
	float4 diffuse;
	float3 normal;
	float4 aorm;
	float3 emissive;
	float  camDistance;
	float3 toCamera;
	float3 pos;
};

MaterialParams GetMaterialParams(MODEL_PS_INPUT i, uniform int flags)
{
	if(flags & MAT_FLAG_CLIP_IN_COCKPIT)
		clipInCockpit(i.wPos.xyz);

	if(flags & MAT_FLAG_DITHERING)
		dither8x8(i.pos.xy, i.wPos.w);//by opacity

	MaterialParams mp;

	if(flags & MAT_FLAG_NORMAL_MAP)
		mp.normal = getNormalFromTangentSpace(i.normal, i.tangent, i.uv);
	else
		mp.normal = normalize(i.normal);
	
	mp.aorm = float4(1.0, 0.75, 0.0, 1.0);
	
	if(flags & MAT_FLAG_SPECULAR_MAP)
		mp.aorm = texSpecular.Sample(gAnisotropicWrapSampler, i.uv);
	
	mp.diffuse = texDiffuse.Sample(gAnisotropicWrapSampler, i.uv);

	mp.emissive = 0;

	mp.pos = i.wPos.xyz;
	mp.toCamera = normalize(gCameraPos - mp.pos);
	mp.camDistance = length(mp.toCamera);

	return mp;
}

GBuffer MODEL_PS_SHADER_NAME( MODEL_PS_INPUT i,
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex: SV_SampleIndex, 
#endif
	uniform int flags)
{
	MaterialParams mp = GetMaterialParams(i, flags);
	
	return BuildGBuffer(i.pos.xy,
#if USE_SV_SAMPLEINDEX
				sv_sampleIndex, 
#endif
				mp.diffuse, mp.normal, mp.aorm, mp.emissive 
		#if USE_PREV_POS
				,calcMotionVector(i.projPos, i.prevProjPos)
		#elif USE_MOTION_VECTORS
				,float2(0.0, 0.0)
		#endif
);
}

float4 MODEL_FORWARD_PS_SHADER_NAME(MODEL_PS_INPUT i, uniform int flags): SV_Target0
{
	MaterialParams mp = GetMaterialParams(i, flags);

	float shadow = 1.0;
	float2 cloudShadowAO = SampleShadowClouds(mp.pos);
	shadow = cloudShadowAO.x;
	if(flags & MAT_FLAG_CASCADE_SHADOWS)
		shadow = min(shadow, applyShadow(float4(mp.pos, i.pos.z), mp.normal));

#ifdef MODEL_SHADING_OPACITY_CONTROL
	mp.diffuse.a *= i.opacity;
#endif

	float3 sunColor = SampleSunRadiance(mp.pos.xyz, gSunDir);
	float4 finalColor = float4(ShadeHDR(i.pos.xy, sunColor, mp.diffuse.rgb, mp.normal, mp.aorm.y, mp.aorm.z, mp.emissive, shadow, mp.aorm.x, cloudShadowAO, mp.toCamera, mp.pos, float2(1,mp.aorm.w)), mp.diffuse.a);

	return float4(applyAtmosphereLinear(gCameraPos.xyz, mp.pos, i.projPos, finalColor.rgb), finalColor.a);
}
