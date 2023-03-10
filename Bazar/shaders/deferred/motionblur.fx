
#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "deferred/Decoder.hlsl"
#include "deferred/DecoderCommon.hlsl"

TEXTURE_2D(float4, ComposedTex);
TEXTURE_2D(float2, MotionVectors);

Texture2D<float2> VelocityAvg;
uint2	sourceSize;
float	value, dithering;

#define AVG_MIP_COUNT 6
#define VEL_SCALE 20.0

static const float2 quad[4] = {
	float2(-1, -1), float2(1, -1),
	float2(-1, 1),	float2(1, 1),
};

struct VS_OUTPUT {
	float4 pos:			SV_POSITION;
	float2 projPos:		TEXCOORD0;
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.pos = float4(quad[vid], 0, 1);
	o.projPos = o.pos.xy;
	return o;
}

float2 sampleVelocity(uint2 uv) {
	return SampleMap(MotionVectors, uv, 0).xy / gTargetDims / gPrevFrameTimeDelta;
}

float depthToDistane(float depth) {
	float4 pos = mul(float4(0, 0, depth, 1), gProjInv);
	return pos.z / pos.w;
}

float2 saturateLength(float2 v) {
	float l = length(v) + 1e-9;
	return v * (saturate(l) / l);
}

float4 sampleVelocityScaledDepth(uint2 uv, uint sidx) {
	float2 v = sampleVelocity(uv);
	v = saturateLength(v * VELOCITY_MAP_SCALE);
	v *= VEL_SCALE * value * 1.5;
	float depth = SampleMap(DepthMap, uv, sidx).x;
	return float4(v, depthToDistane(depth), length(v) + 1e-9);
}

static const uint2 offset[4] = {
	uint2(0, 0), uint2(1, 0),
	uint2(0, 1), uint2(1, 1),
};

float2 calcVelAvg(float2 uv, float2 dims, uint mip) {
	float2 avgVelocity = 0;
	[unroll]
	for (uint j = 0; j < 4; ++j)
		avgVelocity += VelocityAvg.SampleLevel(gTrilinearClampSampler, uv + (offset[j] - 0.5) * (1.0 / dims), mip).xy;
	return avgVelocity * 0.25;
}

float2 calcVelocityAvg(float2 uv) {
	float2 avgVelocity = 0;

	uint2 dims = sourceSize / 2;
	[unroll]
	for (uint mip = 1; mip < AVG_MIP_COUNT; ++mip) {
		dims /= 2;
		avgVelocity += VelocityAvg.SampleLevel(gTrilinearClampSampler, uv, mip).xy;
	}
	avgVelocity += calcVelAvg(uv, dims, AVG_MIP_COUNT - 1);

	return avgVelocity / AVG_MIP_COUNT;
}

float gaussian(float x, float s) {
	return exp(-(x * x) / (2 * s * s));
}

float cone(float x) {
	return max(0, 1 - abs(x*0.5));
}

float hash(float3 n) {
	return frac(sin(dot(n, float3(3.117, 2.695, 1.833))) * 43758.5453);
}

float2 projPosToUV(float2 projPos) {
	return float2(projPos.x, -projPos.y) * 0.5 + 0.5;
}

// old simple very fast technique with many artifacts
static float kernel[] = { 0.095478, 0.095002, 0.093587, 0.091276, 0.088137, 0.084259 };

float4 PS_MOTION_BLUR_0(const VS_OUTPUT i, uint sidx: SV_SampleIndex) : SV_TARGET0 {

	float2 v = sampleVelocity(i.pos.xy);
	v *= 8 * value;			// as in rev 140727

	float2 uv = i.pos.xy;
	float3 acc = SampleMap(ComposedTex, uv, sidx).rgb * kernel[0];
	for (uint j = 1; j < 6; ++j)
		acc += (SampleMap(ComposedTex, uv + v * j, sidx).rgb + SampleMap(ComposedTex, uv - v * j, sidx).rgb) * kernel[j];

	return float4(acc, 1);
}

