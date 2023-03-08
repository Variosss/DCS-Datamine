#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "common/softParticles.hlsl"
#include "common/random.hlsl"

#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "ParticleSystem2/common/noiseSimplex.hlsl"

Texture2D	afterburnerTex;
Texture2D	noiseTex;
Texture2D	glowTex;

float		opacityMax;
float4		params;
float4		params2;
float4      params3;
float4x4	World;

#define circleCount			params.x
#define circleCountInv		params.y
#define time				params.z
#define power				params.w
#define circlesPos			(params2.xy)
#define circleScale			params2.z
#define emitterId			params2.w
#define stuttPower			params3.x
#define circleBrightness	params3.y
#define volumeBrightness	params3.z
#define effectDistMax		params3.w

static const float3	glowColor = float3(1, 0.7, 0.3);

static const int	maxSegments = 26;
static const int	maxSegmentsHotAir = 8;

static const float	opacityFactor = 1.0f/maxSegments;
static const float	opacityFactorHotAir = 1.0f/maxSegmentsHotAir;

static const float	alphaOpacity = 0.4;

static const float	hotAirPower = 0.5;
static const float	hotAirDistOffset = 10.0;
static const float	hotAirDistMaxInv = 1.0 / 200.0;

static const float2 xLocal = {-0.13, 1.0};//начало и конец форсажа в локальной СК

SamplerState BlackBorderLinearSampler
{
	Filter        = MIN_MAG_MIP_LINEAR;
	AddressU      = BORDER;
	AddressV      = BORDER;
	AddressW      = BORDER;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};


struct VS_OUTPUT {
	float4 pos		: POSITION0;
};

struct VS_CIRCLE_OUTPUT {
	uint vertId		: TEXCOORD2;
};

struct HS_CONST_OUTPUT {
	float edges[2]	: SV_TessFactor;
};

struct HS_OUTPUT{
	float4 pos		: POSITION0;
};

struct DS_OUTPUT{
	float4 pos		: POSITION0;
};

struct GS_OUTPUT{
	float4 pos		: SV_POSITION0;
	float4 projPos	: TEXCOORD0;
	float4 UV		: TEXCOORD1;
	float  cldAlpha	: TEXCOORD2;
	float  dist		: TEXCOORD3;
};


VS_OUTPUT vs(uint vertId: SV_VertexId)
{
	VS_OUTPUT o;
	o.pos = 0;
	return o;
}
VS_CIRCLE_OUTPUT vsCircle(uint vertId: SV_VertexId)
{
	VS_CIRCLE_OUTPUT o;
	o.vertId = vertId;
	return o;
}

float GetAfterburnerAttenuation(float attPower = 1.0)
{
	return 1;
	// return 1 - attPower * max(0,gSunDir.y);
}

// HULL SHADER ---------------------------------------------------------------------
HS_CONST_OUTPUT hsConstant( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o;
	o.edges[1] = maxSegments;
	o.edges[0] = 1; 
	return o;
}
HS_CONST_OUTPUT hsConstantHotAir( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o;
	o.edges[1] = maxSegmentsHotAir;
	o.edges[0] = 1; 
	return o;
}
[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("hsConstant")]
HS_OUTPUT hs(InputPatch<VS_OUTPUT, 1> ip, uint cpid : SV_OutputControlPointID)
{
	HS_OUTPUT o;
	o.pos = ip[0].pos;
	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("hsConstantHotAir")]
HS_OUTPUT hsHotAir(InputPatch<VS_OUTPUT, 1> ip, uint cpid : SV_OutputControlPointID)
{
	HS_OUTPUT o;
	o.pos = ip[0].pos;
	return o;
}

// DOMAIN SHADER ---------------------------------------------------------------------
[domain("isoline")]
DS_OUTPUT ds( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	DS_OUTPUT o;
	float2 sc;
	sincos(UV.x*PI, sc.x, sc.y);
	o.pos = float4(sc*0.55, opacityFactor, 0);
	return o; 
}

