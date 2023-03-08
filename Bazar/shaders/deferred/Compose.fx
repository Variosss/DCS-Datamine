#include "common/stencil.hlsl"
#include "deferred/compose.hlsl"

#ifndef USE_SSAO
	#define USE_SSAO 0
#endif

#ifndef USE_SSLR
	#define USE_SSLR 1
#endif

#ifndef USE_SHADOWS
	#define USE_SHADOWS 0
#endif

#define USE_RENDER_COMPOSITION_DEBUG 1
#define USE_COMPOSER_SEPARATE_PASSES 0
#define USE_SEPARATE_SHADOW_PASS 0

static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

VS_COMPOSE_OUTPUT VS(uint vid: SV_VertexID) {
	VS_COMPOSE_OUTPUT o;
	o.projPos = o.pos = float4(quad[vid], 0, 1);
	o.projPos /= o.projPos.w;
	return o;
}

VS_COMPOSE_OUTPUT VS_CUSTOM(uint vid: SV_VertexID) {
	VS_COMPOSE_OUTPUT o;
	o.projPos = o.pos = float4(quad[vid] * GBufferViewportScaleOffset.xy + GBufferViewportScaleOffset.zw, 0, 1);
	o.projPos /= o.projPos.w;
	return o;
}

float4 PS_DUMMY(const VS_COMPOSE_OUTPUT i): SV_TARGET0 {
	return 0;
}

float4 ComposeSampleMain(const VS_COMPOSE_OUTPUT i, uint sidx,
	uniform bool useShadows, uniform bool useSSAO, uniform bool useSSLR, uniform bool useCockpitGI, uniform bool discardTerrainInsideFog, uniform int mode, uniform bool bSampleFrequency)
{
	ComposerInput input = ReadComposerData(i.pos.xy, i.projPos, sidx);

#if defined(USE_STENCIL_CLIP_MASK)
	if((input.stencil & STENCIL_CLIP_MASK) && mode==0)
		return float4(0,0,0,1);
#endif

	uint materialId = input.stencil & STENCIL_COMPOSITION_MASK;

	if (materialId == STENCIL_COMPOSITION_UNDERWATER)
		return float4(ComposeUnderWaterSample(input, sidx, useShadows, bSampleFrequency, mode), 1);

	if(input.depth==0 || input.depth==1)
	{
		float2 uv2 = float2(i.projPos.x, -i.projPos.y)*0.5+0.5;
		return float4(skyTex.SampleLevel(gBilinearClampSampler, uv2, 0).rgb, 1);
	}

	if(mode>0)
	{
		if(renderMode==15) {
			const float3 colors[] = {{1,0,0},{0,1,0}, {0,0,1}, {1,1,0}, {1,0,1}, {0,1,1}};
			return float4(colors[materialId >> STENCIL_COMPOSITION_MASK_SHIFT], 1.0);
		}
		else if(renderMode==16) {
			const float3 colors[] = {{1,0,0},{0,1,0}, {0,0,1}, {1,1,0}, {1,0,1}, {0,1,1}};
			return float4(colors[input.stencil & 3], 1.0);
		}
		else if (renderMode == 21) {
			return float4(input.stencil & STENCIL_SELECTED_OBJECT ? 1 : 0, 0, 0, 1.0);
		}
	}

	float4 finalColor = 0;

	[branch]
	switch(materialId)
	{
	case STENCIL_COMPOSITION_SURFACE:	finalColor = float4(ComposeTerrainSample(input, sidx, useShadows, useSSAO, discardTerrainInsideFog, bSampleFrequency, mode), 1); break;
	case STENCIL_COMPOSITION_MODEL:		finalColor = float4(ComposeSample(input, sidx, useShadows, useSSAO, bSampleFrequency, mode, input.stencil & 1, useSSLR), mode>0? 0 : 1); break;	// input.stencil & 1 ? FAR_ENV_MAP : LERP_ENV_MAP
	case STENCIL_COMPOSITION_COCKPIT:	finalColor = float4(ComposeCockpitSample(input, sidx, useShadows, useSSAO, useCockpitGI, bSampleFrequency, mode, useSSLR), mode>0? 0 : 1); break;
	case STENCIL_COMPOSITION_GRASS:		finalColor = float4(ComposeGrassSample(input, sidx, useShadows, bSampleFrequency, mode), 1); break;
	case STENCIL_COMPOSITION_FOLIAGE:	finalColor = float4(ComposeFoliageSample(input, sidx, useShadows, useSSAO, bSampleFrequency, mode), 1); break;
	case STENCIL_COMPOSITION_WATER:		finalColor = float4(ComposeWaterSample(input, sidx, useShadows, discardTerrainInsideFog, bSampleFrequency, mode), 1); break;
	}

	if(materialId != STENCIL_COMPOSITION_COCKPIT && (mode==0 || renderMode==22))
		finalColor.xyz = applyAtmosphereLinear(gCameraPos.xyz, input.wPos.xyz, input.projPos, finalColor.xyz);

	return finalColor;
}

