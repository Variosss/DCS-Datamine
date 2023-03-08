#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"

#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "ParticleSystem2/common/noiseSimplex.hlsl"



float	time;
float	rootBranchLen;
float	zoom;

static const float opacityMax = 0.12;
static const float distMax = 10;

static const float halfWidth = 6.f/2;

//TEXTURE_SAMPLER3D_FILTER(noiseTex, MIN_MAG_MIP_LINEAR, WRAP, WRAP, WRAP);
TEXTURE_SAMPLER(tex, MIN_MAG_MIP_LINEAR, CLAMP, WRAP);

//from god
struct VS_INPUT
{	
	float4 params1: TEXCOORD0; // emitterSpeed, birthTime, opacity, age
	float1 params2: TEXCOORD1; // начальная позиция партикла в мировой СК
};


struct VS_OUTPUT
{
	float4 params1: TEXCOORD0; // pos, age
	float3 params2: TEXCOORD1; // not used
};

struct HS_OUTPUT
{
	float4 params1: TEXCOORD0; // pos, age
	float3 params2: TEXCOORD1; // dir
};


struct PS_INPUT
{    
	float4 pos	 : SV_POSITION;
    float3 params: TEXCOORD0; // UV, age
};




VS_OUTPUT VS(VS_INPUT i)
{
	VS_OUTPUT o;
	o.params1 = i.params1;
	//o.params1.xyz -= worldOffset;
	o.params2 = 0;
	//o.params2 = mul(float4(i.params1.xyz,1), View).xyz;
	return o;
}

//без тесселяции
PS_INPUT VS_spline(VS_INPUT i)
{
	PS_INPUT o;
	o.pos = mul(float4(i.params1.xyz,1), VP);
	o.params = 0;
	return o;
}

/////////////////////////////////////////////////////////////////
//////////////////// TESSELATION ////////////////////////////////
/////////////////////////////////////////////////////////////////

struct HS_PATCH_OUTPUT
{
    float edges[2] : SV_TessFactor;
};

HS_PATCH_OUTPUT HSconst(InputPatch<VS_OUTPUT, 2> ip)
{
    HS_PATCH_OUTPUT o;

	// const float maxSegments = 16;
	const float maxSegments = 32;

	float dist = distance(ip[0].params1.xyz, ip[1].params1.xyz);//длина отрезка
	//rootBranchLen - длина базовой ветки

    o.edges[0] = 1; 
	o.edges[1] = 1 + floor((maxSegments-1)*min(1,sqrt(dist/rootBranchLen))+0.5);

    return o;
}


[domain("isoline")]
[partitioning("integer")]
[outputtopology("line")]
[outputcontrolpoints(2)]
[patchconstantfunc("HSconst")]
VS_OUTPUT HS(InputPatch<VS_OUTPUT, 2> ip, uint id : SV_OutputControlPointID)
{
    HS_OUTPUT o;
	o = ip[id];
	//o.params1.xyz -=worldOffset;
	//o.params1 = ip[id].params1;
	//o.params2 = ip[]
    //o = ip[id];
    return o;
}


