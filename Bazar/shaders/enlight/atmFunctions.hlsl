#ifndef ATMOSPHERE_FUNCTIONS_HLSL
#define ATMOSPHERE_FUNCTIONS_HLSL
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
 *
 * Precomputed Atmospheric Scattering
 * Copyright (c) 2008 INRIA
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

/*<h2>atmosphere/functions.glsl</h2>

<p>This GLSL file contains the core functions that implement our atmosphere
model. It provides functions to compute the transmittance, the single scattering
and the second and higher orders of scattering, the ground irradiance, as well
as functions to store these in textures and to read them back. It uses physical
types and constants which are provided in two versions: a
<a href="definitions.glsl.html">GLSL version</a> and a
<a href="reference/definitions.h.html">C++ version</a>. This allows this file to
be compiled either with a GLSL compiler or with a C++ compiler (see the
<a href="../index.html">Introduction</a>).

<p>The functions provided in this file are organized as follows:
<ul>
<li><a href="#transmittance">Transmittance</a>
<ul>
<li><a href="#transmittance_computation">Computation</a></li>
<li><a href="#transmittance_precomputation">Precomputation</a></li>
<li><a href="#transmittance_lookup">Lookup</a></li>
</ul>
</li>
<li><a href="#single_scattering">Single scattering</a>
<ul>
<li><a href="#single_scattering_computation">Computation</a></li>
<li><a href="#single_scattering_precomputation">Precomputation</a></li>
<li><a href="#single_scattering_lookup">Lookup</a></li>
</ul>
</li>
<li><a href="#multiple_scattering">Multiple scattering</a>
<ul>
<li><a href="#multiple_scattering_computation">Computation</a></li>
<li><a href="#multiple_scattering_precomputation">Precomputation</a></li>
<li><a href="#multiple_scattering_lookup">Lookup</a></li>
</ul>
</li>
<li><a href="#irradiance">Ground irradiance</a>
<ul>
<li><a href="#irradiance_computation">Computation</a></li>
<li><a href="#irradiance_precomputation">Precomputation</a></li>
<li><a href="#irradiance_lookup">Lookup</a></li>
</ul>
</li>
<li><a href="#rendering">Rendering</a>
<ul>
<li><a href="#rendering_sky">Sky</a></li>
<li><a href="#rendering_aerial_perspective">Aerial perspective</a></li>
<li><a href="#rendering_ground">Ground</a></li>
</ul>
</li>
</ul>

<p>They use the following utility functions to avoid NaNs due to floating point
values slightly outside their theoretical bounds:
*/

Number GetLayerDensity(IN(DensityProfileLayer) layer, Length altitude) {
  Number density = layer.exp_term * exp(layer.exp_scale * altitude) +
      layer.linear_term * altitude + layer.constant_term;
  return saturate(density);
}

Number GetProfileDensity(IN(DensityProfile) profile, Length altitude) {
  return altitude < profile.layers[0].width ?
      GetLayerDensity(profile.layers[0], altitude) :
      GetLayerDensity(profile.layers[1], altitude);
}

#ifndef GetDensityRayleigh
float GetDensityRayleigh(AtmosphereParameters atmosphere, Length r)
{
	return exp(-(r - atmosphere.bottom_radius) / atmosphere.rayleigh_scale_height);
}
#endif

#ifndef GetDensityMie
float GetDensityMie(AtmosphereParameters atmosphere, Length r)
{
	return exp(-(r - atmosphere.bottom_radius) / atmosphere.mie_scale_height);
}

float GetDensityMie(AtmosphereParameters atmosphere, Length r, Length dist)
{
	float distFactor = min(1, dist / 10.0);
	return exp(-(r - atmosphere.bottom_radius) / (atmosphere.mie_scale_height * (1 + 4*distFactor) ));
}
#endif

#ifndef GetDensityAbsorption
float GetDensityAbsorption(AtmosphereParameters atmosphere, Length r)
{
	return GetProfileDensity(atmosphere.absorption_density, r - atmosphere.bottom_radius) * atmosphere.absorption_factor;
	// return exp(-(r - atmosphere.bottom_radius) / atmosphere.mie_scale_height);
}
#endif
 

Number ClampCosine(Number mu) {
  return clamp(mu, Number(-1.0), Number(1.0));
}

Length ClampDistance(Length d) {
  return max(d, 0.0 * m);
}

Length ClampRadius(IN(AtmosphereParameters) atmosphere, Length r) {
  return clamp(r, atmosphere.bottom_radius, atmosphere.top_radius);
}

Length SafeSqrt(Area a) {
  return sqrt(max(a, 0.0 * m2));
}

/*
<h3 id="transmittance">Transmittance</h3>

<p>As the light travels from a point $\bp$ to a point $\bq$ in the atmosphere,
it is partially absorbed and scattered out of its initial direction because of
the air molecules and the aerosol particles. Thus, the light arriving at $\bq$
is only a fraction of the light from $\bp$, and this fraction, which depends on
wavelength, is called the
<a href="https://en.wikipedia.org/wiki/Transmittance">transmittance</a>. The
following sections describe how we compute it, how we store it in a precomputed
texture, and how we read it back.

<h4 id="transmittance_computation">Computation</h4>

<p>For 3 aligned points $\bp$, $\bq$ and $\br$ inside the atmosphere, in this
order, the transmittance between $\bp$ and $\br$ is the product of the
transmittance between $\bp$ and $\bq$ and between $\bq$ and $\br$. In
particular, the transmittance between $\bp$ and $\bq$ is the transmittance
between $\bp$ and the nearest intersection $\bi$ of the half-line $[\bp,\bq)$
with the top or bottom atmosphere boundary, divided by the transmittance between
$\bq$ and $\bi$ (or 0 if the segment $[\bp,\bq]$ intersects the ground):

<svg width="340px" height="195px">
  <style type="text/css"><![CDATA[
    circle { fill: #000000; stroke: none; }
    path { fill: none; stroke: #000000; }
    text { font-size: 16px; font-style: normal; font-family: Sans; }
    .vector { font-weight: bold; }
  ]]></style>
  <path d="m 0,26 a 600,600 0 0 1 340,0"/>
  <path d="m 0,110 a 520,520 0 0 1 340,0"/>
  <path d="m 170,190 0,-30"/>
  <path d="m 170,140 0,-130"/>
  <path d="m 170,50 165,-33"/>
  <path d="m 155,150 10,-10 10,10 10,-10"/>
  <path d="m 155,160 10,-10 10,10 10,-10"/>
  <path d="m 95,50 30,0"/>
  <path d="m 95,190 30,0"/>
  <path d="m 105,50 0,140" style="stroke-dasharray:8,2;"/>
  <path d="m 100,55 5,-5 5,5"/>
  <path d="m 100,185 5,5 5,-5"/>
  <path d="m 170,25 a 25,25 0 0 1 25,20" style="stroke-dasharray:4,2;"/>
  <path d="m 170,190 70,0"/>
  <path d="m 235,185 5,5 -5,5"/>
  <path d="m 165,125 5,-5 5,5"/>
  <circle cx="170" cy="190" r="2.5"/>
  <circle cx="170" cy="50" r="2.5"/>
  <circle cx="320" cy="20" r="2.5"/>
  <circle cx="270" cy="30" r="2.5"/>
  <text x="155" y="45" class="vector">p</text>
  <text x="265" y="45" class="vector">q</text>
  <text x="320" y="15" class="vector">i</text>
  <text x="175" y="185" class="vector">o</text>
  <text x="90" y="125">r</text>
  <text x="185" y="25">μ=cos(θ)</text>
  <text x="240" y="185">x</text>
  <text x="155" y="120">z</text>
</svg>

<p>Also, the transmittance between $\bp$ and $\bq$ and between $\bq$ and $\bp$
are the same. Thus, to compute the transmittance between arbitrary points, it
is sufficient to know the transmittance between a point $\bp$ in the atmosphere,
and points $\bi$ on the top atmosphere boundary. This transmittance depends on
only two parameters, which can be taken as the radius $r=\Vert\bo\bp\Vert$ and
the cosine of the "view zenith angle",
$\mu=\bo\bp\cdot\bp\bi/\Vert\bo\bp\Vert\Vert\bp\bi\Vert$. To compute it, we
first need to compute the length $\Vert\bp\bi\Vert$, and we need to know when
the segment $[\bp,\bi]$ intersects the ground.

<h5>Distance to the top atmosphere boundary</h5>

<p>A point at distance $d$ from $\bp$ along $[\bp,\bi)$ has coordinates
$[d\sqrt{1-\mu^2}, r+d\mu]^\top$, whose squared norm is $d^2+2r\mu d+r^2$.
Thus, by definition of $\bi$, we have
$\Vert\bp\bi\Vert^2+2r\mu\Vert\bp\bi\Vert+r^2=r_{\mathrm{top}}^2$,
from which we deduce the length $\Vert\bp\bi\Vert$:
*/

