#ifdef USE_EDGE_OLD_DCS_FORWARD	// deprecated mode
float3 atmEarthCenter;			//	camera position in planet space, kilometers (center of planet as origin)
float3 atmSunDirection;			//	sun direction
float atmExposure;
#endif

Texture2D transmittanceTex;

#include "common/context.hlsl"
#include "common/states11.hlsl"

#include "atmCommon.hlsl"

//#define USE_OZONE
Texture2D deltaETex;	//irradiance tex
Texture3D deltaSRTex;	//delta scattering rayleigh
Texture3D deltaSMTex;	//delta scattering mie
Texture3D deltaJTex;	//scattering density
Texture3D deltaMultipleScatteringTex; // delta multiple scattering ( = delta scattering rayleigh )

float r;
float4 dhdH;
uint layer;
uint first;
uint scatteringOrder;

static const uint TRANSMITTANCE_INTEGRAL_SAMPLES = 1000;
static const uint INSCATTER_INTEGRAL_SAMPLES = 50;
static const uint IRRADIANCE_INTEGRAL_SAMPLES = 32;
static const uint INSCATTER_SPHERICAL_INTEGRAL_SAMPLES = 16;


#define FOG_SCATTERING

static const float3 betaFogSca = float3(4e-3f,4e-3f,4e-3f);
static const float3 betaFogEx = betaFogSca / 1.5;

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
	float4 pos:			SV_POSITION0;
	uint   layer:		SV_RenderTargetArrayIndex;
};

