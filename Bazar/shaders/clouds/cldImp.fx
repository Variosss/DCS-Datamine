#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#define FOG_ENABLE 1
#include "enlight/skyCommon.hlsl"

Texture2D texTarg;
#define SkyTex skyTex2

float4 const5;
float4 const6;
float4 const12;

float4x4 viewproj;
float4x4 world;

float4 cldclr;
float4 camPos;

static const float4 clearclr=float4(0.7529,0.7529,0.8157,0.0);


void VertOutSimple(float2 inPos0 : POSITION0,
				out float4 oPos : SV_POSITION)
{
	oPos.xy=inPos0.xy;
	oPos.z=0;
	oPos.w=1;
	
}

void VertOut(float2 inPos0 : POSITION0,

              out float4 oPos : SV_POSITION, out float4 oD0 :COLOR0,// out float4 oD1 : COLOR1,
              out float2 oT0 : TEXCOORD0, out float4 oT1 : TEXCOORD1, out float3 oT2 : TEXCOORD2)
{
	float4 r0;
	r0.x=inPos0.x*const6.z;
	r0.y=inPos0.y*const6.y;
	r0.z=0;
	r0.w=1;

	//
	//dp4 r1.x,r0,c0
	//dp4 r1.y,r0,c1
	//dp4 r1.z,r0,c2
	//dp4 r1.w,r0,c3

	float4 r1=mul(r0,viewproj);
	float4 ww=mul(r0,world);
	oT2=ww.xyz;

	//mov r7,r1
	float4 r7=r1;

	//mul r4.w, r1.w, c4.z
	//mad r1.x, r1.x, c4.z, r4.w
	//mad r1.y, r1.y, -c4.z, -r4.w

	float r4w=r1.w*0.5;
	r1.x=r1.x*0.5+r4w;
	r1.y=r1.y*(-0.5)-r4w;

	//mov oT1,r1
	oT1=r1;
	// oT1.xy /= oT1.w;


	//mad r0.xy,v0.xy,c4.z,c4.z
	r0.x=inPos0.x*0.5+0.5;
	r0.y=inPos0.y*0.5+0.5;
	 
	//mad oT0.xy,r0.xy,c5.zw,c5.xy ;*uv_span+shifts
	oT0.xy=r0.xy*const5.zw+const5.xy; //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


	//;
	//add r2.x,r1.w,-c12.x ;r-fogstart
	//mul r2.x,r2.x,c12.y  ;*slope
	//max r2.x,r2.x,c4.y
	//min r2.x,r2.x,c4.w

	float r2x=min(1,max(0,(r1.w-const12.x)*const12.y));

	//
	//add oD0.w,c4.w,-r2.x
	//mov oD0.xyz,c6.x
	//mov oD1.xyz,c10

	oD0.w=1-r2x;
	oD0.xyz=1;


	//mov oPos,r7

	oPos=r7;
	//oPos.xy=inPos0.xy*0.5+0.5;
	//oPos.z=0;
	//oPos.w=1;
}

float4 PixOutSimple( float4 pos : SV_POSITION): SV_TARGET0
{
	return clearclr;
}

float4 PixOut( float4 pos : SV_POSITION, float4 dif :COLOR0,// float4 spec : COLOR1,
                  float2 tex0 : TEXCOORD0, float4 tex1 : TEXCOORD1,//,float3 tex2 : TEXCOORD2,float2 tex3 : TEXCOORD3)
				  float3 objPos : TEXCOORD2): SV_TARGET0
{
	float4 c = texTarg.Sample(ClampLinearSampler, tex0.xy);
	
    float4 cOut;
    cOut.w=c.w;

	float3 view = objPos.xyz-camPos.xyz;
	float dist = length(view);
	view /= dist;
	cOut.a *= saturate(exp((85000-dist)/5000.0));
	if (cOut.a <= 0.001)
		discard;

	float ff=exp(-0.00002*max(0,dist-20000));
	float VoL = const6.x;

	float3 halo = gSunDiffuse.rgb * VoL * (1-c.w);
	float3 cloudColor = c.rgb * cldclr * 0.3;
	float3 fin = (cloudColor + halo) * gSunIntensity;

	cOut.xyz = applyFog(fin, view, dist);
	cOut.a *= ff;
    return cOut;
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
 
technique10 TSimple
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOutSimple()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOutSimple()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
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
	ZEnable = True;
	ZWriteEnable = False;
//	FillMode = WIREFRAME;
	CullMode = NONE;
      


   	VertexShader = compile vs_3_0 VertOut();
	PixelShader = compile ps_3_0 PixOut();

    }
 }
 //
 technique TSimple
{
    pass P0
    {
	AlphaBlendEnable =False;

	AlphaTestEnable = false;
	ZEnable = False;
	ZWriteEnable = False;
	CullMode = NONE;
      


   	VertexShader = compile vs_3_0 VertOutSimple();
	PixelShader = compile ps_3_0 PixOutSimple();

    }
 }
#endif
