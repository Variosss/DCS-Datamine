#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#define FOG_ENABLE
#include "common/fog2.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

struct VS_INPUT
{
	float4 params1: TEXCOORD0; // dist, angle, random[0..1], age
	float3 params2: TEXCOORD1; // ��������� ������� �������� � ������� ��
	float4 params3: TEXCOORD2; // ��������� �������� �������� � ������� ��, lifetime
	float4 params4: TEXCOORD3; // spinDir + dissipation direction
};

struct VS_OUTPUT
{
	float4 params1: TEXCOORD0; // posOffset, UVangle
	float4 params2: TEXCOORD1; // speed, scale
	float4 params3: TEXCOORD2; // stretch, opacity, brigtness, Rand
};

struct PS_INPUT
{
	float4 pos	 : SV_POSITION0;
	float4 params: TEXCOORD0; // UV, temperOffset, transparency
};

float time;
float scaleBase;

float4 gColorBrightness;
static const float opacityMax = 0.12;
static const float distMax = 10;


VS_OUTPUT VS1
#include "exhaustTrail_vs.hlsl"

#define GROUND
VS_OUTPUT VS2
#include "exhaustTrail_vs.hlsl"

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	#define posOffset		input[0].params1.xyz
	#define UVangle			input[0].params1.w
	#define startSpeed		input[0].params2.xyz
	#define scale			input[0].params2.w
	#define speedStretch	input[0].params3.x
	#define Rand			input[0].params3.w

	PS_INPUT o;
	o.params.z = input[0].params3.y * getFogTransparency(gCameraPos, posOffset);//transparency

	o.params.w = input[0].params3.z * (1-o.params.z*0.5) * (0.05 / PI) * gSunDiffuse.r;

	float4x4 mBillboard = mul(billboardOverSpeed(posOffset, startSpeed, scale), VP);

	float2x2 Mrot = rotMatrix2x2(UVangle);

	[unroll]
	for (int i = 0; i < 4; i++)
	{
		float4 vPos = {staticVertexData[i].xy, 0, 1};

		o.params.xy = mul(vPos.xy, Mrot);
		o.params.x = Rand * o.params.x + 0.52;
		o.params.y += 0.5;

		vPos.y *= speedStretch;//����������� ����� ������� ��������

		o.pos = mul(vPos, mBillboard);

		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 PS(PS_INPUT i) : SV_TARGET0
{
	float t = tex.Sample(ClampLinearSampler, i.params.xy).a;
	float color = i.params.w * t * (gSunIntensity / 10);
	float alpha = i.params.z * t * t;
	return float4(gColorBrightness.xyz*color, alpha);
}

#define PASS_BODY(vs, gs, ps)  { SetVertexShader(vs); SetGeometryShader((gs)); SetPixelShader(ps); \
		DISABLE_CULLING; ENABLE_RO_DEPTH_BUFFER; SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);}

GeometryShader	gsCompiled = CompileShader(gs_4_0, GS());
PixelShader		psCompiled = CompileShader(ps_4_0, PS());

technique10 tech
{
	//� ������
	pass fast			PASS_BODY(CompileShader(vs_5_0, VS1(false)), gsCompiled, psCompiled)
	pass fastWithClouds	PASS_BODY(CompileShader(vs_5_0, VS2(true)),  gsCompiled, psCompiled)
	//� ���������� � �����
	pass slow			PASS_BODY(CompileShader(vs_4_0, VS2(false)), gsCompiled, psCompiled)
	pass slowWithClouds	PASS_BODY(CompileShader(vs_4_0, VS2(true)),  gsCompiled, psCompiled)
}

technique10 techLOD
{
	//� ������
	pass fast			PASS_BODY(CompileShader(vs_5_0, VS1(false, true)), gsCompiled, psCompiled)
	pass fastWithClouds	PASS_BODY(CompileShader(vs_5_0, VS2(true, true)),  gsCompiled, psCompiled)
	//� ���������� � �����
	pass slow			PASS_BODY(CompileShader(vs_4_0, VS2(false, true)), gsCompiled, psCompiled)
	pass slowWithClouds	PASS_BODY(CompileShader(vs_4_0, VS2(true, true)),  gsCompiled, psCompiled)
}

technique10 techLeakage
{
	//� ������
	pass fast			PASS_BODY(CompileShader(vs_5_0, VS1(false, false, true)), gsCompiled, psCompiled)
	pass fastWithClouds	PASS_BODY(CompileShader(vs_5_0, VS2(true, false, true)),  gsCompiled, psCompiled)
	//� ���������� � �����
	pass slow			PASS_BODY(CompileShader(vs_4_0, VS2(false, false, true)), gsCompiled, psCompiled)
	pass slowWithClouds	PASS_BODY(CompileShader(vs_4_0, VS2(true, false, true)),  gsCompiled, psCompiled)
}