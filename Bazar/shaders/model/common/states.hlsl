#ifndef MODEL_STATES_HLSL
#define MODEL_STATES_HLSL

#include "./common/model_constants.hlsl"

#ifdef SET_RASTER_STATE
#undef SET_RASTER_STATE
#endif

RasterizerState _RASTER_STATE_BIAS{
	CullMode = Front;
	FillMode = Solid;
	MultisampleEnable = TRUE;
	DepthBias = DEF_DEPTH_BIAS;
};

RasterizerState _RASTER_STATE_NO_BIAS{
#ifndef FOREST_MATERIAL
	CullMode = Front;
#else
	CullMode = None;
#endif
	FillMode = Solid;
	MultisampleEnable = TRUE;
	DepthBias = 0.0;
};

#ifndef DEPTH_BIAS
	#define SET_RASTER_STATE SetRasterizerState(_RASTER_STATE_NO_BIAS)
#else
	#define SET_RASTER_STATE SetRasterizerState(_RASTER_STATE_BIAS)
#endif

#endif

