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

#define time			params.x
#define phase			params.y
#define chaffRadius		params.z
#define particleSize	params.w

#define	PI2 6.28319

#define	PI 6.28319*0.5


struct VS_OUTPUT
{
	float4 pos: POSITION0;
	float4 rnd: TEXCOORD0;
};

struct GS_OUTPUT
{
	float4 pos: SV_POSITION0;
	float4 color: COLOR0;
	float2 uv:	TEXCOORD0;
};

static const float4 particle[4] = {
    float4( -0.5,  0.5, 0, 1),
    float4( 0.5,  0.5, 1, 1),
    float4( -0.5, -0.5, 0, 0),
    float4( 0.5, -0.5, 1, 0)
};

VS_OUTPUT vsChaff(uint vertId:  SV_VertexID)
{
	VS_OUTPUT o;
	//неслучайные числа для партикла 
	o.rnd = noise4( float4(vertId*0.1783234+0.123, vertId*0.2184295, vertId*0.48564523+0.321, vertId*0.37291365+0.42) + (phase+1)*0.358231 );
	
	float theta= (o.rnd.x+sin(time+o.rnd.w*1.64382)*0.03) * PI2;
	float phi = (o.rnd.y+sin(time+o.rnd.z*5.8532)*0.03) * PI;
	float radius = sqrt(o.rnd.z) * chaffRadius * pow(time, 0.45) + sin(time*0.2+o.rnd.w*7.432173)*chaffRadius * min(1,time*0.3);

	float3 dir = convertSphericalToRect(theta, phi, radius);
	o.pos = float4(dir + worldOffset, 1);	
	//o.pos = float4(worldOffset+vertId*float3(0.1, 0.0, 0.0), 1);
	return o;
}

[maxvertexcount(4)]
void gsChaff(point VS_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	GS_OUTPUT o;
	float4 rnd2 = noise4(input[0].rnd);
	
	const float scale = 0.07;
	const float speed = 0.35;
	
	float2 ang = float2(time*(0.8+0.2*rnd2.z) + rnd2.x*5.6921, time + rnd2.y*7.172) * PI2 * speed;
	// float2 ang = float2(time*0.8, 0) * PI2;

	float3x3 mRot = mul(rotMatrixZ(ang.x), rotMatrixY(ang.y));

	float3 norm = mul(float3(1, 0, 0), mRot);	

	//lambert
	float3 vNorm = mul(float4(norm,0), gView).xyz;//ибо частичка у нас освещается с двух сторон, а нормалька торчит только в одну
	float NoL = max(0, dot(norm, -gSunDir.xyz) * sign(vNorm.z));
	
	//phong
	float3 V = normalize(input[0].pos.xyz - gCameraPos.xyz);
	float3 R = reflect(gSunDir.xyz, norm);
	float RoV = max(0, dot(R, V));
	
	float3	ambient = AmbientLight(norm);
	float3	diffuse = 0.8*0.8;
	float3	specular = pow(RoV, 20);
	
	// float glowFactor = saturate((specular-0.2)*5);
	float nDist = min(1, distance(input[0].pos.xyz, gCameraPos.xyz)/400);
	
	

	float glowFactor = step(0.15+nDist*0.85, specular);

	diffuse /= PI;
	//diffuse IBL
	const float IBL_intensity = 0.5;
	o.color.rgb = diffuse * ambient * IBL_intensity;
	//sun diffuse
	o.color.rgb += (diffuse + specular) * getPrecomputedSunColor(0) * NoL;
	
	float alpha = 1-0.3*glowFactor;
	
	for (int ii = 0; ii < 4; ++ii)	
	{
		float4 wPos = {0, particle[ii].xy*particleSize, 1};
		//мировая позиция партикла
		wPos.xyz = mul(wPos.xyz, mRot)*(1-glowFactor) + input[0].pos.xyz;

		//если частица блестит - поворачиваем на экран
		o.pos = mul(wPos, gView);
		o.pos /= o.pos.w;

		o.color.a = alpha * saturate(o.pos.z-1.2);//не рисуем в кабине
		o.pos.xyz += (float3(1,0,0)*particle[ii].x + float3(0,1,0)*particle[ii].y)*glowFactor*(0.06 + 1*nDist);
		o.pos = mul(o.pos, gProj);
		o.color.rgb *= 1.0 + glowFactor*1.2;
		o.uv = particle[ii].xy*lerp(0.04, 1, glowFactor) + 0.5; // [0.04...glowFactor]
		outputStream.Append(o);
	}

	outputStream.RestartStrip();                          
}
 
float4 psChaff(GS_OUTPUT i): SV_TARGET0
{
	float alpha = tex.Sample(ClampLinearSampler, i.uv).r;
	alpha*=alpha; // to gamma space
	return float4(i.color.rgb, i.color.a*alpha);
}

technique10 chaffTech
{
	pass p0
	{
		DISABLE_CULLING;
		ENABLE_DEPTH_BUFFER;
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_4_0, vsChaff()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsChaff()));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psChaff())); 
	}
}
