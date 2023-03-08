#include "../common/states11.hlsl"

#ifdef MSAA
// #undef MSAA
#endif

#ifdef MSAA
	Texture2DMS<float, MSAA> Source;
#else
	Texture2D<float> Source;
#endif

float4x4	invProj;
float4		viewport;
int2 		dims;

SamplerState ClampPointSampler
{
	Filter        = MIN_MAG_MIP_POINT;
	AddressU      = CLAMP;
	AddressV      = CLAMP;
	AddressW      = CLAMP;
};

struct VS_OUTPUT {
	float4 pos:		SV_POSITION0;
	float2 projPos: TEXCOORD0;
};

static const float2 quad[4] = {
	float2(-1, -1),
	float2(1, -1),
	float2(-1, 1),
	float2(1, 1),
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.projPos = quad[vid];
	o.pos = float4(o.projPos, 0, 1);
	return o;
}


float4 PS(const VS_OUTPUT i): SV_TARGET0 {
	float2 uv = float2(i.projPos.x*0.5 + 0.5, -i.projPos.y*0.5 + 0.5)*viewport.zw + viewport.xy;
#ifdef MSAA
	float depth = 0;
	[unroll]
	for(uint ii=0; ii<MSAA; ++ii)	
		depth += Source.Load( int2(dims*uv), ii);	
	depth /= MSAA;
#else
	float depth = Source.SampleLevel(ClampPointSampler, uv, 1);
#endif
	if (depth >= 1.0)
		discard;
	float4 wpos = mul(float4(i.projPos, depth, 1.0), invProj);
	return float4(wpos.z / wpos.w * 0.001, 0, 0, 0);
}

technique10 LinearDistance {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}
