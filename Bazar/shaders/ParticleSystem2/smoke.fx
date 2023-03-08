#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/softParticles.hlsl"
#include "common/random.hlsl"

#define CLOUDS_SHADOW
#define ATMOSPHERE_COLOR
// #define NO_DEFAULT_UNIFORMS
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/splines.hlsl"
#include "ParticleSystem2/common/noiseSimplex.hlsl"

// #define DEBUG_FIXED_SIZE_AND_ANGLE
// #define DEBUG_PARTICLE_ID
// #define DEBUG_NO_PS

#define getTextureFrameUV		getTextureFrameUV16x8

float4	params0;
float4	params1;
float4	params2;
float4	params3;
float4	params4;
float2	params5;
float3	smokeColor;

Texture2D colorGradientTex;
Texture2D alphaGradientTex;

#define trailLength				params0.x
#define particleSizeFactor		params0.y
#define splineSegments			params0.z
#define nVel					params0.w //скорость для нормализованной длины шлейфа

#define heightFactor			params1.x // UNUSED
#define effectOpacity			params1.y
#define effectLighting			params1.z
#define animSpeed				params1.w

#define flameAttenuation		(params2.xy)
#define flamePower				params2.z
#define flameFactor				params2.w

#define particleSize			(params3.xy)
#define emitterTime				params3.z
#define emitterScale			params3.w

#define trailDir				params4.xyz
#define visibilityLength		params4.w

#define widthAtStart			params5.x
#define particleDistanceFactor	params5.y

static const float shadeFactor = effectLighting;
static const float opacityMax = effectOpacity;

struct VS_OUTPUT {
	float4 pos: POSITION0;
	float3 tangent: TANGENT0;
	float nDist: TEXCOORD0;
	float shadow: TEXCOORD1;
};

struct HS_PATCH_OUTPUT {
	float	edges[2] : SV_TessFactor;
	float4	orderOffset: TEXCOORD3;
};

struct GS_INPUT {
	float4 pos: POSITION0;
	float4 params: TEXCOORD0;
	float shadow: TEXCOORD1;
	uint   tiledID: TEXCOORD2;
};

struct PS_INPUT {
	float4 pos: SV_POSITION0;
	float4 posProj: NORMAL0;
	float4 uv : TEXCOORD0;
	nointerpolation float4 sunDirM: TEXCOORD1;
	nointerpolation float3 sunColor: TEXCOORD2;
};

VS_OUTPUT vs(float4 pos: POSITION0, float4 tangentDist: TEXCOORD0, uint vertId: SV_VertexId)
{
	VS_OUTPUT o;
	o.pos = pos;
	o.pos.xyz = o.pos.xyz * trailLength * emitterScale + worldOffset;
	o.tangent = tangentDist.xyz;
	o.nDist = tangentDist.w;
	o.shadow = getCloudsShadow(pos.xyz);
	return o;
}

HS_PATCH_OUTPUT hsConst(InputPatch<VS_OUTPUT, 2> ip)
{
	#define POS_MSK(id) ip[id].pos.xyz
	HS_PATCH_OUTPUT o;
	o.edges[0] = 1; // detail factor
	//количество сегментов на которые разбиваем отрезок
	o.edges[1] = floor(trailLength / splineSegments / (particleSize.x * particleDistanceFactor) + 0.5);
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
	
	const float perturbationFactor = 0.2; ///!!!!!!!!!!!!!!!!!!!!!!!!!!!

	float particleSizeFinal = particleSize.x * emitterScale;
	
	o.pos.xyz = lerp(op[0].pos.xyz, op[1].pos.xyz, tSegment);
	o.pos.y += sqrt(t) * trailLength * heightFactor;
	o.pos.y -= 0.16 * particleSizeFinal;//чтобы партикл появлялся из под земли
	
	float3x3 mWorld = basis(trailDir.yxz);
	float3 perturbationPos = 0;
	float t2 = nVel * gModelTime;
	perturbationPos.x = snoise(float2((t-t2)*4, o.pos.w*10.0))*0.5;
	perturbationPos.z = snoise(float2((t-t2)*4, o.pos.w*10.0 + 1123.412));
	
	float2 rnd = noise2(float2(id*13.37295746182366912 + 13.77312, id*44.3211745678 + 5.91653))*2-1;
	
	o.pos.xyz += mul(float3(rnd.x, 0, rnd.y), mWorld) * (particleSizeFinal * widthAtStart * saturate(1-t*2));

	o.pos.xyz += mul(perturbationPos, mWorld) * (t * trailLength * perturbationFactor);

	o.tiledID = id;
	
	o.params.x = t; // nAge
	o.params.y = noise1(id*13.37295746182366912);
#ifdef DEBUG_PARTICLE_ID
	o.params.y = (float)id / particlesTotal;
#endif
	o.params.zw = 0;
	return o;
}