[maxvertexcount(4)]
void gsAfterburner(point DS_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream, uniform bool bHotAir, uniform bool bClouds)
{
	#define sinCos input[0].pos.xy
	#define gsOpacity input[0].pos.z

	GS_OUTPUT o;
	
	float3 pos = {-xLocal.x, sinCos.x, sinCos.y};
	float3 pos2 = {-xLocal.x, -sinCos.x, -sinCos.y};
	
	float3 normal = cross(normalize(pos), float3(1,0,0));
	normal = mul(float4(normal,0), World).xyz;
	
	// o.UV.z = gsOpacity * pow(abs(dot(normal, gView._13_23_33)), 1);
	o.UV.z = pow(abs(dot(normal, gView._13_23_33)), 0.3);
	o.UV.z *= 0.4 +0.6*gsOpacity;
	o.UV.z *= opacityMax;
	o.UV.w = sinCos.x;
	
	float4 vPos = mul(mul(float4(0,0,0, 1), World), gView); vPos /= vPos.w;
	o.dist = max(0, vPos.z) * 1.73 / gProj._11;
	
	if(bClouds)
		o.cldAlpha = getAtmosphereTransmittance(0).r;
	else
		o.cldAlpha = 1;
	
	float4x4 WVP = mul(World, gViewProj);

	//ребро 1
	o.pos = o.projPos = mul(float4(pos,1), WVP);
	o.UV.xy = float2(0,0);
	outputStream.Append(o);
	o.pos = o.projPos = mul(float4(pos2,1), WVP);
	o.UV.xy = float2(0,1);
	outputStream.Append(o);
	
	//ребро 2
	pos.x = pos2.x = -xLocal.y*0.9;//0.9 чтобы оставалось место на биение по X
	o.pos = o.projPos = mul(float4(pos,1), WVP);
	o.UV.xy = float2(0.9,0);
	outputStream.Append(o);
	o.pos = o.projPos = mul(float4(pos2,1), WVP);
	o.UV.xy = float2(0.9,1);
	outputStream.Append(o);

	outputStream.RestartStrip();
}

float getCircleParamStutter(float param)
{
	return circlesPos.x + circlesPos.y*param + noise2D(float2(time*1.52, param*5.123+emitterId*0.3639))*0.007*(param+0.4)*stuttPower;
}

float2 getCircleUV(in float2 UV, float t)
{
	UV.x = 20*(UV.x - t);//длина

	UV.y *= 0.85 + t*2;//ширина
	UV.y -= t - 0.075;
	
	return UV;
}

