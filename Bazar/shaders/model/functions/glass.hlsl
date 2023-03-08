#ifndef GLASS_HLSL
#define GLASS_HLSL

#define INFRARED_SHADERS
#define FOG_ENABLE
#define EXTERN_UNIFORM_LIGHT_COUNT
#define EXTERN_ATMOSPHERE_SAMPLES_ID
#ifndef SHADING_MODEL
	#define SHADING_MODEL	SHADING_GLASS
#endif

#include "common/enums.hlsl"
#include "common/context.hlsl"

#include "functions/misc.hlsl"
#include "functions/vertex_shader.hlsl"
#include "functions/vt_utils.hlsl"
#include "functions/scratches.hlsl"
#include "functions/matParams.hlsl"
#include "functions/aorms.hlsl"

#include "functions/satellite.hlsl"
#include "functions/map.hlsl"
#include "functions/infrared.hlsl"

#include "enlight/stochasticSampler.hlsl"

#ifdef ENABLE_DEBUG_UNIFORMS
#include "common/color_table.hlsl"
#include "common/debug_uniforms.hlsl"
#endif

Texture2D RainDroplets: register(t104);
Texture2D CockpitRefraction: register(t103);

Texture2D IcingMap;

struct PS_OUTPUT_GLASS {
	float4 colorAdd : SV_TARGET0;
	float4 colorMul : SV_TARGET1;
};

#define CALC_GLASS_FRESHEN			1
#define CALC_GLASS_TRANSMITTANCE	0 //for the future

#include "functions/shading.hlsl"

// Glass filter color.
#ifdef DIFFUSE_UV
Texture2D GlassColorMap;
#endif

float3 getScatteringCoef(float3 T, float dist){
	return log(float3(1.0,1.0,1.0) / T) / dist;
}

float3 getTransmittance(float3 scatteringCoef, float dist){
	return exp(-scatteringCoef*dist);
}

float3 getTransmittance(float3 t0, float D0, float dist){
	return getTransmittance(getScatteringCoef(t0, D0), dist);
}

//reflected energy lobe - modified Shlick's approximation for the critical angle of total internal reflection, cosAlpha = NoV
float getFresnelFactor(float cosAlpha, float cosAlphaCrit){
	return pow(saturate(1.0 - (cosAlpha + (cosAlphaCrit - 1.0)) / cosAlphaCrit), 5.0);
}

//cosine of refraction angle (NoR)
float getCosGamma(float cosAlpha, float N1, float N2){
	return sqrt(1.0 - N1*N1*(1.0-cosAlpha*cosAlpha)/(N2*N2));
}

//refracted ray length relative to incidence angle of 0 degrees and a shell of unit thickness
float getRefractedRayLength(float cosAlpha, float N1, float N2){
	return 1.0 / getCosGamma(cosAlpha, N1, N2);
}

float4 forwardGlassPSPass2(VS_OUTPUT input, MaterialParams mp, uniform int Flags, out float3 transmittance)
{
	float shadow = 1.0;
	float2 cloudShadowAO = 1.0;
	cloudShadowAO = SampleShadowClouds(mp.pos);
	shadow = cloudShadowAO.x;
	
	if(!(Flags & F_DISABLE_SHADOWMAP))
		shadow = min(shadow, applyShadow(float4(mp.pos, input.projPos.z/input.projPos.w), mp.normal, true, true, Flags & F_IN_COCKPIT));

	mp.diffuse.rgb = modifyAlbedo(mp.diffuse.rgb, albedoLevel, albedoContrast, mp.aorms.x);

	AtmosphereSample atm = SamplePrecomputedAtmosphere(0);
	atm.sunColor /= gSunIntensity;

	float4 finalColor;

	finalColor = float4(ShadeTransparent(input.Position.xy, atm.sunColor, mp.diffuse.rgb, mp.diffuse.a, mp.normal, mp.aorms.y, mp.aorms.z, mp.emissive, shadow, cloudShadowAO, mp.toCamera, mp.pos, true, Flags & F_IN_COCKPIT), mp.diffuse.a);
	if(Flags & F_IN_COCKPIT)
		finalColor.rgb += calcScratches(input, shadow);

	if(!(Flags & F_IN_COCKPIT))
	{
		finalColor.rgb = finalColor.rgb * atm.transmittance + atm.inscatter;
		transmittance = atm.transmittance;
	}
	else transmittance = 1.0;

	return finalColor;
}