float4 PS_SINGLE_PASS(const VS_COMPOSE_OUTPUT i, uniform bool useShadows, uniform bool useSSAO, uniform bool useSSLR, uniform bool useCockpitGI, uniform int mode = 0): SV_TARGET0
{
	return ComposeSampleMain(i, 0, useShadows, useSSAO, useSSLR, useCockpitGI, false, mode, false);
}

bool IsMSAAResolvingPossible(float2 projPos)
{
	return distance(projPos*0.5+0.5, float2(gProj[2][0] * 0.5 + 0.5, 0.5)) < msaaMaskSize;
}

bool IsComplexGBuffer(float2 pos)
{
	#define SampleGBuffer(layer, smpl) SampleMapArray(GBufferMap, pos, layer, smpl)

	bool samplesAreEqual = true;
	float2 s0Ref = SampleGBuffer(0, 0).rg;//normal
	float  s1Ref = SampleGBuffer(1, 0).r; //albedo luminance
	[loop]
	for(uint j=1; j<SAMPLE_COUNT; ++j)
	{
		float2 s0 = SampleGBuffer(0, j).rg;
		float  s1 = SampleGBuffer(1, j).r;

		float2 d0 = s0 - s0Ref;
		samplesAreEqual = samplesAreEqual && (abs(s1-s1Ref)< 0.015) && (dot(d0, d0) < 0.0005);
	}
	#undef SampleGBuffer

	return !samplesAreEqual;
}

bool IsEdgeWithSky(float2 pos)
{
	float mn=1, mx=0;
	bool bComplex = false;
	for(uint j=0; j<SAMPLE_COUNT; ++j)
	{
		float d = SampleMap(DepthMap, pos, j).r;
		mn = min(mn, d);
		mx = max(mx, d);
	}
	return mn < mx && (mn == 0);
}

float4 PS_NON_MSAA_SAMPLE(const VS_COMPOSE_OUTPUT i, uniform bool useShadows, uniform bool useSSAO, uniform bool useSSLR, uniform bool useCockpitGI, uniform int mode = 0): SV_TARGET0
{
	ComposerInput input = ReadComposerData(i.pos.xy, i.projPos, 0);

	if(input.depth==1)
		return 0;

	if(IsMSAAResolvingPossible(i.projPos.xy/i.projPos.w))
	{
		if(IsEdgeWithSky(i.pos.xy) || IsComplexGBuffer(i.pos.xy))
			discard;
	}

	return ComposeSampleMain(i, 0, useShadows, useSSAO, useSSLR, useCockpitGI, false, mode, false);
}

float4 PS_MSAA_SAMPLE(const VS_COMPOSE_OUTPUT i, uint sidx: SV_SampleIndex, uniform bool useShadows, uniform bool useSSAO, uniform bool useSSLR, uniform bool useCockpitGI, uniform int mode = 0): SV_TARGET0
{
	return ComposeSampleMain(i, sidx, useShadows, useSSAO, useSSLR, useCockpitGI, false, mode, true);
}

float4 PS_CUSTOM(VS_COMPOSE_OUTPUT i, uint sidx: SV_SampleIndex, uniform bool useShadows, uniform bool useSSAO, uniform bool useSSLR) : SV_TARGET0 {
	i.pos.xy += GBufferSampleOffset;
	const int mode = 2;
	uint materialId = SampleMap(StencilMap, i.pos.xy, sidx).g & STENCIL_COMPOSITION_MASK;
	float4 sample = 0;
	[loop]
	for(uint ii=0; ii<SAMPLE_COUNT; ++ii){
		sample += ComposeSampleMain(i, ii, useShadows, useSSAO, useSSLR, false, false, mode, false);
	}
	sample /= SAMPLE_COUNT;
	sample.w = materialId / 255.0;
	return sample;
}

