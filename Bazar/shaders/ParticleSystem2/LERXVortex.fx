#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/random.hlsl"
#include "common/stencil.hlsl"

#define CLOUDS_SHADOW
#define CASCADE_SHADOW
#define ATMOSPHERE_COLOR
// #define NO_DEFAULT_UNIFORMS
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/splines.hlsl"
#include "ParticleSystem2/common/noiseSimplex.hlsl"

// #define DEBUG_FIXED_SIZE_AND_ANGLE
// #define DEBUG_PARTICLE_ID
// #define DEBUG_NO_PS

#define NO_VORTEX
// #define NO_EXPLOSION
#define EXPLICIT_OPACITY
#define PER_PARTICLE_CASCADE_SHADOW

Texture2D noiseTex;

float4x4 World;

float4	params0;
float3	params1;
float4	params2;
float4	params3;
float3	smokeColor;

#define trailLength				params0.x
#define particleSizeMin 		params0.y
#define splineSegments			params0.z
#define nVel					params0.w //скорость для нормализованной длины шлейфа

#define effectSeed				params1.x
#define effectOpacity			params1.y
#define effectLighting			params1.z

#define explosionsStartDist		params2.x
#define explosionsStartRadius	params2.y

#define explosionRadius			params3.x
#define explosionScale			params3.y
#define explosionAgeFactor		params3.z
#define vortexSpinDir			params3.w

static const float particleSizeFactor = 2.3;//множитель на размер патикла, чтобы текстура визуально совпадала с радиусом вихря
static const float particleDistanceFactor = 1.0; //дистанция между партиклами
static const float dissipationFactor = 1.5; //разлет партиклов к концу следа
static const float upscaleFactor = 7.0;
static const float shadeFactor = effectLighting;
static const float opacityMax = effectOpacity;

struct VS_OUTPUT {
	float4 pos: 	POSITION0;
	float4 vel:		TANGENT0;
	float nDist:	TEXCOORD0;
	float shadow:	TEXCOORD1;
};

struct HS_PATCH_OUTPUT {
	float	edges[2]:		SV_TessFactor;
	float4	orderOffset:	TEXCOORD3;
	float3	tangent0:		TANGENT0;
	float3	tangent1:		TANGENT1;
};

struct GS_INPUT {
	float4 pos: 	POSITION0;
	float4 vel: 	TANGENT0;
	float4 params:	TEXCOORD0;
	float shadow:	TEXCOORD1;
};

struct PS_INPUT {
	float4 pos: SV_POSITION0;
	float3 uv : TEXCOORD0;
	nointerpolation float4 sunDirM: TEXCOORD1;
	nointerpolation float3 sunColor: TEXCOORD2;
};

VS_OUTPUT vs(
	float4 pos: 	POSITION0,
	float4 velDist: TEXCOORD0,
	float  opacity:	TEXCOORD1,
	uniform bool bCascadeShadow)
{
	VS_OUTPUT o;
	o.pos = pos;
	float4 p = mul(float4(o.pos.xyz, 1), World);
	o.pos.xyz = p.xyz;
	o.vel.xyz = mul(velDist.xyz, (float3x3)World).xyz;
	o.vel.w = opacity;
	o.nDist = velDist.w;
	o.shadow = getCloudsShadow(pos.xyz);

#ifndef PER_PARTICLE_CASCADE_SHADOW
	if(bCascadeShadow)
	{
		float4 projPos = mul(float4(o.pos.xyz,1), gViewProj);
		o.shadow *= getCascadeShadowForVertex(p.xyz/p.w, projPos.z/projPos.w);
	}
#endif
	return o;
}

