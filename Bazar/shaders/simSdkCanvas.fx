#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

cbuffer ConstantBufferMatrixes
{
    float4x4    Projection;
	float4      ScreenEffect;
	float4      UVEffect;
}

Texture2D txDiffuse;

struct VS_INPUT
{
    float2 Pos : POSITION0;
    float2 Tex : TEXCOORD0;
    float4 Col : COLOR0;
};

struct PS_INPUT
{
	float4 Pos : SV_POSITION0;
    float2 Tex : TEXCOORD0;
    float4 Col : COLOR;
};

struct PS_INPUT_IC
{
	float4 Pos : SV_POSITION0;
    float2 Tex : TEXCOORD0;
    float4 Col : COLOR;
	float2 Effect : TEXCOORD1;
	float4 UVParam : TEXCOORD2;
};

//-----------------------------------------------------------------------------
// VS
//-----------------------------------------------------------------------------

PS_INPUT vs( VS_INPUT input )
{
    PS_INPUT output = (PS_INPUT)0;
	float4 vec = float4(input.Pos, 0.0, 1.0);
    output.Pos = mul( vec, Projection );
    output.Tex = input.Tex; 
    output.Col = input.Col; 
    return output;
}

PS_INPUT_IC vsIC( VS_INPUT input )
{
    PS_INPUT_IC output = (PS_INPUT_IC)0;
	float4 vec = float4(input.Pos, 0.0, 1.0);
    output.Pos = mul( vec, Projection );
    output.Tex = input.Tex; 
	output.Col = input.Col;// *float4(ScreenEffect.x, ScreenEffect.x, ScreenEffect.x, 1.0);
	output.Effect.x = ScreenEffect.x;
	output.Effect.y = ScreenEffect.y;
	return output;
}

PS_INPUT_IC vsTL( VS_INPUT input )
{
    PS_INPUT_IC output = (PS_INPUT_IC)0;
	float4 vec = float4(input.Pos, 0.0, 1.0);
    output.Pos = mul( vec, Projection );
    output.Tex = input.Tex; 
	output.Col = input.Col;
	output.Effect.x = ScreenEffect.x;
	output.Effect.y = ScreenEffect.y;
	output.UVParam.x = UVEffect.x;
	output.UVParam.y = UVEffect.y;
	output.UVParam.z = UVEffect.x;
	output.UVParam.w = UVEffect.w;
	return output;
}

#if 1
#define vsTLIC vsTL
#else
PS_INPUT_IC vsTLIC( VS_INPUT input )
{
    PS_INPUT_IC output = (PS_INPUT_IC)0;
	float4 vec = float4(input.Pos, 0.0, 1.0);
    output.Pos = mul( vec, Projection );
    output.Tex = input.Tex; 
	output.Col = input.Col;
	output.Effect.x = ScreenEffect.x;
	output.Effect.y = ScreenEffect.y;
	output.UVParam.x = UVEffect.x;
	output.UVParam.y = UVEffect.y;
	output.UVParam.z = UVEffect.x;
	output.UVParam.w = UVEffect.w;
	return output;
}
#endif

//-----------------------------------------------------------------------------
// PS 
//-----------------------------------------------------------------------------

float4 ps(PS_INPUT input, uniform bool bTextured = false) : SV_Target0
{
    if(bTextured)
        return input.Col*txDiffuse.Sample( gPointWrapSampler, input.Tex );
    else
    {
        float4 finalColor = input.Col;
        finalColor.a = 1.0f;
        return finalColor;
    }
}

float4 psIC(PS_INPUT_IC input, uniform bool bTextured = false) : SV_Target0
{
	float4 color = input.Col;

    if(bTextured)
        color *= txDiffuse.Sample(gPointWrapSampler, input.Tex);

	float3 dif = color.xyz - float3(1.0, 1.0, 1.0);
	dif *= input.Effect.y;
	color.xyz = float3(1.0, 1.0, 1.0) + dif;

	color += float4(input.Effect.x, input.Effect.x, input.Effect.x, 0.0);
	float4 finalColor = color;
	return finalColor;
}

float4 psTexturesTL(PS_INPUT_IC input) : SV_Target0
{
	float u = (input.Tex.x - ceil(input.Tex.x)) * (input.UVParam.y - input.UVParam.x) + input.UVParam.x;
	float v = (input.Tex.y - ceil(input.Tex.y)) * (input.UVParam.w - input.UVParam.z) + input.UVParam.z;
	float2 vc = float2(u, v);

	float4 color = input.Col*txDiffuse.Sample(gPointWrapSampler, vc);// input.Tex);
	float4 finalColor = color;
	return finalColor;
};

float4 psTexturedTLIC(PS_INPUT_IC input) : SV_Target
{
	float u = (input.Tex.x - floor(input.Tex.x)) * (input.UVParam.y - input.UVParam.x) + input.UVParam.x;
	float v = (input.Tex.y - floor(input.Tex.y)) * (input.UVParam.w - input.UVParam.z) + input.UVParam.z;
	float2 vc = float2(u, v);

	float4 color = input.Col*txDiffuse.Sample(gPointWrapSampler, vc);//input.Tex); // 
	float3 dif = color.xyz - float3(1.0, 1.0, 1.0);
	dif *= input.Effect.y;
	color.xyz = float3(1.0, 1.0, 1.0) + dif;

	color += float4(input.Effect.x, input.Effect.x, input.Effect.x, 0.0);
	float4 finalColor = color;
	return finalColor;
};


BlendState alphaBlendState
{
	BlendEnable[0] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = ZERO;
	DestBlendAlpha = ONE;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
	AlphaToCoverageEnable = TRUE;
};

RasterizerState rasterizerState
{
	CullMode = None;
	FillMode = Solid;
	FrontCounterClockwise = true;
	DepthBias = false;
	DepthBiasClamp = 0;
	SlopeScaledDepthBias = 0;
	DepthClipEnable = true;
	ScissorEnable = true;
	MultisampleEnable = false;
	AntialiasedLineEnable = false;
};

#define PASS_BODY(vs, ps) { SetVertexShader(CompileShader(vs_5_0, vs)); SetGeometryShader(NULL); SetPixelShader(CompileShader(ps_5_0, ps)); \
	SetDepthStencilState(disableDepthBuffer, 0); \
	SetBlendState(alphaBlendState, float4(1.0f, 1.0f, 0.0f, 1.0f), 0xFFFFFFFF); \
	SetRasterizerState(rasterizerState);}

#define TEXTURED true

technique10 canvas
{
	pass colored			PASS_BODY(vs(),		ps())
	pass coloredIC			PASS_BODY(vsIC(),	psIC())
	pass textured			PASS_BODY(vs(),		ps(TEXTURED))
	pass texturedIC			PASS_BODY(vsIC(),	psIC(TEXTURED))
	pass texturedTL			PASS_BODY(vsIC(),	psTexturesTL())
	pass texturedTLIC		PASS_BODY(vsTLIC(), psTexturedTLIC())
}
