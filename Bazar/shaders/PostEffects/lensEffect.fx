#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "deferred/deferredCommon.hlsl"

Texture2D DiffuseMap;
Texture2D dirtTex;
Texture2D ghostTex;
Texture2D sunTex;
Texture2D bloomMap;

float4 viewport;// = {0,0,1,1};
float3 sunPosScreen;//ub, viewport aspect

struct LensData { float2 params; };
StructuredBuffer<LensData> lensData;

struct GhostParams { float3	coefs; };//x - distCoef; y - scale
StructuredBuffer<GhostParams> sbGhosts;

#define sbShadow			lensData[0].params.x //текущая затененость камеры
#define sbSunlightSmooth	lensData[0].params.y //освещенность
#define sunColor			gSunDiffuse.xyz
#define sunDirV				gSunDirV.xyz
#define viewportAspect		sunPosScreen.z

struct PS_INPUT_COPY
{
	noperspective float4 vPosition	:SV_POSITION;
	noperspective float4 vTexCoords	:TEXCOORD0;
	noperspective float3 wPos		:TEXCOORD1;
};

//-------------------------------------------

float3 getHDRcolor(in float3 clr, in float2 coord, in float dotSun)
{
	float2 vDist = sunPosScreen.xy-coord;
	vDist.x *= viewportAspect;
	float dist = pow(1-min(1, length(vDist)*0.555555), 2) * mad(sbShadow,0.5,0.5) * max(0, mad(dotSun,0.6,0.3));
	
	return pow(clr*1.05,2) * float3(1.0,0.9,0.8) * (1-dist*gSunDiffuse.r) + dist * gSunDiffuse;
}

PS_INPUT_COPY vsCopy(in float2 pos: POSITION0)
{
	PS_INPUT_COPY res;
	float4 Pos = mul(float4(pos.x, pos.y, 1, 1), gProjInv);
	res.wPos = Pos.xyz/Pos.w;
	
	res.vPosition = float4(pos.xy, 0, 1);
	res.vTexCoords.xy = (float2(pos.x, -pos.y)*0.5+0.5)*viewport.zw + viewport.xy;
	res.vTexCoords.zw = float2(pos.x, pos.y);
	return res;
}

float4 psCopy(in PS_INPUT_COPY v): SV_TARGET0 
{
	return DiffuseMap.Sample(gBilinearClampSampler, v.vTexCoords.xy);
}

#include "lensDirt.hlsl"
#include "lensGhosts.hlsl"

#define PASS_BODY(vs, ps, blend) { SetVertexShader(CompileShader(vs_4_0, vs)); SetGeometryShader(NULL); SetPixelShader(CompileShader(ps_4_0, ps)); \
	SetDepthStencilState(disableDepthBuffer, 0); \
	SetBlendState(blend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
	SetRasterizerState(cullNone);}

technique10 lensTech 
{
	pass Copy	PASS_BODY(vsCopy(),		psCopy(),	disableAlphaBlend)
	pass Dirt	PASS_BODY(vsDirt(),		psDirt(),	disableAlphaBlend)
	pass Ghosts	PASS_BODY(vsGhost(),	psGhost(),	aberrationBlend)
	pass Sun	PASS_BODY(vsSun(),		psSun(),	additiveAlphaBlend)
}
