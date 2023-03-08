#ifndef ATMOSPHERE_INSCATTER_H
#define ATMOSPHERE_INSCATTER_H

#include "enlight/materialParams.hlsl"
#include "enlight/deprecated/atmCommon.hlsl"

#if defined(FOG_ENABLE)
#include "common/fogCommon.hlsl"
#endif

#define NO_YELLOWISH_HORIZON

//inscattered light along ray x+tv, when sun in direction s (=S[L]-T(x,x0)S[L]|x0)
float3 inscatter(float3 x, float t, float3 v, float3 s, out float3 attenuation) {

	x.y+=2.5;			

    float r = length( x );

    float mu = dot(x, v) / r;

	const float lim = -sqrt(1 - (Rg / r) * (Rg / r));
	v.y = mu = min(mu, lim-0.001);
	
	float nu = dot(v, s);
    float muS = dot(x, s) / r;

	float3 x0 = x + t * v;

#if ANALYTIC_TRANSMITTANCE
	attenuation = min(analyticTransmittance(r, mu, t), 1.0);
#else
	attenuation = transmittance(r, mu, v, x0);
#endif

	float4 inscatter = texture4D(inscatterTex, r, mu, muS, nu);

	float r0 = length(x0);
	float mu0 = (r * mu + t) / r0;
	float4 inscatter1 = texture4D(inscatterTex, r0, mu0, muS, nu);
	inscatter = max(inscatter, inscatter1) - inscatter1 * attenuation.rgbr;

    float phaseR = phaseFunctionR(nu);
    float phaseM = phaseFunctionM(nu);

#ifndef NO_YELLOWISH_HORIZON
	const float e = 0.85;
	attenuation = pow(attenuation, e);
	return pow(inscatter.rgb * phaseR + getMie(inscatter) * phaseM, 1.0/e) * ISun;
#else
	return (inscatter.rgb * phaseR + getMie(inscatter) * phaseM) * ISun;
#endif
}

float3 attenuation(float3 x, float t, float3 v) {

	float r = length(x);
	float mu = dot(x, v) / r;

#if ANALYTIC_TRANSMITTANCE
	return min(analyticTransmittance(r, mu, t), 1.0);
#else
	float3 x0 = x + t * v;
	return transmittance(r, mu, v, x0);
#endif

}

float3 atmApplyInternal(float3 v, float distance, float3 color) {
	float3 attenuation;
	float3 inscatterColor = inscatter(atmEarthCenter, distance, v, atmSunDirection, attenuation); 

#ifndef NO_YELLOWISH_HORIZON
	return color*attenuation + HDR( inscatterColor.rgb );
#else
	const float distMax = 1 / 120.0;// 1/km
	return lerp(color*attenuation + HDR( inscatterColor.rgb ),
				HDR(color*attenuation + inscatterColor.rgb ),
				min(1, distance*distMax));
#endif
}

float3 atmosphereApply(const float3 camera, const float3 pos, const float4 projPos, float3 color, uniform bool lerpToSky = true) {		// position in camera space, kilometers

#if !defined(EDGE) 
	#if !defined(FOG_ENABLE) && defined(DISABLE_ATMOSPHERE)
		return color;
	#endif
#endif

	float3 cpos = (pos-camera)*0.001;	// in km
	float d = length(cpos);

	static const float artefactDistance = 0.2;	// it prevent artifacts for GeForce on short distances

	if(d>atmFarDistance)
		discard;

	float3 v = cpos/d;

#if defined(FOG_ENABLE)
	// apply fog
	float attL = fogCalcAttenuation(fogCoeff.z, fogCoeff.w, fogCameraHeight, d*1000.0, v.y);
	color = lerp(fogColor, color, attL);
	#if defined(DISABLE_ATMOSPHERE)
		return color;
	#endif
	float3 result = lerp(color, atmApplyInternal(v, max(artefactDistance, d), color), min(saturate(d/artefactDistance), fogCameraHeightNorm));
#else
	float3 result = lerp(color, atmApplyInternal(v, max(artefactDistance, d), color), saturate(d/artefactDistance));
#endif

	if(lerpToSky)
	{
		float lerpFactor = saturate( (d-atmNearDistance) / (atmFarDistance-atmNearDistance) );
		float2 tc = float2(0.5f *projPos.x/projPos.w + 0.5, -0.5f * projPos.y/projPos.w + 0.5);	
		float4 sky = skyTex.Sample(AtmSampler, tc.xy);
		return lerp(result, sky.rgb, lerpFactor);
	}
	else
		return result;
}

// the special fast case of zero plane, used for water surface
float3 atmosphereApplyZeroPlane(const float3 camera, const float3 pos, const float4 projPos, float3 color) {

	float3 cpos = (pos-camera)*0.001;	// in km
	float d = length(cpos);

	if(d>atmFarDistance)
		discard;

	const float EPS = 0.0015;	

	float3 v = cpos/d;
    float r = length(atmEarthCenter);
    float mu = dot(atmEarthCenter, v) / r;
	const float lim = -sqrt(1 - (Rg / r) * (Rg / r));

	if(mu >= lim+EPS)	// cut by sphere
		discard;

	float2 tc = float2(0.5f *projPos.x/projPos.w + 0.5, -0.5f * projPos.y/projPos.w + 0.5 + EPS*2.5);	// little up texture to prevent over lighting of horizon
	float4 sky = skyTex.Sample(AtmSampler, tc.xy);

#if defined(FOG_ENABLE)
	// apply fog
	float attL = fogCalcAttenuation(fogCoeff.z, fogCoeff.w, fogCameraHeight, d*1000.0, v.y);
	float3 result = (lerp(fogColor, color*attenuation(atmEarthCenter, d, v), attL) + sky.rgb ) / (2.0-attL);
#else
	float3 result = color*attenuation(atmEarthCenter, d, v) + sky.rgb;
#endif

	float lerpFactor = saturate( (d-atmNearDistance) / (atmFarDistance-atmNearDistance) );

	return lerp(result, sky.rgb, lerpFactor);

}


float3 atmosphereAttenuation(const float3 camera, const float3 pos) {			// position in camera space, kilometers
	float3 cpos = (pos-camera)*0.001;	// in km
	float d = length(cpos);
	return attenuation(atmEarthCenter, d, cpos/d); 
}

#endif
