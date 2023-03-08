#include "common/context.hlsl"
#include "common/states11.hlsl"
#include "common/samplers11.hlsl"

/*
TODO:
1) равномерно распределить семплы в интеграле по сфере в расчете скаттеринга
2) адаптивно менять длину шага при расчете трансмиттенса и скаттеринга в зависимости от функции плотности атмосферы
*/

#ifdef TRANSMITTANCE_VOLUME_TEXTURE
	#define TRANSMITTANCE_3D
#endif

#ifdef USE_EDGE_OLD_DCS_FORWARD	// deprecated mode
float3 atmEarthCenter;			//	camera position in planet space, kilometers (center of planet as origin)
float3 atmSunDirection;			//	sun direction
float atmExposure;
#endif

Texture2D transmittanceTex;
Texture3D transmittanceTex2;

RWTexture3D<float4> resolvedScattering;

Texture3D<float4> scatteringTex;

Buffer<float>	miePhaseFunctionInput;

Texture1D miePhaseFuncTex: register(t93);

#include "atmDefinitions.hlsl"

//#define USE_OZONE
Texture2D deltaETex;	//irradiance tex
Texture3D deltaSRTex;	//delta scattering rayleigh
Texture3D deltaSMTex;	//delta scattering mie
Texture3D deltaJTex;	//scattering density
Texture3D deltaMultipleScatteringTex; // delta multiple scattering ( = delta scattering rayleigh )

float	r;
uint	layer;
uint	scatteringOrder;
//float3	sunDir;
float   NdotL;
float	blurWidth;

uint3	threadIdOffset;

static const float3 betaFogEx = 15.0e-3;
static const float3 betaRainEx = 0.15e-3;

float GetDensityRayleighFunc(AtmosphereParameters atmosphere, Length r)
{
	return exp(-(r - atmosphere.bottom_radius) / atmosphere.rayleigh_scale_height);
}

float GetDensityOzoneFunc(AtmosphereParameters atmosphere, float r)
{
	return GetDensityRayleighFunc(atmosphere, r) * 6e-5;
	// return getDensityR(r);
	//пик на 25км, значение 1
	// return 0.5 / (pow((abs((r-Rg)*0.1)-2.5), 2) + 0.5) * 200;
}

float GetDensityMieFunc(AtmosphereParameters atmosphere, Length r)
{
	return exp(-(r - atmosphere.bottom_radius) / atmosphere.mie_scale_height);
}

float GetDensityMieFunc(AtmosphereParameters atmosphere, Length r, Length dist)
{
	return GetDensityMieFunc(atmosphere, r);

	float distFactor = min(1, dist / 50.0);
	float heightFactor = saturate(1 - (r - atmosphere.bottom_radius) / 10.0);
	return distFactor * heightFactor;
	// return exp(-(r - atmosphere.bottom_radius) / (atmosphere.mie_scale_height * (1 + 0*distFactor) ));
}

//#define GetDensityRayleigh	GetDensityRayleighFunc
#define GetDensityMie			GetDensityMieFunc
//#define GetDensityAbsorption	GetDensityOzoneFunc

#include "atmFunctions.hlsl"

//интерполяция сплайна Безье. t - параметр [0;1],	p1,p2,p3,p4 - контрольные точки
float4 BezierCurve4(in float t, in float4 p1, in float4 p2, in float4 p3, in float4 p4)
{
	const float t2 = t*t;
	const float tInv = 1-t;
	const float tInv2 = tInv*tInv;
	return tInv2*tInv*p1 + 3*tInv2*t*p2 + 3*tInv*t2*p3 + t2*t*p4;
}

static const float2 verts[4] = {
	float2(-1.0, -1.0),	
	float2( 1.0, -1.0),	
	float2(-1.0,  1.0),	
	float2( 1.0,  1.0)	
};

float4 VS(uint vid: SV_VertexID): SV_POSITION {
	return float4(verts[vid], 0, 1);
}

uint VS_LAYER(uint vid: SV_VertexID): TEXCOORD0 {
	return layer; 
}

struct GS_OUTPUT {
	float4 pos	: SV_POSITION0;
	uint   layer: SV_RenderTargetArrayIndex;
};

