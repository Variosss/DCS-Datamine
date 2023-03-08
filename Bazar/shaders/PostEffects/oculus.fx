#include "../common/states11.hlsl"
#include "../common/samplers11.hlsl"

float4x4 View;
float4x4 Texm;

Texture2D Texture;
float3 DistortionClearColor;
float  EdgeFadeScale;
float2 EyeToSourceUVScale;
float2 EyeToSourceUVOffset;
float2 EyeToSourceNDCScale;
float2 EyeToSourceNDCOffset;
float2 TanEyeAngleScale;
float2 TanEyeAngleOffset;
float4 HmdWarpParam;
float4 ChromAbParam;

// Scales input texture coordinates for distortion.
// ScaleIn maps texture coordinates to Scales to ([-1, 1]), although top/bottom will be larger due to aspect ratio.

struct VS_INPUT {
	float4 Position: POSITION;
};

struct VS_OUTPUT {
	float4 Position: SV_POSITION;
	float2 TexCoord: TEXCOORD0;
};

VS_OUTPUT VS(VS_INPUT i) {
	VS_OUTPUT o;
    o.Position = mul(View, i.Position);
    o.TexCoord = mul(Texm, float4(i.Position.x, 1-i.Position.y, 0,1)).xy;
	return o;
}

float4 PS(VS_OUTPUT i): SV_TARGET0 {
	

// Input i.TexCoord is [-1,1] across the half of the screen used for a single eye.
  float2 TanEyeAngleDistorted = i.TexCoord * TanEyeAngleScale + TanEyeAngleOffset; // Scales to tan(thetaX),tan(thetaY), but still distorted (i.e. only the center is correct)
  float  rSq = TanEyeAngleDistorted.x * TanEyeAngleDistorted.x + TanEyeAngleDistorted.y * TanEyeAngleDistorted.y;
  float Distort = rcp(HmdWarpParam.x + rSq * ( HmdWarpParam.y + rSq * ( HmdWarpParam.z + rSq * ( HmdWarpParam.w ) ) ) );
  float DistortR = Distort * ( ChromAbParam.x + rSq * ChromAbParam.y );
  float DistortG = Distort;
  float DistortB = Distort * ( ChromAbParam.z + rSq * ChromAbParam.w );
  float2 TanEyeAngleR = DistortR * TanEyeAngleDistorted;
  float2 TanEyeAngleG = DistortG * TanEyeAngleDistorted;
  float2 TanEyeAngleB = DistortB * TanEyeAngleDistorted;

// These are now in "TanEyeAngle" space.
// The vectors (TanEyeAngleRGB.x, TanEyeAngleRGB.y, 1.0) are real-world vectors pointing from the eye to where the components of the pixel appear to be.
// If you had a raytracer, you could just use them directly.

// Scale them into ([0,0.5],[0,1]) or ([0.5,0],[0,1]) UV lookup space (depending on eye)
   float2 SourceCoordR = TanEyeAngleR * EyeToSourceUVScale + EyeToSourceUVOffset;
   float2 SourceCoordG = TanEyeAngleG * EyeToSourceUVScale + EyeToSourceUVOffset;
   float2 SourceCoordB = TanEyeAngleB * EyeToSourceUVScale + EyeToSourceUVOffset;

// Find the distance to the nearest edge.

   float2 NDCCoord = TanEyeAngleG * EyeToSourceNDCScale + EyeToSourceNDCOffset;
   float EdgeFadeIn = 0.15 * ( 1.0 - max ( abs ( NDCCoord.x ), abs ( NDCCoord.y ) ) );
   if ( EdgeFadeIn < 0.0 )
   {
       return float4(DistortionClearColor.r, DistortionClearColor.g, DistortionClearColor.b, 1.0);
   }
   EdgeFadeIn = saturate ( EdgeFadeIn );

// Actually do the lookups.
   float ResultR = Texture.Sample(ClampLinearSampler,SourceCoordR).r;
   float ResultG = Texture.Sample(ClampLinearSampler,SourceCoordG).g;
   float ResultB = Texture.Sample(ClampLinearSampler,SourceCoordB).b;

   return float4(ResultR, ResultG, ResultB, 1.0);
}

technique10 Warp
{
    pass P0
    {          
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
    }
}

