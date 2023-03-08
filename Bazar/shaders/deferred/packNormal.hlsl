#ifndef PACKNORMAL_HLSL
#define PACKNORMAL_HLSL

//#define NORMAL_STEREOGRAPHIC 1
//#define NORMAL_ZLESS 1 
#define NORMAL_HEMIOCT 1

#if NORMAL_STEREOGRAPHIC

float2 packNormal(float3 n) {
	return n.xy/(1-n.z);
}

float3 unpackNormal(float2 n) {
	float d = dot(n, n);
	return float3(2*n, d-1)/(d+1);
}

#elif NORMAL_ZLESS

float2 packNormal(float3 n) {
	return n.xy;
}

float3 unpackNormal(float2 n) {
	return float3(n, -sqrt(max(1-dot(n, n), 0)));
}

#elif NORMAL_HEMIOCT

float2 packNormal(float3 v) {
	float2 p = v.xy / (abs(v.x) + abs(v.y) - v.z);
	return float2(p.x + p.y, p.x - p.y);
}

float3 unpackNormal(float2 e) {
	float2 temp = float2(e.x + e.y, e.x - e.y) * 0.5;
	return float3(temp, abs(temp.x) + abs(temp.y) - 1);	// normalize it!
}

#endif


#endif
