
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#define FOG_ENABLE
#include "common/fog2.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "common/AmbientCube.hlsl"	
#include "common/easing.hlsl"
#include "common/random.hlsl"
#include "common/motion.hlsl"
#include "common/basis.hlsl"
#include "common/softParticles.hlsl"

#define ENABLE_INTERSEGMENT_SORTING false

// Required const data:
float4 gParams0;
// max length of a segment
#define gSegmentLength    gParams0.x
// inv max length of a segment
#define gSegmentLengthInv gParams0.y
// max size of lod.
#define gLODMax			 gParams0.z 

// Custom data:
float4 gParams1;
float4 gParams2;
float4 gParams3;

#define gScale gParams1.xy
#define gLifetime gParams1.z
#define gTime gParams1.w
#define gLocalOffset gParams3.xyz

 // start distance from the camera at which lod becomes worse
#define gLODChangeMinDist gParams2.x
 // start distance from the camera at which lod becomes better
#define gLODChangeMaxDist gParams2.y

struct VS_INPUT
{
//Custom Fields:
	float birthTime: POSITION0;
	float  lifetime:  POSITION1;

	float3 posL: POSITION2;
	float3 xBasisL: POSITION3;
	float3 zBasisL: POSITION4;
};

struct VS_OUTPUT
{
//Required Fields:
	float3 pos : POSITION0;
	uint  bIsFirstSegment: POSITION1;
	float3 tangent: POSITION2;
//Custom Fields:
	float3 zBasisL: POSITION3;
	float opacity: TEXCOORD0;
};

struct DS_OUTPUT
{
//Required Fields:
	float3 pos	  : POSITION0;
//Custom Fields:
	float3 xBasisL: POSITION1;
	float3 zBasisL: POSITION2;
	float  opacity:  POSITION3;
};

struct HS_PATCH_OUTPUT
{
//Required Fields:
	float edges[2]		: SV_TessFactor;
	float3 pos1		: POSITION0;
	float3 pos2		: POSITION1;
	float  lodParam     : POSITION2;
	uint  vertexFrequencies: POSITION3;
	float offset 		: POSITION4;
//Optional Fields:
#if ENABLE_INTERSEGMENT_SORTING
	float order			: POSITION5;
#endif
//Custom Fields:
};

struct PS_INPUT
{
//Required Fields:
	float4 pos: SV_POSITION0;
//Custom Fields:
	float2 uv: TEXCOORD0;
	float opacity: TEXCOORD1;
};

//Required definitions of functions:
float3 getCameraPosInParticleCS()
{
	float3 cameraPosW = -gViewInv._41_42_43;
	float3 cameraPosL = cameraPosW-gLocalOffset+gOrigin;
	return cameraPosL;
}

// lod: 2,4,4.5....8
float getLOD(VS_OUTPUT v0, VS_OUTPUT v1)
{	
	float3 cameraPos = getCameraPosInParticleCS();
	float distCamera = length(v0.pos-cameraPos);
	distCamera = min(distCamera, 600);
	//distCamera = min(distCamera, gLODChangeMaxDist);

	// nearFactor == 0.0 if it's far, 1.0 if it's near
	//float nearFactor = 1.0-(distCamera-gLODChangeMinDist)/(gLODChangeMaxDist-gLODChangeMinDist);
	//float lod = 1 + (gLODMax-1)*nearFactor;

	float nearFactor = 1.0-(distCamera-0.0)/(600-0.0);
	float lod = 1 + (4-1)*nearFactor;
	return lod;
}

DS_OUTPUT processSubVertex(DS_OUTPUT o, VS_OUTPUT v0, VS_OUTPUT v1, float t, float unbiasedLocalID)
{
	o.zBasisL = lerp(v0.tangent, v1.tangent, t);
	o.zBasisL = normalize(o.zBasisL);
	
	o.xBasisL = lerp(v0.zBasisL, v1.zBasisL, t);
	o.xBasisL = normalize(o.xBasisL);
	o.opacity = lerp(v0.opacity, v1.opacity, t);

	// LocalSpace -> WorldSpace
	o.pos -= gOrigin-gLocalOffset;
	return o;
}

VS_OUTPUT VS(VS_INPUT i)
{
	VS_OUTPUT o;
	o.tangent = i.zBasisL;
	o.zBasisL = i.xBasisL;
	o.pos = i.posL;
	o.bIsFirstSegment = false;

	float age =  gTime-i.birthTime;
	float reciprocalTime = gLifetime-age;

	float barrier = 2.0;
	float s = step(reciprocalTime, barrier);

	// linear reduction of opacity after the barrier gTime
	o.opacity = 1.0 - s*(1.0-reciprocalTime/barrier);

	return o;
}

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point DS_OUTPUT i[1], inout TriangleStream<PS_INPUT> outputStream)
{	
	PS_INPUT o;

	o.opacity = i[0].opacity;

	float4x4 worldViewProj = {
		i[0].xBasisL.x, 0, i[0].zBasisL.x, 0,
		i[0].xBasisL.y, 0, i[0].zBasisL.y, 0,
		i[0].xBasisL.z, 0, i[0].zBasisL.z, 0,
		i[0].pos.x, i[0].pos.y, i[0].pos.z, 1
	};
	worldViewProj = mul(worldViewProj, gViewProj);

	static const float4 staticVertexData2[4] = {
		float4( -0.5,  0.5, 0, 1),
		float4( 0.5,  0.5, 1, 1),
		float4( -0.5, -0.5, 0, 0),
		float4( 0.5, -0.5, 1, 0)
	};

	[unroll]
	for (int j = 0; j < 4; j++)
	{
		float3 vPos = {staticVertexData2[j].x*gScale.x, 0, staticVertexData2[j].y*gScale.y};
		
		o.pos = mul_v3xm44(vPos, worldViewProj);
		o.uv = staticVertexData2[j].zw;
		outputStream.Append(o);
		}
	outputStream.RestartStrip();
}

float4 PS(PS_INPUT i) : SV_TARGET0
{
	return float4(1.0, 0.0, 0.0, 1.0);
	float4 finalClr = tex.SampleBias(gAnisotropicClampSampler, i.uv, 0.15);
	finalClr.a *= i.opacity;

	float NoL = satDotNormalized(float3(0.0, 0.0, -1.0), gSunDirV, 0.5);
	finalClr.rgb = shading_AmbientSun_Atmosphere(finalClr.rgb, AmbientTop, NoL/PI, 0);
	return finalClr;
}
#include "distBasedTesselatorTemplate.hlsl"

technique10 tech
{
	//в полете
	pass P0{
		SetGeometryShader(CompileShader(gs_5_0, GS()));
		SetHullShader(CompileShader(hs_5_0, HS()));
		SetDomainShader(CompileShader(ds_5_0, DS()));
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, PS()));
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}
}

