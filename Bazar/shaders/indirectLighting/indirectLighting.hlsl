#ifndef INDIRECT_LIGHTING_HLSL
#define INDIRECT_LIGHTING_HLSL

//фильтрация по тетраэдрам - пока не рабочий вариант, так как паттер
//разбиения куба на тетраэдры должен быть фиксированным и не должен вращаться
//#define ILV_THETRAHEDRON_FILTERING

#define ILV_TRILINEAR_FILTERING // фильтрация по соседним узлам сетки

// #define PACKED_KNOT

#ifndef DBG_VALUE
	#define DBG_VALUE float4(1,1,1,1)
#endif

struct SHKnot
{
	float4 walls[6];
};
StructuredBuffer<SHKnot> resolvedIndirectLightKnots: register(t112);

// TextureCube cockpitAOMap: register(t111);
TextureCube cockpitEnvironmentMap: register(t108);

#define cockpitTransform	gCockpitTransform
#define	ILVBBmin			gILVBBMin
#define	ILVBBSizeInv		gILVBBSizeInv
#define ILVGridSize			gILVGridSize

uint getKnotLinearId(uint3 id)
{
	uint SHGridPitch = ILVGridSize.x;
	uint SHGridPitchDepth = SHGridPitch * ILVGridSize.y;//todo: оптимизировать
	return id.z * SHGridPitchDepth + id.y * SHGridPitch + id.x;
}

#ifdef PACKED_KNOT
float4 unpackWall(uint2 e)
{
	return float4(f16tof32(e), f16tof32(e >> 16));
}
float4 unpackWall2(uint val)
{
	uint r = val & 255;
	uint g = (val>>8) & 255;
	uint b = (val>>16) & 255;
	uint a = (val>>24) & 255;
	return float4(r, g, b, a) / 255;
}
#endif

//возвращает барицентрические координаты тетраэда для точки p
float4 GetTetrahedraBarycentricCoords(float3 p0, float3 p1, float3 p2, float3 p3, float3 p)
{
	float3 V0 = p0-p3;
	float3 V1 = p1-p3;
	float3 V2 = p2-p3;
	
	float3x3 M = transpose(float3x3(V0,V1,V2));
	float3x3 Minv;
	//считаем матрицу алгебраических дополнений, они же миноры дл¤ матрицы M
	Minv._11 =   M._22*M._33 - M._23*M._32;
	Minv._12 = -(M._21*M._33 - M._23*M._31);
	Minv._13 =   M._21*M._32 - M._22*M._31;
	Minv._21 = -(M._12*M._33 - M._13*M._32);
	Minv._22 =   M._11*M._33 - M._13*M._31;
	Minv._23 = -(M._11*M._32 - M._12*M._31);
	Minv._31 =   M._12*M._23 - M._13*M._22;
	Minv._32 = -(M._11*M._23 - M._13*M._21);
	Minv._33 =   M._11*M._22 - M._12*M._21;
	
	//определитель
	Minv *= rcp(M._11 * Minv._11 - M._12 * (-Minv._12) + M._13 * Minv._13);
	
	float4 bc;
	bc.xyz = mul(p-p3, Minv);//барицентрические координаты для p0-p2
	bc.w = 1 - bc.x - bc.y - bc.z;
	return bc;
}

