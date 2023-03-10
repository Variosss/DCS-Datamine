#ifndef CONTEXT_HLSL
#define CONTEXT_HLSL

#define MAX_SHADOWMAP_COUNT 10

//в соответствии со структурой PerFrameData в сontext.cpp
cbuffer cPerFrame: register(b6)
{
	float  gModelTime;		float gCivilLightsAmount;	float gSunIntensity;	float gIBLIntensity;
	float3 gSunDiffuse;		float gDummy08;
	float3 gSunAmbient;		float gAtmIntensity;
	float3 gSunDir;			float gSunAttenuation;
	float3 gMoonDiffuse;	float gEffectsIBLFactor;
	float3 gMoonDir;		float gSeaLevel;
	float3 gSreenParams;	float gEffectsSunFactor;

	float4 gFogCoeffs;
	float3 gFogColor;		float gAtmGroundReflectanceAvg;

	float gModelEmissiveIntensity;
	float gTerrainEmissiveIntensity;
	float gUseVolumetricClouds;
	float gUseVolumetricCloudsShadow;

	// Rayleigh
	float3 gAtmBetaR;		float gAtmHR;
	// Mie
	float3 gAtmBetaMSca;	float gAtmHM;
	float3 gAtmBetaMExt;	float gAtmMieG;
	// Absorption (ozone)
	float3 gAtmBetaAExt;	float gAtmAbsorptionFactor;
	float3 gAtmScaToMie;	float gDummy02;

	struct
	{
		float atmosphereFactor;
		float volumetricCloudsFactor;
		float cirrusCloudsFactor;
		float sunMoonFactor;
	} gIceHaloParams;
	
	struct
	{
		float2 rainbowPolarizationFactors; 
		float  rainbowFactor; 
		float  gloryFactor;
	} gRainbowGloryParams;

	float gEarthRadius;     float amtTopRadius; float dummy04; float dummy05; 

	float4x4 gCockpitPosition, gCockpitTransform;
	float3	gCockpitCubemapPos;	float gDummy03;
	float3	gCockpitElipsoid;	float gDummy06;
	float3	gCockpitElipsoidGlassReflection;	float gDummy07;
	float4	gCockpitIBL;
	float4	gCockpitIcing;
	//cockpit indirect light volume
	float3 gILVBBMin;		float gILVSunFactor;
	float3 gILVBBSizeInv;	float gILVSkyFactor;
	uint3  gILVGridSize;	float gCloudiness;

	float  gOutputGamma;	float gOutputGammaInv;	uint COVERAGE_MASK;	float gDummy01;

	float4 gDev0;
	float4 gDev1;
};

#define gScreenWidth		gSreenParams.x
#define gScreenHeight		gSreenParams.y
#define gScreenAspect		gSreenParams.z



//в соответствии со структурой PerViewData в сontext.cpp
cbuffer cPerView: register(b7)
{
	float4x4 gLocal, gLocalInv;
	float4x4 gView, gViewInv;
	float4x4 gProj, gProjInv;
	float4x4 gViewProj, gViewProjInv;
	float4x4 gPrevFrameTransform;
	float4x4 gPrevFrameViewProj;
	float4x4 gCloudShadowsProj;	//clouds shadows matrix
	float4x4 gTerrainShadowMatrix;
	float4x4 gTerrainMaskMatrix;
	float4x4 gSecondaryShadowmapMatrix[MAX_SHADOWMAP_COUNT];
	float4x4 gClipCockpit;		// clipping in cockpit

	float3	 gSunDirV;		float gModelClipLevel;	// в СК камеры, gModelClipLevel == gSeaLevel for REFLECTION pass
	float3	 gOrigin;		float gCameraHeightAbs;// abs(мировая высота камеры)
	float3	 gCameraPos;	float gFogCameraHeightNorm;//нормализованная высота камера по высоте тумана
	float3	 gMoonDirV;		float gPrevFrameTimeDelta;
	float4	 gNearFarFovZoom; // near, far, fov, fov/60grad

	float3   gSurfaceNormal; float gSurfaceNdotL;

	float3	 gEarthCenter;	float gExposure;

	float2	 gNVDpos;		float gNVDaspect;	float gInsideCockpit;

	float3	gRadarPos;		float	gRadarPixelSize;
	uint2	gTargetDims;	float	 gCloudsLow, gCloudsHigh;

	float3	gCloudVolumeScale;	float gMipLevelBias;
	float3	gCloudVolumeOffset;	float gFlatShadowAlpha;

	float4	 ShadowDistance;
	float4	 ShadowLinearDistance;
	float4x4 ShadowMatrix[4];
	float4x4 ShadowMatrixInv[4];
	float3	 ShadowLightDir;			float ShadowMapSize;
	float4	 FlatShadowDistance;
	float	 ShadowCascadeFadeDepth;	
	uint	 ShadowFirstMap;
	float2	 ShadowDummy;	
};

#define gNearClip	gNearFarFovZoom.x
#define gFarClip	gNearFarFovZoom.y
#define gFov		gNearFarFovZoom.z
#define gZoom		gNearFarFovZoom.w

void clipInCockpit(float3 pos) {
	float4 p = mul(float4(pos, 1), gClipCockpit);
	clip(-!any(step(1, abs(p.xyz/p.w))));
}

#endif
