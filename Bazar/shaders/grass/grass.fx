#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/colorTransform.hlsl"
#include "ParticleSystem2/perlin.hlsl"
#include "ParticleSystem2/noiseSimplex.hlsl"


static const float PI2 = 6.28319f;

cbuffer cGrassParams
{
	float4	lodRadiusGrassDiameterSize;
	float4	grassBladeParams;
	uint4	intParams;	//zw - unused
};

float3 camPosAligned;
float3 centerOffset;
float4 gridOffset;//xy-выравнивание сетки по квадратам; zw-сдвиг симплекс шума для ветра

Texture2D<float2> heightMap;//карта высот
Texture2D colorMap;

float4x4 VP;
float4	origin;	//xyz -origin, w - time

float3	wind;//sin, cos, speed

#define radiusMin		lodRadiusGrassDiameterSize.x //радиус ближнего лода
#define radiusMax		lodRadiusGrassDiameterSize.y //радиус дальнего лода
#define grassDiameter	lodRadiusGrassDiameterSize.z //диаметр круга травы, в метрах
#define quadSize		lodRadiusGrassDiameterSize.w //размер ячейки травы

#define grassHalfWidth	grassBladeParams.x //половина ширины травинки, м
#define grassHeight		grassBladeParams.y //масимальная средняя высота травинки, м
#define bendDistMax		grassBladeParams.z //максимальная проекция наклона травинки в сторону, м
#define pointSpread		grassBladeParams.w //разброс травинок одной ячейки, как бы метры

#define lodsCount		intParams.x //количество лодов
#define heightMapSize	intParams.y //размер карты высот в пикселях

#define time origin.w
#define windSpeed wind.z
#define windOffset gridOffset.zw

static const float	lodRange = radiusMax - radiusMin;

static const float2 SaturationHeightTable[] = {
	float2(0.2600,0.0000),
	float2(0.2600,0.2500),
	float2(0.2600,0.5000),
	float2(0.2600,0.7500),
	float2(0.2600,1.0000),
	float2(0.3200,0.0000),
	float2(0.3200,0.2500),
	float2(0.3200,0.5000),
	float2(0.3200,0.7500),
	float2(0.3200,1.0000),
	float2(0.3800,0.0000),
	float2(0.3800,0.2500),
	float2(0.3800,0.5000),
	float2(0.3800,0.7500),
	float2(0.3800,1.0000),
	float2(0.4400,0.0000),
	float2(0.4400,0.2500),
	float2(0.4400,0.5000),
	float2(0.4400,0.7500),
	float2(0.4400,1.0000),
	float2(0.5000,0.0000),
	float2(0.5000,0.2500),
	float2(0.5000,0.5000),
	float2(0.5000,0.7500),
	float2(0.5000,1.0000),
};



//SamplerState ClampPointSampler
//{
//	Filter        = MIN_MAG_MIP_POINT;
//	AddressU      = WRAP;
//	AddressV      = WRAP;
//	AddressW      = WRAP;
//	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
//	BorderColor   = float4(0, 0, 0, 0);
//};

struct VS_OUTPUT
{
    float3 pos	: POSITION0;
};

struct HS_CONST_OUTPUT
{
	float edges[2] : SV_TessFactor;
	float4 lodParam: TEXCOORD1;
};

struct HS_OUTPUT
{
    float3 pos  : POSITION0;
	float4 color: COLOR0;//color, grass height
};

struct DS_OUTPUT
{
    float4 pos	 : POSITION0;//pos, lodFactor
    float4 color : COLOR0;//clr, height
	float4 params: TEXCOORD0;//
	//int bladeId:TEXCOORD2;//DEBUG
};

struct GS_OUTPUT
{
    float4 pos  : SV_POSITION0;
    float3 color : COLOR0;//rgb-color, w - gradient
	//int bladeId:TEXCOORD2;//DEBUG
};




VS_OUTPUT vs(in float2 pos: POSITION0)
{
	VS_OUTPUT o;
	//локальную координату сетки переводим в пиксель на текстуре
	float2 UV = pos.xy/grassDiameter + 0.5;	UV.y = 1-UV.y;//меняем местами координаты		

	float2 height = heightMap.SampleLevel(ClampPointSampler, UV, 0).r - 1000.f;////////////////////////////////////////////////////////////

	o.pos.xyz = float3(pos.x, height.x, pos.y);

	return o;
}

VS_OUTPUT vsTest(in float2 pos: POSITION0)
{
	VS_OUTPUT o;
	o.pos.xyz = float3(pos.x, 0, pos.y) - origin.xyz;
	return o;
}

