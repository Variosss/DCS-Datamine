#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/atmosphereSamples.hlsl"
#include "common/random.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "common/stencil.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/motion.hlsl"

float  normSpeedLA;
float4x4	World;
float angleSpeed;
float time;

#define	PI 6.28319*0.5

static const float p_width = 0.15*0.01; 
static const float p_length = 1.5;
static const float speed = 1.2;
static const float brightness = 40.0;
static const float opacity = 0.8;
static const float fadeout = 1.0;

static const uint segments = 5;
static const float segStep = 1.0/segments;

struct VS_OUTPUT
{
	float4 pos: 		POSITION0;
	float3 rnd: 		TEXCOORD0;
	float2 ageNage: 	TEXCOORD1;
};

struct GS_OUTPUT
{
	float4 pos: 		SV_POSITION0;
	float4 rNAgeRandL:	TEXCOORD0;
	float3 sunColor: 	TEXCOORD1;
};


struct HS_CONST_OUTPUT{
	float edges[2] : SV_TessFactor;
};

struct HS_OUTPUT{
	float4 pos: 		POSITION0;
	float3 rnd: 		TEXCOORD0;
	float2 ageNage: 	TEXCOORD1;
};

struct DS_OUTPUT{
	float4 pos: 		POSITION0;
	float3 rnd: 		TEXCOORD0;
	float4 ageNagePar: 	TEXCOORD1;
};


VS_OUTPUT vsSparks(float3 randValues: TEXCOORD0, float2 birthTimeLife: TEXCOORD1, uint vertId:  SV_VertexID)
{
	VS_OUTPUT o;
	float age = time - birthTimeLife.x;

	o.rnd = noise3(randValues);
	o.pos = float4(worldOffset + (randValues-0.5)*0.11, 1);
	o.ageNage.xy = float2(age, age/birthTimeLife.y);

	return o;
}


// HULL SHADER ---------------------------------------------------------------------
HS_CONST_OUTPUT hsConstant( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o; 
	o.edges[1] = segments;
	o.edges[0] = 1; 
	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("hsConstant")]

HS_OUTPUT hs( InputPatch<VS_OUTPUT, 1> ip, uint cpid : SV_OutputControlPointID)
{
	HS_OUTPUT o;
	o.pos = ip[0].pos;
	o.rnd = ip[0].rnd;
	o.ageNage = ip[0].ageNage;
	return o;
}
// DOMAIN SHADER ---------------------------------------------------------------------
[domain("isoline")]
DS_OUTPUT ds( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
    DS_OUTPUT o;
	o.pos = patch[0].pos;
	o.rnd = patch[0].rnd;
	o.ageNagePar.xy = patch[0].ageNage;
	o.ageNagePar.z = UV.x;
	o.ageNagePar.w = UV.y;
	return o;
}


