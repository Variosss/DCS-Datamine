#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

#include "../common/TextureSamplers.hlsl"
#include "../common/States11.hlsl"
//#include "../common/fog.hlsl"
Texture3D noiseTex;
Texture2D normalSphereTex;

float	time;
float	timeOffset;
float3	sunDirCam;
int		pointsCount;
float	scaleBase;	// глобальный масштаб частицы
float	speedCurrent;
float	segmentLength;
float3	origin;

static const float opacityMax = 0.12;
static const float distMax = 10;

TEXTURE_SAMPLER3D_FILTER(noiseTex, MIN_MAG_MIP_LINEAR, WRAP, WRAP, WRAP);
TEXTURE_SAMPLER(normalSphereTex, MIN_MAG_MIP_LINEAR, WRAP, WRAP);
TEXTURE_SAMPLER(tex, MIN_MAG_MIP_LINEAR, WRAP, WRAP);

//from god
struct VS_INPUT
{
	uint   id	  : SV_VertexID;
	float4 params1: TEXCOORD0; // emitterSpeed, birthTime, opacity, age
	float3 params2: TEXCOORD1; // начальная позиция партикла в мировой СК
	//float4 params3: TEXCOORD2; // начальная скорость партикла в мировой СК, lifetime	
	//float4 params4: TEXCOORD3; // spinDir + dissipation direction
};

//for toiletWire
struct VS_OUTPUT
{
	float4 params1: TEXCOORD0; // posOffset, UVangle
	float4 params2: TEXCOORD1; // speed, scale
	float4 params3: TEXCOORD2; // stretch, opacity, brigtness, Rand
};

//for toiletPaper
struct VS_OUTPUT2
{	
	float4 params1: TEXCOORD0; 
	float4 params2: TEXCOORD1; // позиция вершины в СК камеры
	float4 params3: TEXCOORD2; 	
	float4 params4: TEXCOORD3; 
	float3 pos	  : TEXCOORD4; // позиция вершины в МСК
	float nAge	  : TEXCOORD5;
};

//for toiletHexagon
struct VS_OUTPUT3
{	
	float4 params1: TEXCOORD0; 
	float4 params2: TEXCOORD1; // позиция вершины в СК камеры
	float4 params3: TEXCOORD2; 	
	float4 params4: TEXCOORD3; 
	float3 pos	  : TEXCOORD4; // позиция вершины в МСК
	float nAge	  : TEXCOORD5;
	float vertexId: TEXCOORD6;
};

//for toiletWire
struct PS_INPUT
{    
	float4 pos	 : SV_POSITION;
    float4 params: TEXCOORD0; // UV, temperOffset, transparency	
};

//for toiletPaper
struct PS_INPUT2//полоска, всегда повернутая на экран
{    
	float4 pos	  : SV_POSITION;
    float4 params : TEXCOORD0;	// UVW, параметр для полусферы
	float4 params2: TEXCOORD1;	// UVW в глубине, прозрачность
	float3 binormal: BINORMAL;	// бинормаль в МСК
	float3 tangent: TANGENT;	// направление отрезка  в МСК
	float  params3: TEXCOORD2;  // dot на вью дирекшн
};

struct PS_INPUT_GEOM //честная геометрия с передачей нормали
{    
	float4 pos	  : SV_POSITION;
    float4 params : TEXCOORD0;	// UVW, параметр для полусферы
	float4 params2: TEXCOORD1;	// UVW в глубине, относительный возраст
	float3 normal : NORMAL;		// нормаль в МСК
	float3 tangent: TANGENT;	// направление отрезка  в МСК
	float  params3: TEXCOORD2;  // прозрачность
	float3 posW	  : TEXCOORD3;  // позиция в мире
};

struct PS_INPUT_PARTICLE //партикл с передачей нормали
{    
	float4 pos	  : SV_POSITION;
    float4 params : TEXCOORD0;	// UVW, относительный возраст	
	//float4 params2: TEXCOORD1;	// UVW в глубине, относительный возраст	
	float3 tangent: TANGENT;	// проекция направления отрезка на плоскость экрана
	float3 params3: TEXCOORD2;  // локальные UV партикла для вычисления нормали, прозрачность
	float3 posW	  : TEXCOORD3;  // позиция в мире
};


VS_OUTPUT2 VS_toiletPaper(VS_INPUT i)
{
	VS_OUTPUT2 o;
	#define PARTICLE_POS i.params1.xyz	
	#define BIRTH_TIME i.params1.w
	#define startSpeed i.params2.xyz

	o.params1 = i.params1;
	//o.nAge = min(1, (float(i.id)+timeOffset)/(pointsCount-1));
	o.nAge = min(1, (float(i.id))/(pointsCount-1));

	const float AGE = time - BIRTH_TIME;
	const float RAND = noise1D(BIRTH_TIME*0.01)*2 - 1;
	const float RAND2 = noise1D(BIRTH_TIME*0.01+0.23543)*2 - 1;

	//растаскиваем вершины рандомно в стороны, хвост выравниваем обратно
	const float3x3 speedBasis = basis(normalize(startSpeed));
	const float3 posOffset = mul(float3(RAND, 0, RAND2)*AGE*4, speedBasis)*pow(1-o.nAge,3) - worldOffset;
	//const float3 posOffset = mul(float3(RAND, 0, RAND2)*AGE*4, speedBasis) - worldOffset;

	o.pos = PARTICLE_POS + posOffset;
	//o.pos = PARTICLE_POS - worldOffset;
	o.params2 = mul(float4(o.pos, 1), View);	

	o.params3.xyz = mul(float4(normalize(startSpeed), 1), View).xyz;
	o.params3.w = 0;
	o.params4 = 0;

	#undef startSpeed
	return o;
}


//считаем итоговую мировую позицию и относительное время жизни, остальные параметры просто передаем дальше
VS_OUTPUT2 VS_toiletPaper_tess(VS_INPUT i)
{
	VS_OUTPUT2 o;
	#define PARTICLE_POS i.params1.xyz	
	#define BIRTH_TIME i.params1.w
	#define startSpeed i.params2.xyz

	
	const float notFirstVertex = min(1, i.id); // равно 1 если не нулевая вершина
	o.nAge = min(1, (float(i.id)+timeOffset)/(pointsCount-1)) * notFirstVertex;

	const float AGE = (time - BIRTH_TIME) * notFirstVertex;
	const float RAND = noise1D(BIRTH_TIME*0.01)*2 - 1;
	const float RAND2 = noise1D(BIRTH_TIME*0.01+0.23543)*2 - 1;

	//растаскиваем вершины рандомно в стороны, хвост выравниваем обратно
	const float3x3 speedBasis = basis(normalize(startSpeed));

	float3 posOffset = mul(float3(RAND, 0, RAND2)*AGE*2, speedBasis) * pow(1-o.nAge,3) - worldOffset;

	//движение вдоль вектора скорости ---------
	const float speedValue = length(startSpeed);
	const float offset = -2 * (1 + (speedValue - 55.556)/100 );	
	const float xMin = exp(offset);
	posOffset +=  normalize(startSpeed) * 2*(log(xMin+AGE*2)-offset) * notFirstVertex ;
	//-----------------------------------------

	o.pos = PARTICLE_POS + posOffset;
	o.params1 = i.params1;
	o.params2 = float4(i.params2,0);
	o.params3 = 0;
	o.params4 = 0;

	#undef startSpeed
	return o;
}

