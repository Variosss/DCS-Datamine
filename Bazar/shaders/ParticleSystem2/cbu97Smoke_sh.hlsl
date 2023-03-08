
[domain("isoline")]
DS_OUTPUT dsCBU97( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	#define dsBirthTime patch[0].pos.w
	#define dsLifetime patch[0].speed.w
	#define dsSpeed patch[0].speed.xyz

	const float scale = 8;
	
	DS_OUTPUT o;
	float age = max(0, time - dsBirthTime);
	float nAge = age / dsLifetime;
	// float opacity = min(1,age*30) * pow(1 - nAge,1);//fadeIn, fadeOut
	float opacity = pow(1 - nAge,1) * step(0.0001, age);//fadeIn, fadeOut
	float speedValue = length(dsSpeed);
	float3 dir = dsSpeed/speedValue;
	
	float glowFactor = max(0, 1-age*20);
	
	float isTop = step(UV.x, 0.5);
	float moveDir = lerp(1, -1, isTop);
	float dirFactor = abs(UV.x-0.5);//length(rand.xz);
	
	float perlin = createPerlinNoise1D(dsBirthTime + dir.x*9.73512719 + 2*UV.x);
	float perlin2 = createPerlinNoise1D(dsBirthTime + dir.y*20.73512719 + 2*UV.x);
	
	float2 sc;
	sincos(perlin*PI2*2, sc.x, sc.y);
	
	float3 rand = dir*moveDir;
	rand.xz = moveDir*sc*(0.4+age)*0.1 * (0.6+0.4*noise1D(UV.x))*scale * (0.2 + 0.8*perlin2);
	rand = normalize(rand);//рандомный вектор
	float initialWidth = 0.7*scale;
	
	float distFactor = pow(dirFactor, 1.2);

	float dist = dirFactor*initialWidth + pow(max(0, age*1.5), 0.45)*distFactor*scale;

	o.pos.xyz = patch[0].pos.xyz - worldOffset + rand*dist*smokeScale*lerp(1, 1.5, isTop);
	o.pos.xyz += dir*calcTranslationWithDeceleration(speedValue*0.5, 1, age);//тормозим до нуля со стартовой скорости
	o.pos.w = age;
	
	o.params.x = opacity*(0.4+0.6*(UV.x)) * 0.7;
	//ANGLE
	o.params.y = noise2D(float2(dsBirthTime+1.432, UV.x*32.57203))*PI2;
	
	//scale
	o.params.z = (1 + pow( max(0,(nAge-0.06)), 0.3)) * smokeScale * 0.6 + 0.2*UV.x;
	
	o.params.z *= scale;
	
	o.params.w = glowFactor * (1-dirFactor);
    
    return o; 
}
