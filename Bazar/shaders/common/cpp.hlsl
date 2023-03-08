#ifndef CPP_HLSL
#define CPP_HLSL

#ifdef __cplusplus

	#define IN 
	#define INOUT(type)		type &
#ifdef OUT
#undef OUT
	#define OUT(type)		type &
#endif
	#define uniform

	#define ROLL				
	#define UNROLL
	#define BRANCH
	#define FLATTEN

	#define _SV_POSITION(n)
	#define _SV_TARGET(n)
	#define _TEXCOORD(n)
	#define _POSITION(n)
	#define _NORMAL(n)
	#define _COLOR(n)

	#define _SV_VERTEXID

#else

	#define ROLL			[roll]
	#define UNROLL			[unroll]
	#define BRANCH			[branch]
	#define FLATTEN			[flatten]
	#define TTexture1D		Texture1D
	#define TTexture2D		Texture2D
	#define TTexture3D		Texture3D
	#define TTexture2DArray	Texture2DArray
	#define TTexture3DArray	Texture3DArray 

	#define _SV_POSITION(n)	: SV_POSITION##n
	#define _SV_TARGET(n)	: SV_TARGET##n
	#define _TEXCOORD(n)	: TEXCOORD##n
	#define _POSITION(n)	: POSITION##n
	#define _NORMAL(n)		: NORMAL##n
	#define _COLOR(n)		: COLOR##n

	#define _SV_VERTEXID	: SV_VertexID

	#define INOUT(type) 	inout type
	#define OUT(type) 		out type
    #define IN              in    

#endif



#endif
