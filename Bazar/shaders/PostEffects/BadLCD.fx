#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/BC.hlsl"

Texture2D DiffuseMap;
float4	viewport;
float4 params;

struct VS_OUTPUT {
	float4 pos:			SV_POSITION;
	float4 projPos:		TEXCOORD0;
};

static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.projPos = o.pos = float4(quad[vid], 0, 1);
	return o;
}

static const float3 mult[3][3] = {
	{ { 0.7, 0.3, 0.3 },{ 0.3, 0.7, 0.3 },{ 0.3, 0.3, 0.7 } },
	{ { 2.0, 0.5, 0.5 },{ 0.5, 2.0, 0.5 },{ 0.5, 0.5, 2.0 } },
	{ { 2.0, 0.5, 0.5 },{ 0.5, 2.0, 0.5 },{ 0.5, 0.5, 2.0 } },
};

float4 PS(const VS_OUTPUT i): SV_TARGET0 {
	uint2 idx = i.pos.xy;
	float2 uv = float2(i.projPos.x*0.5+0.5, -i.projPos.y*0.5+0.5)*viewport.zw + viewport.xy;
	
	float3 color = DiffuseMap.Sample(ClampPointSampler, uv).rgb;
	color = BCM(color, params.x, params.y, params.z);
	color = lerp(color, color * mult[idx.y % 3][idx.x % 3], params[3]);
	return float4(color, 1);
}

technique10 Tech {
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}


