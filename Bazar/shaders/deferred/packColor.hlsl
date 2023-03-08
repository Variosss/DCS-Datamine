#ifndef PACKCOLOR_HLSL
#define PACKCOLOR_HLSL

#define MIDPOINT_8_BIT              (127.0f / 255.0f)

float3 encodeColorYCC(float3 col) {
	// Y'Cb'Cr'
	float3 encodedCol = float3(
		dot( float3( 0.299,   0.587,   0.114),  col.rgb ),
		dot( float3(-0.1687, -0.3312,  0.5),    col.rgb ),
		dot( float3( 0.5,    -0.4186, -0.0813), col.rgb )
		);
	
	return float3(encodedCol.x, encodedCol.y * MIDPOINT_8_BIT + MIDPOINT_8_BIT, encodedCol.z * MIDPOINT_8_BIT + MIDPOINT_8_BIT);
}

float3 decodeColorYCC(float3 encodedCol) {
	encodedCol = float3(encodedCol.x, encodedCol.y / MIDPOINT_8_BIT - 1, encodedCol.z / MIDPOINT_8_BIT - 1);
	// Y'Cb'Cr'
	float3 col = float3(
		encodedCol.x + 1.402 * encodedCol.z,
		dot( float3( 1, -0.3441, -0.7141 ), encodedCol.xyz ),
		encodedCol.x + 1.772 * encodedCol.y
		);

	return col;
}


#endif
