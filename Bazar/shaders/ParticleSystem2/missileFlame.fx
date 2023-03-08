#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "common/random.hlsl"
#include "particleSystem2/common/motion.hlsl"
#include "particleSystem2/common/psCommon.hlsl"
#include "particleSystem2/common/perlin.hlsl"
#include "ParticleSystem2/common/splines.hlsl"


float4 param0;
float4 param1;

float3 pos0;
float3 pos1;
float3 tangent0;
float3 tangent1;
float3 speed0;
float3 speed1;

#define time		param0.x
#define scaleBase	param0.y
#define flameLength param0.z
#define brightness	param0.w
#define color       param1.xyz
#define clrAlpha    param1.a

static const float width = 0.2;

struct VS_OUTPUT{
	float4 pos	: 	TEXCOORD0;//pos + birthTime
};

struct HS_CONST_OUTPUT{
	float edges[2]:		SV_TessFactor;
	float2 sort:		TEXCOORD3;
	float3 t0:			TEXCOORD4;
	float3 t1:			TEXCOORD5;
	float4 tangent0:	TEXCOORD6;
	float4 speed0:		TEXCOORD7;
};

struct DS_OUTPUT{
	float4 pos:		POSITION0;
	float3 dir:		TEXCOORD1;
	float2 params:	TEXCOORD2;
};

struct GS_OUTPUT{
	float4 pos  : SV_POSITION0;
	float3 params:TEXCOORD0;
};


#define decomposeVec3(src, dir, value) float value = length(src.xyz); float3 dir = src.xyz/value;
#define decomposeVec3To(src, dir, value) value = length(src.xyz); dir = src.xyz/value;

// движение точки вдоль вектора скорости c торможением
float translationWithResistance(in float speedValue, in float t)
{
	const float offset = -2 * (1 + (speedValue - 55.556)/150 );
	const float xMin = exp(offset);
	return 4 * (log(xMin+2*t)-offset); //итоговое перемещение
}

VS_OUTPUT vs(uint vertId: SV_VertexId)
{
	VS_OUTPUT o;
	o.pos = float4(pos0 - worldOffset, 0);
	return o;
}

// HULL SHADER ---------------------------------------------------------------------
HS_CONST_OUTPUT hsConstant( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o;
	decomposeVec3To(tangent0, o.tangent0.xyz, o.tangent0.w);
	decomposeVec3To(speed0, o.speed0.xyz, o.speed0.w);
	
	float resultSpeedValue = o.tangent0.w + o.speed0.w;
	float transOverNozzleFactor = lerp(0.75, 0.15, min(1, o.tangent0.w/1000)) * mad(scaleBase, 0.8*0.333, 0.2);
	float transOverNozzleMax = translationWithResistance(resultSpeedValue, flameLength / o.tangent0.w) * transOverNozzleFactor;
	const float particlesMin = 32;
	o.edges[1] = particlesMin + (64-particlesMin) * saturate((transOverNozzleMax+flameLength)/30);
	o.edges[0] = 1;

	float3 posLast = ip[0].pos.xyz - o.tangent0.xyz * flameLength;

	o.sort.x = step( length(ip[0].pos.xyz-gViewInv._41_42_43), length(posLast-gViewInv._41_42_43) );
	o.sort.y = o.sort.x / floor(o.edges[1]);

	//касательные к сплайну позиций
	float3 p0 = pos0 - worldOffset;
	float3 p1 = pos1 - worldOffset;
	float segLen = distance(p0, p1);
	float coef = -0.33 * segLen;
	o.t0 = p0 + normalize(tangent0) * coef;
	o.t1 = p1 - normalize(tangent1) * coef;

	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("hsConstant")]
VS_OUTPUT hs( InputPatch<VS_OUTPUT, 1> ip, uint cpid : SV_OutputControlPointID)
{
	return ip[0];
}

