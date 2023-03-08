#include "../common/states11.hlsl"
#include "../common/samplers11.hlsl"

Texture2D Texture;

float2 	 EyeToSrcUVScale;
float2 	 EyeToSrcUVOffset;
float4x4 EyeRotationStart;
float4x4 EyeRotationEnd;

float2 TimewarpTexCoord(float2 TexCoord, float4x4 rotMat)
{
	// Vertex inputs are in TanEyeAngle space for the R,G,B channels (i.e. after chromatic
	// aberration and distortion). These are now "real world" vectors in direction (x,y,1)
	// relative to the eye of the HMD. Apply the 3x3 timewarp rotation to these vectors.
	float3 transformed = float3( mul ( rotMat, float4(TexCoord.xy, 1, 1) ).xyz);
	// Project them back onto the Z=1 plane of the rendered images.
	float2 flattened = (transformed.xy / transformed.z);
	// Scale them into ([0,0.5],[0,1]) or ([0.5,0],[0,1]) UV lookup space (depending on eye)
	return(EyeToSrcUVScale * flattened + EyeToSrcUVOffset);
}

struct VS_INPUT {
	float2 Position:	POSITION;
	float4 Color:		COLOR0;
	float2 TexCoord0:	TEXCOORD0;
	float2 TexCoord1:	TEXCOORD1;
	float2 TexCoord2:	TEXCOORD2;
};

struct VS_OUTPUT {
	float4 Position:	SV_Position;
	float4 Color:		COLOR;
	float2 TexCoord0:	TEXCOORD0;
	float2 TexCoord1:	TEXCOORD1;
	float2 TexCoord2:	TEXCOORD2;
};

VS_OUTPUT VS(VS_INPUT i) {
	VS_OUTPUT o;
	o.Position.x = i.Position.x;
	o.Position.y = i.Position.y;
	o.Position.z = 0.5;
	o.Position.w = 1.0;
    // Vertex inputs are in TanEyeAngle space for the R,G,B channels (i.e. after chromatic aberration and distortion).
    // Scale them into the correct [0-1],[0-1] UV lookup space (depending on eye)
	o.TexCoord0 = i.TexCoord0 * EyeToSrcUVScale + EyeToSrcUVOffset;
	o.TexCoord1 = i.TexCoord1 * EyeToSrcUVScale + EyeToSrcUVOffset;
	o.TexCoord2 = i.TexCoord2 * EyeToSrcUVScale + EyeToSrcUVOffset;
	o.Color = i.Color;             // Used for vignette fade.
	return o;
}

VS_OUTPUT VS_TIME_WARP(VS_INPUT i) {
	VS_OUTPUT o;
	
	float	 timewarpLerpFactor = i.Color.a;
	float4x4 lerpedEyeRot = lerp(EyeRotationStart, EyeRotationEnd, timewarpLerpFactor);
	
	o.TexCoord0 = TimewarpTexCoord(i.TexCoord0,lerpedEyeRot);
	o.TexCoord1 = TimewarpTexCoord(i.TexCoord1,lerpedEyeRot);
	o.TexCoord2 = TimewarpTexCoord(i.TexCoord2,lerpedEyeRot);
	o.Position  = float4(i.Position.xy, 0.5, 1.0);
	o.Color     = i.Color.r; /* For vignette fade */
	return o;
}

float4 PS(VS_OUTPUT i): SV_TARGET0 {
	float ResultR = Texture.Sample(ClampLinearSampler,i.TexCoord0).r;
    float ResultG = Texture.Sample(ClampLinearSampler,i.TexCoord1).g;
    float ResultB = Texture.Sample(ClampLinearSampler,i.TexCoord2).b;
    return float4(ResultR * i.Color.r, ResultG * i.Color.g, ResultB * i.Color.b, 1.0);
}


technique10 Warp {
	pass P0 {

		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);  
	}
}

technique10 TimeWarp {
	pass P0 {

		SetVertexShader(CompileShader(vs_4_0, VS_TIME_WARP()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);  
	}
}

