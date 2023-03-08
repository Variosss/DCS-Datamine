#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"

#include "deferred/GBuffer.hlsl"
#include "deferred/atmosphere.hlsl"
#include "deferred/shading.hlsl"

#include "deferred/shadows.hlsl"

float radius;
uint2 targetDims;
uint pointCount;
StructuredBuffer<float3> points;

Texture2D tex;

struct VS_OUTPUT {
	float3 pos	: TEXTURE0;
};

struct DS_OUTPUT {
	float3 pos	: TEXTURE0;
	float4 tangent	: TEXTURE1;
};

struct PS_INPUT {
    float4 sv_pos	: SV_POSITION0; 
	float4 projPos	: TEXTURE0; 
	float3 normal	: NORMAL;
	float3 pos		: TEXTURE1;
	float2 uv		: TEXTURE2;		// textCoord or alpha
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	int sid = vid / 4;
	int pid = vid % 4;
	int idx = clamp(sid + pid - 1, 0, (int)pointCount - 1);
	o.pos = points[idx];
	return o;
}

struct HS_CONSTANT_OUTPUT {
	float edges[2] : SV_TessFactor;
};

HS_CONSTANT_OUTPUT HSConst(InputPatch<VS_OUTPUT, 4> ip) {
	HS_CONSTANT_OUTPUT o;

	float4 p1 = mul(float4(ip[1].pos, 1), gViewProj);
	float4 p2 = mul(float4(ip[2].pos, 1), gViewProj);
	float d = distance(p1.xy / p1.w, p2.xy / p2.w);

	o.edges[0] = 1.0f;					// Detail factor (see below for explanation)
	o.edges[1] = min(sqrt(d) * 20, 16);	// Density factor

	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("line")]
[outputcontrolpoints(4)]
[patchconstantfunc("HSConst")]
VS_OUTPUT HS(InputPatch<VS_OUTPUT, 4> ip, uint id : SV_OutputControlPointID) {
	VS_OUTPUT o;
	o = ip[id];
	return o;
}


float3 cathmullRom(float3 v0, float3 v1, float3 v2, float3 v3, float t) {
	float3 k0 = v1 * 2;
	float3 k1 = v2 - v0;
	float3 k2 = v0 * 2 - v1 * 5 + v2 * 4 - v3;
	float3 k3 = -v0 + (v1 - v2) * 3 + v3;
	return (((k3*t + k2)*t + k1)*t + k0) * 0.5;
}

float3 bspline(float3 v0, float3 v1, float3 v2, float3 v3, float t) {
	float3 k0 = (v0 + v1 * 4 + v2) / 3;
	float3 k1 = v2 - v0;
	float3 k2 = v0 - v1 * 2 + v2;
	float3 k3 = (-v0 + (v1 - v2) * 3 + v3) / 3;
	return (((k3*t + k2)*t + k1)*t + k0) * 0.5;
}

[domain("isoline")]
DS_OUTPUT DS(HS_CONSTANT_OUTPUT i, OutputPatch<VS_OUTPUT, 4> op, float2 uv : SV_DomainLocation) {
	DS_OUTPUT o;
	o.pos = cathmullRom(op[0].pos, op[1].pos, op[2].pos, op[3].pos, uv.x);
//	o.pos = bspline(op[0].pos, op[1].pos, op[2].pos, op[3].pos, uv.x);
	o.tangent = float4(normalize(lerp(normalize(op[2].pos - op[0].pos), normalize(op[3].pos - op[1].pos), uv.x)), uv.x * ceil(distance(op[2].pos, op[1].pos)*4) );
	return o;
}


float calcThickness(float3 pos, float radius) {
#if USE_DEPTH_DIST
	float dist = max(1, dot(pos - gCameraPos, gView._13_23_33));
#else
	float dist = max(1, distance(pos, gCameraPos));
#endif
	float4 pp = mul(float4(0, radius * 2, dist, 1), gProj);
	return pp.y / pp.w * targetDims.y;
}

[domain("isoline")]
PS_INPUT DS_LINE(HS_CONSTANT_OUTPUT i, OutputPatch<VS_OUTPUT, 4> op, float2 uv : SV_DomainLocation) {
	PS_INPUT o;
	o.pos = cathmullRom(op[0].pos, op[1].pos, op[2].pos, op[3].pos, uv.x);
	o.sv_pos = o.projPos = mul(float4(o.pos, 1), gViewProj);
#if 0
	float3 tangent = lerp(normalize(op[2].pos - op[0].pos), normalize(op[3].pos - op[1].pos), uv.x);
	float3 v = mul(float3(0, 0, 1), (float3x3)gViewInv);
	o.normal = normalize(cross(tangent, cross(tangent, v)));
#else
	o.normal = float3(0, 0, 1);
#endif
	o.uv = float2(saturate(calcThickness(o.pos, radius)), 0);

	return o;
}

