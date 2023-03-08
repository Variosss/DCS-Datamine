#ifndef NOISE_COMMON
#define NOISE_COMMON

float mod289(float x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0; 
}

float2 mod289(float2 x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0;
}

float3 mod289(float3 x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0; 
}

float4 mod289(float4 x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0; 
}

float permute(float x) {
	return mod289(((x*34.0)+1.0)*x);
}

float3 permute(float3 x) {
	return mod289(((x*34.0)+1.0)*x);
}

float4 permute(float4 x) {
	return mod289(((x*34.0)+1.0)*x);
}

float4 taylorInvSqrt(float4 r) {
	return 1.79284291400159 - 0.85373472095314 * r;
}

float taylorInvSqrt(float r) {
	return 1.79284291400159 - 0.85373472095314 * r;
}

float4 grad4(float j, float4 ip)
  {
  const float4 ones = float4(1.0, 1.0, 1.0, -1.0);
  float4 p,s;

  p.xyz = floor( frac (j * ip.xyz) * 7.0) * ip.z - 1.0;
  p.w = 1.5 - dot(abs(p.xyz), ones.xyz);
  s = float4(1 - step(0.0, p));
  p.xyz = p.xyz + (s.xyz*2.0 - 1.0) * s.www; 

  return p;
  }
						
// (sqrt(5) - 1)/4 = F4, used once below
#define F4 0.309016994374947451

float3 mod(float3 x, float3 y) {
	return x - y * floor(x/y);
}

float4 mod(float4 x, float4 y) {
	return x - y * floor(x/y);
}

float2 fade(float2 t) {
	return t*t*t*(t*(t*6.0-15.0)+10.0);
}

float3 fade(float3 t) {
	return t*t*t*(t*(t*6.0-15.0)+10.0);
}

float4 fade(float4 t) {
	return t*t*t*(t*(t*6.0-15.0)+10.0);
}



#endif
