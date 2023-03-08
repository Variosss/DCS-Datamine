#include "common/samplers11.hlsl"
#include "common/context.hlsl"

#define BILINEAR_FILTERING

Texture2DArray indirectLightKnots;

struct Knot
{
	float4 walls[6];
};

struct KnotPacked
{
	uint4 walls[2];
};

StructuredBuffer<Knot>			sbIndirectLightKnots;//все ракурсы солнца для всех узлов
RWStructuredBuffer<Knot>		sbResolvedKnots;//резолвеные кубы для заданного положения солнца, либо результат сложения отскоков
RWStructuredBuffer<KnotPacked>	sbResolvedPackedKnots;//резолвеные кубы для заданного положения солнца, либо результат сложения отскоков

StructuredBuffer<Knot>			sbResolvedKnotsSource; //сумма предыдущих отскоков
StructuredBuffer<Knot>			sbResolvedKnotsBounce; //следующий отскок

float4x4 cockpitTransform;
float3	 sunDir;
uint3	 samplesXY;//z - knots count

float2	 sunSkyFactors;

// Returns ±1
float2 signNotZero(float2 v)
{
	return float2((v.x >= 0.0) ? +1.0 : -1.0, (v.y >= 0.0) ? +1.0 : -1.0);
}

// Assume normalized input. Output is on [-1, 1] for each component.
float2 float32x3_to_oct(in float3 v)
{
	// Project the sphere onto the octahedron, and then onto the xy plane
	float2 p = v.xy * (1.0 / (abs(v.x) + abs(v.y) + abs(v.z)));
	// Reflect the folds of the lower hemisphere over the diagonals
	return (v.z <= 0.0) ? ((1.0 - abs(p.yx)) * signNotZero(p)) : p;
}

float3 oct_to_float32x3(float2 e)
{
	float3 v = float3(e.xy, 1.0 - abs(e.x) - abs(e.y));
	if (v.z < 0) v.xy = (1.0 - abs(v.yx)) * signNotZero(v.xy);
	return normalize(v);
}

float3 unpackSunDir(float u, float v)
{
	float3 sunDir;
	sunDir.y = -1.0 + 2.0 * v;
	float azimuth = 2.0 * 3.1415 * u;
	float normFactor = sqrt(1.0 - sunDir.y*sunDir.y);
	sunDir.x = sin(azimuth)*normFactor;
	sunDir.z = cos(azimuth)*normFactor;
	return sunDir;
}

float2 packSunDir(in float3 sunDir)
{
	float azimuth = (abs(sunDir.x) < 1e-6 && abs(sunDir.z) < 1e-6) ? 0.0 : atan2(sunDir.x, sunDir.z);
	if(sunDir.x < 0)
		azimuth += 3.1415 * 2.0;
	float2 uv;
	uv.x = azimuth / 3.1415 / 2.0;
	uv.y = sunDir.y * 0.5 + 0.5;
	return uv;
}

uint2 packWall(float4 c)
{
	return f32tof16(c.rg) | (f32tof16(c.ba) << 16);
}

uint packWall2(float4 val)
{
	return (uint)min(255, (val[3]*255.0f)) << 24 |
           (uint)min(255, (val[2]*255.0f)) << 16 |
           (uint)min(255, (val[1]*255.0f)) << 8  |
           (uint)min(255, (val[0]*255.0f));
}


uint getCubeId(uint knotId, uint2 xy)
{
	return knotId * samplesXY.x * samplesXY.y + xy.y * samplesXY.x + xy.x;
}

float4 applySunSkyFactors(float4 knot)
{
	knot.rgb *= gSunIntensity * sunSkyFactors.x;
	knot.a = (sunSkyFactors.y + (1-sunSkyFactors.y) * knot.a) * gIBLIntensity;
	return knot;
}

float4 getKnotWall(uint knotId, uint wallId, float2 uv)
{
#ifdef BILINEAR_FILTERING
	float2 p = uv * (samplesXY.xy-1);
	uint2 k0 = p;
	uint2 k1 = ceil(p) + 0.5;
	k1.x = k1.x % samplesXY.x;
	k1.y = min(samplesXY.y-1, k1.y);
	float2 delta = frac(p);
	#define C(x,y) sbIndirectLightKnots[getCubeId(knotId, uint2(x,y))].walls[wallId]
	float4 c0 = lerp(C(k0.x, k0.y), C(k1.x, k0.y), delta.x);
	float4 c1 = lerp(C(k0.x, k1.y), C(k1.x, k1.y), delta.x);
	#undef C
	return lerp(c0, c1, delta.y);
#else
	uint2 xy = uv * (samplesXY.xy-1);
	return sbIndirectLightKnots[getCubeId(knotId, xy)].walls[wallId];
#endif
}

#define KNOTS_PER_CALL		16

groupshared float4 sharedWalls[KNOTS_PER_CALL][6];

