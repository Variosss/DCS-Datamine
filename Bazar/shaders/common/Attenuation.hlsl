#ifndef ATTENUATION_H
#define ATTENUATION_H

//		distance - distance between light source and position
//		range - defined range
//		vLight - vector to light (LightDirection - position)
//		theta, phi - attenuation angles of spot light source (cone)

float LightAttenuation(float distance, float range){
	float d = saturate(distance/range);
	return 1-d*d;
}

struct OmniAttenParams{
	float distance;
	float range;
};

float OmniAttenuation(const in OmniAttenParams at){
	return LightAttenuation(at.distance, at.range);
}

struct SpotAttenParams{
	float distance;
	float3 vLight;
	float3 vLightDirection;
	float range;
	float phi;
	float theta;
};

float SpotAttenuation(const in SpotAttenParams at){
	float alpha = dot(at.vLight, at.vLightDirection);
	float A = alpha > 0.0 ? smoothstep(at.phi, at.theta, alpha) * LightAttenuation(at.distance, at.range) : 0.0;
	return A;
}

#endif
