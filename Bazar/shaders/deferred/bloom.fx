#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "deferred/deferredCommon.hlsl"
#include "deferred/luminance.hlsl"
#include "deferred/toneMap.hlsl"
#include "common/colorTransform.hlsl"

Texture2D<float4> bloomTexture;
Texture2D<float4> bloomLayer0;
Texture2D<float4> bloomLayer1;
Texture2D<float4> bloomLayer2;
Texture2D<float4> bloomLayer3;
Texture2D<float4> bloomLayer4;
Texture2D<float4> bloomLayer5;

float2	srcDims;
TEXTURE_2D(float4, srcFit);

float	accumOpacity;
float3	thresholdTint;

struct VS_OUTPUT {
	noperspective float4 pos	:SV_POSITION0;
	noperspective float2 projPos:TEXCOORD0;
};

VS_OUTPUT VS(uint vid: SV_VertexID)
{
	const float2 quad[4] = {
		{-1, -1}, {1, -1},
		{-1,  1}, {1,  1}
	};
	VS_OUTPUT o;
	o.pos = float4(quad[vid], 0, 1);
	o.projPos.xy = float2(o.pos.x, -o.pos.y) * 0.5 + 0.5;
	return o;
}

float3 thresholdMap(float3 color, float exposure, float threshold)
{
	//[CRUNCH]
	// Частенько из земли прилетает очень большая яркость как следствие кривых нормалей
	// поверхности земли, или кривой шероховатости. Блуму это не нравится.
	// Anatol, 8:57 PM: "Долгая история, проблемы в сборке. Не придумали еще как пофиксить"
	// color.rgb = min(float3(256 * 256, 256 * 256, 256 * 256), color.rgb);//clamp to float16

	float lum = (color.r+color.g+color.b) * 0.3333 * exposure;
	return color * saturate((lum - threshold) * 0.5);
}

float3 thresholdMap(float3 color)
{
	return thresholdMap(color, getLinearExposure(getAvgLuminanceClamped()), bloomThreshold);
}

float3 PS_ThresholdMap(const VS_OUTPUT i, uniform bool modeNVG): SV_TARGET0 // threshold and downsample 2х
{
	const uint2 offs[4] = { {0, 0}, {1, 0},	{0, 1}, {1, 1} };

	float3 result = 0;
	float weight = 0.0;
	uint2 uv = i.pos.xy*2;

	if (modeNVG) {
		return thresholdMap(SampleMap(ComposedMap, uv, 0).rgb * thresholdTint);
	} else {
		[unroll]
		for (int i = 0; i < 4; ++i)
		{
			//TODO: учесть MSAA?
			float3 color = thresholdMap(SampleMap(ComposedMap, uv + offs[i%4], 0).rgb);
			// float3 color = SampleMap(ComposedMap, uv + offs[i], 0).rgb;
			float w = rcp(color.r + color.g + color.b + 1e-5);
			result += color * w;
			weight += w;
		}
		return result / weight;
		// return thresholdMap(result / weight);
	}
}

float3 PS_ThresholdMapFit(const VS_OUTPUT i, uniform bool modeNVG): SV_TARGET0  {
	float2 uv = i.projPos.xy;
	float3 color = SampleMap(srcFit, uv * srcDims, 0).xyz;
	if (modeNVG) 
		return thresholdMap(color * thresholdTint);
	else 
		return thresholdMap(color);
}

float3 PS_downsampling(const VS_OUTPUT i, uniform bool bWeighted): SV_TARGET0
{
	float2 p = 0.5/srcDims;
	float2 uv = i.projPos.xy + p;
	float2 offset[] = {-p, {-p.x, p.y}, {p.x, -p.y}, p};
	float3 result = 0;
	float weight = 0;
	[unroll]
	for(int i=0; i<4; ++i)
	{
		float3 color = bloomTexture.SampleLevel(gPointClampSampler, uv+offset[i], 0).rgb;

		float w = 1;//bWeighted? rcp(color.r + color.g + color.b + 1e-6) : 1;
		result += color * w;
		weight += w;
	}
	return result / weight;
}

float3 getBloomColor(float i, float b0)
{
	// return 1;//bloomIntensity0;
	return lerp(bloomIntensity0, bloomIntensity1, i/5.0);
	// return lerp(bloomTint0*bloomIntensity0, bloomTint1*bloomIntensity1, saturate(i/5.0 + exp(-b0*gDev1.z))) * bloomIntensity0;
}

