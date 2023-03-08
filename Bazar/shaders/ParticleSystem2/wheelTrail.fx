#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/modelShading.hlsl"

struct VS_INPUT
{
	float  birthTime: TEXCOORD0;
	float  lifetime:  TEXCOORD1;
	float3 x: POSITION0; 
	float3 y: POSITION1; 
	float3 z: POSITION2; 
	float3 posL: POSITION3; 
};

struct VS_OUTPUT
{
	float3 x: POSITION0; 
	float3 y: POSITION1; 
	float3 z: POSITION2; 
	float3 posW: POSITION3; 
	float  opacity: TEXCOORD0;
};

struct PS_INPUT
{
	float4 pos: 	SV_POSITION0;
	float4 wPos: 	POSITION0;
	float2 uv:		TEXCOORD0;
};

float4 gParams0; // gScale.x, gScale.y, gLifegTime, gTime
float3 gParams1; // gSunDirW.xyz
#define gScale gParams0.xy
#define gLifetime gParams0.z
#define gTime gParams0.w
#define gSunDirW gParams1.xyz

VS_OUTPUT VS(VS_INPUT i)
{
	VS_OUTPUT o;
	o.x = i.x;
	o.y = i.y;
	o.z = i.z;


	float offset = 0.01;
	o.posW = i.posL + float3(0.0, 1.0, 0.0)*offset - worldOffset;

	float age =  clamp(gTime-i.birthTime, 0.0, gLifetime);
	float reciprocalTime = gLifetime-age;

	float barrier = 2.0;
	float s = step(reciprocalTime, barrier);

	// linear reduction of opacity after the barrier gTime
	o.opacity = 1.0 - s*(1.0-reciprocalTime/barrier);
	return o;
}

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT i[1], inout TriangleStream<PS_INPUT> outputStream)
{
	PS_INPUT o;

	o.wPos.w = i[0].opacity;

	float4x4 world = {
		i[0].x.x, i[0].x.y, i[0].x.z, 0,
		i[0].y.x, i[0].y.y, i[0].y.z, 0,
		i[0].z.x, i[0].z.y, i[0].z.z, 0,
		i[0].posW.x, i[0].posW.y, i[0].posW.z, 1
	};
	float4x4 worldViewProj = mul(world, gViewProj);

	static const float4 staticVertexData2[4] = {
		float4(-0.5, 0.5, 0, 1),
		float4(0.5,  0.5, 1, 1),
		float4(-0.5, -0.5, 0, 0),
		float4(0.5,-0.5, 1, 0)

	};

	[unroll]
	for (int j = 0; j < 4; j++)
	{
		float3 vPos = { staticVertexData2[j].y*gScale.x, 0,staticVertexData2[j].x*gScale.y};
		
		o.wPos.xyz = mul_v3xm44(vPos, world).xyz;
		o.pos = mul_v3xm44(vPos, worldViewProj);
		o.uv = staticVertexData2[j].zw;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}


GBuffer PS_DECAL( PS_INPUT _i)
{
	MaterialParams mp;

	float albedo = texDiffuse.Sample(gAnisotropicWrapSampler, _i.uv).a; 
	dither8x8(_i.pos.xy, albedo*_i.wPos.w);//by opacity
	mp.normal = float3(0.0, 1.0, 0.0);
	mp.aorm = float4(1.0, 0.75, 0.0, 0.0);
	mp.diffuse = float4(0.05, 0.05, 0.05, 1.0);
	mp.emissive = 0;
	mp.pos = _i.wPos.xyz;
	mp.toCamera = gCameraPos - mp.pos;
	mp.camDistance = length(mp.toCamera);

	return BuildGBuffer(_i.pos.xy, mp.diffuse, mp.normal, mp.aorm, mp.emissive);
}


float4 PS(PS_INPUT i) : SV_TARGET0
{
	float alpha = texDiffuse.Sample(gAnisotropicClampSampler, i.uv	).a;

	alpha *= i.wPos.w;
	float NoL = max(dot(float3(0.0, 1.0, 0.0), gSunDirW), 0);
	float3 albedo = float3(0.1, 0.1, 0.1);
	float3 radiance = shading_AmbientSun_Atmosphere(albedo, AmbientTop, NoL/PI, 0);
	return float4(radiance, alpha);
}

technique10 tech
{
	//в полете
	pass P0{
		//ENABLE_DEPTH_BUFFER;
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		//SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;

		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(CompileShader(gs_5_0, GS()));
		SetPixelShader(CompileShader(ps_5_0, PS()));
	}
}