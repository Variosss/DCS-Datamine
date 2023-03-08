#ifndef DITHERING_HLSL
#define DITHERING_HLSL

static const uint ditherArray[8][8] = 
{
	{ 0, 32, 8, 40, 2, 34, 10, 42}, /* 8x8 Bayer ordered dithering */
	{48, 16, 56, 24, 50, 18, 58, 26}, /* pattern. Each input pixel */
	{12, 44, 4, 36, 14, 46, 6, 38}, /* is scaled to the 0..63 range */
	{60, 28, 52, 20, 62, 30, 54, 22}, /* before looking in this table */
	{ 3, 35, 11, 43, 1, 33, 9, 41}, /* to determine the action. */
	{51, 19, 59, 27, 49, 17, 57, 25},
	{15, 47, 7, 39, 13, 45, 5, 37},
	{63, 31, 55, 23, 61, 29, 53, 21}
};

float dither_ordered8x8(uint2 pixel)
{
	uint2 coord = uint2(pixel.xy) % 8;
	return (ditherArray[coord.x][coord.y] + 0.5) / 64.0;
}

#endif
