#include "common/Samplers11.hlsl"
#include "common/States11.hlsl"

float4 params;
Texture2D source;
float4	viewport;

struct VS_OUTPUT {
	float4 pos:			SV_POSITION0;
	float2 texCoord:	TEXCOORD0;
};

static const float2 quad[4] = {
	float2(-1, -1),
	float2( 1, -1),
	float2(-1,  1),
	float2( 1,  1),
};


VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	float2 p = quad[vid];
	o.pos = float4(p, 0, 1);
	o.texCoord = float2(p.x*0.5 + 0.5, -p.y*0.5 + 0.5)*viewport.zw + viewport.xy;
	return o;
}

float getIR(float2 tex_coord) {
	float4 InColor = source.Sample(WrapPointSampler, tex_coord);
	float amp = 0.35 * pow(abs((1.0 - 0.33*(InColor.r + 0.9*InColor.g - InColor.b))), 7.2);
	return pow(2.8 *(1 - cos(3.14 * amp)), 0.7);
}

float calcResult(float2 tex_coord) {
	float Color = 0;
	float blur_factor = params[0] *            // "разрешение IR сенсора"
					(1.0 + 20.0*params[3]);   // управление фокусировкой (focus_factor), параметр должен быть в диапазоне [0.0.....1.0]

	for (float i = -10; i < 11; i++) {
		for (float j = -10; j < 11; j++)
			Color += 0.0025 * getIR(tex_coord + blur_factor*float2(i, j));
	}

	// gain control
	Color = (Color - 0.5)*pow(16.0, params[1]) + 0.5;

	// level control
	Color += params[2];

	return Color;
}

float4 PS_WH(VS_OUTPUT i): SV_TARGET0 {
	float c = calcResult(i.texCoord);
	return float4(c, c, c, 1);
}

float4 PS_BH(VS_OUTPUT i): SV_TARGET0{
	float c = 1.0-calcResult(i.texCoord);
	return float4(c, c, c, 1);
}

/*
float4 psO2I(vsParams input ): SV_TARGET0 
{
	float2 tex_coord = input.vTexCoord0 ;
	float4 InColor = optical.Sample(WrapPointSampler, tex_coord);

	float amp =  0.35 * pow(abs((1.0 - 0.33*(InColor.r + 0.9*InColor.g - InColor.b))) , 7.2 ) ; 
	amp = pow ( 2.8 *(1-cos( 3.14 * amp)) , 0.7 ) ;
	
	return float4 (amp , amp , amp , 1.0 ) ;

}

float4 psBLUR(vsParams input ): SV_TARGET0 
{
	float2 tex_coord = input.vTexCoord0 ;
	float4 Color ;
	float blur_factor = params[0] *            // "разрешение IR сенсора"
                      (1.0+20.0*params[3]) ;   // управление фокусировкой (focus_factor), параметр должен быть в диапазоне [0.0.....1.0]
  
  for (float i = -10 ; i < 11 ; i++)
   {
     for (float j = -10 ; j < 11 ; j++)
      {
        Color +=  0.0025 * optical.Sample(WrapPointSampler, tex_coord + blur_factor*float2(i,j) ) ;
      }

   }
  
  // gain control
  Color = (Color - 0.5)*pow ( 16.0 , params[1]) + 0.5 ;
  
  // level control
  Color += float4( params[2] , params[2] , params[2] , 0.0);
  
  Color[3]=1.0 ; 

  return Color  ;
	
}

technique10 O2I {
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vsInfraRed()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psO2I()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);       
	}
}

technique10 Blur {
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vsInfraRed()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBLUR()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);       
	}
}

*/

technique10 WhiteHot {
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS_WH()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

technique10 BlackHot {
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS_BH()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

