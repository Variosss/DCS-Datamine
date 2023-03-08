#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"

Texture2D diffuseMap;
Texture2D distanceMap;
Texture2D<float2> smokeMap;

#ifdef MSAA
	Texture2DMS<float, MSAA> depthMap;
#else
	Texture2D<float> depthMap;
#endif

float4 viewport;
int2 dims;
float power;

struct PS_INPUT
{
	float4 vPosition:		SV_POSITION;
	float4 vTexCoords:		TEXCOORD0;
	float4 fogColorFactor: 	TEXCOORD1;
	float4 smokeColorFactor:TEXCOORD2;
};

PS_INPUT vsSmoke(in float2 pos: POSITION0)
{
	PS_INPUT res;
	res.vPosition = float4(pos.xy, 0, 1);
	res.vTexCoords.xy = float2(pos.x, -pos.y)*0.5+0.5;
	res.vTexCoords.xy = res.vTexCoords.xy * viewport.zw + viewport.xy;
	res.vTexCoords.zw = res.vTexCoords.xy * dims;
	
	res.fogColorFactor.xyz = AmbientTop.rgb * (float3(0.24,0.28,0.33) + 0.05);
	res.fogColorFactor.w = saturate((power-0.2)*2);
	
	res.smokeColorFactor.xyz = AmbientTop.rgb * float3(0.24,0.28,0.33)*0.86;
	res.smokeColorFactor.w = sqrt(sin(power*2.5));
	
	return res;
}

float4 psSmoke(in PS_INPUT i): SV_TARGET0
{
	float3 sourceColor	= diffuseMap.Load(int3(i.vTexCoords.zw, 0)).rgb;
	// float3 sourceColor	= diffuseMap.SampleLevel(ClampLinearSampler, i.vTexCoords.xy, 0).rgb;
	float2 smoke = smokeMap.SampleLevel(ClampLinearSampler, i.vTexCoords.xy, 0).rg;
	
#ifdef MSAA
	float depth = depthMap.Load(int2(i.vTexCoords.zw), 0).r;//берем только 1 семпл, для софт-партиклов вполне достаточно
#else
	float depth = depthMap.Load(int3(i.vTexCoords.zw, 0)).r;
#endif
	
	if(depth>0.9999)//TODO: выпилить, когда Подъячев выгрузит запись прозрачных объектов в глубину
		depth = 0.9;

	float fogFactor = pow(saturate(depth*(1+0.03*power)), 15-10*power) * i.fogColorFactor.w;
	float smokeFactor = smoke.r * i.smokeColorFactor.w;

	float3 fogColor = i.fogColorFactor.xyz;
	float3 smokeColor = i.smokeColorFactor.xyz + smoke.g * gSunDiffuse.rgb * 0.3;

	float3 result;
	result = lerp(sourceColor, fogColor, fogFactor);
	result = lerp(result, smokeColor, smokeFactor);
	
	return float4(result, 1);
}


technique10 tech
{
	pass cockpitSmoke
	{
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		
		SetVertexShader(CompileShader(vs_4_0, vsSmoke()));
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSmoke()));
	}
}
