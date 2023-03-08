#ifndef OMNI_SPOT_LIGHTING_HLSL
#define OMNI_SPOT_LIGHTING_HLSL

/******************************************************
Файлик устаревший, и будет выпилен. Юзать lighting.hlsl
******************************************************/

#include "common/Attenuation.hlsl"

struct OmniLightInfo
{
	float4 pos;
	float4 diffuse;
};

struct SpotLightInfo
{
	float4 pos;
	float4 dir;//xyz
	float4 angles;//xy
	float4 diffuse;
};

#define MAX_OMNIS_NUM 16
#define MAX_SPOTS_NUM 16

cbuffer cOmnis
{
	OmniLightInfo omnis[MAX_OMNIS_NUM];
}

cbuffer cSpots
{
	SpotLightInfo spots[MAX_SPOTS_NUM];
}

#ifndef EXTERN_UNIFORM_LIGHT_COUNT
	// Used in impostors
	uint3 lightCount; //x - omnis; y - spots; z - projection spots
#endif

float3 calculateSumLighting(float3 pos, float3 normal, float4 diff, float sp, float sf, uniform bool uGlassMaterial)
{
	float3 vView = normalize(gCameraPos.xyz - pos);

	float3 sumColor = 0;

	OmniAttenParams attPrms;

	dInput diffuseInputPrms;
	diffuseInputPrms.vDiffuse = diff.rgb;
	diffuseInputPrms.vNormal = normal;

	sInput specInputPrms;
	specInputPrms.vSpecColor = diff.rgb;
	specInputPrms.vNormal = normal;
	specInputPrms.vView = vView;
	specInputPrms.fSpecFactor = sf;
	specInputPrms.fSpecPower = sp;

	float4 res;
	float3 diffuse, specular;
	float specA, att;

//////	WTF? don't touch this and [unroll] atribute!!! it's nail fix for ATI 57xx-58xx video cards
	const int oc = lightCount.x;
	const int sc = lightCount.y;
	// [unroll]
////////
	[loop]
	for(int i=0; i<oc; ++i)
	{
		attPrms.distance = distance(pos, omnis[i].pos.xyz);
		attPrms.range = omnis[i].pos.w;
		att = OmniAttenuation(attPrms);

		// Diffuse term
		diffuseInputPrms.vLightDir = normalize(omnis[i].pos.xyz - pos);
		diffuseInputPrms.vLightColor = omnis[i].diffuse.rgb;
		diffuseInputPrms.fLightPower = omnis[i].diffuse.a;
		diffuse = DiffuseTerm(diffuseInputPrms);

		// Specular term
		specInputPrms.vLightDirection = diffuseInputPrms.vLightDir;
		specInputPrms.vLightColor = omnis[i].diffuse.rgb;
		specInputPrms.fLightPower = omnis[i].diffuse.a;
		specular = SpecTerm(specInputPrms);

		if(!uGlassMaterial){
			res = float4((diffuse + specular) * att, 1.0);
		}else{
			specA = max(max(specular.r, specular.g), specular.b);
			res = float4((diffuse + specular) * att, saturate(specA * att + diff.a));
		}

#ifdef SELF_ILLUM_MAT
		applySelfIlluminationAlpha(input, diff, res);
#endif

		sumColor.rgb += res.rgb*res.a;
	}

	SpotAttenParams attPrmsSpot;

//////	don't touch [unroll] atribute!!! it's nail fix for ATI 57xx-58xx video cards
	// [unroll]
////////////
	[loop]
	for(i=0; i<sc; ++i)
	{
		attPrmsSpot.distance = distance(pos, spots[i].pos.xyz);
		attPrmsSpot.vLight = -normalize(spots[i].pos.xyz - pos);
		attPrmsSpot.vLightDirection = spots[i].dir.xyz;
		attPrmsSpot.phi = spots[i].angles.x;
		attPrmsSpot.theta = spots[i].angles.y;
		attPrmsSpot.range = spots[i].pos.w;
		att = SpotAttenuation(attPrmsSpot);

		// Diffuse term
		diffuseInputPrms.vLightDir = normalize(spots[i].pos.xyz - pos);
		diffuseInputPrms.vLightColor = spots[i].diffuse.rgb;
		diffuseInputPrms.fLightPower = spots[i].diffuse.a;

		diffuse = DiffuseTerm(diffuseInputPrms);

		// Specular term
		specInputPrms.vLightDirection = diffuseInputPrms.vLightDir;
		specInputPrms.vLightColor = spots[i].diffuse.rgb;
		specInputPrms.fLightPower = spots[i].diffuse.a;

		specular = SpecTerm(specInputPrms);
		specA = max(max(specular.r, specular.g), specular.b);

		if(!uGlassMaterial){
			res = float4((diffuse + specular) * att, 1.0);
		}else{
			specA = max(max(specular.r, specular.g), specular.b);
			res = float4((diffuse + specular) * att, saturate(specA * att + diff.a));
		}

#ifdef SELF_ILLUM_MAT
		applySelfIlluminationAlpha(input, diff, res);
#endif

		sumColor.rgb += res.rgb*res.a;
	}

	return saturate(sumColor);
}

#endif
