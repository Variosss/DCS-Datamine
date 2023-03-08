#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "common/softParticles.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"

float4		params;
float4		surfaceNormal;

#define time		params.x
#define waveSpeed	params.y
#define lifetime	params.z
#define radiusMin	params.w
#define opacityMax	surfaceNormal.w

/*
static const float3 boxVert[] =
{
	//top quad
	{-0.5, -0.5, -0.5},
	{-0.5, -0.5,  0.5},
	{ 0.5, -0.5, -0.5},
	{ 0.5, -0.5,  0.5},
	//bottom quad
	{-0.5,  0.5, -0.5},
	{-0.5,  0.5,  0.5},
	{ 0.5,  0.5,  0.5},
	{ 0.5,  0.5, -0.5},	
};

static const uint boxIndex[14] = {3, 2, 6, 7, 4, 2, 0, 3, 1, 6, 5, 4, 1, 0};
*/

static const float radiusScale = 1.1;

struct VS_BLASTWAVE_OUTPUT
{
	float4 pos:		SV_POSITION0;
	float3 params:	TEXCOORD0;
	nointerpolation float3 color: TEXCOORD1;
};

struct VS_BLASTWAVE_OUTPUT2
{
	float4 pos:		POSITION0;
	float2 params:	TEXCOORD0;
};

struct DS_BLASTWAVE_OUTPUT
{
	float4 pos:		SV_POSITION0;
	float  params:	TEXCOORD0;
	float4 projPos: TEXCOORD1;
	float4 vPos:	TEXCOORD2;
	float3 norm:	NORMAL0;
};

float CalcBlastWaveRadius(out float opacity, in float opacityFactor = 1.5)
{
	float age = max(0, time);
	float nAgeInv = 1 - min(1, age / lifetime );
	opacity = pow(min(1, opacityFactor * nAgeInv * nAgeInv), 1.5);

	return age < lifetime ? (radiusMin + waveSpeed*age) : 0;
}

//depth test in View coord sys
void depthTest(in float2 projPos, in float vPosZ)
{
	float depth = g_DepthTexture.SampleLevel(gPointClampSampler, float2(projPos.x, -projPos.y)*0.5 + 0.5, 0).r;

	float4 vDepth = mul(float4(projPos, depth, 1), gProjInv);
	if(vDepth.z/vDepth.w - vPosZ < 0)
		discard;
}

float getHeightOffset()
{
	return 0;//задается в конфиге через сдвиг эмиттера
}


VS_BLASTWAVE_OUTPUT vsBlastWave(uint vertId: SV_VertexId, uniform bool bScreenSpace = false)
{
	float opacity;
	float radius = CalcBlastWaveRadius(opacity) * radiusScale;
	float3x3 world = basis(surfaceNormal);

	VS_BLASTWAVE_OUTPUT o;
	o.pos = float4(staticVertexData[vertId].x*radius, getHeightOffset(), staticVertexData[vertId].y*radius, 1);
	o.pos.xyz = mul(o.pos.xyz, world) + worldOffset.xyz;
	float NoV = abs(dot(surfaceNormal, normalize(gCameraPos - o.pos.xyz)));
	o.pos = mul(o.pos, gViewProj);
	o.params.xy = staticVertexData[vertId].zw;//uv
	o.params.z = opacity * opacityMax * NoV;
	o.color = AmbientTop*gIBLIntensity + (gSunDiffuse.rgb*gSunIntensity*gEffectsSunFactor) / PI;
	return o;
}

VS_BLASTWAVE_OUTPUT2 vsBlastWaveSphere(uint vertId: SV_VertexId, uniform bool bScreenSpace = false)
{
	float opacity;
	float radius = CalcBlastWaveRadius(opacity, 2.2);
	
	VS_BLASTWAVE_OUTPUT2 o;
	o.pos = staticVertexData[vertId];
	o.params.x = radius;
	o.params.y = opacity * opacityMax;
	return o;
}

struct HS_CONST_OUTPUT
{
	float edges[4] : SV_TessFactor;
	float inside[2]: SV_InsideTessFactor;
};

