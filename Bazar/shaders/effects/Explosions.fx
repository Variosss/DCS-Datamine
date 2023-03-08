#define FOG_ENABLE

#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "common/fog2.hlsl"

Texture2D Noise;
Texture2D Normal;

float4x4 matWorld;
float3 left;
float3 up;
float3 dir;

float3 flashcolor;
float flashI;

float scale;

struct vsInput {
	float3 p:		POSITION0;
	float4 n:		NORMAL0;
	float4 tc:		TEXCOORD0;
};

struct vsOutput {
	float4 p:				SV_POSITION0;
	float2 uv:				TEXCOORD0;
	float4 SinCosThetaFog:	TEXCOORD1;
	float3 c:				TEXCOORD2;
	float3 lp:				TEXCOORD3;
};

struct psOutput {
	float4 c:		SV_TARGET0; 
};

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}
vsOutput vsMain(vsInput i) {
	vsOutput o;

	o.lp = i.p;

	float4 ppsPos = mul(float4(i.p * scale, 1.0), matWorld);
	
	o.p = mul(ppsPos, gViewProj);

	o.uv = i.tc.xy;

	sincos(i.tc.w, o.SinCosThetaFog.x, o.SinCosThetaFog.y);
	o.SinCosThetaFog.z = i.tc.z;
	o.SinCosThetaFog.w = getFogTransparency(gCameraPos.xyz, ppsPos);

	o.c = i.n.xyz;

	return o;
}

psOutput psColorFill(vsOutput i) {
	psOutput o;

	o.c = float4(1.0, 0.0, 0.0, 1.0);

	return o;
}

psOutput psColorFillFlir(vsOutput i) {
	psOutput o;

	o.c = float4(1.0, 0.0, 0.0, 1.0);

	float l = luminance(o.c);

	o.c = float4(l, l, l, o.c.a);
	return o;

	return o;
}

psOutput psNoiseFill(vsOutput i) {
	psOutput o;

	float3 noise = Noise.Sample(WrapLinearSampler, i.uv);

	float alpha = noise.r * (1.0f - i.SinCosThetaFog.z);
	
	
	o.c = float4(1.0, 1.0, 1.0, alpha);
	
	//fog	
	o.c.rgb = lerp(gFogColor.rgb, o.c.rgb, i.SinCosThetaFog.w);

	return o;
}

psOutput psNoiseFillFlir(vsOutput i) {
	psOutput o;

	float3 noise = Noise.Sample(WrapLinearSampler, i.uv);

	float alpha = noise.r * (1.0f - i.SinCosThetaFog.z);
	
	
	o.c = float4(1.0, 1.0, 1.0, alpha);
	
	//fog	
	o.c.rgb = lerp(gFogColor.rgb, o.c.rgb, i.SinCosThetaFog.w);


	float l = luminance(o.c);

	o.c = float4(l, l, l, o.c.a);
	return o;

	return o;
}

psOutput psStandart(vsOutput i) {
	psOutput o;

	float3 noise = Noise.Sample(WrapLinearSampler, i.uv).rgb;
	float3 normal = Normal.Sample(WrapLinearSampler, i.uv).rgb;

	float alpha = saturate(noise.r * (1.0f - i.SinCosThetaFog.z));

	normal = normalize(normal.xyz * 2.0 - 1.0);

	float3 rotnorm;
	float fSinTheta = i.SinCosThetaFog.x;
	float fCosTheta = i.SinCosThetaFog.y;
	
	float2x2 RotMatrix = {fCosTheta, -fSinTheta, fSinTheta, fCosTheta};

	rotnorm.xy = mul(normal.xy, RotMatrix);
	rotnorm.z = normal.z;
	
	float3 worldnorm;
    worldnorm = -rotnorm.x * left;
    worldnorm += rotnorm.y * up;
    worldnorm += -rotnorm.z * dir;

	normal = -normalize(worldnorm);

	float NdotL = dot(normal, gSunDir) * 0.5 + 0.5;
	
	float power = pow(saturate(dot(gSunDir, float3(0.0, 1.0, 0.0))), 0.5);

	float3 ambient = AmbientTop;
	float3 composite = (i.c + 0.1) * NdotL * gSunDiffuse * 1.2 * length(ambient) * 0.5;
	composite += power * ambient * i.c * 0.5;

	float flashdist = length(i.lp) + 0.1;
	float att = saturate(1.0 / (flashdist * flashdist));

	float3 flashdir = normalize(-i.lp);

	composite = lerp(composite, att * flashI * flashcolor, saturate(flashI * att));
	
	//fog	
	composite = lerp(gFogColor.rgb, composite, i.SinCosThetaFog.w);
	
	o.c = float4(composite, alpha);
	return o;
}

