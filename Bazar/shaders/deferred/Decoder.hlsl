#ifndef DECODER_HLSL
#define DECODER_HLSL

#include "deferred/deferredCommon.hlsl"
#include "deferred/decoderCommon.hlsl"
#include "deferred/GBuffer.hlsl"
#include "deferred/packNormal.hlsl"
#include "deferred/packColor.hlsl"
#include "deferred/packFloat.hlsl"

TEXTURE_2D_ARRAY(float2, GBufferMap);
TEXTURE_2D(float, DepthMap);
TEXTURE_2D(uint2, StencilMap);
float2 depthDims;

#define OLD_PACKING 1 // new packing is not working correctly! present aliasing artefacts

#ifndef DEBUG_OVERRIDE_GBUFFER
	#define DEBUG_OVERRIDE_GBUFFER(baseColorSRGB, normal, aorms, emissive)
#endif

struct EncodedGBuffer
{
	float2	t0;
	float2	t1;
	float4	t2;
	float2	t3;
#if USE_SEPARATE_AO
	float2	t4;
#endif
	uint	idx;
};

struct ComposerInput
{
	uint			stencil;
	float			depth;
	EncodedGBuffer	gbuffer;
	uint2			uv;
	float4			projPos;
	float3			wPos;
};

EncodedGBuffer SampleGBuffer(uint2 uv, uint msaaSample)
{
	EncodedGBuffer o;

#if OLD_PACKING
	#if defined(MSAA) && USE_SV_SAMPLEINDEX
		o.idx  = (msaaSample ^ uv.y) & 1;
		uint msaaSample2 = msaaSample + (1-(msaaSample & 1)*2);
//		o.t2[1] = SampleMapArray(GBufferMap, uv, 2, msaaSample2).xy;
	#else
		o.idx  = (uv.x ^ uv.y) & 1;
		uint x2 = uv.x + (1-(uv.x & 1)*2);
//		o.t2[1] = SampleMapArray(GBufferMap, uint2(x2, uv.y), 2, msaaSample).xy;
	#endif
	o.t2.xy		= SampleMapArray(GBufferMap, uv, 2, msaaSample).xy;
	o.t2.zw		= SampleMapArray(GBufferMap, uint2(x2, uv.y), 2, msaaSample).xy;
#else
	uint2 t2uv = uv;
	#if defined(MSAA) && USE_SV_SAMPLEINDEX
		o.idx  = (msaaSample ^ uv.y) & 1;
		uint msaaSample2 = msaaSample + (1-(msaaSample & 1)*2);
//		t2[1] = SampleMapArray(GBufferMap, uv, 2, msaaSample2).xy;
	#else
		o.idx = uv.y & 1;
		t2uv.x -= (uv.x & 1);
	#endif
	o.t2.xy		= SampleMapArray(GBufferMap, t2uv, 2, msaaSample).xy;
	o.t2.zw		= SampleMapArray(GBufferMap, uint2(t2uv.x+1, t2uv.y), 2, msaaSample).xy;
#endif

	o.t0		= SampleMapArray(GBufferMap, uv, 0, msaaSample).xy;
	o.t1		= SampleMapArray(GBufferMap, uv, 1, msaaSample).xy;
	o.t3		= SampleMapArray(GBufferMap, uv, 3, msaaSample).xy;
#if USE_SEPARATE_AO
	o.t4		= SampleMapArray(GBufferMap, uv, 4, msaaSample).xy;
#endif
	return o;
}

float3 RestoreWorldPos(float depth, float2 projPos, uint msaaSample)
{
#ifdef MSAA
	projPos += MSAA_OFFSET[msaaSample] / depthDims;
#endif
	float4 pos = mul(float4(projPos, depth, 1), gViewProjInv);
	return pos.xyz / pos.w;
}

ComposerInput ReadComposerData(uint2 uv, float4 projPos, uint msaaSample)
{
	ComposerInput o;
	o.depth		= SampleMap(DepthMap, uv, msaaSample).r;
	o.stencil	= SampleMap(StencilMap, uv, msaaSample).g;
	o.gbuffer	= SampleGBuffer(uv, msaaSample);
	o.wPos		= RestoreWorldPos(o.depth, projPos.xy, msaaSample);
	o.uv		= uv;
	o.projPos	= projPos;
	return o;
}

