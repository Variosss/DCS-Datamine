#ifndef SPECULAR_TERM_H
#define SPECULAR_TERM_H

// Specular shader

struct sInput{
	float3 vSpecColor;
	float3 vNormal;
	float3 vView;
	float3 vLightDirection;
	float fSpecFactor;
	float fSpecPower;
	float3 vLightColor;
	float fLightPower;
	
#ifdef COOK_TORRANCE
	float R;
#endif

};

#ifdef PHONG

float3 SpecTerm(const in sInput i){
	float3 R = reflect(-i.vLightDirection, i.vNormal);
	float RdotV = max(0, dot(R, i.vView));
    float3 S = i.vSpecColor * pow(RdotV, (i.fSpecFactor + 0.0001)) * i.fSpecPower;
    return S * i.vLightColor * i.fLightPower;
}

#endif

#ifdef BLINN_PHONG

float3 SpecTerm(const in sInput i){
    float3 H = normalize(i.vLightDirection + i.vView);
	float HdotN = max(0, dot(H, i.vNormal));
    float3 S = i.vSpecColor * pow(HdotN, (i.fSpecFactor + 0.0001)) * i.fSpecPower;
	return S * i.vLightColor * i.fLightPower;
}
	
#endif

#ifdef TROWBRIDGE_REITZ

float3 SpecTerm(const in sInput i){
    float3 H = normalize(i.vLightDirection + i.vView);
	float HdotN = dot(H, i.vNormal);	
	float a2 = i.fSpecFactor*i.fSpecFactor;	
	return i.vLightColor * i.fSpecPower * a2 / (3.14*pow(HdotN*HdotN *(a2-1)+1, 2));
}
#endif

#ifdef WARD_ISOTROPIC

//асфальт, бетон, металл
float3 SpecTerm(const in sInput i)
{
    // const float k = 10.0;//шероховатость
	const float k = i.fSpecFactor;

    float3 H = normalize(i.vLightDirection + i.vView);
	float HdotN = dot(H, i.vNormal);
	float HdotN2 = HdotN * HdotN;	
 
	float3 S = i.vSpecColor * exp( -k * (1.0 - HdotN2) / HdotN2 ) * i.fSpecPower;
	
	return S * i.vLightColor * i.fLightPower;
}
	
#endif

#ifdef COOK_TORRANCE

float3 SpecTerm(const in sInput i){
    float3 H = normalize(i.vLightDirection + i.vView);
    
    float NdotH = max(dot(H, i.vNormal), 1.0e-7);
    float VdotH = saturate(dot(H, i.vView));
    float NdotV = saturate(dot(i.vNormal, i.vView));
    float NdotL = saturate(dot(i.vNormal, i.vLightDirection));
    
    float G = 2.0 * NdotH / VdotH;
    G = G * min(NdotV, NdotL);

	float r2 = i.R * i.R;
	float NdotH_sq = NdotH * NdotH;
	float NdotH_sq_r = 1.0 / (NdotH_sq * r2);
	float roughness_exp = (NdotH_sq - 1.0) * ( NdotH_sq_r );
	float D = exp(roughness_exp) * NdotH_sq_r / (4.0 * NdotH_sq );

	float F = 1.0 / (1.0 + NdotV);

	float Rs = (F * G * D) / (NdotV * NdotL + 1.0e-7);
    
    return NdotL * i.vSpecColor * Rs * i.vLightColor * i.fLightPower * i.fSpecPower;
}

#endif

#endif
