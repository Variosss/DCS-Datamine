#ifndef COMMON_PARABOLOID_MAPPING_HLSL
#define COMMON_PARABOLOID_MAPPING_HLSL

// ------------------------------------
// Scaled *-Paraboloid Mappings
// ------------------------------------
// Based on: https://developer.nvidia.com/gpugems/gpugems3/part-iii-rendering/chapter-20-gpu-based-importance-sampling

// Note: without mipmaps generation 1.01 will be enough
static const float pmScale = 1.01f;
static const float invPmScale = 2.0f - pmScale;

float hemisphereSignFromIndex(uint index)
{
	return ((index == 0) ? 1.0 : -1.0);
}

// For Single-Paraboloid
// Hemisphere (with virtual index 0) covers +Z, over (with virtual index 1) covers -Z

float spmInvDistortion(float3 dir, float scale)
{
	float t = abs(dir.z) + 1.0;
	return 1.0 / (4.0 * scale * scale * t * t);
}

uint spmHemisphereIndexFromDir(float3 dir)
{
	return dir.z >= 0.0 ? 0 : 1;
}

float2 spmDirToUV(float3 dir, float scale)
{
	float denom = 1.0 / ((1.0 + abs(dir.z)) * scale);
	return denom * dir.xy * 0.5 + 0.5;
}

float2 spmDirToUV(float3 dir, float scale, uint hemisphereIndex)
{
	float denom = 1.0 / ((1.0 + hemisphereSignFromIndex(hemisphereIndex) * abs(dir.z)) * scale);
	return denom * dir.xy * 0.5 + 0.5;
}

// For Dual-Paraboloid +Y is UP direction
// One hemisphere (with index 0) covers +Y, over (with index 1) covers -Y

// Note: dpmInvDistortion mult by 2.0 to match energy in single paraboloid
float dpmInvDistortion(float3 dir, float scale)
{
	float t = abs(dir.y) + 1.0;
	return 2.0 / (4.0 * scale * scale * t * t);
}

uint dpmHemisphereIndexFromDir(float3 dir)
{
	return dir.y >= 0.0 ? 0 : 1;
}

float2 dpmDirToUV(float3 dir, float scale)
{
	float denom = 1.0 / ((1.0 + abs(dir.y)) * scale);
	return denom * dir.xz * 0.5 + 0.5;
}

float2 dpmDirToUV(float3 dir, float scale, uint hemisphereIndex)
{
	float denom = 1.0 / ((1.0 + hemisphereSignFromIndex(hemisphereIndex) * abs(dir.y)) * scale);
	return denom * dir.xz * 0.5 + 0.5;	
}

float dpmComputeLod(float3 dir, float scale)
{
	// TODO
	return 0.0;
	//return max(0.5 * log2(w * h / samplesCount?) - 0.5 * log2(1.0 * dpmDistortion(dir, scale)), 0);
}


#endif // COMMON_PARABOLOID_MAPPING_HLSL