[numthreads(6, KNOTS_PER_CALL, 1)]
void csResolveKnotsStructBuf2StructBuf(uint3 dId: SV_GroupThreadID, uint3 groupId: SV_GroupID, uniform bool bPacked = false)
{
	const uint knotLocalId = dId.y;
	const uint knotId = groupId.x*KNOTS_PER_CALL + knotLocalId;
	const uint wallId = dId.x;
	
	if(knotId>= samplesXY.z)
		return;
	
	float2 uv = packSunDir(mul(sunDir, (float3x3)cockpitTransform));
	sbResolvedKnots[knotId].walls[wallId] = applySunSkyFactors( getKnotWall(knotId, wallId, uv) );
}

[numthreads(6, KNOTS_PER_CALL, 1)]
void csResolveKnotsStructBuf2PackedStructBuf(uint3 dId: SV_GroupThreadID, uint3 groupId: SV_GroupID)
{
	const uint knotLocalId = dId.y;
	const uint knotId = groupId.x*KNOTS_PER_CALL + knotLocalId;
	const uint knotIdClamped = min(knotId, samplesXY.z-1);
	const uint wallId = dId.x;

	float2 uv = packSunDir(mul(sunDir, (float3x3)cockpitTransform));
	sharedWalls[knotLocalId][wallId] = applySunSkyFactors( getKnotWall(knotIdClamped, wallId, uv) );
	GroupMemoryBarrierWithGroupSync();
	
	if(knotId>= samplesXY.z)
		return;

	// if(wallId%2)
		// sbResolvedPackedKnots[knotId].walls[wallId/2] = uint4(packWall(sharedWalls[knotLocalId][wallId-1]), packWall(sharedWalls[knotLocalId][wallId]));
	if(wallId==0)
	{
		sbResolvedPackedKnots[knotId].walls[0] = uint4(
			packWall2(sharedWalls[knotLocalId][0]),
			packWall2(sharedWalls[knotLocalId][1]),
			packWall2(sharedWalls[knotLocalId][2]),
			packWall2(sharedWalls[knotLocalId][3])
		);
		// sbResolvedPackedKnots[knotId].walls[wallId/2] = packWall2(sharedWalls[knotLocalId][wallId-1]), packWall2(sharedWalls[knotLocalId][wallId]));
	}
	else if(wallId==1)
	{
		sbResolvedPackedKnots[knotId].walls[1] = uint4(packWall2(sharedWalls[knotLocalId][4]), packWall2(sharedWalls[knotLocalId][5]), 0, 0);
	}
}

[numthreads(6, 1, 1)]
void csResolveKnots(uint3 dId: SV_GroupThreadID, uint3 groupId: SV_GroupID, uniform bool bUseStructBuffer, uniform bool bPacked = false)
{
	const uint knotId = groupId.x;
	const uint wallId = dId.x;
	
	float2 uv = packSunDir(mul(sunDir, (float3x3)cockpitTransform));
	float sliceId = knotId * 6 + wallId;
	float4 wallColor = indirectLightKnots.SampleLevel(gBilinearWrapSampler, float3(uv, sliceId), 0).rbga;
	sbResolvedKnots[knotId].walls[wallId] = applySunSkyFactors(wallColor);	
}

[numthreads(6, 1, 1)]
void csApplySunSkyFactorsToResolvedSB(uint3 dId: SV_GroupThreadID, uint3 groupId: SV_GroupID)
{
	const uint knotId = groupId.x;
	const uint wallId = dId.x;
	
	float4 knot = sbResolvedKnotsSource[knotId].walls[wallId];
	sbResolvedKnots[knotId].walls[wallId] = applySunSkyFactors(knot);
}

[numthreads(6, 1, 1)]
void csAddBounceToResolvedKnot(uint3 dId: SV_GroupThreadID, uint3 groupId: SV_GroupID)
{
	const uint knotId = groupId.x;
	const uint wallId = dId.x;
	
	float4 sumBounces = sbResolvedKnotsSource[knotId].walls[wallId];
	float4 nextBounce = sbResolvedKnotsBounce[knotId].walls[wallId];

	sbResolvedKnots[knotId].walls[wallId] = sumBounces + nextBounce;
}

technique10 tech
{
	pass resolveKnots						{	SetComputeShader(CompileShader(cs_5_0, csResolveKnots(false)));						}
	pass resolveKnotsToStructBuffer			{	SetComputeShader(CompileShader(cs_5_0, csResolveKnotsStructBuf2StructBuf()));		}
	pass resolveKnotsToPackedStructBuffer	{	SetComputeShader(CompileShader(cs_5_0, csResolveKnotsStructBuf2PackedStructBuf()));	}
	pass addBounce							{	SetComputeShader(CompileShader(cs_5_0, csAddBounceToResolvedKnot()));				}
	pass applySunSkyFactors					{	SetComputeShader(CompileShader(cs_5_0, csApplySunSkyFactorsToResolvedSB()));		}
}
