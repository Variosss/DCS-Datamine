#include "common\States11.hlsl"
#include "common\TextureSamplers.hlsl"

Texture2D shadowTex;

float4x4 viewproj;
float4x4 texproj;
float4 cam;

const float Size=100000.0;

struct VS_OUTPUT
{
	float4 oPos : SV_POSITION;
    float4 oT0 : TEXCOORD0;
};
VS_OUTPUT VertOut(float2 inPos0 : POSITION0)
{
	VS_OUTPUT OUT = (VS_OUTPUT)0;
	float4 r0;
	r0.x=(inPos0.x-0.5)*2*Size;//+cam.x;
	r0.z=(inPos0.y-0.5)*2*Size;//+cam.z;
	r0.y=100-cam.y;
	r0.w=1;

	float4 r1=r0;
	r1.x+=cam.x;
	r1.y=100;
	r1.z+=cam.z;


	OUT.oPos=mul(r0,viewproj);
	OUT.oT0=mul(r1,texproj);
	return OUT;
}

#ifdef DIRECTX11
TEXTURE_SAMPLER_WHITEBORDER(shadowTex,MIN_MAG_MIP_LINEAR,Border,Border);
#endif

struct PS_OUTPUT
{
    float4 cOut : SV_TARGET0;  // Pixel color    
};

PS_OUTPUT PixOut( VS_OUTPUT input)
// 	float4 pos : SV_POSITION,		
// 	float4 tex0 : TEXCOORD0)//,float4 tex1 : TEXCOORD1)
{ 
    PS_OUTPUT Out;
#ifdef DIRECTX11
	float4 c = TEX2DPROJ(shadowTex, input.oT0);
#else
    float4 c = tex2Dproj(mySampler, input.oT0);
#endif
	Out.cOut.xyz=float3(0.05,0.2,0)*c.xyz;
	Out.cOut.w=1;//c.w;
#ifdef DIRECTX11
	// Alpha test
	//if (Out.cOut.w <= 0) // 0 is the same as ALPHAREF = 0 // Ахуенно полезно при Out.cOut.w=1;
	//	discard;
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
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend /*enableAlphaBlend*/, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone); 

    }
 }
#else
technique T0
{
    pass P0
    {
	AlphaBlendEnable =False;//True;
	SrcBlend=SrcAlpha;
   	DestBlend=InvSrcAlpha;

	AlphaTestEnable = true;
	AlphaRef = 0;
	ZEnable = True;
	ZWriteEnable = True;
//	FillMode = WIREFRAME;
	CullMode = NONE;
   	VertexShader = compile vs_3_0 VertOut();
	PixelShader = compile ps_3_0 PixOut();

    }
 }
#endif
