//#include "../deferred/shadows.hlsl"
//#include "../enlight/atmInscatterResults.hlsl"

#define USE_INVERSE_PROJ

#include "../common/states11.hlsl"

float4x4 WVP;
float4x4 Model;
float3 color;

float4x4 inverseCockpit;

float3 cameraPos;			// The camera's current position
float3 lightDir;			// The direction vector to the light source

struct VS_INPUT
{
   	float4 pos		: POSITION; 
   	float3 normal	: NORMAL; 
};


struct VS_OUTPUT
{
    float4 pos		: SV_POSITION; 
	float3 normal	: TEXCOORD0;
	float3 view		: TEXCOORD1; 
	float4 ppos		: TEXCOORD2;
	float4 projPos	: TEXCOORD3;  
};

VS_OUTPUT VS(VS_INPUT i)
{

    	VS_OUTPUT o;

	float4 tp = mul(i.pos, Model);

	o.projPos = o.pos = mul(tp, WVP);
	o.normal = i.normal;
	o.view = tp.xyz/tp.w - cameraPos;

	o.ppos = float4(tp.xyz/tp.w, o.pos.z/o.pos.w);

	return o;    
}


float4 PS(VS_OUTPUT i) : SV_TARGET0
{ 

//	Lambert
//    float3 diff = color * max ( dot ( i.normal, lightDir ), 0.0 );

//	Minnaert
	const float	k = 0.8;
	float3 n2 = normalize( i.normal );
	float3 v2 = normalize( i.view );
	float3 l2 = normalize ( lightDir );

	float d1 = pow ( max ( dot ( n2, l2 ), 0.0 ), 1.0 + k );
	float d2 = pow ( 1.0 - dot ( n2, v2 ), 1.0 - k );

	float3 diff = color * d1 * d2;

	float lightFactor = 1;
//	float lightFactor = SampleShadow(i.ppos, n2);
//	lightFactor = 0.5 + saturate(lightFactor)*0.5;

    diff*=lightFactor;

//	diff = atmosphereApply(float3(0,0,0), i.view, i.projPos, diff);
//	diff = diff*sbAtmosphereSamples[inscatterID].attenuation + sbAtmosphereSamples[inscatterID].inscatter;
	

	float3 wp = i.ppos.xyz;

	float4 cp = mul(float4(wp, 1), inverseCockpit);

//	if(!any(step(1, abs(cp.xyz/cp.w))))
//		discard;
	clip(-!any(step(1, abs(cp.xyz/cp.w))));

//	if(abs(cp.x)<1 && abs(cp.y)<1 && abs(cp.z)<1)
//		discard;


	return float4(diff, 1);
}


technique10 solid
{
    pass P0
	{          
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, PS()));
		SetComputeShader(NULL);

		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              

    }
}