[maxvertexcount(4)]
void GS(point uint i[1]: TEXCOORD0, inout TriangleStream<GS_OUTPUT> outputStream)
{
	GS_OUTPUT o;
	[unroll]
	for(int j=0; j<4; ++j) {
		o.layer = layer;
		o.pos = float4(verts[j], 0, 1);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float3 WriteMiePhaseFunctionPS(float4 vPos: SV_POSITION0): SV_TARGET0
{
	int id = int(vPos.x) * 3;
	float mieScale = 0.35;
	return float3(miePhaseFunctionInput[id], miePhaseFunctionInput[id+1], miePhaseFunctionInput[id+2]) * mieScale;//пакуем в таргет R10G11B10
}
float3 ComputeTransmittancePS(float4 vPos: SV_POSITION0): SV_TARGET0
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	return ComputeTransmittanceToTopAtmosphereBoundaryTexture(atmParams, vPos.xy);
}

float3 ComputeTransmittance3DPS(float4 vPos: SV_POSITION0): SV_TARGET0
{
#ifdef TRANSMITTANCE_VOLUME_TEXTURE
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	return ComputeTransmittance3DTexture(atmParams, float3(vPos.xy, layer + 0.5));
#else
	return float3(1,0,0);
#endif
}

struct IRRADIANCE_OUTPUT
{
	float4 deltaIrradiance: SV_TARGET0;
	float4 irradiance	  : SV_TARGET1;
};

IRRADIANCE_OUTPUT ComputeDirectIrradiancePS(float4 vPos: SV_POSITION0)
{
	IRRADIANCE_OUTPUT o;
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
#ifdef TRANSMITTANCE_3D
	o.deltaIrradiance = float4(ComputeDirectIrradianceTexture3D(atmParams, transmittanceTex2, vPos.xy), 0);
#else
	o.deltaIrradiance = float4(ComputeDirectIrradianceTexture(atmParams, transmittanceTex, vPos.xy), 0);
#endif
	o.irradiance = 0;
	return o;
}

struct SINGLE_SCATTERING_OUTPUT
{
	float3 deltaRayleigh: SV_TARGET0;
	float3 deltaMie		: SV_TARGET1;
	float4 scattering	: SV_TARGET2;
};

SINGLE_SCATTERING_OUTPUT ComputeSingleScatteringPS(float4 vPos: SV_POSITION0)
{
	SINGLE_SCATTERING_OUTPUT o;
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
#ifdef TRANSMITTANCE_3D
	ComputeSingleScatteringTexture3D(atmParams, transmittanceTex2, float3(vPos.xy, layer + 0.5), o.deltaRayleigh.rgb, o.deltaMie.rgb);
#else
	ComputeSingleScatteringTexture(atmParams, transmittanceTex, float3(vPos.xy, layer + 0.5), o.deltaRayleigh.rgb, o.deltaMie.rgb);
#endif
	o.scattering = float4(o.deltaRayleigh.rgb, o.deltaMie.r);
	return o;
}

float3 ComputeScatteringDensityPS(float4 vPos: SV_POSITION0): SV_TARGET0
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
#ifdef TRANSMITTANCE_3D
	return ComputeScatteringDensityTexture3D(atmParams, transmittanceTex2, deltaSRTex, deltaSMTex, deltaMultipleScatteringTex,
										   deltaETex, float3(vPos.xy, layer + 0.5), scatteringOrder);
#else
	return ComputeScatteringDensityTexture(atmParams, transmittanceTex, deltaSRTex, deltaSMTex, deltaMultipleScatteringTex,
										   deltaETex, float3(vPos.xy, layer + 0.5), scatteringOrder);
#endif
}

IRRADIANCE_OUTPUT ComputeIndirectIrradiancePS(float4 vPos: SV_POSITION0)
{
	IRRADIANCE_OUTPUT o;
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	o.deltaIrradiance = float4(ComputeIndirectIrradianceTexture(atmParams, deltaSRTex, deltaSMTex, deltaMultipleScatteringTex, vPos.xy, scatteringOrder), 0);
	o.irradiance = o.deltaIrradiance; //sum blending
	return o;
}

struct MULTIPLE_SCATTERING_OUTPUT
{
	float4 deltaMultipleScattering: SV_TARGET0;
	float4 scattering: SV_TARGET1;
};

MULTIPLE_SCATTERING_OUTPUT ComputeMultipleScatteringPS(float4 vPos: SV_POSITION0)
{
	MULTIPLE_SCATTERING_OUTPUT o;
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	float nu;
#ifdef TRANSMITTANCE_3D
	o.deltaMultipleScattering = float4(ComputeMultipleScatteringTexture3D(atmParams, transmittanceTex2, deltaJTex, float3(vPos.xy, layer + 0.5), nu), 0);
#else
	o.deltaMultipleScattering = float4(ComputeMultipleScatteringTexture(atmParams, transmittanceTex, deltaJTex, float3(vPos.xy, layer + 0.5), nu), 0);
#endif
	o.scattering = float4(o.deltaMultipleScattering.rgb / RayleighPhaseFunction(nu), 0);
	return o;
}










