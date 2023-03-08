#include "common/samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

static const float distMax = 3.48;// максимальная дистанция вылета партикла
static const float opacityMax = 0.035;

float side;
float scaleBase; //масштаб частицы
float emitterId;
int	  lod;

struct VS_OUTPUT
{
	float4 pos		: POSITION0;
	float4 vel  	: TEXCOORD0;
	float3 params	: TEXCOORD1;
};

struct PS_INPUT
{
	float4 pos		 : SV_POSITION0;
	float4 TextureUV : TEXCOORD0; // UV, transparency
	nointerpolation float  inCamera : TEXCOORD1;
	nointerpolation float3 color	: TEXCOORD2;
};

VS_OUTPUT VS(float4 startPosIn		: TEXCOORD0, // UV, random[0..1], age
			 float4 vortexVelIn		: TEXCOORD1, // начальная позиция партикла в мировой СК
			 float4 aircraftVelAGE	: TEXCOORD2) // начальная скорость партикла в мировой СК
{
	const float  lifetime		= startPosIn.w;
	const float  BIRTH_TIME		= vortexVelIn.w;
	const float3 aircraftVel	= aircraftVelAGE.xyz;
	const float  AGE			= aircraftVelAGE.w;

	const float3 startPos = startPosIn.xyz - worldOffset;
	const float3 vortexVel = vortexVelIn.xyz;
	
	const float nAge = AGE / lifetime;

	const float aircraftSpeed = length(aircraftVel);
	const float vortexSpeed = length(vortexVel);
	const float nSpeed = min(1, vortexSpeed*0.008); //450км/ч

	float3 particleVelWorld = aircraftVel + vortexVel;
	float  particleSpeed = length(particleVelWorld);
	float3 particleVelWorldDir = particleVelWorld / particleSpeed;

	//ускорение торможения
	const float deceleration = 100;

	const float ANGLE = createPerlinNoise1D(BIRTH_TIME*(1+7*nSpeed) + emitterId*3);

	//проекция смещения партикла в плоскости XZ в системе координат связанной с вектором скорости партикла
	float _sin, _cos; 
	sincos( (ANGLE+side*AGE) * PI2, _sin, _cos );

	//радиальное перемещение
	float3 posOffset = float3(_sin, 0, _cos) * (distMax * pow(abs(nAge), 2) *  scaleBase * (0.2 + 0.8*nSpeed));

	// перемещение вдоль вектора скорости
	float ageCap = min(AGE, particleSpeed/deceleration);

	//строим СК по вектору скорости	
	float3x3 speedBasis = basis(normalize(vortexVel));

	//переводим партикл в мирвую СК и прибавляем к стартовой позиции
	VS_OUTPUT o;
	o.pos.xyz = startPos + mul(posOffset, speedBasis);
	o.pos.xyz += particleVelWorldDir * ((particleSpeed - 0.5*deceleration*ageCap) * ageCap);

	//вычисляем угол, на который надо довернуть плашку, штобы она была ориентирована по вектору скорости
	float inCamera = abs(dot(ViewInv._31_32_33, normalize(-vortexVel)));
	float speedStretch = 1 + 5*(1-pow(inCamera,2));
	o.pos.w = pow(inCamera, 20);

	//поворачиваем плашку вдоль вектора скорости
	o.vel = float4(lerp(-vortexVel, aircraftVel, saturate(AGE / (particleSpeed/deceleration))), scaleBase*(1+nAge));

	//растягиваем вдоль вектора скорости
	o.params.z = speedStretch;

	o.params.x = 0.01+0.99*pow(abs(nAge), 1.5);

	// прозрачность = начальное условие * конечное условие * лод
	float startTransp = min(1, nAge*15);
	o.params.y =  startTransp * (1 - 2.0*max(0,nAge-0.7)) * opacityMax;
	o.params.y *= (1+1.0*lod)*(1 + 0.7*(1-nSpeed));
	o.params.y *= (1 - 0.4 * o.pos.w);//in camera factor
	// освещенность
	// o.params.y *= max(0.01, 0.666*(0.5 + sunDir.y));

	return o;
}

[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float3 posOffset	= input[0].pos.xyz;
	float3 vortexDir	= input[0].vel.xyz;
	float  scale		= input[0].vel.w;
	float  age			= input[0].params.x;
	float  opacity		= input[0].params.y;
	float  speedStretch	= input[0].params.z;

	PS_INPUT o;
	o.TextureUV.z = age;
	o.TextureUV.w = opacity;
	o.inCamera = input[0].pos.w;
	o.color = shading_AmbientSun(1.0, AmbientAverage, getPrecomputedSunColor(0) / PI);
	float4x4 mBillboard = mul(billboardOverSpeed(posOffset, vortexDir, scale), VP);

	[unroll]
	for(int i = 0; i < 4; ++i)
	{
		float4 vPos = {staticVertexData[i].xy, 0, 1};
		vPos.y *= speedStretch;
		o.pos = mul(vPos, mBillboard);
		o.TextureUV.xy = staticVertexData[i].zw;

		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 PS(PS_INPUT i) : SV_TARGET0
{
	float opacity = i.TextureUV.w;
	
	float3 clr = tex.Sample(ClampLinearSampler, i.TextureUV.xy).rgb;
	clr *= clr;
	
	float alpha = lerp(clr.g, clr.b, i.inCamera);
		  alpha = lerp(clr.r, alpha, i.TextureUV.z);

	float transmittance = 0.8;
	// float transmittance = 1;

	return float4(i.color * alpha * opacity, lerp(1, transmittance, alpha * opacity));
}

BlendState wingtipContrailAlphaBlend
{
	BlendEnable[0] = true;
	SrcBlend = ONE;
	DestBlend = SRC_ALPHA;
	BlendOp = ADD;
};

technique10 Textured
{
	pass P0
	{
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(wingtipContrailAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PS())
	}
}
