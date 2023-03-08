#ifndef SHADING_GRASS_HLSL
#define SHADING_GRASS_HLSL

void DecodeGBufferGrass(EncodedGBuffer i, uint2 uv, int msaaSample, out float3 Diffuse, out float3 Normal, out float Height, out float surfaceNoL)
{
	Normal		= float3(i.t0.x, 0, i.t0.y);
	Diffuse		= decodeColorYCC( float3(i.t1.x, i.t2.xy) );
	surfaceNoL	= i.t3.x;
	Height		= i.t3.y;
}

float GetForwardTranslucencyFactor(float3 sunDir, float3 viewDir, float factor)
{
	return pow(max(0, dot(-sunDir, viewDir)), factor);
}

float3 ShadeGrass(uint2 uv, float3 sunColor, float3 diffuse, float3 normal, float roughness, float translucencyAmount, float shadow, float2 cloudsShadowAO, float surfaceNoL, float AO, float3 viewDir, float3 pos, float2 energyLobe)
{
	float3 diffuseColor = GammaToLinearSpace(diffuse);
	float3 specularColor = 0.04;

	const float3 translucencyColor = float3(113/255.0, 118/250.0, 52/255.0);
	specularColor *= translucencyColor / dot(translucencyColor, 0.3333);

	float NoL = dot(normal, gSunDir);

	float translucencyMask = saturate((translucencyAmount-NoL) / (translucencyAmount+1.0));//где вообще применять проникающий свет прямой

	float shadowClear = shadow;
	shadow *= saturate(surfaceNoL*1.5);//гасим свет на скользящих углах

	const float lambertSmoothness = 1;

	float3 lightAmountSmooth = gSunIntensity * shadow * max(0, (NoL+lambertSmoothness) / (1.0 + lambertSmoothness));
	float3 lightAmountSpec   = gSunIntensity * shadow * max(0, -NoL);
	
	// diffuse sun light
	float3 finalColor = (Diffuse_lambert(diffuseColor) * sunColor) * (lightAmountSmooth * energyLobe.x);
	// translucent specular sun light
	finalColor += (ShadingSimple(diffuseColor, specularColor, roughness, normal, viewDir, gSunDir, float2(0, energyLobe.y)) * sunColor) * lightAmountSpec;

	//forward diffuse translucensy
	float transLightAmount = GetForwardTranslucencyFactor(gSunDir,viewDir, grassForwardTranslucencyFactor) * gSunIntensity * shadow * translucencyMask * translucencyAmount;
	finalColor += (diffuseColor * sunColor) * (transLightAmount * grassForwardTranslucency);

	//diffuse IBL
	EnvironmentIrradianceSample eis = SampleEnvironmentIrradianceApprox(pos, cloudsShadowAO.x, cloudsShadowAO.y);
	float3	secondaryLight = SampleEnvironmentMapApprox(eis, normal, roughness);
	//translucent diffuse IBL
	float3	secondaryLightTranslucent = SampleEnvironmentMapApprox(eis, -normal, roughness);
	finalColor += diffuseColor * (secondaryLight + secondaryLightTranslucent*(shadowClear*translucencyAmount)) * (gIBLIntensity * AO);

	//additional lighting
	finalColor += CalculateDynamicLightingTiled(uv, diffuseColor, specularColor, roughness, normal, viewDir, pos, 0, float2(1,1), 0.08);

	return finalColor;
}

#endif
