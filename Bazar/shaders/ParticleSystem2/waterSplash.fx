#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"

#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "ParticleSystem2/common/noiseSimplex.hlsl"
#include "common/random.hlsl"
#include "common/stencil.hlsl"

Texture3D	texFoam;
Texture2D	texWater;
Texture2D	texWaterNormal;
Texture2D	texTerrainNoise;
Texture2D	texTerrainNormal;
float4		uParams;
float3		wind;
float emitTimer;

#define speedMin			uParams.x
#define speedMax			uParams.y
#define power				uParams.z
#define effectLifetimeInv	uParams.w

static const float nPower = power/4.0;

struct VS_OUTPUT_SPLASH
{
	float4 pos:		POSITION0;
	float4 speed:	TEXCOORD1;//speed dir and scalar
	float3 params:	TEXCOORD0; // UV, transparency, alphaMult, rand2 as radius
	nointerpolation int v_id: TEXCOORD2;
};


struct PS_INPUT_SPLASH
{
	float4 pos:							SV_POSITION0;
	float2 uv:							TEXCOORD0; // UV, transparency, alphaMult
	nointerpolation float4 params2:		TEXCOORD1;
	nointerpolation float3 sunColor: 	TEXCOORD2;
	nointerpolation float id_particle: TEXCOORD3;
};

struct PS_INPUT_TERRAINS
{
	float4 pos:							SV_POSITION0;
	float2 uv:							TEXCOORD0; // UV, transparency, alphaMult
	nointerpolation float4 params2:		TEXCOORD1;
	nointerpolation float3 sunColor: 	TEXCOORD2;
	nointerpolation int v_id: TEXCOORD4;
};

VS_OUTPUT_SPLASH VS_SPLASH(float4 params:		TEXCOORD0, //startSpeedDir, startSpeedValue
			 float4 params2:	TEXCOORD1, uint id: SV_VertexID) // ��������� ������� �������� � ������� ��
{
	float RAND1		= params2.x;
	float RAND2		= params2.y;
	float AGE		= params2.z;
	float LIFETIME	= params2.w;

	float _sin, _cos; 
	sincos(RAND2*PI2*14.32, _sin, _cos );

	float3 startPos = float3(_sin, 0, _cos)*RAND2*power*2;
	
	VS_OUTPUT_SPLASH o;
	o.pos = float4(startPos - worldOffset, AGE);
	o.speed = params;
	o.params.x = AGE * effectLifetimeInv;
	o.params.y = RAND1;
	o.params.z = RAND2;
	o.v_id = id;
	return o;
}

float calcHorisontalTransWithAirResistSplash(in float startSpeed, in float mass, in float c, in float time)
{
	c = 2.5;
	return mass*startSpeed/c*(1-exp(-c*time/mass));

}

float calcHorisontalSpeed(in float startSpeed, in float mass, in float c, in float time)
{
	c = 2.5;

	const float g = 9.80665f;
	const float Vt = mass*g/c;
	const float k = (1-exp(-g*time/Vt))*Vt/g;

	float tau = mass/(c*startSpeed);

	return startSpeed*(exp(-c*time/mass));

}

float calcVerticalTransWithAirResistSplash(in float vertSpeed, in float mass, in float c, in float time)
{
	c = 3.05;
	vertSpeed *= 2.8;

	const float g = 9.80665f;
	const float Vt = mass*g/c;
	const float k = (1-exp(-g*time/Vt))*Vt/g;

	float tau = mass/(c*vertSpeed);

	return (vertSpeed+Vt)*k - Vt*time;

}

float calcVerticalSpeed(in float vertSpeed, in float mass, in float c, in float time)
{
	c = 1.0;

	const float g = 9.80665f;
	const float Vt = mass*g/c;
	const float k = (1-exp(-g*time/Vt))*Vt/g;

	float tau = mass/(c*vertSpeed);

	return Vt-exp(-c*time/mass)*(Vt-vertSpeed);

}

float calcHorisontalTransWithAirResistSpray(in float vertSpeed, in float mass, in float c, in float time)
{
	c = 1.0;
	float tau = mass/(c*vertSpeed);

	return vertSpeed*tau*log(1+time/tau);

}

