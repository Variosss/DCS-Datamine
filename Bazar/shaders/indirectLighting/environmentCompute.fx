#include "common/samplers11.hlsl"
#include "common/BRDF.hlsl"
#include "common/context.hlsl"

#include "indirectLighting/importanceSampling.hlsl"

#define FIX_GF_OVEREXPOSE

TextureCube envCube;
RWTexture2DArray<float4> prefilteredEnvMap;
RWTexture2D<float2>		 preintegratedGF;

struct SHKnot
{
	float4 walls[6];
};
RWStructuredBuffer<SHKnot> resolvedKnots;

uint	knotId;
float	gRoughness;
float2	gMipSize;

float4	ambientColor;

static const float3 minAmbient = ambientColor.rgb * ambientColor.a;

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

float3 GetDirectionFromCubeMapUV(uint wall, float2 uv)
{
	uv = uv * 2.0 - 1.0;

	float3 normal = normals[wall];
	float3 binorm = binormals[wall];
	float3 tangent = cross(normal, binorm);

	return normalize(normal - uv.y*binorm - uv.x*tangent);
}

float4 prefilterEnvMap(TextureCube environmentMap, sampler sm, float roughness, float3 N, uniform uint samples)
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
	[loop]
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

#ifdef FIX_GF_OVEREXPOSE
float2 integrateBRDFWithCorrection(float roughness, float NoV)
{
	float2 fg0 = integrateBRDF(roughness, 1);//центр
	float2 fg1 = integrateBRDF(roughness, 0);//край
	float2 fg = integrateBRDF(roughness, NoV);

	float2 fgNorm = max(1.0, fg1) - fg0;

	return lerp(fg, (fg0 + (fg-fg0) / fgNorm), (1-NoV)*0.2);
}
#endif

[numthreads(16,16,1)]
void csPrefilterCubemap(uint3 dId: SV_DispatchThreadID, uniform uint samples, uniform int components = 3)
{
	const uint wall = dId.z;
	const uint2 pixel = dId.xy;

	float2 uv = (pixel + 0.5) / gMipSize;
	float3 normal = GetDirectionFromCubeMapUV(wall, uv);

	//считаем что с верхней полусферы всегда идет минимальный рассеяный свет
//	float NdotMoon = max(0, dot(gSunDir, normal));
//	float ambientFactor = max(0.0001, (normal.y*(1+gSunDir.y)*0.05 + pow(NdotMoon, 20))*(1-gCloudiness));
	float NoL = max(0.01, normal.y*0.7 + 0.01) * gRoughness;

	if(components==3)
//		prefilteredEnvMap[dId] = float4(max(minAmbient*ambientFactor, prefilterEnvMap3(envCube, gPointClampSampler, gRoughness, normal, samples)), 1);
		prefilteredEnvMap[dId] = float4(max(minAmbient*NoL, prefilterEnvMap(envCube, gPointClampSampler, gRoughness, normal, samples).rgb), 1);
	else if(components==4) {
		prefilteredEnvMap[dId] = prefilterEnvMap(envCube, gPointClampSampler, gRoughness, normal, samples).rgba;
	}
	else
		prefilteredEnvMap[dId] = float4(1,0,0,1);
	
#if 0
	if(dId.z<2)
		prefilteredEnvMap[dId] = float4(1,0,0, 1);
	else if(dId.z<4)
		prefilteredEnvMap[dId] = float4(0,1,0, 1);
	else
		prefilteredEnvMap[dId] = float4(0,0,1, 1);
#endif	
}

[numthreads(6,1,1)]
void csPrefilterCubemapForSHKnot(uint3 dId: SV_GroupThreadID, uniform uint samples, uniform int components = 3)
{
	const uint wall = dId.x;
	float3 normal = normals[wall];

	if(components==3)
		resolvedKnots[knotId].walls[wall] = float4(prefilterEnvMap(envCube, gPointClampSampler, gRoughness, normal, samples).rgb, 1);
	else if(components==4) {
		resolvedKnots[knotId].walls[wall] = prefilterEnvMap(envCube, gPointClampSampler, gRoughness, normal, samples).rgba;
	}
	else
		resolvedKnots[knotId].walls[wall] = float4(1,0,0,1);
}

[numthreads(16,16,1)]
void csPreintegrateGF(uint3 dId: SV_DispatchThreadID)
{
	float2 dims;
	preintegratedGF.GetDimensions(dims.x, dims.y);
	uint2 pixel = dId.xy;
	float2 uv = pixel/dims;

#ifdef FIX_GF_OVEREXPOSE
	float3 skewFactor = 0.02 * pow((1-uv.x), 1.3);
	preintegratedGF[pixel] = float2(integrateBRDFWithCorrection(max(0.005, uv.x), saturate(skewFactor + (1-skewFactor)*uv.y)));
#else
	preintegratedGF[pixel] = float2(integrateBRDF(max(0.005, uv.x), uv.y));
#endif
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

technique10 prefilterEnvCubeForSHKnotTech
{
	pass P0 { SetComputeShader(CompileShader(cs_5_0, csPrefilterCubemapForSHKnot(1024, 3))); }
}

technique10 prefilterEnvCubeForSHKnotTech4
{
	pass P0 { SetComputeShader(CompileShader(cs_5_0, csPrefilterCubemapForSHKnot(1024, 4))); }
}


technique10 preintegratedGFTech
{
	pass P0
	{
		SetComputeShader(CompileShader(cs_5_0, csPreintegrateGF()));
	}
}
