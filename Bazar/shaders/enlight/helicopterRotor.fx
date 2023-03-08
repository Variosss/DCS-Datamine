#include "common/context.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "deferred/atmosphere.hlsl"
#include "deferred/shading.hlsl"
#include "common/atmosphereSamples.hlsl"

#define USE_DEPTH_REPROJECT 1
#define MAX_BLUR_ANGLE 40.0

float4x4 bladePos;
float4x4 modelPos;
float4x4 viewProj;
float4x4 sampleMatrix;
float4x4 sampleInvMatrix;

uint	instanceCount;
float	texScale;
float	sigma;
float	scaleY;
float3	sagging;
float3	cScale;
float4	flirCoeff;

Texture2D texProject;
Texture2D texProjectDepth;
Texture2D texAlbedo;
Texture2D texAORM;
Texture2D texNormal;		// ignore it
Texture2D texFLIR;

#define PI 3.1415926535897932384626433832795
#define MAX_BLUR_ANGLE_RAD ((MAX_BLUR_ANGLE / 180.0) * PI)

float gaussian(float x, float s) {
	return exp(-(x * x) / (2 * s * s));
}

float rand(float value) {
	return frac(sin(value) * 143758.5453);
}

float rand2(float2 value) {
	float seed = dot(frac(value), float2(12.9898, 37.719));
	return rand(seed);
}

float instanceAlpha(uint id, uint instanceCount, float sigma) {
	float f = (float)id / (instanceCount - 1) - 0.5;
	return gaussian(f * 2, sigma);
}

float normalizedInstanceAlpha(uint id, uint instanceCount, float sigma) {
	float acc = 0;
	for (uint i = 0; i < instanceCount; ++i)
		acc += instanceAlpha(i, instanceCount, sigma);
	return instanceAlpha(id, instanceCount, sigma) / acc;
}

float3 applySagging(float3 pos) {
	return float3(pos.x, pos.y + pos.x * lerp(-pos.x * sagging.x * sagging.y, sagging.y, sagging.z), pos.z);
}

float3 applySaggingBound(float3 pos) {
	float3 result = float3(pos.x, pos.y + sagging.y * pos.x, pos.z);
	if (pos.y * sign(sagging.y) > 0) {
		float f = saturate(abs(pos.z / pos.x) / tan(MAX_BLUR_ANGLE_RAD));
		result = lerp(applySagging(pos), result, f);
	}	
	return result;
}

float4x4 calcRotateMatrix(float angle) {
	float s, c;
	sincos(angle, s, c);
	float4x4 rm = { c, 0,-s, 0,
						  0, 1, 0, 0,
						  s, 0, c, 0,
						  0, 0, 0, 1 };
	return rm;
}

float4x4 calcRotateMatrixVS(uint instId, uniform bool useRand = false) {
	float f = (float)instId / (instanceCount - 1) - 0.5;
	float a = MAX_BLUR_ANGLE_RAD * f;
	if(useRand)
		a += (rand(instId) - 0.5) * 0.005;
	return calcRotateMatrix(a);
}

float4x4 calcRotateMatrixPS(uint j, uint steps, float2 randSeed) {
	float f = (j + 0.5) / steps - 0.5;
	float a = MAX_BLUR_ANGLE_RAD * f / instanceCount * 2;
	float rnd = rand2(randSeed) - 0.5;
	return calcRotateMatrix(a - rnd * sigma * 0.2);
}

struct PS_INPUT_MESH {
	float4 sv_pos: 	SV_POSITION0;
	float4 wpos: 	POSITION0;
	float3 normal: 	NORMAL0;
	float2 uv:		TEXCOORD0;
	nointerpolation float  bladeAlpha: TEXCOORD1;
};