// HULL SHADER ---------------------------------------------------------------------

HS_CONST_OUTPUT hsConstant( InputPatch<VS_OUTPUT, 1> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o; 

	float distReal = distance(ip[0].pos.xyz+centerOffset, float3(0, origin.y, 0));
	float dist = max(0, distReal - radiusMin);//задаем минимальный радиус ближнего лода
	float nDist = min(1, (dist/lodRange));
	
	o.lodParam.w = floor(lodsCount*(1-nDist) + 0.500001); // lodId
	o.lodParam.x = frac((lodsCount)*nDist+0.5);//*2;//нормализованный параметр расстояния от ближней до дальней границы лода
	
	//относительное расстояние до конца круга травы,выглядит норм, если трава всегда находится в нуле, при смещении камеры вперед не подходит
	//o.lodParam.y = 2*distReal/grassDiameter; 
	//относительное расстояние до конца круга травы, всегда считаем от ее центра
	o.lodParam.y = 2*distance(ip[0].pos.xyz, float3(0, origin.y, 0)) / grassDiameter;
	o.lodParam.z = 2*distReal / grassDiameter; //от центра камеры до реального положения вершины

	o.edges[1] = exp2(o.lodParam.w);//2 точки, и для кажой точки 2^lod травинок
	o.edges[0] = 1; // detail factor	

	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("line")]
[outputcontrolpoints(1)]
[patchconstantfunc("hsConstant")]
HS_OUTPUT hs( InputPatch<VS_OUTPUT, 1> ip, uint cpid : SV_OutputControlPointID)
{
	HS_OUTPUT o;
    o.pos = ip[0].pos;	
	//читаем цвет травы
	float2 UV = o.pos.xz/grassDiameter + 0.5;	UV.y = 1-UV.y;//меняем местами координаты		
	o.color.rgb = colorMap.SampleLevel(ClampPointSampler, UV, 0).rgb;////////////////////////////////////////////////////////////////
	//распаковываем цвет травы
	uint tableId = o.color.g*24.0+0.5;
	o.color.ga = SaturationHeightTable[tableId];
	o.color.rgb = hsv2rgb(o.color.rgb);

    return o;
}

float windAmount2D(float2 uv)
{
	//float result = 0.0f;	
	//result = (snoise(uv)*0.5+0.5);
	//result += (snoise(uv*2)*0.5+0.5)*0.25;
	return snoise(uv)*0.5+0.5;
}


// DOMAIN SHADER ---------------------------------------------------------------------
[domain("isoline")]
DS_OUTPUT ds( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> patch )
{
	#define BLADES_TOTAL input.edges[1]
	#define LOD_GRAD input.lodParam.x
	#define DIST_GRAD input.lodParam.y// от центра круга до его края с учетом высоты камеры
	#define DIST_GRAD_WORLD input.lodParam.z //от центра камеры до реального положения вершины
	#define LOD_ID input.lodParam.w //от центра камеры до реального положения вершины

    DS_OUTPUT o;

	o.pos.xyz = patch[0].pos.xyz;
	o.color = patch[0].color;

	int bladeId = UV.x*BLADES_TOTAL + 0.50001;//id травинки
	int2 rndPos = fmod((o.pos.xz + camPosAligned.xz)/quadSize, 10000.f);//XY, приведенные к целым пикселям, и зацикленные через каждые 10км, и 
		
	//шатаем траву
	//WIND AND ANIMATION -------------------------------------------
	const float speed = 3;//скорость шевеления травы
	const float frec = 0.45;
	const float ampl = 0.5*2;
	const float windPower = sqrt(min(1, windSpeed/50));//его мощность [0;1]

	float minWindAmount = windPower*0.5;//минимальное отклонение травинки, чем выше сила ветра - тем больше
	
	float windAmount = windAmount2D( (rndPos.xy - windOffset) * lerp(0.06, 0.03, windPower) );
	//float windAmount = windAmount2D( (rndPos.xy - wind.xy*time*windSpeed*(1+0.4*windPower)) * lerp(0.06, 0.03, windPower) );
	o.color.w *= 1-0.6*windAmount*(0.8+0.2*windPower);//чем сильнее порыв ветра, тем ниже трава опускается

	o.params.xy = float2(sin(time*speed + rndPos.x*frec), cos(time*speed + rndPos.y*frec))*ampl*(0.4+1.1*windPower);//простое брожение травинок
	o.params.xy += wind.xy*lerp(minWindAmount, 1, windAmount)*(0.1+0.9*windPower)*grassHeight*10;//ветрюга		
	//--------------------------------------------------------------

	o.params.z = noise2D(rndPos + bladeId*14.4261 );//random
	o.params.w = min(1, max(0,DIST_GRAD_WORLD-0.2)*1.25);//dist gradient

	//разброс оттенков травинок теплее/холоднее + уменьшаем по яркости и по дальности
	o.color.rg += (o.params.z-0.5)*0.20*max(o.color.r,o.color.g)*(1-pow(o.params.w,2));

	//при увеличении детализации, все новые травики сужаются до 0, и расширяются до 1 к концу лода
	//сделано для визаульной плавности переключения лодов
	const float newBladesScale = lerp(1, 1-pow(LOD_GRAD,2), step(BLADES_TOTAL/2, bladeId));

	//опускаем только дальнюю границу круга чтобы ее сгладить
	o.pos.y -= max(0,DIST_GRAD-0.5)*grassHeight;
	//компенсируем скачкообразное перемещение сетки
	o.pos.xyz -= float3(gridOffset.x, origin.y, gridOffset.y);

	o.pos.w = (1+1*max(0, lodsCount - LOD_ID + LOD_GRAD))*newBladesScale;	//scale factor

	//DEBUG
	//o.bladeId = bladeId;
    
    return o;    
	#undef DIST_GRAD
}


