#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"

#define FOG_ENABLE
#include "common/fog2.hlsl"

#include "common/haloSampling.hlsl"

#include "deferred/atmosphere.hlsl"

Texture2D DiffTex;
Texture2D DiffTex2;

float4 params;

#define time	gModelTime
#define phase	params.y
#define origin	gOrigin

static const float cirrusAltitude = 13000.0;

static const float quadSize = 550000.0;//размер квадрата облаков
static const float fadeInv = 1.0 / 600.0;//затухании облаков при приближении к ним

static const float earthRadiusBottom = gEarthRadius * 0.25;//радиус земли при расчете кривизны купола когда камера под ним
static const float earthRadiusTop = gEarthRadius;//радиус земли при расчете кривизны купола когда камера над ним

static const float rangeInv = 2.0 / quadSize;
static const float rangeTopInv = 2.0 / 450000.0;

static const float tile = 13;

static const float cirrusThickness = 1;
static const float cirrusThicknessMax = 40; // compared to cirrusThickness
static const float albedo = 0.8;
static const float extinction = 0.35 * 0.8;
static const float shadowExtinctionMult = 5;//a little hack to get stronger shadows from a thinner cloud layer
static const float shadowRadius = 150000;
static const float multipleScatCoef = 0.4;
static const float opacityClamp = 0.001;


static const float windSpeed = 20.0;//m/s

struct VS_INPUT
{
	float2 vPos : POSITION0;
	float2 vTex : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 oPos : SV_POSITION;
	float3 oT0  : TEXCOORD0;
	float4 params: TEXCOORD1;
	float3 inscatter: TEXCOORD2;
	float3 sunColor: TEXCOORD3;
	float3 transmittance: TEXCOORD4;
	float3 posWS : POSITION1;
	float3 normal: TEXCOORD5;
};

#define mieG 0.7
#define	M_PI 3.14159265

float phaseFunctionM(float mu)
{
	return 1.5 * 1.0 / (4.0 * M_PI) * (1.0 - mieG*mieG) * pow( abs(1.0 + (mieG*mieG) - 2.0*mieG*mu ), -3.0/2.0) * (1.0 + mu * mu) / (2.0 + mieG*mieG);
}

//from clouds.hlsl
//https://www.shadertoy.com/view/tdcBDj
float numericalMieFit(float costh)
{
	float bestParams[10];
	bestParams[0]=9.805233e-06;
	bestParams[1]=-6.500000e+01;
	bestParams[2]=-5.500000e+01;
	bestParams[3]=8.194068e-01;
	bestParams[4]=1.388198e-01;
	bestParams[5]=-8.370334e+01;
	bestParams[6]=7.810083e+00;
	bestParams[7]=2.054747e-03;
	bestParams[8]=2.600563e-02;
	bestParams[9]=-4.552125e-12;

	float p1 = costh + bestParams[3];
	float4 expValues = exp(float4(bestParams[1] *costh+bestParams[2], bestParams[5] *p1*p1, bestParams[6] *costh, bestParams[9] *costh));
	float4 expValWeight= float4(bestParams[0], bestParams[4], bestParams[7], bestParams[8]);

	float x = 1.0 - saturate((1.0 - costh) / 0.04);

	return dot(expValues, expValWeight) * 0.25 + 2.7 * ((x*x)*(x*x));
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
	float3 cpos = (pos - camera) * 0.001;	// in km
	float d = length(cpos);
	float3 view = cpos / d;
	float mu = view.y;	
	float r = length(camera);
	return camera + view * distanceToCirrus(r, view.y);
}

float3 calculateAtmosphereForCirrus(float3 cameraPos, float3 pos, out float3 transmittance)
{
	return GetSkyRadianceToPoint(cameraPos, pos, 0.0/*shadow*/, gSunDir, transmittance) * gAtmIntensity;
}

