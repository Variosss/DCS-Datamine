#ifndef FOG_FXH
#define FOG_FXH

#if defined(FOG_ENABLE)

#include "common/fogCommon.hlsl"
#include "common/samplers11.hlsl"

// Coefficients are alpha, beta.
#ifdef CONTEXT_HLSL
	#define FogCoefficients gFogCoeffs
	#define FogColor		gFogColor
	#define FogCamHeight	gCameraHeightAbs
#else
	float4 FogCoefficients;
	float4 FogColor;// rgb - layered fog color, a - camHeight
	#define FogCamHeight FogColor.a
#endif

#ifdef MATERIALPARAMS
	#define FogMap skyTex2
#else
	Texture2D FogMap;
#endif

// Calculates attenuation due to fog.
// camPos - camera position in world space
// objPos - object position in world space
// projPos - object position multiplied by view projection matrix
// objColor - color of object
void fogApply(float3 camPos, float3 objPos, float4 projPos, inout float3 objColor, float distanceFactor=1)
{
	float dist = distance(camPos, objPos) * distanceFactor;
	
	// calculate cos(eta)
	float3 dir = normalize(objPos - camPos);
	float cosEta = dir.y;

	// attenuation
	float attD = fogCalcAttenuation(FogCoefficients.x, FogCoefficients.y, FogCamHeight, dist, cosEta);
#ifndef EDGE
	float attL = fogCalcAttenuation(FogCoefficients.z, FogCoefficients.w, FogCamHeight, dist, cosEta);
#else
	const float attL = 1.0;
#endif

	float4 tc;
#ifdef EDGE
	// В EDGE иначе реализован рендер неба, поэтому для
	// совместимости с lockon шейдерами необходимо иначе
	// считать координаты для тумана.
	tc.x = -0.5f * (projPos.x + projPos.w);
#else
	tc.x = 0.5f * (projPos.x + projPos.w);
#endif
	tc.y = -0.5f * (projPos.y + projPos.w);	
	tc.z = projPos.z;
	tc.w = projPos.w;

#ifdef EDGE
	float4 fogSky = FogMap.Sample(WrapLinearSampler, tc.xy/projPos.w);
	fogSky.rgb *= fogSky.a;
#else
	float3 fogSky = FogMap.Sample(WrapLinearSampler, tc.xy/projPos.w).rgb;
#endif

	objColor = lerp(FogColor.rgb, objColor, attL);
	objColor = lerp(fogSky.rgb, objColor, attD);
}

// Calculates attenuation due to layered fog not haze.
// camPos - camera position in world space
// objPos - object position in world space
// objColor - color of object
void fogApplyLayered(float3 camPos, float3 objPos, inout float3 objColor)
{
#ifndef EDGE
	float dist = distance(camPos, objPos);
	
	// calculate cos(eta)
	float3 dir = normalize(objPos - camPos);
	float cosEta = dir.y;

	// attenuation
	float attL = fogCalcAttenuation(FogCoefficients.z, FogCoefficients.w, FogCamHeight, dist, cosEta);
	
	objColor = lerp(FogColor.rgb, objColor, attL);
#endif
}

// Calculates attenuation due to fog.
// camPos - camera position in world space
// objPos - object position in world space
float fogGetAttenuation(float3 camPos, float3 objPos)
{
	float dist = distance(camPos, objPos);
	
	// calculate cos(eta)
	float3 dir = normalize(objPos - camPos);
	float cosEta = dir.y;

	// attenuation
	float attD = fogCalcAttenuation(FogCoefficients.x, FogCoefficients.y, FogCamHeight, dist, cosEta);
#ifndef EDGE
	float attL = fogCalcAttenuation(FogCoefficients.z, FogCoefficients.w, FogCamHeight, dist, cosEta);
#else
	const float attL = 1.0;
#endif
	return attD * attL;
}

// Calculates attenuation due to layered fog not haze.
// camPos - camera position in world space
// objPos - object position in world space
float fogGetLayeredOnlyAttenuation(float3 camPos, float3 objPos)
{
#ifndef EDGE
	float dist = distance(camPos, objPos);
	
	// calculate cos(eta)
	float3 dir = normalize(objPos - camPos);
	float cosEta = dir.y;

	// attenuation
	float attL = fogCalcAttenuation(FogCoefficients.z, FogCoefficients.w, FogCamHeight, dist, cosEta);
	return attL;
#else
	return 1.0;
#endif
}

#else

void fogApply(float3 camPos, float3 objPos, float4 projPos, inout float3 objColor)
{
}

// Calculates attenuation due to fog.
float fogGetAttenuation(float3 camPos, float3 objPos)
{
	return 1.0;
}

#endif

#endif
