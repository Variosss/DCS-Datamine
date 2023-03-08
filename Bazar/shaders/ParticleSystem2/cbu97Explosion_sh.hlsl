
[domain("isoline")]
DS_OUTPUT dsCBU97( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	float  dsBirthTime	= patch[0].pos.w;	
	float  dsLifetime	= patch[0].speed.w;
	float3 dsSpeed		= patch[0].speed.xyz;

	const float scale = 8.0;
	
    DS_OUTPUT o;	
	float age = time - dsBirthTime;
	float nAge = age / dsLifetime;
	// float opacity = min(1,age*30) * pow(1 - nAge,1);//fadeIn, fadeOut
	float opacity = 1;//pow(1 - nAge,1);//fadeIn, fadeOut
	float speedValue = length(dsSpeed);
	float3 dir = dsSpeed/speedValue;
	
	float glowFactor = max(0, 1-age*20);	
	
	float isTop = step(UV.x, 0.5);
	float moveDir = lerp(1, -1, isTop);
	float dirFactor = abs(UV.x-0.5);//length(rand.xz);
	
	//todo: заменить на smooth noise
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
	// o.pos.xyz += dir*calcTranslationWithDeceleration(speedValue*0.5, 1, age);//тормозим до нуля со стартовой скорости
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


struct GS_TEST_OUTPUT{
	float4 pos  : SV_POSITION0;
	float4 params:TEXCOORD0;// UV, opacity, distance
	float4 sunDirM: TEXCOORD1;
	float3 sunDirBackM: TEXCOORD2;
};

[maxvertexcount(4)]
void gsPuffTest(point DS_OUTPUT input[1], inout TriangleStream<GS_TEST_OUTPUT> outputStream)
{
	float3 gsPos	= input[0].pos.xyz;
	float  gsOpacity= input[0].params.x;
	float  gsAngle	= input[0].params.y;
	float  gsScale	= input[0].params.z;
	
	GS_TEST_OUTPUT o;
	
	float _sin, _cos;
	// sincos(gsAngle, _sin, _cos);
	sincos(0, _sin, _cos);
	
	float2x2 M = {
	_cos, _sin,
	-_sin,  _cos};
	
	gsPos = mul(float4(gsPos,1), gView).xyz;
	
	o.params.z = gsOpacity;
	o.params.w = input[0].params.w;//distance

	int phase = (time + gsAngle)*25;
	float2 uvScaleFactor = 1.0 / float2(16, 8);
	
	// float2 uvOffset = floor(float2(fmod(time2, 8), time2*8));
	float2 uvOffset = float2((float)(phase & 15), (float)((phase>>4) & 7) );

	float3x3 M2 = {
    _cos, _sin, 0, 
    -_sin,  _cos, 0, 
    0,     0, 1};
	
	float3x3 M3 = {
    _cos, -_sin, 0, 
    _sin,  _cos, 0, 
    0,     0, 1};

	o.sunDirM.xyz = max(0, mul(-gSunDirV.xyz, M2));
	o.sunDirBackM.xyz = max(0, mul(gSunDirV.xyz, M2));
	// o.sunDirBackM.xyz = saturate(mul(gSunDirV.xyz, M3));
	
	o.sunDirM.w = 1 / ( dot(o.sunDirM.xyz, 1) + dot(o.sunDirBackM.xyz, 1) );
	
	// old-school
	// float3 front = normalize(gsPos);
	// float3 up = float3(-_sin, _cos, 0);
	// float3 right = normalize(cross(front, up));
	// up = cross(right, front);	
	// o.sunDirM.x = saturate(dot(right, -gSunDirV)); 
	// o.sunDirM.y = saturate(dot(up, gSunDirV)); 
	// o.sunDirM.z = saturate(dot(front, -gSunDirV));	
	
	[unroll]
	for (int i = 0; i < 4; ++i)
	{
		o.params.xy = staticVertexData[i].xy + 0.5;
		o.params.xy = (o.params.xy+uvOffset)*uvScaleFactor;
		
		float4 vPos = float4(staticVertexData[i].xy, 0, 1);
		vPos.xy = mul(vPos.xy, M);
		vPos.xy *= gsScale;
		vPos.xyz += gsPos;
		o.pos = mul(vPos, gProj);
		
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}


float4 psPuffTest(in GS_TEST_OUTPUT i): SV_TARGET0
{
	// return float4(1,1,1,0.2);
	float psOpacity		= i.params.z;
	float psGlowFactor	= i.params.w;

	float4 texParticle = tex.Sample(ClampLinearSampler, i.params.xy);
	
	texParticle.xyz = texParticle.xyz*2-1;
	// float sunDot = dot(i.sunDirM, texParticle.xyz*2-1);
	// float sunDot = dot(i.sunDirM, texParticle.xyz);
	
	float sunDot = dot(i.sunDirM.xyz, texParticle.xyz) + dot(i.sunDirBackM.xyz, texParticle.xyz);
	sunDot *= i.sunDirM.w;

	//базовая прозрачность партикла
	float alpha = texParticle.a;
	// float alpha = max(0, (texParticle.a-0.2)*1.25);
	//основная освещенка
	float3 smokeColor = lerp(AmbientTop*0.5, gSunDiffuse.xyz, sunDot)*1.0;
	
	smokeColor = lerp(smokeColor, glowColor, psGlowFactor);
	// smokeColor = texParticle.rgb;
	
	// float4 clr = float4(smokeColor, min(1, alpha * psOpacity*(1+1.5*psGlowFactor)));
	// float4 clr = float4(texParticle.rgb, min(1, alpha * psOpacity*(1+1.5*psGlowFactor)));
	float4 clr = float4(sunDot.xxx, min(1, alpha * psOpacity*(1+1.5*psGlowFactor)));

	return clr;
}
