#ifndef ATMOSPHERE_COMMON_H
#define ATMOSPHERE_COMMON_H

static const float ISun = 100.0;
#ifdef EDGE
SamplerState AtmSampler {
	Filter        = MIN_MAG_MIP_LINEAR;
	AddressU      = CLAMP;
	AddressV      = CLAMP;
	AddressW      = CLAMP;
};
#else
	#include "common/samplers11.hlsl"
	#define AtmSampler gTrilinearClampSampler
#endif

#define TRANSMITTANCE_NON_LINEAR
#define INSCATTER_NON_LINEAR

static float atmNearDistance = 80.0;
static float atmFarDistance  = 120.0;

static const float M_PI = 3.141592653589793238;

static const float Rg = 6360.0;
static const float Rt = 6420.0;
static const float RL = 6421.0;

static const float TRANSMITTANCE_W = 256;
static const float TRANSMITTANCE_H = 64;

static const float SKY_W = 64;
static const float SKY_H = 16;

static const float RES_R = 32;
static const float RES_MU = 128;
static const float RES_MU_S = 32;
static const float RES_NU = 8;

static const float Rg2 = Rg*Rg;
static const float Rt2 = Rt*Rt;
static const float RL2 = RL*RL;

static const float htR = 0.5 / RES_R;
static const float htMU = 0.5 / RES_MU;
static const float htMU_S = 0.5 / RES_MU_S;
static const float htNU = 0.5 / RES_NU;

//
#if !defined(CONTEXT_HLSL) //|| defined(EDGE)

static const float AVERAGE_GROUND_REFLECTANCE = 0.3;

static const float3 betaO = {0.320420e-4, 0.254078e-4, 0.242613e-4};

// Rayleigh
static const float HR = 8.0;//высота, на которой плотность молекул для рэлеевского рассеивания падает в ~3 раза - км
static const float3 betaR = float3(5.8e-3, 1.35e-2, 3.31e-2);

// Mie
// DEFAULT
static const float HM = 1.2;//высота, до которой плотность молекул одинаковая для аэрозольного рассеивания и абсорбации - км
static const float3 betaMSca = float3(4e-3, 4e-3, 4e-3); //scattering
static const float3 betaMEx = betaMSca / 0.9; //extinction
static const float mieG = 0.8;

#else
	#define AVERAGE_GROUND_REFLECTANCE	gAtmGroundReflectanceAvg
	// Rayleigh
	#define HR			gAtmHR
	#define betaR		gAtmBetaR
	#define betaRSca	gAtmBetaR
	// Mie
	#define HM			gAtmHM
	#define betaMSca	gAtmBetaMSca
	#define betaMEx		gAtmBetaMExt
	#define mieG		gAtmMieG

	#define atmSunDirection gSunDir
	#define atmEarthCenter  gEarthCenter
	#define atmExposure  	gExposure
#endif

float sqrtf(float v) {
	return v>0 ? sqrt(v) : 0;
}

float2 getTransmittanceUV(float r, float mu) {
    float uR, uMu;
#ifdef TRANSMITTANCE_NON_LINEAR
	uR = sqrtf((r - Rg) / (Rt - Rg));
	uMu = atan((mu + 0.15) / (1.0 + 0.15) * tan(1.5)) / 1.5;
#else
	uR = (r - Rg) / (Rt - Rg);
	uMu = (mu + 0.15) / (1.0 + 0.15);
#endif
    return float2(uMu, uR) - float2(0.5 / TRANSMITTANCE_W, 0.5 / TRANSMITTANCE_H);
}

void getTransmittanceRMu(float2 vPos, out float r, out float muS) {
    r = vPos.y / float(TRANSMITTANCE_H);
    muS = vPos.x / float(TRANSMITTANCE_W);
#ifdef TRANSMITTANCE_NON_LINEAR
    r = Rg + (r * r) * (Rt - Rg);
    muS = -0.15 + tan(1.5 * muS) / tan(1.5) * (1.0 + 0.15);
#else
    r = Rg + r * (Rt - Rg);
    muS = -0.15 + muS * (1.0 + 0.15);
#endif
}

float2 getIrradianceUV(float r, float muS) {
    float uR = (r - Rg) / (Rt - Rg);
    float uMuS = (muS + 0.2) / (1.0 + 0.2);
    return float2(uMuS, uR) - float2(0.5 / SKY_W, 0.5 / SKY_H);
}

void getIrradianceRMuS(float2 vPos, out float r, out float muS) {
    r = Rg + (vPos.y - 0.5) / (float(SKY_H) - 1.0) * (Rt - Rg);
    muS = -0.2 + (vPos.x - 0.5) / (float(SKY_W) - 1.0) * (1.0 + 0.2);
}

