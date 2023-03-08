#ifndef STATES11_HLSL
#define STATES11_HLSL

// Cтандартные стейты для DirectX11, чтоб не разводить копипасту

/**
 * Blend States
 */

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

#ifdef USE_DCS_DEFERRED

BlendState shadowAlphaBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = ONE;
	DestBlend = ONE;
	BlendOp = MIN;
	SrcBlendAlpha = ZERO;
	DestBlendAlpha = ONE;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

#define enableFlatShadowAlphaBlend shadowAlphaBlend

#else

BlendState enableFlatShadowAlphaBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = DEST_COLOR;
	DestBlend = ZERO;
	BlendOp = ADD;
	SrcBlendAlpha = DEST_ALPHA;
	DestBlendAlpha = ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

#endif


BlendState enableAlphaBlendWriteMaskAlpha
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = ONE;
	DestBlendAlpha = INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x08; //ALPHA
};

BlendState enableAlphaBlendWriteMaskRGB
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x07; //RED | GREEN | BLUE;
};

BlendState additiveAlphaBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = ONE;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = ONE;//ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

BlendState disableAlphaBlend
{
	BlendEnable[0] = FALSE;
	BlendEnable[1] = FALSE;
};

BlendState disableAlphaBlendWriteMaskAlpha
{
	BlendEnable[0] = FALSE;
	BlendEnable[1] = FALSE;
	RenderTargetWriteMask[0] = 0x08; //ALPHA
};

BlendState disableColorOutput
{
	BlendEnable[0] = FALSE;
	BlendEnable[1] = FALSE;
	RenderTargetWriteMask[0] = 0x00;
};

BlendState enableAlphaToCoverage
{
	BlendEnable[0] = FALSE;
	BlendEnable[1] = FALSE;
	AlphaToCoverageEnable = TRUE;
};

/**
 * Rasterizer State
 */
RasterizerState cullFront
{
	CullMode = Front;
	FillMode = Solid;
	MultisampleEnable = FALSE;
};

RasterizerState cullBack
{
	CullMode = Back;
	FillMode = Solid;
	MultisampleEnable = FALSE;
};

RasterizerState cullNone
{
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = FALSE;
};

RasterizerState wireframe
{
	CullMode = None;
	FillMode = Wireframe;
	MultisampleEnable = FALSE;
};

RasterizerState rasterizerStateFlatShadow {
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = TRUE;
	DepthBias = 200.0;
	SlopeScaledDepthBias = 0.0;
};

/**
 *  Macro for rasterizer state.
 * Now depth buffer created with UNORM format.
 * Result name of rasterizer state will be "RasterizerState##cullMode"
 * see how depthbias in DX11 working with UNORM format
*/
#define RASTERIZER_STATE(cullMode, depthBias) RasterizerState RasterizerState##cullMode\
{\
	CullMode = cullMode;\
	FillMode = Solid;\
	MultisampleEnable = FALSE;\
	DepthBias = depthBias;\
};

/**
 * Depth Stencil States
 */

#ifndef DEPTH_FUNC
#if !defined(EDGE) || defined(USE_INVERSE_PROJ)
#define DEPTH_FUNC GREATER_EQUAL
#else
#define DEPTH_FUNC LESS_EQUAL
#endif
#endif

 DepthStencilState enableDepthBuffer
{
	DepthEnable        = TRUE;
	DepthWriteMask     = ALL;
	DepthFunc          = DEPTH_FUNC;

	StencilEnable      = FALSE;
	StencilReadMask    = 0;
	StencilWriteMask   = 0;
};

DepthStencilState enableDepthBufferNoWrite
{
	DepthEnable        = TRUE;
	DepthWriteMask     = ZERO;
	DepthFunc          = DEPTH_FUNC;

	StencilEnable      = FALSE;
	StencilReadMask    = 0;
	StencilWriteMask   = 0;
};

DepthStencilState disableDepthBuffer
{
	DepthEnable        = FALSE;
	DepthWriteMask     = ZERO;
	DepthFunc          = DEPTH_FUNC;

	StencilEnable      = FALSE;
	StencilReadMask    = 0;
	StencilWriteMask   = 0;
};

DepthStencilState alwaysDepthBuffer
{
	DepthEnable        = TRUE;
	DepthWriteMask     = ALL;
	DepthFunc          = ALWAYS;

	StencilEnable      = FALSE;
	StencilReadMask    = 0;
	StencilWriteMask   = 0;
};

