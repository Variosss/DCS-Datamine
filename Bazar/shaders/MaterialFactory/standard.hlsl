#include "ParticleSystem2/common/modelShading.hlsl"

struct FROM_GEOMETRY
{
	float3 pos:			POSITION0;
	float3 normal:		NORMAL0;
	float2 texCoord:	TEXCOORD0;
};

MODEL_PS_INPUT vsStandard2(in FROM_GEOMETRY i)
{
	MODEL_PS_INPUT o;
	o.wPos = mul(float4(i.pos, 1.0), matWorld);
	o.pos = mul(float4(i.pos, 1.0), matWorldViewProj);
	o.uv = i.texCoord;
	o.tangent = 0;
	o.normal = normalize(mul(i.normal.xyz, (float3x3)matWorld));
	return o;
}

VertexShader vsComp	= CompileShader(vs_4_0, vsStandard2());

PixelShader psCompD   = CompileShader(ps_5_0, psModel(MAT_FLAG_DIFFUSE_MAP));
PixelShader psCompDS  = CompileShader(ps_5_0, psModel(MAT_FLAG_DIFFUSE_MAP | MAT_FLAG_SPECULAR_MAP));
PixelShader psCompDN  = CompileShader(ps_5_0, psModel(MAT_FLAG_DIFFUSE_MAP | MAT_FLAG_NORMAL_MAP));
PixelShader psCompDNS = CompileShader(ps_5_0, psModel(MAT_FLAG_DIFFUSE_MAP | MAT_FLAG_NORMAL_MAP | MAT_FLAG_SPECULAR_MAP));

#define PASS_BODY(ps, ds, bs) { SetVertexShader(vsComp); SetGeometryShader(NULL); SetPixelShader(ps); \
	SetDepthStencilState(ds, 0); \
	SetBlendState(bs, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
	SetRasterizerState(cullNone);}

#define PASS_BODY_OPAQUE(ps) PASS_BODY(ps, enableDepthBuffer, disableAlphaBlend)
#define PASS_BODY_TRANSP(ps) PASS_BODY(ps, enableDepthBufferNoWrite, enableAlphaBlend)

technique10 tech
{
	//â g-buffer
	pass opaque_diffuse			PASS_BODY_OPAQUE(psCompD)
	pass opaque_diffuseSpec		PASS_BODY_OPAQUE(psCompDS)
	pass opaque_diffuseNorm		PASS_BODY_OPAQUE(psCompDN)
	pass opaque_diffuseNormSpec	PASS_BODY_OPAQUE(psCompDNS)

	//â g-buffer
	pass decal_diffuse			PASS_BODY_TRANSP(psCompD)
	pass decal_diffuseSpec		PASS_BODY_TRANSP(psCompDS)
	pass decal_diffuseNorm		PASS_BODY_TRANSP(psCompDN)
	pass decal_diffuseNormSpec	PASS_BODY_TRANSP(psCompDNS)
}
