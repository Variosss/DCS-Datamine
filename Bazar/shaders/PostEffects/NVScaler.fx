#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

#define NIS_HLSL 1

Texture2D source;
float4	viewport;

cbuffer cb : register(b0) 
{
    float kDetectRatio;
    float kDetectThres;
    float kMinContrastRatio;
    float kRatioNorm;

    float kContrastBoost;
    float kEps;
    float kSharpStartY;
    float kSharpScaleY;

    float kSharpStrengthMin;
    float kSharpStrengthScale;
    float kSharpLimitMin;
    float kSharpLimitScale;

    float kScaleX;
    float kScaleY;

    float kDstNormX;
    float kDstNormY;
    float kSrcNormX;
    float kSrcNormY;

    uint kInputViewportOriginX;
    uint kInputViewportOriginY;
    uint kInputViewportWidth;
    uint kInputViewportHeight;

    uint kOutputViewportOriginX;
    uint kOutputViewportOriginY;
    uint kOutputViewportWidth;
    uint kOutputViewportHeight;

    float reserved0;
    float reserved1;
};

#define samplerLinearClamp gBilinearClampSampler
#define in_texture source
RWTexture2D<float4> out_texture;
Texture2D coef_scaler;
Texture2D coef_usm;

#include "NIS_Scaler.hlsl"

[numthreads(NIS_THREAD_GROUP_SIZE, 1, 1)]
void NV_SCALER(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID) {
    NVScaler(blockIdx.xy, threadIdx.x);
}

struct VS_OUTPUT {
	float4 pos:			SV_POSITION;
	float4 projPos:		TEXCOORD0;
};

static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.projPos = o.pos = float4(quad[vid], 0, 1);
	return o;
}

float4 PS(const VS_OUTPUT i): SV_TARGET0 {
	float2 uv = float2(i.projPos.x*0.5+0.5, -i.projPos.y*0.5+0.5)*viewport.zw + viewport.xy;
	float3 c3 = source.SampleLevel(gBilinearWrapSampler, uv, 0).rgb;
	return float4(c3, 1);
}

#define COMMON_PART         SetGeometryShader(NULL);                                                            \
                            SetHullShader(NULL);                                                                \
                            SetDomainShader(NULL);                                                              \
                            SetDepthStencilState(disableDepthBuffer, 0);                                        \
                            SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);       \
                            SetRasterizerState(cullNone);



technique10 Tech {
	pass P0 {
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, PS()));
        SetComputeShader(NULL);
        COMMON_PART
	}
    pass P1 {
        SetVertexShader(NULL);
        SetPixelShader(NULL);
        SetComputeShader(CompileShader(cs_5_0, NV_SCALER()));
        COMMON_PART
    }
}


