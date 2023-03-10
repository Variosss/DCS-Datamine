#ifndef ED_MODEL_SHADER_MACROSES_HLSL
#define ED_MODEL_SHADER_MACROSES_HLSL

#include "common/enums.hlsl"

#include "common/stencil.hlsl"
#include "common/states11.hlsl"

// composition type write mask
#define WRITE_COMPOSITION_TYPE_TO_STENCIL_NO_FLAT_SHADOWS StencilEnable=true; \
	StencilWriteMask = STENCIL_COMPOSITION_MASK | STENCIL_SELECTED_OBJECT | 1; \
	FrontFaceStencilFunc = ALWAYS; \
	FrontFaceStencilPass = REPLACE; \
	BackFaceStencilFunc = ALWAYS; \
	BackFaceStencilPass = REPLACE


DepthStencilState enableDepthBufferCP
{
	DepthEnable        = TRUE;
	DepthWriteMask     = ALL;
	DepthFunc          = DEPTH_FUNC;

	WRITE_COMPOSITION_TYPE_TO_STENCIL_NO_FLAT_SHADOWS;
};
DepthStencilState enableDepthBufferNoWriteCP
{
	DepthEnable        = TRUE;
	DepthWriteMask     = ZERO;
	DepthFunc          = DEPTH_FUNC;
	WRITE_COMPOSITION_TYPE_TO_STENCIL_NO_FLAT_SHADOWS;
};
DepthStencilState disableDepthBufferCP
{
	DepthEnable        = FALSE;
	DepthWriteMask     = ZERO;
	DepthFunc          = DEPTH_FUNC;
	WRITE_COMPOSITION_TYPE_TO_STENCIL_NO_FLAT_SHADOWS;
};

#undef	ENABLE_DEPTH_BUFFER
#define ENABLE_DEPTH_BUFFER				SetDepthStencilState(enableDepthBufferCP, STENCIL_COMPOSITION_MODEL | 1)
#define ENABLE_DEPTH_BUFFER_SELECTED	SetDepthStencilState(enableDepthBufferCP, STENCIL_COMPOSITION_MODEL | STENCIL_SELECTED_OBJECT | 1)
#define ENABLE_DEPTH_BUFFER_COCKPIT		SetDepthStencilState(enableDepthBufferCP, STENCIL_COMPOSITION_COCKPIT)
#undef	ENABLE_RO_DEPTH_BUFFER
#define ENABLE_RO_DEPTH_BUFFER			SetDepthStencilState(enableDepthBufferNoWriteCP, STENCIL_COMPOSITION_MODEL | 1)
#define ENABLE_RO_DEPTH_BUFFER_COCKPIT	SetDepthStencilState(enableDepthBufferNoWriteCP, STENCIL_COMPOSITION_COCKPIT)
#undef	DISABLE_DEPTH_BUFFER
#define DISABLE_DEPTH_BUFFER			SetDepthStencilState(disableDepthBufferCP, STENCIL_COMPOSITION_MODEL | 1)
#define DISABLE_DEPTH_BUFFER_COCKPIT	SetDepthStencilState(disableDepthBufferCP, STENCIL_COMPOSITION_COCKPIT)

BlendState enableDecalBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	BlendEnable[2] = TRUE;
	BlendEnable[3] = TRUE;
	BlendEnable[4] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
	RenderTargetWriteMask[5] = 0;
};

#define ENABLE_DECAL_BLEND  SetBlendState(enableDecalBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF)

#if defined(DIFFUSE_UV) && (BLEND_MODE == BM_ALPHA_TEST || BLEND_MODE == BM_TRANSPARENT) || DAMAGE_UV //если пиксельный шейдер вообще нужен - сетим
#define SHADOW_WITH_ALPHA_TEST
#endif

#if BLEND_MODE == BM_NONE
	#define BLEND_STATE		DISABLE_ALPHA_BLEND
	#define DEPTH_STATE		ENABLE_DEPTH_BUFFER
	#define DEPTH_STATE_COCKPIT	ENABLE_DEPTH_BUFFER_COCKPIT
#elif BLEND_MODE == BM_ALPHA_TEST
	#define BLEND_STATE		SetBlendState(enableAlphaToCoverage, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF)
	#define DEPTH_STATE		ENABLE_DEPTH_BUFFER
	#define DEPTH_STATE_COCKPIT	ENABLE_DEPTH_BUFFER_COCKPIT
#elif BLEND_MODE == BM_TRANSPARENT || BLEND_MODE == BM_SHADOWED_TRANSPARENT
	#define BLEND_STATE		ENABLE_ALPHA_BLEND
	#define DEPTH_STATE		ENABLE_RO_DEPTH_BUFFER
	#define DEPTH_STATE_COCKPIT	ENABLE_RO_DEPTH_BUFFER_COCKPIT
#elif BLEND_MODE == BM_ADDITIVE
	#define BLEND_STATE		ADDITIVE_ALPHA_BLEND
	#define DEPTH_STATE		ENABLE_RO_DEPTH_BUFFER
	#define DEPTH_STATE_COCKPIT	ENABLE_RO_DEPTH_BUFFER_COCKPIT
#elif BLEND_MODE == BM_DECAL
	#define BLEND_STATE		ENABLE_DECAL_BLEND
	#define DEPTH_STATE		ENABLE_RO_DEPTH_BUFFER
	#define DEPTH_STATE_COCKPIT	ENABLE_RO_DEPTH_BUFFER_COCKPIT
#elif BLEND_MODE == BM_DECAL_DEFERRED
	#define BLEND_STATE		ENABLE_DECAL_BLEND
	#define DEPTH_STATE		ENABLE_RO_DEPTH_BUFFER
	#define DEPTH_STATE_COCKPIT	ENABLE_RO_DEPTH_BUFFER_COCKPIT
#else
	#define BLEND_STATE		DISABLE_ALPHA_BLEND
	#define DEPTH_STATE		DISABLE_DEPTH_BUFFER
	#define DEPTH_STATE_COCKPIT	DISABLE_DEPTH_BUFFER_COCKPIT
#endif

#define PASS_BODY(vs, ps, blendState, depthState) { \
	COMPILED_VERTEX_SHADER(vs) \
	COMPILED_PIXEL_SHADER(ps) \
	GEOMETRY_SHADER_PLUG \
	SET_RASTER_STATE; \
	blendState; \
	depthState;}

#define TECH_NAME_GEN(a, b) TECHNIQUE a##b

#ifdef DIFFUSE_UV
#define GET_DIFFUSE_UV(input) (input.DIFFUSE_UV.xy)
#elif defined(COLOR0_SIZE)
#define GET_DIFFUSE_UV(input) (input.color)
#else
#define GET_DIFFUSE_UV(input) float2(0, 0)
#endif

#endif
