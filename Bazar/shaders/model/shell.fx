#include "../common/context.hlsl"
#include "common/shader_macroses.hlsl"

float4x4 PositionMatrix;	// Position matrix multiplied by view matrix and projection matrices
float3 Color;

struct VS_INPUT
{
	float3 pos : POSITION0;
};

struct VS_INPUT_WITH_NORMAL
{
	float3 pos : POSITION0;
	float3 normal : NORMAL0;
};


// Vertex shader o structure
struct VS_OUTPUT
{
	float4 Position		: SV_POSITION0;		// vertex position
	float3 Normal		: COLOR0;		// normal
	float4 Pos			: COLOR1;		// vertex position in world
};

// Pixel shader o structure
struct PS_OUTPUT
{
	float4 RGBColor : SV_TARGET0;  // Pixel color
};

RasterizerState rasterState{
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = TRUE;
	DepthBias = 0.0;
};

VS_OUTPUT vertex_shader_with_normal(VS_INPUT_WITH_NORMAL input)
{
	VS_OUTPUT o;

	o.Pos = mul(float4(input.pos,1.0), PositionMatrix);
	o.Position = mul(o.Pos,gViewProj);

	o.Normal = normalize(input.normal);
	return o;
}

VS_OUTPUT vertex_shader_segment(VS_INPUT input)
{
	VS_OUTPUT o;

	o.Pos = mul(float4(input.pos,1.0), PositionMatrix);
	o.Position = mul(o.Pos,gViewProj);

	o.Normal = float3(0.0, 1.0, 0.0);

	return o;
}

#include "deferred/GBuffer.hlsl"

GBuffer pixel_shader_shell(VS_OUTPUT input
#if USE_SV_SAMPLEINDEX
	, uint si: SV_SampleIndex
#endif
)
{
	return BuildGBuffer(input.Position.xy,
#if USE_SV_SAMPLEINDEX
		si,
#endif
		float4(Color, 1.0), input.Normal, float4(1,0.9,0.5,1), 0);
}

GBuffer pixel_shader_segment(VS_OUTPUT input
#if USE_SV_SAMPLEINDEX
	, uint si: SV_SampleIndex
#endif
)
{
	return BuildGBuffer(input.Position.xy,
#if USE_SV_SAMPLEINDEX
		si,
#endif
		float4(Color, 1.0), input.Normal, float4(1,0.9,0.5,1), 0);
}

[maxvertexcount(3)]
void geometry_shader_shell(triangle VS_OUTPUT points[3], inout TriangleStream<VS_OUTPUT> triStream)
{
	float3 v1 = points[0].Pos.xyz/points[0].Pos.w,
		   v2 = points[1].Pos.xyz/points[1].Pos.w,
		   v3 = points[2].Pos.xyz/points[2].Pos.w;

	VS_OUTPUT r1 = points[0], r2 = points[1], r3 = points[2];
	r1.Normal = r2.Normal = r3.Normal = normalize(cross(v2 - v1, v3 - v1));

    triStream.Append(r1);
    triStream.Append(r2);
    triStream.Append(r3);
    triStream.RestartStrip();
}

TECHNIQUE shell_with_normal
{
	pass P0
	{
		SetRasterizerState(rasterState);

		DISABLE_ALPHA_BLEND;

		ENABLE_DEPTH_BUFFER;

		VERTEX_SHADER(vertex_shader_with_normal())
		GEOMETRY_SHADER_PLUG
		PIXEL_SHADER(pixel_shader_shell())
	}
}

TECHNIQUE segment
{
	pass P0
	{
		SetRasterizerState(rasterState);

		DISABLE_ALPHA_BLEND;

		ENABLE_DEPTH_BUFFER;

		VERTEX_SHADER(vertex_shader_segment())
		PIXEL_SHADER(pixel_shader_segment())
		GEOMETRY_SHADER_PLUG
	}
}


