#include "common/states11.hlsl"

#ifdef MSAA
	Texture2DMS<float, MSAA> Source;
#else
	Texture2D<float> Source;
#endif

float4		viewport;
// int2		dims;

// SamplerState ClampPointSampler
// {
	// Filter        = MIN_MAG_MIP_POINT;
	// AddressU      = CLAMP;
	// AddressV      = CLAMP;
	// AddressW      = CLAMP;
// };

struct VS_OUTPUT {
	noperspective float4 pos:	SV_POSITION0;
	// float2 uv: 	TEXCOORD0;
};

struct PS_OUTPUT {
	float depth:	SV_DEPTH;
};

static const float2 quad[4] = {
	float2(-1, -1),
	float2(1, -1),
	float2(-1, 1),
	float2(1, 1),
};

VS_OUTPUT VS(uint vid: SV_VertexID)
{
	VS_OUTPUT o;
	o.pos = float4(quad[vid], 0, 1);
	// o.uv = float2(o.pos.x*0.5+0.5, -o.pos.y*0.5+0.5)*viewport.zw + viewport.xy;
// #ifdef MSAA//TODO: унести умножение в код
	// o.uv *= dims;
// #endif
	return o;
}

PS_OUTPUT PS(const VS_OUTPUT i
#ifdef MSAA
	, uint sampleId: SV_SampleIndex
#endif
)
{
	PS_OUTPUT o;
#ifdef MSAA
	o.depth = Source.Load(int2(i.pos.xy), sampleId).r < 0.9999? 0.0 : 1.0;
#else
	o.depth = Source.Load(int3(i.pos.xy, 0)).r < 0.9999? 0.0 : 1.0;
#endif
	return o;
}

BlendState noBlendNoColorWrite
{
	BlendEnable[0] = false;
	BlendEnable[1] = false;
	RenderTargetWriteMask[0] = 0x00; //RED | GREEN | BLUE | ALPHA
};

technique10 NearDepthToFarDepth {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, PS()));

		SetDepthStencilState(alwaysDepthBuffer, 0);
		SetBlendState(noBlendNoColorWrite, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}