inline void addSegment(float3 startPos, inout TriangleStream<GS_OUTPUT> outputStream, inout GS_OUTPUT o, float height, float2 offset, float2 bendOffset)
{
	float4 pos = float4(startPos, 1);
	pos.y += height;
	pos.xz += bendOffset;

	pos.xz += offset;	
	o.pos = mul(pos, VP);
	outputStream.Append(o);

	pos.xz -= 2*offset;	
	o.pos = mul(pos, VP);
	outputStream.Append(o);
}

float getBladeGradient(float height, float distCoef/*nDist*/)
{
	return lerp( (0.6+0.4*pow(min(1, height/0.30),2)),	1,	distCoef);
}

inline void generateBlade(float3 startPos, inout TriangleStream<GS_OUTPUT> outputStream, inout GS_OUTPUT o, 
						  float2 size, float segments, float angle, float rand, float2 animOffset, float scale, float nDist, float3 color)
{
	const float bendDist = bendDistMax*scale*(0.2+0.8*(rand));//чем больше высота травинки тем больше изгиб
	const float animDist = 0.08*scale;//m
	float spread = pointSpread*(0.3+0.7*noise1D(rand*14.6235));//m

	startPos.x += spread * (noise1D(rand*54.1347)-0.5);
	startPos.z += spread * (noise1D((rand+0.7243)*61.5251)-0.5);

	float _sin,_cos; sincos(angle, _sin, _cos);
	float2 offsetMax = float2(size.x*_sin, size.x*_cos);//*(0.5+0.5*scale);//

	float2 bendDir = normalize(float2(-offsetMax.y, offsetMax.x));

	animOffset *= animDist;

	float distCoef = max(0.1, pow(nDist,0.5));

	//основание травы
	o.color.rgb = color*getBladeGradient(0, distCoef);

	addSegment(startPos, outputStream, o, 0,offsetMax,0);

	//сегменты
	[unroll]
	for(float ii=1; ii<segments; ii+=1.f)
	{
		float p = ii/segments;	//[0;1)
		o.color.rgb = color*getBladeGradient(size.y*p, distCoef);

		addSegment(startPos, outputStream, o, 
			size.y*p, //высота 
			offsetMax * pow(1-p, 0.3),//сдвиг точки вбок
			bendDir*bendDist*pow(p,1.5) + animOffset*p//сдвиг точки в сторону изгиба
			);
	}

	//вершина травы
	o.color.rgb = color*getBladeGradient(size.y, distCoef);

	o.pos.xyz = startPos;	
	o.pos.xz += bendDir*bendDist + animOffset;
	o.pos.y += size.y;
	o.pos = mul(float4(o.pos.xyz,1), VP);
	outputStream.Append(o);
	outputStream.RestartStrip();
}