//считаем итоговую мировую позицию и относительное время жизни, остальные параметры просто передаем дальше
VS_OUTPUT3 VS_toiletHexagon_tess(VS_INPUT i)
{
	VS_OUTPUT3 o;
	#define PARTICLE_POS i.params1.xyz	
	#define BIRTH_TIME i.params1.w
	#define startSpeed i.params2.xyz

	
	o.vertexId = i.id;
	const float notFirstVertex = min(1, o.vertexId); // равно 1 если не нулевая вершина
	o.nAge = min(1, (float(i.id)+timeOffset)/(pointsCount*2-1));// * notFirstVertex;

	const float AGE = (time - BIRTH_TIME);// * notFirstVertex;
	const float RAND = noise1D(BIRTH_TIME*0.01)*2 - 1;
	const float RAND2 = noise1D(BIRTH_TIME*0.01+0.23543)*2 - 1;

	//растаскиваем вершины рандомно в стороны
	const float3x3 speedBasis = basis(normalize(startSpeed));

	float3 posOffset = mul(float3(RAND, 0, RAND2)*pow(AGE*2,0.5), speedBasis)*2.0*pow(min(1,AGE*0.75),2) - worldOffset;

	// движение точки вдоль вектора скорости
	const float speedValue = length(startSpeed);
	const float offset = -2 * (1 + (speedValue - 55.556)/100 );	
	const float xMin = exp(offset);
	posOffset +=  normalize(startSpeed) * 2*(log(xMin+AGE*2)-offset);// * notFirstVertex ;
	//--------------------------------------

	o.pos = PARTICLE_POS + posOffset;
	o.params1 = i.params1;
	o.params2 = float4(i.params2,0);
	o.params3 = float4(normalize(startSpeed), speedValue); // tangent + speedValue
	o.params4 = 0;

	#undef startSpeed
	#undef BIRTH_TIME
	return o;
}

/////////////////////////////////////////////////////////////////
//////////////////// TESSELATION ////////////////////////////////
/////////////////////////////////////////////////////////////////

struct HS_PATCH_OUTPUT
{
    float edges[2] : SV_TessFactor;
};

HS_PATCH_OUTPUT HSconst(InputPatch<VS_OUTPUT2, 2> ip)
{
    HS_PATCH_OUTPUT o;

	float dist = length(ip[0].pos - ViewInv._41_42_43);

    o.edges[0] = 1; // Detail factor (see below for explanation)
	//o.edges[1] = 4*(1-pow(saturate((dist-100)/1000),2)) + 1; // Density factor [5/100]
	o.edges[1] = 1;

    return o;
}
HS_PATCH_OUTPUT HSconstHexagon(InputPatch<VS_OUTPUT3, 2> ip)
{
    HS_PATCH_OUTPUT o;

	//float dist = length(ip[0].pos - ViewInv._41_42_43);
	const float maxParticles = 32; // максимальное число партиклов, на которое разбивается отрезок
	const float minParticles = 1; //минимальное количество партиклов в конце следа

	float len = distance(ip[0].pos, ip[1].pos);

    o.edges[0] = 1; // Detail factor (see below for explanation)
	//o.edges[1] = 4*(1-pow(saturate((dist-100)/1000),2)) + 1; // Density factor [5/100]

	float particlesCount = minParticles + (maxParticles-minParticles) * pow( min(1, 1.2*(1-ip[0].nAge)), 2 ); //уменьшение количества партиклов к хвосту следа начиная прмиерно с 1/3
	o.edges[1] = particlesCount * min(1,len/segmentLength);//убираем лишние партиклы в первом отезке, в остальных всегда по максимуму

	//o.edges[1] = 2; 

    return o;
}


[domain("isoline")]
[partitioning("integer")]
[outputtopology("line")]
[outputcontrolpoints(2)]
[patchconstantfunc("HSconst")]
VS_OUTPUT2 HS(InputPatch<VS_OUTPUT2, 2> ip, uint id : SV_OutputControlPointID)
{
    VS_OUTPUT2 o;
    o = ip[id];
    return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("line")]
[outputcontrolpoints(2)]
[patchconstantfunc("HSconstHexagon")]
VS_OUTPUT3 HS_hexagon(InputPatch<VS_OUTPUT3, 2> ip, uint id : SV_OutputControlPointID)
{
    VS_OUTPUT3 o;
    o = ip[id];
    return o;
}

//мимо геометрического шейдера сразу на отрисовку как линия
[domain("isoline")]
PS_INPUT DS_spline(HS_PATCH_OUTPUT input, OutputPatch<VS_OUTPUT2, 2> op, float2 uv : SV_DomainLocation)
{
    PS_INPUT o;
	o.params = 0;

    float t = uv.x;
  
	float speedValue = length(op[0].params3.xyz);
	float dist = distance(op[0].pos, op[1].pos);

	float coef = 0.5; // относительная длина направляющих между контрольными точками

	//float3 tangent = op[0].params3.xyz*coef*dist/speedValue;

	float3 p0 = op[0].pos;
	float3 p1 = op[0].pos + op[0].params3.xyz*coef*dist/speedValue;

	speedValue = length(op[1].params3.xyz);
	float3 p2 = op[1].pos - op[1].params3.xyz*coef*dist/speedValue;
	float3 p3 = op[1].pos;	

	float3 pos = pow(1.0f - t, 3.0f) * p0 + 3.0f * pow(1.0f - t, 2.0f) * t * p1 + 3.0f * (1.0f - t) * pow(t, 2.0f) * p2 + pow(t, 3.0f) * p3;

	//o.params2 = mul(float4(o.pos, 1), View);	

	//o.params3.xyz = mul(float4(normalize(startSpeed), 1), View).xyz;

	//pos = lerp(op[0].pos, op[1].pos, t);

	o.pos = mul(float4(pos,1), VP);	
    //o.pos = mul(o.pos, Proj);	
    return o;
}


//через все круги ада
[domain("isoline")]
VS_OUTPUT2 DS(HS_PATCH_OUTPUT input, OutputPatch<VS_OUTPUT2, 2> op, float2 uv : SV_DomainLocation)
{
    VS_OUTPUT2 o;
	o = op[0];
	//o.params = 0;

    float t = uv.x;
  
	float speedValue = length(op[0].params3.xyz);
	float dist = distance(op[0].pos, op[1].pos);

	float coef = 0.5; // относительная длина направляющих между контрольными точками

	//float3 tangent = op[0].params3.xyz*coef*dist/speedValue;

	float3 p0 = op[0].pos;
	float3 p1 = op[0].pos + op[0].params3.xyz*coef*dist/speedValue;

	speedValue = length(op[1].params3.xyz);
	float3 p2 = op[1].pos - op[1].params3.xyz*coef*dist/speedValue;
	float3 p3 = op[1].pos;	

	float3 pos = pow(1.0f - t, 3.0f) * p0 + 3.0f * pow(1.0f - t, 2.0f) * t * p1 + 3.0f * (1.0f - t) * pow(t, 2.0f) * p2 + pow(t, 3.0f) * p3;

	o.pos = pos;//позиция вершины в МСК
	o.params2 = mul(float4(pos, 1), View);//в камере

	float4 speedResult = float4(normalize(lerp(op[0].params3.xyz,op[1].params3.xyz,t)), 0);

	o.params1.y = lerp(op[0].params1.y, op[1].params1.y, t);//время рождения
	o.params3.xyz = mul(speedResult, View).xyz; // интерполированная касательная в пространстве камеры

    return o;
}

