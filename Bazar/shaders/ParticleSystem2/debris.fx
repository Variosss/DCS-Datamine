#include "common/context.hlsl"
#include "common/random.hlsl"
#include "ParticleSystem2/common/modelShading.hlsl"
#include "ParticleSystem2/common/quat.hlsl"
#include "ParticleSystem2/common/motion.hlsl"

float4 worldOffset;
float4 params;
#define time worldOffset.w

float3	spreadDir; //TODO: �������� �� �������
uint	instanceIdOffset;
float3 	randomNumbers;
float 	weightSpeedY;

struct Instance
{
	float3 pos;
	float birthTime;
	
	float mass;	
	float lifetime;
	float2 rnd;
};
StructuredBuffer<Instance> sbInstanced;

//������ X
float3x3 makeRot(float3 dir)
{
	float3 Y,Z;
	if(abs(dir.y)<0.99)	{
		Z = normalize(cross(dir, float3(0,1,0)));
		Y = cross(Z, dir);
	} else {
		Y = normalize(cross(dir, float3(1,0,0)));
		Z = cross(dir, Y);
	}
	return float3x3(dir, Y, Z);
}

/*���������� ������ 3�3*/
float3x3 basis(float3 Z)
{
	float3 X,Y;
	if(abs(Z.y) < 0.90f) {
		X = normalize(cross(float3(0,1,0), Z));
		Y = cross(X, Z);
	} 
	else {
		Y = normalize(cross(Z, float3(1,0,0)));
		X = cross(Y, Z);
	}
	return float3x3(X,Z,Y);
};

MODEL_PS_INPUT vsDebris (
	in float3 pos: POSITION0,
	in float3 norm: NORMAL0,
	in float4 tangent: NORMAL1,
	in float2 uv: TEXCOORD0,
	in uint instId: SV_InstanceID
)
{
	instId += instanceIdOffset;
	const float2 rnd2 = sbInstanced[instId].rnd;
	const float birthTime = sbInstanced[instId].birthTime;
	const float age = max(0, time - birthTime);	

	//вращение вокруг собственной оси
	float4 rnd4 = noise4(float4(rnd2.x, rnd2.x+1.421312, rnd2.y, rnd2.y+1.6231235))-0.5;
	float4 quat = makeQuat(normalize(rnd4.xyz), 3.1415*(2*pow(age*2, 0.8) + rnd2.x));
	pos = qTransform(quat, pos);
	
	//������� ������ �������� � ��������� ��
	float3 vel = sbInstanced[instId].pos.xyz+0.5;
	vel += randomNumbers;
	vel = float3(frac(vel.x), frac(vel.y), frac(vel.z));
	vel = noise3(vel)-0.5;
	vel.y = abs(vel.y)*(2+weightSpeedY);
	vel.xz *= max((1.0-weightSpeedY*0.6), 0.0);

	//переводим ее в МСК
	float3x3 mWorld = basis(spreadDir);
	vel = mul(vel, mWorld);
	
	//летим по баллистической таректории
	// float3 trans = calcTranslation(vel*40, age);
	float3 trans = calcTranslationWithAirResistance(vel*40, sbInstanced[instId].mass*0.4 + 0.5, 1.0, age);
	
	//базис вдоль мирового вектора скорости
	// float3x3 mVel = basis((trans1-trans0));
	// pos.y *= 1 + min( 1, distance(trans0, trans1));
	// pos = mul(pos, mVel);
	
	//ставим на стартовую позицию
	pos += sbInstanced[instId].pos*4;
	
	MODEL_PS_INPUT o;
	o.wPos.w = saturate(3 -  3 * time / sbInstanced[instId].lifetime);
	o.wPos.xyz = pos + trans - worldOffset.xyz;
	o.pos = o.projPos = mul(float4(o.wPos.xyz, 1), gViewProj);
	// norm = mul(norm, mWorld);
	o.normal = qTransform(quat, norm);
	o.tangent = qTransform(quat, tangent.xyz);
	o.uv = uv;
	return o;
}

technique10 tech
{
	pass diffSpec
	{
		SetVertexShader(CompileShader(vs_5_0, vsDebris()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psModel(MAT_FLAGS_ALL_MAPS)));
		
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	}
}
