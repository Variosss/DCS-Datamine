#include "../common/states11.hlsl"

#define USE_BLOT 1

Texture2DArray src;
int	steps;

static const float2 quad[4] = {
	float2(-1, -1),	float2(1, -1),
	float2(-1,  1),	float2(1,  1),
};

float4 VS(uint vid: SV_VertexID): SV_POSITION {
    return float4(quad[vid], 0, 1);
}

struct PS_OUTPUT {
	float4 color0 :SV_TARGET0;
	float4 color1 :SV_TARGET1;
};

static const float2 dirs[8] = {
	float2(0,  -1),	float2(0,  1),
	float2(-1,  0),	float2(1,  0),
	float2(-1, -1),	float2(1, -1),
	float2(-1,  1),	float2(1,  1),
};

PS_OUTPUT PS(float4 pos: SV_POSITION) { 
	PS_OUTPUT o;
	o.color0 = src.Load(int4(pos.xy, 0, 0));
#if USE_BLOT
	if(o.color0.a==0) {
		[loop]
		for(int i=0; i<steps; ++i) {
			[unroll]
			for(int j=0; j<8; ++j) {
				int2 np = pos.xy+dirs[j]*i;
				float4 c = src.Load(int4(np, 0, 0));
				if(c.a != 0) {
					o.color0.rgb = c.rgb;
					o.color1 = src.Load(int4(np, 1, 0));
					return o;
				}
			}
		}
	}
#endif
	o.color1 = src.Load(int4(pos.xy, 1, 0));
	return o;
}

technique10 Blot {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetPixelShader(CompileShader(ps_4_0, PS()));
		SetGeometryShader(NULL);

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}
