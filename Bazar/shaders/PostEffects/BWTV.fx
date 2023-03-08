#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "deferred/blur.hlsl"
#include "noise/noise2D.hlsl"
#include "common/BC.hlsl"

Texture2D DiffuseMap;
float4	viewport;

uint2 uDims;

float uNoiseFrequency;	// 1..100, default = 10
float uFreqNoise;		// 0..1
float uFrontNoise;		// 0..1
float uSyncNoise;		// 0..1 
float uBlur;			// 0..1
float uContrast;		// 0..1
float uBrightness;		// 0..1

struct VS_OUTPUT {
	float4 pos:			SV_POSITION;
	float4 projPos:		TEXCOORD0;
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

static const float3 mult = { 1.5, 1.0, 0.5 };
static const float3 LUM = { 0.2125f, 0.7154f, 0.0721f };

float3 BW_simple(float2 uv,uniform Texture2D tex) {
	float2 uv2 = uv;
	float  dy;
	uv2.x = modf(uv2.x + 0.0, dy); 
	uv2.y += (dy - 0.0) / uDims.y;
	return tex.SampleLevel(gBilinearWrapSampler, uv2, 0).rgb;
}


float3 BlurWB(float2 uv, float off, float sigma, uniform Texture2D tex) {
	float3 result = 0;
	[unroll]
	for (int i = 0; i < 15; i++) {
		float weight = calcGaussianWeight(i, sigma)*(1+sign(i));
		float2 uv2 = uv;
		uv2.x -= off * i * sigma;
		float dy;
		uv2.x = modf(uv2.x + 0.0, dy); 
		uv2.y += (dy - 0.0) / uDims.y;
		result += tex.SampleLevel(gBilinearWrapSampler, uv2, 0).rgb * weight;
	}
	return result;
}

float syncNoise1(float y, float t) {
	float v = max(0, snoise(float2(y, t)) - 1.0 + uSyncNoise*2.0);
	return  v*y;
}

float2 syncNoise(float2 uv, float t) {
	const float dy = 0.15;
	return float2(-syncNoise1(uv.y, t) * frac(uv.y*50)*10, max(0, (1-uv.y) / dy) * 
		max(syncNoise1(max(uv.y - 0.2, 0), t),
  		    syncNoise1(max(uv.y - 0.5, 0), t)) * dy);
}

float frontNoise(float2 uv, float t) {
	float result  = max(0, snoise(float2(uv.y * 5.0, t)) - 0.1);
	result += max(0, snoise(float2(uv.y * 20.0, t)) - 0.2);
	result += max(0, snoise(float2(uv.y * 80.0, t)) - 0.4);
	return result;
}

float3 distorsionNoBlur(float2 uv) {
	float t = floor(gModelTime*25.0) / 2.5;	// quant time * 10

	float frn = frontNoise(uv, t) * (uFrontNoise * -0.03);
	float fn = 1.0 - uFreqNoise * 0.5 + uFreqNoise * snoise(float2((uv.y*uDims.x + uv.x)*uNoiseFrequency, t));

	float3 c3 = BW_simple(uv + syncNoise(uv, t) + float2(frn, 0),DiffuseMap) * fn;
	c3 = BC(c3, uBrightness, uContrast);

	return saturate(c3);
}

float3 baseDistorsion(float2 uv) {
	float t = floor(gModelTime*25.0) / 2.5;	// quant time * 10

	float frn = frontNoise(uv, t) * (uFrontNoise * -0.03);
	float fn = 1.0 - uFreqNoise * 0.5 + uFreqNoise * snoise(float2((uv.y*uDims.x + uv.x)*uNoiseFrequency, t));

	float3 c3 = BlurWB(uv + syncNoise(uv, t) + float2(frn, 0), uBlur / uDims.x, 3.0, DiffuseMap) * fn;
	c3 = BC(c3, uBrightness, uContrast);

	return saturate(c3);
}

float4 PS(const VS_OUTPUT i): SV_TARGET0 {
	uint2 idx = i.pos.xy;
	uint y = uint(idx.y / 3) * 3;

	float2 uv = float2(i.projPos.x*0.5+0.5, -i.projPos.y/idx.y*y*0.5+0.5)*viewport.zw + viewport.xy;

	float3 c3 = baseDistorsion(uv);
	c3 *= 1 - length(i.projPos.xy)*0.25;
	float c = dot(c3, LUM) *mult[idx.y % 3];	// build BW raster
	return float4(c, c, c, 1);
}

float4 PS_BW_DISTORSION(const VS_OUTPUT i) : SV_TARGET0 {
	float2 uv = float2(i.projPos.x*0.5 + 0.5, -i.projPos.y*0.5 + 0.5)*viewport.zw + viewport.xy;
	float   c = dot(baseDistorsion(uv), LUM);
	return float4(c, c, c, 1);
}

float4 PS_BW_DISTORSION_NOBLUR(const VS_OUTPUT i): SV_TARGET0 {
	float2 uv = float2(i.projPos.x*0.5 + 0.5, -i.projPos.y*0.5 + 0.5)*viewport.zw + viewport.xy;
	float   c = dot(distorsionNoBlur(uv), LUM);
	return float4(c, c, c, 1);
}

float4 PS_DISTORSION(const VS_OUTPUT i) : SV_TARGET0 {
	float2 uv = float2(i.projPos.x*0.5 + 0.5, -i.projPos.y*0.5 + 0.5)*viewport.zw + viewport.xy;
	return float4(baseDistorsion(uv), 1);
}

technique10 Tech {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS_DISTORSION()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
	pass P1 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS_BW_DISTORSION()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	pass P2 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
	pass P3 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS_BW_DISTORSION_NOBLUR()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}

}


