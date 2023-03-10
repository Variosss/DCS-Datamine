#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "deferred/atmosphere.hlsl"
#include "deferred/shadows.hlsl"
#include "deferred/ESM.hlsl"
#include "deferred/shading.hlsl"

#define USE_RECURSIVE_IBL 1
#define USE_CASCADE_SHADOW 1

TextureCube albedoTex;
TextureCube normalTex;

static const float2 quad[4] = {
	float2(-1, -1), float2(1, -1),
	float2(-1, 1),	float2(1, 1),
};

static const float3x3 view[6] = {
	float3x3(0,0,-1, 0,1,0, 1,0,0), float3x3(0,0,1, 0,1,0, -1,0,0), float3x3(1,0,0, 0,0,-1, 0,1,0),
	float3x3(1,0,0, 0,0,1, 0,-1,0), float3x3(1,0,0, 0,1,0, 0,0,1), float3x3(-1,0,0, 0,1,0, 0,0,-1),
};

uint VS(uint vid: SV_VertexID) : TEXCOORD0 {
	return vid;
}

struct GS_OUTPUT {
	uint   layer:		SV_RenderTargetArrayIndex;
	float4 pos:			SV_POSITION0;
	float3 location:	TEXTURE0;
};

[maxvertexcount(4)]
void GS(point uint i[1]: TEXCOORD0, inout TriangleStream<GS_OUTPUT> outputStream) {
	GS_OUTPUT o;
	[unroll]
	for (int j = 0; j < 4; ++j) {
		o.layer = i[0];
		o.pos = float4(quad[j], 1, 1);
		o.location = mul(o.pos.xyz, view[o.layer]);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float3 SimplestShadeCockpit(float3 sunColor, float3 diffuseColor, float3 normal, float shadow, float3 viewDir, float3 pos, uniform bool recursiveIBL) {
	float roughness = 0.9;
	float3 specularColor = 0.02;

	float NoL = max(0, dot(normal, gSunDir));
	float3 lightAmount = sunColor * (gSunIntensity * NoL * shadow);
	float3 finalColor = ShadingDefault(diffuseColor, specularColor, roughness, normal, viewDir, gSunDir) * lightAmount;

	//diffuse IBL
	float3 envLightDiffuse = 
#if	USE_RECURSIVE_IBL	
							recursiveIBL ? SampleCockpitCubeMapMip(pos, normal, environmentMipsCount) * gCockpitIBL.x :
#endif
							SampleEnvironmentMapDetailed(normal, environmentMipsCount);

	finalColor += diffuseColor * envLightDiffuse * gIBLIntensity;

	//specular IBL
	float3 R = reflect(-viewDir, normal);
	float3 envLightSpecular = 
#if	USE_RECURSIVE_IBL	
							recursiveIBL ? SampleCockpitCubeMap(pos, R, roughness) * gCockpitIBL.y : 
#endif
							SampleEnvironmentMapDetailed(R, environmentMipsCount);

	finalColor += envLightSpecular * EnvBRDFApprox(specularColor, roughness, normal, viewDir);

	return finalColor;
}

float3 ShadeCockpitCube(float3 baseColor, float3 normal, float3 pos, uniform bool recursiveIBL) {
#if USE_CASCADE_SHADOW
	float NoL = max(0, dot(normal, gSunDir));
	float cascadeShadow = SampleShadowMap(pos, NoL, ShadowFirstMap, false, 1, false);
#else
	float cascadeShadow = 1;
#endif
	float cloudsShadow = SampleShadowClouds(pos).x;
	float terrainShadow = terrainShadowsSSM(float4(pos, 1));
	float terranAndCloudsShadow = min(terrainShadow, cloudsShadow);
	float shadow = min(terranAndCloudsShadow, cascadeShadow);

	float3 viewDir = normalize(gCockpitPosition._m30_m31_m32 - pos);
	float3 sunColor = SampleSunRadiance(pos, gSunDir) * terranAndCloudsShadow;

	return SimplestShadeCockpit(sunColor, baseColor, normal, shadow, viewDir, pos, recursiveIBL);
}

static const float3 LUM = { 0.2125f, 0.7154f, 0.0721f };

float4 PS(GS_OUTPUT i, uniform bool recursiveIBL) : SV_TARGET0 {
	float4 albedo = albedoTex.SampleLevel(gPointClampSampler, i.location, 0);

	if (albedo.a == 0) {
		float3 v = mul(i.location, (float3x3)gCockpitPosition);
		float3 c = environmentMap.SampleLevel(gTrilinearClampSampler, v, 0).xyz;
		c = lerp(c, dot(c, LUM), saturate((i.location.y < 0)-0.5));	// lerp cockpit bottom to b/w
		return float4(c, 1);
	}

	float4 normalDist = normalTex.SampleLevel(gPointClampSampler, i.location, 0);
	float3 normal = normalDist.xyz * 2 - 1;
	normal = normalize(mul(normal, (float3x3)gCockpitPosition));

	float dist = normalDist.w * 2.52;
	float4 pos = mul(float4(gCockpitCubemapPos + normalize(i.location) * dist, 1), gCockpitPosition);
	float3 wPos = pos.xyz / pos.w;

	float3 baseColor = GammaToLinearSpace(albedo.xyz);
	float3 c = ShadeCockpitCube(baseColor, normal, wPos, recursiveIBL);
	return float4(c, 1);
}

#define COMMON_PART		SetVertexShader(CompileShader(vs_5_0, VS()));									\
						SetGeometryShader(CompileShader(gs_5_0, GS()));									\
						SetDepthStencilState(disableDepthBuffer, 0);									\
						SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
						SetRasterizerState(cullNone);													\
						SetHullShader(NULL);															\
						SetDomainShader(NULL);															\
						SetComputeShader(NULL);						



technique10 tech {
	pass p0 {
		SetPixelShader(CompileShader(ps_5_0, PS(false)));
		COMMON_PART
	}
	pass p1 {
		SetPixelShader(CompileShader(ps_5_0, PS(true)));
		COMMON_PART
	}
}

