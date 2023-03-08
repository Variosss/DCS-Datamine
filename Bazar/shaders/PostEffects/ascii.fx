
//  8888b.   dP""b8 .dP"Y8     888888 888888    db    8b    d8     
//   8I  Yb dP   `" `Ybo."       88   88__     dPYb   88b  d88     
//   8I  dY Yb      o.`Y8b       88   88""    dP__Yb  88YbdP88     
//  8888Y"   YboodP 8bodP'       88   888888 dP""""Yb 88 YY 88   

#include "common/Samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "common/dithering.hlsl"
#include "common/random.hlsl"

float2 dims;
float overload;
Texture2D source;
Texture2D font;
float4	viewport;
float3 direction; //= float3(0,0,1);//TODO: протащить

static const float3 fontColor = float3(0,1,0);//когда матрица отключена
static const float2 fontdims = float2(16.0/256, (32/256.0));
static const int2   d    = int2(8,16);

static const float  matrixPower = 0.40;
static const float  matrixSpeed = 1.0 / 16;
static const float  matrixScaleY = 1.2;//по вертикали
static const float3 firstCharColor = float3(0, 1.0, 0.7);
static const float3 lastCharColor = float3(0, 1.0, 0.1);
static const float3 matrixColorFactor = float3(5, 5, 15);
static const float  gradientLum = 0.7;
static const float	gradientFactor = 3;

#define SCREEN_3D_NOISE	1
#define DCS_RAINDROPS	1

struct VS_OUTPUT {
	float4 pos:			SV_POSITION0;
	float2 texCoord:	TEXCOORD0;
	float4 projPos:		TEXCOORD1;
};

static const float2 quad[4] = {
	float2(-1, -1),
	float2( 1, -1),
	float2(-1,  1),
	float2( 1,  1),
};


const static int lettercount = 17;
const static int ascii[] = {'W', 'M', 'B', 'K', '6', 'G', '$', 'Y', 'F', 'L', 's', '<', '+', '^', '_', ':', '\'', ' '};


VS_OUTPUT VS(uint vid: SV_VertexID)
{
	VS_OUTPUT o;
	float2 p = quad[vid];
	o.pos = o.projPos = float4(p, 0, 1);
	o.texCoord = float2(p.x*0.5 + 0.5, -p.y*0.5 + 0.5)*viewport.zw + viewport.xy;
	return o;
}

float4 fonttext2(int letter)
{
	const float2 CellSize = fontdims;
	const float2 CellOffset = float2(0, 0);

    // Determine the texture coordinates:
    letter = clamp(letter - 32, 0, 96);
    int row = letter / 16;
    int col = letter % 16;
    float S0 = CellOffset.x + CellSize.x * col;
    float T0 = CellOffset.y + CellSize.y * row;
    float S1 = S0 + CellSize.x - CellOffset.x;
    float T1 = T0 + CellSize.y;
	return float4(S0, T0, S1, T1);
}

float4 bc(float4 pixelColor, float Brightness, float Contrast)
{
	pixelColor.rgb /= pixelColor.a;
	pixelColor.rgb = ((pixelColor.rgb - 0.5f) * max(Contrast, 0)) + 0.5f;
	pixelColor.rgb += Brightness;
	pixelColor.rgb *= pixelColor.a;
	return pixelColor;
}

float3 sampleAvarageColor(float2 tileindex)
{
	float3 col = float3(0,0,0);
	for (int i = 0; i < d.x ; i++)
	{
		for (int j = 0 ; j < d.y; j++)
		{
		    float2 tc = (tileindex + float2(i,j))/dims;
			col += bc(source.Sample(ClampLinearSampler, tc), 0.2, 1.0).xyz;
		}
	}
	return col/(d.x*d.y);
}

float hash(in float3 p, in float scale)
{
	// This is tiling part, adjusts with the scale...
	p = fmod(p, scale);
	return frac(sin(dot(p, float3(27.16898, 38.90563, 49.40573))) * 5151.5473453);
}

float noise3d(in float3 p, in float scale)
{
	float3 f;
	
	p *= scale;
	
	f = frac(p);
	p = floor(p);
	
	f = f*f*(3.0-2.0*f);
	
	float resA = lerp(lerp(hash(p + float3(0.0, 0.0, 0.0), scale),
						hash(p + float3(1.0, 0.0, 0.0), scale), f.x),
					lerp(hash(p + float3(0.0, 1.0, 0.0), scale),
						hash(p + float3(1.0, 1.0, 0.0), scale), f.x), f.y);

	float resB = lerp(lerp(hash(p + float3(0.0, 0.0, 1.0), scale),
						hash(p + float3(1.0, 0.0, 1.0), scale), f.x),
					lerp(hash(p + float3(0.0, 1.0, 1.0), scale),
						hash(p + float3(1.0, 1.0, 1.0), scale), f.x), f.y);

	return lerp(resA,resB,f.z);
}

struct MatrixData
{
	float3	color;
	float	columnRnd;
	float	charMask[3];//0 - первый символ
};

