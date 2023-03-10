#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"

uint2	motionVectorsDims;

Texture2D<float4> frame;
Texture2D<float4> framePrev;
Texture2D<float2> motionVectors;

static const float2 quad[4] = {
	float2(-1, -1), float2(1, -1),
	float2(-1, 1),	float2(1, 1),
};

struct VS_OUTPUT {
	float4 pos:			SV_POSITION;
	float2 projPos:		TEXCOORD0;
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.pos = float4(quad[vid], 0, 1);
	o.projPos = o.pos.xy;
	return o;
}

//float2 transformColorBuffer(float2 uv) {
//	return (uv*g_ColorBufferViewport.zw+g_ColorBufferViewport.xy)*g_ColorBufferSize;
//}

float2 calcFarVelocity(float2 projPos) {
	float4 prevProj = mul(float4(projPos, 0, 1), gPrevFrameTransform);
	return projPos.xy - prevProj.xy / prevProj.w;
}

float4 PS(const VS_OUTPUT i, uint sidx: SV_SampleIndex) : SV_TARGET0{
	/*
	//	return float4(SampleMap(frame, i.pos.xy, sidx).xyz, 1);	// source

		float2 v = (SampleMapArray(GBufferMap, i.pos.xy, 5, 0).xy - 127.0 / 255.0) * 2;	// restore velocity
		v *= (gPrevFrameTimeDelta / VELOCITY_MAP_SCALE);	// restore SS offset

		float2 uv = i.projPos - v;

		float weight = saturate(1 - length(v) * 100);	// clamp by max velocity
		weight *= 1 - any(step(1, abs(uv.xy)));			// skip out of screen bound


		return float4( (SampleMap(frame, i.pos.xy, sidx).xyz + SampleMap(framePrev, transformColorBuffer(float2(uv.x, -uv.y)*0.5+0.5), sidx).xyz*weight)/(1 + weight), 1);

		return float4(weight, 0,0,1);
	*/
		return float4(1,0,0,1);
}

float4 TEST_MOTION_VECTORS(const VS_OUTPUT i) : SV_TARGET0 {
	float2 uv = float2(i.projPos.x, -i.projPos.y) * 0.5 + 0.5;
	float3 c0 = frame.SampleLevel(gPointClampSampler, uv, 0).xyz;
	float2 mv = motionVectors.SampleLevel(gPointClampSampler, uv, 0).xy;
	float2 uv2 = uv + float2(mv.x, mv.y) / motionVectorsDims;
	float3 c1 = framePrev.SampleLevel(gTrilinearClampSampler, uv2, 0).xyz;
	return float4(abs(c0-c1), 1);
}

float4 TEST_MOTION_VECTORS2(const VS_OUTPUT i) : SV_TARGET0{
	float2 uv = float2(i.projPos.x, -i.projPos.y) * 0.5 + 0.5;
	float2 mv = motionVectors.SampleLevel(gPointClampSampler, uv, 0).xy;
	return float4 (abs(mv), 0, 1);
}


technique10 Compose {
	pass P0 {
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, PS()));
		
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}	
	pass P1 {
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, TEST_MOTION_VECTORS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	pass P2 {
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, TEST_MOTION_VECTORS2()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

