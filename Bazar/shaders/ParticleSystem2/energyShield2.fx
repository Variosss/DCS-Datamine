#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#define ATMOSPHERE_COLOR

#include "common/ambientCube.hlsl"
#include "common/shadingCommon.hlsl"
#include "common/random.hlsl"
#include "deferred/shading.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"

Texture2D   GBufferComposed;


float4 params0;
float3 gOrigin2;
float4x4 gWorld;

uint params1;


struct VS_OUTPUT
{
	float4 pos: SV_POSITION0;
	float3 posW: POSITION0;
	float3 normalW: POSITION1;
	float4 posP: POSITION3;
	float2 uv: TEXCOORD0;
};

struct PS_OUTPUT {
	float4 colorAdd : SV_TARGET0;
	float4 colorMul : SV_TARGET1;
};


#define gMulPos params0.x
#define gMulNeg params0.y
#define gGBufferWidth params1.x
#define gGBufferHeight params1.y

VS_OUTPUT vs(float3 posL: POSITION0, float3 normalL: POSITION1, float2 uv: TEXCOORD0)
{
	VS_OUTPUT o;

	
	float3 p = posL;



	if(p.z > 0.0){
		p.xy *= gMulPos;
	}
	else{
		p.xy *= gMulNeg;
	}	

	o.posW = mul_v3xm44(p, gWorld)-gOrigin2;

	o.pos =  o.posP = mul_v3xm44(o.posW, gViewProj);
	o.normalW = mul(normalL, (float3x3)gWorld);
	o.uv = uv;

	return o;
}

PS_OUTPUT ps(VS_OUTPUT i)
{
	
	float3 reflectance;
	float3 refraction;
	
	float3 normalW = normalize(i.normalW);
	float3 viewW = normalize(-(i.posW-gCameraPos));
	
	float nov = dot(normalW, viewW);
	if(nov < 0.0){
		nov *= -1;
		normalW *= -1;
	}


	float fresnel = Fresnel_schlick(0.02, nov);	

	float3 atmosphereMul, atmosphereAdd;
	getPrecomputedAtmosphere(0, atmosphereMul, atmosphereAdd);
	
	atmosphereMul = 1.0;
	atmosphereAdd = 0.0;

	PS_OUTPUT o;
	float3 importLightDirV = reflect(-viewW, normalW);

	float3 ref = SampleEnvironmentMapDetailed(importLightDirV, 3);
	reflectance = (fresnel*ref*1.0+0.1)*float3(0.75, 1.0, 0.55);
	refraction = (1.0-fresnel)*float3(1.0, 1.0, 1.0)*1.15;

	// | 4 2 1 | 1.0/7 |  1.0/4.0 + 1.0/2.0 + 1.0 0.25  0.5 1.0 0.14 

	//refraction = 0;

	float3 refractionAtmosphere = refraction*atmosphereMul;
	o.colorAdd = float4(reflectance*atmosphereMul+atmosphereAdd*(float3(1.0, 1.0, 1.0)-refractionAtmosphere), 1.0);
	o.colorMul = float4(refractionAtmosphere, 1.0);

	//o.colorAdd.xyz += refractionAtmosphere*GBufferComposed.SampleLevel(gPointClampSampler, float2(i.posP.x, -i.posP.y) / i.posP.w*0.5 + 0.5, 0);
	//o.colorMul = 0;
	//o.colorAdd = 1;
	return o;



	//return float4(i.uv.x, i.uv.y, 0, 1.0);
}


BlendState enableGlassAlphaBlend
{
	BlendEnable[0] = TRUE;

	SrcBlend = ONE;
	DestBlend = SRC1_COLOR;
	BlendOp = ADD;

	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;


	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

technique10 tech
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps()));
		SetBlendState(enableGlassAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullBack);
		SetRasterizerState(cullFront);
		SetRasterizerState(cullNone);
	}
}
