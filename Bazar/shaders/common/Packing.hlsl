#ifndef COMMON_PACKING_HLSL
#define COMMON_PACKING_HLSL

//--------------------------------------------------------------------------
// U24 U8  <->  U32
//--------------------------------------------------------------------------
// пакуем uint24 и uint8 в uint32; i24=[0;16777215]  i8=[0;255]
uint packUI24UI8(in uint i24,in uint i8)
{
	return i24*256+i8;
}

void unpackUI24UI8(in uint packedUI, out uint i24, out uint i8)
{
	i24 = packedUI*0.00390625;//  /256;
	i8 = fmod(packedUI, 256);
	return;
}


//--------------------------------------------------------------------------
// U16 F32  <->  U32
//--------------------------------------------------------------------------
// если на вход идет u32 не забыть отклампить! u16 = (u32 & 0xffff)
uint pack_U16F32_to_U32(in uint u16, in float f32)
{
	uint f16 = f32tof16(f32);
	return (f16 << 16) | (u16);
}

void unpack_U16F32_from_U32(in uint packedU32, out uint u16, out float f32)
{
	u16 = packedU32 & 0xffff;
	f32 = f16tof32(packedU32>>16);
}


//--------------------------------------------------------------------------
// U16 F32  <->  F32
//--------------------------------------------------------------------------
// если на вход идет u32 не забыть отклампить! u16 = (u32 & 0xffff)
float pack_U16F32_to_F32(in uint u16, in float f32)
{
	return asfloat( pack_U16F32_to_U32(u16, f32) );
}

void unpack_U16F32_from_F32(in float packedf32, out uint u16, out float f32)
{
	unpack_U16F32_from_U32(asuint(packedf32), u16, f32);
}


//--------------------------------------------------------------------------
// F16 F16  <->  UI32
//--------------------------------------------------------------------------
//'val' will be clamped to 65504!
uint pack_F16F16_to_UI32(float2 val)
{
	uint2 u16 = f32tof16(val);
	return (u16.x << 16) | (u16.y);
}

float2 unpack_F16F16_from_UI32(uint val)
{
	return float2(f16tof32(val >> 16), f16tof32(val));
}

#endif
