#ifndef CONSTANTS_HLSL
#define CONSTANTS_HLSL

///////////////////////
// RENDERMODES:

//#define DISABLE_SHADING

//#define RENDER_SPECULAR_COMPONENTS

//#define CONSTANT_DIFFUSE float4(1, 1, 1, 1.0)

//#define RENDER_SELF_ILLUMINATION_COMPONENTS

//#define RENDER_SHADOWS

//#define RENDER_NORMALS

//#define RENDER_NOISE_FAR

///////////////////////

#ifndef USE_DCS_DEFERRED
static const float SPEC_FACTOR_MULT=66.008;
static const float SPEC_POWER_MULT=1.0;
#endif

// hack to increase terrain brightness
#ifdef EDGE
static const float SURFACECOLORGAIN=1;
#else
static const float SURFACECOLORGAIN=1.35;
#endif

static const float3 IR_MULT = float3(0.299, 0.587, 0.114);

#endif
