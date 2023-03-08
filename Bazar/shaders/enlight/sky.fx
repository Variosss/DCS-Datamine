#ifndef EDGE
#define FOG_ENABLE
#endif

#include "common/context.hlsl"
#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/fog2.hlsl"
#include "common/dithering.hlsl"
#include "enlight/skyCommon.hlsl"
#include "deferred/deferredCommon.hlsl"

#include "common/haloSampling.hlsl"

//#define USE_MILKYWAY

#ifdef USE_MILKYWAY 
TextureCube milkywayTex;
#endif

float4x4 viewProjInverse;

static const float atmDepth = paramDistMax;//km

struct VS_OUTPUT {
	float4	pos:	SV_POSITION;
	float2	coords: TEXCOORD0;
	float3	ray:	TEXCOORD1;
};


static const float2 verts[4] = {
	float2(-1.0, -1.0),
	float2( 1.0, -1.0),
	float2(-1.0,  1.0),
	float2( 1.0,  1.0)
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	float4 pos = float4(verts[vid], 0, 1);

	VS_OUTPUT o;
	o.pos = pos;
	o.coords = pos.xy * 0.5 + 0.5;
	o.ray =  mul(pos, viewProjInverse).xyz;
	return o;
}

float3 applyDitheringOnLowLuminance(uint2 pixel, float3 color, float lumMaxInv)
{
	float lum = dot(color, 0.333333);
	return color * lerp((0.9 + 0.2*dither_ordered8x8(pixel)), 1, saturate(lum*lumMaxInv));
}

float4 PS(VS_OUTPUT i, uniform bool drawSunDisk): SV_TARGET0
{
	float3 viewDir = normalize(i.ray);
	float r = length(atmEarthCenter);
	float mu = dot(atmEarthCenter, viewDir) / r;
	float3 transmittance;
	float3 singleMieScattering;
	float3 skyRadiance = GetSkyRadiance(atmEarthCenter + float3(0, heightHack, 0), viewDir, 0.0, atmSunDirection, transmittance, singleMieScattering, atmDepth);

	float3 skyColor = skyRadiance * gAtmIntensity;
	skyColor = applyDitheringOnLowLuminance(i.pos.xy, skyColor, 1/0.0045);

	if(drawSunDisk)
		skyColor += transmittance * SunDisc(viewDir, atmSunDirection);
		
	if (gIceHaloParams.atmosphereFactor > 0.0)
		skyColor += singleMieScattering * sampleHalo(gBilinearClampSampler, viewDir, gSunDir) * (gAtmIntensity * gIceHaloParams.atmosphereFactor);

	static const float Rg = gEarthRadius;
	AtmosphereParameters atmosphere; initAtmosphereParameters(atmosphere);
	float dist = RayIntersectsGround(atmosphere, r, mu) ? DistanceToBottomAtmosphereBoundary(atmosphere, r, mu) : sqrt(r*r-Rg*Rg)*0.3;

	return float4(applyFog(skyColor, viewDir, dist*1000.0, true), 1.0);
}

float4 PS2(VS_OUTPUT i, uniform bool bFadeByHeight): SV_TARGET0
{
	const float Rg = gEarthRadius;
	float3 viewDir = normalize(i.ray);
	float r, mu, mu2;
	float3 skyColor;
	float3 transmittance;
	float3 singleMieScattering;
	GetRMu(atmEarthCenter, viewDir, r, mu);
	mu2 = max(mu, -sqrtf(1.0 - (Rg / r) * (Rg / r))+0.01);
	if(bFadeByHeight)
	{
		float3 skyRadianceBase = GetSkyRadiance(r, mu,  atmEarthCenter, viewDir, 0.0, atmSunDirection, transmittance, singleMieScattering, atmDepth);
		float3 skyRadiance     = GetSkyRadiance(r, mu2, atmEarthCenter, viewDir, 0.0, atmSunDirection, transmittance, singleMieScattering, atmDepth);
		
		float nHeight = saturate((gCameraPos.y + gOrigin.y) / 15000.0);
		skyColor = lerp(skyRadiance, skyRadianceBase, nHeight) * gAtmIntensity;
	}
	else
	{
		skyColor = GetSkyRadiance(r, mu2, atmEarthCenter, viewDir, 0.0, atmSunDirection, transmittance, singleMieScattering, atmDepth) * gAtmIntensity;
	}

	if (gIceHaloParams.atmosphereFactor > 0.0)
		skyColor += sampleHalo(gBilinearClampSampler, viewDir, gSunDir) * singleMieScattering * (gAtmIntensity * gIceHaloParams.atmosphereFactor);
	
	AtmosphereParameters atmosphere; initAtmosphereParameters(atmosphere);
	float dist = RayIntersectsGround(atmosphere, r, mu) ? DistanceToBottomAtmosphereBoundary(atmosphere, r, mu) : sqrt(r*r-Rg*Rg)*0.3;
	
	return float4(applyFog(skyColor, viewDir, dist*1000.0, true), 1.0);
}

technique10 Sky
{
	pass clearSky
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS(false)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	pass clearSkyWithSunDisk
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS(true)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	pass skyWithFogOnTheGround
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS2(false)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	pass skyForEnvironmentCube
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS2(true)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
