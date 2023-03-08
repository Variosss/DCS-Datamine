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
#include "enlight/waterCommon.hlsl"
#include "enlight/waterParams.hlsl"

Texture3D<float> noiseTex;
Texture2D normalSphereTex;

float4	timePhaseFadeinSegments;
float4	scaleLengthSpinLight;
float4	fadingHeights;// -low, high, fadeInRangeInv, fadeInInv by length
float4	params3;
float4	params4;
float	params5;
float4	sunColorCorrection;//rgb - sunColor; w - attenuation
float4	dbg;

#define fadeInInv		fadingHeights.w
#define phase			scaleLengthSpinLight.x
#define segmentLengthInv scaleLengthSpinLight.y
#define spinDir			scaleLengthSpinLight.z
#define lightAmount		scaleLengthSpinLight.w//������������
#define effectTime		timePhaseFadeinSegments.x
#define scaleBase		timePhaseFadeinSegments.y
#define lodMax			timePhaseFadeinSegments.z
#define vertexCountInv	timePhaseFadeinSegments.w
#define podSmallSpeed   params5	
#define vertexIdOffset	params4.x
#define colorFadingFactor params4.y
#define lifeScaleFactor params4.z
#define lifeScalePow params4.w
// #define lodMax 3.0
// #define power dbg.x
#define power 0.35

#define dissipationFactor		params3.x // �� C++
#define dissipationFactorBase	params3.y // �� �������
#define segmentParam			params3.z // ��������������� ����� ��������
#define gOpacity     			params3.w;
static const float	sideSpeed = 2;	// �������� ������������� ������ � �������
static const float3	lumCoef = {0.2125f, 0.7154f, 0.0721f};
static const float texTile = 0.12 / ( scaleBase + 2.0);

// #define DEBUG_OUTPUT
// #define DEBUG_FIXED_SIZE 10	//������������� ������ ��������, �
// #define DEBUG_NO_JITTER		//�� ������ �������� � �������
// #define DEBUG_NO_JITTER2	//�������� �� ��������� ����� ������� �����
// #define DEBUG_NO_STRETCH	//������������ ������ ��������� ����� ������ ����
// #define DEBUG_NO_FADEIN
// #define DEBUG_NO_LIGHTING
// #define DEBUG_NO_HALO

// #define DRAW_OPAQUE		//��������� + ������������ �������
// #define DRAW_SEGMENT_ID
// #define DRAW_SEGMENT_VERT_ID
// #define DRAW_HALO_FACTOR
// #define DRAW_OPACITY
// #define DRAW_UNIQUE_ID

//техника рисования линиями:
#define SHOW_NOZZLE_DIR  //красный
#define SHOW_TANGENT	 //зеленый
#define SHOW_RESULT_SPEED//синий

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

#if defined(DRAW_OPAQUE) || defined(DRAW_SEGMENT_ID) || defined(DRAW_HALO_FACTOR) || \
	defined(DRAW_OPACITY) || defined(DRAW_SEGMENT_VERT_ID) || defined(DRAW_UNIQUE_ID)
	#define DEBUG_RENDER
	#ifndef DEBUG_OUTPUT
		#define DEBUG_OUTPUT
	#endif
#endif

#ifdef DEBUG_OUTPUT
	#define DEBUG_SET_ZERO o.debug = 0;
	// #define DEBUG_COPY_PARAMS o.debug = i.debug;
#else 
	#define DEBUG_SET_ZERO
	// #define DEBUG_COPY_PARAMS
#endif

//from god
struct VS_INPUT
{
	float4 params1: TEXCOORD0; // начальная позиция партикла в МСК, время рождения партилка
	float4 params2: TEXCOORD1; // начальная скорость партикла в МСК, время жизни партикла
	float3 params3: TEXCOORD2; // касательная к сплайну
	float4 params4: TEXCOORD3; // xy - dissipation dir(encoded); zw - wind
	float3 params5: TEXCOORD4; // color
	uint   vertId : SV_VertexID;
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
	float4 params3: TEXCOORD2;
	float4 pos	  : TEXCOORD3;
	float params4: TEXCOORD4;

#ifdef DEBUG_OUTPUT
	float4 debug  : TEXCOORD8;
#endif
};

