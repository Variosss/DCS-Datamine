#ifndef DECAL_HLSL
#define DECAL_HLSL

#ifdef DECAL_UV
// decal
Texture2D Decal;

// Returns decal alpha.
float addDecal(inout float4 diffuseColor, const VS_OUTPUT input, inout float reflValue)
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
	reflValue = lerp(reflValue, 0.0, decal.a);
	return 1.0 - decal.a;
}

#else

float addDecal(inout float4 diffuseColor, const VS_OUTPUT input, inout float reflValue)
{
	reflValue *= 1;
	return 1.0;
}

#endif
#endif
