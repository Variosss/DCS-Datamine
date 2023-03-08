#ifndef COCKPIT_CUBEMAP_HLSL
#define COCKPIT_CUBEMAP_HLSL

struct CockpitCubemapGBuffer {
	float4 albedo : SV_TARGET0;
	float4 normal : SV_TARGET1;
};

CockpitCubemapGBuffer cockpit_cubemap_ps(VS_OUTPUT input) {
	MaterialParams mp = calcMaterialParams(input, MP_DIFFUSE | MP_NORMAL | MP_SPECULAR);
	mp.diffuse.rgb = modifyAlbedo(mp.diffuse.rgb, albedoLevel, albedoContrast, mp.aorms.x);

	float dist = distance(gViewInv._m30_m31_m32, mp.pos) / 2.55;

	CockpitCubemapGBuffer o;
	o.albedo = float4(mp.diffuse.rgb, 1);
	o.normal = float4(mp.normal*0.5 + 0.5, dist);
	return o;
}

#endif