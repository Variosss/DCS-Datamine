#ifndef MODEL_AMBIENT_OCCLUSION_HLSL
#define MODEL_AMBIENT_OCCLUSION_HLSL

#ifdef AMBIENT_OCCLUSION_UV
Texture2D AmbientOcclusion;

float getAmbientOcclusion(const VS_OUTPUT input)
{
	return AmbientOcclusion.Sample(gAnisotropicWrapSampler, input.AMBIENT_OCCLUSION_UV.xy + ambientOcclusionShift).r;
}

#else

float getAmbientOcclusion(const VS_OUTPUT input)
{
	return 1;
}
#endif
#endif