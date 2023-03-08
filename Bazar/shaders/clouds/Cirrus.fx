#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"

#define FOG_ENABLE
#include "common/fog2.hlsl"

#include "deferred/atmosphere.hlsl"

Texture2D DiffTex;
Texture2D DiffTex2;

float4 cv4;
float4 cldclr;

#define time	gModelTime
#define phase	cv4.y
#define cam		gOrigin

static const float cirrusAltitude = 13000.0;

static const float quadSize = 550000.0;//размер квадрата облаков
static const float fadeInv = 1.0 / 600.0;//затухании облаков при приближении к ним

static const float earthRadiusBottom = gEarthRadius * 0.25;//радиус земли при расчете кривизны купола когда камера под ним
static const float earthRadiusTop = gEarthRadius;//радиус земли при расчете кривизны купола когда камера над ним

static const float rangeInv = 2.0 / quadSize;
static const float rangeTopInv = 2.0 / 450000.0;

static const float tile = 13;

static const float brightness = 0.6 / 3.1415;
static const float opacity = 0.35;

static const float windSpeed = 20.0;//m/s

struct VS_INPUT
{
	float2 vPos : POSITION0;
	float2 vTex : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 oPos : SV_POSITION;
	float4 oT0  : TEXCOORD0;
	float4 params: TEXCOORD1;
	float3 inscatter: TEXCOORD2;
	float3 sunColor: TEXCOORD3;
};

#define mieG 0.7
#define	M_PI 3.14159265

float phaseFunctionM(float mu)
{
	return 1.5 * 1.0 / (4.0 * M_PI) * (1.0 - mieG*mieG) * pow( abs(1.0 + (mieG*mieG) - 2.0*mieG*mu ), -3.0/2.0) * (1.0 + mu * mu) / (2.0 + mieG*mieG);
}

float distanceToCirrus(float r, float mu)
{
	const float rg = gEarthRadius;
	float rc = cirrusAltitude*0.001 + rg;
	Area discriminant = r * r * (mu * mu - 1.0) + rc * rc;
	float dist;
	if(rc>r)
		dist = ClampDistance(-r * mu + SafeSqrt(discriminant));
	else
		dist = ClampDistance(-r * mu - SafeSqrt(discriminant));
	return max(dist, 0.001);
}

//считаем точку от камеры камеры до пересечения с реальным радиусом облаков
float3 getRealCirrusPos(float3 camera, float3 pos)
{
	float3 cpos = (pos-camera)*0.001;	// in km
	float d = length(cpos);
	float3 view = cpos/d;
	float mu = view.y;	
	float r = length(gEarthCenter);
	return gEarthCenter + view*distanceToCirrus(r, view.y);
}

float3 calculateAtmosphereForCirrus(float3 pos, out float3 transmittance)
{
	return GetSkyRadianceToPoint(gEarthCenter, pos, 0.0/*shadow*/, gSunDir, transmittance) * gAtmIntensity;
}

