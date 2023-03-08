#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"
#include "noise/noise3D.hlsl"



float emitTimer;
float phaseOffset;
float opacityFlir;
float brightness;
float rpm;

Texture2D texAfterburner;

float4x4	World;
float4x4	WorldInv;
float3 firstPoint;
static const float3 secondPoint = float3(0.0, 0.0, 0.0);
static const float epsilon = 0.05; 	//add margin for our parallelepiped
float trailRadius;

struct VS_OUTPUT_RAYMARCH
{
	float4 pos			: SV_POSITION0;
	float3 efPos		: TEXCOORD0;
};



VS_OUTPUT_RAYMARCH vs_raymarch(float3 pos: POSITION0, uint id: SV_VertexID)
{

	VS_OUTPUT_RAYMARCH o;


	//make our input cube into parallelepipid that contains the effect
	float3 newPos = pos + float3(1.0, 0.0, 0.0);
	newPos.x *= abs(firstPoint.x - secondPoint.x)/2.0 + epsilon;
	newPos.y *= trailRadius + epsilon;
	newPos.z *= trailRadius + epsilon;
	newPos += secondPoint;

	float3 worldPos = mul(float4(newPos, 1.0), World);
	o.efPos = newPos;
	o.pos = mul(mul(float4(newPos, 1.0), World), gViewProj);
	return o;
}

float2 GetCylinderIntersection(const float3 p, const float3 v, const float radius)
{
	//extreme points of the axis of the cylinder
	#define x_0	secondPoint.x
	#define x_1	firstPoint.x
	//#define radius trailRadius


	// find intersection points, p+L*v, p - eye posion, v- viewDir
	float L_min = 1000;
	float L_max = -1000;
	float L;
	int points_intersected = 0;
	
	//find intersection point on the body of the cylinder, we solve quadratic equation
	float a = (pow(v.y,2)+pow(v.z,2));
	float b = 2*(v.y*p.y+v.z*p.z);
	float c = pow(p.y,2)+pow(p.z,2)-pow(radius,2);

	//we are inside the cylinder
	if ((x_0 <= p.x <= x_1) && (c <= 0)) {
		points_intersected ++;
		L =  0.0;
		L_min = min(L_min, L);
		L_max = max(L_max, L);
	}


	L = (-p.x+x_0)/v.x;
	if (pow(p.y + L*v.y,2)+pow(p.z + L*v.z,2) <= pow(radius,2)) {
		points_intersected ++;
		L_min = min(L_min, L);
		L_max = max(L_max, L);
		/*if (L > 0.0) {
			L_min = min(L_min, L);
			L_max = max(L_max, L);
		}*/
	}

	L = (-p.x+x_1)/v.x;
	if (pow(p.y + L*v.y,2)+pow(p.z + L*v.z,2) <= pow(radius,2)) {
		points_intersected ++;
		L_min = min(L_min, L);
		L_max = max(L_max, L);
		/*if (L > 0.0) {
			L_min = min(L_min, L);
			L_max = max(L_max, L);
		}*/
	}

	//if (points_intersected == 2)
		//return float2(L_min, L_max);
	
	//find discriminant of the quadratic equation
	float D = pow(b, 2)-4*a*c;


	if (D > 0.0) {
		L = (-b+sqrt(D))/(2*a);
		
		if ((x_0 <= p.x+L*v.x) &&  (p.x+L*v.x <= x_1)) {
			points_intersected ++;
			L_min = min(L_min, L);
			L_max = max(L_max, L);
			/*if (L > 0.0) {
				L_min = min(L_min, L);
				L_max = max(L_max, L);
			}*/
			
			//if (points_intersected == 2)
				//return float2(L_min, L_max);
		}

		L = (-b-sqrt(D))/(2*a);
		
		if ((x_0 <= p.x+L*v.x) &&  (p.x+L*v.x <= x_1)) {
			points_intersected ++;
			L_min = min(L_min, L);
			L_max = max(L_max, L);
			/*if (L > 0.0) {
				L_min = min(L_min, L);
				L_max = max(L_max, L);
			}*/
			
			//if (points_intersected == 2)
				//return float2(L_min, L_max);
		}
	}

	if (points_intersected >= 2)
		return float2(L_min, L_max);
	//return float2(L_min, L_max);
	return float2(-1.0, -1.0);
	#undef x_0
	#undef x_1
	//#undef radius

}

float2 EffectSpaceToHeightAndDist(float3 posInEffectSpace)
{
	float2 cyl;
	cyl.y  = abs(posInEffectSpace.x)/abs(firstPoint.x - secondPoint.x);
	cyl.x = length((posInEffectSpace - (firstPoint-secondPoint)/2.0).yz)/(2.0*trailRadius)+0.5;
	return float2(cyl.y, cyl.x);

}


float2 HeightAndRadiusToUV(float2 heightDist)
{
	float2 uv;
	return float2(heightDist.x*0.67 + 0.08, heightDist.y);
}


float4 SampleEmission(float2 uv)
{
	return  texAfterburner.SampleLevel(gTrilinearClampSampler, float3(uv, 0.0), 0.0);
}

#define _width 		gScreenWidth
#define _height 	gScreenHeight


