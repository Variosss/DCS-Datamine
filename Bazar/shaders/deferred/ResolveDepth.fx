#include "common/states11.hlsl"
#include "common/samplers11.hlsl"

#ifdef MSAA
	#define TEXTURE_2D(type, name) Texture2DMS<type, MSAA> name
    #define	SampleMap(name, uv, idx)  name.Load(uint2(uv), idx)
#else
	#define TEXTURE_2D(type, name) Texture2D<type> name
    #define	SampleMap(name, uv, idx)  name.Load(uint3(uv, 0))
#endif

TEXTURE_2D(float, Depth);
TEXTURE_2D(uint2, Stencil);

float4 viewport;

static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

float4 VS(uint vid: SV_VertexID): SV_POSITION {
	return float4(quad[vid], 0, 1);
}

float PS(float4 pos :SV_POSITION): SV_DEPTH {
	uint2 uv = pos.xy/pos.w;
	float depth = SampleMap(Depth, uv, 0).x;
#ifdef MSAA
	[unroll]
	for (uint i = 1; i < MSAA; ++i)
		depth = min(depth, SampleMap(Depth, uv, i).x);
#endif
	return depth;
}

float PS_STENCIL(float4 pos :SV_POSITION) : SV_DEPTH {
	uint2 uv = pos.xy / pos.w;
	float depth = SampleMap(Depth, uv, 0).x;

/////////////////////// dirty hack for flat shadows clipping, fbShadows framebuffer in DeferredComposer
#ifdef MSAA
	[unroll]
	uint t = 1;
	for (int i = 0; i < MSAA; ++i)
		t &= SampleMap(Stencil, uv, i).y;
	if(t & 1)
		depth *= 1.1;
#else
	if(SampleMap(Stencil, uv, 0).y & 1)
		depth *= 1.1;
#endif
/////////////////////

	return depth;
}

float PS_PER_SAMPLE(float4 pos: SV_POSITION0, uint idx: SV_SampleIndex, uniform uint inputSamplesPerOutputSample): SV_DEPTH
{
	uint2 uv = pos.xy;
	
	if(inputSamplesPerOutputSample==0)
		return SampleMap(Depth, uv, 0).x;
	else if(inputSamplesPerOutputSample==1)
		return SampleMap(Depth, uv, idx).x;
	else
	{
		float result = SampleMap(Depth, uv, inputSamplesPerOutputSample*idx).x;
		[unroll]
		for(uint i=1; i<inputSamplesPerOutputSample; ++i)
			result = min(result, SampleMap(Depth, uv, inputSamplesPerOutputSample*idx + i).x);

		return result;
	}
}

struct VS_OUTPUT {
	float4 svPosition	:SV_POSITION0;
	float4 NDC_Position	:TEXCOORD0;
};

VS_OUTPUT VS_UPSCALE(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.svPosition = o.NDC_Position = float4(quad[vid], 0, 1);
	return o;
}

float PS_UPSCALE(VS_OUTPUT i) : SV_DEPTH{
#ifdef MSAA		// unsuppotred
	return 0;	
#else
	return Depth.SampleLevel(gPointClampSampler, viewport.xy + (float2(i.NDC_Position.x, -i.NDC_Position.y) / i.NDC_Position.w * 0.5 + 0.5) * viewport.zw, 0).x;
#endif

}

DepthStencilState resolveDepthBuffer {
	DepthEnable = TRUE;
	DepthWriteMask = ALL;
	DepthFunc = ALWAYS;

	StencilEnable = TRUE;
	StencilReadMask = 1;
	StencilWriteMask = 1;

	FrontFaceStencilFunc = ALWAYS;
	FrontFaceStencilPass = REPLACE;
	FrontFaceStencilFail = KEEP;

	BackFaceStencilFunc = ALWAYS;
	BackFaceStencilPass = REPLACE;
	BackFaceStencilFail = KEEP;
};

#define COMMON_PART		SetGeometryShader(NULL);	\
						SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
						SetRasterizerState(cullNone);


technique10 ResolveDepth {
	pass output_without_MSAA {		// as min depth
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, PS()));
		SetDepthStencilState(resolveDepthBuffer, 0);
		COMMON_PART
	}
	pass upscale_DLSS {
		SetVertexShader(CompileShader(vs_5_0, VS_UPSCALE()));
		SetPixelShader(CompileShader(ps_5_0, PS_UPSCALE()));
		SetDepthStencilState(alwaysDepthBuffer, 0);
		COMMON_PART
	}

#ifdef MSAA		// unused
	pass output_as_MSAA_2X {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetPixelShader(CompileShader(ps_4_1, PS_PER_SAMPLE( MSAA / 2 )));
		SetDepthStencilState(alwaysDepthBuffer, 0);
		COMMON_PART
	}
#endif
}

technique10 ResolveDepthStencil {
	pass P0 {
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, PS_STENCIL()));
		SetDepthStencilState(resolveDepthBuffer, 0);
		COMMON_PART
	}
}

technique10 CopyDepth {
	pass P0 {
		SetVertexShader(CompileShader(vs_5_0, VS()));
#ifdef MSAA
		SetPixelShader(CompileShader(ps_4_1, PS_PER_SAMPLE(1)));
#else
		SetPixelShader(CompileShader(ps_5_0, PS()));
#endif
		SetDepthStencilState(alwaysDepthBuffer, 0);
		COMMON_PART
	}
}