struct HS_PATCH_OUTPUT2
{
	float edges[2]		: SV_TessFactor;
	float4 p1			: TEXCOORD5;
	float4 p2			: TEXCOORD6;
	float2 orderOffset	: TEXCOORD7;
};

struct PS_INPUT_PARTICLE
{
	float4 pos					 : SV_POSITION;
	float4 params				 : TEXCOORD0;
	nointerpolation float4 params2: TEXCOORD1;
	float4 params3				 : TEXCOORD2;
	nointerpolation float4 posW  : TEXCOORD3;
	nointerpolation uint  vertId : TEXCOORD4;
	float2 alpha                 : TEXCOORD5;


#ifdef DEBUG_OUTPUT
	nointerpolation float4 debug  : TEXCOORD8;
#endif
};

float4 debugOutput(PS_INPUT_PARTICLE i)
{
	float3 UVW				= i.params.xyz;
	float nAgeInv			= i.params.w; // 1 - начало, 0 - конец
	float3 SPEED_PROJ		= i.params2.xyz;
	float OPACITY			= i.params2.w;	
	float2 UVparticle		= i.params3.xy;
	float2 sinCos			= i.params3.zw;
	float3 PARTICLE_COLOR	= i.posW.rgb;
	float HALO_FACTOR		= i.posW.w;
	uint VERT_ID			= i.vertId;
	
	float alpha = 1.0;
	
#if defined(DRAW_OPAQUE)
	return float4(1,1,1, 0.25*alpha);
#elif defined(DRAW_SEGMENT_ID)	
	float3 p = ((asuint(VERT_ID)*21)%uint3(16,8,4)) / float3(16,8,4);
	return float4(p, 1.0*alpha);
#elif defined(DRAW_SEGMENT_VERT_ID)
	float3 p = ((asuint(VERT_ID)*21)%uint3(16,8,4)) / float3(16,8,4);
	return float4(p * (0.2+0.8*frac(i.debug.x/8)), 1.0*alpha);
#elif defined(DRAW_HALO_FACTOR)
	return float4(HALO_FACTOR.xxx, 1.0*alpha);
#elif defined(DRAW_OPACITY)
	return float4(OPACITY.xxx, 1.0*alpha);
#elif defined(DRAW_UNIQUE_ID)
	float3 p = fmod(i.debug.yyy, float3(17,9,5)) / float3(17,9,5);
	return float4(p, 1.0*alpha);
#endif
	return 1;
}

//spheremap transform
half2 encodeSMT(half3 n)
{
    half2 enc = normalize(n.xy) * sqrt(-n.z*0.5+0.5);
    // enc = enc*0.5+0.5;
    return enc;
}

float3 decodeSMT(float4 enc)
{
    // half4 nn = enc*half4(2,2,0,0) + half4(-1,-1,1,-1);
    float4 nn = enc*half4(1,1,0,0) + float4(0,0,1,-1);
    float l = dot(nn.xyz,-nn.xyw);
    nn.z = l;
    nn.xy *= sqrt(l);
    return nn.xyz * 2 + float3(0,0,-1);
}

// движение точки вдоль вектора скорости c торможением
float translationWithResistance(in float speedValue, in float time)
{	
	const float offset = -2 * (1 + (speedValue - 55.556)/150 );
	const float xMin = exp(offset);
	return 4 * (log(xMin+2*time)-offset); //итоговое перемещение
}

// движение точки вдоль вектора скорости c торможением
float translationWithResistanceSimple(in float speedValue, in float time)
{
	const float offset = -2 * (1 - (speedValue - 15.556)/80 );
	const float xMin = exp(offset);
	return 2.5 * (log(xMin+2*time)-offset); //итоговое перемещение
}

#include "smokeTrail_wire.hlsl"

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

#define techPostfix Main
#include "smokeTrail_tech.hlsl"
#undef techPostfix

#define MISSILE
#define techPostfix Missile
#include "smokeTrail_tech.hlsl"
#undef techPostfix
#undef MISSILE
