#include "common\States11.hlsl"
#include "common\samplers11.hlsl"
#define FOG_ENABLE
#include "common\fog.hlsl"


Texture2D DiffTex1;
Texture2D DiffTex2;

//Texture2D SkyTex;

float4 const5;
float4 const6;
float4 phase;

float4x4 view;
float4x4 proj;


void VertOut(float2 inPos0 : POSITION0,

              out float4 oPos : SV_POSITION,
              out float2 oT0 : TEXCOORD0)
{
	float4 r0;
	r0.xy=inPos0.xy*const5.xy;
	r0.z=0;
	r0.w=1;

	r0.xyz+=const6.xyz;

	oPos=mul(r0,proj);

	oT0.x=inPos0.x*0.5+0.5;
	oT0.y=inPos0.y*0.5+0.5;
	 
}

struct PS_OUTPUT
{
    float4 cOut : SV_TARGET0;  // Pixel color   for directx11
};

PS_OUTPUT PixOut( float4 pos : SV_POSITION,
                  float2 tex0 : TEXCOORD0)
{ 
    PS_OUTPUT Out;
    float4 c1 = DiffTex1.Sample(WrapLinearSampler, tex0);
    float4 c2 = DiffTex2.Sample(WrapLinearSampler, tex0);

    float c= 2 * lerp(c1.x,c2.x,1-phase.x);

    Out.cOut.w=c;


    Out.cOut.xyz=1;//float3(1,1,1);//c.xyz;
	
#ifdef DIRECTX11
	// Alpha test
	if (Out.cOut.a <= 0) // 0 is the same as ALPHAREF = 0
		discard;
#endif
    return Out;
}
#ifdef DIRECTX11
technique10 T0
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone); 
    }
 }
#else
technique T0
{
    pass P0
    {
	AlphaBlendEnable =True;
	SrcBlend=SrcAlpha;
    DestBlend=InvSrcAlpha;

	AlphaTestEnable = true;
	AlphaRef = 0;
	ZEnable = False;//True;
	ZWriteEnable = False;
//	FillMode = WIREFRAME;
	CullMode = NONE;
      


   	VertexShader = compile vs_3_0 VertOut();
	PixelShader = compile ps_3_0 PixOut();

    }
 }
#endif
