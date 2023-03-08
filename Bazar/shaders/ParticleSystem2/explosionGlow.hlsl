#include "common/stencil.hlsl"
#include "common/softParticles.hlsl"


#ifndef GLOW_SIZE
	#error GLOW_SIZE must be defined
#endif
#ifndef GLOW_BRIGHTNESS
	#error GLOW_BRIGHTNESS must be defined
#endif
#ifndef GLOW_TINT
	#error GLOW_TINT must be defined
#endif
#ifndef GLOW_POSITION
	#error GLOW_POSITION must be defined
#endif

struct GS_INPUT_DUMMY {};

struct PS_INPUT_STATIC
{
	float4 pos		: SV_POSITION0;
	float4 projPos	: TEXCOORD0;
	float4 uv 		: TEXCOORD1;
};

void vsBillboardStaticDummy() {}

#define ZFEATHER

[maxvertexcount(4)]
void gsBillboardStatic(point GS_INPUT_DUMMY i[1], inout TriangleStream<PS_INPUT_STATIC> outputStream)
{
	PS_INPUT_STATIC o;
		
	float3 viewDir = gCameraPos.xyz - GLOW_POSITION;
	float dist = length(viewDir);
	
	o.uv.w = GLOW_BRIGHTNESS * saturate(1-dist/6000);
	
	float sizeBase = GLOW_SIZE;
	float distNorm = dist/sizeBase;
	
	float sizeFactor = 1 - exp(-distNorm * 1);
	float size = sizeBase * sizeFactor;
	
#ifdef ZFEATHER	
	// size *= (1 - exp(-dist/size*2));
	float offsetMax = 0.5 * sizeBase * saturate(distNorm);//сдвиг партикла на камеру
	float3 offset = (viewDir/dist) * offsetMax;
	o.uv.z = 1.0 / offsetMax;
	o.uv.w /= (0.5+0.5*sizeFactor);
#else
	float3 offset = 0;
	o.uv.z = 1;
#endif

	float4x4 mBillboard = mul(enlargeMatrixTo4x4(basis(viewDir/dist), GLOW_POSITION + offset), gViewProj);	
	
	[unroll]	
	for (int i = 0; i < 4; ++i)
	{
		o.pos = o.projPos = mul(float4(staticVertexData[i].x*size, 0, staticVertexData[i].y*size, 1),	mBillboard);
		o.uv.xy = staticVertexData[i].xy*2;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 psBillboardEmissive(PS_INPUT_STATIC i): SV_TARGET0
{
	float alpha = depthAlpha(i.projPos/i.projPos.w, i.uv.z);

	float t = tex.Sample(gTrilinearWrapSampler, i.uv.xy).r;
	
	float dist = length(i.uv.xy); clip(1-dist);
	t = saturate(dist);	t = exp(-t*6.3);
	
	return  float4(GLOW_TINT, t * alpha * i.uv.w);
}

DepthStencilState glowDS_clipCockpit {
	DepthEnable = false;
	DepthWriteMask = ZERO;
	DepthFunc = GREATER_EQUAL;

	StencilEnable = TRUE;
	StencilReadMask = STENCIL_COMPOSITION_COCKPIT;
	StencilWriteMask = 0;

	FrontFaceStencilFunc = NOT_EQUAL;
	FrontFaceStencilPass = KEEP;
	FrontFaceStencilFail = KEEP;
	BackFaceStencilFunc = NOT_EQUAL;
	BackFaceStencilPass = KEEP;
	BackFaceStencilFail = KEEP;
};

technique10 techGlow
{	
	pass emissive
	{
		SetVertexShader(CompileShader(vs_4_0, vsBillboardStaticDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsBillboardStatic()));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBillboardEmissive()));
		
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		// SetDepthStencilState(glowDS_clipCockpit, STENCIL_COMPOSITION_COCKPIT);
		// SetDepthStencilState(enableDepthBufferNoWrite, 0);
		// SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}