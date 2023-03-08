#ifndef MODEL_DIFFUSE_HLSL
#define MODEL_DIFFUSE_HLSL

#include "functions/decal.hlsl"
#include "functions/damage.hlsl"

#ifdef DIFFUSE_UV
Texture2D Diffuse;
#endif

float clipByDiffuseAlpha(float2 uv, float clipValue)
{
	float a = 1;
#ifdef DIFFUSE_UV
	a = Diffuse.Sample(gAnisotropicWrapSampler, uv + diffuseShift).a;
#if BLEND_MODE == BM_ALPHA_TEST
	clip(a - clipValue);
#endif
#endif
	return a;
}

float4 extractDiffuse(float2 uv)
{
	float4 diff = float4(0.75, 0.75, 0.75, 	1.0);
#ifdef DIFFUSE_UV
	diff = Diffuse.Sample(gAnisotropicWrapSampler, uv + diffuseShift);

#if BLEND_MODE == BM_ALPHA_TEST
	{
		float lod = Diffuse.CalculateLevelOfDetail(gAnisotropicWrapSampler, uv + diffuseShift);
		diff.a *= 1 + lod * 0.2;
		// Removes artefacts connected with alpha to coverage.
		// https://bgolus.medium.com/anti-aliased-alpha-test-the-esoteric-alpha-to-coverage-8b177335ae4f
		diff.a = ((diff.a - 0.5) / max(fwidth(diff.a), 0.0001) + 0.5);
		
	}
#endif
#ifndef SELF_ILLUMINATION_COLOR_MATERIAL
	diff.rgb *= diffuseValue;
#endif
#elif defined(COLOR_ONLY)

	diff = float4(LinearToGammaSpace(color) * diffuseValue, 1);
#endif
	return diff;
}

#endif