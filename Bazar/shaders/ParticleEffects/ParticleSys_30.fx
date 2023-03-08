#define FOG_ENABLE

#include "../common/TextureSamplers.hlsl"
#include "../common/States11.hlsl"
#include "../common/fog.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"

#include "TextureAtlas.hlsl"
#include "SoftParticles.hlsl"

float4x4 matModViewProjection;
float4x4 matViewInverse;

float4x4 matWorld;
float3 cameraPos;

Texture2D randTex;
float2 randTexSize;
TEXTURE_SAMPLER(randTex, MIN_MAG_MIP_POINT, WRAP, WRAP);

float3 vecParams;
float lifeTime;//Время жизни эффекта

#define sunColor		gSunDiffuse.xyz
#define sunDir			gSunDirV.xyz

static const float4 staticVertexData[4] = {
    float4( 0,  1, -0.5,  -0.5),
    float4( 0,  0,  -0.5,  0.5),
    float4( 1,  0, 0.5, 0.5),
    float4( 1,  1,  0.5, -0.5),
};

struct VS_INPUT 
{
   float4 pos : POSITION;     // worldpos, particleIndex
   float4 ind  : TEXCOORD0;		 // id, size, spin, birthTime
   float4 color  : TEXCOORD1;    // color
};

struct PS_INPUT 
{
   float4 pos :  SV_POSITION;
   float4 texcoord :  TEXCOORD0; //x,y,id,birthTime
   float4 color    : TEXCOORD1;
   float2 screenTex: TEXCOORD2;
   float  depth	   : TEXCOORD3;
   float4 worldPos : TEXCOORD4;
   float4 screenpos :  TEXCOORD5;
};

//TODO обрабатывать поворот камеры

float4x4 billboard(float3 pos, float roll) 
{
    float _sin, _cos;
    float fR = 0;
	sincos( roll + fR , _sin, _cos);

    float4x4 M = float4x4(
    _cos, _sin, 0, 0, 
    -_sin,  _cos, 0, 0, 
      0,     0, 1, 0, 
      0,     0, 0, 1);
    M = mul(M, matViewInverse);
    M[3][0] = pos.x;
    M[3][1] = pos.y;
    M[3][2] = pos.z;
    return M;
};

PS_INPUT vs( VS_INPUT input )
{
	PS_INPUT output;
    
	float4x4 BM = billboard( input.pos.xyz , input.ind.z );
	float index = input.pos.w;
	//положение вершины в системе координат камеры
	float4 billboardedPos = mul(float4( staticVertexData[index].z * input.ind.y, 
		staticVertexData[index].w * input.ind.y, 0.f, 1.f) , BM);
		
	// позиция частицы
	output.screenpos = mul(billboardedPos, matModViewProjection);
	output.color = input.color;
	output.texcoord  = float4(staticVertexData[index].x, staticVertexData[index].y, input.ind.x, input.ind.w);
	output.screenTex = output.screenpos.xy/output.screenpos.w;
	output.depth = output.screenpos.z/output.screenpos.w;
	output.worldPos = mul(billboardedPos, matWorld);
	output.pos = output.screenpos;
    
    return output;
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

#include "PSAnimatedFire.hlsl"
#include "PSAnimatedSmoke.hlsl"
#include "PSTranscluent.hlsl"

technique Translucent
{
	pass P0
	{
		VertexShader = compile vs_3_0 vs();
		PixelShader  = compile ps_3_0 psTranslucent(); 
		
		AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
		BlendOp = ADD;
		SrcBlendAlpha = ONE;
		DestBlendAlpha = INVSRCALPHA;
		BlendOpAlpha = ADD;
		ColorWriteEnable = RED|GREEN|BLUE|ALPHA; //RED | GREEN | BLUE | ALPHA
		
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
	}

	pass Flir
	{
		VertexShader = compile vs_3_0 vs();
		PixelShader  = compile ps_3_0 psTranslucentFlir(); 
		
		AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
		BlendOp = ADD;
		SrcBlendAlpha = ONE;
		DestBlendAlpha = INVSRCALPHA;
		BlendOpAlpha = ADD;
		ColorWriteEnable = RED|GREEN|BLUE|ALPHA; //RED | GREEN | BLUE | ALPHA
		
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
	}
}

technique TranslucentAnim
{
	pass P0
	{
		VertexShader = compile vs_3_0 vs();
		PixelShader  = compile ps_3_0 psTranslucentAnim(0.5); 
		
		AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
		BlendOp = ADD;
		SrcBlendAlpha = ONE;
		DestBlendAlpha = INVSRCALPHA;
		BlendOpAlpha = ADD;
		ColorWriteEnable = RED|GREEN|BLUE|ALPHA; //RED | GREEN | BLUE | ALPHA
		
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
	}

	pass Flir
	{
		VertexShader = compile vs_3_0 vs();
		PixelShader  = compile ps_3_0 psTranslucentAnimFlir(0.5); 
		
		AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
		BlendOp = ADD;
		SrcBlendAlpha = ONE;
		DestBlendAlpha = INVSRCALPHA;
		BlendOpAlpha = ADD;
		ColorWriteEnable = RED|GREEN|BLUE|ALPHA; //RED | GREEN | BLUE | ALPHA
		
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
	}
}

technique TranslucentAnimLowLight
{
	pass P0
	{
		VertexShader = compile vs_3_0 vs();
		PixelShader  = compile ps_3_0 psTranslucentAnim(0.75); 
		
		AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
		BlendOp = ADD;
		SrcBlendAlpha = ONE;
		DestBlendAlpha = INVSRCALPHA;
		BlendOpAlpha = ADD;
		ColorWriteEnable = RED|GREEN|BLUE|ALPHA; //RED | GREEN | BLUE | ALPHA
		
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
	}

	pass Flir
	{
		VertexShader = compile vs_3_0 vs();
		PixelShader  = compile ps_3_0 psTranslucentAnimFlir(0.75); 
		
		AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
		BlendOp = ADD;
		SrcBlendAlpha = ONE;
		DestBlendAlpha = INVSRCALPHA;
		BlendOpAlpha = ADD;
		ColorWriteEnable = RED|GREEN|BLUE|ALPHA; //RED | GREEN | BLUE | ALPHA
		
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
	}
}

technique AnimatedFire
{
	pass P0
	{
		VertexShader = compile vs_3_0 vs();
		PixelShader  = compile ps_3_0 psAnimatedFire(); 
		
		AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
		BlendOp = ADD;
		SrcBlendAlpha = SRCALPHA;
		DestBlendAlpha = INVSRCALPHA;
		BlendOpAlpha = ADD;
		ColorWriteEnable = RED|GREEN|BLUE|ALPHA; //RED | GREEN | BLUE | ALPHA
		
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
	}

	pass Flir
	{
		VertexShader = compile vs_3_0 vs();
		PixelShader  = compile ps_3_0 psAnimatedFireFlir(); 
		
		AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
		BlendOp = ADD;
		SrcBlendAlpha = SRCALPHA;
		DestBlendAlpha = INVSRCALPHA;
		BlendOpAlpha = ADD;
		ColorWriteEnable = RED|GREEN|BLUE|ALPHA; //RED | GREEN | BLUE | ALPHA
		
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
	}
}

#undef FOG_ENABLE
