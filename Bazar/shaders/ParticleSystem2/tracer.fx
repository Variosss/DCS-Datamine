#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/softParticles.hlsl"
#include "common/stencil.hlsl"
#define FOG_ENABLE
#include "common/fog2.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"	

float4		tracerColor;
float4		params;
float3		position; 
float3		backOffset;
#define tracerLength		params.x
#define tracerWidth			params.y
#define tracerBrightness	params.z
#define tracerDistanceMax	params.w //tracer thickness on screen, pixels

struct VS_OUTPUT {};

struct GS_OUTPUT
{
	float4 pos	: SV_POSITION0;
	float3 uv	: TEXCOORD0;
};

//xy - dir, z - length
float3 GetVectorScreenLength(float3 vPos0, float3 vPos1)
{
	// получаем проецированные координаты
	float4 p1 = mul(float4(vPos0, 1), gProj);
	float4 p2 = mul(float4(vPos1, 1), gProj);
	p1.xyz /= p1.w;
	p2.xy /= p2.w;

	float4 dir = float4(p2.xy-p1.xy, p1.z, 1);
	dir.x *= gProj._22 / gProj._11; //aspect
	dir.z = length(dir.xy); // длига векьлоа
	dir.xy /= dir.z; // нормализуем вектор
	return dir.xyz;
}

void GetTracerParams(out float3 vPosFront, out float3 vPosBack, out float distCorrected, out float scaleFactor, out float brightness)
{
	vPosBack = position - backOffset;
	vPosFront = mul(float4(position, 1.0), View).xyz;
	vPosBack = mul(float4(vPosBack, 1.0), View).xyz;

	distCorrected = (1.73 / gProj._11) * length(vPosFront); 
	scaleFactor = 1 + 0.001 * distCorrected;
	
	float distMax = tracerDistanceMax;
	float distMin = 0.0 * distMax;
	float fadeOutFactor = saturate(1 - (distCorrected - distMin) / (distMax - distMin) );
	brightness = tracerBrightness * fadeOutFactor * fadeOutFactor * getFogTransparency(gCameraPos.xyz, position);
}

void vsTracerDummy()
{
}

GS_OUTPUT vsTracerDot()
{
	float3 vPosFront, vPosBack;
	float  dist, scaleFactor, brightness;
	GetTracerParams(vPosFront, vPosBack, dist, scaleFactor, brightness);
	
	GS_OUTPUT o;
	o.pos = mul(float4((vPosBack + vPosFront)*0.5, 1), gProj);
	o.uv = float3(0, 0, 0.5 * brightness);
	return o;
}

[maxvertexcount(8)]
void gsTracerGeometry(point VS_OUTPUT input[1], inout TriangleStream<GS_OUTPUT> outputStream)
{
	float3 vPosFront, vPosBack;
	float  dist, scaleFactor, brightness;
	GetTracerParams(vPosFront, vPosBack, dist, scaleFactor, brightness);
	
	//считаем направление трассера на экране, иначе будет крутиться
	float3 screenDir = GetVectorScreenLength(vPosBack, vPosFront);

	float3 dirProj = float3(screenDir.xy, 0);
	float3 sideProj = float3(-dirProj.y, dirProj.x, 0); 
	
	//чтобы полукуги не переворачивались в ответственный момент
	// float d = dot(float3(dir.xy,0), dirProj);
	// dirProj = d<0? -dirProj : dirProj;

	dist /= 1000;
	brightness *= (1 + 1000 * saturate(dist*dist));
	
	float3 offsetDirView = mul(backOffset, (float3x3)View);
	float3 side = sideProj * tracerWidth * scaleFactor;
	
	//при вгляде близкому к оси трассера на небольшом расстоянии виден очень сильный перепад
	//размеров полукругов - уменьшаем глубину трассера
	// float VoDir = dot(dir, normalize(vPosBack));
	// float lenFactor = pow(saturate(4 - 4 * abs(VoDir)), 0.4);
	// offsetDirView.z *= lenFactor;
	
	const float capWidth = tracerWidth * 0.5 * scaleFactor;	
	
	const float4 vertexData[] =
	{	//offsetDirView, side, u, sideFactor
		{0, -0.5, 0,   -1},
		{0,  0.5, 0,   -1},
		{0, -0.5, 0.5,  0},
		{0,  0.5, 0.5,  0},
		{1, -0.5, 0.5,  0},
		{1,  0.5, 0.5,  0},
		{1, -0.5, 1.0,  1},
		{1,  0.5, 1.0,  1},
	};
	
	GS_OUTPUT o;
	o.uv.z = brightness;
	for(uint i=0; i<8; ++i)
	{
		float4 v = vertexData[i];
		
		o.pos.xyz = vPosBack + offsetDirView * v.x + side * v.y + dirProj * (v.w * capWidth);

		o.pos = mul(float4(o.pos.xyz, 1), gProj);
		o.uv.xy = float2(v.z, v.y + 0.5);
		outputStream.Append(o);
	}	
	outputStream.RestartStrip();
}

[maxvertexcount(2)]
void gsTracerLine(point VS_OUTPUT input[1], inout LineStream<GS_OUTPUT> outputStream)
{
	float3 vPosFront, vPosBack;
	float  dist, scaleFactor, brightness;
	GetTracerParams(vPosFront, vPosBack, dist, scaleFactor, brightness);

	GS_OUTPUT o;
	o.uv = float3(0,0, 0.5 * brightness);
	o.pos = mul(float4(vPosBack, 1), gProj);
	outputStream.Append(o);
	o.pos = mul(float4(vPosFront, 1), gProj);
	outputStream.Append(o);	
	outputStream.RestartStrip();
}

float4 psTracer(in GS_OUTPUT i, uniform bool bLod): SV_TARGET0
{
	if(!bLod)
	{
		float alpha = tex.Sample(WrapLinearSampler, i.uv.xy).a;
		alpha *= alpha * alpha;

		float3 color = lerp(tracerColor.rgb, 1, alpha * 0.3) * i.uv.z;
		return float4(color, tracerColor.a * alpha);
	}
	else
	{
		return float4(tracerColor.rgb * i.uv.z, tracerColor.a);
	}
}

RasterizerState lineRasterizerState
{
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = true;
};

technique10 tech
{
	//geometric
	pass tracerLOD0
	{
		SetVertexShader(CompileShader(vs_4_0, vsTracerDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsTracerGeometry()));
		SetPixelShader(CompileShader(ps_4_0, psTracer(false)));
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetRasterizerState(cullNone);
	}
	//line
	pass tracerLOD1
	{
		SetVertexShader(CompileShader(vs_4_0, vsTracerDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsTracerLine()));
		SetPixelShader(CompileShader(ps_4_0, psTracer(true)));
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(lineRasterizerState);
	}
	//point
	pass tracerLOD2
	{
		SetVertexShader(CompileShader(vs_4_0, vsTracerDot()));	
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psTracer(true)));
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(lineRasterizerState);
	}
}