//normal - в мире
float4 LerpKnotWalls(float3 mNormal, uint knotLinearId)
{
	float3 nSquared = mNormal * mNormal;
	// uint3 isNegative = (mNormal < 0.0);
	uint3 isNegative = uint3(0, 2, 4) + (mNormal < 0.0);
	
	float4 clr;
#ifdef PACKED_KNOT
	//копирование целого узла в разы быстрее чем прямое индексирование стенок в стуктурном буфере
	KnotPacked knot = resolvedPackedIndirectLightKnots[knotLinearId];
	
	#if 0 //медленнее
		float4 walls[6];
		[unroll]
		for(uint i=0; i<3; ++i)
		{
			walls[i*2] = unpackWall(knot.walls[i].rg);
			walls[i*2+1] = unpackWall(knot.walls[i].ba);
		}
		clr =	nSquared.x * walls[isNegative.x].rgba +
				nSquared.y * walls[isNegative.y].rgba +
				nSquared.z * walls[isNegative.z].rgba;
	#else
		uint3 isNeg = mNormal < 0.0;
		clr =	nSquared.x * unpackWall(isNeg.x ? knot.walls[isNeg.x].ba : knot.walls[isNeg.x].rg).rgba +
				nSquared.y * unpackWall(isNeg.y ? knot.walls[isNeg.y+1].ba : knot.walls[isNeg.y+1].rg).rgba +
				nSquared.z * unpackWall(isNeg.z ? knot.walls[isNeg.z+2].ba : knot.walls[isNeg.z+2].rg).rgba;
		//упаковка float4 в uint
		// clr =	nSquared.x * unpackWall2(isNeg.x ? knot.walls[0].g : knot.walls[0].r).rgba +
				// nSquared.y * unpackWall2(isNeg.y ? knot.walls[0].a : knot.walls[0].b).rgba +
				// nSquared.z * unpackWall2(isNeg.z ? knot.walls[1].g : knot.walls[1].r).rgba;
	#endif
#else
	//копирование целого узла в разы быстрее чем прямое индексирование стенок в стуктурном буфере
	SHKnot knot = resolvedIndirectLightKnots[knotLinearId];
	clr =	nSquared.x * knot.walls[isNegative.x].rgba +
			nSquared.y * knot.walls[isNegative.y].rgba +
			nSquared.z * knot.walls[isNegative.z].rgba;
#endif

	return clr;
}

//rgb - рассеяное освещение от солнца, a - атмосферный АО
float4 CalculateIndirectSunLight(float3 wPos, float3 wNormal)
{
	float3 mPos = mul(float4(wPos,1), cockpitTransform).xyz;//w!!!!!!!
	float3 mNormal = mul(wNormal, (float3x3)cockpitTransform);
	
#ifdef ILV_TRILINEAR_FILTERING
	float3 p = clamp((mPos - ILVBBmin) * ILVBBSizeInv, 0, 0.9999) * (ILVGridSize-1); //сразу в ячейках
	//находим координаты бокса для фильтрации
	uint3 k0 = p;
	uint3 k1 = ceil(p);// + 0.5;
	float3 delta = frac(p);
	
	// #define C(x,y,z)	((x+z)%2? 1.0 : 0.0) //test checker
	#define C(x,y,z)	LerpKnotWalls(mNormal, getKnotLinearId(uint3(x,y,z)))
	float4 c00 = lerp(C(k0.x, k0.y, k0.z), C(k1.x, k0.y, k0.z), delta.x);
	float4 c10 = lerp(C(k0.x, k1.y, k0.z), C(k1.x, k1.y, k0.z), delta.x);
	float4 c01 = lerp(C(k0.x, k0.y, k1.z), C(k1.x, k0.y, k1.z), delta.x);
	float4 c11 = lerp(C(k0.x, k1.y, k1.z), C(k1.x, k1.y, k1.z), delta.x);
	#undef C
	float4 c0 = lerp(c00, c10, delta.y);
	float4 c1 = lerp(c01, c11, delta.y);

	return lerp(c0, c1, delta.z);
#elif defined(ILV_THETRAHEDRON_FILTERING)
	float3 p = clamp((mPos - ILVBBmin) * ILVBBSizeInv, 0, 0.9999) * (ILVGridSize-1); //сразу в ¤чейках
	//находим координаты бокса дл¤ фильтрации
	uint3 k0 = p;
	float3 delta = frac(p);
	
	//координаты вершин тетраэдра:
	float3 p0 = round(delta);
	float3 p1 = float3(p0.x, p0.y, 1-p0.z);//любая соседняя точка
	float3 p2 = 1.0-p1;//диагональ
	float2 norm = float2(-(p2.y-p0.y), (p2.x-p0.x));//перпендикуляр к проекции диагонали на плоскость XY
	float3 p3 = dot(norm, delta.xy-p0.xy)>0 ? float3(p0.x, p2.yz) : float3(p2.x, p0.y, p2.z);
	
	float4 bc = GetTetrahedraBarycentricCoords(p0, p1, p2, p3, delta);
	
	float4 C0 = LerpKnotWalls(mNormal, getKnotLinearId(k0 + uint3(p0+0.5)));
	float4 C1 = LerpKnotWalls(mNormal, getKnotLinearId(k0 + uint3(p1+0.5)));
	float4 C2 = LerpKnotWalls(mNormal, getKnotLinearId(k0 + uint3(p2+0.5)));
	float4 C3 = LerpKnotWalls(mNormal, getKnotLinearId(k0 + uint3(p3+0.5)));
	
	return C0*bc.x + C1*bc.y + C2*bc.z + C3*bc.w;
#else
	float3 p = clamp((mPos - ILVBBmin) * ILVBBSizeInv, 0, 0.9999);
	uint3  knotId = p * (ILVGridSize-1) + 0.5;
	uint   knotLinearId = getKnotLinearId(knotId);
	float4 lightColor = LerpKnotWalls(mNormal, knotLinearId);
	// return ((knotId.x+knotId.z)%2? 1.0 : 0.0); //test checker
	return lightColor;
#endif
}

