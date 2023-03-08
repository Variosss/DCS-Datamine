#ifndef SSR_HLSL
#define SSR_HLSL

#include "deferred/shading.hlsl"

float3 SimplestShading(uint2 sv_pos_xy, float3 color, float3 normal, float3 emissive, float3 camera, float3 pos, float3 view, float depth=0, uniform bool useShadows=false) {
#if 1
	//Иногда случается что camera == pos, тогда в атмосфере происходит деление на 0
	//при вычислении nu в GetPrecomputedSkyRadianceToPoint, и скаттеринг получается отрицательным.
	//Дальше идет размытие рефлекшена, потом размытие блумом, и в итоге приезжаем к черному экрану.
	const float rayLengthHack = 1.0e-7;

	float2 cloudsShadowAO = 1; 
	float shadow = 1;
	if(useShadows) {
		cloudsShadowAO = SampleShadowClouds(pos);
		shadow = min(cloudsShadowAO.x, SampleShadowCascade(pos, depth, normal, false, false, false, 1));
	}
	color = ShadeHDR(sv_pos_xy, gSunDiffuse, color, normal, 0.95, 0, emissive*0.3333, shadow, 1, cloudsShadowAO, -view, pos, 1, FAR_ENV_MAP, false, 0, LL_NONE); // emissive*0.3333 - decrease lightmap effect at night
	return atmApplyLinear(view, distance(pos, camera)*0.001 + rayLengthHack, color);
#else
	float NdotL = max(0, dot(normal, gSunDirV.xyz)) * pow(max(gSunDir.y, 0), 0.2);
	color *= NdotL;
	return float4(lerp(color, getReflectionSkyColorLDR(view), 0.5), 1);
#endif
}

float2 getScreenCoord(float3 pos) {
	float4 p = mul(float4(pos, 1), gProj);
	return float2(p.x, -p.y) / p.w * 0.5 + 0.5;
}

SamplerState DepthSampler {
	Filter = MIN_MAG_MIP_POINT;
	AddressU = BORDER;
	AddressV = BORDER;
	AddressW = BORDER;
	BorderColor = float4(0, 0, 0, 0);
};

float getDepth(float2 uv) {
#ifdef MSAA
	float mult = !any(step(0.5, abs(uv - 0.5)));	// check range of uv to [0..1]
	uint2 tuv = transformColorBufferUV(uv) + 0.5;	// center of pixel
	float depth = LoadDepth(tuv) * mult;
#else
	float2 uv2 = uv * g_ColorBufferViewport.zw + g_ColorBufferViewport.xy;
	float depth = SSR_Depth.SampleLevel(DepthSampler, uv2, 0).x;
#endif
	float4 p = mul(float4(float2(uv.x, 1 - uv.y) * 2 - 1, depth, 1), gProjInv);
	return p.z / p.w;
}

float4 getColor(float2 uv) {
	uint2 suv = transformColorBufferUV(uv) + 0.5;	// center of pixel

	if (isWater(LoadStencil(suv)))
		return 0; 

	float3 diffuse, normal;
	float3 emissive;
	DecodeGBufferReflection(suv, diffuse, normal, emissive);
	float depth = LoadDepth(suv);

	float4 p = mul(float4(float2(uv.x, 1 - uv.y) * 2 - 1, depth, 1), gViewProjInv);
	p.xyz /= p.w;
	float3 color = SimplestShading(suv, diffuse, normal, emissive, gCameraPos, p.xyz, normalize(p.xyz - gCameraPos), depth, true);

	return float4(color, 1);
}

float rand(float3 value) {
	float random = dot(frac(value), vec3(12.9898, 78.233, 37.719));
	return frac(sin(random) * 143758.5453);
}

#if 1
	static const uint sampleSteps = 32;
	static const float stepSize = 0.003; // stride of cast rays (in blender units)
	static const float stepMult = 1.04;
#else
	static const uint sampleSteps = 64;
	static const float stepSize = 0.005; // stride of cast rays (in blender units)
	static const float stepMult = 1;
#endif

float4 raymarch(float3 pos, float3 dir, float offset) {		// in view space, dir must be normalized 

	float3 v = normalize(pos);
	float3 dv = abs(dot(v, dir));

#if 1
	float jitterStep = (1 + (rand(dir)-0.25)) * stepSize;
#else
	float jitterStep = stepSize;
#endif
	float3 e = pos + dir;
	float3 ep = e / e.z;
	float3 pp = pos / pos.z;
	float3 dp = ep - pp;
	float3 dp0 = normalize(dp);

	for (uint i = 0; i < sampleSteps; ++i) {
		jitterStep *= stepMult;
		float rayLen = i * jitterStep;
		float3 sp = pp + dp0 * rayLen;
		float t = -cross(sp, pos).z / cross(sp, dir).z;
		if (t > 100000)
			return 0;

		float3 rayEnd = pos + dir * t;
		float2 screenCoord = getScreenCoord(rayEnd);
		float depth = getDepth(screenCoord);
		float delta = rayEnd.z - depth - 0.5;	// -0.5 fix water to water reflection
		float delta2 = depth - pos.z + offset;
//		if (delta > 0) {
		if (delta > 0 && delta2 > lerp(delta, 0, saturate(rayEnd.z*0.0002)) ) {		// 5km far to check delta2 
			float4 c = getColor(screenCoord);
#if 0										
			if (c.a == 0)	// water to water reflection, continue raymarch
				continue;
#endif
			return c;
		}
	}

	return 0;// float4(1, 0, 1, 1);
}

float4 getSSR(float4 NDC, float3 wsNormal, float offset) {
	float4 dp = mul(NDC, gProjInv);
	float3 vsPos = dp.xyz / dp.w;
	float3 vsView = normalize(vsPos);

	float dist = length(vsPos);
	float3 vsNormal = mul(wsNormal, (float3x3)gView);
	vsNormal = normalize(vsNormal);

	float3 vsRay = reflect(vsView, vsNormal);
	float4 c = raymarch(vsPos, vsRay, offset);

	return c;
}

#endif
