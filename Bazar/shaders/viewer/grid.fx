/*
shaders for OnePride's ParticleViewer
*/
#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"

float3 color;
float3 worldOffset;
float4x4 World;

struct VS_OUTPUT
{
	float4 pos	: SV_POSITION0;
	float4 projPos: POSITION0;
	float  mult	: TEXCOORD0;
	float3 color : TEXCOORD1;
};

VS_OUTPUT VS(float3 pos: POSITION0)
{
	VS_OUTPUT o;
	o.pos = mul(float4(pos+worldOffset, 1), World);
	o.pos = mul(o.pos, gViewProj);
	o.projPos = o.pos;
	o.mult = 0.5 + 0.5 * (abs(pos.x)>1.0e-6 && abs(pos.z)>1.0e-6);
	o.color = color;
	return o;
}

VS_OUTPUT vsSunDir(uint vertId: SV_VertexID)
{
	VS_OUTPUT o;
	o.pos = mul(mul(float4(gSunDir.xyz * (vertId%2) * 100 + worldOffset, 1), World), gViewProj);
	o.projPos = o.pos;
	o.mult = 1;
	o.color = color;
	return o;
}

VS_OUTPUT vsAxes(uint vertId: SV_VertexID)
{
	static const float3x3 mtx = {
		1.0, 0.0, 0.0,
		0.0, 1.0, 0.0,
		0.0, 0.0, 1.0
	};

	static const float3 vOffset = { 0.0, 0.03, 0.0 };

	VS_OUTPUT o;
	o.pos = mul(mul(float4(mtx[vertId/2] * (vertId%2) * 100 + worldOffset + vOffset, 1), World), gViewProj);
	o.projPos = o.pos;
	o.mult = 1;
	o.color = mtx[vertId / 2];
	return o;
}


float4 PS(VS_OUTPUT i, out float depth: SV_Depth) : SV_TARGET0
{
	depth = i.projPos.z/i.projPos.w + 1.0e-4;
	return float4(i.color,1);
}

RasterizerState gridRS
{
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = false;
};

technique10 tech
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetPixelShader(CompileShader(ps_4_0, PS()));
		SetGeometryShader(NULL);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(gridRS);
	}
}

technique10 techSunDir
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vsSunDir()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(gridRS);
	}
}

technique10 techAxes
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vsAxes()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(gridRS);
	}
}
