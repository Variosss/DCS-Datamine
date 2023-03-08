#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "deferred/decoder.hlsl"
#include "common/dithering.hlsl"
#include "deferred/tonemap.hlsl"

#define GAMMA 2.2
// #define GAMMA 1.0


float3 ACESFilm2( float3 x )
{
    float a = 2.51f;
    float b = 0.03f;
    float c = 2.43f;
    float d = 0.59f;
    float e = 0.14f;
    return saturate((x*(a*x+b))/(x*(c*x+d)+e));
}

static const float toneMapFactor2 = 0.001;

#define tmPower	0.8
#define tmExp	1.2
static const float dcExposureKey2 = 0.8;

float getLinearExposure3(float averageLuminance) {
	return (dcExposureKey2 + toneMapFactor2) / (averageLuminance + toneMapFactor2);
}

float3 ToneMap_Filmic2(float3 x) {
	// x *= 0.35;
	float a = 1.89f;//shoulder strength
	float b = 1.00f;//linear strength
	float c = 2.06f;//linear angle
	float d = 0.15f;//toe strength
	float ef = 1.08f;//toe angle
	return saturate((x*(a*x+b))/(x*(c*x+d)+ef));
	// return saturate( (x * (tmA*x + tmB) ) / (x * (tmC * x + tmD) + tmE) );
}

float3 ToneMap_Exp22(float3 L) {
	return pow(1 - exp(-L*tmPower), tmExp);
}

float3 toneMap3(float3 color, float3 bloom, float averageLuminance)
{
	// return color;
	float3 linearColor = color * getLinearExposure3(averageLuminance);// + bloom * bloomMagnitude;	

	float3 tonmappedColor = ToneMap_Exp22(linearColor);
	// float3 tonmappedColor = ToneMap_Filmic2(linearColor);
	// float3 tonmappedColor = ToneMap_Linear(linearColor);
	
	return pow(tonmappedColor, 1.0/2.2);
	// return LinearToGammaSpace(tonmappedColor);
}


#define NAME(name, id) name##id

#define INPUT_ARRAY(type, name) \
	type NAME(name, 0); \
	type NAME(name, 1); \
	type NAME(name, 2); \
	type NAME(name, 3); \
	type NAME(name, 4); \
	type NAME(name, 5); \
	type NAME(name, 6); \
	type NAME(name, 7)

INPUT_ARRAY( Texture2D, 		source );
INPUT_ARRAY( Texture3D, 		source3d );
INPUT_ARRAY( Texture2DArray, 	sourceArray );
INPUT_ARRAY( float4, 			params );

Texture2D depthMap;
Texture2D shadowMap: register(t117);
TextureCube envMap: register(t123);
// Texture2D preintegratedGF: register(t124);

// uint2 dims;
uint lightsCount;

float4 dbg;
float4 viewport;
float averageLuminance;

#include "viewer/customShading.hlsl"

struct vOutput
{
	float4 pos	:SV_POSITION;
	float2 screenPos:TEXCOORD0;
	float2 uv	:TEXCOORD1;
};

static const float2 quad[4] =
{
	float2(-1, -1), float2(1, -1),
	float2(-1, 1),	float2(1, 1),
};


vOutput vsMain(uint vid: SV_VertexID)
{
	vOutput o;
	float2 sc;
	sincos(params0.x*3.141592653589/180, sc.x, sc.y);
	float2x2 M = {sc.y, sc.x, -sc.x, sc.y};
	o.pos = float4(quad[vid], 0, 1);
	o.screenPos = quad[vid];
	o.uv.xy = mul(quad[vid], M)*0.5+0.5; 
	// o.uv.xy = quad[vid]*0.5+0.5;
	o.uv.y = 1 - o.uv.y;	
	return o;
}

float4 psCopy(const vOutput i): SV_TARGET0 
{
	return source0.SampleLevel(gBilinearClampSampler, i.uv.xy, 0);
}

float4 psCopyFromTexArray(const vOutput i): SV_TARGET0 
{
	return sourceArray0.SampleLevel(gBilinearClampSampler, float3(i.uv.xy, params0.y), 0.0);
}


float4 psComposing(const vOutput i): SV_TARGET0
{
	float zDepth = depthMap.SampleLevel(gPointClampSampler, i.uv.xy, 0).r;
	
	float4 wPos = mul(float4(i.screenPos, zDepth, 1), gViewProjInv);
	wPos /= wPos.w;	

	float4 baseColor = source0.SampleLevel(gPointClampSampler, i.uv.xy, 0);
	float4 specular  = source1.SampleLevel(gPointClampSampler, i.uv.xy, 0);
	float4 emissive	 = source2.SampleLevel(gPointClampSampler, i.uv.xy, 0);
	float3 normalV = source3.SampleLevel(gPointClampSampler, i.uv.xy, 0).xyz;
	
	baseColor.rgb = pow(baseColor.rgb, GAMMA);
	baseColor.rgb *= baseColor.a;
	
	if(!any(normalV))
		return float4(baseColor);
	
	float3 normal = normalize(mul(normalV*2-1, (float3x3)gViewInv));
		
	// return float4(normal*0.5+0.5, 0);
	// return baseColor.aaaa;
	// return emissive;
	// return specular.xxxx;
	// float roughness = min(1, specular.r*2);
	// float roughness = clamp(min(1, specular.r*2.5), 0.02, 0.99);
	// float roughness = clamp(specular.w, 0.01, 0.99);
	float roughness = clamp(specular.x, 0.01, 0.999);
	// float roughness = dbg.x/100.0;
	
	float cavity = specular.z*2.0;
	cavity = 1;
	float metallic = specular.y; //baseColor.y;
	
	//analytic SUN
	emissive = 0;//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	float3 finalColor = ShadeCustom(normal, baseColor, roughness, metallic, cavity, 1, emissive, wPos);
	
	return float4(finalColor, 1);
}

float4 psTonemapping(vOutput i, uniform bool bManual = false): SV_TARGET0 
{
	// return float4(LinearToGammaSpace(source0.Load(uint3(i.pos.xy, 0)).rgb), 1.0);
	// return source0.Load(uint3(i.pos.xy, 0));
	return float4(toneMap3(source0.Load(uint3(i.pos.xy, 0)).rgb, float3(0,0,0), averageLuminance), 1);
}

float4 psColorGrading(vOutput i): SV_TARGET0
{
	float3 sourceColor = source0.Load(uint3(i.pos.xy, 0)).rgb;
	float3 gradedColor = source3d0.SampleLevel(gTrilinearClampSampler, sourceColor, 0);
	
	float gradingFactor = dbg.w/100.0;
	return float4(lerp(sourceColor, gradedColor, gradingFactor), 1);
}

VertexShader vsComp = CompileShader(vs_5_0, vsMain());

#define PASS_BODY(ps) { SetVertexShader(vsComp); \
	SetGeometryShader(NULL); \
	SetPixelShader(CompileShader(ps_5_0, ps)); \
	SetDepthStencilState(disableDepthBuffer, 0); \
	SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
	SetRasterizerState(cullNone);}

technique10 tech
{
	pass copy				PASS_BODY( psCopy() )
	pass copyFromTexArray	PASS_BODY( psCopyFromTexArray())
	pass composing			PASS_BODY( psComposing() )	
	pass tonemapping		PASS_BODY( psTonemapping() )
	pass tonemappingManual	PASS_BODY( psTonemapping(true) )
	pass colorGrading		PASS_BODY( psColorGrading() )
}