Length DistanceToTopAtmosphereBoundary(IN(AtmosphereParameters) atmosphere,
    Length r, Number mu) {
  assert(r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  Area discriminant = r * r * (mu * mu - 1.0) +
      atmosphere.top_radius * atmosphere.top_radius;
  return ClampDistance(-r * mu + SafeSqrt(discriminant));
}


Length DistanceFromHeightToHorizon(IN(AtmosphereParameters) atmosphere, Length r)
{
	return SafeSqrt(r * r - atmosphere.bottom_radius * atmosphere.bottom_radius);
}

/*
<p>We will also need, in the other sections, the distance to the bottom
atmosphere boundary, which can be computed in a similar way (this code assumes
that $[\bp,\bi)$ intersects the ground):
*/

Length DistanceToBottomAtmosphereBoundary(IN(AtmosphereParameters) atmosphere,
    Length r, Number mu) {
  assert(r >= atmosphere.bottom_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  Area discriminant = r * r * (mu * mu - 1.0) +
      atmosphere.bottom_radius * atmosphere.bottom_radius;
  return ClampDistance(-r * mu - SafeSqrt(discriminant));
}

// Distance to top atmosphere boundary for a horizontal ray at ground level.
Length DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(IN(AtmosphereParameters) atmosphere)
{
	return DistanceFromHeightToHorizon(atmosphere, atmosphere.top_radius);
}

/*
<h5>Intersections with the ground</h5>

<p>The segment $[\bp,\bi]$ intersects the ground when
$d^2+2r\mu d+r^2=r_{\mathrm{bottom}}^2$ has a solution with $d \ge 0$. This
requires the discriminant $r^2(\mu^2-1)+r_{\mathrm{bottom}}^2$ to be positive,
from which we deduce the following function:
*/

bool RayIntersectsGround(IN(AtmosphereParameters) atmosphere,
    Length r, Number mu) {
  assert(r >= atmosphere.bottom_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  return mu < 0.0 && r * r * (mu * mu - 1.0) +
      atmosphere.bottom_radius * atmosphere.bottom_radius >= 0.0 * m2;
}

struct CloudLightMapSPSample
{
	float shadowLengthKm; //km
	float mieFactor;
	float rayleighFactor;
};

CloudLightMapSPSample initCloudLightMapSPSample()
{
	CloudLightMapSPSample o;
	o.shadowLengthKm = 0;
	o.mieFactor = 1;
	o.rayleighFactor = 1;
	return o;
}

struct AtmPoint
{
	Length r;
	Number mu;
	Number mu_s;
	Number nu;
	bool bRayIntersectsGround;
};

float GetRAtDistance(Length r, Number mu, Length d)
{
	return sqrt(d * d + 2.0 * r * mu * d + r * r);//теорема косинусов
}

// R + MU
AtmPoint GetRMuAtDistance(IN(AtmosphereParameters) atmosphere, Length r, Number mu, Length d)
{
	AtmPoint p;
	p.r = ClampRadius(atmosphere, GetRAtDistance(r,mu,d));
	p.mu = ClampCosine((r * mu + d) / p.r);
	p.mu_s = 0;
	p.nu = 0;
	return p;
}

// R + MU + MU_S
AtmPoint GetRMuMuSAtDistance(IN(AtmosphereParameters) atmosphere, Length r, Number mu, Number mu_s, Number nu, Length d)
{
	AtmPoint p;
	p.r = ClampRadius(atmosphere, GetRAtDistance(r,mu,d));
	p.mu = ClampCosine((r * mu + d) / p.r);
	p.mu_s = ClampCosine((r * mu_s + d * nu) / p.r);
	p.nu = nu;
	return p;
}

AtmPoint GetAtmPointForRay(IN(AtmosphereParameters) atmosphere, IN(ATMPosition) camera, IN(Direction) view_ray, IN(Direction) sun_direction, uniform bool bCosmos = false)
{
	Length r = length(camera);
	Length rmu = dot(camera, view_ray);
	Number mu_s = dot(camera, sun_direction) / r;
	Number nu = dot(view_ray, sun_direction);

#ifndef NO_OUTER_SPACE
	if(bCosmos)
	{
		Length distance_to_top_atmosphere_boundary = -rmu - sqrt(rmu * rmu - r * r + atmosphere.top_radius * atmosphere.top_radius);
		// If the viewer is in space and the view ray intersects the atmosphere, move
		// the viewer to the top atmosphere boundary (along the view ray):
		if (distance_to_top_atmosphere_boundary > 0.0 * m)
		{
			camera = camera + view_ray * distance_to_top_atmosphere_boundary;
			r = atmosphere.top_radius;
			rmu += distance_to_top_atmosphere_boundary;
		}
	}
#endif

	AtmPoint o;
	o.r = r;
	o.mu = rmu / r;
	o.mu_s = mu_s;
	o.nu = nu;
	o.bRayIntersectsGround = RayIntersectsGround(atmosphere, o.r, o.mu);
	return o;
}

AtmPoint GetAtmPointForPosition(IN(AtmosphereParameters) atmosphere, IN(ATMPosition) camera, IN(ATMPosition) pos, IN(Direction) sun_direction, uniform bool bCosmos = false)
{
	Direction view_ray = pos - camera;
	Length d = length(view_ray);
	view_ray /= d;
	return GetAtmPointForRay(atmosphere, camera, view_ray, sun_direction, bCosmos);
}

/*
<h5>Transmittance to the top atmosphere boundary</h5>

<p>We can now compute the transmittance between $\bp$ and $\bi$. From its
definition and the
<a href="https://en.wikipedia.org/wiki/Beer-Lambert_law">Beer-Lambert law</a>,
this involves the integral of the number density of air molecules along the
segment $[\bp,\bi]$, as well as the integral of the number density of aerosols
along this segment. Both integrals have the same form and, when the segment
$[\bp,\bi]$ does not intersect the ground, they can be computed numerically with
the help of the following auxilliary function (using the <a href=
"https://en.wikipedia.org/wiki/Trapezoidal_rule">trapezoidal rule</a>):
*/

Length ComputeOpticalLengthToTopAtmosphereBoundary(
    IN(AtmosphereParameters) atmosphere, Length scale_height,
    Length r, Number mu) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  // Number of intervals for the numerical integration.
  const uint SAMPLE_COUNT = TRANSMITTANCE_SAMPLES;
  // The integration step, i.e. the length of each integration interval.
  Length dx = DistanceToTopAtmosphereBoundary(atmosphere, r, mu) / Number(SAMPLE_COUNT);
  // Integration loop.
  Length result = 0.0 * m;
  for (uint i = 0; i <= SAMPLE_COUNT; ++i) {
    Length d_i = Number(i) * dx;
    // Distance between the current sample point and the planet center.
    Length r_i = GetRAtDistance(r, mu, d_i);
    // Number density at the current sample point (divided by the number density
    // at the bottom of the atmosphere, yielding a dimensionless number).
    Number y_i = exp(-(r_i - atmosphere.bottom_radius) / scale_height);
    // Sample weight (from the trapezoidal rule).
    Number weight_i = i == 0 || i == SAMPLE_COUNT ? 0.5 : 1.0;
    result += y_i * weight_i * dx;
  }
  return result;
}

/*
<p>With this function the transmittance between $\bp$ and $\bi$ is now easy to
compute (we continue to assume that the segment does not intersect the ground):
*/

#ifdef TRANSMITTANCE_FIXED_STEPS
DimensionlessSpectrum ComputeTransmittanceToPoint(IN(AtmosphereParameters) atmosphere, Length r, Number mu, Length d)
#else
DimensionlessSpectrum ComputeTransmittanceToPoint(IN(AtmosphereParameters) atmosphere, Length r, Number mu, Number distFactor)
#endif
{
	assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
	assert(mu >= -1.0 && mu <= 1.0);
	
#ifdef TRANSMITTANCE_FIXED_STEPS
	float distToHoriz = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
	float distFactor = d / distToHoriz;	
	const uint SAMPLE_COUNT = TRANSMITTANCE_SAMPLES * distFactor;
	// The integration step, i.e. the length of each integration interval.
	Length dx = d / Number(SAMPLE_COUNT);
#else
	const uint SAMPLE_COUNT = TRANSMITTANCE_SAMPLES * distFactor;
	// The integration step, i.e. the length of each integration interval.
	Length dx = (DistanceToTopAtmosphereBoundary(atmosphere, r, mu) * distFactor) / Number(SAMPLE_COUNT);
	// Length dx = d / Number(SAMPLE_COUNT);
#endif
	
	Length rayleigh_density = 0.0 * m;
	Length mie_density = 0.0 * m;
	Length absorption_density = 0.0 * m;
	Length rmu2 = 2.0 * r * mu;
	Length r2 = r * r;
	[loop]
	for (uint i = 0; i <= SAMPLE_COUNT; ++i)
	{
		Length d_i = Number(i) * dx;
		// Distance between the current sample point and the planet center.
		Length r_i = sqrt(d_i * d_i + rmu2 * d_i + r2);
		// Sample weight (from the trapezoidal rule).
		Number weight_i = (i > 0 && i < SAMPLE_COUNT) ? 1.0 : 0.5;
		// Number density at the current sample point (divided by the number density
		// at the bottom of the atmosphere, yielding a dimensionless number).
		rayleigh_density	+= GetDensityRayleigh(atmosphere, r_i) * weight_i;
		mie_density			+= GetDensityMie(atmosphere, r_i, d_i) * weight_i;
		absorption_density	+= GetDensityAbsorption(atmosphere, r_i) * weight_i;
	}
	rayleigh_density *= dx;
	mie_density *= dx;
	absorption_density *= dx;
	
	// Length rayleigh_density = ComputeOpticalLengthToTopAtmosphereBoundary(atmosphere, atmosphere.rayleigh_scale_height, r, mu);
	// Length mie_density = ComputeOpticalLengthToTopAtmosphereBoundary(atmosphere, atmosphere.mie_scale_height, r, mu);
	
	return exp(-(atmosphere.rayleigh_scattering   * rayleigh_density +
				 atmosphere.mie_extinction 		  * mie_density	+
				 atmosphere.absorption_extinction * absorption_density
				 ));
}

DimensionlessSpectrum ComputeTransmittanceToDist(IN(AtmosphereParameters) atmosphere, Length r, Number mu, Length d, uniform uint samplesMin = 3)
{
	float distToHoriz = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
	float distFactor = d / distToHoriz;
	const uint SAMPLE_COUNT = max(samplesMin, 0.5 * TRANSMITTANCE_SAMPLES * distFactor);
	// The integration step, i.e. the length of each integration interval.
	Length dx = d / Number(SAMPLE_COUNT);
	Length rayleigh_density = 0.0 * m;
	Length mie_density = 0.0 * m;
	Length absorption_density = 0.0 * m;
	Length rmu2 = 2.0 * r * mu;
	Length r2 = r * r;
	Length d_i = 0;
	[loop]
	for (uint i = 0; i <= SAMPLE_COUNT; ++i)
	{
		// Distance between the current sample point and the planet center.
		Length r_i = sqrt(d_i * d_i + rmu2 * d_i + r2);
		// Sample weight (from the trapezoidal rule).
		Number weight_i = (i > 0 && i < SAMPLE_COUNT) ? 1.0 : 0.5;
		// Number density at the current sample point (divided by the number density
		// at the bottom of the atmosphere, yielding a dimensionless number).
		rayleigh_density	+= GetDensityRayleigh(atmosphere, r_i) * weight_i;
		mie_density			+= GetDensityMie(atmosphere, r_i, d_i) * weight_i;
		absorption_density	+= GetDensityAbsorption(atmosphere, r_i) * weight_i;
		d_i += dx;
	}	
	return exp(-(atmosphere.rayleigh_scattering   * rayleigh_density +
				 atmosphere.mie_extinction 		  * mie_density	+
				 atmosphere.absorption_extinction * absorption_density
				 )*dx);
}

DimensionlessSpectrum ComputeTransmittanceToTopAtmosphereBoundary(IN(AtmosphereParameters) atmosphere, Length r, Number mu)
{
	assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
	assert(mu >= -1.0 && mu <= 1.0);
	
#ifdef TRANSMITTANCE_FIXED_STEPS
	return ComputeTransmittanceToPoint(atmosphere, r, mu, DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere));
#else
	return ComputeTransmittanceToPoint(atmosphere, r, mu, 1.0);
#endif
}

/*
<h4 id="transmittance_precomputation">Precomputation</h4>

<p>The above function is quite costly to evaluate, and a lot of evaluations are
needed to compute single and multiple scattering. Fortunately this function
depends on only two parameters and is quite smooth, so we can precompute it in a
small 2D texture to optimize its evaluation.

<p>For this we need a mapping between the function parameters $(r,\mu)$ and the
texture coordinates $(u,v)$, and vice-versa, because these parameters do not
have the same units and range of values. And even if it was the case, storing a
function $f$ from the $[0,1]$ interval in a texture of size $n$ would sample the
function at $0.5/n$, $1.5/n$, ... $(n-0.5)/n$, because texture samples are at
the center of texels. Therefore, this texture would only give us extrapolated
function values at the domain boundaries ($0$ and $1$). To avoid this we need
to store $f(0)$ at the center of texel 0 and $f(1)$ at the center of texel
$n-1$. This can be done with the following mapping from values $x$ in $[0,1]$ to
texture coordinates $u$ in $[0.5/n,1-0.5/n]$ - and its inverse:
*/

Number GetTextureCoordFromUnitRange(Number x, uint texture_size) {
  return 0.5 / Number(texture_size) + x * (1.0 - 1.0 / Number(texture_size));
}

Number GetUnitRangeFromTextureCoord(Number u, uint texture_size) {
  return (u - 0.5 / Number(texture_size)) / (1.0 - 1.0 / Number(texture_size));
}

/*
<p>Using these functions, we can now define a mapping between $(r,\mu)$ and the
texture coordinates $(u,v)$, and its inverse, which avoid any extrapolation
during texture lookups. In the <a href=
"http://evasion.inrialpes.fr/~Eric.Bruneton/PrecomputedAtmosphericScattering2.zip"
>original implementation</a> this mapping was using some ad-hoc constants chosen
for the Earth atmosphere case. Here we use a generic mapping, working for any
atmosphere, but still providing an increased sampling rate near the horizon.
Our improved mapping is based on the parameterization described in our
<a href="https://hal.inria.fr/inria-00288758/en">paper</a> for the 4D textures:
we use the same mapping for $r$, and a slightly improved mapping for $\mu$
(considering only the case where the view ray does not intersect the ground).
More precisely, we map $\mu$ to a value $x_{\mu}$ between 0 and 1 by considering
the distance $d$ to the top atmosphere boundary, compared to its minimum and
maximum values $d_{\mathrm{min}}=r_{\mathrm{top}}-r$ and
$d_{\mathrm{max}}=\rho+H$ (cf. the notations from the
<a href="https://hal.inria.fr/inria-00288758/en">paper</a> and the figure
below):

<svg width="505px" height="195px">
  <style type="text/css"><![CDATA[
    circle { fill: #000000; stroke: none; }
    path { fill: none; stroke: #000000; }
    text { font-size: 16px; font-style: normal; font-family: Sans; }
    .vector { font-weight: bold; }
  ]]></style>
  <path d="m 5,85 a 520,520 0 0 1 372,105"/>
  <path d="m 5,5 a 600,600 0 0 1 490,185"/>
  <path d="m 60,0 0,190"/>
  <path d="m 60,65 180,-35"/>
  <path d="m 55,5 5,-5 5,5"/>
  <path d="m 55,60 5,5 5,-5"/>
  <path d="m 55,70 5,-5 5,5"/>
  <path d="m 60,40 a 25,25 0 0 1 25,20" style="stroke-dasharray:4,2;"/>
  <path d="m 60,65 415,105"/>
  <circle cx="60" cy="65" r="2.5"/>
  <circle cx="240" cy="30" r="2.5"/>
  <circle cx="180" cy="95" r="2.5"/>
  <circle cx="475" cy="170" r="2.5"/>
  <text x="20" y="40">d<tspan style="font-size:10px" dy="2">min</tspan></text>
  <text x="35" y="70" class="vector">p</text>
  <text x="35" y="125">r</text>
  <text x="75" y="40">μ=cos(θ)</text>
  <text x="120" y="75">ρ</text>
  <text x="155" y="60">d</text>
  <text x="315" y="125">H</text>
</svg>

<p>With these definitions, the mapping from $(r,\mu)$ to the texture coordinates
$(u,v)$ can be implemented as follows:
*/

vec2 GetTransmittanceTextureUvFromRMu(IN(AtmosphereParameters) atmosphere, Length r, Number mu)
{
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
#ifdef TRANSMITTANCE_BETTER_MAPPING

	Number x_r = SafeSqrt((r - atmosphere.bottom_radius) / (atmosphere.top_radius - atmosphere.bottom_radius));
	Number x_mu = atan((mu + 0.15) / (1.0 + 0.15) * tan(1.5)) / 1.5;

#else
  // Distance to top atmosphere boundary for a horizontal ray at ground level.
  Length H = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
  // Distance to the horizon.
  Length rho = DistanceFromHeightToHorizon(atmosphere, r);
  // Distance to the top atmosphere boundary for the ray (r,mu), and its minimum
  // and maximum values over all mu - obtained for (r,1) and (r,mu_horizon).
  Length d = DistanceToTopAtmosphereBoundary(atmosphere, r, mu);
  Length d_min = atmosphere.top_radius - r;
  Length d_max = rho + H;
  Number x_mu = (d - d_min) / (d_max - d_min);
  Number x_r = rho / H;
  // Number x_r = SafeSqrt((r - atmosphere.bottom_radius) / (atmosphere.top_radius - atmosphere.bottom_radius));
#endif
  return vec2(GetTextureCoordFromUnitRange(x_mu, TRANSMITTANCE_TEXTURE_WIDTH),
              // GetTextureCoordFromUnitRange(sqrt(x_r), TRANSMITTANCE_TEXTURE_HEIGHT));
              GetTextureCoordFromUnitRange(x_r, TRANSMITTANCE_TEXTURE_HEIGHT));
}

/*
<p>and the inverse mapping follows immediately:
*/

void GetRMuFromTransmittanceTextureUv(IN(AtmosphereParameters) atmosphere, IN(vec2) uv, OUT(Length) r, OUT(Number) mu)
{
  assert(uv.x >= 0.0 && uv.x <= 1.0);
  assert(uv.y >= 0.0 && uv.y <= 1.0);
  Number x_mu = GetUnitRangeFromTextureCoord(uv.x, TRANSMITTANCE_TEXTURE_WIDTH);
  Number x_r = GetUnitRangeFromTextureCoord(uv.y, TRANSMITTANCE_TEXTURE_HEIGHT);

#ifdef TRANSMITTANCE_BETTER_MAPPING
    r = atmosphere.bottom_radius + (x_r * x_r) * (atmosphere.top_radius - atmosphere.bottom_radius);
    mu = -0.15 + tan(1.5 * x_mu) / tan(1.5) * (1.0 + 0.15);
#else

  // Distance to top atmosphere boundary for a horizontal ray at ground level.
  Length H = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
  // Distance to the horizon, from which we can compute r:
  Length rho = H * x_r;
  r = sqrt(rho * rho + atmosphere.bottom_radius * atmosphere.bottom_radius);
  // Distance to the top atmosphere boundary for the ray (r,mu), and its minimum
  // and maximum values over all mu - obtained for (r,1) and (r,mu_horizon) -
  // from which we can recover mu:
  Length d_min = atmosphere.top_radius - r;
  Length d_max = rho + H;
  Length d = d_min + x_mu * (d_max - d_min);
  mu = d == 0.0 * m ? Number(1.0) : (H * H - rho * rho - d * d) / (2.0 * r * d);
  mu = ClampCosine(mu);
#endif
}

/*
<p>It is now easy to define a fragment shader function to precompute a texel of
the transmittance texture:
*/

DimensionlessSpectrum ComputeTransmittanceToTopAtmosphereBoundaryTexture(
    IN(AtmosphereParameters) atmosphere, IN(vec2) gl_frag_coord) {
  const vec2 TRANSMITTANCE_TEXTURE_SIZE =
      vec2(TRANSMITTANCE_TEXTURE_WIDTH, TRANSMITTANCE_TEXTURE_HEIGHT);
  Length r;
  Number mu;
  GetRMuFromTransmittanceTextureUv(atmosphere, gl_frag_coord / TRANSMITTANCE_TEXTURE_SIZE, r, mu);
  float3 transmittance = ComputeTransmittanceToTopAtmosphereBoundary(atmosphere, r, mu);
#ifdef TRANSMITTANCE_SRGB
  return transmittance>0? sqrt(transmittance) : 0;
#else
  return transmittance;
#endif
}

/*
<h4 id="transmittance_lookup">Lookup</h4>

<p>With the help of the above precomputed texture, we can now get the
transmittance between a point and the top atmosphere boundary with a single
texture lookup (assuming there is no intersection with the ground):
*/

DimensionlessSpectrum GetTransmittanceToTopAtmosphereBoundary(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    Length r, Number mu) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  vec2 uv = GetTransmittanceTextureUvFromRMu(atmosphere, r, mu);
  float3 transmittance = SampleTexture2D(transmittance_texture, uv).rgb;
#ifdef TRANSMITTANCE_SRGB
  return DimensionlessSpectrum(transmittance * transmittance);
#else
  return DimensionlessSpectrum(transmittance);
#endif
}

/*
<p>Also, with $r_d=\Vert\bo\bq\Vert=\sqrt{d^2+2r\mu d+r^2}$ and $\mu_d=
\bo\bq\cdot\bp\bi/\Vert\bo\bq\Vert\Vert\bp\bi\Vert=(r\mu+d)/r_d$ the values of
$r$ and $\mu$ at $\bq$, we can get the transmittance between two arbitrary
points $\bp$ and $\bq$ inside the atmosphere with only two texture lookups
(recall that the transmittance between $\bp$ and $\bq$ is the transmittance
between $\bp$ and the top atmosphere boundary, divided by the transmittance
between $\bq$ and the top atmosphere boundary, or the reverse - we continue to
assume that the segment between the two points does not intersect the ground):
*/

DimensionlessSpectrum GetTransmittance(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    Length r, Number mu, Length d, bool ray_r_mu_intersects_ground) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  assert(d >= 0.0 * m);

   AtmPoint p = GetRMuAtDistance(atmosphere, r, mu, d);

#ifdef TRANSMITTANCE_TEST_GROUND_BY_MU
  if (mu<0)
#else
  if (ray_r_mu_intersects_ground)
#endif
  {
    return min(
        GetTransmittanceToTopAtmosphereBoundary(
            atmosphere, transmittance_texture, p.r, -p.mu) /
        GetTransmittanceToTopAtmosphereBoundary(
            atmosphere, transmittance_texture, r, -mu),
        DimensionlessSpectrum(1.0, 1.0, 1.0));
  } else {
    return min(
        GetTransmittanceToTopAtmosphereBoundary(
            atmosphere, transmittance_texture, r, mu) /
        GetTransmittanceToTopAtmosphereBoundary(
            atmosphere, transmittance_texture, p.r, p.mu),
        DimensionlessSpectrum(1.0, 1.0, 1.0));
  }
}

/*
<p>where <code>ray_r_mu_intersects_ground</code> should be true iif the ray
defined by $r$ and $\mu$ intersects the ground. We don't compute it here with
<code>RayIntersectsGround</code> because the result could be wrong for rays
very close to the horizon, due to the finite precision and rounding errors of
floating point operations. And also because the caller generally has more robust
ways to know whether a ray intersects the ground or not (see below).

<h3 id="single_scattering">Single scattering</h3>

<p>The single scattered radiance is the light arriving from the Sun at some
point after exactly one scattering event inside the atmosphere (which can be due
to air molecules or aerosol particles; we exclude reflections from the ground,
computed <a href="#irradiance">separately</a>). The following sections describe
how we compute it, how we store it in a precomputed texture, and how we read it
back.

<h4 id="single_scattering_computation">Computation</h4>

<p>Consider the Sun light scattered at a point $\bq$ by air molecules before
arriving at another point $\bp$ (for aerosols, replace "Rayleigh" with "Mie"
below):

<svg height="190px" width="340px">
  <style type="text/css"><![CDATA[
    circle { fill: #000000; stroke: none; }
    path { fill: none; stroke: #000000; }
    text { font-size: 16px; font-style: normal; font-family: Sans; }
    .vector { font-weight: bold; }
  ]]></style>
  <path d="m 0,66 a 600,600 0 0 1 340,0"/>
  <path d="m 0,150 a 520,520 0 0 1 340,0"/>
  <path d="m 170,180 0,-165"/>
  <path d="m 250,180 30,-165"/>
  <path d="m 170,90 -30,-60"/>
  <path d="m 155,70 0,-10 8,6" />
  <path d="m 270,70 -20,-40" style="stroke-width:2;"/>
  <path d="m 170,90 100,-20" style="stroke-width:2;"/>
  <path d="m 270,70 75,-15" />
  <path d="m 170,65 a 25,25 0 0 1 25,20" style="stroke-dasharray:4,2;"/>
  <path d="m 170,30 a 60,60 1 0 0 -26.8,6.3" style="stroke-dasharray:4,2;"/>
  <path d="m 255,40 a 35,35 0 0 1 21,-3.2" style="stroke-dasharray:4,2;"/>
  <path d="m 258,45 a 30,30 0 0 1 41,19" style="stroke-dasharray:4,2;"/>
  <circle cx="170" cy="90" r="2.5"/>
  <circle cx="270" cy="70" r="2.5"/>
  <text x="155" y="105" class="vector">p</text>
  <text x="275" y="85" class="vector">q</text>
  <text x="130" y="70" class="vector">ω<tspan
      dy="2" style="font-size:10px;font-weight:normal;">s</tspan></text>
  <text x="155" y="164">r</text>
  <text x="265" y="165">r<tspan dy="2" style="font-size:10px">d</tspan></text>
  <text x="220" y="95">d</text>
  <text x="190" y="65">μ</text>
  <text x="145" y="25">μ<tspan dy="2" style="font-size:10px">s</tspan></text>
  <text x="290" y="45">ν</text>
  <text x="250" y="20">μ<tspan dy="2" style="font-size:10px">s,d</tspan></text>
</svg>

<p>The radiance arriving at $\bp$ is the product of:
<ul>
<li>the solar irradiance at the top of the atmosphere,</li>
<li>the transmittance between the top of the atmosphere and $\bq$ (i.e. the
fraction of the light at the top of the atmosphere that reaches $\bq$),</li>
<li>the Rayleigh scattering coefficient at $\bq$ (i.e. the fraction of the
light arriving at $\bq$ which is scattered, in any direction),</li>
<li>the Rayleigh phase function (i.e. the fraction of the scattered light at
$\bq$ which is actually scattered towards $\bp$),</li>
<li>the transmittance between $\bq$ and $\bp$ (i.e. the fraction of the light
scattered at $\bq$ towards $\bp$ that reaches $\bp$).</li>
</ul>

<p>Thus, by noting $\bw_s$ the unit direction vector towards the Sun, and with
the following definitions:
<ul>
<li>$r=\Vert\bo\bp\Vert$,</li>
<li>$d=\Vert\bp\bq\Vert$,</li>
<li>$\mu=(\bo\bp\cdot\bp\bq)/rd$,</li>
<li>$\mu_s=(\bo\bp\cdot\bw_s)/r$,</li>
<li>$\nu=(\bp\bq\cdot\bw_s)/d$</li>
</ul>
the values of $r$ and $\mu_s$ for $\bq$ are
<ul>
<li>$r_d=\Vert\bo\bq\Vert=\sqrt{d^2+2r\mu d +r^2}$,</li>
<li>$\mu_{s,d}=(\bo\bq\cdot\bw_s)/r_d=((\bo\bp+\bp\bq)\cdot\bw_s)/r_d=
(r\mu_s + d\nu)/r_d$</li>
</ul>
and the Rayleigh and Mie single scattering components can be computed as follows
(note that we omit the solar irradiance and the phase function terms, as well as
the scattering coefficients at the bottom of the atmosphere - we add them later
on for efficiency reasons):
*/

