Texture2D		mapTex;
Texture2DArray	mapTexArray;

float4x4		WVP;
float			quadDrawing = -1;
float			texturePresented;
float 			textureArrayPresented;
float4			fontBlurColor;
float2			position;
float			colorCount;
float4			colors[9];
float			opacity;//		= 1;
float			gamma;//		= 1;
float			intensity;//	= 1;
float4			params;

cbuffer cbQuads
{
float4			quadsBounds[100];
float4			quadsTexCoors[100];
uint4			quadsTexIndices[100/8+1]; // indices are packed as uint16 => 8 values per row
};

cbuffer cbQuadsShort
{
float4			quadsBoundsShort[16];
float4			quadsTexCoorsShort[16];
uint4			quadsTexIndicesShort[16/8+1]; // indices are packed as uint16 => 8 values per row
};

SamplerState texSampler
{
	Filter			= MIN_MAG_MIP_POINT;
	AddressU		= WRAP;
	AddressV		= WRAP;
	MaxAnisotropy	= 1;
	BorderColor		= float4(0, 0, 0, 0);
};

SamplerState fontSampler
{
	Filter			= MIN_MAG_MIP_POINT;
	AddressU		= WRAP;
	AddressV		= WRAP;
	MaxAnisotropy	= 1;
	BorderColor		= float4(0, 0, 0, 0);
};

SamplerState userTexSampler
{
	Filter			= MIN_MAG_LINEAR_MIP_POINT;
	AddressU		= WRAP;
	AddressV		= WRAP;
	MaxAnisotropy	= 4;
	BorderColor		= float4(0, 0, 0, 0);
};

SamplerState userTexSamplerAnisotropic
{
	Filter			= ANISOTROPIC;
	AddressU		= WRAP;
	AddressV		= WRAP;
	MaxAnisotropy	= 4;
	BorderColor		= float4(0, 0, 0, 0);
};

struct VS_INPUT
{
	float4 Position	: POSITION0;
	float4 Color	: COLOR0;
	float2 TexCoord	: TEXCOORD0;
};

struct VS_OUT 
{
	float4	Position	: SV_POSITION0;
	float4	Color		: COLOR0;
	float3	TexCoord	: TEXCOORD0;
};

#define bounds			quadsBounds
#define texCoords		quadsTexCoors
#define texIndices		quadsTexIndices
#include "guiQuads.hlsl"
#undef bounds
#undef texCoords
#undef texIndices


#define bounds			quadsBoundsShort
#define texCoords		quadsTexCoorsShort
#define texIndices		quadsTexIndicesShort
#define getTextureIndex getTextureIndexShort
#define getQuadVertex	getQuadVertexShort
#include "guiQuads.hlsl"
#undef bounds
#undef texCoords
#undef texIndices
#undef getQuadVertex
#undef getTextureIndex

VS_OUT vs_main( VS_INPUT IN )
{
	VS_OUT OUT = (VS_OUT)0;

	if(quadDrawing <= 0)
	{
		IN.Position.xy = IN.Position.xy + position.xy;
		OUT.Position = mul(IN.Position, WVP);
		OUT.TexCoord.xy = IN.TexCoord.xy;
		OUT.TexCoord.z = 0;
		OUT.Color = IN.Color;
	}
	else if(quadDrawing<=1)	//short path
		OUT = getQuadVertexShort(IN);
	else	// full power
		OUT = getQuadVertex(IN);

	OUT.Color.a *= opacity;

	return OUT;	
}

#define NO_TEXTURE			0
#define USE_TEXTURE			1
#define USE_TEXTURE_ARRAY	2
#define USE_TEXTURE_FONT	3

float3 correctGammaAndBrightness(float3 color)
{
	return pow(abs(color), gamma) * intensity;
}

float4 correctGammaAndBrightness(float4 color)
{
	return float4(correctGammaAndBrightness(color.rgb), color.a);
}

float4 ps_main2(VS_OUT IN, uniform int textureType, uniform SamplerState sm) : SV_TARGET0
{
	if(textureType > NO_TEXTURE)
	{
		float4 diffuse;
		
		if(textureType == USE_TEXTURE_ARRAY)
		{
			diffuse = mapTexArray.Sample(sm, IN.TexCoord.xyz).rrrg;

			if(fontBlurColor.a > 0)
			{
				float3 color = lerp(fontBlurColor.rgb, IN.Color.rgb, diffuse.a);

				return float4(correctGammaAndBrightness(color), saturate(diffuse.r * IN.Color.a * 1.5));
			}
		}
		else
		{
			if (textureType == USE_TEXTURE_FONT)
			{
				diffuse = mapTex.Sample(sm, IN.TexCoord.xy).rrrg;

				if (fontBlurColor.a > 0)
				{
					float3 color = lerp(fontBlurColor.rgb, IN.Color.rgb, diffuse.a);

					return float4(correctGammaAndBrightness(color), saturate(diffuse.r * IN.Color.a * 1.5));
				}
			}
			else
			{
				diffuse = mapTex.Sample(sm, IN.TexCoord.xy);
			}
		}
		
		return correctGammaAndBrightness(diffuse * IN.Color);
	}

	return correctGammaAndBrightness(IN.Color);
}