float calcVerticalTransWithAirResistSpray(in float vertSpeed, in float mass, in float c, in float time)
{
	c = 1.0;

	float tau = mass/(c*vertSpeed);

	return vertSpeed*tau*log(1+time/tau);
	return vertSpeed*mass/c*log(1+time*c/mass*vertSpeed);

}

float calcHorisontalTransWithAirResistTerrains(in float startSpeed, in float mass, in float c, in float time)
{
	c = 1.0;
	mass = 0.3;
	return mass*startSpeed/c*(1-exp(-c*time/mass));

}

float calcVerticalTransWithAirResistTerrains(in float vertSpeed, in float mass, in float c, in float time)
{
	c = 6.5;
	mass = 0.6;
	vertSpeed *= 1.0;
	//vertSpeed = max(vertSpeed, 10.0);
	const float g = 9.80665f;
	const float Vt = mass*g/c;
	const float k = (1-exp(-g*time/Vt))*Vt/g;

	float tau = mass/(c*vertSpeed);

	return (vertSpeed+Vt)*k - Vt*time;

}


float3 calcTranslationWithAirResistanceSpray(in float3 startSpeed, in float mass, in float c, in float time)
{
	return float3(calcHorisontalTransWithAirResistSpray(startSpeed.x, mass, c, time), calcVerticalTransWithAirResistSpray(startSpeed.y, mass, c, time), calcHorisontalTransWithAirResistSpray(startSpeed.z, mass, c, time));
}

float3 calcTranslationWithAirResistanceSplash(in float3 startSpeed, in float mass, in float c, in float time)
{
	return float3(calcHorisontalTransWithAirResistSplash(startSpeed.x, mass, c, time), calcVerticalTransWithAirResistSplash(startSpeed.y, mass, c, time), calcHorisontalTransWithAirResistSplash(startSpeed.z, mass, c, time));
}

float calcNewOpacity(in float time, in float dens_const)
{

	return exp(-dens_const*time);
}

float3 calcTranslationWithAirResistanceTerrains(in float3 startSpeed, in float mass, in float c, in float time)
{
	return float3(calcHorisontalTransWithAirResistTerrains(startSpeed.x, mass, c, time), calcVerticalTransWithAirResistTerrains(startSpeed.y, mass, c, time), calcHorisontalTransWithAirResistTerrains(startSpeed.z, mass, c, time));
}

#define particlesCount 3
#define GSSplash gsMain
//#define GSTerrainsImpacts gsTerrains
#include "waterSplash.hlsl"

#undef GSSplash
#undef particlesCount
//lod
#define LOD
#define particlesCount 2
#define GSSplash gsLod
#include "waterSplash.hlsl"
#undef GSSplash
#undef particlesCount

#define particlesCount 2
#define GSTerrains gsTerrains
#include "terrainImpacts.hlsl"
#undef GSTerrain
#undef particlesCount

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

float4 psWaterSplash(PS_INPUT_SPLASH i, uniform bool bLod): SV_TARGET0
{
	float	_sin		= i.params2.x;
	float	_cos		= i.params2.y;
	float	OPACITY 	= i.params2.w;
	float	LERP_FACTOR = i.params2.z;
	
	float4 norm = tex.Sample(ClampLinearSampler, i.uv);
	clip(norm.a-0.1);

	norm.xyz = norm.xyz*2-1;
	norm.z *= 0.5;
	if(!bLod)
		norm.xy = float2( norm.x*_cos - norm.y*_sin, norm.x*_sin + norm.y*_cos );

	float light = dot(normalize(norm.xyz), gSunDirV.xyz)*0.5+0.5;

	float4 color = 1;
	color.a = norm.a * lerp(1, texFoam.Sample(gTrilinearWrapSampler, float3(i.uv, LERP_FACTOR)).r, LERP_FACTOR) * OPACITY;
	

	//color.rgb = shading_AmbientSun(0.8, AmbientAverage, i.sunColor * max(0, light) / PI);
	color.rgb = shading_AmbientSun(0.8, color.rgb*length(AmbientAverage), i.sunColor * max(0, light) / PI);
	if (i.id_particle) {
		color.a *= 0.7;
	}
	else {
		color.rgb *= float3(0.53, 0.72, 0.93);
	}

	return color;
}

