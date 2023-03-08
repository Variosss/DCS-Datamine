#include "common/ambientCube.hlsl"
#include "ParticleSystem2/common/psShading.hlsl"

Texture2D	DiffuseMap2;
float4		effectColor;

struct vsInputEffect
{
	float3 vPosition:	POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
	// float4 vDiffuse:	COLOR0;
};

struct vsOutputEffect
{
	float4 vPosition:	SV_POSITION0;
	float3 vTexCoord0:	TEXCOORD0;
	float4 vDiffuse:	COLOR0;
};



vsOutputEffect vsEffect(vsInputEffect i)
{
	vsOutputEffect o;
	o.vPosition = mul(float4(i.vPosition, 1.0), matWorldViewProj);
	
	float3 diffuse = effectColor.rgb * float3(1,0.95,0.85)*0.45;

	o.vDiffuse.a = effectColor.a * 0.1;
	o.vDiffuse.rgb = shading_AmbientSun(diffuse*diffuse/3.1415, AmbientTop.rgb * 0.5, gSunDiffuse.rgb * gSunIntensity);

	o.vTexCoord0.xy = i.vTexCoord0.xy;
	float4 vPos = mul(o.vPosition, gProjInv);
	o.vTexCoord0.z = saturate(vPos.z/vPos.w-1.4);
	return o;
}

float4 psTech_1(vsOutputEffect i): SV_TARGET0
{
	float4 color = DiffuseMap.Sample(WrapLinearSampler, i.vTexCoord0.xy);
	return color * i.vDiffuse;
}

float4 psTech_2(vsOutputEffect i): SV_TARGET0
{
	return 1;
	float4 vColor = i.vDiffuse;

	float4 color1 = DiffuseMap.Sample(WrapLinearSampler, i.vTexCoord0.xy);
	float4 color2 = DiffuseMap2.Sample(WrapLinearSampler, i.vTexCoord0.xy);

	vColor = vColor * color1;
	vColor.rgb = lerp(vColor.rgb, color2.rgb, color2.a);
	vColor.a = saturate(vColor.a + color2.a);

	return vColor;
}

float4 psTech_3(vsOutputEffect i): SV_TARGET0
{
	return i.vDiffuse;
}

float4 psTech_4(vsOutputEffect i): SV_TARGET0
{
	return effectColor;
}

VertexShader vsStandart_c = CompileShader(vs_4_0, vsEffect());

technique10 tech_1 {
	pass P0 {
		SetVertexShader(vsStandart_c);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psTech_1()));

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);            
	}
}

technique10 tech_2 {
	pass P0 {
		SetVertexShader(vsStandart_c);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psTech_2()));

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);            
	}
}

technique10 tech_3 {
	pass P0 {
		SetVertexShader(vsStandart_c);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psTech_3()));

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);            
	}
}

technique10 tech_4 {
	pass P0 {
		SetVertexShader(vsStandart_c);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psTech_4()));

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);            
	}
}