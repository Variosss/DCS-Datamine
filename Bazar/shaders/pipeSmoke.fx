#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/random.hlsl"

#define ATMOSPHERE_COLOR
#define NO_DEFAULT_UNIFORMS
#define CLOUDS_SHADOW
#include "ParticleSystem2/common/psCommon.hlsl"

// #define DEBUG_FIXED_SIZE_AND_ANGLE
// #define DEBUG_PARTICLE_ID
// #define DEBUG_NO_PS

#define getTextureFrameUV getTextureFrameUV16x8

Texture2D			tex;
Texture2D<float2>	texNoise;
float4				params0;
float4				params1;

#define trailLength				params0.x
#define tubeRadius 				params0.y
#define splineSegments			params0.z
#define nVel					params0.w //скорость для нормализованной длины шлейфа

#define trailDir				params1.xyz
#define effectNDist				params1.w

static const float tubeRadiusToParticleSize = 2.0; //пересчет радиуса трубы в радиус партикла
static const float particleDistanceFactor = 0.6; //дистанция между партиклами
static const float dissipationFactor = 1.0; //разлет партиклов к концу следа
static const float opacityMax = 0.9;
#ifdef USE_DCS_DEFERRED
static const float3 smokeColor = float3(1.0, 1.0, 0.75) * 0.85;
#else
static const float3 smokeColor = float3(1.1,1.1, 0.8);
#endif

struct VS_OUTPUT {
	float4 pos: POSITION0;
	float nDist: TEXCOORD0;
	float shadow: TEXCOORD1;
};

struct HS_PATCH_OUTPUT {
	float	edges[2] : SV_TessFactor;
	float4	orderOffset: TEXCOORD7;
};

struct GS_INPUT {
	float4 pos: POSITION0;
	float4 params: TEXCOORD0;
	float shadow: TEXCOORD1;
};

struct PS_INPUT {
	float4 pos: SV_POSITION0;
	float3 uv : TEXCOORD0;
	nointerpolation float4 sunDirM: TEXCOORD1;
	nointerpolation float3 sunColor: TEXCOORD2;
};


VS_OUTPUT vs(float4 pos: POSITION0, float nDist: TEXCOORD0, uint vertId: SV_VertexId)
{
	VS_OUTPUT o;
	o.pos = pos;
	o.nDist = nDist;
	o.shadow = getCloudsShadow(pos.xyz);
	return o;
}

HS_PATCH_OUTPUT hsConst(InputPatch<VS_OUTPUT, 2> ip)
{
	#define POS_MSK(id) ip[id].pos.xyz
	HS_PATCH_OUTPUT o;
	o.edges[0] = 1; // detail factor
	//количество сегментов на которые разбиваем отрезок
	o.edges[1] = floor(trailLength / splineSegments / (tubeRadius * tubeRadiusToParticleSize * particleDistanceFactor) + 0.5);
	o.edges[1] = clamp(o.edges[1], 1.0, 64.0);

	//сортировка
	o.orderOffset.x = step( length(ip[0].pos.xyz - gViewInv._41_42_43), length(ip[1].pos.xyz - gViewInv._41_42_43) );
	//так как мы рисуем сегментами непрерывную линию из партиклов,
	//последний партикл не должен накладываться на первый, поэтому равномерно сжимаем параметр t
	o.orderOffset.y = o.edges[1] / (o.edges[1] + 1.0);

	float particlesTotal = floor((o.edges[1] + 1.0) * splineSegments + 0.5);//ибо input.edges[1] есть количество сегментов
	
	//затайленое время анимации
	float time = fmod(gModelTime, 1.0 / nVel);
	//нормализованный сдвиг тайла
	float trans = nVel * time;
	o.orderOffset.z = fmod(trans, 1.0 / particlesTotal);//затайленое перемещение партикла
	o.orderOffset.w = floor(trans * particlesTotal);//затайленый сдвиг ID партиклов
	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(2)]
[patchconstantfunc("hsConst")]
VS_OUTPUT hs(InputPatch<VS_OUTPUT, 2> ip, uint id : SV_OutputControlPointID)
{
	VS_OUTPUT o;
	o = ip[id];
	return o;
}

[domain("isoline")]
GS_INPUT ds(HS_PATCH_OUTPUT input, OutputPatch<VS_OUTPUT, 2> op, float2 uv : SV_DomainLocation)
{
	//сортируем
	float tSegment = lerp(uv.x, 1.0 - uv.x, input.orderOffset.x) * input.orderOffset.y; //позиция партикла в сегменте
	
	float tStart = op[0].nDist + (op[1].nDist - op[0].nDist) * tSegment; //стартовая позиция партикла на сплайне

	//имитируем движение с заданной скоростью относительно нормализованной длины шлейфа
	float t = tStart + input.orderOffset.z;
	
	//пересчитываем параметр сплайна в параметр сегмента обратно с учетом перемещения
	tSegment = (t - op[0].nDist) / (op[1].nDist - op[0].nDist);

	//затайленый ID партикла по всей длине сплайна
	const float particlesTotal = floor((input.edges[1] + 1.0) * splineSegments + 0.5); //ибо input.edges[1] есть количество сегментов
	uint pId = tStart * particlesTotal + 0.5;// локальный Id партикла
	uint id = (uint(particlesTotal) + uint(input.orderOffset.w) - pId ) % uint(particlesTotal);
	
	GS_INPUT o;
	o.shadow = lerp(op[0].shadow, op[1].shadow, tSegment);
	o.pos.w = op[0].pos.w; //seed
	o.pos.xyz = lerp(op[0].pos.xyz, op[1].pos.xyz, tSegment);
	o.params.x = t; // nAge
	o.params.y = noise1(id*13.37295746182366912);
#ifdef DEBUG_PARTICLE_ID
	o.params.y = (float)id / particlesTotal;
#endif
	o.params.zw = 0;

	//рандомайзим форму по перлину
	const float perturbationFactor = 0.10;
	float3x3 mWorld = basis(trailDir.yxz);
	float3 perturbationPos = 0;
	float t2 = nVel * gModelTime;
	perturbationPos.zx = (texNoise.SampleLevel(gBilinearWrapSampler, float2((t-t2)*0.2 + o.pos.w, 0), 0).rg*2-1);	
	o.pos.xyz += mul(perturbationPos, mWorld) * (t * trailLength * perturbationFactor);
	
	float2 rnd = noise2(float2(id*13.37295746182366912 + 13.77312, id*44.3211745678 + 5.91653))*2-1;
	o.pos.xyz += mul(float3(rnd.x, 0, rnd.y), mWorld) * (tubeRadius * t * dissipationFactor);

	return o;
}