float4 psFlirSplash(PS_INPUT_SPLASH i): SV_TARGET0
{
	float	_sin		= i.params2.x;
	float	_cos		= i.params2.y;
	float	OPACITY 	= i.params2.w;
	float	LERP_FACTOR = i.params2.z;
	
	float4 norm = tex.Sample(ClampLinearSampler, i.uv);
	clip(norm.a-0.1);

	norm.xyz = norm.xyz*2-1;
	norm.z *= 0.5;

	//float light = dot(normalize(norm.xyz), gSunDirV.xyz)*0.5+0.5;

	float4 color = 1;
	color.a = norm.a * lerp(1, texFoam.Sample(gTrilinearWrapSampler, float3(i.uv, LERP_FACTOR)).r, LERP_FACTOR) * OPACITY;

	//color.rgb = shading_AmbientSun(0.8, AmbientAverage, i.sunColor * max(0, light) / PI);
	if (i.id_particle) {
		color.a *= 0.7;
	}
	else {
		color.rgb *= float3(0.53, 0.72, 0.93);
	}
	float l = luminance(color)/5.0;
	return float4(l, l, l, color.a);

}

SamplerState MirrorLinearSampler
{
	Filter        = MIN_MAG_MIP_LINEAR;
	AddressU      = MIRROR;
	AddressV      = MIRROR;
	AddressW      = MIRROR;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};

//TEXTURE_SAMPLER(texTerrainNoise, MIN_MAG_MIP_LINEAR, CLAMP, CLAMP);

float4 psTerrainImpacts(PS_INPUT_TERRAINS i, uniform bool bLod): SV_TARGET0
{
	float	_sin		= i.params2.x;
	float	_cos		= i.params2.y;
	float	OPACITY 	= i.params2.w;
	float	LERP_FACTOR = i.params2.z;
	
	float4 norm = tex.Sample(ClampLinearSampler, i.uv);
	clip(norm.a-0.1);

	norm.xyz = norm.xyz*2-1;
	norm.z *= 0.5;
	//if(!bLod)
		//norm.xy = float2( norm.x*_cos - norm.y*_sin, norm.x*_sin + norm.y*_cos );

	float NoL = saturate(dot(norm.xyz, gSunDirV.xyz)*0.4+0.2);
	//float light = dot(normalize(norm.xyz), gSunDirV.xyz)*0.5+0.5;

	float4 color = 1;
	float3 noise = texTerrainNoise.Sample(WrapLinearSampler, i.uv).rgb;

	float alpha = noise.r;
	float4 clrSmoke = tex.Sample(MirrorLinearSampler, i.uv).a;
	color.a = norm.a * clrSmoke.a * OPACITY;
	//float3 clrr =  clrSmoke.a*float3(124.0/255.0, 100.0/255.0, 91.0/255.0) + (1.0-clrSmoke.a)*float3(50.0/255.0, 25.0/255.0, 17.0/255.0);
	//float3 clrr =  clrSmoke.a*float3(151.0/255.0, 122.0/255.0, 94.0/255.0) + (1.0-clrSmoke.a)*float3(234.0/255.0, 167.0/255.0, 102.0/255.0);
	float3 clrr = float3(0.0, 0.0, 0.0);
	if (i.v_id%3 == 0) {
		clrr = float3(220.0/255.0, 170.0/255.0, 104.0/255.0);
	}
	else if (i.v_id%3 == 1) {
		clrr = float3(0.95, 0.76, 0.49);
	}
	else {
		clrr = float3(78.0/255.0, 59.0/255.0, 41.0/255.0);
	}

	//color.a = 0.5*norm.a * alpha * OPACITY;
	//float4 clr = TEX2D(texWater,  i.uv);
	//clrSmoke.a*float3(243.0/255.0, 187.0/255.0, 92.0/255.0) + (1.0 - clrSmoke.a)*float3(166.0/255.0, 91.0/255.0, 32.0/255.0);
	//color.rgb = clrr;

	color.rgb = shading_AmbientSun(clrr, AmbientTop, i.sunColor*NoL/PI);
	return float4(applyPrecomputedAtmosphere(color.rgb, 0), color.a);
	//color.rgb = float3(1.0, 0.0, 0.0);
	//float3(138.0/255.0, 110.0/255.0, 85.0/255.0)*
	//color.rgb = float3(88*2/255, 64*2/255, 51*2/255);
	//float3(138.0/255.0, 110.0/255.0, 85.0/255.0)

	return color;
}

