#ifndef TONEMAP_HLSL
#define TONEMAP_HLSL

#include "deferred/tonemapCommon.hlsl"
#include "deferred/luminance.hlsl"
#include "common/ambientCube.hlsl"
#include "deferred/filmicCurve.hlsl"

// ACES encoding https://www.shadertoy.com/view/Mdfcz7

#define OPERATOR_LUT 0

Buffer<float>			histogram;
Texture1D<float>		tonemapLUT;

float getAvgLuminanceClamped() {
	return clamp(getAverageLuminance(), sceneLuminanceMin, sceneLuminanceMax);//todo: унести в предрасчет?
}

float getAvgLuminanceClampedCockpit() {
	return clamp(getAverageLuminanceCockpit(), sceneLuminanceMin, sceneLuminanceMax);//todo: унести в предрасчет?
}

float getLinearExposure(float averageLuminance, float exposureCorrection = 0)
{
	if(0)//old-school
	{
		const float toneMapFactor = 0.0001;
		return 0.18 / (pow(averageLuminance, dcExposureKey) + toneMapFactor);
	}
	else
	{
		float linearExposure = 0.18 / averageLuminance;

		return exp2(log2(linearExposure) + dcExposureCorrection);
	}
}

float getLinearExposureMFD(float averageLuminance) {
	const float toneMapFactor = 0.05;
	const float exposureKey = 1.3;
	return 0.5 / (pow(averageLuminance, exposureKey) + toneMapFactor);
}

/*
	//полосочками картинка
    vec2 center = vec2(iResolution.x/2., iResolution.y/2.);
    vec2 uv = fragCoord.xy;
    
    float scale = 1.;
    float radius = .5;
    vec2 d = uv - center;
    float r = length(d)/1000.;
    float a = atan(d.y,d.x) + scale*(radius-r)/radius;
    //a += .1 * iGlobalTime;
    vec2 uvt = center+r*vec2(cos(a),sin(a));
    
	vec2 uv2 = fragCoord.xy / iResolution.xy;
    float c = ( .75 + .25 * sin( uvt.x * 1000. ) );
    vec4 color = texture2D( iChannel0, uv2 );
    float l = luma( color );
    float f = smoothstep( .5 * c, c, l );
	f = smoothstep( 0., .5, f );
    
	fragColor = vec4( vec3( f ),.0);
*/

float3 ToneMap_Hejl2015(float3 color, float whitePoint) {
	float4 vh = float4(color, whitePoint);
	float4 va = (1.425 * vh) + 0.05f;
	float4 vf = ((vh * va + 0.004f) / (( vh * (va + 0.55f) + 0.0491f))) - 0.0821f;
	return vf.rgb / vf.www;
}

//http://filmicworlds.com/blog/filmic-tonemapping-with-piecewise-power-curves/
#if 0 
float3 ToneMap_Filmic_JohnHable(float3 hdrColor)
{	
	CurveParamsDirect params;
	params.m_x0 = m_x0;
	params.m_y0 = m_y0;
	params.m_x1 = m_x1;
	params.m_y1 = m_y1;
	params.m_W = m_W;
	params.m_overshootX = m_overshootX;
	params.m_overshootY = m_overshootY;
	params.m_gamma = m_gamma;
	
	FullCurve curve;
	CreateCurve(curve, params);

	return float3(FullCurveEval(curve, hdrColor.r), FullCurveEval(curve, hdrColor.g), FullCurveEval(curve, hdrColor.b));
}
#endif


float3 desturateColorHack(float3 linearColor)
{
	const float3 LUM = { 0.2125, 0.7154, 0.0721 };
	float lum = dot(linearColor, LUM);

	return lerp(lum, linearColor, sqrt( min(1, lum / sceneLuminanceMin * 0.4)) );
}

#if OPERATOR_LUT


//https://www.desmos.com/calculator/auxwpmmq3o
float3 ToneMap_Filmic_Unrealic(float3 linearColor)
{
	linearColor = desturateColorHack(linearColor);

	float3 logColor = log10(linearColor);

	float3 u = (logColor - LUTLogLuminanceMin) / (LUTLogLuminanceMax - LUTLogLuminanceMin);//todo: оптимизировать

	float3 tonmappedColor;
	tonmappedColor.r = tonemapLUT.SampleLevel(gBilinearClampSampler, u.r, 0).r;
	tonmappedColor.g = tonemapLUT.SampleLevel(gBilinearClampSampler, u.g, 0).r;
	tonmappedColor.b = tonemapLUT.SampleLevel(gBilinearClampSampler, u.b, 0).r;

	return tonmappedColor;
}
#else
float Curve(float c0, float c1, float ca, float curveSlope, float X)
{
	float t = 1 + c1 - c0;
	return 2*t / (1 + exp((2*curveSlope/t) * (X - ca))) - c1;
}