[maxvertexcount(4)]
void gs(point GS_INPUT i[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float3 gsPos	= i[0].pos.xyz;
	float gsSeed	= i[0].pos.w;
	float nAge		= i[0].params.x;
	float randBase	= i[0].params.y;

	float4 rand = noise4((randBase + frac(gsSeed) + float4(0, 0.612312932, 0.22378683, 0.5312313)) * float4(1, 1.5231, 1.125231, 1.65423));
	
#ifndef DEBUG_FIXED_SIZE_AND_ANGLE
	nAge = min(1, nAge * (1 + 1*rand.z));
	float2 rand2 = noise2(rand);
	float3 dir = normalize(float3(rand2.x, 0, rand2.y) * 2.0 - 1.0);
	gsPos.xz += dir.xz * tubeRadius * randBase; //стартовая позиция партикла в радиусе трубы
	float gsAngle = gModelTime * 0.05 * (1 + randBase * 0.3) + rand.x * PI2;
	float gsScale = (tubeRadius * tubeRadiusToParticleSize) * (1 + 3 * (rand.y*0.5+0.5) * nAge);
#else
	float gsAngle = gModelTime * 0.05;
	float gsScale = tubeRadius * tubeRadiusToParticleSize;
#endif

	float2x2 M = rotMatrix2x2(gsAngle);

	gsPos = mul(float4(gsPos,1), gView).xyz;
	
	//анимация текстуры
	float4 uvOffsetScale = getTextureFrameUV(randBase*3, 10);
	uvOffsetScale.xy *= 0.98;
	
	PS_INPUT o;
	o.sunColor = getPrecomputedSunColor(0) * i[0].shadow;
	//направление на солнце в пространстве партикла + halo фактор
	o.sunDirM = float4(getSunDirInNormalMapSpace(M), getHaloFactor(gSunDirV.xyz, gsPos, 10) * 0.7);
	o.uv.z = saturate(min(1, nAge * 4) * max(0, 2 - 2*nAge)) * saturate(2 - 2*effectNDist) * opacityMax;// opacity
#ifdef DEBUG_PARTICLE_ID
	o.uv.z = pow(randBase, 1/1.5)*3;// opacity
#endif
	[unroll]
	for (int ii = 0; ii < 4; ++ii)
	{
		float4 vPos = {mul(staticVertexData[ii].xy, M) * gsScale, 0, 1};
		vPos.xyz += gsPos;
		o.pos = mul(vPos, gProj);
		o.uv.xy = staticVertexData[ii].zw * uvOffsetScale.xy + uvOffsetScale.zw;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 ps(PS_INPUT i, uniform bool bAtmosphere): SV_TARGET0
{
#ifdef DEBUG_NO_PS
	return float4(i.uv.zzz, 0.5);
	return float4(AmbientTop * gIBLIntensity + gSunDiffuse * gSunIntensity, 0.15 * i.uv.z);
#endif
	
	float4 t = tex.Sample(gTrilinearClampSampler, i.uv.xy);

	float NoL = max(0, dot(t.xyz*2 - 1, -i.sunDirM.xyz)*0.5 + 0.5);
	
	float haloFactor = i.sunDirM.w * (1 - min(1, 1.5 * t.a));
	
	float3 color = shading_AmbientSunHalo(smokeColor, AmbientTop, i.sunColor * (NoL / PI), haloFactor);

	return float4(applyPrecomputedAtmosphere(color, 0), t.a * i.uv.z);
}

float4 psFLIR(PS_INPUT i) : SV_TARGET0
{
	float4 t = tex.Sample(gTrilinearClampSampler, i.uv.xy);
	return (t.xxx*2, t.a * i.uv.z);
}

VertexShader	vsComp = CompileShader(vs_5_0, vs());
HullShader		hsComp = CompileShader(hs_5_0, hs());
DomainShader	dsComp = CompileShader(ds_5_0, ds());
GeometryShader	gsComp = CompileShader(gs_5_0, gs());

technique10 tech
{
	pass noAtmosphere
	{
		DISABLE_CULLING;
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(vsComp);
		SetHullShader(hsComp);
		SetDomainShader(dsComp);
		SetGeometryShader(gsComp);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps(false))); 
	}
	/*
	pass withAatmosphere
	{
		DISABLE_CULLING;
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(vsComp);
		SetHullShader(hsComp);
		SetDomainShader(dsComp);
		SetGeometryShader(gsComp);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps(true)));
	}
	*/
}

technique10 techFLIR
{
	pass FLIR
	{
		DISABLE_CULLING;
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

		SetVertexShader(vsComp);
		SetHullShader(hsComp);
		SetDomainShader(dsComp);
		SetGeometryShader(gsComp);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psFLIR()));
	}
}
