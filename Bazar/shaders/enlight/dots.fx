#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "deferred/GBuffer.hlsl"
#include "deferred/atmosphere.hlsl"
#include "deferred/shading.hlsl"

#define USE_GS 1

uint2 targetDims;

struct VS_INPUT {
    float3 pos		: POSITION0; 
    float4 color	: COLOR0; 
};

struct VS_OUTPUT {
    float4 sv_pos	: SV_POSITION0; 
    float3 wpos		: TEXTURE0; 
    float4 projPos	: TEXTURE1; 
	float4 color	: COLOR0; 
};

VS_OUTPUT VS(VS_INPUT i) {
    VS_OUTPUT o;
	o.sv_pos = o.projPos = mul(float4(i.pos,1), gViewProj);
	o.wpos = i.pos;
	o.color = i.color;
	return o;    
}

float4 PS(VS_OUTPUT i): SV_TARGET0 { 
//	return float4(applyAtmosphereLinear(gCameraPos.xyz, i.wpos, i.projPos, i.color.rgb*gSunDiffuse.rgb), i.color.a);

	float3 v = normalize(i.wpos - gCameraPos);
#ifdef VERSION_NEWER_2_5_6
	float2 cloudsShadowAO = SampleShadowClouds(i.wpos);
	float3 c = ShadeSolid(i.wpos, gSunDiffuse, i.color.rgb, 0, float3(0,-1,0), 1, 0, cloudsShadowAO.x, 1, cloudsShadowAO, v, 1, FAR_ENV_MAP);
#else
	float3 c = ShadeSolid(gSunDiffuse, i.color.rgb, 0, float3(0, -1, 0), 1, 0, 1, 1, v, 1, FAR_ENV_MAP);
#endif
	return float4(applyAtmosphereLinear(gCameraPos.xyz, i.wpos, i.projPos, c), i.color.a);
}

[maxvertexcount(3)]
void GS(point VS_OUTPUT points[1], inout TriangleStream<VS_OUTPUT> output) {
	float4 p = points[0].sv_pos;
	p /= p.w;

	VS_OUTPUT v[3];
	v[0] = v[1] = v[2] = points[0];

	v[0].sv_pos = v[1].sv_pos = v[2].sv_pos = float4((floor(p.xy * targetDims * 0.5) + 1) * 2 / targetDims, p.z, 1);
	v[1].sv_pos.x -= 2.5 / targetDims.x;
	v[2].sv_pos.y -= 2.5 / targetDims.y;

	output.Append(v[0]);
	output.Append(v[1]);
	output.Append(v[2]);
	output.RestartStrip();
}

technique10 dots
{
    pass P0
	{          
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, PS()));
#if USE_GS
		SetGeometryShader(CompileShader(gs_5_0, GS()));
#else
		SetGeometryShader(NULL);
#endif
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetComputeShader(NULL);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
    }
}
