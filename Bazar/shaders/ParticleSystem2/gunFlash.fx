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

Texture3D flashTex;
Texture3D flashFrontTex;
Texture2D glowTex;
Texture3D newTex;

float params2;
float4 params;	
float4 params3;
float4 params4;
float4x4 World;

#define flashSize	(params.xy)
#define time		params.z
#define power		params.w
#define emitterId	params2.x
#define animationOffset params3.x
#define randomSize params3.yz
#define flash      params3.w
#define colorPalette params4.xyz
#define fadingOut params4.w


static const float4 glowColor = float4(1, 0.7, 0.3, 1);

static const int	maxSegments = 5;
static const float	opacityFactor = 1.0 / maxSegments;

static const float	frontBillboardSize = flashSize.x * 1.0*2.0;
static const float	frontBillboardOffset = flashSize.y * 0.3*1.2;
static const float4 frontBillboardColorMultiplier = float4(1.0, 1.0, 1.0, 1.0);
//static const float	flameStartOffset = 0.2;//������ ������� �� �������� � % �� ����� ������
static const float	flameStartOffset = 0.1;//������ ������� �� �������� � % �� ����� ������

static const float	zFeather = 0.2 / 0.13;

static const float	brightness = 0.85*power;
static const float	frontBrightness = brightness;

static const float	animationSpeed = 5;
static const float	animationRandom = 0.3;

static const float3 colorTint = float3(1.0, 0.8, 0.6) * 1.1;

struct VS_INPUT {
	float4 posBirthTime: POSITION0;
	float4 dirLifetime: POSITION1;
	float2 scale : POSITION2;
};

struct VS_OUTPUT {
	float4 posBirthTime	: POSITION0;
	float4 dirLifetime	: POSITION1;
	float2 scale : POSITION2;
};

struct VS_CIRCLE_OUTPUT{
	float4 posBirthTime	: POSITION0;
	float4 dirLifetime	: POSITION1;
	float2 scale : POSITION2;
	uint vertId: TEXCOORD2;
};

struct HS_CONST_OUTPUT{
	float edges[2] : SV_TessFactor;
};

struct DS_OUTPUT{
	float4 posBirthTime	: POSITION0;
	float4 dirLifetime	: POSITION1;
	float2 sinCos		: TEXCOORD0;
	float2 scale : POSITION2;
};

struct GS_OUTPUT{
	float4 pos  	: SV_POSITION0;
	float4 UV		: TEXCOORD0;
	float  cldAlpha	: TEXCOORD1;
	float4 projPos	: TEXCOORD2;
	float2 brigtnessFactor: TEXCOORD3;
	float4 forDistToCenterVis	: TEXCOORD4;
};

VS_OUTPUT vs(VS_INPUT i, in uint vertId: SV_VertexId)
{
	VS_OUTPUT o;
	o.posBirthTime = i.posBirthTime;
	o.dirLifetime = i.dirLifetime;
	o.scale = i.scale;
	return o;
}

HS_CONST_OUTPUT hsConstant( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o;
	o.edges[1] = maxSegments;
	o.edges[0] = 1; 
	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("hsConstant")]
VS_OUTPUT hs( InputPatch<VS_OUTPUT, 1> ip, uint cpid : SV_OutputControlPointID)
{
	VS_OUTPUT o;
	o = ip[0];
	return o;
}

[domain("isoline")]
DS_OUTPUT ds( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<VS_OUTPUT, 1> patch )
{
	DS_OUTPUT o;
	sincos(UV.x * PI, o.sinCos.x, o.sinCos.y);
	o.posBirthTime = patch[0].posBirthTime;
	o.dirLifetime = patch[0].dirLifetime;
	o.scale = patch[0].scale;
	return o; 
}

float4x4 makeFlashBasis(float3 dir, float3 pos)
{
	float3 Z = normalize(cross(dir, float3(0,1,0)));
	//float4x4 M = float4x4(float4(dir,0), float4(cross(dir,Z),0), float4(Z,0), float4(pos,1));
	float4x4 M = float4x4(float4(dir,0), float4(Z,0),float4(cross(dir,Z),0), float4(pos,1));
	//M = enlargeMatrixTo4x4(mul((float3x3)M, rotMatrixX(-PI*0.2)), M._41_42_43);
	// float4x4 M = float4x4(float4(1,0,0,0), float4(0,1,0,0), float4(0,0,1,0), float4(pos,1));
	return M;
}

