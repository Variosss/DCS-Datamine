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

Texture3D foamTex;

struct VS_INPUT
{
	float4 params0: TEXCOORD0; // startPosL.xyz, birthTime
	float3 params1: TEXCOORD1; // lifetime, rand.xy
};

struct VS_OUTPUT
{
	float4 params0: TEXCOORD0; // posV.xyz, nFrame
	float4 params1: TEXCOORD1; // scale, angle, opacity, shadowFactor
};

struct PS_INPUT
{
	float4 pos: SV_POSITION0;
	float4 projPos: TEXCOORD1; 
	float4 params0: TEXCOORD2; // halo, opacity, shadowFactor, nFrame
    float2 params1: TEXCOORD3; // uv.xy
};

float4 gParams0; // gVelocity.xyz, gTime,
float4 gParams1; // gSpeed, gScaleBase, gScaleMax, gOpacityBase
float3 gParams2; // gBaseColor.xyz

#define gVelocity gParams0.xyz
#define gTime gParams0.w
#define gSpeed gParams1.x
#define gScaleBase gParams1.y
#define gScaleMax gParams1.z
#define gOpacityBase gParams1.w
#define gBaseColor gParams2.xyz

VS_OUTPUT VS(VS_INPUT i, uniform bool SHADOWS_ENABLED)
{
	// INPUT VERTEX
	#define inStartPosL i.params0.xyz
	#define inBirthTime i.params0.w 
	#define inLifetime 	i.params1.x
	#define inRand 	i.params1.yz

	// OUTPUT VERTEX	
	VS_OUTPUT o;
	#define outPosV o.params0.xyz
	#define outNFrame o.params0.w
	#define outScale o.params1.x	
	#define outAngle o.params1.y 
    #define outOpacity o.params1.z
	#define outShadowFactor o.params1.w

	float age = gTime-inBirthTime;
	float nAge = age/inLifetime;


    float3 speed = float3(sampleUniformDist(gSpeed*0.7, gSpeed, inRand.x), 0.0, sampleUniformDist(-gSpeed*0.3, gSpeed*0.3, inRand.y));
    float3 translation = age*speed;

	float3x3 speedBasis = basisShip(gVelocity);
    float3 posW = inStartPosL + mul(translation, speedBasis) - worldOffset;

    outPosV = mul_v3xm44(posW, gView);
    outShadowFactor = (SHADOWS_ENABLED) ? 1.0 : getCascadeShadow(posW, getDepthByZView(outPosV.z));
	outOpacity = lerp_pow(gOpacityBase, 0.0, nAge, 8.0);

	float relativeOpacity = outOpacity/gOpacityBase;
	outScale = min(gScaleBase/relativeOpacity, gScaleMax);
	outScale = sampleUniformDist(outScale, outScale*1.3, inRand.x);

	float rAngleOffset = sampleUniformDist(0, 3.14*0.3, inRand.x);
	float rAngleSpeed = sampleUniformDist(3.14, 3.14*1.2, inRand.y);
	
	float sign = (inRand.x > 0.5) ? 1.0 : -1.0;
	rAngleSpeed *= sign; 
    outAngle = rAngleOffset + age*rAngleSpeed;

	float rFrameOffset = sampleUniformDist(0.0, 0.2, inRand.y);
	float frameSpeed = gSpeed*0.1;
	outNFrame = min(age/2.0+rFrameOffset, 1.0);
	return o;
}

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	PS_INPUT o;

	#define inPosV          input[0].params0.xyz
	#define inNFrame		input[0].params0.w
	#define inScale         input[0].params1.x	
	#define inAngle         input[0].params1.y 
    #define inOpacity       input[0].params1.z
	#define inShadowFactor  input[0].params1.w

	#define outPos	        o.pos
	#define outProjPos	    o.projPos
	#define outSunHalo      o.params0.x
	#define outOpacity      o.params0.y
    #define outShadowFactor o.params0.z
	#define outNFrame		o.params0.w
    #define outUV           o.params1.xy
	

	outNFrame = inNFrame;
	outOpacity = inOpacity;
	outSunHalo = getHaloFactor(gSunDirV.xyz, inPosV)*0.4;
    outShadowFactor = inShadowFactor;

	float4x4 billboardM = billboardView(inPosV, inScale, inAngle);
	billboardM  = mul(billboardM, gProj);
	[unroll]
	for (int i = 0; i < 4; i++)
	{
		float3 vPos = {staticVertexData[i].xy, 0};
		outPos = mul_v3xm44(vPos, billboardM);
		outProjPos = outPos;
		outUV = staticVertexData[i].zw;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 PS(PS_INPUT i) : SV_TARGET0
{
#define inPos	       i.pos
#define inProjPos	   i.projPos
#define inSunHalo      i.params0.x
#define inOpacity      i.params0.y
#define inShadowFactor i.params0.z
#define inNFrame	   i.params0.w	 
#define inUV           i.params1.xy
	float4 finalClr;
	float mask = foamTex.Sample(gTrilinearClampSampler, float3(inUV, inNFrame)).r;
	mask *= mask;

    finalClr.a = tex.Sample(gTrilinearClampSampler, inUV).a;
	finalClr.a *= mask;
	finalClr.a *= inOpacity;
	//return float4(inOpacity, 0.0, 0.0, 1.0);
	finalClr.a = applyDepthAlpha(finalClr.a, inProjPos, 1.0);
	clip(finalClr.a - 0.001);

	finalClr.rgb = gBaseColor;

	//float NoL = satDotNormalized(float3(0.0, 0.0, 1.0), gSunDirV, 0.5);
	//finalClr.rgb = shading_AmbientSunHalo_Atmosphere(gBaseColor, AmbientTop, NoL/PI*inShadowFactor, inSunHalo, 0);
	return finalClr;
}


technique10 tech
{
	//в полете
	pass P0{
		SetGeometryShader(CompileShader(gs_5_0, GS()));
		SetVertexShader(CompileShader(vs_5_0, VS(false)));
		SetPixelShader(CompileShader(ps_5_0, PS()));
		
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ENABLE_ALPHA_BLEND;
	}
	pass P1{
		SetGeometryShader(CompileShader(gs_5_0, GS()));
		SetVertexShader(CompileShader(vs_5_0, VS(true)));
		SetPixelShader(CompileShader(ps_5_0, PS()));
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}
}