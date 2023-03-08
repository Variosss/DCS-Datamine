/*
Задефайнить обязательно:
CLUSTER_COLOR			- цвет партикла

опционально:
CLUSTER_GLOW_COLOR			- включает свечение партиклов и указывает цвет вспышки
CLUSTER_GLOW_COLOR_COLD		- второй цвет свечения для низкой температуры, плавно лерпается в CLUSTER_GLOW_COLOR
CLUSTER_GLOW_ADDITIVENESS	- от 0 до 1 степерь аддитивности свечения
CLUSTER_TRANSLUCENCY		- пропускание света партиклом
CLUSTER_DETAIL_TILE			- тайлинг детальной текстуры
CLUSTER_DETAIL_SPEED		- скорость скролирования детальной текстуры
CLUSTER_GLOW_BRIGHTNESS 	- яркость свечения
CLUSTER_RESULT_OPACITY		- множитель к финальной прозрачности патрикла
ANIMATION_SPEED				- скорость анимации партикла, кадров/сек
NO_DETAIL_TEX				- отключает деталеровку шумовой текстурой
SOFT_PARTICLES				- софт пакртиклы
*/

#include "common/dithering.hlsl"
#include "common/stencil.hlsl"
#include "common/random.hlsl"

#ifdef SOFT_PARTICLES
	#include "common/softParticles.hlsl"
#endif

// #define DEBUG_OPAQUE
// #define DEBUG_CLUSTER_LIGHT
// #define DEBUG_NO_AMBIENT_LIGHT
// #define DEBUG_NO_NORMALS
// #define DEBUG_OUTPUT_TEMP

// #define USE_TEX_ARRAY

#ifndef CLUSTER_COLOR
#error CLUSTER_COLOR should be defined
#endif

#ifndef CLUSTER_TRANSLUCENCY
#define CLUSTER_TRANSLUCENCY	0.0
#endif

#ifndef CLUSTER_DETAIL_TILE
#define CLUSTER_DETAIL_TILE		0.2
#endif

#ifndef CLUSTER_DETAIL_SPEED
#define CLUSTER_DETAIL_SPEED	0.1
#endif

#ifndef NO_DETAIL_TEX
#define	DETAIL_TEX
#endif

#ifndef getTextureFrameUV
#define getTextureFrameUV		getTextureFrameUV16x8
#endif

#ifndef ANIMATION_SPEED
#define ANIMATION_SPEED			25
#endif

#ifndef PARTICLE_ROTATE_SPEED
#define PARTICLE_ROTATE_SPEED	0.1
#endif

#ifndef CLUSTER_AMBIENT_COLOR
#define CLUSTER_AMBIENT_COLOR	AmbientAverage
#endif

#ifndef CLUSTER_RESULT_OPACITY
#define CLUSTER_RESULT_OPACITY	1
#endif

#ifndef CLUSTER_GLOW_BRIGHTNESS
	#ifdef CLUSTER_GLOW_COLOR
		#define CLUSTER_GLOW_BRIGHTNESS	10.0
	#else
		#define CLUSTER_GLOW_BRIGHTNESS 0.0
	#endif
#endif

#ifndef CLUSTER_GLOW_ADDITIVENESS
#define CLUSTER_GLOW_ADDITIVENESS 0.0
#endif

float4			detailParams;// = {0, 0, 1, 1};
Texture2D		detailTex;
#ifdef USE_TEX_ARRAY
Texture2DArray	texArray;
#endif

#ifndef CLUSTER_CUSTOM_VS_NAME

	#ifdef USE_VERTEX_BUFFER
	VS_OUTPUT vsClusterDefault(in VS_INPUT i)
	{
		VS_OUTPUT o;
		o.posRadius = i.posRadius;
		o.posRadius.xyz += worldOffset;
		o.sizeLifeOpacityRnd = i.sizeLifeOpacityRnd;
		o.clusterLight = i.clusterLight;
		return o;
	}
	#else
	VS_OUTPUT vsClusterDefault(in uint vertId: SV_VertexId)
	{
		VS_OUTPUT o;
		o.vertId = sbSortedIndices[vertId];
		const CLUSTER_STRUCT i = sbParticles[o.vertId];
		o.posRadius = i.posRadius;
		o.posRadius.xyz += worldOffset;
		o.sizeLifeOpacityRnd = i.sizeLifeOpacityRnd;
		o.clusterLight.xyz = i.clusterLight;
	#ifdef CLUSTER_WORLD_NORMAL
		o.worldNormal = i.reserved.xyz;
	#endif
		return o;
	}
	#endif
	
