#include "common/States11.hlsl"
#include "common/Samplers11.hlsl"
#include "common/TextureSamplers.hlsl"

#ifdef MSAA
	#define TEXTURE_2D(type, name) Texture2DMS<type, MSAA> name	
	#define	SampleMap(name, uv, idx)  name.Load(uint2(uv), idx)
	#define TEXTURE_2D_ARRAY(type, name) Texture2DMSArray<type, MSAA> name
	#define	SampleMapArray(name, uv, slice, idx)  name.Load(uint3(uv, slice), idx)
#else
	#define TEXTURE_2D(type, name) Texture2D<type> name
	#define	SampleMap(name, uv, idx)  name.Load(uint3(uv, 0))
	#define TEXTURE_2D_ARRAY(type, name) Texture2DArray<type> name
	#define	SampleMapArray(name, uv, slice, idx)  name.Load(uint4(uv, slice, 0))
#endif

TEXTURE_2D(float4, Target);


Texture3D Target3D;
TEXTURE_SAMPLER3D(Target3D, CLAMP, CLAMP, CLAMP);

TEXTURE_2D_ARRAY(float4, TargetArray);

Texture2D<unsigned int> TargetInt;

float4x4 ViewProjectionMatrix;
float opacity;
float zoominv;
float value_pow;
float textureArrayIndex;

float4 sunColorValue;
float4 globalAmbientValue;

int3 dims;
int channel = -1;

float4 getFinalColor(float4 sourceColor)
{
	switch(channel)
	{
		case 0: return float4(sourceColor.rrr, opacity);
		case 1: return float4(sourceColor.ggg, opacity);
		case 2: return float4(sourceColor.bbb, opacity);
		case 3: return float4(sourceColor.aaa, opacity);
	}

	return float4(sourceColor.rgb, opacity);
}

struct VS_OUTPUT
{
	float4 vPosition		: SV_POSITION;
	float2 vTexCoord		: TEXCOORD0;
};

VS_OUTPUT vsMain(float3 pos : POSITION0, float2 tc : TEXCOORD0)
{
	VS_OUTPUT o;

	o.vPosition = mul(float4(pos,1.0), ViewProjectionMatrix);
	o.vTexCoord = (tc-float2(0.5, 0.5))*zoominv + float2(0.5, 0.5);

	return o;
}

float4 psSolidTech(VS_OUTPUT input) : SV_TARGET0
{
	float2 diff = 0.5 / dims.xy;
	float4 color = SampleMap(Target, (input.vTexCoord + diff)*dims.xy, 0);
	return pow(getFinalColor(color), value_pow);
}
float4 psAlphaTech(VS_OUTPUT input) : SV_TARGET0
{
	float2 diff = 0.5 / dims.xy;
	float4 color = SampleMap(Target, (input.vTexCoord + diff)*dims.xy, 0);
	color.rgb = color.a;
	color.a = opacity;
	return color;
}

float4 psSolidTechTexture3D(VS_OUTPUT input) : SV_TARGET0
{
	int sizeX, sizeY, layers;
	Target3D.GetDimensions(sizeX, sizeY, layers);
	float2 diff = 0.5 / dims.xy;
	float4 color = TEX3DLOD(Target3D, float4(input.vTexCoord + diff, (textureArrayIndex + 0.5f) / layers, 0.0f));
	return getFinalColor(color);
}

float4 psSunColor(VS_OUTPUT input) : SV_TARGET0
{
	return float4(sunColorValue.xyz, opacity);
}
float4 psGlobalAmbient(VS_OUTPUT input) : SV_TARGET0
{
	return float4(globalAmbientValue.xyz, opacity);
}


float4 psSolidTechTextureArray(VS_OUTPUT input) : SV_TARGET0
{
	float4 color = SampleMapArray(TargetArray, input.vTexCoord*dims.xy, floor(textureArrayIndex), 0);
	return pow(getFinalColor(color), value_pow);
}

float4 psAlphaTechTextureArray(VS_OUTPUT input) : SV_TARGET0
{
	float4 color = SampleMapArray(TargetArray, input.vTexCoord*dims.xy, floor(textureArrayIndex), 0);
	color.rgb = color.a;
	color.a = opacity;
	return getFinalColor(color);
}

float4 psSolidTechTextureInt(VS_OUTPUT input) : SV_TARGET0
{
	uint f = 0xffffffff >> ((4-dims.z)*8);
//	float4 color = TargetInt.Load(int3(input.vTexCoord*dims.xy, 0))/float(f);
	float4 color = TargetInt.Load(int3(input.vTexCoord*dims.xy, 0))/float(0xffff);
	return getFinalColor(color);
}

float4 psDepthTexture(VS_OUTPUT input) : SV_TARGET0
{
	float2 diff = 0.5 / dims.xy;
	float4 color = SampleMap(Target, (input.vTexCoord + diff)*dims.xy, 0);

	float1 depth = color.x;
	color.rgb = lerp(float3(1, 1, 0), float3(0, 1, 1), saturate(-depth/30));

	color.a = opacity;
	return color;
}

float4 psDepth(VS_OUTPUT input) : SV_TARGET0
{
	float2 diff = 0.5 / dims.xy;
	float depth = SampleMap(Target, (input.vTexCoord + diff)*dims.xy, 0).r;
	return float4( pow(saturate(depth.xxx), 20), opacity);
}


VertexShader vsMainCompiled = CompileShader(vs_4_0, vsMain());

technique10 solid
{
	pass P0
	{
		SetVertexShader(vsMainCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSolidTech()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}

technique10 solidTextureInt
{
	pass P0
	{
		SetVertexShader(vsMainCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSolidTechTextureInt()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}

technique10 alpha
{
	pass P0
	{
		SetVertexShader(vsMainCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psAlphaTech()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}

technique10 solidTexture3D
{
	pass P0
	{
		SetVertexShader(vsMainCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSolidTechTexture3D()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}

technique10 solidTextureArray
{
	pass P0
	{
		SetVertexShader(vsMainCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSolidTechTextureArray()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}

technique10 alphaTextureArray
{
	pass P0
	{
		SetVertexShader(vsMainCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psAlphaTechTextureArray()));

		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}

technique10 depthTexture
{
	pass P0
	{
		SetVertexShader(vsMainCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psDepthTexture()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}
technique10 sunColor
{
	pass P0
	{
		SetVertexShader(vsMainCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSunColor()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}
technique10 globalAmbient
{
	pass P0
	{
		SetVertexShader(vsMainCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psGlobalAmbient()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}

technique10 depthTech
{
	pass P0
	{
		SetVertexShader(vsMainCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psDepth()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}
