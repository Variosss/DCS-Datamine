#ifndef _stencil_hlsl
#define _stencil_hlsl

#define STENCIL_COMPOSITION_MASK_SHIFT	3 //пропускаем биты, занятые землей

//маска для проверки типа композинга
#define STENCIL_COMPOSITION_MASK		(7 << STENCIL_COMPOSITION_MASK_SHIFT)

//типы композинга
#define STENCIL_COMPOSITION_SURFACE		(0 << STENCIL_COMPOSITION_MASK_SHIFT)
#define STENCIL_COMPOSITION_MODEL		(1 << STENCIL_COMPOSITION_MASK_SHIFT)
#define STENCIL_COMPOSITION_WATER		(2 << STENCIL_COMPOSITION_MASK_SHIFT)
#define STENCIL_COMPOSITION_GRASS		(3 << STENCIL_COMPOSITION_MASK_SHIFT)
#define STENCIL_COMPOSITION_FOLIAGE		(4 << STENCIL_COMPOSITION_MASK_SHIFT)
#define STENCIL_COMPOSITION_COCKPIT		(5 << STENCIL_COMPOSITION_MASK_SHIFT)
#define STENCIL_COMPOSITION_UNDERWATER		(6 << STENCIL_COMPOSITION_MASK_SHIFT)

#define STENCIL_COMPOSITION_EMPTY		(7 << STENCIL_COMPOSITION_MASK_SHIFT)

#define STENCIL_SELECTED_OBJECT			(8 << STENCIL_COMPOSITION_MASK_SHIFT)	// selected object bit

// применять статические тени
#define STENCIL_SURFACE_SHADOW_RECEIVER     4

//вставка в DepthStencilState для записи типа материала в стенсиль
#define WRITE_COMPOSITION_TYPE_TO_STENCIL StencilEnable=true; \
	StencilWriteMask = STENCIL_COMPOSITION_MASK | STENCIL_SELECTED_OBJECT; \
	FrontFaceStencilFunc = ALWAYS; \
	FrontFaceStencilPass = REPLACE; \
	BackFaceStencilFunc = ALWAYS; \
	BackFaceStencilPass = REPLACE

//вставка в DepthStencilState для тестирования типа материала по стенсилю
#define	TEST_COMPOSITION_TYPE_IN_STENCIL	StencilEnable = true; \
	StencilReadMask = STENCIL_COMPOSITION_MASK; \
	FrontFaceStencilFunc = EQUAL; \
	FrontFaceStencilPass = KEEP; \
	FrontFaceStencilFail = KEEP; \
	BackFaceStencilFunc = EQUAL; \
	BackFaceStencilPass = KEEP; \
	BackFaceStencilFail = KEEP


DepthStencilState enableDepthBufferNoWriteClipCockpit {
	DepthEnable = TRUE;
	DepthWriteMask = ZERO;
	DepthFunc = GREATER_EQUAL;

	StencilEnable = TRUE;
	StencilReadMask = STENCIL_COMPOSITION_COCKPIT;
	StencilWriteMask = 0;

	FrontFaceStencilFunc = NOT_EQUAL;
	FrontFaceStencilPass = KEEP;
	FrontFaceStencilFail = KEEP;
	BackFaceStencilFunc = NOT_EQUAL;
	BackFaceStencilPass = KEEP;
	BackFaceStencilFail = KEEP;
};

#define ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT SetDepthStencilState(enableDepthBufferNoWriteClipCockpit, STENCIL_COMPOSITION_COCKPIT)


#endif
