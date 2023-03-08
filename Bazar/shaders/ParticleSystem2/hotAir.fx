#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/softParticles.hlsl"

#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

float time;
float scaleBase;

static const float visibleDistanceInv = 1.0 / 500; //m

// #define DEBUG_NO_JITTER
// #define DEBUG_OPAQUE
// #define DEBUG_FIXED_SCALE 0.15

#ifdef DEBUG_FIXED_SCALE
	#define scaleBase DEBUG_FIXED_SCALE
#endif

struct VS_INPUT
{
	float4 params1: TEXCOORD0; // dist, angle, random[0..1], age
	float3 params2: TEXCOORD1; // начальная позиция партикла в мировой СК
	float4 params3: TEXCOORD2; // начальная скорость партикла в мировой СК, lifetime
	float3 params4: TEXCOORD3; // dissipation direction
};

struct VS_OUTPUT
{
	float4 params1: TEXCOORD0; // posOffset, UVangle
	float4 params2: TEXCOORD1; // speed, scale
	float2 params3: TEXCOORD2; // stretch, opacity, brigtness, Rand
};


struct PS_INPUT
{
	float4 pos	 : SV_POSITION;
	float4 params: TEXCOORD0; // UV, transparency, depth
	float2 projPos: TEXCOORD2;
};

VS_OUTPUT VS(VS_INPUT i)
{
	#define PARTICLE_POS	i.params1.xyz
	#define HEIGHT			i.params1.w
	#define EMITTER_SPEED	i.params2.x
	#define OPACITY			i.params2.y
	#define BIRTH_TIME		i.params2.z
	#define PARTICLE_SPEED	i.params3.xyz
	#define LIFETIME		i.params3.w
	#define DISSIPATION_DIR i.params4.xyz

	VS_OUTPUT o;
	float _sin, _cos;
	const float3 startSpeed = PARTICLE_SPEED;//startSpeedIn.xyz;
	const float3 startSpeedDir = normalize(startSpeed);//startSpeedIn.xyz;
	const float3 dissipationDir = normalize(DISSIPATION_DIR);
	const float speedValue = length(startSpeed);
	const float RAND = noise1D(BIRTH_TIME*2);
	const float AGE = time-BIRTH_TIME;
	const float nSpeed = speedValue/277.75; //нормализуем к 1000км/ч
	const float nAge = AGE / LIFETIME;
	const float nConv = 1-saturate(EMITTER_SPEED*3.6/100);
	const float nHeight = saturate(HEIGHT * HEIGHT / 100000000.0); //квадратичная нормализованная высота к 10км
	const float3 startPos = PARTICLE_POS - worldOffset;
	
	// угол поворота текстурных координаты
	const float UVangle = -RAND*PI2;
	
	float3 posOffset=0;
	//-------- скорость частицы вдоль вектора скорости ---------------
	const float offset = -2 * (1 + (speedValue - 55.556)/100 );
	const float xMin = exp(offset);
	posOffset.y = (log(xMin+AGE*2)-offset) * scaleBase*(1+nConv) + nConv*AGE*(4+1.0*RAND) + scaleBase + AGE;
	//----------------------------------------------------------------

	//строим СК по вектору скорости
	float3x3 speedBasis = {normalize(cross(startSpeed,dissipationDir)), startSpeedDir, dissipationDir};

	posOffset = startPos + mul(posOffset, speedBasis);
	
	//масштаб частицы
	float scale = scaleBase;
	float scaleFadeIn = min(1, nAge*30*(1+nSpeed*4));
	scaleFadeIn = pow(scaleFadeIn, 0.3) * (1+nHeight);
	scale *= 1 + (7+3*nHeight)*pow(abs(AGE*3),0.8)*nSpeed + scaleFadeIn; //чем дольше живет, тем шире * чем меньше скорость тем медленнее нарастает толщина + рандомное масштабирование по синусу

	//растягиваем по вектору скорости если надо	
	const float speedAngle = pow(abs(dot(ViewInv._31_32_33, startSpeedDir)), 3);
	const float speedStretch = 1 + 3 * (1-speedAngle) * max(0,2-AGE) * pow(abs(0.4+0.3*nSpeed), 2);	 //добавил больше размытия на минимальной скорости
	
	o.params1 = float4(posOffset, UVangle);
	o.params2 = float4(startSpeed, scale);
	o.params3.x = speedStretch;

	//прозрачность партикла	=  fadeOut * общая альфа * (чем больше высота тем прозрачнее след)
	o.params3.y  = min(1, mad(nSpeed,0.3, 1)*(1-nAge)) * pow(OPACITY, 0.8) * mad(1-nHeight, 0.5, 0.5);
 
	return o;
}

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	#define posOffset		input[0].params1.xyz
	#define UVangle			input[0].params1.w
	#define startSpeed		input[0].params2.xyz
	#define scale			input[0].params2.w
	#define speedStretch	input[0].params3.x
	#define opacityFactor	input[0].params3.y

	PS_INPUT o;

	float4x4 mBillboard = mul(billboardOverSpeed(posOffset, startSpeed, scale), gViewProj);

	float _sin,_cos;
	sincos( UVangle, _sin, _cos );

	[unroll]
	for (int i = 0; i < 4; ++i)
	{
		float4 vPos = {staticVertexData[i].x, staticVertexData[i].y, 0, 1};

		o.params.xy = float2( vPos.x*_cos - vPos.y*_sin + 0.52, vPos.x*_sin + vPos.y*_cos + 0.5 ) * 0.9;

		vPos.y *= speedStretch;//растягиваем вдоль вектора скорости

		o.pos = mul(vPos, mBillboard);

		o.projPos.xy = (o.pos.xy/o.pos.w)*0.5 + 0.5;
		o.projPos.y = 1-o.projPos.y;

		o.params.w = o.pos.z/o.pos.w;

		o.params.z = opacityFactor * pow(1-saturate(o.params.w*visibleDistanceInv),3);//opacity

		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

void depthTest(float2 projPos, float depthRef)
{
	float depth = g_DepthTexture.SampleLevel(gPointClampSampler, projPos, 0).r;
	clip(depthRef - depth);
}

float4 PS(PS_INPUT In) : SV_TARGET0
{
#ifdef DEBUG_OPAQUE
	return float4(1,0,0,0.1);
#endif
	depthTest(In.projPos.xy, In.params.w);
	
	#define	TRANSPARENCY In.params.z
	
	float alpha = tex.Sample(ClampLinearSampler, In.params.xy).a * TRANSPARENCY;

	return float4(TRANSPARENCY, 0, 0, alpha);
}


float4  PS_solid(PS_INPUT In) : SV_TARGET0
{
	return float4(In.params.z, In.params.z, In.params.z, 0.3);
}

technique10 Solid
{
	pass P0
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PS_solid())
	}
}

technique10 Textured
{
	pass P0
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PS()) 
	}
}
