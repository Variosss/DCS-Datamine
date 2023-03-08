#ifndef BC_HLSL
#define BC_HLSL

float3 sigmoid(float3 x, float k) {
	x = 0.5 - x; 
	float3 s = sign(x);
	x = saturate(abs(x) * 2.0);
	return s * x / (x * (k - 1.0) - k) * 0.5 + 0.5;
}

float3 BC(float3 src, float brightness, float contrast) {
	float b = (brightness - 0.5) * 2;
	float3 c3 = lerp(src, (sign(b) + 1)*0.5, abs(b));
	c3 = sigmoid(c3, 1.0 / (contrast + 1e-6) - 1);
	return c3;
}

float3 BCM(float3 src, float brightness, float contrast, float multiplyer) {
	return BC(src, brightness, contrast) * multiplyer;
}

#endif