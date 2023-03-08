#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "common/softParticles.hlsl"
#include "common/lighting.hlsl"

#include "ParticleSystem2/common/motion.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

float3 bulletParams;

float4 lightDiffuseIntensity;
float3 lightPos;

#define smokeOpacityBase bulletParams.x
#define smokeScale	bulletParams.y
#define time		bulletParams.z

static const int particles = 5;

static const float zFeather = 0.1 / 0.2;

struct VS_INPUT{
	float4 posBirth		: POSITION0;//pos + birthTime
	float4 speedLifetime: TEXCOORD0;//speed + lifetime
};

struct VS_OUTPUT{
    float4 pos	: POSITION0;//pos + birthTime
	float4 speed: TEXCOORD0;//speed + lifetime
};

struct HS_CONST_OUTPUT{
	float edges[2] : SV_TessFactor;
};

struct HS_OUTPUT{
    float4 pos  : POSITION0;
	float4 speed: TEXCOORD0;
};

struct DS_OUTPUT{
    float4 pos	: POSITION0;
	float4 params:TEXCOORD0;
};

struct GS_OUTPUT{
    float4 pos  : SV_POSITION0;
	float4 params: TEXCOORD0;// UV, opacity, gun light attenuation
	float4 gunLightDirHalo: TEXCOORD1;
	float4 normalSunHalo: NORMAL;
	float4 projPos: TEXCOORD2;
};


VS_OUTPUT vs(in VS_INPUT i)
{
	VS_OUTPUT o;
	o.pos = i.posBirth;
	o.speed = i.speedLifetime;
	return o;
}


// HULL SHADER ---------------------------------------------------------------------
HS_CONST_OUTPUT hsConstant( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o; 
	o.edges[1] = particles;
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
	o.speed = ip[0].speed;

    return o;
}

// DOMAIN SHADER ---------------------------------------------------------------------
[domain("isoline")]
DS_OUTPUT ds( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	#define dsBirthTime patch[0].pos.w	
	#define dsLifetime patch[0].speed.w
	#define dsSpeed patch[0].speed.xyz

    DS_OUTPUT o;	
	float age = time - dsBirthTime;
	float nAge = age / dsLifetime;
	float opacity = min(1,age*20) * pow(1 - nAge,3) * 0.35 * smokeOpacityBase;//fadeIn, fadeOut
	float scale = (1.0 + sqrt(max(0,(nAge-0.06)*1.064))*3) * smokeScale;
	float speedValue = length(dsSpeed);
	float3 dir = dsSpeed/speedValue;
	
	float3 rand = { noise2D(float2(dsBirthTime, UV.x*17.32157)), 
					noise2D(float2(dsBirthTime+5.835636, UV.x*17.32157+7.41834)),
					noise2D(float2(dsBirthTime+8.624569, UV.x*17.32157+3.62133))};
	
	// float dist = noise1D(UV.x*3.5163602)*min(1, age*20)*0.2 + age*0.8;
	float dist = noise1D(UV.x*3.5163602)*min(1, age*20)*0.2 + sqrt(max(0, (age-0.1)*1.1111))*1;
	
	rand = normalize(rand-0.5);//��������� ������	

	o.pos.xyz = patch[0].pos.xyz - worldOffset + rand*dist*smokeScale*0.75;
	o.pos.xyz += dir*calcTranslationWithDeceleration(speedValue, 200, age);//�������� �� ���� �� ��������� ��������
	o.pos.w = age;	
	o.params.x = opacity;
	o.params.y = noise2D(float2(dsBirthTime+1.432, UV.x*32.57203))*PI2; //ANGLE
	o.params.z = scale;//scale

	float3 dis = (lightPos.xyz-worldOffset)-o.pos.xyz;
	o.params.w = min(1.0, 1.0/dot(dis, dis)); //* pow(1-saturate(gSunDir.y*5),2);
    
    return o;
}

[maxvertexcount(4)]
void gs(point DS_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	#define gsPos input[0].pos.xyz
	#define gsOpacity input[0].params.x
	#define gsAngle input[0].params.y
	#define gsScale input[0].params.z
	
	GS_OUTPUT o;
	float _sin, _cos;
	sincos(gsAngle, _sin, _cos);
	
	

	o.params.w = input[0].params.w;
	o.gunLightDirHalo.xyz = normalize(mul(float4(lightPos.xyz - gsPos, 0), gView).xyz);
	float4 vPos = mul(float4(gsPos,1), gView);
	vPos /= vPos.w;
	
	o.gunLightDirHalo.w = getHaloFactor(o.gunLightDirHalo.xyz, vPos);
	o.params.z = gsOpacity * saturate(vPos.z-1);
	o.normalSunHalo.w = getHaloFactor(gSunDirV, vPos);
	
	float2x2 M = {
		_cos, _sin,
		-_sin,  _cos
	};
	
	[unroll]
	for (int i = 0; i < 4; i++)
	{
		float4 p = float4(staticVertexData[i].xy, 0, 1);
		o.params.xy = mul(staticVertexData[i].xy, M)+0.5;
		
		p.xy *= gsScale;
		p.xyz += vPos.xyz;
		o.pos = o.projPos = mul(p, gProj);
		o.normalSunHalo.xyz = float3(staticVertexData[i].xy, -0.2);
		
		outputStream.Append(o);
	}
	outputStream.RestartStrip();	
}

float4 ps(in GS_OUTPUT i): SV_TARGET0
{
	#define psOpacity i.params.z
	#define psLightAtt i.params.w
	
	i.normalSunHalo.xyz = normalize(i.normalSunHalo.xyz);
	float sunDot = dot(i.normalSunHalo.xyz, gSunDirV)*0.5 + 0.5;
	float gunDot = saturate(dot(i.normalSunHalo.xyz, i.gunLightDirHalo.xyz));

	//������� ������������ ��������
	float particleAlpha = max(0,(tex.Sample(gTrilinearClampSampler, i.params.xy).a-0.2)*1.25);

	float3 sunColor = getPrecomputedSunColor(0);
	//�������� ���������
	float3 smokeColor = shading_AmbientSunHalo(/*baseColor*/0.2, AmbientAverage, sunColor*sunDot/PI, i.normalSunHalo.w);

	//float3 lightC = float3(255/255.0, 130/255.0, 30/255.0);
	//������� �� ��������
	float3 gunLightColor = lightDiffuseIntensity.xyz*(gunDot+i.gunLightDirHalo.w)*psLightAtt;//todo: ���� �� �����!!! 	
	smokeColor += particleAlpha*gunLightColor*0.02;
	
	float alpha = particleAlpha*psOpacity *depthAlpha(i.projPos, zFeather)*0.5;
	if (alpha < 1.0 / 255)
		discard;

	return float4(smokeColor, alpha);
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}


float4 psFlir(in GS_OUTPUT i): SV_TARGET0
{
	#define psOpacity i.params.z
	
	//������� ������������ ��������
	float particleAlpha = max(0,(tex.Sample(gTrilinearClampSampler, i.params.xy).a-0.2)*1.25);

	
	float alpha = particleAlpha*psOpacity *depthAlpha(i.projPos, zFeather)*0.4;
	if (alpha < 1.0 / 255)
		discard;

	float l = 0.3;

	return float4(l,l, l, alpha);
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

	pass p1
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));	
		SetGeometryShader(CompileShader(gs_4_0, gs()));
		SetPixelShader(CompileShader(ps_4_0, psFlir()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}
