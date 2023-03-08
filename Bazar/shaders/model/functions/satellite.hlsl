#ifndef MODEL_SATELLITE_SHADING_HLSL
#define MODEL_SATELLITE_SHADING_HLSL

#include "functions/matParams.hlsl"
#include "common/constants.hlsl"

#ifdef BANO_MATERIAL

PS_OUTPUT diffuse_sun_ps_sat(VS_OUTPUT input)
{
	MaterialParams matParams = calcMaterialParams(input, MP_DIFFUSE | MP_NORMAL);

	PS_OUTPUT o;
	float a = 0;
	calcBANOAttenuation(matParams.diffuse.a, matParams.normal, matParams.toCamera, matParams.camDistance, a);
	o.RGBColor = float4(matParams.diffuse.rgb, a);
	return o;
}

#else

PS_OUTPUT diffuse_sun_ps_sat(VS_OUTPUT input)
{
	MaterialParams matParams = calcMaterialParams(input, MP_DIFFUSE);

#if defined(BUILDING_MATERIAL)
	matParams.diffuse.rgb *= SURFACECOLORGAIN;
#endif

	matParams.diffuse.a *= MeltFactor.x;

	float4 res = matParams.diffuse;

	PS_OUTPUT o;
	o.RGBColor = res;
	return o;
}

#endif















#endif