// fast technique with some artifats
float3 MotionBlurPS(const VS_OUTPUT i, uint sidx, uniform int SAMPLE_COUNT) {

	float2 vm = VelocityAvg.SampleLevel(gTrilinearClampSampler, projPosToUV(i.projPos), 0).xy;
	vm /= length(vm) + 1e-9;

	float2 p0 = i.pos.xy;
	float4 vd0 = sampleVelocityScaledDepth(p0, sidx);

	float4 acc = 0;
	float scale = VEL_SCALE * value / SAMPLE_COUNT;
	[unroll]
	for (int j = -SAMPLE_COUNT; j <= SAMPLE_COUNT; ++j) {
		float rnd = hash(float3(p0, j));

		float2 p1 = clamp(p0 + vm * (j * (1 + rnd * dithering) * scale), 0, sourceSize - 1);
		float2 dp = p1 - p0;
		float ldp = length(dp) + 1e-9;

		float4 vd1 = sampleVelocityScaledDepth(p1, sidx);

		float dwl = saturate(1.5 + vd0.w - vd1.w);
		float zw = smoothstep(vd0.z * 1.01, vd0.z*0.99, vd1.z);

#if 1	// try to fix the incorrect blur for a fast moving object and the shaky camera	
//		float wdir = pow(abs(dot(vd1.xy / vd1.w, vm)), 50) + 1e-12;
		float wdir = pow(abs(dot(vd1.xy / vd1.w, (vd0.xy + vd1.xy * 0.001) / (vd0.w + vd1.w * 0.001) )), 5) + 1e-9;
		float w1 = gaussian(ldp / (vd1.w * wdir), 1);
#else
		float w1 = gaussian(ldp / vd1.w, 1);
#endif

#if 1
		float w0 = cone(ldp / vd0.w) * (1 - dwl * zw);
		float w00 = cone(1.5 * scale / vd0.w);
		float lf = w00 + zw * (1 - w00);
		float w = lerp(w0, w1, lf) * lerp(zw, 1, dwl) + 1e-9;
#else
		float w0 = gaussian(ldp / vd0.w, 1) * (1 - dwl);
		float w = (w0 + w1) * lerp(zw, 1, dwl) + 1e-9;
#endif
		acc += float4(SampleMap(ComposedTex, p1, sidx).xyz * w, w);
	}
	return acc.xyz / acc.w;
}

float4 PS_MOTION_BLUR(const VS_OUTPUT i, uniform int SAMPLE_COUNT): SV_TARGET0 {
	return float4(MotionBlurPS(i, 0, SAMPLE_COUNT), 1);
}

float4 PS_MOTION_BLUR_MSAA(const VS_OUTPUT i, uint sidx: SV_SampleIndex, uniform int SAMPLE_COUNT): SV_TARGET0 {
#if 1
	return float4(MotionBlurPS(i, sidx, SAMPLE_COUNT), 1);
#else 	// show edges
	return float4(1, 0, 0, 1);
#endif
}

#if 0
// naive very slow technique
float4 PS_MOTION_BLUR_2(const VS_OUTPUT i, uint sidx: SV_SampleIndex) : SV_TARGET0 {
	float2 p0 = i.pos.xy;
	float4 vd0 = sampleVelocityScaledDepth(p0, sidx);

	float4 acc = 0;
	[loop]
	for (int x = -15; x <= 15; ++x) {
		[unroll]
		for (int y = -15; y <= 15; ++y) {
			float2 p1 = clamp(i.pos.xy + int2(x, y) * 1.33, 0, sourceSize - 1);
			float2 dp = p1 - p0;
			float ldp = length(dp);

			float4 vd1 = sampleVelocityScaledDepth(p1, 0);
			float dvw = gaussian(vd0.w - vd1.w, 1);
			float zw = smoothstep(vd0.z * 1.01, vd0.z*0.99, vd1.z) + dvw;

			float d0 = dot(dp, vd0.xy);
			float w0 = gaussian(ldp - abs(d0) / vd0.w, 0.1);
			w0 *= gaussian(ldp / vd0.w, 1);

			float d1 = dot(dp, vd1.xy);
			float w1 = gaussian(ldp - abs(d1) / vd1.w, 0.1);
			w1 *= gaussian(ldp / vd1.w, 1);

			float w = (w0 + w1) * zw + 1e-9;

			acc += float4(SampleMap(ComposedTex, p1, sidx).xyz * w, w);
		}
	}
	return float4(acc.xyz / acc.w, 1);
}
#endif

float4 PS_VELOCITY_MAX_0(const VS_OUTPUT i) : SV_TARGET0 {
	float2 uv = i.pos.xy * 2;
	float2 maxVelocity = sampleVelocity(uv);
	float maxMag = dot(maxVelocity, maxVelocity);
	[unroll]
	for (uint j = 1; j < 4; ++j) {
		float2 v = sampleVelocity(clamp(uv + offset[j], 0, sourceSize - 1));
		float mag = dot(v, v);
		if (mag > maxMag) {
			maxVelocity = v;
			maxMag = mag;
		}
	}
	return float4(maxVelocity, 0, 1);
}