#if USE_SEPARATE_SHADOW_PASS

float4 PS_ShadowsSinglePass(const VS_COMPOSE_OUTPUT i, uint sidx: SV_SampleIndex): SV_TARGET0
{
	uint materialId = SampleMap(StencilMap, i.pos.xy, sidx).g & STENCIL_COMPOSITION_MASK;

	uint2 uv = i.pos.xy;
	float depth = SampleMap(DepthMap, uv, sidx);
	float4 pos = mul(float4(i.projPos.xy, depth, 1), gViewProjInv);
	float3 wPos = pos.xyz/pos.w;

	float3 normal = DecodeNormal(uv, sidx);
	switch(materialId) {
		case STENCIL_COMPOSITION_MODEL:
		case STENCIL_COMPOSITION_COCKPIT:
		case STENCIL_COMPOSITION_SURFACE:
		case STENCIL_COMPOSITION_WATER:
			return float4(SampleShadowHDR(wPos, depth, normal, true), 0,0,1);
		case STENCIL_COMPOSITION_GRASS:
		case STENCIL_COMPOSITION_FOLIAGE:
			return float4(SampleShadowHDR(wPos, depth, normal, false), 0,0,1);
	}

	return float4(1, 0, 0, 1);
}

#endif // USE_SEPARATE_SHADOW_PASS

#if USE_COMPOSER_SEPARATE_PASSES

DepthStencilState Test_DefaultShading_DepthStencilState {
	DepthEnable        = FALSE;
	DepthWriteMask     = ZERO;
	DepthFunc          = ALWAYS;

	StencilEnable      = TRUE;
	StencilReadMask    = 3 << (STENCIL_COMPOSITION_MASK_SHIFT+1);//только STENCIL_COMPOSITION_SURFACE + STENCIL_COMPOSITION_MODEL
	StencilWriteMask   = 0;

	FrontFaceStencilFunc = EQUAL;
	FrontFaceStencilPass = KEEP;
	FrontFaceStencilFail = KEEP;
	
	BackFaceStencilFunc  = EQUAL;
	BackFaceStencilPass  = KEEP;
	BackFaceStencilFail  = KEEP;
};

DepthStencilState Test_CompositionType_DepthStencilState {
	DepthEnable        = FALSE;
	DepthWriteMask     = ZERO;
	DepthFunc          = ALWAYS;
	
	TEST_COMPOSITION_TYPE_IN_STENCIL;
};

//example: pass Default PASS_BODY(PS(USE_SHADOWS, USE_SSAO),			Test_CompositionType_DepthStencilState,	STENCIL_COMPOSITION_MODEL)

#endif //if USE_COMPOSER_SEPARATE_PASSES

GBuffer PS_CLEAR_GBUFFER(const VS_COMPOSE_OUTPUT i) {
	GBuffer o;
	o.target0 = float4(0, 0, 0, 1);
	o.target1 = float4(0, 0, 0, 1);
	o.target2 = float4(0.5, 0.5, 0, 1);
	o.target3 = float4(0.98f, 0, 0, 1);
#if USE_SEPARATE_AO
	o.target4 = float4(1, 0, 0, 1);
#endif
#if USE_VELOCITY_MAP
	o.target5 = float4(calcVelocityMapStatic(i.projPos), 0, 1);
#endif
	return o;
}

DepthStencilState BuildEdgeMaskStencilState {
	DepthEnable = FALSE;
	DepthWriteMask = ZERO;
	DepthFunc = ALWAYS;

	StencilEnable = TRUE;
	StencilWriteMask = 1;
	FrontFaceStencilFunc = ALWAYS;
	FrontFaceStencilPass = REPLACE;
	BackFaceStencilFunc = ALWAYS;
	BackFaceStencilPass = REPLACE;
};

