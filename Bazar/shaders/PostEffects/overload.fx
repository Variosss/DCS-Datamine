#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"

Texture2D DiffuseMap;
float4	viewport;

float distortion;
float magn;

float3 direction;
float phi;		// inner cos
float theta;	// outer cos
float hypoxia;
float overload;

#ifdef MSAA
	Texture2DMS<float, MSAA> depthMap;
#else
	Texture2D<float> depthMap;
#endif
uint2	dims;

static const float3 LUM   = {0.2125f, 0.7154f, 0.0721f};
static const float3 black = {0.0, 0.0, 0.0};
static const float3 red   = {1.0, 0.0, 0.0};

struct VS_OUTPUT {
	noperspective float4 pos:		SV_POSITION0;
	noperspective float4 projPos:	TEXCOORD0;
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

static const float2 bp[8] = {
	{0, 1}, {0, -1},
	{1, 0}, {-1, 0},
	{0.707,  0.707}, {0.707,  -0.707},
	{-0.707, 0.707}, {-0.707, -0.707}
};

float3 blur(float2 uv, float d) {
   float3 res = float3(0, 0, 0);
   for(int i = 0; i<8; ++i)
	   res += DiffuseMap.Sample(ClampLinearSampler, uv + bp[i]*d).rgb;
   return res * 0.125;
}

#define BLUR_OFFS 0.005
#define EYE_OFFS 0.01

float getDistance(float2 uv) {
	#ifdef MSAA
		float depth = depthMap.Load(uint2(uv*dims), 0).r;
	#else
		float depth = depthMap.Load(uint3(uv*dims, 0)).r;
	#endif
	float4 p = mul(float4(uv*2-1, depth, 1), gProjInv);
	return p.z/p.w;
}

float4 PS(const VS_OUTPUT i, uniform bool useHypoxia, uniform bool useOverload): SV_TARGET0 {

	float4 v = mul(i.projPos, gProjInv);
	float d = dot(normalize(v.xyz/v.w), direction);

	float2 uv = float2(i.projPos.x*0.5+0.5, -i.projPos.y*0.5+0.5)*viewport.zw + viewport.xy;
	float3 color;
	if(useHypoxia) {
		float e = 1-exp(-hypoxia*10);
	//	float s = 1/(1+exp((0.5-hypoxia)*5)); // sigmoid
		float spotVal = saturate((d-phi)/min(theta-phi, -1e-9)) * e; 

		float dist = getDistance(uv);
		float dVal = min(hypoxia*hypoxia, dist*0.01);
		float3 left  = blur(uv+float2(-EYE_OFFS*dVal, 0), spotVal*BLUR_OFFS);
		float3 right = blur(uv+float2( EYE_OFFS*dVal, 0), spotVal*BLUR_OFFS);

		color = (left+right)*0.5;
		float L = dot(color, LUM);
		float bwVal = lerp(spotVal, 1, dVal);
		float blackVal = pow(1-hypoxia,0.2);
		color = lerp(color, float3(L,L,L), bwVal)*blackVal;
	} else {
	    color = DiffuseMap.Sample(ClampLinearSampler, uv).rgb;
	}

	if(useOverload) {
		float3 C = lerp(red, black, sign(overload)*0.5+0.5);
		float overl = abs(overload);
		float val = saturate(overl*(1-pow(d, 4))+pow(overl, 4));
		float blackVal = pow(1-overl, 0.5);
		color = lerp(color, C, val)*blackVal;
	}

	return float4(color,1);

}

technique10 Hypoxia {
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS(true, false)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

technique10 Overload {
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS(false, true)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

technique10 Both {
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS(true, true)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