void calcGlassColors(VS_OUTPUT input, uniform int Flags, out float4 colorMul, out float4 colorAdd)
{
	float3 transmittance;
	MaterialParams mp = calcMaterialParams(input, MP_ALL);
	colorAdd = forwardGlassPSPass2(input, mp, Flags, transmittance);

#ifdef DIFFUSE_UV
	colorMul = GlassColorMap.Sample(gAnisotropicWrapSampler, input.DIFFUSE_UV.xy + diffuseShift);
#else
	colorMul = float4(1, 0, 0, 1);
#endif

#if CALC_GLASS_FRESHEN
	static const float d0 = 1.0;//medium thickness for incidence angle of 0 degrees
	static const float n1 = 1.000292; //air
	static const float n2 = 1.49; //plexiglass
	// static const float n2 = 1.334; //water

	//RoVcrit - critical cosine of the total internal reflection while transmitting light from n2 to n1.
	//Should be determined over the surface curvature and the medium thickness, or adjusted visually for a suitable result
	static const float RoVcrit = 0.98;
	static const float inscatterFactor = 0.5;//artistic choice

	float3 T0 = GammaToLinearSpace(colorMul.rgb);
	colorMul.rgb = transmittance - transmittance*colorAdd.aaa;

	//transmitted light
	float NoV = dot(mp.normal, mp.toCamera);
	float Ft = 1.0 - getFresnelFactor(NoV, RoVcrit);//energy lobe

	#if CALC_GLASS_TRANSMITTANCE
		float d = d0 * getRefractedRayLength(NoV, n1, n2);
		float3 scatteringCoef = getScatteringCoef(t0, d0);
		colorMul.rgb *= getTransmittance(scatteringCoef, d) * (Ft * (1.0-getFresnelFactor(NoV, 1.0)));
		//magic approximation: inscattered light within shell thickness
		colorAdd.rgb += getTransmittance(scatteringCoef, d*4.0) * AmbientAverage * ((1.0 - Ft) * inscatterFactor) * transmittance;
	#else
		colorMul.rgb *= T0 * (Ft * (1.0-getFresnelFactor(NoV, 1.0)));
		//magic approximation: inscattered light within shell thickness
		colorAdd.rgb += T0 * AmbientAverage * ((1.0 - Ft) * inscatterFactor) * transmittance;
	#endif

#else
	colorMul.rgb = GammaToLinearSpace(colorMul.rgb);
	colorMul.rgb *= transmittance - transmittance*colorAdd.aaa;
#endif
}

PS_OUTPUT_GLASS forward_ps_pass1(VS_OUTPUT input, uniform int Flags) {
	PS_OUTPUT_GLASS o;

	float4 colorMul, colorAdd;
	calcGlassColors(input, Flags, colorMul, colorAdd);

	o.colorMul = colorMul;
	o.colorAdd = colorAdd;

#ifdef ENABLE_DEBUG_UNIFORMS
	if(PaintNodes == 1){
		o.colorAdd.rgb = color_table[NodeId];
	}
#endif

	return o;
}

// TODO refactoring, MeltFactor is deprecated
#define viewportSize float2(MeltFactor.yz)

float4 forward_ps_pass_droplets(VS_OUTPUT input, uniform int Flags): SV_TARGET0 {

#ifdef DIFFUSE_UV

	float4 colorMul, colorAdd;
	calcGlassColors(input, Flags, colorMul, colorAdd);

	float2 uv = input.DIFFUSE_UV.xy + diffuseShift;

	float3 normal = normalize(input.Normal);
#ifdef NORMAL_MAP_UV
	float3 tangent = normalize(input.Tangent.xyz);
#else
	float3 tangent = normal;
#endif
	float3x3 tangentSpace = { tangent, cross(normal, tangent), normal };

	float3 n = normalize((RainDroplets.Sample(gTrilinearWrapSampler, uv).xyz - 127.0 / 255) * 2);
	n.z = sqrt(1 - dot(n.xy, n.xy));
	n = mul(n, tangentSpace);

	float2 ruv = float2(input.projPos.x, -input.projPos.y) / input.projPos.w;
	float3 duv = mul(normal - n, (float3x3)gView);

	float4 colorDst;
	[unroll]
	for (int i = 2; i >= 0; --i) {
		duv *= 0.5 * sign(i);
		colorDst = CockpitRefraction.SampleLevel(gBilinearClampSampler, viewportSize * saturate((ruv + duv.xy) * 0.5 + 0.5), 0);
		[branch]
		if (colorDst.a == 0)
			break;
	}

	colorDst.xyz = lerp(colorDst.xyz, SampleEnvironmentMapDetailed(-n, 4).xyz, saturate(dot(duv.xy, duv.xy) * 5));

	return colorDst * colorMul + colorAdd;

#else
	return float4(1, 0, 0, 1);
#endif
}

