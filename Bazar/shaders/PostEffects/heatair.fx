#include "../common/samplers11.hlsl"
#include "../common/states11.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

Texture2D<float> HeatMap;
Texture3D<float2> HeatTex;

#ifdef MSAA
	Texture2DMS<float4, MSAA> Source;
	static const float samplesInv = 1.0 / MSAA;
#else
	Texture2D Source;
#endif

int2 	Dims;
float4	viewport;
float	time;

struct VS_OUTPUT {
	noperspective float4 pos:		SV_POSITION0;
	noperspective float4 texCoords:	TEXCOORD0;
};

VS_OUTPUT vsHeatAir(float2 pos: POSITION0)
{
	VS_OUTPUT o;
	o.pos = float4(pos, 0, 1.0);
	o.texCoords.xy = (float2(pos.x, -pos.y)*0.5+0.5)*viewport.zw + viewport.xy;
	o.texCoords.zw = o.texCoords.xy;
#ifdef MSAA
	o.texCoords.xy *= Dims;
#endif
	return o;
}

static const float2 Poisson4[] = {
	{-0.841121, 0.521165},
	{-0.495102, -0.232887},
	{-0.182714, 0.321329},
	{0.0381787, -0.728996},
	// {0.423627, 0.429975},
	// {0.652089, 0.669668},
};

float2 calcDistortedCoord(in float2 texCoords, in uint id, in float2 dir, in float2 normal, in float heat, in float2 amplitude, in float distortion) 
{
	return texCoords + amplitude * mad(heat,0.9,0.1) * (dir - heat*normal.xy*(id+2) + distortion*Poisson4[id]*mad(heat,0.6,0.4));
}

#ifdef MSAA
float4 getSourceColor(in int2 uv)
{
	float4 diffuse = 0;
	[unroll]
	for(uint i=0; i<MSAA; ++i){
		diffuse += Source.Load(uv, i);
	}
	return diffuse * samplesInv;
}
#else
float4 getSourceColor(in float2 uv)
{
	return Source.SampleLevel(gBilinearClampSampler, uv, 0);
}
#endif

//простое размытие
float4 psHeatAir(const VS_OUTPUT i): SV_TARGET0
{
	float heat = HeatMap.SampleLevel(gBilinearClampSampler, i.texCoords.zw, 0).r;
	if(heat<0.01)
		return getSourceColor(i.texCoords.xy);

	float2 normal = HeatTex.Sample(gBilinearWrapSampler, float3(i.texCoords.zw*10, time*1))*2-1;
	//return float4(normal.xy*0.5+0.5, 0, 1);
	
	float2 sc;
	sincos(noise2D(i.texCoords.zw+time*0.0001)*3.1415926, sc.x, sc.y);
	
	float4 clr=0;
	float2 amplitude = 0.001;
	float  distortion = 7.5;
	
#ifdef MSAA
	amplitude *= Dims;
#endif

	[unroll]
	for(uint ii=0; ii<4; ++ii)
	{
		float2 uv = calcDistortedCoord(i.texCoords.xy, ii, sc, normal, heat, amplitude, distortion);
		
		#ifdef MSAA
			uv = clamp(uv, 0, Dims-1);
		#else
			uv = saturate(uv);
		#endif
		
		clr += getSourceColor(uv);
	}

	return clr * 0.25;
}

technique10 Standard {
	pass heatAir{
		SetVertexShader(CompileShader(vs_4_0, vsHeatAir()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psHeatAir()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
