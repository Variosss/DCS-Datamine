#include "common/States11.hlsl"
#include "common/constants.hlsl"
#include "common/model_constants.hlsl"
#include "common/context.hlsl"
#include "common/samplers11.hlsl"
#define FOG_ENABLE
#include "common/fog2.hlsl"

// GENERATED CODE BEGIN ID: fake_omni_lights2_uniforms
cbuffer fake_omni_lights2_uniforms {
	float3 sizeFactors;	// min. size in pixels, max distance, reserved.
	float shiftToCamera;	// shift of light in camera direction. - - decrease distance to camera, + increase distance to camera.
	uint posStructOffset;	// offset in structured buffer 'sbPositions'
	float luminance;	// luminance multiplier
	int atmosphereSamplesId;	// To apply atmosphere on transparent objects
	float unused_huzm;
}
// GENERATED CODE END ID: fake_omni_lights2_uniforms

#define EXTERN_ATMOSPHERE_INSCATTER_ID
#include "common/atmosphereSamples.hlsl"
#include "functions/fake_lights_common.hlsl"
#include "functions/vt_utils.hlsl"

Texture2D Diffuse;

struct VS_INPUT
{
	float4 pos : POSITION0;
	float4 tc : TEXCOORD0; // left bottom, right top
	float size : TEXCOORD1;
};

struct VS_OUTPUT
{
	float4 Position		: SV_POSITION0;
	float4 tc : TEXCOORD0; // left bottom, right top
	float size : TEXCOORD2;
};

struct GS_OUTPUT {
	float4 Position		: SV_POSITION0;
	float4 ProjPos			: TEXCOORD0;
	nointerpolation float3 WorldPos			: TEXCOORD1;
	nointerpolation float sizeInPixels : TEXCOORD2;
	float2 uv : TEXCOORD3;
	float2 coords : TEXCOORD4;
};

VS_OUTPUT omni_lights_vs(VS_INPUT input)
{
	VS_OUTPUT o;

	float4x4 posMat = get_matrix((uint)input.pos.w);

	o.Position = mul(float4(input.pos.xyz,1.0),posMat);

	o.tc = input.tc;
	o.size = input.size;

	return o;
}

[maxvertexcount(4)]
void omni_lights_gs(point VS_OUTPUT i[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	GS_OUTPUT o;

	float s = i[0].size;
	float4 p = calculate_position(i[0].Position, s, sizeFactors.y, sizeFactors.x, o.sizeInPixels, o.WorldPos);

	[unroll]
	for(int j=0; j<4; ++j) {
		float4 pos = p;
		pos.xy += vertex[j] * s;
		pos = mul(float4(pos.xyz, 1), gProj);
		o.Position = pos;
		o.ProjPos = pos;

		o.uv = float2(i[0].tc[tc[j].x],  i[0].tc[tc[j].y]);
		o.coords = coords[j];
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 omni_lights_color(GS_OUTPUT input)
{
	float4 res = 0;
	res = Diffuse.Sample(gAnisotropicWrapSampler, input.uv.xy);
	res = calculate_light_intensity(res, input.sizeInPixels, input.coords, input.WorldPos.xyz, sizeFactors.y);
	res.rgb *= SamplePrecomputedAtmosphere(0).transmittance;
	return res;
}

PS_FIKE_LIGHT_OUTPUT omni_lights_ps(GS_OUTPUT input)
{
	PS_FIKE_LIGHT_OUTPUT o;
	o.RGBColor = omni_lights_color(input);
	float depth = depthAlpha(input.ProjPos, SOFT_PARTICLE_RADIUS);
	o.RGBColor.rgb *= depth;
	return o;
}

PS_FIKE_LIGHT_OUTPUT omni_lights_ps_nosoft(GS_OUTPUT input)
{
	PS_FIKE_LIGHT_OUTPUT o;
	o.RGBColor = omni_lights_color(input);
	return o;
}

PS_FIKE_LIGHT_OUTPUT omni_lights_ps_ir(GS_OUTPUT input)
{
	PS_FIKE_LIGHT_OUTPUT o;
	o.RGBColor = omni_lights_color(input);
	o.RGBColor.rgb = dot(o.RGBColor.rgb, IR_MULT);

	return o;
}

VertexShader omni_lights_vs_c = COMPILE_VERTEX_SHADER(omni_lights_vs());
GeometryShader omni_lights_gs_c = CompileShader(gs_4_0, omni_lights_gs());

TECHNIQUE normal
{
	pass P0
	{
		FRONT_CULLING;

		ADDITIVE_ALPHA_BLEND;

		ENABLE_RO_DEPTH_BUFFER;

		COMPILED_VERTEX_SHADER(omni_lights_vs_c)
		PIXEL_SHADER(omni_lights_ps())
		SetGeometryShader(omni_lights_gs_c);
	}
}

TECHNIQUE normal_nosoft
{
	pass P0
	{
		FRONT_CULLING;

		ADDITIVE_ALPHA_BLEND;

		ENABLE_RO_DEPTH_BUFFER;

		COMPILED_VERTEX_SHADER(omni_lights_vs_c)
		PIXEL_SHADER(omni_lights_ps_nosoft())
		SetGeometryShader(omni_lights_gs_c);
	}
}

TECHNIQUE normal_ir
{
	pass P0
	{
		FRONT_CULLING;

		ADDITIVE_ALPHA_BLEND;

		ENABLE_RO_DEPTH_BUFFER;

		COMPILED_VERTEX_SHADER(omni_lights_vs_c)
		PIXEL_SHADER(omni_lights_ps_ir())
		SetGeometryShader(omni_lights_gs_c);
	}
}