PS_INPUT_MESH VS_BLADE(
	in float3 pos: POSITION0,
	in float3 normal: NORMAL0,
	in float3 tangent: NORMAL1,			// ignore it
	in float2 uv: TEXCOORD0,
	in uint instId: SV_InstanceID)
{
	float4x4 instRotate = calcRotateMatrixVS(instId, true);
	float4x4 transform = mul(bladePos, instRotate);
	float3x3 normalMatrix = mul((float3x3)transform, (float3x3)modelPos);
	float4 p = mul(float4(applySagging(pos), 1), transform);

	PS_INPUT_MESH o;
	o.wpos = mul(p, modelPos);
	o.sv_pos = mul(o.wpos, viewProj);
	o.normal = mul(normal, normalMatrix);
	o.bladeAlpha = normalizedInstanceAlpha(instId, instanceCount, sigma);
	o.uv = uv;

	return o;
}

PS_INPUT_MESH VS_HUB_LOD(
	in float3 pos: POSITION0,
	in float3 normal : NORMAL0,
	in float3 tangent : NORMAL1,		// ignore it
	in float2 uv : TEXCOORD0,
	in uint instId : SV_InstanceID)
{
	float4x4 instRotate = calcRotateMatrixVS(instId);
	float3x3 normalMatrix = mul((float3x3)instRotate, (float3x3)modelPos);
	float4 p = mul(float4(pos, 1), instRotate);

	PS_INPUT_MESH o;
	o.wpos = mul(p, modelPos);
	o.sv_pos = mul(o.wpos, viewProj);
	o.normal = mul(normal, normalMatrix);
	o.bladeAlpha = normalizedInstanceAlpha(instId, instanceCount, sigma);
	o.uv = uv;

	return o;
}

float4 PS_MESH(PS_INPUT_MESH i): SV_TARGET0 {
	float3 N = normalize(i.normal);	// ignore texNormal and tangent space
	float4 aorm = texAORM.Sample(gAnisotropicWrapSampler, i.uv);
	float3 albedo = texAlbedo.Sample(gAnisotropicWrapSampler, i.uv).xyz;
	float3 wpos = i.wpos.xyz;
	float3 V = normalize(gCameraPos - wpos);

	float shadow = SampleShadowCascade(wpos + N * 0.1, i.sv_pos.z, N, false, false, false);
	shadow = min(shadow, SampleShadowClouds(wpos).x);

	float3 sunColor = SampleSunRadiance(wpos, gSunDir);
	return float4(ShadeHDR(i.sv_pos.xy, sunColor, albedo, N, aorm.y, aorm.z, 0, shadow, aorm.x, 1, V, wpos), i.bladeAlpha);
}

float4 PS_MESH_FLIR(PS_INPUT_MESH i): SV_TARGET0 {
	float4 flir = texFLIR.Sample(gAnisotropicWrapSampler, i.uv);
	float v = flir[0] * flirCoeff[0] + flir[1] * flirCoeff[1] + flir[2] * flirCoeff[2] + flir[3] * flirCoeff[3];
	float4 c = float4(v, v, v, i.bladeAlpha);
	return c;
}

struct PS_INPUT_BOUND {
	float3 pos: TEXCOORD0;
	float3 wpos: TEXCOORD1;
	float4 projPos: TEXCOORD2;
	float4 sv_pos: SV_POSITION0;
};

PS_INPUT_BOUND VS_BOUND_HUB(in float3 pos: POSITION0) {
	float4 wpos = mul(float4(pos, 1), modelPos);

	PS_INPUT_BOUND o;
	o.pos = pos;
	o.wpos = wpos.xyz / wpos.w;
	o.sv_pos = o.projPos = mul(wpos, gViewProj);
	return o;
}

