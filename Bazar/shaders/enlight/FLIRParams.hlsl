#ifndef FLIRPARAMS_HLSL
#define FLIRPARAMS_HLSL

#define FLIR_WATER				0
#define FLIR_COUNT				1

cbuffer cbFLIRParams: register(b4) 
{
	float4	flirFactor[FLIR_COUNT];
	float	flirDayNightLerp; // 0

	float3 flirDummy;
};

float adjustFLIR(float v, uint id) {
	float4 f = flirFactor[id];
	float dc = lerp(v, 1 - v, f[0]) * f[1];	// day value
	float nc = lerp(v, 1 - v, f[2]) * f[3];	// night value
	return lerp(dc, nc, flirDayNightLerp);
}

float adjustFLIR(float v, float4 factor) {
	float dc = lerp(v, 1 - v, factor[0]) * factor[1];	// day value
	float nc = lerp(v, 1 - v, factor[2]) * factor[3];	// night value
	return lerp(dc, nc, flirDayNightLerp);
}

float adjustFLIR(float3 v3, uint id) {
	float v = dot(v3, float3(0.3333, 0.3333, 0.3333));
	return adjustFLIR(v, id);
}

float adjustFLIR(float3 v3, float4 factor) {
	float v = dot(v3, float3(0.3333, 0.3333, 0.3333));
	return adjustFLIR(v, factor);
}


#endif
