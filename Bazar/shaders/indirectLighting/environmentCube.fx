#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/ambientCube.hlsl"
#include "common/context.hlsl"
#include "common/BRDF.hlsl"
#include "deferred/atmosphere.hlsl"
#include "deferred/shadows.hlsl"

Texture2D	texOld;
Texture2D	texNew;
Texture2D	texOvercast;
TextureCube texCube;

float2 angleWall;
float height;
float lerpParam;
float2 altitudeThickness;
float4x4 VP;
#define VPInv VP

static const float3 normals[] = {
	{1,0,0},
	{-1,0,0},
	{0, 1,0},
	{0,-1,0},
	{0,0, 1},
	{0,0,-1},
};

static const float3 binormals[] = {
	{0, 1, 0},
	{0, 1, 0},
	{0, 0, -1},
	{0, 0, 1},
	{0, 1, 0},
	{0, 1, 0},
};

// uv: [0-1]
float3 GetDirectionFromCubeMapUV(uint wall, float2 uv)
{
	uv = uv * 2.0 - 1.0;
	uv *= 2;

	float3 normal = normals[wall];
	float3 binorm = binormals[wall];
	float3 tangent = cross(normal, binorm);

	return normalize(normal - uv.y*binorm - uv.x*tangent);
}

// y - up
float2 CartesianToSphericalCoordSys(float3 normalizedDir)
{
	const float pi = 3.141592653589;
	float phi = atan2(normalizedDir.x, normalizedDir.z);
	float theta = acos(normalizedDir.y);
	return float2( -phi / pi, theta / (pi/2)) * 0.5;
}

struct VS_OUTPUT {
	float4	pos:	SV_POSITION0;
	float2	coords: TEXCOORD0;
	float3	dir:	TEXCOORD1;
};

struct VS_QUAD_OUTPUT {
	float4	pos:	SV_POSITION0;
	float4	projPos: TEXCOORD0;
};

struct VS_OUTPUT2 {
	float4	pos:	SV_POSITION0;
	float3	coords: TEXCOORD0;
};

struct VS_OUTPUT_OVC {
	float4	pos:	SV_POSITION0;
	float3	coords: TEXCOORD0;
	float3  color: TEXCOORD1;
};


static const float2 quad[4] =  {
	{-1, -1},	{1, -1},
	{-1,  1}, 	{1,  1},
};

VS_OUTPUT VS(uint id: SV_VertexId)
{
	float2 sc;
	sincos(angleWall.x, sc.x, sc.y);
	float2x2 M = {sc.y, sc.x, -sc.x, sc.y};

	VS_OUTPUT o;
	o.pos = float4(quad[id].xy, 0, 0.5);
	o.coords = mul(quad[id].xy, M) * 0.5 + 0.5;
	o.coords.y = 1 - o.coords.y;
	
	float2 uv = quad[id].xy * 0.5 + 0.5;
	uv.y = 1.0 - uv.y;
	o.dir = GetDirectionFromCubeMapUV(angleWall.y, uv);

	return o;
}

VS_QUAD_OUTPUT vsQuad(uint id: SV_VertexId)
{
	VS_QUAD_OUTPUT o;
	o.pos = o.projPos = float4(quad[id].xy, 0, 1);
	return o;
}

float4 PS(VS_OUTPUT i): SV_TARGET0
{
	return texNew.Sample(ClampLinearSampler, i.coords);
}

float4 cubic(float x)
{
	float x2 = x * x;
	float x3 = x2 * x;
	float4 w;
	w.x =   -x3 + 3*x2 - 3*x + 1;
	w.y =  3*x3 - 6*x2       + 4;
	w.z = -3*x3 + 3*x2 + 3*x + 1;
	w.w =  x3;
	return w / 6.f;
}

float4 BicubicFilter(Texture2D tex, float2 texcoord, float2 texscale)
{
	float fx = frac(texcoord.x);
	float fy = frac(texcoord.y);
	texcoord.x -= fx;
	texcoord.y -= fy;

	float4 xcubic = cubic(fx);
	float4 ycubic = cubic(fy);

	float4 c = float4(texcoord.x - 0.5, texcoord.x + 1.5, texcoord.y - 0.5, texcoord.y + 1.5);
	float4 s = float4(xcubic.x + xcubic.y, xcubic.z + xcubic.w, ycubic.x + ycubic.y, ycubic.z + ycubic.w);
	float4 offset = c + float4(xcubic.y, xcubic.w, ycubic.y, ycubic.w) / s;

	float4 sample0 = tex.SampleLevel(gBilinearClampSampler, float2(offset.x, offset.z) * texscale, 0);
	float4 sample1 = tex.SampleLevel(gBilinearClampSampler, float2(offset.y, offset.z) * texscale, 0);
	float4 sample2 = tex.SampleLevel(gBilinearClampSampler, float2(offset.x, offset.w) * texscale, 0);
	float4 sample3 = tex.SampleLevel(gBilinearClampSampler, float2(offset.y, offset.w) * texscale, 0);

	float sx = s.x / (s.x + s.y);
	float sy = s.z / (s.z + s.w);

	return lerp(
		lerp(sample3, sample2, sx),
		lerp(sample1, sample0, sx), sy);
}

float4 psBlendWithCube(VS_QUAD_OUTPUT i): SV_TARGET0
{
	float4 pos = mul(i.projPos, VPInv);
	float3 rayDir = normalize((pos.xyz/pos.w) - gCameraPos.xyz);

	// return float4(SampleEnvironmentMapApprox(gCameraPos.xyz, rayDir, 0.5), 1);
	return texCube.SampleLevel(ClampLinearSampler, rayDir, 0);// * (1-gDev1.x);
}

