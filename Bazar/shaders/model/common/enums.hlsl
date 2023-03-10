#ifndef MODEL_ENUMS_HLSL
#define MODEL_ENUMS_HLSL

//shading models
#define SHADING_STANDARD	0
#define SHADING_GLASS		1
#define SHADING_EMISSIVE	2

static const int F_DISABLE_SHADOWMAP	= 1 << 0;
static const int F_COCKPIT_GI			= 1 << 1;
static const int F_IN_COCKPIT			= 1 << 2;
static const int F_SELECTED_OBJECT		= 1 << 3;

static const int F_GLASS_DROPLETS		= 1 << 2;
static const int F_GLASS_ICING			= 1 << 3;
static const int F_GLASS_FOGGING		= 1 << 4;

#define BM_NONE					0
#define	BM_TRANSPARENT			1
#define	BM_ALPHA_TEST			2
#define	BM_ADDITIVE				3
#define	BM_DECAL				4
#define	BM_DECAL_DEFERRED		5
#define	BM_SHADOWED_TRANSPARENT	6

#endif
