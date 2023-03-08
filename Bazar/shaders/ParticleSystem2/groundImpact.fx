#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"

#define MODEL_SHADING_OPACITY_CONTROL
#include "ParticleSystem2/common/modelShading.hlsl"

#define NO_DEFAULT_UNIFORMS
// #define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"

float4		worldOffset;
float emitTimer;
static float renderDistMaxSq = worldOffset.w;

struct ClusterInstance
{
	float4	posAng: POSITION0;
	float4	normalRadius: POSITION1;
	float	startTime: POSITION2;
};

ClusterInstance vsDummy(ClusterInstance i)
{
	return i;
}

struct MODEL_PS_INPUT_FLIR_IMPACTS
{
	float4 pos: 	SV_POSITION0;
	float4 wPos: 	POSITION0;
	float4 projPos:	POSITION1;
	float3 normal: 	NORMAL0;
	float3 tangent:	TANGENT0;
	float2 uv:		TEXCOORD0;
	float curTimeInst:	TEXCOORD1;
#ifdef MODEL_SHADING_OPACITY_CONTROL
	float opacity:	TEXCOORD2;
#endif
};



[maxvertexcount(4)]
void gsBillboard(point ClusterInstance i[1], inout TriangleStream<MODEL_PS_INPUT> outputStream)
{
	ClusterInstance cluster = i[0];
	float3 normal = cluster.normalRadius.xyz;
	float2 sc;
	sincos(cluster.posAng.w, sc.x, sc.y);

	float2x2 M = {sc.y, sc.x, -sc.x, sc.y};
	float3x3 world = basis(normal);

	float3 clusterPos = worldOffset.xyz + cluster.posAng.xyz + normal * 0.1;

	MODEL_PS_INPUT o;
	float3 d = clusterPos-gCameraPos;
	o.opacity = smoothstep(renderDistMaxSq, renderDistMaxSq*0.3, dot(d,d));
	o.normal = normal;
	o.tangent = mul(-float3(sc.y, 0, sc.x), world);
	[unroll]
	for(int ii = 0; ii < 4; ++ii)
	{
		float3 posW = 0;
		posW.xzy = float3(mul(staticVertexData[ii].xy, M)*cluster.normalRadius.w, 0);
		posW = mul(posW, world) + clusterPos;
		o.wPos = float4(posW, 1);
		o.pos = o.projPos = mul(o.wPos, gViewProj);
		o.uv = staticVertexData[ii].zw;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}



[maxvertexcount(4)]
void gsBillboardFlir(point ClusterInstance i[1], inout TriangleStream<MODEL_PS_INPUT_FLIR_IMPACTS> outputStream)
{
	ClusterInstance cluster = i[0];
	float3 normal = cluster.normalRadius.xyz;
	float2 sc;
	sincos(cluster.posAng.w, sc.x, sc.y);

	float2x2 M = {sc.y, sc.x, -sc.x, sc.y};
	float3x3 world = basis(normal);

	float3 clusterPos = worldOffset.xyz + cluster.posAng.xyz + normal * 0.1;

	MODEL_PS_INPUT_FLIR_IMPACTS o;
	float3 d = clusterPos-gCameraPos;
	o.opacity = smoothstep(renderDistMaxSq, renderDistMaxSq*0.3, dot(d,d));
	o.normal = normal;
	o.tangent = mul(-float3(sc.y, 0, sc.x), world);
	o.curTimeInst = emitTimer - cluster.startTime;
	[unroll]
	for(int ii = 0; ii < 4; ++ii)
	{
		float3 posW = 0;
		posW.xzy = float3(mul(staticVertexData[ii].xy, M)*cluster.normalRadius.w, 0);
		posW = mul(posW, world) + clusterPos;
		o.wPos = float4(posW, 1);
		o.pos = o.projPos = mul(o.wPos, gViewProj);
		o.uv = staticVertexData[ii].zw;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}


float4 MODEL_FORWARD_PS_SHADER_NAME_FLIR(MODEL_PS_INPUT_FLIR_IMPACTS i, uniform int flags): SV_Target0
{
	float4 diffuseFlir  = texDiffuse.Sample(gAnisotropicWrapSampler, i.uv);

#ifdef MODEL_SHADING_OPACITY_CONTROL
	diffuseFlir.a *= i.opacity;
#endif
	float3 normalFlir = getNormalFromTangentSpace(i.normal, i.tangent, i.uv);

	float3 sunColor = SampleSunRadiance(i.wPos.xyz, gSunDir);
	float3 finalColor = diffuseFlir.xyz*(0.5*saturate(1.0-i.curTimeInst/100.0)+0.45)*(length(sunColor)/5.0+0.7);
	float l = luminance(finalColor);
	return float4(l, l, l, diffuseFlir.a);

}

technique10 tech
{	
	pass forwardDecal
	{
		SetHullShader(NULL);
		SetDomainShader(NULL);

		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetGeometryShader(CompileShader(gs_4_0, gsBillboard()));
		SetPixelShader(CompileShader(ps_5_0, psModelForward(MAT_FLAG_DIFFUSE_MAP | MAT_FLAG_SPECULAR_MAP | MAT_FLAG_NORMAL_MAP | MAT_FLAG_CASCADE_SHADOWS)));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullBack);
	}

	pass forwardFlir
	{
		SetHullShader(NULL);
		SetDomainShader(NULL);

		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetGeometryShader(CompileShader(gs_4_0, gsBillboardFlir()));
		SetPixelShader(CompileShader(ps_5_0, MODEL_FORWARD_PS_SHADER_NAME_FLIR(MAT_FLAG_DIFFUSE_MAP | MAT_FLAG_SPECULAR_MAP | MAT_FLAG_NORMAL_MAP | MAT_FLAG_CASCADE_SHADOWS)));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullBack);
	}

}