float4 psTerrainsFlir(PS_INPUT_TERRAINS i): SV_TARGET0
{
	float	_sin		= i.params2.x;
	float	_cos		= i.params2.y;
	float	OPACITY 	= i.params2.w;
	float	LERP_FACTOR = i.params2.z;
	
	float4 norm = tex.Sample(ClampLinearSampler, i.uv);
	clip(norm.a-0.1);

	norm.xyz = norm.xyz*2-1;
	norm.z *= 0.5;
	//if(!bLod)
		//norm.xy = float2( norm.x*_cos - norm.y*_sin, norm.x*_sin + norm.y*_cos );

	float NoL = saturate(dot(norm.xyz, gSunDirV.xyz)*0.4+0.2);
	//float light = dot(normalize(norm.xyz), gSunDirV.xyz)*0.5+0.5;

	float4 color = 1;
	float3 noise = texTerrainNoise.Sample(WrapLinearSampler, i.uv).rgb;

	float alpha = noise.r;
	float4 clrSmoke = tex.Sample(MirrorLinearSampler, i.uv).a;
	color.a = norm.a * clrSmoke.a * OPACITY;
	//float3 clrr =  clrSmoke.a*float3(124.0/255.0, 100.0/255.0, 91.0/255.0) + (1.0-clrSmoke.a)*float3(50.0/255.0, 25.0/255.0, 17.0/255.0);
	//float3 clrr =  clrSmoke.a*float3(151.0/255.0, 122.0/255.0, 94.0/255.0) + (1.0-clrSmoke.a)*float3(234.0/255.0, 167.0/255.0, 102.0/255.0);
	float3 clrr = float3(0.0, 0.0, 0.0);
	if (i.v_id%2 == 0) {
		clrr = float3(0.59, 0.48, 0.37);
	}
	else {
		clrr = float3(0.95, 0.76, 0.49);
	}
	//color.a = 0.5*norm.a * alpha * OPACITY;
	//float4 clr = TEX2D(texWater,  i.uv);
	//clrSmoke.a*float3(243.0/255.0, 187.0/255.0, 92.0/255.0) + (1.0 - clrSmoke.a)*float3(166.0/255.0, 91.0/255.0, 32.0/255.0);
	//color.rgb = clrr;

	float l = luminance(clrr)/3.5;
	return float4(l, l, l, color.a);

}


struct VS_OUTPUT_ON_WATER {
	float4 pos: SV_POSITION0;
	float4 posP: TEXCOORD0;
	float2 uv: TEXCOORD1;
	nointerpolation float3 sunColor: 	TEXCOORD2;
	float nAge : TEXCOORD3;
};


VS_OUTPUT_ON_WATER vs_on_water(uint id: SV_VertexID)
{
	float2 vertPos[] =
	{
		float2(-1.0f, -1.0f),
		float2(-1.0f,  1.0f),
		float2( 1.0f, -1.0f),
		float2( 1.0f,  1.0f)
	};
	float nAge	= emitTimer * (effectLifetimeInv)/2;

	VS_OUTPUT_ON_WATER o;
	float3 temp_pos = float3(1.3*vertPos[id].x, 0.0, 1.3*vertPos[id].y);
	temp_pos = temp_pos - worldOffset;
	o.pos = o.posP = mul(float4(temp_pos, 1.0), gViewProj);
	o.uv = vertPos[id];

	float4 uvOffsetScale = getTextureFrameUV8x8(pow(nAge, 0.5)*(8*8-1));
	o.uv = staticVertexData[id].zw * uvOffsetScale.xy + uvOffsetScale.zw;
	o.sunColor = getPrecomputedSunColor(0);
	o.nAge = nAge;
	return o;
}