float4 texture4D(Texture3D table, float r, float mu, float muS, float nu)
{
    float H = sqrtf(Rt2 - Rg2);
    float rho = sqrtf(r * r - Rg2);
#ifdef INSCATTER_NON_LINEAR
    float rmu = r * mu;
    float delta = rmu * rmu - r * r + Rg2;
    float4 cst = rmu < 0.0 && delta > 0.0 ? float4(1, 0, 0, 0.5 - htMU) : float4(-1, H * H, H, 0.5 + htMU);
	float uR = htR + rho / H * (1.0 - 2.0 * htR);
    float uMu = cst.w + (rmu * cst.x + sqrtf(delta + cst.y)) / (rho + cst.z) * (0.5 - 2.0 * htMU);
    // paper formula
    //float uMuS = htMU_S + max((1.0 - exp(-3.0 * muS - 0.6)) / (1.0 - exp(-3.6)), 0.0) * (1.0 - 2.0 * htMU_S);
    // better formula
    float uMuS = htMU_S + (atan(max(muS, -0.1975) * tan(1.26 * 1.1)) / 1.1 + (1.0 - 0.26)) * 0.5 * (1.0 - 2.0*htMU_S);
#else
	float uR = htR + rho / H * (1.0 - 2.0 * htR);
    float uMu = htMU + (mu + 1.0) / 2.0 * (1.0 - 2.0 * htMU);
    float uMuS = htMU_S + max(muS + 0.2, 0.0) / 1.2 * (1.0 - 2.0 * htMU_S);
#endif
    float lrp = (nu + 1.0) / 2.0 * (float(RES_NU) - 1.0);
    float uNu = floor(lrp);
    lrp = lrp - uNu;

   return table.SampleLevel(AtmSampler, float3( (uNu + uMuS) / float(RES_NU), uMu, uR), 0 ) * (1.0 - lrp) +
           table.SampleLevel(AtmSampler, float3( (uNu + uMuS + 1.0) / float(RES_NU), uMu, uR), 0 ) * lrp;
}

// nearest intersection of ray r,mu with ground or top atmosphere boundary
// mu=cos(ray zenith angle at ray origin)
float limit(float r, float mu) {
    float dout = -r * mu + sqrtf(r * r * (mu * mu - 1.0) + RL2);
    float delta2 = r * r * (mu * mu - 1.0) + Rg2;
    if (delta2 >= 0.0) {
        float din = -r * mu - sqrtf(delta2);
        if (din >= 0.0) {
            dout = min(dout, din);
        }
    }
    return dout;
}

// optical depth for ray (r,mu) of length d, using analytic formula
// (mu=cos(view zenith angle)), intersections with ground ignoredHDR
// H=height scale of exponential density function
float opticalDepth(float H, float r, float mu, float d) {
    float a = sqrtf((0.5/H)*r);
    float2 a01 = a*float2(mu, mu + d / r);
    float2 a01s = sign(a01);
    float2 a01sq = a01*a01;
    float x = a01s.y > a01s.x ? min(1e30, exp(a01sq.x)) : 0.0;
    float2 y = a01s / (2.3193*abs(a01) + sqrt(1.52*a01sq + 4.0)) * float2(1.0, exp(-d/H*(d/(2.0*r)+mu)));
    return sqrtf((6.2831*H)*r) * exp((Rg-r)/H) * (x + dot(y, float2(1.0, -1.0)));
}

// transmittance(=transparency) of atmosphere for ray (r,mu) of length d
// (mu=cos(view zenith angle)), intersections with ground ignored
// uses analytic formula instead of transmittance texture
float3 analyticTransmittance(float r, float mu, float d) {
    return exp(- betaR * opticalDepth(HR, r, mu, d) - betaMEx * opticalDepth(HM, r, mu, d));
}

#if ANALYTIC_TRANSMITTANCE == 0

// transmittance(=transparency) of atmosphere for infinite ray (r,mu)
// (mu=cos(view zenith angle)), intersections with ground ignored
float3 transmittance(float r, float mu) {
	float2 uv = getTransmittanceUV(r, mu);
    return transmittanceTex.SampleLevel(AtmSampler, uv, 0).rgb;
}

// transmittance(=transparency) of atmosphere for infinite ray (r,mu)
// (mu=cos(view zenith angle)), or zero if ray intersects ground
float3 transmittanceWithShadow(float r, float mu) {
    return mu < -sqrtf(1.0 - (Rg / r) * (Rg / r)) ? float3(0.0, 0.0, 0.0) : transmittance(r, mu);
}

