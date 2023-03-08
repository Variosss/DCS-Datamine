#include "common/states11.hlsl"
#include "common/stencil.hlsl"

#ifdef MSAA
	#define TEXTURE_2D(type, name) Texture2DMS<type, MSAA> name
	#define	SampleMap(name, uv, idx)  name.Load(uint2(uv), idx)
#else
	#define TEXTURE_2D(type, name) Texture2D<type> name
	#define	SampleMap(name, uv, idx)  name.Load(uint3(uv, 0))
#endif

TEXTURE_2D(float4, ComposedGBuffer);
TEXTURE_2D(uint2, StencilMap);

static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

float4 VS(uint vid: SV_VertexID): SV_POSITION {
	return float4(quad[vid], 0, 1);
}

float4 PS(float4 pos: SV_POSITION) : SV_TARGET0 {
#ifdef MSAA
	uint materialId = STENCIL_COMPOSITION_COCKPIT;
	float3 color = 0;
	[unroll]
	for (uint i = 0; i < MSAA; ++i) {
		materialId &= SampleMap(StencilMap, pos.xy, i).g & STENCIL_COMPOSITION_MASK;
		color += SampleMap(ComposedGBuffer, pos.xy, i).rgb;
	}
	color /= MSAA;
#else
	uint materialId = SampleMap(StencilMap, pos.xy, 0).g & STENCIL_COMPOSITION_MASK;
	float3 color = SampleMap(ComposedGBuffer, pos.xy, 0).rgb;
#endif
	float mask = materialId == STENCIL_COMPOSITION_COCKPIT;
//	return float4(mask > 0 ? float4(1, 0, 0, 1) : color, mask);
	return float4(color, mask);
}

technique10 CockpitRefraction {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