//через все круги ада, тока скорость не переводим в пространство камеры
[domain("isoline")]
VS_OUTPUT2 DS_cross(HS_PATCH_OUTPUT input, OutputPatch<VS_OUTPUT2, 2> op, float2 uv : SV_DomainLocation)
{
    VS_OUTPUT2 o;
	o = op[0];

    const float t = uv.x;
  
	float speedValue = length(op[0].params3.xyz);

	const float dist = distance(op[0].pos, op[1].pos);
	const float coef = 0.5 * dist; // относительная длина направляющих между контрольными точками

	float3 p0 = op[0].pos;
	float3 p1 = op[0].pos + op[0].params3.xyz*coef/speedValue;

	speedValue = length(op[1].params3.xyz);
	float3 p2 = op[1].pos - op[1].params3.xyz*coef/speedValue;
	float3 p3 = op[1].pos;	

	float3 pos = pow(1 - t, 3) * p0 + 3.0f * pow(1 - t, 2) * t * p1 + 3.0f * (1 - t) * pow(t, 2) * p2 + pow(t, 3) * p3; //интерполированная позиция

	o.pos = pos;//позиция вершины в МСК
	o.params2 = mul(float4(pos, 1), View);//в камере

	o.params1.y = lerp(op[0].params1.y, op[1].params1.y, t); //время рождения
	o.params3.xyz = normalize(lerp(op[0].params3.xyz,op[1].params3.xyz,t)); // интерполированная касательная в МСК

    return o;
}


//через все круги ада, тока скорость не переводим в пространство камеры
[domain("isoline")]
VS_OUTPUT3 DS_hexagon(HS_PATCH_OUTPUT input, OutputPatch<VS_OUTPUT3, 2> op, float2 uv : SV_DomainLocation)
{
	#define POS_MSK(x)	op[x].pos	
	#define DIR(x)		   op[x].params3.xyz
	#define SPEED_VALUE(x) op[x].params3.w
	#define BIRTH_TIME_INTERP o.params1.w

    VS_OUTPUT3 o;
	//o = op[0];

	float t = uv.x;
	if(length(POS_MSK(1) > length(POS_MSK(0)))) // сортируем куски
		t = 1-uv.x;

    //const float t = uv.x;

	const float dist = distance(POS_MSK(0), POS_MSK(1));
	const float coef = 0.33 * dist; // относительная длина направляющих между контрольными точками

	float3 p0 = POS_MSK(0);
	float3 p1 = POS_MSK(0) + DIR(0)*coef;

	float3 p2 = POS_MSK(1) - DIR(1)*coef;
	float3 p3 = POS_MSK(1);	

	const float t2 = t*t;
	const float tInv = 1-t;
	const float tInv2 = tInv*tInv;
	float3 pos = tInv2*tInv * p0 + 3*tInv2*t*p1 + 3*tInv*t2*p2 + t2*t*p3; //интерполированная позиция в МСК
	//float3 pos = pow(1 - t, 3) * p0 + 3.0f * pow(1 - t, 2) * t * p1 + 3.0f * (1 - t) * pow(t, 2) * p2 + pow(t, 3) * p3; //интерполированная позиция

	o.nAge = lerp(op[0].nAge, op[1].nAge, t);
	o.params1 = lerp(op[0].params1, op[1].params1, t);

	const float RAND = noise1D(BIRTH_TIME_INTERP*0.01)*2 - 1;
	const float RAND2 = noise1D(BIRTH_TIME_INTERP*0.01+0.23543)*2 - 1;
	const float RAND3 = noise1D(BIRTH_TIME_INTERP*0.01+0.74345)*2 - 1;

	//TODO: сделать сделать затухание рандомного всплеска, когда в тесселяторе начнет убывать количество партиклов в одном сегменте - готово
	o.pos = pos + 0*10*float3(RAND, RAND2, RAND3)*pow(o.nAge, 0.5)*pow(max(0,(1-2*o.nAge)), 2); //позиция вершины в МСК + добавляем рандомное смещение

	
	o.params2 = mul(float4(pos, 1), View);//в камере
		
	o.params3 = lerp(op[0].params3, op[1].params3, t); // интерполированная касательная(вектор скорости) + величина скорости в МСК
	o.params3.xyz = normalize(o.params3.xyz); //нормализуем вектор скорости
	o.vertexId = lerp(op[0].vertexId, op[1].vertexId, t);

	#undef POS_MSK
    return o;	
}
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////





//GEOMETRY SHADERS


[maxvertexcount(segments+1)]
void GS_spline(lineadj VS_INPUT input[4], inout LineStream<PS_INPUT> outputStream)
{	
	PS_INPUT o;
	o.params = float4(0,0,0,0);

	float4 coefs[4];
	calcBSK4(input,coefs);	

	[unroll]
	for(float t=0; t<=1.0; t += 1.0/segments)
	{		
		o.pos = pointBS4(coefs,t);	
		outputStream.Append(o);
	}
}

