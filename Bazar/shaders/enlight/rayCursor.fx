#include "common/states11.hlsl"
#include "common/samplers11.hlsl"

#include "common/context.hlsl"

#define USE_RAY_TEST 0

Texture2D tex;

#ifdef MSAA
	Texture2DMS<float, MSAA> texDepth;
	float loadDepth(uint2 uv, uint idx)	{	return texDepth.Load(uint2(uv), idx).x;	}
#else
	Texture2D<float> texDepth;
	float loadDepth(uint2 uv, uint idx) {	return texDepth.Load(uint3(uv, 0)).x;	}
#endif

float3 source, direction;
float4 color;	
float2 size;

static const float rayLength = 10.0;

static const float2 offs[4] = {
    float2(-1, -1),  float2(1, -1),
    float2(-1, 1),  float2(1, 1)
};

#define MapSampler gBilinearClampSampler

struct psInput
{
	float4 sv_pos:		SV_POSITION0;
	float4 projPos:		TEXCOORD0;
};

float4 VS(uint vid: SV_VertexID): POSITION0 {
	return float4(source + direction*rayLength, 1);
}

[maxvertexcount(8)]
void GS(point float4 input[1]: POSITION0, inout TriangleStream<psInput> outputStream) {
	float4 position = mul(input[0], gView);
	float dist = distance(input[0].xyz, gCameraPos);

	psInput o[4];
	[unroll]
	for(int i = 0; i < 4; ++i) {

		float3 p = position.xyz / position.w;
		p.xy += offs[i].xy*size.y*dist;

		o[i].sv_pos = o[i].projPos = mul(float4(p, 1), gProj);
	}

	psInput os;
	os.sv_pos = os.projPos = mul(float4(source, 1), gViewProj);

	outputStream.Append(o[0]);
	outputStream.Append(o[1]);
	outputStream.Append(os);
	outputStream.Append(o[3]);
	outputStream.RestartStrip();

	outputStream.Append(o[3]);
	outputStream.Append(o[2]);
	outputStream.Append(os);
	outputStream.Append(o[0]);
	outputStream.RestartStrip();
	
}

float4 PS(const psInput i, uint sidx: SV_SampleIndex): SV_TARGET0 {

	uint2 uv = i.sv_pos.xy;
	float depth = loadDepth(uv, sidx);

	clip(i.sv_pos.z- depth);			// depth test

	float4 wPos = mul(float4(i.projPos.xy/i.projPos.w, depth, 1), gViewProjInv);
	float3 dir = normalize(wPos.xyz/wPos.w - source);

	float d = dot(dir, direction);
	float sp=smoothstep(size.x, 1, d);	// spot 

#if !USE_RAY_TEST
	clip(d-size.x);
#endif

	float3 vU = normalize(cross(float3(0,1,0),direction));
	float3 vV = normalize(cross(direction, vU));
	float2 tuv = float2(dot(vU, dir), dot(vV, dir))/size.y*0.5+0.5;
	float4 clr = tex.Sample(ClampLinearSampler, tuv) * (sp + 0.5);
#if USE_RAY_TEST
	clr += float4(1, 0, 0, 0.25);
#endif
	return clr;
}


BlendState xorAlphaBlend {
	BlendEnable[0] = TRUE;
	SrcBlend = INV_DEST_COLOR;
	DestBlend = INV_SRC_COLOR;
	BlendOp = ADD;
	SrcBlendAlpha = ZERO;
	DestBlendAlpha = ONE;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

technique10 normal {
	pass P0 {
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(CompileShader(gs_5_0, GS()));
		SetPixelShader(CompileShader(ps_5_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
//		SetBlendState(xorAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullFront);      
	}
}