void ComputeSingleScatteringIntegrand(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    Length r, Number mu, Number mu_s, Number nu, Length d,
    bool ray_r_mu_intersects_ground,
    OUT(DimensionlessSpectrum) rayleigh, OUT(DimensionlessSpectrum) mie) {

  AtmPoint p = GetRMuMuSAtDistance(atmosphere, r, mu, mu_s, nu, d);

  if (RayIntersectsGround(atmosphere, p.r, p.mu_s)) {
    rayleigh = DimensionlessSpectrum(0.0, 0.0, 0.0);
    mie = DimensionlessSpectrum(0.0, 0.0, 0.0);
  } else {
    DimensionlessSpectrum transmittance =
	#ifdef INTEGRATE_TRANSMITTANCE_WHILE_COMPUTE_SCATTERING
		ComputeTransmittanceToDist(atmosphere, r, mu, d) * 
	#else
        GetTransmittance(atmosphere, transmittance_texture, r, mu, d, ray_r_mu_intersects_ground) *
	#endif
        GetTransmittanceToTopAtmosphereBoundary(
            atmosphere, transmittance_texture, p.r, p.mu_s);
    rayleigh = transmittance * GetDensityRayleigh(atmosphere, p.r);
    mie = transmittance * GetDensityMie(atmosphere, p.r, d);
  }
}

/*
<p>Consider now the Sun light arriving at $\bp$ from a given direction $\bw$,
after exactly one scattering event. The scattering event can occur at any point
$\bq$ between $\bp$ and the intersection $\bi$ of the half-line $[\bp,\bw)$ with
the nearest atmosphere boundary. Thus, the single scattered radiance at $\bp$
from direction $\bw$ is the integral of the single scattered radiance from $\bq$
to $\bp$ for all points $\bq$ between $\bp$ and $\bi$. To compute it, we first
need the length $\Vert\bp\bi\Vert$:
*/

Length DistanceToNearestAtmosphereBoundary(IN(AtmosphereParameters) atmosphere,
    Length r, Number mu, bool ray_r_mu_intersects_ground) {
  if (ray_r_mu_intersects_ground) {
    return DistanceToBottomAtmosphereBoundary(atmosphere, r, mu);
  } else {
    return DistanceToTopAtmosphereBoundary(atmosphere, r, mu);
  }
}

/*
<p>The single scattering integral can then be computed as follows (using
the <a href="https://en.wikipedia.org/wiki/Trapezoidal_rule">trapezoidal
rule</a>):
*/

void ComputeSingleScattering(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    Length r, Number mu, Number mu_s, Number nu,
    bool ray_r_mu_intersects_ground,
    OUT(IrradianceSpectrum) rayleigh, OUT(IrradianceSpectrum) mie) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  assert(mu_s >= -1.0 && mu_s <= 1.0);
  assert(nu >= -1.0 && nu <= 1.0);

	float dist = DistanceToNearestAtmosphereBoundary(atmosphere, r, mu, ray_r_mu_intersects_ground);

#ifdef SINGLE_SCATTERING_ADAPTIVE_STEPS_COUNT
	float distToHoriz = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
	  // Number of intervals for the numerical integration.
	  const uint SAMPLE_COUNT = max(10, SINGLE_SCATTERING_SAMPLES * (dist / distToHoriz));
#else
  // Number of intervals for the numerical integration.
  const uint SAMPLE_COUNT = SINGLE_SCATTERING_SAMPLES;
#endif

  // The integration step, i.e. the length of each integration interval.
  Length dx = dist / Number(SAMPLE_COUNT);
  // Integration loop.
  DimensionlessSpectrum rayleigh_sum = DimensionlessSpectrum(0.0, 0.0, 0.0);
  DimensionlessSpectrum mie_sum = DimensionlessSpectrum(0.0, 0.0, 0.0);
  for (uint i = 0; i <= SAMPLE_COUNT; ++i) {
    Length d_i = Number(i) * dx;
    // The Rayleigh and Mie single scattering at the current sample point.
    DimensionlessSpectrum rayleigh_i;
    DimensionlessSpectrum mie_i;
    ComputeSingleScatteringIntegrand(atmosphere, transmittance_texture,
        r, mu, mu_s, nu, d_i, ray_r_mu_intersects_ground, rayleigh_i, mie_i);
    // Sample weight (from the trapezoidal rule).
    Number weight_i = (i == 0 || i == SAMPLE_COUNT) ? 0.5 : 1.0;
    rayleigh_sum += rayleigh_i * weight_i;
    mie_sum += mie_i * weight_i;
  }
  rayleigh = rayleigh_sum * dx * atmosphere.solar_irradiance *
      atmosphere.rayleigh_scattering;
  mie = mie_sum * dx * atmosphere.solar_irradiance * atmosphere.mie_scattering;
}

/*
<p>Note that we added the solar irradiance and the scattering coefficient terms
that we omitted in <code>ComputeSingleScatteringIntegrand</code>, but not the
phase function terms - they are added at <a href="#rendering">render time</a>
for better angular precision. We provide them here for completeness:
*/

InverseSolidAngle RayleighPhaseFunction(Number nu) {
  InverseSolidAngle k = 3.0 / (16.0 * atmPI * sr);
  return k * (1.0 + nu * nu);
}

InverseSolidAngle MiePhaseFunction(Number g, Number nu) {
#ifdef MIE_PHASE_FUNCTION_LUT
	return miePhaseFuncTex.SampleLevel(gBilinearClampSampler, 1-(nu*0.5+0.5), 0).r;
#else
  InverseSolidAngle k = 3.0 / (8.0 * atmPI * sr) * (1.0 - g * g) / (2.0 + g * g);
  return k * (1.0 + nu * nu) / pow(1.0 + g * g - 2.0 * g * nu, 1.5);
  // return k * (1.0 + nu * nu) / pow(1.0 + g * g - 2.0 * g * nu, 1.5) + 0.9/((1.0-nu)*600.0+0.05); //TODO: check this model
 #endif
}

/*
<h4 id="single_scattering_precomputation">Precomputation</h4>

<p>The <code>ComputeSingleScattering</code> function is quite costly to
evaluate, and a lot of evaluations are needed to compute multiple scattering.
We therefore want to precompute it in a texture, which requires a mapping from
the 4 function parameters to texture coordinates. Assuming for now that we have
4D textures, we need to define a mapping from $(r,\mu,\mu_s,\nu)$ to texture
coordinates $(u,v,w,z)$. The function below implements the mapping defined in
our <a href="https://hal.inria.fr/inria-00288758/en">paper</a>, with some small
improvements (refer to the paper and to the above figures for the notations):
<ul>
<li>the mapping for $\mu$ takes the minimal distance to the nearest atmosphere
boundary into account, to map $\mu$ to the full $[0,1]$ interval (the original
mapping was not covering the full $[0,1]$ interval).</li>
<li>the mapping for $\mu_s$ is more generic than in the paper (the original
mapping was using ad-hoc constants chosen for the Earth atmosphere case). It is
based on the distance to the top atmosphere boundary (for the sun rays), as for
the $\mu$ mapping, and uses only one ad-hoc (but configurable) parameter. Yet,
as the original definition, it provides an increased sampling rate near the
horizon.</li>
</ul>
*/

vec4 GetScatteringTextureUvwzFromRMuMuSNu(IN(AtmosphereParameters) atmosphere,
    Length r, Number mu, Number mu_s, Number nu,
    bool ray_r_mu_intersects_ground) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  assert(mu_s >= -1.0 && mu_s <= 1.0);
  assert(nu >= -1.0 && nu <= 1.0);

  // Distance to top atmosphere boundary for a horizontal ray at ground level.
  Length H = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
  // Distance to the horizon.
  Length rho = DistanceFromHeightToHorizon(atmosphere, r);
#ifdef SCATTERING_BETTER_R_MAPPING
  Number u_r = GetTextureCoordFromUnitRange(sqrt(rho / H), SCATTERING_TEXTURE_R_SIZE);
#else
  Number u_r = GetTextureCoordFromUnitRange(rho / H, SCATTERING_TEXTURE_R_SIZE);
 #endif

  // Discriminant of the quadratic equation for the intersections of the ray
  // (r,mu) with the ground (see RayIntersectsGround).
  Length r_mu = r * mu;
  Area discriminant = r_mu * r_mu - r * r + atmosphere.bottom_radius * atmosphere.bottom_radius;
  Number u_mu;

  if (ray_r_mu_intersects_ground) {
    // Distance to the ground for the ray (r,mu), and its minimum and maximum
    // values over all mu - obtained for (r,-1) and (r,mu_horizon).
    Length d = -r_mu - SafeSqrt(discriminant);
    Length d_min = r - atmosphere.bottom_radius;
    Length d_max = rho;
    u_mu = 0.0 + 0.5 * GetTextureCoordFromUnitRange(d_max == d_min ? 0.0 : (d - d_min) / (d_max - d_min), SCATTERING_TEXTURE_MU_SIZE / 2);
  } else {
    // Distance to the top atmosphere boundary for the ray (r,mu), and its
    // minimum and maximum values over all mu - obtained for (r,1) and
    // (r,mu_horizon).
    Length d = -r_mu + SafeSqrt(discriminant + H * H);
    Length d_min = atmosphere.top_radius - r;
    Length d_max = rho + H;
    u_mu = 1 - 0.5 * GetTextureCoordFromUnitRange((d - d_min) / (d_max - d_min), SCATTERING_TEXTURE_MU_SIZE / 2);
  }

#ifdef SCATTERING_BETTER_MU_S_MAPPING
	// from "Outdoor Light Scattering Sample Update" by Egor Yusov
	Number u_mu_s = 0.5 * (atan(max(mu_s, -0.1975) * tan(1.26 * 1.1)) / 1.1 + (1.0 - 0.26));
	u_mu_s = GetTextureCoordFromUnitRange(u_mu_s, SCATTERING_TEXTURE_MU_S_SIZE);
#else
  Length d = DistanceToTopAtmosphereBoundary(atmosphere, atmosphere.bottom_radius, mu_s);
  Length d_min = atmosphere.top_radius - atmosphere.bottom_radius;
  Length d_max = H;
  Number a = (d - d_min) / (d_max - d_min);
  Number A = -2.0 * atmosphere.mu_s_min * atmosphere.bottom_radius / (d_max - d_min);
  Number uMuS = max(1.0 - a / A, 0.0) / (1.0 + a);
  Number u_mu_s = GetTextureCoordFromUnitRange(uMuS, SCATTERING_TEXTURE_MU_S_SIZE);
#endif

  Number u_nu = (nu + 1.0) / 2.0;
  return vec4(u_nu, u_mu_s, u_mu, u_r);
}

/*
<p>The inverse mapping follows immediately:
*/

void GetRMuMuSNuFromScatteringTextureUvwz(IN(AtmosphereParameters) atmosphere,
    IN(vec4) uvwz, OUT(Length) r, OUT(Number) mu, OUT(Number) mu_s,
    OUT(Number) nu, OUT(bool) ray_r_mu_intersects_ground) {
  assert(uvwz.x >= 0.0 && uvwz.x <= 1.0);
  assert(uvwz.y >= 0.0 && uvwz.y <= 1.0);
  assert(uvwz.z >= 0.0 && uvwz.z <= 1.0);
  assert(uvwz.w >= 0.0 && uvwz.w <= 1.0);

  // Distance to top atmosphere boundary for a horizontal ray at ground level.
  Length H = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
  // Distance to the horizon.
  Length uR = GetUnitRangeFromTextureCoord(uvwz.w, SCATTERING_TEXTURE_R_SIZE);
#ifdef SCATTERING_BETTER_R_MAPPING
  // sqrt((r-atmosphere.bottom_radius) / 60.0)
  //Length uR = GetUnitRangeFromTextureCoord(uvwz.w, SCATTERING_TEXTURE_R_SIZE);
  //r = (uR*uR)*60.0 + atmosphere.bottom_radius;
  //Length rho = DistanceFromHeightToHorizon(atmosphere, r);//sqrt(r*r - atmosphere.bottom_radius * atmosphere.bottom_radius);  
  Length uRho = uR;
  Length rho = H * uRho * uRho;
#else
  Length rho = H * uR;
#endif
	r = sqrt(rho * rho + atmosphere.bottom_radius * atmosphere.bottom_radius);
	ray_r_mu_intersects_ground = uvwz.z < 0.5;

  if (ray_r_mu_intersects_ground) {
    // Distance to the ground for the ray (r,mu), and its minimum and maximum
    // values over all mu - obtained for (r,-1) and (r,mu_horizon) - from which
    // we can recover mu:
    Length d_min = r - atmosphere.bottom_radius;
    Length d_max = rho;
    // Length d = d_min + (d_max - d_min) * GetUnitRangeFromTextureCoord(1.0 - 2.0 * uvwz.z, SCATTERING_TEXTURE_MU_SIZE / 2);
    Length d = d_min + (d_max - d_min) * GetUnitRangeFromTextureCoord(2.0 * uvwz.z, SCATTERING_TEXTURE_MU_SIZE / 2);
    mu = d == 0.0 * m ? Number(-1.0) :ClampCosine(-(rho * rho + d * d) / (2.0 * r * d));
  } else {
    // Distance to the top atmosphere boundary for the ray (r,mu), and its
    // minimum and maximum values over all mu - obtained for (r,1) and
    // (r,mu_horizon) - from which we can recover mu:
    Length d_min = atmosphere.top_radius - r;
    Length d_max = rho + H;
    // Length d = d_min + (d_max - d_min) * GetUnitRangeFromTextureCoord(2.0 * uvwz.z - 1.0, SCATTERING_TEXTURE_MU_SIZE / 2);
    Length d = d_min + (d_max - d_min) * GetUnitRangeFromTextureCoord(2 - 2*uvwz.z, SCATTERING_TEXTURE_MU_SIZE / 2);
    mu = d == 0.0 * m ? Number(1.0) : ClampCosine((H * H - rho * rho - d * d) / (2.0 * r * d));
  }
  
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  //Number x_mu_s = GetUnitRangeFromTextureCoord(sqrt(uvwz.y), SCATTERING_TEXTURE_MU_S_SIZE);
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#ifdef SCATTERING_BETTER_MU_S_MAPPING
  Number x_mu_s = GetUnitRangeFromTextureCoord(uvwz.y, SCATTERING_TEXTURE_MU_S_SIZE);
  // from "Outdoor Light Scattering Sample Update" by Egor Yusov
  mu_s = tan((2.0 * x_mu_s - 1.0 + 0.26) * 1.1) / tan(1.26 * 1.1);
  mu_s = clamp(mu_s, -0.2, 1.0);
  // mu_s = tan((2.0 * x_mu_s - 1.0 + 0.26) * 0.75) / tan(1.26 * 0.75);
#else
  Number x_mu_s = GetUnitRangeFromTextureCoord(uvwz.y, SCATTERING_TEXTURE_MU_S_SIZE);
  Length d_min = atmosphere.top_radius - atmosphere.bottom_radius;
  Length d_max = H;
  Number A = -2.0 * atmosphere.mu_s_min * atmosphere.bottom_radius / (d_max - d_min);
  Number a = (A - x_mu_s * A) / (1.0 + x_mu_s * A);
  Length d = d_min + min(a, A) * (d_max - d_min);
  mu_s = d == 0.0 * m ? Number(1.0) : ClampCosine((H * H - d * d) / (2.0 * atmosphere.bottom_radius * d));
#endif

  nu = ClampCosine(uvwz.x * 2.0 - 1.0);
}

/*
<p>We assumed above that we have 4D textures, which is not the case in practice.
We therefore need a further mapping, between 3D and 4D texture coordinates. The
function below expands a 3D texel coordinate into a 4D texture coordinate, and
then to $(r,\mu,\mu_s,\nu)$ parameters. It does so by "unpacking" two texel
coordinates from the $x$ texel coordinate. Note also how we clamp the $\nu$
parameter at the end. This is because $\nu$ is not a fully independent variable:
its range of values depends on $\mu$ and $\mu_s$ (this can be seen by computing
$\mu$, $\mu_s$ and $\nu$ from the cartesian coordinates of the zenith, view and
sun unit direction vectors), and the previous functions implicitely assume this
(their assertions can break if this constraint is not respected).
*/

