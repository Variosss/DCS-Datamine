#ifndef _COMMON_RANDOM_HLSL_
#define _COMMON_RANDOM_HLSL_

float sampleUniformDist(float a, float b, float rand){ return (b-a)*rand+a;}

float noise1(float param, float factor = 13758.937545312382)
{
	return frac(sin(param) * factor);
}

float2 noise2(float2 param, float factor = 14251.895649154)
{
	return frac(sin(param) * factor);
}

float3 noise3(float3 param, float factor = 12958.345742318)
{
	return frac(sin(param) * factor);
}

float4 noise4(float4 param, float factor = 17572.193754531238)
{
	return frac(sin(param) * factor);
}

uint wang_hash(uint seed)
{
    seed = (seed ^ 61) ^ (seed >> 16);
    seed *= 9;
    seed = seed ^ (seed >> 4);
    seed *= 0x27d4eb2d;
    seed = seed ^ (seed >> 15);
    return seed;
}

uint rand_xorshift(uint rng_state)
{
    // Xorshift algorithm from George Marsaglia's paper
    rng_state ^= (rng_state << 13);
    rng_state ^= (rng_state >> 17);
    rng_state ^= (rng_state << 5);
    return rng_state;
}

float smoothNoise1( in float x, float factor = 43758.5453123)
{
	float p = floor(x);
	float f = frac(x);
	f = f*f*(3.0-2.0*f);
	float2 s = noise2(float2(p, p+1), factor);
	return lerp( s[0], s[1], f);
}

float smoothNoise2( in float2 x, float factor = 43758.5453123)
{
	float2 p = floor(x);
	float2 f = frac(x);
	f = f*f*(3.0-2.0*f);
	float n = p.x + p.y*57.0;

	float4 s = noise4(float4(n, n+1, n+57, n+58), factor);
	return lerp(lerp( s[0], s[1], f.x),
				lerp( s[2], s[3], f.x), 
				f.y);
}


#define HASHSCALE1 .1031
#define HASHSCALE3 float3(.1031, .1030, .0973)
#define HASHSCALE4 float4(.1031, .1030, .0973, .1099)

float hash12(float2 p) {
	 float3 p3 = frac(float3(p.xyx) * HASHSCALE1);
	 p3 += dot(p3, p3.yzx + 19.19);
	 return frac((p3.x + p3.y) * p3.z);
}

float2 hash22(float2 p) {
	 float3 p3 = frac(float3(p.xyx) * HASHSCALE3);
	 p3 += dot(p3, p3.yzx + 19.19);
	 return frac((p3.xx + p3.yz)*p3.zy);
}


// -------------------------------------------------------------
// Random generator based on hash fucntion with per-thread state
// -------------------------------------------------------------
static uint g_rngState;

// Main hash fucntion
// https://www.reedbeta.com/blog/hash-functions-for-gpu-rendering/
uint hashPCG(uint input)
{
	uint state = input * 747796405u + 2891336453u;
	uint word = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
	return (word >> 22u) ^ word;
}

// Must be called before ANY call to rand* functions presented below
void initRandom(uint seed)
{
	g_rngState = hashPCG(seed);
}

// Generates next pseudo-random uint value via hashPCG and updates global random state (g_rngState)
uint randPCG()
{
	uint state = g_rngState;
	g_rngState = g_rngState * 747796405u + 2891336453u;
	uint word = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
	return (word >> 22u) ^ word;
}

// Pseudo-random uint value
uint  urand()  { return randPCG(); }
uint2 urand2() { return uint2(randPCG(), randPCG()); }
uint3 urand3() { return uint3(randPCG(), randPCG(), randPCG()); }
uint4 urand4() { return uint4(randPCG(), randPCG(), randPCG(), randPCG()); }

// Construct a float with half-open range [0..1) using low 23 bits.
// All zeroes yields 0.0, all ones yields the next smallest representable value below 1.0.
float floatConstruct(uint m)
{
	const uint ieeeMantissa = 0x007FFFFFu; // binary32 mantissa bitmask
	const uint ieeeOne = 0x3F800000u;      // 1.0 in IEEE binary32
	m &= ieeeMantissa;                     // Keep only mantissa bits (fractional part)
	m |= ieeeOne;                          // Add fractional part to 1.0
	float f = asfloat(m);                  // Range [1..2)
	return f - 1.0;                        // Range [0..1)
}

// Pseudo-random uniformly distributed float values in half-open range [0..1)
float  rand()  { return floatConstruct(randPCG()); }
float2 rand2() { return float2(rand(), rand()); }
float3 rand3() { return float3(rand(), rand(), rand()); }
float4 rand4() { return float4(rand(), rand(), rand(), rand()); }

// Pseudo-random uniformly distributed float value in half-open range [s..e)
float  randInRange(float s, float e)   { return s + (e - s) * rand(); }
float2 randInRange(float2 s, float2 e) { return s + (e - s) * rand2(); }
float3 randInRange(float3 s, float3 e) { return s + (e - s) * rand3(); }
float4 randInRange(float4 s, float4 e) { return s + (e - s) * rand4(); }


// ----------------------
// Specific distributions 
// ----------------------

