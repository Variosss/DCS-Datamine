#ifndef FOGCOMMON_HLSL
#define FOGCOMMON_HLSL

#if defined(FOG_ENABLE)

#ifdef EDGE
float3 FogDistances;
#else
static const float3 FogDistances = float3(0.0, 0.0, 0.0);
#endif

static const float MAX_EXPONENT = 60.0;

float fogCalcAttenuationLim(float a, float b, float camHeight, float dist)
{
	float d = (dist > FogDistances.x) ? (dist - FogDistances.x) : 0.0;
	float c = a * camHeight;
#ifdef EDGE
	float attByDistance = (1.0 - smoothstep(FogDistances.y, FogDistances.z, d));
#else
	const float attByDistance = 1.0;
#endif
	return exp(-b * exp(min(-c, MAX_EXPONENT)) * d) * attByDistance;
}

float fogCalcAttenuation(float a, float b, float camHeight, float dist, float cosEta)
{
	float d = (dist > FogDistances.x) ? (dist - FogDistances.x) : 0.0;

	float c = a * camHeight;
	
	float e = a * cosEta;
	float u = -b * (exp(min(-c, MAX_EXPONENT)) - exp(min(-e * d - c, MAX_EXPONENT)));

#ifdef EDGE
	float attByDistance = (1.0 - smoothstep(FogDistances.y, FogDistances.z, d));
#else
	const float attByDistance = 1.0;
#endif

	return abs(e) > 1.0e-6 ? exp(min(u / e, MAX_EXPONENT)) * attByDistance : fogCalcAttenuationLim(a, b, camHeight, dist);
}

#endif

#endif