[maxvertexcount(4)]
void GS(point uint i[1]: TEXCOORD0, inout TriangleStream<GS_OUTPUT> outputStream) {
	GS_OUTPUT o;
	[unroll]
	for(int j=0; j<4; ++j) {
		o.layer = layer;
		o.pos = float4(verts[j], 0, 1);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float getDensityR(float height)
{
	return exp(-(height - Rg) / HR);
}

float getDensityMie(float height)
{
	return exp(-(height - Rg) / HM);
}

float getDensityOzone(float height)
{
	return getDensityR(height) * 6.0e-5;
	// return getDensityR(height);
	//пик на 25км, значение 1
	// return 0.5 / (pow((abs((height-Rg)*0.1)-2.5), 2) + 0.5)*200;
}

float getDensityR2(float height)
{
	return exp(-(height - Rg) / HR);
}

float getDensityMie2(float height)
{
	return exp(-(height - Rg) / HM);
}

float getDensityFog(float height)
{
#ifdef FOG_SCATTERING
	const float fogHeightMin = 0.10;//km
	const float fogHeightMax = 1.00;//km
	float density = saturate(1.0 - (height - Rg - fogHeightMin) / (fogHeightMax - fogHeightMin));
	return density * 0.0001;
#else
	return 0;
#endif
}

//проинтегрировать шаг и сохранить состояние
void addIntegralStep(float cur, inout float prev, inout float total, float dx)
{
	total += (cur + prev) * 0.5 * dx;
	prev = cur;
}

void addIntegralStep3(float3 cur, inout float3 prev, inout float3 total, float dx)
{
	total += (cur + prev) * 0.5 * dx;
	prev = cur;
}

float opticalDepth(float H, float r, float mu) {
    float result = 0.0;
    float dx = limit(r, mu) / float(TRANSMITTANCE_INTEGRAL_SAMPLES);
    float xi = 0.0;
    float yi = exp(-(r - Rg) / H);
    for (float i = 1.0; i <= float(TRANSMITTANCE_INTEGRAL_SAMPLES); i += 1.0) {
        float xj = i * dx;
		float height = sqrt(r * r + xj * xj + 2.0 * xj * r * mu);
        float yj = exp(-(height - Rg) / H);
        result += (yi + yj) * 0.5 * dx;
        xi = xj;
        yi = yj;
    }
    return mu < -sqrt(1.0 - (Rg / r) * (Rg / r)) ? 1e9 : result;
}


void integrand(float r, float mu, float muS, float nu, float t, out float3 ray, out float3 mie, out float3 fogMie)
{
    ray = mie = fogMie = 0;
    float ri = sqrt(r * r + t * t + 2.0 * r * mu * t);
    float muSi = (nu * t + muS * r) / ri;
    ri = max(Rg, ri);
    if (muSi >= -sqrt(1.0 - Rg2 / (ri * ri)))
	{
        float3 ti = transmittance(r, mu, t) * transmittance(ri, muSi);
        ray = getDensityR(ri) * ti;
        mie = getDensityMie(ri) * ti;
		// fogMie = getDensityFog(ri) * ti;
    }
}

void inscatter(float r, float mu, float muS, float nu, out float3 ray, out float3 mie) {
    ray = 0;
    mie = 0;
    float dx = limit(r, mu) / float(INSCATTER_INTEGRAL_SAMPLES);
    float3 rayi, rayj;
    float3 miei, miej;
    float3 fogi, fogj;
	// float3 fogDensity = 0;
    integrand(r, mu, muS, nu, 0.0, rayi, miei, fogi);
    for (float i = 1.0; i <= float(INSCATTER_INTEGRAL_SAMPLES); i += 1.0)
	{
        float xj = i * dx;
        integrand(r, mu, muS, nu, xj, rayj, miej, fogj);
		
		addIntegralStep3(rayj, rayi, ray, dx);
		addIntegralStep3(miej, miei, mie, dx);
		// addIntegralStep3(fogj, fogi, fogDensity, dx);
    }
    ray *= betaR;
    mie *= betaMSca;
	// mie = betaMSca * mie;// + betaFogSca * fogDensity;
}

void inscatterS(float r, float mu, float muS, float nu, out float3 raymie)
{
	const float dphi = M_PI / float(INSCATTER_SPHERICAL_INTEGRAL_SAMPLES);
	const float dtheta = M_PI / float(INSCATTER_SPHERICAL_INTEGRAL_SAMPLES);

    r = clamp(r, Rg, Rt);
    mu = clamp(mu, -1.0, 1.0);
    muS = clamp(muS, -1.0, 1.0);
    float var = sqrt(1.0 - mu * mu) * sqrt(1.0 - muS * muS);
    nu = clamp(nu, muS * mu - var, muS * mu + var);

    float cthetamin = -sqrt(1.0 - (Rg / r) * (Rg / r));

    float3 v = float3(sqrt(1.0 - mu * mu), 0.0, mu);
    float sx = v.x == 0.0 ? 0.0 : (nu - muS * mu) / v.x;
    float3 s = float3(sx, sqrt(max(0.0, 1.0 - sx * sx - muS * muS)), muS);

    raymie = float3(0.0, 0.0, 0.0);

    // integral over 4.PI around x with two nested loops over w directions (theta,phi) -- Eq (7)
    for (uint itheta = 0; itheta < INSCATTER_SPHERICAL_INTEGRAL_SAMPLES; ++itheta)
	{
        float theta = (float(itheta) + 0.5) * dtheta;
        float ctheta = cos(theta);

        float greflectance = 0.0;
        float dground = 0.0;
        float3 gtransp = float3(0.0, 0.0, 0.0);
        if (ctheta < cthetamin) { // if ground visible in direction w
            // compute transparency gtransp between x and ground
            greflectance = AVERAGE_GROUND_REFLECTANCE / M_PI;
            dground = -r * ctheta - sqrt(r * r * (ctheta * ctheta - 1.0) + Rg * Rg);
            gtransp = transmittance(Rg, -(r * ctheta + dground) / Rg, dground);
        }

        for (float iphi = 0.0; iphi < 2.0 * float(INSCATTER_SPHERICAL_INTEGRAL_SAMPLES); iphi += 1.0)
		{
            float phi = (float(iphi) + 0.5) * dphi;
            float dw = dtheta * dphi * sin(theta);
            float3 w = float3(cos(phi) * sin(theta), sin(phi) * sin(theta), ctheta);

            float nu1 = dot(s, w);
            float nu2 = dot(v, w);
            float pr2 = phaseFunctionR(nu2);
            float pm2 = phaseFunctionM(nu2);

            // compute irradiance received at ground in direction w (if ground visible) =deltaE
            float3 gnormal = (float3(0.0, 0.0, r) + dground * w) / Rg;
            float3 girradiance = irradiance(deltaETex, Rg, dot(gnormal, s));

            float3 raymie1; // light arriving at x from direction w

            // first term = light reflected from the ground and attenuated before reaching x, =T.alpha/PI.deltaE
            raymie1 = greflectance * girradiance * gtransp;

            // second term = inscattered light, =deltaS
            if (first == 1) {
                // first iteration is special because Rayleigh and Mie were stored separately,
                // without the phase functions factors; they must be reintroduced here
                float pr1 = phaseFunctionR(nu1);
                float pm1 = phaseFunctionM(nu1);
                float3 ray1 = texture4D(deltaSRTex, r, w.z, muS, nu1).rgb;
                float3 mie1 = texture4D(deltaSMTex, r, w.z, muS, nu1).rgb;
                raymie1 += ray1 * pr1 + mie1 * pm1;
            } else {
                raymie1 += texture4D(deltaSRTex, r, w.z, muS, nu1).rgb;
            }

            // light coming from direction w and scattered in direction v
            // = light arriving at x from direction w (raymie1) * SUM(scattering coefficient * phaseFunction)
            // see Eq (7)
            raymie += raymie1 * (betaR * getDensityR(r) * pr2 + (betaMSca * getDensityMie(r) + betaFogSca * getDensityFog(r)) * pm2) * dw;
        }
    }

    // output raymie = J[T.alpha/PI.deltaE + deltaS] (line 7 in algorithm 4.1)
}

float3 integrand(float r, float mu, float muS, float nu, float t) {
    float ri = sqrt(r * r + t * t + 2.0 * r * mu * t);
    float mui = (r * mu + t) / ri;
    float muSi = (nu * t + muS * r) / ri;
    return texture4D(deltaJTex, ri, mui, muSi, nu).rgb * transmittance(r, mu, t);
}

float3 inscatterN(float r, float mu, float muS, float nu) {
    float3 raymie = float3(0.0, 0.0, 0.0);
    float dx = limit(r, mu) / float(INSCATTER_INTEGRAL_SAMPLES);
    float3 raymiei = integrand(r, mu, muS, nu, 0.0);
    for (uint i = 1; i <= INSCATTER_INTEGRAL_SAMPLES; ++i) {
        float xj = float(i) * dx;
        float3 raymiej = integrand(r, mu, muS, nu, xj);
        raymie += (raymiei + raymiej) / 2.0 * dx;
        raymiei = raymiej;
    }
    return raymie;
}

float4 TransmittancePS(float4 vPos: SV_POSITION): SV_TARGET0
{ 
    float r, mu;
    getTransmittanceRMu(vPos.xy, r, mu);
#ifdef USE_OZONE
	// if(mu < -sqrt(1.0 - (Rg / r) * (Rg / r)))
		// return 0.0;
	float dx = distanceToTopAtmosphereBoundary(r, mu) / float(TRANSMITTANCE_INTEGRAL_SAMPLES);

	float totalDensityMie   = 0.0;
	float totalDensityR     = 0.0;
	float totalDensityOzone = 0.0;
	float totalDensityFog	= 0.0;
	float prevDensityMie   = getDensityMie(r);
	float prevDensityR     = getDensityR(r);
	float prevDensityOzone = getDensityOzone(r);
	float prevDensityFog   = getDensityFog(r);
	float r2 = r*r;
	float rMu2 = 2.0 * r * mu;
	for(float i = 1.0; i <= float(TRANSMITTANCE_INTEGRAL_SAMPLES); i += 1.0)
	{
		float x = i * dx;
		float ri = sqrt(r2 + x * x + x * rMu2);
		
		addIntegralStep(getDensityMie(ri), 	prevDensityMie, 	totalDensityMie, 	dx);
		addIntegralStep(getDensityR(ri), 	prevDensityR, 		totalDensityR, 		dx);
		addIntegralStep(getDensityOzone(ri),prevDensityOzone, 	totalDensityOzone, 	dx);
		addIntegralStep(getDensityFog(ri), 	prevDensityFog, 	totalDensityFog, 	dx);
	}
	
	float3 depth = betaR * totalDensityR + betaMEx * totalDensityMie + betaFogEx * totalDensityFog + betaO * totalDensityOzone*0;
#else
	float3 depth = betaR * opticalDepth(HR, r, mu) + betaMEx * opticalDepth(HM, r, mu);
#endif

	return float4(exp(-depth), 0.0); // Eq (5)
}

float4 Irradiance1PS(float4 vPos: SV_POSITION): SV_TARGET0 { 
    float r, muS;
    getIrradianceRMuS(vPos.xy, r, muS);
    return float4(transmittance(r, muS) * max(muS, 0.0), 0.0);
}

struct PS_OUTPUT
{
    float4 color0	: SV_TARGET0; 
    float4 color1	: SV_TARGET1; 
};

PS_OUTPUT SingleScatteringPS(float4 vPos: SV_POSITION) {
    float3 ray;
    float3 mie;
    float mu, muS, nu;
    getMuMuSNu(vPos.xy, r, dhdH, mu, muS, nu);
    inscatter(r, mu, muS, nu, ray, mie);
    // store separately Rayleigh and Mie contributions, WITHOUT the phase function factor
    // (cf "Angular precision")
	PS_OUTPUT o;
	o.color0 = float4(ray, 1.0);
	o.color1 = float4(mie, 1.0);
	return o;
}

float4 CopyIrradiancePS(float4 vPos: SV_POSITION): SV_TARGET0 { 
    float2 uv = vPos.xy / float2(SKY_W, SKY_H);
    return deltaETex.Sample(AtmSampler, uv); 
}

float4 CopyInscatter1PS(float4 vPos: SV_POSITION): SV_TARGET0 { 
    float3 uvw = float3(vPos.xy, float(layer)) / float3(RES_MU_S * RES_NU, RES_MU, RES_R);
    float4 ray = deltaSRTex.Sample(AtmSampler, uvw);
    float4 mie = deltaSMTex.Sample(AtmSampler, uvw);
    return float4(ray.rgb, mie.r); // store only red component of single Mie scattering (cf. "Angular precision")
}

float4 InscatterSPS(float4 vPos: SV_POSITION): SV_TARGET0 { 
    float3 raymie;
    float mu, muS, nu;
    getMuMuSNu(vPos.xy, r, dhdH, mu, muS, nu);
    inscatterS(r, mu, muS, nu, raymie);
    return float4(raymie, 0.0);
}

float4 IrradianceNPS(float4 vPos: SV_POSITION): SV_TARGET0 { 

	const float dphi = M_PI / float(IRRADIANCE_INTEGRAL_SAMPLES);
	const float dtheta = M_PI / float(IRRADIANCE_INTEGRAL_SAMPLES);

    float r, muS;
    getIrradianceRMuS(vPos.xy, r, muS);

    float3 s = float3(max(sqrt(1.0 - muS * muS), 0.0), 0.0, muS);

    float3 result = float3(0.0, 0.0, 0.0);
    // integral over 2.PI around x with two nested loops over w directions (theta,phi) -- Eq (15)
    for (uint iphi = 0; iphi < 2 * IRRADIANCE_INTEGRAL_SAMPLES; ++iphi) {
        float phi = (float(iphi) + 0.5) * dphi;
        for (uint itheta = 0; itheta < IRRADIANCE_INTEGRAL_SAMPLES / 2; ++itheta) {
            float theta = (float(itheta) + 0.5) * dtheta;
            float dw = dtheta * dphi * sin(theta);
            float3 w = float3(cos(phi) * sin(theta), sin(phi) * sin(theta), cos(theta));
            float nu = dot(s, w);
            if (first == 1) {
                // first iteration is special because Rayleigh and Mie were stored separately,
                // without the phase functions factors; they must be reintroduced here
                float pr1 = phaseFunctionR(nu);
                float pm1 = phaseFunctionM(nu);
                float3 ray1 = texture4D(deltaSRTex, r, w.z, muS, nu).rgb;
                float3 mie1 = texture4D(deltaSMTex, r, w.z, muS, nu).rgb;
                result += (ray1 * pr1 + mie1 * pm1) * w.z * dw;
            } else {
                result += texture4D(deltaSRTex, r, w.z, muS, nu).rgb * w.z * dw;
            }
        }
    }

    return float4(result, 0.0);
}

float4 InscatterNPS(float4 vPos: SV_POSITION): SV_TARGET0 { 
    float mu, muS, nu;
    getMuMuSNu(vPos.xy, r, dhdH, mu, muS, nu);
    return float4(inscatterN(r, mu, muS, nu), 0.0);
}

float4 CopyInscatterNPS(float4 vPos: SV_POSITION): SV_TARGET0 { 
    float mu, muS, nu;
    getMuMuSNu(vPos.xy, r, dhdH, mu, muS, nu);
    float3 uvw = float3(vPos.xy, float(layer)) / float3(RES_MU_S * RES_NU, RES_MU, RES_R);
	float3 result = deltaSRTex.Sample(AtmSampler, uvw).rgb / phaseFunctionR(nu);
    return any(isnan(result)) ? float4(0,0,0,0) : float4(result, 0.0);
}

BlendState addBlend {
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = ONE;
	DestBlend = ONE;
	BlendOp = ADD;
	SrcBlendAlpha = ONE;
	DestBlendAlpha = ONE;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

// computes transmittance table T using Eq (5)
technique10 Transmittance
{
    pass P0
    {      
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, TransmittancePS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
    }
}

// computes ground irradiance due to direct sunlight E[L0] (line 2 in algorithm 4.1)
technique10 Irradiance1
{
    pass P0
    {          
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, Irradiance1PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
    }
}

// computes single scattering (line 3 in algorithm 4.1)
technique10 Inscatter1
{
    pass P0
    {          
		SetVertexShader(CompileShader(vs_4_0, VS_LAYER()));
		SetGeometryShader(CompileShader(gs_4_0, GS()));
		SetPixelShader(CompileShader(ps_4_0, SingleScatteringPS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
    }
}

technique10 CopyIrradianceAdd
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, CopyIrradiancePS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(addBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
    }
}

// copies deltaS into S (line 5 in algorithm 4.1)
technique10 CopyInscatter1
{
    pass P0
    {          
		SetVertexShader(CompileShader(vs_4_0, VS_LAYER()));
		SetGeometryShader(CompileShader(gs_4_0, GS()));
		SetPixelShader(CompileShader(ps_4_0, CopyInscatter1PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);     
    }
}

// computes deltaJ (line 7 in algorithm 4.1)
technique10 InscatterS
{
    pass P0
    {       
		SetVertexShader(CompileShader(vs_4_0, VS_LAYER()));
		SetGeometryShader(CompileShader(gs_4_0, GS()));
		SetPixelShader(CompileShader(ps_4_0, InscatterSPS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);     
    }
}

// computes ground irradiance due to skylight E[deltaS] (line 8 in algorithm 4.1)
technique10 IrradianceN
{
    pass P0
    {          
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, IrradianceNPS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);     
    }
}

// computes higher order scattering (line 9 in algorithm 4.1)
technique10 InscatterN
{
    pass P0
    {          
		SetVertexShader(CompileShader(vs_4_0, VS_LAYER()));
		SetGeometryShader(CompileShader(gs_4_0, GS()));
		SetPixelShader(CompileShader(ps_4_0, InscatterNPS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);     
    }
}

// adds deltaS into S (line 11 in algorithm 4.1)
technique10 CopyInscatterN
{
    pass P0
    {          
		SetVertexShader(CompileShader(vs_4_0, VS_LAYER()));
		SetGeometryShader(CompileShader(gs_4_0, GS()));
		SetPixelShader(CompileShader(ps_4_0, CopyInscatterNPS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(addBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);     
    }
}


