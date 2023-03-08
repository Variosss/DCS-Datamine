#ifndef WATERPARAMS_HLSL
#define WATERPARAMS_HLSL

cbuffer cbWaterParams :register(b5) {
	// 1
	float3	g_Offset;  
	float	g_Time; // 0
	// 2
	float2	g_TexOffset; 
	float2	g_Scale;
	// 3
	float2  g_TexScale; // {1,1};
	float	g_TileSize; 
	float	g_Level;
	// 4
	float2	g_WindDir;	// normalized wind direction
	float	g_WindForce;			
	float	g_WindDirFadeWaves;
	// 5
	float4	g_ColorBufferViewport;
	// 6
	float2	g_ColorBufferSize;
	float	g_ColorIntensity;
	float	g_SpecularIntensity;
	// 7
	float3	g_DeepColor;
	float	g_ScatterIntensity;
	// 8
	float3	g_ScatterColor;
	float	g_SunMultiplier;
	// 9
	float3	g_RiverDeepColor;
	float	g_WaterOpacity;
	// 10
	float3	g_RiverScatterColor;
	float	g_RiverWaterOpacity;
	// 11
	float	g_UseWaterMask;
	float	g_UseRefractionFilter;
	float	g_PrevFrameWeight;
	float	g_Dummy1;
	// 12
	float4x4	g_WaveMatrix;
	float4x4	g_MaskMatrix;
};

uint2 transformColorBufferUV(float2 uv) {
	return clamp(uv*g_ColorBufferViewport.zw+g_ColorBufferViewport.xy, 0, 0.99999)*g_ColorBufferSize+0.0001;
}

uint2 transformColorBuffer(float2 projPos) {
	return transformColorBufferUV(float2(projPos.x*0.5 + 0.5, -projPos.y*0.5 + 0.5));
}

float calcWaterDeepFactor(float water_depth, float riverLerp) {
	return saturate(exp(-water_depth * lerp(g_WaterOpacity, g_RiverWaterOpacity, riverLerp)*0.05));
}

#endif
