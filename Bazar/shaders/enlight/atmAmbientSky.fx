#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "indirectLighting/importanceSampling.hlsl"

#define FOG_ENABLE
#include "enlight/skyCommon.hlsl"


RWTexture2D<float4> texOutput;
RWTexture3D<float4> tex3DOutput;
RWTexture3D<float4> tex3DOutput2;

Texture3D scatteringTex;

float3 sunDir;
float3 texSize;

float4 SampleSky(float3 viewDir, float3 cameraPos, float surfaceHeight, uniform bool bBlackSurface, uniform bool bFog = true)
{
	const float atmDepth = paramDistMax;//km
	const float Rg = gEarthRadius;// + surfaceHeight;

	float r, mu, mu2;
	float3 skyColor;
	float3 transmittance;
	GetRMu(cameraPos, viewDir, r, mu);
	float muHorizon = -sqrtf(1.0 - (Rg / r) * (Rg / r)) + 0.01;
	mu2 = max(mu, muHorizon);

	AtmosphereParameters atmosphere; initAtmosphereParameters(atmosphere);

	AtmosphereParameters atmosphere2 = atmosphere;	atmosphere2.bottom_radius = Rg + surfaceHeight;

	bool bRayIntersectsGround = RayIntersectsGround(atmosphere2, r, mu);

	float dist = bRayIntersectsGround ? DistanceToBottomAtmosphereBoundary(atmosphere2, r, mu) : sqrt(r*r-Rg*Rg)*0.3;//atmDepth;//sqrt(r*r-Rg*Rg)*0.3;

	float3 skyRadianceBase = GetSkyRadiance(r, mu,  cameraPos, viewDir, 0.0, sunDir, transmittance, atmDepth);
	if(bBlackSurface && 0)
		skyColor = skyRadianceBase * gAtmIntensity;
	else {
		float3 skyRadiance = GetSkyRadiance(r, mu2, cameraPos, viewDir, 0.0, sunDir, transmittance, atmDepth);
		float nHeight = 0;//saturate((gCameraPos.y + gOrigin.y) / 15000.0);
		skyColor = lerp(skyRadiance, skyRadianceBase, nHeight) * gAtmIntensity;
		// return abs(mu2);
	}

	float surfaceVisibility = bRayIntersectsGround ? dot(GetTransmittance(atmosphere, transmittanceTex, r, mu, dist, RayIntersectsGround(atmosphere, r, mu)), 0.3333) : 0.0;
	return float4(bFog? applyFog(skyColor, viewDir, dist*1000.0, true) : skyColor, surfaceVisibility);
}

#undef THREADS_PER_WALL
#define THREADS_PER_WALL 1

groupshared float4	sharedColors[6][THREADS_PER_WALL];
groupshared float	sharedWeights[6][THREADS_PER_WALL];

float3 unpackNormal(float u, float v)
{
	float3 N;
	N.y = -0.999 + 1.9999 * v;
	float azimuth = 2.0 * PI * u;
	float normFactor = sqrt(max(0, 1.0 - N.y*N.y));
	N.x = sin(azimuth) * normFactor;
	N.z = cos(azimuth) * normFactor;
	return N;
}

