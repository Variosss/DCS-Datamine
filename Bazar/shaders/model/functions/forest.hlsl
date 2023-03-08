#ifndef FOREST_HLSL
#define FOREST_HLSL

#define FOG_ENABLE
#define EXTERN_UNIFORM_LIGHT_COUNT
#define EXTERN_ATMOSPHERE_SAMPLES_ID
#include "common/atmosphereSamples.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"

#include "common/enums.hlsl"
#include "functions/misc.hlsl"
#include "functions/vt_utils.hlsl"

#include "deferred/GBuffer.hlsl"

float4 calculateForestDiffuse(const VS_OUTPUT input)
{
	float4 diff;
	diff = extractDiffuse(GET_DIFFUSE_UV(input));
	return diff;
}

VS_OUTPUT model_vs(VS_INPUT input)
{
	VS_OUTPUT o;

	float4x4 posMat = get_matrix((uint)input.pos.w);

	o.Pos = mul(float4(input.pos.xyz,1.0),posMat);
	o.projPos = o.Position = mul(o.Pos, gViewProj);
	o.Pos /= o.Pos.w;

	// o.Normal = mul(float3(0.0,1.0,0.0),(float3x3)posMat);
	o.Normal = float3(0,1,0);

#ifdef NORMAL_MAP_UV
	o.Tangent = 0;
	o.Binormal = 0;
#endif

	#include "functions/set_texcoords.hlsl"
	return o;
}

GBuffer deferredDefaultPS(VS_OUTPUT input
#if USE_SV_SAMPLEINDEX
	, uint sv_sampleIndex
#endif
) {

	float3 pos = input.Pos.xyz;

	if(pos.y + gOrigin.y < -1.0)
		discard;

	float camDist = distance(pos, gCameraPos.xyz) * gNearFarFovZoom.w;// as forest doesn't support changing of camera fov
	float forestAlpha = smoothstep(MeltFactor.y, MeltFactor.z, camDist);
	if(forestAlpha > 0.9)
		discard;

	float4 diff = calculateForestDiffuse(input);

	return BuildGBuffer(input.Position.xy,
#if USE_SV_SAMPLEINDEX
		sv_sampleIndex,
#endif
		diff, float3(0,1,0), float4(1, 0.95, 0, 1), float3(0,0,0));
}

GBuffer deferred_ps(VS_OUTPUT input,
#if USE_SV_SAMPLEINDEX
		uint sv_sampleIndex: SV_SampleIndex,
#endif
		uniform int Flags) {
	return deferredDefaultPS(input
#if USE_SV_SAMPLEINDEX
		, sv_sampleIndex
#endif
		);
}

PS_OUTPUT forward_ps(VS_OUTPUT input, uniform int Flags)
{
	PS_OUTPUT o;

//	o = _diffuse_sun_ps(input, Flags);
	o.RGBColor.rgb = float3(1,0,0);

	if(!(Flags & F_IN_COCKPIT))
		o.RGBColor.rgb = atmosphereApply(gCameraPos.xyz, input.Pos.xyz, input.projPos, o.RGBColor.rgb);

	return o;
}

PS_OUTPUT _diffuse_sun_ps_ir(VS_OUTPUT input)
{
	PS_OUTPUT o;
	o.RGBColor = float4(1, 0, 0, 1);
	return o;
}

PS_OUTPUT diffuse_sun_ps_ir(VS_OUTPUT input)
{
	return _diffuse_sun_ps_ir(input);
}

PS_OUTPUT diffuse_sun_ps_map(VS_OUTPUT input)
{
	discard;
	PS_OUTPUT o;
	return o;
}

#endif
