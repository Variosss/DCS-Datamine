#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

#define A_GPU 1
#define A_HLSL 1

#define SAMPLE_SLOW_FALLBACK 1
#define WIDTH   64
#define HEIGHT  1
#define DEPTH   1

#define samLinearClamp gBilinearClampSampler

cbuffer cb {
	uint4 Const0;
	uint4 Const1;
	uint4 Const2;
	uint4 Const3;
	uint4 Sample;
};

#if SAMPLE_SLOW_FALLBACK
    #include "ffx_a.h"
    Texture2D InputTexture;
    RWTexture2D<float4> OutputTexture;

    #define FSR_EASU_F 1
    AF4 FsrEasuRF(AF2 p) { AF4 res = InputTexture.GatherRed(samLinearClamp, p, int2(0, 0)); return res; }
    AF4 FsrEasuGF(AF2 p) { AF4 res = InputTexture.GatherGreen(samLinearClamp, p, int2(0, 0)); return res; }
    AF4 FsrEasuBF(AF2 p) { AF4 res = InputTexture.GatherBlue(samLinearClamp, p, int2(0, 0)); return res; }

    #define FSR_RCAS_F
    AF4 FsrRcasLoadF(ASU2 p) { return InputTexture.Load(int3(ASU2(p), 0)); }
    void FsrRcasInputF(inout AF1 r, inout AF1 g, inout AF1 b) {}
#else
    #define A_HALF
    #include "ffx_a.h"
    Texture2D<AH4> InputTexture;
    RWTexture2D<AH4> OutputTexture;

    #define FSR_EASU_H 1
    AH4 FsrEasuRH(AF2 p) { AH4 res = InputTexture.GatherRed(samLinearClamp, p, int2(0, 0)); return res; }
    AH4 FsrEasuGH(AF2 p) { AH4 res = InputTexture.GatherGreen(samLinearClamp, p, int2(0, 0)); return res; }
    AH4 FsrEasuBH(AF2 p) { AH4 res = InputTexture.GatherBlue(samLinearClamp, p, int2(0, 0)); return res; }

    #define FSR_RCAS_H
    AH4 FsrRcasLoadH(ASW2 p) { return InputTexture.Load(ASW3(ASW2(p), 0)); }
    void FsrRcasInputH(inout AH1 r, inout AH1 g, inout AH1 b) {}
#endif

#include "ffx_fsr1.h"

void CurrFilter_EASU(int2 pos) {
#if SAMPLE_SLOW_FALLBACK
    AF3 c;
    FsrEasuF(c, pos, Const0, Const1, Const2, Const3);
    if (Sample.x == 1)
        c *= c;
    OutputTexture[pos] = float4(c, 1);
#else
    AH3 c;
    FsrEasuH(c, pos, Const0, Const1, Const2, Const3);
    if (Sample.x == 1)
        c *= c;
    OutputTexture[pos] = AH4(c, 1);
#endif
}

void CurrFilter_RCAS(int2 pos) {
#if SAMPLE_SLOW_FALLBACK
    AF3 c;
    FsrRcasF(c.r, c.g, c.b, pos, Const0);
    if (Sample.x == 1)
        c *= c;
    OutputTexture[pos] = float4(c, 1);
#else
    AH3 c;
    FsrRcasH(c.r, c.g, c.b, pos, Const0);
    if (Sample.x == 1)
        c *= c;
    OutputTexture[pos] = AH4(c, 1);
#endif
}

void CurrFilter_BILINEAR(int2 pos) {
    AF2 pp = (AF2(pos) * AF2_AU2(Const0.xy) + AF2_AU2(Const0.zw)) * AF2_AU2(Const1.xy) + AF2(0.5, -0.5) * AF2_AU2(Const1.zw);
    OutputTexture[pos] = InputTexture.SampleLevel(samLinearClamp, pp, 0.0);
}

#define CS_BODY(Name, CurrFilter) [numthreads(WIDTH, HEIGHT, DEPTH)]                                                    \
void Name(uint3 LocalThreadId : SV_GroupThreadID, uint3 WorkGroupId : SV_GroupID, uint3 Dtid : SV_DispatchThreadID) {   \
    AU2 gxy = ARmp8x8(LocalThreadId.x) + AU2(WorkGroupId.x << 4u, WorkGroupId.y << 4u);                                 \
    CurrFilter(gxy);                                                                                                    \
    gxy.x += 8u;                                                                                                        \
    CurrFilter(gxy);                                                                                                    \
    gxy.y += 8u;                                                                                                        \
    CurrFilter(gxy);                                                                                                    \
    gxy.x -= 8u;                                                                                                        \
    CurrFilter(gxy);                                                                                                    \
}

CS_BODY(CS_EASU, CurrFilter_EASU)
CS_BODY(CS_RCAS, CurrFilter_RCAS)
CS_BODY(CS_BILINEAR, CurrFilter_BILINEAR)

#define COMMON_PART         SetVertexShader(NULL);                                                              \
                            SetPixelShader(NULL);                                                               \
                            SetGeometryShader(NULL);                                                            \
                            SetHullShader(NULL);                                                                \
                            SetDomainShader(NULL);                                                              \
                            SetDepthStencilState(disableDepthBuffer, 0);                                        \
                            SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);       \
                            SetRasterizerState(cullNone);

technique10 Tech {
    pass P0 {
        SetComputeShader(CompileShader(cs_5_0, CS_EASU()));
        COMMON_PART
    }
    pass P1 {
        SetComputeShader(CompileShader(cs_5_0, CS_RCAS()));
        COMMON_PART
    }
    pass P2 {
        SetComputeShader(CompileShader(cs_5_0, CS_BILINEAR()));
        COMMON_PART
    }
}