[maxvertexcount(7)]
void gs(point DS_OUTPUT i[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	#define ANIM_OFFSET i[0].params.xy
	#define RAND		i[0].params.z
	#define DIST_GRAD	i[0].params.w
	#define GRASS_SCALE i[0].color.w//высота травы
	#define SCALE_FACTOR i[0].pos.w//1-передний план, N-самый дальний	
	#define RAND2 noise1D(RAND)//i[0].distGrad.y

	GS_OUTPUT o;
	//dbg
	//o.bladeId = i[0].bladeId;
	o.color.rgb = i[0].color.rgb;	
	//o.color.w = LOD_FACTOR;

	float segments = 2;
	generateBlade(
		i[0].pos.xyz, outputStream, o, 		
		float2(grassHalfWidth*SCALE_FACTOR, grassHeight*GRASS_SCALE*(0.7+0.6*RAND)), 
		segments, RAND2*PI2, RAND, ANIM_OFFSET, GRASS_SCALE, DIST_GRAD, o.color.rgb);

}






//static const float4 dbgColors[] = 
//{
//	float4(1,0,0,1),
//	float4(0,1,0,1),
//	float4(0,0,1,1),
//	float4(1,1,0,1),
//	float4(0,1,1,1),
//	float4(1,0,1,1),
//	float4(0,0,0,1),
//	float4(1,1,1,1),
//};


float4 ps(in GS_OUTPUT i): SV_TARGET0
{	
	//return 1;
	return float4(i.color.rgb, 1); //цвет травы из карты * градиент
}




technique10 grassTech
{
	pass grass
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(CompileShader(hs_5_0, hs()));
		SetDomainShader(CompileShader(ds_5_0, ds()));	
		SetGeometryShader(CompileShader(gs_4_0, gs()));
		SetPixelShader(CompileShader(ps_4_0, ps()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
	pass tesselatorReset
	{
		SetHullShader(NULL);
		SetDomainShader(NULL);
	}
}














static const float2 quad[] =
{
	float2(-1,-1),
	float2(-1,1),
	float2(1,-1),
	float2(1,1),
};


struct VS_HEIGHT_OUTPUT
{
    float4 pos  : SV_POSITION0;
	float2 uv: TEXCOORD8;
};

struct PS_HEIGHT_OUTPUT
{
    float2 height : SV_TARGET0;
	float4 color : SV_TARGET1;
	//uint color : SV_TARGET1;
};

VS_HEIGHT_OUTPUT vsHeightmap(in uint vertId : SV_VertexID)
{
	VS_HEIGHT_OUTPUT o;	
	o.pos = float4(quad[vertId].xy, 0, 1);
	o.uv = o.pos.xy*0.5+0.5;
	o.uv.y = 1 - o.uv.y;
	return o;
}



PS_HEIGHT_OUTPUT psHeightmap(in VS_HEIGHT_OUTPUT i)
{
	PS_HEIGHT_OUTPUT o;
	const float terraFreq = 0.005;
	//float height = simplexNoise2D((camPosAligned/quadSize + i.pos.xy)*terraFreq)*2+1000.f+50.f;
	float2 UV = (camPosAligned.xz/quadSize + float2(i.pos.x,1-i.pos.y))*terraFreq;//координаты поворачиваем так, как рендерит камера в игре
	float height = simplexNoise2D(UV) + 1000.f;

	//o.height = packUI24UI8(height*2000.f, 0);
	o.height = float2(height, simplexNoise2D(UV+0.163627));
	o.color = float4(simplexNoise2D(UV), o.height.y, 0, max(0,simplexNoise2D(2*UV+0.0259351)));

	o.color.rgb = rgb2hsv(o.color.rgb);	
	//uint x = min(1, max(0, output.color.r-0.08) * (1/(0.33-0.08)))*4;//hue id
	uint x = min(1, max(0, o.color.g-0.26) * 1 / (0.5-0.26)) * 4;//saturation id
	uint y = 4;
	o.color.g = (x*5 + y)/24.0;

	return o;
}

float4 psHeightmapToScreen(in VS_HEIGHT_OUTPUT i): SV_TARGET0
{
	float height = heightMap.Sample(ClampLinearSampler, i.uv.xy, 7).r - 1000.f;
	//float3 c=0;
	//float3 clr = colorMap.Sample(ClampLinearSampler, i.uv.xy, 0).rgb;
	//uint ref = ((uint(clr.r*15.0+0.5)<<4) ) | uint(clr.b*15.f+0.5);// 4|4	
	//return float4(c,1);
	return float4(height,height,height,1);
}


technique10 heightmapTest
{
	pass drawHeightMap
	{
		SetVertexShader(CompileShader(vs_4_0, vsHeightmap()));	
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psHeightmap()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}

	pass heightMapToScreen
	{
		SetVertexShader(CompileShader(vs_4_0, vsHeightmap()));	
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psHeightmapToScreen()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}

}


