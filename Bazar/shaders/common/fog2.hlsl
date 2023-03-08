#ifndef FOG_NEW_HLSL
#define FOG_NEW_HLSL

#if defined(FOG_ENABLE)

#include "common/fogCommon.hlsl"

void getFogViewDist(float3 cameraPos, float3 pos, out float3 view, out float dist)
{
	view = pos - cameraPos;
	dist = length(view);
}

float getFogTransparency(float heightAboveGround, float mu, float dist)
{
	return fogCalcAttenuation(gFogCoeffs.z, gFogCoeffs.w, heightAboveGround, dist, mu);
}

float getFogTransparency(float3 cameraPos, float3 pos)
{
#ifndef EDGE
	float3 view;
	float dist;
	getFogViewDist(cameraPos, pos, view, dist);
	
	return getFogTransparency(cameraPos.y+gOrigin.y, view.y/dist, dist);
#else
	return 1.0;
#endif
}

float3 applyFog(float3 color, float3 view, float dist, uniform bool bSky = false)
{
#ifdef USE_DCS_DEFERRED
	float3 fogClr = (gFogColor + gSunDiffuse.rgb ) * gSunIntensity * 0.1; //+ max(0, gMoonDir.y) * float3(9, 26, 52) / 255.0*0.1
#else
	float3 fogClr = gFogColor;
#endif
	float fogTransparency = getFogTransparency(gCameraHeightAbs, view.y, dist);

	if(bSky)
		return lerp(fogClr, color, max(fogTransparency, gFogCameraHeightNorm));
	else
		return lerp(fogClr, color, fogTransparency);
}

float3 applyFog(float3 color, float3 cameraPos, float3 pos)
{
	float3 view;
	float dist;
	getFogViewDist(cameraPos, pos, view, dist);
	return applyFog(color, view/dist, dist, false);
}

#else

float getFogTransparency(float3 cameraPos, float3 pos)
{
	return 1.0;
}

float getFogTransparency(float heightAboveGround, float dist, float mu)
{
	return 1.0;
}

float3 applyFog(float3 color, float3 view, float dist, uniform bool bSky = false)
{
	return color;
}

float3 applyFog(float3 color, float3 cameraPos, float3 pos)
{
	return color;
}

#endif

#endif