[numthreads(1, THREADS_PER_WALL, 1)]
void ComputeFogColorTableCS(uint id: SV_GroupIndex, uint3 gId: SV_GroupID, uint3 tId: SV_GroupThreadID, uint3 dId: SV_DispatchThreadID)
{
	const uint wall = 0;
	const uint batchId = tId.y;

	static const float roughness = 0.1;
	static const uint samples = 1;

	const uint batchesPerWall = THREADS_PER_WALL;
	const uint batchSize = samples / batchesPerWall;
	const uint samplesPerWall = batchSize * batchesPerWall;

	float4 wallColor = 0;
	float weight = 0;

	float3 cameraPos = float3(0, gEarthRadius + max(1000, (gOrigin.y+gCameraPos.y))*0.001, 0); //в км о центра земли

	float3 N = unpackNormal(gId.x/128.0, gId.y/64.0);

	//семплируем атмосферу
	float3 V = N;
	uint i;
	uint firstId = batchId * batchSize;
	uint lastId = firstId + batchSize;
	[loop]
	for(i = firstId; i < lastId; ++i)
	{
		float2 E = hammersley(i, samplesPerWall);
		float3 H = importanceSampleGGX(E, roughness, N);
		float3 L = 2.0 * dot(V, H) * H - V;//reflect V via H
		float NoL = saturate( dot(N, L) );
		if(NoL > 0)
		{
			wallColor += SampleSky(L, cameraPos, 0, false, false) * NoL;
			// wallColor += NoL;
			weight += NoL;
		}
	}
	// wallColor /= max(weight, 0.0001);

	//сохраняем результаты для каждого батча
	sharedColors[wall][batchId] = wallColor;
	sharedWeights[wall][batchId] = weight;

	GroupMemoryBarrierWithGroupSync();

	//суммируем веса и цвета для каждой стенки раздельно
	[unroll( uint( ceil(log2(batchesPerWall)) ) ) ]
	for (i = 1; i < batchesPerWall; i <<= 1) { //for n = 0 .. log2(N), i =  2^n
		float4 color;
		float w;
		if ((i==1 && batchId >= i) || batchId > i) {
			color = sharedColors[wall][batchId] + sharedColors[wall][batchId-i];
			w = sharedWeights[wall][batchId] + sharedWeights[wall][batchId-i];
		} else {
			color = sharedColors[wall][batchId];
			w = sharedWeights[wall][batchId];
		}
		GroupMemoryBarrierWithGroupSync();
		sharedColors[wall][batchId] = color;
		sharedWeights[wall][batchId] = w;
		GroupMemoryBarrierWithGroupSync();
	}

	if(id==0)
	{
		wallColor = sharedColors[wall][batchesPerWall-1];
		weight = sharedWeights[wall][batchesPerWall-1];

		texOutput[gId.xy] = wallColor / max( weight, 0.001 );
	}
}

float GetMuS(float3 cameraPos, float3 sunDir)
{
	return dot(normalize(cameraPos), sunDir);
}

void GetRMuMuSNu(float3 cameraPos, float3 viewDir, float3 sunDir, out float r, out float mu, out float mu_s, out float nu)
{
	GetRMu(cameraPos, viewDir, r, mu);
	mu_s = dot(cameraPos, sunDir) / r;
	nu = dot(viewDir, sunDir);
}

float4 SampleSky2(float3 viewDir, float3 cameraPos, float muS, float surfaceAltitude, float3 surfaceAlbedo = 0.2, uniform bool bFog = true)
{
	const float atmDepth = paramDistMax;//km
	const float Rg = gEarthRadius;// + surfaceAltitude;

	float r, mu, mu2, muSdummy, nu;	
	GetRMuMuSNu(cameraPos, viewDir, sunDir, r, mu, muSdummy, nu);
	
	float muHorizon = -sqrtf(1.0 - (Rg / r) * (Rg / r)) + 0.01;
	mu2 = max(mu, muHorizon);

	AtmosphereParameters atmosphere; initAtmosphereParameters(atmosphere);
	AtmosphereParameters atmosphere2 = atmosphere;	atmosphere2.bottom_radius = Rg + surfaceAltitude;
	
	//sky sample
	float3 transmittance;
	float3 skyRadiance = GetSkyRadianceInternal(atmosphere, transmittanceTex, scatteringTex, scatteringTex, r, mu, muS, nu, 0.0, 0.0, transmittance);
	float3 skyColor = skyRadiance * gAtmIntensity;
	
	//surface sample
	bool bRayIntersectsGround = RayIntersectsGround(atmosphere2, r, mu);

	float dist = bRayIntersectsGround ? 
				 DistanceToBottomAtmosphereBoundary(atmosphere2, r, mu) : 
				 sqrt(r*r-Rg*Rg) * 0.3;


	float surfaceVisibility = 0.0;
	if(bRayIntersectsGround)
	{	
		AtmPoint p = GetRMuMuSAtDistance(atmosphere2, r, mu, muS, nu, dist);
		
		float3 surfaceTransmittance = GetTransmittance(atmosphere, transmittanceTex, r, mu, dist, RayIntersectsGround(atmosphere, r, mu));
		
		surfaceVisibility = surfaceTransmittance * p.mu_s;

		if(any(surfaceAlbedo>0))
		{
			skyColor += surfaceAlbedo * (surfaceVisibility) * gSunIntensity;
		}
	}

	return float4(bFog? applyFog(skyColor, viewDir, dist*1000.0, true) : skyColor, surfaceVisibility);
}

