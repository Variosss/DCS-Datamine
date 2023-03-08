#ifndef _CLOUDS_FX_H_
#define _CLOUDS_FX_H_

#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"

#include "deferred/atmosphere.hlsl"

static const float vertGradient = 0.5;						// [0..1] contrast of vertical gradient

Texture2D ParticleMap;
Texture2D NormalMap;
Texture2D GradientMap;
Texture2D AlphaGradientMap;

float4x4 CloudRotMatrix;
float3 center;
float3 cMin;
float3 cMax;
float4 instance_Pos;
float3 dir;
float3 left;
float3 up;

struct VSInput {
    float4 vPosition : POSITION0;
    float4 vTexCoord : TEXCOORD0;
	float  VTexCoord : TEXCOORD1;
};

struct VSOutput {
	float4 vPosition:	SV_POSITION;
	float3 vTexCoord:	TEXCOORD0;
	float4 vNormal:		TEXCOORD1;
	float4 vPPSPos:		TEXCOORD2;
	float4 wPos:		TEXCOORD3;
	float4 lPos:		TEXCOORD4;

	float3 inscatter:	TEXCOORD5;
	float3 sunColor:	TEXCOORD6;
};

static const float2 spritePos[] = {
	float2(-1.0, -1.0),
	float2(1.0, -1.0), 
	float2(1.0, 1.0),
	float2(-1.0, 1.0),
};

void CreateBillboard(float4 at, out float4x4 dest) {

    float3 Z = at.xyz, X, Y;

    static float3 wY = float3(0.0f,1.0f,0.0);
    static float3 wX = float3(1.0f,0.0f,0.0f);

	Z = normalize(Z);
    
    if(abs(Z.y) < 0.99f) {
		X = normalize(cross(wY, Z));
		Y = normalize(cross(X, Z));
    } else {
		Y = normalize(cross(Z, wX));
		X = normalize(cross(Y, Z));
    }

    dest._m00 = X.x; dest._m01 = X.y; dest._m02 = X.z; dest._m03 = 0;
    dest._m10 = Y.x; dest._m11 = Y.y; dest._m12 = Y.z;dest._m13 =0;
	dest._m20 = Z.x; dest._m21 = Z.y; dest._m22 = Z.z; dest._m23 =0;
	dest._m30 = Z.x; dest._m31 = Z.y; dest._m32 = Z.z; dest._m33 =1;
}

#ifdef USE_DCS_DEFERRED

float3 calculateAtmosphereForCirrus(float3 pos, out float3 transmittance)
{
	return GetSkyRadianceToPoint(gEarthCenter, pos, 0.0/*shadow*/, gSunDir, transmittance) * gAtmIntensity;
}

#endif

VSOutput vsMain(const in VSInput i) {
	VSOutput o;
	
	float4 iPos = instance_Pos;
	float Radius = iPos.w;
	
	float3 pos = float3(spritePos[(int)i.vTexCoord.x].xy, 0.0) * i.vPosition.w * Radius * 1.25 * (i.vTexCoord.y * 0.5 + 0.5);

	float cosA = cos(i.vTexCoord.y * 3.14);
	float sinA = sin(i.vTexCoord.y * 3.14);

	float4 rotpos = mul(float4(i.vPosition.xyz, 1.0), CloudRotMatrix);
	
	float4x4 posMatrix = {
		1.0,						0.0,						0.0,						0.0,
		0.0,						1.0,						0.0,						0.0, 
		0.0,						0.0,						1.0,						0.0,
		rotpos.x * Radius,		rotpos.y * Radius,		rotpos.z * Radius,		1.0
	};

	float2x2 rotMatrix = {
		cosA,	-sinA,
		sinA,	cosA
	};

	float4 vPos = float4(pos, 1.0);
	vPos.xy = mul(vPos.xy, rotMatrix);
	float3 V = ((instance_Pos.xyz + rotpos.xyz * Radius) - gCameraPos);
	float L = length(V);
	float d = max(i.vPosition.w * Radius * 4.0 - L, 0.0);
	V-= dir*d;

	float4x4 BB = gViewInv;
	BB._41_42_43 = 0;

	vPos = mul(float4(vPos.xyz, 1.0), BB);

	vPos = mul(float4(vPos.xyz, 1.0), posMatrix);
	o.lPos = float4(normalize(vPos.xyz / vPos.w), i.vTexCoord.y);
	float4 wPos = float4(vPos.xyz + iPos.xyz, 1.0);
	wPos.xyz /= wPos.w;

	float3 minV = cMin * Radius + iPos.xyz;
	float3 maxV = cMax * Radius + iPos.xyz;
	float G = (wPos.y - minV.y) / (maxV.y - minV.y);

	float3 N = normalize(vPos.xyz - center);// / vPos.w - ((maxV + minV) * 0.5));
	o.vNormal = float4(G, N.xyz);
	o.wPos = float4(wPos.xyz, Radius);
	o.vPosition = o.vPPSPos = mul(float4(wPos.xyz, 1.0), gViewProj);

	float2 UV = (spritePos[(int)i.vTexCoord.x]);
	o.vTexCoord = float3(i.vTexCoord.zw, i.vPosition.w * Radius * 1.3 * (i.vTexCoord.y * 0.5 + 0.5));
	o.lPos.xy = UV.xy * 0.5 + 0.5;
	o.lPos.zw = float2(cos(-i.vTexCoord.y * 3.14), sin(-i.vTexCoord.y * 3.14));

	float3 transmittance;
	float3 cPos = (wPos.xyz - gCameraPos)*0.001;

//	float dist = length(cPos);
//	cPos += cPos * (75/dist - 1);
//	cPos.y += 6360.0 + gOrigin.y*0.001;

//	const float Rg = 6360.0;
//	float3 viewDir = cPos/dist;
//	float r, mu, mu2;
//	GetRMu(gEarthCenter, viewDir, r, mu);
//	mu2 = -sqrtf(1.0 - (Rg / r) * (Rg / r)) + 0.01;
//	viewDir += float3(0, -1, 0)*(m2 - mu);

//	static const float atmDepth = paramDistMax;//km
//	o.inscatter = GetSkyRadiance(gEarthCenter, viewDir, 0.0, gSunDir, transmittance, atmDepth) * gAtmIntensity;

	cPos.xz = normalize(cPos.xz) * 200;
	cPos.y = 6361.0;

	o.inscatter = calculateAtmosphereForCirrus( cPos, transmittance);
	o.inscatter += o.inscatter.z*(1-exp(-(gCameraPos.y + gOrigin.y) / 25000));

	o.sunColor = GetSunRadiance(cPos, gSunDir);
	o.sunColor = lerp(o.sunColor, dot(o.sunColor, 0.333).xxx, saturate(1 - gSunDir)*0.3);//чутка обесцвечиваем красноту солнца
	o.sunColor *= transmittance * gSunIntensity;

	return o;
}

