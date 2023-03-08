#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/TextureSamplers.hlsl"
#include "common/AmbientCube.hlsl"

TextureCube Target;

float4x4 ViewProjectionMatrix;
float opacity;
float zoominv;
int3 dims;
int  channel;
float value_pow;

struct VS_INPUT
{
	float4 pos : POSITION;
	float2 tc  : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 vPosition : SV_POSITION;
	float2 vTexCoord : TEXCOORD0;
};

VS_OUTPUT vsMain(VS_INPUT IN)
{
	VS_OUTPUT o;
	o.vPosition = mul(float4(IN.pos.xyz,1.0), ViewProjectionMatrix);
	o.vTexCoord = IN.tc;
	return o;
}

float4 psSolidTech(VS_OUTPUT input, uniform bool top, uniform float mip = -1.0) : SV_TARGET0
{
	float3 r;
	r.xz = input.vTexCoord*2-1;
	r.y  = 1.0f - sqrt(r.x*r.x+r.z*r.z);
	if(r.y <= 0)
		discard;
	if(!top)
		r.y = -r.y;
	
	float4 color;
	
	if(mip<0.0)
		color = float4(Target.Sample(gTrilinearClampSampler, r).rgb, opacity);
	else
		color = float4(Target.SampleLevel(gTrilinearClampSampler, r, mip).rgb, opacity);

	return color;
}

float4 psAlphaTech(VS_OUTPUT input, uniform bool top, uniform float mip = -1.0) : SV_TARGET0
{
	float3 r;
	r.xz = input.vTexCoord*2-1;
	r.y  = 1.0f - sqrt(r.x*r.x+r.z*r.z);
	if(r.y <= 0)
		discard;
	if(!top)
		r.y = -r.y;
	
	float4 color;
	
	if(mip<0.0)
		color = float4(Target.Sample(gTrilinearClampSampler, r).aaa, opacity);
	else
		color = float4(Target.SampleLevel(gTrilinearClampSampler, r, mip).aaa, opacity);

	return color;
}

float4 psAmbientTech(VS_OUTPUT input, in uniform bool top) : SV_TARGET0
{
	float3 r;
	r.xz = input.vTexCoord*2-1;
	r.y  = 1.0f - sqrt(r.x*r.x+r.z*r.z);
	if( r.y<=0)
		discard;
	if( !top)
		r.y = -r.y;
		

	float coef = 1 - min(1, r.y+1); // при отрицательном Y ходит от 0 до 1,    единица когда Y минимальный!!!!
	r.y -= coef*1.0;
	r = normalize(r);
	
	float4 color = float4(AmbientLight(normalize(r)), opacity);
	color.a = color.a;

	return color;
}

float3 uvToSphere(float u, float v)
{
	float3 sunDir;
	sunDir.y = -1.0 + 2.0 * v;
	float azimuth = 2.0 * 3.1415 * u;
	float normFactor = sqrt(1.0 - sunDir.y*sunDir.y);
	sunDir.x = sin(azimuth)*normFactor;
	sunDir.z = cos(azimuth)*normFactor;
	return sunDir;
}

float4 psCubeToQuadTech(VS_OUTPUT input) : SV_TARGET0
{	
	float2 uv = input.vTexCoord;
	float4 color = float4(Target.SampleLevel(gTrilinearClampSampler, uvToSphere(uv.x, 1-uv.y), 0).rgb*2, opacity);
	return color;
}

float4 psCubeToQuadTechAlpha(VS_OUTPUT input) : SV_TARGET0
{	
	float2 uv = input.vTexCoord;
	float4 color = float4(Target.SampleLevel(gTrilinearClampSampler, uvToSphere(uv.x, 1-uv.y), 0).aaa, opacity);
	return color;
}

VertexShader vsCompiled = CompileShader(vs_4_0, vsMain());

#define TECH_BODY(topBottom, mip) { \
	pass p0 {\
		SetVertexShader(vsCompiled); \
		SetGeometryShader(NULL); \
		SetPixelShader( CompileShader(ps_4_0, psSolidTech(topBottom, mip) ) );\
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
		SetRasterizerState(cullNone); \
		SetDepthStencilState(disableDepthBuffer, 0); \
	} \
}

technique10 topSphere		TECH_BODY(true, -1.0);
technique10 topSphere0		TECH_BODY(true, 0.0);
technique10 topSphere1		TECH_BODY(true, 1.0);
technique10 topSphere2		TECH_BODY(true, 2.0);
technique10 topSphere3		TECH_BODY(true, 3.0);
technique10 topSphere4		TECH_BODY(true, 4.0);
technique10 topSphere5		TECH_BODY(true, 5.0);
technique10 topSphere6		TECH_BODY(true, 6.0);
technique10 topSphere7		TECH_BODY(true, 7.0);
technique10 topSphere8		TECH_BODY(true, 8.0);
technique10 topSphere9		TECH_BODY(true, 9.0);
technique10 topSphere10		TECH_BODY(true, 10.0);

technique10 bottomSphere	TECH_BODY(false, -1.0);
technique10 bottomSphere0	TECH_BODY(false, 0.0);
technique10 bottomSphere1	TECH_BODY(false, 1.0);
technique10 bottomSphere2	TECH_BODY(false, 2.0);
technique10 bottomSphere3	TECH_BODY(false, 3.0);
technique10 bottomSphere4	TECH_BODY(false, 4.0);
technique10 bottomSphere5	TECH_BODY(false, 5.0);
technique10 bottomSphere6	TECH_BODY(false, 6.0);
technique10 bottomSphere7	TECH_BODY(false, 7.0);
technique10 bottomSphere8	TECH_BODY(false, 8.0);
technique10 bottomSphere9	TECH_BODY(false, 9.0);
technique10 bottomSphere10	TECH_BODY(false, 10.0);

#undef TECH_BODY
#define TECH_BODY(topBottom, mip) { \
	pass p0 {\
		SetVertexShader(vsCompiled); \
		SetGeometryShader(NULL); \
		SetPixelShader( CompileShader(ps_4_0, psAlphaTech(topBottom, mip) ) );\
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
		SetRasterizerState(cullNone); \
		SetDepthStencilState(disableDepthBuffer, 0); \
	} \
}

technique10 topSphereAlpha		TECH_BODY(true, 0.0);
technique10 bottomSphereAlpha	TECH_BODY(false, 0.0);

technique10 cubeToQuad
{
	pass P0
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psCubeToQuadTech()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}

technique10 cubeToQuadAlpha
{
	pass P0
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psCubeToQuadTechAlpha()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}


technique10 bottomSphereAmbient
{
	pass P0
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psAmbientTech(false)));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}

technique10 topSphereAmbient
{
	pass P0
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psAmbientTech(true)));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}