float3 getBloomGradient(float t, float b0)
{
	return lerp(bloomTint1, bloomTint0, saturate(t*1));
	// return lerp(bloomTint1, bloomTint0, saturate(t*gDev1.z));
	// return lerp(bloomTint1*bloomIntensity1, bloomTint0*bloomIntensity0, saturate(t*gDev1.z));
	// return lerp(bloomTint0*bloomIntensity0, bloomTint1*bloomIntensity1, saturate(i/5.0 + exp(-b0*gDev1.z))) * bloomIntensity0;
}


float3 PS_sum_hw(const VS_OUTPUT i, uniform int count): SV_TARGET0
{
	float3 color = 0;

	float3 b0 = bloomLayer0.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * getBloomColor(0, 99999);
	color += b0;
	b0 = dot(b0, 0.33333);
	color += bloomLayer1.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * getBloomColor(1, b0);

	if(count>2)
		color += bloomLayer2.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * getBloomColor(2, b0);
	if(count>3)
		color += bloomLayer3.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * getBloomColor(3, b0);
	if(count>4)
		color += bloomLayer4.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * getBloomColor(4, b0);
	if(count>5)
		color += bloomLayer5.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * getBloomColor(5, b0);

	// float3 hsv = rgb2hsv(color*gDev0.x);
	// hsv.x += gDev1.w;
	// return hsv2rgb(hsv);
	float3 colorCompressed = 1 - exp(-color*1);

	color = lerp(color, colorCompressed, hwFactor);
	// color = 1 - exp(-color*gDev0.x);

	color *= getBloomGradient(dot(color,0.33333), 0);

	return color;
}

float3 PS_sum(const VS_OUTPUT i, uniform int count): SV_TARGET0
{
	float3 color = 0;

	color += bloomLayer0.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * bloomTint0 * bloomIntensity0;
	color += bloomLayer1.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * bloomTint1 * bloomIntensity1;

	if(count>2)
		color += bloomLayer2.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * bloomTint2 * bloomIntensity2;
	if(count>3)
		color += bloomLayer3.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * bloomTint3 * bloomIntensity3;
	if(count>4)
		color += bloomLayer4.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * bloomTint4 * bloomIntensity4;
	if(count>5)
		color += bloomLayer5.SampleLevel(gBilinearClampSampler, i.projPos.xy, 0).rgb * bloomTint5 * bloomIntensity5;

	return color;
}

float4 PS_CopyToAccumulator(const VS_OUTPUT i): SV_TARGET0
{
	float3 bloom = bloomTexture.SampleLevel(gPointClampSampler, i.projPos.xy, 0).rgb;
	float lum = dot(bloom, 0.333);
	float factor = 1 - exp(-lum * 10);
	return float4(bloom, lerp(1, accumOpacity, factor) );
}


VertexShader vsComp = CompileShader(vs_5_0, VS());

#define PASS_BODY(ps) { SetVertexShader(vsComp); SetGeometryShader(NULL); SetPixelShader(CompileShader(ps_5_0, ps)); \
	SetDepthStencilState(disableDepthBuffer, 0); \
	SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
	SetRasterizerState(cullNone);}

technique10 Bloom {
	pass thresholdMap			PASS_BODY(PS_ThresholdMap(false))
	pass thresholdMap_NVG		PASS_BODY(PS_ThresholdMap(true))
	pass thresholdMapFit		PASS_BODY(PS_ThresholdMapFit(false))
	pass thresholdMapFit_NVG	PASS_BODY(PS_ThresholdMapFit(true))
	pass downsample				PASS_BODY(PS_downsampling(false))
	pass downsampleWeighted		PASS_BODY(PS_downsampling(true))
	pass sum2					PASS_BODY(PS_sum(2))
	pass sum3					PASS_BODY(PS_sum(3))
	pass sum4					PASS_BODY(PS_sum(4))
	pass sum5					PASS_BODY(PS_sum(5))
	pass sum6					PASS_BODY(PS_sum(6))
	pass sum6HW					PASS_BODY(PS_sum_hw(6))
	pass copyToAccumulator
	{ 
		SetVertexShader(vsComp);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, PS_CopyToAccumulator()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
