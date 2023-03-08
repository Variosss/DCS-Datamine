/*
	���� �� ���� �� �������� + ������ � ��� ����
*/
#include "common/samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#define FOG_ENABLE
#include "common/fog2.hlsl"
#include "common/ambientCube.hlsl"
#include "common/stencil.hlsl"
#include "common/softParticles.hlsl"
#define ATMOSPHERE_COLOR
#define CASCADE_SHADOW
#include "ParticleSystem2/common/psCommon.hlsl"
#include "enlight/skyCommon.hlsl"
#include "enlight/underwater.hlsl"

Texture3D foamTex;

float3	shipSize;	// x - length, y-width, z-nose angle cos
float	scaleBase;
float	speed;
float	width;

SamplerState MirrorLinearSampler
{
	Filter        = MIN_MAG_MIP_LINEAR;
	AddressU      = MIRROR;
	AddressV      = MIRROR;
	AddressW      = MIRROR;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};

struct VS_OUTPUT
{
	float4 pos	 : POSITION0;
	float3 params: TEXCOORD0;
	float2 params2: TEXCOORD1;
};

struct PS_INPUT
{
	float4 pos		 : SV_POSITION0;
	float3 posW	 : TEXCOORD0;
	float3 TextureUV : TEXCOORD1;
	float2 age		 : TEXCOORD2;
};


struct PS_OUTPUT
{
	float3 add: SV_TARGET0;
	float3 mult: SV_TARGET1;
};

VS_OUTPUT VS(float4 params		: TEXCOORD0, // UV, random[0..1], age
			 float3 startPos	: TEXCOORD1, // ��������� ������� �������� � ������� ��
			 float4 startVelIn: TEXCOORD2) // ��������� �������� �������� � ������� ��
{
	float lifetime	= startVelIn.w;
	float DIST		= params.x;
	float ANGLE		= params.y;
	float RAND		= params.z; //��������� ����� ��� ��������
	float AGE		= params.w; //����� ����� �������� � ��������

	const float3 startVel = startVelIn.xyz;
	const float nAge = AGE / lifetime;
	const float nSpeed = min(1, speed/13.9); // �� 50 ��/�	

	float posSideOffset = (DIST-0.5) * width;//������� �� ������

	//��������� ������� � ������ �� � ���������� � ��������� �������
	float3 posOffset = startPos - worldOffset + normalize(float3(startVel.z, 0, -startVel.x)) * posSideOffset;

	float scaleFactor = 1 + 0.5 * nAge;
	float scale = scaleBase * scaleFactor;

	float distFactor = max(0, (distance(gCameraPos, posOffset) - 500)) / 9500;

	float dir = step(0.5, RAND);
	//������������
	float fadeIn = 0.3 + 0.7 * saturate(nAge*10);
	float opacity = min(fadeIn, pow(saturate(2*(1-nAge)), 3)) * (0.5 + 0.5*nSpeed) / scaleFactor / (1+1*distFactor);

	float textureFrame = RAND - AGE + 0.01*AGE*AGE;

	VS_OUTPUT o;
	o.pos 		= float4(posOffset, ANGLE);	
	o.params	= float3(scale, dir, opacity);
	o.params2	= float2(textureFrame, nAge);
	return o;
}

