#include "common/States11.hlsl"

#ifndef NUM_GRAPH
#define NUM_GRAPH 1
#endif

#ifndef SIZE
#define SIZE 1
#endif

float2 Win_size;
float3 Min_max;
int iP[NUM_GRAPH];
float4 vColor[NUM_GRAPH];
float fLns[SIZE*NUM_GRAPH];

struct VS_INPUT 
{
	uint   vId : SV_VertexID;
	uint   iId : SV_InstanceID;
};

struct VS_OUT
{
	float4 oPos : SV_POSITION;
	float4 oColor : TEXCOORD0;
};

VS_OUT vs_main(VS_INPUT IN)
{
	VS_OUT vs_out;
	float4 f4Pos;
	
	int i=IN.iId*SIZE+(iP[IN.iId]+IN.vId)%SIZE;
	float val=(fLns[i]-Min_max.x)/(Min_max.y-Min_max.x);

	f4Pos=float4((IN.vId/Win_size.x)*2.0-1,val*2.0-1.0,0,1);
	
	vs_out.oPos = f4Pos;
	vs_out.oColor=vColor[IN.iId];
	return vs_out;
}

float4 ps_main(VS_OUT IN) : SV_TARGET0
{
	return IN.oColor;
}

#ifdef DIRECTX11
technique10 Standart
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
#else

void vs_main9(in float4 vPos  : POSITION, out float4 oPos  : SV_POSITION)
{
	oPos = vPos;
}
void ps_main9(out float4 color : SV_TARGET0)
{
	color = float4(1, 1, 1, 1);
}

technique Standart
{
	pass P0
	{
		AlphaBlendEnable = True;
		SrcBlend    = SRCALPHA;
		DestBlend   = INVSRCALPHA;
		AlphaTestEnable =  false;
		ZEnable = False;
		StencilEnable = False;
		CULLMODE = NONE;

		VertexShader = compile vs_3_0 vs_main9(); 	
		PixelShader = compile ps_3_0 ps_main9();
	}
}
#endif
