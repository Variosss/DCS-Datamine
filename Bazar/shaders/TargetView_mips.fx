#include "common/States11.hlsl"
#include "common/Samplers11.hlsl"
#include "common/TextureSamplers.hlsl"

Texture2D Target;

float4x4 ViewProjectionMatrix;
float opacity;
float zoominv;
int3 dims;
int  channel;
float value_pow;

struct VS_OUTPUT {
	float4 vPosition		: SV_POSITION;
	float2 vTexCoord		: TEXCOORD0;
};

VS_OUTPUT vsMain(float3 pos : POSITION0, float2 tc : TEXCOORD0) {
	VS_OUTPUT o;

	o.vPosition = mul(float4(pos,1.0), ViewProjectionMatrix);
	o.vTexCoord = (tc-float2(0.5, 0.5))*zoominv + float2(0.5, 0.5);

	return o;
}

float4 psSolidTech(VS_OUTPUT input, uniform uint mip) : SV_TARGET0 {
	float4 color = Target.SampleLevel(gTrilinearClampSampler, input.vTexCoord, mip);
	color.a = opacity;
	return color;
}

VertexShader vsMainCompiled = CompileShader(vs_4_0, vsMain());

#define TECH_BODY(mip) { \
	pass p0 {\
		SetVertexShader(vsMainCompiled); \
		SetGeometryShader(NULL); \
		SetPixelShader( CompileShader(ps_4_0, psSolidTech(mip) ) );\
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
		SetRasterizerState(cullNone); \
		SetDepthStencilState(disableDepthBuffer, 0); \
	} \
}


technique10 mip0		TECH_BODY(0)
technique10 mip1		TECH_BODY(1)
technique10 mip2		TECH_BODY(2)
technique10 mip3		TECH_BODY(3)
technique10 mip4		TECH_BODY(4)
technique10 mip5		TECH_BODY(5)
technique10 mip6		TECH_BODY(6)
technique10 mip7		TECH_BODY(7)

