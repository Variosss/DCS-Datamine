#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"

float3	billboardColor;// color
float	billboardSize;// size


struct VS_OUTPUT
{
    float3 pos	: POSITION0;
};

struct PS_INPUT
{
    float4 pos	: SV_POSITION;
};


VS_OUTPUT VS(float3 pos	: POSITION0) 
{
	VS_OUTPUT o;
	o.pos = pos+worldOffset-gOrigin;
	return o;
}


[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float4x4 mBillboard = mul(billboard(input[0].pos, billboardSize, 0), gViewProj);

	[unroll]
	for (int i = 0; i < 4; i++)
	{
		PS_INPUT o;
		float4 vPos = {staticVertexData[i].x, staticVertexData[i].y, 0, 1};
		o.pos = mul_v3xm44(vPos, mBillboard);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();                          
}

float3 PS(PS_INPUT i) : SV_TARGET0
{
	float NoL = satDotNormalized(float3(0.0, 0.0, -1.0), gSunDirV, 0.4);
	return billboardColor*NoL;
}


technique10 Textured
{
	pass P0
	{
		ENABLE_DEPTH_BUFFER;
		DISABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PS()) 
	}
}
