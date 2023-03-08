#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "common/random.hlsl"
#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/splines.hlsl"
#include "ParticleSystem2/common/basis.hlsl"

float3 worldOffset;
float3 bulletParams;

#define bulletMass	bulletParams.x
#define bulletCx	bulletParams.y
#define time		bulletParams.z

static const float traceWidth = 0.3;
static const uint segments = 4;
static const float segStep = 1.0/(4);
static const uint controls = 12;
static const float segYStep = 1.0/(12);
//static const float controls_float = 5.0;


struct VS_INPUT{
	float4 posBirth		: POSITION0;//pos + birthTime
	float4 speedLifetime: TEXCOORD0;//speed + lifetime
};

struct VS_OUTPUT{
	float4 pos		: POSITION0;//pos + birthTime
	float4 speed	: TEXCOORD0;//speed + lifetime
};

struct HS_CONST_OUTPUT{
	float edges[2] : SV_TessFactor;
};

struct HS_OUTPUT{
	float4 pos  	: POSITION0;
	float4 speed	: TEXCOORD0;
};

struct DS_OUTPUT
{
	float3 pos1	  		: POSITION0;
	float3 pos2   		: POSITION1;
	float3 vel1   		: TEXCOORD0;
	float3 vel2	  		: TEXCOORD1;
	float4 opacityWidth	: TEXCOORD2;
};

struct GS_OUTPUT{
	float4 pos  	: SV_POSITION0;
	float4 params	: TEXCOORD0;
};


VS_OUTPUT vs(in VS_INPUT i)
{
	VS_OUTPUT o;
	o.pos = i.posBirth;
	float4 vPos = float4(o.pos.xyz - worldOffset, 1);
	o.pos.xyz = vPos.xyz;
	o.speed = i.speedLifetime;
	return o;
}


// HULL SHADER ---------------------------------------------------------------------
HS_CONST_OUTPUT hsConstant( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o; 
	o.edges[1] = segments;
	o.edges[0] = controls; 
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
	o.speed = ip[0].speed;
	return o;
}


[domain("isoline")]
DS_OUTPUT ds(HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch)
{
	DS_OUTPUT o;

	float2 params = {UV.x, UV.x+segStep};


	float2 params_y = {UV.y, UV.y+segYStep};
	float AGE = time - patch[0].pos.w;;
	float min_AGE = saturate(AGE)*0.15*AGE;
	float2 ages = (AGE-min_AGE) * params_y + min_AGE;

	float3 pos1_edges = patch[0].pos.xyz + calcTranslation(patch[0].speed.xyz, ages.x);
	float3 pos2_edges = patch[0].pos.xyz + calcTranslation(patch[0].speed.xyz, ages.y);

	float3 rnd[2] = {
		noise3(float3(params_y.x + patch[0].pos.w, (params_y.x + patch[0].pos.w)*1.104523, (params_y.x + patch[0].pos.w)*0.8941232), 3123.512371903),
		noise3(float3((params_y.y + patch[0].pos.w), (params_y.y + patch[0].pos.w)*1.104523, (params_y.y + patch[0].pos.w)*0.8941232), 3123.512371903)
	};

	float3 vel1_edges = float3((rnd[0].x -0.5), abs(rnd[0].y), (rnd[0].z -0.5));
	vel1_edges = normalize(vel1_edges);

	float3 dir = patch[0].speed.xyz;
	dir = normalize(dir);
	float3x3 mWorld = basis(dir);
	vel1_edges = 0.03*mul(vel1_edges, mWorld);
	vel1_edges += dir;
	vel1_edges = normalize(vel1_edges);

	float3 vel2_edges = float3((rnd[1].x -0.5), abs(rnd[1].y), (rnd[1].z -0.5));
	vel2_edges = normalize(vel2_edges);

	vel2_edges = 0.03*mul(vel2_edges, mWorld);
	vel2_edges += dir;
	vel2_edges = normalize(vel2_edges);



	float len = distance(pos1_edges, pos2_edges);
	const float coef = 1.0/3.0 * len;

	float3 pos1_extra = pos1_edges + vel1_edges*coef;
	float3 pos2_extra = pos2_edges - vel2_edges*coef;

	float t1 = params.x;
	float t2 = min(params.y, 1.0);

	o.pos1.xyz	= BezierCurve3(t1, pos1_edges, pos1_extra, pos2_extra, pos2_edges);
	o.pos2.xyz	= BezierCurve3(t2, pos1_edges, pos1_extra, pos2_extra, pos2_edges);

	float3 trans1	= o.pos1.xyz - patch[0].pos.xyz; 
	float3 trans2	= o.pos2.xyz - patch[0].pos.xyz; 
	
	float nAge1 = lerp(params_y.x,	params_y.y,	 t1);
	float nAge2 = lerp(params_y.x,	params_y.y,	 t2);

	float2 nAges = float2(nAge1, nAge2);
	nAges = 1.0 - nAges;
	nAges = min(1, nAges*1.5);
	ages = nAges*AGE;


	float nTraceAge = AGE / patch[0].speed.w;
	float2 fadeIn = min(1, (float2(dot(trans1, trans1), dot(trans2, trans2))/6000));

	nAges  = 1.0-nAges;
	ages = (1.0-float2(nAge1, nAge2))*AGE;
	float2 opacity;
	
	opacity = (1-nAges) * (1 - nTraceAge.xx*nTraceAge.xx) * fadeIn * fadeIn * 0.024;
	opacity.x *= 1.0-smoothstep(0.45, 1.0, ages.x/AGE);
	opacity.y *= 1.0-smoothstep(0.45, 1.0, ages.y/AGE);
	opacity *= 1.1-saturate(AGE/2.0);

	o.opacityWidth.xy = opacity;

	o.opacityWidth.zw = traceWidth*(0.2+0.7*(1-nAges));

	o.vel1.xyz  = lerp(vel1_edges,	vel2_edges,	 t1);
	o.vel2.xyz  = lerp(vel1_edges,	vel2_edges,	 t2);

	return o;
}