//ручное семплирование по id пикселя с линейной интерполяцией muS, id.x - чистый индекс nu без muS!!!
float4 SampleScattering(AtmosphereParameters atmosphere, uint3 id, float muS)
{
	//muS --> uMuS
	Length H = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
	Length d = DistanceToTopAtmosphereBoundary(atmosphere, atmosphere.bottom_radius, muS);
	Length d_min = atmosphere.top_radius - atmosphere.bottom_radius;
	Length d_max = H;
	Number a = (d - d_min) / (d_max - d_min);
	Number A = -2.0 * atmosphere.mu_s_min * atmosphere.bottom_radius / (d_max - d_min);
	Number uMuS = max(1.0 - a / A, 0.0) / (1.0 + a);

	//uMuS --> pixels
	float p = uMuS * (SCATTERING_TEXTURE_MU_S_SIZE);
	uint x0 = id.x * (SCATTERING_TEXTURE_MU_S_SIZE) + uint(p);
	uint x1 = id.x * (SCATTERING_TEXTURE_MU_S_SIZE) + min(uint(ceil(p) + 0.5), SCATTERING_TEXTURE_MU_S_SIZE-1);
	float lerpFactor = frac(p);
	
	float4 scattering0 = scatteringTex[uint3(x0, id.yz)];
	float4 scattering1 = scatteringTex[uint3(x1, id.yz)];
	
	return lerp(scattering0, scattering1, lerpFactor);
}




[numthreads(8, 32, 4)]
void ResolveScatteringCS(uint3 dId: SV_DispatchThreadID)
{
	const uint3 texSize = {SCATTERING_TEXTURE_NU_SIZE, SCATTERING_TEXTURE_MU_SIZE, SCATTERING_TEXTURE_R_SIZE};
	if(any(dId>=texSize))
		return;	

	AtmosphereParameters atmosphere; initAtmosphereParameters(atmosphere);	
	resolvedScattering[dId] = SampleScattering(atmosphere, dId, NdotL);
}

//маппинг индексов в параметры scatteringTex: r, mu, muS, nu
void GetScatteringParametersFromIndex(uint3 ids, out float uR, out float uMu, out float uMuS, out float uNu)
{
	//пересчитывает индекс в параметры
	const float4 SCATTERING_TEXTURE_SIZE = float4
	(
		SCATTERING_TEXTURE_NU_SIZE - 1,
		SCATTERING_TEXTURE_MU_S_SIZE,
		SCATTERING_TEXTURE_MU_SIZE,
		SCATTERING_TEXTURE_R_SIZE
	);

	uNu  = floor(ids.x / Number(SCATTERING_TEXTURE_MU_S_SIZE)) / SCATTERING_TEXTURE_SIZE.x;
	uMuS = fmod(ids.x, Number(SCATTERING_TEXTURE_MU_S_SIZE)) / SCATTERING_TEXTURE_SIZE.y;
	uMu  = ids.y / (SCATTERING_TEXTURE_SIZE.z-1);
	uR   = ids.z / (SCATTERING_TEXTURE_SIZE.w-1);
}


//маппинг индексов в параметры resolvedScattering: r, mu, dist, nu
void GetResolvedScatteringParametersFromIndex(uint3 ids, out float uR, out float uMu, out float uDist, out float uNu)
{
	//пересчитывает индекс в параметры
	const float4 SCATTERING_TEXTURE_SIZE = float4
	(
		SKY_RADIANCE_TEXTURE_NU_SIZE - 1,
		SKY_RADIANCE_TEXTURE_DIST_SIZE,
		SKY_RADIANCE_TEXTURE_MU_SIZE,
		SKY_RADIANCE_TEXTURE_R_SIZE
	);

	uNu  = floor(ids.x / Number(SKY_RADIANCE_TEXTURE_DIST_SIZE)) / SCATTERING_TEXTURE_SIZE.x;
	uDist = fmod(ids.x, Number(SKY_RADIANCE_TEXTURE_DIST_SIZE)) / SCATTERING_TEXTURE_SIZE.y;
	uMu  = ids.y / (SCATTERING_TEXTURE_SIZE.z-1);
	uR   = ids.z / (SCATTERING_TEXTURE_SIZE.w-1);
}

