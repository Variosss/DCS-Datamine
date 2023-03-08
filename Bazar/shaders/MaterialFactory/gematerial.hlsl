#include "common/ambientCube.hlsl"
#include "ParticleSystem2/common/psShading.hlsl"
#define sunAtt uSunDiffuse.w

struct vsInputGE
{
	float3 vPosition:	POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
	float4 vDiffuse:	COLOR0;
};

struct vsOutputGE
{
	float4 vPosition:	SV_POSITION0;
	float3 vTexCoord0:	TEXCOORD0;
	float4 vDiffuse:	COLOR0;
};

vsOutputGE vsGE(in vsInputGE i)
{
	vsOutputGE o;
	o.vPosition = mul(float4(i.vPosition, 1.0), matWorldViewProj);
	o.vDiffuse.a = i.vDiffuse.a;
	o.vDiffuse.rgb = shading_AmbientSun(i.vDiffuse.rgb*i.vDiffuse.rgb/3.1415, AmbientTop.rgb * 0.5, gSunDiffuse.rgb * gSunIntensity);
	o.vTexCoord0.xy = i.vTexCoord0.xy;
	float4 vPos = mul(o.vPosition, gProjInv);
	o.vTexCoord0.z = saturate(vPos.z/vPos.w-1.4);
	return o;
}

float4 psTech_1(in vsOutputGE i) : SV_TARGET0 
{
	float4 color = i.vDiffuse * DiffuseMap.Sample(WrapLinearSampler, i.vTexCoord0.xy);
	color.a *= i.vTexCoord0.z;
	return color;
}

technique10 tech_1{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsGE()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psTech_1()));

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);            
	}
}

technique10 tech_2{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsGE()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psTech_1()));

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

