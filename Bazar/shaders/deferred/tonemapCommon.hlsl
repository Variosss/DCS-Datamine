#ifndef COMPOSECOMMON_HLSL
#define COMPOSECOMMON_HLSL

#include "deferred/DecoderCommon.hlsl"

#define TONEMAP_OPERATOR_LINEAR			0
#define TONEMAP_OPERATOR_EXPONENTIAL	1
#define TONEMAP_OPERATOR_FILMIC			2

#define TONEMAP_FLAG_COLOR_GRADING		1
#define TONEMAP_FLAG_CUSTOM_FILTER		2
#define TONEMAP_FLAG_DIRT_EFFECT		4

cbuffer cbTonemapParams {
	// 1
	float	dcExposureKey;
	float	dcSigmaKey;
	float	dcTau;
	float	dcExposureCorrection;
	// 2
	float	bloomThreshold;
	float	bloomLerpFactor;
	float	whiteBalanceFactor;
	float	vignetteFactor;
	//3
	float4	dcViewport;
	//4
	uint2	dcDims;
	float	tmExp;
	float	tmPower;

	float	sceneLuminanceMin;
	float	sceneLuminanceMax;
	float	focusWidth;
	float	focusSigma;

	//histogram:
	float	inputLuminanceMin;
	float	inputLuminanceMax;
	float	inputLuminanceRange;
	float	hwFactor;

	float	percentMin;
	float	percentMax;
	float	operatorGamma;
	float	cubeAverageLumAmount;

	float	slope;
	float	toe;
	float	shoulder;
	float	blackClip;

	float	whiteClip;
	float	LUTLogLuminanceMin;
	float	LUTLogLuminanceMax;
	float	cockpitExposureClamp;

	float2	inputLuminanceScaleOffset;
	float	outputGammaInv;
	float	tpDummy01;

	float3	bloomTint0;	float bloomIntensity0;
	float3	bloomTint1;	float bloomIntensity1;
	float3	bloomTint2;	float bloomIntensity2;
	float3	bloomTint3;	float bloomIntensity3;
	float3	bloomTint4;	float bloomIntensity4;
	float3	bloomTint5;	float bloomIntensity5;
};

TEXTURE_2D(float4, ComposedMap);
float2 viewportTransform(float2 uv) {
	return (uv*dcViewport.zw+dcViewport.xy)*dcDims;
}

#endif