float3 DecodeNormal(uint2 uv, int msaaSample)// for function ShadowsSample in compose.hlsl
{
	float2 t0 = SampleMapArray(GBufferMap, uv, 0, msaaSample).xy;
	float2 rm = SampleMapArray(GBufferMap, uv, 3, msaaSample).xy;

	float3 normal = normalize(unpackNormal(t0.xy * 2 - 1).xzy);
	normal.y = rm.x <= 0.5? normal.y : -normal.y;

	return normal;
}

float3 DecodeNormal(EncodedGBuffer i)
{
	float2 t0 = i.t0;
	float2 rm = i.t3;

	float3 normal = normalize(unpackNormal(t0.xy * 2 - 1).xzy);
	normal.y = rm.x <= 0.5? normal.y : -normal.y;

	return normal;
}

bool DecodeGBuffer(EncodedGBuffer i, uint2 uv, uint msaaSample, out float3 Diffuse, out float3 Normal, out float4 aorms, out float3 emissive)
{
	Normal = DecodeNormal(i);
	
	float2 t1 = i.t1;
	float2 t2[2] = {i.t2.xy, i.t2.zw};
	uint idx = i.idx;

	bool bValidEmissive = t1.y >= emissiveLumMin;

#if USE_MASK_IC
	t2[idx].xy   = bValidEmissive ? t2[idx].xy : t2[0];
	t2[1-idx].xy = bValidEmissive ? t2[1-idx].xy : float2(0, 0);
#endif

	Diffuse = decodeColorYCC( float3(t1.x, t2[idx].xy) );
	emissive = bValidEmissive ? decodeColorYCC( float3(t1.y, t2[1-idx].xy) ) : 0;

	//HACK: after decoding of emissive color we can get negative values due to checkerboarded chrominance data AND/OR insufficient precision
	//of stored YCC emissive values. It happens mostly when emissive luminance is low, and original emissive color is close to clear R/G/B color
	emissive = any(emissive<-0.1)? 0 : max(0, emissive);

	emissive *= emissive * emissiveValueMax;

#if USE_SEPARATE_AO
	aorms.xw = i.t4;
#else
	aorms.xw = 1;
#endif

	aorms.yz = i.t3;
	aorms.y = unpackFloat1Bit(aorms.y);
	
	DEBUG_OVERRIDE_GBUFFER(Diffuse, Normal, aorms, emissive);

	return true;
}

bool DecodeGBuffer(float2 projPos, uint2 uv, int msaaSample, out float3 WPos, out float3 Diffuse, out float3 Normal, out float4 aorms, out float3 emissive)
{
	EncodedGBuffer gbuffer = SampleGBuffer(uv, msaaSample);
	float depth	= SampleMap(DepthMap, uv, msaaSample).r;
	WPos = RestoreWorldPos(depth, projPos, msaaSample);
	return DecodeGBuffer(gbuffer, uv, msaaSample, Diffuse, Normal, aorms, emissive);
}

float3 DecodeGBufferRefraction(uint2 uv)
{
	const uint msaaSample = 0;
	float4 aorms;
	float3 normal, emissive, diffuse;

	DecodeGBuffer(SampleGBuffer(uv, msaaSample), uv, msaaSample, diffuse, normal, aorms, emissive);
	return diffuse;
}

void DecodeGBufferReflection(uint2 uv, out float3 diffuse, out float3 normal, out float3 emissive)
{
	const uint msaaSample = 0;
	float4 aorms;
	DecodeGBuffer(SampleGBuffer(uv, msaaSample), uv, msaaSample, diffuse, normal, aorms, emissive);
}

float3 unpackWaterNormal(float2 packedNormal) {
	float3 n = unpackNormal(packedNormal * 2 - 1);
	return normalize(float3(n.x, -n.z, n.y));
}

float3 DecodeWaterNormal(uint2 uv, int msaaSample) {
	float2 t0 = SampleMapArray(GBufferMap, uv, 0, msaaSample).xy;
	return unpackWaterNormal(t0.xy);
}

void DecodeGBufferWater(EncodedGBuffer i, uint2 uv, int msaaSample, out float3 Normal, out float wLevel, out float Foam, out float deepFactor, out float riverLerp) {
	Normal = unpackWaterNormal(i.t0.xy); 
	wLevel	= i.t3.x;
	Foam = i.t3.y;
	deepFactor = i.t4.x;
	riverLerp = i.t4.y;
}

#endif