void GetRMuMuSNuFromScatteringTextureFragCoord(
    IN(AtmosphereParameters) atmosphere, IN(vec3) gl_frag_coord,
    OUT(Length) r, OUT(Number) mu, OUT(Number) mu_s, OUT(Number) nu,
    OUT(bool) ray_r_mu_intersects_ground)
{
  const vec4 SCATTERING_TEXTURE_SIZE = vec4(
      SCATTERING_TEXTURE_NU_SIZE - 1,
      SCATTERING_TEXTURE_MU_S_SIZE,
      SCATTERING_TEXTURE_MU_SIZE,
      SCATTERING_TEXTURE_R_SIZE);
  Number frag_coord_nu = floor(gl_frag_coord.x / Number(SCATTERING_TEXTURE_MU_S_SIZE));
  Number frag_coord_mu_s = fmod(gl_frag_coord.x, Number(SCATTERING_TEXTURE_MU_S_SIZE));

  vec4 uvwz = vec4(frag_coord_nu, frag_coord_mu_s, gl_frag_coord.y, gl_frag_coord.z) / SCATTERING_TEXTURE_SIZE;

  GetRMuMuSNuFromScatteringTextureUvwz(atmosphere, uvwz, r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  // Clamp nu to its valid range of values, given mu and mu_s.
  float root = sqrt((1.0 - mu * mu) * (1.0 - mu_s * mu_s));
  nu = clamp(nu, mu * mu_s - root, mu * mu_s + root);
}

/*
<p>With this mapping, we can finally write a function to precompute a texel of
the single scattering in a 3D texture:
*/

void ComputeSingleScatteringTexture(IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture, IN(vec3) gl_frag_coord,
    OUT(IrradianceSpectrum) rayleigh, OUT(IrradianceSpectrum) mie) {
  Length r;
  Number mu;
  Number mu_s;
  Number nu;
  bool ray_r_mu_intersects_ground;
  GetRMuMuSNuFromScatteringTextureFragCoord(atmosphere, gl_frag_coord,
      r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  ComputeSingleScattering(atmosphere, transmittance_texture,
      r, mu, mu_s, nu, ray_r_mu_intersects_ground, rayleigh, mie);
}

/*
<h4 id="single_scattering_lookup">Lookup</h4>

<p>With the help of the above precomputed texture, we can now get the scattering
between a point and the nearest atmosphere boundary with two texture lookups (we
need two 3D texture lookups to emulate a single 4D texture lookup with
quadrilinear interpolation; the 3D texture coordinates are computed using the
inverse of the 3D-4D mapping defined in
<code>GetRMuMuSNuFromScatteringTextureFragCoord</code>):
*/

TEMPLATE(AbstractSpectrum)
AbstractSpectrum GetScattering(
    IN(AtmosphereParameters) atmosphere,
    IN(AbstractScatteringTexture TEMPLATE_ARGUMENT(AbstractSpectrum))
        scattering_texture,
    Length r, Number mu, Number mu_s, Number nu,
    bool ray_r_mu_intersects_ground) {
  vec4 uvwz = GetScatteringTextureUvwzFromRMuMuSNu(
      atmosphere, r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  Number tex_coord_x = uvwz.x * Number(SCATTERING_TEXTURE_NU_SIZE - 1);
  Number tex_x = floor(tex_coord_x);
  Number lerp = tex_coord_x - tex_x;
  vec3 uvw0 = vec3((tex_x + uvwz.y) / Number(SCATTERING_TEXTURE_NU_SIZE),
      uvwz.z, uvwz.w);
  vec3 uvw1 = vec3((tex_x + 1.0 + uvwz.y) / Number(SCATTERING_TEXTURE_NU_SIZE),
      uvwz.z, uvwz.w);
  return AbstractSpectrum(SampleTexture3D(scattering_texture, uvw0).rgb * (1.0 - lerp) +
      SampleTexture3D(scattering_texture, uvw1).rgb * lerp);
}

/*
<p>Finally, we provide here a convenience lookup function which will be useful
in the next section. This function returns either the single scattering, with
the phase functions included, or the $n$-th order of scattering, with $n>1$. It
assumes that, if <code>scattering_order</code> is strictly greater than 1, then
<code>multiple_scattering_texture</code> corresponds to this scattering order,
with both Rayleigh and Mie included, as well as all the phase function terms.
*/

RadianceSpectrum GetScattering(
    IN(AtmosphereParameters) atmosphere,
    IN(ReducedScatteringTexture) single_rayleigh_scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    IN(ScatteringTexture) multiple_scattering_texture,
    Length r, Number mu, Number mu_s, Number nu,
    bool ray_r_mu_intersects_ground,
    uniform int scattering_order) {
  if (scattering_order == 1) {
    IrradianceSpectrum rayleigh = GetScattering(atmosphere, single_rayleigh_scattering_texture, r, mu, mu_s, nu, ray_r_mu_intersects_ground);
    IrradianceSpectrum mie		= GetScattering(atmosphere, single_mie_scattering_texture, 		r, mu, mu_s, nu, ray_r_mu_intersects_ground);
    return rayleigh * RayleighPhaseFunction(nu) + mie * MiePhaseFunction(atmosphere.mie_phase_function_g, nu);
  } else {
    return GetScattering(atmosphere, multiple_scattering_texture, r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  }
}

/*
<h3 id="multiple_scattering">Multiple scattering</h3>

<p>The multiply scattered radiance is the light arriving from the Sun at some
point in the atmosphere after two or more <i>bounces</i> (where a bounce is
either a scattering event or a reflection from the ground). The following
sections describe how we compute it, how we store it in a precomputed texture,
and how we read it back.

<p>Note that, as for single scattering, we exclude here the light paths whose
<i>last</i> bounce is a reflection on the ground. The contribution from these
paths is computed separately, at rendering time, in order to take the actual
ground albedo into account (for intermediate reflections on the ground, which
are precomputed, we use an average, uniform albedo).

<h4 id="multiple_scattering_computation">Computation</h4>

<p>Multiple scattering can be decomposed into the sum of double scattering,
triple scattering, etc, where each term corresponds to the light arriving from
the Sun at some point in the atmosphere after <i>exactly</i> 2, 3, etc bounces.
Moreover, each term can be computed from the previous one. Indeed, the light
arriving at some point $\bp$ from direction $\bw$ after $n$ bounces is an
integral over all the possible points $\bq$ for the last bounce, which involves
the light arriving at $\bq$ from any direction, after $n-1$ bounces.

<p>This description shows that each scattering order requires a triple integral
to be computed from the previous one (one integral over all the points $\bq$
on the segment from $\bp$ to the nearest atmosphere boundary in direction $\bw$,
and a nested double integral over all directions at each point $\bq$).
Therefore, if we wanted to compute each order "from scratch", we would need a
triple integral for double scattering, a sextuple integral for triple
scattering, etc. This would be clearly inefficient, because of all the redundant
computations (the computations for order $n$ would basically redo all the
computations for all previous orders, leading to quadratic complexity in the
total number of orders). Instead, it is much more efficient to proceed as
follows:
<ul>
<li>precompute single scattering in a texture (as described above),</li>
<li>for $n \ge 2$:
<ul>
<li>precompute the $n$-th scattering in a texture, with a triple integral whose
integrand uses lookups in the $(n-1)$-th scattering texture</li>
</ul>
</li>
</ul>

<p>This strategy avoids many redundant computations but does not eliminate all
of them. Consider for instance the points $\bp$ and $\bp'$ in the figure below,
and the computations which are necessary to compute the light arriving at these
two points from direction $\bw$ after $n$ bounces. These computations involve,
in particular, the evaluation of the radiance $L$ which is scattered at $\bq$ in
direction $-\bw$, and coming from all directions after $n-1$ bounces:

<svg width="340px" height="150px">
  <style type="text/css"><![CDATA[
    circle { fill: #000000; stroke: none; }
    path { fill: none; stroke: #000000; }
    text { font-size: 16px; font-style: normal; font-family: Sans; }
    .vector { font-weight: bold; }
  ]]></style>
  <path d="m 0,26 a 600,600 0 0 1 340,0"/>
  <path d="m 0,110 a 520,520 0 0 1 340,0"/>
  <path d="m 170,140 0,-135"/>
  <path d="m 20,80 200,-40" />
  <path d="m 209,39 11,1 -10,5" />
  <circle cx="70" cy="70" r="2.5"/>
  <circle cx="120" cy="60" r="2.5"/>
  <circle cx="170" cy="50" r="2.5"/>
  <text x="65" y="60" class="vector">p</text>
  <text x="175" y="65" class="vector">q</text>
  <text x="225" y="35" class="vector">ω</text>
  <text x="115" y="50" class="vector">p<tspan
     style="font-weight:normal;">'</tspan></text>
</svg>

<p>Therefore, if we computed the n-th scattering with a triple integral as
described above, we would compute $L$ redundantly (in fact, for all points $\bp$
between $\bq$ and the nearest atmosphere boundary in direction $-\bw$). To avoid
this, and thus increase the efficiency of the multiple scattering computations,
we refine the above algorithm as follows:
<ul>
<li>precompute single scattering in a texture (as described above),</li>
<li>for $n \ge 2$:
<ul>
<li>for each point $\bq$ and direction $\bw$, precompute the light which is
scattered at $\bq$ towards direction $-\bw$, coming from any direction after
$n-1$ bounces (this involves only a double integral, whose integrand uses
lookups in the $(n-1)$-th scattering texture),</li>
<li>for each point $\bp$ and direction $\bw$, precompute the light coming from
direction $\bw$ after $n$ bounces (this involves only a single integral, whose
integrand uses lookups in the texture computed at the previous line)</li>
</ul>
</li>
</ul>

<p>To get a complete algorithm, we must now specify how we implement the two
steps in the above loop. This is what we do in the rest of this section.

<h5 id="multiple_scattering_first_step">First step</h5>

<p>The first step computes the radiance which is scattered at some point $\bq$
inside the atmosphere, towards some direction $-\bw$. Furthermore, we assume
that this scattering event is the $n$-th bounce.

<p>This radiance is the integral over all the possible incident directions
$\bw_i$, of the product of
<ul>
<li>the incident radiance $L_i$ arriving at $\bq$ from direction $\bw_i$ after
$n-1$ bounces, which is the sum of:
<ul>
<li>a term given by the precomputed scattering texture for the $(n-1)$-th
order,</li>
<li>if the ray $[\bq, \bw_i)$ intersects the ground at $\br$, the contribution
from the light paths with $n-1$ bounces and whose last bounce is at $\br$, i.e.
on the ground (these paths are excluded, by definition, from our precomputed
textures, but we must take them into account here since the bounce on the ground
is followed by a bounce at $\bq$). This contribution, in turn, is the product
of:
<ul>
<li>the transmittance between $\bq$ and $\br$,</li>
<li>the (average) ground albedo,</li>
<li>the <a href="https://www.cs.princeton.edu/~smr/cs348c-97/surveypaper.html"
>Lambertian BRDF</a> $1/\pi$,</li>
<li>the irradiance received on the ground after $n-2$ bounces. We explain in the
<a href="#irradiance">next section</a> how we precompute it in a texture. For
now, we assume that we can use the following function to retrieve this
irradiance from a precomputed texture:
</li>
</ul>
</li>
</ul>
</li>
</ul>
*/

IrradianceSpectrum GetIrradiance(
    IN(AtmosphereParameters) atmosphere,
    IN(IrradianceTexture) irradiance_texture,
    Length r, Number mu_s);


float3 getFibonacchiSpherePoint(int i, uniform int count)
{
	const float r8_phi = (1.0 + sqrt(5.0)) / 2.0;
	float cnt = (float)count;

	float i_r8 = (float)(-count + 1 + 2 * i);
	float theta = 2.0 * atmPI * i_r8 / r8_phi;
	float sphi = i_r8 / cnt;
	float cphi = sqrt((cnt + i_r8) * (cnt - i_r8)) / cnt;
	// return float3(cphi * sin(theta), sphi, cphi * cos(theta));
	return float3(cphi * sin(theta), cphi * cos(theta), sphi);
}


/*
<ul>
<li>the scattering coefficient at $\bq$,</li>
<li>the scattering phase function for the directions $\bw$ and $\bw_i$</li>
</ul>
This leads to the following implementation (where
<code>multiple_scattering_texture</code> is supposed to contain the $(n-1)$-th
order of scattering, if $n>2$, <code>irradiance_texture</code> is the irradiance
received on the ground after $n-2$ bounces, and <code>scattering_order</code> is
equal to $n$):</li>
*/

RadianceDensitySpectrum ComputeScatteringDensity(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) single_rayleigh_scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    IN(ScatteringTexture) multiple_scattering_texture,
    IN(IrradianceTexture) irradiance_texture,
    Length r, Number mu, Number mu_s, Number nu, int scattering_order) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  assert(mu_s >= -1.0 && mu_s <= 1.0);
  assert(nu >= -1.0 && nu <= 1.0);
  assert(scattering_order >= 2);

  // Compute unit direction vectors for the zenith, the view direction omega and
  // and the sun direction omega_s, such that the cosine of the view-zenith
  // angle is mu, the cosine of the sun-zenith angle is mu_s, and the cosine of
  // the view-sun angle is nu. The goal is to simplify computations below.
  vec3 zenith_direction = vec3(0.0, 0.0, 1.0);
  vec3 omega = vec3(sqrt(1.0 - mu * mu), 0.0, mu);
  Number sun_dir_x = omega.x == 0.0 ? 0.0 : (nu - mu * mu_s) / omega.x;
  Number sun_dir_y = sqrt(max(1.0 - sun_dir_x * sun_dir_x - mu_s * mu_s, 0.0));
  vec3 omega_s = vec3(sun_dir_x, sun_dir_y, mu_s);

  RadianceDensitySpectrum rayleigh_mie = RadianceDensitySpectrum(0.0, 0.0, 0.0) * watt_per_cubic_meter_per_sr_per_nm;

#ifdef SCATTERING_UNIFORM_SAMPLING

  // const uint SAMPLE_COUNT = 200;
  const uint SAMPLE_COUNT = 2 * SCATTERING_DENSITY_SAMPLES * SCATTERING_DENSITY_SAMPLES;

  SolidAngle domega_i = 1.0 / SAMPLE_COUNT;

  float scatteringRayleigh = atmosphere.rayleigh_scattering * GetDensityRayleigh(atmosphere, r);
  float scatteringMie = atmosphere.mie_scattering * GetDensityMie(atmosphere, r);

  // Nested loops for the integral over all the incident directions omega_i.
  for (uint l = 0; l < SAMPLE_COUNT; ++l)
  {
	vec3 omega_i = getFibonacchiSpherePoint(l, SAMPLE_COUNT);

    Number cos_theta = omega_i.z;

    bool ray_r_theta_intersects_ground = RayIntersectsGround(atmosphere, r, cos_theta);

    // The distance and transmittance to the ground only depend on theta, so we
    // can compute them in the outer loop for efficiency.
    Length distance_to_ground = 0.0 * m;
    DimensionlessSpectrum transmittance_to_ground = DimensionlessSpectrum(0.0, 0.0, 0.0);
    DimensionlessSpectrum ground_albedo = DimensionlessSpectrum(0.0, 0.0, 0.0);
    if (ray_r_theta_intersects_ground) {
      distance_to_ground = DistanceToBottomAtmosphereBoundary(atmosphere, r, cos_theta);
      transmittance_to_ground = GetTransmittance(atmosphere, transmittance_texture, r, cos_theta, distance_to_ground, true /* ray_intersects_ground */);
      ground_albedo = atmosphere.ground_albedo;
    }
	  // The radiance L_i arriving from direction omega_i after n-1 bounces is
	  // the sum of a term given by the precomputed scattering texture for the
	  // (n-1)-th order:
	  Number nu1 = dot(omega_s, omega_i);
	  RadianceSpectrum incident_radiance = GetScattering(atmosphere,
		  single_rayleigh_scattering_texture, single_mie_scattering_texture,
		  multiple_scattering_texture, r, omega_i.z, mu_s, nu1,
		  ray_r_theta_intersects_ground, scattering_order - 1);

	  // and of the contribution from the light paths with n-1 bounces and whose
	  // last bounce is on the ground. This contribution is the product of the
	  // transmittance to the ground, the ground albedo, the ground BRDF, and
	  // the irradiance received on the ground after n-2 bounces.
	  vec3 ground_normal = normalize(zenith_direction * r + omega_i * distance_to_ground);
	  IrradianceSpectrum ground_irradiance = GetIrradiance(atmosphere, irradiance_texture, atmosphere.bottom_radius, dot(ground_normal, omega_s));
	  incident_radiance += transmittance_to_ground * ground_albedo * (1.0 / (atmPI * sr)) * ground_irradiance;

	  // The radiance finally scattered from direction omega_i towards direction
	  // -omega is the product of the incident radiance, the scattering
	  // coefficient, and the phase function for directions omega and omega_i
	  // (all this summed over all particle types, i.e. Rayleigh and Mie).
	  Number nu2 = dot(omega, omega_i);
	  rayleigh_mie += incident_radiance * 
		(
			scatteringRayleigh * RayleighPhaseFunction(nu2) +
			scatteringMie * MiePhaseFunction(atmosphere.mie_phase_function_g, nu2)
		);
  }
  return rayleigh_mie * domega_i;







#else
  const uint SAMPLE_COUNT = SCATTERING_DENSITY_SAMPLES;
  const Angle dphi = pi / Number(SAMPLE_COUNT);
  const Angle dtheta = pi / Number(SAMPLE_COUNT);

  // Nested loops for the integral over all the incident directions omega_i.
  for (uint l = 0; l < SAMPLE_COUNT; ++l) {
    Angle theta = (Number(l) + 0.5) * dtheta;
    Number cos_theta = cos(theta);
    Number sin_theta = sin(theta);
    bool ray_r_theta_intersects_ground = RayIntersectsGround(atmosphere, r, cos_theta);

    // The distance and transmittance to the ground only depend on theta, so we
    // can compute them in the outer loop for efficiency.
    Length distance_to_ground = 0.0 * m;
    DimensionlessSpectrum transmittance_to_ground = DimensionlessSpectrum(0.0, 0.0, 0.0);
    DimensionlessSpectrum ground_albedo = DimensionlessSpectrum(0.0, 0.0, 0.0);
    if (ray_r_theta_intersects_ground) {
      distance_to_ground =
          DistanceToBottomAtmosphereBoundary(atmosphere, r, cos_theta);
      transmittance_to_ground =
          GetTransmittance(atmosphere, transmittance_texture, r, cos_theta,
              distance_to_ground, true /* ray_intersects_ground */);
      ground_albedo = atmosphere.ground_albedo;
    }

    for (uint m = 0; m < 2 * SAMPLE_COUNT; ++m)
	{
      Angle phi = (Number(m) + 0.5) * dphi;
      vec3 omega_i = vec3(cos(phi) * sin_theta, sin(phi) * sin_theta, cos_theta);
      SolidAngle domega_i = (dtheta / rad) * (dphi / rad) * sin(theta) * sr;

      // The radiance L_i arriving from direction omega_i after n-1 bounces is
      // the sum of a term given by the precomputed scattering texture for the
      // (n-1)-th order:
      Number nu1 = dot(omega_s, omega_i);
      RadianceSpectrum incident_radiance = GetScattering(atmosphere,
          single_rayleigh_scattering_texture, single_mie_scattering_texture,
          multiple_scattering_texture, r, omega_i.z, mu_s, nu1,
          ray_r_theta_intersects_ground, scattering_order - 1);

      // and of the contribution from the light paths with n-1 bounces and whose
      // last bounce is on the ground. This contribution is the product of the
      // transmittance to the ground, the ground albedo, the ground BRDF, and
      // the irradiance received on the ground after n-2 bounces.
      vec3 ground_normal =
          normalize(zenith_direction * r + omega_i * distance_to_ground);
      IrradianceSpectrum ground_irradiance = GetIrradiance(
          atmosphere, irradiance_texture, atmosphere.bottom_radius,
          dot(ground_normal, omega_s));
      incident_radiance += transmittance_to_ground * ground_albedo * (1.0 / (atmPI * sr)) * ground_irradiance;

      // The radiance finally scattered from direction omega_i towards direction
      // -omega is the product of the incident radiance, the scattering
      // coefficient, and the phase function for directions omega and omega_i
      // (all this summed over all particle types, i.e. Rayleigh and Mie).
      Number nu2 = dot(omega, omega_i);
      rayleigh_mie += incident_radiance * (
          atmosphere.rayleigh_scattering * GetDensityRayleigh(atmosphere, r) *
              RayleighPhaseFunction(nu2) +
          atmosphere.mie_scattering * GetDensityMie(atmosphere, r) *
              MiePhaseFunction(atmosphere.mie_phase_function_g, nu2)) *
          domega_i;
    }
  }
  return rayleigh_mie;
 #endif
}

/*
<h5 id="multiple_scattering_second_step">Second step</h5>

<p>The second step to compute the $n$-th order of scattering is to compute for
each point $\bp$ and direction $\bw$, the radiance coming from direction $\bw$
after $n$ bounces, using a texture precomputed with the previous function.

<p>This radiance is the integral over all points $\bq$ between $\bp$ and the
nearest atmosphere boundary in direction $\bw$ of the product of:
<ul>
<li>a term given by a texture precomputed with the previous function, namely
the radiance scattered at $\bq$ towards $\bp$, coming from any direction after
$n-1$ bounces,</li>
<li>the transmittance betweeen $\bp$ and $\bq$</li>
</ul>
Note that this excludes the light paths with $n$ bounces and whose last
bounce is on the ground, on purpose. Indeed, we chose to exclude these paths
from our precomputed textures so that we can compute them at render time
instead, using the actual ground albedo.

<p>The implementation for this second step is straightforward:
*/

RadianceSpectrum ComputeMultipleScattering(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ScatteringDensityTexture) scattering_density_texture,
    Length r, Number mu, Number mu_s, Number nu,
    bool ray_r_mu_intersects_ground) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  assert(mu_s >= -1.0 && mu_s <= 1.0);
  assert(nu >= -1.0 && nu <= 1.0);

  // Number of intervals for the numerical integration.
  const int SAMPLE_COUNT = MULTIPLE_SCATTERING_SAMPLES;
  // The integration step, i.e. the length of each integration interval.
  Length dx =
      DistanceToNearestAtmosphereBoundary(
          atmosphere, r, mu, ray_r_mu_intersects_ground) /
              Number(SAMPLE_COUNT);
  // Integration loop.
  RadianceSpectrum rayleigh_mie_sum =
      RadianceSpectrum(0.0, 0.0, 0.0) * watt_per_square_meter_per_sr_per_nm;
  for (int i = 0; i <= SAMPLE_COUNT; ++i)
  {
    Length d_i = Number(i) * dx;

    // The r, mu and mu_s parameters at the current integration point (see the
    // single scattering section for a detailed explanation).
	AtmPoint p = GetRMuMuSAtDistance(atmosphere, r, mu, mu_s, nu, d_i);

    // The Rayleigh and Mie multiple scattering at the current sample point.
    RadianceSpectrum rayleigh_mie_i =
        GetScattering(atmosphere, scattering_density_texture, p.r, p.mu, p.mu_s, nu,ray_r_mu_intersects_ground) *
			//p.mu<0) *
	#ifdef INTEGRATE_TRANSMITTANCE_WHILE_COMPUTE_SCATTERING
		ComputeTransmittanceToDist(atmosphere, r, mu, d_i);
	#else
        GetTransmittance(atmosphere, transmittance_texture, r, mu, d_i,ray_r_mu_intersects_ground);
	#endif
			//mu<0);
    // Sample weight (from the trapezoidal rule).
    Number weight_i = (i == 0 || i == SAMPLE_COUNT) ? 0.5 : 1.0;
    rayleigh_mie_sum += rayleigh_mie_i * weight_i;
  }
  return rayleigh_mie_sum * dx;
}