VS_OUTPUT VertOut(VS_INPUT i)
{
	float ex = i.vPos.x * quadSize * 0.001;
	float ez = i.vPos.y * quadSize * 0.001;
	
	float cameraAboveCirrus = step(cirrusAltitude, cam.y);
	
	float r0 = earthRadiusBottom + cirrusAltitude*0.001;
	float r1 = earthRadiusTop + cirrusAltitude*0.001;
	
	float ey0 = sqrt(r0*r0 - ex*ex - ez*ez) - earthRadiusBottom;
	float ey1 = sqrt(r1*r1 - ex*ex - ez*ez) - earthRadiusTop;

	float4 tw;
	tw.xz = i.vPos.xy * quadSize;
	tw.y = lerp(ey0, ey1, cameraAboveCirrus) * 1000.0 - cam.y;
	tw.w=1.0;
	
	VS_OUTPUT o;
	float windOffset = time * windSpeed;
	o.oPos = mul(tw, gViewProj);
	o.oT0.xy = (i.vTex.xy + (cam.xz + windOffset) / quadSize) * tile;

	float nDist=length(tw.xz) * lerp(rangeInv, rangeTopInv, cameraAboveCirrus);
	o.oT0.z = pow(nDist, 3);
	float fadeFactor = min(abs(cirrusAltitude-cam.y)* fadeInv, 1);
	o.oT0.w=fadeFactor;
	
	float2 density = sin((time + phase).xx / float2(60.0, 80.0));
	float visibility = sin(o.oT0.x*2 + phase + time/100+density.x*0.5) * sin(o.oT0.y*2+phase*4.231 + time/100-density.y*0.5);
	
	o.params.xy = saturate( density * pow(saturate(visibility+0.5), 0.7) );
	o.params.z = saturate(sin(time / 120.0)+0.5); // lerp factor
	
	float3 view = normalize(tw.xyz - gViewInv._41_42_43);
	o.params.w = phaseFunctionM(dot(gSunDir, view));
	
	float3 transmittance;
	float3 pos = OriginSpaceToEarthSpace(tw);
	float3 realPos = getRealCirrusPos(gEarthCenter, pos);
	o.inscatter = calculateAtmosphereForCirrus(realPos, transmittance);
	o.sunColor  = GetSunRadiance(realPos, gSunDir);
	o.sunColor  = lerp(o.sunColor, dot(o.sunColor, 0.333).xxx, saturate(1-gSunDir)*0.3);//чутка обесцвечиваем красноту солнца
	o.sunColor *= transmittance * gSunIntensity;
	
	//todo: надо семплировать не из предрасчитанной текстуры skyRadiance, а из inscatterTex, т.к. у каждой точки дожен быть взят свой muS
	// float3 posOnGround = float3(pos.x, 6360.0, pos.z);
	// o.sunColor += GetSkyRadiance(posOnGround, normalize(gSunDir + normalize(posOnGround)), 0.0, gSunDir, transmittance) * gAtmIntensity;
	return o;
}

float4 psCirrus(VS_OUTPUT i, uniform bool FLIR_mode): SV_TARGET0
{
	float  psDistSq		 = i.oT0.z;
	float  psFadeFactor	 = i.oT0.w;
	float2 psVisibility	 = i.params.xy;
	float  psLerpFactor	 = i.params.z;
	float  psHaloFactor	 = i.params.w;
	
	clip(0.99 - psDistSq);

	float4 r  = DiffTex.Sample(WrapLinearSampler, i.oT0 ) * float4(1,1,1, psVisibility.x);
	float4 r1 = DiffTex2.Sample(WrapLinearSampler, i.oT0)		 * float4(1,1,1, psVisibility.y);

	r = lerp(r, r1, psLerpFactor);
	float alpha = r.a;
	r.a = saturate(r.a-psDistSq*0.7) * psFadeFactor * (1-psDistSq);
	clip(r.a-0.002);
	
	float3 norm = r.xzy*2-1;
	float sunDot = max(0, dot(normalize(norm), gSunDir)*0.8 + 0.2) * 2;
	
	float4 color = float4(brightness.rrr, r.a * opacity);
	float sunFactor = max(0,1-gSunDir.y);
	color.rgb *= i.sunColor * (1 + 3 * psHaloFactor * max(0, 1 - alpha) * (sunDot*0.7+0.3) * sunFactor * sunFactor);
	color.rgb += i.inscatter;

	if (FLIR_mode)
		color.rgb = lerp(color.rgb, 1, 0.25);

	return color;
}

RasterizerState cirrusRS
{
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = false;
	DepthClipEnable = false;
};

VertexShader vsComp = CompileShader(vs_4_0, VertOut());

technique10 T0
{
	pass MAIN
	{
		SetVertexShader(vsComp);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psCirrus(false)));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cirrusRS);
	}
	pass FLIR
	{
		SetVertexShader(vsComp);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psCirrus(true)));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cirrusRS);
	}
}
