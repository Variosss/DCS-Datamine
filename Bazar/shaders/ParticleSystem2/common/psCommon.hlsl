#ifndef _OPS_FUNCS_
#define _OPS_FUNCS_

#include "ParticleSystem2/common/psShading.hlsl"
#include "ParticleSystem2/common/basis.hlsl"

#if defined(ATMOSPHERE_COLOR)
	#include "common/atmosphereSamples.hlsl"
#endif

#if defined(CLOUDS_SHADOW)
	#include "common/samplers11.hlsl"
	#include "deferred/shadows.hlsl"
#endif

#if defined(CASCADE_SHADOW)
	#include "deferred/shadows.hlsl"
#endif




static const float3 axisX = {1,0,0};
static const float3 axisY = {0,1,0};
static const float3 axisZ = {0,0,1};

static const float	halfPI = 1.5707963267948f;
static const float	PI = 3.141592653589f;
static const float	PI2 = 6.283185307179f;

#ifndef NO_DEFAULT_UNIFORMS
Texture2D			tex;
float3				worldOffset;
#endif

#define ViewInv 	gViewInv
#define View		gView
#define VP			gViewProj
#define Proj		gProj 

#define sunDir		gSunDir
#define sunDiffuse	gSunDiffuse

static const float4 staticVertexData[4] = {
	float4( -0.5,  0.5, 0, 1),
	float4( 0.5,  0.5, 1, 1),
	float4( -0.5, -0.5, 0, 0),
	float4( 0.5, -0.5, 1, 0)
};

uint getTextureAnimPhase(float random, float framesPerSecond)
{
	return (gModelTime + random) * framesPerSecond;
}


//16х8
float4 getTextureFrameUV16x8(uint phase)
{
	float4 uvOffsetScale;
	uvOffsetScale.xy = float2(1.0/16.0, 1.0/8.0);
	uvOffsetScale.zw = uvOffsetScale.xy * float2((float)(phase & 15), (float)((phase>>4) & 7) );
	return uvOffsetScale;
}

//16х8
float4 getTextureFrameUV16x8ByNTime(float nTime, uniform float speed)
{
	return getTextureFrameUV16x8(saturate(nTime*speed)*(16*8-1));
}

float4 getTextureFrameUV16x8(float random, float framesPerSecond)
{
	return getTextureFrameUV16x8(getTextureAnimPhase(random, framesPerSecond));
}

//8х8
float4 getTextureFrameUV8x8(uint phase)
{	
	float4 uvOffsetScale;
	uvOffsetScale.xy = float2(1.0/8.0, 1.0/8.0);
	uvOffsetScale.zw = uvOffsetScale.xy * float2((float)(phase & 7), (float)((phase>>3) & 7) );
	return uvOffsetScale;
}

float4 getTextureFrameUV8x8(float random, float framesPerSecond)
{
	return getTextureFrameUV8x8(getTextureAnimPhase(random, framesPerSecond));
}

//8x4
float4 getTextureFrameUV8x4(uint phase)
{
	float4 uvOffsetScale;
	uvOffsetScale.xy = float2(1.0/8, 1.0/4.0);
	uvOffsetScale.zw = uvOffsetScale.xy * float2((float)(phase & 7), (float)((phase>>3) & 3) );
	return uvOffsetScale;
}

float4 getTextureFrameUV8x4(float random, float framesPerSecond)
{
return getTextureFrameUV8x4(getTextureAnimPhase(random, framesPerSecond));
}

//6х6
float4 getTextureFrameUV6x6(uint phase)
{
	float4 uvOffsetScale;
	uvOffsetScale.xy = float2(1.0/6.0, 1.0/6.0);
	uvOffsetScale.zw = uvOffsetScale.xy * float2(fmod(phase, 6), fmod(phase / 6, 6));
	return uvOffsetScale;
}

float4 getTextureFrameUV6x6(float random, float framesPerSecond)
{
	return getTextureFrameUV6x6(getTextureAnimPhase(random, framesPerSecond));
}

float4 getTextureFrameUV(uint phase, uint2 size){
	float4 uvOffsetScale;
	uvOffsetScale.xy = float2(1.0/size.x, 1.0/size.y);
	uvOffsetScale.zw = uvOffsetScale.xy*
	float2((float)(phase&(size.x-1)), (float)((phase/size.x)&(size.y-1)));
	return uvOffsetScale;
}

float4 getTextureFrameUVSizeNotPow2(uint phase, uint2 size){
	float4 uvOffsetScale;
	uvOffsetScale.xy = float2(1.0/size.x, 1.0/size.y);
	uvOffsetScale.zw = uvOffsetScale.xy*
	float2((float)(phase%size.x), (float)((phase/size.x)%size.y));
	return uvOffsetScale;
}

float getSunBrightness()
{
	return 0.05 + max(0,0.666*(0.5 + gSunDir.y) * 6.0);
}

