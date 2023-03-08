#include "common/samplers11.hlsl"
#include "common/colorTransform.hlsl"

Texture2D	tex;
TextureCube envCube;

float heightRelative;//высота над поверхностью земли [0; 1]
float dParam; //величина прибавки интерполяции
float sunDirY;

struct TempValues
{
	float3 top;		//оригинальная верхняя грань куб мапы
	float3 bottom;	//оригинальная нижняя грань куб мапы
	float3 surfaceColorNew;//цвет земли заданный
	float3 surfaceColorLast;//цвет земли старый
	float3 surfAmbient;// цвет земли текущий (с учетом интерполяции)
	// float3 surfColorDelta;//изменение цвета эмбиента земли
};

RWStructuredBuffer<TempValues> tmpValues;
RWStructuredBuffer<float4> cubeWalls;


static const uint samples = 12;//семплирование стенок env куба

static const float2 Poisson25[] = {
	{-0.841121, 0.521165},
	{-0.702933, 0.903134},
	{-0.495102, -0.232887},
	{-0.345866, -0.564379},
	{-0.182714, 0.321329},
	{-0.0564287, -0.36729},
	{0.0381787, -0.728996},
	{0.253639, 0.719535},	
	{0.423627, 0.429975},
	{0.566027, -0.940489},
	{0.652089, 0.669668},
	{0.968871, 0.840449}	
};

// static const float2 Poisson25[] = {
	// {-0.978698, -0.0884121},
	// {-0.841121, 0.521165},
	// {-0.71746, -0.50322},
	// {-0.702933, 0.903134},
	// {-0.663198, 0.15482},
	// {-0.495102, -0.232887},
	// {-0.364238, -0.961791},
	// {-0.345866, -0.564379},
	// {-0.325663, 0.64037},
	// {-0.182714, 0.321329},
	// {-0.142613, -0.0227363},
	// {-0.0564287, -0.36729},
	// {-0.0185858, 0.918882},
	// {0.0381787, -0.728996},
	// {0.16599, 0.093112},
	// {0.253639, 0.719535},
	// /*
	// {0.369549, -0.655019},
	// {0.423627, 0.429975},
	// {0.530747, -0.364971},
	// {0.566027, -0.940489},
	// {0.639332, 0.0284127},
	// {0.652089, 0.669668},
	// {0.773797, 0.345012},
	// {0.968871, 0.840449},
	// {0.991882, -0.657338},
	// */
// };

static const float3 normals[] = {
	{1,0,0},
	{-1,0,0},
	{0, 1,0},
	{0,-1,0},
	{0,0, 1},
	{0,0,-1},
};

static const float3 binormals[] = {
	{0, 1, 0},
	{0, 1, 0},
	{0, 0, 1},
	{0, 0, 1},
	{1, 0, 0},
	{1, 0, 0},
};

static const float isSideWall[] = { 1, 1, 0, 0, 1, 1 };

static const float3 lumCoef =  {0.2125f, 0.7154f, 0.0721f};

static const float3 minAmbient = float3(9, 26, 52) / 255.f * 0.5;

//при нормальном HDR корректировать тут нечего, тогда и выпилить
inline float getSunAttenuation()
{
	return pow(max(0, sunDirY),0.65)*0.1+0.9;
}
//делаем выборки из грани куба
float3 SampleEnvironmentCube(uint id, uniform bool isOutdoor = true)
{
	float3 clr = 0;
	float3 normal = normals[id];
	float3 normResult;	
	float isSide = isSideWall[id];
	
	float3x3 M = {
		normal, 
		binormals[id], 
		cross(normal, binormals[id])
		};

#if USE_DCS_DEFERRED == 1
	normResult = mul(float3(1, 0, 0), M);
	return envCube.SampleLevel(ClampLinearSampler,normalize(normResult), 8).rgb;
#else
	[unroll]
	for(uint i=0; i<samples; ++i)
	{
		normResult = mul(float3(1, Poisson25[i].x, Poisson25[i].y), M);
		if(isOutdoor)
			normResult.y = lerp(normResult.y, abs(normResult.y)*0.5, isSide);

		clr += envCube.SampleLevel(ClampLinearSampler,normalize(normResult), 0).rgb;
	}
	return clr/samples;
#endif
}

