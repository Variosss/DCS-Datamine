#ifndef _0a2ab7b6e21f0bcc7f04b827ef3ca7bb_HLSL
#define _0a2ab7b6e21f0bcc7f04b827ef3ca7bb_HLSL

// GENERATED CODE BEGIN ID: deck_uniforms
cbuffer deck_uniforms {
	uint4 lightCount;	// x - omnis; y - spots, z - omnisDiffuse, w - spotsDiffuse
	float4 FlatShadowPlane;
	float4x4 prevFrameTransform;
	float4 flirCoeff;	// Coefficients for flir
	float3 MeltFactor;	// holds melt factor, near melt and far melt
	uint posStructOffset;	// offset in structured buffer 'sbPositions'
	float2 FlatShadowProps;
	float Rain;
	float unused_owfe;
}
// GENERATED CODE END ID: deck_uniforms

#endif
