#include "common/samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "noise/noise3D.hlsl"
#include "noise/noise2D.hlsl"

float4x4 VP; 

Texture2D Tex;
float	blendFactor;
float	displaceFactor;


Texture2DArray TexArray;
float2	dir;
float2 texelSize;
float frameRate, frameOffset, displaceMult;
int frameCount;

struct VS_INPUT
{
    float3 pos   		: POSITION0; 
    float2 texCoord  	: TEXCOORD0; 
    float2 normal  		: TEXCOORD1; 
};

struct VS_OUTPUT
{
    float4 pos   		: SV_POSITION0; 
    float2 texCoord  	: TEXCOORD0; 
    float2 normal  		: TEXCOORD1; 
    float3 wpos   		: REXCOORD2; 
};

#define HALF (127 / 255.0)

VS_OUTPUT VS(VS_INPUT i) {
	VS_OUTPUT o;

	o.wpos = i.pos;
	o.pos = mul(float4(i.pos, 1.0), VP);
	o.texCoord = i.texCoord;
	o.normal = normalize(i.normal);

	return o;    
}

float4 KelvinWakePS(VS_OUTPUT i) : SV_TARGET0 {

	float2 bnormal = normalize(i.normal);
	float2x2 rot = float2x2(
				bnormal.x, bnormal.y,
			    -bnormal.y, bnormal.x);

	float4 normalMap = Tex.Sample(ClampLinearSampler, i.texCoord).rbga * 2.0 - 1.0;

	float bump = normalMap.a*displaceFactor * 0.5;

	normalMap.y += 2;
	float3 normal = normalize(normalMap.xyz);
	normal.xz = mul(normal.xz, rot);

	float fade = 1.0 - abs(i.texCoord.y);	
	fade = saturate(fade * blendFactor);

	normal = lerp(float3(0,1,0), normal, fade);

	float a = saturate(i.texCoord.y * 10);

	return float4(normal.xz + HALF, bump * fade * 0.5 + HALF, 0.25*a);
}

float4 FoamPS(VS_OUTPUT i) : SV_TARGET0 {
	float t = gModelTime * 0.1;

	t += snoise((i.wpos.xz + gOrigin.xz) * 0.025) * 0.5;
	float lerpFoam = cos(t * (2 * 3.14159265359)) * 0.5 + 0.5;	// sin pulse

	float foam0 = Tex.Sample(ClampLinearSampler, i.texCoord).r;
	float foam1 = Tex.Sample(ClampLinearSampler, float2(1-i.texCoord.x, i.texCoord.y)).r;
	float foam = lerp(foam0, foam1, lerpFoam);
	foam *= blendFactor;
	return float4(0, 0, 0, foam*foam);
}

float4 sampleShipWake(float3 uv) {
	float2 v0 = TexArray.Sample(gTrilinearClampSampler, uv).xy;
	float d1 = TexArray.Sample(gTrilinearClampSampler, float3(uv.x + texelSize.x, uv.yz)).x;
	float d2 = TexArray.Sample(gTrilinearClampSampler, float3(uv.x, uv.y + texelSize.y, uv.z)).x;
	float3 n = normalize( cross(float3(1, 0, (d1 - v0.x)*10), float3(0, -1, (d2 - v0.x)*10)) );
	return float4(v0.xy, n.xy);
}

float4 ShipWakePS(VS_OUTPUT i) : SV_TARGET0 {
	float2 uv = i.texCoord;

	float t = gModelTime * frameRate / frameCount - frameOffset;
	float2 phase = frac(float2(t, t + 0.5));
	float2 frame = phase * frameCount;
	float2 ft = frac(frame);
	float4 sw00 = sampleShipWake(float3(uv, (int)frame[0]));
	float4 sw01 = sampleShipWake(float3(uv, (int)(frame[0] + 1) % frameCount));
	float4 sw10 = sampleShipWake(float3(uv, (int)frame[1]));
	float4 sw11 = sampleShipWake(float3(uv, (int)(frame[1] + 1) % frameCount));
	float4 sw0 = lerp(sw00, sw01, ft[0]);
	float4 sw1 = lerp(sw10, sw11, ft[1]);
	float lerpPhase = 2 * abs(phase[0] - 0.5);						// triangle pulse
	float4 sw = lerp(sw0, sw1, lerpPhase);
		
	float2x2 rot = float2x2(
		dir.y, -dir.x,
		dir.x, dir.y);
	sw.zw = mul(-sw.zw, rot);

	float2 da = uv * 2 - 1;
	da.x *= -da.x;
	float fd= saturate((0.99 - dot(da, da)) * 10); //	fade displace around
	float ff = saturate((1 - abs(da.x)) * 10); //	fade foam by x

	float2 fblend = float2(0.5 * (1 + blendFactor), 1 - blendFactor);
	return float4(sw.zw * (blendFactor * fd) + HALF, (sw.x - HALF) * (blendFactor * fd * displaceMult) + HALF, saturate((pow(sw.y, 0.5) - fblend.y) * fblend.x * ff));
}

BlendState alphaBlend {
	BlendEnable[0] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x07; //rgb
};

BlendState alphaBlendFoam {
	BlendEnable[0] = TRUE;
	SrcBlend = ONE;
	DestBlend = ONE;
	BlendOp = ADD;
	SrcBlendAlpha = ONE;
	DestBlendAlpha = ONE;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x08; //ALPHA
};

#define COMMON_PART 		SetHullShader(NULL);			\
							SetDomainShader(NULL);			\
							SetGeometryShader(NULL);		\
							SetComputeShader(NULL);			\
							SetRasterizerState(cullNone);	

technique10 Tech {
	pass P0	{
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, KelvinWakePS()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(alphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		COMMON_PART
	}
	pass P1	{
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, FoamPS()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(alphaBlendFoam, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		COMMON_PART
//		SetRasterizerState(wireframe);
	}
	pass P2	{
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, ShipWakePS()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		COMMON_PART
	}
}

