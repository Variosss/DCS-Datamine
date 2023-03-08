/*
grid shader for OnePride's EdgeViewer
*/
#include "../common/TextureSamplers.hlsl"
#include "../common/States11.hlsl"

float3 gridColor;
float3 worldOffset;

float4x4 WVP;                  // World matrix for object


float4 VS(float3 pos : POSITION0): SV_POSITION0
{
	return mul(float4(pos-worldOffset, 1), WVP);
}


float4 PS() : SV_TARGET0
{ 
    return float4(gridColor,1);
}


technique10 tech
{
    pass P0
    {          
		ENABLE_DEPTH_BUFFER;
		DISABLE_CULLING;
		DISABLE_ALPHA_BLEND;

		VERTEX_SHADER(VS())
		PIXEL_SHADER(PS())
		GEOMETRY_SHADER_PLUG
    }
}
