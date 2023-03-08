#ifndef LandLightMap_HLSL
#define LandLightMap_HLSL

float4x4 landLightTTF;
Texture2D landLightTex;
#ifdef EDGE
TEXTURE_SAMPLER_DEFAULT(landLightTex, BORDER);
#endif

float4 getLandLightUVW( float4 posWS)
{
#ifdef EDGE
	posWS.y = 0;
	float4 res = mul(posWS, landLightTTF);
	res.xy = NDCtoUV(res.xy / res.w);
	return res;
#else
	return mul(posWS, landLightTTF);
#endif
}
float3 getLandLightColor( float4 coord)
{
#ifndef EDGE
	return landLightTex.Sample(WrapPointSampler, coord.xy/coord.w).xyz;
#else
	return TEX2D(landLightTex, coord.xy).xyz;
#endif
}

#endif // LandLightMap_HLSL