struct Sample
{
	float4	sum;
	float	weight;
};

//атмосфера семплируется равномерно по сфере
Sample SampleSkyAmbientBatched(float3 cameraPos, float muS, uint samples, uint batchId, uint batchCount, 
	uniform bool bSampleTopHemisphereOnly = true,
	uniform float3 surfaceAlbedo = 0.2)
{
	const float surfaceAltitude = 0;

	uint samplesPerBatch = samples / batchCount;
	samples = samplesPerBatch * batchCount;

	uint firstId = batchId * samplesPerBatch;
	uint lastId = firstId + samplesPerBatch;

	Sample sample;
	sample.sum = 0;
	sample.weight = 0;

	[loop]
	for(uint i = firstId; i < lastId; ++i)
	{
		float2 E = hammersley(i, samples);
		E.y = (bSampleTopHemisphereOnly? 1 : 2) * (1 - E.y);// top hemisphere or whole sphere
		float3 ray = importanceSampleUniform(E).xzy;

		float weight = sqrt(abs(ray.y));

		sample.sum += SampleSky2(ray, cameraPos, muS, surfaceAltitude, surfaceAlbedo) * weight;
		sample.weight += weight;
	}
	return sample;
}

float4 SampleSkyWithCylinderProjection(float2 uv, bool bSampleTopHemisphereOnly, float3 surfaceAlbedo = 0.2)
{
	float altitude = 5.1;
	float distance = 0;

	float cameraAltitude = gEarthRadius + altitude + heightHack;

	float3 cameraPos = float3(0, cameraAltitude, 0);

	float muS = GetMuS(cameraPos + normalize(float3(sunDir.x, 0, sunDir.z)) * distance, sunDir); //properly rotated by distance from camera

	float3 ray = importanceSampleUniform(float2(uv.x, (bSampleTopHemisphereOnly? 1 : 2) * (1 - uv.y))).xzy;

	return SampleSky2(ray, cameraPos, muS, 0, surfaceAlbedo);
}

struct TexelParameters
{
	float uDistance;
	float uAltitude;
	float altitude;
	float distance;
	float3 cameraPos;
	float muS;
};

TexelParameters getParametersFromTexel(uint2 texel, float2 texSize, float altitudeMax, float distanceRange)
{
	TexelParameters o;
	o.uDistance = saturate( texel.x / (texSize.x - 1) );//normalized 0-1
	o.uAltitude = saturate( texel.y / (texSize.y - 1) );//normalized 0-1

	o.altitude = o.uAltitude * altitudeMax;
	o.distance = (o.uDistance*2-1) * distanceRange;

	float3 sunDirProj = normalize(float3(sunDir.x, 0, sunDir.z));

	float cameraAltitude = gEarthRadius + o.altitude + heightHack;

	o.cameraPos = float3(0, cameraAltitude, 0);
	// o.cameraPos = normalize(o.cameraPos + sunDirProj * distance) * cameraAltitude;

	o.muS = GetMuS(o.cameraPos + sunDirProj * o.distance, sunDir); //properly rotated for distance from camera
	return o;
}

