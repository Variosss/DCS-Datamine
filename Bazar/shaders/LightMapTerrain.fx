#include "common/States11.hlsl"
#include "common/TextureSamplers.hlsl"
#include "common/Attenuation.hlsl"

#define USE_TEXTURE 0

/*рисует проекции лампочек на землю*/

float4x4 W;
float4x4 WVP;
float4x4 ttf;
float4 vAtt;
float4 vXL;
float3 color;
float lengthToLand;
float fi, theta;

float4 omniPos;

Texture2D tex;
TEXTURE_SAMPLER(tex, MIN_MAG_MIP_ANISOTROPIC, BORDER, BORDER);

struct VS_INPUT
{
	float4 Position : POSITION0;
//	float4 normal   : NORMAl;
};

struct VS_OUT 
{
	float4 Position : SV_POSITION;
	float4 TexCoord : TEXCOORD0;
	float4 TexCoord1 : TEXCOORD1;
	float2 TexCoord2 : TEXCOORD3;

	float4	pos	:	TEXCOORD2;
};

VS_OUT vs_main( VS_INPUT IN )
{
	VS_OUT OUT;
	IN.Position.y = 0.0f;
	float4 pos = mul(IN.Position, W);

	OUT.pos = pos;

	// дальность
	pos.xz -= vAtt.xz;
	pos.y = lengthToLand * abs(vXL.y);
	// штобы в жопу не светил
	OUT.TexCoord2.x = dot(pos.xyz, vXL.xyz);
	OUT.TexCoord2.y = 0;//dot(normalize(pos.xyz), vXL.xyz);
	// расстояние
	OUT.TexCoord1 = pos * vAtt.w;	
	
	float4 v = IN.Position;
	v.y = 0.0f;	
	//-------------------------------------
	// create texture coords for Light0	
	OUT.TexCoord = mul(v, ttf);	
	//vertex
	OUT.Position = mul(v, WVP);	
	return OUT;	 
}

float4 ps_main(VS_OUT IN) : SV_TARGET0
{

	float4 res = IN.TexCoord1;
	res.a = LightAttenuation(length(IN.TexCoord1.xz), 1);
	res.a *= saturate(IN.TexCoord2.x);	
	res.a = pow(res.a,2);

	res.rgb = color.rgb;

	float spotFactor = 1.0 / (1 - clamp(theta/fi, 0.0, 0.85));
	float dp = (1 - saturate(length( (saturate(IN.TexCoord.xy/max(IN.TexCoord.z, 1.0)) - 0.5) * 2.0))) * spotFactor;
	res.rgb *= dp;

#if USE_TEXTURE
	res.rgb *= TEX2DPROJ(tex, IN.TexCoord).rgb;	
#endif

	return res;	

}

float4 ps_omni(VS_OUT IN) : SV_TARGET0
{
	OmniAttenParams oap;
	oap.distance = distance(IN.pos/IN.pos.w, omniPos.xyz);
	oap.range = omniPos.w;
	return float4(color * OmniAttenuation(oap), 1);	
}

technique10 LightSpot
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));

		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}

technique10 LightOmni
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_omni()));

		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}