//это для scatteringTex
void GetRMuMuSNuFromScatteringTextureIndexes(IN(AtmosphereParameters) atmosphere, 
			IN(uint3) pixelIndexes, OUT(Length) r, OUT(Number) mu, OUT(Number) mu_s,
			OUT(Number) nu, OUT(bool) ray_r_mu_intersects_ground)
{
	float uR, uMu, uMuS, uNu;
	GetScatteringParametersFromIndex(pixelIndexes, uR, uMu, uMuS, uNu);

	// Distance to top atmosphere boundary for a horizontal ray at ground level.
	Length H = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
	// Distance to the horizon.
#ifdef SCATTERING_BETTER_R_MAPPING 
	// uR = GetUnitRangeFromTextureCoord(uR, SCATTERING_TEXTURE_R_SIZE);
	Length rho = H * uR * uR;
	r = sqrt(rho * rho + atmosphere.bottom_radius * atmosphere.bottom_radius);
#else
	Length rho = H * uR;
	r = sqrt(rho * rho + atmosphere.bottom_radius * atmosphere.bottom_radius);
#endif
	if (uMu < 0.5) {
		// Distance to the ground for the ray (r,mu), and its minimum and maximum
		// values over all mu - obtained for (r,-1) and (r,mu_horizon) - from which
		// we can recover mu:
		Length d_min = r - atmosphere.bottom_radius;
		Length d_max = rho;
		Length d = d_min + (d_max - d_min) * (1.0 - 2.0 * uMu);
		mu = d == 0.0 * m ? Number(-1.0) : ClampCosine(-(rho * rho + d * d) / (2.0 * r * d));
		ray_r_mu_intersects_ground = true;
	} else {
		// Distance to the top atmosphere boundary for the ray (r,mu), and its
		// minimum and maximum values over all mu - obtained for (r,1) and
		// (r,mu_horizon) - from which we can recover mu:
		Length d_min = atmosphere.top_radius - r;
		Length d_max = rho + H;
		Length d = d_min + (d_max - d_min) * (2.0 * uMu - 1.0);
		mu = d == 0.0 * m ? Number(1.0) : ClampCosine((H * H - rho * rho - d * d) / (2.0 * r * d));
		ray_r_mu_intersects_ground = false;
	}

#ifdef SCATTERING_BETTER_MU_S_MAPPING
	Number x_mu_s = uMuS;
	// from "Outdoor Light Scattering Sample Update" by Egor Yusov
	mu_s = tan((2.0 * x_mu_s - 1.0 + 0.26) * 1.1) / tan(1.26 * 1.1);
	mu_s = clamp(mu_s, -0.2, 1.0);
	// mu_s = tan((2.0 * x_mu_s - 1.0 + 0.26) * 0.75) / tan(1.26 * 0.75);
#else
	Number x_mu_s = uMuS;
	Length d_min = atmosphere.top_radius - atmosphere.bottom_radius;
	Length d_max = H;
	Number A = -2.0 * atmosphere.mu_s_min * atmosphere.bottom_radius / (d_max - d_min);
	Number a = (A - x_mu_s * A) / (1.0 + x_mu_s * A);
	Length d = d_min + min(a, A) * (d_max - d_min);
	mu_s = d == 0.0 * m ? Number(1.0) : ClampCosine((H * H - d * d) / (2.0 * atmosphere.bottom_radius * d));
#endif

	nu = ClampCosine(uNu * 2.0 - 1.0);
	// Clamp nu to its valid range of values, given mu and mu_s.
	float root = sqrt((1.0 - mu * mu) * (1.0 - mu_s * mu_s));
	nu = clamp(nu, mu * mu_s - root, mu * mu_s + root);
}

