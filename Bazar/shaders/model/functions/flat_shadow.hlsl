#ifndef FLAT_SHADOW_HLSL
#define FLAT_SHADOW_HLSL

#include "functions/structs.hlsl"
#include "functions/vt_utils.hlsl"

#define FOG_ENABLE
#include "deferred/shadows.hlsl"


RasterizerState modelFlatShadowsRasterizerState {
	CullMode = Front;
	FillMode = Solid;
	MultisampleEnable = TRUE;
	DepthBias = 200.0;
	SlopeScaledDepthBias = 0.0;
};

#define SET_RASTER_STATE_FLAT_SHADOW SetRasterizerState(modelFlatShadowsRasterizerState)


// Vertex shader o structure
struct VS_OUTPUT_FLAT_SHADOWS
{
	float4 Position		: SV_POSITION0;		// vertex position in projection space
	float4 Pos			: COLOR0;		// vertex position in world space, w component holds height in world coordinates
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

VS_OUTPUT_FLAT_SHADOWS flat_shadow_vs(VS_INPUT_SHADOWS input)
{
	VS_OUTPUT_FLAT_SHADOWS o;

	float4x4 posMat = get_transform_matrix(input);

	o.Pos = mul(float4(input.pos.xyz,1.0),posMat);
	o.Pos /= o.Pos.w;

	float y = o.Pos.y;

#ifndef FOREST_MATERIAL
	// project on plane
	float t = -(dot(FlatShadowPlane.xyz, o.Pos.xyz) + FlatShadowPlane.w) / (dot(FlatShadowPlane.xyz, ShadowLightDir.xyz));
#else
	float4 plane;
	plane = FlatShadowPlane;
	plane.w += dot(FlatShadowPlane.xyz, -FlatShadowPlane.xyz * 1.0);

	float t = -(dot(plane.xyz, o.Pos.xyz) + plane.w) / (dot(plane.xyz, ShadowLightDir.xyz));
#endif

	o.Pos.xyz = o.Pos.xyz + ShadowLightDir.xyz * t;

	o.Position = mul(o.Pos, gViewProj);

	o.Pos.w = y;

#if defined(SHADOW_WITH_ALPHA_TEST)
	#include "functions/set_texcoords.hlsl"
	#if defined(DAMAGE_UV)
		o.DamageLevel = get_damage_argument((int)input.pos.w);
	#endif
#endif

	return o;
}


float4 flat_shadow_ps(VS_OUTPUT_FLAT_SHADOWS input): SV_TARGET0 {
#ifndef FOREST_MATERIAL
	if(input.Pos.w < FlatShadowProps.y)
		discard;
#endif

#if defined(SHADOW_WITH_ALPHA_TEST)
	clipByDiffuseAlpha(GET_DIFFUSE_UV(input), 0.5);
	#ifdef DAMAGE_UV
		testDamageAlpha(input.DAMAGE_UV.xy + diffuseShift, input.DamageLevel, distance(input.Pos.xyz, gCameraPos.xyz) * gNearFarFovZoom.w);
	#endif
#endif
	return float4(0,0,0,gFlatShadowAlpha);
}

float4 flat_shadow_transparent_ps(VS_OUTPUT_FLAT_SHADOWS input): SV_TARGET0
{
	if(input.Pos.w < FlatShadowProps.y)
		discard;

#if defined(SHADOW_WITH_ALPHA_TEST)
	float alpha = clipByDiffuseAlpha(GET_DIFFUSE_UV(input), 0.1);

	#ifdef DAMAGE_UV
		testDamageAlpha(input.DAMAGE_UV.xy + diffuseShift, input.DamageLevel, distance(input.Pos.xyz, gCameraPos.xyz) * gNearFarFovZoom.w);
	#endif

	return float4(1-alpha,0,0,0);
#endif

	return 0;
}


#define FLAT_SHADOW_TEST 1

DepthStencilState FlatShadowsState {
	DepthEnable = TRUE;
	DepthWriteMask = ZERO;
	DepthFunc = DEPTH_FUNC;

	StencilEnable = TRUE;
	StencilReadMask = FLAT_SHADOW_TEST;
	StencilWriteMask = FLAT_SHADOW_TEST;

	FrontFaceStencilFunc = NOT_EQUAL;
	FrontFaceStencilPass = REPLACE;
	FrontFaceStencilFail = KEEP;

	BackFaceStencilFunc = NOT_EQUAL;
	BackFaceStencilPass = REPLACE;
	BackFaceStencilFail = KEEP;
};

#endif
