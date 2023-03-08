#ifndef DIFFUSE_TERM_H
#define DIFFUSE_TERM_H

// Diffuse shader

//		vNormal - surface normal
//		vLightDir - light direction
//		vDiffuse - diffuse color
//		vLightColor - sun color
//		R - surface roughness
//		vView - view vector

struct dInput{
	float3 vNormal;
	float3 vLightDir;
	float3 vDiffuse;
	float3 vLightColor;
	float fLightPower;
	
#ifdef OREN_NAYAR
	float R;
	float3 vView;	
#endif

};

#ifdef LAMBERTIAN

float3 DiffuseTerm(in const dInput i){
	float D = saturate(dot(i.vNormal, i.vLightDir));
	return i.vDiffuse * D * i.vLightColor * i.fLightPower;
}

inline float LightDot(in float3 normal,in float3 dir)
{
	return saturate(dot(normal,dir));
}

#endif

#ifdef SOFT_DIFFUSE

float3 DiffuseTerm(in const dInput i){
	float D = dot(i.vNormal, i.vLightDir);
	D = pow(D * 0.5	+ 0.5, 2.0);
	return i.vDiffuse * D * i.vLightColor * i.fLightPower;
}

//только для солнца 
inline float LightDot(in float3 normal,in float3 dir)
{
	float D = dot(normal, dir);
	return pow(D * 0.5	+ 0.5, 2.0);
}

#endif

#ifdef OREN_NAYAR

float3 DiffuseTerm(in const dInput i){
	float LdotN = dot(i.vLightDir, i.vNormal);
	float VdotN = dot(i.vView, i.vNormal);
	
	float a = max(LdotN, VdotN);
	float b = min(LdotN, VdotN);
	
	float R = i.R * i.R;
	
	float A = 1.0 - 0.5 * (R / (R + 0.33));
	float B = 0.45 * (R /(R + 0.09));
	
	vec3 L_proj = i.vLightDir - i.vNormal * LdotN; 
	vec3 V_proj = i.vView - i.vNormal * VdotN;
	
	float3 final = i.vDiffuse * i.vLightColor * i.fLightPower;
	final *= LdotN * (A + B * max(0.0, dot(L_proj, V_proj)) * sin(a) * sin(b));
	
	return final;
}

///TODO оформить правильный вариант!!!
inline float LightDot(in float3 normal,in float3 dir)
{
	float D = dot(normal, dir);
	return pow(D * 0.5	+ 0.5, 2.0);	
}

#endif

#endif