void GetRMuDistNuFromResolvedScatteringIndexes(IN(AtmosphereParameters) atmosphere, 
			IN(uint3) pixelIndexes, IN(Number) mu_s, OUT(Length) r, OUT(Number) mu, OUT(Number) dist,
			OUT(Number) nu, OUT(bool) ray_r_mu_intersects_ground)
{
	float uR, uMu, uD, uNu;
	GetResolvedScatteringParametersFromIndex(pixelIndexes, uR, uMu, uD, uNu);

	// Distance to top atmosphere boundary for a horizontal ray at ground level.
	Length H = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
	// Distance to the horizon.
#ifdef SCATTERING_BETTER_R_MAPPING 
	// uR = GetUnitRangeFromTextureCoord(uR, SCATTERING_TEXTURE_R_SIZE);
	Length rho = H * uR * uR;
	r = sqrt(rho * rho + atmosphere.bottom_radius * atmosphere.bottom_radius);
#else
	Length rho = H * uR;
	r = sqrt(rho * rho + atmosphere.bottom_radius * atmosphere.bottom_radius);
#endif

#ifdef LINEAR_MU
	mu = ParameterToMu(atmosphere, uMu, r);
	ray_r_mu_intersects_ground = RayIntersectsGround(atmosphere, r, mu);
#else
	if (uMu < 0.5) {
		// Distance to the ground for the ray (r,mu), and its minimum and maximum
		// values over all mu - obtained for (r,-1) and (r,mu_horizon) - from which
		// we can recover mu:
		Length d_min = r - atmosphere.bottom_radius;
		Length d_max = rho;
		Length d = d_min + (d_max - d_min) * (1.0 - 2.0 * uMu);
		mu = d == 0.0 * m ? Number(-1.0) : ClampCosine(-(rho * rho + d * d) / (2.0 * r * d));
		ray_r_mu_intersects_ground = true;
	} else {
		// Distance to the top atmosphere boundary for the ray (r,mu), and its
		// minimum and maximum values over all mu - obtained for (r,1) and
		// (r,mu_horizon) - from which we can recover mu:
		Length d_min = atmosphere.top_radius - r;
		Length d_max = rho + H;
		Length d = d_min + (d_max - d_min) * (2.0 * uMu - 1.0);
		mu = d == 0.0 * m ? Number(1.0) : ClampCosine((H * H - rho * rho - d * d) / (2.0 * r * d));
		ray_r_mu_intersects_ground = false;
	}
#endif

	dist = ParameterToDist(uD);

	nu = ClampCosine(uNu * 2.0 - 1.0);
	// Clamp nu to its valid range of values, given mu and mu_s.
	float root = sqrt((1.0 - mu * mu) * (1.0 - mu_s * mu_s));
	nu = clamp(nu, mu * mu_s - root, mu * mu_s + root);
}

