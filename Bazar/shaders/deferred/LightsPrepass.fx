
#define LIGHTS_PREPASS
#define USE_TEST 0

#include "common/context.hlsl"
#include "common/lightsData.hlsl"
#include "deferred/DecoderCommon.hlsl"

Buffer<uint> lightCount;

TEXTURE_2D(float, Depth);
uint4 viewport;

shared RWStructuredBuffer<uint> OffsetSync;

// These defines must correlate with LightsPrepass.cpp
#define TILE_GROUP_DIM 8
#define TILE_GROUP_SIZE (TILE_GROUP_DIM * TILE_GROUP_DIM)
#define MAX_LIGHTS 512		// per tile
#define TILE_CHUNK_SIZE 12
#define TILE_CHUNK_LIGHTS_COUNT 8192
#define TILE_CHUNK_CLEAR_GROUPSIZE 8
#define LIGHTS_TO_CHUNKS_GROUPSIZE 64

uint2 TilesCount;
uint2 TileChunksCount;

Buffer<uint>   TileChunksOmniCountsR;
RWBuffer<uint> TileChunksOmniCountsW;
Buffer<uint>   TileChunksOmniIdsR;
RWBuffer<uint> TileChunksOmniIdsW;

Buffer<uint>   TileChunksSpotCountsR;
RWBuffer<uint> TileChunksSpotCountsW;
Buffer<uint>   TileChunksSpotIdsR;
RWBuffer<uint> TileChunksSpotIdsW;

// Clear tile chunks
[numthreads(TILE_CHUNK_CLEAR_GROUPSIZE, TILE_CHUNK_CLEAR_GROUPSIZE, 1)]
void CS_ResetTileChunks(uint3 dispatchThreadId: SV_DispatchThreadID)
{
	if (dispatchThreadId.x >= TileChunksCount.x || dispatchThreadId.y >= TileChunksCount.y)
		return;

	TileChunksOmniCountsW[dispatchThreadId.y * TileChunksCount.x + dispatchThreadId.x] = 0;
	TileChunksSpotCountsW[dispatchThreadId.y * TileChunksCount.x + dispatchThreadId.x] = 0;
}

