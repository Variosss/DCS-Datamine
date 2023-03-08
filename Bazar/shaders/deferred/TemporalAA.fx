#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "deferred/DecoderCommon.hlsl"
#include "deferred/GBuffer.hlsl"

float4	g_ColorBufferViewport;
float2	g_ColorBufferSize;

TEXTURE_2D(float4, frame);
TEXTURE_2D(float4, framePrev);

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

float2 transformColorBuffer(float2 uv) {
	return (uv*g_ColorBufferViewport.zw+g_ColorBufferViewport.xy)*g_ColorBufferSize;
}

float2 calcFarVelocity(float2 projPos) {
	float4 prevProj = mul(float4(projPos, 0, 1), gPrevFrameTransform);
	return projPos.xy - prevProj.xy / prevProj.w;
}

float4 PS(const VS_OUTPUT i, uint sidx: SV_SampleIndex): SV_TARGET0 {
//	return float4(SampleMap(frame, i.pos.xy, sidx).xyz, 1);	// source

	float2 v = (SampleMapArray(GBufferMap, i.pos.xy, 5, 0).xy - 127.0 / 255.0) * 2;	// restore velocity
	v *= (gPrevFrameTimeDelta / VELOCITY_MAP_SCALE);	// restore SS offset

	float2 uv = i.projPos - v;

	float weight = saturate(1 - length(v) * 100);	// clamp by max velocity
	weight *= 1 - any(step(1, abs(uv.xy)));			// skip out of screen bound


	return float4( (SampleMap(frame, i.pos.xy, sidx).xyz + SampleMap(framePrev, transformColorBuffer(float2(uv.x, -uv.y)*0.5+0.5), sidx).xyz*weight)/(1 + weight), 1);

	return float4(weight, 0,0,1);

}

//float4 PS_COPY(const VS_OUTPUT i, uint sidx: SV_SampleIndex): SV_TARGET0 {
//	return SampleMap(ComposedTex, i.pos.xy, sidx); 
//}

technique10 Compose {
	pass P0 {
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, PS()));
		
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}	
}

