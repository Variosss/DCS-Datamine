#include "common/Samplers11.hlsl"
#include "common/States11.hlsl"

Texture2D	tex;
TextureCube	texCube;
float4 Color;

matrix WVP;
matrix UVrotation;

struct VS_INPUT
{
	float4 vPos : POSITION;
	float2 vAngles : TEXCOORD0;
};

struct VS_OUT
{
	float4 oPos : SV_POSITION;
	float3 oTex0 : TEXCOORD0;
};

void vs_main(in float4 vPos : POSITION, out float4 oPos : SV_POSITION)
{
	oPos = mul(vPos, WVP);
}

float2 packSunDir(in float3 sunDir)
{
	float azimuth = atan2(sunDir.x, sunDir.z);
	if(sunDir.x < 0)
		azimuth += 3.1415 * 2.0;
	float2 uv;
	uv.x = azimuth / 3.1415 / 2.0;
	uv.y = sunDir.y * 0.5 + 0.5;
	return uv;
}

VS_OUT vs_main_textured(VS_INPUT IN, uniform bool bCube)
{
	VS_OUT vs_out;
	vs_out.oPos = mul(IN.vPos, WVP);
	
	// UV
	if(bCube)
		vs_out.oTex0 = IN.vPos;	
	else
		// vs_out.oTex0 = float3(IN.vAngles, 0);
		vs_out.oTex0 = IN.vPos;
	
	return vs_out;
}

float4 ps_main(in float4 oPos : SV_POSITION) : SV_TARGET0
{
	return Color;
}

float4 ps_main_textured(VS_OUT IN, uniform bool bCube) : SV_TARGET0
{
	if(bCube)
		return float4(texCube.Sample(gTrilinearWrapSampler, normalize(IN.oTex0.xyz)).rgb, 1);
	else {
		// return float4(tex.Sample(gTrilinearWrapSampler, float2(IN.oTex0.x, IN.oTex0.y)).rgb, 1);
		return float4(tex.Sample(gTrilinearWrapSampler, packSunDir(normalize(IN.oTex0.xyz))).rgb*5, 1);
	}
}

technique10 Solid
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}

technique10 Wireframe
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));

		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(wireframe);
	}
}

technique10 Rainbow
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main_textured(false)));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main_textured(false)));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}	
	pass CubeTexture
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main_textured(true)));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main_textured(true)));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