MatrixData getMatrixColor(float2 pixel)
{
	float2 tilesCount = dims / d;
	float2 tileIndex = floor(pixel / d);

	float tilesY = floor(tilesCount.y * matrixScaleY);

	MatrixData o;
	o.columnRnd = noise1(tileIndex.x*41.5123127+0.4123);
	// float columnGrad = fmod(2 + tileIndex.y / (tilesCount.y * matrixScaleY) + o.columnRnd - fmod(gModelTime*matrixSpeed,1), 1.0);
	float columnGrad = fmod(2 + tileIndex.y / tilesY + o.columnRnd - fmod(gModelTime*matrixSpeed,1), 1.0);

	o.charMask[0] = ((columnGrad * tilesY) > (tilesY-1));
	o.charMask[1] = ((columnGrad * tilesY) > (tilesY-2)) && ((columnGrad * tilesY) < (tilesY-1));
	o.charMask[2] = ((columnGrad * tilesY) > (tilesY-3)) && ((columnGrad * tilesY) < (tilesY-2));

	float matrixMask = (o.charMask[0]>0? 1 : gradientLum) * pow(columnGrad, gradientFactor);

	o.color = lerp(lastCharColor, firstCharColor, pow(columnGrad, matrixColorFactor));

	o.color *= lerp(1, matrixMask, matrixPower);

	return o;
}

float3 getColor(float2 pixel)
{
	float2 tilesCount = dims / d;
	float2 tileindex = pixel - trunc(pixel % d);

	float3 col = sampleAvarageColor(tileindex);

	const float luminance = 1-dot(col, 0.3333);

	MatrixData md = getMatrixColor(pixel);

	int letterOriginal = ascii[min(24*luminance, 24)];

#if DCS_RAINDROPS
	int letter = md.charMask[0]>0 ? 'S' : md.charMask[1]>0 ? 'C' : md.charMask[2] ? 'D' : letterOriginal;
	letter = noise1(md.columnRnd+33.12312)>0.85 ? letter : letterOriginal;
#else
	int letter = letterOriginal;
#endif

	float4 fonttc = fonttext2(letter);
	float2 len = float2(1.0/16.0, (1.0/8.0));//fonttc.zw - fonttc.xy;
	float2 offset = len * float2(fmod(pixel, d) / d);

	float fontMask = font.SampleLevel(ClampLinearSampler, fonttc.xy + offset, 0);

	// float3 resultColor = lerp(fontColor.rgb, source.SampleLevel(ClampLinearSampler, tileindex/dims, 0).rgb, 0.5);

	// return fontMask * lerp(resultColor, getMatrixColor(pixel), matrixPower);
	return fontMask * md.color;
}

float3 overloadEffect(float4 InColor, float3 fontcolor, float2 pixel, float4 projPos)
{
	float overll = saturate((overload-0.2)/0.75);

#if 0
	float r = length(dims/2 - pixel)/length(dims) + 0.5;
	float cr = 1-overll;
	return lerp(InColor, float4(fontcolor, 1), smoothstep(cr, cr*1.2, r));
#else
	float2 tileSize = d;
	float2 tilesCount = dims / tileSize;
	float2 tile = pixel / tileSize;

	projPos /= projPos.w;
	// projPos.xy = (floor((projPos.xy/2)*tilesCount) / tilesCount) * 2;
	projPos.xy = (floor(pixel / d) * d) / dims * 2 - 1;
	projPos.y = -projPos.y;

	float4 v = mul(projPos, gProjInv);
	float4 v2 = mul(float4(-1,-1, 0.5, 1), gProjInv);
	float3 view = normalize(v.xyz/v.w);
	float3 view2 = normalize(v2.xyz/v2.w);

	float4 vw = mul(projPos, gViewProjInv);
	float3 wview = normalize(vw.xyz/vw.w);

	// float dd = view.z;
	float dd = dot(view, direction);
	// float ddmin = view2.z;//граница экрана
	float ddmin = 0.5;//120 град угол
	float range = 1-ddmin;

	float grad = saturate((dd - ddmin) / (1-ddmin));//от центра экрана

	float overl = abs(overll);

	float noiseDepth = 0.9;

#if SCREEN_3D_NOISE
	float screenNoise = noise3d(wview, 6);
#else
	float screenNoise = smoothNoise2(projPos.xy * float2(1, 0.5/gProj._11) * 7);
#endif

	float val = saturate(overl * pow(1-grad, 10-overl*9)*10);
	val = pow(saturate((screenNoise - 1)*noiseDepth + 2*val + overl*overl*0.4), 0.3);
	val = lerp(val, 1, pow(saturate((overl-0.8)/0.2), 2));


	float ditheredOverloadMask = dither_ordered8x8(tile) < val;
	return lerp(InColor, fontcolor, ditheredOverloadMask);
#endif
}

float3 PS(VS_OUTPUT i): SV_TARGET0 {
	float4 InColor = source.Sample(WrapPointSampler, i.texCoord);

	float2 pixel = (float2(i.projPos.x, -i.projPos.y)*0.5+0.5) * dims;
 
	float3 fontcolor = getColor(pixel);
	return overloadEffect(InColor, fontcolor, pixel, i.projPos);
}

technique10 tech {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
