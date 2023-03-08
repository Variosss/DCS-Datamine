#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"

matrix WVP;
float4 Color;
float3 f3PointScale;	//масштаб точки(x,y-масштаб,z-кол-во граней)

// #define f3PointScale float3(1,1,4)

struct VS_INPUT
{
	float4 vPos : POSITION;
};

struct VS_OUT
{
	float4 oPos : POSITION;
};

struct GS_OUTPUT
{
   float4 f4Pos : SV_POSITION;
};

VS_OUT vs_main(VS_INPUT IN)
{
	VS_OUT vs_out;
	vs_out.oPos = mul(IN.vPos,WVP);
	return vs_out;
}

[maxvertexcount(48)]
void gs(point VS_OUT input[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	GS_OUTPUT output;
	
	//доворот трех и четырех угольникаx
	float fR=1.570796;
	if (f3PointScale.z==4.0)
		fR=-0.785398;

	float fKof = 6.283185/f3PointScale.z;
	float4 f4PosZerro=input[0].oPos+float4(cos(fR)*f3PointScale.x,
			sin(fR)*f3PointScale.y,0,0);
			
	for(int i=1;i<(f3PointScale.z-1);i++)
	{
		output.f4Pos = f4PosZerro;
		outputStream.Append(output);
		
		output.f4Pos = input[0].oPos+float4(cos((float)i*fKof+fR)*f3PointScale.x,
			sin((float)i*fKof+fR)*f3PointScale.y,0,0);
		outputStream.Append(output);
		
		
		output.f4Pos = input[0].oPos+float4(cos((float)(i+1)*fKof+fR)*f3PointScale.x,
			sin((float)(i+1)*fKof+fR)*f3PointScale.y,0,0);
		outputStream.Append(output);
		
		outputStream.RestartStrip();
	}
}


float4 ps_main(GS_OUTPUT IN) : SV_TARGET0
{
	return Color;
}

#ifdef DIRECTX11
technique10 Standart
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(CompileShader(gs_4_0, gs()));
		SetPixelShader(CompileShader(ps_4_0, ps_main()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
#else
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

		VertexShader = compile vs_3_0 vs_main(); 	
		PixelShader = compile ps_3_0 ps_main();
	}
}
#endif
