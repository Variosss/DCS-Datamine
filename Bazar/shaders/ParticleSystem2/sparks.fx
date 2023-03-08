#include "common/context.hlsl"
#include "common/random.hlsl"
#include "ParticleSystem2/common/modelShading.hlsl"
#include "ParticleSystem2/common/quat.hlsl"
#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

float4x4 world;
float4x4 projViewt0;
float3 cameraVelocity;
float3 wind;
float3 color;
float emitTimer;
float2 scale;
float speed;
float spreadFactor;
float3	spreadDir; //TODO: заменить на матрицу

struct VS_OUTPUT
{
	float3	posV		: TEXCOORD1;
	float4 transAge: TEXCOORD2;
};


//вокруг X
float3x3 makeRot(float3 dir)
{
	float3 Y,Z;
	if(abs(dir.y)<0.99)	{
	 	Z = normalize(cross(dir, float3(0,1,0)));
		Y = cross(Z, dir);
	} else {
		Y = normalize(cross(dir, float3(1,0,0)));
		Z = cross(dir, Y);
	}
	return float3x3(dir, Y, Z);
}

struct PS_INPUT
{
    float4 posSV		 : SV_POSITION;
    float3 uvAlpha : TEXCOORD0; // uv
	float3 color: TEXCOORD1;

};

VS_OUTPUT VS(
	in float4 posLifetime: TEXCOORD0
)
{
#define pos posLifetime.xyz
	float nAge = min(emitTimer/posLifetime.w, 1.0);

	float3 rVel = noise3(pos+0.5);
	//считаем вектор скорости в локальной — 
	rVel.y = abs(rVel.y);

	float3 vel = lerp(spreadDir,rVel, spreadFactor);
	vel = normalize(vel);

	float rSpeed = speed*(0.8+rVel.x*0.2);
	float nextTime = emitTimer+0.05;
	//летим по баллистической таректории
	// float3 trans = calcTranslation(vel*40, age);

	float3 speed0 = vel*rSpeed;
	float lbase = length(speed0);
	lbase = clamp(lbase, 0, lbase);
	float3 direction = -cameraVelocity + speed0;
	float3 speed = normalize(direction)*lbase;

	float3 trans = calcTranslation(speed-emitTimer*wind, emitTimer);
	float3 lastTrans = calcTranslation(speed-nextTime*wind, nextTime);
	float3 delta = lastTrans-nextTime*wind-trans+emitTimer*wind;
	//базис вдоль мирового вектора скорости
	// float3x3 mVel = basis((trans1-trans0));
	// pos.y *= 1 + min( 1, distance(trans0, trans1));
	// pos = mul(pos, mVel);

	//ставим на стартовую позицию
	//pos += sbInstanced[instId].pos*4;

	VS_OUTPUT o;
    o.posV = mul(float4(pos, 1.0), world).xyz + trans;
    o.transAge = float4(delta*(1.0-nAge), nAge);
    return o;
}

float3 GetVectorScreenLength(float3 vPos0, float3 vPos1)
{
	// получаем проецированные координаты
	float4 p1 = mul(float4(vPos0, 1), gProj);
	float4 p2 = mul(float4(vPos1, 1), gProj);
	p1.xyz /= p1.w;
	p2.xy /= p2.w;

	float4 dir = float4(p2.xy-p1.xy, p1.z, 1);
	dir.x *= gProj._22 / gProj._11; //aspect
	dir.z = length(dir.xy); // длига векьлоа
	dir.xy /= dir.z; // нормализуем вектор
	return dir.xyz;
}


[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	#define posOffset input[0].posV.xyz
	#define trans input[0].transAge.xyz
    #define nAge input[0].transAge.w

/*
	float3 transScaled = trans*pow(1.0-nAge, 2);
	l0 = lengh(transScaled);
	transScale *= clamp(l0, 0.0, 1.5)/l0;
	*/
	float3 transScaled = trans*pow(1.0-nAge, 2);

	float4 vPosFront = mul(float4(posOffset+transScaled, 1.0), gView);
	float4 vPosBack = mul(float4(posOffset, 1.0), gView);

	PS_INPUT o;

	//считаем направление трассера на экране, иначе будет крутиться
	float3 screenDir = GetVectorScreenLength(vPosBack, vPosFront);

	float3 dirProj = float3(screenDir.xy, 0);
	float3 sideProj = float3(-dirProj.y, dirProj.x, 0); 
	
	//чтобы полукуги не переворачивались в ответственный момент

	//float d = dot(float3(dir.xy,0), dirProj);
	//dirProj = d<0? -dirProj : dirProj;

	
	float3 offsetDirView = mul(-transScaled, (float3x3)View);
	float3 side = sideProj * 1;


	const float4 vertexData[] =
	{	//offsetDirView, side, u, sideFactor
		{0, -0.5, 0,   -1},
		{0,  0.5, 0,   -1},
		{0, -0.5, 0.5,  0},
		{0,  0.5, 0.5,  0},
		{1, -0.5, 0.5,  0},
		{1,  0.5, 0.5,  0},
		{1, -0.5, 1.0,  1},
		{1,  0.5, 1.0,  1},
	};

	/*
	float3 eye = -normalize(vPosFront);
	float3 up = cross(normalize(motion), eye);
	float3 motionProj = cross(eye, up);
	*/

	[unroll]
	for (int i = 0; i < 4; i++)
	{
		float4 v = vertexData[i];
		float3 posV = vPosBack + offsetDirView * v.x + side * v.y*0.02 + dirProj *v.w*0.25*sqrt(1.0-nAge) ;

		o.uvAlpha.xy = float2(staticVertexData[i].z, staticVertexData[i].w);
		o.uvAlpha.z = pow(1.0-nAge, 1.0/16.0);
		o.color = lerp(float3(224/255.0, 158.0/255.0, 66.0/255.0), float3(80.0/255.0, 35.0/255.0, 16.0/255.0), pow((nAge+0.2)*PI*0.5, 1.0/16.0));
		//o.pos.xyz = vPosBack + speed * v.x*2.0 + up * v.y; //+ dirProj * (v.x * capWidth);
		//float3 posV = vPosBack + motionProj*v.z + up*v.w*0.07 + motion*v.z;
		o.posSV = mul(float4(posV, 1.0), gProj);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();                          
}


float4 PS(PS_INPUT i) : SV_TARGET0
{
	float4 finalColor = float4(color, tex.Sample(gBilinearClampSampler, i.uvAlpha.xy).a);
	finalColor.a *= i.uvAlpha.z;
	finalColor.rgb = i.color*15.0;
	clip(finalColor.a - 0.001);
	return finalColor;
}

technique10 tech
{
	pass P0
	{
        ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(CompileShader(gs_5_0, GS()));
    	SetPixelShader(CompileShader(ps_5_0, PS()));

		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	}
}