/**
 * Depth Stencil States with stencil buffer enabled
 * If you use some bit of stencil buffer, write it here:
 *
 * 0 - flat shadows for blocks (blockFlatShadowsState)
 * 1 - unused
 * 2 - unused
 * 3 - unused
 * 4 - unused
 * 5 - unused
 * 6 - unused
 * 7 - unused
 */
DepthStencilState blockFlatShadowsState
{
	DepthEnable          = TRUE;
	DepthWriteMask       = ZERO;
	DepthFunc            = DEPTH_FUNC;

	StencilEnable        = TRUE;
	StencilReadMask      = 1;
	StencilWriteMask     = 1;

	FrontFaceStencilFunc = NOT_EQUAL;
	FrontFaceStencilPass = REPLACE;
	FrontFaceStencilFail = KEEP;

	BackFaceStencilFunc  = NOT_EQUAL;
	BackFaceStencilPass  = REPLACE;
	BackFaceStencilFail  = KEEP;
};

#define TECHNIQUE technique11

#define VERTEX_SHADER(name) SetVertexShader(CompileShader(vs_5_0, name));
#define PIXEL_SHADER(name) SetPixelShader(CompileShader(ps_5_0, name));

typedef VertexShader VertexShader_t;
typedef PixelShader PixelShader_t;

#define COMPILE_VERTEX_SHADER(name) CompileShader(vs_5_0, name)
#define COMPILE_PIXEL_SHADER(name) CompileShader(ps_5_0, name)

#define COMPILED_VERTEX_SHADER(var) SetVertexShader(var);
#define COMPILED_PIXEL_SHADER(var) SetPixelShader(var);

#define GEOMETRY_SHADER(name) SetGeometryShader(CompileShader(gs_4_0, name));
#define GEOMETRY_SHADER_PLUG SetGeometryShader(NULL);

#define DISABLE_ALPHA_BLEND SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF)
#define DISABLE_ALPHA_BLEND_WRITE_MASK_ALPHA SetBlendState(disableAlphaBlendWriteMaskAlpha, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF)
#define ENABLE_ALPHA_BLEND  SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF)

#define ADDITIVE_ALPHA_BLEND SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF)
#define FLAT_SHADOW_ALPHA_BLEND SetBlendState(enableFlatShadowAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF)
#define DISABLE_COLOR_OUTPUT SetBlendState(disableColorOutput, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF)

#define DISABLE_CULLING SetRasterizerState(cullNone)
#define FRONT_CULLING SetRasterizerState(cullFront)
#define BACK_CULLING SetRasterizerState(cullBack)

#define ENABLE_DEPTH_BUFFER SetDepthStencilState(enableDepthBuffer, 0)
#define ENABLE_RO_DEPTH_BUFFER SetDepthStencilState(enableDepthBufferNoWrite, 0)
#define DISABLE_DEPTH_BUFFER SetDepthStencilState(disableDepthBuffer, 0)

#ifdef USE_DCS_DEFERRED
	#ifdef MSAA
		#define ENABLE_FLAT_SHADOW_DEPTH_BUFFER SetDepthStencilState(disableDepthBuffer, 0)
	#else
		#define ENABLE_FLAT_SHADOW_DEPTH_BUFFER SetDepthStencilState(enableDepthBufferNoWrite, 0)
	#endif
#else
	#define ENABLE_FLAT_SHADOW_DEPTH_BUFFER SetDepthStencilState(blockFlatShadowsState, 1)
#endif

RasterizerState _RASTER_STATE_NO_CULLING_NO_BIAS{
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = FALSE;
	DepthBias = 0.0;
};

#define SET_RASTER_STATE_NO_CULLING_NO_BIAS SetRasterizerState(_RASTER_STATE_NO_CULLING_NO_BIAS)

RasterizerState _RASTER_STATE_FRONT_CULLING_NO_BIAS{
	CullMode = Front;
	FillMode = Solid;
	MultisampleEnable = FALSE;
	DepthBias = 0.0;
};

#define SET_RASTER_STATE_FRONT_CULLING_NO_BIAS SetRasterizerState(_RASTER_STATE_FRONT_CULLING_NO_BIAS)

#endif