// transmittance(=transparency) of atmosphere between x and x0
// assume segment x,x0 not intersecting ground
// r=||x||, mu=cos(zenith angle of [x,x0) ray at x), v=unit direction vector of [x,x0) ray
float3 transmittance(float r, float mu, float3 v, float3 x0) {
    float3 result;
    float r1 = length(x0);
    float mu1 = dot(x0, v) / r;
    if (mu > 0.0) {
        result = min(transmittance(r, mu) / transmittance(r1, mu1), 1.0);
    } else {
        result = min(transmittance(r1, -mu1) / transmittance(r, -mu), 1.0);
    }
    return result;
}

// transmittance(=transparency) of atmosphere between x and x0
// assume segment x,x0 not intersecting ground
// d = distance between x and x0, mu=cos(zenith angle of [x,x0) ray at x)
float3 transmittance(float r, float mu, float d) {
    float3 result;
    float r1 = sqrtf(r * r + d * d + 2.0 * r * mu * d);
    float mu1 = (r * mu + d) / r1;
    if (mu > 0.0) {
        result = min(transmittance(r, mu) / transmittance(r1, mu1), 1.0);
    } else {
        result = min(transmittance(r1, -mu1) / transmittance(r, -mu), 1.0);
    }
    return result;
}
#endif

float mod(float x, float y) {
	return fmod(x, y);
}

void getMuMuSNu(float2 vPos, float r, float4 dhdH, out float mu, out float muS, out float nu) {
    float x = vPos.x - 0.5;
    float y = vPos.y - 0.5;
#ifdef INSCATTER_NON_LINEAR
    if (y < float(RES_MU) / 2.0) {
        float d = 1.0 - y / (float(RES_MU) / 2.0 - 1.0);
        d = min(max(dhdH.z, d * dhdH.w), dhdH.w * 0.999);
        mu = (Rg2 - r * r - d * d) / (2.0 * r * d);
        mu = min(mu, -sqrtf(1.0 - (Rg / r) * (Rg / r)) - 0.001);
    } else {
        float d = (y - float(RES_MU) / 2.0) / (float(RES_MU) / 2.0 - 1.0);
        d = min(max(dhdH.x, d * dhdH.y), dhdH.y * 0.999);
        mu = (Rt * Rt - r * r - d * d) / (2.0 * r * d);
    }
    muS = mod(x, float(RES_MU_S)) / (float(RES_MU_S) - 1.0);
    // paper formula
    //muS = -(0.6 + log(1.0 - muS * (1.0 -  exp(-3.6)))) / 3.0;
    // better formula
    muS = tan((2.0 * muS - 1.0 + 0.26) * 1.1) / tan(1.26 * 1.1);
    nu = -1.0 + floor(x / float(RES_MU_S)) / (float(RES_NU) - 1.0) * 2.0;
#else
    mu = -1.0 + 2.0 * y / (float(RES_MU) - 1.0);
    muS = mod(x, float(RES_MU_S)) / (float(RES_MU_S) - 1.0);
    muS = -0.2 + muS * 1.2;
    nu = -1.0 + floor(x / float(RES_MU_S)) / (float(RES_NU) - 1.0) * 2.0;
#endif
}

float3 irradiance(Texture2D tex, float r, float muS) {
    float2 uv = getIrradianceUV(r, muS);
    return tex.SampleLevel(AtmSampler, uv, 0).rgb;
}

// Rayleigh phase function
float phaseFunctionR(float nu) {
	return (3.0 / (16.0 * M_PI)) * (1.0 + nu * nu);
}

// Mie phase function
float phaseFunctionM(float nu) {
	return 1.5 * 1.0 / (4.0 * M_PI) * (1.0 - mieG*mieG) * pow( abs(1.0 + (mieG*mieG) - 2.0*mieG*nu), -3.0/2.0) * (1.0 +nu * nu) / (2.0 + mieG*mieG);
}

// approximated single Mie scattering (cf. approximate Cm in paragraph "Angular precision")
float3 getMie(float4 rayMie) { // rayMie.rgb=C*, rayMie.w=Cm,r
	return rayMie.rgb * rayMie.w / max(rayMie.r, 1e-4) * (betaR.r / betaR);

  // return scattering.rgb * scattering.a / scattering.r *
	    // (atmosphere.rayleigh_scattering.r / atmosphere.mie_scattering.r) *
	    // (atmosphere.mie_scattering / atmosphere.rayleigh_scattering);
}

float3 HDR(float3 L) {
	L = L * atmExposure;
	L = L < 1.413 ? pow(abs(L) * 0.38317, 1.0 / 2.2) : 1.0 - exp(-L);
	return L;
}

#endif

