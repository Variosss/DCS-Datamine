#include "metashaders\terrain\inc\TerrainContext.hlsl"
#include "metashaders\inc\HeightOutput.hlsl"

struct PS_OUTPUT
{
	float4 color : SV_Target0;
	uint4 Heightmap_NoL_SDID : SV_Target1;
	float4 grassRGBL : SV_Target2;
};

static const float2 quad[4] = 
{
	{ -1, -1 },{ 1, -1 },
	{ -1,  1 },{ 1,  1 }
};

float4 VS(uint vid : SV_VertexID): SV_Position
{
	return float4(quad[vid], 0, 1);
}

PS_OUTPUT PS(float4 pos: SV_Position)
{
	PS_OUTPUT o;
	o.color = 0;
	o.Heightmap_NoL_SDID = uint4(0, invalidSurfaceDetailHint, 0, 0);
	o.grassRGBL = 0;
	return o;
}

DepthStencilState noDepth
{
	DepthEnable = FALSE;
	DepthWriteMask = 0;
};

BlendState noBlend
{
	BlendEnable[0] = FALSE;
	BlendEnable[1] = FALSE;
	BlendEnable[2] = FALSE;
};

technique10 ClearHeightmapFramebuffer
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(NULL); 
		SetPixelShader(CompileShader(ps_5_0, PS()));
		SetDepthStencilState(noDepth, 0);
		SetBlendState(noBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		//SetRasterizerState(cullNone);
	}
}
