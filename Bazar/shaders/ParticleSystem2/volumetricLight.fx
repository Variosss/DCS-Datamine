#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "common/shadingCommon.hlsl"
#include "common/random.hlsl"
#include "common/stencil.hlsl"
#include "enlight/materialParams.hlsl"
#include "common/softParticles.hlsl"
#define CLOUDS_COLOR
#define ATMOSPHERE_COLOR

#include "ParticleSystem2/common/psCommon.hlsl"

#ifdef MSAA
	Texture2DMS<float, MSAA> depthMap;
#else
	Texture2D<float> depthMap;
#endif

float4		params0;
float4 		params1;// = float4(1.0, 1.0, 1.0, 0.0);
float4 		params2;// = float4(1.0, 1.0, 1.0, 0.0);

// float kt;// = 0.05;

#define gWorldOffset params0.xyz
#define gRadius params0.w
#define gLightRadiance params1.xyz
#define gDensity params1.w

#define gMultipleScattering params2.x
#define gSingleScattering params2.y
#define gShadowBias params2.z
#define gDensityFactor params2.w


struct VS_OUTPUT
{
	float4 pos: SV_POSITION0;
	float3 posW: POSITION1;
	float4 projPos: POSITION3;
	float  density: POSITION2;
};

#define TestGPUDensity

RWTexture3D<float> volumeDST;
Texture3D<float> volumeSRC;

float cloudDensity()
{
	float3 uvw = gWorldOffset * gCloudVolumeScale + gCloudVolumeOffset;
	float2 s = cloudsDensityMap.SampleLevel(gBilinearClampSampler, uvw.xzy, 0).xy;
	s.y *= s.y;
	float densityGrad = s.x * 2 - 1;
	float shapeSignal = saturate(densityGrad * 3 + 0.1);
	float density = shapeSignal * 0.05 * s.y;
	return max(0, density);
}

VS_OUTPUT vs(float3 pos: POSITION0)
{
	VS_OUTPUT o;
	o.density = cloudDensity()*gDensityFactor;

	//o.density = 0.05;
	//o.density = gDensity;
	//o.density = 1.0;
	
	float radius = gRadius*1.1;
	//radius *= ((1.0-exp(-o.density))*0.0+0.5*2);

	
	float3 pL = pos.xyz*radius;
	float3 pW = pL+gWorldOffset;

	o.posW = pW;
	o.projPos = o.pos = mul(float4(pW, 1), gViewProj);
	return o;
}

// VS_OUTPUT vsInside(float3 pos: POSITION0)
// {
// 	VS_OUTPUT Out;
    
// 	Out.cOut.xy = quad[vid];
// 	Out.cOut.z = 0.0;  // computes near plane
// 	Out.cOut.w = 1.0;


// 	return Out;
// }


float2 sphereIntersect( in float3 ro, in float3 rd, in float3 ce, float ra )
{
    float3 oc = ro - ce;
    float b = dot( oc, rd );
    float c = dot( oc, oc ) - ra*ra;
    float h = b*b - c;
    if( h<0.0 ) return float2(-1.0, -1.0); // no intersection
    h = sqrt( h );
    return float2( -b-h, -b+h );
}

float I0(float a, float va, float vb) {
	const int maxIterations = 3; // Enough precision for the current scene

	float pva = sqrt(a * a * (va * va + 1.0));
	float pvb = sqrt(a * a * (vb * vb + 1.0));
	float ova = atan2(a, a * va);
	float ovb = atan2(a, a * vb);
	float sina = sin(a);
	float cosa = cos(a);
	float logv = log(pvb / pva);
	float phiv = ovb - ova;
	float I0 = sina * logv - cosa * phiv;

	float kfac = 1.0;
	float pkva = 1.0;
	float pkvb = 1.0;

	for (int k = 1; k <= maxIterations; k++) {
        float kf = float(k);
		kfac *= kf;
		pkva *= pva;
		pkvb *= pvb;
		float okva = a - kf * ova;
		float okvb = a - kf * ovb;
		float denom = 1.0 / (kf * kfac);
		I0 += (pkvb * sin(okvb) - pkva * sin(okva)) * denom;
	}
	return I0;
}


static float simRadius = 3;

float2 singleScatteringHomogenousSphere(float cosAlpha, float density, float depth=1.0){

	const uint NSAMPLES = 500;

	

	float3 pos = float3(1.0, 0.0, 0.0)*simRadius;

	float3 dir = -float3(cosAlpha, sqrt(1.0-cosAlpha*cosAlpha), 0.0);
	dir = normalize(dir);
	float2 t = sphereIntersect(pos, dir, float3(0.0f, 0.0f, 0.0f), 1.0*simRadius);


	float3 start = t.x*dir+pos;
	float3 end = t.y*dir+pos;
	end = (end-start)*depth + start;
	
	float3 step = (end-start)/float(NSAMPLES);
	float3 samplePos = start;
	float stepSize = length(step);
	float inScattered = 0.0;
	float distanceTravelled = 0.0;
	for(uint i=0; i < NSAMPLES; i++){
		float l = length(samplePos);
		float t= exp(-density*stepSize);
		float li = exp(-density*l)/(l*l);
		inScattered += density*li*exp(-distanceTravelled*density)*stepSize/(4*3.14)*gSingleScattering*0.75;
		inScattered += density*li*exp(-distanceTravelled*density)*stepSize*sqrt(l/simRadius)*gMultipleScattering*1.35; // multiple scattering (типа)
		
		distanceTravelled += stepSize;
		samplePos += step;
	}
	

	
	return float2(inScattered, 1.0);
}

