#ifndef ENVIRONMENT_CUBE_HLSL
#define ENVIRONMENT_CUBE_HLSL

#define USE_COCKPIT_CUBEMAP 1
#define USE_DEBUG_COCKPIT_CUBEMAP 0
#define USE_BRDF_K 0

TextureCube environmentMap: 	register(t123);
TextureCube environmentCockpitMap: 	register(t100);
Texture2D   SSLRMap:			register(t98);

float3 EnvBRDFApproxK(float3 specularColor, float roughness, float NoV, float k) {
	float3 brdf = EnvBRDFApprox(specularColor, roughness, NoV);
	float f = (1 - exp(-NoV)) * 2.71828182846;	// integral [0..1] of it = 1
	return brdf * lerp(1, f, k);
}

static const float environmentMipsCount = 8.0;

#define LERP_ENV_MAP 0
#define FAR_ENV_MAP  1
#define NEAR_ENV_MAP 2

#define USE_DEBUG_ENV_MAP 0

float getMipFromRoughness(float roughness, float mipsCount) {
	return (mipsCount - 0.999) * log2(roughness + 1.0);
}

float getRoughnessFromMip(float mip, float mipsCount) {
	return exp2(mip / (mipsCount - 0.999)) - 1;
}

float3 SampleEnvironmentMapDetailed(float3 normal, float mip) {
#if USE_DEBUG_ENV_MAP
	return float3(1, 0, 0)
#else
	float3 env = environmentMap.SampleLevel(gTrilinearClampSampler, normal, mip).rgb;
//	env = GammaToLinearSpace(env);
	return env;
#endif
}

float3 SampleEnvironmentMap(EnvironmentIrradianceSample eis, float3 normal, float roughness, float mip, uniform uint selectEnvCube = NEAR_ENV_MAP, float lerpEnvCubeFactor = LERP_ENV_MAP) {
#if USE_DEBUG_ENV_MAP
	switch (selectEnvCube) {
	case LERP_ENV_MAP:
		return lerp(float3(0, 1, 0), float3(1, 0, 0), lerpEnvCubeFactor);
	case FAR_ENV_MAP:
		return float3(0, 1, 0);
	case NEAR_ENV_MAP:
		return float3(1, 0, 0);
	}
#else
	switch (selectEnvCube) {
	case LERP_ENV_MAP:
		return lerp(SampleEnvironmentMapApprox(eis, normal, roughness), SampleEnvironmentMapDetailed(normal, mip), lerpEnvCubeFactor);
	case FAR_ENV_MAP:
		return SampleEnvironmentMapApprox(eis, normal, roughness);
	case NEAR_ENV_MAP:
		return SampleEnvironmentMapDetailed(normal, mip);
	}
#endif
	return float3(1, 0, 1);	// wrong value
}

float3 SampleEnvironmentMap(float3 pos, float3 normal, float roughness, uniform uint selectEnvCube = NEAR_ENV_MAP, float lerpEnvCubeFactor = LERP_ENV_MAP)
{
	float mip = getMipFromRoughness(roughness, environmentMipsCount);
	float2 cloudShadowAO = SampleShadowClouds(pos);
	EnvironmentIrradianceSample eis = SampleEnvironmentIrradianceApprox(pos, cloudShadowAO.x, cloudShadowAO.y);
	return SampleEnvironmentMap(eis, normal, roughness, mip, selectEnvCube, lerpEnvCubeFactor);
}

float rayIntersectEllipsoid(float3 pos, float3 ray, float3 size) {
	float3 osb = 1.0 / (size * size);
	float a = dot(ray * ray, osb);
	float b = 2.0 * dot(pos * ray, osb);
	float c = dot(pos * pos, osb) - 1.0;
	float d = b * b - 4.0 * a * c;
	if (d <= 0)					// does not intersect
		return 0;

	float t = -0.5 * (b + sign(b) * sqrt(d));
	return max(t / a, c / t);	// return far result
}

float3 SampleCockpitCubeMapMip(float3 wPos, float3 wRay, float mip, uniform bool glassReflectionClip = false) {
	float4 cPos = mul(float4(wPos, 1), gCockpitTransform);	// position in cockpit space
	cPos.xyz -= gCockpitCubemapPos;

	#if USE_DEBUG_COCKPIT_CUBEMAP 
		if (gDev1.z > 0.5)
			return environmentCockpitMap.SampleLevel(gTrilinearClampSampler, cPos.xyz, 0).xyz;
	#endif

	float3 cRay = normalize(mul(wRay, (float3x3)gCockpitTransform));
	float dist = rayIntersectEllipsoid(cPos.xyz, cRay, gCockpitElipsoid); // front, up, left

	if (dist <= 0)
	#if 0
		return float3(1, 0, 0);
	#else
		dist = 1;
	#endif
	//	return float3(saturate(dist*0.5), 0, 0);
	float3 cp = cPos.xyz + cRay * dist;
#if 0	// adaptive mip by distance
	mip = lerp(mip*0.5, mip, saturate(dist*0.5));
#endif
	float3 c = environmentCockpitMap.SampleLevel(gTrilinearClampSampler, cp, mip).xyz;

	if (glassReflectionClip) {
		float l = max(0, length(cPos.xyz/gCockpitElipsoidGlassReflection) - 1);
		c = lerp(SampleEnvironmentMapDetailed(wRay, mip), c, exp(-l * 5));
	}

	return c;
}

float3 SampleCockpitCubeMap(float3 wPos, float3 wRay, float roughness) {
	float mip = getMipFromRoughness(roughness, environmentMipsCount);
	return SampleCockpitCubeMapMip(wPos, wRay, mip);
}

#endif
