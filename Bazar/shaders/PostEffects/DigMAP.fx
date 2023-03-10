#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

#ifdef MSAA
	Texture2DMS<float3, MSAA> SourceMap;
#else
	Texture2D<float3> SourceMap;
#endif

Texture2D ColorBand;

float4 viewport;
float3 lightDir;
float4 params;
uint2 dims;

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

static const float3 color_band[8] = {
	{ 0.11, 0.41, 0.00 },{ 0.25, 0.65, 0.09 },{ 0.47, 0.89, 0.38 },{ 0.87, 0.84, 0.70 },
	{ 0.88, 0.88, 0.37 },{ 0.89, 0.69, 0.34 },{ 0.71, 0.48, 0.04 },{ 0.52, 0.41, 0.00 }
};

float2 prePS(const VS_OUTPUT i) {
	uint2 idx = i.pos.xy;
	float2 uv = float2(i.projPos.x*0.5 + 0.5, -i.projPos.y*0.5 + 0.5)*viewport.zw + viewport.xy;

#ifdef MSAA
	int2 px = uv*dims;
	float3 src = 0;
	[unroll]
	for(uint i=0; i<MSAA; ++i)
		src += SourceMap.Load(px, i).xyz;
	src /= MSAA;
#else
	float3 src = SourceMap.Sample(gTrilinearClampSampler, uv).xyz;
#endif

	float3 n;
	n.xz = (src.yz - 0.5) * 2;
	n.y = sqrt(1 - dot(n.xz, n.xz));
	float c = dot(n, lightDir);
	float a = src.x - 500;
	return float2(c, a);
}

float4 PS(const VS_OUTPUT i): SV_TARGET0 {
	float2 c = prePS(i);
	return float4(c.xxx, 1);
}

float4 PS_1(const VS_OUTPUT i): SV_TARGET0 {
	float2 c = prePS(i);
	float alt = c.y;
	const float feet50 = 15.24; // 50 feet = 15.24 meters
	float3 ac = float3(1, alt < params.x, alt < params.x - feet50);
	return float4(lerp(c.xxx, ac * c.x, 0.5), 1);
}

float4 PS_2(const VS_OUTPUT i): SV_TARGET0 {
	float2 c = prePS(i);
	float a = smoothstep(params.y, params.z, c.y);
	int idx = clamp(uint(a * 8), 0, 7);
	float3 ac = color_band[idx] * 1.5;
	return float4(lerp(c.xxx, ac * c.x, 0.5), 1);
}

float4 PS_3(const VS_OUTPUT i): SV_TARGET0 {
	float2 c = prePS(i);
	float a = 1 - smoothstep(params.y, params.z, c.y);
	return float4(lerp(c.xxx, float3(0, a * c.x, 0), 0.5), 1);
}

float4 PS_4(const VS_OUTPUT i): SV_TARGET0 {
	float2 c = prePS(i);
	float a = smoothstep(params.y, params.z, c.y);
	float3 ac = ColorBand.Sample(gPointClampSampler, float2(a, 0)).xyz * 1.5;
	return float4(lerp(c.xxx, ac * c.x, 0.5), 1);
}

#define COMMON_PART SetVertexShader(CompileShader(vs_4_0, VS()));									\
					SetGeometryShader(NULL);														\
					SetDepthStencilState(disableDepthBuffer, 0);									\
					SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
					SetRasterizerState(cullNone);										

technique10 Tech {
	pass P0 {
		SetPixelShader(CompileShader(ps_4_0, PS()));
		COMMON_PART
	}
	pass P1 {
		SetPixelShader(CompileShader(ps_4_0, PS_1()));
		COMMON_PART
	}
	pass P2 {
		SetPixelShader(CompileShader(ps_4_0, PS_2()));
		COMMON_PART
	}
	pass P3 {
		SetPixelShader(CompileShader(ps_4_0, PS_3()));
		COMMON_PART
	}
	pass P4 {
		SetPixelShader(CompileShader(ps_4_0, PS_4()));
		COMMON_PART
	}
}


