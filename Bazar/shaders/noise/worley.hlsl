#ifndef WORLEY_HLSL
#define WORLEY_HLSL

float hash(float n) {
 	return frac(cos(n*89.42)*343.42);
}

float2 hash2(float2 n) {
 	return float2(hash(n.x*23.62-300.0+n.y*34.35), hash(n.x*45.13+256.0+n.y*38.89)); 
}

float worley(float2 c) {
    float d = 1.0;
	[unroll]
    for(int x = -1; x <= 1; x++)
		[unroll]
        for(int y = -1; y <= 1; y++){
            float2 p = floor(c) + float2(x,y);
            d = min(d, length(hash2(p) + float2(x,y) - frac(c)));
        }
    return d;
}

float worley(float2 c, float time) {
    float d = 1.0;
	[unroll]
    for(int x = -1; x <= 1; x++)
		[unroll]
        for(int y = -1; y <= 1; y++){
			float2 p = floor(c) + float2(x, y);
            float2 a = hash2(p) * time;
            float2 rnd = 0.5+sin(a)*0.5;
            d = min(d, length(rnd+float2(x,y)-frac(c)));
        }
    return d;
}

float worley(float2 c, float time, uniform uint sampleCount) {
    float w = 0.0;
    float a = 0.5;
	[unroll]
    for (uint i = 0; i<sampleCount; i++) {
        w += worley(c, time)*a;
        a*=0.5;
        c*=2.0;
        time*=2.0;
    }
    return w;
}


float worley(float2 c, uniform uint sampleCount) {
	float w = 0.0;
	float a = 0.5;
	[unroll]
	for (uint i = 0; i < sampleCount; i++) {
		w += worley(c)*a;
		a *= 0.5;
		c *= 2.0;
	}
	return w;
}


#endif


