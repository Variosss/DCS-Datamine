#include "common/context.hlsl"
#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "common/softParticles.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"

Texture3D fireTex;

float4x4 World;
float4 params0;
float4 params1;
float4 params2;
float4 flameColor;

#define engineFreq		params0.x
#define enginePhase		params0.y
#define frameFreq		params0.z//ФПС
#define engineFreqN		params0.w//нормализованная частота вращения вала двигателя

#define scaleBase		params1.x
#define opacityMax		params1.y
#define particleAspect	(params1.zw)

#define exhaustIntensity params2.x
#define strobVisMin		 params2.y//минимальная видимость пламени при максимальном стробоскопическом эффекте

static const float2 UVOffset = {0.0, -0.28};

static const float  engineFreqMax = 50.0;//не более 3000 об/мин
static const float  combustionDuration = 1.0 / 4.0;//время горения в цикле
static const float3 orangeFlameColor = float3(1.000, 0.456, 0.173);
static const float3 blueFlameColor = float3(0.2, 0.2, 1);

static const float nFrameMin = 2*(1/combustionDuration);
static const float nFrameMax = 4*(1/combustionDuration);

TEXTURE_SAMPLER(fireTex, MIN_MAG_MIP_LINEAR, MIRROR, CLAMP);

struct VS_OUTPUT
{
	float4 pos: POSITION0;
	float3 dir: TEXCOORD0;
};

struct PS_INPUT
{
	float4 pos: SV_POSITION0;
	float4 uv : TEXCOORD0;
	float4 projPos	 : TEXCOORD1;
};

float GetLuminanceMult(float multPower = 1.0)
{
	return 1 + multPower * (1 - pow(saturate((gSunDir.y+0.07)*3.0), 0.35));
}

VS_OUTPUT vs(float4 posPhase: POSITION0, float3 dir: TEXCOORD0)
{
	VS_OUTPUT o;
	o.pos = posPhase;
	o.dir = dir;
	return o;
}

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void gs(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float phaseOffset = input[0].pos.w;	
	
	//частота обновления экрана должна быть выше частоты вращения вала двигателя в 2*(1/combustionDuration)
	//чтобы хотя бы один кадр гарантированно попадал в фазу гарения
	float nFrameFreq = frameFreq / max(0.1, engineFreq);//частота обновления экрана относительно часоты вращения вала двигателя
	float frameFactor = 1 - saturate((nFrameFreq-nFrameMin) / (nFrameMax - nFrameMin));
	
	float phase = frac(enginePhase + phaseOffset);
	
	float combustionFactor = lerp(combustionDuration, 1.0, frameFactor);//имитируем что пламя видно весь цикл
	
	//когда частота обновления кадра позволяет разглядеть отдельные вспышки
	float visibility = sin( max(0, (phase - (1-combustionFactor)) / combustionFactor) * PI );
	
	float3 pos = mul(float4(input[0].pos.xyz, 1), World).xyz;
	float3 dir = mul(input[0].dir.xyz, (float3x3)World).xyz;

	float4x4 mBillboard = mul(billboardOverSpeed(pos, normalize(dir), scaleBase), VP);

	PS_INPUT o;
	o.uv.z  = frac(gModelTime*(1+1.5*engineFreqN) + phaseOffset);
	o.uv.w  = strobVisMin*frameFactor + (1-strobVisMin*frameFactor) * visibility; //(bClouds) ? 1-getCloudsColor(0).a : 1;
	o.uv.w *= opacityMax;
	o.uv.w *= GetLuminanceMult(5.0);

	float frontView = abs(dot(normalize(pos-gCameraPos.xyz), normalize(dir)));

	float aspect = lerp(particleAspect.x, particleAspect.y, exhaustIntensity*(1-frontView*frontView));

	[unroll]
	for(int i = 0; i < 4; ++i)
	{
		o.uv.xy = staticVertexData[i].zw;
		float4 vPos = {staticVertexData[i].xy + UVOffset, 0, 1};
		vPos.y *= aspect;
		o.pos = o.projPos = mul(vPos, mBillboard);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 ps(PS_INPUT i) : SV_TARGET0
{
	float4 clr = 0;
	for(uint ii=0; ii<4; ++ii)
	{
		i.uv.z = frac(i.uv.z +(1.0/4.0));
		i.uv.y += 0.05;
		clr += fireTex.Sample(gBilinearClampSampler, i.uv.xyz);
	}
	clr.a *= depthAlpha(i.projPos, 20.0);
	clip(clr.a-0.1);
	return clr * flameColor * i.uv.w;
}


technique10 Textured
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gs()));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps()));

		DISABLE_CULLING;
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	}
}
