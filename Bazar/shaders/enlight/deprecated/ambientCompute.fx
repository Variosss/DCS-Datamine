#include "common/samplers11.hlsl"
#include "common/BRDF.hlsl"

TextureCube envCube;
RWTexture2DArray<float4> prefilteredEnvMap;
RWTexture2D<float2>		 preintegratedGF;

float	gRoughness;
float2	gMipSize;

#define PI 3.141592653589793238462

static const float3 minAmbient = float3(9, 26, 52) / 255.f * 0.008;

static const float3 normals[] = {
	{1,0,0},
	{-1,0,0},
	{0, 1,0},
	{0,-1,0},
	{0,0, 1},
	{0,0,-1},
};

static const float3 binormals[] = {
	{0, 1, 0},
	{0, 1, 0},
	{0, 0, -1},
	{0, 0, 1},
	{0, 1, 0},
	{0, 1, 0},
};

float2 hammersley(uint i, uint N) 
{
	float den = reversebits(i) * 2.3283064365386963e-10;
	return float2(float(i) / float(N), (den) );
}

// нормаль торчит вверх
float3 importanceSampleGGX(float2 E, float roughness)
{
	// float a2 = roughness * roughness * roughness * roughness;
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

#define Y_UP

// для мировой нормали N
float3 importanceSampleGGX(float2 E, float roughness, float3 N)
{
	float3 h = importanceSampleGGX(E, roughness);
	
#ifndef Y_UP
	float3 up = abs(N.z) < 0.999 ? float3(0,0,1) : float3(1,0,0);
#else
	float3 up = abs(N.y) < 0.999 ? float3(0,1,0) : float3(1,0,0);
#endif

	float3 tangentX = normalize( cross(up, N) );
	float3 tangentY = cross(N, tangentX);
	return tangentX * h.x + tangentY * h.y + N * h.z;
}

float3 prefilterEnvMap3(TextureCube environmentMap, sampler sm, float roughness, float3 N, uniform uint samples)
{
	float3 color = 0;
	float weight = 0;
	
	float3 V = N;
	
	roughness *= roughness * roughness * roughness;
	
	// const uint samples = 64;
	[loop]
	for(uint i = 0; i < samples; ++i)
	{
		float2 E = hammersley(i, samples);
		float3 H = importanceSampleGGX(E, roughness, N);
		float3 L = 2 * dot(V, H) * H - V;//reflect V via H
		float NoL = saturate( dot(N, L) );
		if(NoL > 0)
		{
			color += environmentMap.SampleLevel(sm, L, 0).rgb * NoL;
			weight += NoL;
		}
	}
	return color / max( weight, 0.001 );
}

float4 prefilterEnvMap4(TextureCube environmentMap, sampler sm, float roughness, float3 N, uniform uint samples)
{
	float4 color = 0;
	float weight = 0;
	
	float3 V = N;
	
	roughness *= roughness * roughness * roughness;
	
	// const uint samples = 64;
	[loop]
	for(uint i = 0; i < samples; ++i)
	{
		float2 E = hammersley(i, samples);
		float3 H = importanceSampleGGX(E, roughness, N);
		float3 L = 2 * dot(V, H) * H - V;//reflect V via H
		float NoL = saturate( dot(N, L) );
		if(NoL > 0)
		{
			color += environmentMap.SampleLevel(sm, L, 0).rgba * NoL;
			weight += NoL;
		}
	}
	return color / max( weight, 0.001 );
}

float2 integrateBRDF(float roughness, float NoV)
{
	float3 V = {sqrt(1.0 - NoV * NoV), 0, NoV};// {sin - 0 - cos}
	float2 res = 0;

	const uint samples = 512;
	for(uint i = 0; i < samples; ++i)
	{
		float2 E = hammersley(i, samples);
		float3 H = importanceSampleGGX(E, roughness);
		float3 L = 2 * dot(V, H) * H - V;

		float NoL = saturate(L.z);
		float NoH = saturate(H.z);
		float VoH = saturate(dot(V, H));

		if(NoL > 0)
		{
			float vis = Visibility_smith(roughness, NoV, NoL);
			// incident light = NoL
			// pdf = D * NoH / (4 * VoH)
			// NoL * vis / pdf
			float m = NoL * vis * (4 * VoH / NoH);
			float Fc = pow(1 - VoH, 5);
			res.x += (1 - Fc) * m;
			res.y += Fc * m;
		}
	}
	return res / samples;
}

[numthreads(16,16,1)]
void csPrefilterCubemap(uint3 dId: SV_DispatchThreadID, uniform uint samples, uniform int components = 3)
{
	const uint wall = dId.z;
	const uint2 pixel = dId.xy;

	
	float3 normal = normals[wall];
	float3 binorm = binormals[wall];
	float3 tangent = cross(normal, binorm);


	float2 uv = 2.0 * (pixel + 0.5) / gMipSize - 1.0;
	normal = normalize(normal - uv.y*binorm - uv.x*tangent);

	//считаем что с верхней полусферы всегда идет минимальный рассеяный свет
	float NoL = max(0.2, normal.y*0.7+0.3);
	if(components==3)
		prefilteredEnvMap[dId] = float4(max(minAmbient*NoL, prefilterEnvMap3(envCube, gPointClampSampler, gRoughness, normal, samples)), 1);
	else if(components==4) {
		prefilteredEnvMap[dId] = prefilterEnvMap4(envCube, gPointClampSampler, gRoughness, normal, samples);
	}
	else
		prefilteredEnvMap[dId] = float4(1,0,0,1);
	
	//prefilteredEnvMap[dId] = float4(envCube.SampleLevel(gPointClampSampler, normal, 0).rgb, 1);
	
#if 0
	if(dId.z<2)
		prefilteredEnvMap[dId] = float4(1,0,0, 1);
	else if(dId.z<4)
		prefilteredEnvMap[dId] = float4(0,1,0, 1);
	else
		prefilteredEnvMap[dId] = float4(0,0,1, 1);
#endif	
}

[numthreads(16,16,1)]
void csPreintegrateGF(uint3 dId: SV_DispatchThreadID)
{
	float2 dims;
	preintegratedGF.GetDimensions(dims.x, dims.y);
	uint2 pixel = dId.xy;
	float2 uv = pixel/dims;
	preintegratedGF[pixel] = float2(integrateBRDF(max(0.01, uv.x), uv.y));
}

#define MIP_PASS(mip, s) pass P##mip { SetComputeShader(CompileShader(cs_5_0, csPrefilterCubemap(s, 3))); }

technique10 prefilterEnvCubeTech
{
	//для оффлайн фильтрации:
	MIP_PASS(0, 1024)

	//для рантайма:
	//куб 256х256 с последним мипом 2х2
	MIP_PASS(1, 42)
	MIP_PASS(2, 120)
	MIP_PASS(3, 220)
	MIP_PASS(4, 256)
	MIP_PASS(5, 200)
	MIP_PASS(6, 200)
	MIP_PASS(7, 300)

	//куб 256х256 с последним мипом 4х4
	// MIP_PASS(1, 42)
	// MIP_PASS(2, 150)
	// MIP_PASS(3, 200)
	// MIP_PASS(4, 256)
	// MIP_PASS(5, 256)
	// MIP_PASS(6, 320)
	// MIP_PASS(7, 0)
}

#undef MIP_PASS
#define MIP_PASS(mip, s) pass P##mip { SetComputeShader(CompileShader(cs_5_0, csPrefilterCubemap(s, 4))); }

technique10 prefilterEnvCubeTech4
{
	//для оффлайн фильтрации:
	MIP_PASS(0, 1024)
}

technique10 preintegratedGFTech
{
	pass P0
	{
		SetComputeShader(CompileShader(cs_5_0, csPreintegrateGF()));
	}
}
