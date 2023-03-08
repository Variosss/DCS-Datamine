#ifndef MODEL_MAP_SHADING_HLSL
#define MODEL_MAP_SHADING_HLSL

PS_OUTPUT diffuse_sun_ps_map(VS_OUTPUT input)
{
	PS_OUTPUT o;
	o.RGBColor = float4(0.0, 0.0, 0.0, 1.0);
	return o;
}

#endif