/// позиция вершины передается в пространстве камеры
//[maxvertexcount( (segments+1)*2 )]
[maxvertexcount( (segments+1)*3 +5)] //с запасом на половину сегментов
void GS_toiletWire(lineadj VS_OUTPUT2 input[4], inout LineStream<PS_INPUT> outputStream)
{	
	#define BIRTH_TIME input[1].params1.w
	#define BIRTH_TIME2 input[2].params1.w
	PS_INPUT o;

	const float AGE = time - BIRTH_TIME;
	const float dAge = BIRTH_TIME - BIRTH_TIME2;

	o.params = float4(0,0,0,0);

	float3 coefs[4];
	float3 pos[segmentsMax];//вершины сплайна	
	int i=0;
	calcBSK3(input,coefs);	
	//интерполированные точки на сплайне
	[unroll]
	for(float t=0; t<=1.0; t += 1.0/segments, i++)
	{
		pos[i] = pointBS3(coefs,t);	
	}



	//первый квад
	float3 dir = pos[0] - input[0].params1.xyz;
	float2 dirProj = normalize(float2(dir.x, dir.y));
	float3 offset = {dirProj.y*scale, -dirProj.x*scale, 0};	
	//offset.xy *=  (1+AGE*sideSpeed);

	//float3 offsetResult =  offset * (1+AGE*sideSpeed);
	float3 offsetResult =  offset * (1 + pow(AGE*sideSpeed, 0.5)*1.5);
	

	o.pos = mul(float4(pos[0] + offsetResult, 1), Proj);
	outputStream.Append(o);	

	float4 firstPos = o.pos;

	o.pos = mul(float4(pos[0] - offsetResult, 1), Proj);
	outputStream.Append(o);

	float3 offset2 = {0,0,0};

	//остальные квады
	[unroll]
	for(i=1; i<segments; ++i)
	{
		dir = pos[i] - pos[i-1];
		dirProj = normalize(float2(dir.x, dir.y));

		float t = float(i)/(segments);
		float curAge = AGE + dAge*t;//абсолютный возраст
	
		offset2.xy = float2(dirProj.y*scale, -dirProj.x*scale);	
		offset2.xy = (offset.xy + offset2.xy) * 0.5;
		//offsetResult =  offset2 * (1+(AGE+dAge*t)*sideSpeed);
		offsetResult =  offset2 * (1 + pow(curAge*sideSpeed, 0.5)*1.5);

		o.pos = mul(float4(pos[i] + offsetResult, 1), Proj);
		outputStream.Append(o);	

		o.pos = mul(float4(pos[i] - offsetResult, 1), Proj);
		outputStream.Append(o);		

		offset.xy = offset2.xy;
	}

	//последний квад совмещаем с первым квадом следующего отрезка
	dir = pos[i] - input[1].params1.xyz;
	dirProj = normalize(float2(dir.x, dir.y));
	offset.xy = float2(dirProj.y*scale, -dirProj.x*scale);

	//offsetResult = offset * (1+(AGE+dAge)*sideSpeed);
	offsetResult =  offset * (1 + pow((AGE+dAge)*sideSpeed, 0.5)*1.5);

	o.pos = mul(float4(pos[i] + offsetResult, 1), Proj);
	outputStream.Append(o);	
	o.pos = mul(float4(pos[i] - offsetResult, 1), Proj);
	outputStream.Append(o);

	outputStream.RestartStrip();

	float3 vertexPos = input[1].params1.xyz;
	o.pos = mul(float4(vertexPos + float3(staticVertexData[0].x, staticVertexData[0].y,0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + float3(staticVertexData[1].x, staticVertexData[1].y,0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + float3(staticVertexData[3].x, staticVertexData[3].y,0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + float3(staticVertexData[2].x, staticVertexData[2].y,0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + float3(staticVertexData[0].x, staticVertexData[0].y,0), 1), Proj);
	outputStream.Append(o);
	outputStream.RestartStrip();
	#undef BIRTH_TIME
	#undef BIRTH_TIME2
}


void addEdge(in VS_OUTPUT2 input[4], inout PS_INPUT2 o, in float3 pos, in float3 offset, inout TriangleStream<PS_INPUT2> outputStream, in float age)
{
	const float normalOffset = 0.2*(1+age*0.15);
	const float texTile = 0.04;
	const float deepSpeed = 2; //скорость приращения глубины
	const float3 UVoffset = 1.4 * texTile * ViewInv._31_32_33 * (1+pow(abs(age),0.9)*deepSpeed);//смещение в глубину экрана для второй выборки из текстуры, увеличивается с возрастом
	
	//offset *= 1 + age;  
	offset *= 1 + pow(age, 0.5)*1.5;//увеличиваем ширину шлейфа по времени

	//----------------------------------------------
	float4 Pos = float4(pos + offset, 1);//позиция вершины в СК камеры
	o.pos = mul(Pos, Proj);//теперь в экранных координатах
	o.params.w = 0;//UV 		
	o.params.xyz =  mul(Pos, ViewInv).xyz * texTile; // UVW шума есть мировая позиция вершины * coef	
	o.params2.xyz = o.params.xyz - UVoffset;//второй комплект UVW шума, сдвигаемый в глубину экран по времени жизни вершины
	o.binormal = mul(float4(normalize(offset),0), ViewInv).xyz; // бинормаль в МСК, задается один раз для всего ребра
	outputStream.Append(o);	
	//---------------------------------------------
	Pos.xyz = pos - offset;//позиция вершины в СК камеры
	o.pos = mul(Pos, Proj);//теперь в экранных координатах
	o.params.w = 1;//UV 
	o.params.xyz = mul(Pos, ViewInv).xyz * texTile;
	o.params2.xyz = o.params.xyz - UVoffset;
	outputStream.Append(o);
}

/// позиция вершины передается в пространстве камеры
//[maxvertexcount( (segments+1)*2 )]
[maxvertexcount( (segments+1)*3 )] //с запасом на половину сегментов
void GS_toiletPaper(lineadj VS_OUTPUT2 input[4], inout TriangleStream<PS_INPUT2> outputStream)
{	
	#define BIRTH_TIME input[1].params1.y
	#define BIRTH_TIME2 input[2].params1.y
	PS_INPUT2 o;
	//o.params = float4(0,0,0,0);

	//const float AGE = pow(time - BIRTH_TIME,0.2);
	const float AGE = time - BIRTH_TIME;
	const float dAge = BIRTH_TIME - BIRTH_TIME2; //приращение абсолютного возраста
	const float dnAge = input[2].nAge - input[1].nAge; // приращение относительного возраста

	float3 coefs[4];
	float3 pos[segmentsMax];//вершины сплайна

	calcBSK3(input,coefs);	
	//calcCathmullRom3(input,coefs);	

	int i=0;
	//интерполированные точки на сплайне
	[unroll]
	for(float t=0; t<=1.0; t += 1.0/segments, i++)
	{
		pos[i] = pointBS3(coefs,t);	
		//pos[i] = pointCathmullRom3(coefs,t);
	}

	//const float K = 1/0.75;	
	const float opacityExp = 6;
	const float Utile = 2;
	const float texTile = 0.2;	
	//const flaot UVTile = 10;

	//первый квад
	float3 dir = pos[0] - input[0].params1.xyz;	//направление отрезка в СК камеры
	//float3 dir = input[1].params3.xyz;
	//dir.y =- dir.y;
	float2 dirProj = normalize(float2(dir.x, dir.y));// его проекция на экран
	float3 offset = {dirProj.y*scale, -dirProj.x*scale, 0};	

	//o.params3 = dir.z;

	//float Uoffset = BIRTH_TIME * Utile;
	//угол между касательными к сплайну, дает представление о его кривизне
	//float tangentAngle = dot(dir, normalize(pos[segments].xy - input[1].params1.xy));
	float3 dirNorm = normalize(dir);
	//o.params3 = 1 - saturate(abs(dirNorm.z)*3-2); 
	o.params3 = dirNorm.z; 

	o.params2.w = 1 - input[1].nAge;//непрозрачность партикла
	//o.tangent = dirNorm;
	const float3 startTangent = normalize(input[2].pos - input[1].pos);
	const float3 dTangent = normalize(input[3].pos - input[2].pos) - startTangent;

	o.tangent = startTangent;

	addEdge(input, o, pos[0], offset, outputStream, AGE*sideSpeed);

	float3 offset2 = {0,0,0};
	
	//остальные квады
	[unroll]
	for(i=1; i<segments; ++i)
	{
		dir = pos[i] - pos[i-1];
		dirNorm = normalize(dir);
		dirProj = normalize(float2(dir.x, dir.y));
		offset2.xy = float2(dirProj.y*scale, -dirProj.x*scale);	
		offset2.xy = (offset.xy + offset2.xy) * 0.5;

		o.params3 = dirNorm.z; 
			
		float t = float(i) / segments;		
		float curAge = AGE + dAge*t;//абсолютный возраст		

		o.tangent = startTangent + t*dTangent;	

		o.params2.w = 1 - input[1].nAge - dnAge*t;
		//o.params2.w -= dnAge; //фокус не прокатывает ибо набегает ошибка и o.params2.w оказывается меньше нуля

		addEdge(input, o, pos[i], offset2, outputStream, sideSpeed*curAge);
		offset.xy = offset2.xy;
	}

	//последний квад совмещаем с первым квадом следующего отрезка
	dir = pos[i] - input[1].params2.xyz;
	dirNorm = normalize(dir);

	dirProj = normalize(float2(dir.x, dir.y));
	offset.xy = float2(dirProj.y*scale, -dirProj.x*scale);	

	//o.tangent = dirNorm;
	o.tangent = startTangent + dTangent;
	//o.params.z = 1 -saturate(abs(normalize(dir).z)*3-2);
	//o.params3 = 1 - saturate(abs(dirNorm.z)*3-2); 
	o.params3 = dirNorm.z; 
	o.params2.w = 1 - input[2].nAge;
	addEdge(input, o, pos[i], offset, outputStream,(AGE+dAge)*sideSpeed);
	#undef BIRTH_TIME
	#undef BIRTH_TIME2
}







void addEdge2(inout PS_INPUT2 o, in float3 pos, in float3 offset, inout TriangleStream<PS_INPUT2> outputStream, in float age)
{	
	const float texTile = 0.04;
	const float deepSpeed = 2; //скорость приращения глубины
	const float3 UVoffset = 1.4 * texTile * ViewInv._31_32_33 * (1+pow(age,0.9)*deepSpeed);//смещение в глубину экрана для второй выборки из текстуры, увеличивается с возрастом
	
	//offset *= 1 + age;  
	offset *= 1 + pow(age, 0.5)*1.5;//увеличиваем ширину шлейфа по времени

	//----------------------------------------------
	float4 Pos = float4(pos + offset, 1);//позиция вершины в СК камеры
	o.pos = mul(Pos, Proj);//теперь в экранных координатах
	o.params.w = 0;//UV 		
	o.params.xyz =  mul(Pos, ViewInv).xyz * texTile; // UVW шума есть мировая позиция вершины * coef	
	o.params2.xyz = o.params.xyz - UVoffset;//второй комплект UVW шума, сдвигаемый в глубину экран по времени жизни вершины
	o.binormal = mul(float4(normalize(offset),0), ViewInv).xyz; // бинормаль в МСК, задается один раз для всего ребра
	outputStream.Append(o);	
	//---------------------------------------------
	Pos.xyz = pos - offset;//позиция вершины в СК камеры
	o.pos = mul(Pos, Proj);//теперь в экранных координатах
	o.params.w = 1;//UV 
	o.params.xyz = mul(Pos, ViewInv).xyz * texTile;
	o.params2.xyz = o.params.xyz - UVoffset;
	outputStream.Append(o);
}



//строим квадратик из выхлопа доменного шейдера
//позиция вершины передается в пространстве камеры
//[maxvertexcount( (segments+1)*2 )]
[maxvertexcount(4)]
void GS_toiletPaper_tess(line VS_OUTPUT2 input[2], inout TriangleStream<PS_INPUT2> outputStream)
{	
	#define BIRTH_TIME input[0].params1.w
	#define BIRTH_TIME2 input[1].params1.w
	PS_INPUT2 o;

	const float AGE = time - BIRTH_TIME; //абсолютный возраст
	const float dAge = BIRTH_TIME - BIRTH_TIME2; //приращение абсолютного возраста
	const float dnAge = input[1].nAge - input[0].nAge; // приращение относительного возраста
	
	//первый квад
	float3 dir = input[0].params3.xyz; //касательная в СК камеры
	float3 dirNorm = normalize(dir);
	float2 dirProj = normalize(float2(dir.x, dir.y));// его проекция на экран
	float3 offset = {dirProj.y*scale, -dirProj.x*scale, 0};	
	
	o.tangent = dir;
	o.params3 = dirNorm.z; 
	o.params2.w = 1 - input[0].nAge;//непрозрачность партикла	

	addEdge2(o, input[0].params2.xyz, offset, outputStream, AGE*sideSpeed);	
	
	//последний квад совмещаем с первым квадом следующего отрезка
	dir = input[1].params3.xyz;
	dirNorm = normalize(dir);
	dirProj = normalize(float2(dir.x, dir.y));
	offset.xy = float2(dirProj.y*scale, -dirProj.x*scale);	

	o.tangent = dir;
	o.params3 = dirNorm.z; 
	o.params2.w = 1 - input[1].nAge;

	addEdge2(o, input[1].params2.xyz, offset, outputStream,(AGE+dAge)*sideSpeed);
	#undef BIRTH_TIME
	#undef BIRTH_TIME2
}






//pos, offset, offset2 в МСК!!!  offset тупо прибавляется к позиции, вершины задаются вдоль offset2
void addEdge_cross(inout PS_INPUT_GEOM o, in float3 pos, in float3 offset, in float3 offset2, inout TriangleStream<PS_INPUT_GEOM> outputStream, in float age)
{	
	const float texTile = 0.04;
	const float deepSpeed = 2; //скорость приращения глубины
	const float3 UVoffset = 1.4 * texTile * ViewInv._31_32_33 * (1+pow(age,0.9)*deepSpeed);//смещение в глубину экрана для второй выборки из текстуры, увеличивается с возрастом
	
	const float offsetCoef = 1 + pow(age, 0.5)*1.5;
	offset *= offsetCoef;//увеличиваем ширину шлейфа по времени
	offset2 *= offsetCoef;//увеличиваем ширину шлейфа по времени

	//----------------------------------------------
	o.normal = offset + offset2;
	float3 Pos = pos + o.normal;//позиция вершины в МСК
	o.pos = mul(float4(Pos,1), VP);//теперь в экран
	o.normal = normalize(o.normal);
	o.params.w = 0;//UV 		
	o.params.xyz =  Pos * texTile; // UVW шума есть мировая позиция вершины * coef	
	o.params2.xyz = o.params.xyz - UVoffset;//второй комплект UVW шума со сдвигом в глубину экран по времени жизни вершины
	outputStream.Append(o);	

	//---------------------------------------------
	//Pos -= offset2*2;//позиция вершины в МСК
	o.normal = offset - offset2;
	Pos = pos + o.normal; 
	o.normal = normalize(o.normal);
	o.pos = mul(float4(Pos,1), VP);//теперь в экран
	o.params.w = 1;//UV 
	o.params.xyz = Pos * texTile;
	o.params2.xyz = o.params.xyz - UVoffset;
	outputStream.Append(o);
}

//строим  квадрат из выхлопа доменного шейдера
//позиция вершины передается в пространстве камеры
//[maxvertexcount( (segments+1)*2 )]
[maxvertexcount(12)]
void GS_toiletCube_tess(line VS_OUTPUT2 input[2], inout TriangleStream<PS_INPUT_GEOM> outputStream)
{	
	#define BIRTH_TIME input[0].params1.w
	#define BIRTH_TIME2 input[1].params1.w
	#define POS_MSK(x) input[x].pos
	#define TANGENT_MSK(x) input[x].params3.xyz
	PS_INPUT_GEOM o1, o2;

	const float AGE = time - BIRTH_TIME; //абсолютный возраст
	const float dAge = BIRTH_TIME - BIRTH_TIME2; //приращение абсолютного возраста
	const float dnAge = input[1].nAge - input[0].nAge; // приращение относительного возраста
	
	o1.tangent = TANGENT_MSK(0);
	o1.params3 = 0;///dirNorm.z; 
	o1.params2.w = 1 - input[0].nAge;//непрозрачность партикла	

	o2.tangent = TANGENT_MSK(1);
	o2.params3 = 0;///dirNorm.z; 
	o2.params2.w = 1 - input[1].nAge;

	//первый квад
	float3 offset10 = normalize(cross(TANGENT_MSK(0),axisY));//вектор смещения вбок
	float3 offset20 = cross(TANGENT_MSK(0), offset10);//ортогональный вектор смещения вверх

	//последний квад совмещаем с первым квадом следующего отрезка
	float3 offset11 = normalize(cross(TANGENT_MSK(1),axisY));//вектор смещения вбок
	float3 offset21 = cross(TANGENT_MSK(0), offset11);//ортогональный вектор смещения вверх
	
	// 1й квад ----------------------------------------------------------------------

	addEdge_cross(o1, input[0].pos, offset10, offset20, outputStream, AGE*sideSpeed);	
	addEdge_cross(o2, input[1].pos, offset11, offset21, outputStream,(AGE+dAge)*sideSpeed);
	outputStream.RestartStrip();

	// 2й квад ----------------------------------------------------------------------
	addEdge_cross(o1, input[0].pos, -offset10, -offset20, outputStream, AGE*sideSpeed);	
	addEdge_cross(o2, input[1].pos, -offset11, -offset21, outputStream,(AGE+dAge)*sideSpeed);
	outputStream.RestartStrip();

	// нижний -----------------------------------------------------------------------
	addEdge_cross(o1, input[0].pos, offset20, -offset10, outputStream, AGE*sideSpeed);		
	addEdge_cross(o2, input[1].pos, offset21, -offset11, outputStream,(AGE+dAge)*sideSpeed);
	outputStream.RestartStrip();

	// верхний -----------------------------------------------------------------------
	addEdge_cross(o1, input[0].pos, -offset20, offset10, outputStream, AGE*sideSpeed);	
	addEdge_cross(o2, input[1].pos, -offset21, offset11, outputStream,(AGE+dAge)*sideSpeed);
	outputStream.RestartStrip();
	#undef BIRTH_TIME
	#undef BIRTH_TIME2
	#undef POS_MSK
	#undef TANGENT_MSK
}







//pos, offset, offset2 в МСК!!! offset тупо прибавляется к позиции, вершины задаются вдоль offset2
void addEdge_hexagon(inout PS_INPUT_GEOM o[2], in float3 pos1, in float3 pos2, inout TriangleStream<PS_INPUT_GEOM> outputStream, in float age1, in float age2, in float rad,
					 in float3 X1, in float3 Y1, in float3 X2, in float3 Y2)
{	
	const float texTile = 0.05;
	const float deepSpeed = 1; //скорость приращения глубины
	const float3 UVoffset1 = 1.4 * texTile * ViewInv._31_32_33 * (1+pow(age1,0.5)*deepSpeed);//смещение в глубину экрана для второй выборки из текстуры, увеличивается с возрастом	
	const float offsetCoef1 = 1 + pow(age1, 0.5)*2.5; // увеличение толщины шлейфа

	const float3 UVoffset2 = 1.4 * texTile * ViewInv._31_32_33 * (1+pow(age2,0.5)*deepSpeed);//смещение в глубину экрана для второй выборки из текстуры, увеличивается с возрастом	
	const float offsetCoef2 = 1 + pow(age2, 0.5)*2.5; // увеличение толщины шлейфа

	float _sin,_cos;
	sincos(rad, _sin, _cos);

	float3 offset1 = X1*_cos + Y1*_sin;
	float3 offset2 = X2*_cos + Y2*_sin;
	offset1 *= offsetCoef1; 
	offset2 *= offsetCoef2;

	//----------------------------------------------
	float3 Pos = pos1 + offset1;//позиция вершины в МСК
	o[0].posW = Pos;
	o[0].pos = mul(float4(Pos,1), VP);//теперь в экран
	o[0].normal = normalize(offset1);
	o[0].params.w = 0;//UV 		
	//o[0].params.xyz =  Pos * texTile; - ViewInv._31_32_33*0.2; // UVW шума есть мировая позиция вершины * coef	
	o[0].params.xyz = (Pos + worldOffset) * texTile;
	o[0].params2.xyz = o[0].params.xyz - UVoffset1;//второй комплект UVW шума со сдвигом в глубину экран по времени жизни вершины
	outputStream.Append(o[0]);	

	//---------------------------------------------
	Pos = pos2 + offset2; 
	o[1].posW = Pos;
	o[1].normal = normalize(offset2);
	o[1].pos = mul(float4(Pos,1), VP);//теперь в экран
	o[1].params.w = 1;//UV 
	//o[1].params.xyz = Pos * texTile; - ViewInv._31_32_33*0.2;
	o[1].params.xyz =  (Pos + worldOffset) * texTile;
	o[1].params2.xyz = o[1].params.xyz - UVoffset2;
	outputStream.Append(o[1]);
}


//строим  квадрат из выхлопа доменного шейдера
//позиция вершины передается в пространстве камеры
static const int edges = 8;

[maxvertexcount(edges*2+2)]
void GS_toiletHexagon_tess(line VS_OUTPUT3 input[2], inout TriangleStream<PS_INPUT_GEOM> outputStream)
{	
	#define BIRTH_TIME(x) input[x].params1.w
	//#define OPACITY(x) input[x].params1.z
	#define POS_MSK(x) input[x].pos
	#define TANGENT_MSK(x) input[x].params3.xyz
	
	PS_INPUT_GEOM o[2];

	const float AGE = time - BIRTH_TIME(0); //абсолютный возраст
	const float dAge = BIRTH_TIME(0) - BIRTH_TIME(1); //приращение абсолютного возраста
	const float dnAge = input[1].nAge - input[0].nAge; // приращение относительного возраста

	const float fadeInLength = 10;
	//input[0].vertexId
	//float	speedCurrent;
	//float	segmentLength;		
	//o.vertexId = i.id;
	//const float notFirstVertex = min(1, o.vertexId); // равно 1 если не нулевая вершина
	//o.nAge = min(1, (float(i.id)+timeOffset)/(pointsCount-1)) * notFirstVertex;

	// TODO:
	// посчитать градиент fadeIn
	// вынести цвет в юниформу
	// вынести ширину в юниформу
	// вынести длину в конфиг
	// вынести шаг в конфиг
	// протащить прозрачность от эмиттера до конца
	// добавить сдвиг UVW координат против вектора скорости!!! для имитации начальной скорости следа

	float dist = segmentLength*max(0,input[0].vertexId-1) + segmentLength*timeOffset;
	o[0].params3 = min(1,dist/fadeInLength);

	dist = speedCurrent*(input[1].vertexId);
	o[1].params3 = min(1,dist/fadeInLength);

	
	o[0].tangent = TANGENT_MSK(0);
	//o[0].params3 = 0;///dirNorm.z; 
	o[0].params2.w = 1 - input[0].nAge; //относительный возраст
	//o[0].params3 = OPACITY(0); //прозрачность точки от эмиттера

	o[1].tangent = TANGENT_MSK(1);
	//o[1].params3 = 0;///dirNorm.z; 
	o[1].params2.w = 1 - input[1].nAge;
	o[1].params3 = 1;//OPACITY(1);

	//первый квад
	float3 offset10 = normalize(cross(TANGENT_MSK(0), axisY));//вектор смещения вбок
	float3 offset20 = cross(TANGENT_MSK(0), offset10);//ортогональный вектор смещения вверх

	//последний квад совмещаем с первым квадом следующего отрезка
	float3 offset11 = normalize(cross(TANGENT_MSK(1), axisY));//вектор смещения вбок
	float3 offset21 = cross(TANGENT_MSK(0), offset11);//ортогональный вектор смещения вверх	
	
	const float baseScale = 0.5;
	offset10 *= baseScale;
	offset20 *= baseScale;
	offset11 *= baseScale;
	offset21 *= baseScale;


	const float age1 = AGE*sideSpeed * min(1,input[0].vertexId);
	const float age2 = (AGE+dAge)*sideSpeed * min(1,input[1].vertexId);

	const float dAngle = 2*PI/edges;
	//const float age1 = AGE*sideSpeed;
	//const float age2 = (AGE+dAge)*sideSpeed;

	[unroll]
	for(int i=0; i<edges; ++i)
	{
		addEdge_hexagon(o, input[0].pos, input[1].pos, outputStream, age1, age2, i*dAngle, offset10, offset20, offset11, offset21);	
	}
	addEdge_hexagon(o, input[0].pos, input[1].pos, outputStream, age1, age2, 0, offset10, offset20, offset11, offset21);

	//#undef OPACITY
	#undef BIRTH_TIME
}































float4 PS(PS_INPUT In) : SV_TARGET0
{ 	
	#define	TRANSPARENCY In.params.z
	#define	BRIGHTNESS In.params.w	
	
	//float4 clr = tex2D(texMap, params.xy);
	float4 clr = TEX2D(tex, In.params).a;

	clr.a *= clr.r*TRANSPARENCY;
	clr.r *= BRIGHTNESS * (1-TRANSPARENCY*0.5)*0.5;
	clr.gb = clr.r;
	return clr;
}

float4  PS_solid(PS_INPUT i) : SV_TARGET0
{ 	
	//return float4(i.params.z*2, i.params.z*2, i.params.z*2, 1);
	return float4(i.params.w, i.params.w, i.params.w, 0.7);	
}

float4  PS_toiletPaper(PS_INPUT2 i) : SV_TARGET0
{	
	#define UVparam i.params.w
	#define nAge i.params2.w // 1 - начало, 0 - конец
	#define dotView i.params3
	float3 tangent = normalize(i.tangent);//направление отрезка в МСК
	float3 binorm = normalize(i.binormal);//бинормаль в МСК
	float3 norm = normalize(cross(tangent, i.binormal));

	//float3 tmp = binorm*0.5 + 0.5;
	const float densityCoef = pow(abs(dotView),3);//плотность дыма, чем меньше угол между вектором взгляда и поверхностю, тем коэффициент больше
	const float convexity = 0.2; // чем больше значение, тем более плоско
	const float normParam = UVparam*2-1; // [-1; 1]
	const float cilyndricAlpha = sqrt(1-normParam*normParam);
	norm = binorm*normParam + convexity*norm*cilyndricAlpha; //нормаль для полусферы, 0.3 - коэф. выпуклости
	
	binorm = normalize(cross(norm,tangent));
	float3x3 M = {tangent, binorm, norm};

	//выборки
	float4 clr = TEX3D(noiseTex, i.params.xyz);
	float4 clr2 = TEX3D(noiseTex, i.params2.xyz);
	float4 clrLowRes = TEX3D(noiseTex, i.params.xyz*0.05);
	clr = lerp(clr,clr2, 0.5);
	clr = lerp(clrLowRes, clr, pow(nAge,7));

	float3 normDelta = clr.xyz*2-1;	
	//float3 normDelta = TEX3D(noiseTex, i.params.xyz*2).rgb*2-1;

	//normDelta.b *= (1+nAge*2);
	normDelta.b += nAge*3;

	//norm = normalize(mul(normalize(normDelta), M));
	norm = lerp(normalize(mul(normalize(normDelta), M)).xyz, norm, densityCoef); //бугры при взгляде сбоку, и гладкая поверхность при взгляде вскользь

	float light = dot(normalize(norm), sunDir)*0.5 + 0.5;		


	//const float3 diffColor = {0.9,0.2,0.2};
	const float3 diffColor = {0.2,1.0,0.2};
	//const float3 diffColor = {1.0,1.0,1.0};
	const float3 lumCoef =  {0.2125f, 0.7154f, 0.0721f};
	float lum = dot(lumCoef, diffColor);//яркость
	/*
	//полусфера * fadeout
	clr.a *= pow(cilyndricAlpha, 4) * pow(nAge, 1.5);// * nAge;
	//clr.a *= pow(sin(UVparam*PI), 4) * pow(nAge, 1.0);// * nAge;
	clr.a *= clr.a;
	clr.a = saturate(clr.a*3);
	*/
	clr.rgb = lerp(float3(lum,lum,lum), diffColor, clr.a);

	//clr.rgb *= lerp(1, pow(abs(light), 0.3), pow(nAge, 0.5)); //убираем влияние освещения к хвосту следа
	//clr.rgb *= lerp(1, pow(abs(light), 0.6), pow(nAge, 0.5)); //убираем влияние освещения к хвосту следа
	clr.rgb *= lerp(1, light, pow(nAge, 0.5)); //убираем влияние освещения к хвосту следа

	clr.a =  max(0, (clr.a-0.15)) / 0.85;//обрезаем прозрачность снизу
	//clr.a = pow(clr.a,0.5);
	
	//clr.a = lerp(clr.a, 1, densityCoef);1
	clr.a *= pow(cilyndricAlpha, 4) * pow(nAge, 0.5);//поперечный градиент для полусферы * fadeout
	//clr.a *= pow(cilyndricAlpha, 1+10*clr.a) * pow(nAge, 1.0);//поперечный градиент для полусферы * fadeout
	clr.a *= clr.a;
	clr.a = saturate(clr.a*3);

	//float dot = mul(float4(sunDir,1), View).z;
	const float3 sunColor = {255/255.0, 250/255.0, 215/255.0};
	//const float3 sunColor = {255/255.0, 190/255.0, 117/255.0};
	float dotSun = dot(sunDir, View._13_23_33)*0.5 + 0.5;
	//clr.rgb = lerp(clr.rgb, sunColor, pow((1-dotSun),2) * pow(1-clr.a,4) );//ореол по контуру дыма против солнца
	//float alphaParam = 1-saturate(2*pow(clr.a-0.01, 3));
	float alphaParam = pow(1-saturate(2*(clr.a-0.1)), 5);
	clr.rgb = lerp(clr.rgb, sunColor, pow((1-dotSun),4) * alphaParam );//ореол по контуру дыма против солнца
	//light = dotSun;
	//clr.a *= 1 - saturate(abs(i.params3)*3-2);// прозрачность на крутом изгибе 	

	//clr.a *= clr.a;
	//float4 clr = TEX3D(noiseTex, i.params).a*1.5;	
	//return float4(light,light,light, 1);
	//return float4(tmp,1);
	//return float4(normDelta.x, normDelta.y, normDelta.z, 1);
	//return float4(nAge, nAge, nAge, 1);

	//return float4(i.params3, i.params3, i.params3, 1);
	return clr;
}

float4  PS_toiletCylinder(PS_INPUT_GEOM i) : SV_TARGET0
{	
	#define UVparam i.params.w
	#define nAge i.params2.w // 1 - начало, 0 - конец
	#define OPACITY i.params3
	#define UVW1 i.params.xyz
	#define UVW2 i.params2.xyz
	#define WORLD_POS i.posW

	float3 tangent = normalize(i.tangent);//направление отрезка в МСК	
	float3 norm = normalize(i.normal); // нормаль
	float3 binorm = cross(norm, tangent);//бинормаль в МСК
	
	const float densityCoef = 0; ///!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
	//const float densityCoef = pow(abs(dotNormView),3); //плотность дыма, чем меньше угол между вектором взгляда и поверхностю, тем коэффициент больше
	//const float densityCoef = pow(abs(dotView),3); //плотность дыма, чем меньше угол между вектором взгляда и поверхностю, тем коэффициент больше
	
	float3x3 M = {tangent, binorm, norm};//базис для карты нормалей

	//выборки
	float4 clr = TEX3D(noiseTex, UVW1);
	float4 clr2 = TEX3D(noiseTex, UVW2);
	float4 clrLowRes = TEX3D(noiseTex, UVW1*0.05);

	clr = lerp(clr,clr2, 0.5);
	clr = lerp(clrLowRes, clr, pow(nAge,7));

	float3 normDelta = clr.xyz*2-1;	//нормаль из карты
	normDelta.z += nAge*0.1;//делаем менее выпуклой по времени

	//float3 normCylinder = norm;
	norm = lerp(normalize(mul(normalize(normDelta), M)), norm, densityCoef); //бугры при взгляде сбоку, и гладкая поверхность при взгляде вскользь

	float light = dot(normalize(norm), sunDir)*0.25 + 0.75; // освещеника [0.5; 1]	
	

	//const float3 diffColor = {0.9,0.2,0.2}; //red
	const float3 diffColor = {0.2,1.0,0.2}; //green
	//const float3 diffColor = {0.2,0.6,1.0}; //blue
	//const float3 diffColor = {1.0,1.0,1.0};
	const float3 lumCoef =  {0.2125f, 0.7154f, 0.0721f};
	float lum = dot(lumCoef, diffColor);//яркость	
	clr.rgb = lerp(float3(lum,lum,lum), diffColor, clr.a);//обесцвечиваем с уменьшением альфы


	clr.rgb *= lerp(1, light, pow(nAge, 0.5)); //убираем влияние освещения к хвосту следа

	clr.a =  max(0, (clr.a-0.15)) / 0.85; //обрезаем прозрачность снизу

	//clr.a = lerp(clr.a, 1, densityCoef);
		

	//float3 ViewDirReal = normalize(WORLD_POS - ViewInv._41_42_43);
	float3 ViewDirReal = normalize(WORLD_POS);
	//float3 ViewDirReal = View._13_23_33;

	float dotNormView = dot(norm, normalize(cross(-tangent, ViewDirReal)));
	//float dotNormView = dot(norm, View._13_23_33);

	float edge = 1 - pow(max(0, abs(dot(tangent, ViewDirReal))-0.98)/0.02, 2);//выделяем места, где дирекшн направлен на реальный вектор взгляда
	//edge *= 1-abs(dotNormView); //выделяем края, параллельные реальному дирекшену
	//edge *= 1- pow(  max(0, abs(dotNormView)-0.3)/0.7,    1);
	//edge *= 1- pow(  max(0, (pow(abs(dotNormView),0.5)-0.3)/0.7),    1);
	//edge *= 1 - pow(  max(0, (pow(abs(dotNormView),0.5)-0.2)/0.8),    1); // истинное шаманство c толщиной и границами шлейфа
	//edge *= 1- pow(  max(0, (pow(abs(dotNormView),0.7)-0.1)/0.9),    1); // истинное шаманство c толщиной и границами шлейфа //////////////////////////////// good
	
	edge *= 1- pow(  max(0, (pow(abs(dotNormView),0.7)-0.1)/0.9),    2);	

	//edge *= 1 - abs(dotNormView);


	clr.a *= edge * pow(nAge, 0.5);
	clr.a *= clr.a;
	clr.a = saturate(clr.a*3);

	//---------- ореол ----------------------
	const float3 sunColor = {255/255.0, 250/255.0, 215/255.0};
	//const float3 sunColor = {255/255.0, 190/255.0, 117/255.0};
	float dotSun = dot(sunDir, View._13_23_33)*0.5 + 0.5;
	float alphaParam = pow(1-saturate(2*(clr.a-0.1)), 5);
	clr.rgb = lerp(clr.rgb, sunColor, pow((1-dotSun),4) * alphaParam );//ореол по контуру дыма против солнца
	//---------------------------------------
	
	//light = OPACITY;
	//light = edge;
	//return float4(light,light,light, 1);
	//return float4(tangent*0.5+0.5,1);

	return clr;

	#undef nAge
	#undef OPACITY
}
















float4  PS_black(PS_INPUT i) : SV_TARGET0
{ 	
	return float4(0,0,0,1);	
}

technique10 Solid
{
	pass P0
    {
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		//VERTEX_SHADER(VS_spline())
		VERTEX_SHADER(VS_toiletPaper())
		//GEOMETRY_SHADER(BezierGS())
		GEOMETRY_SHADER(GS_toiletPaper())
		//PIXEL_SHADER(PS()) 
		PIXEL_SHADER(PS_toiletPaper()) 
    }
    pass P1
    {
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS_toiletPaper())
		GEOMETRY_SHADER(GS_toiletWire())		
		PIXEL_SHADER(PS_black()) 
    }
}

// техника ресует партиклы в тесселированных точках на сплайне
technique10 Textured
{
	pass P_tessSpline_cross
    {
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		BACK_CULLING;

		VERTEX_SHADER(VS_toiletHexagon_tess())
		SetHullShader(CompileShader(hs_5_0, HS_hexagon()));
		SetDomainShader(CompileShader(ds_5_0, DS_hexagon()));	
		GEOMETRY_SHADER(GS_particle_tess())
		//PIXEL_SHADER(PS_black()) 
		PIXEL_SHADER(PS_particle()) 
    }

	pass P_tessWireframe
    {
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS_toiletPaper_tess())
		SetHullShader(CompileShader(hs_5_0, HS()));
		SetDomainShader(CompileShader(ds_5_0, DS()));	
		GEOMETRY_SHADER(GS_toiletWire_tess())	
		PIXEL_SHADER(PS_black()) 
    }
}


//техника рисует цилиндрическую геометрию по сплайну, с тесселяцией. 
//количество радиальных сегментов задается в геометрическом шейдере
/*
technique10 Textured
{
	//pass P_tessSpline_paper
 //   {
	//	ENABLE_RO_DEPTH_BUFFER;
	//	ENABLE_ALPHA_BLEND;
	//	DISABLE_CULLING;

	//	VERTEX_SHADER(VS_toiletPaper_tess())
	//	SetHullShader(CompileShader(hs_5_0, HS()));
	//	SetDomainShader(CompileShader(ds_5_0, DS()));	
	//	GEOMETRY_SHADER(GS_toiletPaper_tess())
	//	PIXEL_SHADER(PS_toiletPaper()) 
 //   }

	pass P_tessCylinder
    {
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		//DISABLE_CULLING;
		BACK_CULLING;

		VERTEX_SHADER(VS_toiletHexagon_tess())
		SetHullShader(CompileShader(hs_5_0, HS_hexagon()));
		SetDomainShader(CompileShader(ds_5_0, DS_hexagon()));	
		GEOMETRY_SHADER(GS_toiletHexagon_tess())
		//PIXEL_SHADER(PS_black()) 
		PIXEL_SHADER(PS_toiletCylinder()) 
    }

	pass P_tessWireframe
    {
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS_toiletPaper_tess())
		SetHullShader(CompileShader(hs_5_0, HS()));
		SetDomainShader(CompileShader(ds_5_0, DS()));	
		GEOMETRY_SHADER(GS_toiletWire_tess())	
		PIXEL_SHADER(PS_black()) 
    }

  //  pass P0
  //  {
		//ENABLE_RO_DEPTH_BUFFER;
		//ENABLE_ALPHA_BLEND;
		//DISABLE_CULLING;

		////VERTEX_SHADER(VS_spline())
		//VERTEX_SHADER(VS_toiletPaper())
		////GEOMETRY_SHADER(BezierGS())
		//GEOMETRY_SHADER(GS_toiletPaper())
		////PIXEL_SHADER(PS()) 
		//PIXEL_SHADER(PS_toiletPaper()) 
  //  }
}
*/