psOutput psStandartFlir(vsOutput i) {
	psOutput o;

	float3 noise = Noise.Sample(WrapLinearSampler, i.uv).rgb;
	float3 normal = Normal.Sample(WrapLinearSampler, i.uv).rgb;

	float alpha = saturate(noise.r * (1.0f - i.SinCosThetaFog.z));

	normal = normalize(normal.xyz * 2.0 - 1.0);

	float3 rotnorm;
	float fSinTheta = i.SinCosThetaFog.x;
	float fCosTheta = i.SinCosThetaFog.y;
	
	float2x2 RotMatrix = {fCosTheta, -fSinTheta, fSinTheta, fCosTheta};

	rotnorm.xy = mul(normal.xy, RotMatrix);
	rotnorm.z = normal.z;
	
	float3 worldnorm;
    worldnorm = -rotnorm.x * left;
    worldnorm += rotnorm.y * up;
    worldnorm += -rotnorm.z * dir;

	normal = -normalize(worldnorm);

	float NdotL = dot(normal, gSunDir) * 0.5 + 0.5;
	
	float power = pow(saturate(dot(gSunDir, float3(0.0, 1.0, 0.0))), 0.5);

	float3 ambient = AmbientTop;
	float3 composite = (i.c + 0.1) * NdotL * gSunDiffuse * 1.2 * length(ambient) * 0.5;
	composite += power * ambient * i.c * 0.5;

	float flashdist = length(i.lp) + 0.1;
	float att = saturate(1.0 / (flashdist * flashdist));

	float3 flashdir = normalize(-i.lp);

	composite = lerp(composite, att * flashI * flashcolor, saturate(flashI * att));
	
	//fog	
	composite = lerp(gFogColor.rgb, composite, i.SinCosThetaFog.w);
	
	o.c = float4(composite, alpha);

	float l = max(luminance(o.c), 0.2);

	o.c = float4(l, l, l, o.c.a);
	return o;
}


TECHNIQUE ColorFill {
	pass P0 {
		SET_RASTER_STATE_FRONT_CULLING_NO_BIAS;
		ENABLE_ALPHA_BLEND;
		ENABLE_RO_DEPTH_BUFFER;
		
		VERTEX_SHADER(vsMain())
		PIXEL_SHADER(psColorFill())
		GEOMETRY_SHADER_PLUG
	}

	pass P1 {
		SET_RASTER_STATE_FRONT_CULLING_NO_BIAS;
		ENABLE_ALPHA_BLEND;
		ENABLE_RO_DEPTH_BUFFER;
		
		VERTEX_SHADER(vsMain())
		PIXEL_SHADER(psColorFillFlir())
		GEOMETRY_SHADER_PLUG
	}
}

TECHNIQUE NoiseFill {
	pass P0 {
		SET_RASTER_STATE_FRONT_CULLING_NO_BIAS;
		ENABLE_ALPHA_BLEND;
		ENABLE_RO_DEPTH_BUFFER;
		
		VERTEX_SHADER(vsMain())
		PIXEL_SHADER(psNoiseFill())
		GEOMETRY_SHADER_PLUG
	}

	pass P1 {
		SET_RASTER_STATE_FRONT_CULLING_NO_BIAS;
		ENABLE_ALPHA_BLEND;
		ENABLE_RO_DEPTH_BUFFER;
		
		VERTEX_SHADER(vsMain())
		PIXEL_SHADER(psNoiseFillFlir())
		GEOMETRY_SHADER_PLUG
	}
}

TECHNIQUE Standart {
	pass P0 {
		SET_RASTER_STATE_FRONT_CULLING_NO_BIAS;
		ENABLE_ALPHA_BLEND;
		ENABLE_RO_DEPTH_BUFFER;
		
		VERTEX_SHADER(vsMain())
		PIXEL_SHADER(psStandart())
		GEOMETRY_SHADER_PLUG
	}

	pass P1 {
		SET_RASTER_STATE_FRONT_CULLING_NO_BIAS;
		ENABLE_ALPHA_BLEND;
		ENABLE_RO_DEPTH_BUFFER;
		
		VERTEX_SHADER(vsMain())
		PIXEL_SHADER(psStandartFlir())
		GEOMETRY_SHADER_PLUG
	}
}