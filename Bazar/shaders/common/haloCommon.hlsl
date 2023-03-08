#ifndef HALO_COMMON_HLSL
#define HALO_COMMON_HLSL

// --------------------
// Rotation functions
// --------------------

float3x3 rotateAroundX(float angle)
{
	float c, s;
	sincos(angle, s, c);
	return float3x3(
		1.0, 0.0, 0.0,
		0.0, c, s,
		0.0, -s, c
	);
}

float3x3 rotateAroundY(float angle)
{
	float c, s;
	sincos(angle, s, c);
	return float3x3(
		c, 0.0, -s,
		0.0, 1.0, 0.0,
		s, 0.0, c
	);
}

float3x3 rotateAroundZ(float angle)
{
	float c, s;
	sincos(angle, s, c);
	return float3x3(
		c, s, 0.0,
		-s, c, 0.0,
		0.0, 0.0, 1.0
	);
}

float3x3 rotateAroundAxis(float angle, float3 axis)
{
	float c, s;
	sincos(angle, s, c);
	
	float t = 1 - c;
	float x = axis.x;
	float y = axis.y;
	float z = axis.z;

	return float3x3(
		t * x * x + c,      t * x * y - s * z,  t * x * z + s * y,
		t * x * y + s * z,  t * y * y + c,      t * y * z - s * x,
		t * x * z - s * y,  t * y * z + s * x,  t * z * z + c
	);
}

// -----------
// Utilities
// -----------

// Spherical coordinates is (radius, azimuthal angle, polar angle)
// Cartesian with Y-up, so spherical(1.0, 0.0, 0.0) == cartesian(0.0, 1.0, 0.0)
float3 cartesianToSpherical(float3 cartesian)
{
	float radius = length(cartesian);
	float azimuth = atan2(cartesian.z, cartesian.x);
	float polar = acos(cartesian.y / radius);
	return float3(radius, azimuth, polar);
}

float3 sphericalToCartesian(float3 spherical)
{
	float x = spherical.r * sin(spherical.z) * cos(spherical.y);
	float y = spherical.r * cos(spherical.z);
	float z = spherical.r * sin(spherical.z) * sin(spherical.y);
	return float3(x, y, z);
}

float3 getDirInHaloStorage(float3 viewDir, float3 sunDir)
{
	float3 sunSpherical = cartesianToSpherical(sunDir);
	float3x3 rotationToHaloStorage = mul(rotateAroundZ(-sunSpherical.z), rotateAroundY(-sunSpherical.y));
	return mul(rotationToHaloStorage, viewDir);
}

#endif // HALO_COMMON_HLSL