float3 getPrecomputedSunColor(uint localId)
{
#ifdef ATMOSPHERE_COLOR
	return SamplePrecomputedAtmosphere(localId).sunColor;
#else
	return gSunDiffuse;
#endif
}

float3 applyPrecomputedAtmosphere(in float3 color, in uint localId)
{
#ifdef ATMOSPHERE_COLOR
	return color * SamplePrecomputedAtmosphere(localId).transmittance + SamplePrecomputedAtmosphere(localId).inscatter;
#else
	return color;
#endif
}

float3 getAtmosphereTransmittance(uint localId)
{
#ifdef ATMOSPHERE_COLOR
	return SamplePrecomputedAtmosphere(localId).transmittance;
#else
	return 1;
#endif
}

float3 getAtmosphereTransmittanceLerp(uint localId, float param)
{
	return lerp(getAtmosphereTransmittance(localId),
				getAtmosphereTransmittance(localId+1),
				param);
}

float3 applyPrecomputedAtmosphereLerp(in float3 color, in uint localId, float param)
{
	return lerp(applyPrecomputedAtmosphere(color, localId),
				applyPrecomputedAtmosphere(color, localId+1),
				param);
}

void getPrecomputedAtmosphere(in uint localId, out float3 transmittance, out float3 inscatter)
{
#ifdef ATMOSPHERE_COLOR
	transmittance = SamplePrecomputedAtmosphere(localId).transmittance;
	inscatter =  SamplePrecomputedAtmosphere(localId).inscatter;
#endif
}

float3 shading_AmbientSunHalo_Atmosphere(float3 baseColor, float3 ambientColor, float NoLSun, float haloFactor, uint localIDPrecomputedData)
{
	float3 clr;
	clr = shading_AmbientSunHalo(baseColor, ambientColor, NoLSun*getPrecomputedSunColor(localIDPrecomputedData), haloFactor);
	return applyPrecomputedAtmosphere(clr, localIDPrecomputedData);
}

float3 shading_Irradiance(float3 irradiance, uint localIDPrecomputedData)
{
	return applyPrecomputedAtmosphere(irradiance, localIDPrecomputedData);
}

float3 shading_AmbientSun_Atmosphere(float3 baseColor, float3 ambientColor, float NoLSun, uint localIDPrecomputedData)
{
	float3 clr;
	clr = shading_AmbientSun(baseColor, ambientColor, NoLSun*getPrecomputedSunColor(localIDPrecomputedData));
	return applyPrecomputedAtmosphere(clr, localIDPrecomputedData);
}


float3 unpackUnitVec(in float3 packedVec){
	return packedVec*2 - 1.0;
}	

float satDot(in float3 v0, in float3 v1, uniform float t=1.0){
	return max(0.0, dot(v0, v1)*t + (1.0-t));
}

float satDotNormalized(in float3 v0, in float3 v1, uniform float t=1.0){
	return saturate(dot(v0, v1)*t + (1.0-t));
}

float getCloudsShadow(float3 posW)
{
#if defined(CLOUDS_SHADOW)
	return SampleShadowClouds(posW).x;
#else
	return 1.0;
#endif
}

// computes a depth by the position in the world space
// use the depthByZView for the better performance if it's possible
float getDepthByPosWorld(float3 posW){
	float projZ = mul_v3xv4(posW, gViewProj._13_23_33_43);
	float projW = mul_v3xv4(posW, gViewProj._14_24_34_44);
	return projZ/projW;
}

// computes a depth by the position'z coordinate in the view space.
float getDepthByZView(float zv){
	return (zv*gProj._22+gProj._32)/zv;
}

float getCascadeShadow(float3 posW, float depth)
{
#if defined(CASCADE_SHADOW)
	return SampleShadowCascade(posW, depth, gSunDir, false, false);
#else
	return 1.0;
#endif
}

// use the getCascadeShadow for the better performance if it's possible
float getCascadeShadowByPosWorld(float3 posW)
{
	return getCascadeShadow(posW, getDepthByPosWorld(posW));
}

float getCascadeShadowForVertex(float3 posW, float depth)
{
#if defined(CASCADE_SHADOW)
	return SampleShadowCascadeVertex(posW, depth);
#else
	return 1.0;
#endif
}

//ѕлавно мен¤ет альфа-блендинг цвета с обычного на аддитивный. 
//јдекватно работает только с блендингом SrcBlend = ONE и DestBlend = INV_SRC_ALPHA.
//additiveness = 0 - обычна¤ прозрачность; 1 - чисто аддитивный блендинг.
float4 makeAdditiveBlending(in float4 clr, in float additiveness = 1)
{
	clr.rgb *= clr.a;
	float4 clr2 = float4(clr.rgb, 0);
	return lerp(clr, clr2, clr.a*additiveness);
}

#endif