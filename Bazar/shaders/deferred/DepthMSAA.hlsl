#ifndef DEPTHMSAA_HLSL
#define DEPTHMSAA_HLSL

#ifndef TEXTURE_2D

#ifdef MSAA
	#define TEXTURE_2D(type, name) Texture2DMS<type, MSAA> name
	#define	SampleMap(name, uv, idx)  name.Load(uint2(uv), idx)
#else
	#define TEXTURE_2D(type, name) Texture2D<type> name
	#define	SampleMap(name, uv, idx)  name.Load(uint3(uv, 0))
#endif

#endif

TEXTURE_2D(float, depthMSAA): register(t118);

float getAlphaDepthMSAA(float2 uv, float depth) {
#ifdef MSAA
	float sum = 0;
	[unroll]
	for(uint s=0; s<MSAA; ++s)
		sum += SampleMap(depthMSAA, uv, s).x < depth;
	return sum / MSAA;
#else
	return SampleMap(depthMSAA, uv, 0).x < depth;
#endif
}


#endif