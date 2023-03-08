#ifndef _ede6fb494f802b03d5b0dc877303936d_HLSL
#define _ede6fb494f802b03d5b0dc877303936d_HLSL

#ifdef ENABLE_DEBUG_UNIFORMS

// GENERATED CODE BEGIN ID: fake_lights_debug_uniforms
cbuffer fake_lights_debug_uniforms {
	float FL_DBG_SIZE_MULT;	// Multiplier of source size.
	float FL_DBG_LUMINANCE_MULT;	// Multiplier of luminance.
	float FL_DBG_MIN_SIZE_IN_PIXELS_MULT;	// Self describing.
	float FL_DBG_DISTANCE_MULT;	// Self describing.
}
// GENERATED CODE END ID: fake_lights_debug_uniforms

#else

static const float FL_DBG_SIZE_MULT = 1;	// Multiplier of source size.
static const float FL_DBG_LUMINANCE_MULT = 1;	// Multiplier of luminance.
static const float FL_DBG_MIN_SIZE_IN_PIXELS_MULT = 1;	// Self describing.
static const float FL_DBG_DISTANCE_MULT = 1;	// Self describing.

#endif

#endif
