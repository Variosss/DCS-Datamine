
//HIGH
#define postfix		High
#define TECH_HIGH
#define PS_HALO			// �������� �������� �� ����� ���� ������ ������
#define PS_NORMAL_LIGHT // �������� ��������� �� ����� ��������
#include "smokeTrail_sh.hlsl"
#undef	PS_NORMAL_LIGHT
#undef	PS_HALO
#undef	TECH_HIGH

//LOW
#define postfix		Low
#define LOW
#define PS_HALO	
#include "smokeTrail_sh.hlsl"
#undef	PS_HALO
#undef	LOW

//LOD
#define postfix		Lod
#define LOD
#include "smokeTrail_sh.hlsl"
#undef LOD

//HIGH_FLIR
#define postfix		HighFlir
#define TECH_HIGH
#define FLIR
#define PS_HALO			// �������� �������� �� ����� ���� ������ ������
#define PS_NORMAL_LIGHT // �������� ��������� �� ����� ��������
#include "smokeTrail_sh.hlsl"
#undef	PS_NORMAL_LIGHT
#undef	PS_HALO
#undef FLIR
#undef	TECH_HIGH

//LOW_FLIR
#define postfix		LowFlir
#define LOW
#define FLIR
#define PS_HALO	
#include "smokeTrail_sh.hlsl"
#undef	PS_HALO
#undef FLIR
#undef	LOW

//LOD_FLIR
#define postfix		LodFlir
#define LOD
#define FLIR
#include "smokeTrail_sh.hlsl"
#undef FLIR
#undef LOD



