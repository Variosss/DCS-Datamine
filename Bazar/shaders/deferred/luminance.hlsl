#ifndef LUMINANCE_HLSL
#define LUMINANCE_HLSL

#define LUMINANCE_WITHOUT_ADAPTATION	0	// deprecated, don't use it
#define LUMINANCE_AVERAGE				1
#define EXPOSURE_AVERAGE				2 //TODO: compute it
#define EXPOSURE_CLAMPED				3 //TODO: compute it
#define LUMINANCE_VIEWPORT_0			4

#endif

#ifdef WRITE_LUMINANCE

#ifndef LUMINANCE_WRITE_HLSL
#define LUMINANCE_WRITE_HLSL

RWStructuredBuffer<float2>	luminanceResult;
RWStructuredBuffer<float2>	luminanceResultCockpit;
#endif

#elif !defined(LUMINANCE_READ_HLSL) // if read luminance
#define LUMINANCE_READ_HLSL

StructuredBuffer<float2>	avgLuminance;
StructuredBuffer<float2>	avgLuminanceCockpit;

float getAverageLuminance()
{
	return avgLuminance[LUMINANCE_AVERAGE].x;
}

float getExposure()
{
	return avgLuminance[EXPOSURE_AVERAGE].x;
}

float getExposureClamped()
{
	return avgLuminance[EXPOSURE_CLAMPED].x;
}

float getAverageLuminanceCockpit()
{
	return avgLuminanceCockpit[LUMINANCE_AVERAGE].x;
}

float getExposureCockpit()
{
	return avgLuminanceCockpit[EXPOSURE_AVERAGE].x;
}

float getExposureClampedCockpit()
{
	return avgLuminanceCockpit[EXPOSURE_CLAMPED].x;
}

#endif