// Fill tile chunks with light indices
[numthreads(LIGHTS_TO_CHUNKS_GROUPSIZE, 1, 1)]
void CS_FillTileChunks(uint3 dispatchThreadId: SV_DispatchThreadID)
{
	// Get light to camera relationships
	uint lightIndex = dispatchThreadId.x;
	uint omnisCount = lightCount[0];
	uint spotsCount = lightCount[1];

	uint isOmniLight = lightIndex < omnisCount;
	uint isSpotLight = lightIndex < omnisCount + spotsCount;
	float4 lightPos;
	if (lightIndex < omnisCount)
	{
		lightPos = omnis[lightIndex].pos;
	}
	else if (lightIndex < omnisCount + spotsCount)
	{
		lightIndex -= omnisCount;
		lightPos = spots[lightIndex].pos;
	}
	else
	{
		return;
	}

	float3 cameraDir = float3(gView[0][2], gView[1][2], gView[2][2]);
	float dist = lightPos.w;
	float distToCamera = length(gCameraPos - lightPos.xyz);
	float3 lightToCamera = gCameraPos.xyz - lightPos.xyz;
	int4 rect = uint4(1, 1, 0, 0); // Invalid rect

	// If light is very close, mark all tiles
	// If light is further away and is behind camera - ignore
	// If light is further away and is in front of camera - calculate rect

	float4 center = float4(lightPos.xyz, 1.0f);
	center = mul(center, gView);
	center.xyz /= center.w;

	float x = center.x;
	float y = center.y;
	float z = center.z;
	float r = dist;

	//if (distToCamera <= dist) // Checking sphere dist in two 2d cases that we have inside is not enough
	// Last two are square root args, must be greater that zero to go into second branch. We cull against 2 3d cylinders as it seems (Wat??)
	if (distToCamera <= dist || x*x + z*z <= r*r || y*y + z*z <= r*r) 
	//if (abs(lightToCamera.z) <= dist) // Solves the same problem as checking kx, ky sign does, but results in extra tile chunks involved
	{
		// Mark all tiles
		rect = uint4(0, 0, TilesCount[0] - 1, TilesCount[1] - 1);
		rect /= TILE_CHUNK_SIZE;
	}
	else if(distToCamera > dist && dot(cameraDir, -lightToCamera) > 0 )
	//else if (abs(lightToCamera.z) > dist && dot(cameraDir, -lightToCamera) > 0)
	{
		// Calculate 2 tangents to light circle, intersect those tangents with line (z = center.z) - those are tiles affected
		
		// System of equations:
		//		x - kz = 0							// kz = x
		//		(c.x + kc.z) / sqrt(1 + k^2) = r	// distance from line above to circle center == r
		// Find k both for (left to right) and (up to down) planes of frustum:
		float xRoot = sqrt( x*x + z*z - r*r );
		float xDiv = r*r - z*z;
		float kx1 = (-z*x + r*xRoot) / xDiv;
		float kx2 = (-z*x - r*xRoot) / xDiv;

		float yRoot = sqrt( y*y + z*z - r*r );
		float yDiv = r*r - z*z;
		float ky1 = (-z*y + r*yRoot) / yDiv;
		float ky2 = (-z*y - r*yRoot) / yDiv;

		// kz = x; kz = y;	where z = center.z; Find x, y ranges
		float x1 = kx1 * z;
		float x2 = kx2 * z;

		// We may go wrong direction when the sphere center is in front of camera but the tangent point is behind
		if (x >= 0 && kx2 <= 0) x2 = x + r;
		if (x <= 0 && kx1 >= 0) x1 = x - r;

		float2 xRange = float2(min(x1, x2), max(x1, x2));

		float y1 = ky1 * z;
		float y2 = ky2 * z;

		// We may go wrong direction when the sphere center is in front of camera but the tangent point is behind
		if (y >= 0 && ky2 <= 0) y2 = y + r;
		if (y <= 0 && ky1 >= 0) y1 = y - r;

		float2 yRange = float2(min(y1, y2), max(y1, y2));

		// Fill points
		float4 points[4] = {
			float4(xRange.y, center.y, center.z, 1),
			float4(xRange.x, center.y, center.z, 1),
			float4(center.x, yRange.y, center.z, 1),
			float4(center.x, yRange.x, center.z, 1)
		};
		

		// Convert to normalized screen coordinates
		[unroll]
		for (int i = 0; i < 4; i++)
		{
			points[i] = mul(points[i], gProj);
			points[i] /= points[i].w;
			points[i].xy /= 2.0;
			points[i].xy += 0.5;
			//points[i] = saturate(points[i]);
		}

		// Convert to tiles rect
		rect.x = points[1].x         * TilesCount[0];
		rect.y = (1.0 - points[2].y) * TilesCount[1];
		rect.z = points[0].x         * TilesCount[0] + 1;
		rect.w = (1.0 - points[3].y) * TilesCount[1] + 1;

		rect.x = max(rect.x, 0);
		rect.y = max(rect.y, 0);
		rect.z = min(rect.z, TilesCount[0] - 1);
		rect.w = min(rect.w, TilesCount[1] - 1);

		// Convert to chunk id
		rect /= TILE_CHUNK_SIZE;
	}

	// Mark light to each chunk it lits
	for (uint x = rect.x; x <= rect.z; x++)
	{
		for (uint y = rect.y; y <= rect.w; y++)
		{
			uint tileChunkIndex = y * TileChunksCount[0] + x;
			if (isOmniLight)
			{
				uint tileLightId;
				InterlockedAdd(TileChunksOmniCountsW[tileChunkIndex], 1, tileLightId);
				if (tileLightId < TILE_CHUNK_LIGHTS_COUNT)
					TileChunksOmniIdsW[TILE_CHUNK_LIGHTS_COUNT * tileChunkIndex + tileLightId] = lightIndex;
			}
			else if (isSpotLight)
			{
				uint tileLightId;
				InterlockedAdd(TileChunksSpotCountsW[tileChunkIndex], 1, tileLightId);
				if (tileLightId < TILE_CHUNK_LIGHTS_COUNT)
					TileChunksSpotIdsW[TILE_CHUNK_LIGHTS_COUNT * tileChunkIndex + tileLightId] = lightIndex;
			}
		}
	}
}


groupshared uint sMinZ;
groupshared uint sMaxZ;

// Light lists for the tile
groupshared uint sOmniLightIdx[MAX_LIGHTS];
groupshared uint sOmniCount;
groupshared uint sSpotLightIdx[MAX_LIGHTS];
groupshared uint sSpotCount;

groupshared uint sOmniLightIdxTransp[MAX_LIGHTS];
groupshared uint sOmniCountTransp;
groupshared uint sSpotLightIdxTransp[MAX_LIGHTS];
groupshared uint sSpotCountTransp;

groupshared uint sOffsetIdx;

groupshared uint sShadowmapUsed[MAX_SHADOWMAP_COUNT];
groupshared uint sShadowmapUsedTransp[MAX_SHADOWMAP_COUNT];

