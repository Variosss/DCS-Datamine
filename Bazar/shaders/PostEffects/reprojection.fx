#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

TextureCube Source;
float4	viewport;
int2 	Dims;

struct VS_OUTPUT {
	noperspective float4 pos:		SV_POSITION0;
	noperspective float2 texCoords:	TEXCOORD0;
};

VS_OUTPUT vsMain(float2 pos: POSITION0)
{
	VS_OUTPUT o;
	o.pos = float4(pos, 0, 1.0);
	o.texCoords.xy = (float2(-pos.x, -pos.y)*0.5+0.5);//*viewport.zw + viewport.xy;
	return o;
}

float4 psSphericalProjection(const VS_OUTPUT i): SV_TARGET0
{
	float2 phi, teta;
	const float pi = 3.14159265;
	
	sincos(i.texCoords.x*pi*2+pi,	phi.x, 	phi.y);
	sincos((i.texCoords.y)*pi,	teta.x,	teta.y);
	
	float3 n = {teta.x*phi.y, teta.y, teta.x*phi.x};
	
	return Source.SampleLevel(gBilinearClampSampler, n, 0);
}

technique10 Standard {
	pass decartToSphericalCoordSys{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSphericalProjection()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