float4 PS_VELOCITY_MAX_1(const VS_OUTPUT i) : SV_TARGET0 {
	float2 uv = i.pos.xy * 2;
	float2 maxVelocity = VelocityAvg.Load(uint3(uv, 0)).xy;
	float maxMag = dot(maxVelocity, maxVelocity);

	[unroll]
	for (uint j = 1; j < 4; ++j) {
		float2 v = VelocityAvg.Load(uint3(clamp(uv + offset[j], 0, sourceSize - 1), 0)).xy;
		float mag = dot(v, v);
		if (mag > maxMag) {
			maxVelocity = v;
			maxMag = mag;
		}
	}
	return float4(maxVelocity, 0, 1);
}

float4 PS_VELOCITY_AVG_1(const VS_OUTPUT i) : SV_TARGET0 {
	float2 uv = projPosToUV(i.projPos);
	float2 avgVelocity = 0;
	[unroll]
	for (uint j = 0; j < 4; ++j) 
		avgVelocity += VelocityAvg.SampleLevel(gTrilinearClampSampler, uv + (offset[j] - 0.5) * (1.0 / sourceSize), 0).xy;
	
	return float4(avgVelocity * 0.25, 0, 1);
}

float4 PS_VELOCITY_AVG_2(const VS_OUTPUT i) : SV_TARGET0 {
	float2 va = normalize( calcVelocityAvg(projPosToUV(i.projPos)) );
	return float4(va, 0, 1);
}

float4 PS_COPY(const VS_OUTPUT i, uint sidx: SV_SampleIndex): SV_TARGET0 {
	return SampleMap(ComposedTex, i.pos.xy, sidx); 
}

DepthStencilState stencilTestState {
	DepthEnable = FALSE;
	DepthWriteMask = ZERO;
	DepthFunc = ALWAYS;

	StencilEnable = TRUE;
	StencilReadMask = 1;
	StencilWriteMask = 0;

	FrontFaceStencilFunc = EQUAL;
	FrontFaceStencilPass = KEEP;
	FrontFaceStencilFail = KEEP;
	BackFaceStencilFunc = EQUAL;
	BackFaceStencilPass = KEEP;
	BackFaceStencilFail = KEEP;
};

VertexShader vsCompiled = CompileShader(vs_5_0, VS());

#define PASS_BODY(ps) {	SetPixelShader(CompileShader(ps_5_0, ps));								    \
                    SetVertexShader(vsCompiled);													\
					SetGeometryShader(NULL);														\
					SetDepthStencilState(disableDepthBuffer, 0);									\
					SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
					SetRasterizerState(cullNone); }

#define PASS_BODY_STENCIL(ps, stencilRef) { SetPixelShader(CompileShader(ps_5_0, ps));					\
					    SetVertexShader(vsCompiled);													\
						SetGeometryShader(NULL);														\
						SetDepthStencilState(stencilTestState, stencilRef);								\
						SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
						SetRasterizerState(cullNone); }

technique10 MotionBlur {
	pass MotionBlurLow				PASS_BODY(PS_MOTION_BLUR_0())

	pass MotionBlurMedium			PASS_BODY(PS_MOTION_BLUR(20))
	pass MotionBlurMediumMSAA		PASS_BODY_STENCIL(PS_MOTION_BLUR(20), 1)
	pass MotionBlurMediumMSAAEdges	PASS_BODY_STENCIL(PS_MOTION_BLUR_MSAA(20), 0)

	pass MotionBlurHigh				PASS_BODY(PS_MOTION_BLUR(50))
	pass MotionBlurHighMSAA			PASS_BODY_STENCIL(PS_MOTION_BLUR(50), 1)
	pass MotionBlurHighMSAAEdges	PASS_BODY_STENCIL(PS_MOTION_BLUR_MSAA(50), 0)

	pass VelocityMax0				PASS_BODY(PS_VELOCITY_MAX_0())
	pass VelocityMax1				PASS_BODY(PS_VELOCITY_MAX_1())
	pass VelocityAvg1				PASS_BODY(PS_VELOCITY_AVG_1())
	pass VelocityAvg2				PASS_BODY(PS_VELOCITY_AVG_2())

	pass Copy						PASS_BODY(PS_COPY())
}
