#ifndef LK_SHADOW_HLSL
#define LK_SHADOW_HLSL

#include "functions/structs.hlsl"
#include "functions/vt_utils.hlsl"

// Vertex shader structure
struct VS_OUTPUT_SHADOWS
{
	float4 Position		: SV_POSITION0;		// vertex position in projection space
	float4 Pos			: COLOR0;

#if defined(SHADOW_WITH_ALPHA_TEST)
	#ifdef TEXCOORD0_SIZE
		vector<float, TEXCOORD0_SIZE> tc0 : TEXCOORD0;
	#endif
	#ifdef TEXCOORD1_SIZE
		vector<float, TEXCOORD1_SIZE> tc1 : TEXCOORD1;
	#endif
	#ifdef TEXCOORD2_SIZE
		vector<float, TEXCOORD2_SIZE> tc2 : TEXCOORD2;
	#endif
	#ifdef TEXCOORD3_SIZE
		vector<float, TEXCOORD3_SIZE> tc3 : TEXCOORD3;
	#endif
	#ifdef TEXCOORD4_SIZE
		vector<float, TEXCOORD4_SIZE> tc4 : TEXCOORD4;
	#endif
	#ifdef TEXCOORD5_SIZE
		vector<float, TEXCOORD5_SIZE> tc5 : TEXCOORD5;
	#endif

	#if defined(DAMAGE_UV)
		nointerpolation float DamageLevel : TEXCOORD8;
	#endif
#endif
};

VS_OUTPUT_SHADOWS lk_shadow_vs(const VS_INPUT_SHADOWS input)
{
	VS_OUTPUT_SHADOWS o;

	float4x4 posMat = get_transform_matrix(input);

	float4 Pos = mul(float4(input.pos.xyz,1.0),posMat);
	o.Position = mul(Pos, gViewProj);
	o.Pos = Pos;	

#if defined(SHADOW_WITH_ALPHA_TEST)
	#include "functions/set_texcoords.hlsl"

	#if defined(DAMAGE_UV)
		o.DamageLevel = get_damage_argument((int)input.pos.w);
	#endif
#endif

	return o;
}

void lk_shadow_ps(const VS_OUTPUT_SHADOWS input)
{
#if defined(SHADOW_WITH_ALPHA_TEST)

	clipByDiffuseAlpha(GET_DIFFUSE_UV(input), 0.4);
	#ifdef DAMAGE_UV
		testDamageAlpha(input.DAMAGE_UV.xy + diffuseShift, input.DamageLevel, distance(input.Pos.xyz, gCameraPos.xyz) * gNearFarFovZoom.w);
	#endif

#endif
}

void lk_shadow_transparent_ps(const VS_OUTPUT_SHADOWS input)
{
#if defined(GLASS_MATERIAL) || !defined(SHADOW_WITH_ALPHA_TEST)
	discard;
#else
	#if defined(DIFFUSE_UV) && (BLEND_MODE == BM_ALPHA_TEST || BLEND_MODE == BM_TRANSPARENT)
		float4 diff = Diffuse.Sample(gAnisotropicWrapSampler, input.DIFFUSE_UV.xy + diffuseShift);
		if(diff.a < 0.25)
			discard;
	#endif

	#ifdef DAMAGE_UV
		testDamageAlpha(input.DAMAGE_UV.xy + diffuseShift, input.DamageLevel, distance(input.Pos.xyz, gCameraPos.xyz) * gNearFarFovZoom.w);
	#endif

#endif
}


#endif