#endif

#if PARTICLES_IN_CLUSTER>1

// HULL SHADER ---------------------------------------------------------------------
HS_CONST_OUTPUT hsClusterConstant( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o;
	o.edges[1] = PARTICLES_IN_CLUSTER-1;
	o.edges[0] = 1;
	o.octantId.x = getNearestOctant( ip[0].posRadius.xyz, sbParticles[ip[0].vertId].mToWorld );
	// o.octantId.x = getNearestOctant(ip[0].posRadius.xyz);
	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("hsClusterConstant")]
HS_OUTPUT hsCluster( InputPatch<VS_OUTPUT, 1> ip, uint cpid : SV_OutputControlPointID)
{
	HS_OUTPUT o;
	o.posRadius = ip[0].posRadius;
	o.sizeLifeOpacityRnd = ip[0].sizeLifeOpacityRnd;
	o.clusterLight = ip[0].clusterLight;
	o.vertId = ip[0].vertId;
#ifdef CLUSTER_WORLD_NORMAL
	o.worldNormal = ip[0].worldNormal;
#endif
	return o;
}

// DOMAIN SHADER ---------------------------------------------------------------------
[domain("isoline")]
HS_OUTPUT dsCluster( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	uint id = getParticleSortedIndex(input.octantId, PARTICLES_IN_CLUSTER, UV.x);
	
	HS_OUTPUT o = patch[0];
	float rndCluster = o.sizeLifeOpacityRnd.w;
	o.sizeLifeOpacityRnd.w = noise1( (rndCluster + id) * 6.152312923 * PI2, 5123.4213719 );	
	o.sizeLifeOpacityRnd.x = o.sizeLifeOpacityRnd.x * (0.6+0.8*o.sizeLifeOpacityRnd.w);//randomized size

	float3 particleLocalPos = mul(particlePos[id].xyz, sbParticles[patch[0].vertId].mToWorld);
	o.posRadius.xyz += particleLocalPos * (patch[0].posRadius.w * (0.7 + 0.6*rndCluster));

	const float verticalGradientFactor = 0.15;//имитация эмбиентного затения к низу кластера в тени
	o.clusterLight.y = (0.5 + 0.5 * particleLocalPos.y * (1-o.clusterLight.x));
	o.clusterLight.y *= o.clusterLight.y * verticalGradientFactor;
	
#ifdef DEBUG_NO_AMBIENT_LIGHT
	o.clusterLight.y = 0.5;
#endif
	o.vertId = patch[0].vertId;
	return o;
}

[domain("isoline")]
HS_OUTPUT dsClusterShadow( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	HS_OUTPUT o;
	uint id = getParticleSortedIndex(input.octantId, PARTICLES_IN_CLUSTER, UV.x);
	float3 particleLocalPos = mul(particlePos[id].xyz, sbParticles[patch[0].vertId].mToWorld);
	o.posRadius.xyz = patch[0].posRadius.xyz + particleLocalPos * patch[0].posRadius.w;
	o.posRadius.w = patch[0].posRadius.w;
	o.sizeLifeOpacityRnd = patch[0].sizeLifeOpacityRnd;
	o.clusterLight = patch[0].clusterLight;
	o.vertId = patch[0].vertId;
	return o;
}

#endif // if PARTICLES_IN_CLUSTER>1

