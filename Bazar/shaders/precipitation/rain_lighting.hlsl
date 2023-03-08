#ifndef RAIN_LIGHTING_HLSL
#define RAIN_LIGHTING_HLSL

#include "common/Attenuation.hlsl"
#include "common/lightsCommon.hlsl"

float4 calculateSumLightingSpecular(float3 toCam, float3 pos, float3 norm, float rainSpecularPower)
{


	float4	sumColor = 0;
	float	Att;

	//споты	
	SpotAttenParams attPrmsSpot;
	attPrmsSpot.theta = 1;//spotsLocal[i].angles.y;//делаем радиальный градиент прямо от центра к краю конуса 
	// attPrmsSpot.phi = spotsLocal[0].angles.x;//делаем радиальный градиент прямо от центра к краю конуса 

	for(uint i=0; i<lightCount.y; ++i)
	{
		//конус затухания от спота
		//----------------------------------------------------
		attPrmsSpot.distance = distance(spotsLocal[i].pos.xyz, pos);
		attPrmsSpot.vLight = -normalize(spotsLocal[i].pos.xyz - pos);
		attPrmsSpot.vLightDirection = spotsLocal[i].dir.xyz;

		float3 Rspec = reflect(-attPrmsSpot.vLight, norm);
		float RdotV = max(0, dot(Rspec, toCam));
		//RdotV = 1.0;

		attPrmsSpot.phi = spotsLocal[i].angles.x;//делаем радиальный градиент прямо от центра к краю конуса
		attPrmsSpot.range = spotsLocal[i].pos.w;
	// #ifdef USE_DCS_DEFERRED
		// Att = angleAttenuation(attPrmsSpot.vLightDirection, attPrmsSpot.phi, attPrmsSpot.theta, -attPrmsSpot.vLight) * distAttenuation(attPrmsSpot.range, attPrmsSpot.distance);
	// #else
		Att = SpotAttenuation(attPrmsSpot);
	// #endif
		//sumColor.rgb += spotsLocal[i].diffuse.rgb * spotsLocal[i].diffuse.a*Att;
		sumColor.rgb += spotsLocal[i].diffuse.rgb * spotsLocal[i].diffuse.a*Att*(pow(RdotV, 3)*0.6+0.4);
		sumColor.a += Att;
	}

	return sumColor;
}

float4 calculateSumLighting(float3 toCam, float3 pos)
{
	float4	sumColor = 0;
	float	Att;

	//споты	
	SpotAttenParams attPrmsSpot;
	attPrmsSpot.theta = 1;//spotsLocal[i].angles.y;//делаем радиальный градиент прямо от центра к краю конуса 
	// attPrmsSpot.phi = spotsLocal[0].angles.x;//делаем радиальный градиент прямо от центра к краю конуса 

	for(uint i=0; i<lightCount.y; ++i)
	{
		//конус затухания от спота
		//----------------------------------------------------
		attPrmsSpot.distance = distance(spotsLocal[i].pos.xyz, pos);
		attPrmsSpot.vLight = -normalize(spotsLocal[i].pos.xyz - pos);
		attPrmsSpot.vLightDirection = spotsLocal[i].dir.xyz;
		attPrmsSpot.phi = spotsLocal[i].angles.x;//делаем радиальный градиент прямо от центра к краю конуса
		attPrmsSpot.range = spotsLocal[i].pos.w;
	// #ifdef USE_DCS_DEFERRED
		// Att = angleAttenuation(attPrmsSpot.vLightDirection, attPrmsSpot.phi, attPrmsSpot.theta, -attPrmsSpot.vLight) * distAttenuation(attPrmsSpot.range, attPrmsSpot.distance);
	// #else
		Att = SpotAttenuation(attPrmsSpot);
	// #endif
		sumColor.rgb += spotsLocal[i].diffuse.rgb * spotsLocal[i].diffuse.a*Att;
		sumColor.a += Att;
	}

	return sumColor;
}

float4 calculateMistSumLighting(float3 toCam, float3 pos)
{	
	float4	sumColor = 0;
	float	Att;

	//споты
	SpotAttenParams attPrmsSpot;
	attPrmsSpot.theta = 1;//spotsLocal[j].angles.y;//делаем радиальный градиент прямо от центра к краю конуса 

	for(uint j=0; j<lightCount.y; ++j)
	{
		//конус затухания от спота
		//----------------------------------------------------
		attPrmsSpot.distance = distance(spotsLocal[j].pos.xyz, pos);
		attPrmsSpot.vLight   = -normalize(spotsLocal[j].pos.xyz - pos);
		

		attPrmsSpot.vLightDirection = spotsLocal[j].dir.xyz;
		attPrmsSpot.phi   = spotsLocal[j].angles.x;  //делаем радиальный градиент прямо от центра к краю конуса
		// attPrmsSpot.theta = spotsLocal[j].angles.y;//делаем радиальный градиент прямо от центра к краю конуса
		attPrmsSpot.range = spotsLocal[j].pos.w;
	// #ifdef USE_DCS_DEFERRED
		// Att = angleAttenuation(attPrmsSpot.vLightDirection, attPrmsSpot.phi, attPrmsSpot.theta, -attPrmsSpot.vLight) * distAttenuation(attPrmsSpot.range, attPrmsSpot.distance);
	// #else
		Att = SpotAttenuation(attPrmsSpot);
	// #endif
		//---------------------------------------------------- 
		Att *= Att;

		sumColor.rgb += spotsLocal[j].diffuse.rgb * spotsLocal[j].diffuse.a * Att; //color * power * attenuation
		sumColor.a += Att;
	}

	return sumColor;
}

#endif