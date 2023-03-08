#include "common/Samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"

Texture2D	tex;
TextureCube	texCube;
float4x4	WVP;
float3		sunDir;
uint		knotId;
uint2		samplesXY;

struct Knot { float4 walls[6]; };
StructuredBuffer<Knot>		sbSourceKnots;//все ракурсы солнца для всех узлов

#define PASS_SOURCE_SB		0
#define PASS_RESOLVED_SB	1
#define	PASS_CUBE_TEX		2

struct VS_INPUT
{
	float3 vPos : POSITION0;
};

struct VS_OUT
{
	float4 pos : SV_POSITION0;
	float3 tex0 : TEXCOORD0;
};

VS_OUT vsDefault(VS_INPUT i, uniform bool bCube)
{
	VS_OUT o;
	o.pos = mul(float4(i.vPos, 1), WVP);
	// o.pos = mul(float4(i.vPos + float3(0,0,-5), 1), gViewProj);

	if(bCube)
		o.tex0 = i.vPos.xyz;	
	else
		o.tex0 = i.vPos.xyz;
	
	return o;
}


float3 unpackSunDir(float u, float v)
{
	float3 sunDir;
	sunDir.y = -1.0 + 2.0 * v;
	float azimuth = 2.0 * 3.1415 * u;
	float normFactor = sqrt(1.0 - sunDir.y*sunDir.y);
	sunDir.x = sin(azimuth)*normFactor;
	sunDir.z = cos(azimuth)*normFactor;
	return sunDir;
}

float2 packSunDir(in float3 sunDir)
{
	float azimuth = (abs(sunDir.x) < 1e-6 && abs(sunDir.z) < 1e-6) ? 0.0 : atan2(sunDir.x, sunDir.z);
	if(sunDir.x < 0)
		azimuth += 3.1415 * 2.0;
	float2 uv;
	uv.x = azimuth / 3.1415 / 2.0;
	uv.y = sunDir.y * 0.5 + 0.5;
	return uv;
}

#define BILINEAR_FILTERING

uint getCubeId(uint knotId, uint2 xy)
{
	return knotId*samplesXY.x*samplesXY.y + xy.y * samplesXY.x + xy.x;
}

float4 psDefault(VS_OUT i, uniform uint tech): SV_TARGET0
{
	// return 1;
	Knot knot;//наш расчитанный узел
	float3 normal = normalize(i.tex0.xyz);
	
	// float4 lightAmount = gSunIntensity;
	float4 lightAmount = float4((gSunIntensity * gILVSunFactor).xxx, 1);

	if(tech == PASS_SOURCE_SB)
	{
		float2 uv = packSunDir(mul(sunDir, (float3x3)gCockpitTransform));
		
		[unroll]
		for(uint wallId=0; wallId<6; ++wallId)
		{
		#ifdef BILINEAR_FILTERING
			float2 p = uv * (samplesXY-1);
			uint2 k0 = p;
			uint2 k1 = ceil(p) + 0.5;
			k1.x = k1.x % samplesXY.x;
			k1.y = min(samplesXY-1, k1.y);
			float2 delta = frac(p);
			#define C(x,y) sbSourceKnots[getCubeId(knotId, uint2(x,y))].walls[wallId]
			float4 c0 = lerp(C(k0.x, k0.y), C(k1.x, k0.y), delta.x);
			float4 c1 = lerp(C(k0.x, k1.y), C(k1.x, k1.y), delta.x);
			#undef C
			knot.walls[wallId] = lerp(c0, c1, delta.y);
		#else
			uint2 xy = uv * (samplesXY-1);
			knot.walls[wallId] = sbSourceKnots[getCubeId(knotId, xy)].walls[wallId];
		#endif
		}
	}
	else if(tech == PASS_RESOLVED_SB)
	{
		knot = sbSourceKnots[knotId];
	}
	
	if(tech < PASS_CUBE_TEX)
	{
		float3 nSquared = normal * normal;
		uint3 isNegative = uint3(0, 2, 4) + (normal < 0.0);
		
		return	(nSquared.x * knot.walls[isNegative.x].rgba +
				 nSquared.y * knot.walls[isNegative.y].rgba +
				 nSquared.z * knot.walls[isNegative.z].rgba) * lightAmount;
	}
	else
	{
		return float4(texCube.Sample(gTrilinearWrapSampler, normal).rgb, 1) * lightAmount;
	}
}

technique10 tech
{
	pass KnotAmbientCubeFromSourceSB
	{
		SetVertexShader(CompileShader(vs_4_0, vsDefault(false)));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psDefault(PASS_SOURCE_SB)));
		
		// SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		// SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
	
	pass KnotAmbientCubeFromResolvedSB
	{
		SetVertexShader(CompileShader(vs_4_0, vsDefault(false)));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psDefault(PASS_RESOLVED_SB)));
		
		// SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		// SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
	
	pass CubeTexture
	{
		SetVertexShader(CompileShader(vs_4_0, vsDefault(true)));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psDefault(PASS_CUBE_TEX)));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
