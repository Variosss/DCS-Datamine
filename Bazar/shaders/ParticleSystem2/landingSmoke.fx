#include "common/samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/softParticles.hlsl"

#define CASCADE_SHADOW
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"

cbuffer cEmitterParams
{
	float4 scaleOffset;
	float4 spinDirSideOffset;//zw - unused
};

#define scaleBase	scaleOffset.x	// глобальный масштаб частицы
#define scaleMin	scaleOffset.y	// минимальный масштаб частицы относительно scaleBase
#define scaleJitter	scaleOffset.z	// разброс масштабов партиклов в зависимости от удаления от оси эмиттера от [scaleMin] до [scaleMin + scaleJitter]
#define offsetMax	scaleOffset.w

#define spinDir		spinDirSideOffset.x
#define sideOffset	spinDirSideOffset.y

static const float opacityScale = 1.0;
static const float atanStart = -1.41296514;
static const float distMax = offsetMax;
static const float offsetMaxInv = 1/offsetMax; // 1/квадрат максимального расстояния партикла от оси эмиттера
static const float qDistMaxInvResult = 1/(distMax*distMax); // 1/квадрат максимального расстояния партикла от оси эмиттера c учетом радиуса поворота
static const float zFeather = 1.0 / 1.4;
static const float vortexRadius = 4;

struct VS_OUTPUT
{
	float4 pos		: POSITION0;
	float2 params	: TEXCOORD0;
};

struct PS_INPUT
{
	float4 pos		 : SV_POSITION0;
	float3 normal	 : NORMAL0;
	float4 TextureUV : TEXCOORD0; // UV, temperOffset, transparency
	float3 wPos		 : TEXCOORD1;
	float4 projPos	 : TEXCOORD2;
};

VS_OUTPUT VS(float4 params		: TEXCOORD0, // dist, angle, random[0..1], age
			 float3 startPos	: TEXCOORD1, // начальная позиция партикла в мировой СК
			 float4 startSpeedIn	: TEXCOORD2) // начальная скорость партикла в мировой СК, lifetime
			 /*float2 startParams	: TEXCOORD3) // дистанция и угол в локальной СК партикла		*/	
{
	#define lifetime startSpeedIn.w;
	#define DIST params.x
	#define ANGLE params.y
	#define RAND params.z //рандомное число для партикла
	#define AGE params.w //время жизни партикла в секундах

	#define JITTER(x) (1+(2*RAND-1)*x)

	VS_OUTPUT o;

	float _sin, _cos;
	float3 startSpeed = startSpeedIn.xyz;
	
	startSpeed.y = 0;//проекция вектора скорости на землю
	
	startPos -= worldOffset;

	// текстурные координаты
	o.pos.w = AGE*spinDir + 2*PI*RAND; // UV angle
	//const float texAngle = AGE*spinDir + 2*PI*RAND;
	//sincos(texAngle, _sin, _cos );

	//o.TextureUV.x = vPos.x*_cos - vPos.y*_sin + 0.5;
	//o.TextureUV.y = vPos.x*_sin + vPos.y*_cos + 0.5;

	
	const float nAge = AGE / lifetime; 

	//nAge = pow(nAge, 1+0*RAND);

	float speedValue = length(startSpeed);

	//ускорение торможения
	float deceleration = lerp(50, 400, (speedValue-20)/555.5);
	float decelerationInv = 1/deceleration;


	// нормализованная проекция смещения партикла в плоскости XZ
	sincos(ANGLE, _sin, _cos );
	float3 offsetProj = float3(_sin,0, _cos);


	//sincos( PI/2 + (1/(0.5+0.5*abs(spinDir))) * saturate(2.5*(nAge-0.6)) * PI * 0.9 * (0.75+0.5*RAND) , _sin, _cos );
	sincos( PI/2 + (1/(0.5+0.5*abs(spinDir))) * saturate(4.00*(nAge-0.75*(0.6 + 0.4*RAND))) * PI * 0.9 * (0.75+0.5*RAND) , _sin, _cos );

	float3 vortexProj = float3(_sin*spinDir, 0, abs(spinDir)*_cos) * pow(abs(nAge),4) * vortexRadius*(0.1 + 0.9*RAND);	

	vortexProj.z*=3*RAND;



	// получаем итоговое смещение партикла в XYZ локальной СК с учетом вращения
	float3 posOffset = DIST*offsetProj*(1+0.5*nAge);// + offsetRot;

	// вычисляем новое положение по Y с учетом изменения скорости партикла
	float ageCap = min(AGE, speedValue*decelerationInv);
	posOffset.y += (speedValue - 0.5*deceleration*ageCap)*ageCap;

	// считаем итоговую нормализованную длину проекции смещения партикла на плоскость XZ
	float nDist = (posOffset.x*posOffset.x + posOffset.z*posOffset.z) * qDistMaxInvResult;

	posOffset += vortexProj;
	//const float atanStart = atan(-2*PI);
	posOffset.x += (atan((3*nAge-2)*PI)-atanStart) * sideOffset * spinDir * (1+1*RAND);
	//startPos.y += vortexRadius*sqrt(nAge);//nAge*vortexRadius*0.5;
	startPos.y += pow(abs(nAge),4)*vortexRadius*0.7*(1-RAND*RAND) + scaleBase*0.5;	

	//строим СК по вектору скорости. Т.к. у нас еще есть и конвекция, добавляем ее.	
	float3x3 speedBasis = basis(normalize(startSpeed));
	//переводим партикл в мирвую СК и прибавляем к стартовой позиции
	o.pos.xyz = startPos + mul(posOffset, speedBasis);
	
	
	//масштаб частицы
	float scale  =	scaleBase * 
					max(scaleMin+scaleJitter*nDist*2, (scaleMin+scaleJitter*nDist))  *
					(1+8*nAge*nAge);
	
	o.params.x = scale;
	//задаем нормаль - делаем билборд выпуклым
	//billboardNormal(vPos.xy, o.normal);
	//o.normal = mul(o.normal, ViewInv);
	
	//делаем билборд
	//float4x4 mBillboard = billboard(posOffset, scale); // базис в точке posOffset
	//vPos = mul(vPos, mBillboard);
	
	
	//o.pos = mul(vPos, VP);

	//прозрачность партикла	
	/* fade-in прозрачность в зависимости от скорости, чем меньше скорость, тем короче по отношению к нормализованному времени жизни партикла длина перехода*/
	const float speedOpacity = lerp(10/(0.9 + 0.1*scaleBase), 1, saturate(speedValue/555));	

	o.params.y = pow( saturate( nAge*speedOpacity ), 2);
	o.params.y = min(1,  o.params.y * pow(abs(1-nAge*0.85), 2) * opacityScale);	
	// o.params.z = 0; //getSunBrightness();

	return o;
}


// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float3 posOffset	= input[0].pos.xyz;
	float  angle		= input[0].pos.w;
	float  scale		= input[0].params.x;
	float  transparency	= input[0].params.y;

	PS_INPUT o;
	o.wPos.xyz = posOffset;
	o.TextureUV.z = transparency;
	o.TextureUV.w = max(0,sunDir.y);
	
	float2x2 Mrot = rotMatrix2x2(angle);

	float4x4 M = billboard(posOffset, scale);
	M = mul(M, VP);
	
	[unroll]
	for (int i = 0; i < 4; i++)
	{	
		float4 vPos = {staticVertexData[i].xy, 0 ,1};
		
		o.TextureUV.xy = mul(staticVertexData[i].xy, Mrot) + 0.5;//UV
		o.pos = o.projPos = mul(vPos, M);
		
		billboardNormal(vPos.xy, o.normal);
		o.normal = mul(o.normal, (float3x3)ViewInv).xyz;
		
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}


float4 PSnorm(PS_INPUT i, uniform bool drawShadows) : SV_TARGET0
{
	float TRANSPARENCY = i.TextureUV.z;
	float LUM_FACTOR  = i.TextureUV.w;

	float4 clr = tex.Sample(ClampLinearSampler, i.TextureUV);
	clr.rgb = clr.rrr*0.5+0.8;
	clr.a *= TRANSPARENCY;
	
	clr.a *= depthAlpha(i.projPos, zFeather);

	float NoL = dot(normalize(i.normal), sunDir)*0.5 + 0.5;
	
	float shadow = 1;
	if(drawShadows)
		shadow = getCascadeShadow(i.wPos.xyz, i.projPos.z/i.projPos.w);

	float3 sunColor = getPrecomputedSunColor(0) * (NoL * shadow / 3.14159);
	clr.rgb = shading_AmbientSun(clr.rgb, AmbientAverage, sunColor);
	clr.rgb = applyPrecomputedAtmosphere(clr.rgb, 0);
	
	return clr;
}

technique10 Textured
{
	pass normal
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PSnorm(false))
	}
	
	pass withShadows
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PSnorm(true))
	}
}
