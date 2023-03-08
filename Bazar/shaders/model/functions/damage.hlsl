#ifndef DAMAGE_HLSL
#define DAMAGE_HLSL

#ifdef DAMAGE_UV

static const float HOLE_LOW_THRESHOLD = 0.85;

static const float LOD_DIST_INV = 1.0/2000.0;

// damage
Texture2D Damage;
// damage alpha
Texture3D DamageMask;
#ifdef DAMAGE_NORMAL_MAP_UV
// damage normal map
Texture2D DamageNormalMap;
#endif

// calculates normal using normal map
float3 calculateDamageNormal(const VS_OUTPUT input)
{
#ifdef DAMAGE_NORMAL_MAP_UV
	float4 tex = DamageNormalMap.Sample(gAnisotropicWrapSampler, input.DAMAGE_NORMAL_MAP_UV.xy + diffuseShift);
	return calculateNormal(input.Normal, tex, input.DamageTangent);
#else
	return normalize(input.Normal);
#endif
}

void testDamageAlpha(const float2 damageUV, const float2 damageLevel, in float dist){
	if(damageLevel.x < 0.0){
		return;
	}
	float lod=dist*LOD_DIST_INV;
	float alpha = DamageMask.SampleLevel(gBilinearWrapSampler, float3(damageUV.xy, damageLevel.x), lod).r;

	if(alpha.r > HOLE_LOW_THRESHOLD) discard;
}
#endif

void addDamage(const VS_OUTPUT input, in float dist, inout float4 diffuseColor, inout float3 normal, inout float4 aorms)
{
#ifdef DAMAGE_UV
	if(input.DamageLevel.x < 0.0){
		return;
	}

	float lod=dist*LOD_DIST_INV;
	float4 alpha = DamageMask.SampleLevel(gBilinearWrapSampler, float3(input.DAMAGE_UV.xy + diffuseShift,input.DamageLevel.x), lod);
	// alpha.g - roughness
	// alpha.b - metallic
	// alpha.a - sub mask

	//if(input.DamageLevel.y < alpha.a){
		// Some damage masks have alpha channel repeating red channel. It's bug as for now alpha channel is sub mask.
		// Uncomment when masks are fixed.
		//return;
	//}

	if(alpha.r > HOLE_LOW_THRESHOLD) discard;

	float4 damage = Damage.Sample(gAnisotropicWrapSampler, input.DAMAGE_UV.xy + diffuseShift);

	normal = lerp(normal, calculateDamageNormal(input), alpha.r);

#ifndef GLASS_MATERIAL
	diffuseColor.rgb=lerp(diffuseColor.rgb,damage.rgb,alpha.r);
#else
	diffuseColor=lerp(diffuseColor,damage,alpha.r);
#endif

	const float d = length(damage.rgb) / 1.7320508075688772;
	aorms.y = lerp(aorms.y, alpha.g, alpha.g);
	aorms.z = lerp(aorms.z, alpha.b, alpha.b * d);
#endif
	aorms *= 1;
}

void addDamageNew(const VS_OUTPUT input, in float dist, inout float4 diffuseColor, inout float3 normal, inout float4 aorms)
{
#ifdef DAMAGE_UV
	if(input.DamageLevel.x < 0.0){
		return;
	}

	float lod=dist*LOD_DIST_INV;
	float4 alpha = DamageMask.SampleLevel(gBilinearWrapSampler, float3(input.DAMAGE_UV.xy + diffuseShift,input.DamageLevel.x), lod);
	// alpha.g - specular
	// alpha.b - reflection
	// alpha.a - sub mask

	if(input.DamageLevel.y < alpha.a){
		// Some damage masks have alpha channel repeating red channel. It's bug as for now alpha channel is sub mask.
		// Uncomment when masks are fixed.
		//return;
	}

	if(alpha.r > HOLE_LOW_THRESHOLD) discard;

	alpha.gb = 1.0 - alpha.gb;

	float4 damage = Damage.Sample(gAnisotropicWrapSampler, input.DAMAGE_UV.xy + diffuseShift);

	normal = lerp(normal, calculateDamageNormal(input), alpha.r);

#ifndef GLASS_MATERIAL
	diffuseColor.rgb=lerp(diffuseColor.rgb,damage.rgb,alpha.r);
#else
	diffuseColor=lerp(diffuseColor,damage,alpha.r);
#endif
	aorms.yz *= alpha.gb;
#endif
}

#endif
