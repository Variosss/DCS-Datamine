#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"

#include "deferred/shading.hlsl"
#include "deferred/atmosphere.hlsl"

Texture2DArray diffuseMap;

float4x4 vTransform;
float4x4 pTransform;	// the same as vTrasform, it is work around to fix impostors blinking

float4x4 impostorTransform;
float4	impostorMin, impostorMax;
int impostorIdx;
float alpha;

static const float2 texCoord[4] = {
    float2(0, 0),  float2(1, 0),
    float2(0, 1),  float2(1, 1)
};

#define MapSampler gBilinearClampSampler
/*
SamplerState MapSampler
{
	Filter        = MIN_MAG_LINEAR_MIP_POINT;
	AddressU      = CLAMP;
	AddressV      = CLAMP;
	AddressW      = CLAMP;
	MaxAnisotropy = 0;
	BorderColor   = float4(0, 0, 0, 0);
};*/

struct psInput
{
	float4 vPosition:	SV_POSITION0;
	float2 vTexCoord:	TEXCOORD0;
	float4 pos:			TEXCOORD1;
	float4 wPos:		TEXCOORD2;
};

float4 VS(uint vid: SV_VertexID): POSITION0 {
	return mul(float4(0,0,0,1), vTransform);
}

[maxvertexcount(4)]
void GS(point float4 input[1]: POSITION0, inout TriangleStream<psInput> outputStream) {
	psInput o;

	float4 position = mul(input[0], gView);

	const float2 offset[4] = {
		float2(impostorMin.x, impostorMax.y), float2(impostorMax.x, impostorMax.y),
		float2(impostorMin.x, impostorMin.y), float2(impostorMax.x, impostorMin.y)
	};

	[unroll]
	for(int i=0; i<4; ++i) {

		float3 p = position.xyz / position.w;

		float4 off = mul(float4(offset[i],0,1), impostorTransform);
		p.xy += off.xy;

		o.pos = float4(p, 1);
		o.wPos = mul(o.pos, gViewInv);
		o.vPosition = mul(o.pos, gProj);
		o.vTexCoord = texCoord[i];
		outputStream.Append(o);
	}

	outputStream.RestartStrip();
}

struct PS_OUTPUT {
	float4	color: SV_TARGET0;
	float	depth: SV_DEPTH;
};


PS_OUTPUT PS(const psInput i, uniform bool useLights = false) {

	PS_OUTPUT o;

	float4 diff = diffuseMap.Sample(MapSampler, float3(i.vTexCoord.xy, impostorIdx*2));

	if(diff.a < 1.0/255.0)
		discard;

	float4 n = diffuseMap.Sample(MapSampler, float3(i.vTexCoord.xy, impostorIdx*2+1));
	float3 normal = normalize(n.xyz*2.0 - 1.0);
	normal = mul(float4(normal, 0), pTransform).xyz;		// normal in world space

	float4 pos = float4(i.pos.xy, i.pos.z + (1-n.a) * (impostorMax.z-impostorMin.z) + impostorMin.z, 1); // correct depth
	float4 projPos = mul(pos, gProj);
	o.depth = projPos.z/projPos.w;

	float shadow = 1.0;

	float3 sunColor = SampleSunRadiance(i.wPos.xyz, gSunDir);
	float3 toCamera = normalize(gCameraPos - i.wPos.xyz);
	float2 cloudsShadowAO = 1;
	o.color = float4(ShadeHDR(i.vPosition.xy, sunColor, diff.rgb, normal, 0.7, 0.2, float3(0,0,0), shadow, 1, cloudsShadowAO, toCamera, i.wPos.xyz), diff.a*alpha);

	return o;
}

technique10 Impostor {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(CompileShader(gs_4_0, GS()));
		SetPixelShader(CompileShader(ps_4_0, PS(false)));

		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

technique10 ImpostorLight {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(CompileShader(gs_4_0, GS()));
		SetPixelShader(CompileShader(ps_4_0, PS(true)));

		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