#include "guiPrimitives.hlsl"

RasterizerState cullNone
{
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = FALSE;
};

DepthStencilState depthState
{
	DepthEnable        = false;
	DepthWriteMask     = ALL;
	DepthFunc          = LESS_EQUAL;
};


DepthStencilState depthStencilState
{
	DepthEnable			= false;
	DepthWriteMask		= ALL;
	DepthFunc			= LESS_EQUAL;

	StencilEnable			= true;
	StencilReadMask			= 1;
	StencilWritemask		= 1;
	FrontFaceStencilFunc	= NOT_EQUAL;
	FrontFaceStencilPass	= REPLACE;
	FrontFaceStencilFail	= KEEP;
	BackFaceStencilFunc		= NOT_EQUAL;
	BackFaceStencilPass		= REPLACE;
	BackFaceStencilFail		= KEEP;
};

DepthStencilState depthStencilStateTest
{
	DepthEnable			= false;
	DepthWriteMask		= ALL;
	DepthFunc			= LESS_EQUAL;

	StencilEnable			= true;
	StencilReadMask			= 1;
	StencilWritemask		= 1;
	FrontFaceStencilFunc	= EQUAL;
	FrontFaceStencilPass	= KEEP;
	FrontFaceStencilFail	= KEEP;
	BackFaceStencilFunc		= EQUAL;
	BackFaceStencilPass		= KEEP;
	BackFaceStencilFail		= KEEP;
};

BlendState blendState
{
	BlendEnable[0]	= TRUE;
	// BlendEnable[1] = TRUE;
	SrcBlend		= SRC_ALPHA;
	DestBlend		= INV_SRC_ALPHA;
	BlendOp			= ADD;
	SrcBlendAlpha	= SRC_ALPHA;
	DestBlendAlpha	= INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha	= ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

BlendState blendStateOne
{
	BlendEnable[0]	= TRUE;
	// BlendEnable[1] = TRUE;
	SrcBlend		= SRC_ALPHA; //ONE;
	DestBlend		= INV_SRC_ALPHA;
	BlendOp			= ADD;
	SrcBlendAlpha	= SRC_ALPHA;
	DestBlendAlpha	= ONE;
	BlendOpAlpha	= ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

void vs_dummy() {}

VertexShader	vsDummy					= CompileShader(vs_5_0, vs_dummy());
VertexShader	vsSimple				= CompileShader(vs_5_0, vs_main());

GeometryShader	gsCircle				= CompileShader(gs_5_0, gs_cicle());
GeometryShader	gsLifeBar				= CompileShader(gs_5_0, gs_lifeBar());

PixelShader		psSimple				= CompileShader(ps_5_0, ps_main2(NO_TEXTURE			, texSampler));
PixelShader		psTex					= CompileShader(ps_5_0, ps_main2(USE_TEXTURE		, texSampler));
PixelShader		psTexUser				= CompileShader(ps_5_0, ps_main2(USE_TEXTURE		, userTexSampler));
PixelShader		psTexArray				= CompileShader(ps_5_0, ps_main2(USE_TEXTURE_ARRAY	, texSampler));
PixelShader		psTexArrayUser			= CompileShader(ps_5_0, ps_main2(USE_TEXTURE_ARRAY	, userTexSampler));
PixelShader		psTexUserAnisotropic	= CompileShader(ps_5_0, ps_main2(USE_TEXTURE		, userTexSamplerAnisotropic));
PixelShader		psTexFont				= CompileShader(ps_5_0, ps_main2(USE_TEXTURE_FONT	, texSampler));

PixelShader		psPrimitive				= CompileShader(ps_5_0, ps_primitive());
PixelShader		psLifeBar				= CompileShader(ps_5_0, ps_lifeBar());

#define SET_SHADERS(vs,ps)  			SetVertexShader(vs); SetGeometryShader(NULL); SetPixelShader(ps)
#define SET_SHADERS_G(vs,gs,ps)			SetVertexShader(vs); SetGeometryShader(gs); SetPixelShader(ps)

// для нормального пасса
#define SET_PASS(name, vs, ps, dsState, blState)  pass name { SET_SHADERS(vs,ps); SetDepthStencilState(dsState, 1); \
		SetBlendState(blState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); SetRasterizerState(cullNone); }

#define SET_PASS_G(name, vs, gs, ps, dsState, blState)  pass name { SET_SHADERS_G(vs,gs,ps); SetDepthStencilState(dsState, 1); \
		SetBlendState(blState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); SetRasterizerState(cullNone); }