float TonemapFilmic(float logLuminance)
{
	float ta = (1-toe - 0.18) / slope - 0.733;
	float sa = (shoulder - 0.18) / slope - 0.733;

	float t = 1 + blackClip - toe;
	float s = 1 + whiteClip - shoulder;

	if(logLuminance < ta)
		return Curve(toe, blackClip, ta, -slope, logLuminance);
	else if(logLuminance < sa)
		return slope * (logLuminance + 0.733) + 0.18;
	else
		return 1 - Curve(shoulder, whiteClip, sa, slope, logLuminance);
}

float3 ToneMap_Filmic_Unrealic(float3 linearColor)
{
	linearColor = desturateColorHack(linearColor);

	float3 logColor = log10(linearColor);

	float3 outColor;
	outColor.r = TonemapFilmic(logColor.r);
	outColor.g = TonemapFilmic(logColor.g);
	outColor.b = TonemapFilmic(logColor.b);

	return outColor;
}
#endif

float3 ToneMap_Hable(float3 x)
{
	float hA = 0.15;
	float hB = 0.50;
	float hC = 0.10;
	float hD = 0.20;
	float hE = 0.02;
	float hF = 0.30;

	return ((x*(hA*x+hC*hB)+hD*hE) / (x*(hA*x+hB)+hD*hF)) - hE/hF;
}

float3 ToneMap_atmHDR(float3 L) {
	L = L < 1.413 ? (abs(L) * 0.38317) : pow(max(0, 1.0 - exp(-L)), 2.2);
	return L;
}

float3 ToneMap_Linear(float3 L) {
	return L;
}
//https://www.desmos.com/calculator/auxwpmmq3o
float3 ToneMap_Exp(float3 L) {
	return pow(max(0, 1 - exp(-L*tmPower)), tmExp);
}
//https://www.desmos.com/calculator/auxwpmmq3o
float3 ToneMap_Exp2(float3 L) {
	return (1 - exp(-L*tmPower)) * (1 - exp(-L*tmExp));
}

float3 toneMap(float3 linearColor, uniform int tonemapOperator)
{
	float3 tonmappedColor;
	
	switch(tonemapOperator)
	{
	case TONEMAP_OPERATOR_LINEAR:		tonmappedColor = ToneMap_Linear(linearColor); break;
	case TONEMAP_OPERATOR_EXPONENTIAL:	tonmappedColor = ToneMap_Exp(linearColor); break;
	case TONEMAP_OPERATOR_FILMIC:		tonmappedColor = ToneMap_Filmic_Unrealic(linearColor); break;
	// case TONEMAP_OPERATOR_FILMIC:		tonmappedColor = ToneMap_Filmic_JohnHable(linearColor); break;
	// case TONEMAP_OPERATOR_CUSTOM:		tonmappedColor = ToneMap_Custom(linearColor); break;
	}

	return tonmappedColor;
}

float3 simpleToneMapFLIR(float3 color, uniform bool gammaSpace) {
	float averageLuminance = avgLuminance[LUMINANCE_AVERAGE].x;
	float exposure = getLinearExposureMFD(averageLuminance);
	exposure = lerp(exposure, 3.5, 0.25);
	float3 tonmappedColor = ToneMap_Exp(color * exposure);
	if(gammaSpace)
		return LinearToGammaSpace(tonmappedColor);
	else
		return tonmappedColor;
}

float3 simpleToneMap(float3 color) {
	float averageLuminance = avgLuminance[LUMINANCE_AVERAGE].x;
	float exposure = getLinearExposureMFD(averageLuminance);
	float3 tonmappedColor = ToneMap_Exp(color * exposure);
	return LinearToGammaSpace(tonmappedColor);
}









#define drawGrid(uv, eps) ((abs(uv.x-0.5)<eps || abs(uv.x-1.0)<eps || abs(uv.x-1.5)<eps || abs(uv.y - 0.5)<eps) ? 1.0 : 0.0)

#define plotGrid(uv, colorOut, gridColor) {colorOut = lerp(colorOut, gridColor.rgb, gridColor.a*drawGrid(p, 2*1e-3));}

#define plotFunction(uv, p, funcName, colorOut, funcColor) { if(abs((1-p.y) - funcName(p.x).x)<0.002)\
	colorOut = lerp(colorOut, funcColor.rgb, funcColor.a);}

uint digit(float2 p, float n) {
	uint i = uint(p.y+0.5), b = uint(exp2(floor(30.000 - p.x - n*3.0)));
	i = ( p.x<=0.0||p.x>3.0? 0: i==5u? 972980223u: i==4u? 690407533u: i==3u? 704642687u: i==2u? 696556137u:i==1u? 972881535u: 0u ) / b;
	return i-(i>>1) * 2u;
}

