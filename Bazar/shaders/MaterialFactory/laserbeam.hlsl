
#include "PostEffects/NVD_common.hlsl"

float4 Color;

struct vsLBOutput{
	float4 vPosition:	SV_POSITION;
	float4 projPos : TEXCOORD0;
};

vsLBOutput vsStandart_LB(in float3 vPosition: POSITION){		
	vsLBOutput o;
	
	o.vPosition = o.projPos = mul(float4(vPosition, 1.0), matWorldViewProj);
	
	return o;
}

float4 psStandart_LB(in const vsLBOutput i) : SV_TARGET0 {

	if (getNVDMask(i.projPos.xy/i.projPos.w) <= 0)
		discard;

	return Color;
}

float4 psNoMask_LB(in const vsLBOutput i) : SV_TARGET0 {
	return Color;
}

vertexshader vs_lb = compile vs_4_0 vsStandart_LB();
pixelshader ps_lb_0 = compile ps_4_0 psStandart_LB();
pixelshader ps_lb_1 = compile ps_4_0 psNoMask_LB();

technique10 Standart_LB{
	pass P0{
		SetRasterizerState(cullNone);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

		VertexShader = vs_lb;
		PixelShader  = ps_lb_0; 
		SetGeometryShader(NULL);
	}
}

technique10 NoMask_LB{
	pass P0{
		SetRasterizerState(cullNone);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	

		VertexShader = vs_lb;
		PixelShader  = ps_lb_1; 
		SetGeometryShader(NULL);
	}
}
