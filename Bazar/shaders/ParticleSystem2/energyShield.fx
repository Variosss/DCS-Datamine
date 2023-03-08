#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "common/shadingCommon.hlsl"
#include "common/random.hlsl"
#include "deferred/shading.hlsl"
#include "common/softParticles.hlsl"
#include "common/stencil.hlsl"

#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"

float3		baseColor;
float4		params;
float4		surfaceNormal;
#define		effectRadius	params.y
#define 	effectHeight	params.z
#define     gOpacity        params.w

#define		effectAspect	(effectHeight / (2*3.1415 * effectRadius))

static const float2 aspect = float2(1, effectAspect);

static const float waveScale = 10;
static const float hexTile = max(300, floor(2 * effectRadius / 100));

static const float3 edgeBaseColor = float3(3, 1.2, 0.75);
static const float3 temporalColor = float3(0.9, 0.6, 0.1);


struct VS_OUTPUT
{
	float4 pos: SV_POSITION0;
	float4 posP: TEXCOORD1;
};





VS_OUTPUT vsEnergyShield_line(uint id: SV_VertexID)
{
	float2 vertPos[] =
	{
		float2(-1.0f, -1.0f),
		float2(-1.0f,  1.0f),
		float2( 1.0f, -1.0f),
		float2( 1.0f,  1.0f)
	};

	VS_OUTPUT o;
	o.pos = float4(vertPos[id], 0, 1.0);
	o.posP = float4(vertPos[id], 0, 1.0);


	return o;
}


float depthReconstruct(float4 projPos) {
	float depth = g_DepthTexture.SampleLevel(gPointClampSampler, float2(projPos.x, -projPos.y) / projPos.w*0.5 + 0.5, 0).r;
	float4 p0 = mul(projPos, gProjInv);
	float4 p1 = mul(float4(projPos.xy / projPos.w, depth, 1), gProjInv);
	return (p1.z / p1.w - p0.z / p0.w);
}

float3 RestoreWorldPos(float depth, float2 projPos)
{
	float4 pos = mul(float4(projPos, depth, 1), gViewProjInv);
	return pos.xyz / pos.w;
}


float4 psEnergyShield_line(VS_OUTPUT i): SV_TARGET0
{
	
	if(true){

		float4 finalColor = float4(1.0, 0.0, 0.0, 1.0);
		//finalColor.rgb = finalColor.rgb*i.mediaTr+i.mediaInSc;
		float depth =  g_DepthTexture.SampleLevel(gPointClampSampler, float2(i.posP.x, -i.posP.y) / i.posP.w*0.5 + 0.5, 0).r;
		float3 posW = RestoreWorldPos(depth, i.posP.xy/i.posP.w);
		float3 offset = posW-worldOffset;
		offset.y = 0;
		float r = sqrt(dot(offset, offset));
		float subradius = 50.0;

		if(r >= effectRadius && r <= effectRadius+subradius){
			return finalColor*gOpacity;
		}
		
		clip(-1);
	}

	return float4(1.0, 0.0, 0.0, 1.0);

}




BlendState hybridAlphaBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = ZERO;
	DestBlendAlpha = INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

DepthStencilState energyShieldDS
{
  DepthEnable        = TRUE;
  DepthWriteMask     = ALL;
  DepthFunc          = NOT_EQUAL;

  StencilEnable = TRUE;
  StencilReadMask = STENCIL_COMPOSITION_COCKPIT;
  StencilWriteMask = 0;

  FrontFaceStencilFunc = NOT_EQUAL;
  FrontFaceStencilPass = KEEP;
  FrontFaceStencilFail = KEEP;
  BackFaceStencilFunc = NOT_EQUAL;
  BackFaceStencilPass = KEEP;
  BackFaceStencilFail = KEEP;
};

technique10 tech
{

	pass p0
	{
		SetVertexShader(CompileShader(vs_4_0, vsEnergyShield_line()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psEnergyShield_line()));
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(energyShieldDS, STENCIL_COMPOSITION_COCKPIT);
		SetRasterizerState(cullBack);
	}

}
