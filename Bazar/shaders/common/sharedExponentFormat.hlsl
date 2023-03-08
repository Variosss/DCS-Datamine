#ifndef COMMON_SHARED_EXPONENT_FORMAT_HLSL
#define COMMON_SHARED_EXPONENT_FORMAT_HLSL

// ----------------------------------------------------------------
// Custom packing of float3 into RGBA16_Uint with shared exponent
// ----------------------------------------------------------------
// Based on: https://www.khronos.org/registry/OpenGL/extensions/EXT/EXT_texture_shared_exponent.txt

static const uint exponent_bits = 7;
static const uint mantissa_bits = 19;
static const uint exp_bias = (1 << exponent_bits) / 2 - 1;

static const uint mantissa_values = (1 << mantissa_bits);
static const uint max_mantissa = (mantissa_values - 1);

static const uint exp_bias_32 = 127;

int floorLog2(float x)
{
	int biasedExponent = (asuint(x) & 0x7F800000) >> 23;
	return biasedExponent - int(exp_bias_32);
}

uint4 toRGB19E7(const float3 rgb)
{
	uint4 rgbe;
	
	float maxComponent = max(rgb.r, max(rgb.g, rgb.b));
	int expShared = max(-int(exp_bias) - 1, floorLog2(maxComponent)) + 1 + exp_bias;
	
	float denom = pow(2, expShared - int(exp_bias) - int(mantissa_bits));
	
	int maxMantissa = floor(maxComponent / denom + 0.5);
	if (maxMantissa == (max_mantissa + 1))
	{
		denom *= 2;
		expShared += 1;
	}
	
	uint3 rgbMantissa = uint3(floor(rgb / denom + 0.5));
	
#if 1
	// Pack to match storage format
	rgbe.rgb = (rgbMantissa >> 3) & 0xFFFF;
	rgbe.a = 
		  ((rgbMantissa.r << 13) & 0xE000)
		| ((rgbMantissa.g << 10) & 0x1C00)
		| ((rgbMantissa.b << 7) & 0x0380)
		| (expShared & 0x007F);
#else
	rgbe.rgb = rgbMantissa;
	rgbe.a = expShared;
#endif
	
	return rgbe;
}

float3 fromRGB19E7(uint4 packedRGBE)
{
	uint4 rgbe;
#if 1
	// Unpack from storage
	rgbe.rgb = uint3(
		((packedRGBE.r << 3) & 0x7FFF8) | ((packedRGBE.a >> 13) & 0x7),
		((packedRGBE.g << 3) & 0x7FFF8) | ((packedRGBE.a >> 10) & 0x7),
		((packedRGBE.b << 3) & 0x7FFF8) | ((packedRGBE.a >> 7) & 0x7)
	);
	rgbe.a = (packedRGBE.a & 0x007F);
#else
	rgbe = packedRGBE;
#endif
	
	// Convert back to float32
	int exponent = int(rgbe.a) - int(exp_bias) - int(mantissa_bits);
	float scale = (float)pow(2, exponent);

	return float3(rgbe.rgb) * scale;	
}

uint2 packUint16(uint4 v)
{
	return uint2(
		((v.x << 16) & 0xFFFF0000) | (v.y & 0x0000FFFF),
		((v.z << 16) & 0xFFFF0000) | (v.w & 0x0000FFFF)
	);
}

uint4 unpackUint16(uint2 v)
{
	return uint4(
		(v.x >> 16) & 0xFFFF,
		(v.x) & 0xFFFF,
		(v.y >> 16) & 0xFFFF,
		(v.y) & 0xFFFF
	);
}

#endif // COMMON_SHARED_EXPONENT_FORMAT_HLSL