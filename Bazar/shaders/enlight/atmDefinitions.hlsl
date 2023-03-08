#ifndef ATMOSPHERE_DEFINITIONS_HLSL
#define ATMOSPHERE_DEFINITIONS_HLSL
/**
 * Copyright (c) 2017 Eric Bruneton
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holders nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

/*<h2>atmosphere/definitions.glsl</h2>

<p>This GLSL file defines the physical types and constants which are used in the
main <a href="functions.glsl.html">functions</a> of our atmosphere model, in
such a way that they can be compiled by a GLSL compiler (a
<a href="reference/definitions.h.html">C++ equivalent</a> of this file
provides the same types and constants in C++, to allow the same functions to be
compiled by a C++ compiler - see the <a href="../index.html">Introduction</a>).

<h3>Physical quantities</h3>

<p>The physical quantities we need for our atmosphere model are
<a href="https://en.wikipedia.org/wiki/Radiometry">radiometric</a> and
<a href="https://en.wikipedia.org/wiki/Photometry_(optics)">photometric</a>
quantities. In GLSL we can't define custom numeric types to enforce the
homogeneity of expressions at compile time, so we define all the physical
quantities as <code>float</code>, with preprocessor macros (there is no
<code>typedef</code> in GLSL).

<p>We start with six base quantities: length, wavelength, angle, solid angle,
power and luminous power (wavelength is also a length, but we distinguish the
two for increased clarity).
*/

#ifndef GEOTERRAIN
#define NO_OUTER_SPACE
#endif
#define COMBINED_SCATTERING_TEXTURES

// #define TRANSMITTANCE_BETTER_MAPPING
#define TRANSMITTANCE_SRGB
// #define TRANSMITTANCE_VOLUME_TEXTURE //////
// #define TRANSMITTANCE_FIXED_STEPS
// #define INTEGRATE_TRANSMITTANCE_WHILE_COMPUTE_SCATTERING //or use transmittance LUT - less precise but faster

#define SINGLE_SCATTERING_ADAPTIVE_STEPS_COUNT
// #define SCATTERING_UNIFORM_SAMPLING

// #define TRANSMITTANCE_TEST_GROUND_BY_MU
// #define RESOLVED_SCATTERING


// #define SCATTERING_BETTER_R_MAPPING //криво пашет в GetRMuMuSNuFromScatteringTextureIndexes!!!!
// #define SCATTERING_BETTER_MU_MAPPING
// #define SCATTERING_BETTER_MU_S_MAPPING

#define SKY_RADIANCE_TEXTURE  ///!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// #define FLIP_MAPPING_MU
#define LINEAR_MU

// #define MIE_PHASE_FUNCTION_LUT
#define ENABLE_MIE_SCATTERING

#define heightHack 0.1


#define TRANSMITTANCE_SAMPLES			500
#define SINGLE_SCATTERING_SAMPLES		200
#define SCATTERING_DENSITY_SAMPLES		16 // result: N * (2*N)
#define MULTIPLE_SCATTERING_SAMPLES		100
#define INDIRECT_IRRADIANCE_SAMPLES		32 // result: N * (2*N)


#define TRANSMITTANCE_TEXTURE_WIDTH		(256)
#define TRANSMITTANCE_TEXTURE_HEIGHT	(64)
#define TRANSMITTANCE_TEXTURE_DEPTH		(64)

#define SCATTERING_TEXTURE_R_SIZE		(32)
#define SCATTERING_TEXTURE_MU_SIZE		(128)
#define SCATTERING_TEXTURE_MU_S_SIZE	(32)
#define SCATTERING_TEXTURE_NU_SIZE		8

#define SKY_RADIANCE_TEXTURE_R_SIZE		(32)
#define SKY_RADIANCE_TEXTURE_MU_SIZE	(128)
#define SKY_RADIANCE_TEXTURE_DIST_SIZE	(32*4)
#define SKY_RADIANCE_TEXTURE_NU_SIZE	8

#define IRRADIANCE_TEXTURE_WIDTH		64
#define IRRADIANCE_TEXTURE_HEIGHT		16

#define vec2 float2
#define vec3 float3
#define vec4 float4

#define SampleTexture2D(tex, uv)	tex.SampleLevel(gBilinearClampSampler, uv, 0)
#define SampleTexture3D(tex, uvw)	tex.SampleLevel(gTrilinearClampSampler, uvw, 0)

#define IN(x) in x
#define OUT(x) out x
#define TEMPLATE(x)
#define TEMPLATE_ARGUMENT(x)
#define assert(x)

#define Length			float
#define Wavelength		float
#define Angle			float
#define SolidAngle		float
// #define Power			float
#define LuminousPower	float

