#include "common/context.hlsl"
#include "common/random.hlsl"
#include "ParticleSystem2/common/modelShading.hlsl"
#include "ParticleSystem2/common/quat.hlsl"
#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

float4x4 world;
float3 wind;
float4 params;
float time;
float3	spreadDir; //TODO: заменить на матрицу
float lifetime;
struct Preset
{
	float2 uvMin;
    float2 uvMax;
    float2  size;
    float2 sizeUVDelta;
};

float explosionPower;

StructuredBuffer<Preset> sbPresets;

struct VS_OUTPUT
{
	float3	posV		: TEXCOORD1;
    float3 angleAgeScale   : POSITION1;
    float4 quat : POSITION2;
	int3 typeSubtype : TEXCOORD0;
};


//вокруг X
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



struct PS_INPUT
{
    float4 pos		 : SV_POSITION;
	float4 projPos   : TEXCOORD3;
    float3 TextureUVAge : TEXCOORD0; // UV, transparency, alphaMult
    nointerpolation float3 sunColor:  TEXCOORD1;
    float3 sunDirM: TEXCOORD2;
};

VS_OUTPUT vsDebris (
	in float4 posBirthTime: TEXCOORD0,
    in float4 massScaleRND: TEXCOORD1,
	in int4  typeSubtype: TEXCOORD2
)
{
#define mass massScaleRND.x
#define scale massScaleRND.y

	const float2 rnd2 = massScaleRND.zw;
	const float birthTime = posBirthTime.w;
	const float age = max(0, time - birthTime);
    float3 pos = posBirthTime.xyz;

	//float3 vel = noise3(pos.xyz*10000);
	float3 vel = noise3(pos.xyz*rnd2.x*3.14);
	vel = float3((vel.x -0.5)*2*sqrt(2), abs(vel.y)/10.0+0.2, (vel.z -0.5)*2*sqrt(2));
	vel = normalize(vel);
	//вращение вокруг собственной оси
	float4 rnd4 = noise4(float4(rnd2.x, rnd2.x+1.421312, rnd2.y, rnd2.y+1.6231235))-0.5;
	//pos = qTransform(quat, pos);

	float3 dir = spreadDir;
	//dir.y *= 4.0;
	dir = normalize(dir);
	//переводим ее в ћ— 
	float3x3 mWorld = basis(dir);
	vel = mul(vel, mWorld);

	//летим по баллистической таректории
	// float3 trans = calcTranslation(vel*40, age);
	float3 trans = calcTranslationWithAirResistance(vel*explosionPower-age*wind, mass*0.4 + 0.5, 1.0, age);

	//базис вдоль мирового вектора скорости
	// float3x3 mVel = basis((trans1-trans0));
	// pos.y *= 1 + min( 1, distance(trans0, trans1));
	// pos = mul(pos, mVel);

	//ставим на стартовую позицию
	//pos += sbInstanced[instId].pos*4;


    float sign = 1.0;
    if(rnd2.x > 0.5)
     sign = -1.0;

	VS_OUTPUT o;
    o.posV.xyz = mul(float4(pos.xyz, 1.0), world) + trans + age*wind;
    o.angleAgeScale = float3(sign*3.1415*(2*pow(age*2, 0.8) + rnd2.x), min(age/lifetime, 1.0), scale);
    o.typeSubtype = typeSubtype.xyz;
	o.quat = makeQuat(normalize(rnd4.xyz), 3.1415*(2*pow(age*2, 0.8) + rnd2.x));
	return o;
}

