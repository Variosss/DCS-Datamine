#include "ParticleSystem2/common/clusterCommon.hlsl"

float3 effectParams;
float3 smokeColor;

#define CLUSTER_COLOR			smokeColor.xyz
#define CLUSTER_TRANSLUCENCY 	effectParams.x
#define CLUSTER_DETAIL_TILE		effectParams.y
#define CLUSTER_DETAIL_SPEED	effectParams.z
// #define NO_DETAIL_TEX
#define CLUSTER_GLOW_COLOR		float3(1.000000, 0.576470613, 0.13333334)
#define CLUSTER_GLOW_COLOR_COLD	float3(1.000000, 0.305882365, 0.11372549)
#define CLUSTER_GLOW_ADDITIVENESS 1
#define CLUSTER_GLOW_BRIGHTNESS 3
#include "ParticleSystem2/common/clusterShading.hlsl"