[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream, uniform float sizeMult = 1.0)
{
	PS_INPUT o;
	o.age = input[0].params2.xy;

	float3 posOffset	= input[0].pos.xyz;
	float  angle		= input[0].pos.w;
	float  scale		= input[0].params.x * lerp(1, sizeMult, o.age.y);
	float  Rand			= input[0].params.y;
	float  opacity		= input[0].params.z;

	float2x2 mRot = rotMatrix2x2(angle);
	
	o.TextureUV.z = opacity;
	
	[unroll]
	for(uint i = 0; i < 4; i++)
	{
		o.TextureUV.xy = float2(staticVertexData[i].z + Rand, staticVertexData[i].w);

		float3 vPos = {staticVertexData[i].x, 0, staticVertexData[i].y};
		vPos.xz = mul(vPos.xz, mRot) * scale;
		o.posW = vPos + posOffset;
		o.pos = mul(float4(o.posW, 1), VP);
		//o.posW += worldOffset;

		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 PS(PS_INPUT i) : SV_TARGET0
{
	float frame		= i.age.x;
	float nAge		= i.age.y;
	float opacity	= i.TextureUV.z;

	float foam = foamTex.Sample(WrapLinearSampler, float3(i.TextureUV.xy, frame)).r;//������������� �������� ����
	float circleMask = tex.Sample(WrapLinearSampler, i.TextureUV.xy).a;//������
	float grad = min(1, nAge*2.0);
	float mask = foam * circleMask;
	mask *= lerp(1, mask, grad);

	const float albedo = 0.6;
	float3 sunColor = getPrecomputedSunColor(0);
	float3 clr = shading_AmbientSun(albedo, AmbientAverage, sunColor)*mask;

	mask *= underwaterVisible(i.posW);

	return float4(clr, mask);
}

//------------------------------------------- BOW FOAM -------------------------------------------------------//

struct VS_OUTPUT_BOW
{
	float4 pos	  : POSITION0;
	float4 params : TEXCOORD0; // UV, transparency, nAge
	float3 params2: TEXCOORD1;
};

struct PS_INPUT_BOW
{
	float4 pos		 : SV_POSITION0;
	float4 projPos	 : TEXCOORD0;
	float4 TextureUV : TEXCOORD1; // UV, transparency, nAge, zFeather
	nointerpolation float3 age: TEXCOORD2;
	nointerpolation float shadow: TEXCOORD3;
};

static const float bowOpacityMax = 0.6;
static const float bowAngle = 90*PI/180;//45 �������� ����� �����
static const float bowHorizontalSpeed = 0.8;
static const float bowVertSpeed = 0.6;
static const float bowZFeatherFactor = 0.5;

VS_OUTPUT_BOW VS_bow(
	float4 params	: TEXCOORD0, // rnd1, rndAngle, rnd3, age
	float3 startPos	: TEXCOORD1, // ��������� ������� �������� � ������� ��
	float4 startVelIn: TEXCOORD2) // ��������� �������� �������� � ������� ��
{
	float  lifetime	= startVelIn.w;
	float  DIST		= params.x;
	float  RAND		= params.y;
	float  RAND2	= params.z;
	float  AGE		= params.w;
	
	const float3 startVel = startVelIn.xyz;
	const float  speed = length(startVel);
	const float  nAge = AGE / lifetime;
	const float  nSpeed = min(1, speed/13.9); // �� 50 ��/�
	const float  sizeFactor = saturate(shipSize.x / 150);

	float dir = RAND>0.5? 1 : -1;	

	//side speed
	float speedTotal = speed / shipSize.z;
	float waterSpeed = sqrt(speedTotal*speedTotal - speed*speed);//������� �������� �� ����������� ����
	float sideSpeed = (1.0/exp(speed/60))*dir * waterSpeed * (1+1.0*DIST);
	//vertical speed
	float vertSpeed = (1.0/exp(speed/13))*(bowVertSpeed * speed * (1 + 3*sizeFactor) - 9.8*AGE) * (0.3+0.7*DIST);

	const float scaleFactorMin = 0.2;
	float3 posOffset = float3(scaleBase * scaleFactorMin * 0.5, vertSpeed * AGE - scaleBase*scaleFactorMin, sideSpeed * AGE);
	posOffset.xz += float2(-speed / speedTotal, dir * waterSpeed / speedTotal) * (shipSize.x * (0.10 - 0.07*sizeFactor) * RAND2);
	
	//��������� ������� �������� � ������ ��
	float3x3 speedBasis = basisShip(startVel);
	posOffset = startPos + mul(posOffset, speedBasis) - worldOffset;

	float scaleFactor = (scaleFactorMin + (1-scaleFactorMin)*sqrt(nAge)) * (0.5 + 0.5*nSpeed);
	float scale = scaleBase * scaleFactor;

	float fadeIn = saturate(nAge*5);
	float fadeOut = saturate(2*(1-nAge));
	float opacity = min(fadeIn, fadeOut*fadeOut*fadeOut) * (0.5 + 0.5*nSpeed) / scaleFactor * bowOpacityMax;

	VS_OUTPUT_BOW o;
	o.params2.x = RAND - AGE;
	o.params2.y = 0.2 + 0.8*pow(nAge, 0.1);
	o.params2.z = getSunBrightness();
	o.pos		= float4(posOffset, DIST*PI2);
	o.params	= float4(scale, dir, opacity, 1.0 / (scale*bowZFeatherFactor));
	return o;
}

[maxvertexcount(4)]
void GS_bow(point VS_OUTPUT_BOW input[1], inout TriangleStream<PS_INPUT_BOW> outputStream, uniform bool bShadows)
{
	float3 posOffset	= input[0].pos.xyz;
	float  angle		= input[0].pos.w;
	float  scale		= input[0].params.x;
	// float  Rand			= input[0].params.y;

	float4 centerProjPos = mul(float4(posOffset, 1), VP);

	PS_INPUT_BOW o;
	o.TextureUV.zw = input[0].params.zw;
	o.age = input[0].params2;
	o.shadow = bShadows? getCascadeShadow(posOffset.xyz, centerProjPos.z/centerProjPos.w) : 1.0;

	float4x4 mBillboard = mul(billboard(posOffset, scale, angle), VP);

	[unroll]
	for (int i = 0; i < 4; i++)
	{
		o.TextureUV.xy = float2(staticVertexData[i].zw);

		o.pos = o.projPos = mul(float4(staticVertexData[i].xy, 0, 1), mBillboard);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 PS_bow(PS_INPUT_BOW i) : SV_TARGET0
{
	//������������� ����
	float clrFoam = foamTex.Sample(MirrorLinearSampler, float3(i.TextureUV.xy, i.age.x)).r;

	//����� ��� ��������
	float4 clr = { 1, 1, 1, tex.Sample(WrapLinearSampler, i.TextureUV.xy).a};

	clr.a *= lerp(1, clrFoam*clrFoam, i.age.y) * i.TextureUV.z;
	clr.a *= depthAlpha(i.projPos, i.TextureUV.w);

	const float albedo = 0.6;
	float3 sunColor = getPrecomputedSunColor(0) * ((0.1+i.shadow*0.4) / 3.14159);
	clr.rgb = shading_AmbientSun(albedo, AmbientAverage, sunColor);
	clr.rgb = applyPrecomputedAtmosphere(clr.rgb, 0);

	return clr;
}

float sampleFoam(float2 uv, float frame) {
	float f0 = foamTex.Sample(WrapLinearSampler, float3(uv, frame)).r;
	float f1 = foamTex.Sample(WrapLinearSampler, float3(uv, frame + 0.5)).r;
	float lerpPhase = 2 * abs(frac(frame) - 0.5);	// triangle pulse
	return lerp(f0, f1, lerpPhase);
}

float4 PS_FOAM(PS_INPUT i) : SV_TARGET0
{
	float frame = i.age.x * 0.05;
	float nAge = i.age.y;
	float opacity = saturate(i.TextureUV.z * 2);

	float2 da = frac(i.TextureUV.xy)*2 - 1;
	float a = 1 - length(da);	//	calculate alpha circle

	float2 uv = frac(i.TextureUV.xy);

	float t = gModelTime* 0.3;
	float2 phase = frac(float2(t, t + 0.5));

	float f0 = sampleFoam((uv - 0.5) * (1 - phase[0]*0.5) + 0.5, frame);
	float f1 = sampleFoam((uv - 0.5) * (1 - phase[1]*0.5) + 0.5, frame + 0.5);
	float lerpPhase = 2 * abs(phase[0] - 0.5);
	float f = lerp(f0, f1, lerpPhase);

	float foam = pow(f, 0.5)  * a;

	float blend = pow(min(1 - nAge, nAge * 7), 0.5);
	return foam * blend;

//	mask *= underwaterVisible(i.posW);
//	return float4(clr, mask); 
}


BlendState foamAlphaBlend
{
	BlendEnable[0] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;

	SrcBlendAlpha = ONE;
	DestBlendAlpha = ONE;
	BlendOpAlpha = MAX;

	RenderTargetWriteMask[0] = 0x0f;
};

DepthStencilState foamDS
{
	DepthEnable		= false;
	DepthWriteMask	= false;
	DepthFunc		= ALWAYS;

	TEST_COMPOSITION_TYPE_IN_STENCIL;
};

BlendState foamOnly {
	BlendEnable[0] = TRUE;
	SrcBlend = ZERO;
	DestBlend = ONE;
	BlendOp = ADD;
	SrcBlendAlpha = ONE;
	DestBlendAlpha = ONE;
	BlendOpAlpha = MAX;
	RenderTargetWriteMask[0] = 0x08; //ALPHA
};

technique10 Textured	// ship trail foam tech
{
	pass P0
	{
		SetDepthStencilState(foamDS, STENCIL_COMPOSITION_WATER);
		SetBlendState(foamAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
		
		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PS())
	}
	pass P1	{		// tech for target bowwave
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, PS_FOAM()));
		SetGeometryShader(CompileShader(gs_5_0, GS(0.5)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(foamOnly, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

technique10 Bow
{
	pass noShadows
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;


		VERTEX_SHADER(VS_bow())
		SetGeometryShader(CompileShader(gs_5_0, GS_bow(false)));
		PIXEL_SHADER(PS_bow())
	}
	pass withShadows
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS_bow())
		SetGeometryShader(CompileShader(gs_5_0, GS_bow(true)));
		PIXEL_SHADER(PS_bow())
	}
}
