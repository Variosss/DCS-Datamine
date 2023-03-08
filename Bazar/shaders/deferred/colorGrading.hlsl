#ifndef COLOR_GRADING_HLSL
#define COLOR_GRADING_HLSL

#include "common/dithering.hlsl"
#include "common/colorTransform.hlsl"

//две спирали к центру
// static const uint ditherArray[8][8] =
// {
	// { 0,	1,	2,	3,	4,	5,	6,	7}, /* 8x8 Bayer ordered dithering */
	// {45,	46,	47,	48,	49,	50,	51,	8}, /* pattern. Each input pixel */
	// {44,	23,	24,	25,	26,	27,	52,	9}, /* is scaled to the 0..63 range */
	// {43,	22,	61,	62,	63,	28,	53,	10}, /* before looking in this table */
	// {42,	21,	60,	31,	30,	29,	54,	11}, /* to determine the action. */
	// {41,	20,	59,	58,	57,	56,	55,	12},
	// {40,	19,	18,	17,	16,	15,	14,	13},
	// {39,	38,	37,	36,	35,	34,	33,	32}
// };

float3 ColorGrade_Cinecolor(float3 sourceColor, float3 baseColor)
{
	float3 compColor = 1 - baseColor;//complementary color
	
	float baseLum = dot(sourceColor, baseColor) / dot(baseColor, 1);
	float compLum = dot(sourceColor, compColor) / dot(compColor, 1);
	
	baseColor *= baseLum;
	compColor *= compLum;
	
	return baseColor + compColor;
}

float3 ColorGrade_Technicolor_1(float3 sourceColor)
{
	const float3 redFilter = float3(1.0, 0.0, 0.0);
	const float3 blueGreenFilter = float3(0.0, 1.0, 0.7);
	
	float3 redRecord = sourceColor * redFilter / dot(redFilter, 1);
	float3 bluegreenRecord = sourceColor * blueGreenFilter;
	float3 bluegreenNegative = (bluegreenRecord.yyy + bluegreenRecord.zzz) / dot(blueGreenFilter, 1);
	
	return redRecord.xxx * redFilter + bluegreenNegative * blueGreenFilter;
}

float3 ColorGrade_Technicolor_2(float3 sourceColor)
{
	const float3 cyanFilter		= float3(0.0, 1.0, 0.5);
	const float3 magentaFilter	= float3(1.0, 0.0, 0.25);
	
	float3 redRecord = sourceColor * float3( 1.0, 0.0, 0.0);
	float3 bluegreenRecord = sourceColor * float3(0.0, 1.0, 1.0);
	float3 bluegreenNegative = (bluegreenRecord.yyy + bluegreenRecord.zzz) / 2.0;
	
	// float3 redOutput = redRecord.xxx + cyanFilter;
	// float3 bluegreenOutput = bluegreenNegative + magentaFilter;
	float3 redOutput = cyanFilter + (1-cyanFilter) * redRecord.xxx;
	float3 bluegreenOutput = magentaFilter + (1-magentaFilter) * bluegreenNegative;

	return lerp(sourceColor, redOutput * bluegreenOutput, 0.75);
}

float3 ColorGrade_Technicolor_ThreeStrip(float3 sourceColor, float3 baseColorxxx)
{
	float3 tc = sourceColor;
	float3 redmatte = tc.r - ((tc.g + tc.b) / 2.0);
	float3 greenmatte = tc.g - ((tc.r + tc.b) / 2.0);
	float3 bluematte = tc.b - ((tc.r + tc.g) / 2.0);
	redmatte = 1.0 - redmatte;
	greenmatte = 1.0 - greenmatte;
	bluematte = 1.0 - bluematte;
	float3 red =  greenmatte * bluematte * tc.r;
	float3 green = redmatte * bluematte * tc.g;
	float3 blue = redmatte * greenmatte * tc.b;
	float3 result = float3(red.r, green.g, blue.b);
	return lerp(tc, result, 0.7);
}

float3 ColorGrade_Funny(float3 sourceColor)
{
	sourceColor = rgb2hsv(sourceColor);
	sourceColor.x = frac(sourceColor.x + gModelTime*0.2);
	sourceColor.y = saturate(sourceColor.y + 0.3);
	sourceColor = hsv2rgb(sourceColor);
	
	float colors = 8;
	float offset = frac( 12 * gModelTime/colors) * (1.0 / colors) * 1;
	return saturate( floor((sourceColor+offset)*colors) / colors  - offset );
}

#define _ 0.0		// 0x00
#define o (1.0/3.0) // 0x01
#define b (2.0/3.0)	// 0x10
#define B 1.0		// 0x11
#define checkColor(clr) dist = distance(clr, sample); \
	if (dist < bestColorDistance.w) bestColorDistance = float4(clr, dist);

float3 ColorGrade_CGA(float3 sourceColor, uint2 uv, uniform uint palette = 1)
{
	static const float3 palette_CGA0[] = {
		float3(_,_,_),
		float3(o,B,o),
		float3(B,o,o),
		float3(B,B,o)
	};

	static const float3 palette_CGA1[] = {
		float3(_,_,_),
		float3(o,B,B),
		float3(B,o,B),
		float3(B,B,B)
	};
	
	float dist;
	float4 bestColorDistance = float4(0,0,0, 1000);
	float3 sample = sourceColor + (dither_ordered8x8(uv) - 0.5) * 0.5;

	[unroll]
	for(uint i=0; i<4; ++i)
	{
		const float3 color = palette==0 ? palette_CGA0[i] : palette_CGA1[i];
		checkColor(color);
	}
	return bestColorDistance.rgb;
}

float3 ColorGrade_EGA(float3 sourceColor, uint2 uv)
{
	float3 sample = sourceColor + (dither_ordered8x8(uv) - 0.5) * 0.5;
	float I = floor(length(sample.rgb) + 0.5) * 0.5 + 1.1;
	return floor(sample * I * 3.0) / 3.0;
	
#if 0
	static const float3 palette_EGA[] = {
		float3(_,_,_),
		float3(_,_,b),
		float3(_,b,_),
		float3(_,b,b),
		float3(b,_,_),
		float3(b,_,b),
		float3(b,o,_),
		float3(b,b,b),
		float3(o,o,o),
		float3(o,o,B),
		float3(o,B,o),
		float3(o,B,B),
		float3(B,o,o),
		float3(B,o,B),
		float3(B,B,o),
		float3(B,B,B),
	};
	const float colorDetail = 1.0;
	float dist;
	float4 bestColorDistance = float4(0,0,0, 1000);	
	sample = floor(sample*colorDetail+0.5) / colorDetail;
	[unroll]
	for(uint i=0; i<16; ++i)
	{
		checkColor(palette_EGA[i]);
	}
	return bestColorDistance.rgb;
#endif
}

#undef _
#undef o
#undef b
#undef B
#undef checkColor

#endif
