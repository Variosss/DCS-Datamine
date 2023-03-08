#ifndef MODEL_MATPARAMS_HLSL
#define MODEL_MATPARAMS_HLSL

#include "common/context.hlsl"
#include "deferred/deferredCommon.hlsl"
#include "functions/normal_map.hlsl"
#include "functions/misc.hlsl"
#include "functions/diffuse.hlsl"

#include "functions/specular.hlsl"
#include "functions/aorms.hlsl"
#include "common/shader_macroses.hlsl"

#ifdef SELF_ILLUMINATION_UV
Texture2D SelfIllumination;
#endif

struct MaterialParams
{
	float4 diffuse;
	float3 normal;
	float4 aorms;
	float3 emissive;
	float camDistance;
	float3 toCamera;
	float3 pos;
	float decalMask;
};

float4 getSelfIllumination(const VS_OUTPUT input, in float diffuseAlpha)
{
	float4 selfIllumColor = float4(0,0,0,1);

#ifdef SELF_ILLUMINATION_TRANSPARENT_MATERIAL

	selfIllumColor = Diffuse.Sample(gAnisotropicWrapSampler, input.DIFFUSE_UV.xy + diffuseShift);

#elif defined(SELF_ILLUMINATION_UV) || defined(SELF_ILLUMINATION_COLOR_MATERIAL)

	#ifdef SELF_ILLUMINATION_COLOR_MATERIAL

		selfIllumColor.rgb = selfIlluminationColor;

		#ifdef SELF_ILLUMINATION_UV
			selfIllumColor.a *= SelfIllumination.Sample(gAnisotropicWrapSampler, input.SELF_ILLUMINATION_UV.xy).a;
		#else
			selfIllumColor.a *= diffuseAlpha;
		#endif

	#else
		selfIllumColor = SelfIllumination.Sample(gAnisotropicWrapSampler, input.SELF_ILLUMINATION_UV.xy);
	#endif

#endif
	return selfIllumColor;
}

#define MP_DIFFUSE		1
#define MP_SPECULAR		2
#define MP_NORMAL		4
#define MP_ILLUMINATION	8
#define MP_ALL			15

MaterialParams calcMaterialParams(VS_OUTPUT input, uint materialParamFlags)
{
	MaterialParams o;
	o.pos = input.Pos.xyz / input.Pos.w;
	o.toCamera = gCameraPos.xyz - o.pos;
	float len = length(o.toCamera);
	o.toCamera /= len;
	o.camDistance = len * gNearFarFovZoom.w;

	if(materialParamFlags & MP_NORMAL)
		o.normal = calculateNormal2(input);
	else
		o.normal = float3(0,1,0);

#ifdef METROUGH_MAP
	if(materialParamFlags & MP_SPECULAR){
		o.aorms = getAORMS(input);
	}else{
		o.aorms = 0;
	}

	if(materialParamFlags & MP_DIFFUSE){
		o.diffuse = extractDiffuse(GET_DIFFUSE_UV(input));
		o.decalMask = addDecal(o.diffuse, input, o.aorms.z);
		addDamage(input,o.camDistance,o.diffuse,o.normal, o.aorms);
	}else{
		o.decalMask = 1.0;
		o.diffuse = float4(0, 0, 0, 1);
	}
#else
	// sp, sf, reflValue, reflBlur
	float4 specular = 0;
	if(materialParamFlags & MP_SPECULAR){
		// sp, sf, reflValue, reflBlur
		calculateSpecular(input, specular);
		o.aorms = specToAORMS(input, specular);
	}

	if(materialParamFlags & MP_DIFFUSE){
		o.diffuse = extractDiffuse(GET_DIFFUSE_UV(input));
		o.decalMask = addDecal(o.diffuse, input, o.aorms.z);
		addDamage(input,o.camDistance,o.diffuse,o.normal, o.aorms);
	}else{
		o.decalMask = 1.0;
		o.diffuse = float4(0, 0, 0, 1);
	}
#endif

	o.aorms.yz = lerp(float2(0.7, 0.1), o.aorms.yz, o.decalMask);

	if(materialParamFlags & MP_ILLUMINATION) {
		float4 si = getSelfIllumination(input, o.diffuse.a);
		o.emissive = CoarseGammaToLinearSpace(si.rgb) * gModelEmissiveIntensity * si.a * selfIlluminationValue;
	} else {
		o.emissive = 0;
	}

	return o;
}

void calcBANOAttenuation(float opacity, float3 normal, float3 viewDir, float camDistance, inout float a)
{
#ifdef BANO_MATERIAL
	float sunAttenuation = 0.8+0.7*gSunAttenuation;
	float distAttenuation = max(smoothstep(banoDistCoefs.x, banoDistCoefs.y, camDistance) * banoDistCoefs.z, 1.0);
	float viewDirAttenuation = abs(dot(viewDir, normal));

	a = saturate( opacity * diffuseValue * sunAttenuation *  distAttenuation) * viewDirAttenuation;
#else
	a = 0;
#endif
}

#endif