[domain("isoline")]
VS_OUTPUT DS_spline(HS_PATCH_OUTPUT input, OutputPatch<VS_OUTPUT, 2> op, float2 uv : SV_DomainLocation, uint pId: SV_PrimitiveID)
{
    VS_OUTPUT o;

	//const float offsetCoef = 0.08;//кривизна отрезка
	const float offsetCoef = 0.1;//кривизна отрезка
	const float tCoef = pId*0.05;

    const float t = uv.x;
	//const float t2 = t*pId*513.8123;
	
	const float t2 = t*tCoef;
		
	float3 pos = lerp(op[0].params1.xyz, op[1].params1.xyz, t);//интерполированная позиция на линии;
	
	float3 dir = op[1].params1.xyz-op[0].params1.xyz;
	float3 side = normalize(cross(dir, float3(0,1,0)));
	float3 up = normalize(cross(dir, side));	
	// p1->pos += side*(randomArr.getValue()*2-1)*offsetMax + up*(randomArr.getValue()*2-1)*offsetMax;
	
	// float3 offset = side*snoise(float2(t2, pos.y*0.01)) + up*snoise(float2(t2+3.1321*tCoef, pos.y*0.01));
	float3 offset = side*snoise(float2(0, pos.y*0.005)) + up*snoise(float2(3.1321*tCoef, pos.y*0.005));

	// float3 offset = float3(snoise(float2(t2,0)), snoise(float2(t2+3.1321*tCoef,64.123)), snoise(float2(t2+14.321*tCoef,23.6413)))*2 - 1;
	// float3 offset = float3(snoise(float2(t2,0)), snoise(float2(t2+3.1321*tCoef,64.123)), snoise(float2(t2+14.321*tCoef,23.6413)))*2 - 1;

	//float3 offset = float3(noise2D(float2(t2,pos.y)), noise2D(float2(t2+3.1321, pos.y)), noise2D(float2(t2+14.321,pos.y)))*2 - 1;
	float dist = distance(op[0].params1.xyz, op[1].params1.xyz);//длина отрезка, который надо разбить
		
	pos += offset*cos((t*2-1)*halfPI)*dist*offsetCoef; //рандомное смещение 

	//o.params2 = lerp(op[0].params1.w, op[1].params1.w, t); //время рождения
	//o.params1 = mul(float4(pos,1), View);
	//o.params1 = float4(mul(float4(pos,1), VP), lerp(op[0].params1.w, op[1].params1.w, t));	
	//o.params1 = float4(mul(float4(pos,1), View).xyz, lerp(op[0].params1.w, op[1].params1.w, t));
	o.params1 = float4(pos, lerp(op[0].params1.w, op[1].params1.w, t));
	//o.params1 = float4(pos, lerp(op[0].params1.w, op[1].params1.w, t));
	o.params2 = mul(float4(o.params1.xyz-worldOffset,1), View).xyz;
    return o;
}
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


[maxvertexcount(3+5)] //с запасом на половину сегментов
void GS_spline(line VS_OUTPUT input[2], inout LineStream<PS_INPUT> outputStream)
{	
	PS_INPUT o;
	o.params = 0;

	const float dist = distance(input[0].params1.xyz, input[1].params1.xyz);
	//float3 offset = float3(noise2D(input[0].params1.xy), noise2D(input[0].params1.yz), noise2D(2*input[0].params1.xz))*2 - 1;

	float3 offset = float3(noise1D(input[0].params1.y*13.246), noise1D(input[0].params1.y*87.342), noise1D(input[0].params1.y*54.732))*2 - 1;
	
	o.pos = mul(float4(input[0].params1.xyz, 1), VP);
	outputStream.Append(o);

	o.pos = mul(float4((input[0].params1.xyz+input[1].params1.xyz)*0.5 + offset*dist*0.2, 1), VP);//середина отрезка + оффсет
	outputStream.Append(o);

	o.pos = mul(float4(input[1].params1.xyz, 1), VP);
	outputStream.Append(o);
	outputStream.RestartStrip();

	//const float vSize = 0.3;
	//const float3 vertexPos = input[0].params2;
	//o.pos = mul(float4(vertexPos + float3(staticVertexData[0].x, staticVertexData[0].y,0)*vSize, 1), Proj);
	//outputStream.Append(o);
	//o.pos = mul(float4(vertexPos + float3(staticVertexData[1].x, staticVertexData[1].y,0)*vSize, 1), Proj);
	//outputStream.Append(o);
	//o.pos = mul(float4(vertexPos + float3(staticVertexData[3].x, staticVertexData[3].y,0)*vSize, 1), Proj);
	//outputStream.Append(o);
	//o.pos = mul(float4(vertexPos + float3(staticVertexData[2].x, staticVertexData[2].y,0)*vSize, 1), Proj);
	//outputStream.Append(o);
	//o.pos = mul(float4(vertexPos + float3(staticVertexData[0].x, staticVertexData[0].y,0)*vSize, 1), Proj);
	//outputStream.Append(o);
	//outputStream.RestartStrip();
}



