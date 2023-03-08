#ifndef MODEL_CONSTANTS_HLSL
#define MODEL_CONSTANTS_HLSL

#ifndef BUILDING_MATERIAL
	static const float DEF_DEPTH_BIAS = 1.0e2;
#else
	static const float DEF_DEPTH_BIAS = 1.0e1;
#endif

#endif
