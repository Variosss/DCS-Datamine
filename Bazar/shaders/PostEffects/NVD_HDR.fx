#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "deferred/blur.hlsl"
#include "noise/noise3D.hlsl"
#include "NVD_common.hlsl"

Texture2D DiffuseMap;
Texture2D NVDMap;
Texture2D DepthMap;

uint2 dims;
float4 viewport;
float3 color;
float gain;
float noiseFactor;

static const float3 LUM = { 1.0, 0.0721f, 0.0721f };

struct VS_OUTPUT {
	float4 pos:		SV_POSITION;
	float4 projPos:	TEXCOORD0;
};

static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.projPos = o.pos = float4(quad[vid], 0, 1);
	return o;
}

float4 PS(const VS_OUTPUT i, uniform bool useMask): SV_TARGET0 {

	uint2 idx = i.pos.xy;
	float2 uv = float2(i.projPos.x*0.5+0.5, -i.projPos.y*0.5+0.5)*viewport.zw + viewport.xy;

	float3 c1 = NVDMap.SampleLevel(ClampPointSampler, uv, 0).rgb;
	if (useMask) {
		float3 c0 = DiffuseMap.SampleLevel(ClampPointSampler, uv, 0).rgb;

		float2 uvm = calcMaskCoord(i.projPos);

		float m0 = 1 - getMask(uvm*0.6, 3);
		float m1 = getMask(uvm, 10);

		return float4(m0*c0 + m1*c1, 1);
	} else {
		return float4(c1, 1);
	}
}

#define FOCUS_DISTANCE 10.0
float3 BlurOffs(const VS_OUTPUT i, float2 offs, out float depth) {
	float2 uv = float2(i.projPos.x*0.5 + 0.5, -i.projPos.y*0.5 + 0.5);
	depth = DepthMap.SampleLevel(gBilinearClampSampler, uv, 0).r;
	float4 pos = mul(float4(i.projPos.xy, depth, 1), gProjInv);
	float sigma = 0.8 + 2 * saturate((FOCUS_DISTANCE - (pos.z / pos.w)) / FOCUS_DISTANCE);
	return Blur(uv, offs*(0.5 / dims), sigma, NVDMap);
}

float4 PS_BlurX(const VS_OUTPUT i): SV_TARGET0 {
	float depth;
	return float4(BlurOffs(i, float2(1, 0), depth), 1);
}

float hash31(float3 p3) {
	p3 = frac(p3 * float3(.1031, .11369, .13787));
	p3 += dot(p3, p3.yzx + 19.19);
	return frac((p3.x + p3.y) * p3.z);
}

float noise1(float2 p, float seed) {
	float2 i = floor(p);
	float2 f = frac(p);
	float2 u = f*f*(3.0 - 2.0*f);
	return lerp(
			lerp(hash31(float3(i + float2(0.0, 0.0), seed)),
				hash31(float3(i + float2(1.0, 0.0), seed)), u.x),
			lerp(hash31(float3(i + float2(0.0, 1.0), seed)),
				hash31(float3(i + float2(1.0, 1.0), seed)), u.x),
			u.y);
}

float noise2(float2 p, float seed) {
	float n = noise1(p, seed);
	return (n*0.1 + pow(n, 50)*0.4);
}

float noise3(float2 p, float time) {
	time += sin(p.x*20) + cos(p.y*20);
	float i = floor(time);
	float f = frac(time);
	return lerp(noise2(p, i), noise2(p, i + 1), f);
}

float4 PS_BlurY(const VS_OUTPUT i) : SV_TARGET0 {
	float depth;
	float3 result = BlurOffs(i, float2(0, 1), depth);
	result = dot(result, LUM) * 2 * color;
//	result += depth == 0 ? color * pow(gain*1.5, 4) : 0;			// more bright sky
	result += color * noise3((i.projPos.xy*0.5+0.5) * 400, gModelTime * 10) * noiseFactor;
	return float4(result, 1);
}

#define COMMON_PART 		SetVertexShader(CompileShader(vs_5_0, VS()));									\
							SetGeometryShader(NULL);														\
							SetDepthStencilState(disableDepthBuffer, 0);									\
							SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
							SetRasterizerState(cullNone);

technique10 Compose {
	pass P0 {
		SetPixelShader(CompileShader(ps_5_0, PS(false)));
		COMMON_PART
	}
	pass P1 {
		SetPixelShader(CompileShader(ps_5_0, PS(true)));
		COMMON_PART
	}
}

technique10 BlurX {
	pass P0 {
		SetPixelShader(CompileShader(ps_5_0, PS_BlurX()));
		COMMON_PART
	}
}

technique10 BlurY {
	pass P0 {
		SetPixelShader(CompileShader(ps_5_0, PS_BlurY()));
		COMMON_PART
	}
}

