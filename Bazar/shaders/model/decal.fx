#include "common/States11.hlsl"
#include "common/constants.hlsl"
#include "common/context.hlsl"
#include "common/samplers11.hlsl"
#define FOG_ENABLE
#include "common/fog2.hlsl"

#define USE_VELOCITY_MAP 1
#include "deferred/GBuffer.hlsl"

// GENERATED CODE BEGIN ID: decal_uniforms
cbuffer decal_uniforms {
	uint posStructOffset;	// offset in structured buffer 'sbPositions'
	float3 unused_lrdv;
}
// GENERATED CODE END ID: decal_uniforms

#include "functions/vt_utils.hlsl"

#define TANGENT_SIZE 4
#include "functions/misc.hlsl"

Texture2D Diffuse;
Texture2D NormalMap;
Texture2D RoughMethMap;

static const float2 vertex[4] = {
	float2(1, 1),  float2(-1, 1),
	float2(1, -1), float2(-1, -1)
};

static const int2 tc[4] = {
	int2(2, 3),  int2(0, 3),
	int2(2, 1), int2(0, 1)
};

struct VS_INPUT
{
	float4 pos : POSITION0;
	float3 normal : NORMAL0;
	float size : TEXCOORD0;
	float4 tc : TEXCOORD1; // left bottom, right top
	float2 angles : TEXCOORD2;

};

struct VS_OUTPUT
{
	float4 Position		: SV_POSITION0;
	float3 normal : NORMAL0;
	float4 tc : TEXCOORD0; // left bottom, right top
	float size : TEXCOORD1;
	float2 angles : TEXCOORD2;
};

struct GS_OUTPUT {
	float4 Position		: SV_POSITION0;
	float3 normal : NORMAL0;
	float4 tangent : TEXCOORD1;
	float2 uv : TEXCOORD2;
};

struct PS_OUTPUT
{
	float4 RGBColor : SV_TARGET0;  // Pixel color
};

VS_OUTPUT decal_vs(VS_INPUT input)
{
	VS_OUTPUT o;

	float4x4 posMat = get_matrix((uint)input.pos.w);

	o.Position = mul(float4(input.pos.xyz,1.0), posMat);

	float3x3 normMat = (float3x3)posMat;
	o.normal = mul(input.normal, normMat);

	o.tc = input.tc;
	o.size = input.size;
	o.angles = input.angles;

	return o;
}

float4 calculateTangent(in float3 v1, in float3 v2, in float3 v3, in float2 uv1, in float2 uv2, in float2 uv3, float3 normal)
{
	const float3 ev1 = v2 - v1, ev2 = v3 - v1;
	const float2 et1 = uv2 - uv1, et2 = uv3 - uv1;

	const float r = 1.0f / (et1.x * et2.y - et2.x * et1.y);

	const float3 sdir = float3((et2.y * ev1.x - et1.y * ev2.x) * r, (et2.y * ev1.y - et1.y * ev2.y) * r, (et2.y * ev1.z - et1.y * ev2.z) * r);
	const float3 tdir = float3((et1.x * ev2.x - et2.x * ev1.x) * r, (et1.x * ev2.y - et2.x * ev1.y) * r, (et1.x * ev2.z - et1.x * ev1.z) * r);

	float w = dot(float2(-et1.y, et1.x), et2) > 0?-1:1;											// check UV clockwise

	float4 tan = float4(normalize(sdir - normal * dot(normal, sdir)), w);
	return tan;
}

[maxvertexcount(4)]
void decal_gs(point VS_OUTPUT i[1], inout	 TriangleStream<GS_OUTPUT> outputStream)
{
	GS_OUTPUT o;

	float3 dir = normalize(i[0].normal);
	float3 up = (abs(dir.y) > 0.99) ? float3(1.0,0.0,0.0) : float3(0.0,1.0,0.0);
	float3 right = normalize(cross(up, dir));
	up = normalize(cross(right, dir));

	float3 newRight = normalize(right * i[0].angles.x + up * i[0].angles.y);
	right = newRight;
	up = normalize(cross(right, dir));

	float4 pos = i[0].Position / i[0].Position.w;
	pos.xyz += dir * 0.001;

	o.normal = i[0].normal;

	//--------------------------------------//
	const float3 v1 = pos.xyz + (up*vertex[0].x + right*vertex[0].y) * i[0].size;
	const float3 v2 = pos.xyz + (up*vertex[1].x + right*vertex[1].y) * i[0].size;
	const float3 v3 = pos.xyz + (up*vertex[2].x + right*vertex[2].y) * i[0].size;
	const float3 v4 = pos.xyz + (up*vertex[3].x + right*vertex[3].y) * i[0].size;

	const float2 uv1 = float2(i[0].tc[tc[0].x],  i[0].tc[tc[0].y]);
	const float2 uv2 = float2(i[0].tc[tc[1].x],  i[0].tc[tc[1].y]);
	const float2 uv3 = float2(i[0].tc[tc[2].x],  i[0].tc[tc[2].y]);
	const float2 uv4 = float2(i[0].tc[tc[3].x],  i[0].tc[tc[3].y]);

	o.tangent = calculateTangent(v1, v2, v3, uv1, uv2, uv3, i[0].normal);

	//--------------------------------------//
	o.Position = mul(float4(v1, 1), gViewProj);
	o.uv = uv1;
	outputStream.Append(o);

	o.Position = mul(float4(v2, 1), gViewProj);
	o.uv = uv2;
	outputStream.Append(o);

	o.Position = mul(float4(v3, 1), gViewProj);
	o.uv = uv3;
	outputStream.Append(o);

	o.Position = mul(float4(v4, 1), gViewProj);
	o.uv = uv4;
	outputStream.Append(o);
	//--------------------------------------//

	outputStream.RestartStrip();
}

GBuffer decal_deferred_ps(GS_OUTPUT input,
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex: SV_SampleIndex,
#endif
	uniform int Flags) {

	float4 baseColor = Diffuse.Sample(gAnisotropicWrapSampler, input.uv.xy);
	clip((baseColor.a)-0.5);

	float4 nm = NormalMap.Sample(gAnisotropicWrapSampler, input.uv.xy);
	float3 normal = calculateNormal(input.normal, nm, input.tangent);

	float4 aorms = RoughMethMap.Sample(gAnisotropicWrapSampler, input.uv.xy);

	return BuildGBuffer(input.Position.xy,
#if USE_SV_SAMPLEINDEX
						sv_sampleIndex,
#endif
						baseColor, normal, aorms, 0, 0);
}

PS_OUTPUT decal_ps(GS_OUTPUT input)
{
	PS_OUTPUT o;
	o.RGBColor = Diffuse.Sample(gAnisotropicWrapSampler, input.uv.xy);

	return o;
}

VertexShader decal_vs_c = COMPILE_VERTEX_SHADER(decal_vs());
GeometryShader decal_gs_c = CompileShader(gs_4_0, decal_gs());

TECHNIQUE normal
{
	pass P0
	{
		DISABLE_CULLING;

		DISABLE_ALPHA_BLEND;

		ENABLE_RO_DEPTH_BUFFER;

		COMPILED_VERTEX_SHADER(decal_vs_c)
		PIXEL_SHADER(decal_deferred_ps(0))
		SetGeometryShader(decal_gs_c);
	}
}
