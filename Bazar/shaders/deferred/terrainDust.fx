#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "deferred/blur.hlsl"
#include "common/context.hlsl"
#include "noise/noise2D.hlsl"

#define FOG_ENABLE 1
#include "common/fogCommon.hlsl"


Texture2D<float> blurSrc;
uint2	dims;
float4x4 maskInvMatrix;


Texture2D<float> DepthMap;
Texture2D<float> DustMap;
Texture2D skyTex: register(t107); 			//prerendered sky


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
	o.projPos /= o.projPos.w;
	return o;
}

static const float factor = 0.25;

float Blur(float2 uv, float2 off, float sigma, uniform bool firstPass) {
	float result = 0;
	for (int i = -6; i < 6; i++) {
		float weight = calcGaussianWeight(i, sigma);
		float v = blurSrc.SampleLevel(gBilinearClampSampler, uv + off*sigma*i, 0).r;
		if (firstPass) {
			v = v < 1;
			float2 uv2 = (mul(float4(uv, 0, 1), maskInvMatrix).xz + gOrigin.xz)*0.0002;
			v = factor+saturate(snoise(uv2)+0.25)*v*(1-factor);
		}
		result += v * weight;
	}
	return result;
}

static const float blurSigma = 4.0;

float4 PS_BlurH(const VS_OUTPUT i) : SV_TARGET0 {
	float2 uv = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	return Blur(uv, float2(1, 0)*(4.0 / dims), blurSigma, true);
}

float4 PS_BlurV(const VS_OUTPUT i) : SV_TARGET0 {
//	return 1;
	float2 uv = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	return Blur(uv, float2(0, 1)*(2.0 / dims), blurSigma, false);
}

/////////////////////////////// Dust

float heightFalloff;	// = 0.005;
float globalDensity;	// = 0.005;
float3 dustColor;		// = float3(1, 0.5, 0.25);

static const float3 LUM = { 0.2125, 0.7154, 0.0721 };

float getMask(float3 wpos) {
	float4 uv = mul(float4(wpos, 1), gTerrainMaskMatrix);
	return DustMap.SampleLevel(gBilinearClampSampler, uv.xy / uv.w, 0).x;
}

float2 computeFog(float3 wpos) {

	float cameraHeight = gCameraPos.y + gOrigin.y;
	float3 cwpos = wpos - gCameraPos;
	float dist = length(cwpos);
	float3 v = cwpos / dist;

	float factor = saturate((cameraHeight - 3.5/heightFalloff)*0.01);
	float df = dist*0.001 * factor;

	float d0 = getMask(gCameraPos);
	float d1 = getMask(wpos);
	float d = max(lerp(d0, d1, factor), d1);

	d = lerp(d0, d, exp(-dist*0.00003));
//	d = lerp(1, d, exp(-dist*0.00003));

	float density = d * globalDensity;
	float fog = 1-fogCalcAttenuation(heightFalloff, density, cameraHeight, dist, v.y);

	return float2(fog, df);
}

float4 PS(const VS_OUTPUT i): SV_TARGET0 {

	uint2 uv = i.pos.xy;
	float depth = DepthMap.Load(uint3(uv, 0));
	float4 pos = mul(float4(i.projPos.xy, depth, 1), gViewProjInv);
	float3 wpos = pos.xyz/pos.w;

	float2 f = computeFog(wpos);

	float col = lerp(gSunDiffuse, dot(gSunDiffuse, LUM), 0.7);
	float3 fog = (dustColor*col*gSunIntensity*0.2)*f.x;

	float2 tc = float2(0.5 * i.projPos.x + 0.5, -0.5 * i.projPos.y + 0.5);
	float3 sky = skyTex.Sample(gBilinearClampSampler, tc.xy).xyz;

	fog = lerp(sky, fog, exp(-f.y*0.025));

	return float4(fog, f.x);
}


VertexShader vsComp = CompileShader(vs_5_0, VS());

technique10 BlurTech {
	pass P0 {
		SetVertexShader(vsComp);
		SetPixelShader(CompileShader(ps_5_0, PS_BlurH()));
		SetGeometryShader(NULL);

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	pass P1 {
		SetVertexShader(vsComp);
		SetPixelShader(CompileShader(ps_5_0, PS_BlurV()));
		SetGeometryShader(NULL);

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

technique10 DustTech {
	pass P0 {
		SetVertexShader(vsComp);
		SetPixelShader(CompileShader(ps_5_0, PS())); 
		SetGeometryShader(NULL); 
		SetDepthStencilState(disableDepthBuffer, 0); 
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); 
		SetRasterizerState(cullNone);
	}
}



