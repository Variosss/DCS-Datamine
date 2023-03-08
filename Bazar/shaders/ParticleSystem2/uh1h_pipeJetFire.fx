#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"

static const float LODdistance = 1200; 

float scaleBase;		// глобальный масштаб частицы
float speedValue;		// скорость вдоль оси Y Ћ—  системы партиклов
float effectLifetime;

float4x4 World;

Texture3D fireTex;

TEXTURE_SAMPLER(fireTex, MIN_MAG_MIP_LINEAR, MIRROR, CLAMP);

struct VS_OUTPUT
{
	float4 pos	: POSITION;
	float4 params:TEXCOORD0;
};

struct PS_INPUT
{
	float4 pos		 : SV_POSITION;
	float4 TextureUV : TEXCOORD0; // UV, transparency, alphaMult
};

VS_OUTPUT VS(float4 params		: TEXCOORD0, // UV, random[0..1], age
			 float params2		: TEXCOORD1) // начальна€ позици€ партикла в мировой — 
			  // начальна€ скорость партикла в мировой — 
{
	#define lifetime params2;
	#define DIST params.x
	#define ANGLE params.y
	#define RAND params.z //рандомное число дл€ партикла
	#define AGE params.w //врем€ жизни партикла в секундах

	VS_OUTPUT o;

	float _sin, _cos; 
	float nAge = AGE / lifetime;

	//проекци€ смещени€ партикла в плоскости XZ в системе кооридан св€занной с вектором скорости партикла
	sincos(ANGLE + pow(abs(AGE*2),1.5)*PI2, _sin, _cos );

	float3 posOffset = DIST * float3(0, _sin, _cos);	//x
	//float3 posOffset = DIST * float3(_sin, _cos, 0);	//z

	// вычисл€ем новое положение по Y с учетом изменени€ скорости партикла	
	posOffset.x += speedValue*AGE*(1+1*RAND) - (RAND-0.5)*0.8*scaleBase;

	//приводим к миру
	posOffset = mul(float4(posOffset,1), World).xyz;
	posOffset.y += pow(abs(AGE*1.2),2.5)*0.1;


	//вычисл€ем угол, на который надо довернуть плашку, штобы она была ориентирована по вектору скорости
	float3 speedScreenProj = mul(World._11_12_13, VP); //x
	//float3 speedScreenProj = mul(World._21_22_23, VP); //y
	//float3 speedScreenProj = mul(World._31_32_33, VP); //z
	float angle = atan2(speedScreenProj.y, speedScreenProj.x) + halfPI;	
	
	float scale = scaleBase*(1 + pow(abs(AGE*1.2),2.5)*0.65);
	//float4x4 mBillboard = billboard(posOffset, scale, angle);
	
	o.pos = float4(posOffset, angle);
	o.params.xy = float2(scale, step(0.5, RAND));
	
	o.params.z = 0.2 + 0.8*nAge;
	float startOpaquity = saturate(4*effectLifetime);

	o.params.w = 1;

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

	float4x4 mBillboard = billboard(posOffset, scale, angle);
	mBillboard = mul(mBillboard, VP);

	[unroll]
	for (int i = 0; i < 4; i++)
	{	
		o.TextureUV.xy = float2(staticVertexData[i].z + Rand, staticVertexData[i].w);

		float4 vPos = {staticVertexData[i].x, staticVertexData[i].y - 0.28, 0, 1};

		o.pos = mul(vPos, mBillboard);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}


float4 PS(PS_INPUT i) : SV_TARGET0
{
	float4 clr = TEX3D(fireTex, i.TextureUV);

	clr.r *= 2.0;
	clr.gb -= 0.05;
	clr.gb /= 1.1;
	clr.rgb = max(0, clr.rgb*3);
	clr.a *= i.TextureUV.w;

	return clr;
}


float4 PS_solid(PS_INPUT i) : SV_TARGET0
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
		//AlphaRef = 0;
		ADDITIVE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PS())
	}
}