[maxvertexcount(4)]
void gs(point GS_INPUT i[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float3 gsPos	= i[0].pos.xyz;
	float gsSeed	= i[0].pos.w;
	float nAge		= i[0].params.x;
	float randBase	= i[0].params.y;

	float4 rand = noise4((randBase + gsSeed + float4(0.012312, 0.612312932, 0.22378683, 0.5312313)) * float4(10.015123, 1.5231, 1.125231, 1.65423));
	
	float nAgeLod = min(1.0, nAge * (1.0 + 1.5 * (i[0].tiledID%2)));
	
#ifndef DEBUG_FIXED_SIZE_AND_ANGLE
	nAge = min(1, nAge * (1 + 0.2*rand.z));
	gsPos.y += max(rand.w-0.5, 0)  * nAge * trailLength * 0.15;
	float gsAngle = gModelTime * 0.05 * (1 + randBase * 0.3) + rand.x * PI2;
	float gsScale = lerp(particleSize.x, particleSize.y, pow(nAge, particleSizeFactor)) * step(nAgeLod, 0.9999);
#else
	float gsAngle = gModelTime * 0.05;
	float gsScale = particleSize.x * step(nAgeLod, 0.9999);
#endif

	// float2x2 M = rotMatrix2x2(gsAngle);
	float2x2 M = rotMatrix2x2((rand.x*2-1) * PI * (0.20 + 0.7*min(1.0, nAge*1.5)) + PI);

	gsPos = mul(float4(gsPos, 1), gView).xyz;

	//анимация текстуры
	float age = nAge/nVel;//в секундах от начала дыма	
	float4 uvOffsetScale = getTextureFrameUV( (pow(age, 0.7) + randBase) * animSpeed*0.5);
	uvOffsetScale.xy *= 0.98;
	
	PS_INPUT o;
	o.sunColor = getPrecomputedSunColor(0);// * i[0].shadow;
	//направление на солнце в пространстве партикла + halo фактор
	o.sunDirM = float4(-getSunDirInNormalMapSpace(M), getHaloFactor(gSunDirV.xyz, gsPos, 10) * 0.21 * shadeFactor);
	
	//прозрачность
	float startOpacity = saturate((emitterTime - age)*10);
	float nVisibility = visibilityLength / trailLength + 2 * nVel * gModelTime;//TODO: должно зависеть от времени рождения эффекта
	o.uv.z = startOpacity * saturate(min(1, nAgeLod * 20) * max(0, 1 - nAgeLod)) * opacityMax;
	o.uv.z *= saturate(1 - nAgeLod / nVisibility);
#ifdef DEBUG_PARTICLE_ID
	o.uv.z = pow(randBase, 1/1.5) * 3;// opacity
#endif
	o.uv.w = nAge;
	
	[unroll]
	for (int ii = 0; ii < 4; ++ii)
	{
		float4 vPos = {mul(staticVertexData[ii].xy, M) * gsScale * emitterScale, 0, 1};
		vPos.xyz += gsPos;
		o.pos = o.posProj = mul(vPos, gProj);
		
		o.uv.xy = staticVertexData[ii].zw * uvOffsetScale.xy + uvOffsetScale.zw;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float getFlamePower(float age)
{
	return pow(age * flameAttenuation.x + flameAttenuation.y, flameFactor);
}

float4 psSmoke(PS_INPUT i, uniform bool bFire): SV_TARGET0
{
	const float opacity = i.uv.z;
	const float nAge = i.uv.w;

#ifdef DEBUG_NO_PS
	return float4(opacity.xxx, 0.5);
#endif

	float4 t = tex.Sample(gTrilinearClampSampler, i.uv.xy);

	float NoL = max(0, dot(t.xyz*2.0 - 1.0, i.sunDirM.xyz)*0.5 + 0.5);
	NoL = lerp(0.3, NoL, shadeFactor * (1-nAge*0.5));

	float haloFactor = i.sunDirM.w * (1.0 - min(1.0, 1.5 * t.a));

	float alpha = alphaGradientTex.SampleLevel(gBilinearClampSampler, float2(t.a, opacity), 0).a; clip(alpha - 0.01);
	alpha*=depthAlpha(i.posProj, 0.75);
	float3 finalColor = 0.0;
	float smokeFactor = 1.0;
	if(bFire){
		float3 fireColor = colorGradientTex.SampleLevel(gBilinearClampSampler, float2(1.0-t.a, getFlamePower(nAge)), 0).rgb;	
		smokeFactor = 1-dot(fireColor,0.3333);
		finalColor += fireColor * fireColor * min(flamePower*pow(1.0-nAge, 4), (length(i.sunColor)+0.1)*10.0);
	}
	
	float3 smokeColor2 = lerp(smokeColor, 0.1 + 0.9 * smokeColor, nAge*nAge);

	finalColor += shading_AmbientSunHalo(smokeColor2 * smokeFactor*smokeFactor, AmbientTop, i.sunColor * (NoL / PI), haloFactor);

	// return float4(applyPrecomputedAtmosphere(finalColor, 0), t.a * opacity);
	return float4(applyPrecomputedAtmosphere(finalColor, 0), alpha);
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

float4 psSmokeFLIR(PS_INPUT i, uniform bool bFire): SV_TARGET0
{
	
	const float opacity = i.uv.z;
	const float nAge = i.uv.w;

#ifdef DEBUG_NO_PS
	return float4(opacity.xxx, 0.5);
#endif

	float4 t = tex.Sample(gTrilinearClampSampler, i.uv.xy);

	float NoL = max(0, dot(t.xyz*2.0 - 1.0, i.sunDirM.xyz)*0.5 + 0.5);
	NoL = lerp(0.3, NoL, shadeFactor * (1-nAge*0.5));

	float haloFactor = i.sunDirM.w * (1.0 - min(1.0, 1.5 * t.a));

	float alpha = alphaGradientTex.SampleLevel(gBilinearClampSampler, float2(t.a, opacity), 0).a; clip(alpha - 0.01);
	alpha*=depthAlpha(i.posProj, 0.75);
	float3 finalColor = 0.0;
	float smokeFactor = 1.0;
	if(bFire){
		float3 fireColor = colorGradientTex.SampleLevel(gBilinearClampSampler, float2(1.0-t.a, getFlamePower(nAge)), 0).rgb;	
		smokeFactor = 1-dot(fireColor,0.3333);
		finalColor += fireColor * fireColor * flamePower*pow(1.0-nAge, 4);
	}
	
	float3 smokeColor2 = lerp(smokeColor, 0.1 + 0.9 * smokeColor, nAge*nAge);
	finalColor += (smokeFactor*smokeFactor*sqrt(1.0-nAge)+0.15)*0.35*(NoL*0.7+0.3);
	finalColor += shading_AmbientSunHalo(smokeColor2 * smokeFactor*smokeFactor, AmbientTop, i.sunColor * (NoL / PI), haloFactor);
	
	// return float4(applyPrecomputedAtmosphere(finalColor, 0), t.a * opacity);
	float l = luminance(applyPrecomputedAtmosphere(finalColor, 0));
	l = max(l, 0.15);
	return float4(l, l, l, alpha);
}

VertexShader	vsComp = CompileShader(vs_5_0, vs());
HullShader		hsComp = CompileShader(hs_5_0, hs());
DomainShader	dsComp = CompileShader(ds_5_0, ds());
GeometryShader	gsComp = CompileShader(gs_5_0, gs());

technique10 tech
{
	pass smokeWithFire
	{
		DISABLE_CULLING;
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(vsComp);
		SetHullShader(hsComp);
		SetDomainShader(dsComp);
		SetGeometryShader(gsComp);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psSmoke(true))); 
	}
	pass smoke
	{
		DISABLE_CULLING;
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(vsComp);
		SetHullShader(hsComp);
		SetDomainShader(dsComp);
		SetGeometryShader(gsComp);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psSmoke(false))); 
	}

	pass smokeWithFireFLIR
	{
		DISABLE_CULLING;
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(vsComp);
		SetHullShader(hsComp);
		SetDomainShader(dsComp);
		SetGeometryShader(gsComp);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psSmokeFLIR(true))); 
	}
	pass smokeFLIR
	{
		DISABLE_CULLING;
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(vsComp);
		SetHullShader(hsComp);
		SetDomainShader(dsComp);
		SetGeometryShader(gsComp);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psSmokeFLIR(false))); 
	}
}