technique10 Standart
{	
	SET_PASS(simple					, vsSimple	, psSimple				, depthState			, blendState)
	SET_PASS(tex					, vsSimple	, psTex					, depthState			, blendState)
	SET_PASS(texUser				, vsSimple	, psTexUser				, depthState			, blendState)
	SET_PASS(array					, vsSimple	, psTexArray			, depthState			, blendState)
	SET_PASS(arrayUser				, vsSimple	, psTexArrayUser		, depthState			, blendState)
	SET_PASS(texUserAnisotropic		, vsSimple	, psTexUserAnisotropic	, depthState			, blendState)
	SET_PASS(texFont				, vsSimple	, psTexFont				, depthState			, blendState)
	SET_PASS_G(simpleCircle			, vsDummy, gsCircle, psPrimitive	, depthState			, blendState)
	SET_PASS_G(simpleLifeBar		, vsDummy, gsLifeBar, psLifeBar		, depthState			, blendState)
}

technique10 StencilWrite
{
	SET_PASS(simple					, vsSimple	, psSimple				, depthStencilState		, blendState)
	SET_PASS(tex					, vsSimple	, psTex					, depthStencilState		, blendState)
	SET_PASS(texUser				, vsSimple	, psTexUser				, depthStencilState		, blendState)
	SET_PASS(array					, vsSimple	, psTexArray			, depthStencilState		, blendState)
	SET_PASS(arrayUser				, vsSimple	, psTexArrayUser		, depthStencilState		, blendState)
	SET_PASS(texUserAnisotropic		, vsSimple	, psTexUserAnisotropic	, depthStencilState		, blendState)
	SET_PASS(texFont				, vsSimple	, psTexFont				, depthStencilState		, blendState)
	SET_PASS_G(simpleCircle			, vsDummy, gsCircle, psPrimitive	, depthStencilState		, blendState)
	SET_PASS_G(simpleLifeBar		, vsDummy, gsLifeBar, psLifeBar		, depthStencilState		, blendState)
}

technique10 StencilWriteTarget
{
	SET_PASS(simple					, vsSimple	, psSimple				, depthStencilState		, blendStateOne)
	SET_PASS(tex					, vsSimple	, psTex					, depthStencilState		, blendStateOne)
	SET_PASS(texUser				, vsSimple	, psTexUser				, depthStencilState		, blendStateOne)
	SET_PASS(array					, vsSimple	, psTexArray			, depthStencilState		, blendStateOne)
	SET_PASS(arrayUser				, vsSimple	, psTexArrayUser		, depthStencilState		, blendStateOne)
	SET_PASS(texUserAnisotropic		, vsSimple	, psTexUserAnisotropic	, depthStencilState		, blendStateOne)
	SET_PASS(texFont				, vsSimple	, psTexFont				, depthStencilState		, blendStateOne)
	SET_PASS_G(simpleCircle			, vsDummy, gsCircle, psPrimitive	, depthStencilState		, blendStateOne)
	SET_PASS_G(simpleLifeBar		, vsDummy, gsLifeBar, psLifeBar		, depthStencilState		, blendStateOne)
}

technique10 Target
{
	SET_PASS(simple					, vsSimple	, psSimple				, depthStencilStateTest	, blendStateOne)
	SET_PASS(tex					, vsSimple	, psTex					, depthStencilStateTest	, blendStateOne)
	SET_PASS(texUser				, vsSimple	, psTexUser				, depthStencilStateTest	, blendStateOne)
	SET_PASS(array					, vsSimple	, psTexArray			, depthStencilStateTest	, blendStateOne)
	SET_PASS(arrayUser				, vsSimple	, psTexArrayUser		, depthStencilStateTest	, blendStateOne)
	SET_PASS(texUserAnisotropic		, vsSimple	, psTexUserAnisotropic	, depthStencilStateTest	, blendStateOne)
	SET_PASS(texFont				, vsSimple	, psTexFont				, depthStencilStateTest	, blendStateOne)
	SET_PASS_G(simpleCircle			, vsDummy, gsCircle, psPrimitive	, depthStencilStateTest	, blendStateOne)
	SET_PASS_G(simpleLifeBar		, vsDummy, gsLifeBar, psLifeBar		, depthStencilStateTest	, blendStateOne)
}

technique10 TargetVR
{
	SET_PASS(simple					, vsSimple	, psSimple				, depthState	, blendStateOne)
	SET_PASS(tex					, vsSimple	, psTex					, depthState	, blendStateOne)
	SET_PASS(texUser				, vsSimple	, psTexUser				, depthState	, blendStateOne)
	SET_PASS(array					, vsSimple	, psTexArray			, depthState	, blendStateOne)
	SET_PASS(arrayUser				, vsSimple	, psTexArrayUser		, depthState	, blendStateOne)
	SET_PASS(texUserAnisotropic		, vsSimple	, psTexUserAnisotropic	, depthState	, blendStateOne)
	SET_PASS(texFont				, vsSimple	, psTexFont				, depthState	, blendStateOne)
	SET_PASS_G(simpleCircle			, vsDummy, gsCircle	, psPrimitive	, depthState	, blendStateOne)
	SET_PASS_G(simpleLifeBar		, vsDummy, gsLifeBar, psLifeBar		, depthState	, blendStateOne)
}