float getVisibilityFactor(float3 dir, float3 mPos)
{
	float3 wPos = mul(float4(mPos, 1), World).xyz;
	// float3 wPos = World._41_42_43 + World._11_12_13 * flashSize.y * 0.5;
	// float visibilityFactor = min(1, 6*(1-abs(dot(normalize(World._11_12_13), normalize(wPos - gCameraPos.xyz)))));
	return dot(normalize(mul(dir, (float3x3)World)), normalize(wPos - gCameraPos.xyz));
}
[maxvertexcount(4)]
void gs(point DS_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream, uniform bool bClouds)
{
	float2 sinCos	= input[0].sinCos.xy;
	float3 mPos		= input[0].posBirthTime.xyz;
	float  birhtime	= input[0].posBirthTime.w;
	float3 dir		= normalize(input[0].dirLifetime.xyz);
	float  lifetime	= input[0].dirLifetime.w;
	float  opacity	= opacityFactor;
	
	float3 pos  = flashSize.yxx * float3(-flameStartOffset, sinCos.xy * 0.5);
	float3 pos2 = flashSize.yxx * float3(-flameStartOffset, -sinCos.xy * 0.5);
	
	float4x4 M = makeFlashBasis(dir, mPos);	
	float visibilityFactor = min(1, 10*(1-abs(getVisibilityFactor(dir, mPos))));
	visibilityFactor = sqrt(visibilityFactor);

	GS_OUTPUT o;
	float age = gModelTime - birhtime;
	float2 rnd = noise2(float2(birhtime, mPos.x+mPos.y+mPos.z));
	o.UV.z = frac(age*animationSpeed*1 + birhtime*5);//phase
	//o.UV.z = frac(age*animationSpeed*0 + rnd.x*animationRandom*0 + rnd.y+birhtime*50);//phase
	
	o.UV.w = (0.4 + 0.6*opacity) * visibilityFactor * 0.45;//opacity
	o.brigtnessFactor.x = brightness;
	o.brigtnessFactor.y = 1.0;
	o.cldAlpha = bClouds? getAtmosphereTransmittance(0).r : 1;

	float4x4 M2 = float4x4(
		float4(1,0,0,0),
		float4(0,1,0,0),
		float4(0,0,1,0),
		float4(mPos, 1)
		// float4(mPos.x,0,0,1)
		// float4(0,mPos.y,0,1)
		// float4(0,0,mPos.y, 1)
		// float4(10,0,0,1)
	);
	
	float4x4 WVP = mul(mul(M, World), gViewProj);

	// float4x4 WVP = mul(World, gViewProj);
	
	//????? 1
	o.forDistToCenterVis = float4(0.0, 0.0, 0.0, 0.0);
	o.pos = o.projPos = mul(float4(pos, 1), WVP);
	o.UV.xy = float2(0, 0);
	outputStream.Append(o);

	o.pos = o.projPos = mul(float4(pos2,1), WVP);
	o.UV.xy = float2(0, 1);
	outputStream.Append(o);
	
	//????? 2
	pos.x += flashSize.y;
	pos2.x = pos.x;
	o.pos = o.projPos = mul(float4(pos, 1), WVP);
	o.UV.xy = float2(1, 0);
	outputStream.Append(o);
	o.pos = o.projPos = mul(float4(pos2,1), WVP);
	o.UV.xy = float2(1, 1);
	outputStream.Append(o);

	outputStream.RestartStrip();
}

float4 ps(in GS_OUTPUT i): SV_TARGET0
{
	float4 baseColor = flashTex.SampleLevel(gPointWrapSampler, i.UV.xyz, 0);

	baseColor.a *= i.UV.w;
	baseColor.rgb *= baseColor.rgb * colorTint;
	baseColor.a *= depthAlpha(i.projPos, zFeather) * i.cldAlpha;
	return baseColor  * brightness*flash;
}


