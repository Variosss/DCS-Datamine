
Texture2D TextureMap;

float4 BlendColor;
float Power;

struct vsIn
{
	float3 vPosition:	POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

struct vsOutput_ils
{
	float4 vPosition:	SV_POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

vsOutput_ils vsSimpleILS(in vsIn i)
{
	vsOutput_ils o;
	o.vPosition = mul(float4(i.vPosition, 1.0), matWorldViewProj);	
	o.vTexCoord0.xy = i.vTexCoord0;
	return o;
}

float4 psTexShader(in vsOutput_ils i): SV_TARGET0 
{
	float4 tex   = TextureMap.Sample(WrapLinearSampler, i.vTexCoord0.xy);
	float3 color = pow(tex.rgb * BlendColor.rgb, 2.2);
	// alpha separate
	float alpha =  tex.a   * BlendColor.a;
		
	return float4(color, alpha);
}

float4 psTexShaderA8(in vsOutput_ils i): SV_TARGET0 
{
	float4 tex = TextureMap.Sample(WrapLinearSampler, i.vTexCoord0.xy);
	clip(tex.a-0.02);

	// alpha separate
	float3 color = BlendColor.rgb * pow(1.0/0.99, Power);
	float alpha =  tex.a * BlendColor.a;
	return float4(color, alpha);
}

float4 vsWithoutTexture(float3 vPosition: POSITION): SV_POSITION0
{
	return mul(float4(vPosition, 1.0), matWorldViewProj);
}

float4 psWithoutTexture(): SV_TARGET0
{
	return BlendColor;
}

VertexShader vsSimpleComp 			= CompileShader(vs_4_0, vsSimpleILS());
VertexShader vsWithoutTextureComp	= CompileShader(vs_4_0, vsWithoutTexture());

#define PASS(name, vs, ps) \
	pass name {\
		SetVertexShader(vs);\
		SetGeometryShader(NULL);\
		SetPixelShader(ps);\
		SetRasterizerState(cullNone);}

technique10 tech {
	PASS(main,			vsSimpleComp, CompileShader(ps_4_0, psTexShader()))
}

technique10 techA8 {
	PASS(main,			vsSimpleComp, CompileShader(ps_4_0, psTexShaderA8()))
}

technique10 techWithoutTexture {
	PASS(main, 			vsWithoutTextureComp, CompileShader(ps_4_0, psWithoutTexture()))
}

