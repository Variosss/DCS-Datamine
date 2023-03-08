
#define puffDelay	0.04 //задержка появления пуфика, чтобы сначала отрисовать иглы


float getCBU103VertTranslation(in float speedValue, in float age)
{
	return calcTranslationWithDeceleration(speedValue*0.5, 1.5, age);
}

[domain("isoline")]
DS_OUTPUT dsCBU103( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	#define dsBirthTime patch[0].pos.w
	#define dsLifetime patch[0].speed.w
	#define dsSpeed patch[0].speed.xyz
	const float scale = 7;
	const float initialWidth = 0.1*scale;
	
	float age = max(0, time - dsBirthTime - puffDelay);
	float nAge = age / dsLifetime;
	float opacity = max(0, 1 - nAge*(1+UV.x*0.2));
	float speedValue = length(dsSpeed);
	float3 dir = dsSpeed/speedValue;
	float isTop = step(UV.x, 0.5);
	float moveDir = isTop*2-1;
	float dirFactor = abs(UV.x-0.5);

	float2 sc;
	sincos(smoothNoise1(dsBirthTime + dir.x*9.73512719 + 2*UV.x)*PI2*2, sc.x, sc.y);
	
	float3 rand = dir*moveDir;
	rand.xz = moveDir * sc * (0.4+age) * (0.6+0.4*noise1D(UV.x)) * 0.2 * scale;// * (0.2 + 0.8*perlin2);
	rand = normalize(rand);//рандомный вектор
	
	float dist = dirFactor*initialWidth + pow(max(0, age*0.5), 0.45)*pow(dirFactor, 1.2)*scale;

	DS_OUTPUT o;
	//позиция центра пуфика
	o.pos.xyz = patch[0].pos.xyz - worldOffset + dir*getCBU103VertTranslation(speedValue, age);
	//растаскивание пуфика во все стороны
	o.pos.xyz += rand*dist*smokeScale*lerp(1, 1.2, isTop);
	o.pos.w = age;
	
	o.params.x = opacity*(0.4+0.6*(UV.x)) * 0.7*min(1,age*2000);
	//ANGLE
	o.params.y = noise2D(float2(dsBirthTime+1.432, UV.x*32.57203))*PI2;
	//scale
	o.params.z = (1 + pow( max(0,(nAge-0.06)), 0.3)) * smokeScale * 0.6 + 0.2*UV.x;
	o.params.z *= scale;
	float glowFactor = max(0, 1-age*40);
	o.params.w = glowFactor * (1-dirFactor);
    
    return o; 
}

//---------------------------------------------------------------------------------------------------------------------
// NEEDLES ------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------

struct GS_NEEDLE_OUTPUT{
    float4 pos  : SV_POSITION0;
	float3 params:TEXCOORD0;
};

[domain("isoline")]
DS_OUTPUT dsCBU103Needle( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	#define dsBirthTime patch[0].pos.w
	#define dsSpeed patch[0].speed.xyz
    DS_OUTPUT o;
	o.pos.xyz = patch[0].pos.xyz - worldOffset;
	o.pos.w = max(0,time - dsBirthTime);
	
	float uniqueSeed = dsBirthTime + UV.x*15.512371;
	o.params.xyz = frac(sin(float3(uniqueSeed, uniqueSeed*1.123 + 71.512772, uniqueSeed*2.421 + 12.51237)*6231.8653612))*2-1;
	o.params.xyz = normalize(o.params.xyz);
	o.params.w = getCBU103VertTranslation(length(dsSpeed), o.pos.w);
    return o;
	#undef dsSpeed
	#undef dsBirthTime
}

void addEdge(
	inout TriangleStream<GS_NEEDLE_OUTPUT> outputStream, 
	inout GS_NEEDLE_OUTPUT o,
	in float3 pos,
	in float3 offset,
	in float opacity,
	in float glowFactor)
{
	o.pos = mul(float4(pos+offset, 1), gViewProj);
	o.params.xyz = float3(1, opacity, glowFactor);
	outputStream.Append(o);
	
	o.pos = mul(float4(pos-offset, 1), gViewProj);
	o.params.xyz = float3(0, opacity, glowFactor);
	outputStream.Append(o);
}

#define edgesCount 10

static const float edgesCountInv = 1.0 / (edgesCount-1);

[maxvertexcount(edgesCount*2)]
void gsCBU103Needle(point DS_OUTPUT i[1], inout TriangleStream<GS_NEEDLE_OUTPUT> outputStream)
{
	#define gsPos i[0].pos.xyz
	#define gsAge i[0].pos.w
	#define gsDir i[0].params.xyz
	#define gsVerticalTrans i[0].params.w

	#define gsLifetime  3.5
	#define traceWidth 0.45
	#define gsSpeed gsDir*350

	float nAge = gsAge / gsLifetime;
	float glowFactor = max(0, 1-gsAge*15);
	
	const float mass = 0.5;
	const float c = 5;
	float3 translation = calcTranslationWithAirResistance(gsSpeed, mass, c, gsAge);
	float3 edgeDir = normalize(cross(gsDir, gView._13_23_33)) * traceWidth;
	float3 dissipationPower = edgeDir*gsAge*3;

	GS_NEEDLE_OUTPUT o;
	for(float id=0; id<edgesCount; id+=1.0)
	{
		float p = id*edgesCountInv;
		float nAgeRelative = p*nAge;
		float n = frac(sin(p*51.729146)*412317.8653612)-0.5;
		
		addEdge(outputStream, o,
			gsPos + p*translation + n*dissipationPower + float3(0,-gsVerticalTrans*(1-p),0),//pos
			edgeDir*max(0,1-nAgeRelative - p*0.8), //dir * width
			pow(p,0.5) * (1-pow(nAge, 1)) * 0.07,//opacity
			glowFactor*pow(sin(p*3.14),0.3)//*mad(p,0.8,0.2)
			);
	}
	#undef gsPos
	#undef gsAge
	#undef gsDir
	#undef gsVerticalTrans
}

float4 psNeedle(in GS_NEEDLE_OUTPUT i): SV_TARGET0
{
	#define psGlowFactor i.params.z
	// return float4(1,0,0,0.2);
	float3 color = (gSunDiffuse.r+gSunDiffuse.g)/2;
	color *= gSunDiffuse*0.5 + 0.5;
	
	color = lerp(color, glowColor, psGlowFactor);
	
	float alpha = sin((i.params.x)*3.14) * i.params.y * (1+psGlowFactor*5);
	
	// return float4(color, alpha);
	return makeAdditiveBlending(float4(color, alpha), psGlowFactor);
	#undef psGlowFactor
}