HS_CONST_OUTPUT hsConstant( InputPatch<VS_BLASTWAVE_OUTPUT2, 4> ip, uint pid : SV_PrimitiveID )
{
	float radius = ip[0].params.x;
	float dist = length(worldOffset.xyz + float3(0,getHeightOffset(),0) - gCameraPos.xyz);
	float lod = 1 - min( 1, dist/(2.5*radius) );
	float edge = 8 + lod * 24;
	float insideFactor = edge;

	HS_CONST_OUTPUT o;
	o.edges[0] = edge;
	o.edges[1] = edge; 
	o.edges[2] = edge;
	o.edges[3] = edge;
	o.inside[0] = insideFactor;
	o.inside[1] = insideFactor;
	return o;
}

[domain("quad")]
[partitioning("integer")]
[outputtopology("triangle_cw")]
[outputcontrolpoints(4)]
[patchconstantfunc("hsConstant")]
VS_BLASTWAVE_OUTPUT2 hsBlastWaveSphere( InputPatch<VS_BLASTWAVE_OUTPUT2, 4> ip, uint cpid : SV_OutputControlPointID)
{
	VS_BLASTWAVE_OUTPUT2 o = ip[cpid];
	return o;
}

[domain("quad")]
DS_BLASTWAVE_OUTPUT dsBlastWaveSphere( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, OutputPatch<VS_BLASTWAVE_OUTPUT2, 4> patch )
{
	float radius	= patch[0].params.x; //radius
	float opacity	= patch[0].params.y;//opacity
	float3 heightOffset = float3(0, getHeightOffset(), 0);//чтобы совсем жестоко не файтился с землей
	float3 viewDir = normalize((worldOffset.xyz + heightOffset) - gCameraPos);
	
	float4 pos = lerp(
						lerp(patch[0].pos, patch[1].pos, UV.x),
						lerp(patch[2].pos, patch[3].pos, UV.x),
						UV.y
					);

	float len = max(abs(pos.x), abs(pos.y));//к какой длине нормализуем
	pos.xy *= (len>0.001) ? len / length(pos.xy) : 1;
	
	float height = sqrt(0.252 - pos.x*pos.x - pos.y*pos.y);

	float3 Z = normalize(cross(viewDir, float3(0,1,0)));
	float3 X = cross(viewDir, Z);
	float3x3 M = {X, viewDir, Z};

	DS_BLASTWAVE_OUTPUT o;
	o.pos.xyz = mul(float3(pos.x, -height, pos.y)*radius, M);
	o.norm = -mul(o.pos.xyz, (float3x3)gView);

	o.pos.xyz += worldOffset.xyz + heightOffset;
	o.pos.w = 1;
	o.pos = mul(o.pos, gViewProj);
	o.projPos.xyz = o.pos.xyw;
	o.projPos.w = radius;
	o.params = opacity;
	o.vPos = mul(o.pos, gProjInv);
	return o;
}

float4 psBlastWaveSphere(in DS_BLASTWAVE_OUTPUT i): SV_TARGET0
{
	i.vPos /= i.vPos.w;
	depthTest(i.projPos.xy/i.projPos.z, i.vPos.z);
	float opacity = 1 - max(0, dot(normalize(i.norm), normalize(i.vPos.xyz)));
	return float4(1,1,1, opacity * i.params);
}

float4 psBlastWave(in VS_BLASTWAVE_OUTPUT i): SV_TARGET0
{
	return float4(i.color, i.params.z * tex.Sample(ClampLinearSampler, i.params.xy).a);
}

technique10 tech
{
	pass blastWaveGround
	{
		SetVertexShader(CompileShader(vs_4_0, vsBlastWave()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBlastWave()));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	pass blastWaveScreenSpace
	{
		SetVertexShader(CompileShader(vs_4_0, vsBlastWaveSphere(true)));
		SetHullShader(CompileShader(hs_5_0, hsBlastWaveSphere()));
		SetDomainShader(CompileShader(ds_5_0, dsBlastWaveSphere()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBlastWaveSphere()));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullBack);
	}
}
