
Texture2D TextureMap;

#ifdef MSAA
	Texture2DMS<float, MSAA> DepthMap;
	static const float samplesInv = 1.0 / MSAA;
#else
	Texture2D DepthMap;
#endif

float4 BlendColor;
float Power;
uint2 Dims;

struct vsIn
{
	float3 vPosition:	POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

struct vsOutput_ils
{
	float4 vPosition:	SV_POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

float2 getScreenUV(float4 projPos)
{
	float2 uv = 0.5*projPos.xy/projPos.w + 0.5;
	uv.y = 1 - uv.y;
#ifdef MSAA
	uv *= Dims;
#endif
	return uv;
}

void depthTest(float2 uv, float depth)
{
#ifdef MSAA
	float depthRef = DepthMap.Load(uv, 0).r;
#else
	float depthRef = DepthMap.SampleLevel(gBilinearClampSampler, uv, 0).r;
#endif
	if(depthRef >= depth)
		discard;
}

vsOutput_ils vsSimpleILS(in vsIn i)
{
	vsOutput_ils o;
	o.vPosition = mul(float4(i.vPosition, 1.0), matWorldViewProj);
	o.vTexCoord0.xy = i.vTexCoord0;
	return o;
}

float4 psTexShader(in vsOutput_ils i, uniform bool bReadDepth): SV_TARGET0 
{
	float4 tex = TextureMap.Sample(WrapLinearSampler, i.vTexCoord0.xy);
	//clip(tex.a-0.02);
	
	if(bReadDepth)
		depthTest(i.vPosition.xy, i.vPosition.z);

	// alpha separate
	float3 color = (pow(tex.rgb, Power) * BlendColor.rgb) * pow(1.0/0.99, Power);
	float alpha =  tex.a * BlendColor.a;
		
	return float4(color, alpha);
}

float4 psTexShaderA8(in vsOutput_ils i, uniform bool bReadDepth): SV_TARGET0 
{
	float4 tex = TextureMap.Sample(WrapLinearSampler, i.vTexCoord0.xy);
	clip(tex.a-0.02);
	
	if(bReadDepth)
		depthTest(i.vPosition.xy, i.vPosition.z);

	// alpha separate
	float3 color = BlendColor.rgb * pow(1.0/0.99, Power);
	float alpha =  tex.a * BlendColor.a;
	return float4(color, alpha);
}

struct vsOutput2
{
	float4 vPosition:	SV_POSITION0;
};

vsOutput2 vsWithoutTexture(float3 vPosition: POSITION) 
{
	vsOutput2 o;
	o.vPosition = mul(float4(vPosition, 1.0), matWorldViewProj);
	return o;	
}

float4 psWithoutTexture(in vsOutput2 i, uniform bool bReadDepth): SV_TARGET0
{
	if(bReadDepth)
		depthTest(i.vPosition.xy, i.vPosition.z);
	
	return BlendColor;
}


void vsLine(in vsIn i, out float4 vPos:POSITION0)
{
	vPos = mul( mul(float4(i.vPosition, 1.0), matWorldViewProj), gProjInv);
	vPos /= vPos.w;
}

#define addVert(pos) o.vPosition = mul(pos, gProj); outStream.Append(o);

#define addVert2(pos, padd, uv) o.vTexCoord0.xy = uv.xy; \
								o.vPosition = mul(float4(pos.xy + mul(padd.xy, M), pos.z, 1), gProj); outStream.Append(o);

#define addVertL(padd, uv) 	addVert2(vPos[0], padd, uv)
#define addVertR(padd, uv) 	addVert2(vPos[1], padd, uv)

[maxvertexcount(24)]
void gsLine(in lineadj float4 vPos[4] : POSITION0, inout TriangleStream<vsOutput_ils> outStream)
{
	static const float p = 0.003; // padding
	static const float width = 0.001;
	static const float uvOffset = 0.0;


	const float width2 = width / 2;	
	float2 dir = normalize(vPos[1].xy - vPos[0].xy);
	float2x2 M = {dir.xy, -dir.y, dir.x};
	vsOutput_ils o;

	//начальная крышка
	addVertL(float2(-p, 	width2 + p), float2(0.0 - uvOffset, 1.0 + uvOffset));
	addVertL(float2(0, 		width2 + p), float2(0.5, 1.0 + uvOffset));

	addVertL(float2(-p, 	width2), float2(0.0 - uvOffset, 0.5));
	addVertL(float2(0, 		width2), float2(0.5, 0.5));

	addVertL(float2(-p,		-width2), float2(0.0 - uvOffset, 0.5));
	addVertL(float2(0,		-width2), float2(0.5, 0.5));

	addVertL(float2(-p,		-width2 - p), float2(0.0 - uvOffset, 0.0 - uvOffset));
	addVertL(float2(0,		-width2 - p), float2(0.5, 0.0 - uvOffset));	
	outStream.RestartStrip();

	//центральная линия
	addVertL(float2(0, 	width2 + p), float2(0.5, 1.0 + uvOffset));
	addVertR(float2(0, 	width2 + p), float2(0.5, 1.0 + uvOffset));
	
	addVertL(float2(0, 	width2), float2(0.5, 0.5));
	addVertR(float2(0, 	width2), float2(0.5, 0.5));

	addVertL(float2(0,	-width2), float2(0.5, 0.5));
	addVertR(float2(0,	-width2), float2(0.5, 0.5));

	addVertL(float2(0,	-width2 - p), float2(0.5, 0.0 - uvOffset));
	addVertR(float2(0,	-width2 - p), float2(0.5, 0.0 - uvOffset));
	outStream.RestartStrip();

	//конечная крышка
	addVertR(float2(0, 	width2 + p), float2(0.5, 1.0 + uvOffset));
	addVertR(float2(p, 	width2 + p), float2(1.0 + uvOffset, 1.0 + uvOffset));
	
	addVertR(float2(0, 	width2), float2(0.5, 0.5));
	addVertR(float2(p, 	width2), float2(1.0 + uvOffset, 0.5));

	addVertR(float2(0,	-width2), float2(0.5, 0.5));
	addVertR(float2(p,	-width2), float2(1.0 + uvOffset, 0.5));

	addVertR(float2(0,	-width2 - p), float2(0.5, 0.0 - uvOffset));
	addVertR(float2(p,	-width2 - p), float2(1.0 + uvOffset, 0.0 - uvOffset));
	outStream.RestartStrip();
}

float4 psLine(in vsOutput_ils i, uniform bool bReadDepth): SV_TARGET0
{
	float alpha = TextureMap.Sample(ClampLinearSampler, i.vTexCoord0.xy).a;
	return float4(1,0.5,0, alpha);
}


VertexShader vsSimpleComp 			= CompileShader(vs_4_0, vsSimpleILS());
VertexShader vsWithoutTextureComp	= CompileShader(vs_4_0, vsWithoutTexture());

VertexShader vsLineComp 			= CompileShader(vs_4_0, vsLine());
GeometryShader gsLineComp			= CompileShader(gs_4_0, gsLine());

#define PASS(name, vs, ps) \
	pass name {\
		SetVertexShader(vs);\
		SetGeometryShader(NULL);\
		SetPixelShader(ps);\
		SetRasterizerState(cullNone);}

#define PASS_LINE(name, vs, gs, ps) \
	pass name {\
		SetVertexShader(vs);\
		SetGeometryShader(gs);\
		SetPixelShader(ps);\
		SetRasterizerState(cullNone);}

technique10 tech {
	PASS(main,			vsSimpleComp, CompileShader(ps_4_0, psTexShader(false)))
	PASS(mainWithDepth, vsSimpleComp, CompileShader(ps_4_0, psTexShader(true)))
}

technique10 techA8 {
	PASS(main,			vsSimpleComp, CompileShader(ps_4_0, psTexShaderA8(false)))
	PASS(mainWithDepth, vsSimpleComp, CompileShader(ps_4_0, psTexShaderA8(true)))
}

technique10 techWithoutTexture {
	PASS(main, 			vsWithoutTextureComp, CompileShader(ps_4_0, psWithoutTexture(false)))
	PASS(mainWithDepth, vsWithoutTextureComp, CompileShader(ps_4_0, psWithoutTexture(true)))
}

technique10 techLine {
	PASS_LINE(main, 			vsLineComp, gsLineComp, CompileShader(ps_4_0, psLine(false)))
	PASS_LINE(mainWithDepth, vsLineComp, gsLineComp, CompileShader(ps_4_0, psLine(true)))
}

