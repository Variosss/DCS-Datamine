#ifndef STOCHASTIC_SAMPLER_HLSL
#define STOCHASTIC_SAMPLER_HLSL

void triangleGrid(float2 uv, out float3 w, out int2 v0, out int2 v1, out int2 v2) {
	const float2x2 gridToSkewedGrid = { 1.0, 0.0, -0.57735026919, 1.15470053838 };
	float2 skewedCoord = mul(gridToSkewedGrid, uv * 3.46410161514); // 2 * sqrt(3)
	int2 id = int2(floor(skewedCoord));	
	float3 t = float3(frac(skewedCoord), 0);
	t.z = 1.0 - t.x - t.y;
	if (t.z > 0.0) {
		w = t.zyx;
		v0 = id;
		v1 = id + int2(0, 1);
		v2 = id + int2(1, 0);
	} else {
		w.x = -t.z;
		w.yz = 1.0 - t.yx;
		v0 = id + int2(1, 1);
		v1 = id + int2(1, 0);
		v2 = id + int2(0, 1);
	}
}

float2 hash(float2 p) {
	return frac(sin(mul(p, float2x2(127.1, 311.7, 269.5, 183.3))) * 43758.5453);
}

struct StochasticUV {
	float2 uv0, uv1, uv2;
	float3 w;
};

StochasticUV stochasicUV(float2 uv, uniform uint tilingMult = 128) {
	StochasticUV r;
	int2 v0, v1, v2;
	triangleGrid(uv, r.w, v0, v1, v2);

	if (tilingMult > 0) {
		v0 %= tilingMult;
		v1 %= tilingMult;
		v2 %= tilingMult;
	}

	r.uv0 = uv + hash(v0);
	r.uv1 = uv + hash(v1);
	r.uv2 = uv + hash(v2);
	return r;
}

float4 stochasticSampleLevel(uniform Texture2D tex, uniform sampler texSampler, StochasticUV s, int mip, float2 offset = 0) {
	float4 c0 = tex.SampleLevel(texSampler, s.uv0 + offset, mip);
	float4 c1 = tex.SampleLevel(texSampler, s.uv1 + offset, mip);
	float4 c2 = tex.SampleLevel(texSampler, s.uv2 + offset, mip);
	return c0 * s.w.x + c1 * s.w.y + c2 * s.w.z;
}

float4 stochasticSampleLevelArr(uniform Texture2DArray tex, uniform uint layer, uniform sampler texSampler, StochasticUV s, int mip, float2 offset = 0) {
	float4 c0 = tex.SampleLevel(texSampler, float3(s.uv0 + offset, layer), mip);
	float4 c1 = tex.SampleLevel(texSampler, float3(s.uv1 + offset, layer), mip);
	float4 c2 = tex.SampleLevel(texSampler, float3(s.uv2 + offset, layer), mip);
	return c0 * s.w.x + c1 * s.w.y + c2 * s.w.z;
}

float4 stochasticSampleGrad(uniform Texture2D tex, uniform sampler texSampler, StochasticUV s, float2 ddx, float2 ddy, float2 offset = 0) {
	float4 c0 = tex.SampleGrad(texSampler, s.uv0 + offset, ddx, ddy);
	float4 c1 = tex.SampleGrad(texSampler, s.uv1 + offset, ddx, ddy);
	float4 c2 = tex.SampleGrad(texSampler, s.uv2 + offset, ddx, ddy);
	return c0 * s.w.x + c1 * s.w.y + c2 * s.w.z;
}

float4 stochasticSampleGradArr(uniform Texture2DArray tex, uniform uint layer, uniform sampler texSampler, StochasticUV s, float2 ddx, float2 ddy, float2 offset = 0) {
	float4 c0 = tex.SampleGrad(texSampler, float3(s.uv0 + offset, layer), ddx, ddy);
	float4 c1 = tex.SampleGrad(texSampler, float3(s.uv1 + offset, layer), ddx, ddy);
	float4 c2 = tex.SampleGrad(texSampler, float3(s.uv2 + offset, layer), ddx, ddy);
	return c0 * s.w.x + c1 * s.w.y + c2 * s.w.z;
}


float4 stochasticSampleLevel(uniform Texture2D tex, uniform sampler texSampler, float2 uv, int mip, uniform uint tilingMult = 128) {
	StochasticUV s = stochasicUV(uv, tilingMult);
	return stochasticSampleLevel(tex, texSampler, s, mip);
}

float4 stochasticSample(uniform Texture2D tex, uniform sampler texSampler, float2 uv, uniform uint tilingMult = 128) {
	StochasticUV s = stochasicUV(uv, tilingMult);
	float2 dx = ddx(uv);
	float2 dy = ddy(uv);
	return stochasticSampleGrad(tex, texSampler, s, dx, dy);
}

#endif
