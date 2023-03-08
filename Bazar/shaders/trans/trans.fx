#include "common\States11.hlsl"
#include "common\TextureSamplers.hlsl"

float4 offset;
float4 clr;

void VertOut(float2 vPos : POSITION, out float4 oPos : SV_POSITION, out float2 oT0 : TEXCOORD0)
{
	float2 oo=vPos;
	oo.y*=-1;
	
	oPos.xy=((oo*0.5+0.5)*offset.xy+offset.zw)*2-1;
	
	oPos.z=0;
	oPos.w=1.0;
	oT0.x=(oo.x*0.5+0.5);
	oT0.y=(-oo.y*0.5+0.5);
}

void VertOutBack(float2 vPos : POSITION, out float4 oPos : SV_POSITION, out float2 oT0 : TEXCOORD0)
{
	float2 oo=vPos;
	oo.y*=-1;
	
	if ((oo.y)>0)
		oo.x=offset.z;
	else
		oo.x=(offset.x*(oo.x*0.5+0.5)+offset.z);

	oPos.x=oo.x*2-1;
	oPos.y=((oo.y*0.5+0.5)*offset.y+offset.w)*2-1;
	
	oPos.z=0;
	oPos.w=1.0;
	oT0.x=(oo.x*0.5+0.5);
	oT0.y=(-oo.y*0.5+0.5);
}

void VertOutFront(float2 vPos : POSITION, out float4 oPos : SV_POSITION, out float2 oT0 : TEXCOORD0)
{
	float2 oo=vPos;
	oo.y*=-1;
	
	if ((oo.y)>0)
		oo.x=offset.x+offset.z;
	else
		oo.x=(offset.x*(oo.x*0.5+0.5)+offset.z);

	oPos.x=oo.x*2-1;
	oPos.y=((oo.y*0.5+0.5)*offset.y+offset.w)*2-1;
	
	oPos.z=0;
	oPos.w=1.0;
	oT0.x=(oo.x*0.5+0.5);
	oT0.y=(-oo.y*0.5+0.5);
}

void VertOutPex(float2 vPos : POSITION, out float4 oPos : SV_POSITION, out float2 oT0 : TEXCOORD0)
{
	float2 oo=vPos;
	oo.y*=-1;
	
	if ((oo.y)<0)
		oo.x=0.5*offset.x+offset.z;
	else
		oo.x=(offset.x*(oo.x*0.5+0.5)+offset.z);

	oPos.x=oo.x*2-1;
	oPos.y=((oo.y*0.5+0.5)*offset.y+offset.w)*2-1;
	
	oPos.z=0;
	oPos.w=1.0;
	oT0.x=(oo.x*0.5+0.5);
	oT0.y=(-oo.y*0.5+0.5);
}

void VertOutApex(float2 vPos : POSITION, out float4 oPos : SV_POSITION, out float2 oT0 : TEXCOORD0)
{
	float2 oo=vPos;
	oo.y*=-1;
	
	if ((oo.y)>-0.1)
		oo.x=0.5*offset.x+offset.z;
	else
		oo.x=(offset.x*(oo.x*0.5+0.5)+offset.z);

	oPos.x=oo.x*2-1;
	oPos.y=((oo.y*0.5+0.5)*offset.y+offset.w)*2-1;
	
	oPos.z=0;
	oPos.w=1.0;
	oT0.x=(oo.x*0.5+0.5);
	oT0.y=(-oo.y*0.5+0.5);
}

struct PS_OUTPUT
{
    float4 cOut : SV_TARGET0;  // Pixel color
};


PS_OUTPUT PixOut( float4 pos : SV_POSITION,float2 tex0 : TEXCOORD0)
{ 
    PS_OUTPUT Out;

        Out.cOut.xyzw = clr;//float4(0.5,0,0,0.5);

    return Out;
}

technique10 tRect
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }

technique10 tBack
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOutBack()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }

technique10 tFront
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOutFront()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }

technique10 tPex
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOutPex()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }

technique10 tApex
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOutApex()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }

//#endif
