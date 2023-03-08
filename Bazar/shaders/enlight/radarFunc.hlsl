#ifndef RADARFUNC_HLSL
#define RADARFUNC_HLSL

static const float2 uipo[] = {
	{ 0.0398,  0.0631},			// forest, summer {-14, -12} dB
	{ 0.0251, 0.00501},			// steppe, summer, grass {-16, -23} dB
	{ 0.00501,  0.001},			// steppe, winter, snow {-23, -30} dB
	{ 0.0316,  0.0316},			// desert, sand, rocks {-15, -15} dB
	{ 0.0001,   0.001},			// concrete, asphalt, runway, road {-40, -30} dB
	{ 0.0001,   0.000631},		// sea 2 points {-40, -32} dB
	{ 0.000316, 0.001},			// sea 6 points {-35, -30} dB
};

float rand(float2 co) {
	return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
}

float radarRnd(float3 wpos) {
	return clamp(rand(float2(wpos.x, wpos.y + wpos.z) * 0.001), 0.001, 0.999);
}

float radarPhisicalValue(float3 V, float3 N, float m, float S, float R, float rnd) {
	const float Ptx = 500;
	const float po = 0.035;

	float epr = m * max(dot(V, N), 0) * S;

	float z = sqrt(-2 * epr*epr * log(rnd));

	return po * Ptx / pow(R, 4) * z;
}

float radarValue(float3 radarPos, float3 wpos, float3 normal, float m) {
	float3 V = radarPos - wpos;
	float R = length(V);	// distance 
	V /= R;
	R *= 0.001;

	float rnd = radarRnd(wpos);	// rnd [0..1]
	return radarPhisicalValue(V, normal, m, R, R, rnd);
}

float radarCornerReflector(float3 radarPos, float3 wpos, float intensity) {		
	float3 V = radarPos - wpos;
	float R = length(V);	
	V /= R;
	R *= 0.001;

	float m = intensity * 0.2;

	float rnd = radarRnd(wpos);	// rnd [0..1]
	return radarPhisicalValue(V, float3(0,1,0), m, R, R, rnd);
}

#endif
