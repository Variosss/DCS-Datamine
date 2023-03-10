#include "common/BC.hlsl"

Texture2D MFDMap1;
Texture2D MFDMap2;

float3 pc0;
float4 pc1;

float2 b;	// bightness <0,>0
float c;
float gamma;
float brightnessMax;

float3 params;

struct VertexInput{
	float3 vPosition:	POSITION;
	float2 vTexCoord0:	TEXCOORD0;
};

struct VertexOutput{
	float4 vPosition:	SV_POSITION;
	float2 vTexCoord0:	TEXCOORD0;
};

VertexOutput vsSimpleMFD(const VertexInput i){
	VertexOutput o;

	o.vPosition = mul(float4(i.vPosition, 1.0), matWorldViewProj);	
	o.vTexCoord0 = i.vTexCoord0;
	
	return o;
}

//from graphicsxp\Include\Renderer\BrightnessContrastAlgorithm.h
//http://en.wikipedia.org/wiki/Image_editing#Contrast_change_and_brightening
//	struct BrightnessContrastAlgorithm
//	{
//		float b,c;
//		//brightness contrast in range of 0..1 , (common usage for avionic)
//		BrightnessContrastAlgorithm(float brightness,float contrast)
//		{
//			const float range_modifier = 0.8f;
//			b = range_modifier * 2.0f * (brightness - 0.5f);
//			c = range_modifier * 2.0f * (contrast   - 0.5f);
//			c = tan((c + 1.0f) * PI/4.0f);
//		}
//		inline float process(float value)
//		{
//			//where value is the input color value in the 0..1 range and b and c are in the -1..1 range.
//			if (b < 0.0f) value = value * (1.0f + b);
//			else		  value = value + (1.0f - value) * b;
//			value = (value - 0.5f) * c + 0.5f;
//			return std::min(value,1.0f);
//		};
//};



float4 source(const VertexOutput i)
{
	float4 pixelColor = MFDMap1.SampleBias(WrapLinearSampler, i.vTexCoord0, gMipLevelBias);
	pixelColor.rgb    = pow(pixelColor.rgb, gamma);
	return pixelColor;
}

float4 applyMask(const VertexOutput i, float4 value)
{
	float4 maskColor = MFDMap2.SampleBias(WrapPointSampler, i.vTexCoord0, gMipLevelBias);
	float3 val = value.rgb * maskColor.rgb * brightnessMax;
	return float4(val,value.a * maskColor.a);
}

float4 BC(const VertexOutput i, float4 value)
{
	value.rgb = value.rgb * (1 + b.x) + (1.0f - value.rgb) * b.y;
	value.rgb = saturate((value.rgb - 0.5f) * c + 0.5f);
	return applyMask(i,value);
}



float4 ps_COLORED_b(const VertexOutput i): SV_TARGET0 {
	float4 pixelColor = source(i);
	return saturate( BC(i, pixelColor * float4(pc0, 1) + pc1) );
}

float4 ps_COLORED_b_1(const VertexOutput i) : SV_TARGET0 {
	float4 c = source(i) * float4(pc0, 1) + pc1;
	c.xyz = BCM(c.xyz, params.x, params.y, params.z);
	return applyMask(i,c);
}

float4 ps_BW_b(const VertexOutput i): SV_TARGET0 {
	float4 pixelColor = source(i);
//	return BC(i, dot(pixelColor.rgb, pc0) + pc1);
	return BC(i, float4(dot(pixelColor.rgb, pc0).xxx + pc1.xyz, pixelColor.w) );
}

float4 ps_BW_b_1(const VertexOutput i) : SV_TARGET0 {
	float4 c = source(i);
	c = dot(c.rgb, pc0) + pc1;
	c.xyz = BCM(c.xyz, params.x, params.y, params.z);
	return applyMask(i,c);
}

technique10 Colored_b {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, vsSimpleMFD()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_COLORED_b()));
		SetRasterizerState(cullNone);            
	}
	pass P1 {
		SetVertexShader(CompileShader(vs_4_0, vsSimpleMFD()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_COLORED_b_1()));
		SetRasterizerState(cullNone);
	}
}

technique10 BW_b {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, vsSimpleMFD()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_BW_b()));
		SetRasterizerState(cullNone);
	}
	pass P1 {
		SetVertexShader(CompileShader(vs_4_0, vsSimpleMFD()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_BW_b_1()));
		SetRasterizerState(cullNone);
	}
}