static float densitymin = 0.0;
static float densitymax = 0.5;
static float distmin = 0.0;
static float distmax = 1.0;

[numthreads(1, 32, 32)]
void CS(uint3 gid: SV_GroupId, uint3 gtid: SV_GroupThreadID) 
{	
    uint3 idx = uint3(gid.x, gtid.y+gid.y*32, gtid.z);

	float densityrange = densitymax -densitymin;

	float density = pow(float(idx.x)/31.0, 2)*densityrange+densitymin;
	float angle = asin(pow(idx.y/63.0, 2));
	float cosAngle = cos(angle*0.9999); // fix for tangent rays near borders
	float depth = float(idx.z)/31.0*(distmax-distmin)+distmin;
    volumeDST[idx] =  singleScatteringHomogenousSphere(cosAngle, density, depth).x;
}
//#define DEBUG_RT
float4 ps(VS_OUTPUT i): SV_TARGET0
{
	
	//return float4(abs(i.posL.x), abs(i.posL.y), abs(i.posL.z), 1.0);
	

	
	float3 view = normalize(gCameraPos.xyz-i.posW);
	float2 t = sphereIntersect(gCameraPos.xyz, -view, gWorldOffset, gRadius);
	if(t.x == t.y){
		clip(-1);
	}
	


	float3 crossPointW = -view*t.x+gCameraPos.xyz;
	view = normalize(gCameraPos.xyz-crossPointW);
	float3 forward = normalize(crossPointW- gWorldOffset);
	float cosAngle = abs(dot(-view, forward));


	float intensity = 1.0;

	float cosThreshold = 0.99;
	float borderAttenuation = (1.0-saturate(cosThreshold-cosAngle)/cosThreshold);

	float radius = gRadius;
	float3 mediaTr  = SamplePrecomputedAtmosphere(0).transmittance;
	//mediaTr = 1;
	

	float depth = g_DepthTexture.SampleLevel(gPointClampSampler, float2(i.projPos.x, -i.projPos.y) / i.projPos.w*0.5 + 0.5, 0).r;
	float4 p1 = mul(float4(i.projPos.xy / i.projPos.w, depth, 1), gProjInv);
	float distToGeometry = p1.z / p1.w;
	//distToGeometry = 100000;
	float distToSphereStart = t.x;
	float distToSphereEnd = t.y;

	float3 distFirst = distToSphereStart;
	float3 distSecond = distToSphereEnd;

	if(distToGeometry < distToSphereStart){
		clip(-1);
	}
	

	float shadowBias = 0;
	if(distToGeometry < distToSphereEnd){
		distSecond = min(distToGeometry+gRadius*gShadowBias, distToSphereEnd);

	}

	

	
	float distFirstSample = saturate(((distFirst-distToSphereStart)/(2*gRadius)-distmin)/(distmax-distmin));
	float distSecondSample = saturate(((distSecond-distToSphereStart)/(2*gRadius) -distmin)/(distmax-distmin));
	

	float densityrange = densitymax -densitymin;
	float density = sqrt(clamp(i.density, densitymin, densitymax)/(densityrange));
	
	float sinAngle = sqrt(1.0-cosAngle*cosAngle);
	float angle = sqrt(sinAngle);
	float inScatteredEnd = volumeSRC.SampleLevel(gBilinearClampSampler, float3(density, angle, distSecondSample), 0);
	float inScatteredStart = volumeSRC.SampleLevel(gBilinearClampSampler, float3(density, angle, distFirstSample), 0);
	float inScattered = inScatteredEnd-inScatteredStart;
#ifdef DEBUG_RT
	
	 inScattered = singleScatteringHomogenousSphere(cosAngle, i.density, 1.0).x;
#endif
	//inScattered = inScatteredEnd;

	float alpha =  (inScattered)*intensity*borderAttenuation;
	float3 color =gLightRadiance*alpha*mediaTr;

	return float4(color.x, color.y, color.z, alpha);
}

RasterizerState cull
{
	CullMode = Front;
	FillMode = Solid;
};


technique10 tech
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, vs()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps()));
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		//ENABLE_ALPHA_BLEND;
		SetRasterizerState(cull);
		SetComputeShader(NULL);

	}
}

technique10 bake
{
	pass p0
	{
	 	SetComputeShader(CompileShader(cs_5_0, CS()));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);	
	}
}