HS_PATCH_OUTPUT hsConst(InputPatch<VS_OUTPUT, 2> ip)
{
	#define RADIUS(id)  ip[id].pos.w
	#define POS_MSK(id)	ip[id].pos.xyz
	#define TAN(id)		ip[id].vel.xyz
	
	float segmentLength = distance(POS_MSK(0), POS_MSK(1));
	float radius = max(particleSizeMin, min(RADIUS(0), RADIUS(1)) );

	HS_PATCH_OUTPUT o;
	o.edges[0] = 1; // detail factor
	//количество сегментов на которые разбиваем отрезок
	o.edges[1] = floor(segmentLength / (radius * particleDistanceFactor) + 0.5);
	o.edges[1] = clamp(o.edges[1], 4.0, 64.0);

	//сортировка
	o.orderOffset.x = step( length(POS_MSK(0) - gCameraPos), length(POS_MSK(1) - gCameraPos) );
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

	float tangentLength = segmentLength * 0.333;
	o.tangent0 = POS_MSK(0) + normalize(TAN(0)) * tangentLength;
	o.tangent1 = POS_MSK(1) - normalize(TAN(1)) * tangentLength;
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
#ifndef PER_PARTICLE_CASCADE_SHADOW
	o.shadow = min(ip[0].shadow, ip[1].shadow);
#endif
	return o;
}

[domain("isoline")]
GS_INPUT ds(HS_PATCH_OUTPUT input, OutputPatch<VS_OUTPUT, 2> op, float2 uv : SV_DomainLocation, uniform bool bCascadeShadow = false)
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
	
	//на маленьком радиусе партиклов видны отдельные партиклы и смотрится не гуд, поэтому в первом сегменте радиус увеличиваем не линейно
	float radiusFactor = op[0].nDist<1.0e-3? 0.4 : 1.0;
	
	GS_INPUT o;	
	o.vel	   = lerp(op[0].vel, op[1].vel, tSegment);
	o.pos.xyz  = BezierCurve3(tSegment, op[0].pos.xyz, input.tangent0, input.tangent1, op[1].pos.xyz);
	o.pos.w    = lerp(op[0].pos.w, op[1].pos.w, pow(tSegment, radiusFactor)); //radius
	o.params.x = t; // nAge
	o.params.y = noise1(id*13.37295746182366912);
#ifdef DEBUG_PARTICLE_ID
	o.params.y = (float)id / particlesTotal;
#endif
	o.params.zw = 0;
	o.shadow   = lerp(op[0].shadow, op[1].shadow, tSegment);
#ifdef PER_PARTICLE_CASCADE_SHADOW
	if(bCascadeShadow)
	{
		float4 projPos = mul(float4(o.pos.xyz,1), gViewProj);
		o.shadow *= getCascadeShadowForVertex(o.pos.xyz, projPos.z/projPos.w);
	}
#endif
	return o;
}

struct ParticleState
{
	float3	pos;
	float	opacity;
	float	radius;
};

ParticleState getExplosionParams(float nAge, float splineRadius, float4 rnd)
{
	ParticleState p;
	
	p.pos = 0;
	
	float phase = frac(nAge*0.1 - gModelTime*nVel + effectSeed*13.12372);

	float4 t = noiseTex.SampleLevel(gBilinearWrapSampler, float2(phase, 0), 0);

	p.pos.yz += normalize(t.xy * 2 - 1) * t.z * 0.8;
	p.pos.yz += normalize(rnd.xy * 2 - 1) * (rnd.z * 0.5);
	p.pos.yz *= splineRadius;

	p.radius = max(splineRadius, explosionsStartRadius * particleSizeFactor) * (1 + 0.5*t.z);
	
	p.opacity = t.a * exp( - max(0, p.radius-explosionsStartRadius) );// * saturate(0.5 + 1.5 * rnd.w);

	return p;
}