// DOMAIN SHADER ---------------------------------------------------------------------
[domain("isoline")]
DS_OUTPUT ds( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<VS_OUTPUT, 1> patch, uniform bool bHighQuality)
{
	float3 tangent0Dir		= input.tangent0.xyz;
	float  tangent0Value	= input.tangent0.w;
	float3 speed0Dir		= input.speed0.xyz;
	float  speed0Value		= input.speed0.w;

	DS_OUTPUT o;
	UV.x = lerp(UV.x, 1-UV.x - input.sort.y, input.sort.x);	
	o.pos.w = UV.x;

	float lifetime = flameLength / tangent0Value;
	// float t = pow(UV.x, 2 + 8*min(1, tangent0Value/1000));
	float t = pow(UV.x, 5 + 5*min(1, tangent0Value/1000));
	float AGE = t * lifetime;
	
	if(bHighQuality)
	{
		float3 p0 = pos0 - worldOffset;
		float3 p1 = pos1 - worldOffset;
		
		//интерполированная позиция на траектории ракеты
		float3 p = BezierCurve3(t, p0, input.t0, input.t1, p1);
		
		//скорость эмиттера вдоль траектории
		float3 emitterSpeed = lerp(tangent0, tangent1, t);
		decomposeVec3(emitterSpeed, emitterSpeedDir, emitterSpeedValue);
		
		//результирующая скорость истечения струи
		float3 resultSpeed = lerp(speed0, speed1, t);
		decomposeVec3(resultSpeed, resultSpeedDir, resultSpeedValue);
		resultSpeedValue += emitterSpeedValue;
		
		//расчет перемещения струи вдоль сопла - копия из smokeTrail_sh.hlsl!!!
		float transOverNozzleFactor = lerp(0.75, 0.15, min(1, emitterSpeedValue/1000)) * mad(scaleBase, 0.8*0.333, 0.2);
		float transOverNozzle = translationWithResistance(resultSpeedValue, AGE) * transOverNozzleFactor;
		
		//итоговая позиция партикла
		o.pos.xyz = p + resultSpeedDir * transOverNozzle;
		
		//считаем нормализованный параметр перемещения вдоль всей длины пламени
		float transOverNozzleMax = translationWithResistance(resultSpeedValue, lifetime) * transOverNozzleFactor;
		o.params.y = min(1, distance(patch[0].pos.xyz, o.pos.xyz) / (transOverNozzleMax + flameLength));//scale factor
		o.params.y = pow(o.params.y, 0.5);
	}
	else
	{
		//расчет перемещения струи вдоль сопла - копия из smokeTrail_sh.hlsl!!!
		float resultSpeedValue = tangent0Value + speed0Value;
		float transOverNozzleFactor = lerp(0.75, 0.15, min(1, tangent0Value/1000)) * mad(scaleBase, 0.8*0.333, 0.2);
		float transOverNozzle = translationWithResistance(resultSpeedValue, AGE) * transOverNozzleFactor;
		
		//итоговая позиция партикла
		o.pos.xyz = pos0 - tangent0Dir * t * flameLength + speed0Dir * transOverNozzle - worldOffset;
		
		//считаем нормализованный параметр перемещения вдоль всей длины пламени
		float transOverNozzleMax = translationWithResistance(resultSpeedValue, lifetime) * transOverNozzleFactor;
		o.params.y = min(1, distance(patch[0].pos.xyz, o.pos.xyz) / (transOverNozzleMax + flameLength));//scale factor
		o.params.y = pow(o.params.y, 0.45);
	}
	
	float speedAngle = pow(abs(dot(ViewInv._31_32_33, speed0Dir)), 3);
	float SpeedDotNozzle = 1 - pow(abs(dot(tangent0Dir, speed0Dir)), 2);
	float speedStretch = 1 + 4 * (1-speedAngle) * SpeedDotNozzle * min(1, UV.x*2);
	o.params.x = speedStretch;
	o.dir.xyz = speed0Dir;
	return o;
}

[maxvertexcount(4)]
void gs(point DS_OUTPUT i[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	float3 gsPos			= i[0].pos.xyz;
	float gsParam			= i[0].pos.w;
	float3 gsNozzleDir		= i[0].dir.xyz;
	float gsSpeedStretch	= i[0].params.x;
	float gsScaleParam		= i[0].params.y;
	
	float frontSize = width * 0.3333;
	
	float2 noise = noise2(float2(time+gsParam*0.33217, time*0.3921+gsParam*0.163692), 4612.37491253);

	float scale = scaleBase * (frontSize + (0.75 + noise.y*0.4) * gsScaleParam);
	float4x4 mBillboard = mul(billboardOverSpeed(gsPos, gsNozzleDir, scale), VP);
	float2x2 mRot = rotMatrix2x2(noise.x*PI);

	GS_OUTPUT o;
	o.params.z = 1-gsScaleParam;
	o.params.z *= o.params.z;
	
	[unroll]
	for (int ii = 0; ii < 4; ++ii)
	{
		float4 vPos = {staticVertexData[ii].xy, 0, 1};
		o.params.xy = mul(vPos.xy, mRot) + 0.5;
		vPos.y *= gsSpeedStretch;//растягиваем вдоль вектора скорости
		o.pos = mul(vPos, mBillboard);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 ps(in GS_OUTPUT i): SV_TARGET0
{	
	float4 t = tex.Sample(ClampLinearSampler, i.params.xy);
	
	float psAge	= i.params.z;
	float alpha = lerp(t.a, t.r, psAge) * (psAge*0.98+0.02);
	float3 clr = color;
	clr.rgb *= brightness;
	return float4(clr, alpha*clrAlpha);
}


// #define enableAlphaBlend2 enableAlphaBlend
#define enableAlphaBlend2 additiveAlphaBlend

#if 0
BlendState enableAlphaBlend2
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = FALSE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};
#endif

VertexShader vsComp = CompileShader(vs_4_0, vs());
HullShader hsComp = CompileShader(hs_5_0, hs());
GeometryShader gsComp = CompileShader(gs_4_0, gs());
PixelShader psComp = CompileShader(ps_4_0, ps());

technique10 tech
{
	pass highQuality
	{
		SetVertexShader(vsComp);
		SetHullShader(hsComp);
		SetDomainShader(CompileShader(ds_5_0, ds(true)));
		SetGeometryShader(gsComp);
		SetPixelShader(psComp);
		
		SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	pass lod
	{
		SetVertexShader(vsComp);
		SetHullShader(hsComp);
		SetDomainShader(CompileShader(ds_5_0, ds(false)));
		SetGeometryShader(gsComp);
		SetPixelShader(psComp);
		
		SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}
