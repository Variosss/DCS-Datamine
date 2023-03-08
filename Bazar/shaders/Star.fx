#include "common/TextureSamplers.hlsl"
#include "common/context.hlsl"
#include "enlight/materialParams.hlsl"
#define FOG_ENABLE
#include "common/fog2.hlsl"
#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

#include "deferred/atmosphere.hlsl"

float4x4 matWorld;
float4x4 matWorldInv;

TextureCube milkywayTex;

float uScale;

float2 pixelSize;
float milkywayOpacity;
float glitter;

static const float2 vertexOffset[4] = {{-1, 1},  {1, 1}, {-1, -1}, {1, -1}};

struct vsInput
{
	float3 vPosition:	POSITION0;
	float2 vColor:		COLOR0;
};

struct psInput
{
	float4 vPosition:	SV_POSITION0;
	float2 vTexCoord:	TEXCOORD0;
	float4 vWorldPos:	TEXCOORD1;
	float4 vColor:		COLOR0;
};

float earthIntersect(float3 viewRay)
{
	static const float Rg = gEarthRadius;			// earth radius in km
	float dr = Rg / ((gOrigin.y + gCameraPos.y)*0.001 + Rg);
	return viewRay.y < -sqrt(1.0 - dr * dr); 
}

vsInput vsStar(in const vsInput i)
{
	return i;
}

[maxvertexcount(4)]
void gsStar(point vsInput input[1], inout TriangleStream<psInput> outputStream)
{
	vsInput i = input[0];
	
	float4 position = float4(i.vPosition, 1);
	float4 worldPos = mul(position, matWorld);
	float4 screenPos = mul(worldPos, gViewProj);  screenPos /= screenPos.w;

	if(abs(screenPos.z-0.5)>0.5 || any(abs(screenPos.xy)>1.02))
		return;

	if(earthIntersect( normalize(worldPos.xyz - gCameraPos.xyz) ) > 0)
		return;

	float magnitude = i.vColor.r; //normalized

	const float sizeMin = 1; //px
	const float sizeMax = 5; //px
	const float starBrightnessMin = 0.00065;
	const float starBrightnessMax = 0.035;
	const float starSizeMinPx = 2;

	float2 sizeReal = pixelSize * lerp(sizeMin, sizeMax, magnitude*magnitude);
	float2 sizeClamped = max(sizeReal, pixelSize * starSizeMinPx);

	float brightness = starBrightnessMin + (starBrightnessMax-starBrightnessMin) * magnitude * magnitude * min(sizeReal.x / sizeClamped.x, 1.0);	

	{//мерцание звезд
		float phi = i.vColor.g * (6.28318 * 20) + gModelTime * 3.5;
		float noise = saturate((sin(phi) + 1)*0.6 + 0.4);
		brightness *= noise;
	}

	float3 view = normalize(worldPos.xyz/worldPos.w - gCameraPos.xyz);

	psInput o;
	o.vColor.rgb = float3(i.vColor.gg*0.15+0.85, 1) * brightness * SampleSunRadiance(gCameraPos.xyz, view);
	o.vColor.a = 1;
	o.vWorldPos = worldPos;

	// if(o.vColor.r < 0.1/255.0)
		// return;

	[unroll]
	for(int ii=0; ii<4; ++ii)
	{
		o.vPosition = screenPos;
		o.vPosition.xy += vertexOffset[ii] * sizeClamped;
		o.vTexCoord = vertexOffset[ii];
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 psStar(psInput v): SV_TARGET0
{
	float4 color = v.vColor;
	float g = saturate(1 - dot(v.vTexCoord.xy, v.vTexCoord.xy));
	color.a *= g;
	color.a /= uScale;//увеличение яркости с увеличением зума
	return color;
}

struct VS_MILKYWAY_OUTPUT
{
	float4 pos: SV_POSITION0;
	float4 projPos: POSITION0;
	float3 cosmicDir: TEXCOORD1;
	float3 view: TEXCOORD2;
};

VS_MILKYWAY_OUTPUT vsMilkyway(uint vertId: SV_VertexID)
{
	VS_MILKYWAY_OUTPUT o;
	o.pos = o.projPos = float4(vertexOffset[vertId], 0.0, 1);

	float4 worldPos = mul(float4(vertexOffset[vertId], 0, 1), gViewProjInv);
	o.view = normalize(worldPos.xyz/worldPos.w - gCameraPos.xyz);
	o.cosmicDir = mul(o.view, (float3x3)matWorldInv);

	return o;
}

float4 psMilkyway(VS_MILKYWAY_OUTPUT i): SV_TARGET0
{
	float4 worldPos = mul(float4(i.projPos.xy/i.projPos.w, 0, 1), gViewProjInv);
	float3 view = normalize(worldPos.xyz/worldPos.w - gCameraPos.xyz);
	float3 milkyway = milkywayTex.Sample(gBilinearWrapSampler, normalize(mul(view, (float3x3)matWorldInv))).rgb;

	milkyway *= SampleSunRadiance(gCameraPos.xyz, normalize(i.view));

	return float4(milkyway * 0.0007, milkywayOpacity);
}

technique10 Star
{
	pass milkyway
	{
		SetVertexShader(CompileShader(vs_4_0, vsMilkyway()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psMilkyway()));

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	
	pass stars
	{
		SetVertexShader(CompileShader(vs_4_0, vsStar()));
		SetGeometryShader(CompileShader(gs_4_0, gsStar()));
		SetPixelShader(CompileShader(ps_4_0, psStar()));

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
