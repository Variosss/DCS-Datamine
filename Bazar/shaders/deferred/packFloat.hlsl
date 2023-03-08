#ifndef PACKFLOAT_HLSL
#define PACKFLOAT_HLSL

float packFloat1Bit(float v, bool bit) {
	return min(v, 1)*(127 / 255.0) + bit*(128 / 255.0);
}

float unpackFloat1Bit(float v) {
	// bool bit = v > 0.5;
	return fmod(v, 128 / 255.0) * 255.0 / 127;
}

#endif