float4 PS_BOUND_HUB(PS_INPUT_BOUND i) : SV_TARGET0 {
	float4 pos = float4(i.pos, 1);

	const uint steps = 64;

	float aw;
	float4 rpos = pos;

#if USE_DEPTH_REPROJECT
	aw = 0.1;
	[loop]
	for (uint j = 0; j < steps; ++j) {

		float f = (j + 0.5) / steps - 0.5;
		float a = MAX_BLUR_ANGLE_RAD * f;
		float w = gaussian(f, sigma * 0.25);
		float4x4 mr = calcRotateMatrix(a);

		float4 p = mul(pos, mr);
		float4 uvp = mul(p, sampleMatrix);

		float2 uv = uvp.xy / uvp.w * texScale;

		float depth = texProjectDepth.SampleLevel(gPointClampSampler, uv, 0).x;
		w *= step(1e-6, depth);

		float4 rp = mul(float4(uvp.xy / uvp.w, depth, 1), sampleInvMatrix);
		rp = mul(mr, rp);
		w *= max(dot(rp, pos), 0);

		rpos += rp * w;
		aw += w;
	}
	rpos /= aw;
#endif

	float4 acc = 0;
	aw = 0;
	[loop]
	for (uint j = 0; j < steps; ++j) {
		
		// special case of rotate matrix
		float f = (j + 0.5) / steps - 0.5;
		float a = MAX_BLUR_ANGLE_RAD * f;
		float w = gaussian(f, sigma * 0.5);
		float4x4 mr = calcRotateMatrix(a);

		float4 p = mul(rpos, mr);
		float4 uvp = mul(p, sampleMatrix);

		float2 uv = uvp.xy / uvp.w * texScale;
		float4 col = texProject.SampleLevel(gTrilinearClampSampler, uv, 0);
		acc += col * w;
		aw += w;
	}
	acc /= aw;

	AtmosphereSample atm = SamplePrecomputedAtmosphere(0);
	acc.xyz += atm.inscatter * acc.a;

	return acc;
}

PS_INPUT_BOUND VS_BOUND_BLADE(in float3 pos: POSITION0) {
	float3 p = pos;
	p.y *= scaleY;
	p = applySaggingBound(p);
	float4 wpos = mul(float4(p, 1), modelPos);

	PS_INPUT_BOUND o;
	o.pos = p;
	o.wpos = wpos.xyz / wpos.w;
	o.sv_pos = o.projPos = mul(wpos, gViewProj);
	return o;
}

float4 PS_BOUND_BLADE(PS_INPUT_BOUND i): SV_TARGET0 {
	float4 pos = float4(i.pos, 1);
	float4 acc = 0;
	float aw = 0;

	const uint steps = 128;
	[loop]
	for (uint j = 0; j < steps; ++j) {

		float4x4 mr = calcRotateMatrixPS(j, steps, i.projPos.xy);

		float4 p = mul(pos, bladePos);
		p = mul(p, mr);
		float4 uvp = mul(p, sampleMatrix);

		float2 uv = uvp.xy / uvp.w * texScale;
		float4 col = texProject.SampleLevel(gTrilinearClampSampler, uv, 0);
		acc += col;
	}
	acc /= steps;

	acc.a += 1e-6;
	acc *= saturate(acc.a) / acc.a;		// normalize by alpha

	AtmosphereSample atm = SamplePrecomputedAtmosphere(0);
	acc.xyz += atm.inscatter * acc.a;

	return acc;
}

PS_INPUT_BOUND VS_BOUND_CYLINDER(in float3 pos: POSITION0) {
	float4 p = float4(pos.x * cScale[2], lerp(cScale[0], cScale[1], step(0, pos.y))*1.1, pos.z * cScale[2], 1);
	float4 wpos = mul(p, modelPos);

	PS_INPUT_BOUND o;
	o.pos = p;
	o.wpos = wpos.xyz / wpos.w;
	o.sv_pos = o.projPos = mul(wpos, gViewProj);
	return o;
}

float4 PS_BOUND_CYLINDER(PS_INPUT_BOUND i): SV_TARGET0 {
	float4 pos = float4(i.pos, 1);
	float4 acc = 0;
	float aw = 0;

	const uint steps = 64;
	[loop]
	for (uint j = 0; j < steps; ++j) {

		float4x4 mr = calcRotateMatrixPS(j, steps, i.projPos.xy);

		float4 p = mul(pos, mr);
		float4 uvp = mul(p, sampleMatrix);

		float2 uv = uvp.xy / uvp.w * texScale;
		float4 col = texProject.SampleLevel(gTrilinearClampSampler, uv, 0);
		acc += col;
	}
	acc /= steps;

	acc.a += 1e-6;
	acc *= saturate(acc.a) / acc.a;		// normalize by alpha

	AtmosphereSample atm = SamplePrecomputedAtmosphere(0);
	acc.xyz += atm.inscatter * acc.a;

	return acc;
}

