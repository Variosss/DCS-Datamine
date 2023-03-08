#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/random.hlsl"
#include "common/stencil.hlsl"
#define	 ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "ParticleSystem2/common/splines.hlsl"

Texture2D normalSphereTex;

float4	timePhaseFadeinSegments;
float4	scaleLengthSpinLight;
float3	params2;

#define phase			scaleLengthSpinLight.x
#define segmentLengthInv scaleLengthSpinLight.y
#define vertexIdOffset	scaleLengthSpinLight.z
#define lightAmount		scaleLengthSpinLight.w//������������
#define effectTime		timePhaseFadeinSegments.x
#define scaleBase		timePhaseFadeinSegments.y
#define lodMax			timePhaseFadeinSegments.z
#define vertexCountInv	timePhaseFadeinSegments.w

#define trailLength		params2.x
#define segmentParam	params2.y

float4	diffuseColor;// flame color + opacity
float4	sunColorCorrection;//rgb - sunColor; w - attenuation

//static const float3	lumCoef = {0.2125f, 0.7154f, 0.0721f};

// #define DEBUG_OUTPUT
// #define DEBUG_OPAQUE			//��������� + ������������ �������
// #define DEBUG_FIXED_SIZE 1	//������������� ������ ��������, �
// #define DEBUG_NO_JITTER		//�� ������ �������� � �������
// #define DEBUG_NO_JITTER2
// #define DEBUG_NO_STRETCH
// #define DEBUG_NO_LIGHTING
// #define DEBUG_NO_HALO

// #define power dbg.x
#define power 0.35


#ifdef DEBUG_OUTPUT
	#define DEBUG_SET_ZERO o.debug = 0;
#else 
	#define DEBUG_SET_ZERO	
#endif

//from god
struct VS_INPUT
{
	float4 params1: TEXCOORD0; // pos, birthTime
	float4 params2: TEXCOORD1; // speed, lifeTime
	float2 params3: TEXCOORD2; // wind
	uint   vertId:  SV_VertexID;
};

struct VS_OUTPUT
{	
	float4 params1: TEXCOORD0; 
	float4 params2: TEXCOORD1;
	float4 params3: TEXCOORD2; 	
	float4 pos	  : TEXCOORD3;
	float nAge	  : TEXCOORD4;

#ifdef DEBUG_OUTPUT
	float4 debug  : TEXCOORD8;
#endif
};

struct DS_OUTPUT
{	
	float4 params1: TEXCOORD0;
	float4 params2: TEXCOORD1;
	float3 opacity: TEXCOORD2;
	float4 pos	  : TEXCOORD3;

#ifdef DEBUG_OUTPUT
	float4 debug  : TEXCOORD8;
#endif
};

struct HS_PATCH_OUTPUT2
{
	float edges[2] : SV_TessFactor;
	float4 p1	: TEXCOORD5;
	float4 p2	: TEXCOORD6;
	float2 orderOffset: TEXCOORD7;
};

struct PS_INPUT_PARTICLE
{
	float4 pos	  : SV_POSITION;
	nointerpolation float3 params : TEXCOORD0;
	nointerpolation float4 params2: TEXCOORD1;
	float4 params3: TEXCOORD2;
	nointerpolation uint  vertId : TEXCOORD3;
	float3 opacity: TEXCOORD4;
#ifdef DEBUG_OUTPUT
	float4 debug  : TEXCOORD8;
#endif
};

// �������� ����� ����� ������� �������� c �����������
float translationWithResistanceSimple(in float speedValue, in float time)
{	
	const float offset = -2 * (1 + (speedValue - 55.556)/100 );
	const float xMin = exp(offset);
	return 2.5 * (log(xMin+2*time)-offset); //�������� �����������
}

BlendState enableAlphaBlend2
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = FALSE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

/*
BlendState enableAlphaBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};*/

//HIGH
#define postfix		High
#define TECH_HIGH
#define PS_HALO			// �������� �������� �� ����� ���� ������ ������
#define PS_NORMAL_LIGHT // �������� ��������� �� ����� ��������
#include "flareTrail_sh.hlsl"
#undef	PS_NORMAL_LIGHT
#undef	PS_HALO
#undef	TECH_HIGH
#undef	postfix

//LOD
#define postfix		Lod
#define LOD
#include "flareTrail_sh.hlsl"
#undef LOD
#undef	postfix
