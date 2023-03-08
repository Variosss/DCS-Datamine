
//-----------------------------------------------------------------------------------------------
// SPARKS
//-----------------------------------------------------------------------------------------------
struct GS_103_OUTPUT
{
	float4 pos  : SV_POSITION0;
	float3 params:TEXCOORD0;
};

[domain("isoline")]
DS_OUTPUT dsCBU103Sparks( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	float  dsBirthTime	= patch[0].pos.w;
	float3 dsSpeed		= patch[0].speed.xyz;

	DS_OUTPUT o;
	o.pos.xyz = patch[0].pos.xyz - worldOffset;
	o.pos.w = max(0,time - dsBirthTime);
	
	float uniqueSeed = dsBirthTime + UV.x*15.512371 + frac(patch[0].pos.y)*7.12312;

	float3 param = float3(uniqueSeed, uniqueSeed*4.123 + 3.512772, uniqueSeed*1.3251 + 17.51237)*412.8653612;	
	o.params.xyz = frac(sin(param))*2-1;

	o.params.y = abs(o.params.y)*1.3;
	o.params.xyz = normalize(o.params.xyz);
	o.params.w = 0;//UNUSED
	
	o.pos.xyz += float3(o.params.x, 0, o.params.z)*6;
	
	return o;
}

void setParticle(
	inout TriangleStream<GS_103_OUTPUT> outputStream, 
	inout GS_103_OUTPUT o, 
	in float4x4 mBillboard,
	in float glowFactor)
{
	o.params.z = glowFactor;
	for (int i = 0; i < 4; ++i)
	{
		float4 vPos = {staticVertexData[i].x, staticVertexData[i].y, 0, 1};
		o.params.xy = (vPos.xy + 0.5)*3.1415;
		vPos.y *= 1.5 + 2*glowFactor;//растягиваем по траектории
		vPos = mul(vPos, mBillboard);
		o.pos = mul(vPos, gViewProj);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

#define particlesCount 16
static const float particlesCountInv = 1.0 / (particlesCount-1);

[maxvertexcount(particlesCount*4)]
void gsCBU103Sparks(point DS_OUTPUT i[1], inout TriangleStream<GS_103_OUTPUT> outputStream)
{
	#define gsPos i[0].pos.xyz
	#define gsAge i[0].pos.w
	#define gsDir i[0].params.xyz

	#define gsLifetime  2.5
	#define gsExplosionHeightMax 30
	
	const float scaleFactor = 0.5;
	const float mass = 1.0;
	const float c = 4.5;

	float nAge = gsAge / gsLifetime;
	float nAge02 = pow(nAge,0.2);
	float c2 = c-pow(gsDir.y,3)*3.8;
	float3 dir;//текущее направление партикла по траектории
	float opacityFactor = sqrt(saturate((nAge-0.5)*1.2));
	
	GS_103_OUTPUT o;
	for(float id=0; id<particlesCount; id+=1.0f)
	{
		float2 rnd = frac(sin(float2(gsDir.y + id*5.1231231, dot(gsDir.xy, float2(12.9898,78.233)*2.0) )*31536.7653118));
		
		float p = sqrt(id*particlesCountInv + 0.05*rnd.x); //1 - вершина пика
		
		float m = mass-p*0.8;
		float particleAge = max(0,gsAge*2 - p*0.08);
		float particleAge2 = particleAge + 0.2;
		
		//стартовое направление партикла
		float3 particleDir = frac(sin(gsDir + id*4.189123 + float3(p, p*4.123 + 71.512772, p + 12.51237)*4131.8653612))*2-1;
		particleDir.y = abs(particleDir.y);
		float3 offset = float3(particleDir.x, 0, particleDir.y);
		particleDir = normalize(particleDir + gsDir);
		
		float3 addSpeedCur = float3(particleDir.x, -1, particleDir.z);
		addSpeedCur.xz *= (10-p*8)*scaleFactor;
		addSpeedCur.y *= (15-p*10)*scaleFactor;
		
		float3 speed = 150*particleDir*scaleFactor;
		
		float3 trans1 = calcTranslationWithAirResistance(speed, m, c2, particleAge)  + addSpeedCur*particleAge;		
		float3 trans2 = calcTranslationWithAirResistance(speed, m, c2, particleAge2) + addSpeedCur*particleAge2;
		dir = trans2 - trans1;

		float scale = 0.5 + p*(2.0-2.0*nAge02);
		scale *= scaleFactor;
		
		float opacity =  1 - pow(saturate(gsAge + rnd.y*p), 2);
		opacity *= saturate( trans1.y/(0.1 + opacityFactor * gsExplosionHeightMax * p*p) );
		
		float4x4 mBillboard = billboardOverSpeed(gsPos + offset*2 + trans1, dir, scale);//pos, dir, scale
		setParticle(outputStream, o, mBillboard, opacity);
	}
	#undef gsPos
	#undef gsAge
	#undef gsDir
}

// static const float3 CBU130GlowColor = glowColor * float3(1.1,0.75,0.65);
static const float3 CBU130GlowColor = glowColor * float3(1.1,0.75,0.60);

float4 psSparks(in GS_103_OUTPUT i): SV_TARGET0
{
	float  psGlowFactor = i.params.z;
	float2 psUV			= i.params.xy;

	float alpha = sin(i.params.x) * sin(i.params.y);
	alpha = saturate(pow(alpha, 5) * 0.9);	

	float3  color = CBU130GlowColor*CBU130GlowColor;// + (1-psGlowFactor)*0.4;
	return float4(color*4, alpha*psGlowFactor);
}

//-----------------------------------------------------------------------------------------------
// GLOW 
//-----------------------------------------------------------------------------------------------

VS_OUTPUT vsCB103Glow(in VS_INPUT i, uint vertId: SV_VertexID)
{
	VS_OUTPUT o;
	o.pos = i.posBirth;
	o.pos.xz += gWind*(time - i.posBirth.w);
	o.speed = i.speedLifetime;//TODO: выпилить для glow и blastWave
	o.particles = float(vertId % 2);//TODO: переименовать
	return o;
}

[maxvertexcount(4)]
void gsCBU103Glow(point VS_OUTPUT input[1], inout TriangleStream<GS_103_OUTPUT> outputStream)
{
	#define gsPos input[0].pos.xyz
	#define gsBirthTime input[0].pos.w

	const float gsScale = 30.0;
	float age = max(0,time - gsBirthTime);
	float opacity = max(0, sin(min(1, (age-0.01)*8)*3.14)) * 0.7;
	float scale = gsScale * input[0].particles * min(1, 0.1 + age*15) * step(0.01, opacity);
	
	gsPos -= worldOffset.xyz;
	gsPos.y+=1;//чтобы не файтился с землей
	
	GS_103_OUTPUT o;
	o.params.z = opacity;
	[unroll]
	for (int i = 0; i < 4; ++i)
	{
		float4 vPos = float4(staticVertexData[i].x, 0, staticVertexData[i].y, 1);
		o.params.xy = staticVertexData[i].xy*0.7 + 0.5;
		
		vPos.xz *= scale;
		vPos.xyz += gsPos;
		o.pos = mul(vPos, gViewProj);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
	#undef gsBirthTime
	#undef gsPos
}

float4 psCBU103Glow(in GS_103_OUTPUT i): SV_TARGET0
{
	float  psGlowFactor = i.params.z;
	float2 psUV			= i.params.xy;
	float  alpha = sin(psUV.x*3.1415) * sin(psUV.y*3.1415);	alpha = pow(alpha,5);//TODO: заменить на текстуру и проверить скорость
	return float4(CBU130GlowColor*CBU130GlowColor*2, alpha*psGlowFactor);
}

//-----------------------------------------------------------------------------------------------
// BLAST WAVE
//-----------------------------------------------------------------------------------------------

[maxvertexcount(4)]
void gsCBU103BlastWave(point VS_OUTPUT input[1], inout TriangleStream<GS_103_OUTPUT> outputStream)
{
	#define gsPos input[0].pos.xyz
	#define gsBirthTime input[0].pos.w

	const float gsScale = 8.0;
	float age = max(0,time - gsBirthTime-0.05);
	float nAge = min(1, age*4);
	float opacity = pow(1-nAge,3)*1.5;
	float scale = gsScale * input[0].particles * (0.05 + pow(age,0.3)*10) * step(0.02, opacity);
	
	gsPos -= worldOffset.xyz;
	gsPos.y+=1.05;//чтобы не файтился с землей
	
	GS_103_OUTPUT o;
	o.params.z = opacity;
	[unroll]
	for (int i = 0; i < 4; ++i)
	{
		float4 vPos = float4(staticVertexData[i].x, 0, staticVertexData[i].y, 1);
		o.params.xy = staticVertexData[i].xy*1.0 + 0.5;
		
		vPos.xz *= scale;
		vPos.xyz += gsPos;
		o.pos = mul(vPos, gViewProj);
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
	#undef gsBirthTime
	#undef gsPos
}

float4 psCBU103BlastWave(in GS_103_OUTPUT i): SV_TARGET0
{
	float  psGlowFactor = i.params.z;
	float  psUV			= i.params.xy;
	float4 color  = float4(1,1,1, blastWaveTex.Sample(ClampLinearSampler, psUV).a*psGlowFactor);
	return color;
}