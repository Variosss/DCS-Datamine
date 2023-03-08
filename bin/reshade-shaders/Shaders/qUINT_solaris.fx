/*=============================================================================

	ReShade 4 effect file
    github.com/martymcmodding

    Copyright (c) Pascal Gilcher. All rights reserved.

	Support me:
   		paypal.me/mcflypg
   		patreon.com/mcflypg    

    * Unauthorized copying of this file, via any medium is strictly prohibited
 	* Proprietary and confidential

=============================================================================*/

/*=============================================================================
	Preprocessor settings
=============================================================================*/

#ifndef ENABLE_SOLARIS_REGRADE_PARITY
 #define ENABLE_SOLARIS_REGRADE_PARITY                 0   //[0 or 1]      If enabled, ReGrade takes HDR input from SOLARIS as color buffer instead. This allows HDR exposure, bloom and color grading to work nondestructively
#endif

/*=============================================================================
	UI Uniforms
=============================================================================*/

uniform float HDR_EXPOSURE <
	ui_type = "drag";
	ui_min = -5.0; ui_max = 5.0;
	ui_label = "Log Exposure Bias";
> = 0.0;

uniform float HDR_WHITEPOINT <
	ui_type = "drag";
	ui_min = 0.0; ui_max = 12.0;
    ui_label = "Log HDR Whitepoint";
> = 7.0;

uniform float HDR_BLOOM_INT <
	ui_type = "drag";
	ui_min = 0.0; ui_max = 1.0;
	ui_label = "Bloom Intensity";
> = 0.3;

uniform float HDR_BLOOM_RADIUS <
	ui_type = "drag";
	ui_min = 0.0; ui_max = 1.0;
	ui_label = "Bloom Radius";
> = 1.0;

uniform bool BLOOM_TONE_PRES <
    ui_label = "Preserve Tones (HDR)";
> = true;

uniform bool BLOOM_DEPTH_MASK <
    ui_label = "Mask by Depth";
> = true;

uniform float BLOOM_DEPTH_MASK_STRENGTH <
	ui_type = "drag";
	ui_min = 0.0; ui_max = 1.0;
	ui_label = "Depth Mask Strength";
> = 0.5;

uniform int HDR_BLOOM_BLEND_MODE <
	ui_type = "radio";
    ui_label = "Blend Mode";
	ui_items = "Add\0Multiply\0";
> = 0;

/*
uniform float4 tempF1 <
    ui_type = "drag";
    ui_min = -100.0;
    ui_max = 100.0;
> = float4(1,1,1,1);

uniform float4 tempF2 <
    ui_type = "drag";
    ui_min = -100.0;
    ui_max = 100.0;
> = float4(1,1,1,1);

uniform float4 tempF3 <
    ui_type = "drag";
    ui_min = -100.0;
    ui_max = 100.0;
> = float4(1,1,1,1);
*/

/*=============================================================================
	Textures, Samplers, Globals, Structs
=============================================================================*/

#define T1(x,n) ((uint(x)>>(n))>0)
#define T2(x,n) (T1(x,n)+T1(x,n+1))
#define T4(x,n) (T2(x,n)+T2(x,n+2))
#define T8(x,n) (T4(x,n)+T4(x,n+4))
#define LOG2(x) (T8(x,0)+T8(x,8))

//max screen width allowed, everything above will get downscaled
#define LOG_MAX_RES     11                  //2048
#define LOG_RES         LOG2(BUFFER_WIDTH)

#define BASE_SIZE_X     (1 << LOG_MAX_RES)
#define BASE_SIZE_Y     (BASE_SIZE_X * BUFFER_HEIGHT) / BUFFER_WIDTH

#define MAKE_TEXTURE(N) texture Bloom##N { Width = BASE_SIZE_X >> N; Height = BASE_SIZE_Y >> N; Format = RGBA16F;  }; sampler sBloom##N { Texture = Bloom##N;  };  

MAKE_TEXTURE(0)
MAKE_TEXTURE(1)
MAKE_TEXTURE(2)
MAKE_TEXTURE(3)
MAKE_TEXTURE(4)
MAKE_TEXTURE(5)
MAKE_TEXTURE(6)

texture BloomOut { Width = BASE_SIZE_X; Height = BASE_SIZE_Y; Format = RGBA16F;  }; 
sampler sBloomOut { Texture = BloomOut; };

texture ColorInputTex : COLOR;
texture DepthInputTex : DEPTH;
sampler ColorInput 	{ Texture = ColorInputTex;};
sampler DepthInput 	{ Texture = DepthInputTex;};