/*
<h4 id="multiple_scattering_precomputation">Precomputation</h4>

<p>As explained in the <a href="#multiple_scattering">overall algorithm</a> to
compute multiple scattering, we need to precompute each order of scattering in a
texture to save computations while computing the next order. And, in order to
store a function in a texture, we need a mapping from the function parameters to
texture coordinates. Fortunately, all the orders of scattering depend on the
same $(r,\mu,\mu_s,\nu)$ parameters as single scattering, so we can simple reuse
the mappings defined for single scattering. This immediately leads to the
following simple functions to precompute a texel of the textures for the
<a href="#multiple_scattering_first_step">first</a> and
<a href="#multiple_scattering_second_step">second</a> steps of each iteration
over the number of bounces:
*/

RadianceDensitySpectrum ComputeScatteringDensityTexture(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) single_rayleigh_scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    IN(ScatteringTexture) multiple_scattering_texture,
    IN(IrradianceTexture) irradiance_texture,
    IN(vec3) gl_frag_coord, int scattering_order) {
  Length r;
  Number mu;
  Number mu_s;
  Number nu;
  bool ray_r_mu_intersects_ground;
  GetRMuMuSNuFromScatteringTextureFragCoord(atmosphere, gl_frag_coord,
      r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  return ComputeScatteringDensity(atmosphere, transmittance_texture,
      single_rayleigh_scattering_texture, single_mie_scattering_texture,
      multiple_scattering_texture, irradiance_texture, r, mu, mu_s, nu,
      scattering_order);
}

RadianceSpectrum ComputeMultipleScatteringTexture(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ScatteringDensityTexture) scattering_density_texture,
    IN(vec3) gl_frag_coord, OUT(Number) nu) {
  Length r;
  Number mu;
  Number mu_s;
  bool ray_r_mu_intersects_ground;
  GetRMuMuSNuFromScatteringTextureFragCoord(atmosphere, gl_frag_coord,
      r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  return ComputeMultipleScattering(atmosphere, transmittance_texture,
      scattering_density_texture, r, mu, mu_s, nu,
      ray_r_mu_intersects_ground);
}

/*
<h4 id="multiple_scattering_lookup">Lookup</h4>

<p>Likewise, we can simply reuse the lookup function <code>GetScattering</code>
implemented for single scattering to read a value from the precomputed textures
for multiple scattering. In fact, this is what we did above in the
<code>ComputeScatteringDensity</code> and <code>ComputeMultipleScattering</code>
functions.

<h3 id="irradiance">Ground irradiance</h3>

<p>The ground irradiance is the Sun light received on the ground after $n \ge 0$
bounces (where a bounce is either a scattering event or a reflection on the
ground). We need this for two purposes:
<ul>
<li>while precomputing the $n$-th order of scattering, with $n \ge 2$, in order
to compute the contribution of light paths whose $(n-1)$-th bounce is on the
ground (which requires the ground irradiance after $n-2$ bounces - see the
<a href="#multiple_scattering_computation">Multiple scattering</a>
section),</li>
<li>at rendering time, to compute the contribution of light paths whose last
bounce is on the ground (these paths are excluded, by definition, from our
precomputed scattering textures)</li>
</ul>

<p>In the first case we only need the ground irradiance for horizontal surfaces
at the bottom of the atmosphere (during precomputations we assume a perfectly
spherical ground with a uniform albedo). In the second case, however, we need
the ground irradiance for any altitude and any surface normal, and we want to
precompute it for efficiency. In fact, as described in our
<a href="https://hal.inria.fr/inria-00288758/en">paper</a> we precompute it only
for horizontal surfaces, at any altitude (which requires only 2D textures,
instead of 4D textures for the general case), and we use approximations for
non-horizontal surfaces.

<p>The following sections describe how we compute the ground irradiance, how we
store it in a precomputed texture, and how we read it back.

<h4 id="irradiance_computation">Computation</h4>

<p>The ground irradiance computation is different for the direct irradiance,
i.e. the light received directly from the Sun, without any intermediate bounce,
and for the indirect irradiance (at least one bounce). We start here with the
direct irradiance.

<p>The irradiance is the integral over an hemisphere of the incident radiance,
times a cosine factor. For the direct ground irradiance, the incident radiance
is the Sun radiance at the top of the atmosphere, times the transmittance
through the atmosphere. And, since this radiance is zero outside the small solid
angle of the Sun, we can approximate the irradiance integral with the Sun
radiance, times the Sun solid angle (yielding the solar irradiance), times the
transmittance and the cosine factor for the Sun direction, i.e. $\mu_s$. This
yields the following implementation:
*/

IrradianceSpectrum ComputeDirectIrradiance(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    Length r, Number mu_s)
{
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu_s >= -1.0 && mu_s <= 1.0);

  return atmosphere.solar_irradiance *
      GetTransmittanceToTopAtmosphereBoundary(
          atmosphere, transmittance_texture, r, mu_s) * max(mu_s, 0.0);
}

/*
<p>For the indirect ground irradiance the integral over the hemisphere must be
computed numerically. More precisely we need to compute the integral over all
the directions $\bw$ of the hemisphere, of the product of:
<ul>
<li>the radiance arriving from direction $\bw$ after $n$ bounces,
<li>the cosine factor, i.e. $\omega_z$</li>
</ul>
This leads to the following implementation (where
<code>multiple_scattering_texture</code> is supposed to contain the $n$-th
order of scattering, if $n>1$, and <code>scattering_order</code> is equal to
$n$):</li>
*/

IrradianceSpectrum ComputeIndirectIrradiance(
    IN(AtmosphereParameters) atmosphere,
    IN(ReducedScatteringTexture) single_rayleigh_scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    IN(ScatteringTexture) multiple_scattering_texture,
    Length r, Number mu_s, uniform int scattering_order) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu_s >= -1.0 && mu_s <= 1.0);
  assert(scattering_order >= 1);

  const uint SAMPLE_COUNT = INDIRECT_IRRADIANCE_SAMPLES;
  const Angle dphi = pi / Number(SAMPLE_COUNT);
  const Angle dtheta = pi / Number(SAMPLE_COUNT);

  IrradianceSpectrum result =
      IrradianceSpectrum(0.0, 0.0, 0.0) * watt_per_square_meter_per_nm;
  vec3 omega_s = vec3(sqrt(1.0 - mu_s * mu_s), 0.0, mu_s);
  for (uint j = 0; j < SAMPLE_COUNT / 2; ++j) {
    Angle theta = (Number(j) + 0.5) * dtheta;
    //bool ray_r_theta_intersects_ground = RayIntersectsGround(atmosphere, r, cos(theta));
    for (uint i = 0; i < 2 * SAMPLE_COUNT; ++i) {
      Angle phi = (Number(i) + 0.5) * dphi;
      vec3 omega =
          vec3(cos(phi) * sin(theta), sin(phi) * sin(theta), cos(theta));
      SolidAngle domega = (dtheta / rad) * (dphi / rad) * sin(theta) * sr;

      Number nu = dot(omega, omega_s);
      result += GetScattering(atmosphere, single_rayleigh_scattering_texture,
          single_mie_scattering_texture, multiple_scattering_texture,
          r, omega.z, mu_s, nu, false/*ray_r_theta_intersects_ground*/,
          scattering_order) *
              omega.z * domega;
    }
  }
  return result;
}

/*
<h4 id="irradiance_precomputation">Precomputation</h4>

<p>In order to precompute the ground irradiance in a texture we need a mapping
from the ground irradiance parameters to texture coordinates. Since we
precompute the ground irradiance only for horizontal surfaces, this irradiance
depends only on $r$ and $\mu_s$, so we need a mapping from $(r,\mu_s)$ to
$(u,v)$ texture coordinates. The simplest, affine mapping is sufficient here,
because the ground irradiance function is very smooth:
*/

vec2 GetIrradianceTextureUvFromRMuS(IN(AtmosphereParameters) atmosphere,
    Length r, Number mu_s) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu_s >= -1.0 && mu_s <= 1.0);
  Number x_r = (r - atmosphere.bottom_radius) /
      (atmosphere.top_radius - atmosphere.bottom_radius);
  Number x_mu_s = mu_s * 0.5 + 0.5;
  return vec2(GetTextureCoordFromUnitRange(x_mu_s, IRRADIANCE_TEXTURE_WIDTH),
              GetTextureCoordFromUnitRange(x_r, IRRADIANCE_TEXTURE_HEIGHT));
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//              GetTextureCoordFromUnitRange(SafeSqrt(x_r), IRRADIANCE_TEXTURE_HEIGHT));
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

}

/*
<p>The inverse mapping follows immediately:
*/

void GetRMuSFromIrradianceTextureUv(IN(AtmosphereParameters) atmosphere,
    IN(vec2) uv, OUT(Length) r, OUT(Number) mu_s) {
  assert(uv.x >= 0.0 && uv.x <= 1.0);
  assert(uv.y >= 0.0 && uv.y <= 1.0);
  Number x_mu_s = GetUnitRangeFromTextureCoord(uv.x, IRRADIANCE_TEXTURE_WIDTH);
  Number x_r = GetUnitRangeFromTextureCoord(uv.y, IRRADIANCE_TEXTURE_HEIGHT);
  r = atmosphere.bottom_radius +
      x_r * (atmosphere.top_radius - atmosphere.bottom_radius);
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      //x_r * x_r * (atmosphere.top_radius - atmosphere.bottom_radius);
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  mu_s = ClampCosine(2.0 * x_mu_s - 1.0);
}

/*
<p>It is now easy to define a fragment shader function to precompute a texel of
the ground irradiance texture, for the direct irradiance:
*/

static const vec2 IRRADIANCE_TEXTURE_SIZE = vec2(IRRADIANCE_TEXTURE_WIDTH, IRRADIANCE_TEXTURE_HEIGHT);

IrradianceSpectrum ComputeDirectIrradianceTexture(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(vec2) gl_frag_coord) {
  Length r;
  Number mu_s;
  GetRMuSFromIrradianceTextureUv(
      atmosphere, gl_frag_coord / IRRADIANCE_TEXTURE_SIZE, r, mu_s);
  return ComputeDirectIrradiance(atmosphere, transmittance_texture, r, mu_s);
}

/*
<p>and the indirect one:
*/

IrradianceSpectrum ComputeIndirectIrradianceTexture(
    IN(AtmosphereParameters) atmosphere,
    IN(ReducedScatteringTexture) single_rayleigh_scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    IN(ScatteringTexture) multiple_scattering_texture,
    IN(vec2) gl_frag_coord, int scattering_order) {
  Length r;
  Number mu_s;
  GetRMuSFromIrradianceTextureUv(
      atmosphere, gl_frag_coord / IRRADIANCE_TEXTURE_SIZE, r, mu_s);
  return ComputeIndirectIrradiance(atmosphere,
      single_rayleigh_scattering_texture, single_mie_scattering_texture,
      multiple_scattering_texture, r, mu_s, scattering_order);
}

/*
<h4 id="irradiance_lookup">Lookup</h4>

<p>Thanks to these precomputed textures, we can now get the ground irradiance
with a single texture lookup:
*/

IrradianceSpectrum GetIrradiance(
    IN(AtmosphereParameters) atmosphere,
    IN(IrradianceTexture) irradiance_texture,
    Length r, Number mu_s) {
  vec2 uv = GetIrradianceTextureUvFromRMuS(atmosphere, r, mu_s);
  return IrradianceSpectrum(SampleTexture2D(irradiance_texture, uv).rgb);
}

/*
<h3 id="rendering">Rendering</h3>

<p>Here we assume that the transmittance, scattering and irradiance textures
have been precomputed, and we provide functions using them to compute the sky
color, the aerial perspective, and the ground radiance.

<p>More precisely, we assume that the single Rayleigh scattering, without its
phase function term, plus the multiple scattering terms (divided by the Rayleigh
phase function for dimensional homogeneity) are stored in a
<code>scattering_texture</code>. We also assume that the single Mie scattering
is stored, without its phase function term:
<ul>
<li>either separately, in a <code>single_mie_scattering_texture</code> (this
option was not provided our <a href=
"http://evasion.inrialpes.fr/~Eric.Bruneton/PrecomputedAtmosphericScattering2.zip"
>original implementation</a>),</li>
<li>or, if the <code>COMBINED_SCATTERING_TEXTURES</code> preprocessor
macro is defined, in the <code>scattering_texture</code>. In this case, which is
only available with a GLSL compiler, Rayleigh and multiple scattering are stored
in the RGB channels, and the red component of the single Mie scattering is
stored in the alpha channel).</li>
</ul>

<p>In the second case, the green and blue components of the single Mie
scattering are extrapolated as described in our
<a href="https://hal.inria.fr/inria-00288758/en">paper</a>, with the following
function:
*/

#ifdef COMBINED_SCATTERING_TEXTURES
vec3 GetExtrapolatedSingleMieScattering(
    IN(AtmosphereParameters) atmosphere, IN(vec4) scattering) {
  if (scattering.r == 0.0) {
    return vec3(0.0, 0.0, 0.0);
  }
  return scattering.rgb * atmosphere.scatteringToSingleMie * (scattering.a / (scattering.r+1.0e-3));
	    // (atmosphere.rayleigh_scattering.r / atmosphere.mie_scattering.r) *
	    // (atmosphere.mie_scattering / atmosphere.rayleigh_scattering);
}
#endif

/*
<p>We can then retrieve all the scattering components (Rayleigh + multiple
scattering on one side, and single Mie scattering on the other side) with the
following function, based on
<a href="#single_scattering_lookup"><code>GetScattering</code></a> (we duplicate
some code here, instead of using two calls to <code>GetScattering</code>, to
make sure that the texture coordinates computation is shared between the lookups
in <code>scattering_texture</code> and
<code>single_mie_scattering_texture</code>):
*/

