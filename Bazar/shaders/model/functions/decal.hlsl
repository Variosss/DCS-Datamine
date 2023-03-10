#ifndef DECAL_HLSL
#define DECAL_HLSL

#ifdef DECAL_UV
// decal
Texture2D Decal;
#ifdef TWO_LAYERED_MATERIAL
Texture2D DecalAORMS;
Texture2D DecalNormalMap;

// Returns decal alpha.
float addDecal(const VS_OUTPUT input, inout float4 diffuseColor, inout float3 normal, inout float4 aorms)
{
#ifdef AIRCRAFT_REGISTRATION
	float2 uv = input.DECAL_UV.xy + decalShift + input.TailNumber;
	float4 decal = Decal.Sample(gAnisotropicWrapSampler, uv);
	clip(decal.a - 0.1);
#else
	float2 uv = input.DECAL_UV.xy + decalShift;
	float4 decal = Decal.Sample(gAnisotropicWrapSampler, uv);
#endif

	float4 v = DecalAORMS.Sample(gAnisotropicWrapSampler, uv);
	float4 nm = DecalNormalMap.Sample(gAnisotropicWrapSampler, uv);

	diffuseColor.rgb=lerp(diffuseColor.rgb,decal.rgb,decal.a);
	aorms = lerp(aorms, v, decal.a);
	
	return 1.0 - decal.a;
}

#else

float addDecal(const VS_OUTPUT input, inout float4 diffuseColor, inout float3 normal, inout float4 aorms)
{
#ifdef AIRCRAFT_REGISTRATION
	float2 uv = input.DECAL_UV.xy + decalShift + input.TailNumber;
	float4 decal = Decal.Sample(gAnisotropicWrapSampler, uv);
	clip(decal.a - 0.1);
#else
	float2 uv = input.DECAL_UV.xy + decalShift;
	float4 decal = Decal.Sample(gAnisotropicWrapSampler, uv);
#endif
	diffuseColor.rgb=lerp(diffuseColor.rgb,decal.rgb,decal.a);
	aorms.z = lerp(aorms.z, 0.0, decal.a);
	return 1.0 - decal.a;
}
#endif

#else

float addDecal(const VS_OUTPUT input, inout float4 diffuseColor, inout float3 normal, inout float4 aorms)
{
	return 1.0;
}

#endif
#endif
