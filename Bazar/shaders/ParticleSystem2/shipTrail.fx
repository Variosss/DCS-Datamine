/*
	˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜
*/
#include "common/samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "common/stencil.hlsl"
	#define FOG_ENABLE
#include "common/fog2.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"
#include "enlight/skyCommon.hlsl"	
float2	scale;
float	time;
float	visibilityLength; // % ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜
float	speedValue;

Texture2D texFoam;

struct PS_INPUT
{
	float4 pos			: SV_POSITION0;
	float4 posW			: TEXCOORD0;
	float4 UV			: TEXCOORD1; // UVmask, UVtex1
	float2 distToCamera	: TEXCOORD2;//distToCamera, opacity
};

struct PS_OUTPUT
{
	float3 add: SV_TARGET0;
	float3 mult: SV_TARGET1;
};

static const float tile2 = 3;
static const float speed2 = 0.015;
static const float lodDistance = 3000;//˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜

static const float3 colorTint = float3(1, 1, 0.7);
static const float brightness = 5;
static const float opacity = 1.0;

PS_INPUT VS(float2 vPos : POSITION, float2 uv : TEXCOORD0)
{
	PS_INPUT o;

	o.UV.xy = uv;
	o.UV.zw = float2(0.2*uv.x, uv.y*tile2 - time*speed2);

	o.posW = float4(vPos.x, 0, vPos.y, 1);
	o.posW.xyz -= worldOffset;
	o.pos = mul(o.posW, VP);

	o.distToCamera.x = max(0, (distance(ViewInv._41_42_43, o.posW.xyz)- 50)) / lodDistance;
	o.distToCamera.y = min(1, speedValue / 5.55556);
	return o;
}


PS_OUTPUT PS(PS_INPUT i): SV_TARGET0
{
	float distFactor	= i.distToCamera.x;
	float nSpeed		= i.distToCamera.y;
	
	float3 clr = texFoam.Sample(WrapLinearSampler, i.UV.zw).rgb;

	float colorCoef = pow(abs(1-i.UV.y), 20) * (1 - pow(saturate(2*abs(i.UV.x-0.5)), 2));

	clr = lerp(clr, float3(1,1,1), colorCoef*0.5);

	//˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ * ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜
	float mask = tex.Sample(ClampLinearSampler, i.UV).g;
	mask *= mask * pow(abs(1-i.UV.y), 3) * nSpeed;


	clr = lerp(1, clr * colorTint , mask * opacity);

	float3 transmittance, inscatter;
	ComputeFogAndAtmosphereCombinedFactors(i.posW, gCameraPos, gCameraHeightAbs, gFogCameraHeightNorm, transmittance, inscatter);

	PS_OUTPUT output;
	output.add =  inscatter * mask;
	output.mult = lerp(1.0, clr*transmittance, mask);
	
	return output;
}

DepthStencilState shipTrailDS
{
	DepthEnable        = false;
	DepthWriteMask     = false;
	DepthFunc          = ALWAYS;

	TEST_COMPOSITION_TYPE_IN_STENCIL;
};

BlendState foamAlphaBlend
{
	BlendEnable[0]	= TRUE;
	SrcBlend		= ONE;
	DestBlend		= SRC1_COLOR;
};

technique10 Textured
{
	pass P0
	{
		SetDepthStencilState(shipTrailDS, STENCIL_COMPOSITION_WATER);
		SetBlendState(foamAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

		DISABLE_CULLING;
		VERTEX_SHADER(VS())
		PIXEL_SHADER(PS()) 
		GEOMETRY_SHADER_PLUG
	}
}