[maxvertexcount(4)]
void gsHeli(point DS_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream, uniform bool bClouds)
{
	float2 sinCos	= input[0].sinCos.xy;
	float3 mPos		= input[0].posBirthTime.xyz;
	float  birhtime	= input[0].posBirthTime.w;
	float3 dir		= normalize(input[0].dirLifetime.xyz);
	float  lifetime	= input[0].dirLifetime.w;
	float  opacity	= opacityFactor;
	
	float age = gModelTime - birhtime;
	float2 rnd = noise2(float2(age, mPos.x+mPos.y+mPos.z));
	float3 rnd2 = noise3(float3(141*mPos.x+512*mPos.y+1321*mPos.z+emitterId, 12*mPos.x+13*mPos.y*emitterId+11*mPos.z, 15*mPos.x+39*mPos.y*emitterId+21*mPos.z));
	float r =rnd2.y*randomSize.x+0.75;
	float r2 = rnd2.x*randomSize.y+0.75;
	
	//sinCos = float2(0.0, 1.0);
	
	float2 sizet = flashSize;
	float3 pos  = sizet.yxx* float3(-flameStartOffset, sinCos.xy * 0.5);
	float3 pos2 = sizet.yxx* float3(-flameStartOffset, -sinCos.xy * 0.5);
	
	float4x4 M = makeFlashBasis(dir, mPos);	
	float visibilityFactor = min(1, 10*(1-abs(getVisibilityFactor(dir, mPos))));
	visibilityFactor = sqrt(visibilityFactor);

	GS_OUTPUT o;
	// o.UV.z = frac(age*animationSpeed + rnd.x*animationRandom + rnd.y);//phase
	o.UV.z = frac(age*animationSpeed*0.4 + rnd.x*animationRandom + rnd.y);//phase
	o.UV.w = (0.4 + 0.6*opacity) * visibilityFactor * 0.45;//opacity
	o.cldAlpha = bClouds? getAtmosphereTransmittance(0).r : 1;

	float4x4 M2 = float4x4(
		float4(1,0,0,0),
		float4(0,1,0,0),
		float4(0,0,1,0),
		float4(mPos, 1)
		// float4(mPos.x,0,0,1)
		// float4(0,mPos.y,0,1)
		// float4(0,0,mPos.y, 1)
		// float4(10,0,0,1)
	);

	float4x4 mView = mul(mul(M, World), gView);
	float4x4 WVP = mul(mView, gProj);
	
	float angleFactor = pow(saturate(abs(mView._23)), 3);
	o.brigtnessFactor.x = angleFactor;
	o.brigtnessFactor.y = step(0.25, rnd2.z)* rnd2.z*4;


	o.forDistToCenterVis.w = abs(getVisibilityFactor(dir, mPos));

	// float4x4 WVP = mul(World, gViewProj);
	
	//����� 1
	o.pos = o.projPos = mul(float4(pos, 1), WVP);

	o.UV.xy = float2(0, 0);
	o.UV.x = lerp(o.UV.x, 1.0-o.UV.x, step(r, 0.0));
	o.forDistToCenterVis.xy = pos.yz/(sizet.x*0.5);
	o.forDistToCenterVis.z = (1.0);
	outputStream.Append(o);

	o.pos = o.projPos = mul(float4(pos2,1), WVP);
	o.UV.xy = float2(0, 1);
	o.forDistToCenterVis.xy = pos2.yz/(sizet.x*0.5);
	o.UV.x = lerp(o.UV.x, 1.0-o.UV.x, step(r, 0.0));
	o.forDistToCenterVis.z = (1.0);
	outputStream.Append(o);

	//����� 2
	pos.x += sizet.y;
	pos2.x = pos.x;
	o.pos = o.projPos = mul(float4(pos, 1), WVP);
	o.forDistToCenterVis.xy = pos.yz/(sizet.x*0.5);
	o.UV.xy = float2(1, 0);
	o.UV.x = lerp(o.UV.x, 1.0-o.UV.x, step(r, 0.0));
	o.forDistToCenterVis.z = (-1.0);
	outputStream.Append(o);



	o.pos = o.projPos = mul(float4(pos2,1), WVP);
	o.forDistToCenterVis.xy = pos2.yz/(sizet.x*0.5);
	o.forDistToCenterVis.z = (-1.0);
	o.UV.xy = float2(1, 1);
	o.UV.x = lerp(o.UV.x, 1.0-o.UV.x, step(r, 0.0));






	outputStream.Append(o);

	outputStream.RestartStrip();
}


