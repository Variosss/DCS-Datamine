// left top corner of rectangle is [0, 0] 
Texture2D	mapTex;
float4x4	WVP;
float		valueX;
float		valueY;
int			columns;
int			rows;
float		quadSize;
float		quadSizeX;
float		quadSizeY;
float		texSizeX;
float		texSizeY;
float		quadsAlpha[100];

#define	M_PI 3.14159265

SamplerState texSampler
{
	Filter			= ANISOTROPIC;
	AddressU		= WRAP;
	AddressV		= WRAP;
	MaxAnisotropy	= 4;
	BorderColor		= float4(0, 0, 0, 0);
};

struct VS_INPUT
{
	float4	Position	: POSITION0;
	float4	Color		: COLOR0;
	float2	TexCoord	: TEXCOORD0;
};

struct VS_OUT 
{
	float4	Position	: SV_POSITION0;
	float4	Color		: COLOR0;
	float3	TexCoord	: TEXCOORD0;
};

VS_OUT vs_main( VS_INPUT IN )
{
	VS_OUT OUT;

	float quadIndex	= IN.Position.z;
	int column		= int(quadIndex) % columns;
	int row			= int(quadIndex / columns);

	IN.Position.z = 0;

	float4 pos = mul(IN.Position, WVP);

	if (IN.Position.x == 0)
	{
		pos.x += column * quadSizeX + valueX;
		OUT.TexCoord.x = float(column * quadSize) / texSizeX;
	}
	else
	{
		pos.x += column * quadSizeX - valueX;
		OUT.TexCoord.x = (float(column * quadSize) + IN.Position.x) / texSizeX;
	}

	if (IN.Position.y == 0)
	{
		pos.y -= row * quadSizeY + valueY;
		OUT.TexCoord.y = float(row * quadSize) / texSizeY;
	}
	else
	{
		pos.y -= row * quadSizeY - valueY;
		OUT.TexCoord.y = (float(row * quadSize) + IN.Position.y) / texSizeY;
	}

	OUT.Position	= pos;
	OUT.TexCoord.z	= 0;
	OUT.Color		= IN.Color;
	OUT.Color.a		= OUT.Color.a * quadsAlpha[int(quadIndex) % 100];
	
	return OUT;	
}

float4 ps_main2(VS_OUT IN, uniform SamplerState sm) : SV_TARGET0
{
	float4 diffuse = mapTex.Sample(sm, IN.TexCoord.xy);

	return diffuse * IN.Color;
}

RasterizerState cullNone
{
	CullMode					= None;
	FillMode					= Solid;
	MultisampleEnable			= FALSE;
};

DepthStencilState depthState
{
	DepthEnable					= false;
	DepthWriteMask				= ALL;
	DepthFunc					= LESS_EQUAL;
};

DepthStencilState depthStencilState
{
	DepthEnable					= false;
	DepthWriteMask				= ALL;
	DepthFunc					= LESS_EQUAL;

	StencilEnable				= true;
	StencilReadMask				= 1;
	StencilWritemask			= 1;
	FrontFaceStencilFunc		= NOT_EQUAL;
	FrontFaceStencilPass		= REPLACE;
	FrontFaceStencilFail		= KEEP;
	BackFaceStencilFunc			= NOT_EQUAL;
	BackFaceStencilPass			= REPLACE;
	BackFaceStencilFail			= KEEP;
};

DepthStencilState depthStencilStateTest
{
	DepthEnable					= false;
	DepthWriteMask				= ALL;
	DepthFunc					= LESS_EQUAL;

	StencilEnable				= true;
	StencilReadMask				= 1;
	StencilWritemask			= 1;
	FrontFaceStencilFunc		= EQUAL;
	FrontFaceStencilPass		= KEEP;
	FrontFaceStencilFail		= KEEP;
	BackFaceStencilFunc			= EQUAL;
	BackFaceStencilPass			= KEEP;
	BackFaceStencilFail			= KEEP;
};

BlendState blendState
{
	BlendEnable[0]				= TRUE;
	// BlendEnable[1] = TRUE;
	SrcBlend					= SRC_ALPHA;
	DestBlend					= INV_SRC_ALPHA;
	BlendOp						= ADD;
	SrcBlendAlpha				= SRC_ALPHA;
	DestBlendAlpha				= INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha				= ADD;
	RenderTargetWriteMask[0]	= 0x0f; //RED | GREEN | BLUE | ALPHA
};

VertexShader	vsSimple		= CompileShader(vs_4_0, vs_main());
PixelShader		psSimple		= CompileShader(ps_4_0, ps_main2(texSampler));

#define SET_SHADERS(vs,ps)  SetVertexShader(vs); SetGeometryShader(NULL); SetPixelShader(ps)

// для нормального пасса
#define SET_PASS(name, vs, ps, dsState)  pass name { SET_SHADERS(vs,ps); SetDepthStencilState(dsState, 1); \
		SetBlendState(blendState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); SetRasterizerState(cullNone); }

technique10 Standart
{	
	SET_PASS(tex, vsSimple, psSimple, depthState)
}