[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<MODEL_PS_INPUT> outputStream)
{
	#define posOffset input[0].posV.xyz
	#define angle input[0].angleAgeScale.x
    #define nAge input[0].angleAgeScale.y
    #define scale input[0].angleAgeScale.z

    Preset preset = sbPresets[input[0].typeSubtype.x];
	float4 uvOffsetScale;
    uvOffsetScale.zw = lerp(preset.uvMin, preset.uvMax, float2(input[0].typeSubtype.yz)/preset.size);
    uvOffsetScale.xy = preset.sizeUVDelta;

    float scaleUpdated =  scale*pow(1.0-nAge, 0.5);

    MODEL_PS_INPUT psIn;
    float3 normal = float3(0.0, 0.0, 1.0);
	float4 quat = input[0].quat;

    psIn.normal = normal;
    psIn.tangent = 0;
	[unroll]
	for (int i = 0; i < 4; i++)
	{
		psIn.uv= float2(staticVertexData[i].z, staticVertexData[i].w);
		psIn.uv *= uvOffsetScale.xy;
		psIn.uv += uvOffsetScale.zw;
		// if(sign > 0)
		// 	psIn.uv = 0;

		psIn.wPos= float4(staticVertexData[i].x, staticVertexData[i].y, 0, 1);
        psIn.wPos.xyz = qTransform(quat, psIn.wPos.xyz);
        psIn.wPos.xyz *= scaleUpdated;	
        psIn.wPos.xyz += posOffset;
        psIn.pos = psIn.projPos = mul(psIn.wPos, gViewProj);
		psIn.wPos.w = saturate(3 -  3 * nAge);
		outputStream.Append(psIn);
	}
	outputStream.RestartStrip();
}

// float4 PS(PS_INPUT i) : SV_TARGET0
// {
// 	float4 finalColor = textr.Sample(gBilinearClampSampler, i.TextureUVAge.xy);
//     finalColor.xyz *= 1.0 - 0.3*(1.0-i.TextureUVAge.z);
//     clip(finalColor.a-0.001);
//     float3 normal = float3(0.0, 0.0, 1.0);
//     float NoL = saturate(dot(normal, i.sunDirM)*0.5 + 0.5);

// 	finalColor.xyz = shading_AmbientSun(finalColor.xyz, AmbientTop, i.sunColor*NoL/PI);
//     //return float4(i.TextureUVAge.xy, 0.0, 1.0);
// 	//return float4(applyPrecomputedAtmosphere(finalColor.xyz, 0), finalColor.a);
// }

// float4 PS(MODEL_PS_INPUT psIn) : SV_TARGET0
// {
//     return float4(psIn.normal.z*0.5 + 0.5, 0.0, 0.0, 1.0);
// }

GBuffer PS_ALPHA_TEST( MODEL_PS_INPUT i,
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex: SV_SampleIndex,
#endif
	uniform int flags)
{
	MaterialParams mp = GetMaterialParams(i, flags);
	mp.aorm = float4(0.0, 0.5, 0.75, 1.0);

    clip(mp.diffuse.a-0.001);

	return BuildGBuffer(i.pos.xy,
#if USE_SV_SAMPLEINDEX
		sv_sampleIndex,
#endif
		mp.diffuse*1.35, mp.normal, mp.aorm, mp.emissive, calcMotionVectorStatic(i.projPos));	// TODO: correct motion vector to use calcMotionVector()
}

technique10 tech
{
	pass P0
	{
		// ENABLE_RO_DEPTH_BUFFER;
		// ENABLE_ALPHA_BLEND;
		// DISABLE_CULLING;
		// SetVertexShader(CompileShader(vs_5_0, vsDebris()));
		// SetHullShader(NULL);
		// SetDomainShader(NULL);
		// SetComputeShader(NULL);
    	// GEOMETRY_SHADER(GS())
		// PIXEL_SHADER(PS())
    	

        ENABLE_DEPTH_BUFFER;
		DISABLE_ALPHA_BLEND;
		DISABLE_CULLING;
        //AlphaTestEnable = true;
		SetVertexShader(CompileShader(vs_5_0, vsDebris()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetComputeShader(NULL);
    	GEOMETRY_SHADER(GS())
    	SetPixelShader(CompileShader(ps_5_0, PS_ALPHA_TEST(MAT_FLAG_DIFFUSE_MAP | MAT_FLAG_CLIP_IN_COCKPIT | MAT_FLAG_DITHERING)));
		SetBlendState(enableAlphaToCoverage, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	}
}