TEXTURE_SAMPLER(texWater, MIN_MAG_MIP_LINEAR, CLAMP, CLAMP);
TEXTURE_SAMPLER(texWaterNormal, MIN_MAG_MIP_LINEAR, CLAMP, CLAMP);


#include "deferred/reflections.fx"


float4 ps_on_water(VS_OUTPUT_ON_WATER i): SV_TARGET0
{

	float4 clr = TEX2D(texWater,  i.uv);

	float4 norm = TEX2D(texWaterNormal,  i.uv);

	//clr = clr*clr;
	//norm = norm*norm;
	//clip(norm.a-0.1);

	norm.xyz = norm.xyz*2-1;
	norm.z *= 0.5;
	//if(!bLod)
		//norm.xy = float2( norm.x*_cos - norm.y*_sin, norm.x*_sin + norm.y*_cos );

	float light = dot(normalize(norm.xyz), gSunDirV.xyz)*0.5+0.5;

	//float4 color = 1;
	//color.a = norm.a * lerp(1, texFoam.Sample(gTrilinearWrapSampler, float3(i.uv, LERP_FACTOR)).r, LERP_FACTOR) * OPACITY;
	

	clr.rgb = shading_AmbientSun(0.8, AmbientAverage, i.sunColor * max(0, light) / PI);

	//float nAge	= emitTimer * effectLifetimeInv;
	clr.a *= 0.8;
	clr.a = clamp(clr.a, 0.0, 0.3);
	clr.a *= pow(1.0-i.nAge, 1.5);
	//clr.a *= max(min(1.0-nAge, 1.0), 0.0);
	return clr;
}

float4 ps_on_water_flir(VS_OUTPUT_ON_WATER i): SV_TARGET0
{
	clip(-1);
	float4 clr = TEX2D(texWater,  i.uv);

	//clr.rgb *= norm.rgb;

	clr.a *= 0.8;
	clr.a = clamp(clr.a, 0.0, 0.3);
	float l = luminance(clr)*0.65;
	return float4(l, l, l, clr.a);
	return clr;
}

DepthStencilState foamDS
{
	DepthEnable		= false;
	DepthWriteMask	= false;
	DepthFunc		= ALWAYS;

	TEST_COMPOSITION_TYPE_IN_STENCIL;
};



BlendState foamAlphaBlend
{
	BlendEnable[0] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;

	SrcBlendAlpha = ONE;
	DestBlendAlpha = ONE;
	BlendOpAlpha = MAX;

	RenderTargetWriteMask[0] = 0x0f;
};

technique10 Textured
{
	pass splashMain
	{
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS_SPLASH())
		GEOMETRY_SHADER(gsMain())
		PIXEL_SHADER(psWaterSplash(false))
	}
	pass splashlod
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS_SPLASH())
		GEOMETRY_SHADER(gsLod())
		PIXEL_SHADER(psWaterSplash(true))
	}

	pass splashTexture
	{
		SetRasterizerState(cullFront);
		SetVertexShader(CompileShader(vs_4_0, vs_on_water()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_on_water()));
		SetDepthStencilState(foamDS, STENCIL_COMPOSITION_WATER);
		//ENABLE_ALPHA_BLEND;
		SetBlendState(foamAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	}

	pass terrains
	{
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS_SPLASH())
		GEOMETRY_SHADER(gsTerrains())
		PIXEL_SHADER(psTerrainImpacts(false))
	}

	pass splashFlir
	{
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS_SPLASH())
		GEOMETRY_SHADER(gsMain())
		PIXEL_SHADER(psFlirSplash())
	}

	pass splashLodFlir
	{
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS_SPLASH())
		GEOMETRY_SHADER(gsLod())
		PIXEL_SHADER(psFlirSplash())
	}

	pass splashTextureFlir
	{
		SetRasterizerState(cullFront);
		SetVertexShader(CompileShader(vs_4_0, vs_on_water()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_on_water_flir()));
		SetDepthStencilState(foamDS, STENCIL_COMPOSITION_WATER);
		ENABLE_ALPHA_BLEND;
		//SetBlendState(foamAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	}

	pass terrainsFlir
	{
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS_SPLASH())
		GEOMETRY_SHADER(gsTerrains())
		PIXEL_SHADER(psTerrainsFlir())
	}
}
