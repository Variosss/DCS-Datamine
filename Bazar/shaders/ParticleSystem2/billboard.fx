#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/softParticles.hlsl"
#include "ParticleEffects/SoftParticles.hlsl"

#define NO_DEFAULT_UNIFORMS
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"

Texture2D	tex;
Texture2D	colorGradientTex;
float4		worldOffset;
float4		color;
float4		params;
float4		params2;
float4		params3;
float4      params4;
float sizeMult;



int2		atlasSize;

#define		particleSize			params.x
#define		particleOpacity			params.y
#define		particleLifetime		params.z
#define		animFPSFactor			params.w

#define		particleOpacityFactors	params2.xy
#define		particleAngleSinCos		params2.zw
#define		emitterTime				worldOffset.w

#define		animLastFrameId			params3.x
#define		flameParams				(params3.yz)
#define     speedAttTime            params3.w

#define		smokeColor				color
#define     gVelocity               params4.xyz
#define     gSpeed                  params4.w
struct GS_INPUT
{
};

struct PS_INPUT
{
	float4 pos	: SV_POSITION0;
	float4 projPos : POSITION0;
	float3 uv 	: TEXCOORD0;	
	nointerpolation float4 sunDirM	: TEXCOORD1;
	nointerpolation float3 sunColor	: TEXCOORD2;
};

void vsDummy() {}

[maxvertexcount(4)]
void gsBillboard(point GS_INPUT i[1], inout TriangleStream<PS_INPUT> outputStream, uniform bool bLoop)
{
	float2 sc = particleAngleSinCos;
	float2x2 M = {sc.y, sc.x, -sc.x, sc.y};

	float offset = 0;

	/*
	if(emitterTime < speedAttTime){
		float tc = emitterTime;
		float tm = speedAttTime;
		float v0 = gSpeed;
		// vc = v0*(1.0-(t/tm)^2);
		offset = v0*tc*(1-tc/(3*tm));
	}


	float3 posW = worldOffset.xyz + offset*gVelocity;
	*/

	float3 posW = worldOffset.xyz;
	float3 gsPos = mul_v3xm44(posW, gView).xyz;
	
	float nAge = saturate(emitterTime / particleLifetime);

	uint frame = bLoop? (animFPSFactor*emitterTime) : (animLastFrameId * pow(nAge, animFPSFactor));
	float4 uvOffsetScale = getTextureFrameUV(frame, atlasSize);

	PS_INPUT o;
	o.sunColor = getPrecomputedSunColor(0);
	o.sunDirM = float4(-getSunDirInNormalMapSpace(M), getHaloFactor(gSunDirV.xyz, gsPos, 10) * 0.4);
	o.uv.z = particleOpacity * saturate(nAge/(1.0e-5+particleOpacityFactors.x)) * saturate(1.0-(nAge - particleOpacityFactors.y) / (1.0 + 1.0e-5 - particleOpacityFactors.y)); //opacity
	[unroll]
	for (int ii = 0; ii < 4; ++ii)
	{
		float4 vPos = float4(gsPos, 1);
		vPos.xy += mul(sizeMult*staticVertexData[ii].xy, M) * particleSize;

		o.pos = mul(vPos, gProj);
		o.projPos = o.pos;
		o.uv.xy = staticVertexData[ii].zw * uvOffsetScale.xy + uvOffsetScale.zw;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 psBillboard(PS_INPUT i, uniform bool bFlame = true, uniform bool bSoftParticle = false): SV_TARGET0
{
	float4 t = tex.Sample(gTrilinearWrapSampler, i.uv.xy);
	float nAge = saturate(emitterTime / particleLifetime);

	float shadeFactor = 0.7;
	float NoL = saturate(dot(t.xyz*2.0 - 254.0/255.0, i.sunDirM.xyz)*0.5 + 0.5);
	NoL = lerp(0.3, NoL, shadeFactor * (1-nAge));
	
	float haloFactor = i.sunDirM.w * saturate(1.0 - 1.5 * t.a);
	
	float alpha = colorGradientTex.SampleLevel(gTrilinearClampSampler, float2(t.a, i.uv.z), 0).a; 
	clip(alpha - 0.02);

	// float alpha = sqrt(t.a) * i.uv.z; clip(alpha - 0.01);
	
	float3 finalColor = shading_AmbientSunHalo(smokeColor, AmbientTop, i.sunColor * (NoL / PI), haloFactor*0.25);
	if(bFlame)
	{
		float3 fireColor = colorGradientTex.SampleLevel(gBilinearClampSampler, float2(1.0-t.a, flameParams.y), 0).rgb;
		finalColor += fireColor * fireColor * flameParams.x;
		alpha *= lerp(1.0, particleOpacity, t.a);
	}
	else{
		alpha *= particleOpacity;
	}

	if(bSoftParticle){
		alpha *= depthAlpha(i.projPos, 1.0);
	}

	return float4(applyPrecomputedAtmosphere(finalColor, 0), alpha);
}


float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

float4 psBillboardFlir(PS_INPUT i, uniform bool bFlame = true, uniform bool bSoftParticle = false): SV_TARGET0
{
	float4 t = tex.Sample(gTrilinearWrapSampler, i.uv.xy);
	float nAge = saturate(emitterTime / particleLifetime);

	float shadeFactor = 0.7;
	float NoL = saturate(dot(t.xyz*2.0 - 254.0/255.0, i.sunDirM.xyz)*0.5 + 0.5);
	NoL = lerp(0.3, NoL, shadeFactor * (1-nAge));
	
	float haloFactor = i.sunDirM.w * saturate(1.0 - 1.5 * t.a);
	
	float alpha = colorGradientTex.SampleLevel(gTrilinearClampSampler, float2(t.a, i.uv.z), 0).a; 
	clip(alpha - 0.02);

	// float alpha = sqrt(t.a) * i.uv.z; clip(alpha - 0.01);
	float3 finalColor = smokeColor;
	//float3 finalColor = shading_AmbientSunHalo(smokeColor, AmbientTop, i.sunColor * (NoL / PI), haloFactor*0.25);
	if(bFlame)
	{
		float3 fireColor = colorGradientTex.SampleLevel(gBilinearClampSampler, float2(1.0-t.a, flameParams.y), 0).rgb;
		finalColor += fireColor * fireColor * flameParams.x;
		alpha *= lerp(1.0, particleOpacity, t.a);
	}
	else{
		alpha *= particleOpacity;
	}

	if(bSoftParticle){
		alpha *= depthAlpha(i.projPos, 1.0);
	}

	float l = max(luminance(applyPrecomputedAtmosphere(finalColor, 0))/3.0, 0.2);
	return float4(l, l, l, alpha);
	//return float4(applyPrecomputedAtmosphere(finalColor, 0), alpha);
}


technique10 tech
{
	
	pass animationOnce
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsBillboard(false)));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBillboard()));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

	pass animationOnceSoftParticle
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsBillboard(false)));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBillboard(true, true)));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

	pass animationLoop
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsBillboard(true)));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBillboard()));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

		pass animationLoopSoftParticle
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsBillboard(true)));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBillboard(false, true)));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

	pass animationOnceFlir
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsBillboard(false)));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBillboardFlir()));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

	pass animationOnceSoftParticleFlir
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsBillboard(false)));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBillboardFlir(true, true)));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

	pass animationLoopFlir
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsBillboard(true)));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBillboardFlir()));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

		pass animationLoopSoftParticleFlir
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsBillboard(true)));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBillboardFlir(false, true)));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

