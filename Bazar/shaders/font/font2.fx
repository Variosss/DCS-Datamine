Texture2D FontTexture;

// #define FONT_SHADOWS

SamplerState WrapSampler
{
	Filter        = ANISOTROPIC;
	AddressU      = WRAP;
	AddressV      = WRAP;
	AddressW      = WRAP;
	MaxAnisotropy = 16;
	BorderColor   = float4(0, 0, 0, 0);
};
BlendState enableAlphaBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};
DepthStencilState disableDepthBuffer
{
	DepthEnable        = FALSE;
	DepthWriteMask     = ZERO;
	DepthFunc          = LESS_EQUAL;

	StencilEnable      = FALSE;
	StencilReadMask    = 0;
	StencilWriteMask   = 0;
};
RasterizerState cullNone
{
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = FALSE;
};

float4 color;
float2 textPos;
float2 targetDims;
float4x4 rotation;
float2 justify;
// float4 shadowColor = float4(0, 0, 0, 1);
float4 shadowColor = float4(1, 0, 0, 1);
float shadowSize = 1.5;

struct VS_INPUT
{
	float2 pos  : POSITION0;
	float2 uv : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 pos  : SV_POSITION;
	float2 uv : TEXCOORD0;
};

float offset = 0;

VS_OUTPUT VerText(VS_INPUT input)
{
	VS_OUTPUT output;
	input.pos += justify;
	input.pos = mul(input.pos, rotation);
	output.pos.x =   ((input.pos.x + textPos.x + offset) / targetDims.x - 0.5f) * 2.0f;
	output.pos.y = - ((input.pos.y + textPos.y + offset) / targetDims.y - 0.5f) * 2.0f;
	output.pos.z = 0.5f;
	output.pos.w = 1.0f;
	output.uv = input.uv;
	return output;
}

static const float2 kernel[] = 
{
	{-1, -1},
	{ 0, -1},
	{ 1, -1},
	{ 1,  0},
	{ 1,  1},
	{ 0,  1},
	{-1,  1},
	{-1,  0}
};

float4 PixOut(VS_OUTPUT input) : SV_TARGET0
{
	float4 t = color;
	t.a *= FontTexture.Sample(WrapSampler, input.uv).a;
	
#ifndef FONT_SHADOWS
	return t;
#else
	// shadow
	float width, height;
	FontTexture.GetDimensions(width, height);
	float2 kernelSize = shadowSize / float2(width, height);
	
	float shadow = 0;
	for(uint i=0; i<8; ++i)	
		shadow += FontTexture.Sample(WrapSampler, input.uv + kernel[i]*kernelSize).a;	
	shadow /= 8;
	
	// blend shadow
	float3 color = t.rgb;
	float a = max(shadow, t.a);
	if(a==0) discard;
	color = lerp(shadowColor, color/a, t.a);
	return float4(color, a);
#endif
}

technique10 Standart
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, VerText()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
