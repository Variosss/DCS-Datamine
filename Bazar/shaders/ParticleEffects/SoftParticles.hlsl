
#include "common/softParticles.hlsl"

float softParticlesAlpha(float2 screenTex, float depth) {
	return depthAlpha(float4(screenTex, depth, 1));
}


#if(SAMPLES > 1)
#define MSAA 1
#endif

#ifdef MSAA
const Texture2DMS<float, SAMPLES>  depthTex;
const float2 depthTexSize;
#else
const Texture2D depthTex;
#endif

static const float spScale = 0.8;
static const float spContrast = 0.8;
bool useSoftParticles;
#define matProjInverse gProjInv

#if 0

float contrast(float depth)
{
     //piecewise contrast function
	 depth *= spScale;
     bool isAboveHalf = depth > 0.5 ;
     float toRaise = saturate(2*(isAboveHalf ? 1-depth : depth));
     float res = 0.5*pow(toRaise, spContrast); 
     return isAboveHalf ? 1-res : res;
}
	 
float getDepthDiff(float2 screenTex, float depth)
{
    float2 depthTexCoords = 0.5*((screenTex) + float2(1,1));
    depthTexCoords.y = 1 - depthTexCoords.y;
 
 #ifdef MSAA
	float depthSample = 0.f;
	float curSample = 0.f;
	//FIXME хз какой смысл усреднять сэмплы буфера глубины
	for(int i = 0; i < SAMPLES; ++i)
	{
		curSample = depthTex.Load(int2( depthTexCoords * depthTexSize), i);
		curSample = curSample == 0.f ? 1.f : curSample;
		depthSample += curSample > 0.f ? curSample : 0.f;
	}
	depthSample /= SAMPLES;
 #else
	float depthSample = depthTex.SampleLevel(ClampPointSampler, depthTexCoords, 0);
	depthSample = depthSample == 0.f ? 1.f : depthSample;
 #endif
	
	float4 depthViewSample = mul( float4( screenTex, depthSample, 1 ), matProjInverse);
	float4 depthViewParticle = mul( float4( screenTex, depth, 1 ), matProjInverse);
	return depthViewParticle.z/depthViewParticle.w - depthViewSample.z/depthViewSample.w; 
}

float softParticlesAlpha(float2 screenTex, float depth)
{
	if (useSoftParticles)
	{
		float depthDiff = getDepthDiff(screenTex, depth);
		clip(depthDiff);
		return contrast(depthDiff);
	}
	return 1.f;
}

#endif