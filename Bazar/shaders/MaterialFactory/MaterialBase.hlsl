#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/DiffuseTerm.hlsl"
#include "common/TextureSamplers.hlsl"
#include "common/context.hlsl"
#include "enlight/materialParams.hlsl"
#include "common/fog.hlsl"

Texture2D DiffuseMap;
Texture2D uLightMap;

float4x4 matWorldViewProj;
float4x4 matWorld;

// Sun light source params
float4 uSunDir;
float4 uSunDiffuse;

float4 uCameraPos;

bool TwoSided;

float uOpacity;
float uGloss;
float uLighted;

//material
float4 uMatSpecular;
float4 uMatEmissive;
float4 uMatDiffuse;
float4 uMatAmbient;

#ifdef FLAT_MATERIAL
#include "flat.hlsl"
#endif

#ifdef LASERBEAM_MATERIAL
#include "laserbeam.hlsl"
#endif

#ifdef MFD_MATERIAL
#ifdef NO_MANUAL_Z_FOR_HUD
#include "mfd151.hlsl"
#else
#include "mfd.hlsl"
#endif
#endif

#ifdef ILS_MATERIAL
#ifdef NO_MANUAL_Z_FOR_HUD
#include "ils151.hlsl"
#else
#include "ils.hlsl"
#endif
#endif

#ifdef GE_MATERIAL
#include "gematerial.hlsl"
#endif

#ifdef SPARKBURST_MATERIAL
#include "sparkburst.hlsl"
#endif

#ifdef DEBUG_MATERIAL
#include "dbg.hlsl"
#endif

#ifdef STANDARD_MATERIAL
#include "standard.hlsl"
#endif

#ifdef STANDART_EFFECT_MATERIAL
#include "effectmaterial.hlsl"
#endif

#ifdef LRLS_SPOT
#include "LRLS_spot.hlsl"
#endif