float4 psMain(const in VSOutput i): SV_TARGET0 {

	float L = length(gCameraPos - i.wPos.xyz);

	float2 uv = i.vTexCoord;

	float2x2 rotMatrix = {
		i.lPos.z,	-i.lPos.w,
		i.lPos.w,	i.lPos.z,
	};

	// cloud mask
	float mask = ParticleMap.Sample(gBilinearClampSampler, uv).r;
	float3 normal = NormalMap.Sample(gBilinearClampSampler, i.lPos.xy);
	normal = normal * 2.0 - 1.0;

	normal.xy = mul(normal.xy, rotMatrix);

	float3 worldnorm;
	worldnorm = -normal.x * left;
	worldnorm += normal.y * up;
	worldnorm += -normal.z * dir;
	normal = -normalize(worldnorm);

	float3 view = normalize(gCameraPos - i.wPos.xyz);

	float VdotUP = max(dot(view, float3(0.0, 1.0, 0.0)), 0.0) * 0.3;
	float LdotV = pow(max(0.0, dot(view, -gSunDir)), 10.0);
	float LdotN = dot(gSunDir, normalize(i.vNormal.yzw)) * 0.5 + 0.5;
	float LdotNormal = max(dot(gSunDir, normal), 0.0);// * 0.5 + 0.5;
	float LdotUP = pow(max(0.0, dot(gSunDir, float3(0.0, 1.0, 0.0))), 1.0);

	float3 gradient = saturate(VdotUP + GradientMap.Sample(gBilinearClampSampler, float2(0.5, i.vNormal.x)).rgb)*vertGradient+(1.0-vertGradient);
	float3 storedGradient = gradient;
	float alpha = pow(AlphaGradientMap.Sample(gBilinearClampSampler, float2(0.5, i.vNormal.x)).r, 0.6);

	float3 masked_gradient = lerp(gradient * 0.9 + mask * 0.05, gradient + mask * 0.05, LdotNormal * mask) * 0.9;
	gradient = pow(lerp(gradient, masked_gradient, alpha), 1.1) * 1.1;
	
	float h = saturate((gCameraPos.y - i.vNormal.z) / 2000.0);

	float nearAlpha = saturate(L / (i.wPos.w / 10));
	float nra = saturate(L / (i.wPos.w / 0.2));

	float3 sphereUV = normalize(worldnorm + i.vNormal.xyz);
	float tuy = dot(sphereUV, normal.xyz) * VdotUP;
	
//	float c_ambient = gSunDiffuse;
//	float3 color = gSunDiffuse * gradient;
//	color = lerp(color, c_ambient * gradient * 2.0, gradient) * 1.1 + LdotN * gSunDiffuse * pow((1.0 - LdotUP), 6.0) * 0.5;
//	color += (LdotV * 0.5 + 0.3 * (1.0 - mask) * pow(LdotV, 4.0)) * storedGradient * gSunDiffuse * (1.0 - LdotUP);
//	color = pow(color*cloudColor, 2.2);

	float3 color = i.inscatter * gradient;
	color += LdotN * i.sunColor * pow((1.0 - LdotUP), 6.0) * 0.5;
	color += (LdotV * 0.5 + 0.3 * (1.0 - mask) * pow(LdotV, 4.0)) * storedGradient * i.sunColor * (1.0 - LdotUP);

	float fm = pow(saturate(L / 80000), 1.2);

	float DepthAlpha = (1.0 - saturate(L / i.wPos.w * 1)) * (1.0 - length(i.lPos.xy * 2.0 - 1.0));
	float A = lerp(saturate(pow(mask, 2) *alpha * nearAlpha * pow(1-fm,1)), nearAlpha * DepthAlpha * alpha, 1 - nra);

	if(A<0.01)
		discard;
	
	return float4(color, A);
}

technique11 standart
{
    pass P0
    {
	    SetVertexShader(CompileShader(vs_5_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psMain()));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
    }
}



#endif