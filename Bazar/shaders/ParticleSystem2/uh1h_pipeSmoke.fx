#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"


static const float LODdistance = 1200;

float scaleBase;		// глобальный масштаб частицы
float speedValue;		// скорость вдоль оси Y ЛСК системы партиклов
float effectLifetime;

float4x4 World;

TEXTURE_SAMPLER(tex, MIN_MAG_MIP_LINEAR, MIRROR, CLAMP);

struct VS_OUTPUT
{
    float4 pos	: POSITION;
    float4 params:TEXCOORD0; // UV, transparency, alphaMult
};

struct PS_INPUT
{
    float4 pos		 : SV_POSITION;
    float4 TextureUV : TEXCOORD0; // UV, transparency, alphaMult
};

VS_OUTPUT VS(float4 params		: TEXCOORD0, // UV, random[0..1], age
			 float params2		: TEXCOORD1) // начальная позиция партикла в мировой СК
			  // начальная скорость партикла в мировой СК			
{	
	#define lifetime params2;
	#define DIST params.x
	#define ANGLE params.y
	#define RAND params.z //рандомное число для партикла
	#define AGE params.w //время жизни партикла в секундах

    VS_OUTPUT o;	
	float _sin, _cos; 
	const float nAge = AGE / lifetime;	

	//ускорение торможения
	const float deceleration = 1.5;
	
	//проекция смещения партикла в плоскости XZ в системе кооридан связанной с вектором скорости партикла
	sincos(ANGLE*PI2, _sin, _cos );
	//sincos(ANGLE + pow(abs(nAge),2.5)*PI2, _sin, _cos );


	// вычисляем новое положение по Y с учетом изменения скорости партикла	
	const float ageCap = min(AGE, speedValue/deceleration); 		
	//приводим к миру	
	float3 posOffset = World._11_12_13 * (  (speedValue - 0.5*deceleration*ageCap)*ageCap - (RAND-0.5)*0.8*scaleBase  ) - 0.25;
	posOffset += World._41_42_43 - worldOffset;
	//конвекция
	posOffset.y += AGE*1;
	//растаскивание по перлинчику
	posOffset += DIST * float3(_sin, 0, _cos) * pow(abs(nAge),2);


	//вычисляем угол, на который надо довернуть плашку, штобы она была ориентирована по вектору скорости
	const float3 speedScreenProj = mul(World._11_12_13, VP); //x
	float angle = atan2(speedScreenProj.y, speedScreenProj.x) + halfPI;	
	
	float scale = scaleBase*(1+3*pow(abs(nAge),2.5));

	o.pos = float4(posOffset, angle*RAND + AGE*PI*0.5*(1+0.2*RAND));
	o.params.xy = float2(scale, step(0.5, RAND));

	o.params.z = 0.15 * getSunBrightness();

	const float startOpaquity = saturate(4*nAge);
	o.params.w = pow(startOpaquity,2) * saturate(1.5*(1-nAge));// * (0.5 + 0.5*saturate(2*(1-effectLifetime)));!!!!!!!!!!!!!! потом включить !!

	return o;

}

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	#define posOffset input[0].pos.xyz
	#define angle input[0].pos.w
	#define scale input[0].params.x
	#define Rand input[0].params.y

	PS_INPUT o;
	o.TextureUV.zw = input[0].params.zw; 

	float4x4 mBillboard = mul(billboard(posOffset, scale, angle), VP);

	[unroll]
	for (int i = 0; i < 4; i++)
	{
		o.TextureUV.xy = float2(staticVertexData[i].z + Rand, staticVertexData[i].w);

		float4 vPos = {staticVertexData[i].x, staticVertexData[i].y, 0, 1};

		o.pos = mul(vPos, mBillboard);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 PS(PS_INPUT i) : SV_TARGET0
{ 	
	#define BRIGHTNESS i.TextureUV.z 
	float4 clr = TEX2D(tex, i.TextureUV).aaaa;
	
	clr.rgb *= BRIGHTNESS;
	clr.a *= clr.a * 0.15 * i.TextureUV.w;

	return clr;
}

float4  PS_solid(PS_INPUT i) : SV_TARGET0
{
	return float4(i.TextureUV.z, i.TextureUV.z, i.TextureUV.z, 0.2);
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
