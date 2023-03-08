#ifndef _common_samplers11_hlsl
#define _common_samplers11_hlsl

#ifndef MAXANISOTROPY_DEFAULT
#define MAXANISOTROPY_DEFAULT 16
#endif

#if 1 || !defined(EDGE) 
	#define USE_SAMPLERSTATEPOOL

	//general purpose
	SamplerState gAnisotropicWrapSampler:	register(s15);
	SamplerState gAnisotropicClampSampler:	register(s14);
	SamplerState gTrilinearWrapSampler:		register(s13);
	SamplerState gTrilinearClampSampler:	register(s12);
	SamplerState gBilinearWrapSampler: 		register(s11);
	SamplerState gBilinearClampSampler:		register(s10);
	SamplerState gPointWrapSampler: 		register(s9);
	SamplerState gPointClampSampler:		register(s8);

	//shadows, lightmap
	SamplerComparisonState gCascadeShadowSampler: 	register(s7);
	SamplerState gTrilinearWhiteBorderSampler:	register(s6);
	SamplerState gTrilinearBlackBorderSampler:	register(s5);

	#define gCloudsShadowSampler	gTrilinearWhiteBorderSampler

	#define WrapSampler			gAnisotropicWrapSampler
	#define WrapLinearSampler	gTrilinearWrapSampler
	#define ClampSampler		gAnisotropicClampSampler
	#define ClampLinearSampler	gTrilinearClampSampler
	
	#define WrapPointSampler	gPointWrapSampler
	#define ClampPointSampler	gPointClampSampler
	
	#define WhiteBorderLinearSampler gTrilinearWhiteBorderSampler

	#define LightMapSampler gTrilinearBlackBorderSampler

#else
SamplerState WrapSampler
{
	Filter        = ANISOTROPIC;
	AddressU      = WRAP;
	AddressV      = WRAP;
	AddressW      = WRAP;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};
SamplerState ClampSampler
{
	Filter        = ANISOTROPIC;
	AddressU      = CLAMP;
	AddressV      = CLAMP;
	AddressW      = CLAMP;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};


SamplerState WrapLinearSampler
{
	Filter        = MIN_MAG_MIP_LINEAR;
	AddressU      = WRAP;
	AddressV      = WRAP;
	AddressW      = WRAP;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};

SamplerState ClampLinearSampler
{
	Filter        = MIN_MAG_MIP_LINEAR;
	AddressU      = CLAMP;
	AddressV      = CLAMP;
	AddressW      = CLAMP;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};

SamplerState WrapPointSampler
{
	Filter        = MIN_MAG_MIP_POINT;
	AddressU      = WRAP;
	AddressV      = WRAP;
	AddressW      = WRAP;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};

SamplerState ClampPointSampler
{
	Filter        = MIN_MAG_MIP_POINT;
	AddressU      = CLAMP;
	AddressV      = CLAMP;
	AddressW      = CLAMP;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};

SamplerState WhiteBorderLinearSampler
{
	Filter        = MIN_MAG_MIP_LINEAR;
	AddressU      = BORDER;
	AddressV      = BORDER;
	AddressW      = BORDER;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(1.0, 1.0, 1.0, 1.0);
};

SamplerState LightMapSampler
{
	Filter        = MIN_MAG_MIP_LINEAR;
	AddressU      = BORDER;
	AddressV      = BORDER;
	AddressW      = BORDER;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};

#endif

#endif
