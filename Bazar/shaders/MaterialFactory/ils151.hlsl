#include "common/shadingCommon.hlsl"
#include "deferred/shading.hlsl"

Texture2D		TextureMap;
Texture2DArray	TextureArray;

float4			BlendColor;
float			Power;
float2			lineParams;

struct vsIn
{
	float3 vPosition:	POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

struct vsOutput_ils
{
	float4 vPosition:	SV_POSITION0;
	float3 vTexCoord0:	TEXCOORD0;
};

struct vsOutput_line
{
	float4 vPosition:	SV_POSITION0;
	float4 projPos:		TEXCOORD0;
	float3 wPos:		TEXCOORD1;
	float2 vTexCoord0:	TEXCOORD2;
};

vsOutput_ils vsSimpleILS(in const vsIn i, uniform bool bTexArray)
{
	vsOutput_ils o;
	o.vPosition  = mul(float4(bTexArray? float3(0, i.vPosition.yz) : i.vPosition.xyz, 1.0), matWorldViewProj);
	o.vTexCoord0 = float3(i.vTexCoord0.xy, bTexArray ? i.vPosition.x : 0);
	return o;
}

float4 psTex(in vsOutput_ils i, uniform bool bTexArray, uniform bool sRGB): SV_TARGET0
{
	float4 tex = bTexArray? TextureArray.SampleBias(WrapLinearSampler, i.vTexCoord0.xyz, gMipLevelBias) : TextureMap.SampleBias(WrapLinearSampler, i.vTexCoord0.xy, gMipLevelBias);
	//clip(tex.a-0.02);

	if (sRGB)
		tex.xyz = GammaToLinearSpace(tex.xyz);

	// alpha separate
	float3 color = (pow(abs(tex.rgb), Power) * BlendColor.rgb) / pow(0.99, Power);
	float alpha =  tex.a * BlendColor.a;
	return float4(color, alpha);
}


//always array
float4 psUITTF(in vsOutput_ils i): SV_TARGET0
{
	float4 tex 		= TextureArray.SampleBias(WrapLinearSampler, i.vTexCoord0.xyz, gMipLevelBias).rrrg;
	// alpha separate
	float3 color 	= (pow(abs(tex.rgb), Power) * BlendColor.rgb) / pow(0.99, Power);
	float alpha 	=  tex.a * BlendColor.a;
	return float4(color, alpha);
}


float4 psTexA8(in vsOutput_ils i, uniform bool bTexArray): SV_TARGET0
{
	float tex = bTexArray? TextureArray.SampleBias(WrapLinearSampler, i.vTexCoord0.xyz, gMipLevelBias).a : TextureMap.SampleBias(WrapLinearSampler, i.vTexCoord0.xy, gMipLevelBias).a;
	clip(tex-0.02);

	// alpha separate
	float3 color = BlendColor.rgb / pow(0.99, Power);
	float alpha =  tex * BlendColor.a;
	return float4(color, alpha);
}

float4 vsWithoutTexture(float3 vPosition: POSITION): SV_POSITION0 {
	return mul(float4(vPosition, 1.0), matWorldViewProj);
}

float4 psWithoutTexture(): SV_TARGET0 {
	return BlendColor;
}

void vsLine(float3 pos: POSITION0, out float4 vPos: POSITION0)
{
	vPos = mul( mul(float4(pos, 1.0), matWorldViewProj), gProjInv);
	vPos /= vPos.w;
}

#define addVert(pos) o.vPosition = mul(pos, gProj); outStream.Append(o);

#define addVert2(pos, padd, uv) o.vTexCoord0.xy = uv.xy; \
								o.wPos = float3(pos.xy + mul(padd.xy, M), pos.z); \
								o.vPosition = o.projPos = mul(float4(o.wPos, 1), gProj); \
								o.wPos = mul(float4(o.wPos, 1.0), gViewInv).xyz;\
								outStream.Append(o);

#define addVertL(padd, uv) 	addVert2(vPos[0], padd, uv)
#define addVertR(padd, uv) 	addVert2(vPos[1], padd, uv)

[maxvertexcount(24)]
void gsLine(line float4 vPos[2] : POSITION0, inout TriangleStream<vsOutput_line> outStream)
{
	static const float width = lineParams.x;
	static const float p = lineParams.y; //padding
	static const float uvOffset = 0.0;

	const float width2 = width * 0.5;
	float2 dir = normalize(vPos[1].xy - vPos[0].xy);
	float2x2 M = {dir.xy, -dir.y, dir.x};
	vsOutput_line o;

	//начальная крышка
	addVertL(float2(-p, 	width2 + p), float2(0.0 - uvOffset, 1.0 + uvOffset));
	addVertL(float2(0, 		width2 + p), float2(0.5, 1.0 + uvOffset));

	addVertL(float2(-p, 	width2), float2(0.0 - uvOffset, 0.5));
	addVertL(float2(0, 		width2), float2(0.5, 0.5));

	addVertL(float2(-p,		-width2), float2(0.0 - uvOffset, 0.5));
	addVertL(float2(0,		-width2), float2(0.5, 0.5));

	addVertL(float2(-p,		-width2 - p), float2(0.0 - uvOffset, 0.0 - uvOffset));
	addVertL(float2(0,		-width2 - p), float2(0.5, 0.0 - uvOffset));	
	outStream.RestartStrip();

	//центральная линия
	addVertL(float2(0, 	width2 + p), float2(0.5, 1.0 + uvOffset));
	addVertR(float2(0, 	width2 + p), float2(0.5, 1.0 + uvOffset));
	
	addVertL(float2(0, 	width2), float2(0.5, 0.5));
	addVertR(float2(0, 	width2), float2(0.5, 0.5));

	addVertL(float2(0,	-width2), float2(0.5, 0.5));
	addVertR(float2(0,	-width2), float2(0.5, 0.5));

	addVertL(float2(0,	-width2 - p), float2(0.5, 0.0 - uvOffset));
	addVertR(float2(0,	-width2 - p), float2(0.5, 0.0 - uvOffset));
	outStream.RestartStrip();

	//конечная крышка
	addVertR(float2(0, 	width2 + p), float2(0.5, 1.0 + uvOffset));
	addVertR(float2(p, 	width2 + p), float2(1.0 + uvOffset, 1.0 + uvOffset));
	
	addVertR(float2(0, 	width2), float2(0.5, 0.5));
	addVertR(float2(p, 	width2), float2(1.0 + uvOffset, 0.5));

	addVertR(float2(0,	-width2), float2(0.5, 0.5));
	addVertR(float2(p,	-width2), float2(1.0 + uvOffset, 0.5));

	addVertR(float2(0,	-width2 - p), float2(0.5, 0.0 - uvOffset));
	addVertR(float2(p,	-width2 - p), float2(1.0 + uvOffset, 0.0 - uvOffset));
	outStream.RestartStrip();
}

#define ANALYTIC_ALPHA

float4 psLine(vsOutput_line i, uniform bool bSpecular): SV_TARGET0
{
	float3	screenSpecular = 0;
	float	opacity = 1.0;
	
	if(bSpecular)
	{
		float  roughness = 0.55;
		float3 norm = -matWorld._11_12_13;
		float3 specular = 0.08;
		float  shadow = SampleShadow(float4(i.wPos, i.projPos.z/i.projPos.w), norm, true, true);
		float3 viewDir = normalize(gCameraPos.xyz - i.wPos.xyz);
		screenSpecular = ShadeSolid(i.wPos.xyz, gSunDiffuse, 0, specular, norm, roughness, 0, shadow, 1, viewDir, 1, float2(0, 1));
		opacity = 1 / (1 + screenSpecular.r*3);
	}

#ifdef ANALYTIC_ALPHA
	float alpha = max(0, 1.0 - distance(i.vTexCoord0.xy, 0.5) * 2.0);
#else
	float alpha = TextureMap.SampleBias(ClampLinearSampler, i.vTexCoord0.xy, gMipLevelBias).a;
#endif
	return float4(BlendColor.rgb*BlendColor.rgb + screenSpecular, alpha * BlendColor.a * opacity);
}

VertexShader vsComp		 = CompileShader(vs_4_0, vsSimpleILS(false));
VertexShader vsArrayComp = CompileShader(vs_4_0, vsSimpleILS(true));

technique10 tech {
	pass main {
		SetVertexShader(vsComp);
		SetPixelShader(CompileShader(ps_4_0, psTex(false, false)));
		SetGeometryShader(NULL);
		SetRasterizerState(cullNone);
	}
	pass texArray {
		SetVertexShader(vsArrayComp);
		SetPixelShader(CompileShader(ps_4_0, psTex(true, false)));
		SetGeometryShader(NULL);
		SetRasterizerState(cullNone);
	}
	pass main_sRGB {
		SetVertexShader(vsComp);
		SetPixelShader(CompileShader(ps_4_0, psTex(false, true)));
		SetGeometryShader(NULL);
		SetRasterizerState(cullNone);
	}
	pass texArray_sRGB {
		SetVertexShader(vsArrayComp);
		SetPixelShader(CompileShader(ps_4_0, psTex(true, true)));
		SetGeometryShader(NULL);
		SetRasterizerState(cullNone);
	}
}

technique10 techA8 {
	pass main {
		SetVertexShader(vsComp);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psTexA8(false)));

		SetRasterizerState(cullNone);
	}
	pass texArray {
		SetVertexShader(vsArrayComp);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psTexA8(true)));

		SetRasterizerState(cullNone);
	}
}


technique10 techUITTF {
	pass main {
		SetVertexShader(vsArrayComp);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psUITTF()));
		SetRasterizerState(cullNone);
	}
}

technique10 techWithoutTexture {
	pass main {
		SetVertexShader(CompileShader(vs_4_0, vsWithoutTexture()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psWithoutTexture()));

		SetRasterizerState(cullNone);
	}
}

technique10 techLine {
	pass main {
		SetVertexShader(CompileShader(vs_4_0, vsLine()));
		SetGeometryShader(CompileShader(gs_4_0, gsLine()));
		SetPixelShader(CompileShader(ps_5_0, psLine(false)));
		SetRasterizerState(cullNone);
	}
}

technique10 techLineSpecular {
	pass main {
		SetVertexShader(CompileShader(vs_4_0, vsLine()));
		SetGeometryShader(CompileShader(gs_4_0, gsLine()));
		SetPixelShader(CompileShader(ps_5_0, psLine(true)));
		SetRasterizerState(cullNone);
	}
}
