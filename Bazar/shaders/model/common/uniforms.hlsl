#ifndef _75f210d2aa6227ce8048375db660dc84_HLSL
#define _75f210d2aa6227ce8048375db660dc84_HLSL

// GENERATED CODE BEGIN ID: def_uniforms
cbuffer def_uniforms {
	uint4 lightCount;	// x - omnis; y - spots, z - omnisDiffuse, w - spotsDiffuse
	float4 FlatShadowPlane;
	float4x4 prevFrameTransform;
	float4 flirCoeff;	// Coefficients for flir
	float3 color;	// for materials without textures, only color
	float specFactor;
	float3 MeltFactor;	// holds melt factor, near melt and far melt
	float specPower;
	float3 selfIlluminationColor;
	float specMapValue;	// holds amount of specular map
	float3 banoDistCoefs;
	float diffuseValue;	// holds multiplier for diffuse color
	float2 diffuseShift;	// holds diffuse texture coordinates shift by u and v
	float2 decalShift;	// holds decal texture coordinates shift by u and v
	float2 normalMapShift;	// holds normal map texture coordinates shift by u and v
	float2 ambientOcclusionShift;
	float2 FlatShadowProps;
	float normalMapValue;	// holds multiplier for normal map
	float dirtValue;
	float reflectionValue;
	float specColorMapValue;
	float selfIlluminationValue;
	float reflectionBlurring;
	uint posStructOffset;	// offset in structured buffer 'sbPositions'
	int atmosphereSamplesId;	// To apply atmosphere on transparent objects
	float phosphor;
	float multiplyDiffuse;	// Multiply or not self illumination color by diffuse.
	float reflMult;
	float reflAdd;
	float specMult;
	float specAdd;
	uint specSelect;
	float albedoContrast;
	float albedoLevel;
	float unused_nxgp;
}
// GENERATED CODE END ID: def_uniforms

#endif