float4 PS_DEBUG_COLOR(): SV_TARGET0 {
	return float4(1,0,0,0.5);
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

BlendState BlendStateBound {
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

#define MESH_PART			SetDepthStencilState(disableDepthBuffer, 0);									\
							SetBlendState(BlendStatePrepass, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
							COMMON_PART

#define BOUND_PART			SetDepthStencilState(enableDepthBufferNoWrite, 0);								\
							SetBlendState(BlendStateBound, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);		\
							COMMON_PART

#define WIREFRAME_PART		SetPixelShader(CompileShader(ps_5_0, PS_DEBUG_COLOR()));						\
							SetDepthStencilState(enableDepthBufferNoWrite, 0);								\
							SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
							SetRasterizerState(wireframe);

DepthStencilState testDepthBuffer {
	DepthEnable = TRUE;
	DepthWriteMask = ALL;
	DepthFunc = GREATER;

	StencilEnable = FALSE;
	StencilReadMask = 0;
	StencilWriteMask = 0;
};

technique10 Tech {
	pass p0 {	// blade
		SetVertexShader(CompileShader(vs_5_0, VS_BLADE()));
		SetPixelShader(CompileShader(ps_5_0, PS_MESH()));
		MESH_PART
	}
	pass p1 {	// hub lod
		SetVertexShader(CompileShader(vs_5_0, VS_HUB_LOD()));
		SetPixelShader(CompileShader(ps_5_0, PS_MESH()));
		MESH_PART
	}
	pass p2 {	// blade FLIR
		SetVertexShader(CompileShader(vs_5_0, VS_BLADE()));
		SetPixelShader(CompileShader(ps_5_0, PS_MESH_FLIR()));
		MESH_PART
	}
	pass p3 {	// hub lod FLIR
		SetVertexShader(CompileShader(vs_5_0, VS_HUB_LOD()));
		SetPixelShader(CompileShader(ps_5_0, PS_MESH_FLIR()));
		MESH_PART
	}
	pass p4 {	// hub bound Mesh
		SetVertexShader(CompileShader(vs_5_0, VS_BOUND_HUB()));
		SetPixelShader(CompileShader(ps_5_0, PS_BOUND_HUB()));
		BOUND_PART
	}
	pass p5 {	// blade bound mesh
		SetVertexShader(CompileShader(vs_5_0, VS_BOUND_BLADE()));
		SetPixelShader(CompileShader(ps_5_0, PS_BOUND_BLADE()));
		BOUND_PART
	}
	pass p6 {	// cylinder bound mesh
		SetVertexShader(CompileShader(vs_5_0, VS_BOUND_CYLINDER()));
		SetPixelShader(CompileShader(ps_5_0, PS_BOUND_CYLINDER()));
		BOUND_PART
	}

	pass p7 {	// Brute force tech
		SetVertexShader(CompileShader(vs_5_0, VS_BLADE()));
		SetPixelShader(CompileShader(ps_5_0, PS_MESH()));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
#if 0
		SetRasterizerState(wireframe);
#else
		COMMON_PART
#endif
	}
	pass p8 {	
		SetVertexShader(CompileShader(vs_5_0, VS_BOUND_HUB()));
		WIREFRAME_PART
	}
	pass p9 {
		SetVertexShader(CompileShader(vs_5_0, VS_BOUND_BLADE()));
		WIREFRAME_PART
	}
	pass p10 {
		SetVertexShader(CompileShader(vs_5_0, VS_BOUND_CYLINDER()));
		WIREFRAME_PART
	}
}
