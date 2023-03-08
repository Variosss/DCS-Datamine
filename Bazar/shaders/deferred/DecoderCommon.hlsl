#ifndef DECODER_COMMON_HLSL
#define DECODER_COMMON_HLSL

#ifdef MSAA
	#define TEXTURE_2D(type, name) Texture2DMS<type, MSAA> name
    #define	SampleMap(name, uv, idx)  name.Load(uint2(uv), idx)
	#define TEXTURE_2D_ARRAY(type, name) Texture2DMSArray<type, MSAA> name
    #define	SampleMapArray(name, uv, slice, idx)  name.Load(uint3(uv, slice), idx)

#if MSAA == 2
	static const float2 MSAA_OFFSET[2] = { float2(4.0/8, -4.0/8), float2(-4.0/8, 4.0/8) };
#elif MSAA == 4
	static const float2 MSAA_OFFSET[4] = { float2(-2.0/8, 6.0/8), float2(6.0/8, 2.0/8), float2(-6.0/8, -2.0/8), float2(2.0/8, -6.0/8) };
#endif

#else
	#define TEXTURE_2D(type, name) Texture2D<type> name
    #define	SampleMap(name, uv, idx)  name.Load(uint3(uv, 0))
	#define TEXTURE_2D_ARRAY(type, name) Texture2DArray<type> name
    #define	SampleMapArray(name, uv, slice, idx)  name.Load(uint4(uv, slice, 0))
#endif

#endif

