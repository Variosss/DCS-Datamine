#include "ParticleSystem2/common/clusterCommon.hlsl"

float4 effectParams;//emitter time, phase, wind.xy
float3 effectParams2;//translusency
float3 smokeColor;
float transparent;


#if USE_DRAW_COLUD_ID
	static const float3 clr[6] = { { 1,0,0 },{ 0,1,0 },{ 0,0,1 },{ 1,1,0 },{ 0,1,1 },{ 1,0,1 } };
	#define CLUSTER_COLOR			(clr[atmosphereSamplesId.x % 6])
#else
	#define CLUSTER_COLOR			smokeColor.xyz
#endif

#define CLUSTER_TRANSLUCENCY 	effectParams2.x*0.7
#define CLUSTER_AMBIENT_COLOR	AmbientTop*0.25

#define CLUSTER_DETAIL_TILE		effectParams2.y*2
#define CLUSTER_DETAIL_SPEED	effectParams2.z*0.1
#define ANIMATION_SPEED			0
#define PARTICLE_ROTATE_SPEED	0.02
#define CLUSTER_RESULT_OPACITY	transparent

#define CLIP_COCKPIT
// #define NO_DETAIL_TEX
#define CLUSTER_GLOW_COLOR		float3(1.000000, 0.694118, 0.262745)

#define getTextureFrameUV		getTextureFrameUV6x6

#include "ParticleSystem2/common/clusterShading.hlsl"