void addEdge(inout PS_INPUT o[2], in float3 pos1, in float2 offset, in float2 offsetDir, inout TriangleStream<PS_INPUT> outputStream, in float age, in float v)
{	
	const float texTile = 0.05;
	const float deepSpeed = 1; //скорость приращения глубины
	const float offsetCoef1 = 1;// + pow(age1, 0.5)*2.5; // увеличение толщины шлейфа
	const float offsetCoef2 = 1;// + pow(age2, 0.5)*2.5; // увеличение толщины шлейфа
	
	offset *= 1-pow(age,2);
	//offset *=2;

	offsetDir *= 1-pow(age,2);

	//----------------------------------------------
	float2 offsetResult = offsetDir + offset;
	o[0].pos = mul(float4(pos1 + float3(offsetResult,0), 1), Proj);
	o[0].params.y = v;
	o[0].params.z = age;
	outputStream.Append(o[0]);	

	//----------------------------------------------
	offsetResult = offsetDir - offset;
	o[1].pos = mul(float4(pos1 + float3(offsetResult,0), 1), Proj);
	o[1].params.y = v;
	o[1].params.z = age;
	outputStream.Append(o[1]);
}

[maxvertexcount(6)]
void GS(line VS_OUTPUT input[2], inout TriangleStream<PS_INPUT> outputStream)
{	
	PS_INPUT o[2];
	o[0].params.x = 0;
	o[1].params.x = 1;

	//float3 dir = input[1].params1.xyz - input[0].params1.xyz;
	float3 dir = input[1].params2 - input[0].params2;//во вью
	const float dist = length(dir);
	float3 posOffset = float3(noise1D(input[0].params1.y*13.246), noise1D(input[0].params1.y*87.342), noise1D(input[0].params1.y*54.732))*2 - 1;

	float3 posMiddle = (input[0].params1.xyz+input[1].params1.xyz)*0.5 + posOffset*dist*0.3;// в МСК
	float3 posMiddleV = mul(float4(posMiddle-worldOffset, 1), View).xyz;
		
	float2 offset = {-dir.y, dir.x};
	offset = normalize(offset)*halfWidth * clamp(length(posMiddleV)/10000, 0.3, 10)*(1+zoom);

	float3 offsetDir = posMiddleV - input[0].params2;
	offsetDir = normalize(offsetDir);

	
	addEdge(o, input[0].params2, offset, -offsetDir.xy, outputStream, input[0].params1.w, 0);

	const float age = lerp(input[0].params1.w, input[1].params1.w, 0.5);
	addEdge(o, posMiddleV, offset, 0,  outputStream, age, 0.5);

	offsetDir = input[1].params2 - posMiddleV;
	offsetDir = normalize(offsetDir);

	addEdge(o, input[1].params2, offset, offsetDir.xy, outputStream, input[1].params1.w, 1);

	outputStream.RestartStrip();
}


float4  PS_solid(PS_INPUT i) : SV_TARGET0
{
	//return float4(i.params.z*2, i.params.z*2, i.params.z*2, 1);
	//return float4(i.params.w, i.params.w, i.params.w, 0.7);
	return float4(i.params.xyz, 0.7);
}


float4  PS_black(PS_INPUT i) : SV_TARGET0
{
	return float4(0,0,0,1);	
}

float4  PS_geom(PS_INPUT i) : SV_TARGET0
{
	i.params.y = 0.15 + 0.7*i.params.y;
	float4 clr = TEX2D(tex, i.params);

	clr.a *= cos((2*(1-i.params.x)-1)*PI/2);
	clr.a *= min(1, cos((2*(1-i.params.y)-1)*PI/2)*1.5*2);
	clr.a *= step(i.params.z, time);
	clr.rgb *= clr.rgb;

	return max(0, clr);
}

#define lightningAlphaBlend additiveAlphaBlend

#if 0
BlendState lightningAlphaBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = ONE;
	//DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	//BlendOp = MAX;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha = MAX;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};
#endif

TECHNIQUE Textured
//TECHNIQUE Solid
{
	pass P_tessSpline_paper
	{
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(lightningAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
		//SetRasterizerState(wireframe);

		VERTEX_SHADER(VS())
		SetHullShader(CompileShader(hs_5_0, HS()));
		SetDomainShader(CompileShader(ds_5_0, DS_spline()));
		GEOMETRY_SHADER(GS())
		PIXEL_SHADER(PS_geom()) 
	}

}

//TECHNIQUE Textured
TECHNIQUE Solid
{
	pass P_tessSpline
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;

		VERTEX_SHADER(VS())
		SetHullShader(CompileShader(hs_5_0, HS()));
		SetDomainShader(CompileShader(ds_5_0, DS_spline()));
		GEOMETRY_SHADER(GS_spline())
		PIXEL_SHADER(PS_black()) 
	}
}