bool cutCone(float3 n, float3 vp, float3 vd, float radius, float tana) {	// spherical cone - plane intersection 
	float d0 = dot(vp, n);
	float d1 = dot(vp + (vd - normalize(cross(vd, cross(vd, n))) * tana) * radius, n);
	return d0 + radius > 0 && (d0 > 0 || d1 > 0);
}

[numthreads(TILE_GROUP_DIM, TILE_GROUP_DIM, 1)]
void CS_Main(uint3 groupId: SV_GroupID, uint3 dispatchThreadId : SV_DispatchThreadID, uint3 groupThreadId : SV_GroupThreadID, uint groupIndex : SV_GroupIndex, uniform bool useDepth)
{
	int tileId = groupId.y * TilesCount[0] + groupId.x;
	int tileChunkId = (groupId.y / TILE_CHUNK_SIZE) * TileChunksCount[0] + (groupId.x / TILE_CHUNK_SIZE);

	uint2 globalCoords = dispatchThreadId.xy;
	bool validCoords = globalCoords.x < viewport.z && globalCoords.y < viewport.w;
	float2 projPosXY = ((float2(globalCoords) + float2(0.5, 0.5)) / float2(viewport.zw) - 0.5) * float2(2, -2);

////////////// calc zMin, zMax /////////////////////////////////////
	float zMin = 0x7F7FFFFF, zMax = 0;

	if (useDepth) {

		[branch]
		if (validCoords) {
			uint2 idx = globalCoords + viewport.xy;
			//	get zMin, zMax of first sample
			float depth = SampleMap(Depth, idx, 0).r;
			float4 p = mul(float4(projPosXY, depth, 1), gProjInv);
			zMin = zMax = p.z / p.w;

#ifdef MSAA
			[unroll(MSAA - 1)]
			for (uint i = 1; i < MSAA; ++i) {
				depth = SampleMap(Depth, idx, i).r;
				p = mul(float4(projPosXY, depth, 1), gProjInv);
				zMin = min(zMin, p.z / p.w);
				zMax = max(zMax, p.z / p.w);
			}
#endif
		}

	} else {

		float4 p = mul(float4(projPosXY, 0, 1), gProjInv);
		zMin = min(zMin, p.z / p.w);
		zMax = max(zMax, p.z / p.w);
		p = mul(float4(projPosXY, 1, 1), gProjInv);
		zMin = min(zMin, p.z / p.w);
		zMax = max(zMax, p.z / p.w);

	}

    // Initialize shared memory 
    if (groupIndex == 0) {
		sMinZ = 0x7F7FFFFF;      // Max float
		sMaxZ = 0;
        sOmniCount = sSpotCount = sOmniCountTransp = sSpotCountTransp = 0;

		[unroll]
		for (uint i = 0; i < MAX_SHADOWMAP_COUNT; ++i) 
			sShadowmapUsed[i] = sShadowmapUsedTransp[i] = 0;
	}

	GroupMemoryBarrierWithGroupSync();

	[branch]
	if (validCoords) {
		InterlockedMin(sMinZ, asuint(zMin));
		InterlockedMax(sMaxZ, asuint(zMax));
	}
	

	GroupMemoryBarrierWithGroupSync();

	// We assume that every thread in group does 1/64 jf the whole work. 
	// Doing if check here will result in not all lights being calculated for screen resolutions which are not multiple of tile size (1600 x 900)
	if (1 || validCoords) {

		float zMinTile = asfloat(sMinZ);
		float zMaxTile = asfloat(sMaxZ);

		////////////// calc tile lights list ///////////////////////////////////

		float3 frustumPlanes[4];
#if 1	
		float2 p0 = ((groupId.xy       * TILE_GROUP_DIM + float2(0.5, 0.5)) / float2(viewport.zw) - 0.5) * float2(2, -2);
		float2 p1 = (((groupId.xy + 1) * TILE_GROUP_DIM + float2(0.5, 0.5)) / float2(viewport.zw) - 0.5) * float2(2, -2);

		float4 r0 = mul(float4(p0, 0, 1), gProjInv);	r0.xyz /= r0.w;
		float4 r1 = mul(float4(p1, 0, 1), gProjInv);	r1.xyz /= r1.w;

		frustumPlanes[0] = normalize(cross(r0.xyz, float3(-1, 0, 0)));
		frustumPlanes[1] = normalize(cross(r0.xyz, float3(0, -1, 0)));
		frustumPlanes[2] = normalize(cross(r1.xyz, float3(1, 0, 0)));
		frustumPlanes[3] = normalize(cross(r1.xyz, float3(0, 1, 0)));

#else			// this works wrong for HMD skew proj matrix
		float2 tileScale = float2(viewport.zw) / float(2 * TILE_GROUP_DIM);	
		float2 tileBias = tileScale - float2(groupId.xy);

		float3 c1 = float3(gProj._m00 * tileScale.x, 0.0f, tileBias.x) * 2.0;
		float3 c2 = float3(0.0f, -gProj._m11 * tileScale.y, tileBias.y) * 2.0;
		float3 c4 = float3(0.0f, 0.0f, 1.0f);

		frustumPlanes[0] = normalize(c4 - c1);
		frustumPlanes[1] = normalize(c4 + c1);
		frustumPlanes[2] = normalize(c4 - c2);
		frustumPlanes[3] = normalize(c4 + c2);
#endif
		
		// Omnis. Cull, fill groupshared array of all lights for current tile
		for (uint chunkLight = groupIndex; chunkLight < TileChunksOmniCountsR[tileChunkId]; chunkLight += TILE_GROUP_SIZE)
		{
			uint lightIndex = TileChunksOmniIdsR[TILE_CHUNK_LIGHTS_COUNT * tileChunkId + chunkLight];
#if USE_TEST
			uint listIndex;
			InterlockedAdd(sOmniCount, 1, listIndex);
			sOmniLightIdx[listIndex] = lightIndex;
#else
			float4 lightPos = omnis[lightIndex].pos;
			float4 vp = mul(float4(lightPos.xyz, 1), gView);
			vp.xyz /= vp.w;

			float dist = lightPos.w;
			bool inFrustumTransp = vp.z <= zMaxTile + dist;
			[unroll(4)]
			for (uint i = 0; i < 4; ++i) {
				float d = dot(frustumPlanes[i], vp.xyz);
				inFrustumTransp = inFrustumTransp && (d > -dist);
			}

			[branch]
			if (inFrustumTransp) {
				bool inFrustumSolid = inFrustumTransp && vp.z >= zMinTile - dist;

				[branch]
				if (inFrustumSolid) {
					if (sOmniCount < MAX_LIGHTS) {
						uint listIndex;
						InterlockedAdd(sOmniCount, 1, listIndex);
						sOmniLightIdx[listIndex] = lightIndex;
					}
				} else {
					if (sOmniCountTransp < MAX_LIGHTS) {
						uint listIndex;
						InterlockedAdd(sOmniCountTransp, 1, listIndex);
						sOmniLightIdxTransp[listIndex] = lightIndex;
					}
				}

			}
#endif
		}

		// Spots. Cull, fill groupshared array of all lights for current tile
		for (uint chunkLight = groupIndex; chunkLight < TileChunksSpotCountsR[tileChunkId]; chunkLight += TILE_GROUP_SIZE)
		{
			uint lightIndex = TileChunksSpotIdsR[TILE_CHUNK_LIGHTS_COUNT * tileChunkId + chunkLight];
#if USE_TEST
			uint listIndex;
			InterlockedAdd(sSpotCount, 1, listIndex);
			sSpotLightIdx[listIndex] = lightIndex;
#else
			float4 lightPos = spots[lightIndex].pos;
			float3 dir = spots[lightIndex].dir.xyz;
			float tana = spots[lightIndex].angles.z;

			float4 vp = mul(float4(lightPos.xyz, 1), gView);
			vp.xyz /= vp.w;
			float3 vd = mul(dir, (float3x3)gView);

			float dist = lightPos.w;

			bool inFrustumTransp = cutCone(float3(0, 0, -1), float3(vp.xy, vp.z - zMaxTile), vd, dist, tana);

			[unroll(4)]
			for (uint i = 0; i < 4; ++i)
				inFrustumTransp = inFrustumTransp && cutCone(frustumPlanes[i], vp.xyz, vd, dist, tana);

			[branch]
			if (inFrustumTransp) {

				bool inFrustumSolid = inFrustumTransp && cutCone(float3(0, 0, 1), float3(vp.xy, vp.z - zMinTile), vd, dist, tana);
				int shadowmapIdx = spots[lightIndex].shadowmapIdx;

				[branch]
				if (inFrustumSolid) {
					// Append light to list
					if (sSpotCount < MAX_LIGHTS) {
						uint listIndex;
						InterlockedAdd(sSpotCount, 1, listIndex);
						sSpotLightIdx[listIndex] = lightIndex;
						if (shadowmapIdx >= 0) {
							uint dummy;
							InterlockedMax(sShadowmapUsed[shadowmapIdx], 1, dummy);
						}
					}
				} else {
					if (sSpotCountTransp < MAX_LIGHTS) {
						uint listIndex;
						InterlockedAdd(sSpotCountTransp, 1, listIndex);
						sSpotLightIdxTransp[listIndex] = lightIndex;
						if (shadowmapIdx >= 0) {
							uint dummy;
							InterlockedMax(sShadowmapUsedTransp[shadowmapIdx], 1, dummy);
						}
					}
				}
			}
#endif
		}

	}

    GroupMemoryBarrierWithGroupSync();

	// Calculate new offset in LightsIdx buffer for current tile
	if (groupIndex == 0) {
#if USE_TEST
		sOffsetIdx = 0;
#else
		uint shadowmapCount = 0, shadowmapCountTransp = 0;
		[unroll]
		for (uint i = 0; i < MAX_SHADOWMAP_COUNT; ++i) {
			shadowmapCount += sShadowmapUsed[i];
			shadowmapCountTransp += sShadowmapUsedTransp[i];
		}

		InterlockedAdd(OffsetSync[0], sOmniCount + sOmniCountTransp + sSpotCount + sSpotCountTransp + shadowmapCount + shadowmapCountTransp, sOffsetIdx);
		uint offsetOmnis = sOffsetIdx;
		uint offsetSpots = sOffsetIdx + sOmniCount + sOmniCountTransp;
		uint offsetShadowmaps = offsetSpots + sSpotCount + sSpotCountTransp;
		LightsIdxOffsets[uint3(groupId.xy, 0)] = uint4(offsetOmnis, sOmniCount, offsetSpots, sSpotCount);
		LightsIdxOffsets[uint3(groupId.xy, 1)] = uint4(offsetOmnis, sOmniCount + sOmniCountTransp, offsetSpots, sSpotCount + sSpotCountTransp);
		LightsIdxOffsets[uint3(groupId.xy, 2)] = uint4(offsetShadowmaps, shadowmapCount, offsetShadowmaps, shadowmapCount + shadowmapCountTransp);

		[unroll]
		int shadowmapIdx = 0, shadowmapIdxTransp = 0;
		for (i = 0; i < MAX_SHADOWMAP_COUNT; ++i) {
			if (sShadowmapUsed[i]) {
				LightsIdx[offsetShadowmaps + shadowmapIdx] = i;
				shadowmapIdx++;
			}
			if (sShadowmapUsedTransp[i]) {
				LightsIdx[offsetShadowmaps + shadowmapCount + shadowmapIdxTransp] = i;
				shadowmapIdxTransp++;
			}
		}

#endif
//		LightsIdxOffsets[uint3(groupId.xy, 0)] = groupId.xxyy % 10; // test
	}
	GroupMemoryBarrierWithGroupSync();

	// We assume that every thread in group does 1/64 of the whole work. 
	// Rejecting pixel here will result in not all lights being calculated for screen resolutions which are not multiple of tile size (1600 x 900)
	[branch]
	if (0 && !validCoords)		// it must be after all GroupMemoryBarrierWithGroupSync()
		return;
	 
	// Move contents of calculated groupshared buffers for current tile into LightsIdx buffer
	uint offsetOmnis = sOffsetIdx;
	uint offsetSpots = sOffsetIdx + sOmniCount + sOmniCountTransp;
	uint i;
	for (i = groupIndex; i < sOmniCount; i += TILE_GROUP_SIZE)
		LightsIdx[offsetOmnis + i] = sOmniLightIdx[i];
#if !USE_TEST
	for (i = groupIndex; i < sOmniCountTransp; i += TILE_GROUP_SIZE)
		LightsIdx[offsetOmnis + sOmniCount + i] = sOmniLightIdxTransp[i];
#endif
	for (i = groupIndex; i < sSpotCount; i += TILE_GROUP_SIZE)
		LightsIdx[offsetSpots + i] = sSpotLightIdx[i];
#if !USE_TEST
	for (i = groupIndex; i < sSpotCountTransp; i += TILE_GROUP_SIZE)
		LightsIdx[offsetSpots + sSpotCount + i] = sSpotLightIdxTransp[i];
#endif
}

technique10 ResetTileChunks {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, CS_ResetTileChunks()));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}

technique10 FillTileChunks {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, CS_FillTileChunks()));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}

technique10 DepthBasedTech {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, CS_Main(true)));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}

technique10 SimpleTech {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, CS_Main(false)));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}

[numthreads(1, 1, 1)]
void CS_Reset(uint groupIndex: SV_GroupIndex) {
	GroupMemoryBarrierWithGroupSync();
	if (groupIndex == 0) 
		OffsetSync[0] = 0;
}

technique10 ResetTech {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, CS_Reset()));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}

