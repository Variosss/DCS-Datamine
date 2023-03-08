
Texture2D MFDMap1;
Texture2D MFDMap2;

#ifdef MSAA
	Texture2DMS<float, MSAA> DepthMap;
	static const float samplesInv = 1.0 / MSAA;
#else
	Texture2D DepthMap;
#endif

float3 pc0;
float4 pc1;

float b;
float c;

uint2 Dims;

struct VertexInput
{
	float3 vPosition:	POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

struct VertexOutput
{
	float4 vPosition:	SV_POSITION0;
	float4 vTexCoord0:	TEXCOORD0;
};

void depthTest(float2 uv, float depth)
{
#ifdef MSAA
	float depthRef = DepthMap.Load(uv, 0).r;
#else
	float depthRef = DepthMap.SampleLevel(gBilinearClampSampler, uv, 0).r;
#endif
	if(depthRef >= depth)
		discard;
}

VertexOutput vsSimpleMFD(const VertexInput i)
{
	VertexOutput o;
	o.vPosition = mul(float4(i.vPosition, 1.0), matWorldViewProj);
	o.vTexCoord0.xy = i.vTexCoord0.xy;
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

float4 BrightnessContrast(in VertexOutput i, in float4 value, uniform bool bPositive)
{
	if(bPositive)
		value.rgb = value.rgb * (1.0f - b) + b;
	else
		value.rgb = value.rgb * (1.0f + b);
	
	value.rgb = saturate((value.rgb - 0.5f) * c + 0.5f);
	float4 maskColor  = MFDMap2.Sample(WrapPointSampler, i.vTexCoord0.xy);
	return value * maskColor; 
}

float4 ps_COLORED(in VertexOutput i, uniform bool bPositive, uniform bool bReadDepth): SV_TARGET0 
{
	if(bReadDepth)
		depthTest(i.vPosition.xy, i.vPosition.z);

	float4 pixelColor = MFDMap1.Sample(WrapLinearSampler, i.vTexCoord0.xy);
	return BrightnessContrast(i,pixelColor * float4(pc0,1) + pc1, bPositive);
}

float4 ps_BW(in VertexOutput i, uniform bool bPositive, uniform bool bReadDepth): SV_TARGET0 
{
	if(bReadDepth)
		depthTest(i.vPosition.xy, i.vPosition.z);
		
	float4 pixelColor = MFDMap1.Sample(WrapLinearSampler, i.vTexCoord0.xy);
	return BrightnessContrast(i,dot(pixelColor.rgb,pc0) + pc1, true);
}

VertexShader vsSimpleComp = CompileShader(vs_4_0, vsSimpleMFD());

#define PASS(name, vs, ps) \
	pass name {\
		SetVertexShader(vs);\
		SetGeometryShader(NULL);\
		SetPixelShader(ps);\
		SetRasterizerState(cullNone);}

technique10 Colored_b_negative{
	PASS(main,			vsSimpleComp, CompileShader(ps_4_0, ps_COLORED(false, false)))
	PASS(mainWithDepth,	vsSimpleComp, CompileShader(ps_4_0, ps_COLORED(false, true)))
}

technique10 Colored_b_positive{
	PASS(main,			vsSimpleComp, CompileShader(ps_4_0, ps_COLORED(true, false)))
	PASS(mainWithDepth,	vsSimpleComp, CompileShader(ps_4_0, ps_COLORED(true, true)))
}

technique10 BW_b_negative{
	PASS(main,			vsSimpleComp, CompileShader(ps_4_0, ps_BW(false, false)))
	PASS(mainWithDepth,	vsSimpleComp, CompileShader(ps_4_0, ps_BW(false, true)))
}

technique10 BW_b_positive{
	PASS(main,			vsSimpleComp, CompileShader(ps_4_0, ps_BW(true, false)))
	PASS(mainWithDepth,	vsSimpleComp, CompileShader(ps_4_0, ps_BW(true, true)))
}