[maxvertexcount(4)]
void gs(point GS_INPUT i[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float3 gsPos		= i[0].pos.xyz;
	float gsVortexRadius= i[0].pos.w;
	float nAge			= i[0].params.x;
	float rndBase		= i[0].params.y;
	float gsOpacity		= i[0].vel.w;

	float4 rnd = noise4((rndBase + frac(effectSeed) + float4(0, 0.612312932, 0.22378683, 0.5312313)) * float4(1, 1.5231, 1.125231, 1.65423));
	
	float explPower = 0;
	float nExplosion = saturate(explosionsStartDist / trailLength);//нормализованное время начала взрыва вихря
	const float explLengthFactor = 0.15;

	float nExplAge = max(0, nAge - nExplosion);
	
	ParticleState state;
	
	state.pos = 0;//local
	state.radius = max(particleSizeMin, gsVortexRadius * particleSizeFactor * (0.9+0.2*rnd.y));
	state.opacity = gsOpacity * opacityMax;
	
#ifndef DEBUG_FIXED_SIZE_AND_ANGLE

	explPower = min(1, nExplAge / explLengthFactor);
	
	ParticleState expl = getExplosionParams(nExplAge, gsVortexRadius, noise4(rnd));	
	state.pos		= lerp(state.pos, expl.pos, explPower);
	state.radius	= lerp(state.radius, expl.radius, explPower);
	state.opacity  *= lerp(1, expl.opacity, explPower);
	
	gsPos.xyz += mul(state.pos, World).xyz;
	
	float gsAngle = vortexSpinDir*gModelTime + rnd.x * PI2;
	
#else
	float gsAngle = vortexSpinDir*gModelTime * 0.05;
	state.radius = particleSizeMin * 2;
#endif

	float2x2 M = rotMatrix2x2(gsAngle);

	gsPos = mul(float4(gsPos, 1), gView).xyz;
	
	PS_INPUT o;
	float trans = 0.2;
	i[0].shadow = trans + (1-trans)*i[0].shadow;
	o.sunColor = getPrecomputedSunColor(0) * i[0].shadow;
	// o.sunColor = explPower * 10;
	// o.sunColor = (nAge > nExplosion) * 10;
	o.sunDirM = float4(getSunDirInNormalMapSpace(M), getHaloFactor(gSunDirV.xyz, gsPos, 10) * 0.7);
	
#ifdef EXPLICIT_OPACITY
	o.uv.z = state.opacity;
#else
	float opacityFadeIn = min(1, nAge * 10);
	float opacityFadeOut = saturate((2 - 2*nAge));
	opacityFadeOut = min(opacityFadeOut, saturate(1-explPower) / (1 + explosionScale * explPower) );	
	o.uv.z = saturate(opacityFadeIn * opacityFadeOut * opacityMax);// opacity
#endif

#ifdef DEBUG_PARTICLE_ID
	o.uv.z = pow(rndBase, 1/1.5)*3;// opacity
#endif

	[unroll]
	for (int ii = 0; ii < 4; ++ii)
	{
		float4 vPos = {mul(staticVertexData[ii].xy, M) * state.radius, 0, 1};
		vPos.xyz += gsPos;
		o.pos = mul(vPos, gProj);
		o.uv.xy = staticVertexData[ii].zw * 0.98;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 ps(PS_INPUT i): SV_TARGET0
{
#ifdef DEBUG_NO_PS
	return float4(i.uv.zzz, 0.5);
	// return float4(i.uv.z, frac(i.uv.z * 142.31231231), i.uv.z, 1.0);
#endif
	
	float4 t = tex.Sample(gTrilinearClampSampler, i.uv.xy); clip(t.a);

	float NoL = max(0, dot(t.xyz*2 - 1, -i.sunDirM.xyz)*0.5 + 0.5); 
	NoL = pow(NoL, 1.5);
	NoL = lerp(0.4, NoL, shadeFactor);

	float haloFactor = i.sunDirM.w * (1 - min(1, 1.0 * t.a)) * shadeFactor;

	float trans = 0.2;
	NoL = trans + (1-trans)*NoL;
	float3 color = shading_AmbientSunHalo(smokeColor*smokeColor, AmbientTop, i.sunColor * (NoL / PI), haloFactor);

	return float4(applyPrecomputedAtmosphere(color, 0), t.a * i.uv.z);
}

VertexShader	vsComp = CompileShader(vs_5_0, vs(false));
VertexShader	vsCascadeComp = CompileShader(vs_5_0, vs(true));
HullShader		hsComp = CompileShader(hs_5_0, hs());
DomainShader	dsComp = CompileShader(ds_5_0, ds());
DomainShader	dsCascadeComp = CompileShader(ds_5_0, ds(true));
GeometryShader	gsComp = CompileShader(gs_5_0, gs());

technique10 tech
{
	pass main
	{
		DISABLE_CULLING;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		// SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(vsComp);
		SetHullShader(hsComp);
		SetDomainShader(dsComp);
		SetGeometryShader(gsComp);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps())); 
	}
	pass withShadow
	{
		DISABLE_CULLING;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		// SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(vsCascadeComp);
		SetHullShader(hsComp);
		SetDomainShader(dsCascadeComp);
		SetGeometryShader(gsComp);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps())); 
	}
}