static const float RANDOM_PI = 3.141592653589793238462f;

// Pseudo-random gaussian distributed float value with range centered at origin (0.0)
// Mean = 0.0, Std = 1.0
float randGauss()
{
	return cos(2.0 * RANDOM_PI * rand()) * sqrt(-2.0 * log(rand()));
}

// Pseudo-random gaussian distributed float value with range centered at origin (0.0)
float randGauss(float mean, float std)
{
	return mean + randGauss() * std;
}

// Generates a uniformly distributed random 2D points on the surface of a unit-circle
float2 randCirclePoint()
{
	float angle = 2.0 * RANDOM_PI * rand();
	return float2(cos(angle), sin(angle));
}

// Generates a uniformly distributed random 2D points within the area of a unit-disk
float2 randDiskPoint()
{
	return randCirclePoint() * sqrt(rand());
}

// Generates a gaussian distributed random 2D points within the area of a unit-disk 
float2 randDiskPointGauss(float k)
{
	return randCirclePoint() * sqrt(-k * log(rand()));
}

// Generates a uniformly distributed random 3D points within the area of a unit-disk oriented around normal vector 'n' in 3D
float3 randDiskPoint(float3 n)
{
	float2 p = randDiskPoint();
	
	float3 tangent = normalize(cross(n, float3(-n.z, n.x, n.y)));
	float3 bitangent = normalize(cross(n, tangent));
	return tangent * p.x + bitangent * p.y;	
}

// Generates a uniformly distributed random 3D points on the surface of a unit-sphere
float3 randSphereSurfacePoint()
{
	float z = rand() * 2.0 - 1.0;
	float sq = sqrt(1.0 - z * z);
	return float3(randCirclePoint() * sq, z);
}

// Generates a uniformly distributed random 3D points within the volume of unit-sphere
float3 randSpherePoint()
{
	return randSphereSurfacePoint() * pow(rand(), 1.0 / 3.0);
}

// Generates a uniformly distributed random 3D points on the surface of a unit-hemisphere oriented around normal vector 'n' in 3D
float3 randHemisphereSurfacePoint(float3 n)
{
	float3 v = randSphereSurfacePoint();
	return v * sign(dot(v, n));
}

// Generates a uniformly distributed random 3D points within the volume of a unit-hemisphere oriented around normal vector 'n' in 3D
float3 randHemispherePoint(float3 n)
{
	float3 v = randSpherePoint();
	return v * sign(dot(v, n));
}

// Generates a uniformly distributed random 3D points on spherical cap on the surface of a unit-sphere
float3 randSphericalCapSurfacePoint(float angle)
{
	float z = randInRange(cos(angle), 1.0f);
	float sq = sqrt(1.0 - z * z);
	return float3(randCirclePoint() * sq, z);
}

// Generates a uniformly distributed random 3D points on spherical cap on the surface of a unit-sphere oriented around normal vector 'n' in 3D
float3 randSphericalCapSurfacePoint(float angle, float3 n)
{
	float3 d = randSphericalCapSurfacePoint(angle);
	
	float3 tangent = normalize(cross(n, float3(-n.z, n.x, n.y)));
	float3 bitangent = normalize(cross(n, tangent));
	
	return tangent * d.x + bitangent * d.y + n * d.z;
}

// Generates a gaussian distributed random 3D points on spherical cap on the surface of a unit-sphere
float3 randSphericalCapSurfacePointGauss(float angle)
{
	float cs = cos(angle);
	float z = 1.0f - abs(randGauss() * 0.3) * (1.0 - cs);
	float sq = sqrt(1.0 - z * z);
	return float3(randCirclePoint() * sq, z);
}

// Generates a gaussian distributed random 3D points on spherical cap on the surface of a unit-sphere oriented around normal vector 'n' in 3D
float3 randSphericalCapSurfacePointGauss(float angle, float3 n)
{
	float3 d = randSphericalCapSurfacePointGauss(angle);
	
	float3 tangent = normalize(cross(n, float3(-n.z, n.x, n.y)));
	float3 bitangent = normalize(cross(n, tangent));
	
	return tangent * d.x + bitangent * d.y + n * d.z;
}

// Generates a uniformly distributed barycentric coordinates for triangle
float3 randTriangleBarycentric()
{
	float2 uv = rand2();
	if (uv.x + uv.y > 1.0) 
		uv = 1.0 - uv;
	return float3(uv, 1.0 - uv.x - uv.y);
}

// Generates a uniformly distributed random 2D points on the edge of a unit-quad
float2 randQuadEdgePoint()
{
	if ((rand() - 0.5) > 0.0)
	{
		return float2(sign(rand() - 0.5), rand() * 2.0 - 1.0);
	}
	else
	{
		return float2(rand() * 2.0 - 1.0, sign(rand() - 0.5));
	}
}

// Generate a uniformly distributed random 3D points on the edge of a unit-quad oriented with normal 'n' and tangent vectors in 3D
float3 randQuadEdgePoint(float3 n, float3 tangent)
{
	float2 p = randQuadEdgePoint();
	float3 bitangent = normalize(cross(n, tangent));
	return tangent * p.x + bitangent * p.y;
}

#endif
