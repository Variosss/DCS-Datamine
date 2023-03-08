#ifndef _OCEAN_HLSL
#define _OCEAN_HLSL

#include "../metashaders/inc/samplers.hlsl"
#include "../metashaders/terrain/inc/clipmap.hlsl
#include "../metashaders/terrain/inc/SampleFFTMap.hlsl"
CLIPMAP(colortexture)

#include "../common/States11.hlsl"

float refractionFactor = 1.0 / 1.4;
float transparentFactor = 0.9;		// [0..1]


float3 ocean::sunColor;
float ocean::splitBorder;
float4x4 ocean::ViewProj;
float3 ocean::camera;
float ocean::time;
float3 ocean::origin;

float2 ocean::windOffset;
float ocean::windFactor;

float4x4 ocean::shelfMatrix;
float4x4 ocean::HeightMatrix;

Texture2D irendercontext::WaveMap;
TextureCube irendercontext::EnvironmentCube;
Texture2D irendercontext::FFTMap;

//Texture2D ocean::Map;
Texture2D ocean::SeaDepth;
//Texture2D ocean::ShelfNormalMap;
Texture2D ocean::Foam;
Texture2D ocean::FoamMap;
Texture2D ocean::BumpMap;
Texture2D ocean::Mask;
Texture2D ocean::FakeRefl;
Texture2D ocean::TerrainHeights;
Texture2D ocean::ReflMap;
//TextureCube ocean::EnvMap;

float3 ocean::light;
float3 ocean::sunColor;
float  ocean::sunIntensity;


float depthScaler = 6.0;
float WaveLength = 30.0;
float DXZScaler = 0.4;
float DepthLevel = 30.0;
float MaxWaveDist = 1500.0;
float WaveScaler = 1.2;

float foamMagn = 1.0;
float foamDistance = 2000.0;

const float fogFactor = 0.25;	// [0..1] sentience to fog
const float horizonThickness = 0.01;


float3 calcWaterColor(float3 wPos, float waterDepth, float3 N, float2 reflectionUV, inout float NdotL, float shadow, float3 omni_spot);

float2 wPosToUV(float3 wPos, float4x4 projMatrix)
{
	float4 pos = mul(float4(wPos, 1), projMatrix);
		float2 uv = pos.xy / pos.w;
		uv = 0.5 * uv + 0.5;
	uv.y = 1.0 - uv.y;
	return uv;
}

float3 getWaterColorFlat(float3 wPos, float3 omni_spot)
{
	float4 projPos = mul(float4(wPos, 1.0), ocean::ViewProj);

	float2 sUV = projPos.xy / projPos.w * 0.5 + 0.5;
	sUV.y = 1.0 - sUV.y;

	float waterDepth = ocean::SeaDepth.Sample(ClampSampler, wPosToUV(wPos, ocean::shelfMatrix)).r;
	float shadow = 1;// getCloudShadow(wPos);

	float NdotL;
	return calcWaterColor(wPos, waterDepth, float3(0, 1, 0), sUV, NdotL, shadow, omni_spot);
}

bool splitBorder(float3 wPos, float offset=0.0f)
{
	float4 projPos = mul(float4(wPos, 1.0), ocean::ViewProj);
	float dist = projPos.z / projPos.w;
	return (dist - offset) > ocean::splitBorder;
}

float3 sample_position(float3 wPos, float2 scale) {
	float2 UV0 = (wPos.xz + ocean::windOffset) / scale;
	float2 UV1 = (wPos.xz + ocean::windOffset + float2(1.0, 1.0)) / scale;
	return (SampleFFTMapUV(UV0).xyz + SampleFFTMapUV(UV1).xyz) * 0.5;
}

float2 sample_depth(float3 wPos, float scaler) {
	float origDepth = ocean::SeaDepth.SampleLevel(ClampSampler, wPosToUV(wPos, ocean::shelfMatrix), 0).r;

	origDepth = saturate(0 - origDepth / DepthLevel);
	float depth = pow(1.0 - origDepth, scaler);

	return float2(depth, origDepth);
}

struct WaveData {
	float3 wave;
	float wL;
	float wW;
};