float3 CalculateIndirectSkyLight(float3 normal)
{
/*
	float3 L_front = SampleEnvironmentMapDetailed(normal, environmentMipsCount);
	float3 L_back = SampleEnvironmentMapDetailed(-normal, environmentMipsCount);

	float3 sunCockpit = mul(gSunDir.xyz, (float3x3)cockpitTransform);
	float3 normalCockpit = mul(normal, (float3x3)cockpitTransform);
	float4 AlbedoAO_front = cockpitAOMap.SampleLevel(ClampLinearSampler, normalCockpit, 6.0);
	float4 AlbedoAO_back  = cockpitAOMap.SampleLevel(ClampLinearSampler, -normalCockpit, 6.0);
	
	// float3 L_result = L_front * AlbedoAO_front.a * DBG_VALUE.x;
	// float3 L_result = L_back * AlbedoAO_back.a * AlbedoAO_front.rgb * DBG_VALUE.y;
	float3 L_result = L_front * AlbedoAO_front.a * DBG_VALUE.x + L_back * AlbedoAO_back.a * AlbedoAO_front.rgb * DBG_VALUE.y;
	
	L_result = lerp(L_result, L_front, step(0.5, DBG_VALUE.w));
	
	return L_result;
*/
	return 0;
}

//возвращает прямое освещение от солнца без вторички
float3 CalculateDirectSunLight(float3 baseColorSRGB, float3 normal, float roughness, float metallic, float shadow, float3 wPos, uniform bool bFixParams = true)
{
	float3 baseColor = GammaToLinearSpace(baseColorSRGB);
	
#ifdef TEST_ALBEDO
	baseColor = 0.5;
	metallic = 0.0;
	roughness = 0.75;
#endif
	
	//FIXME: при расчете N+1 из-за спекуляра на некоторых углах при некоторых ракурсах
	//солнца появляются лютые пересветы. Пока просто ограничим шероховатость и металличность
	if(bFixParams)
	{
		roughness = max(0.6, roughness);
		metallic = min(0.5, metallic);
	}
	
	float3 diffuseColor = baseColor * (1.0 - metallic);
	float3 specularColor = lerp(0.02, baseColor, metallic);

	float3 viewDir = normalize(gCameraPos.xyz - wPos);
	float NoL = max(0, dot(normal, gSunDir));
	float3 lightAmount = /*gSunIntensity **/ NoL * shadow; //солнце всегда белое
	return ShadingDefault(diffuseColor, specularColor, roughness, normal, viewDir, gSunDir) * lightAmount;
}

#endif
