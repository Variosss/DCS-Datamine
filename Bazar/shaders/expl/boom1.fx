#include "common\States11.hlsl"
#include "common\TextureSamplers.hlsl"
#include "common\samplers11.hlsl"
#include "common\context.hlsl"
#define FOG_ENABLE
#include "common\fog2.hlsl"


Texture2D Texture1;
Texture2D Texture2;
float4x4 invView;
float4x4 viewproj;
float4 wPos;

float4 g_vRight;
float4 g_vUp;
float4 g_vForward;

float4 flashPos;
float4 lightDir;

float4 camPos;

float4 color;

struct VS_OUTPUT 
{
	float4 oPos : SV_POSITION0; 
	float2 oT0	: TEXCOORD0;
	float4 oT1	: TEXCOORD1;
	float4 oT2	: TEXCOORD2;
	float4 oD0	: COLOR0;
};

VS_OUTPUT VertOut(float3 vPos : POSITION0, float3 vLoc : POSITION1, float2 vScale : POSITION2, float rot : POSITION3, float2 opacity : POSITION4/*,
             out float4 oPos : SV_POSITION, out float2 oT0 : TEXCOORD0,out float4 oT1 : TEXCOORD1,out float4 oT2: TEXCOORD2,out float4 oD0 : COLOR0*/)
{
	VS_OUTPUT o;
	float2 t;
	t.x=vPos.x*vScale.x;
	t.y=vPos.y*vScale.y;

	o.oT1.x=sin(-rot);
	o.oT1.y=cos(-rot);

	
	
	float4 tr;
	tr.x= t.x*cos(rot)-t.y*sin(rot);
	tr.y= t.x*sin(rot)+t.y*cos(rot);
	tr.z=0;
	tr.w=0;

	float4 tw=mul(tr,invView);


	tw.xyz+=vLoc+wPos;
	tw.w=1;
	o.oT2=tw;


//------------------------------------
		float3 delta = flashPos.xyz - tw.xyz;
		float distSq = dot(delta,delta);
		//float3 d = float3(1,0,distSq);
		
		float fatten = 1.0 / (12*distSq);
		
		float intensity = fatten * flashPos.w * 0.9;

	o.oT1.z=intensity;
	o.oT1.w=0;



//------------------------------------


	o.oPos=mul(tw,viewproj);


	o.oT0.x=(vPos.x*0.5+0.5);
	o.oT0.y=(-vPos.y*0.5+0.5);
	o.oD0.x=opacity.y;
	o.oD0.yz=1;
	o.oD0.w=opacity.x;

	return o;

}


struct PS_OUTPUT
{
    float4 cOut : SV_TARGET0;  // Pixel color
};

PS_OUTPUT PixOut( VS_OUTPUT i /*float2 tex0 : TEXCOORD0, float4 tex1 : TEXCOORD1, float4 objPos : TEXCOORD2,float4 c0 : COLOR0*/)
{	
	#define tex0 i.oT0
	#define tex1 i.oT1
	#define objPos i.oT2
	#define c0 i.oD0
    PS_OUTPUT Out;

        float4 t1= Texture1.Sample(ClampLinearSampler, tex0*0.7);
        float4 t2= Texture2.Sample(ClampLinearSampler, tex0);


	float3 norm = (t1.xyz-0.5)*2;


	float3 rotnorm;
	float fSinTheta = tex1.x;
	float fCosTheta = tex1.y;
	
	rotnorm.x = fCosTheta * norm.x - fSinTheta * norm.y;
	rotnorm.y = fSinTheta * norm.x + fCosTheta * norm.y;
	rotnorm.z = norm.z;
	
	norm = rotnorm;

    float3 worldnorm;
    worldnorm = -norm.x * g_vRight;
    worldnorm += norm.y * g_vUp;
    worldnorm += -norm.z * g_vForward;

    
//    float lighting = max( 0.0, dot( normalize(worldnorm), lightDir.xyz ) );
//    float lighting = abs(dot( normalize(worldnorm), lightDir.xyz ) );
    float lighting = max(color.w, abs(dot( normalize(worldnorm), lightDir.xyz ) ));



	float alpha=t2.w*c0.x;

	float flash=tex1.z*alpha;
//	float3 flashClr=lerp(float3(1,0.5,0),float3(1,1,1),min(1,tex1.z));//flash;
	// float3 flashClr = min(5, 5*pow(float3(1,0.694118,0.262745),2)*tex1.z*c0.x);
	float3 flashClr = min(5, 5*pow(float3(1,0.5,0.2),1)*tex1.z*c0.x);
	float3 clr = lighting * color.xyz;//max(0.22,flashClr);
	
	Out.cOut.xyz = lerp(flashClr, clr, max(0,1-tex1.z));

	Out.cOut.w = alpha * getFogTransparency(camPos.xyz, objPos);
	return Out;
}

BlendState fxBlend
{
	// AlphaBlendEnable = true;
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;	
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = ONE;
	BlendOp = ADD;
	BlendOpAlpha = ADD;
	// AlphaFunc = Greater;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

technique10 T0
{
    pass P0
    {
	SetBlendState(fxBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	ENABLE_RO_DEPTH_BUFFER;
	DISABLE_CULLING;
	
	VERTEX_SHADER(VertOut())
	PIXEL_SHADER(PixOut())
	GEOMETRY_SHADER_PLUG	
	// AlphaBlendEnable =True;
	// SrcBlend=SrcAlpha;
    // DestBlend=InvSrcAlpha;
    // SrcBlendAlpha = SrcAlpha;
    // DestBlendAlpha = ONE;//ZERO;
	// AlphaTestEnable = True;
	// AlphaRef=0;
	// AlphaFunc=Greater;
	// ZEnable = True;
	// ZWriteEnable = False;
	// CullMode = NONE;	
    // VertexShader = compile vs_3_0 VertOut();	
	// PixelShader = compile ps_3_0 PixOut();
    }
 }