[maxvertexcount(4)]
void gsSparks(point DS_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	GS_OUTPUT o;

	#define 	age 		input[0].ageNagePar.x
	#define 	nAge 		input[0].ageNagePar.y
	#define 	gsParam 	input[0].ageNagePar.z
	
	float width_rand = 0.9;
	float length_rand = 0.3;
	length_rand = saturate(length_rand);
	width_rand = saturate(width_rand);

	float rand_w = noise1D(0.33*input[0].rnd.x+0.33*input[0].rnd.y+0.33*input[0].rnd.z);
	float2 params = {(gsParam*0.25*p_length*(1.0-length_rand+length_rand*input[0].rnd.z)*(1.0-0.5*nAge)+30.0*speed*age*(0.5+0.5*input[0].rnd.x))*(0.8+normSpeedLA/3.0), ((gsParam+segStep)*0.25*p_length*(1.0-length_rand+length_rand*input[0].rnd.z)*(1.0-0.5*nAge)+30.0*speed*age*(0.5+0.5*input[0].rnd.x))*(0.8+normSpeedLA/3.0)};
	float2 ages = age * params*0.3;
	
	float2 params_edges = {(max(gsParam-segStep, 0.0)*0.25*p_length*(1.0-length_rand+length_rand*input[0].rnd.z)*(1.0-0.5*nAge)+30.0*speed*age*(0.5+0.5*input[0].rnd.x))*(0.8+normSpeedLA/3.0), (min(gsParam+2*segStep, 1.0)*0.25*p_length*(1.0-length_rand+length_rand*input[0].rnd.z)*(1.0-0.5*nAge)+30.0*speed*age*(0.5+0.5*input[0].rnd.x))*(0.8+normSpeedLA/3.0)};

	float2 ages_edges = age * params_edges*0.3;

	o.rNAgeRandL.y = nAge;
	o.rNAgeRandL.z = noise1D(input[0].rnd.z);

	float r = 8.0*(0.8+0.2*input[0].rnd.y);
	float2 sc = float2(sin(noise1D(input[0].rnd.x)*PI), cos(noise1D(input[0].rnd.x)*PI));
	
	float3 p1 = input[0].pos.xyz  + mul(float3(7.8*pow(r*ages.x, 2), 3.0*(r-angleSpeed*r*0.68*max(1.0-5.0*ages.x, 0.0))*sc.x*ages.x*(1.0-smoothstep(0.065,  0.25, ages.x)), 0.9*r*sc.y*ages.x), World);
	float3 p2 = input[0].pos.xyz  + mul(float3(7.8*pow(r*ages.y, 2), 3.0*(r-angleSpeed*r*0.68*max(1.0-5.0*ages.y, 0.0))*sc.x*ages.y*(1.0-smoothstep(0.065,  0.25, ages.y)), 0.9*r*sc.y*ages.y), World);

	float3 p0 = input[0].pos.xyz  + mul(float3(7.8*pow(r*ages_edges.x, 2), 3.0*(r-angleSpeed*r*0.68*max(1.0-5.0*ages_edges.x, 0.0))*sc.x*ages_edges.x*(1.0-smoothstep(0.065,  0.25, ages_edges.x)), 0.9*r*sc.y*ages_edges.x), World);

	if (gsParam == 0.0) {
		p0 = p2;
	}

	float3 offset1 = float3(0.0, 0.0, 0.0);
	float3 offset2 = float3(0.0, 0.0, 0.0);

	float3 forwardCamera1 = normalize(gCameraPos - p1);
	float3 forwardCamera2 = normalize(gCameraPos - p2);
	if (gsParam == 0.0) {
		if (all(cross(normalize(p2-p1), forwardCamera2)))
			offset2 = normalize(cross(normalize(p2-p1), forwardCamera2));
		if (all(cross(normalize(p2-p1), forwardCamera1)))
			offset1 = normalize(cross(normalize(p2-p1), forwardCamera1));
	}
	else {
		if (all(cross(normalize(p1-p0), forwardCamera1)))
			offset1 = normalize(cross(normalize(p1-p0), forwardCamera1));
		if (all(cross(normalize(p2-p1), forwardCamera1)))
			offset2 = normalize(cross(normalize(p2-p1), forwardCamera2));
	}


	o.sunColor = getPrecomputedSunColor(0);
	if (dot(o.sunColor, o.sunColor) < 0.001) {
		o.sunColor.xyz = 1.0;
	}
	else {
		o.sunColor.xyz = normalize(o.sunColor);
	}

	float distCorrected = (1.73 / gProj._11) * length(mul(float4(p1, 1.0), gView)); 
	float scaleFactor = 1 + 1.3 * distCorrected * smoothstep(0.2, 5.0, distCorrected);


	o.pos = mul(float4(p1+offset1*p_width*scaleFactor*(1.5-width_rand+width_rand*rand_w), 1), gViewProj);
	o.rNAgeRandL.x = 1.0;
	o.rNAgeRandL.w = gsParam;
	outputStream.Append(o);

	o.pos = mul(float4(p1-offset1*p_width*scaleFactor*(1.5-width_rand+width_rand*rand_w), 1), gViewProj);
	o.rNAgeRandL.x = -1.0;
	o.rNAgeRandL.w = gsParam;
	outputStream.Append(o);

		

	o.pos = mul(float4(p2+offset2*p_width*scaleFactor*(1.5-width_rand+width_rand*rand_w), 1), gViewProj);
	o.rNAgeRandL.x = 1.0;
	o.rNAgeRandL.w = gsParam+segStep;
	outputStream.Append(o);
	
	o.pos = mul(float4(p2-offset2*p_width*scaleFactor*(1.5-width_rand+width_rand*rand_w), 1), gViewProj);
	o.rNAgeRandL.x = -1.0;
	o.rNAgeRandL.w = gsParam+segStep;
	outputStream.Append(o); 

	
	outputStream.RestartStrip();


	#undef 	age
	#undef 	nAge
	#undef 	gsParam
}
 
static const float3 sparksColorDay = float3(0.4, 0.0, 0.0);
static const float3 sparksColorNight = float3(1.0, 0.7, 0.23);

float4 psSparks(GS_OUTPUT i): SV_TARGET0
{
	float w_1 = i.pos.z/i.pos.w;
	w_1 = 1.0-w_1;
	w_1 = smoothstep(0.99, 1.0, w_1);
	w_1 = 1.0-w_1;
	w_1 = 0.3+0.7*w_1;

	#define nAge i.rNAgeRandL.y
	float r = pow(0.5-abs(i.rNAgeRandL.x)/2.0, 2);
	float4 basecolor = tex.Sample(WrapLinearSampler, float2(r, r));
	basecolor = basecolor*basecolor;

	float t = lerp(0.0, 0.8, 1.0 - max((1.0 - fadeout*smoothstep(0.8, 1.0, nAge)), 0.0));
	t = smoothstep(0.0+t/2.0, 0.2+t, i.rNAgeRandL.w);
	t *= smoothstep(0.0, 0.4, 1.0-nAge);
	float opacityDay = 0.01*t*smoothstep(0.86, 0.93, angleSpeed)*opacity*pow(r,2)*smoothstep(0.2, 1.0, 1.0-abs(abs(i.rNAgeRandL.x)))*w_1;
    float opacityNight = t*smoothstep(0.86, 0.93, angleSpeed)*opacity*pow(r,4)*smoothstep(0.2, 1.0, 1.0-abs(abs(i.rNAgeRandL.x)))*w_1;
    t = smoothstep(0.0, 1.0, gSunIntensity/15.0);
    float3 sparksColor = t*sparksColorDay + (1-t)*sparksColorNight;

    basecolor.a *= (1-t)*opacityNight+t*opacityDay;
    basecolor.rgb *= (0.9+0.1*i.rNAgeRandL.z)*w_1*100.0*brightness*sparksColor;

	return basecolor;
}

RasterizerState cullSparks
{
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = TRUE;
};


technique10 sparksTech
{
	pass p0
	{
		//DISABLE_CULLING;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		//ENABLE_DEPTH_BUFFER;
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_4_0, vsSparks()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));
		SetGeometryShader(CompileShader(gs_5_0, gsSparks()));
		SetPixelShader(CompileShader(ps_5_0, psSparks()));
		SetRasterizerState(cullNone);
	}
}
