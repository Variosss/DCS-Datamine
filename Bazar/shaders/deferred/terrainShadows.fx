#include "common/context.hlsl"
#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/stencil.hlsl"
#include "deferred/Decoder.hlsl"
#include "deferred/ESM.hlsl"
#include "deferred/blur.hlsl"
#include "deferred/ComposedShadows.hlsl"

Texture2D<float4> blurSrc;
uint2	dims;
float	downsample;

struct VS_OUTPUT {
	float4 pos:		SV_POSITION0;
	float4 projPos:	TEXCOORD0;
};

static const float2 quad[4] = {
	{ -1, -1 },{ 1, -1 },
	{ -1,  1 },{ 1,  1 }
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.projPos = o.pos = float4(quad[vid], 0, 1);
	return o;
}

float4 PS_TERRAIN_SHADOWS(const VS_OUTPUT i, uint sidx: SV_SampleIndex, uniform bool useSSM) : SV_TARGET0 {
	uint2 uv = i.pos.xy;
	float depth = SampleMap(DepthMap, uv, sidx);
	float4 pos = mul(float4(i.projPos.xy / i.projPos.w, depth, 1), gViewProjInv);
	if (useSSM) {
		uint materialId = SampleMap(StencilMap, i.pos.xy, sidx).g & STENCIL_COMPOSITION_MASK;
		if (materialId == STENCIL_COMPOSITION_FOLIAGE) 
			return terrainShadowsSSM(pos);
	}
	return terrainShadows(pos);
}

float4 PS_TERRAIN_SHADOWS_DOWNSAMPLED(const VS_OUTPUT i, out float depth: SV_DEPTH, uniform bool useSSM): SV_TARGET0 {
	uint2 uv = i.pos.xy * downsample;
	depth = SampleMap(DepthMap, uv, 0).x;
#ifdef MSAA
	[unroll]
	for (uint k = 1; k < MSAA; ++k)
		depth = min(depth, SampleMap(DepthMap, uv, k).x);
#endif
	float4 pos = mul(float4(i.projPos.xy / i.projPos.w, depth, 1), gViewProjInv);
	if (useSSM) {
		uint materialId = SampleMap(StencilMap, uv, 0).g & STENCIL_COMPOSITION_MASK;
		if (materialId == STENCIL_COMPOSITION_FOLIAGE) 
			return terrainShadowsSSM(pos);
	}
	return terrainShadows(pos);
}

static const float blurSigma = 0.7;

float4 PS_Blur(const VS_OUTPUT i, uniform float2 offset) : SV_TARGET0 {
	float2 uv = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	return float4(Blur(uv, offset * (8.0 / dims), blurSigma, blurSrc), 0);
}

void PS_DownsamplingStencil(const VS_OUTPUT i) {
	uint2 uv = i.pos.xy;
	uint s = SampleMap(StencilMap, uv * downsample, 0).y;
	if ((s & 1) == 0)
		discard;
}

#define SC_GAUSS_KERNEL 2
#define SC_SIGMA 1 

float SC_gaussianBlur(uint2 uv) {
	float aw = 0;
	float acc = 0;
	for (int iy = -SC_GAUSS_KERNEL; iy <= SC_GAUSS_KERNEL; ++iy) {
		float gy = SC_gaussian(iy, SC_SIGMA);
		for (int ix = -SC_GAUSS_KERNEL; ix <= SC_GAUSS_KERNEL; ++ix) {
			float gx = SC_gaussian(ix, SC_SIGMA);
			float w = gx * gy;
			acc += ShadowsMap.Load(uint3(uv.x + ix, uv.y + iy, 0)).x * w;
			aw += w;
		}
	}
	return acc / aw;
}

float SC_joinedBilateralGaussianBlur(uint2 uv) {
	float pz = SC_depthToDistane(ShadowsDepth.Load(uint3(uv, 0)).x);
	float aw = 0;
	float acc = 0;
	for (int iy = -SC_GAUSS_KERNEL; iy <= SC_GAUSS_KERNEL; ++iy) {
		float gy = SC_gaussian(iy, SC_SIGMA);
		for (int ix = -SC_GAUSS_KERNEL; ix <= SC_GAUSS_KERNEL; ++ix) {
			float gx = SC_gaussian(ix, SC_SIGMA);
			float vz = SC_depthToDistane(ShadowsDepth.Load(uint3(uv.x + ix, uv.y + iy, 0)).x);

			float gv = SC_gaussian(abs((pz - vz) / pz * 10000.0), SC_SIGMA);
			float w = gx * gy * gv;
			acc += ShadowsMap.Load(uint3(uv.x + ix, uv.y + iy, 0)).x * w;
			aw += w;
		}
	}
	return acc / aw;
}


float4 PS_BlurComposed(const VS_OUTPUT i): SV_TARGET0 {
//	return float4(SC_gaussianBlur(i.pos.xy), 0, 0, 1);
	return float4(SC_joinedBilateralGaussianBlur(i.pos.xy), 0, 0, 1);
}

VertexShader vsComp = CompileShader(vs_5_0, VS());

DepthStencilState DownsamplingDepthState {
	DepthEnable = TRUE;
	DepthWriteMask = ALL;
	DepthFunc = ALWAYS;
	StencilEnable = FALSE;
};

DepthStencilState DownsamplingStencilState {
	DepthEnable = FALSE;

	StencilEnable = TRUE;
	StencilReadMask = 1;
	StencilWriteMask = 1;

	FrontFaceStencilFunc = ALWAYS;
	FrontFaceStencilPass = REPLACE;

	BackFaceStencilFunc = ALWAYS;
	BackFaceStencilPass = REPLACE;
};

#define COMMON_PART2	SetVertexShader(vsComp);	\
						SetGeometryShader(NULL);	\
						SetHullShader(NULL);		\
						SetDomainShader(NULL);		\
						SetComputeShader(NULL);		\
						SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
						SetRasterizerState(cullNone);

#define COMMON_PART		COMMON_PART2 \
						SetDepthStencilState(disableDepthBuffer, 0);

technique10 TerrainShadows {
	pass P0 {
		SetPixelShader(CompileShader(ps_5_0, PS_TERRAIN_SHADOWS(true)));
		COMMON_PART
	}
	pass P1 {
		SetPixelShader(CompileShader(ps_5_0, PS_TERRAIN_SHADOWS(false)));
		COMMON_PART
	}
	pass P2 {
		SetPixelShader(CompileShader(ps_5_0, PS_TERRAIN_SHADOWS_DOWNSAMPLED(true)));
		SetDepthStencilState(DownsamplingDepthState, 0);
		COMMON_PART2
	}
	pass P3 {
		SetPixelShader(CompileShader(ps_5_0, PS_TERRAIN_SHADOWS_DOWNSAMPLED(false)));
		SetDepthStencilState(DownsamplingDepthState, 0);
		COMMON_PART2
	}
	pass DownsampleStencil {
		SetPixelShader(CompileShader(ps_5_0, PS_DownsamplingStencil()));
		SetDepthStencilState(DownsamplingStencilState, 1);
		COMMON_PART2
	}
	pass Blur {
		SetPixelShader(CompileShader(ps_5_0, PS_BlurComposed()));
		COMMON_PART
	}
}

technique10 BlurTech {
	pass P0 {
		SetPixelShader(CompileShader(ps_5_0, PS_Blur(float2(1, 0))));
		COMMON_PART
	}
	pass P1 {
		SetPixelShader(CompileShader(ps_5_0, PS_Blur(float2(0, 1))));
		COMMON_PART
	}
}