WaveData sample_wave(float3 wPos, float XZscaler, float waveL) {

	float2 sUV = wPosToUV(wPos, ocean::ViewProj);

	float4 dXZ = irendercontext::WaveMap.SampleLevel(ClampSampler, sUV, 0);
	dXZ.xy = DXZScaler * clamp(dXZ.xy * 2.0 - 1.0, -1.0, 1.0);
	float wL = length(dXZ.xy);

	float Axz = XZscaler * wL / DXZScaler, Ay = 1.0;
	float k = 2 * 3.1415 / (WaveLength * ocean::windFactor);
	float2 K = dXZ.xy * k;
	float w = sqrt(9.82 * k);
	float D = dXZ.z * waveL;

	float3 wave;
	wave.xz = K / k * Axz * sin(D * k + w * ocean::time);
	wave.y = -Ay * cos(D * k + w * ocean::time) * sign(length(K));

	WaveData o;
	wave.y *= 0.3;
	wave.xz *= 0.9;
	o.wave = wave.xyz;
	o.wL = wL;
	o.wW = dXZ.w;

	return o;
}

float4 getPosition(float3 wPos) {
	float L = length(wPos - ocean::camera);

	float3 hData = 2.0 * sample_position(wPos, float2(64.0, 64.0));
	hData += 1.0 * sample_position(wPos, float2(256.0, 312.0));

	float2 depth = sample_depth(wPos, depthScaler);
	WaveData wave = sample_wave(wPos, 8.0, 300.0);
	wave.wave *= 1.0 - pow(depth.x, 2.0);
	wave.wave *= 1.0 - saturate(L / MaxWaveDist);

	hData.xyz *= saturate(1.0 - depth.x);
	
	float3 ret = wPos +hData * ocean::windFactor;

	float wScaler = lerp(WaveScaler, 1.0, saturate(depth.x));

	float3 W = -wScaler * wave.wave * wave.wL / DXZScaler * ocean::windFactor;
	ret += W;

	return float4(ret, W.y);
}

float3 getNormalVS(float3 wPos, float A)
{
	float3 p0 = getPosition(wPos);
	float3 p1 = getPosition(wPos + float3(A, 0, 0)) - p0;
	float3 p2 = getPosition(wPos + float3(0, 0, A)) - p0;

	float3 N = cross(p1, p2);
	N = normalize(N);
	return N;
}

struct sInput {
	float3 vSpecColor;
	float3 vNormal;
	float3 vView;
	float3 vLightDirection;
	float fSpecFactor;
	float fSpecPower;
	float3 vLightColor;
	float fLightPower;
	float R;
};

float3 SpecTerm(const in sInput i) {
	float3 H = normalize(i.vLightDirection + i.vView);

	float NdotH = max(dot(H, i.vNormal), 1.0e-7);
	float VdotH = saturate(dot(H, i.vView));
	float NdotV = saturate(dot(i.vNormal, i.vView));
	float NdotL = saturate(dot(i.vNormal, i.vLightDirection));

	float G = 2.0 * NdotH / VdotH;
	G = G * min(NdotV, NdotL);

	float r2 = i.R * i.R;
	float NdotH_sq = NdotH * NdotH;
	float NdotH_sq_r = 1.0 / (NdotH_sq * r2);
	float roughness_exp = (NdotH_sq - 1.0) * (NdotH_sq_r);
	float D = exp(roughness_exp) * NdotH_sq_r / (4.0 * NdotH_sq);

	float F = 1.0 / (1.0 + NdotV);

	float Rs = (F * G * D) / (NdotV * NdotL + 1.0e-7);

	return NdotL * i.vSpecColor * Rs * i.vLightColor * i.fLightPower * i.fSpecPower;
}

float4 groundColor(float3 wPos)
{
	float pixelSize = 0.0f;
	return SAMPLE_CLIPMAP_PIXEL_SIZE(colortexture, wPos, pixelSize);
}

const float3 DeepColor_3 = { 0.217, 0.46, 0.478 };

struct fInput {
	float3 vLightDir;
	float3 vNormal;
	float R0;
	float power;
};

float FresnelTerm(in const fInput i)
{
	float F = i.R0 + (1.0 - i.R0) * pow(1.0 - saturate(dot(i.vLightDir, i.vNormal)), i.power);
	return F;
}

float3 refractVector(float3 I, float3 N, float eta)
{
	float NdotI = dot(N, I);
	float k = 1.0 - eta * eta * (1.0 - NdotI * NdotI);

	return eta * I - (eta * NdotI + sqrt(k)) * N;
}