void plotNumber(float2 p, float number, inout float3 colorOut)
{
	float2 i = p/10.0;
	for (float n=2.0; n>-4.0; n--) {
		if ((i.x-=4.)<3.) {
			colorOut = lerp(colorOut, float3(1,0,0), digit(i, floor(fmod((number+1.0e-7)/pow(10.0, n), 10.0))) );
			break;
		}
	}
}

void plotQuad(float2 pixel, float2 quadBottomLeft, float2 quadSize, float4 color, inout float3 colorOut)
{
	pixel -= quadBottomLeft;
	float alpha = color.a;
	if(!all(pixel>=0 & pixel<quadSize))
		alpha = 0;
	colorOut = color.rgb * alpha + colorOut * (1 - alpha);
}

float LuminanceToHistogramPos(float luminance)
{
	float logLuminance = log2(luminance);
	// return saturate((logLuminance - inputLuminanceMin) / (inputLuminanceMax - inputLuminanceMin));
	return saturate(logLuminance * inputLuminanceScaleOffset.x + inputLuminanceScaleOffset.y);
}

void debugDraw(float2 uvNorm, float2 pixel, inout float3 sourceColor)
{
#ifdef PLOT_TONEMAP_FUNCION
	const float plotOpacity = 0.7;
	float2 p = uvNorm * float2(2.5, 1);
	// p.x = exp2((p.x-1.5) * 5);
	p.x = pow(10, (p.x-1.5) * 2);
	// plotGrid(p, sourceColor, float4(0,0,0, 0.2*plotOpacity));
	// plotFunction(uvNorm, p, ToneMap_Custom, sourceColor, float4(1,0,0,0.5*plotOpacity));
	// plotFunction(uvNorm, p, ToneMap_atmHDR, sourceColor, float4(0,1,0,0.5*plotOpacity));
	// plotFunction(uvNorm, p, ToneMap_Linear, sourceColor, float4(0,1,0,0.5*plotOpacity));
	// plotFunction(uvNorm, p, ToneMap_Exp, sourceColor, float4(0,0,1,0.5*plotOpacity));
	plotFunction(uvNorm, p, ToneMap_Filmic_Unrealic, sourceColor, float4(0,0,1,0.5*plotOpacity));
	// plotFunction(uvNorm, p, ToneMap_Filmic_JohnHable, sourceColor, float4(0,0,0, 0.5*plotOpacity));
#endif

#ifdef PLOT_AVERAGE_LUMINANCE
	float2 lumPix = pixel;
	lumPix.y = 768 - lumPix.y;
	plotNumber(lumPix, getAvgLuminanceClamped(), sourceColor);
	// plotNumber(lumPix, log2(getAvgLuminanceClamped()+expOffset), sourceColor);
	// plotNumber(lumPix, histogram[1]/1000.0, sourceColor);
#endif

#ifdef PLOT_HISTOGRAM
	const float2 histogramPos = {50, 400};// from screen top-left, px
	const float2 histogramSize = {200, 150};//px, px
	const uint nHistogramBins = 32;
	const float4 histogramColor = float4(0.7,1,0,0.5);
	const float4 borderColor = float4(0.7,1,0,0.5);

	float binWidth = floor(histogramSize.x / nHistogramBins);

	float2 hisPix = pixel;
	hisPix.y = histogramPos.y - hisPix.y;
	[loop]
	for(uint i=0; i<nHistogramBins; ++i)
		plotQuad(hisPix, float2(histogramPos.x + (binWidth+1)*i, 0), float2(binWidth, 4*histogramSize.y*histogram[i]/1.0), histogramColor, sourceColor);
	//рамка
	float2 size = float2((binWidth+1)*nHistogramBins, histogramSize.y);
	plotQuad(hisPix, float2(histogramPos.x, 0),			 float2(1, size.y),			 borderColor, sourceColor);//vert
	plotQuad(hisPix, float2(histogramPos.x + size.x, 0), float2(1, histogramSize.y), borderColor, sourceColor);//vert
	plotQuad(hisPix, float2(histogramPos.x, -1),		 float2(size.x, 1),			 borderColor, sourceColor);//hor
	plotQuad(hisPix, float2(histogramPos.x, size.y),	 float2(size.x, 1),			 borderColor, sourceColor);//hor
	
	//средняя освещенность
	float pos = LuminanceToHistogramPos(avgLuminance[LUMINANCE_AVERAGE].x);
	plotQuad(hisPix, float2(histogramPos.x + pos * size.x, 0),			float2(1, size.y),	float4(1,1,1,0.7), sourceColor);//vertpos
	plotQuad(hisPix, float2(histogramPos.x + percentMin * size.x, 0),	float2(1, size.y),	float4(0,0,1,0.2), sourceColor);//vertpos
	plotQuad(hisPix, float2(histogramPos.x + percentMax * size.x, 0),	float2(1, size.y),	float4(0,0,1,0.2), sourceColor);//vertpos
#endif
}


#endif
