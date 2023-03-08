#include "../common/samplers11.hlsl"
#include "../common/states11.hlsl"

Texture2D Source;

#ifdef MSAA
	Texture2DMS<float, MSAA> DepthMap;
#else
	Texture2D<float> DepthMap;
#endif
uint2	dims;
float4	viewport;

float4x4 invProj;
float focalDistance, focalWidth;
float aspect, bokehAmount;

struct VS_OUTPUT {
	noperspective float4 pos:		SV_POSITION0;
	noperspective float2 texCoords:	TEXCOORD0;
};

static const float2 quad[4] = {
	float2(-1, -1), float2(1, -1),
	float2(-1, 1),	float2(1, 1),
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.pos = float4(quad[vid], 0, 1);
	o.texCoords = float2(o.pos.x*0.5+0.5, -o.pos.y*0.5+0.5)*viewport.zw + viewport.xy;
	return o;
}

float getBlurFactor(float dist) {
	return focalWidth * abs(focalDistance - dist)/dist;
}

float getRadius(float2 uv) {
#ifdef MSAA
	float depth = DepthMap.Load(uint2(uv*dims), 0).r;
#else
	float depth = DepthMap.Load(uint3(uv*dims, 0)).r;
#endif
	float4 p = mul(float4(uv*2-1, depth, 1), invProj);
	float f = getBlurFactor(p.z/p.w);
	return pow(f, 1.5);
}

#define ONEOVER_ITR  1.0 / ITERATIONS
#define PI 3.141596

// This is (3.-sqrt(5.0))*PI radians, which doesn't precompiled for some reason.
#define GOLDEN_ANGLE 2.39996323
#define NUMBER 150.0

#define ITERATIONS (GOLDEN_ANGLE * NUMBER)

// This creates the 2D offset for the next point.
// (r-1.0) is the equivalent to sqrt(0, 1, 2, 3...)
float2 Sample(in float theta, inout float r) {
    r += 1.0 / r;
	return (r-1.0) * float2(cos(theta), sin(theta)) * .06;
}

float3 Bokeh(Texture2D tex, float2 uv, float radius, float amount) {
	float3 acc = float3(0,0,0);
	float3 div = float3(0,0,0);
    float2 pixel = float2(aspect, 1.0) * radius * .025;
    float r = 1.0;
	for (float j = 0.0; j < ITERATIONS; j += GOLDEN_ANGLE) {
       	
		float2 s = Sample(j, r);
		float2 tuv = uv + pixel * s;

		// rebuild tuv
		float nr = min(getRadius(tuv), radius);
		tuv = uv + pixel * s * (nr/radius);

		float3 col = tex.Sample(ClampLinearSampler, tuv).rgb;
		float3 bokeh = float3(5.0, 5.0, 5.0) + pow(col, 9.0) * amount;
		acc += col * bokeh;
		div += bokeh;
	}
	return acc / div;
}

float4 PS(const VS_OUTPUT i): SV_TARGET0 {	
	return float4(Bokeh(Source, i.texCoords.xy, 0.5, bokehAmount), 1.0);
}

technique10 LinearDistance {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}
