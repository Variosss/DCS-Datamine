#include "common/context.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "deferred/atmosphere.hlsl"
#include "deferred/shading.hlsl"
#include "common/atmosphereSamples.hlsl"

float4x4 pitchMatrix;
float4x4 modelPos;
float4x4 viewProj;
float4x4 sampleMatrix;

uint	instanceCount;
uint	bladeCount;

float3	cScale;
float	blurFactor;
float	texScale;

float	sigma;
float	rpm;

float4	flirCoeff;

Texture2D texAirscrew;
Texture2D texAlbedo;
Texture2D texAORM;
Texture2D texNormal;		// ignore it
Texture2D texFLIR;

static const float PI = 3.1415926535897932384626433832795;

float instanceAlpha(uint id, uint bladeCount, uint instanceCount, float sigma, float angle) {
	float acc = 0;
	for (uint i = 0; i < bladeCount; ++i) {
		float x = (fmod(id + i*instanceCount/bladeCount + angle*instanceCount, instanceCount) - instanceCount * 0.5) / instanceCount;
		acc += exp(-x * x / (2 * sigma*sigma));
	}
	return acc;
}

float normalizedInstanceAlpha(uint id, uint bladeCount, uint instanceCount, float sigma, float angle) {
	float acc = 0;
	for (uint i = 0; i < instanceCount; ++i)
		acc += instanceAlpha(i, bladeCount, instanceCount, sigma, 0);
	return instanceAlpha(id, bladeCount, instanceCount, sigma, angle) / acc * bladeCount;
}

struct PS_INPUT {
	float4 pos: 	SV_POSITION0;
	float4 wPos: 	POSITION0;
	float3 normal: 	NORMAL0;
	float2 uv:		TEXCOORD0;
	float  bladeAlpha: TEXCOORD1;
};

PS_INPUT VS (
	in float3 pos: POSITION0,
	in float3 normal: NORMAL0,
	in float3 tangent: NORMAL1,			// ignore it
	in float2 uv: TEXCOORD0,
	in uint instId: SV_InstanceID,

	uniform bool useContextViewProj
)
{
	float rps = rpm * (1 / 60.0);
	float angle = frac(gModelTime * rps);

	float s, c;
	float a = PI * 2 * instId / instanceCount + PI * 0.5;
	a -= angle * 2 * PI;

	sincos(a, s, c);
	float4x4 mr = { 1, 0, 0, 0,
					0, c,-s, 0,
					0, s, c, 0, 
					0, 0, 0, 1};

	float4x4 bladePos = mul(pitchMatrix, mr);
	float3x3 normalMatrix = mul((float3x3)bladePos, (float3x3)modelPos);
	float4 p = mul(float4(pos, 1), bladePos);

	PS_INPUT o;
	o.wPos = mul(p, modelPos);
	if (useContextViewProj) 
		o.pos = mul(o.wPos, gViewProj);
	else
		o.pos = mul(p, viewProj);
	o.normal = mul(normal, normalMatrix);
	o.bladeAlpha = normalizedInstanceAlpha(instId, bladeCount, instanceCount, sigma, 0);
	o.uv = uv;

	return o;
}

float4 PS_PREPASS(PS_INPUT i, uniform bool applyAtmosphere) : SV_TARGET0 {

	float3 N = normalize(i.normal);	// ignore texNormal and tangent space
	float4 aorm = texAORM.Sample(gAnisotropicWrapSampler, i.uv);
	float3 albedo = texAlbedo.Sample(gAnisotropicWrapSampler, i.uv).xyz;
	float3 wpos = i.wPos.xyz;
	float3 V = normalize(gCameraPos - wpos);

	float shadow = SampleShadowCascade(wpos, i.pos.z, N, false, false, false);
	shadow = min(shadow, SampleShadowClouds(wpos).x);

	if (applyAtmosphere) {
		AtmosphereSample atm = SamplePrecomputedAtmosphere(0);
		float3 c = ShadeHDR(i.pos.xy, atm.sunColor / gSunIntensity, albedo, N, aorm.y, aorm.z, 0, shadow, aorm.x, 1, V, wpos);
		c = c * atm.transmittance;
		return float4(c, i.bladeAlpha);
	} else {
		float3 sunColor = SampleSunRadiance(wpos, gSunDir);
		return float4(ShadeHDR(i.pos.xy, sunColor, albedo, N, aorm.y, aorm.z, 0, shadow, aorm.x, 1, V, wpos), i.bladeAlpha);
	}
}

