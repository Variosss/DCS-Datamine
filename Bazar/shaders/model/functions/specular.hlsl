#ifndef SPECULAR_HLSL
#define SPECULAR_HLSL

#ifdef SPECULAR_UV
Texture2D Specular;
#endif

#ifdef SPECULAR_COLOR_UV
Texture2D SpecularColor;
#endif

//TODO: remove as it is not used
float3 getSpecularColor(const VS_OUTPUT input, float3 sourceColor)
{
#ifndef NO_SPECULAR
#ifdef SPECULAR_COLOR_UV
	return lerp(sourceColor, SpecularColor.Sample(gAnisotropicWrapSampler, input.SPECULAR_COLOR_UV.xy).rgb, specColorMapValue);
#else
	return sourceColor;
#endif
#else
	return sourceColor;
#endif
}

// sp, sf, reflValue, reflBlur
void calculateSpecular(const VS_OUTPUT input, out float4 s)
{
#ifndef NO_SPECULAR
	const float powerMult = 1.0;
	const float factorMult = 1.0;
#ifdef SPECULAR_UV
	float4 tex = Specular.Sample(gAnisotropicWrapSampler, input.SPECULAR_UV.xy + diffuseShift);

	s.x = tex.r * powerMult * specMapValue;
	s.y = tex.g * factorMult * specMapValue;

	s.z = tex.b;
	s.w = lerp(1.0, reflectionBlurring, tex.a);
#else
	s.x = specPower * powerMult;
	s.y = specFactor * factorMult;

	s.z = reflectionValue;
	s.w = reflectionBlurring;
#endif
#else
	s.x = 0;
	s.y = 0;

	s.z = 0;
	s.w = 0;
#endif
}

#endif