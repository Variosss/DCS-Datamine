#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

#ifdef MSAA
	Texture2DMS<float4, MSAA>	DiffuseMap;
	Texture2DMS<float, MSAA>	DepthMap;
#else
	Texture2D 					DiffuseMap;
	Texture2D<float>			DepthMap;
#endif

uint2	Dims;
float4	viewport;

struct vOutput {
	float4 vPosition	:SV_POSITION0;
	float2 vTexCoords	:TEXCOORD0;
};

vOutput vsMain(uint i: SV_VertexID)
{
	float2 vertPos[] =
	{
		float2(-1.0f, -1.0f),
		float2(-1.0f,  1.0f),
		float2( 1.0f, -1.0f),
		float2( 1.0f,  1.0f)
	};

	vOutput res;
	res.vPosition = float4(vertPos[i], 0, 1.0);
	res.vTexCoords = (float2(res.vPosition.x, -res.vPosition.y)*0.5+0.5)*viewport.zw + viewport.xy;
#ifdef MSAA
	res.vTexCoords *= Dims;
#endif
	return res;
}

float4 psColor3(const vOutput v, uniform bool bScaling): SV_TARGET0 {
#ifdef MSAA
	float3 diffuse = 0;
	[unroll]
	for(uint i=0; i<MSAA; ++i) {
		diffuse += DiffuseMap.Load( int2(v.vTexCoords.xy), i).rgb;
	}
	diffuse /= MSAA;
	return float4(diffuse, 1.0);
#else
	return float4(DiffuseMap.Sample(bScaling ? ClampLinearSampler : ClampPointSampler, v.vTexCoords.xy).rgb, 1.0);
#endif
}

float4 psColor4(const vOutput v, uniform bool bScaling): SV_TARGET0 {
#ifdef MSAA
	float4 diffuse = 0;
	[unroll]
	for(uint i=0; i<MSAA; ++i) {
		diffuse += DiffuseMap.Load( int2(v.vTexCoords.xy), i).rgba;
	}
	diffuse /= MSAA;
	return diffuse;
#else
	return DiffuseMap.Sample(bScaling ? ClampLinearSampler : ClampPointSampler, v.vTexCoords.xy).rgba;
#endif	
}

float psDepth(const vOutput v): SV_Depth {
#ifdef MSAA
	float depth = 1.0e8;
	[unroll]
	for(uint i=0; i<MSAA; ++i)
		depth = min(depth, DepthMap.Load( int2(v.vTexCoords.xy), i).r);
	return depth;
#else
	return DepthMap.Sample(ClampPointSampler, v.vTexCoords.xy).r;
#endif
}

float psDepthMSAA_MSAA(const vOutput v, uint i: SV_SampleIndex): SV_Depth  {
#ifdef MSAA
	return DepthMap.Load( int2(v.vTexCoords.xy), i).r;	
#else
	return 0;
#endif
}

#define PASS_BODY(psComp) { SetVertexShader(vsComp); SetGeometryShader(NULL); SetPixelShader(CompileShader(ps_5_0, psComp)); \
	SetDepthStencilState(disableDepthBuffer, 0); \
	SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
	SetRasterizerState(cullNone);}

#define PASS_BODY_D(psComp) { SetVertexShader(vsComp); SetGeometryShader(NULL); SetPixelShader(CompileShader(ps_5_0, psComp)); \
	SetDepthStencilState(alwaysDepthBuffer, 0); \
	SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
	SetRasterizerState(cullNone);}


VertexShader vsComp				= CompileShader(vs_5_0, vsMain());

technique10 tech
{
	pass resolveColor3			PASS_BODY(psColor3(false))
	pass resolveColor3Scale		PASS_BODY(psColor3(true))
	pass resolveColor4			PASS_BODY(psColor4(false))
	pass resolveColor4Scale		PASS_BODY(psColor4(true))
	pass resolveDepth			PASS_BODY_D(psDepth())
	pass copyDepthMSAA_MSAA		PASS_BODY_D(psDepthMSAA_MSAA())
}
