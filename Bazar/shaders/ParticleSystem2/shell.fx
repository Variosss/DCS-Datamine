#include "common/context.hlsl"
#include "common/random.hlsl"
#define USE_PREV_POS 1
#include "deferred/GBuffer.hlsl"
#include "ParticleSystem2/common/modelShading.hlsl"
#include "ParticleSystem2/common/quat.hlsl"
#include "ParticleSystem2/common/motion.hlsl"

float4 worldOffset;
float4 params;
#define time worldOffset.w
float4x4 prevFrameTransform;
static const float4 shellTable[] = //length, diameter, diameter
{
	{0.165, 0.030,	0.030,	0},
	{0.099, 0.0127, 0.0127,	0},
	{0.054, 0.00762,0.00762,0},
	{0.115, 0.023, 	0.023,	0},
	{0.102, 0.020, 	0.020,	0},
	{0.114, 0.0145, 0.0145,	0},
	{0.064, 0.013, 	0.013,	0}
};

struct Instance
{
	float3 pos;
	float birthTime;
	
	float3 speed;
	float lifetime;
	
	float3 dir;
	uint caliberId;
};
StructuredBuffer<Instance> sbInstanced;

float3 GetVectorScreenLength(float4 projPos, float3 wPrevPos)
{
	float4 p1 = projPos;
	float4 p2 = mul(mul(float4(wPrevPos, 1), prevFrameTransform), gPrevFrameViewProj);
	p1.xyz /= p1.w;
	p2.xy /= p2.w;

	float4 dir = float4(p2.xy-p1.xy, p1.z, 1);
	dir.x *= gProj._22 / gProj._11; 
	dir.z = length(dir.xy); 
	if (dir.z > 0.001)
		dir.xy /= dir.z; 
	
	else 
		dir.xy *= lerp(0.0, 1/0.001, smoothstep(0.0, 0.001, dir.z)); 

	return dir.xyz;
}

float3 GetVectorScreenLength2(float4 projPos, float3 wPrevPos)
{
	float4 p1 = projPos;
	float4 p2 = mul(float4(wPrevPos, 1), gViewProj);
	p1.xyz /= p1.w;
	p2.xy /= p2.w;

	float4 dir = float4(p2.xy-p1.xy, p1.z, 1);
	dir.x *= gProj._22 / gProj._11; 
	dir.z = length(dir.xy); 
	if (dir.z > 0.001)
		dir.xy /= dir.z; 
	
	else {
		dir.xy *= lerp(0.0, 1/0.001, smoothstep(0.0, 0.001, dir.z)); 
	}

	return dir.xyz;
}


MODEL_PS_INPUT vsDebris (
	in float3 pos: POSITION0,
	in float3 norm: NORMAL0,
	in float4 tangent: NORMAL1,
	in float2 uv: TEXCOORD0,
	in uint instId: SV_InstanceID
)
{
	const float birthTime = sbInstanced[instId].birthTime;
	const float age = max(0, time - birthTime);

	float3 axis = normalize(4.0*(noise3(float3(birthTime, birthTime+1.421312, birthTime+6.12312))-0.5));
	float4 quat = makeQuat(axis, 0.1 + age*2);

	float3 Y,Z;
	if(abs(sbInstanced[instId].dir.y)<0.99)	{
		Z = normalize(cross(sbInstanced[instId].dir, float3(0,1,0)));
		Y = cross(Z, sbInstanced[instId].dir);
	} else {
		Y = normalize(cross(sbInstanced[instId].dir, float3(1,0,0)));
		Z = cross(sbInstanced[instId].dir, Y);
	}
	float3x3 mRot = {sbInstanced[instId].dir, Y, Z};

	pos *= shellTable[sbInstanced[instId].caliberId].xyz;//������ ���������� ��������� ��� ID ������� ������
	pos = mul(pos, mRot);
	
	MODEL_PS_INPUT o;
	o.wPos.w = 1;
	o.wPos.xyz = qTransform(quat, pos);//��������� ������������� ������
	o.wPos.xyz += sbInstanced[instId].pos + calcTranslation(sbInstanced[instId].speed.xyz, age) - worldOffset.xyz;//������������ + ����� �� ��������
	o.pos = o.projPos = mul(float4(o.wPos.xyz, 1), gViewProj);
	float age_prev;
	float3 prevWPos;
	// = qTransform(makeQuat(axis, 0.1 + age*2), pos);
	//prevWPos += sbInstanced[instId].pos + calcTranslation(sbInstanced[instId].speed.xyz, age) - worldOffset.xyz;

	float3 dir = GetVectorScreenLength(o.projPos, o.wPos);
	o.prevProjPos = o.projPos + 0.1*float4(dir, 0.0);

	age_prev = max(0.0, age - 0.02*gPrevFrameTimeDelta);
	prevWPos = qTransform(makeQuat(axis, 0.1 + age_prev*2), pos);
	prevWPos += sbInstanced[instId].pos + calcTranslation(sbInstanced[instId].speed.xyz, age_prev) - worldOffset.xyz;

	dir = GetVectorScreenLength2(o.projPos, prevWPos);
	o.prevProjPos += 0.15*float4(dir, 0.0);

	o.normal = mul(norm, mRot);
	o.normal = qTransform(quat, o.normal);
	o.uv = uv;
	return o;
}

technique10 tech
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, vsDebris()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psModel(MAT_FLAG_DIFFUSE_MAP | MAT_FLAG_SPECULAR_MAP)));
		
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	}
}
