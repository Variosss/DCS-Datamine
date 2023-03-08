#ifndef ED_MODEL_SCRATCHES_H
#define ED_MODEL_SCRATCHES_H

#if defined(NORMAL_MAP_UV)

#include "functions/normal_map.hlsl"

float calcScratches(VS_OUTPUT input, float shadow) {
	float3 norm = normalize(input.Normal);
	float3 tan = normalize(input.Tangent.xyz);
	float3x3 tangentSpace = { tan*input.Tangent.w, cross(tan, norm), norm };

	float3 eye = mul(tangentSpace, normalize(input.Pos.xyz - gCameraPos));
	float3 t = normalize(cross(float3(1,0,0), eye));
	float3x3 tangentSpace2 = { cross(eye, t), t, eye };
	float3 h = mul(tangentSpace2, mul(tangentSpace, gSunDir.xyz));

	static const float2 kernel[] = { float2(-1, 0),	float2(1, 0), float2(0, -1), float2(0, 1) };
	static const float dtt = 0.25 / 256.0, fac = 1.0025, pwr = 220;

	float2 uv = input.NORMAL_MAP_UV.xy + diffuseShift.xy;

	float sum = 0;
	[unroll]
	for(uint i=0; i<4; ++i) {
		//float3 sn = NormalMap.SampleLevel(gAnisotropicWrapSampler, 3*uv.xy+kernel[i]*dtt, 0).xyz * 2 - 1;
		float3 sn = NormalMap.Sample(gAnisotropicWrapSampler, 3 * uv.xy + kernel[i] * dtt).xyz * 2 - 1;
		sum += pow( fac * max(0, dot(sn.xyz, h)), pwr);
	}
	float scr = min(1.0, 0.5*sum);
	float fade = pow(max(0, gSunDir.y), 0.1);
	float intensity = min(1.0, gSunIntensity*0.1);
	return scr*fade*(1 - shadow)*intensity;
}

#else

float calcScratches(VS_OUTPUT input, float shadow) {
	return 0;
}
#endif

#endif
