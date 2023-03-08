#include "common/constants.hlsl"
#include "common/model_constants.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "common/samplers11.hlsl"
#include "functions/pixel_utils.hlsl"
#define FOG_ENABLE
#include "common/fog2.hlsl"

// GENERATED CODE BEGIN ID: fake_spot_lights2_uniforms
cbuffer fake_spot_lights2_uniforms {
	float3 coneSetup;	// first - cos of inner cone angle, second - cos of outer cone angle, third - min attenuation value
	float minSizeInPixels;	// Holds minimal size of billboard in pixels.
	float maxDistance;	// Holds distance after which attenuation will start.
	uint posStructOffset;	// offset in structured buffer 'sbPositions'
	float shiftToCamera;	// shift of light in camera direction. - - decrease distance to camera, + increase distance to camera
	float luminance;	// luminance multiplier
	int atmosphereSamplesId;	// To apply atmosphere on transparent objects
	float3 unused_nbsr;
}
// GENERATED CODE END ID: fake_spot_lights2_uniforms

#define EXTERN_ATMOSPHERE_INSCATTER_ID
#include "common/atmosphereSamples.hlsl"
#include "functions/fake_lights_common.hlsl"

#define NEED_DIR_IN_STRUCT_BUF
#include "functions/vt_utils.hlsl"

Texture2D Diffuse;

struct VS_INPUT {
	float4 pos : POSITION0;
	float4 tc : TEXCOORD0; // left bottom, right top
	float4 tc_back : TEXCOORD1; // left bottom, right top
	float size : TEXCOORD2;
	float backAlpha : TEXCOORD3; // 0 if there is no back side
};

struct VS_OUTPUT {
	float4 Position	: SV_POSITION0;		// vertex position in world space
	float4 tc : TEXCOORD0; // left bottom, right top
	float4 tc_back : TEXCOORD1; // left bottom, right top
	float size : TEXCOORD2;
	float backAlpha : TEXCOORD3;
	float3 lightDir : TEXCOORD4;
};

struct GS_OUTPUT {
	float4 Position			: SV_POSITION0;
	float4 ProjPos			: TEXCOORD0;
	nointerpolation float3 WorldPos			: TEXCOORD1;
	nointerpolation float sizeInPixels : TEXCOORD2;
	float2 uv 				: TEXCOORD3;
	float2 uv_back			: TEXCOORD4;
	nointerpolation float2 LightAtt			: TEXCOORD5;
	float2 coords : TEXCOORD6;
};

VS_OUTPUT spot_lights_vs(VS_INPUT input)
{
	VS_OUTPUT o;

	float4x4 posMat = get_matrix((uint)input.pos.w);
	o.lightDir = get_direction((int)input.pos.w);

	o.Position = mul(float4(input.pos.xyz,1.0),posMat);
	o.tc = input.tc;
	o.tc_back = input.tc_back;
	o.size = input.size;
	o.backAlpha = input.backAlpha;

	return o;
}

[maxvertexcount(8)]
void spot_lights_gs(point VS_OUTPUT i[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	GS_OUTPUT o;

	float s = i[0].size;
	float4 p = calculate_position(i[0].Position, s, maxDistance, minSizeInPixels, o.sizeInPixels, o.WorldPos);
	float3 toCam = normalize(gCameraPos - o.WorldPos);

	o.LightAtt = float2(
		-dot(toCam, i[0].lightDir),
		max(coneSetup.z, smoothstep(coneSetup.y, coneSetup.x, abs(dot(toCam, i[0].lightDir)))));

	[unroll]
	for(int j=0; j<4; ++j) {
		float4 pos = p;
		pos.xy += vertex[j] * s;
		pos = mul(float4(pos.xyz, 1), gProj);
		o.Position = pos;
		o.ProjPos = pos;

		o.uv = float2(i[0].tc[tc[j].x],  i[0].tc[tc[j].y]);
		if(i[0].backAlpha > 0){
			o.uv_back = float2(i[0].tc_back[tc[j].x], i[0].tc_back[tc[j].y]);
		}else{
			o.uv_back = -1;
		}
		o.coords = coords[j];
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 spot_lights_color(GS_OUTPUT input)
{
	float4 res = 0;
	if(input.LightAtt.x >= 0){
		res = Diffuse.Sample(gAnisotropicWrapSampler, input.uv);
	}else{
		if(input.uv_back.x < 0){
			discard;
		}
		res = Diffuse.Sample(gAnisotropicWrapSampler, input.uv_back);
	}
	res = calculate_light_intensity(res, input.sizeInPixels, input.coords, input.WorldPos.xyz, maxDistance);
	res.rgb *= input.LightAtt.y;
	res.rgb *= SamplePrecomputedAtmosphere(0).transmittance;
	return res;
}

PS_FIKE_LIGHT_OUTPUT spot_lights_ps(GS_OUTPUT input)
{
	PS_FIKE_LIGHT_OUTPUT o;
	o.RGBColor = spot_lights_color(input);
	float depth = depthAlpha(input.ProjPos, SOFT_PARTICLE_RADIUS);
	o.RGBColor.rgb *= depth;
	return o;
}

PS_FIKE_LIGHT_OUTPUT spot_lights_ps_nosoft(GS_OUTPUT input)
{
	PS_FIKE_LIGHT_OUTPUT o;
	o.RGBColor = spot_lights_color(input);
	return o;
}

PS_FIKE_LIGHT_OUTPUT spot_lights_ps_ir(GS_OUTPUT input)
{
	PS_FIKE_LIGHT_OUTPUT o;
	o.RGBColor = spot_lights_color(input);
	o.RGBColor.rgb = dot(o.RGBColor.rgb, IR_MULT);
	return o;
}

VertexShader spot_lights_vs_c = COMPILE_VERTEX_SHADER(spot_lights_vs());
GeometryShader spot_lights_gs_c = CompileShader(gs_4_0, spot_lights_gs());

TECHNIQUE normal
{
	pass P0
	{
		FRONT_CULLING;

		ADDITIVE_ALPHA_BLEND;

		ENABLE_RO_DEPTH_BUFFER;

		COMPILED_VERTEX_SHADER(spot_lights_vs_c)
		PIXEL_SHADER(spot_lights_ps())
		SetGeometryShader(spot_lights_gs_c);
	}
}

TECHNIQUE normal_nosoft
{
	pass P0
	{
		FRONT_CULLING;

		ADDITIVE_ALPHA_BLEND;

		ENABLE_RO_DEPTH_BUFFER;

		COMPILED_VERTEX_SHADER(spot_lights_vs_c)
		PIXEL_SHADER(spot_lights_ps_nosoft())
		SetGeometryShader(spot_lights_gs_c);
	}
}

TECHNIQUE normal_ir
{
	pass P0
	{
		FRONT_CULLING;

		ADDITIVE_ALPHA_BLEND;

		ENABLE_RO_DEPTH_BUFFER;

		COMPILED_VERTEX_SHADER(spot_lights_vs_c)
		PIXEL_SHADER(spot_lights_ps_ir())
		SetGeometryShader(spot_lights_gs_c);
	}
}
