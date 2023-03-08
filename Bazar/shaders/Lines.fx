#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"

float4x4 matWorldViewProj;

struct VertexInput{
	float3 vPosition:	POSITION0;
	float4 vColor:	    COLOR0;
};

struct VertexOutput{
	float4 vPosition:	SV_POSITION0;
	float4 vColor:	    COLOR0;
};

VertexOutput vsSimple(const VertexInput i){
	VertexOutput o;
	
	o.vPosition = mul(float4(i.vPosition, 1.0), matWorldViewProj);	
	o.vColor = i.vColor;
	return o;
}

float4 psSimple(const VertexOutput i): SV_TARGET0 {
	return i.vColor;
}


technique11 Simple
{	
    pass P0
    {
		DISABLE_CULLING;	
		DISABLE_ALPHA_BLEND;
		ENABLE_DEPTH_BUFFER;
		VERTEX_SHADER(vsSimple())		
		PIXEL_SHADER(psSimple())
		GEOMETRY_SHADER_PLUG
    }
}

technique11 SimpleNoDepth
{	
    pass P0
    {
		DISABLE_CULLING;	
		DISABLE_ALPHA_BLEND;
		DISABLE_DEPTH_BUFFER;
		VERTEX_SHADER(vsSimple())		
		PIXEL_SHADER(psSimple())
		GEOMETRY_SHADER_PLUG
    }
}

