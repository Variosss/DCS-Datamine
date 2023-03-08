#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"

#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

Texture2D blastWaveTex;

float3 smokeParams;

#define gWind		smokeParams.xy
#define time		smokeParams.z

#define smokeScale	1

#define smokeColorBase	float3(0.1, 0.12, 0.14)
#define glowColor		float3(1, 0.8, 0.45)

struct VS_INPUT{
	float4 posBirth		: POSITION0;//pos + birthTime
	float4 speedLifetime: TEXCOORD0;//speed + lifetime
};

struct VS_OUTPUT{
	float4 pos	: POSITION0;//pos + birthTime
	float4 speed: TEXCOORD0;//speed + lifetime
	float particles:TEXCOORD1;
};

struct HS_CONST_OUTPUT{
	float edges[2] : SV_TessFactor;
};

struct HS_OUTPUT{
	float4 pos  : POSITION0;
	float4 speed: TEXCOORD0;
};

struct DS_OUTPUT{
	float4 pos	: POSITION0;
	float4 params:TEXCOORD0;
};

struct GS_OUTPUT{
	float4 pos  : SV_POSITION0;
	float4 params:TEXCOORD0;// UV, opacity, distance
	float3 normal: NORMAL;
};


VS_OUTPUT vs(in VS_INPUT i, uniform int nParticles)
{
	VS_OUTPUT o;
	o.pos = i.posBirth;
	o.pos.xz += gWind*(time - i.posBirth.w);
	o.speed = i.speedLifetime;
	o.particles = nParticles;
	return o;
}

// HULL SHADER ---------------------------------------------------------------------
HS_CONST_OUTPUT hsConstant( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o; 
	o.edges[1] = ip[0].particles;
	o.edges[0] = 1; 
	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("hsConstant")]
HS_OUTPUT hs( InputPatch<VS_OUTPUT, 1> ip, uint cpid : SV_OutputControlPointID)
{
	HS_OUTPUT o;
	o.pos = ip[0].pos;
	o.speed = ip[0].speed;

	return o;
}

[maxvertexcount(4)]
void gsPuff(point DS_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	#define gsPos input[0].pos.xyz
	#define gsOpacity input[0].params.x
	#define gsAngle input[0].params.y
	#define gsScale input[0].params.z

	float2x2 M = rotMatrix2x2(gsAngle);
	gsPos = mul(float4(gsPos,1), gView).xyz;

	GS_OUTPUT o;
	o.params.z = gsOpacity;
	o.params.w = input[0].params.w;//distance
	
	[unroll]
	for (int i = 0; i < 4; i++)
	{
		float4 vPos = float4(staticVertexData[i].xy, 0, 1);
		o.params.xy = mul(staticVertexData[i].xy, M)+0.5;
		
		vPos.xy *= gsScale;
		vPos.xyz += gsPos;
		o.pos = mul(vPos, gProj);
		o.normal = float3(staticVertexData[i].xy, -0.2);
		
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
	#undef gsPos
	#undef gsOpacity 
	#undef gsAngle
	#undef gsScale
}


float4 psPuff(in GS_OUTPUT i): SV_TARGET0
{
	// return float4(1,1,1,0.2);
	#define psOpacity i.params.z
	#define psGlowFactor i.params.w
	
	i.normal = normalize(i.normal);
	float sunDot = dot(i.normal.xyz, gSunDirV.xyz)*0.5 + 0.5;
	
	//базовая прозрачность партикла
	float alpha = max(0,(tex.Sample(ClampLinearSampler, i.params.xy).a-0.2)*1.25);
	//основная освещенка
	float3 smokeColor = smokeColorBase * lerp(AmbientTop*0.5, gSunDiffuse.xyz, sunDot)*1.3;
	
	smokeColor = lerp(smokeColor, glowColor, psGlowFactor);
	
	float4 clr = float4(smokeColor, min(1, alpha * psOpacity*(1+1.5*psGlowFactor)));
	
	return makeAdditiveBlending(clr, psGlowFactor);
	#undef psGlowFactor
	#undef psOpacity
}

#include "cbu97Explosion_sh.hlsl"
#include "cbu103Explosion_sh.hlsl"

#define enableAlphaBlend2 additiveAlphaBlend


#if 0
BlendState enableAlphaBlend2
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = FALSE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f;
};

#endif

HullShader		hsComp		= CompileShader(hs_5_0, hs());
GeometryShader	gsPuffComp	= CompileShader(gs_4_0, gsPuff());
PixelShader		psPuffComp	= CompileShader(ps_4_0, psPuff());

technique10 techCBU97
{
	pass puff
	{
		SetVertexShader(CompileShader(vs_4_0, vs(5)));
		SetHullShader(hsComp);
		SetDomainShader(CompileShader(ds_5_0, dsCBU97()));
		SetGeometryShader(CompileShader(gs_4_0, gsPuffTest()));
		SetPixelShader(CompileShader(ps_4_0, psPuffTest()));
		
		SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}

// technique10 techCBU97
// {
	// pass puff
	// {
		// SetVertexShader(CompileShader(vs_4_0, vs(5)));
		// SetHullShader(hsComp);
		// SetDomainShader(CompileShader(ds_5_0, dsCBU97()));
		// SetGeometryShader(gsPuffComp);
		// SetPixelShader(psPuffComp);
		
		// SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		// SetDepthStencilState(enableDepthBufferNoWrite, 0);
		// SetRasterizerState(cullNone);
	// }
// }

technique10 techCBU103
{
	pass glow
	{
		SetVertexShader(CompileShader(vs_4_0, vsCB103Glow()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsCBU103Glow()));
		SetPixelShader(CompileShader(ps_4_0, psCBU103Glow()));
		SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	pass blastWave
	{
		SetVertexShader(CompileShader(vs_4_0, vsCB103Glow()));
		SetGeometryShader(CompileShader(gs_4_0, gsCBU103BlastWave()));
		SetPixelShader(CompileShader(ps_4_0, psCBU103BlastWave()));
		// SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	}
	pass sparks
	{
		SetVertexShader(CompileShader(vs_4_0, vs(64)));
		SetHullShader(hsComp);
		SetDomainShader(CompileShader(ds_5_0, dsCBU103Sparks()));
		SetGeometryShader(CompileShader(gs_4_0, gsCBU103Sparks()));
		SetPixelShader(CompileShader(ps_4_0, psSparks()));
		SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		// SetDepthStencilState(enableDepthBufferNoWrite, 0);
		// SetRasterizerState(cullNone);
	}
}












