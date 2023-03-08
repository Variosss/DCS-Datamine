#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#define CASCADE_SHADOW
#include "ParticleSystem2/common/psCommon.hlsl"

float scaleBase;
float time;
float4x4 World;

#ifdef MSAA
	Texture2DMS<float, MSAA> depthMap;
#else
	Texture2D<float> depthMap;
#endif

#define targetDownSampling 2.0 //таргет в который рисуем

// static const float2 emitterPos = {0.3, 0.3}; // координаты оси эмиттера в плоскости XZ, дует всегда вверх
static const float2 emitterPos = {0.0, 0.0}; // координаты оси эмиттера в плоскости XZ, дует всегда вверх

struct VS_OUTPUT
{
    float4 pos	: POSITION;
    float4 params:TEXCOORD0; // UV, transparency, alphaMult
};

struct PS_INPUT
{
    float4 pos: 	SV_POSITION;
    float4 params: 	TEXCOORD0; // UV, Z, shadow
	// float4 projPos: TEXCOORD1;
};

VS_OUTPUT VS(float4 params	: TEXCOORD0,
			 float3 params2	: TEXCOORD1)
{	
	#define DIST		params.x//относительное рассто€ние от оси эмиттера
	#define PERLIN		params.y
	#define RAND		params.z //рандомное число дл€ партикла
	#define BIRTH_TIME	params.w //врем€ жизни партикла в секундах
	#define lifetime	params2.x

    VS_OUTPUT o;	
	float _sin, _cos;
	
	const float AGE = time/2.0 - BIRTH_TIME;
	const float nAge = AGE / lifetime;
	
	float angle = RAND*PI2;	
	float scale = scaleBase;
	
	float2 dir;
	sincos(angle, dir.x, dir.y);//направление на партикл от оси эмиттера в плоскости XZ
	
	float2 d = 2*dir;
	float2 f = emitterPos;
	
	float a = 4;//  = dot(d,d), ибо dir единичный
	float b = dot(f,d) * 2;
	float c = dot(f,f) - 0.25;//0.25 - квадрат радиуса 
	
	float disc = sqrt(b*b-4*a*c);
	float2 t = float2(-b - disc, -b + disc) / (2*a);
	// float2 p0 = emitterPos + t[0]*d;
	// float2 p1 = emitterPos + t[1]*d;	
	float2 p = emitterPos + max(t[0], t[1])*d;//позици€ на окружности 	
	float2 rotCenter = (p+emitterPos)*0.5;
	float radius = length(emitterPos + dir*DIST-rotCenter) * 0.5;// length(max(t[0], t[1])*d) * 0.5;
	
	float2 sc;
	sincos(AGE*PI2/(0.2+0.8*radius)*0.05, sc[0], sc[1]);//циркул€ци€ партикла
	// sincos(0, sc[0], sc[1]);//циркул€ци€ партикла
	
	float3 pos;//итогова€ позици€
	pos.xz = rotCenter + dir*sc[0]*radius;
	pos.y = sc[1]*radius;
		
	// float4x4 W = World;
	// float scaleFactor = 0.8;
	// W._11_12_13 *= 1.4*scaleFactor;//front
	// W._21_22_23 *= 1.5*scaleFactor;//up
	// W._31_32_33 *= 0.7*scaleFactor;//side
	pos = mul(float4(pos, 1), World).xyz;
	
	o.pos = float4(pos, angle);
	o.params.xy = float2(scale, AGE);
	o.params.z = max(0.1, 0.666*(0.5 + dot(sunDir,axisY)));
	o.params.w = 1;
	
    return o;
	#undef DIST
	#undef PERLIN
	#undef RAND
	#undef BIRTH_TIME
	#undef lifetime
}

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	#define gsPosOffset input[0].pos.xyz
	#define gsAngle input[0].pos.w
	#define gsScale input[0].params.x
	#define gsAge input[0].params.y

	PS_INPUT o;
	
	gsPosOffset = mul(float4(gsPosOffset, 1), gView).xyz;
	
	o.params.z = gsPosOffset.z;//глубина дл€ софт партиклов
	
	float _sin,_cos;
	sincos(gsAngle, _sin, _cos);
	float2x2 M = {
	_cos, _sin,
	-_sin,  _cos};
	
	int phase = (gsAge + gsAngle)*40;
	const float2 uvScaleFactor = 1.0 / float2(16, 8);
	float2 uvOffset = float2((float)(phase & 15), (float)((phase>>4) & 7) );

	[unroll]
	for (int i = 0; i < 4; ++i)
	{
		o.params.xy = staticVertexData[i].xy + 0.5;
		o.params.xy = (o.params.xy+uvOffset)*uvScaleFactor;
		
		// float4 wPos = mul(float4(staticVertexData[i].xy, 0, 1), mBillboard);//world
		// o.pos = mul(wPos, gViewProj);
		float4 vPos = float4(staticVertexData[i].xy, 0, 1);
		vPos.xy = mul(vPos.xy, M);
		vPos.xy *= gsScale;
		vPos.xyz += gsPosOffset;
		
		float4 wPos = mul(vPos, gViewInv);
		
		o.pos = mul(vPos, gProj);
		// o.projPos = o.pos;
		// o.projPos.xyz /= o.projPos.w;
		// o.projPos.xy = float2(o.projPos.x, -o.projPos.y)*0.5+0.5;

		o.params.w = getCascadeShadowForVertex(wPos.xyz, o.pos.z/o.pos.w);
		
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

#define SOFT_PARTICLE

float4 PS(PS_INPUT i) : SV_TARGET0
{
	#define psParticleDepth i.params.z
	float alpha = tex.Sample(ClampLinearSampler, i.params.xy).a * 0.3;
#ifdef SOFT_PARTICLE
	#ifdef MSAA
		float sceneDepth = depthMap.Load(int2(i.pos.xy*targetDownSampling), 0).r;
	#else
		float sceneDepth = depthMap.Load(int3(i.pos.xy*targetDownSampling, 0)).r;
	#endif
	
	float4 z = mul(float4(0,0,sceneDepth,1), gProjInv);
	sceneDepth = z.z/z.w;//in view space
	// clip(sceneDepth - psParticleDepth);
	float zFeather = saturate((sceneDepth - psParticleDepth) / 0.1) * saturate(psParticleDepth*10);
	alpha *= zFeather;
#endif
	clip(alpha-0.01);
	return float4(1, i.params.w, 0, alpha);
}

#include "cockpitSmoke_tess.hlsl"

float4  PS_solid(PS_INPUT i) : SV_TARGET0
{
	return float4(1, 1, 0, 0.5);
}


technique10 Solid
{
	// pass pointViaGS
	// {
		// DISABLE_DEPTH_BUFFER;
		// ENABLE_ALPHA_BLEND;
		// DISABLE_CULLING;
		// VERTEX_SHADER(VS())
		// SetGeometryShader(CompileShader(gs_5_0, GS()));
		// PIXEL_SHADER(PS_solid())
	// }
	pass viaTesselator
	{
		DISABLE_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		// DISABLE_CULLING;
		SetRasterizerState(wireframe);
		VERTEX_SHADER(VS_tess())
		SetHullShader(CompileShader(hs_5_0, HS()));
		SetDomainShader(CompileShader(ds_5_0, DS()));
		SetGeometryShader(NULL);
		PIXEL_SHADER(PS_solid())
	}
}

technique10 Textured
{
	// pass pointViaGS
	// {
		// DISABLE_DEPTH_BUFFER;
		// ENABLE_ALPHA_BLEND;
		// DISABLE_CULLING;
		// VERTEX_SHADER(VS())
		// SetGeometryShader(CompileShader(gs_5_0, GS()));
		// PIXEL_SHADER(PS()) 
	// }
	pass viaTesselator
	{
		DISABLE_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
		// SetRasterizerState(wireframe);
		VERTEX_SHADER(VS_tess())
		SetHullShader(CompileShader(hs_5_0, HS()));
		SetDomainShader(CompileShader(ds_5_0, DS()));
		SetGeometryShader(NULL);
		PIXEL_SHADER(PS())
	}
}
