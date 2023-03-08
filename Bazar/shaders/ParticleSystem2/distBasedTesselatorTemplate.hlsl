#include "ParticleSystem2/common/splines.hlsl"

/*

#define ENABLE_INTERSEGMENT_SORTING true/false 

Specifications:

float4 gParams0;

#define gSegmentLength    gParams0.x // max length of a segment
#define gSegmentLengthInv gParams0.y; // inv max length of a segment
#define gLODMax			 gParams1.z; // max size of lod.

struct VS_INPUT
{
//Custom Fields:
}

struct VS_OUTPUT
{
//Required Fields:
	float3 PosL : POSITION0;
	uint  bIsFirstSegment: POSITION1;
	float3 tangentV: POSITION2;
//Custom Fields:
}


struct DS_OUTPUT
{
//Required Fields:
	float4 PosL	  : POSITION0;
//Optional Fields:

#ifdef DEBUG_OUTPUT
	float4 debug  : TEXCOORD8;
#endif

//Custom Fields:
};

struct HS_PATCH_OUTPUT
{
//Required Fields:
	float edges[2]		: SV_TessFactor;
	float3 pos1L		: POSITION0;
	float3 pos2L		: POSITION1;
	float  lodParam     : POSITION2;
	uint  vertexFrequencies: POSITION3;
	float offset 		: POSITION4;
//Optional Fields:
#if ENABLE_INTERSEGMENT_SORTING
	float order			: POSITION5;
#endif
};

struct PS_INPUT
{
//Required Fields:
	float4 pos: SV_POSITION0;
//Custom Fields:
	float4 projPos: TEXCOORD1;
	float2 uv: TEXCOORD2;
	float3 sunDirM: TEXCOORD3;
	float opacity: TEXCOORD4;
};

//Required definitions of functions:

// lod: 2,4,4.5....8
float getLOD(VS_OUTPUT v0, VS_OUTPUT v1)
{	
	// to do: implement it!
	float lod;
	return lod;
}

float getUniqueID(VS_OUTPUT v)
{
	// to do: implement it!
	float uniqueID;
	return uniqueID;
}

DS_OUTPUT processSubVertex(DS_OUTPUT o, VS_OUTPUT v0, VS_OUTPUT v1, float t, float unbiasedLocalID)
{

	return o;
}

VS_OUTPUT VS(VS_INPUT v)
{
	// to do: implement it
	VS_OUTPUT o;
	return o;
}

float3 getCameraPosL()
{

}

*/



HS_PATCH_OUTPUT HSConst(InputPatch<VS_OUTPUT, 2> i)
{
	HS_PATCH_OUTPUT o;
	#define i0 i[0]
	#define i3 i[1]

	float len = distance(i0.pos.xyz, i3.pos.xyz);
	float lod = getLOD(i0, i3);

	float particlesPerSegment = round(exp2(floor(lod)));//2,4,8...
	// reduced the amount of particles if the distance between particles is not the max
	particlesPerSegment = clamp(particlesPerSegment * min(1, len*gSegmentLengthInv), 2.0, 64.0);
	particlesPerSegment = round(particlesPerSegment);

	float numSegments = particlesPerSegment-1;
	o.edges[0] = 1;
	o.edges[1] = numSegments; 
	
	uint maxParticlesInSegment = exp2(gLODMax);
	o.lodParam = 1 - frac(lod);
	o.vertexFrequencies = maxParticlesInSegment/particlesPerSegment;

	//tangents
	const float coef = -0.33 * len;
	o.pos1.xyz = i0.pos - i0.tangent*coef;
	o.pos2.xyz = i3.pos + i3.tangent*coef;

#if ENABLE_INTERSEGMENT_SORTING
	float3 cameraPos = getCameraPosInParticleCS();
	o.order = step(length(i0.pos-cameraPos),length(i3.pos-cameraPos));
#endif
	// fixing coeficient for computing corrected offset between particles
	o.offset = numSegments/particlesPerSegment;

	if(i0.bIsFirstSegment == 1)
	{
		float distBetweenParticles =  gSegmentLength/numSegments;	
		o.offset *= particlesPerSegment * distBetweenParticles / max(distBetweenParticles, len);
	}

	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(2)]
[patchconstantfunc("HSConst")]
VS_OUTPUT HS(InputPatch<VS_OUTPUT, 2> i, uint id : SV_OutputControlPointID)
{
	VS_OUTPUT o;
	o = i[id];
	return o;
}

[domain("isoline")]
DS_OUTPUT DS(HS_PATCH_OUTPUT i, OutputPatch<VS_OUTPUT, 2> ip, float2 uv : SV_DomainLocation)
{
	VS_OUTPUT v0 = ip[0];
	VS_OUTPUT v3 = ip[1];

	float3 i0Pos = v0.pos;
	float3 i1Pos = i.pos1;
	float3 i2Pos = i.pos2;
	float3 i3Pos = v3.pos;

	DS_OUTPUT o;

#if ENABLE_INTERSEGMENT_SORTING
	uv *= i.offset;

	float t = lerp(uv.x, 1.0 - uv.x, i.order);
#else
	float t = uv.x;
#endif

	float localID = round(t*i.edges[1]); //id тесселированной вершины
	t *= i.offset;

	float unbiasedLocalID = round(localID * i.vertexFrequencies);
	o.pos = BezierCurve3(t, i0Pos , i1Pos, i2Pos, i3Pos);
	o = processSubVertex(o, v0, v3,t, unbiasedLocalID);
	return o;
}