float3 calcWaterColor(float3 wPos, float waterDepth, float3 N, float2 reflectionUV, inout float NdotL, float shadow, float3 omni_spot) {

	float3 worldPos = wPos + ocean::origin;

	float wDepth = saturate(0 - waterDepth / DepthLevel);
	
	float L = length(ocean::camera.xyz - wPos);

	float4 tmp = mul(float4(wPos, 1.0), ocean::HeightMatrix);
	tmp = 0.5f * tmp + 0.5f;
	tmp.y = 1.0f - tmp.y;
	
	float2 bumpOffset = N.xz / 20.0;

	float3 bump = ocean::BumpMap.Sample(WrapSampler, worldPos.xz / 15.0 + bumpOffset) +
		ocean::BumpMap.Sample(WrapSampler, worldPos.xz / 10.0 + bumpOffset) +
		ocean::BumpMap.Sample(WrapSampler, worldPos.xz / 20.0 + bumpOffset);

	N.xz = N.xz + 0.6 * normalize((bump / 3.0 - 0.5) * 2.0).xz;

	bump = ocean::BumpMap.Sample(WrapSampler, worldPos.xz / 5.0 + bumpOffset);
	N.xz = N.xz * 0.8 + normalize((bump - 0.5) * 2.0).xz * 0.2 * ocean::windFactor;

	N = normalize(N);

	float3 hBump = (ocean::BumpMap.Sample(WrapSampler, (worldPos.xz + ocean::windOffset) / 170.0) +
		ocean::BumpMap.Sample(WrapSampler, (worldPos.xz + ocean::windOffset) / 1111.0))*0.5;

	N = normalize(N + normalize((hBump - 0.5) * 2.0) * (0.25 + ocean::windFactor));

	NdotL = max(dot(N, ocean::light), 0.0);
	float3 R = reflect(normalize(-ocean::camera.xyz + wPos.xyz), N);
	float3 V = normalize(ocean::camera.xyz - wPos.xyz);

	fInput fi;
	fi.vLightDir = V;
	fi.vNormal = N;
	fi.R0 = 0.0204;
	fi.power = 5.0;

	float F = clamp(FresnelTerm(fi), 0.15, 1.0);

	// var mask
	float mask = ocean::Mask.Sample(WrapSampler, worldPos.xz / 3000.0 + N.xz).x;
	float mask2 = ocean::Mask.Sample(WrapSampler, worldPos.xz / 150.0 + N.xz).x;
	float mask3 = ocean::Mask.Sample(WrapSampler, worldPos.xz / 5.0 + N.xz).x;

	float3 vrDir = refractVector(V, -N, refractionFactor);
	float depthView = wDepth / vrDir.y;

	// refraction
	float3 refraction = groundColor(wPos + vrDir*depthView);

		// Diffuse
	float3 diffuse = DeepColor_3;
	diffuse = lerp(DeepColor_3, DeepColor_3 * 1.4, mask) * 0.3;
	float H = saturate(ocean::camera.y / 10000.0);

	float opacityWater = 1.0 - pow(transparentFactor*2.0 / depthView, 2);
	diffuse = lerp(refraction.rgb, diffuse, max(saturate(opacityWater + H), 0.01)) * pow(NdotL, 4.0) * lerp(mask2, 1.0, saturate(L / 1000.0)) * 1.5;
	diffuse += lerp(mask3 * 0.05, 0.0, saturate(L / 100.0));

	//	 apply shadow
	diffuse = lerp(diffuse * 0.2, diffuse, shadow);

	//diffuse = applyLightmap(diffuse, wPos);

	// reflections
	float3 reflections00 = irendercontext::EnvironmentCube.Sample(ClampLinearSampler, R);
	float3 fakerefl = ocean::FakeRefl.Sample(WrapLinearSampler, R.xz);
	float4 reflections11 = ocean::ReflMap.Sample(ClampLinearSampler, reflectionUV + N.xz / 2.0 * (1.0 - saturate(L / 2000.0)));

	reflections00 = reflections00 * 0.7 + fakerefl * 0.3 * max(NdotL, 0.1);
	reflections00 = lerp(reflections00, reflections11.rgb, reflections11.a);

	sInput sIn;
	sIn.vSpecColor = float3(1.0, 1.0, 1.0);
	sIn.vNormal = N;
	sIn.vView = V;
	sIn.vLightDirection = ocean::light;
	sIn.fSpecFactor = 70.0;
	sIn.fSpecPower = 0.1;
	sIn.vLightColor = saturate(ocean::sunColor + omni_spot);
	sIn.fLightPower = 2.0;
	sIn.R = 0.1;

	reflections00 += ((max(0.0, NdotL) * SpecTerm(sIn) * 2.0 * (1.0 - H))) * shadow * pow(1.0 - reflections11.a, 4.0) * ocean::sunIntensity;
	reflections00 = saturate(omni_spot + reflections00);

	return lerp(diffuse.rgb, reflections00, F);
}

#endif