float3x3 rotMatrix(float3 vZ) {
	float3 vX = lerp(cross(vZ, float3(1, 0, 0)), cross(vZ, float3(0, 0, 1)), step(abs(vZ.z), 0.9999));
	vX = normalize(vX);
	float3 vY = cross(vZ, vX);
	float3x3 m = { vX, vY, vZ };
	return m;
}

#define FACE_COUNT 6

[maxvertexcount(2*3*FACE_COUNT)]
void GS(line DS_OUTPUT i[2], inout TriangleStream<PS_INPUT> os) {

	float t = max(calcThickness(i[0].pos, radius), calcThickness(i[1].pos, radius));
	if (t < 1)
		return;

	float3x3 m[2];
	m[0] = rotMatrix(i[0].tangent.xyz);
	m[1] = rotMatrix(i[1].tangent.xyz);

	float uvy[2];
	uvy[0] = i[0].tangent.w;
	uvy[1] = i[1].tangent.w;

	float3 n0[FACE_COUNT], n1[FACE_COUNT];

	const float astep = 6.283185307179586476925286766559 / FACE_COUNT;
	[unroll]
	for (uint k = 0; k < FACE_COUNT; k++) {
		float s, c;
		sincos(k * astep, s, c);
		float3 delta = float3(c, s, 0);
		n0[k] = mul(delta, m[0]);
		n1[k] = mul(delta, m[1]);
	}

	PS_INPUT o;

	[unroll]
	for (k = 0; k < FACE_COUNT; k++) {
		o.normal = n0[k];
		o.pos = i[0].pos + n0[k] * radius;
		o.sv_pos = o.projPos = mul(float4(o.pos, 1), gViewProj);
		o.uv = float2((float)k / FACE_COUNT, uvy[0]);
		os.Append(o);
		o.normal = n1[k];
		o.pos = i[1].pos + n1[k] * radius;
		o.sv_pos = o.projPos = mul(float4(o.pos, 1), gViewProj);
		o.uv = float2((float)k / FACE_COUNT, uvy[1]);
		os.Append(o);
	}
	o.normal = n0[0];
	o.pos = i[0].pos + n0[0] * radius;
	o.sv_pos = o.projPos = mul(float4(o.pos, 1), gViewProj);
	o.uv = float2(1, uvy[0]);
	os.Append(o);
	o.normal = n1[0];
	o.pos = i[1].pos + n1[0] * radius;
	o.sv_pos = o.projPos = mul(float4(o.pos, 1), gViewProj);
	o.uv = float2(1, uvy[1]);
	os.Append(o);
	os.RestartStrip();
}

static const float2 rm = float2(0.5, 0.7);
static const float3 diffuse = float3(0.2, 0.2, 0.2);

#ifdef USE_DCS_DEFERRED

GBuffer PS(PS_INPUT i
#if USE_SV_SAMPLEINDEX
	, uint sv_sampleIndex: SV_SampleIndex
#endif
) {
	float3 t = tex.Sample(gTrilinearWrapSampler, i.uv).rgb;
	return BuildGBuffer(i.sv_pos.xy, 
#if USE_SV_SAMPLEINDEX
		sv_sampleIndex, 
#endif
		float4(t * t * 0.5, 1), i.normal, float4(1, 1-(t.r*t.r*t.r), t.r, 1), float3(0, 0, 0));
}

float4 PS_LINE(PS_INPUT i): SV_TARGET0 {
	float3 color = ShadeHDR(i.sv_pos.xy, gSunDiffuse, diffuse, mul(i.normal, (float3x3)gView), 1, 0, float3(0, 0, 0), 0, 1, 1, normalize(i.pos - gCameraPos), i.pos);
	return float4(applyAtmosphereLinear(gCameraPos.xyz, i.pos, i.projPos, color), i.uv.x);
}

#else

float3 SimplestShading(PS_INPUT i) {
	float3 t = tex.Sample(gTrilinearWrapSampler, i.uv).rgb;
	float shadow = SampleShadow(float4(i.pos, i.projPos.z / i.projPos.w), i.normal, false);
	return (0.5*diffuse + 0.5*t*t*dot(i.normal, gSunDir)*shadow)*gSunDiffuse;
}

float4 PS(PS_INPUT i): SV_TARGET0 {
	return float4(SimplestShading(i), 1);
}

float4 PS_LINE(PS_INPUT i) : SV_TARGET0 {
	return float4(SimplestShading(i), i.uv.x);
}

#endif

RasterizerState lineRasterizerState {
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = TRUE;
};

technique10 Tech
{
    pass P0
	{          
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetHullShader(CompileShader(hs_5_0, HS()));
		SetDomainShader(CompileShader(ds_5_0, DS()));
		SetGeometryShader(CompileShader(gs_5_0, GS()));
		SetPixelShader(CompileShader(ps_5_0, PS()));

		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
//		SetRasterizerState(wireframe);
    }

	pass P1
	{
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetHullShader(CompileShader(hs_5_0, HS()));
		SetDomainShader(CompileShader(ds_5_0, DS_LINE()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, PS_LINE()));

		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(lineRasterizerState);
	}

}
