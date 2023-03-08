#include "common/Samplers11.hlsl"
#include "common/States11.hlsl"

#define KERNEL 10

#define F_VOID 0
#define F_BLUR_Y 1
#define F_SHARPER_Y 2

#define M_WHOT 0
#define M_BHOT 1

Texture2D source;
float2	sourceDims;
float4 params;
float sharperSigma;
float4	viewport;

struct VS_OUTPUT {
	float4 pos:			SV_POSITION0;
	float2 texCoord:	TEXCOORD0;
};

static const float2 quad[4] = {
	float2(-1, -1),	float2( 1, -1),	float2(-1,  1),	float2( 1,  1),
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	float2 p = quad[vid];
	o.pos = float4(p, 0, 1);
	o.texCoord = float2(p.x*0.5 + 0.5, -p.y*0.5 + 0.5)*viewport.zw + viewport.xy;
	return o;
}

float gaussian(float x, float s) {
	return exp(-(x * x) / (2 * s * s));
}

float getIR(float2 tex_coord, uniform bool RGB_SOURCE) {
	return RGB_SOURCE ? 
			dot(source.Sample(gTrilinearClampSampler, clamp(tex_coord, viewport.xy, viewport.xy + viewport.zw)).xyz, float3(0.3333, 0.3333, 0.3333)) : 
			source.Sample(gTrilinearClampSampler, clamp(tex_coord, viewport.xy, viewport.xy + viewport.zw)).x;
}

float blur(float2 uv, float2 offs, float sigma, uniform bool RGB_SOURCE) {
	float a = getIR(uv, RGB_SOURCE);
	float aw = 1;
	[unroll]
	for (uint i = 1; i < KERNEL; ++i) {
		float w = gaussian((i * 2.0) / KERNEL, sigma);
		a += (getIR(uv + offs * i, RGB_SOURCE) + getIR(uv - offs * i, RGB_SOURCE)) * w;
		aw += w * 2;
	}
	return a / aw;
}

float sharper(float2 uv, float2 offs, float sigma, uniform bool RGB_SOURCE) {
	float a = getIR(uv, RGB_SOURCE) * (1 + sigma);
	float w = -0.5 * sigma / (KERNEL - 1);
	[unroll]
	for (uint i = 1; i < KERNEL; ++i)
		a += (getIR(uv + offs * i, RGB_SOURCE) + getIR(uv - offs * i, RGB_SOURCE)) * w;
	return a;
}

float getBlurSigma() {
	return 1024 * params[0] *     // "разрешение IR сенсора"
	 	(1.0 + 20.0*params[3]);   // управление фокусировкой (focus_factor), параметр должен быть в диапазоне [0.0.....1.0]
}

float4 PS_SHARPER(VS_OUTPUT i, uniform float2 offs, uniform bool RGB_SOURCE): SV_TARGET0 {
	return float4(sharper(i.texCoord, offs / sourceDims, sharperSigma, RGB_SOURCE).xxx, 1);
}

float4 PS_BLUR_X(VS_OUTPUT i, uniform bool RGB_SOURCE): SV_TARGET0 {
	return float4(blur(i.texCoord, float2(1.0 / sourceDims.x, 0), getBlurSigma(), RGB_SOURCE).xxx, 1);
}

float4 PS_FINAL(VS_OUTPUT i, uniform int filter, uniform int mode): SV_TARGET0 {
	float c = 0;
	switch (filter) {
	case F_VOID:
		c = getIR(i.texCoord, true);
		break;
	case F_BLUR_Y:
		c = blur(i.texCoord, float2(0, 1.0 / sourceDims.y), getBlurSigma(), false);
		break;
	case F_SHARPER_Y:
		c = sharper(i.texCoord, float2(0, 1.0 / sourceDims.y), sharperSigma, false);
		break;
	}

	// gain control
	const float gainOffset = 0.3;
	c = (c - 0.5) * pow(16.0, params[1] + gainOffset) + 0.5;

	// level control
	c += params[2];

	if (mode == M_BHOT)
		c = 1.0 - c;

	return float4(c, c, c, 1);
}

#define COMMON_PART 		SetHullShader(NULL);			\
							SetDomainShader(NULL);			\
							SetGeometryShader(NULL);		\
							SetComputeShader(NULL);			\
							SetVertexShader(CompileShader(vs_5_0, VS()));	\
							SetDepthStencilState(disableDepthBuffer, 0);	\
							SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
							SetRasterizerState(cullNone);

technique10 AdjustFLIR {
	pass P0 {
		SetPixelShader(CompileShader(ps_5_0, PS_SHARPER(float2(1, 0), true)));
		COMMON_PART
	}
	pass P1 {
		SetPixelShader(CompileShader(ps_5_0, PS_SHARPER(float2(0, 1), false)));
		COMMON_PART
	}
	pass P2 {
		SetPixelShader(CompileShader(ps_5_0, PS_BLUR_X(true)));
		COMMON_PART
	}
	pass P3 {
		SetPixelShader(CompileShader(ps_5_0, PS_BLUR_X(false)));
		COMMON_PART
	}
	pass P4	{
		SetPixelShader(CompileShader(ps_5_0, PS_FINAL(F_BLUR_Y, M_WHOT)));
		COMMON_PART
	}
	pass P5 {
		SetPixelShader(CompileShader(ps_5_0, PS_FINAL(F_BLUR_Y, M_BHOT)));
		COMMON_PART
	}
	pass P6 {
		SetPixelShader(CompileShader(ps_5_0, PS_FINAL(F_SHARPER_Y, M_WHOT)));
		COMMON_PART
	}
	pass P7 {
		SetPixelShader(CompileShader(ps_5_0, PS_FINAL(F_SHARPER_Y, M_BHOT)));
		COMMON_PART
	}
	pass P8 {
		SetPixelShader(CompileShader(ps_5_0, PS_FINAL(F_VOID, M_WHOT)));
		COMMON_PART
	}
	pass P9 {
		SetPixelShader(CompileShader(ps_5_0, PS_FINAL(F_VOID, M_BHOT)));
		COMMON_PART
	}
}