VS_OUTPUT VertOut(VS_INPUT i)
{
	i.vPos.xy *= quadSize;

	float ex = i.vPos.x * 0.001;
	float ez = i.vPos.y * 0.001;

	float cameraAltitude = gOrigin.y + gCameraPos.y;
	float cameraAboveCirrus = step(cirrusAltitude, cameraAltitude);

	float r0 = earthRadiusBottom + cirrusAltitude * 0.001;
	float r1 = earthRadiusTop + cirrusAltitude * 0.001;
	
	float ey0 = sqrt(r0 * r0 - ex * ex - ez * ez) - earthRadiusBottom;
	float ey1 = sqrt(r1 * r1 - ex * ex - ez * ez) - earthRadiusTop;

	float3 tw;
	tw.xz = i.vPos.xy;
	tw.y = lerp(ey0, ey1, cameraAboveCirrus) * 1000.0 - origin.y;

	VS_OUTPUT o;
	o.posWS = tw.xyz + float3(gCameraPos.x, 0, gCameraPos.z);
	o.oPos = mul(float4(o.posWS, 1), gViewProj);

	float windOffset = time * windSpeed;
	o.oT0.xy = (i.vTex.xy + (origin.xz / quadSize) + (gCameraPos.xz + windOffset) / quadSize) * tile;

	float nDist = length(tw.xz) * lerp(rangeInv, rangeTopInv, cameraAboveCirrus);
	o.oT0.z = nDist;
	float fadeFactor = min(abs(cirrusAltitude - cameraAltitude) * fadeInv, 1);

	float2 density = sin((time + phase).xx / float2(60.0, 80.0));
	float visibility = sin(o.oT0.x * 2 + phase + time / 100 + density.x * 0.5) * sin(o.oT0.y * 2 + phase * 4.231 + time / 100 - density.y * 0.5);

	o.params.xy = saturate(density * pow(saturate(visibility + 0.5), 0.7));
	o.params.z = saturate(sin(time / 120.0) + 0.5); // lerp factor

	float3 view = normalize(tw.xyz - float3(0, gCameraPos.y, 0));//camera is in {0,0,0}
	o.params.w = phaseFunctionM(dot(gSunDir, view));

	float3 pos = OriginSpaceToEarthSpace(o.posWS);
	// Prevent sampling atmosphere from point lower than atmosphere.bottom_radius == gEarthRadius
	float3 cameraPos = float3(gEarthCenter.x, max(0.0f, gEarthCenter.y - gEarthRadius) + gEarthRadius, gEarthCenter.z);
	float3 realPos = getRealCirrusPos(cameraPos, pos);
	o.inscatter = calculateAtmosphereForCirrus(cameraPos, realPos, o.transmittance);
	o.normal = normalize(realPos);
	float NoL = dot(gSunDir, o.normal);
	NoL = smoothstep(-0.123, 0.0213, NoL);

	o.params.w = fadeFactor*fadeFactor;
	o.sunColor = GetSunRadiance(realPos, gSunDir) * gSunIntensity;
	o.sunColor *= 0.6 + 0.4*NoL*NoL;//self-shadow hack at sunset/sunrise
	return o;
}

float remap(float v, float s, float e) 
{
	return (v - s) / (e - s);
}

float3 getScatteringCoef(float3 T, float dist){
	return log(float3(1.0,1.0,1.0) / T) / dist;
}

//returns cirrus density
float4 SampleCirrus(float2 uv, float2 opacity, float ratio, float bias)
{
	float4 r = DiffTex.SampleBias(WrapLinearSampler,   uv, bias) * float4(1, 1, 1, opacity.x);
	float4 r1 = DiffTex2.SampleBias(WrapLinearSampler, uv, bias) * float4(1, 1, 1, opacity.y);
	return lerp(r, r1, ratio);
}

float GetShadowTransmittance(float extinction, float2 uv, float2 lightDir, float2 opacity, float ratio, float bias, float distToEye)
{
	if(distToEye<shadowRadius)
	{
		float distNorm = distToEye / shadowRadius;
		float localShadowPower = saturate(1 - distNorm*distNorm*distNorm);

		// uint count = gDev1.y;
		// float step0 = gDev1.z;
		// float stepFactor = gDev1.w;
		const float step0 = 0.02;
		const uint count = 3;
		const float stepFactor = 2;

		float d = 0.0;
		// [loop]
		for (uint i = 0; i < count; ++i)
		{
			float s = step0 * (1 + i*stepFactor);
			uv += lightDir * s;
			float density = SampleCirrus(uv, opacity, ratio, bias + i).a;
			density = max(0, density - i*0.01);
			d += density * s;
		}

		return 1 - localShadowPower + localShadowPower * exp( -extinction * max(0,d));
	}

	return 1;
}

