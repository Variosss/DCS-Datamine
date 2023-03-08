/*
Radix Sort.
Cортирует RADIX_THREAD_X * RADIX_THREAD_Y индексов по ключу и вываливает в RADIX_OUTPUT_BUFFER.
Алгоритм правильно работает только для dispatch(1,1,1) и позволяет за один проход 
сортировать до 1024 индексов на dx11. Если нужно сортировать больше 1024 элементов, следует
написать многопроходный варинат сортировки для неограниченного размера массива.

Использование:
задефайнить параметры и заинклудить radixSort.hlsl:

RADIX_OUTPUT_BUFFER		- название RW буфера, в который будут записани отсортированные индексы
RADIX_KEY_FUNCTION_BODY(id)	- тело функции получения ключа по id элемента буффера, индексы которого будут сортироваться, должно возвращать uint. Вызывается один раз для каждого id
RADIX_TECH_NAME			- название техники соритровки, которая будет создана
RADIX_THREAD_X			- количество потоков в группе по X
RADIX_THREAD_Y			- количество потоков в группе по Y
RADIX_BIT_MIN			- начальный младший бит ключа, с которого начинается сортировка [опционально]
RADIX_BIT_MAX			- конечный старший бит ключа, на котором заканчивается сортировка [опционально]
RADIX_NO_LOCAL_INDICES	- сортировать промежуточный массив с индексами, после чего вываливать в глобальный, иначе сразу сортировать глобальный [опционально]
*/

#ifndef RADIX_OUTPUT_BUFFER
#error RADIX_OUTPUT_BUFFER should be defined
#endif

#ifndef RADIX_KEY_FUNCTION_BODY
#error RADIX_KEY_FUNCTION_BODY should be defined
#endif

#ifndef RADIX_THREAD_X
#error RADIX_THREAD_X should be defined
#endif

#ifndef RADIX_THREAD_Y
#error RADIX_THREAD_Y should be defined
#endif

#ifndef RADIX_NO_LOCAL_INDICES
	// сортировать промежуточный массив с индексами, после чего вываливать в глобальный, иначе сразу сотировать глобальный
	#define USE_LOCAL_INDICES
#endif
#ifndef RADIX_TECH_NAME
	#define RADIX_TECH_NAME	techRadixSort
#endif

#ifndef RADIX_BIT_MIN
	#define RADIX_BIT_MIN 0
#endif

#ifndef RADIX_BIT_MAX
	#define RADIX_BIT_MAX 32
#endif

#ifndef CONCAT
#define CONCAT(a, b) a ## b
#endif
#ifndef GEN_NAME
#define GEN_NAME(a, b) CONCAT(a, b)
#endif

#define csShaderName(postfix) GEN_NAME(cs, postfix)
#define ComputeRadixSort(postfix) GEN_NAME(postfix, SortFunc)
#define ComputeRadixSortInternal(postfix) GEN_NAME(postfix, SortFuncInternal)

#define RADIX_GROUP_THREADS RADIX_THREAD_X * RADIX_THREAD_Y

#ifdef USE_LOCAL_INDICES
	#ifndef SHARED_MEMORY_INDICES_BUFFER
		#define SHARED_MEMORY_INDICES_BUFFER
		groupshared uint indices[RADIX_GROUP_THREADS];
		#define MemoryBarrierForOutput GroupMemoryBarrierWithGroupSync()
	#endif
#else
	#define indices	RADIX_OUTPUT_BUFFER
	#define MemoryBarrierForOutput DeviceMemoryBarrierWithGroupSync()
#endif

groupshared uint keys[RADIX_GROUP_THREADS];
groupshared uint e[RADIX_GROUP_THREADS];
groupshared uint f[RADIX_GROUP_THREADS];

uint floatToUInt( float input ){
	return 0xffffffff - asuint( input );
}

bool getBit(uint i, uint n) {
	return ((n >> i) & 1) == 1;
}

uint getKey(uint id){
	RADIX_KEY_FUNCTION_BODY(id)
}

void ComputeRadixSortInternal(RADIX_TECH_NAME)(uint GI, uint key)
{
	keys[GI] = key;// считаем ключики и сохраняем
	
#ifdef USE_LOCAL_INDICES
	indices[GI] = GI; // инитим индексы
#endif
	
	[loop] // [unroll(RADIX_BIT_MAX-RADIX_BIT_MIN)]
	for(uint n = RADIX_BIT_MIN; n < RADIX_BIT_MAX; ++n)
	{
		const uint curIndex = indices[GI];
		e[GI] = getBit(n, keys[curIndex]) == 0;
		GroupMemoryBarrierWithGroupSync();

		uint fCur;
		if(GI != 0)	fCur = e[GI - 1];
		else		fCur = 0;
		f[GI] = fCur;
		GroupMemoryBarrierWithGroupSync();

		// prefix sum
		[unroll( int( ceil(log2(RADIX_GROUP_THREADS)) ) ) ]
		for(uint i = 1; i<RADIX_GROUP_THREADS; i <<= 1) //for n = 0 .. log2(N), i =  2^n
		{
			if (GI > i)
				fCur += f[GI-i];

			GroupMemoryBarrierWithGroupSync();
			f[GI] = fCur;
			GroupMemoryBarrierWithGroupSync();
		}

		// Sum up the falses
		if (GI == 0) 
			f[0] = e[RADIX_GROUP_THREADS - 1] + f[RADIX_GROUP_THREADS - 1]; // f[0] - totalFalses

		GroupMemoryBarrierWithGroupSync(); // wait for thread 0 to finish

		// d contains the destination indexes for all the bits
		uint d = e[GI] ? fCur : GI - fCur + f[0];

		indices[d] = curIndex;
		MemoryBarrierForOutput;
	}
#ifdef USE_LOCAL_INDICES
	RADIX_OUTPUT_BUFFER[GI] = indices[GI];
#endif
}

void ComputeRadixSort(RADIX_TECH_NAME)(uint GI)
{
	ComputeRadixSortInternal(RADIX_TECH_NAME)(GI, getKey(GI));
}

#ifndef RADIX_NO_COMPUTE_SHADER
[numthreads(RADIX_THREAD_X, RADIX_THREAD_Y, 1)]
void csShaderName(RADIX_TECH_NAME)(uint GI : SV_GroupIndex)
{
	ComputeRadixSort(RADIX_TECH_NAME)(GI);
}

technique11 RADIX_TECH_NAME
{
	pass { SetComputeShader(CompileShader(cs_5_0, csShaderName(RADIX_TECH_NAME)())); }
}
#endif

#undef csShaderName
#undef RADIX_GROUP_THREADS
#undef USE_LOCAL_INDICES
#undef MemoryBarrierForOutput
#undef RADIX_NO_COMPUTE_SHADER

#ifdef USE_LOCAL_INDICES
	#undef indices
#endif