float4 forward_ps_pass_icing(VS_OUTPUT input, uniform int Flags) : SV_TARGET0{

#if defined(DIFFUSE_UV) && defined(NORMAL_MAP_UV)

	float4 colorMul, colorAdd;
	calcGlassColors(input, Flags, colorMul, colorAdd);

	float2 uv = input.DIFFUSE_UV.xy + diffuseShift;

	float4 aisMask = RainDroplets.Sample(gAnisotropicWrapSampler, input.DIFFUSE_UV.xy);
	float ais = saturate(aisMask.x * gCockpitIcing.z);
	float value = saturate(gCockpitIcing.x * saturate(1 + (1 - aisMask.w) * 10) - ais);

	float3 normal = normalize(input.Normal);
	float3 tangent = normalize(input.Tangent.xyz);
	float4 nm = stochasticSample(IcingMap, gAnisotropicWrapSampler, input.NORMAL_MAP_UV.xy * gCockpitIcing.w, 128);
	nm.xyz = (nm.xyz - 127.0 / 255) * 2;

	nm.xyz = lerp(float3(0, 0, 1), nm.xyz, value);

	float3x3 tangentSpace = { tangent, cross(normal, tangent), normal };

#if 1
	float3 n = mul(nm.xyz, tangentSpace);
#else
	float3 n = mul(float3(nm.xy, sqrt(1 - dot(nm.xy, nm.xy))), tangentSpace);
#endif

	float2 ruv = float2(input.projPos.x, -input.projPos.y) / input.projPos.w;
	float3 duv = mul(normal - n, (float3x3)gView);

	float4 colorDst;
	[unroll]
	for (int i = 2; i >= 0; --i) {
		duv *= 0.5 * sign(i);
		colorDst = CockpitRefraction.SampleLevel(gBilinearClampSampler, viewportSize * saturate((ruv + duv.xy) * 0.5 + 0.5), 0);
		[branch]
		if (colorDst.a == 0)
			break;
	}
	colorDst = colorDst * colorMul + colorAdd;
	colorDst.xyz = lerp(colorDst.xyz, SampleEnvironmentMapDetailed(-n, 4).xyz, saturate(nm.w * gCockpitIcing.y * (1 - ais) * value));
	return colorDst;

#else
	return float4(1, 0, 1, 1);
#endif
}

float4 forward_ps_pass_fogging(VS_OUTPUT input, uniform int Flags) : SV_TARGET0 {
#if defined(DIFFUSE_UV) && defined(NORMAL_MAP_UV)

	float4 colorMul, colorAdd;
	calcGlassColors(input, Flags, colorMul, colorAdd);

	float2 uv = input.DIFFUSE_UV.xy + diffuseShift;

	float4 aisMask = RainDroplets.Sample(gAnisotropicWrapSampler, input.DIFFUSE_UV.xy);
	float ais = saturate(aisMask.x * gCockpitIcing.z);
	float value = saturate(gCockpitIcing.x * saturate(1 + (1 - aisMask.w) * 10) - ais);

	float3 normal = normalize(input.Normal);
	float3 tangent = normalize(input.Tangent.xyz);
	float4 nm = stochasticSample(IcingMap, gAnisotropicWrapSampler, input.NORMAL_MAP_UV.xy * gCockpitIcing.w, 128);
	float nf = lerp(stochasticSample(IcingMap, gAnisotropicWrapSampler, input.NORMAL_MAP_UV.xy * gCockpitIcing.w * 10, 128).w, 1, 0.7);
	nm.xyz = (nm.xyz -127.0 / 255) * 2;
	nm = lerp(float4(0,0,1, nf), nm, value * gCockpitIcing.y);

	float3x3 tangentSpace = { tangent, cross(normal, tangent), normal };
#if 1
	float3 n = mul(nm.xyz, tangentSpace);
#else
	float3 n = mul(float3(nm.xy, sqrt(1 - dot(nm.xy, nm.xy))), tangentSpace);
#endif
	float2 ruv = float2(input.projPos.x, -input.projPos.y) / input.projPos.w;
	float3 duv = mul(normal - n, (float3x3)gView);
	ruv += duv.xy * 0.25;

	#define KERNEL 64
	float offset = 1.0 / KERNEL;
	const float incr = 3.1415926535897932384626433832795 * (3.0 - sqrt(5.0));

	float4 acc = 0;
	for (int k = 1; k < KERNEL; ++k) {
		float r = k * offset;
		float2 d2;
		sincos(k * incr, d2.y, d2.x);

		float2 v = (d2 * r) * value;
		float3 delta = mul(float3(v * nm.w * 0.1, 0), tangentSpace);
		float3 rduv = mul(delta, (float3x3)gView);
		float w = 1.0 - float(k) / KERNEL;
		acc += float4(CockpitRefraction.SampleLevel(gBilinearClampSampler, viewportSize * saturate((ruv + rduv.xy) * 0.5 + 0.5), 0).xyz * w, w);
	}
	float3 colorDst = acc.xyz / acc.w;
	colorDst = colorDst * colorMul.xyz + colorAdd.xyz;
	colorDst = lerp(colorDst, SampleEnvironmentMapDetailed(-n, 4).xyz, nm.w * value);
	return float4(colorDst, 1);

#else
	return float4(1, 0, 1, 1);
#endif
}

float4 glassFLIR_ps(VS_OUTPUT input): SV_TARGET0 {
#if defined(TRUE_FLIR)
	return calcFLIR(input, LL_TRANSPARENT);
#else	
	return float4(1,1,0,1);
#endif
}

#endif