//x - distance above surface in sun direction, x=0.5 - under the observer
//y - altitude
[numthreads(8, 8, 1)]
void ComputeSkyAmbient(uint id: SV_GroupIndex, uint3 gId: SV_GroupID, uint3 tId: SV_GroupThreadID, uint3 dId: SV_DispatchThreadID)
{
	const float samples = 100;
	const float distanceRange = 400.0;//in each direction, km
	const float altitudeMax = 20.0;//km	
	const bool bSampleTopHemisphereOnly = true;
	const float cloudsTransparency = 0.5;
	const float3 surfaceAlbedo = 0.15;

	TexelParameters i = getParametersFromTexel(dId.xy, texSize.xy, altitudeMax, distanceRange);

	Sample sample = SampleSkyAmbientBatched(i.cameraPos, i.muS, samples, 0, 1, bSampleTopHemisphereOnly, surfaceAlbedo*cloudsTransparency);

	// texOutput[dId.xy] = SampleSkyWithCylinderProjection(float2(uDistance, uAltitude), bSampleTopHemisphereOnly, surfaceAlbedo*cloudsTransparency) * 4;
	texOutput[dId.xy] = sqrt((sample.sum / sample.weight));
}

float3 GetTotalSunRadiance(float altitude, float muS)
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);

	float r = atmParams.bottom_radius + altitude + heightHack;

	return GetSunRadiance(r, muS) * getFogTransparency(altitude*1000.0, muS, 120000.0);
}

//x - distance above surface in sun direction, x=0.5 - under the observer
//y - altitude
[numthreads(8, 8, 1)]
void ComputeSunColor(uint id: SV_GroupIndex, uint3 gId: SV_GroupID, uint3 tId: SV_GroupThreadID, uint3 dId: SV_DispatchThreadID)
{
	const float distanceRange = 400.0;//in each direction, km
	const float altitudeMax = 20.0;//km

	TexelParameters i = getParametersFromTexel(dId.xy, texSize.xy, altitudeMax, distanceRange);

	texOutput[dId.xy] = float4(GetTotalSunRadiance(i.altitude, i.muS), 0);
}

struct AerialParameters
{
	float3 uvw;
	float3 dir;
	float3 pos;
	float dist;
};

AerialParameters getAerialParametersFromTexel(uint3 texel, float3 texSize, float4x4 viewProjInv)
{
	AerialParameters o;
	o.uvw = saturate(texel / (texSize - 1));
	o.uvw.y = 1-o.uvw.y;
	float4 posCS = float4(o.uvw.xy*2-1, 0.0, 1.0);
	float4 posWS = mul(posCS, viewProjInv);	
	
	o.dist = o.uvw.z * o.uvw.z * length(posWS.xyz/posWS.w - gCameraPos.xyz);
	o.dir = normalize(posWS.xyz/posWS.w - gCameraPos.xyz);
	o.pos = gCameraPos.xyz + o.dir * o.dist;
	return o;
}

[numthreads(8, 8, 1)]
void ComputeAerialTransmittance(uint id: SV_GroupIndex, uint3 gId: SV_GroupID, uint3 tId: SV_GroupThreadID, uint3 dId: SV_DispatchThreadID)
{	
	AerialParameters i = getAerialParametersFromTexel(dId.xyz, texSize, gViewProjInv);

	float3 cameraPos = gEarthCenter + float3(0, heightHack, 0);
	float3 transmittance;
	float3 inscatterColor = GetSkyRadianceToPoint(cameraPos, cameraPos + i.dir * i.dist*0.001, 0.0/*shadow*/, gSunDir, transmittance);

	tex3DOutput[dId.xyz] = float4(inscatterColor * gAtmIntensity, 0);
	tex3DOutput2[dId.xyz] = float4(transmittance, 0);
}

technique10 tech
{
	pass skyAmbientForClouds
	{
		SetComputeShader(CompileShader(cs_5_0, ComputeSkyAmbient()));
	}
	pass sunColorForClouds
	{
		SetComputeShader(CompileShader(cs_5_0, ComputeSunColor()));
	}
	pass aerialTransmittance
	{
		SetComputeShader(CompileShader(cs_5_0, ComputeAerialTransmittance()));
	}
	pass aerialScattering
	{
		// SetComputeShader(CompileShader(cs_5_0, ComputeAerialTransmittance()));
	}
	// pass fogColorTable
	// {
		// SetComputeShader(CompileShader(cs_5_0, ComputeFogColorTableCS()));
	// }
}
