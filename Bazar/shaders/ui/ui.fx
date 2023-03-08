Texture2D fontTex;

float4 scale_translate;

struct VS_INPUT
{
	float2 vPos : POSITION0;
	float2 vTex : TEXCOORD0;
	float4 vClr : COLOR0;

};

struct VS_OUTPUT
{
	float4 oPos : SV_POSITION;
	float2 oT0  : TEXCOORD0;
	float4 oClr: COLOR0;
};

VS_OUTPUT VertOut(VS_INPUT vsInput)
{
	VS_OUTPUT vsOutput;
	
	
	vsOutput.oT0=vsInput.vTex;
	vsOutput.oClr=vsInput.vClr;
	vsOutput.oPos=float4(vsInput.vPos*scale_translate.xy+scale_translate.zw,0,1);
	
	return vsOutput;
	
}

SamplerState WrapLinearSampler
{
	Filter        = MIN_MAG_MIP_LINEAR;
	AddressU      = WRAP;
	AddressV      = WRAP;
	AddressW      = WRAP;
	MaxAnisotropy = 16;
//	BorderColor   = float4(0, 0, 0, 0);
};

float4 PixOut(VS_OUTPUT i): SV_TARGET0
{
	float4 d  = fontTex.Sample(WrapLinearSampler, i.oT0.xy);
	return float4(i.oClr.xyz, d.w*i.oClr.w);
}

BlendState enableAlphaBlend2
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = FALSE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
//	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

RasterizerState cullNone
{
        CullMode = None;
        FillMode = Solid;
        MultisampleEnable = FALSE;
};

DepthStencilState enableDepthBufferNoWrite
{
	DepthEnable        = FALSE;
	DepthWriteMask     = ALL;
	DepthFunc          = LESS_EQUAL;
//	StencilEnable      = FALSE;
//	StencilReadMask    = 0;
//	StencilWriteMask   = 0;
};


//#define technique10 technique

technique10 T0
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, PixOut()));
		SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}

