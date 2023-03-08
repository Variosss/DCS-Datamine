#include "../common/states11.hlsl"

float4 color;
float4x4 WVP;

static const float3 surfColor = {0.2, 0.8, 0.3};
//static const float3 surfColor = {0.3, 0.3, 0.3};

float4 VS(float4 pos : POSITION0): SV_POSITION0
{
	return mul(pos, WVP);
}


float4 PS() : SV_TARGET0
{     
	return color;
}

struct VS_OUTPUT2 {
	float4	pos:	SV_POSITION;
	float3	coords: TEXCOORD0;
};

VS_OUTPUT2 VS_fakeSurf(float3 pos: POSITION0) 
{
	VS_OUTPUT2 o;

	//pos.y -= 100;

    o.coords.xy = pos.xz;//UV	
	o.coords.z = pos.y;//height
	o.pos = mul(float4(pos,1), WVP);
    return o;    
}


float4 PS_fakeSurf(VS_OUTPUT2 i) : SV_TARGET0
{
	const float heightMax = 5;

	float opacity = -i.coords.z/heightMax;

	opacity = 6*opacity;


	return float4(surfColor, pow(saturate(opacity), 1.8) );
	//return float4(1,0,0,1);
}



technique10 tech
{
    pass P0
    {
		SetRasterizerState(cullNone);	

		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetPixelShader(CompileShader(ps_4_0, PS()));
		SetGeometryShader(NULL);
    }
}


technique10 fakeSurface
{
    pass P0
    {          
		SetVertexShader(CompileShader(vs_4_0, VS_fakeSurf()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS_fakeSurf()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		//SetRasterizerState(wireframe);
		
    }
}