float4 psSphericalCoordSysToCube(VS_OUTPUT i): SV_TARGET0
{
	return texNew.Sample(gBilinearWrapSampler, CartesianToSphericalCoordSys(normalize(i.dir)));
}

static const float radius = 500.0;

VS_OUTPUT2 vsFakeSurf(float3 pos: POSITION0)
{
	VS_OUTPUT2 o;
	o.pos = mul(float4(pos*radius + gCameraPos, 1), VP);
	o.coords.xy = 0.5 - pos.xz*0.5;//UV

	float nHeight = saturate(height/20000);
	o.coords.z = (-pos.y*0.95+0.05) * (9-7*nHeight);//opacity
	return o;
}

float4 psFakeSurf(VS_OUTPUT2 i) : SV_TARGET0
{
	float3 clr = max(0, lerp(texOld.Sample(gTrilinearClampSampler, i.coords.xy).rgb, texNew.Sample(gTrilinearClampSampler, i.coords.xy).rgb, lerpParam));
	return float4(clr, pow(saturate(i.coords.z), 1.8) );
}


VS_OUTPUT_OVC vsFakeOvercast(uint id: SV_VertexID, uniform bool bWithinOvercast)
{
	const float albedo = 0.6;
	const float3 overcastTint = float3(0.8,0.9,1);

	const float alt = altitudeThickness.x;
	const float thickness = altitudeThickness.y;

	float distToOvercast = height - alt;

	float nHeight = saturate((height - alt) / thickness);

	float3 wPos = float3(quad[id].x, distToOvercast>0? -0.01 : 0.01, quad[id].y)*radius;
	// wPos.y = (height - alt) - gCameraPos.y;

	float3 pos = float3(0, gEarthRadius + (alt + thickness) * 0.001, 0);

	float3 sunColor = GetSunRadiance(pos, gSunDir) * gSunIntensity;
	float sunLuminance = dot(sunColor, 0.333).xxx;
	sunColor = lerp(sunColor, sunLuminance, saturate(1-gSunDir)*0.3);//копия вычислений в ovc.fx!!!!
	sunColor *= saturate((gSunDir.y+0.05)*4) / 3.1416;

	VS_OUTPUT_OVC o;
	o.pos = bWithinOvercast ? float4(quad[id], 0.1, 1) : mul(float4(wPos, 1), VP);
	o.coords.xy = 0;
	o.coords.z = saturate((gSunDir.y+0.1)*5);//opacity
	o.color = albedo * lerp(sunLuminance * 0.1, sunColor, nHeight) * overcastTint;
	return o;
}

float4 psFakeOvercast(VS_OUTPUT_OVC i, uniform bool bWithinOvercast) : SV_TARGET0
{
	return float4(i.color, i.coords.z);
}

float4 vsFakeWater(float2 pos: POSITION0): SV_POSITION0
{
	return float4(pos.x, pos.y, 0, 1);
}

float4 psFakeWater() : SV_TARGET0
{
	static const float3 lumCoef =  {0.2125f, 0.7154f, 0.0721f};
	// static const float3 waterColor = {46.f/255.f, 99.f/255.f, 88.f/255.f};//зеленоватый
	static const float3 waterColor = {45.f/255.f, 86.f/255.f, 96.f/255.f};//более синий
	static const float3 waterColorDark = {24.f/255.f, 33.f/255.f, 56.f/255.f};//темно синий
	
	float lum = dot(lumCoef, AmbientTop);
	return float4(min(1, lerp(waterColorDark, waterColor*1.15, lum) * max(0, lum-0.1)*3), 1-saturate(height/20000));
}

float4 psFarFakeSurf(VS_OUTPUT2 i) : SV_TARGET0 {
	const float3 diffuseColor = float3(0.25, 0.25, 0.25);	// in linear space
	float3 sunColor = SampleSunRadiance(float3(0, 0.05 - gOrigin.y, 0), gSunDir);
	float3 clr = Diffuse_lambert(diffuseColor) * sunColor * (gSunIntensity * gSurfaceNdotL);
	return float4(clr, pow(saturate(i.coords.z), 1.8));
}

BlendState cloudsBS
{
	BlendEnable[0] = true;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	// DestBlend = SRC_ALPHA;
	BlendOp = ADD;
	RenderTargetWriteMask[0] = 0x0f;
};

technique10 cubeAssembly
{
	pass sixWallsToCube
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

	pass sphericalCoordSysToCube
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSphericalCoordSysToCube()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

technique10 fakePrimitives
{
	pass surface
	{
		SetVertexShader(CompileShader(vs_4_0, vsFakeSurf()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psFakeSurf()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	
	pass overcast
	{
		SetVertexShader(CompileShader(vs_4_0, vsFakeOvercast(false)));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psFakeOvercast(false)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
	
	pass water
	{
		SetVertexShader(CompileShader(vs_4_0, vsFakeWater()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psFakeWater()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

	pass farSurface
	{
		SetVertexShader(CompileShader(vs_4_0, vsFakeSurf()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psFarFakeSurf()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

	pass overcastWithin
	{
		SetVertexShader(CompileShader(vs_4_0, vsFakeOvercast(true)));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psFakeOvercast(true)));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

	pass blendClouds
	{
		SetVertexShader(CompileShader(vs_4_0, vsQuad()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psBlendWithCube()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(cloudsBS, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