float4 psHeli(in GS_OUTPUT i): SV_TARGET0
{
	float2 p = float2(1.0-i.UV.xyz.x,1.0-i.UV.y);
	p -= 0.5;
	p *= 2;

	//float4 baseColor = flashTex.SampleLevel(gPointWrapSampler, float3(1.0-i.UV.xyz.x, 1.0-i.UV.y, 1.0-i.UV.z), 0);
	//	baseColor = newTex.SampleLevel(gPointWrapSampler, float3( 1.0-i.UV.y, i.UV.xyz.x, (1.0-i.UV.z)), 0);

	float edgeAlpha = 1.0 - length(i.forDistToCenterVis.xy);
	float edgeAlpha2 = 1.0 - i.forDistToCenterVis.z;
	//return float4(1.0, 0.0, 0.0, edgeAlpha);
	//edgeAlpha = length(i.mPos-i.pos);
	
	/*
	if (edgeAlpha2 > 0.5)
		return float4(1.0, 0.0, 0.0, 1.0);
	else
		return float4(0.0, 1.0, 0.0, 1.0);
	*/
	
	float4 baseColor = newTex.SampleLevel(gTrilinearClampSampler, float3(1.0-i.UV.xyz.x,1.0-i.UV.y, i.UV.z+animationOffset), 0);
	//baseColor.a *= baseColor.a;

	baseColor.a *= i.UV.w;
	//baseColor.rgb *= baseColor.rgb * colorTint;
	baseColor.rgb *= lerp(colorPalette, float3(1.0, 1.0, 1.0), baseColor.a);
	//baseColor.rgb *= colorTint*float3(1.35, 1.1, 1.0);

	//float edgeWeight = pow(edgeAlpha2,3)*pow((1.0 - i.forDistToCenterVis.w),2) + pow(i.forDistToCenterVis.w,1)*pow(edgeAlpha,5);
	edgeAlpha = pow(edgeAlpha,3);
	//edgeAlpha2 = pow(edgeAlpha2,1);
	//edgeAlpha = lerp(edgeAlpha, 1.0, max(1.0-i.forDistToCenterVis.w, 0.1));
	//edgeAlpha2 = lerp(edgeAlpha2, 1.0, max(i.forDistToCenterVis.w, 0.1));

	edgeAlpha = lerp(edgeAlpha, 1.0, min(max(1.0-i.forDistToCenterVis.w , 0.0), 0.8));
	//edgeAlpha2 = lerp(edgeAlpha2, 1.0, min(max(i.forDistToCenterVis.w, 0.1), 0.9)*1.0/0.9);
	//edgeAlpha = 1.0;
	//float edgeWeight = edgeAlpha2*edgeAlpha;
	float edgeWeight = edgeAlpha;
	edgeWeight = edgeWeight*1.2;
	//edgeWeight = 1.0;
	//edgeWeight = 1.0 - i.forDistToCenterVis.z;

	baseColor.a *= depthAlpha(i.projPos, zFeather) * i.cldAlpha * edgeWeight;
	//baseColor.a *= depthAlpha(i.projPos, zFeather) * i.cldAlpha;
	float b = fadingOut*0.4+0.6;
	
	float semiBright = 1.0-b;
	float bright = (brightness*(b+ semiBright*saturate(1.0-sqrt(dot(p, p))/0.2))*brightness);
	return baseColor * baseColor * bright* flash*0.6;
}


// Front ---------------------------------------------------------------------------------

VS_CIRCLE_OUTPUT vsCircle(VS_INPUT i, uint vertId: SV_VertexId)
{
	VS_CIRCLE_OUTPUT o;
	o.posBirthTime = i.posBirthTime;
	o.dirLifetime = i.dirLifetime;
	o.vertId = vertId;
	o.scale = i.scale;
	return o;
}

