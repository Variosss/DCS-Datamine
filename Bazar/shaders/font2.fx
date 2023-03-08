/*эджовский шейдер, используется только в dx11backend*/

#include "common/samplers11.hlsl"
#include "common/States11.hlsl"

Texture2D FontTexture;

float4 color;
float2 textPos;
float2 targetDims;
float4x4 rotation;
float2 justify;
// float4 shadowColor = float4(0, 0, 0, 1);
// float shadowSize = 1.5;

struct VS_INPUT
{
	float2 pos  : POSITION0;
	float2 uv : TEXCOORD0;
};

struct VS_OUTPUT
{
#ifdef DIRECTX11
	float4 pos  : SV_POSITION;
#else
	float4 pos  : POSITION0;
#endif
	float2 uv : TEXCOORD0;
};

#ifdef DIRECTX11
float offset = 0;
#else
float offset = 0.5;
#endif
VS_OUTPUT VerText(VS_INPUT input)
{
	VS_OUTPUT output;
	input.pos += justify;
	input.pos = mul(input.pos, rotation);
	output.pos.x =   ((input.pos.x + textPos.x + offset) / targetDims.x - 0.5f) * 2.0f;
	output.pos.y = - ((input.pos.y + textPos.y + offset) / targetDims.y - 0.5f) * 2.0f;
	output.pos.z = 0.5f;
	output.pos.w = 1.0f;
	output.uv = input.uv;
	return output;
}

float4 PixOut(VS_OUTPUT input) : SV_TARGET0
{
	// float width, height;
	// FontTexture.GetDimensions(width, height);
	float4 t = FontTexture.Sample(WrapLinearSampler, input.uv);
	t.a = t.a * color.a;
	t.rgb = color.rgb;
	return t;
	/*
	//круто конечно, только зачем?
	// shadow
	float2 texelSize = 1.0f/float2(width, height);
	texelSize *= shadowSize;
	float deltax = texelSize.x;
	float deltay = texelSize.y;

	float4 s = float4(0, 0, 0, 0);
	s += TEX2D(FontTexture, input.uv+float2(-deltax, -deltay));
	s += TEX2D(FontTexture, input.uv+float2(      0, -deltay));
	s += TEX2D(FontTexture, input.uv+float2( deltax, -deltay));
	s += TEX2D(FontTexture, input.uv+float2( deltax,      0));
	s += TEX2D(FontTexture, input.uv+float2( deltax,  deltay));
	s += TEX2D(FontTexture, input.uv+float2(      0,  deltay));
	s += TEX2D(FontTexture, input.uv+float2(-deltax,  deltay));
	s += TEX2D(FontTexture, input.uv+float2(-deltax,      0));
	s /= 9;
	s.a *= shadowColor.a;
	s.rgb = shadowColor.rgb;
	
	// blend shadow
	float3 color = t.rgb;
	float a = max(s.a, t.a);
	// float a = max(0,s.a-t.a);
	if(a==0) discard;
	color = lerp(s.rgb, color/a, t.a);	
	return float4(color, a);
	*/
}

technique10 Standart
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, VerText()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
