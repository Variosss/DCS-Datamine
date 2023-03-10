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

static const float blurSigma = 0.7;

float4 PS_Blur(const VS_OUTPUT i, uniform float2 offset) : SV_TARGET0{
	float2 uv = float2(i.projPos.x, -i.projPos.y) * 0.5 + 0.5;
	return float4(Blur(uv, offset * (8.0 / dims), blurSigma, blurSrc), 0);
}

#if USE_BLUR_FLAT_SHADOWS

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

	void PS_DownsamplingStencil(const VS_OUTPUT i) {
		uint2 uv = i.pos.xy;
		uint s = SampleMap(StencilMap, uv * downsample, 0).y;
		uint materialId = s & STENCIL_COMPOSITION_MASK;
		if (materialId == STENCIL_COMPOSITION_SURFACE)
			discard;
	}

	#define SC_GAUSS_KERNEL 2
	#define SC_SIGMA 1.4
	#define BASE_SHADOWMAP_SIZE 4096

	float SC_gaussianBlur(uint2 uv) {
		float aw = 0;
		float acc = 0;
		float sigma = SC_SIGMA * BASE_SHADOWMAP_SIZE / ShadowMapSize;
		for (int iy = -SC_GAUSS_KERNEL; iy <= SC_GAUSS_KERNEL; ++iy) {
			float gy = SC_gaussian(iy, sigma);
			for (int ix = -SC_GAUSS_KERNEL; ix <= SC_GAUSS_KERNEL; ++ix) {
				float gx = SC_gaussian(ix, sigma);
				float w = gx * gy;
				acc += ShadowsMap.Load(uint3(uv.x + ix, uv.y + iy, 0)).x * w;
				aw += w;
			}
		}
		return acc / aw;
	}

#if 0
	float SC_joinedBilateralGaussianBlur(uint2 uv) {
		float pz = SC_depthToDistane(ShadowsDepth.Load(uint3(uv, 0)).x);
		float aw = 0;
		float acc = 0;
		float sigma = SC_SIGMA * BASE_SHADOWMAP_SIZE / ShadowMapSize;
		for (int iy = -SC_GAUSS_KERNEL; iy <= SC_GAUSS_KERNEL; ++iy) {
			float gy = SC_gaussian(iy, sigma);
			for (int ix = -SC_GAUSS_KERNEL; ix <= SC_GAUSS_KERNEL; ++ix) {
				float gx = SC_gaussian(ix, sigma);
				float vz = SC_depthToDistane(ShadowsDepth.Load(uint3(uv.x + ix, uv.y + iy, 0)).x);

				float gv = SC_gaussian(abs((pz - vz) / pz * 5000.0), sigma);
				float w = gx * gy * gv;
				acc += ShadowsMap.Load(uint3(uv.x + ix, uv.y + iy, 0)).x * w;
				aw += w;
			}
		}
		return acc / aw;
	}

#endif

	float2 valueSB(uint2 uv) {
		uint w = !(ShadowsStencil.Load(uint3(uv, 0)).y & 2);
		float v = (1 - ShadowsMap.Load(uint3(uv, 0)).x);
		return float2(v, w);
	}

	float SC_gaussianBlurSB(uint2 uv) {
		float2 v = valueSB(uv);
		if (!v.y)
			return 1-v.x;

		float2 acc = 0;
		float sigma = SC_SIGMA * BASE_SHADOWMAP_SIZE / ShadowMapSize;
		for (int iy = -SC_GAUSS_KERNEL; iy <= SC_GAUSS_KERNEL; ++iy) {
			float gy = SC_gaussian(iy, sigma);
			for (int ix = -SC_GAUSS_KERNEL; ix <= SC_GAUSS_KERNEL; ++ix) {
				float gx = SC_gaussian(ix, sigma);
				float w = gx * gy;
				float2 v = valueSB(uint2(uv.x + ix, uv.y + iy));
				acc += float2(v.x * v.y, v.y) * w;
			}
		}
		return 1 - acc.x / (acc.y + 1e-9);
	}


	float4 PS_BlurComposed(const VS_OUTPUT i): SV_TARGET0 {
	//	return float4(SC_gaussianBlur(i.pos.xy), 0, 0, 1);
	//	return float4(SC_joinedBilateralGaussianBlur(i.pos.xy), 0, 0, 1);
		return float4(SC_gaussianBlurSB(i.pos.xy), 0, 0, 1);
	}

	DepthStencilState DownsamplingDepthState {
		DepthEnable = TRUE;
		DepthWriteMask = ALL;
		DepthFunc = ALWAYS;
		StencilEnable = FALSE;
	};

	DepthStencilState DownsamplingStencilState {
		DepthEnable = FALSE;

		StencilEnable = TRUE;
		StencilReadMask = 3;
		StencilWriteMask = 3;

		FrontFaceStencilFunc = ALWAYS;
		FrontFaceStencilPass = REPLACE;

		BackFaceStencilFunc = ALWAYS;
		BackFaceStencilPass = REPLACE;
	};

#endif

VertexShader vsComp = CompileShader(vs_5_0, VS());

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
#if USE_BLUR_FLAT_SHADOWS
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
		SetDepthStencilState(DownsamplingStencilState, 3);
		COMMON_PART2
	}
	pass Blur {
		SetPixelShader(CompileShader(ps_5_0, PS_BlurComposed()));
		COMMON_PART
	}
#endif
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