/*
на боковых гранях сэмплы берутся только с верхней половины, сделано чтобы не учитывать вклад земли, 
которая теперь рисуется в environment.
*/
[numthreads(6,1,1)]
void BuildAmbientCube( uint id : SV_GroupIndex, uniform bool bOutdoor)
{
#ifdef EDGE
	float3 clr;
	if(id==3) clr = SampleEnvironmentCube(2, bOutdoor)*0.7;
	else	  clr = SampleEnvironmentCube(id, bOutdoor);
#else
	float3 clr = SampleEnvironmentCube(id, bOutdoor);
#endif

#ifndef USE_DCS_DEFERRED
	if(bOutdoor)
	{
		//убираем насыщенность
		float isSide = isSideWall[id];
		float lum = dot(lumCoef, clr);
		clr = lerp(clr, lerp(float3(lum,lum,lum)*0.75, clr, 0.4), isSide);
		//ограничиваем минимальный эмбиент
		cubeWalls[id].xyz = max(minAmbient, clr*getSunAttenuation());
		
		if(id==2)
		{
			clr = rgb2hsv(cubeWalls[id].xyz/lerp(getSunAttenuation()*0.9, 1, max(0,pow(sunDirY,2))));//осветляем когда солнце в горизонте, чтобы земля не была такой темной
			clr.y *= 1-0.28*pow(max(0, sunDirY),0.65);//уменьшаем насыщенность верхней грани куба когда солнце в зените, и не трогаем когда в горизонте	
			cubeWalls[id].xyz = hsv2rgb(clr);
			// tmpValues[0].top.xyz = hsv2rgb(clr);
		}
	}
	else
#endif
	{
		cubeWalls[id].rgb = clr;
	}
}

//вызывается один раз, когда заново отрендерили землю в таргет для эмбиента
[numthreads(1,1,1)]
void GetSurfaceColor()
{
	const int samplesSurf = 12;
	float3 clr = 0;
	
	[unroll]
	for(int i=0; i<samplesSurf; ++i)
	{
		clr += tex.SampleLevel(gBilinearClampSampler, Poisson25[i]*0.5+0.5, 0).rgb;
	}

	tmpValues[0].surfaceColorLast.xyz = tmpValues[0].surfAmbient;//старый цвет земли
	tmpValues[0].surfaceColorNew.xyz = min(1, clr/(float)samplesSurf);//новое значение
	// tmpValues[0].surfColorDelta = tmpValues[0].surfaceColor - tmpValues[0].surfaceColorLast; // изменение цвета земли
}

[numthreads(1,1,1)]
void UpdateAmbientCubeBottomWall()
{
	const float3 averageHorizon = (cubeWalls[0].rgb + cubeWalls[1].rgb + cubeWalls[4].rgb + cubeWalls[5].rgb)/4;
	
	const float heightCoef = pow(saturate(heightRelative + 0.062), 0.55); //нормализованая высота над поверхностью + минимальное смешивание с цветом горизонта

	//интерполируем цвет эмбиента
	// tmpValues[0].surfAmbient = tmpValues[0].surfaceColorLast + tmpValues[0].surfColorDelta*min(1,dParam);		
	tmpValues[0].surfAmbient = lerp(tmpValues[0].surfaceColorLast, tmpValues[0].surfaceColorNew, saturate(dParam));
	//верхняя грань
	// cubeWalls[2].xyz = lerp(tmpValues[0].top.xyz, averageHorizon, 0.4); 
	// cubeWalls[2].xyz = lerp(tmpValues[0].top.xyz+0.02, averageHorizon, 0.2); 
#ifdef USE_DCS_DEFERRED
	cubeWalls[3].xyz = lerp(tmpValues[0].surfAmbient.xyz, averageHorizon*0.7, heightCoef);
#else
	//убираем влияние цвета земли с увеличением высоты, дополнительно затемняем землю, таки это не зеркало
	cubeWalls[3].xyz = lerp(tmpValues[0].surfAmbient.xyz*0.6, averageHorizon*0.7, heightCoef);
#endif
}

technique10 ambientCubeTech
{
	pass outdoor
	{
		SetComputeShader(CompileShader(cs_5_0, BuildAmbientCube(true)));
	}
	pass indoor
	{
		SetComputeShader(CompileShader(cs_5_0, BuildAmbientCube(false)));
	}
}

technique10 surfaceColorTech
{
	pass P0
	{
		SetComputeShader(CompileShader(cs_5_0, GetSurfaceColor()));
	}
}

technique10 updateTech
{
	pass P0
	{
		SetComputeShader(CompileShader(cs_5_0, UpdateAmbientCubeBottomWall()));
	}
}
