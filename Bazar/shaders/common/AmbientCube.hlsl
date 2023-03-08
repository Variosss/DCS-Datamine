#ifndef AMBIENT_CUBE_HLSL
#define AMBIENT_CUBE_HLSL

//глобальный эмбиент куб сцены

#if defined(EDGE) && defined(METASHADER)
	StructuredBuffer<float4> irendercontext::AmbientCube;
	#define AmbientMap irendercontext::AmbientCube
#else
	cbuffer cAmbientMap: register(b8)
	{
		float4 AmbientMap[9];	// 6 ambient walls, average horizon, average cube
	};
#endif

#define AmbientTop				AmbientMap[2].rgb
#define AmbientBottom			AmbientMap[3].rgb
#define AmbientAverageHorizon	AmbientMap[6].rgb
#define AmbientAverage			AmbientMap[7].rgb
#define AmbientWhitePoint		AmbientMap[8].rgb //средний цвет куба с учетом альбедо поверхности земли = 1.0

float3 AmbientLight( const float3 worldNormal )
{
	float3 nSquared = worldNormal * worldNormal;
	uint3 isNegative = ( worldNormal < 0.0 );

	float3 clr;
	clr =	nSquared.x * AmbientMap[isNegative.x].rgb +
			nSquared.y * AmbientMap[isNegative.y+2].rgb +
			nSquared.z * AmbientMap[isNegative.z+4].rgb;

	return clr;
}

float4 SampleAmbientCube(float3 worldNormal, uniform uint offset = 0)
{
	float3 nSquared = worldNormal * worldNormal;
	uint3 isNegative = offset + ( worldNormal < 0.0 );

	return	nSquared.x * AmbientMap[isNegative.x] +
			nSquared.y * AmbientMap[isNegative.y+2] +
			nSquared.z * AmbientMap[isNegative.z+4];
}

//сжимаем и поднимаем границу смешивания земли и неба
float3 AmbientLightStretchGround( float3 worldNormal )
{
	worldNormal.y -= (1 - min(1, worldNormal.y+1))*1.3;// при отрицательном Y ходит от 0 до 1, единица когда Y минимальный
	worldNormal = normalize(worldNormal);
	
	float3 nSquared = worldNormal * worldNormal;
	uint3 isNegative = ( worldNormal < 0.0 );

	float3 clr;
	clr =	nSquared.x * AmbientMap[isNegative.x].rgb +
			nSquared.y * AmbientMap[isNegative.y+2].rgb +
			nSquared.z * AmbientMap[isNegative.z+4].rgb;

	return clr;
}

#endif