/*
<p>From this we "derive" the irradiance, radiance, spectral irradiance,
spectral radiance, luminance, etc, as well pure numbers, area, volume, etc (the
actual derivation is done in the <a href="reference/definitions.h.html">C++
equivalent</a> of this file).
*/

#define Number float
#define InverseLength float
#define Area float
#define Volume float
#define NumberDensity float
#define Irradiance float
#define Radiance float
#define SpectralPower float
#define SpectralIrradiance float
#define SpectralRadiance float
#define SpectralRadianceDensity float
#define ScatteringCoefficient float
#define InverseSolidAngle float
#define LuminousIntensity float
#define Luminance float
#define Illuminance float

/*
<p>We  also need vectors of physical quantities, mostly to represent functions
depending on the wavelength. In this case the vector elements correspond to
values of a function at some predefined wavelengths. Again, in GLSL we can't
define custom vector types to enforce the homogeneity of expressions at compile
time, so we define these vector types as <code>vec3</code>, with preprocessor
macros. The full definitions are given in the
<a href="reference/definitions.h.html">C++ equivalent</a> of this file).
*/

// A generic function from Wavelength to some other type.
#define AbstractSpectrum float3
// A function from Wavelength to Number.
#define DimensionlessSpectrum float3
// A function from Wavelength to SpectralPower.
#define PowerSpectrum float3
// A function from Wavelength to SpectralIrradiance.
#define IrradianceSpectrum float3
// A function from Wavelength to SpectralRadiance.
#define RadianceSpectrum float3
// A function from Wavelength to SpectralRadianceDensity.
#define RadianceDensitySpectrum float3
// A function from Wavelength to ScaterringCoefficient.
#define ScatteringSpectrum float3

// A position in 3D (3 length values).
#define ATMPosition float3
// A unit direction vector in 3D (3 unitless values).
#define Direction float3
// A vector of 3 luminance values.
#define Luminance3 float3
// A vector of 3 illuminance values.
#define Illuminance3 float3

/*
<p>Finally, we also need precomputed textures containing physical quantities in
each texel. Since we can't define custom sampler types to enforce the
homogeneity of expressions at compile time in GLSL, we define these texture
types as <code>sampler2D</code> and <code>sampler3D</code>, with preprocessor
macros. The full definitions are given in the
<a href="reference/definitions.h.html">C++ equivalent</a> of this file).
*/

#define TransmittanceTexture		Texture2D
#define TransmittanceTexture3D		Texture3D
#define AbstractScatteringTexture	Texture3D
#define ReducedScatteringTexture	Texture3D
#define ScatteringTexture			Texture3D
#define ScatteringDensityTexture	Texture3D
#define IrradianceTexture			Texture2D

/*
<h3>Physical units</h3>

<p>We can then define the units for our six base physical quantities:
meter (m), nanometer (nm), radian (rad), steradian (sr), watt (watt) and lumen
(lm):
*/

static const Length m = 1.0;
static const Wavelength nm = 1.0;
static const Angle rad = 1.0;
static const SolidAngle sr = 1.0;
static const float /*Power*/ watt = 1.0;
static const LuminousPower lm = 1.0;

/*
<p>From which we can derive the units for some derived physical quantities,
as well as some derived units (kilometer km, kilocandela kcd, degree deg):
*/

#ifndef atmPI
#define atmPI	3.141592653589793238462
#endif

static const Length km = 1000.0 * m;
static const Area m2 = m * m;
static const Volume m3 = m * m * m;
static const Angle pi = atmPI * rad;
static const Angle deg = pi / 180.0;
static const Irradiance watt_per_square_meter = watt / m2;
static const Radiance watt_per_square_meter_per_sr = watt / (m2 * sr);
static const SpectralIrradiance watt_per_square_meter_per_nm = watt / (m2 * nm);
static const SpectralRadiance watt_per_square_meter_per_sr_per_nm =
    watt / (m2 * sr * nm);
static const SpectralRadianceDensity watt_per_cubic_meter_per_sr_per_nm =
    watt / (m3 * sr * nm);
static const LuminousIntensity cd = lm / sr;
static const LuminousIntensity kcd = 1000.0 * cd;
static const Luminance cd_per_square_meter = cd / m2;
static const Luminance kcd_per_square_meter = kcd / m2;

/*
<h3>Atmosphere parameters</h3>

<p>Using the above types, we can now define the parameters of our atmosphere
model:
*/

// An atmosphere layer of width 'width', and whose density is defined as
//   'exp_term' * exp('exp_scale' * h) + 'linear_term' * h + 'constant_term',
// clamped to [0,1], and where h is the altitude.
struct DensityProfileLayer {
  Length width;
  Number exp_term;
  InverseLength exp_scale;
  InverseLength linear_term;
  Number constant_term;
};

