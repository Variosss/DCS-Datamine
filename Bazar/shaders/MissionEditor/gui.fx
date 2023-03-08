Texture2D		mapTex;
Texture2DArray	mapTexArray;

float4x4		WVP;
float			quadDrawing = -1;
float			texturePresented;
float 			textureArrayPresented;
float4			fontBlurColor;
float4			quadsBounds[100];
float4			quadsTexCoors[100];
float			quadsTexIndices[100];
float2			position;
float			colorCount;
float4			colors[9];
float			opacity;//		= 1;
float			gamma;//		= 1;
float			intensity;//	= 1;

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

VS_OUT vs_main( VS_INPUT IN )
{
	VS_OUT OUT;

	if(quadDrawing > 0)
	{
		float quadIndex		= IN.Position.z;
		float4 quadBounds	= quadsBounds[quadIndex];

		IN.Position.xy = quadBounds.xy + IN.Position.xy * quadBounds.zw + position.xy;
		IN.Position.z	= 0;
		
		OUT.TexCoord.x	= 0;
		OUT.TexCoord.y	= 0;
		
		if(textureArrayPresented > 0)
		{
			OUT.TexCoord.z = quadsTexIndices[quadIndex];
		}

		if(texturePresented > 0 || textureArrayPresented > 0)
		{
			float4 quadTexCoors = quadsTexCoors[quadIndex];
			OUT.TexCoord.xy = IN.TexCoord.xy > 0 ? quadTexCoors.zw : quadTexCoors.xy;
		}
		
		int colorIndex = ceil(fmod(quadIndex, colorCount));
		
		OUT.Color = colors[colorIndex];
		
		OUT.Position = mul(float4(IN.Position.x, IN.Position.y, 0, 1), WVP);
	}
	else
	{
		IN.Position.xy = IN.Position.xy + position.xy;

		OUT.Position = mul(IN.Position, WVP);
		OUT.TexCoord.xy = IN.TexCoord.xy;
		OUT.TexCoord.z = 0;
		OUT.Color = IN.Color;
	}

	OUT.Color.a = OUT.Color.a * opacity;

	return OUT;	
}

#define NO_TEXTURE			0
#define USE_TEXTURE			1
#define USE_TEXTURE_ARRAY	2
#define USE_TEXTURE_FONT	3

float4 ps_main2(VS_OUT IN, uniform int textureType, uniform SamplerState sm) : SV_TARGET0
{
	if(textureType > NO_TEXTURE)
	{
		float4 diffuse;// = float4(1, 1, 0, 1);
		
		if(textureType == USE_TEXTURE_ARRAY)
		{
			diffuse = mapTexArray.Sample(sm, IN.TexCoord.xyz).rrrg;

			if(fontBlurColor.a > 0)
			{
				float3 color = lerp(fontBlurColor.rgb, IN.Color.rgb, diffuse.a);

				color = pow(color, gamma) * intensity;

				return float4(color, saturate(diffuse.r * IN.Color.a * 1.5));
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

					color = pow(color, gamma) * intensity;

					return float4(color, saturate(diffuse.r * IN.Color.a * 1.5));
				}
			}
			else
			{
				diffuse = mapTex.Sample(sm, IN.TexCoord.xy);
			}
		}

		float4 color = diffuse * IN.Color;

		color.rgb = pow(color.rgb, gamma) * intensity;
		
		return color;
	}

	float4 color = IN.Color;

	color.rgb = pow(color.rgb, gamma) * intensity;

	return color;
}

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

VertexShader	vsSimple				= CompileShader(vs_4_0, vs_main());

PixelShader		psSimple				= CompileShader(ps_4_0, ps_main2(NO_TEXTURE			, texSampler));
PixelShader		psTex					= CompileShader(ps_4_0, ps_main2(USE_TEXTURE		, texSampler));
PixelShader		psTexUser				= CompileShader(ps_4_0, ps_main2(USE_TEXTURE		, userTexSampler));
PixelShader		psTexArray				= CompileShader(ps_4_0, ps_main2(USE_TEXTURE_ARRAY	, texSampler));
PixelShader		psTexArrayUser			= CompileShader(ps_4_0, ps_main2(USE_TEXTURE_ARRAY	, userTexSampler));
PixelShader		psTexUserAnisotropic	= CompileShader(ps_4_0, ps_main2(USE_TEXTURE		, userTexSamplerAnisotropic));
PixelShader		psTexFont				= CompileShader(ps_4_0, ps_main2(USE_TEXTURE_FONT	, texSampler));

#define SET_SHADERS(vs,ps)  SetVertexShader(vs); SetGeometryShader(NULL); SetPixelShader(ps)

// для нормального пасса
#define SET_PASS(name, vs, ps, dsState, blState)  pass name { SET_SHADERS(vs,ps); SetDepthStencilState(dsState, 1); \
		SetBlendState(blState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); SetRasterizerState(cullNone); }

technique10 Standart
{	
	SET_PASS(simple					, vsSimple	, psSimple				, depthState			, blendState	)
	SET_PASS(tex					, vsSimple	, psTex					, depthState			, blendState	)
	SET_PASS(texUser				, vsSimple	, psTexUser				, depthState			, blendState	)
	SET_PASS(array					, vsSimple	, psTexArray			, depthState			, blendState	)
	SET_PASS(arrayUser				, vsSimple	, psTexArrayUser		, depthState			, blendState	)
	SET_PASS(texUserAnisotropic		, vsSimple	, psTexUserAnisotropic	, depthState			, blendState	)
	SET_PASS(texFont				, vsSimple	, psTexFont				, depthState			, blendState	)
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
}
