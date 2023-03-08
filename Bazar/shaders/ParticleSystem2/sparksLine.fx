#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/atmosphereSamples.hlsl"
#include "common/random.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"

float4 params;
float3 speedLA;
float3 minMaxAngleSpeed;
#define time			params.x
#define phase			params.y
#define lifetime		params.z
#define particleSize	params.w

#define minSpeed 		minMaxAngleSpeed.x
#define maxSpeed 		minMaxAngleSpeed.y
#define angleSpeed 		minMaxAngleSpeed.z

#define	PI2 6.28319

#define	PI 6.28319*0.5

static const float3 mainSpeed = float3(0.0, 1.0, 0.0);
static const float p_width = 0.15; 
static const float p_length = 50.0;
static const float speed = 0.1;
static const float brightness = 1.5;
static const float fadeout = 1.1;

struct VS_INPUT{
	float4 posBirth		: POSITION0;//pos + birthTime
	float4 speedLifetime: TEXCOORD0;//speed + lifetime
};


struct VS_OUTPUT
{
	float4 pos: 		POSITION0;
	float3 speed:		TEXCOORD0;
	float4 rnd: 		TEXCOORD1;
	float2 ageNage: 	TEXCOORD2;
};

struct GS_OUTPUT
{
	float4 pos: 	SV_POSITION0;
	float3 uvnAge:		TEXCOORD0;
};

static const float4 particle[4] = {
    float4( -0.5,  0.5, 0, 1),
    float4( 0.5,  0.5, 1, 1),
    float4( -0.5, -0.5, 0, 0),
    float4( 0.5, -0.5, 1, 0)
};



VS_OUTPUT vsSparks(float3 startPos: TEXCOORD0, float2 birthTimeLife: TEXCOORD1, uint vertId:  SV_VertexID)
{
	VS_OUTPUT o;
	float age = time - birthTimeLife.x;

	float3 new_speed = normalize(normalize(speedLA) + max(min(angleSpeed, 0.2), 0.0)*mainSpeed);
	float3x3 BasisM = basis(new_speed);
	o.rnd = noise4( float4(vertId*0.1783234+0.123, vertId*0.2184295, vertId*0.48564523+0.321, vertId*0.37291365+0.42) + (phase+1)*0.358231 );
	
	float3 speed_new = mul(float3((o.rnd.x-0.5)/12.0, o.rnd.z+0.1, (o.rnd.y-0.5)/12.0), BasisM);
	o.speed = normalize(speed_new);
	o.pos = float4(lerp(startPos - gOrigin, worldOffset, 1.0 - age/birthTimeLife.y), 1);	
	o.ageNage.xy = float2(age, age/birthTimeLife.y);

	return o;
}


[maxvertexcount(4)]
void gsSparks(point VS_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	GS_OUTPUT o;

	#define 	age 	input[0].ageNage.x
	#define 	nAge 	input[0].ageNage.y
	float4 rnd2 = noise4(input[0].rnd);
	
	float2 ang = float2((rnd2.x-0.5)*0.1, (rnd2.y-0.5)*0.1)*PI2;

	float3x3 mRotAng = mul(rotMatrixZ(ang.x), rotMatrixY(ang.y));
	float3x3 mRot = basis(input[0].speed);


	float speedValue = minSpeed + (maxSpeed - minSpeed)*rnd2.z;


	o.uvnAge.z = nAge;

	float3 p1 = float3(0.0, 0.0, 0.0);
	float3 p2 = float3(0.0, particleSize*p_length*min(10.0*nAge, 1.0)*(1.0-max(nAge, 0.5))*2.0*(1+rnd2.y/10.0), 0.0);

	float3 forwardCamera = normalize(gCameraPos - input[0].pos.xyz);

	float3 offset = float3(0.0, 0.0, 0.0);
	if (all(cross(normalize(mul(p2-p1, mRot)), forwardCamera)))
		offset = normalize(cross(normalize(mul(p2-p1, mRot)), forwardCamera));

	for (int ii = 0; ii < 4; ++ii)	
	{
		float interp = (particle[ii].y+0.5);
		float4 wPos;
		wPos.xyz = (1.0-interp)*p1 + interp*p2;
		wPos.w = 1.0;
		wPos.xyz = mul(wPos.xyz, mRot) + input[0].pos.xyz + speed*speedValue*input[0].speed*age + (particle[ii].x)*particleSize*p_width*(1+rnd2.x/10.0)*offset;

		o.pos = mul(wPos, gViewProj);
		o.uvnAge.x = particle[ii].x+0.5;
		o.uvnAge.y = rnd2.w;
		outputStream.Append(o);
	}
	#undef age
	#undef nAge

	outputStream.RestartStrip();                          
}

 
float4 psSparks(GS_OUTPUT i): SV_TARGET0
{
	#define nAge i.uvnAge.z

	float r = pow(i.uvnAge.x, 2);
	float4 basecolor = tex.Sample(WrapLinearSampler, float2(r, r));
	basecolor = basecolor*basecolor;
	//basecolor.a *= brightness*(1.0 - min(1.0, fadeout)*nAge);
	basecolor.a *= brightness*max(0.0, 1.0 - pow(nAge*(1.0+i.uvnAge.y/10.0), fadeout));
	return basecolor;
}



technique10 sparksTech
{
	pass p0
	{
		DISABLE_CULLING;
		ENABLE_DEPTH_BUFFER;
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_4_0, vsSparks()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsSparks()));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSparks())); 
	}

	pass p1
	{
		DISABLE_CULLING;
		ENABLE_DEPTH_BUFFER;
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_4_0, vsSparks()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsSparks()));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSparks()));
	}
}