IrradianceSpectrum GetCombinedScattering(
    IN(AtmosphereParameters) atmosphere,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    Length r, Number mu, Number mu_s, Number nu,
    bool ray_r_mu_intersects_ground,
    OUT(IrradianceSpectrum) single_mie_scattering)
{
  vec4 uvwz = GetScatteringTextureUvwzFromRMuMuSNu(
      atmosphere, r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  Number tex_coord_x = uvwz.x * Number(SCATTERING_TEXTURE_NU_SIZE - 1);
  Number tex_x = floor(tex_coord_x);
  Number lerp = tex_coord_x - tex_x;
  vec3 uvw0 = vec3((tex_x + uvwz.y) / Number(SCATTERING_TEXTURE_NU_SIZE),
      uvwz.z, uvwz.w);
  vec3 uvw1 = vec3((tex_x + 1.0 + uvwz.y) / Number(SCATTERING_TEXTURE_NU_SIZE),
      uvwz.z, uvwz.w);
#ifdef COMBINED_SCATTERING_TEXTURES
#ifdef RESOLVED_SCATTERING
  uvwz.x = GetTextureCoordFromUnitRange(uvwz.x, SCATTERING_TEXTURE_NU_SIZE);
  vec4 combined_scattering = SampleTexture3D(scattering_texture, uvwz.xzw);
#else
  vec4 combined_scattering = max(0, 
      SampleTexture3D(scattering_texture, uvw0) * (1.0 - lerp) +
      SampleTexture3D(scattering_texture, uvw1) * lerp);
#endif
  IrradianceSpectrum scattering = IrradianceSpectrum(combined_scattering.rgb);
  single_mie_scattering = GetExtrapolatedSingleMieScattering(atmosphere, combined_scattering);
#else//separated rayleigh/mie scattering textures
  IrradianceSpectrum scattering = IrradianceSpectrum(
      SampleTexture3D(scattering_texture, uvw0).rgb * (1.0 - lerp) +
      SampleTexture3D(scattering_texture, uvw1).rgb * lerp);
  single_mie_scattering = IrradianceSpectrum(
      SampleTexture3D(single_mie_scattering_texture, uvw0).rgb * (1.0 - lerp) +
      SampleTexture3D(single_mie_scattering_texture, uvw1).rgb * lerp);
#endif
  return scattering;
}

/*
<h4 id="rendering_sky">Sky</h4>

<p>To render the sky we simply need to display the sky radiance, which we can
get with a lookup in the precomputed scattering SampleTexture2D(s), multiplied by the
phase function terms that were omitted during precomputation. We can also return
the transmittance of the atmosphere (which we can get with a single lookup in
the precomputed transmittance texture), which is needed to correctly render the
objects in space (such as the Sun and the Moon). This leads to the following
function, where most of the computations are used to correctly handle the case
of viewers outside the atmosphere, and the case of light shafts:
*/

RadianceSpectrum GetSkyRadianceInternal(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    IN(Length) r, IN(Number) mu, IN(Number) mu_s, IN(Number) nu, Length shadow_length,
    IN(Direction) sun_direction, OUT(DimensionlessSpectrum) transmittance)
{  
  bool ray_r_mu_intersects_ground = RayIntersectsGround(atmosphere, r, mu);

  transmittance = ray_r_mu_intersects_ground ? DimensionlessSpectrum(0.0, 0.0, 0.0) :
      GetTransmittanceToTopAtmosphereBoundary(
          atmosphere, transmittance_texture, r, mu);
  IrradianceSpectrum single_mie_scattering;
  IrradianceSpectrum scattering;
  if (shadow_length == 0.0 * m) {
    scattering = GetCombinedScattering(
        atmosphere, scattering_texture, single_mie_scattering_texture,
        r, mu, mu_s, nu, ray_r_mu_intersects_ground,
        single_mie_scattering);
  } else {
    // Case of light shafts (shadow_length is the total length noted l in our
    // paper): we omit the scattering between the camera and the point at
    // distance l, by implementing Eq. (18) of the paper (shadow_transmittance
    // is the T(x,x_s) term, scattering is the S|x_s=x+lv term).
    Length d = shadow_length;
	AtmPoint p = GetRMuMuSAtDistance(atmosphere, r, mu, mu_s, nu, d);

    scattering = GetCombinedScattering(
        atmosphere, scattering_texture, single_mie_scattering_texture,
        p.r, p.mu, p.mu_s, nu, ray_r_mu_intersects_ground,
        single_mie_scattering);
    DimensionlessSpectrum shadow_transmittance =
        GetTransmittance(atmosphere, transmittance_texture,
            r, mu, shadow_length, ray_r_mu_intersects_ground);
    scattering = scattering * shadow_transmittance;
    single_mie_scattering = single_mie_scattering * shadow_transmittance;
  }
#ifdef ENABLE_MIE_SCATTERING
  return scattering * RayleighPhaseFunction(nu) + single_mie_scattering * MiePhaseFunction(atmosphere.mie_phase_function_g, nu);
#else
  return scattering * RayleighPhaseFunction(nu);
#endif
}

RadianceSpectrum GetSkyRadianceInternal(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    IN(Length) r, IN(Number) mu, IN(Number) mu_s, IN(Number) nu, Length shadow_length,
    IN(Direction) sun_direction, OUT(DimensionlessSpectrum) transmittance, OUT(RadianceSpectrum)singleMieScattering)
{  
  bool ray_r_mu_intersects_ground = RayIntersectsGround(atmosphere, r, mu);

  transmittance = ray_r_mu_intersects_ground ? DimensionlessSpectrum(0.0, 0.0, 0.0) :
      GetTransmittanceToTopAtmosphereBoundary(
          atmosphere, transmittance_texture, r, mu);
  IrradianceSpectrum single_mie_scattering;
  IrradianceSpectrum scattering;
  if (shadow_length == 0.0 * m) {
    scattering = GetCombinedScattering(
        atmosphere, scattering_texture, single_mie_scattering_texture,
        r, mu, mu_s, nu, ray_r_mu_intersects_ground,
        single_mie_scattering);
  } else {
    // Case of light shafts (shadow_length is the total length noted l in our
    // paper): we omit the scattering between the camera and the point at
    // distance l, by implementing Eq. (18) of the paper (shadow_transmittance
    // is the T(x,x_s) term, scattering is the S|x_s=x+lv term).
    Length d = shadow_length;
	AtmPoint p = GetRMuMuSAtDistance(atmosphere, r, mu, mu_s, nu, d);

    scattering = GetCombinedScattering(
        atmosphere, scattering_texture, single_mie_scattering_texture,
        p.r, p.mu, p.mu_s, nu, ray_r_mu_intersects_ground,
        single_mie_scattering);
    DimensionlessSpectrum shadow_transmittance =
        GetTransmittance(atmosphere, transmittance_texture,
            r, mu, shadow_length, ray_r_mu_intersects_ground);
    scattering = scattering * shadow_transmittance;
    single_mie_scattering = single_mie_scattering * shadow_transmittance;
  }
  singleMieScattering = single_mie_scattering;
#ifdef ENABLE_MIE_SCATTERING
  return scattering * RayleighPhaseFunction(nu) + single_mie_scattering * MiePhaseFunction(atmosphere.mie_phase_function_g, nu);
#else
  return scattering * RayleighPhaseFunction(nu);
#endif
}

RadianceSpectrum GetSkyRadiance(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    ATMPosition camera, IN(Direction) view_ray, Length shadow_length,
    IN(Direction) sun_direction, OUT(DimensionlessSpectrum) transmittance)
{
  // Compute the distance to the top atmosphere boundary along the view ray,
  // assuming the viewer is in space (or NaN if the view ray does not intersect
  // the atmosphere).
  Length r = length(camera);
  Length rmu = dot(camera, view_ray);
  
#ifndef NO_OUTER_SPACE
  Length distance_to_top_atmosphere_boundary = -rmu -
      sqrt(rmu * rmu - r * r + atmosphere.top_radius * atmosphere.top_radius);
  // If the viewer is in space and the view ray intersects the atmosphere, move
  // the viewer to the top atmosphere boundary (along the view ray):
  if (distance_to_top_atmosphere_boundary > 0.0 * m) {
    camera = camera + view_ray * distance_to_top_atmosphere_boundary;
    r = atmosphere.top_radius;
    rmu += distance_to_top_atmosphere_boundary;
  }
  else if (r > atmosphere.top_radius) {
    // If the view ray does not intersect the atmosphere, simply return 0.
    transmittance = DimensionlessSpectrum(1.0, 1.0, 1.0);
    return RadianceSpectrum(0.0, 0.0, 0.0) * watt_per_square_meter_per_sr_per_nm;
  }
#endif

  // Compute the r, mu, mu_s and nu parameters needed for the texture lookups.
  Number mu = rmu / r;
  Number mu_s = dot(camera, sun_direction) / r;
  Number nu = dot(view_ray, sun_direction);
  return GetSkyRadianceInternal(atmosphere, transmittance_texture, scattering_texture, single_mie_scattering_texture,
								r, mu, mu_s, nu, shadow_length, sun_direction, transmittance);
}

/*
<h4 id="rendering_aerial_perspective">Aerial perspective</h4>

<p>To render the aerial perspective we need the transmittance and the scattering
between two points (i.e. between the viewer and a point on the ground, which can
at an arbibrary altitude). We already have a function to compute the
transmittance between two points (using 2 lookups in a texture which only
contains the transmittance to the top of the atmosphere), but we don't have one
for the scattering between 2 points. Hopefully, the scattering between 2 points
can be computed from two lookups in a texture which contains the scattering to
the nearest atmosphere boundary, as for the transmittance (except that here the
two lookup results must be subtracted, instead of divided). This is what we
implement in the following function (the initial computations are used to
correctly handle the case of viewers outside the atmosphere):
*/

RadianceSpectrum GetSkyRadianceToPoint(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    ATMPosition camera, IN(ATMPosition) pos, Length shadow_length,
    IN(Direction) sun_direction, OUT(DimensionlessSpectrum) transmittance) {
  // Compute the distance to the top atmosphere boundary along the view ray,
  // assuming the viewer is in space (or NaN if the view ray does not intersect
  // the atmosphere).
  Direction view_ray = pos - camera;
  Length d = length(view_ray);
  view_ray /= d;
  Length r = length(camera);
  Length rmu = dot(camera, view_ray);
  
#ifndef NO_OUTER_SPACE
  Length distance_to_top_atmosphere_boundary = -rmu -
      sqrt(rmu * rmu - r * r + atmosphere.top_radius * atmosphere.top_radius);
  // If the viewer is in space and the view ray intersects the atmosphere, move
  // the viewer to the top atmosphere boundary (along the view ray):
  if (distance_to_top_atmosphere_boundary > 0.0 * m) {
    camera = camera + view_ray * distance_to_top_atmosphere_boundary;
    r = atmosphere.top_radius;
    rmu += distance_to_top_atmosphere_boundary;
  }
#endif

  // Compute the r, mu, mu_s and nu parameters for the first texture lookup.
  Number mu = rmu / r;
  Number mu_s = dot(camera, sun_direction) / r;
  Number nu = dot(view_ray, sun_direction);
  
  bool ray_r_mu_intersects_ground = RayIntersectsGround(atmosphere, r, mu);

  transmittance = GetTransmittance(atmosphere, transmittance_texture,
      r, mu, d, ray_r_mu_intersects_ground);

  IrradianceSpectrum single_mie_scattering;
  IrradianceSpectrum scattering = GetCombinedScattering(
      atmosphere, scattering_texture, single_mie_scattering_texture,
      r, mu, mu_s, nu, ray_r_mu_intersects_ground,
      single_mie_scattering);

  // Compute the r, mu, mu_s and nu parameters for the second texture lookup.
  // If shadow_length is not 0 (case of light shafts), we want to ignore the
  // scattering along the last shadow_length meters of the view ray, which we
  // do by subtracting shadow_length from d (this way scattering_p is equal to
  // the S|x_s=x_0-lv term in Eq. (17) of our paper).
  d = max(d - shadow_length, 0.0 * m);
  AtmPoint p = GetRMuMuSAtDistance(atmosphere, r, mu, mu_s, nu, d);

  IrradianceSpectrum single_mie_scattering_p;
  IrradianceSpectrum scattering_p = GetCombinedScattering(
      atmosphere, scattering_texture, single_mie_scattering_texture,
      p.r, p.mu, p.mu_s, nu, ray_r_mu_intersects_ground,
      single_mie_scattering_p);

  // Combine the lookup results to get the scattering between camera and point.
  DimensionlessSpectrum shadow_transmittance = transmittance;
  if (shadow_length > 0.0 * m) {
    // This is the T(x,x_s) term in Eq. (17) of our paper, for light shafts.
    shadow_transmittance = GetTransmittance(atmosphere, transmittance_texture,
        r, mu, d, ray_r_mu_intersects_ground);
  }
  scattering = scattering - shadow_transmittance * scattering_p;
  single_mie_scattering =
      single_mie_scattering - shadow_transmittance * single_mie_scattering_p;
#ifdef COMBINED_SCATTERING_TEXTURES
  single_mie_scattering = GetExtrapolatedSingleMieScattering(
      atmosphere, vec4(scattering, single_mie_scattering.r));
#endif

  // Hack to avoid rendering artifacts when the sun is below the horizon.
  single_mie_scattering = single_mie_scattering *
      smoothstep(Number(0.0), Number(0.01), mu_s);

  return scattering * RayleighPhaseFunction(nu) + single_mie_scattering * MiePhaseFunction(atmosphere.mie_phase_function_g, nu);
}

/*
<h4 id="rendering_ground">Ground</h4>

<p>To render the ground we need the irradiance received on the ground after 0 or
more bounce(s) in the atmosphere or on the ground. The direct irradiance can be
computed with a lookup in the transmittance texture, while the indirect
irradiance is given by a lookup in the precomputed irradiance texture (this
texture only contains the irradiance for horizontal surfaces; we use the
approximation defined in our
<a href="https://hal.inria.fr/inria-00288758/en">paper</a> for the other cases).

<p>Note that it is useful here to take the angular size of the sun into account.
With a punctual light source (as we assumed in all the above functions), the
direct irradiance on a slanted surface would be discontinuous when the sun
moves across the horizon. With an area light source this discontinuity issue
disappears because the visible sun area decreases continously as the sun moves
across the horizon.

<p>Taking the angular size of the sun into account, without approximations, is
quite complex because the visible sun area is restricted both by the distant
horizon and by the local surface. Here we ignore the masking by the local
surface, and we approximate the masking by the horizon with a
<code>smoothstep</code>.

<p>The smoothstep approximation is justified as follows. When the sun, of
angular radius $\alpha_s$, is at an angle $\alpha$ above the horizon (we assume
that $\alpha$ is between $-\alpha_s$ and $\alpha_s$), the fraction $f$ of its
surface which is visible can be computed from the area of a <a
href="https://en.wikipedia.org/wiki/Circular_segment">circular segment</a>:
$f(\alpha)=(\theta-\sin\theta)/2\pi$, with
$\theta=2\arccos(-\alpha/\alpha_s)$. The smoothstep approximation is justified
by the fact that $f$, expressed as a function of the cosine of the sun zenith
angle, $\mu_s=\sin\alpha\approx\alpha$, is quite similar to
<code>smoothstep(-alpha_s, alpha_s, mu_s)</code>.

<p>The function below returns the direct and indirect irradiances separately,
and takes the angular size of the sun into account by using the above
approximation:
*/

IrradianceSpectrum GetSunRadiance(IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture, IN(Length) r, IN(Number) mu_s)
{
  float h = r - atmosphere.bottom_radius;
  float muH = -sqrt(h * (2*atmosphere.bottom_radius + h)) / r;
  return /*atmosphere.solar_irradiance * */
      GetTransmittanceToTopAtmosphereBoundary(atmosphere, transmittance_texture, r, mu_s) *
      smoothstep(-atmosphere.sun_angular_radius / rad,
                 atmosphere.sun_angular_radius / rad,
                 mu_s - muH);
}

IrradianceSpectrum GetSunAndSkyIrradiance(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(IrradianceTexture) irradiance_texture,
    IN(ATMPosition) pos, IN(Direction) normal, IN(Direction) sun_direction,
    OUT(IrradianceSpectrum) sky_irradiance) {
  Length r = length(pos);
  Number mu_s = dot(pos, sun_direction) / r;

  // Indirect irradiance (approximated if the surface is not horizontal).
  sky_irradiance = GetIrradiance(atmosphere, irradiance_texture, r, mu_s) *
      (1.0 + dot(normal, pos) / r) * 0.5;

  // Direct irradiance.
  return atmosphere.solar_irradiance * GetSunRadiance(atmosphere, transmittance_texture, r, mu_s) *  max(dot(normal, sun_direction), 0.0);
}
















#ifdef TRANSMITTANCE_VOLUME_TEXTURE


#ifdef TRANSMITTANCE_FIXED_STEPS
vec3 GetTransmittanceTextureUvwFromRMuDistFactor(IN(AtmosphereParameters) atmosphere, Length r, Number mu, Length d)
{
	vec3 uvw;
	uvw.xy = GetTransmittanceTextureUvFromRMu(atmosphere, r, mu);
	float distToHoriz = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
	Number x_d = d / (distToHoriz);
	uvw.z = GetTextureCoordFromUnitRange(x_d, TRANSMITTANCE_TEXTURE_DEPTH);
	return uvw;
}
#else
vec3 GetTransmittanceTextureUvwFromRMuDistFactor(IN(AtmosphereParameters) atmosphere, Length r, Number mu, Number distFactor)
{
	vec3 uvw;
	uvw.xy = GetTransmittanceTextureUvFromRMu(atmosphere, r, mu);
	// Number x_d = sqrt(distFactor);
	Number x_d = distFactor;
	uvw.z = GetTextureCoordFromUnitRange(x_d, TRANSMITTANCE_TEXTURE_DEPTH);
	return uvw;
}
#endif



#ifdef TRANSMITTANCE_FIXED_STEPS
void GetRMuDistFactorFromTransmittanceTextureUvw(
	IN(AtmosphereParameters) atmosphere, IN(vec3) uvw, OUT(Length) r, OUT(Number) mu, OUT(Length) d)
{
	GetRMuFromTransmittanceTextureUv(atmosphere, uvw.xy, r, mu);
	// Number x_d = GetUnitRangeFromTextureCoord(uvw.z*uvw.z, TRANSMITTANCE_TEXTURE_DEPTH);
	Number x_d = GetUnitRangeFromTextureCoord(uvw.z, TRANSMITTANCE_TEXTURE_DEPTH);	
	float distToHoriz = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
	d = x_d * distToHoriz;
}
#else
void GetRMuDistFactorFromTransmittanceTextureUvw(
	IN(AtmosphereParameters) atmosphere, IN(vec3) uvw, OUT(Length) r, OUT(Number) mu, OUT(Number) distFactor)
{
	GetRMuFromTransmittanceTextureUv(atmosphere, uvw.xy, r, mu);
	// Number x_d = GetUnitRangeFromTextureCoord(uvw.z*uvw.z, TRANSMITTANCE_TEXTURE_DEPTH);
	Number x_d = GetUnitRangeFromTextureCoord(uvw.z, TRANSMITTANCE_TEXTURE_DEPTH);
	distFactor = x_d;
}
#endif



 DimensionlessSpectrum ComputeTransmittance3DTexture(IN(AtmosphereParameters) atmosphere, IN(vec3) gl_frag_coord)
{
  const vec3 TRANSMITTANCE_TEXTURE_SIZE = vec3(TRANSMITTANCE_TEXTURE_WIDTH, TRANSMITTANCE_TEXTURE_HEIGHT, TRANSMITTANCE_TEXTURE_DEPTH);
  Length r, distFactor, d;
  Number mu;
  
#ifdef TRANSMITTANCE_FIXED_STEPS
  GetRMuDistFactorFromTransmittanceTextureUvw(atmosphere, gl_frag_coord / TRANSMITTANCE_TEXTURE_SIZE, r, mu, d);
  float3 transmittance = d<1? 1 : ComputeTransmittanceToPoint(atmosphere, r, mu, d);
#else
  GetRMuDistFactorFromTransmittanceTextureUvw(atmosphere, gl_frag_coord / TRANSMITTANCE_TEXTURE_SIZE, r, mu, distFactor);
  float3 transmittance = distFactor<1e-3? 1 : ComputeTransmittanceToPoint(atmosphere, r, mu, distFactor);
#endif
 
#ifdef TRANSMITTANCE_SRGB
  return transmittance>0? sqrt(transmittance) : 0;
#else
  return transmittance;
#endif
}


DimensionlessSpectrum GetTransmittanceToDistance(IN(AtmosphereParameters) atmosphere, IN(TransmittanceTexture3D) transmittance_texture,
	Length r, Number mu, Number d)
{
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius); 
  
#ifdef TRANSMITTANCE_FIXED_STEPS 
  vec3 uvw = GetTransmittanceTextureUvwFromRMuDistFactor(atmosphere, r, mu, d);
#else
  float distMax = DistanceToTopAtmosphereBoundary(atmosphere, r, mu);
  float distFactor = d / distMax;
  vec3 uvw = GetTransmittanceTextureUvwFromRMuDistFactor(atmosphere, r, mu, distFactor);
#endif  

  float3 transmittance = SampleTexture3D(transmittance_texture, uvw).rgb;
#ifdef TRANSMITTANCE_SRGB
  return DimensionlessSpectrum(transmittance * transmittance);
#else
  return DimensionlessSpectrum(transmittance);
#endif
}

 DimensionlessSpectrum GetTransmittanceToTopAtmosphereBoundary3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    Length r, Number mu) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  float dist = DistanceToTopAtmosphereBoundary(atmosphere, r, mu);
  return GetTransmittanceToDistance(atmosphere, transmittance_texture, r, mu, dist);
}