#if ENABLE_SOLARIS_REGRADE_PARITY != 0
texture2D ColorInputHDRTex			    { Width = BUFFER_WIDTH;   Height = BUFFER_HEIGHT;                Format = RGBA16F; };
sampler2D sColorInputHDR			    { Texture = ColorInputHDRTex;  };
#endif

#include "qUINT\Global.fxh"
#include "qUINT\Depth.fxh"

/*=============================================================================
	Functions
=============================================================================*/

float3 srgb_to_linear(float3 srgb)
{
	return (srgb < 0.04045) ? srgb / 12.92 : pow(abs((srgb + 0.055) / 1.055), 2.4);
}

float3 linear_to_srgb(float3 lin)
{
	return (lin < 0.0031308) ? 12.92 * lin : 1.055 * pow(abs(lin), 0.41666666) - 0.055;
}

float3 sdr_to_hdr(float3 c, float w)
{    
    if(BLOOM_TONE_PRES)
        c = c * sqrt(1e-6 + dot(c, c)) / 1.733; 
    else
        c = srgb_to_linear(c);    

    float a = 1 + exp2(-w);  
    c = c / (a - c);    
    return c;
}

float3 hdr_to_sdr(float3 c, float w)
{    
    float a = 1 + exp2(-w);   
    c = a * c * rcp(1 + c);

    if(BLOOM_TONE_PRES)
    {
        c *= 1.733;
        c = c * rsqrt(sqrt(dot(c, c))+0.0001);
    }
    else   
        c = linear_to_srgb(c);    

    return c;
}

float4 tex2Dbicub(sampler tex, float2 iuv)
{
    float2 texsize = tex2Dsize(tex);
	float4 uv = 0.0;
	uv.xy = iuv * texsize;

	float2 center = floor(uv.xy - 0.5) + 0.5;
	float4 d = float4(uv.xy - center, 1 + center - uv.xy);
	float4 d2 = d * d;
	float4 d3 = d2 * d;
	float4 sd = d2 * (3 - 2 * d);	

	float4 o = lerp(d2, d3, 0.3594) * 0.2; //approx |err|*255 < 0.2 < bilinear precision
	uv.xy = center - o.zw;
	uv.zw = center + 1 + o.xy;
	uv /= texsize.xyxy;	

	float4 w = (1.0/6.0) + d * 0.5 + sd * (1.0/6.0);
	w = w.wwyy * w.zxzx;

	return w.x * tex2D(tex, uv.xy)
	     + w.y * tex2D(tex, uv.zy)
		 + w.z * tex2D(tex, uv.xw)
		 + w.w * tex2D(tex, uv.zw);
}

float4 downsample(sampler tex, float2 uv)
{
    float2 dest_size = tex2Dsize(tex);
    float2 offs_small = float2(2.0,2.0) / dest_size;
	float2 offs_large = float2(4.0,4.0) / dest_size;

    float3 offsets[13] = 
    {
        float3(0, 0, 0.5 / 4.0), //center
        float3( offs_small.x,  offs_small.y, 0.5 / 4.0),
        float3(-offs_small.x,  offs_small.y, 0.5 / 4.0),
        float3( offs_small.x, -offs_small.y, 0.5 / 4.0),
        float3(-offs_small.x, -offs_small.y, 0.5 / 4.0),
        float3( offs_large.x,  offs_large.y, 0.125 / 4.0),
        float3(-offs_large.x,  offs_large.y, 0.125 / 4.0),
        float3( offs_large.x, -offs_large.y, 0.125 / 4.0),
        float3(-offs_large.x, -offs_large.y, 0.125 / 4.0),
        float3( offs_large.x, 0, 0.25 / 4.0),
        float3(-offs_large.x, 0, 0.25 / 4.0),
        float3(0,  offs_large.y, 0.25 / 4.0),
        float3(0, -offs_large.y, 0.25 / 4.0)
    };

    float4 sum = tex2D(tex, uv + offsets[0].xy);
    float centerdepth = sum.w;
    sum *= offsets[0].z;
    float wsum = offsets[0].z;

    [branch]
    if(BLOOM_DEPTH_MASK)
    {
        [unroll]
        for(int j = 1; j < 13; j++)
        {
            float4 tap = tex2Dlod(tex, uv + offsets[j].xy, 0);
            float w = offsets[j].z * smoothstep(0, 1, pow(abs(2 * centerdepth * rcp(1e-6 + centerdepth + tap.w)), 2 * saturate(BLOOM_DEPTH_MASK_STRENGTH)));    
            sum += tap * w;
            wsum += w;
        }
    }
    else 
    {
        [unroll]
        for(int j = 1; j < 13; j++)
        {     
            sum += tex2Dlod(tex, uv + offsets[j].xy, 0) * offsets[j].z;
            wsum += offsets[j].z;
        }
    }

    return sum / wsum;  
}

