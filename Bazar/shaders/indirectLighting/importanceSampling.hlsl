#ifndef IMPORTANCE_SAMPLING_HLSL
#define IMPORTANCE_SAMPLING_HLSL

#define PI 3.141592653589793238462

#define Y_UP

float2 hammersley(uint i, uint N) 
{
	float den = reversebits(i) * 2.3283064365386963e-10;
	return float2(float(i) / float(N), (den) );
}

float3 alignToSphereSurface(float3 normal, float3 vec)
{	
#ifndef Y_UP
	float3 up = abs(normal.z) < 0.999 ? float3(0,0,1) : float3(1,0,0);
#else
	float3 up = abs(normal.y) < 0.999 ? float3(0,1,0) : float3(1,0,0);
#endif

	float3 tangentX = normalize( cross(up, normal) );
	float3 tangentY = cross(normal, tangentX);
	return tangentX * vec.x + tangentY * vec.y + normal * vec.z;
}

// нормаль торчит вверх
float3 importanceSampleGGX(float2 E, float roughness)
{
	float a2 = roughness;
	
	float phi = 2.0f * PI * E.x;
	float cosTheta = sqrt( (1 - E.y) / (1 + (a2 - 1.0) * E.y) );
	float sinTheta = sqrt(1 - cosTheta * cosTheta);
	
	float3 h = {sinTheta * cos(phi), sinTheta * sin(phi), cosTheta};
	
	// float d = (cosTheta * a2 - cosTheta) * cosTheta + 1;
	// float D = a2 / ( PI*d*d );
	// float PDF = D * cosTheta;
	// return float4(h, PDF);
	return h;
}

// для мировой нормали N
float3 importanceSampleGGX(float2 E, float roughness, float3 N)
{
	float3 h = importanceSampleGGX(E, roughness);
	return alignToSphereSurface(N, h);
}

// нормаль торчит вверх
float3 importanceSampleCosine(float2 E)
{
	float phi = 2.0f * PI * E.x;
	float cosTheta = sqrt(1 - E.y);
	float sinTheta = sqrt(1 - cosTheta * cosTheta);	

	return float3(sinTheta * cos(phi), sinTheta * sin(phi), cosTheta);
}

// для мировой нормали N
float3 importanceSampleCosine(float2 E, float3 N)
{
	float3 h = importanceSampleCosine(E);
	return alignToSphereSurface(N, h);
}

// нормаль торчит вверх
float3 importanceSampleUniform(float2 E)
{
	float phi = 2.0f * PI * E.x;
	float cosTheta = 1 - E.y;
	float sinTheta = sqrt(1 - cosTheta * cosTheta);
	return float3(sinTheta * cos(phi), sinTheta * sin(phi), cosTheta);
}

// для мировой нормали N
float3 importanceSampleUniform(float2 E, float3 N)
{
	float3 h = importanceSampleUniform(E);
	return alignToSphereSurface(N, h);
}

#endif