void generateCircle(inout TriangleStream<GS_OUTPUT> outputStream, inout GS_OUTPUT o, in float xPos, in float width)
{
	[unroll]
	for (int i = 0; i < 4; ++i)
	{
		o.UV.xy = staticVertexData[i].zw;
		o.pos = mul(mul(float4(xPos, staticVertexData[i].xy*width, 1), World), gViewProj);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

[maxvertexcount(4)]
void gsCircle(point VS_CIRCLE_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream, uniform bool bClouds)
{
	float gsVertId	= input[0].vertId.x;
	float3 mPos		= input[0].posBirthTime.xyz;
	float  birthtime= input[0].posBirthTime.w;
	float3 dir		= input[0].dirLifetime.xyz;
	float  lifetime	= input[0].dirLifetime.w;

	float4x4 M = makeFlashBasis(dir, mPos);	
	float visibilityFactor = abs(getVisibilityFactor(dir, mPos));
	visibilityFactor *= visibilityFactor * visibilityFactor;
	
	float4x4 mView = mul(mul(M, World), gView);
	float4x4 WVP = mul(mView, gProj);
	
	GS_OUTPUT o;
	float age = gModelTime - birthtime;
	float2 rnd = noise2(float2(age, mPos.x+mPos.y+mPos.z));
	o.UV.z = frac(age*animationSpeed + rnd.x*animationRandom + rnd.y);//phase
	o.UV.w = visibilityFactor * (bClouds ? getAtmosphereTransmittance(0).r : 1);
	float angleFactor = pow(saturate(abs(mView._23)), 2);
	o.cldAlpha = 0;
	o.brigtnessFactor = 1.0;
	o.brigtnessFactor.x = angleFactor*0.6+0.4;
	o.forDistToCenterVis = float4(0.0, 0.0, 0.0, 0.0);
	[unroll]
	for (int i = 0; i < 4; ++i)
	{
		o.UV.xy = staticVertexData[i].zw;
		o.pos = o.projPos = mul(float4(frontBillboardOffset, staticVertexData[i].xy*frontBillboardSize, 1), WVP);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}


[maxvertexcount(4)]
void gsCircleHeli(point VS_CIRCLE_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream, uniform bool bClouds)
{
	float frontBillboardOffsetHeli = frontBillboardOffset*0.6;
	float frontBillboardSizeHeli = frontBillboardSize*0.55;

	float gsVertId	= input[0].vertId.x;
	float3 mPos		= input[0].posBirthTime.xyz;
	float  birthtime= input[0].posBirthTime.w;
	float3 dir		= input[0].dirLifetime.xyz;
	float  lifetime	= input[0].dirLifetime.w;

	float4x4 M = makeFlashBasis(dir, mPos);	
	float visibilityFactor = abs(getVisibilityFactor(dir, mPos));
	//visibilityFactor *= visibilityFactor * visibilityFactor;
	
	float4x4 mView = mul(mul(M, World), gView);
	float4x4 WVP = mul(mView, gProj);
	
	GS_OUTPUT o;
	float age = gModelTime - birthtime;
	float2 rnd = noise2(float2(age, mPos.x+mPos.y+mPos.z));
	o.UV.z = frac(age*animationSpeed + rnd.x*animationRandom + rnd.y);//phase
	o.UV.w = visibilityFactor * (bClouds ? getAtmosphereTransmittance(0).r : 1);
	float angleFactor = pow(saturate(abs(mView._23)), 2);
	o.cldAlpha = 0;
	o.brigtnessFactor = 1.0;
	o.brigtnessFactor.x = angleFactor*0.6+0.4;
	o.forDistToCenterVis = float4(0.0, 0.0, 0.0, 0.0);
	[unroll]

	o.forDistToCenterVis.w = abs(getVisibilityFactor(dir, mPos));
	float4 center_pos = mul(float4(frontBillboardOffsetHeli, float2(0.0, 0.0), 1), WVP);
	for (int i = 0; i < 4; ++i)
	{
		o.UV.xy = staticVertexData[i].zw;
		o.pos = o.projPos = mul(float4(frontBillboardOffsetHeli, staticVertexData[i].xy*frontBillboardSizeHeli, 1), WVP);
		o.forDistToCenterVis.xy = staticVertexData[i].xy;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}


float4 psCircle(in GS_OUTPUT i): SV_TARGET0
{
	float2 p = float2(1.0-i.UV.xyz.x,1.0-i.UV.y);
	p -= 0.5;
	p *= 2;
	float4 baseColor = flashFrontTex.SampleLevel(gPointWrapSampler, i.UV.xyz, 0);
	
	baseColor.a *= i.UV.w;
	baseColor.rgb *= lerp(colorPalette, float3(1.0, 1.0, 1.0), baseColor.a);
	baseColor.a *= depthAlpha(i.projPos, zFeather) ;
		baseColor.rgb *= baseColor.rgb * colorTint;

	
	float b = sqrt(1.0-fadingOut)*0.9+0.1;

	
	float semiBright = 1.0-b;
	float bright = brightness*(b+ semiBright*saturate(1.0-sqrt(dot(p, p))/0.6))*0.7;
		return baseColor  * bright* flash*2;

}


float4 psCircleHeli(in GS_OUTPUT i): SV_TARGET0
{
	float2 p = float2(1.0-i.UV.xyz.x,1.0-i.UV.y);
	p -= 0.5;
	p *= 2;
	float4 baseColor = flashFrontTex.SampleLevel(gPointWrapSampler, i.UV.xyz, 0);
	
	baseColor.a *= i.UV.w;
	baseColor.rgb *= lerp(colorPalette, float3(1.0, 1.0, 1.0), baseColor.a);
	baseColor.a *= depthAlpha(i.projPos, zFeather) ;
		baseColor.rgb *= baseColor.rgb * colorTint;

	//baseColor.a*= 0.2;
	float edgeAlpha = pow(1.0-length(i.forDistToCenterVis.xy), 3);
	edgeAlpha = lerp(edgeAlpha, 1.0, max(pow(i.forDistToCenterVis.w, 5)-0.5, 0.0));
	//edgeAlpha*= edgeAlpha;
	baseColor.a *= edgeAlpha;
	
	//float b = sqrt(1.0-fadingOut)*0.9+0.1;
	float b = sqrt(1.0-fadingOut)*0.4 + 0.6;
	b*= 0.7;

	
	float semiBright = 1.0-b;
	float bright = brightness*(b+ semiBright*saturate(1.0-sqrt(dot(p, p))/0.6))*0.7;
		return baseColor  * bright* flash*2*frontBillboardColorMultiplier;

}

// Glow ---------------------------------------------------------------------------------

struct PS_INPUT
{
	float4 pos: SV_POSITION;
	float3 uv : TEXCOORD0;
};

static const float4 quad2[4] = {
	float4( -0.5, -0.5, 0, 0),
	float4( -0.5,  0.5, 0, 0),
	float4(  0.5, -0.5, 0, 0),
	float4(  0.5,  0.5, 0, 0)
};

PS_INPUT vsGlow(uint vertId:  SV_VertexID)
{
	PS_INPUT o;
	float rnd = noise1(gModelTime*21513.5123);
	float4 vPos = quad2[vertId];
	
	const float scale = 5.0;
	const float opacityMax = 0.7;
	
	o.pos = mul(mul(float4(-0.15,0,0,1), World), gView);
	float dist = max(0, o.pos.z)*1.73/gProj._11;
	float scaleFactor = scale.x * (1 + 0.0005 * dist);
	o.pos += vPos * scaleFactor * (5 + rnd);
	o.pos = mul(o.pos, gProj);
	
	float visibiltyFactor = saturate(3*(dot(normalize(World._11_12_13), -gView._31_32_33)));
	visibiltyFactor = sqrt(visibiltyFactor) * min(1, dist/100);
	
	//stuttering
	float2 sc;
	sincos( smoothNoise1(gModelTime*10+rnd*0.1)*6.2832, sc.x, sc.y );
	o.uv.xy = mul(vPos.xy, float2x2(sc.y, sc.x, -sc.x, sc.y)) + 0.5;
	o.uv.z = visibiltyFactor * opacityMax * (0.9 + 0.1*rnd);
	
	return o;
}

float4 psGlow(PS_INPUT i, uniform bool bClouds): SV_TARGET0
{
	
	float4 color = glowColor * glowTex.Sample(ClampLinearSampler, i.uv).r * i.uv.z;
	
	if(bClouds)
		color *= getAtmosphereTransmittance(0).r;
	
	return color;
}


technique10 Textured
{
	pass flashSide
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));
		SetGeometryShader(CompileShader(gs_4_0, gs(false)));
		SetPixelShader(CompileShader(ps_4_0, ps()));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}	
	pass flashFront
	{
		SetVertexShader(CompileShader(vs_4_0, vsCircle()));	
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsCircle(false)));
		SetPixelShader(CompileShader(ps_4_0, psCircle()));
		
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
	
	pass flashSideClouds
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));
		SetGeometryShader(CompileShader(gs_4_0, gs(true)));
		SetPixelShader(CompileShader(ps_4_0, ps()));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	pass flashFrontClouds
	{
		SetVertexShader(CompileShader(vs_4_0, vsCircle()));	
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsCircle(true)));
		SetPixelShader(CompileShader(ps_4_0, psCircle()));
		
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
	pass newHelicopter
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));
		SetGeometryShader(CompileShader(gs_4_0, gsHeli(false)));
		SetPixelShader(CompileShader(ps_4_0, psHeli()));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	pass flashFrontHeli
	{
		SetVertexShader(CompileShader(vs_4_0, vsCircle()));	
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsCircle(false)));
		SetPixelShader(CompileShader(ps_4_0, psCircleHeli()));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
	pass flashFrontCloudsHeli
	{
		SetVertexShader(CompileShader(vs_4_0, vsCircle()));	
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsCircleHeli(true)));
		SetPixelShader(CompileShader(ps_4_0, psCircleHeli()));
		
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}

}
