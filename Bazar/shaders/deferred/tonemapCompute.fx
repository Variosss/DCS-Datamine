#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "deferred/tonemapCommon.hlsl"

RWTexture1D<float>			tonemapLUTOutput;
RWTexture3D<float4>			composedLUTOutput;

#define KERNEL_SIZE			16

#define THREADS_X			KERNEL_SIZE
#define THREADS_Y			KERNEL_SIZE

float Curve(float c0, float c1, float ca, float curveSlope, float X)
{
	float t = 1 + c1 - c0;
	return 2*t / (1 + exp((2*curveSlope/t) * (X - ca))) - c1;
}

float TonemapFilmic(float logLuminance)
{	
	float ta = (1-toe - 0.18) / slope - 0.733;
	float sa = (shoulder - 0.18) / slope - 0.733;
	
	float t = 1 + blackClip - toe;
	float s = 1 + whiteClip - shoulder;	
	
	if(logLuminance < ta)
		return Curve(toe, blackClip, ta, -slope, logLuminance);
	else if(logLuminance < sa)
		return slope * (logLuminance + 0.733) + 0.18;
	else
		return 1 - Curve(shoulder, whiteClip, sa, slope, logLuminance);
}

float3 ToneMap_Filmic_Unrealic(float3 linearColor)
{
	float3 outColor;
	float3 logColor = log10(linearColor);

	outColor.r = TonemapFilmic(logColor.r);
	outColor.g = TonemapFilmic(logColor.g);
	outColor.b = TonemapFilmic(logColor.b);

	return outColor;
}

[numthreads(256, 1, 1)]
void csTonemapLUT(uint3 dId: SV_DispatchThreadId)
{
	const float lutSizeInv = 1.0 / 255.0;
	const uint pixel = dId.x;

	float logLuminance = LUTLogLuminanceMin + float(pixel) * lutSizeInv * (LUTLogLuminanceMax - LUTLogLuminanceMin);

	tonemapLUTOutput[pixel] = pow(max(0,TonemapFilmic(logLuminance)), operatorGamma);
}

technique10 LUTCompute
{
	pass tonemapLUT
	{
		SetComputeShader(CompileShader(cs_5_0, csTonemapLUT()));
	}
}