DimensionlessSpectrum GetTransmittance3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    Length r, Number mu, Length d, bool ray_r_mu_intersects_ground)
{
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  assert(d >= 0.0 * m);

   AtmPoint p = GetRMuAtDistance(atmosphere, r, mu, d);
  // if (mu<0)
  if (ray_r_mu_intersects_ground)
	return GetTransmittanceToDistance(atmosphere, transmittance_texture, p.r, -p.mu, d);
	// return GetTransmittanceToDistance(atmosphere, transmittance_texture, p.r, mu, d);
  else
	return GetTransmittanceToDistance(atmosphere, transmittance_texture, r, mu, d);
}

void ComputeSingleScatteringIntegrand3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    Length r, Number mu, Number mu_s, Number nu, Length d,
    bool ray_r_mu_intersects_ground,
    OUT(DimensionlessSpectrum) rayleigh, OUT(DimensionlessSpectrum) mie) {

  AtmPoint p = GetRMuMuSAtDistance(atmosphere, r, mu, mu_s, nu, d);

  if (RayIntersectsGround(atmosphere, p.r, p.mu_s)) {
    rayleigh = DimensionlessSpectrum(0.0, 0.0, 0.0);
    mie = DimensionlessSpectrum(0.0, 0.0, 0.0);
  } else {
    DimensionlessSpectrum transmittance =
        GetTransmittance3D(
            atmosphere, transmittance_texture, r, mu, d,
            ray_r_mu_intersects_ground) *
        GetTransmittanceToTopAtmosphereBoundary3D(
            atmosphere, transmittance_texture, p.r, p.mu_s);
    rayleigh = transmittance * GetDensityRayleigh(atmosphere, p.r);
    mie = transmittance * GetDensityMie(atmosphere, p.r);
  }
}


void ComputeSingleScattering3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    Length r, Number mu, Number mu_s, Number nu,
    bool ray_r_mu_intersects_ground,
    OUT(IrradianceSpectrum) rayleigh, OUT(IrradianceSpectrum) mie) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  assert(mu_s >= -1.0 && mu_s <= 1.0);
  assert(nu >= -1.0 && nu <= 1.0);

  // Number of intervals for the numerical integration.
  const int SAMPLE_COUNT = SINGLE_SCATTERING_SAMPLES;
  // The integration step, i.e. the length of each integration interval.
  Length dx =
      DistanceToNearestAtmosphereBoundary(atmosphere, r, mu,
          ray_r_mu_intersects_ground) / Number(SAMPLE_COUNT);
  // Integration loop.
  DimensionlessSpectrum rayleigh_sum = DimensionlessSpectrum(0.0, 0.0, 0.0);
  DimensionlessSpectrum mie_sum = DimensionlessSpectrum(0.0, 0.0, 0.0);
  for (int i = 0; i <= SAMPLE_COUNT; ++i) {
    Length d_i = Number(i) * dx;
    // The Rayleigh and Mie single scattering at the current sample point.
    DimensionlessSpectrum rayleigh_i;
    DimensionlessSpectrum mie_i;
    ComputeSingleScatteringIntegrand3D(atmosphere, transmittance_texture,
        r, mu, mu_s, nu, d_i, ray_r_mu_intersects_ground, rayleigh_i, mie_i);
    // Sample weight (from the trapezoidal rule).
    Number weight_i = (i == 0 || i == SAMPLE_COUNT) ? 0.5 : 1.0;
    rayleigh_sum += rayleigh_i * weight_i;
    mie_sum += mie_i * weight_i;
  }
  rayleigh = rayleigh_sum * dx * atmosphere.solar_irradiance *
      atmosphere.rayleigh_scattering;
  mie = mie_sum * dx * atmosphere.solar_irradiance * atmosphere.mie_scattering;
}


void ComputeSingleScatteringTexture3D(IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture, IN(vec3) gl_frag_coord,
    OUT(IrradianceSpectrum) rayleigh, OUT(IrradianceSpectrum) mie) {
  Length r;
  Number mu;
  Number mu_s;
  Number nu;
  bool ray_r_mu_intersects_ground;
  GetRMuMuSNuFromScatteringTextureFragCoord(atmosphere, gl_frag_coord,
      r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  ComputeSingleScattering3D(atmosphere, transmittance_texture,
      r, mu, mu_s, nu, ray_r_mu_intersects_ground, rayleigh, mie);
}


RadianceDensitySpectrum ComputeScatteringDensity3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    IN(ReducedScatteringTexture) single_rayleigh_scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    IN(ScatteringTexture) multiple_scattering_texture,
    IN(IrradianceTexture) irradiance_texture,
    Length r, Number mu, Number mu_s, Number nu, uniform int scattering_order) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  assert(mu_s >= -1.0 && mu_s <= 1.0);
  assert(nu >= -1.0 && nu <= 1.0);
  assert(scattering_order >= 2);

  // Compute unit direction vectors for the zenith, the view direction omega and
  // and the sun direction omega_s, such that the cosine of the view-zenith
  // angle is mu, the cosine of the sun-zenith angle is mu_s, and the cosine of
  // the view-sun angle is nu. The goal is to simplify computations below.
  vec3 zenith_direction = vec3(0.0, 0.0, 1.0);
  vec3 omega = vec3(sqrt(1.0 - mu * mu), 0.0, mu);
  Number sun_dir_x = omega.x == 0.0 ? 0.0 : (nu - mu * mu_s) / omega.x;
  Number sun_dir_y = sqrt(max(1.0 - sun_dir_x * sun_dir_x - mu_s * mu_s, 0.0));
  vec3 omega_s = vec3(sun_dir_x, sun_dir_y, mu_s);

  const uint SAMPLE_COUNT = SCATTERING_DENSITY_SAMPLES;
  const Angle dphi = pi / Number(SAMPLE_COUNT);
  const Angle dtheta = pi / Number(SAMPLE_COUNT);
  RadianceDensitySpectrum rayleigh_mie = RadianceDensitySpectrum(0.0, 0.0, 0.0) * watt_per_cubic_meter_per_sr_per_nm;

  // Nested loops for the integral over all the incident directions omega_i.
  for (uint l = 0; l < SAMPLE_COUNT; ++l)
  {
    Angle theta = (Number(l) + 0.5) * dtheta;
    Number cos_theta = cos(theta);
    Number sin_theta = sin(theta);
    bool ray_r_theta_intersects_ground = RayIntersectsGround(atmosphere, r, cos_theta);

    // The distance and transmittance to the ground only depend on theta, so we
    // can compute them in the outer loop for efficiency.
    Length distance_to_ground = 0.0 * m;
    DimensionlessSpectrum transmittance_to_ground = DimensionlessSpectrum(0.0, 0.0, 0.0);
    DimensionlessSpectrum ground_albedo = DimensionlessSpectrum(0.0, 0.0, 0.0);
    if (ray_r_theta_intersects_ground) {
      distance_to_ground = DistanceToBottomAtmosphereBoundary(atmosphere, r, cos_theta);
      transmittance_to_ground = GetTransmittance3D(atmosphere, transmittance_texture, r, cos_theta, distance_to_ground, true /* ray_intersects_ground */);
      ground_albedo = atmosphere.ground_albedo;
    }

    for (uint m = 0; m < 2 * SAMPLE_COUNT; ++m)
	{
      Angle phi = (Number(m) + 0.5) * dphi;
      vec3 omega_i = vec3(cos(phi) * sin_theta, sin(phi) * sin_theta, cos_theta);
      SolidAngle domega_i = (dtheta / rad) * (dphi / rad) * sin(theta) * sr;

      // The radiance L_i arriving from direction omega_i after n-1 bounces is
      // the sum of a term given by the precomputed scattering texture for the
      // (n-1)-th order:
      Number nu1 = dot(omega_s, omega_i);
      RadianceSpectrum incident_radiance = GetScattering(atmosphere,
          single_rayleigh_scattering_texture, single_mie_scattering_texture,
          multiple_scattering_texture, r, omega_i.z, mu_s, nu1,
          ray_r_theta_intersects_ground, scattering_order - 1);

      // and of the contribution from the light paths with n-1 bounces and whose
      // last bounce is on the ground. This contribution is the product of the
      // transmittance to the ground, the ground albedo, the ground BRDF, and
      // the irradiance received on the ground after n-2 bounces.
      vec3 ground_normal =
          normalize(zenith_direction * r + omega_i * distance_to_ground);
      IrradianceSpectrum ground_irradiance = GetIrradiance(
          atmosphere, irradiance_texture, atmosphere.bottom_radius,
          dot(ground_normal, omega_s));
      incident_radiance += transmittance_to_ground *
          ground_albedo * (1.0 / (atmPI * sr)) * ground_irradiance;

      // The radiance finally scattered from direction omega_i towards direction
      // -omega is the product of the incident radiance, the scattering
      // coefficient, and the phase function for directions omega and omega_i
      // (all this summed over all particle types, i.e. Rayleigh and Mie).
      Number nu2 = dot(omega, omega_i);
      rayleigh_mie += incident_radiance * (
          atmosphere.rayleigh_scattering * GetDensityRayleigh(atmosphere, r) *
              RayleighPhaseFunction(nu2) +
          atmosphere.mie_scattering * GetDensityMie(atmosphere, r) *
              MiePhaseFunction(atmosphere.mie_phase_function_g, nu2)) *
          domega_i;
    }
  }
  return rayleigh_mie;
}


RadianceSpectrum ComputeMultipleScattering3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    IN(ScatteringDensityTexture) scattering_density_texture,
    Length r, Number mu, Number mu_s, Number nu,
    bool ray_r_mu_intersects_ground) {
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  assert(mu_s >= -1.0 && mu_s <= 1.0);
  assert(nu >= -1.0 && nu <= 1.0);

  // Number of intervals for the numerical integration.
  const int SAMPLE_COUNT = MULTIPLE_SCATTERING_SAMPLES;
  // The integration step, i.e. the length of each integration interval.
  Length dx =
      DistanceToNearestAtmosphereBoundary(
          atmosphere, r, mu, ray_r_mu_intersects_ground) /
              Number(SAMPLE_COUNT);
  // Integration loop.
  RadianceSpectrum rayleigh_mie_sum =
      RadianceSpectrum(0.0, 0.0, 0.0) * watt_per_square_meter_per_sr_per_nm;
  for (int i = 0; i <= SAMPLE_COUNT; ++i) {
    Length d_i = Number(i) * dx;

    // The r, mu and mu_s parameters at the current integration point (see the
    // single scattering section for a detailed explanation).
	AtmPoint p = GetRMuMuSAtDistance(atmosphere, r, mu, mu_s, nu, d_i);

    // The Rayleigh and Mie multiple scattering at the current sample point.
    RadianceSpectrum rayleigh_mie_i = 
		GetScattering(atmosphere, scattering_density_texture, p.r, p.mu, p.mu_s, nu, ray_r_mu_intersects_ground) *
        GetTransmittance3D(atmosphere, transmittance_texture, r, mu, d_i, ray_r_mu_intersects_ground) *
        dx;
    // Sample weight (from the trapezoidal rule).
    Number weight_i = (i == 0 || i == SAMPLE_COUNT) ? 0.5 : 1.0;
    rayleigh_mie_sum += rayleigh_mie_i * weight_i;
  }
  return rayleigh_mie_sum;
}

RadianceDensitySpectrum ComputeScatteringDensityTexture3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    IN(ReducedScatteringTexture) single_rayleigh_scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    IN(ScatteringTexture) multiple_scattering_texture,
    IN(IrradianceTexture) irradiance_texture,
    IN(vec3) gl_frag_coord, int scattering_order) {
  Length r;
  Number mu;
  Number mu_s;
  Number nu;
  bool ray_r_mu_intersects_ground;
  GetRMuMuSNuFromScatteringTextureFragCoord(atmosphere, gl_frag_coord,
      r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  return ComputeScatteringDensity3D(atmosphere, transmittance_texture,
      single_rayleigh_scattering_texture, single_mie_scattering_texture,
      multiple_scattering_texture, irradiance_texture, r, mu, mu_s, nu,
      scattering_order);
}

RadianceSpectrum ComputeMultipleScatteringTexture3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    IN(ScatteringDensityTexture) scattering_density_texture,
    IN(vec3) gl_frag_coord, OUT(Number) nu) {
  Length r;
  Number mu;
  Number mu_s;
  bool ray_r_mu_intersects_ground;
  GetRMuMuSNuFromScatteringTextureFragCoord(atmosphere, gl_frag_coord,
      r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  return ComputeMultipleScattering3D(atmosphere, transmittance_texture,
      scattering_density_texture, r, mu, mu_s, nu,
      ray_r_mu_intersects_ground);
}

IrradianceSpectrum ComputeDirectIrradiance3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    Length r, Number mu_s)
{
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu_s >= -1.0 && mu_s <= 1.0);

  return atmosphere.solar_irradiance *
      GetTransmittanceToTopAtmosphereBoundary3D(atmosphere, transmittance_texture, r, mu_s) * max(mu_s, 0.0);
}
 
IrradianceSpectrum ComputeDirectIrradianceTexture3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    IN(vec2) gl_frag_coord) {
  Length r;
  Number mu_s;
  GetRMuSFromIrradianceTextureUv(
      atmosphere, gl_frag_coord / IRRADIANCE_TEXTURE_SIZE, r, mu_s);
  return ComputeDirectIrradiance3D(atmosphere, transmittance_texture, r, mu_s);
}

IrradianceSpectrum GetCombinedScattering3D(
    IN(AtmosphereParameters) atmosphere,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    Length r, Number mu, Number mu_s, Number nu,
    bool ray_r_mu_intersects_ground,
    OUT(IrradianceSpectrum) single_mie_scattering) {
  vec4 uvwz = GetScatteringTextureUvwzFromRMuMuSNu(
      atmosphere, r, mu, mu_s, nu, ray_r_mu_intersects_ground);
  Number tex_coord_x = uvwz.x * Number(SCATTERING_TEXTURE_NU_SIZE - 1);
  Number tex_x = floor(tex_coord_x);
  Number lerp = tex_coord_x - tex_x;
  vec3 uvw0 = vec3((tex_x + uvwz.y) / Number(SCATTERING_TEXTURE_NU_SIZE),
      uvwz.z, uvwz.w);
  vec3 uvw1 = vec3((tex_x + 1.0 + uvwz.y) / Number(SCATTERING_TEXTURE_NU_SIZE),
      uvwz.z, uvwz.w);
#ifdef COMBINED_SCATTERING_TEXTURES
  vec4 combined_scattering = max(0,
      SampleTexture3D(scattering_texture, uvw0) * (1.0 - lerp) +
      SampleTexture3D(scattering_texture, uvw1) * lerp);
  IrradianceSpectrum scattering = IrradianceSpectrum(combined_scattering.rgb);
  single_mie_scattering = GetExtrapolatedSingleMieScattering(atmosphere, combined_scattering);
#else
  IrradianceSpectrum scattering = IrradianceSpectrum(
      SampleTexture3D(scattering_texture, uvw0).rgb * (1.0 - lerp) +
      SampleTexture3D(scattering_texture, uvw1).rgb * lerp);
  single_mie_scattering = IrradianceSpectrum(
      SampleTexture3D(single_mie_scattering_texture, uvw0).rgb * (1.0 - lerp) +
      SampleTexture3D(single_mie_scattering_texture, uvw1).rgb * lerp);
#endif
  return scattering;
}

RadianceSpectrum GetSkyRadianceToPoint3D(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture3D) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    ATMPosition camera, IN(ATMPosition) pos, Length shadow_length,
    IN(Direction) sun_direction, OUT(DimensionlessSpectrum) transmittance) {
  // Compute the distance to the top atmosphere boundary along the view ray,
  // assuming the viewer is in space (or NaN if the view ray does not intersect
  // the atmosphere).
  Direction view_ray = normalize(pos - camera);
  Length r = length(camera);
  Length rmu = dot(camera, view_ray);

  // Compute the r, mu, mu_s and nu parameters for the first texture lookup.
  Number mu = rmu / r;
  Number mu_s = dot(camera, sun_direction) / r;
  Number nu = dot(view_ray, sun_direction);
  Length d = length(pos - camera);
  bool ray_r_mu_intersects_ground = RayIntersectsGround(atmosphere, r, mu);
  
  // transmittance = ray_r_mu_intersects_ground? 1: 0;
  transmittance = GetTransmittance3D(atmosphere, transmittance_texture, r, mu, d, ray_r_mu_intersects_ground);  
  
  IrradianceSpectrum single_mie_scattering;   
  IrradianceSpectrum scattering = GetCombinedScattering3D(
      atmosphere, scattering_texture, single_mie_scattering_texture,
      r, mu, mu_s, nu, ray_r_mu_intersects_ground,
      single_mie_scattering);

  // Compute the r, mu, mu_s and nu parameters for the second texture lookup.
  // If shadow_length is not 0 (case of light shafts), we want to ignore the
  // scattering along the last shadow_length meters of the view ray, which we
  // do by subtracting shadow_length from d (this way scattering_p is equal to
  // the S|x_s=x_0-lv term in Eq. (17) of our paper).
  d = max(d - shadow_length, 0.0 * m);
  AtmPoint p = GetRMuMuSAtDistance(atmosphere, r, mu, mu_s, nu, d);

  IrradianceSpectrum single_mie_scattering_p;
  IrradianceSpectrum scattering_p = GetCombinedScattering3D(
      atmosphere, scattering_texture, single_mie_scattering_texture,
      p.r, p.mu, p.mu_s, nu, ray_r_mu_intersects_ground,
      single_mie_scattering_p);

  // Combine the lookup results to get the scattering between camera and point.
  DimensionlessSpectrum shadow_transmittance = transmittance;
  /*
  if (shadow_length > 0.0 * m) {
    // This is the T(x,x_s) term in Eq. (17) of our paper, for light shafts.
    shadow_transmittance = GetTransmittance(atmosphere, transmittance_texture,
        r, mu, d, ray_r_mu_intersects_ground);
  }
  */

  scattering = scattering - shadow_transmittance * scattering_p;
  single_mie_scattering = single_mie_scattering - shadow_transmittance * single_mie_scattering_p; 
#ifdef COMBINED_SCATTERING_TEXTURES
  single_mie_scattering = GetExtrapolatedSingleMieScattering(atmosphere, vec4(scattering, single_mie_scattering.r));
#endif

  // Hack to avoid rendering artifacts when the sun is below the horizon.
  single_mie_scattering = single_mie_scattering * smoothstep(Number(0.0), Number(0.01), mu_s);

#ifdef ENABLE_MIE_SCATTERING
  return scattering * RayleighPhaseFunction(nu) + max(0, single_mie_scattering) * MiePhaseFunction(atmosphere.mie_phase_function_g, nu);
#else
  return scattering * RayleighPhaseFunction(nu);
#endif
}