float4 GetInterpolatedScattering(IN(AtmosphereParameters) atmosphere, IN(AbstractScatteringTexture) scattering_texture,
								 Length r, Number mu, Number mu_s, Number nu, bool ray_r_mu_intersects_ground)
{
  vec4 uvwz = GetScatteringTextureUvwzFromRMuMuSNu(atmosphere, r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  Number tex_coord_x = uvwz.x * Number(SCATTERING_TEXTURE_NU_SIZE - 1);
  Number tex_x = floor(tex_coord_x);
  Number lerp = tex_coord_x - tex_x;
  vec3 uvw0 = vec3((tex_x + uvwz.y) / Number(SCATTERING_TEXTURE_NU_SIZE), uvwz.zw);
  vec3 uvw1 = vec3((tex_x + 1.0 + uvwz.y) / Number(SCATTERING_TEXTURE_NU_SIZE), uvwz.zw);
  return SampleTexture3D(scattering_texture, uvw0) * (1.0 - lerp) + SampleTexture3D(scattering_texture, uvw1) * lerp;
}

float4 ComputeSkyRadiancePixel(uint3 id)
{
	AtmosphereParameters atmosphere; initAtmosphereParameters(atmosphere);

	//посчитать начальные r, mu, muS, nu, d
	bool bIntersectGround;
	float nu, d;
	AtmPoint p0;
	p0.mu_s = NdotL;
	GetRMuDistNuFromResolvedScatteringIndexes(atmosphere, id, p0.mu_s,		p0.r, p0.mu, d, nu, bIntersectGround);
	// GetRMuMuSNuFromScatteringTextureIndexes(atmosphere, id, p0.r, p0.mu, p0.mu_s, nu, bIntersectGround);

	// d = 1000;
	//огриначиваем по длине луча до конца атмосферы
	d = min(d,  bIntersectGround ? 
				DistanceToBottomAtmosphereBoundary(atmosphere, p0.r, p0.mu) :
				DistanceToTopAtmosphereBoundary(atmosphere, p0.r, p0.mu));

	//посчитать r, mu, muS для конечной точки
	AtmPoint p1 = GetRMuMuSAtDistance(atmosphere, p0.r, p0.mu, p0.mu_s, nu, d);

	// uint3 ids = id; ids.x /= SCATTERING_TEXTURE_MU_S_SIZE; //чистый индекс для uNu
	// float4 scattering0 = scatteringTex[id];
	// float4 scattering0 = SampleScattering(atmosphere, ids, p0.mu_s);//TODO: не равно GetInterpolatedScattering ниже, разобраться!!!!! 
	float4 scattering0 = GetInterpolatedScattering(atmosphere, scatteringTex, p0.r, p0.mu, p0.mu_s, nu, bIntersectGround);
	float4 scattering1 = GetInterpolatedScattering(atmosphere, scatteringTex, p1.r, p1.mu, p1.mu_s, nu, bIntersectGround);
	
	const float shadowLength = 0.0;
	d = max(d - shadowLength, 0);
	// float3 shadowTransmittance = GetTransmittance(atmosphere, transmittanceTex, p0.r, p0.mu, d, p0.mu<0);
	float3 shadowTransmittance = GetTransmittance(atmosphere, transmittanceTex, p0.r, p0.mu, d, bIntersectGround);

	return scattering0 - shadowTransmittance.rgbr * scattering1;
	
	// float4 scatteringRef = GetInterpolatedScattering(atmosphere, scatteringTex, p0.r, p0.mu, p0.mu_s, nu, bIntersectGround);
	// return dot(1, scatteringRef - scattering0);
}









float4 GetSkyRadianceToPointTest(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    Length r, Length mu, Length mu_s, Length nu, Length d,
	OUT(DimensionlessSpectrum) transmittance)
{
	bool ray_r_mu_intersects_ground = RayIntersectsGround(atmosphere, r, mu);
	
	transmittance = GetTransmittance(atmosphere, transmittance_texture, r, mu, d, ray_r_mu_intersects_ground);
	
	float4 scattering = GetInterpolatedScattering(atmosphere, scattering_texture, r, mu, mu_s, nu, ray_r_mu_intersects_ground);
	
	// Compute the r, mu, mu_s and nu parameters for the second texture lookup.
	// If shadow_length is not 0 (case of light shafts), we want to ignore the
	// scattering along the last shadow_length meters of the view ray, which we
	// do by subtracting shadow_length from d (this way scattering_p is equal to
	// the S|x_s=x_0-lv term in Eq. (17) of our paper).
	float shadow_length = 0;
	d = max(d - shadow_length, 0.0 * m);
	AtmPoint p = GetRMuMuSAtDistance(atmosphere, r, mu, mu_s, nu, d);
	
	float4 scattering_p = GetInterpolatedScattering(atmosphere, scattering_texture, p.r, p.mu, p.mu_s, nu, ray_r_mu_intersects_ground);
	
	// Combine the lookup results to get the scattering between camera and point.
	DimensionlessSpectrum shadow_transmittance = transmittance;
	scattering = scattering - shadow_transmittance.rgbr * scattering_p;
	
	//return 0.5+0.5*p.mu;
	return scattering;
}


[numthreads(8, 8, 16)]
void ComputeSkyRadianceCS(uint3 dId: SV_DispatchThreadID)
{
	dId += threadIdOffset;
	const uint3 texSize = {SKY_RADIANCE_TEXTURE_NU_SIZE*SKY_RADIANCE_TEXTURE_DIST_SIZE, SKY_RADIANCE_TEXTURE_MU_SIZE, SKY_RADIANCE_TEXTURE_R_SIZE};
	if(any(dId>=texSize))
		return;
	
	float4 skyRadiance;
	
	uint width = 2;//ширина плосы для смешивания на горизонте, в пикселях
	float muWidth = blurWidth;
	
#if defined(LINEAR_MU) || defined(FLIP_MAPPING_MU)
	AtmosphereParameters atmosphere; initAtmosphereParameters(atmosphere);
	AtmPoint p0;
	p0.mu_s = NdotL;
	bool bIntersectGround;
	float nu, d;
	GetRMuDistNuFromResolvedScatteringIndexes(atmosphere, dId, p0.mu_s,		p0.r, p0.mu, d, nu, bIntersectGround);

	float h = p0.r - atmosphere.bottom_radius;
	float muH = -sqrt(h * (2*atmosphere.bottom_radius + h)) / p0.r;

	float nDist = d/paramDistMax;
	muWidth *= 0.05 + 0.95*pow(saturate(1 - nDist), 20);
	//muWidth *= 0.5 + 0.5*pow(saturate(1 - nDist), 20);
	
	//огриначиваем по длине луча до конца атмосферы
	 d = min(d,  bIntersectGround ?
				DistanceToBottomAtmosphereBoundary(atmosphere, p0.r, p0.mu) :
				DistanceToTopAtmosphereBoundary(atmosphere, p0.r, p0.mu));

	float mu0 = max(-1, muH-muWidth*0.8);
	float mu1 = min( 1, muH+muWidth);

	[branch]
	if(p0.mu>=mu0 && p0.mu < mu1)
	//if(0)
	{
		uint y0 = MuToParameter(atmosphere, mu0, p0.r, RayIntersectsGround(atmosphere, p0.r, mu0)) * (SKY_RADIANCE_TEXTURE_MU_SIZE-1);
		uint y1 = MuToParameter(atmosphere, mu1, p0.r, RayIntersectsGround(atmosphere, p0.r, mu1)) * (SKY_RADIANCE_TEXTURE_MU_SIZE-1)+0.5;

		mu0 = ParameterToMu(atmosphere, float(y0) / (SKY_RADIANCE_TEXTURE_MU_SIZE-1), p0.r);
		mu1 = ParameterToMu(atmosphere, float(y1) / (SKY_RADIANCE_TEXTURE_MU_SIZE-1), p0.r);

		float mu00 = mu0 - muWidth;
		float mu11 = mu1 + muWidth;
		uint y00 = MuToParameter(atmosphere, mu00, p0.r, RayIntersectsGround(atmosphere, p0.r, mu00)) * (SKY_RADIANCE_TEXTURE_MU_SIZE-1);
		uint y11 = MuToParameter(atmosphere, mu11, p0.r, RayIntersectsGround(atmosphere, p0.r, mu11)) * (SKY_RADIANCE_TEXTURE_MU_SIZE-1)+0.5;

	#if 1
		float4 scattering0  = ComputeSkyRadiancePixel(uint3(dId.x, y0,  dId.z));
		float4 scattering1  = ComputeSkyRadiancePixel(uint3(dId.x, y1,  dId.z));
		float4 scattering00 = ComputeSkyRadiancePixel(uint3(dId.x, y00, dId.z));
		float4 scattering11 = ComputeSkyRadiancePixel(uint3(dId.x, y11, dId.z));
	#else
		float3 tr;
		float4 scattering0  = GetSkyRadianceToPointTest(atmosphere, transmittanceTex, scatteringTex, scatteringTex, p0.r, mu0,  p0.mu_s, nu, d, tr);
		float4 scattering1  = GetSkyRadianceToPointTest(atmosphere, transmittanceTex, scatteringTex, scatteringTex, p0.r, mu1,  p0.mu_s, nu, d, tr);
		float4 scattering00 = GetSkyRadianceToPointTest(atmosphere, transmittanceTex, scatteringTex, scatteringTex, p0.r, mu00, p0.mu_s, nu, d, tr);
		float4 scattering11 = GetSkyRadianceToPointTest(atmosphere, transmittanceTex, scatteringTex, scatteringTex, p0.r, mu11, p0.mu_s, nu, d, tr);
	#endif

		float t = saturate((p0.mu - mu0) / (mu1 - mu0));
		// skyRadiance = lerp(scattering0, scattering1, t);
		// skyRadiance = lerp(scattering00, scattering11, t);
		skyRadiance = max(0, BezierCurve4(t, scattering0, 2*scattering0-scattering00, 2*scattering1-scattering11, scattering1));

		// skyRadiance = t;
		// skyRadiance = scattering0;
		// skyRadiance = scattering1;
		// skyRadiance = float4(1, 0, 0, 0);
	}
#else
	// if(dId.y < width  || dId.y >= SCATTERING_TEXTURE_MU_SIZE - width)
	if(0)
	{
		uint y0 = SKY_RADIANCE_TEXTURE_MU_SIZE - width - 1;
		uint y1 = width;
		float4 scattering0 = ComputeSkyRadiancePixel(uint3(dId.x, y0,   dId.z));
		float4 scattering1 = ComputeSkyRadiancePixel(uint3(dId.x, y1,   dId.z));
		
		uint t = (dId.y + width + 1) % SKY_RADIANCE_TEXTURE_MU_SIZE;
		float factor = float(t) / (width*2);
		factor = smoothstep(0, 1, factor);
		// skyRadiance = scattering0;
		// skyRadiance = gId.y == 0 ? float4(1,0,0,0) : float4(0,1,0,0);
		// skyRadiance = float(t)/(width*2.0);
		// skyRadiance = lerp(scattering0, scattering1, pow(factor,0.5));
		skyRadiance = lerp(scattering0, scattering1, pow(factor,1));
		// skyRadiance = lerp(scattering0, scattering1, 1-factor);
		// skyRadiance = factor;
		// skyRadiance = scattering0;
		// skyRadiance = scattering1;
	}
#endif
	else
	{
		float3 tr;
		// skyRadiance = GetSkyRadianceToPointTest(atmosphere, transmittanceTex, scatteringTex, scatteringTex, p0.r, p0.mu,  p0.mu_s, nu, d, tr);
		skyRadiance = ComputeSkyRadiancePixel(dId);
		// skyRadiance = dot(ComputeSkyRadiancePixel(dId), skyRadiance);
	}
	
#if defined(FLIP_MAPPING_MU) && !defined(LINEAR_MU)
	dId.y = (dId.y + SKY_RADIANCE_TEXTURE_MU_SIZE/2) % SKY_RADIANCE_TEXTURE_MU_SIZE;
#endif

	resolvedScattering[dId] = skyRadiance;
}

[numthreads(16, 1, 16)]
void BlurSkyRadianceHorizonCS(uint3 id: SV_DispatchThreadID)
{
	const uint3 texSize = {SKY_RADIANCE_TEXTURE_NU_SIZE*SKY_RADIANCE_TEXTURE_DIST_SIZE, SKY_RADIANCE_TEXTURE_MU_SIZE, SKY_RADIANCE_TEXTURE_R_SIZE};
	if(any(id.xz >= texSize))
		return;
	
	uint width = 4;//ширина плосы для смешивания на горизонте, в пикселях
	
	uint y0 = SKY_RADIANCE_TEXTURE_MU_SIZE/2 - width/2 - 1;
	uint y1 = SKY_RADIANCE_TEXTURE_MU_SIZE/2 + width/2;
	float4 scattering0 = scatteringTex[uint3(id.x, y0,   id.z)];
	float4 scattering1 = scatteringTex[uint3(id.x, y1,   id.z)];
	
	GroupMemoryBarrierWithGroupSync();
	
	float factor = 1.0 / (width+1.0);
	for(uint i=0; i<width; ++i)
		resolvedScattering[uint3(id.x, y0+i+1, id.z)] = scattering0; //lerp(scattering0, scattering1, i*factor);

	// pixels[0] = resolvedScattering[id];
	// resolvedScattering[uint3(id.x, id.y,   id.z)] = float4(10, 0, 0, 1);
	// resolvedScattering[uint3(id.x, id.y-1, id.z)] = float4(10, 0, 0, 1);
	// resolvedScattering[uint3(id.x, id.y+1, id.z)] = float4(10, 0, 0, 1);
}

BlendState addBlend2
{
	BlendEnable[0] = false;
	BlendEnable[1] = true;
	SrcBlend[1] = ONE;
	DestBlend[1] = ONE;
	BlendOp[1] = ADD;
	SrcBlendAlpha[1] = ONE;
	DestBlendAlpha[1] = ONE;
	BlendOpAlpha[1] = ADD;
	RenderTargetWriteMask[1] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

#define PASS_BODY(vs, gs, ps, blend) { \
	SetVertexShader(vs); \
	SetGeometryShader(gs); \
	SetPixelShader(CompileShader(ps_4_0, ps)); \
	SetDepthStencilState(disableDepthBuffer, 0); \
	SetBlendState(blend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
	SetRasterizerState(cullNone); }

VertexShader	vsComp		= CompileShader(vs_4_0, VS());
VertexShader	vsLayerComp = CompileShader(vs_4_0, VS_LAYER());
GeometryShader	gsComp		= CompileShader(gs_4_0, GS());

technique10 Precompute
{
	pass computeTransmittance		PASS_BODY(vsComp,		NULL,		ComputeTransmittancePS(),		disableAlphaBlend)
	pass computeTransmittance3D		PASS_BODY(vsLayerComp,	gsComp,		ComputeTransmittance3DPS(),		disableAlphaBlend)
	pass computeDirectIrradiance	PASS_BODY(vsComp,		NULL,		ComputeDirectIrradiancePS(),	disableAlphaBlend)
	pass computeSingleScattering	PASS_BODY(vsLayerComp,	gsComp,		ComputeSingleScatteringPS(),	disableAlphaBlend)
	pass computeScatteringDensity	PASS_BODY(vsLayerComp,	gsComp,		ComputeScatteringDensityPS(),	disableAlphaBlend)
	pass computeIndirectIrradinace	PASS_BODY(vsComp,		NULL,		ComputeIndirectIrradiancePS(),	addBlend2)
	pass computeMultipleScattering	PASS_BODY(vsLayerComp,	gsComp,		ComputeMultipleScatteringPS(),	addBlend2)
	pass resolveScattering			{	SetComputeShader(CompileShader(cs_5_0, ResolveScatteringCS()));		 }
	pass computeSkyRadiance			{	SetComputeShader(CompileShader(cs_5_0, ComputeSkyRadianceCS()));	 }
	pass blurSkyRadianceHorizon		{	SetComputeShader(CompileShader(cs_5_0, BlurSkyRadianceHorizonCS())); }
	pass writeMiePhaseFunctionLUT	PASS_BODY(vsComp,		NULL,		WriteMiePhaseFunctionPS(),		disableAlphaBlend)
}

#undef PASS_BODY