float4 PS_PREPASS_FLIR(PS_INPUT i): SV_TARGET0 {
	float4 flir = texFLIR.Sample(gAnisotropicWrapSampler, i.uv);
	float v = flir[0] * flirCoeff[0] + flir[1] * flirCoeff[1] + flir[2] * flirCoeff[2] + flir[3] * flirCoeff[3];
	float4 c = float4(v, v, v, i.bladeAlpha);
	return c;
}

struct PS_INPUT_C {
	float3 pos: TEXCOORD0;
	float3 wpos: TEXCOORD1;
	float4 projPos: TEXCOORD2;
	float4 sv_pos: SV_POSITION0;
};

PS_INPUT_C VS_CYLINDER(in float3 pos: POSITION0, uniform bool useContextViewProj) {
	float4 p = float4(lerp(cScale[0], cScale[1], step(0, pos.x))*1.1, pos.yz * cScale[2], 1);
	float4 wpos = mul(p, modelPos);

	PS_INPUT_C o;
	o.pos = p.xyz;
	o.wpos = wpos.xyz / wpos.w;

	if (useContextViewProj)
		o.sv_pos = o.projPos = mul(wpos, gViewProj);
	else
		o.sv_pos = o.projPos = mul(p, viewProj);

	return o;
}

float4 PS_CYLINDER(PS_INPUT_C i) : SV_TARGET0 {

	float4 pos = float4(i.pos, 1);
	float4 acc = 0;

	const uint steps = 32;
	[loop]
	for (uint j = 0; j < steps; ++j) {
		float a = 2 * PI * blurFactor / instanceCount * ((float)j / steps - (0.5-0.5/steps));
		float s, c;
		sincos(a, s, c);

		float4x4 mr = { 1, 0, 0, 0,		// rotate matrix along x
						0, c,-s, 0,
						0, s, c, 0,
						0, 0, 0, 1 };

		float4 p = mul(pos, mr);
		float4 uvp = mul(p, sampleMatrix);
		float2 uv = uvp.xy / uvp.w * texScale;

		float4 col = texAirscrew.SampleLevel(gTrilinearClampSampler, uv, 0);
		acc += float4(col.xyz, saturate(col.a));
	}

	acc /= steps;
	acc.a = saturate(acc.a);

	AtmosphereSample atm = SamplePrecomputedAtmosphere(0);
	acc.xyz += atm.inscatter * acc.a;

	return acc;
}

BlendState BlendStatePrepass {
	BlendEnable[0] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = ONE;
	BlendOp = ADD;
	SrcBlendAlpha = ONE;
	DestBlendAlpha = ONE;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; 
};

BlendState BlendStateCylinder {
	BlendEnable[0] = TRUE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = ZERO;
	DestBlendAlpha = ONE;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x07;
};

#define COMMON_PART 		SetHullShader(NULL);			\
							SetDomainShader(NULL);			\
							SetGeometryShader(NULL);		\
							SetComputeShader(NULL);			\
							SetRasterizerState(cullFront);	

technique10 Tech {
	pass p0 {
		SetVertexShader(CompileShader(vs_5_0, VS(false)));
		SetPixelShader(CompileShader(ps_5_0, PS_PREPASS(false)));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(BlendStatePrepass, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		COMMON_PART
	}
	pass p1 {
		SetVertexShader(CompileShader(vs_5_0, VS(false)));
		SetPixelShader(CompileShader(ps_5_0, PS_PREPASS(true)));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(BlendStatePrepass, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		COMMON_PART
	}
	pass p2 {
		SetVertexShader(CompileShader(vs_5_0, VS(false)));
		SetPixelShader(CompileShader(ps_5_0, PS_PREPASS_FLIR()));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(BlendStatePrepass, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		COMMON_PART
	}
	pass p3 {
		SetVertexShader(CompileShader(vs_5_0, VS_CYLINDER(true)));
		SetPixelShader(CompileShader(ps_5_0, PS_CYLINDER()));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(BlendStateCylinder, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		COMMON_PART
	}
	pass p4 {
		SetVertexShader(CompileShader(vs_5_0, VS_CYLINDER(false)));
		SetPixelShader(NULL);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		COMMON_PART
	}
	pass p5 {	// Brute force tech
		SetVertexShader(CompileShader(vs_5_0, VS(true)));
		SetPixelShader(CompileShader(ps_5_0, PS_PREPASS(true)));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		COMMON_PART
	}

}
