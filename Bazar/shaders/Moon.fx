#include "common/TextureSamplers.hlsl"
#include "common/context.hlsl"
#define FOG_ENABLE
#include "common/fog2.hlsl"
#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

#include "deferred/atmosphere.hlsl"

Texture2D DiffuseMap;
Texture2D normalMap;

float4x4 matWorldViewProj;
float4x4 matWorld;

// Sun light source params
float3 uSunDir;

float3 uCameraPos;

float2 uScale;

struct vsInput{
	float3 vPosition:	POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

struct vsOutput{
	float4 vPosition:	SV_POSITION;
	float2 uv:	TEXCOORD0;
	float4 vWorldPos:	TEXCOORD1;
};

vsOutput vsMoon(in const vsInput i){
	vsOutput o;
	float4 position = float4(i.vPosition*uScale.x, 1.0);
	o.vPosition = mul(position, matWorldViewProj);
	o.vPosition.z=0;
	o.uv = i.vTexCoord0;
	o.vWorldPos = mul(position, matWorld);

	return o;
}

float3 sphericNormal(float2 uv, float radius)
{
	float2 dir = (uv*2-1) / radius;
	float dist = length(dir);
	return float3(normalize(dir.xy)*saturate(dist), sqrt(saturate(1-dot(dir,dir))));
}

float3 applyAtmosphere(float3 viewDir, float3 color)
{
	float r = length(atmEarthCenter);
	float mu = dot(atmEarthCenter, viewDir) / r;
	float3 transmittance;
	float3 skyRadiance = GetSkyRadiance(atmEarthCenter + float3(0, heightHack, 0), viewDir, 0.0, atmSunDirection, transmittance, paramDistMax);

	float3 skyColor = color * transmittance + skyRadiance * gAtmIntensity;

	static const float Rg = gEarthRadius;
	AtmosphereParameters atmosphere; initAtmosphereParameters(atmosphere);
	float dist = RayIntersectsGround(atmosphere, r, mu) ? DistanceToBottomAtmosphereBoundary(atmosphere, r, mu) : sqrt(r*r-Rg*Rg)*0.3;

	return applyFog(skyColor, viewDir, 150000.0, true);
}

float4 psMoon(const vsOutput i): SV_TARGET0
{
	// return 1;
	float planetRadius = 0.98;
	float radiusInv = 1 / planetRadius;

	float2 dir = (i.uv*2-1) * radiusInv;
	float dist = length(dir);
	float planetOpacity = 1 - smoothstep(0.99, 1.00, dist);

	float3 normal = sphericNormal(i.uv, planetRadius);
	float4 n = normalize(mul(float4(normal, 0), matWorld));

	float NoL = saturate(dot(n.xyz, -normalize(uSunDir)));

	float3 diffuse = DiffuseMap.Sample(ClampLinearSampler, i.uv.xy).rgb;

	//HACK: gSunIntensity заменяется на интенсивность луны, но для шейдинга самой луны надо знать абсолютную яркость солнца
	const float sunIntensity = 10 * uScale.y;

	float3 planetColor = diffuse.rgb * diffuse.rgb * (NoL * sunIntensity / atmPI);

	float4 result = float4(planetColor, planetOpacity);

	//earth atmosphere
	float3 view = normalize(i.vWorldPos.xyz - uCameraPos.xyz);
	result.xyz = applyAtmosphere(view, result.xyz);

	result.xyz *= planetOpacity;
	return result;
}

BlendState moonBS
{
	BlendEnable[0] = TRUE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

technique10 Moon{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMoon()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psMoon()));

		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(moonBS, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
