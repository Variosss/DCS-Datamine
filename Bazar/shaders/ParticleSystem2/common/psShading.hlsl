#ifndef _OPS_SHADING_
#define _OPS_SHADING_

float getHaloFactor(float3 sunDirV, float3 posV, float factor = 6/*-10*/)
{
	return pow(abs(0.5+0.5*dot(sunDirV.xyz, normalize(posV))), factor);
}

float3 shading_AmbientSun(float3 baseColor, float3 ambientColor, float3 sunColor)
{
	//diffuse IBL + sun diffuse
	float3 color = baseColor * (ambientColor * (gIBLIntensity * gEffectsIBLFactor) + sunColor * gEffectsSunFactor);
	
	return color;
}

float3 shading_AmbientSunHalo(float3 baseColor, float3 ambientColor, float3 sunColor, float haloFactor)
{
	float3 color = shading_AmbientSun(baseColor, ambientColor, sunColor);
	
	color += (haloFactor * gEffectsSunFactor) * sunColor;
	
	return color;
}

float3 shading_SunHalo(float3 baseColor, float3 sunColor, float haloFactor)
{
	float3 color;
	//sun diffuse + halo
	color.rgb = (baseColor + haloFactor) * sunColor * gEffectsSunFactor;
	
	return color;
}

#endif