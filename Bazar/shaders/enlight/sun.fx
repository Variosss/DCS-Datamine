#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "deferred/shadows.hlsl"

Texture2D sunTexture;
RWStructuredBuffer<float> writeCameraOcclusion;
StructuredBuffer<float> cameraOcclusion;

Texture2D<float> DepthTex;
#ifdef MSAA
	Texture2DMS<float, MSAA> DepthTexMS;
#endif

float4	DepthViewport;
float2	DepthSize;

float sunSize; // 1

static const float2 vertexOffset[4] = {
    float2(-0.5, 0.5),  float2(0.5, 0.5),
    float2(-0.5, -0.5), float2(0.5, -0.5)
};

struct psInput
{
	float4 vPosition:	SV_POSITION0;
	float2 vTexCoord:	TEXCOORD0;
};

float4 vsSun(uint vid: SV_VertexID): POSITION0 {
	return float4(0,0,0,0);
}

[maxvertexcount(4)]
void gsSun(point float3 input[1]: POSITION0, inout TriangleStream<psInput> outputStream) {
	psInput o;

	if(gSurfaceNdotL< 0)
		return;

	float sz = sunSize * (1.0+gSurfaceNdotL) * 0.5;
//	sz *= max(1.5-(gCameraPos.y+gOrigin.y)*0.0001, 0.2);
	[unroll]
	for(int i=0; i<4; ++i) {

		float3 p = gSunDirV;
		p.xy += vertexOffset[i] * sz;

		o.vPosition = mul(float4(p, 1), gProj); 
//		o.vPosition.xy /= o.vPosition.w;
//		o.vPosition.z = o.vPosition.w = 1;
		o.vTexCoord = float2(0.5, 0.5) + vertexOffset[i];
		outputStream.Append(o);
	}

	outputStream.RestartStrip();
}

float4 psSun(const psInput v, uniform bool checkOcclusion) : SV_TARGET0 {

	float a = gSurfaceNdotL*2 + gView[0][0] + gView[1][1] + gView[2][2];
	float c = cos(a);
	float s = sin(a);
	float2x2 rMat = float2x2(c, -s, s, c);

	float4 res =  (sunTexture.Sample(ClampLinearSampler, v.vTexCoord.xy)
				   + sunTexture.Sample(ClampLinearSampler, mul(v.vTexCoord.xy-float2(0.5,0.5), rMat)+float2(0.5,0.5) ) ) * 0.5;

	res.rgb *= 0.1 * gSunDiffuse.rgb * gSunIntensity * max(1.0-(gCameraPos.y+gOrigin.y)*0.00005, 0.03);

	res.a *= saturate(exp(-length(v.vTexCoord.xy*2-1)*3+0.1)-0.1);

	if(checkOcclusion)
		res.a *= cameraOcclusion[0];

	return res;
}

#define GOLDEN_ANGLE 2.39996323
#define COUNT 30

// This creates the 2D offset for the next point.
// (r-1.0) is the equivalent to sqrt(0, 1, 2, 3...)
float2 SampleGolden(in float theta, inout float r) {
    r += 1.0 / r;
	float2 delta;
	sincos(theta, delta.y, delta.x);
	return (r-1.0) * delta * 0.1;
}

float2 transformViewport(float2 uv) {
	return (uv*DepthViewport.zw+DepthViewport.xy)*DepthSize;
}

[numthreads(1, 1, 1)]
void csCameraOcclusion( uint groupIndex : SV_GroupIndex, uint3 groupId : SV_GroupId, uniform bool useMSAA) {
	float4 projPos = mul(float4(gSunDirV, 1), gProj);
	float acc = 0;
    float r = 1.0;
	for (int i = 0; i<COUNT; ++i) {
		float2 s = SampleGolden(i*GOLDEN_ANGLE, r);
		float2 suv = projPos.xy / projPos.w + s*0.025;
		if (!any(step(1, abs(suv)))) {	// check bound -1..1
			suv = transformViewport(clamp(float2(suv.x, -suv.y)*0.5 + 0.5, 0, 0.99999));
			float depth;
#ifdef MSAA
			if(useMSAA) 
				depth = DepthTexMS.Load(uint2(suv), 0).r;
			else
#endif			
				depth = DepthTex.Load(uint3(suv, 0)).r;
			acc += 1 - (depth > 0);
		}
	}
	writeCameraOcclusion[0] = acc/COUNT * SampleShadowClouds(gCameraPos);
}


technique10 Sun {
	pass P0 {
		SetVertexShader(CompileShader(vs_5_0, vsSun()));
		SetGeometryShader(CompileShader(gs_5_0, gsSun()));
		SetPixelShader(CompileShader(ps_5_0, psSun(false)));


		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

technique10 SunCheckOcclusion {
	pass P0 {
		SetVertexShader(CompileShader(vs_5_0, vsSun()));
		SetGeometryShader(CompileShader(gs_5_0, gsSun()));
		SetPixelShader(CompileShader(ps_5_0, psSun(true)));


		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

technique10 CameraOcclusion {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, csCameraOcclusion(false)));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}

#ifdef MSAA
technique10 CameraOcclusionMS {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, csCameraOcclusion(true)));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}
#endif