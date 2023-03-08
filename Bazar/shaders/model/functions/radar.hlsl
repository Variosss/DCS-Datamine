#ifndef RADAR_HLSL
#define RADAR_HLSL

#include "functions/structs.hlsl"
#include "functions/vt_utils.hlsl"
#include "functions/diffuse.hlsl"
#include "enlight/radarFunc.hlsl"

// Vertex shader structure
struct VS_OUTPUT_RADAR
{
	float4 Position		: SV_POSITION0;		// vertex position in projection space
	float4 projPos		: TEXCOORD6;
	float4 Pos			: COLOR0;
	float3 Normal		: NORMAL0;

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
};

VS_OUTPUT_RADAR radar_vs(const VS_INPUT input)
{
	VS_OUTPUT_RADAR o;

	float4x4 posMat = get_transform_matrix(input);

	o.Pos = mul(float4(input.pos.xyz,1.0),posMat);
	o.projPos = o.Position = mul(o.Pos, gViewProj);

	#include "functions/set_texcoords.hlsl"

	float3x3 normMat = (float3x3)posMat;
#ifdef NORMAL_SIZE
	o.Normal = mul(input.normal, normMat);
#else
	o.Normal = mul(float3(0.0,1.0,0.0), normMat);
#endif

#if defined(DAMAGE_UV)
	o.DamageLevel = get_damage_argument((int)input.pos.w);
#endif

	return o;
}

float4 radar_ps(const VS_OUTPUT_RADAR i): SV_TARGET0 {

	clipByDiffuseAlpha(GET_DIFFUSE_UV(i), 0.5);

#ifdef DAMAGE_UV
	testDamageAlpha(i.DAMAGE_UV.xy + diffuseShift, i.DamageLevel, distance(i.Pos.xyz, gCameraPos.xyz) * gNearFarFovZoom.w);
#endif

	float3 wpos = i.Pos.xyz / i.Pos.w;
	float val = radarValue(gRadarPos, wpos, i.Normal, uipo[4][1]);
	return float4(val,0,0,1);
}

struct PSInput {
	float4 position:	SV_POSITION0;
	float3 worldPos:	TEXCOORD0;
};

[maxvertexcount(3)]
void radar_edge_gs(triangle VS_OUTPUT_RADAR input[3], uint pid: SV_PrimitiveID, inout PointStream<PSInput> outputStream) {
	PSInput o;

	if((pid % 2)==0) {
		o.position = input[0].projPos;
		o.worldPos = input[0].Pos.xyz / input[0].Pos.w;
		outputStream.Append(o);
	}
}

float4 radar_edge_ps(const PSInput i): SV_TARGET0 {
	float val = radarCornerReflector(gRadarPos, i.worldPos, 1);
	return float4(val,0,0,1);
}

#endif