DepthStencilState TestEdgeMaskStencilState {
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


VertexShader vsComp				= CompileShader(vs_5_0, VS());
PixelShader psSinglePassComp	= CompileShader(ps_5_0, PS_SINGLE_PASS(USE_SHADOWS, USE_SSAO, USE_SSLR, false));
PixelShader psSinglePassGIComp	= CompileShader(ps_5_0, PS_SINGLE_PASS(USE_SHADOWS, USE_SSAO, USE_SSLR, true));
PixelShader psDummyComp			= CompileShader(ps_4_0, PS_DUMMY());

#define PASS_BODY_SAMPLE_C(psComp, depthStencil, ref, sampleMask) { SetVertexShader(vsComp); SetGeometryShader(NULL); SetPixelShader(psComp); \
	SetDepthStencilState(depthStencil, ref); \
	SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), sampleMask); \
	SetRasterizerState(cullNone);}

#define PASS_BODY_C(psComp, depthStencil, ref)				PASS_BODY_SAMPLE_C(psComp, depthStencil, ref, 0xFFFFFFFF)

#define PASS_BODY(ps, depthStencil, ref)					PASS_BODY_C(CompileShader(ps_5_0, ps), depthStencil, ref)
#define PASS_BODY_SAMPLE(ps, depthStencil, ref, sampleMask) PASS_BODY_SAMPLE_C(CompileShader(ps_5_0, ps), depthStencil, ref, sampleMask)

technique10 Compose
{
	pass SinglePass 			PASS_BODY_C(psSinglePassComp, disableDepthBuffer, 0)
	pass SinglePass_GI			PASS_BODY_C(psSinglePassGIComp, disableDepthBuffer, 0)
	//for debug
#if USE_RENDER_COMPOSITION_DEBUG
	pass DebugRender 			PASS_BODY(PS_SINGLE_PASS(USE_SHADOWS, USE_SSAO, USE_SSLR, false, 1), disableDepthBuffer, 0)
	pass DebugRender_GI 		PASS_BODY(PS_SINGLE_PASS(USE_SHADOWS, USE_SSAO, USE_SSLR, true, 1), disableDepthBuffer, 0)
#else
	pass DebugRender			PASS_BODY_C(psDummyComp, disableDepthBuffer, 0)
	pass DebugRender_GI			PASS_BODY_C(psDummyComp, disableDepthBuffer, 0)
#endif
}

#define BIT(id)			(1<<(id))
#define firstSample		BIT(0)
#define notFirstSample	BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7)

technique10 ComposeMSAA
{
	pass nonMSAASampleWriteStencil		PASS_BODY_SAMPLE(PS_NON_MSAA_SAMPLE(USE_SHADOWS, USE_SSAO, USE_SSLR, false), BuildEdgeMaskStencilState, 1, 0xFFFFFFFF)
	pass nonMSAASampleWriteStencil_GI	PASS_BODY_SAMPLE(PS_NON_MSAA_SAMPLE(USE_SHADOWS, USE_SSAO, USE_SSLR, true), BuildEdgeMaskStencilState, 1, 0xFFFFFFFF)
	pass MSAASampleTestStencil			PASS_BODY(PS_MSAA_SAMPLE(USE_SHADOWS, USE_SSAO, USE_SSLR, false), TestEdgeMaskStencilState, 0)
	pass MSAASampleTestStencil_GI		PASS_BODY(PS_MSAA_SAMPLE(USE_SHADOWS, USE_SSAO, USE_SSLR, true), TestEdgeMaskStencilState, 0)
}

technique10 ComposeCustom
{
	pass P0	{
		SetVertexShader(CompileShader(vs_5_0, VS_CUSTOM()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, PS_CUSTOM(USE_SHADOWS, USE_SSAO, USE_SSLR)));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

#undef PASS_BODY
#define PASS_BODY(ps, depthStencil, ref) { SetVertexShader(vsComp); SetGeometryShader(NULL); SetPixelShader(CompileShader(ps_5_0, ps)); \
	SetDepthStencilState(depthStencil, ref); \
	SetBlendState(shadowAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
	SetRasterizerState(cullNone);}

#if USE_SHADOWS

#if USE_SEPARATE_SHADOW_PASS

technique10 Shadows
{
	pass SinglePass		PASS_BODY(PS_ShadowsSinglePass(), disableDepthBuffer, 0)
	pass DebugRender	PASS_BODY_C(psDummyComp,		  disableDepthBuffer, 0)
}

#endif // USE_SEPARATE_SHADOW_PASS

#endif

technique10 ClearGBuffer {
	pass P0	PASS_BODY(PS_CLEAR_GBUFFER(), disableDepthBuffer, 0)
}