float4 psCirrus(VS_OUTPUT i, uniform bool FLIR_mode, uniform bool HALO_mode/*, uint coverage : SV_Coverage*/): SV_TARGET0
{
	float psDist = i.oT0.z*i.oT0.z;
	float psDistSq = i.oT0.z*i.oT0.z;//*i.oT0.z;
	float2 psVis = i.params.xy;
	float psLerpFactor = i.params.z;
	float psFadeFactor = i.params.w;

	clip(0.99 - psDistSq);

	float distToEye = length(i.posWS.xyz - gCameraPos.xyz);
	float3 viewDir = normalize(i.posWS.xyz - gCameraPos.xyz);

	float lodBias = psDistSq*10;
	float density = SampleCirrus(i.oT0.xy, psVis, psLerpFactor, lodBias).a;
	density = pow(max(0, density), 1.2);

	// float extinction = getScatteringCoef(1-opacity, cirrusThickness);
	float cirrusSlopeThickness = cirrusThickness / abs(dot(viewDir, normalize(i.normal)));
	cirrusSlopeThickness = min(cirrusSlopeThickness, cirrusThicknessMax);

	float shadowLength = cirrusThickness / abs(dot(gSunDir, normalize(i.normal)));
	shadowLength = min(shadowLength, cirrusThicknessMax);

	float opacity = 1 - exp(-extinction * density * cirrusSlopeThickness);
	float opacityHack = psFadeFactor * max(0, 1 - 2*psDistSq*(1-saturate(gSunDir.y*8)));// fading near camera * fading near horizon
	clip(opacity - opacityClamp);

	float edgesDecay = smoothstep(opacityClamp, opacityClamp*2, opacity);

	float miePhase = numericalMieFit(dot(gSunDir, viewDir));

	float posToLightTransmittance = GetShadowTransmittance(extinction*shadowExtinctionMult*shadowLength, i.oT0.xy, gSunDir.xz, psVis, psLerpFactor, lodBias, distToEye);

	float3 ambientLight = GetSkyIrradiance(OriginSpaceToEarthSpace(i.posWS), gSunDir) * (gSunIntensity * gIBLIntensity);

	float4 color;
	color.rgb = i.sunColor * ((albedo/3.1415) * (multipleScatCoef + miePhase) * posToLightTransmittance) + (albedo/3.1415) * ambientLight;
	color.a = opacity * opacityHack * edgesDecay;

	if ((HALO_mode && !FLIR_mode) && gIceHaloParams.cirrusCloudsFactor > 0)
	{
		float3 iceHalo = sampleHalo(gBilinearClampSampler, viewDir, gSunDir);
		
		//float3 dir = getDirInHaloStorage(viewDir, gSunDir);
		//float2 uv = spmDirToUV(dir, pmScale);
		//float3 iceHalo = iceHaloTexture.SampleLevel(gBilinearClampSampler, uv, dpmComputeLod(dir, pmScale)).rgb;
		//return float4(iceHalo, 1.0);
		
		// Modulate Halo by "sunColor.rgb" because Halo is a result 
		// of light scattering by ice particles inside cirrus clouds
		color.rgb += i.sunColor * iceHalo * (posToLightTransmittance * gIceHaloParams.cirrusCloudsFactor);
	}

	//apply atmosphere
	color.rgb *= i.transmittance;
	color.rgb += i.inscatter;

	if (FLIR_mode)
		color.rgb = lerp(color.rgb, 1, 0.25);

	// Debug view with wirefarme (need coverage param as input)
	//color = coverage < 8 ? float4(0.0, 0.0, 0.0, 1.0) : float4(i.sunColor, 1.0);
	
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
		SetPixelShader(CompileShader(ps_5_0, psCirrus(false, false)));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cirrusRS);
	}
	pass FLIR
	{
		SetVertexShader(vsComp);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psCirrus(true, false)));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cirrusRS);
	}
	pass MAIN_wHalo
	{
		SetVertexShader(vsComp);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psCirrus(false, true)));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cirrusRS);
	}
	pass FLIR_wHalo
	{
		SetVertexShader(vsComp);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psCirrus(true, true)));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cirrusRS);
	}

}
