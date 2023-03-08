	#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#define FOG_ENABLE
#include "common/fog2.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/easing.hlsl"
#include "common/random.hlsl"
#include "common/motion.hlsl"
#include "common/basis.hlsl"
#include "common/softParticles.hlsl"

struct VS_INPUT
{
	float4 params0: TEXCOORD0; // startPosL.xyz, birthTime
	float4 params1: TEXCOORD1; // dir.xyz, rand[0;1]
	float  params2: TEXCOORD2; // lifetime
};

struct VS_OUTPUT
{
	float4 params0: TEXCOORD0; // posOffsetV, angle
	float3 params1: TEXCOORD1; // scale, nFrame, opacity
};

struct PS_INPUT
{
	float4 pos: SV_POSITION0;
	float4 projPos: TEXCOORD1;
	float4 params0: TEXCOORD2; // sunDirM halo
	float3 params1: TEXCOORD3; // uv, opacity 
};

float4x4 gWorldView;
float4 gParams0; // gWindConvVelocityV, gTime
float4 gParams1; // gSpeedConv, gSpeedBase, gOpacityBase, gAcceleration
float4 gParams2; // gSmokeColorBase, gScaleMax
float  gParams3; // gDelayBeforeRot

#define gWindConvVelocityV gParams0.xyz
#define gTime gParams0.w
#define gScaleBase gParams1.x
#define gSpeedBase gParams1.y
#define gOpacityBase gParams1.z
#define gAcceleration gParams1.w
#define gSmokeColorBase gParams2.xyz
#define gScaleMax gParams2.w
#define gDelayBeforeRot gParams3.x

VS_OUTPUT VS(VS_INPUT i)
{
	// INPUT
	#define inStartPosL i.params0.xyz
	#define inBirthTime i.params0.w 
	#define inDir 		i.params1.xyz
	#define inRand 		i.params1.w
	#define inLifetime  i.params2.x

	// OUTPUT	
	// float4 params1: TEXCOORD0; // outPosOffset, angle
	// float2 params2: TEXCOORD1; // scale, age, opacity
	VS_OUTPUT o;
	#define outPosOffsetV o.params0.xyz
	#define outAngle o.params0.w 
	#define outScale o.params1.x	
	#define outNFrame o.params1.y 
	#define outOpacity o.params1.z

	float age = gTime-inBirthTime;
	float nAge = age/inLifetime;

	float speed = sampleUniformDist(gSpeedBase*0.8, gSpeedBase, inRand);
	float acceleration = sampleUniformDist(gAcceleration*0.6, gAcceleration, inRand);
	
	float timeStop = speed/gAcceleration;
	float timePhase0 = min(age, timeStop);

	// phase 0 movement
	float pathTotal = calcTranslation_ConstAcceleration(speed, acceleration, timePhase0);
	float2 startPosL = inStartPosL.yz;

	outAngle = 0;
	if(age > timeStop+gDelayBeforeRot){
		// phase 1 movement
		float timePhase1 = age-timeStop-gDelayBeforeRot;
		float turbAngle = calcTranslation_ConstAcceleration_LimitedSpeed(0, acceleration*2, 7.0, timePhase1);
		float2x2 turbRotM = rotMatrix2x2(turbAngle);
		startPosL = mul(startPosL, turbRotM);	

		pathTotal += calcTranslation_ConstAcceleration(0, acceleration*0.7, timePhase1);
		outAngle = turbAngle;
	}

	float3 posOffsetL = -pathTotal*inDir + float3(inStartPosL.x, startPosL);
	
	// transform to view space and estimating convection and wind influence
	outPosOffsetV = mul_v3xm34(posOffsetL, gWorldView);
	outPosOffsetV += age*gWindConvVelocityV;

	outOpacity = lerp_pow(gOpacityBase, 0.0, nAge, 1.0/12.0);

	float relativeOpacity = outOpacity/gOpacityBase;
	outScale = min(gScaleBase/relativeOpacity, gScaleMax);
	outScale = sampleUniformDist(outScale, outScale*1.3, inRand);
	outNFrame = sampleUniformDist(age*0.7, age, inRand);

	return o;
}

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	PS_INPUT o;

	#define inPosOffsetV	input[0].params0.xyz
	#define inAngle			input[0].params0.w
	#define inScale			input[0].params1.x
	#define inNFrame		input[0].params1.y
	#define inOpacity 		input[0].params1.z

	#define outPos	o.pos
	#define outProjPos	o.projPos
	#define outSunDirM o.params0.xyz
	#define outSunHalo o.params0.w
	#define outUV o.params1.xy
	#define outOpacity o.params1.z

	outOpacity = inOpacity;

	float4x4 billboardM = billboardView(inPosOffsetV, inScale, inAngle);

	outSunDirM = -getSunDirInNormalMapSpace((float2x2)(billboardM)); 
	outSunHalo = getHaloFactor(gSunDirV.xyz, inPosOffsetV)*0.4;
	
	float4 uvOffsetScale = getTextureFrameUV16x8ByNTime(inNFrame, 0.1);

	billboardM  = mul(billboardM, gProj);
	[unroll]
	for (int i = 0; i < 4; i++)
	{
		float3 vPos = {staticVertexData[i].xy, 0};
		outPos = mul_v3xm44(vPos, billboardM);
		outProjPos = o.pos;

		outUV = staticVertexData[i].zw * uvOffsetScale.xy + uvOffsetScale.zw;

		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 PS(PS_INPUT i) : SV_TARGET0
{
//	return float4(1.0, 0.0, 0.0, 1.0);
#define inProjPos i.projPos
#define inSunDirM i.params0.xyz
#define inSunHalo i.params0.w
#define inUV i.params1.xy
#define inOpacity i.params1.z

	float4 finalClr;

	float4 normal = tex.Sample(gTrilinearClampSampler, inUV);
	normal.xyz = unpackUnitVec(normal.xyz);
	clip(normal.a - 0.001);

	finalClr.a = normal.a*inOpacity;
	finalClr.a = applyDepthAlpha(finalClr.a, inProjPos);

	float NoL = satDotNormalized(normal.xyz, inSunDirM, 0.5);
	finalClr.rgb = shading_AmbientSunHalo_Atmosphere(gSmokeColorBase, AmbientTop, NoL/PI, inSunHalo, 0);
	return finalClr;
}

#define PASS_BODY(vs, gs, ps)  { SetVertexShader(vs); SetGeometryShader((gs)); SetPixelShader(ps); \
		DISABLE_CULLING; ENABLE_RO_DEPTH_BUFFER; SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);}

GeometryShader	gsCompiled = CompileShader(gs_4_0, GS());
PixelShader		psCompiled = CompileShader(ps_4_0, PS());

technique10 tech
{
	//в полете
	pass P0{
		SetGeometryShader(CompileShader(gs_4_0, GS()));
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetPixelShader(CompileShader(ps_4_0, PS()));
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}
}