#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "common/random.hlsl"

#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

float3 smokeParams;

#define gWind		smokeParams.xy
#define time		smokeParams.z

#define smokeScale	1

#define smokeColorBase	float3(0.1, 0.12, 0.14)
#define glowColor		float3(1, 0.7, 0.30)

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
	
	GS_OUTPUT o;
	
	float _sin, _cos;
	sincos(gsAngle, _sin, _cos);
	
	float2x2 M = {
	_cos, _sin,
	-_sin,  _cos};
	
	gsPos = mul(float4(gsPos,1), gView).xyz;
	
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

//additiveness = 0 - обычная прозрачность; 1 - чисто аддитивный блендинг.
float4 makeAdditiveBlending2(in float4 clr, in float additiveness = 1)
{
	float transmittance = 1 - lerp(clr.a, 0, additiveness);
	return float4(clr.rgb * clr.a, transmittance);
}

float4 psPuff(in GS_OUTPUT i): SV_TARGET0
{
	// return float4(1,1,1,0.2);
	#define psOpacity i.params.z
	#define psGlowFactor i.params.w
	
	i.normal = normalize(i.normal);
	float sunDot = dot(i.normal.xyz, gSunDirV.xyz)*0.5 + 0.5;
	
	//базовая прозрачность партикла
	float alpha = max(0,(tex.Sample(ClampLinearSampler, i.params.xy).a-0.2)*1.25); clip(alpha-0.01);
	//основная освещенка
	float3 smokeColor = smokeColorBase * lerp(AmbientTop*0.5, gSunDiffuse, sunDot) * 1.3;
	
	smokeColor += alpha * glowColor * glowColor * psGlowFactor * 20;
	
	float4 clr = float4(smokeColor, min(1, alpha * psOpacity*(1+1.5*psGlowFactor)));
	
	return makeAdditiveBlending2(clr, psGlowFactor);
}

#include "cbu97Smoke_sh.hlsl"
#include "cbu103Smoke_sh.hlsl"

BlendState enableAlphaBlend2
{
	BlendEnable[0] = TRUE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f;
};

BlendState premultAlphaBlendState
{
	BlendEnable[0] = true;
	SrcBlend = ONE;
	DestBlend = SRC_ALPHA;
	BlendOp = ADD; 
	SrcBlendAlpha = INV_SRC_ALPHA;
	DestBlendAlpha = SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

HullShader		hsComp		= CompileShader(hs_5_0, hs());
GeometryShader	gsPuffComp	= CompileShader(gs_4_0, gsPuff());
PixelShader		psPuffComp	= CompileShader(ps_4_0, psPuff());

technique10 techCBU97
{
	pass puff
	{
		SetVertexShader(CompileShader(vs_4_0, vs(10)));
		SetHullShader(hsComp);
		SetDomainShader(CompileShader(ds_5_0, dsCBU97()));
		SetGeometryShader(gsPuffComp);
		SetPixelShader(psPuffComp);
		
		SetBlendState(premultAlphaBlendState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}

technique10 techCBU103
{
	pass needles
	{
		SetVertexShader(CompileShader(vs_4_0, vs(5)));
		SetHullShader(hsComp);
		SetDomainShader(CompileShader(ds_5_0, dsCBU103Needle()));
		SetGeometryShader(CompileShader(gs_4_0, gsCBU103Needle()));
		SetPixelShader(CompileShader(ps_4_0, psNeedle()));
		
		SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	pass puff
	{
		SetVertexShader(CompileShader(vs_4_0, vs(5)));
		//SetHullShader(hsComp);
		SetDomainShader(CompileShader(ds_5_0, dsCBU103()));
		SetGeometryShader(gsPuffComp);
		SetPixelShader(psPuffComp);
		SetBlendState(premultAlphaBlendState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		//SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		//SetDepthStencilState(enableDepthBufferNoWrite, 0);
		//SetRasterizerState(cullNone);
	}
}

