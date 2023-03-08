#ifndef FRESNEL_TERM_H
#define FRESNEL_TERM_H
// Fresnel shader

//		     pow(1.0 - refraction_index, 2.0)
//		R0 = -------------------------------
//			 pow(1.0 + refraction_index, 2.0)

//		vLightDir - in direction
//		vNormal - surface normal


//	Material Index of Refraction, n
//
//	Vacuum				1.0
//	Air					1.000293
//	Ice					1.31
//	Water				1.333333
//	Ethyl Alcohol		1.36
//	Fluorite			1.43
//	Poppy Seed Oil		1.469
//	Olive Oil			1.47
//	Linseed Oil			1.478
//	Plexiglas			1.51
//	Immersion Oil		1.515
//	Crown Glass			1.52
//	Quartz				1.54
//	Salt				1.54
//	Light Flint Glass	1.58
//	Dense Flint Glass	1.66
//	Tourmaline			1.62
//	Garnet				1.73-1.89
//	Zircon				1.923
//	Cubic Zirconia		2.14-2.20
//	Diamond				2.417
//	Rutile				2.907
//	Gallium Phosphide	3.5

struct fInput{
	float3 vLightDir;
	float3 vNormal;
	float R0;
	float power;
};

float FresnelTerm(in const fInput i){
	float F = i.R0 + (1.0 - i.R0) * pow(1.0 - saturate(dot(i.vLightDir, i.vNormal)), i.power);
	return F;
}

#endif
