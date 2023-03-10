#ifndef COMPOSED_SHADOWS_HLSL
#define COMPOSED_SHADOWS_HLSL

#if defined(MSAA) && !USE_BLUR_FLAT_SHADOWS
	Texture2DMS<float, MSAA> ShadowsMap;
	float SampleShadowComposed(uint2 uv, uint idx) { return ShadowsMap.Load(uint2(uv), idx).x; }
#else
	Texture2D<float> ShadowsMap;
	float SampleShadowComposed(uint2 uv, uint idx) { return ShadowsMap.Load(uint3(uv, 0)).x; }
#endif

float SC_gaussian(float x, float s) {
	return exp(-x * x / (2 * s * s));
}

#if	USE_BLUR_FLAT_SHADOWS 

	Texture2D<float> ShadowsDepth;
	Texture2D<uint2> ShadowsStencil;

	uint2 ShadowsSize;
	float4 ShadowsViewport;

#if 0
	float SC_depthToDistane(float depth) {	// TODO optimizze it
		float4 pos = mul(float4(0,0, depth, 1), gProjInv);
		return pos.z / pos.w;
	}

	float2 SC_sampleValue(uint2 uv) {
		float shadows = ShadowsMap.Load(uint3(uv, 0)).x;
		float depth = ShadowsDepth.Load(uint3(uv, 0)).x;
		float dist = SC_depthToDistane(depth);
		return float2(shadows, dist);
	}

	float SC_joinedBilateralUpsample(float2 uv, float depth) {
		float dist = SC_depthToDistane(depth);

		float2 pixel = uv * ShadowsSize + 0.5;
		float2 f = frac(pixel);
		uint2 px = floor(pixel) - 0.5;
	
		float2 v00 = SC_sampleValue(px + uint2(0, 0));
		float2 v01 = SC_sampleValue(px + uint2(0, 1));
		float2 v10 = SC_sampleValue(px + uint2(1, 0));
		float2 v11 = SC_sampleValue(px + uint2(1, 1));

		const float sigma = 0.1;
		const float dw = 100 / dist;	// distance weight factor

		float2 f1 = 1 - f;
		float w00 = SC_gaussian((dist - v00.y) * dw, sigma) * f1.x * f1.y;
		float w01 = SC_gaussian((dist - v01.y) * dw, sigma) * f1.x * f.y;
		float w10 = SC_gaussian((dist - v10.y) * dw, sigma) * f.x  * f1.y;
		float w11 = SC_gaussian((dist - v11.y) * dw, sigma) * f.x  * f.y;

		w00 += 1e-12;
		return (v00.x * w00 + v01.x * w01 + v10.x * w10 + v11.x * w11) / (w00 + w01 + w10 + w11);
	}

	float getShadowComposed(float2 uv, float depth) {
		return SC_joinedBilateralUpsample(ShadowsViewport.xy + ShadowsViewport.zw * uv, depth);
		return ShadowsMap.SampleLevel(gTrilinearClampSampler, uv, 0).x;
	}
#endif

	float2 SC_sampleValueSB(uint2 uv) {
		float shadows = ShadowsMap.Load(uint3(uv, 0)).x;
		float isSurface = (ShadowsStencil.Load(uint3(uv, 0)).y & 2) >> 1;
		return float2(shadows, 1 - isSurface);
	}

	float getShadowComposed(uint2 px, bool isTerrainSurface) {
		float2 v00 = SC_sampleValueSB(px + uint2(0, 0));
		float2 v01 = SC_sampleValueSB(px + uint2(0, 1));
		float2 v10 = SC_sampleValueSB(px + uint2(1, 0));
		float2 v11 = SC_sampleValueSB(px + uint2(1, 1));
		float w00 = v00.y == isTerrainSurface;
		float w01 = v01.y == isTerrainSurface;
		float w10 = v10.y == isTerrainSurface;
		float w11 = v11.y == isTerrainSurface;
		return (v00.x * w00 + v01.x * w01 + v10.x * w10 + v11.x * w11) / (w00 + w01 + w10 + w11 + 1e-12);
	}

#else
	float getShadowComposed(uint2 uv, bool isTerrainSurface) {	return 0;	}
#endif

#endif
