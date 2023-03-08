#include "../common/samplers11.hlsl"
#include "../common/states11.hlsl"

Texture2D Map;

struct VS_OUTPUT {
	float4 vPos			:SV_POSITION;
	float2 vTexCoords	:TEXCOORD0;
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	float4 pos = float4((vid & 1)? 1.0 : -1.0, (vid & 2)? 1.0 : -1.0, 0, 1);	// generate quad

	VS_OUTPUT o;
    o.vPos = pos;
	o.vTexCoords = float2(pos.x * 0.5 + 0.5, -pos.y * 0.5 + 0.5);
    return o;    
}

float4 PS(VS_OUTPUT i): SV_TARGET0 { 
	return Map.Sample(ClampLinearSampler, i.vTexCoords.xy);
}

technique10 Copy {
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));
		SetComputeShader(NULL);

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

technique10 CopyBlend {
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));
		SetComputeShader(NULL);

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}