#endif //TRANSMITTANCE_VOLUME_TEXTURE


static const float paramDistMax = 700;//TODO: посчитать максимальную дистанцию луча в атмосфере!!!!
static const float paramDistFactor = 0.5;

float ParameterToDist(float uDist)
{
	return uDist * uDist * paramDistMax;
	// return pow(uDist, 1.0/paramDistFactor) * paramDistMax;
}

float DistToParameter(float dist)
{
	float uDist = min(dist/paramDistMax, 1);
	return sqrt(uDist);
	// return pow(uDist, paramDistFactor);
}

static const float muFactor = 0.5;
// float muFactor = 0.2;

float ParameterToMu(AtmosphereParameters atmosphere, float uMu, float r = 0)
{
	float mu;
	float h = r - atmosphere.bottom_radius;
	float muH = -sqrt(h * (2*atmosphere.bottom_radius + h)) / r;
	
#ifdef LINEAR_MU
	uMu = frac(uMu*0.9999 + 0.5);
	
	// if(uMu<0.5)
	if(uMu >= 0.5)//ORIGINAL //sky
	{
		// mu = 1 - (pow(uMu*2, muFactor) * (1-muH) + muH);
		// mu = (1 - pow(uMu*2-1, 1.0/muFactor)) * (1-muH) + muH;
		mu = pow(2.0-uMu*2.0, 1.0/muFactor) * (1-muH) + muH;
		// mu = pow(uMu*2-1, 1.0/muFactor) * (1-muH) + muH;		//ORIGINAL
	}
	else//ground
	{
		// mu = muH - pow(uMu*2-1, 1.0/muFactor) * (muH - (-1));
		mu = muH - pow(uMu*2.0, 1.0/muFactor) * (muH - (-1));		//ORIGINAL
	}
	// mu = cos((1-uMu)*atmPI);
	// mu = uMu * 2.0 - 1.0;
	
#else
  bool ray_r_mu_intersects_ground;
  Length H = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
  Length rho = DistanceFromHeightToHorizon(atmosphere, r);
  if (uMu < 0.5) {
    // Distance to the ground for the ray (r,mu), and its minimum and maximum
    // values over all mu - obtained for (r,-1) and (r,mu_horizon) - from which
    // we can recover mu:
    Length d_min = r - atmosphere.bottom_radius;
    Length d_max = rho;
    // Length d = d_min + (d_max - d_min) * GetUnitRangeFromTextureCoord(1.0 - 2.0 * uMu, SCATTERING_TEXTURE_MU_SIZE / 2);
    Length d = d_min + (d_max - d_min) * uMu;
    mu = d == 0.0 * m ? Number(-1.0) : ClampCosine(-(rho * rho + d * d) / (2.0 * r * d));
    ray_r_mu_intersects_ground = true;
  } else {
    // Distance to the top atmosphere boundary for the ray (r,mu), and its
    // minimum and maximum values over all mu - obtained for (r,1) and
    // (r,mu_horizon) - from which we can recover mu:
    Length d_min = atmosphere.top_radius - r;
    Length d_max = rho + H;
    // Length d = d_min + (d_max - d_min) * GetUnitRangeFromTextureCoord(2.0 * uMu - 1.0, SCATTERING_TEXTURE_MU_SIZE / 2);
    Length d = d_min + (d_max - d_min) * uMu;
    mu = d == 0.0 * m ? Number(1.0) : ClampCosine((H * H - rho * rho - d * d) / (2.0 * r * d));
    ray_r_mu_intersects_ground = false;
  }
#endif
	
	return mu;
}

float MuToParameter(AtmosphereParameters atmosphere, float mu, float r = 0, bool bIntersectGround = false)
{
	float uMu;
#ifdef LINEAR_MU
	float h = r - atmosphere.bottom_radius;
	float muH = -sqrt(h * (2*atmosphere.bottom_radius + h)) / r;
	
	// if(mu<muH)
	if(mu>muH)	//ORIGINAL //sky
	{
		uMu = 0.5 * pow((1-mu-muH) / (1-muH), muFactor);
		uMu = 1 - 0.5 * pow((mu-muH) / (1-muH), muFactor);
		// uMu = 0.5 + 0.5 * pow((mu-muH) / (1-muH), muFactor);		//ORIGINAL
	}
	else // ground
	{
		uMu = 0.5 + 0.5 * pow( max(0, (muH - mu) / (muH-(-1))), muFactor);
		uMu = 0.5 * pow(max(0, (muH - mu) / (muH-(-1))), muFactor);		//ORIGINAL
	}
	uMu = frac(uMu+0.5);

	// uMu = acos(-mu) / atmPI;
	// uMu = mu*0.5 + 0.5;
#else
  // Discriminant of the quadratic equation for the intersections of the ray
  // (r,mu) with the ground (see RayIntersectsGround).
  Length rho = DistanceFromHeightToHorizon(atmosphere, r);
  Length r_mu = r * mu;
  Length H = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
  Area discriminant = r_mu * r_mu - r * r + atmosphere.bottom_radius * atmosphere.bottom_radius;

  if (bIntersectGround) {
    // Distance to the ground for the ray (r,mu), and its minimum and maximum
    // values over all mu - obtained for (r,-1) and (r,mu_horizon).
    Length d = -r_mu - SafeSqrt(discriminant);
    Length d_min = r - atmosphere.bottom_radius;
    Length d_max = rho;
    uMu = 0.5 - 0.5 * GetTextureCoordFromUnitRange(d_max == d_min ? 0.0 :
        (d - d_min) / (d_max - d_min), SKY_RADIANCE_TEXTURE_MU_SIZE / 2);
  } else {
    // Distance to the top atmosphere boundary for the ray (r,mu), and its
    // minimum and maximum values over all mu - obtained for (r,1) and
    // (r,mu_horizon).
    Length d = -r_mu + SafeSqrt(discriminant + H * H);
    Length d_min = atmosphere.top_radius - r;
    Length d_max = rho + H;
    uMu = 0.5 + 0.5 * GetTextureCoordFromUnitRange(
        (d - d_min) / (d_max - d_min), SKY_RADIANCE_TEXTURE_MU_SIZE / 2);
  }
#endif

#if defined(FLIP_MAPPING_MU) && defined(SKY_RADIANCE_TEXTURE)
	// uMu = frac(uMu + 0.5);
#endif
	return uMu;
}


vec4 GetResolvedScatteringTextureUvwzFromRMuDistNu(IN(AtmosphereParameters) atmosphere,
    Length r, Number mu, Number dist, Number nu, bool ray_r_mu_intersects_ground)
{
  assert(r >= atmosphere.bottom_radius && r <= atmosphere.top_radius);
  assert(mu >= -1.0 && mu <= 1.0);
  assert(dist >= 0.0 && dist <= 1.0);
  assert(nu >= -1.0 && nu <= 1.0);

  // Distance to top atmosphere boundary for a horizontal ray at ground level.
  Length H = DistanceToTopAtmosphereBoundaryForHorizRayAtGroundLevel(atmosphere);
  // Distance to the horizon.
  Length rho = DistanceFromHeightToHorizon(atmosphere, r);
#ifdef SCATTERING_BETTER_R_MAPPING
  Number u_r = GetTextureCoordFromUnitRange(sqrt(rho / H), SKY_RADIANCE_TEXTURE_R_SIZE);
#else
  Number u_r = GetTextureCoordFromUnitRange(rho / H, SKY_RADIANCE_TEXTURE_R_SIZE);
 #endif
 
  Number u_mu;
#if defined(LINEAR_MU)
  u_mu = GetTextureCoordFromUnitRange(MuToParameter(atmosphere, mu, r, ray_r_mu_intersects_ground), SKY_RADIANCE_TEXTURE_MU_SIZE);
#else
  // Discriminant of the quadratic equation for the intersections of the ray
  // (r,mu) with the ground (see RayIntersectsGround).
  Length r_mu = r * mu;
  Area discriminant = r_mu * r_mu - r * r + atmosphere.bottom_radius * atmosphere.bottom_radius;
  if (ray_r_mu_intersects_ground) {
    // Distance to the ground for the ray (r,mu), and its minimum and maximum
    // values over all mu - obtained for (r,-1) and (r,mu_horizon).
    Length d = -r_mu - SafeSqrt(discriminant);
    Length d_min = r - atmosphere.bottom_radius;
    Length d_max = rho;
    u_mu = 0.5 - 0.5 * GetTextureCoordFromUnitRange(d_max == d_min ? 0.0 :
        (d - d_min) / (d_max - d_min), SKY_RADIANCE_TEXTURE_MU_SIZE / 2);
  } else {
    // Distance to the top atmosphere boundary for the ray (r,mu), and its
    // minimum and maximum values over all mu - obtained for (r,1) and
    // (r,mu_horizon).
    Length d = -r_mu + SafeSqrt(discriminant + H * H);
    Length d_min = atmosphere.top_radius - r;
    Length d_max = rho + H;
    u_mu = 0.5 + 0.5 * GetTextureCoordFromUnitRange(
        (d - d_min) / (d_max - d_min), SKY_RADIANCE_TEXTURE_MU_SIZE / 2);
  }
#endif

#if defined(SKY_RADIANCE_TEXTURE) && defined(FLIP_MAPPING_MU)
	u_mu = frac(u_mu + 0.5);
#endif

  Number u_dist = GetTextureCoordFromUnitRange(DistToParameter(dist), SKY_RADIANCE_TEXTURE_DIST_SIZE);

  Number u_nu = (nu + 1.0) / 2.0;
  return vec4(u_nu, u_dist, u_mu, u_r);
}

IrradianceSpectrum GetResolvedCombinedScattering(
    IN(AtmosphereParameters) atmosphere,
    IN(ReducedScatteringTexture) scattering_texture,
    Length r, Number mu, Number d, Number nu,
    bool ray_r_mu_intersects_ground,
    OUT(IrradianceSpectrum) single_mie_scattering)
{
  vec4 uvwz = GetResolvedScatteringTextureUvwzFromRMuDistNu(atmosphere, r, mu, d, nu, ray_r_mu_intersects_ground);
  Number tex_coord_x = uvwz.x * Number(SKY_RADIANCE_TEXTURE_NU_SIZE - 1);
  Number tex_x = floor(tex_coord_x);
  Number lerp = tex_coord_x - tex_x;
  vec3 uvw0 = vec3((tex_x + uvwz.y) / Number(SKY_RADIANCE_TEXTURE_NU_SIZE), uvwz.zw);
  vec3 uvw1 = vec3((tex_x + 1.0 + uvwz.y) / Number(SKY_RADIANCE_TEXTURE_NU_SIZE), uvwz.zw);

  vec4 combined_scattering = max(0, 
      SampleTexture3D(scattering_texture, uvw0) * (1.0 - lerp) +
      SampleTexture3D(scattering_texture, uvw1) * lerp);

  IrradianceSpectrum scattering = IrradianceSpectrum(combined_scattering.rgb);
  single_mie_scattering = GetExtrapolatedSingleMieScattering(atmosphere, combined_scattering);
  return scattering;
}

RadianceSpectrum GetPrecomputedSkyRadianceToPoint(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    ATMPosition camera, IN(ATMPosition) pos, IN(CloudLightMapSPSample) lms,
    IN(Direction) sun_direction, OUT(DimensionlessSpectrum) transmittance)
{
  // Compute the distance to the top atmosphere boundary along the view ray,
  // assuming the viewer is in space (or NaN if the view ray does not intersect
  // the atmosphere).
  Direction view_ray = pos - camera;
  Length d = length(view_ray);
  view_ray /= d;

  AtmPoint p = GetAtmPointForRay(atmosphere, camera, view_ray, sun_direction);

  d = max(d - lms.shadowLengthKm, 0.0 * m);

  // transmittance = GetTransmittance(atmosphere, transmittance_texture, r, mu, d, p.bRayIntersectsGround);
  transmittance = GetTransmittance(atmosphere, transmittance_texture, p.r, p.mu, d, p.mu<0);

  IrradianceSpectrum single_mie_scattering;
  IrradianceSpectrum scattering = GetResolvedCombinedScattering(atmosphere, scattering_texture, p.r, p.mu, d, p.nu, p.bRayIntersectsGround, single_mie_scattering);

  // Hack to avoid rendering artifacts when the sun is below the horizon.
  single_mie_scattering *= smoothstep(Number(0.0), Number(0.01), p.mu_s);

#ifdef ENABLE_MIE_SCATTERING
  return scattering * RayleighPhaseFunction(p.nu) * lms.rayleighFactor + single_mie_scattering * (MiePhaseFunction(atmosphere.mie_phase_function_g, p.nu) * lms.mieFactor);
#else
  return scattering * RayleighPhaseFunction(p.nu);
#endif
}

RadianceSpectrum GetPrecomputedSkyRadianceInternal(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture, IN(Direction) view_ray, 
    IN(Length) r, IN(Number) mu, IN(Number) mu_s, IN(Number) nu, IN(CloudLightMapSPSample) lms,
    IN(Direction) sun_direction, IN(Length) dist, OUT(DimensionlessSpectrum) transmittance)
{
#ifndef NO_OUTER_SPACE
  if (r > atmosphere.top_radius) // If the view ray does not intersect the atmosphere, simply return 0.
  {
    transmittance = DimensionlessSpectrum(1.0, 1.0, 1.0);
    return RadianceSpectrum(0.0, 0.0, 0.0) * watt_per_square_meter_per_sr_per_nm;
  }
#endif

  bool ray_r_mu_intersects_ground = RayIntersectsGround(atmosphere, r, mu);
  
  transmittance = ray_r_mu_intersects_ground ? DimensionlessSpectrum(0.0, 0.0, 0.0) : GetTransmittanceToTopAtmosphereBoundary(atmosphere, transmittance_texture, r, mu);
  IrradianceSpectrum single_mie_scattering;
  IrradianceSpectrum scattering;

  dist = max(dist - lms.shadowLengthKm, 0.0 * m);

  scattering = GetResolvedCombinedScattering(atmosphere, scattering_texture, r, mu, dist, nu, ray_r_mu_intersects_ground, single_mie_scattering);

  // Hack to avoid rendering artifacts when the sun is below the horizon.
  single_mie_scattering *= smoothstep(Number(0.0), Number(0.01), mu_s);

#ifdef ENABLE_MIE_SCATTERING
  return scattering * (RayleighPhaseFunction(nu) * lms.rayleighFactor) + single_mie_scattering * (MiePhaseFunction(atmosphere.mie_phase_function_g, nu) * lms.mieFactor);
#else
  return scattering * RayleighPhaseFunction(nu);
#endif
}

// Same, as above, but also return Mie single scattering component
RadianceSpectrum GetPrecomputedSkyRadianceInternal(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture, IN(Direction) view_ray, 
    IN(Length) r, IN(Number) mu, IN(Number) mu_s, IN(Number) nu, IN(CloudLightMapSPSample) lms,
    IN(Direction) sun_direction, IN(Length) dist, OUT(DimensionlessSpectrum) transmittance,
    OUT(RadianceSpectrum) singleMieScattering)
{
#ifndef NO_OUTER_SPACE
  if (r > atmosphere.top_radius) // If the view ray does not intersect the atmosphere, simply return 0.
  {
    transmittance = DimensionlessSpectrum(1.0, 1.0, 1.0);
    return RadianceSpectrum(0.0, 0.0, 0.0) * watt_per_square_meter_per_sr_per_nm;
  }
#endif

  bool ray_r_mu_intersects_ground = RayIntersectsGround(atmosphere, r, mu);
  
  transmittance = ray_r_mu_intersects_ground ? DimensionlessSpectrum(0.0, 0.0, 0.0) : GetTransmittanceToTopAtmosphereBoundary(atmosphere, transmittance_texture, r, mu);
  IrradianceSpectrum single_mie_scattering;
  IrradianceSpectrum scattering;

  dist = max(dist - lms.shadowLengthKm, 0.0 * m);

  scattering = GetResolvedCombinedScattering(atmosphere, scattering_texture, r, mu, dist, nu, ray_r_mu_intersects_ground, single_mie_scattering);

  // Hack to avoid rendering artifacts when the sun is below the horizon.
  single_mie_scattering *= smoothstep(Number(0.0), Number(0.01), mu_s);

  singleMieScattering = single_mie_scattering;

#ifdef ENABLE_MIE_SCATTERING
  return scattering * (RayleighPhaseFunction(nu) * lms.rayleighFactor) + single_mie_scattering * (MiePhaseFunction(atmosphere.mie_phase_function_g, nu) * lms.mieFactor);
#else
  return scattering * RayleighPhaseFunction(nu);
#endif
}

RadianceSpectrum GetPrecomputedSkyRadiance(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    ATMPosition camera, IN(Direction) view_ray, IN(CloudLightMapSPSample) lms,
    IN(Direction) sun_direction, IN(Length) dist, OUT(DimensionlessSpectrum) transmittance)
{ 
  // Compute the distance to the top atmosphere boundary along the view ray,
  // assuming the viewer is in space (or NaN if the view ray does not intersect
  // the atmosphere).
  AtmPoint p = GetAtmPointForRay(atmosphere, camera, view_ray, sun_direction, true);

  return GetPrecomputedSkyRadianceInternal(atmosphere, transmittance_texture, scattering_texture, single_mie_scattering_texture, view_ray,
								p.r, p.mu, p.mu_s, p.nu, lms, sun_direction, dist, transmittance);
}

RadianceSpectrum GetPrecomputedSkyRadiance(
    IN(AtmosphereParameters) atmosphere,
    IN(TransmittanceTexture) transmittance_texture,
    IN(ReducedScatteringTexture) scattering_texture,
    IN(ReducedScatteringTexture) single_mie_scattering_texture,
    ATMPosition camera, IN(Direction) view_ray, IN(CloudLightMapSPSample) lms,
    IN(Direction) sun_direction, IN(Length) dist, OUT(DimensionlessSpectrum) transmittance, OUT(RadianceSpectrum)singleMieScattering)
{ 
  // Compute the distance to the top atmosphere boundary along the view ray,
  // assuming the viewer is in space (or NaN if the view ray does not intersect
  // the atmosphere).
  AtmPoint p = GetAtmPointForRay(atmosphere, camera, view_ray, sun_direction, true);

  return GetPrecomputedSkyRadianceInternal(atmosphere, transmittance_texture, scattering_texture, single_mie_scattering_texture, view_ray,
								p.r, p.mu, p.mu_s, p.nu, lms, sun_direction, dist, transmittance, singleMieScattering);
}

#endif //ATMOSPHERE_FUNCTIONS_HLSL