float4 upsample(sampler2D tex, float2 uv)
{
    float2 dest_size = tex2Dsize(tex) * 2.0;
	float2 offs_small = 3.0 / dest_size;

    float3 offsets[9] = 
    {
        float3(0, 0, 4.0 / 16.0), //center
        float3( offs_small.x,  offs_small.y, 1.0 / 16.0),
        float3(-offs_small.x,  offs_small.y, 1.0 / 16.0),
        float3( offs_small.x, -offs_small.y, 1.0 / 16.0),
        float3(-offs_small.x, -offs_small.y, 1.0 / 16.0),
        float3( offs_small.x, 0, 2.0 / 16.0),
        float3(-offs_small.x, 0, 2.0 / 16.0),
        float3(0,  offs_small.y, 2.0 / 16.0),
        float3(0, -offs_small.y, 2.0 / 16.0)
    };
    
	float4 sum = tex2D(tex, uv + offsets[0].xy);
    float centerdepth = sum.w;
    sum *= offsets[0].z;
    float wsum = offsets[0].z;

    [branch]
    if(BLOOM_DEPTH_MASK)
    {
        [unroll]
        for(int j = 1; j < 9; j++)
        {
            float4 tap = tex2Dlod(tex, uv + offsets[j].xy, 0);
            float w = offsets[j].z * smoothstep(0, 1, pow(abs(2 * centerdepth * rcp(1e-6 + centerdepth + tap.w)), 2 * saturate(BLOOM_DEPTH_MASK_STRENGTH)));    
            sum += tap * w;
            wsum += w;
        }
    }
    else 
    {
        [unroll]
        for(int j = 1; j < 9; j++)
        {     
            sum += tex2Dlod(tex, uv + offsets[j].xy, 0) * offsets[j].z;
            wsum += offsets[j].z;
        }
    }

    return sum / wsum;  
}

//depth masking works on relative values so even though
//this scales alpha as well, it does not interfere
float layerweight(float i)
{
    return exp2(-i * 0.5 * (1 - sqrt(HDR_BLOOM_RADIUS)));
}

/*=============================================================================
	Shader Entry Points
=============================================================================*/

struct VSOUT
{
	float4                  vpos        : SV_Position;
    float2                  uv          : TEXCOORD0;    
};

VSOUT VS_Basic(in uint id : SV_VertexID)
{
    VSOUT o;
    VS_FullscreenTriangle(id, o.vpos, o.uv);
    return o;
}

void PS_Prepass(in VSOUT i, out float4 o : SV_Target0) 
{
    float2 src_size  = BUFFER_SCREEN_SIZE;
    float2 dest_size = float2(BASE_SIZE_X, BASE_SIZE_Y);

    float2 pixelratio = src_size / dest_size; //e.g 3 pixels, 3840x2160 -> 1.875, 1.054
    int2 npixels = round(pixelratio);

    o = 0;

    for(int x = 0; x < npixels.x; x++)
    for(int y = 0; y < npixels.y; y++) 
    {
        o.rgb += tex2Dlod(ColorInput, i.uv + BUFFER_PIXEL_SIZE * (-(npixels - 1) + float2(x, y) * 2), 0).rgb;
        if(BLOOM_DEPTH_MASK) o.w += Depth::get_linear_depth(i.uv + BUFFER_PIXEL_SIZE * (float2(x, y) - npixels * 0.5 + 0.5));
    }

    o /= npixels.x * npixels.y;
    o.rgb = sdr_to_hdr(saturate(o.rgb), HDR_WHITEPOINT); //this is technically not energy preserving but prevents fireflies and prevents too big hue shifts
    o.rgb *= exp2(HDR_EXPOSURE);
}

