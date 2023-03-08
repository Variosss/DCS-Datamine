#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/stencil.hlsl"

Texture2D DiffuseMap;
float4	color;
float4	viewport;

#ifdef MSAA
	Texture2DMS<uint2, MSAA> StencilMap;
	bool isSelected(uint2 idx) { return (StencilMap.Load(uint2(idx), 0).g & STENCIL_SELECTED_OBJECT) != 0; }
#else
	Texture2D<uint2> StencilMap;
	bool isSelected(uint2 idx) { return (StencilMap.Load(uint3(idx, 0)).g & STENCIL_SELECTED_OBJECT) != 0; }
#endif


struct VS_OUTPUT {
	float4 pos:			SV_POSITION;
	float4 projPos:		TEXCOORD0;
};

static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

static const float2 offset[8] = {
	{-1, -1}, {1, -1}, {-1,  1}, {1,  1},
	{-1, 0}, {1, 0}, {0,  1}, {0,  1}
};


VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.projPos = o.pos = float4(quad[vid], 0, 1);
	return o;
}

float4 PS_FILL(const VS_OUTPUT i) : SV_TARGET0{
	uint2 idx = i.pos.xy;
	float4 d = DiffuseMap.Load(uint3(idx, 0));

	bool s = isSelected(idx);
	float4 c = s ? color : float4(0,0,0,0);
	return float4(lerp(d.xyz, c.xyz, c.a), 1);
}


float4 PS_BORDER(const VS_OUTPUT i, uniform int size): SV_TARGET0 {
	uint2 idx = i.pos.xy;
	float4 d = DiffuseMap.Load(uint3(idx, 0));

	bool s0 = isSelected(idx);
	bool s1 = false;
	[unroll]
	for (int x = -size; x <= size; ++x) {
		[unroll]
		for (int y = -size; y <= size; ++y)
			s1 = s1 | isSelected(idx + int2(x, y));
	}
	float4 c = (!s0 & s1) ? color : float4(0,0,0,0);
	return float4(lerp(d.xyz, c.xyz, c.a), 1);
}

#define END_PASS 		SetComputeShader(NULL); \
						SetGeometryShader(NULL); \
						SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
						SetDepthStencilState(disableDepthBuffer, 0); \
						SetRasterizerState(cullNone);

technique10 Tech {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetPixelShader(CompileShader(ps_4_0, PS_FILL()));
		END_PASS
	}
	pass P1 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetPixelShader(CompileShader(ps_4_0, PS_BORDER(1)));
		END_PASS
	}
	pass P2 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetPixelShader(CompileShader(ps_4_0, PS_BORDER(2)));
		END_PASS
	}
	pass P3 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetPixelShader(CompileShader(ps_4_0, PS_BORDER(3)));
		END_PASS
	}
}


