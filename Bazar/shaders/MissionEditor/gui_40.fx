#include "../common/States11.hlsl"

float4x4 WVP;
Texture2D mapTex;
float stencil;
float noTexture;
float fontTexture;
float userTextureFiltering = 0;
float2 pixelSize;

sampler texSampler = sampler_state
{
	Texture = mapTex;
	Filter = MIN_MAG_POINT_MIP_LINEAR;
	MAXANISOTROPY = 16;
	ADDRESSU = WRAP;
	ADDRESSV = WRAP;
};

sampler userTexSampler = sampler_state
{
	Texture = mapTex;
	Filter = ANISOTROPIC;
	MAXANISOTROPY = 4;
	ADDRESSU = WRAP;
	ADDRESSV = WRAP;
};

struct VS_INPUT
{
	float4 Position : POSITION0;
	float4 Color : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

struct VS_OUT 
{
	float4 Position : SV_POSITION0;
	float4 Color : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

VS_OUT vs_main( VS_INPUT IN )
{
	VS_OUT OUT;
	OUT.Position = mul(IN.Position, WVP);
	OUT.TexCoord = IN.TexCoord;
	OUT.Color = IN.Color;
	return OUT;
}

float4 ps_main(VS_OUT IN) : SV_TARGET0
{
  if(noTexture > 0)
  {
    return IN.Color;  
  }
  else
  {
	float4 diffuse;
    

	if(userTextureFiltering > 0)
	{
		diffuse = mapTex.Sample(userTexSampler, IN.TexCoord);
	}
	else
	{
		diffuse = mapTex.Sample(texSampler, IN.TexCoord);
	}
	  
	return diffuse * IN.Color;
  }
}

technique10 Standart
{
  pass P0
  {
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetPixelShader(CompileShader(ps_4_0, ps_main()));   
		SetGeometryShader(NULL);   			
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);	          
  }
}
