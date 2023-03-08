#ifndef RAINDROP_HLSL
#define RAINDROP_HLSL

#include "functions/structs.hlsl"
#include "functions/vt_utils.hlsl"
#include "common/quat.hlsl"

struct VS_OUTPUT_COCKPIT_GLASS_UV
{
	float4 Position		: SV_POSITION0;
	float4 projPos		: TEXCOORD0;
	float3 Normal		: NORMAL0;
	float3 Tangent		: TANGENT0;
};

VS_OUTPUT_COCKPIT_GLASS_UV cockpit_glass_uv_vs(const VS_INPUT input) {

	VS_OUTPUT_COCKPIT_GLASS_UV o;

	float4x4 posMat = get_transform_matrix(input);
//	o.Pos = mul(float4(input.pos.xyz,1.0),posMat); // world pos

	float3x3 normMat = (float3x3)posMat;
#ifdef NORMAL_MAP_UV
	#if TANGENT_SIZE == 4
		o.Normal = mul(input.normal, normMat)*input.tangent.w;
	#else
		o.Normal = mul(input.normal, normMat);
	#endif
	o.Tangent = mul(input.tangent.xyz,normMat);
#else
	o.Normal = mul(float3(0.0,1.0,0.0), normMat);
	o.Tangent = mul(float3(1.0,0.0,0.0), normMat);
#endif

#ifdef TEXCOORD0_SIZE
	o.projPos = o.Position = float4(frac(float2(input.tc0.x, 1-input.tc0.y))*2-1, 0, 1);
#else
	o.projPos = o.Position = 0;
#endif
	return o;
}

float4 cockpit_glass_uv_ps(const VS_OUTPUT_COCKPIT_GLASS_UV input): SV_TARGET0 {

	float3 normal = -normalize(input.Normal);
	float3 tangent = normalize(input.Tangent);
	float3x3 ts = { tangent, cross(normal, tangent), normal };

	float4 q = matrixToQuat(ts);

	return q*0.5 + 127.0 / 255;
}

#endif
