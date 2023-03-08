#ifndef DEFERRED_COMMON_HLSL
#define DEFERRED_COMMON_HLSL

float3 LDRtoHDR(float3 color) {
	return pow(abs(color), 2.2)/(0.38317*0.3*gAtmIntensity);
}

float3 HDRtoLDR(float3 color) {
	return pow(abs(color)*(0.38317*0.3*gAtmIntensity), 1/2.2);
}

float3 GammaToLinearSpace(float3 color)
{
	return pow(abs(color), 2.2);
}

float3 LinearToGammaSpace(float3 color)
{
	return pow(abs(color), 1.0/2.2);
}

float3 CoarseGammaToLinearSpace(float3 color)
{
	return color * color;
}

float4 CoarseGammaToLinearSpace(float4 color)
{
	return color * color;
}

float3 CoarseLinearToGammaSpace(float3 color)
{
	return sqrt(color);
}

float4 CoarseLinearToGammaSpace(float4 color)
{
	return sqrt(color);
}

float3 LinearToScreenSpace(float3 color)
{
	return pow(abs(color), gOutputGammaInv);
}

float3 ScreenSpaceToLinear(float3 color)
{
	return pow(abs(color), gOutputGamma);
}

#define DEPTH_COVERAGE_TEST 4e-5

#endif
