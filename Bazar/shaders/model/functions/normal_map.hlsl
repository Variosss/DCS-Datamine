#ifndef NORMAL_MAP_HLSL
#define NORMAL_MAP_HLSL

#ifdef NORMAL_MAP_UV
	Texture2D NormalMap;

	#ifndef GLASS_MATERIAL
		#include "common/samplers11.hlsl"
		#include "functions/misc.hlsl"
		// calculates normal using normal map
		float3 calculateNormal2(const VS_OUTPUT input){
			float4 tex = NormalMap.Sample(gAnisotropicWrapSampler, input.NORMAL_MAP_UV.xy + diffuseShift);
			return calculateNormal(input.Normal, tex, input.Tangent);
			return normalize(input.Normal);
		}
	#else
		float3 calculateNormal2(const VS_OUTPUT input){
			return normalize(input.Normal);
		}
	#endif
#else
	float3 calculateNormal2(const VS_OUTPUT input){
		return normalize(input.Normal);
	}
#endif
#endif
