#ifndef SKY_COMMON_HLSL
#define SKY_COMMON_HLSL

#include "enlight/atmDefinitions.hlsl"
#include "enlight/atmFunctionsDcs.hlsl"
#include "enlight/materialParams.hlsl"

#include "common/fog2.hlsl"

#define SUN_ANGULAR_DIAMETER (1.0/108)

float3 SunDisc(float3 viewDir, float3 sunDir)
{
	return 1/(1+exp( (cos(SUN_ANGULAR_DIAMETER*0.5) - dot(viewDir, sunDir))*1000000 )) * gSunIntensity;
}

// direct sun light for ray x+tv, when sun in direction s (=L0)
float3 sun(float3 x, float3 v, float3 s, float r, float mu)
{
	return GetSunRadiance(x, s) * SunDisc(v, s);
}

float3 PositionInEarthSpace(float3 posInCameraSpace, float cameraHeight)
{
	// FIXME: geo terrain
	const float Rg = gEarthRadius;
	return float3(0, Rg + cameraHeight*0.001 + heightHack, 0) + posInCameraSpace.xyz*0.001;
}

void CombineFogAndAtmosphereFactors(float3 atmTransmittance, float3 atmInscatter, float3 fogTransmittance, float3 fogColour, float fogFactor, out float3 mult, out float3 add)
{
	/*
	порядок наложения тумана и атмосферы на исходный цвет:
	ColorAfterFog = fogColor * (1-a) + sourceColor * a, где a = fogCalcAttenuation(..)
	ColorAfterAtmosphere = ColorAfterFog * transmittance + inscatter
	ColorResult = ColorAfterFog * (1-b) + ColorAfterAtmosphere * b, где b = min(atmFactor, cameraHeightNorm.y)

	подставляем все в ColorResult и группируем на множител и сумму к sourceColor,
	чтобы ColorResult = sourceColor * mult + add:
	ColorResult = (fc * (1-a) + sc * a) * (1-b)   +   ((fc * (1-a) + sc * a) * t + i) * b
	ColorResult = sc * a * (1-b) + fc * (1-a) * (1-b)   +   fc * (1-a) * t * b + sc * a * t * b + i * b
	ColorResult = sc * a * (t*b + (1-b))   +   [ fc * (1-a) * (1-b) + fc * (1-a) * t * b + i * b ]
	соответственно:
	mult = a * (t*b + (1-b))
	add = fc * (1-a) * (t*b + (1-b)) + i * b
	*/

	float3 a = fogTransmittance;
	float b = fogFactor;
	float3 transmittance = atmTransmittance;
	float3 inscatterColor = atmInscatter;
	
	add = fogColour * (1-a) * (transmittance*b + (1-b)) + inscatterColor * b;
	mult = a * (transmittance * b + (1 - b));
}

void ComputeFogAndAtmosphereCombinedFactors(float3 pos, float3 cameraPos, float cameraHeight, float cameraHeightN, 
	out float3 mult, out float3 add)
{
	pos -= cameraPos;
	float dist = length(pos);
	float3 view = pos / dist;
	dist *= 0.001;

	//FIXME: geo terrain?
	pos = PositionInEarthSpace(pos, cameraHeight);

	static const float artefactDistance = 0.2;	// it prevent artifacts for GeForce on short distances

	const float atmFactor = 1;

	//туманец
	float fogTransmittance = getFogTransparency(cameraHeight, view.y, dist*1000.0);

	float3 fogClr = (gFogColor + gSunDiffuse.rgb ) * gSunIntensity * 0.1;

	float fogFactor = min(atmFactor, cameraHeightN);

	float3 transmittance;

	// cameraPos = gEarthCenter + float3(0, heightHack, 0);//можно юзать в обычных шейдерах но не в этом
	//FIXME geo terrain
	cameraPos = float3(0, gEarthRadius + cameraHeight*0.001 + heightHack, 0);//gEarthCenter тут еще не валиден

	float3 inscatterColor = GetSkyRadianceToPoint(cameraPos, pos, 0.0/*shadow*/, atmSunDirection, transmittance) * gAtmIntensity;

	CombineFogAndAtmosphereFactors(transmittance, inscatterColor, fogTransmittance, fogClr, fogFactor, mult, add);
}

//Combined sky and fog transmittance.
//cameraPos and pos in origin space, in meters
float3 GetAtmosphereTransmittance(float3 cameraPos, float3 pos)
{
	float fogFactor = 1;// TODO: должен равняться gFogCameraHeightNorm, но в эдже не посчитано!
	float3 transmittance, inscatter;
	ComputeFogAndAtmosphereCombinedFactors(pos, cameraPos, gCameraHeightAbs, fogFactor, transmittance, inscatter);
	return transmittance;
}

#endif