[maxvertexcount(4)]
void gs(point DS_OUTPUT i[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	GS_OUTPUT o;

	float2 opacity = i[0].opacityWidth.xy;

	float3 camVector = gCameraPos - i[0].pos1;
	float3 offset1 = i[0].opacityWidth.z*normalize(cross(camVector, i[0].vel1.xyz));
	float3 offset2 = i[0].opacityWidth.w*normalize(cross(gCameraPos - i[0].pos2, i[0].vel2.xyz));

	o.params.w = (gSunDiffuse.r+gSunDiffuse.g)*0.5 * gSunIntensity;
	o.params.w *= gEffectsSunFactor*0.35;

	float fadeout = 1.0 - saturate((length(gCameraPos - i[0].pos1) - 100)/1000);

	o.pos = mul(float4(i[0].pos1+offset1, 1), gViewProj);
	o.params.xyz = float3(3.1415, opacity.x, fadeout);
	outputStream.Append(o);
	
	o.pos = mul(float4(i[0].pos1-offset1, 1), gViewProj);
	o.params.xyz = float3(0.0, opacity.x, fadeout);
	outputStream.Append(o);

	fadeout = 1.0 - saturate((length(gCameraPos - i[0].pos2) - 100)/1000);

	o.pos = mul(float4(i[0].pos2+offset2, 1), gViewProj);
	o.params.xyz = float3(3.1415, opacity.y, fadeout);
	outputStream.Append(o);
	
	o.pos = mul(float4(i[0].pos2-offset2, 1), gViewProj);
	o.params.xyz = float3(0.0, opacity.y, fadeout);
	outputStream.Append(o);


	outputStream.RestartStrip();

}

float4 ps(in GS_OUTPUT i): SV_TARGET0
{
	float t = smoothstep(0.7, 0.9, i.params.z);
	return float4(i.params.www * (gSunDiffuse*0.5 + 0.5), lerp(1.0, sin(i.params.x), t)*i.params.y*i.params.z);
}

technique10 tech
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));
		SetGeometryShader(CompileShader(gs_4_0, gs()));
		SetPixelShader(CompileShader(ps_4_0, ps()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}


}