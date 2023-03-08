#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

float4 Y_UV_scale;
float4 U_V_offset;

Texture2D DataMap;

struct vsInput {
	float2 vPosition:	POSITION0;
};

struct vsOutput {
	float4 vPosition:	SV_POSITION0;
	float2 vUV:			TEXCOORD0;
};

static const float2 quad[4] = {
	float2(-1, -1),
	float2(1, -1),
	float2(-1, 1),	
	float2(1, 1),
};

// vsOutput vsMain(in float2 vPosition: POSITION0)
vsOutput vsMain(in uint vertId: SV_VertexID)
{
	vsOutput o;
	// o.vPosition = float4(vPosition.xy, 0, 1);
	o.vPosition = float4(quad[vertId], 0, 1);
	o.vUV = o.vPosition.xy * 0.5 + 0.5;
	return o;
}


float4 psMain(const vsOutput v) : SV_TARGET0
{
	//float4x4 yuv2rgb_ = {
	//	298.082/256.0,  298.082/256.0,  298.082/256.0, 0.0,
	//	0.0,           -100.291/256.0,  516.412/256.0, 0.0,
	//	408.583/256.0, -208.120/256.0,  0.0,           0.0,
	//	-222.921/256.0, 135.576/256.0, -276.836/256.0, 1.0
	//};
	float4x4 yuv2rgb =
	{
		1.164,  0.000,  1.596, -0.871,
		1.164, -0.392, -0.813,  0.530,
		1.164,  2.017,  0.000, -1.081,
		0.000,  0.000,  0.000,  1.000
	};

	float4 yuv;
	yuv.r = DataMap.SampleLevel(gPointClampSampler, v.vUV * Y_UV_scale.xy, 0).a; // Y
	yuv.g = DataMap.SampleLevel(gPointClampSampler, v.vUV * Y_UV_scale.zw + U_V_offset.xy, 0).a; // U
	yuv.b = DataMap.SampleLevel(gPointClampSampler, v.vUV * Y_UV_scale.zw + U_V_offset.zw, 0).a; // V
	yuv.a = 1.0;

	return mul(yuv2rgb, yuv);
}

technique10 main
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psMain()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