[maxvertexcount(4)]
void gsCluster(point HS_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	float3 gsPos			= input[0].posRadius.xyz;
	float gsScale			= input[0].sizeLifeOpacityRnd.x;
	float gsLifetime		= input[0].sizeLifeOpacityRnd.y;
	float gsOpacity			= input[0].sizeLifeOpacityRnd.z;
	float gsRnd				= input[0].sizeLifeOpacityRnd.w;
	float3 gsClusterLight	= input[0].clusterLight.xyz;
	// #define gsAge		input[0].clusterLight.z // UNUSED

	float3 wPos = gsPos;
	gsPos = mul(float4(gsPos,1), gView).xyz;

#ifndef USE_TEX_ARRAY
	uint phase = (gModelTime + gsRnd*30)*ANIMATION_SPEED;
	float4 uvOffsetScale = getTextureFrameUV(phase);
#endif

	float rotAngle = gsRnd*PI2*30 + gModelTime*PARTICLE_ROTATE_SPEED;
	float haloFactor = getHaloFactor(gSunDirV.xyz, gsPos, 10) * gsClusterLight.x * 0.7;

	GS_OUTPUT o;
	o.clusterLight.xyz = gsClusterLight.xyz;
	o.clusterLight.w = gsOpacity;

	float2 rnd = noise2(float2(gsRnd, gsRnd*3.97512)) + gModelTime * CLUSTER_DETAIL_SPEED;

#ifdef CLUSTER_WORLD_NORMAL
	float3x3 mNormal = mul(rotMatrixY(rotAngle), basis(input[0].worldNormal));
	float4x4 mBillboard = mul(enlargeMatrixTo4x4(mNormal, wPos), gViewProj);
	o.sunDirM = float4(getSunDirInObjectSpace(mNormal), haloFactor);
#else
	float2x2 M = rotMatrix2x2(rotAngle);//angle
	o.sunDirM = float4(getSunDirInNormalMapSpace(M), haloFactor);
#endif
	o.params2 =saturate(length(wPos-worldOffset)/200);

	[unroll]
	for (uint i = 0; i < 4; ++i)
	{
		//uv
		o.params.xyzw = staticVertexData[i].zwzw;
	#ifndef USE_TEX_ARRAY
		o.params.xy = o.params.xy * uvOffsetScale.xy + uvOffsetScale.zw;
	#endif
	#ifdef DETAIL_TEX
		o.params.zw = o.params.zw * CLUSTER_DETAIL_TILE + rnd.xy;
	#endif

		//position
	#ifdef CLUSTER_WORLD_NORMAL
		float2 corner = staticVertexData[i].xy * gsScale;
		o.pos = mul(float4(corner.x,0, corner.y, 1), mBillboard);
	#else
		float2 corner = mul(staticVertexData[i].xy, M) * gsScale;
		float4 vPos = float4(corner, 0, 1);
		vPos.xyz += gsPos;
		o.pos = mul(vPos, gProj);
	#endif

	#ifdef SOFT_PARTICLES
		o.projPos = o.pos;
	#endif
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

//additiveness = 0 - обычная прозрачность; 1 - чисто аддитивный блендинг.
float4 makeAdditiveBlending2(in float4 clr, in float additiveness = 1)
{
	float transmittance = 1 - lerp(clr.a, 0, additiveness);
	return float4(clr.rgb * clr.a, transmittance);
}

float4 psCluster(in GS_OUTPUT i, uniform bool bAtmosphere): SV_TARGET0
{
	
	float psOpacity		= i.clusterLight.w;
#if defined(CLUSTER_GLOW_COLOR)
	float psGlowFactor	= i.clusterLight.z;
#else
	float psGlowFactor = 0;
#endif

#ifndef USE_TEX_ARRAY
	float4 color = tex.Sample(ClampLinearSampler, i.params.xy);
#else
	float4 color = texArray.Sample(ClampLinearSampler, float3(i.params.xy, fmod(gModelTime, 3.1)));
#endif
	
	float alpha = min(1, color.a*10);

#ifdef SOFT_PARTICLES
	color.a *= depthAlpha(i.projPos, SOFT_PARTICLES);
#endif

	clip(color.a-0.01);

#ifdef DEBUG_OUTPUT_TEMP
	return float4(psGlowFactor.xxx, color.a);
#endif

#ifdef DETAIL_TEX
	float2 detail = detailTex.Sample(gTrilinearWrapSampler, i.params.zw).bg;
	detail = detailParams.xy + detail * detailParams.zw;
	color.a = saturate(color.a*detail.y);
#endif
	color.a *= psOpacity;
#ifdef DEBUG_OPAQUE
	color.a = 1;
#endif

	float NoL = max(0, dot((color.xyz*2.0 - 254.0/255.0), -i.sunDirM.xyz)*0.5+0.5);
#ifdef DEBUG_NO_NORMALS
	NoL = 1;
#endif
	NoL = NoL*i.clusterLight.x + i.clusterLight.y;

#ifdef DEBUG_CLUSTER_LIGHT
	// return float4(i.clusterLight.xxx, color.a/**i.clusterLight.z*/);
	// return float4(i.clusterLight.yyy, color.a/**i.clusterLight.z*/);
	return float4(NoL.xxx, color.a/**i.clusterLight.z*/);
#endif
	
	float translucency = 0.3 * CLUSTER_TRANSLUCENCY;//TODO: translucency зашить в i.clusterLight.xy
	
	float3 sunColor = getPrecomputedSunColor(0) * (translucency + (1.0 - translucency) * NoL);

	float haloFactor = saturate( i.sunDirM.w * (1 - 1.5*color.a) );

	color.rgb = shading_AmbientSunHalo(CLUSTER_COLOR * CLUSTER_COLOR, CLUSTER_AMBIENT_COLOR, sunColor/PI, haloFactor);

#ifdef DETAIL_TEX
	color.rgb *= detail.x;
#endif

	//emission
#if defined(CLUSTER_GLOW_COLOR)
	float3 glowClrHot = (CLUSTER_GLOW_COLOR * CLUSTER_GLOW_COLOR);
	#ifdef CLUSTER_GLOW_COLOR_COLD
		float3 glowClrCold = (CLUSTER_GLOW_COLOR_COLD * CLUSTER_GLOW_COLOR_COLD);
		color.rgb += 1.0* lerp(glowClrCold, glowClrHot, sqrt(psGlowFactor)) * psGlowFactor * CLUSTER_GLOW_BRIGHTNESS;//TODO: предрасчитать
	#else
		color.rgb += 1.0* glowClrHot * psGlowFactor * CLUSTER_GLOW_BRIGHTNESS;//TODO: предрасчитать
	#endif
#endif


	if(bAtmosphere)
		color.rgb = applyPrecomputedAtmosphere(color.rgb, 0);

	color.a *= CLUSTER_RESULT_OPACITY;
	return makeAdditiveBlending2(color,  psGlowFactor * CLUSTER_GLOW_ADDITIVENESS);
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}


float4 psClusterFLIR(in GS_OUTPUT i, uniform bool bAtmosphere): SV_TARGET0
{
		float psOpacity		= i.clusterLight.w;
#if defined(CLUSTER_GLOW_COLOR)
	float psGlowFactor	= i.clusterLight.z;
#else
	float psGlowFactor = 0;
#endif

#ifndef USE_TEX_ARRAY
	float4 color = tex.Sample(ClampLinearSampler, i.params.xy);
#else
	float4 color = texArray.Sample(ClampLinearSampler, float3(i.params.xy, fmod(gModelTime, 3.1)));
#endif
	
	float alpha = min(1, color.a*10);

#ifdef SOFT_PARTICLES
	color.a *= depthAlpha(i.projPos, SOFT_PARTICLES);
#endif

	clip(color.a-0.01);

#ifdef DEBUG_OUTPUT_TEMP
	return float4(psGlowFactor.xxx, color.a);
#endif

#ifdef DETAIL_TEX
	float2 detail = detailTex.Sample(gTrilinearWrapSampler, i.params.zw).bg;
	detail = detailParams.xy + detail * detailParams.zw;
	color.a = saturate(color.a*detail.y);
#endif
	color.a *= psOpacity;
#ifdef DEBUG_OPAQUE
	color.a = 1;
#endif

	float NoL = max(0, dot((color.xyz*2.0 - 254.0/255.0), -i.sunDirM.xyz)*0.5+0.5);
#ifdef DEBUG_NO_NORMALS
	NoL = 1;
#endif
	NoL = NoL*i.clusterLight.x + i.clusterLight.y;

#ifdef DEBUG_CLUSTER_LIGHT
	// return float4(i.clusterLight.xxx, color.a/**i.clusterLight.z*/);
	// return float4(i.clusterLight.yyy, color.a/**i.clusterLight.z*/);
	return float4(NoL.xxx, color.a/**i.clusterLight.z*/);
#endif
	
	float translucency = 0.3 * CLUSTER_TRANSLUCENCY;//TODO: translucency зашить в i.clusterLight.xy
	
	float3 sunColor = getPrecomputedSunColor(0) * (translucency + (1.0 - translucency) * NoL);

	float haloFactor = saturate( i.sunDirM.w * (1 - 1.5*color.a) );

	color.rgb = shading_AmbientSunHalo(CLUSTER_COLOR * CLUSTER_COLOR, CLUSTER_AMBIENT_COLOR, sunColor/PI, haloFactor);

#ifdef DETAIL_TEX
	color.rgb *= detail.x;
#endif

	//emission
#if defined(CLUSTER_GLOW_COLOR)
	float3 glowClrHot = (CLUSTER_GLOW_COLOR * CLUSTER_GLOW_COLOR);
	#ifdef CLUSTER_GLOW_COLOR_COLD
		float3 glowClrCold = (CLUSTER_GLOW_COLOR_COLD * CLUSTER_GLOW_COLOR_COLD);
		color.rgb += 10.0* lerp(glowClrCold, glowClrHot, sqrt(psGlowFactor)) * pow(psGlowFactor,2.0) * (sqrt(CLUSTER_GLOW_BRIGHTNESS)+0.1);
		//color.rgb += lerp(glowClrCold, glowClrHot, sqrt(psGlowFactor)) * psGlowFactor * CLUSTER_GLOW_BRIGHTNESS;//TODO: предрасчитать
	#else
		color.rgb += 10.0* glowClrHot * psGlowFactor * CLUSTER_GLOW_BRIGHTNESS;//TODO: предрасчитать
	#endif
#endif


#ifdef EMITTER_TIME_NORM
	color.rgb =  (0.7+color.rgb)*(pow(1.0-EMITTER_TIME_NORM, 2)*i.params2+0.19);
#else
	color.rgb += 0.19*0.7;
#endif
	
	if(bAtmosphere)
		color.rgb = applyPrecomputedAtmosphere(color.rgb, 0);

	color.a *= CLUSTER_RESULT_OPACITY;
	return makeAdditiveBlending2(1.4*color,  psGlowFactor * CLUSTER_GLOW_ADDITIVENESS);
}

[maxvertexcount(4)]
void gsClusterShadow(point HS_OUTPUT input[1], inout TriangleStream<GS_SHADOW_OUTPUT> outputStream)
{
	float3 gsPos			= input[0].posRadius.xyz;
	float gsScale			= input[0].sizeLifeOpacityRnd.x;
	float gsLifetime		= input[0].sizeLifeOpacityRnd.y;
	float gsOpacity			= input[0].sizeLifeOpacityRnd.z;
	float gsRnd				= input[0].sizeLifeOpacityRnd.w;
	float3 gsClusterLight	= input[0].clusterLight.xyz;
	// #define gsAge		input[0].clusterLight.z // UNUSED

#ifndef USE_TEX_ARRAY
	uint phase = (gModelTime + gsRnd*3)*ANIMATION_SPEED;
	float4 uvOffsetScale = getTextureFrameUV(phase);
#endif

	float rotAngle = gsRnd*PI2 + gModelTime*PARTICLE_ROTATE_SPEED;
	float2x2 M = rotMatrix2x2(rotAngle);

	GS_SHADOW_OUTPUT o;
	o.params.z = gsOpacity;
	
	[unroll]
	for (uint i = 0; i < 4; ++i) {
		//uv
		o.params.xy = staticVertexData[i].zw;
	#ifndef USE_TEX_ARRAY
		o.params.xy = o.params.xy * uvOffsetScale.xy + uvOffsetScale.zw;
	#endif
		float4 vPos = float4(mul(staticVertexData[i].xy, M)*gsScale, 0, 1);
		o.pos = mul(float4(gsPos + vPos.xzy + gCameraPos.xyz, 1), gViewProj);
		o.projPos = o.pos;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

void psClusterShadow(GS_SHADOW_OUTPUT i)
{
	float psOpacity	= i.params.z;
#ifndef USE_TEX_ARRAY
	float4 color = tex.Sample(ClampLinearSampler, i.params.xy); clip(color.a-0.01);
#else
	float4 color = texArray.Sample(ClampLinearSampler, float3(i.params.xy, fmod(gModelTime, 3.1))); clip(color.a-0.01);
#endif

	if(dither_ordered8x8(i.pos.xy) >  min(1, pow(psOpacity*color.a, 0.02)))
		discard;
}

BlendState premultAlphaBlendState
{
	BlendEnable[0] = true;
	SrcBlend = ONE;
	DestBlend = SRC_ALPHA;
	BlendOp = ADD; 
	SrcBlendAlpha = INV_SRC_ALPHA;
	DestBlendAlpha = SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

#ifndef CLUSTER_CUSTOM_VS_NAME
VertexShader	vsClusterComp = CompileShader(vs_4_0, vsClusterDefault());
#else
VertexShader	vsClusterComp = CompileShader(vs_4_0, CLUSTER_CUSTOM_VS_NAME());
#endif

#if PARTICLES_IN_CLUSTER>1
HullShader		hsClusterComp			= CompileShader(hs_5_0, hsCluster());
DomainShader	dsClusterComp			= CompileShader(ds_5_0, dsCluster());
DomainShader	dsClusterShadowComp		= CompileShader(ds_5_0, dsClusterShadow());
#endif
GeometryShader	gsClusterComp			= CompileShader(gs_4_0, gsCluster());
GeometryShader	gsClusterShadowComp		= CompileShader(gs_4_0, gsClusterShadow());
PixelShader		psClusterComp			= CompileShader(ps_4_0, psCluster(false));
PixelShader		psClusterAtmComp		= CompileShader(ps_4_0, psCluster(true));
PixelShader		psClusterCompFLIR			= CompileShader(ps_4_0, psClusterFLIR(false));
PixelShader		psClusterAtmCompFLIR		= CompileShader(ps_4_0, psClusterFLIR(true));
PixelShader		psClusterShadowComp		= CompileShader(ps_4_0, psClusterShadow());

technique10 techCluster
{
	pass cluster
	{
		SetVertexShader(vsClusterComp);
	#if PARTICLES_IN_CLUSTER>1
		SetHullShader(hsClusterComp);
		SetDomainShader(dsClusterComp);
	#endif
		SetGeometryShader(gsClusterComp);
		SetPixelShader(psClusterComp);
		SetBlendState(premultAlphaBlendState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	#ifdef CLIP_COCKPIT
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
	#else
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
	#endif
		SetRasterizerState(cullNone);
	}
	
	pass clusterWithAtmsophere
	{
		SetVertexShader(vsClusterComp);
	#if PARTICLES_IN_CLUSTER>1
		SetHullShader(hsClusterComp);
		SetDomainShader(dsClusterComp);
	#endif
		SetGeometryShader(gsClusterComp);
		SetPixelShader(psClusterAtmComp);
		SetBlendState(premultAlphaBlendState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	#ifdef CLIP_COCKPIT
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
	#else
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
	#endif
		SetRasterizerState(cullNone);
	}

	pass clusterShadow
	{
		SetVertexShader(vsClusterComp);
	#if PARTICLES_IN_CLUSTER>1
		SetHullShader(hsClusterComp);
		SetDomainShader(dsClusterComp);
	#endif
		SetGeometryShader(gsClusterShadowComp);
		SetPixelShader(psClusterShadowComp);
		SetDepthStencilState(shadowmapDepthState, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(shadowmapRasterizerState);
	}

	pass clusterFLIR
	{
		SetVertexShader(vsClusterComp);
	#if PARTICLES_IN_CLUSTER>1
		SetHullShader(hsClusterComp);
		SetDomainShader(dsClusterComp);
	#endif
		SetGeometryShader(gsClusterComp);
		SetPixelShader(psClusterCompFLIR);
		//SetBlendState(premultAlphaBlendState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	#ifdef CLIP_COCKPIT
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
	#else
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
	#endif
		SetRasterizerState(cullNone);
	}
	
	pass clusterWithAtmsophereFLIR
	{
		SetVertexShader(vsClusterComp);
	#if PARTICLES_IN_CLUSTER>1
		SetHullShader(hsClusterComp);
		SetDomainShader(dsClusterComp);
	#endif
		SetGeometryShader(gsClusterComp);
		SetPixelShader(psClusterAtmCompFLIR);
		SetBlendState(premultAlphaBlendState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	#ifdef CLIP_COCKPIT
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
	#else
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
	#endif
		SetRasterizerState(cullNone);
	}
}
