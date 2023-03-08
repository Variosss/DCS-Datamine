#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/stencil.hlsl"

#define DISABLE_MASK_STENCIL

int4	screenCenter;
float4	radius;
float	depthValue;

struct VS_OUTPUT
{
	noperspective float4 pos	:SV_POSITION0;
	noperspective float4 projPos:TEXCOORD0;
};

VS_OUTPUT vs(uint vid: SV_VertexID)
{
	const float2 quad[4] = {
		{-1, -1}, {1, -1},
		{-1,  1}, {1,  1}
	};
	VS_OUTPUT o;
	o.pos = float4(quad[vid], depthValue, 1);
	o.projPos.xy = o.pos.xy * 0.5 * screenCenter.zw - screenCenter.xy;
	o.projPos.zw = o.pos.xy - screenCenter.xy / screenCenter.zw;
	return o;
}

bool isInvisible(int2 pixel)
{
	const int patternSize = 4;//в пикселях

	//находим центр квада в координатах таргета
	int2 quadPos = int2(pixel / patternSize) * patternSize + patternSize/2;

	float d = length((quadPos - screenCenter.zw/2)) / screenCenter.zw * 2;

	int2 p = int2(pixel)/(patternSize/2) + 10000;//bias greater than max render target size

	bool row = p.y&1;
	uint pixelId = ((p.y%2)*2 + p.x%2);
	// uint pixelId = ((p.y%2)*2 + row? (1-(p.x%2)) : p.x%2);

	return d<radius.x;

	bool visible = pixelId==1? d<radius.x : pixelId==2? d<radius.y : pixelId==3? d<radius.z : true;
	// uint patternId = d<radius.x? 4u : d<radius.y? 3u : d<radius.z? 2u : 1u;
	// if(patternId>pixelId)
	// uint patternId = d>radius.z? 3u : d>radius.y? 2u : d>radius.x? 1u : 0u;
	// if(patternId<=pixelId)
	return visible;
}

void ps(VS_OUTPUT i) 
{
	// if(isInvisible(i.pos.xy))
		discard;
}

float4 vsOctagonMask(in float2 pos:POSITION0): SV_POSITION0
{
	return float4(pos, 1, 1);
}

float4 psOctagonMask(in float4 pos: SV_POSITION0): SV_Target0
{
	return 0;
}

#ifndef DISABLE_MASK_STENCIL
RasterizerState rState {
	CullMode = NONE;
	FillMode = SOLID;
	MultisampleEnable = false;
	DepthBias = 0;
	SlopeScaledDepthBias = 0;
	DepthClipEnable = false;
};

DepthStencilState dsWriteMask {
	// DepthEnable = true;
	DepthEnable = false;
	DepthWriteMask = ALL;
	DepthFunc = ALWAYS;

	StencilEnable = TRUE;
	StencilWriteMask = STENCIL_CLIP_MASK;
	FrontFaceStencilFunc = ALWAYS;
	FrontFaceStencilPass = REPLACE;
	BackFaceStencilFunc = ALWAYS;
	BackFaceStencilPass = REPLACE;
};
#endif

technique10 Mask
{
	pass maskOctagon
	{
		SetVertexShader(CompileShader(vs_5_0, vsOctagonMask()));
		SetGeometryShader(NULL);
		// SetPixelShader(CompileShader(ps_5_0, psOctagonMask()));
		SetPixelShader(NULL);
		SetDepthStencilState(alwaysDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
#ifndef DISABLE_MASK_STENCIL
	pass maskDepth
	{
		SetVertexShader(CompileShader(vs_5_0, vs()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps()));
		// SetDepthStencilState(enableDepthBuffer, 0);
		SetDepthStencilState(dsWriteMask, STENCIL_CLIP_MASK);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(rState);
	}
	pass maskStencil
	{
		SetVertexShader(CompileShader(vs_5_0, vs()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps()));
		// SetDepthStencilState(enableDepthBuffer, 0); //set from C++
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(rState);
	}

	pass reconstruct
	{
		SetVertexShader(CompileShader(vs_5_0, vs()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps()));
		// SetDepthStencilState(enableDepthBuffer, 0); //set from C++
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(rState);
	}
#endif
}