[maxvertexcount(4)]
void gsCircle(point VS_CIRCLE_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream, uniform bool bHotAir, uniform bool bClouds)
{
	#define gsVertId input[0].vertId.x
	GS_OUTPUT o;
	
	float t = getCircleParamStutter(uint((float)gsVertId+0.1f)*circleCountInv);

	float att = GetAfterburnerAttenuation(0.5);

	float4 vPos = mul(mul(float4(0,0,0, 1), World), gView); vPos /= vPos.w;
	o.dist = max(0, vPos.z) * 1.73 / gProj._11;
	
	if(bClouds)
		o.UV.z = (1-t) * att * getAtmosphereTransmittance(0).r;
	else
		o.UV.z = (1-t) * att;

	o.UV.z *= opacityMax;
	o.UV.w = 0;
	o.cldAlpha = 0;
	
	float xPos = (xLocal.x+0.012) + (xLocal.y-xLocal.x)*t;

	float4x4 WVP = mul(World, gViewProj);
	float4 wPos = mul(float4(-xPos, 0, 0, 1), World);
	
	o.UV.z *= saturate(abs(dot(normalize(wPos.xyz/wPos.w - gCameraPos), normalize(World._11_12_13))));
	
	[unroll]
	for (int i = 0; i < 4; ++i)
	{
		float4 pos = {-xPos, staticVertexData[i].xy, 1};
		if(bHotAir)
		{
			o.UV.xy = pos.yz * 2;
		}
		else
		{
			o.UV.xy = pos.yz + 0.5;
			o.UV.x = 0.875 + 0.125*o.UV.x;	// 64/512
		}
		pos.yz *= circleScale * (1 - 0.5*t);//уменьшаем масштаб с приближением к хвосту
		
		o.pos = o.projPos = mul(pos, WVP);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

void depthTest(float2 projPos, float depthRef)
{
	float depth = g_DepthTexture.SampleLevel(gPointClampSampler, float2(projPos.x, -projPos.y)*0.5 + 0.5, 0).r;
	clip(depthRef - depth);
}

float4 psAfterburner(in GS_OUTPUT i, uniform bool bHotAir): SV_TARGET0
{	
	float psOpacity = i.UV.z;
	
	float2 UVbase = i.UV.xy;
	i.UV.x *= 0.875*1.12;//ибо справа на текстуре у нас кружочек	(512-64)/512
	i.UV.x *= 0.72 + 0.2*saturate(noise1D(time+emitterId*1.3264 +i.UV.w*6.1232));
	
	float4 baseColor = afterburnerTex.Sample(WrapLinearSampler, i.UV.xy);
	//baseColor.rgb = i.UV.x>0.3 ? 0 : 0.3;

#if 0 //TODO: ????????
	if(bHotAir)
	{
		depthTest(i.projPos.xy/i.projPos.w, i.projPos.z/i.projPos.w);
		return float4(1,1,1, min(1, baseColor.a * baseColor.a * i.cldAlpha * hotAirPower * psOpacity * 2.5 * saturate(1 - (i.dist-hotAirDistOffset) * hotAirDistMaxInv)));
	}
	else
	{
		const float afterburnerBaseOpacity = baseColor.a * baseColor.a;

		//круги - вид сбоку
		const uint nCircles = (uint)circleCount;
		float3 emissiveCircles = 0;
		float4 c = 0;
		for(uint j=0; j<nCircles; ++j)
		{
			float t = getCircleParamStutter(j*circleCountInv);
			float4 circle = tex.Sample(BlackBorderLinearSampler, getCircleUV(UVbase, t));
			// emissiveCircles += (circle.rgb * circle.rgb) * (circle.a * circle.a) * 10;
			emissiveCircles += (circle.rgb * circle.rgb) * (circle.a * circle.a) * 10;
			c += circle;
		}
		float3 color = lerp(baseColor.rgb, c.rgb, c.a);
		// float3 emissive = baseColor.rgb * baseColor.rgb * afterburnerBaseOpacity;
		// emissive = emissive * (1 - c.a) + c.rgb * c.rgb * afterburnerBaseOpacity;
		float3 emissive = color * color * afterburnerBaseOpacity;
		// emissive += emissiveCircles * afterburnerBaseOpacity;

		//шум вдоль форсажа
		float2 noiseUV = UVbase * float2(0.36, 0.24) + i.UV.w*1.0256 + emitterId*4.1264 - time*6;
		float noise = noiseTex.Sample(WrapLinearSampler, noiseUV).r;
		emissive *= 1 + 10 * noise * saturate( i.UV.x - i.UV.x * pow(sin(i.UV.y*PI), 10) );
		
		return float4(emissive * (i.cldAlpha * psOpacity * 0.0112 * GetAfterburnerAttenuation(0.5)), 1);
	}
#else

	baseColor.a *= alphaOpacity;
	
	float3 emissive = baseColor.rgb*baseColor.rgb * (baseColor.a*baseColor.a);
	
	if(bHotAir)
	{
		depthTest(i.projPos.xy/i.projPos.w, i.projPos.z/i.projPos.w);
		return float4(1,1,1, min(1, baseColor.a * baseColor.a * i.cldAlpha * hotAirPower * psOpacity * 2.5 * saturate(1 - (i.dist-hotAirDistOffset) * hotAirDistMaxInv)));
	}
	else
	{
		float noiseMask = baseColor.a;
		baseColor.a *= psOpacity * 0.45;
		baseColor.a *= GetAfterburnerAttenuation(0.5);
		
		//круги
		const uint nCircles = (uint)circleCount;
		for(uint j=0; j<nCircles; ++j)
		{
			float t = getCircleParamStutter(j*circleCountInv);
			float4 circle = tex.Sample(BlackBorderLinearSampler, getCircleUV(UVbase, t));
			baseColor += circle * 0.04 * opacityMax*circleBrightness;
		}

		//перлин
		float2 noiseUV = UVbase*0.4*0.3; 
		noiseUV.x *= 1.5;
		noiseUV.y += i.UV.w*0.1523;
		noiseUV.xy += i.UV.w*0.5128 + emitterId*4.1264 - time*3;
		float noise = noiseTex.Sample(WrapLinearSampler, noiseUV*2).r;

		noise = lerp(noise, 0.00, saturate( (1-i.UV.x) + pow(sin(i.UV.y*PI), 5) ) );

		baseColor.a += noise*0.5 * pow(noiseMask,1.5);

		return baseColor * baseColor * i.cldAlpha*volumeBrightness;
	}
#endif
}

float4 psFLIR(in GS_OUTPUT i) : SV_TARGET0
{
	float psOpacity = i.UV.z;

	float2 UVbase = i.UV.xy;
	i.UV.x *= 0.875*1.111;//ибо справа на текстуре у нас кружочек	(512-64)/512
	i.UV.x *= 0.72 + 0.2*saturate(noise1D(time + emitterId * 1.3264 + i.UV.w*6.1232));

	float4 baseColor = afterburnerTex.Sample(WrapLinearSampler, i.UV.xy);

	// baseColor.rgb += lerp(pow(float3(0.89,0.54,0.47)*1.2,2), float3(0.39, 0.32, 0.85), i.UV.x)*0.6;
	baseColor.a *= alphaOpacity;

	float noiseMask = baseColor.a;
	baseColor.a *= psOpacity * 0.45;
	baseColor.a *= GetAfterburnerAttenuation(0.5);

	baseColor.a = pow(baseColor.a, 3);

	return baseColor.rrra*100;
}

float4 psCircle(in GS_OUTPUT i, uniform bool bHotAir): SV_TARGET0
{
	
	if(bHotAir)
	{
		depthTest(i.projPos.xy/i.projPos.w, i.projPos.z/i.projPos.w);
		float alpha = max(0, 1 - dot(i.UV.xy, i.UV.xy));
		return float4(1, 1, 1, min(alpha*2, 1) * hotAirPower * 0.8 * saturate(1 - (i.dist-hotAirDistOffset) * hotAirDistMaxInv));
	}
	else
	{
		float4 clr = afterburnerTex.Sample(ClampLinearSampler, i.UV.xy);
		clr.a *= alphaOpacity;
		return clr * i.UV.z * 0.72*circleBrightness;
	}
}

struct PS_INPUT
{
	float4 pos: SV_POSITION0;
	float3 uv : TEXCOORD0;
};

static const float4 quad2[4] = {
	float4( -0.5, -0.5, 0, 0),
	float4( -0.5,  0.5, 0, 0),
	float4(  0.5, -0.5, 0, 0),
	float4(  0.5,  0.5, 0, 0)
};

PS_INPUT vsGlow(uint vertId:  SV_VertexID, uniform bool bFLIR = false)
{
	const float scale = bFLIR? 3.5 : 1.1;
	const float glowOpacityMax = (bFLIR? 1 : 0.042) * opacityMax;
	const float maxVisFactorDist = 700;

	PS_INPUT o;
	float rnd = frac(sin(gModelTime*321513.5123));
	float4 vPos = quad2[vertId];

	float4 wPos = mul(float4(-0.15,0,0,1), World);
	o.pos = mul(wPos, gView);
	float dist = max(0, o.pos.z)*1.73/gProj._11;
	float scaleFactor = scale.x * (1 + 0.0005 * dist);
	o.pos += vPos * scaleFactor * (5 + rnd);
	o.pos = mul(o.pos, gProj);

	float d = dot(normalize(World._11_12_13), gView._31_32_33);
	float visibiltyFactor = bFLIR? saturate(d + 0.8) : saturate(2*d);
	visibiltyFactor = visibiltyFactor * smoothstep(50, maxVisFactorDist, dist) * saturate(1 - smoothstep(maxVisFactorDist, effectDistMax, dist));

	//stuttering
	float2 sc;
	sincos( smoothNoise1(gModelTime*10+rnd*0.1)*6.2832, sc.x, sc.y );
	o.uv.xy = mul(vPos.xy, float2x2(sc.y, sc.x, -sc.x, sc.y)) + 0.5;
	o.uv.z = visibiltyFactor * glowOpacityMax * (0.9 + 0.1*rnd);
	
	return o;
}

float4 psGlow(PS_INPUT i, uniform bool bClouds, uniform bool bFLIR = false): SV_TARGET0
{
	float alpha = max(0, glowTex.Sample(ClampLinearSampler, i.uv.xy).r - 0.01);
	alpha *= alpha * i.uv.z;

	if(bClouds)
		alpha *= getAtmosphereTransmittance(0).r;

	return float4(glowColor * glowColor, alpha);
}


technique10 Textured
{
	pass afterburner
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));
		SetGeometryShader(CompileShader(gs_4_0, gsAfterburner(false, false)));
		SetPixelShader(CompileShader(ps_4_0, psAfterburner(false)));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	pass circles
	{
		SetVertexShader(CompileShader(vs_4_0, vsCircle()));	
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsCircle(false, false)));
		SetPixelShader(CompileShader(ps_4_0, psCircle(false)));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	
	pass glow
	{
		SetVertexShader(CompileShader(vs_4_0, vsGlow()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psGlow(false)));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}	
	
	pass afterburnerClouds
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));
		SetGeometryShader(CompileShader(gs_4_0, gsAfterburner(false, true)));
		SetPixelShader(CompileShader(ps_4_0, psAfterburner(false)));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	pass circlesClouds
	{
		SetVertexShader(CompileShader(vs_4_0, vsCircle()));	
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsCircle(false, true)));
		SetPixelShader(CompileShader(ps_4_0, psCircle(false)));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	
	pass glowClouds
	{
		SetVertexShader(CompileShader(vs_4_0, vsGlow()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psGlow(true)));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	
	pass afterburnerHotAir
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(CompileShader(hs_5_0, hsHotAir()));
		SetDomainShader(CompileShader(ds_5_0, ds()));
		SetGeometryShader(CompileShader(gs_4_0, gsAfterburner(true, false)));
		SetPixelShader(CompileShader(ps_4_0, psAfterburner(true)));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	pass circlesHotAir
	{
		SetVertexShader(CompileShader(vs_4_0, vsCircle()));	
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsCircle(true, false)));
		SetPixelShader(CompileShader(ps_4_0, psCircle(true)));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}

	pass afterburnerFLIR
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));
		SetGeometryShader(CompileShader(gs_4_0, gsAfterburner(false, false)));
		SetPixelShader(CompileShader(ps_4_0, psFLIR()));

		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}

	pass glowFLIR
	{
		SetVertexShader(CompileShader(vs_4_0, vsGlow(true)));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psGlow(true, true)));

		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}