// An atmosphere density profile made of several layers on top of each other
// (from bottom to top). The width of the last layer is ignored, i.e. it always
// extend to the top atmosphere boundary. The profile values vary between 0
// (null density) to 1 (maximum density).
struct DensityProfile {
  DensityProfileLayer layers[2];
};

struct AtmosphereParameters {
  // The solar irradiance at the top of the atmosphere.
  IrradianceSpectrum solar_irradiance;
  // The sun's angular radius.
  Angle sun_angular_radius;
  // The distance between the planet center and the bottom of the atmosphere.
  Length bottom_radius;
  // The distance between the planet center and the top of the atmosphere.
  Length top_radius;
  // The scale height of air molecules, meaning that their density is
  // proportional to exp(-h / rayleigh_scale_height), with h the altitude
  // (with the bottom of the atmosphere at altitude 0).
  Length rayleigh_scale_height;
  // The scattering coefficient of air molecules at the bottom of the
  // atmosphere, as a function of wavelength.
  ScatteringSpectrum rayleigh_scattering;
  // The scale height of aerosols, meaning that their density is proportional
  // to exp(-h / mie_scale_height), with h the altitude.
  Length mie_scale_height;
  // The scattering coefficient of aerosols at the bottom of the atmosphere,
  // as a function of wavelength.
  ScatteringSpectrum mie_scattering;
  // The extinction coefficient of aerosols at the bottom of the atmosphere,
  // as a function of wavelength.
  ScatteringSpectrum mie_extinction;
  // The asymetry parameter for the Cornette-Shanks phase function for the
  // aerosols.
  Number mie_phase_function_g;
  // The density profile of air molecules that absorb light (e.g. ozone), i.e.
  // a function from altitude to dimensionless values between 0 (null density)
  // and 1 (maximum density).
  DensityProfile absorption_density;
  // The extinction coefficient of molecules that absorb light (e.g. ozone) at
  // the altitude where their density is maximum, as a function of wavelength.
  // The extinction coefficient at altitude h is equal to
  // 'absorption_extinction' times 'absorption_density' at this altitude.
  ScatteringSpectrum absorption_extinction;
  Number absorption_factor;
  // The average albedo of the ground.
  DimensionlessSpectrum ground_albedo;
  // The cosine of the maximum Sun zenith angle for which atmospheric scattering
  // must be precomputed (for maximum precision, use the smallest Sun zenith
  // angle yielding negligible sky light radiance values. For instance, for the
  // Earth case, 102 degrees is a good choice - yielding mu_s_min = -0.2).
  
  ScatteringSpectrum scatteringToSingleMie;
  
  Number mu_s_min;  
};

void initAtmosphereParameters(inout AtmosphereParameters atmosphere)
{
	const float lenghtUnitsInMeter = 1000.0;
	
	atmosphere.solar_irradiance = 1.0;
	atmosphere.sun_angular_radius = 0.00935 / 2.0;
	atmosphere.bottom_radius = gEarthRadius;
	atmosphere.top_radius = amtTopRadius;
	atmosphere.rayleigh_scale_height = gAtmHR;
	atmosphere.rayleigh_scattering = gAtmBetaR;
	atmosphere.mie_scale_height = gAtmHM;
	atmosphere.mie_scattering = gAtmBetaMSca;
	atmosphere.mie_extinction = gAtmBetaMExt;
	atmosphere.mie_phase_function_g = gAtmMieG;
	atmosphere.ground_albedo = gAtmGroundReflectanceAvg;
	atmosphere.mu_s_min = -0.2;
	atmosphere.scatteringToSingleMie = gAtmScaToMie;
	
	//ozone:
	atmosphere.absorption_extinction = gAtmBetaAExt;
	atmosphere.absorption_factor = gAtmAbsorptionFactor;
	atmosphere.absorption_density.layers[0].width = 25000.0 / lenghtUnitsInMeter;
	atmosphere.absorption_density.layers[0].exp_term = 0;
	atmosphere.absorption_density.layers[0].exp_scale = 0;
	atmosphere.absorption_density.layers[0].linear_term = 1.0 / (15000.0 / lenghtUnitsInMeter);
	atmosphere.absorption_density.layers[0].constant_term = -2.0 / 3.0;	
	atmosphere.absorption_density.layers[1].width = 0;
	atmosphere.absorption_density.layers[1].exp_term = 0;
	atmosphere.absorption_density.layers[1].exp_scale = 0;
	atmosphere.absorption_density.layers[1].linear_term = -1.0 / (15000.0 / lenghtUnitsInMeter);
	atmosphere.absorption_density.layers[1].constant_term = 8.0 / 3.0;
}

static float atmNearDistance = 80.0;
static float atmFarDistance  = 120.0;

//TODO: выпилить
#define atmEarthCenter		gEarthCenter
#define atmSunDirection		gSunDir

float sqrtf(float v) { return v>0 ? sqrt(v) : 0; }

#endif
