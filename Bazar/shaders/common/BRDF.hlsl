#ifndef BRDF_HLSL
#define BRDF_HLSL

#ifndef PI
#define PI 3.141592653589793238462
#endif

// Diffuse model

// Lambert
float3 Diffuse_lambert( float3 color )
{
	return color * (1 / PI);
}

// Normal Distibution Functions (NDF)

// Blinn
float D_blinn(float roughness, float NoH)
{
	float a = roughness * roughness;
	float a2 = a * a;
	return (1 / (PI * a2)) * pow(NoH, 2 / a2 - 2);
}

// Trowbridge-Reitz (GGX)
float D_ggx(float roughness, float NoH)
{
	float a = roughness * roughness;
	float a2 = a * a;
	float d = NoH * NoH * (a2 - 1) + 1 + 1.0e-7;
	return a2 / (PI * d * d);
}


// Geometric Shadowing (Visibility) Functions

// Tuned to match Visibility_smith
float Visibility_schlick( float roughness, float NoV, float NoL )
{
	float a = roughness * roughness * 0.5;
	float visV = NoV * (1 - a) + a;
	float visL = NoL * (1 - a) + a;
	return 0.25 / ( visV * visL );
}

// Smith term for GGX
float Visibility_smith( float roughness, float NoV, float NoL )
{
	float a = roughness * roughness;
	float a2 = a*a;
	float visV = NoV + sqrt(NoV * (NoV - NoV * a2) + a2);
	float visL = NoL + sqrt(NoL * (NoL - NoL * a2) + a2);
	return rcp(visV * visL);
}

// joint Smith term for GGX (approximation)
float Visibility_smithJA( float roughness, float NoV, float NoL )
{
	float a = roughness * roughness;
	float visV = NoL * (NoV * (1 - a) + a);
	float visL = NoV * (NoL * (1 - a) + a);
	return 0.5 * rcp(visV + visL);
}

// Neumann
float Visibility_neumann( float NoV, float NoL )
{
	return rcp(4 * max(NoV, NoL));
}

// implicit visibility
float Visibility_implicit()
{
	return 0.25;
}

// Fresnel Reflectance

// Schlick approximation
float3 Fresnel_schlick( float3 f0, float VoH )
{
	float c = pow(1 - VoH, 5);
	// return min(0.0, 50.0 * f0.g) * c + (1 - c) * f0;//f0 не бывает меньше 0.02, обрезаем
	return c + (1 - c) * f0;
}

#undef PI

#endif