void PS_D0to1(  in VSOUT i, out float4 o : SV_Target0) { o = downsample(sBloom0, i.uv) * layerweight(1); }
void PS_D1to2(  in VSOUT i, out float4 o : SV_Target0) { o = downsample(sBloom1, i.uv) * layerweight(2); }
void PS_D2to3(  in VSOUT i, out float4 o : SV_Target0) { o = downsample(sBloom2, i.uv) * layerweight(3); }
void PS_D3to4(  in VSOUT i, out float4 o : SV_Target0) { o = downsample(sBloom3, i.uv) * layerweight(4); }
void PS_D4to5(  in VSOUT i, out float4 o : SV_Target0) { o = downsample(sBloom4, i.uv) * layerweight(5); }
void PS_D5to6(  in VSOUT i, out float4 o : SV_Target0) { o = downsample(sBloom5, i.uv) * layerweight(6); }
void PS_U6to5(  in VSOUT i, out float4 o : SV_Target0) { o =   upsample(sBloom6, i.uv); }
void PS_U5to4(  in VSOUT i, out float4 o : SV_Target0) { o =   upsample(sBloom5, i.uv); }
void PS_U4to3(  in VSOUT i, out float4 o : SV_Target0) { o =   upsample(sBloom4, i.uv); }
void PS_U3to2(  in VSOUT i, out float4 o : SV_Target0) { o =   upsample(sBloom3, i.uv); }
void PS_U2to1(  in VSOUT i, out float4 o : SV_Target0) { o =   upsample(sBloom2, i.uv); }
void PS_U1to0(  in VSOUT i, out float4 o : SV_Target0) { o =   upsample(sBloom1, i.uv); }
void PS_U0toOut(in VSOUT i, out float4 o : SV_Target0) { o =   upsample(sBloom0, i.uv); }

void PS_Blend(in VSOUT i, out float4 o : SV_Target0)
{ 
    float4 bloom = tex2Dbicub(sBloomOut, i.uv);   

    if(BLOOM_DEPTH_MASK)
    {
        float depth = Depth::get_linear_depth(i.uv);
        float bloomdepth = bloom.w;
        float depthw = smoothstep(0, 1, pow(abs(2 * depth * rcp(1e-6 + depth + bloomdepth)), 2 * saturate(BLOOM_DEPTH_MASK_STRENGTH)));     
        bloom.rgb *= depthw;
    }   

    bloom /= 7.0; //amt of textures 
    bloom /= exp2(HDR_WHITEPOINT * 0.25); //visually normalize so observed bloom intensity is agnostic of whitepoint setting
    
    float3 col = tex2D(ColorInput, i.uv).rgb;
    col = sdr_to_hdr(col, HDR_WHITEPOINT);    
    col *= exp2(HDR_EXPOSURE);   

    switch(HDR_BLOOM_BLEND_MODE)
    {
        case 0: col +=       bloom.rgb * HDR_BLOOM_INT * 10.0; break;
        case 1: col += col * bloom.rgb * HDR_BLOOM_INT * 200.0; break;
    }
     
    col = hdr_to_sdr(col, HDR_WHITEPOINT);
    o = saturate(col);
}

/*=============================================================================
	Techniques
=============================================================================*/

technique qUINT_Solaris
< ui_tooltip =
"                  >> qUINT::Solaris <<"
"\n"
"\n"
"SOLARIS is a novel approach for bloom and exposure control.\n"
"It is designed to work in tandem with REGRADE, an all-purpose\n"
"color grading effect for ReShade.\n"
"\n"
"Make sure to place this effect right before ReGrade, with no\n"
"other effects in between, as they will be ignored.\n";
>
{
    pass{VertexShader = VS_Basic;   PixelShader = PS_Prepass; RenderTarget = Bloom0; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_D0to1;   RenderTarget = Bloom1; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_D1to2;   RenderTarget = Bloom2; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_D2to3;   RenderTarget = Bloom3; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_D3to4;   RenderTarget = Bloom4; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_D4to5;   RenderTarget = Bloom5; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_D5to6;   RenderTarget = Bloom6; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_U6to5;   RenderTarget = Bloom5; BlendEnable = true;BlendOp = ADD;SrcBlend = ONE;DestBlend = ONE; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_U5to4;   RenderTarget = Bloom4; BlendEnable = true;BlendOp = ADD;SrcBlend = ONE;DestBlend = ONE; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_U4to3;   RenderTarget = Bloom3; BlendEnable = true;BlendOp = ADD;SrcBlend = ONE;DestBlend = ONE; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_U3to2;   RenderTarget = Bloom2; BlendEnable = true;BlendOp = ADD;SrcBlend = ONE;DestBlend = ONE; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_U2to1;   RenderTarget = Bloom1; BlendEnable = true;BlendOp = ADD;SrcBlend = ONE;DestBlend = ONE; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_U1to0;   RenderTarget = Bloom0; BlendEnable = true;BlendOp = ADD;SrcBlend = ONE;DestBlend = ONE; }
    pass{VertexShader = VS_Basic;   PixelShader = PS_U0toOut; RenderTarget = BloomOut; } 
#if ENABLE_SOLARIS_REGRADE_PARITY != 0
    pass{VertexShader = VS_Basic;   PixelShader = PS_Blend; RenderTarget = ColorInputHDRTex; } 
#else 
    pass{VertexShader = VS_Basic;   PixelShader = PS_Blend;    }
#endif    
}