float SamplePerlinNoise(float3 uvw, float scale)
{
	scale *= 0.5;
	uvw *= scale;

	float w0 = pnoise(uvw*scale*2, scale*2)*0.5+0.5;
	float w1 = pnoise(uvw*scale*7 + 0.16412, scale*7)*0.5+0.5;
	float w2 = pnoise(uvw*scale*14 + 0.05712, scale*14)*0.5+0.5;
	float w3 = pnoise(uvw*scale*18 + 0.13192, scale*18)*0.5+0.5;

	return 0.6*w0 + 0.25*w1 + 0.1*w2 + w3*0.05;
}


float2 DetailedUV(float3 pos, float2 uv, float scale) {
	float perlin = SamplePerlinNoise(pos, 1.2*scale);
	float2 newUV = float2(min(max(uv.x + perlin, 0.0), 1.0), uv.y);
	//newUV = float2(uv.x + perlin, uv.y);

	newUV.x = newUV.x*0.65 + 0.1;
	return newUV;
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

float4 ps_raymarch_flir(VS_OUTPUT_RAYMARCH i): SV_TARGET0
{

    float3 rayVector = normalize(mul(float4(gCameraPos, 1.0), WorldInv).xyz - i.efPos);

	const float rayStep = 0.02;

	float2 inters = GetCylinderIntersection(i.efPos, rayVector, trailRadius);
	
	if (inters.x == inters.y) 
		clip(-1);
	
	//return float4(0.5, 0.5, 0.5, 0.5);
	
	//return float4(abs(inters.y), abs(inters.y), abs(inters.y), 0.1);
	float4 emission_res = float4(0.0, 0.0, 0.0, 0.0);

	for(float distFromEye = inters.x; distFromEye <= inters.y; distFromEye += rayStep)
	{
		float3 pos = i.efPos + rayVector * distFromEye;
		float2 heightAndDist = EffectSpaceToHeightAndDist(pos);

		float2 uv = HeightAndRadiusToUV(heightAndDist);
		//uv.y = lerp(pow(uv.y-0.5, 0.5)/(2*pow(0.5, 0.5))+0.5, uv.y, 1.0 - heightAndDist.x);
		float4 emission = SampleEmission(uv);
		emission = emission * emission;
		if (emission.w < 0.01) 
			continue;
		//pos.x += emitTimer*0.1;
		//float scale = (1.0+phaseOffset/10.0) + 4.0*(frac(emitTimer*(1.0+phaseOffset) + phaseOffset)/5.0 + 0.1);
		//float scale = 1.5*(1.0+phaseOffset/10.0) + 1.5*(frac(emitTimer*(1.0+phaseOffset) + phaseOffset)/20.0 + 0.1) ;
		//float scale = 1.5*(1.0+phaseOffset/10.0) + 1.5*(frac(0.000005*emitTimer*(1.0+phaseOffset)) + 0.1);

		float scale = 1.5*(1.0+phaseOffset/10.0) + (frac(emitTimer*0.0001*(1.0+phaseOffset) + phaseOffset)/20.0 + 0.1);

		//float3 new_pos = EffectSpaceToHeightAndDist3(pos);
		uv = DetailedUV(pos, uv, scale);

		float4 emissionNoise = SampleEmission(uv);
		emissionNoise = emissionNoise * emissionNoise;

		float t = smoothstep(0.2, 0.9, heightAndDist.y);
		//t = smoothstep(0.0, 1.0, heightAndDist.y);
		emission = t*emissionNoise + (1.0 - t)*emission;


		if (emission.w < 0.05) 
			continue;

		emission_res += emission;	
	}	

	float mult = abs(inters.x -inters.y);
	mult = clamp(mult, 1.0, mult/2.0);
	mult = 1.0/mult;

	
	float l = luminance(emission_res.xyz);
	return float4(l, l, l, mult*emission_res.w*opacityFlir*brightness*10.0)*rayStep;

}


float4 ps_raymarch_flirLOD(VS_OUTPUT_RAYMARCH i): SV_TARGET0
{

	float3 eyePosP = mul(float4(gCameraPos, 1.0), WorldInv).xyz; 
    float3 rayVector = normalize(eyePosP - i.efPos);

	const float rayStep = 0.1;


	float2 inters = GetCylinderIntersection(i.efPos, rayVector, trailRadius);
	
	if (inters.x == inters.y) 
		clip(-1);
	
	float4 emission_res = float4(0.0, 0.0, 0.0, 0.0);

	for(float distFromEye = inters.x; distFromEye <= inters.y; distFromEye += rayStep)
	{
		float3 pos = i.efPos + rayVector * distFromEye;
		float2 heightAndDist = EffectSpaceToHeightAndDist(pos);

		float2 uv = HeightAndRadiusToUV(heightAndDist);
		float4 emission = SampleEmission(uv);
		if (emission.w < 0.1) 
			continue;
		emission = emission * emission;
		emission_res += emission;	
	}	

	float l = luminance(emission_res.xyz);
	return float4(l, l, l, emission_res.w*opacityFlir*brightness*6.0)*rayStep;

}




technique10 tech
{
	pass flir
	{
		SetVertexShader(CompileShader(vs_4_0, vs_raymarch()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_raymarch_flir()));
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}

	pass flirLOD
	{
		SetVertexShader(CompileShader(vs_4_0, vs_raymarch()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_raymarch_flirLOD()));
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullFront);
	}

}
