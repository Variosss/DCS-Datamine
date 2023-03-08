#define FOG_ENABLE

#include "common/samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "common/fog2.hlsl"
#include "ParticleSystem2/common/psShading.hlsl"
#include "TextureAtlas.hlsl"
#include "SoftParticles.hlsl"

float4x4 matModViewProjection;
float4x4 matViewInverse;

float4x4 matWorld;
float3 cameraPos;

Texture2D randTex;
float2 randTexSize;

#define sunColor		gSunDiffuse.xyz
#define sunDir			gSunDirV.xyz

float3 vecParams;
float lifeTime;//Время жизни эффекта

static const float4 staticVertexData[4] = {
    float4( 0,  0, -0.5,  0.5),
    float4( 1,  0,  0.5,  0.5),
    float4( 0,  1, -0.5, -0.5),
    float4( 1,  1,  0.5, -0.5),
};

struct VS_INPUT 
{
   float4 pos    : POSITION;     // initial pos, initial roll
   float4 ind  : TEXCOORD0;		 // id, size, spin, birthTime
   float4 color  : TEXCOORD1;    // color
};

struct VS_OUTPUT 
{
   float4 pos    : POSITION;    // initial pos, initial roll
   float4 ind  : TEXCOORD0;		 // id,size, spin, birthTime
   float4 color  : TEXCOORD1;    // color
};

struct PS_INPUT
{
   float4 screenpos :  SV_POSITION;
   float4 texcoord :  TEXCOORD0; //x,y,id,birthTime
   float4 color    : TEXCOORD1;
   float2 screenTex: TEXCOORD2;
   float  depth	   : TEXCOORD3;
   float4 worldPos : TEXCOORD4;
};

float4x4 billboard(float3 pos, float roll) 
{
    float _sin, _cos;
//    float fR = atan2( matModViewProjection[1][0] , matModViewProjection[1][1] );
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

float4 makeAdditiveBlending(in float4 clr, in float additiveness = 1)
{
	clr.rgb *= clr.a;
	float4 clr2 = float4(clr.rgb, 0);
	return lerp(clr, clr2, clr.a*additiveness);
}

VS_OUTPUT vs( VS_INPUT Input )
{
	VS_OUTPUT Output;

	Output.pos = Input.pos;
	Output.ind = Input.ind;
	Output.color = Input.color;
	// Output.texCoord = float4(0,0,1,1);

	return Output;
}

[maxvertexcount(4)]
void gs(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	PS_INPUT output;
	
	output.color = input[0].color;
	//расчет матрицы - ориентация на камеру + доворот на угол roll
	float4x4 BM = billboard( input[0].pos.xyz , input[0].ind.z );
	
	const float4 texCoord = float4(0,0,1,1);
	
	[unroll]
	for(uint i = 0; i < 4; ++i)
	{
		//положение вершины в системе координат камеры
		float4 billboardedPos = mul(float4(staticVertexData[i].zw * input[0].ind.yy, 0, 1), BM);
		
		// позиция частицы
		output.screenpos = mul( billboardedPos , matModViewProjection );
		
		output.texcoord  = float4(texCoord.xy + staticVertexData[i].xy * texCoord.zw, input[0].ind.xw);
		output.screenTex = output.screenpos.xy/output.screenpos.w;
		output.depth = output.screenpos.z/output.screenpos.w;
		output.worldPos = mul(billboardedPos, matWorld);
		output.worldPos /= output.worldPos.w;
		
		outputStream.Append(output);
	}

	outputStream.RestartStrip();
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

#include "PSAnimatedFire.hlsl"
#include "PSAnimatedSmoke.hlsl"
#include "PSTranscluent.hlsl"

BlendState enableAlphaBlendPtFire
{
	BlendEnable[0] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = ONE;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

BlendState enableAlphaBlendPtSys
{
	BlendEnable[0] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = ONE;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

BlendState enableAlphaBlend2
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = FALSE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f;
};

#define enableAlphaBlend2 enableAlphaBlend

VertexShader vsComp = CompileShader(vs_4_0, vs());
GeometryShader gsComp = CompileShader(gs_4_0, gs());

technique10 Translucent
{
	pass Pass_0
	{
		SetVertexShader(vsComp);
		SetGeometryShader(gsComp);
		SetPixelShader(CompileShader(ps_4_0, psTranslucent()));
		SetBlendState(enableAlphaBlendPtSys, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}

	pass Flir
	{
		SetVertexShader(vsComp);
		SetGeometryShader(gsComp);
		SetPixelShader(CompileShader(ps_4_0, psTranslucentFlir()));
		SetBlendState(enableAlphaBlendPtSys, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}

technique10 TranslucentAnim
{
	pass Pass_0
	{
		SetVertexShader(vsComp);
		SetGeometryShader(gsComp);
		SetPixelShader(CompileShader(ps_4_0, psTranslucentAnim(0.5)));
		SetBlendState(enableAlphaBlendPtSys, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}

	pass Flir
	{
		SetVertexShader(vsComp);
		SetGeometryShader(gsComp);
		SetPixelShader(CompileShader(ps_4_0, psTranslucentAnimFlir(0.5)));
		SetBlendState(enableAlphaBlendPtSys, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}

technique10 TranslucentAnimLowLight
{
	pass Pass_0
	{
		SetVertexShader(vsComp);
		SetGeometryShader(gsComp);
		SetPixelShader(CompileShader(ps_4_0, psTranslucentAnim(0.75)));
		SetBlendState(enableAlphaBlendPtSys, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}

	pass Flir
	{
		SetVertexShader(vsComp);
		SetGeometryShader(gsComp);
		SetPixelShader(CompileShader(ps_4_0, psTranslucentAnimFlir(0.75)));
		SetBlendState(enableAlphaBlendPtSys, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}

technique10 TranslucentMarkerSmoke
{
	pass Pass_0
	{
		SetVertexShader(vsComp);
		SetGeometryShader(gsComp);
		SetPixelShader(CompileShader(ps_4_0, psSmokeMarker(1)));
		SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}

	pass Flir
	{
		SetVertexShader(vsComp);
		SetGeometryShader(gsComp);
		SetPixelShader(CompileShader(ps_4_0, psSmokeMarkerFlir(1)));
		SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}

technique10 AnimatedFire
{
	pass Pass_0
	{
		SetVertexShader(vsComp);
		SetGeometryShader(gsComp);
		SetPixelShader(CompileShader(ps_4_0, psAnimatedFire()));
		SetBlendState(enableAlphaBlendPtFire, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}

	pass Flir
	{
		SetVertexShader(vsComp);
		SetGeometryShader(gsComp);
		SetPixelShader(CompileShader(ps_4_0, psAnimatedFireFlir()));
		SetBlendState(enableAlphaBlendPtFire, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}

#undef FOG_ENABLE
