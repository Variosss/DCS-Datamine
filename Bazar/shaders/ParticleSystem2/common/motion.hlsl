#ifndef _OPS_MOTION_HLSL
#define _OPS_MOTION_HLSL

//возвращает количество метров пройденное телом за время time с нулевой стартовой скоростью и с учетом сопротивления воздуха
float getFreefallWithAirResistance(in float mass, in float c, float time)
{
	return  (mass/c)*log(cosh(time/sqrt(mass/(9.80665*c))));
}

//перемещение частицы со стартовой скоростью под действием гравитации и с учетом сопротивления воздуха
float2 calcTranslationWithAirResistance(in float2 startSpeed, in float mass, in float c, in float time)
{
	const float g = 9.80665;
	float Vt = mass*g/c;
	float k = (1-exp(-g*time/Vt))*Vt/g;
	return float2( startSpeed.x*k, (startSpeed.y+Vt)*k - Vt*time );
}

//перемещение частицы со стартовой скоростью под действием гравитации и с учетом сопротивления воздуха
float3 calcTranslationWithAirResistance(in float3 startSpeed, in float mass, in float c, in float time)
{
	const float g = 9.80665;
	float Vt = mass*g/c;
	float k = (1-exp(-c*time/mass))*mass/c;
	return float3( startSpeed.x*k, (startSpeed.y+Vt)*k - Vt*time, startSpeed.z*k );
}

// transition = t*s0 + t*t*a*0.5
float3 calcTranslation_ConstAcceleration(float s0, float a, float t){
	return t*(s0 + a*0.5*t);
}

// transition = t*speed, speed = min(s0+t*a*0.5, maxSpeed)
float3 calcTranslation_ConstAcceleration_LimitedSpeed(float s0, float a, uniform float sMax, float t){
	float speed = min(s0 + a*0.5*t, sMax);
	return t*speed;
}

//без сопротивления по параболе
float3 calcTranslation(in float3 startSpeed, in float time)
{
	const float g = 9.80665;	
	return float3(startSpeed.x*time, startSpeed.y*time-g*time*time*0.5, startSpeed.z*time);
}

//перемещение частицы с постоянным торможением до нулевой скорости
float calcTranslationWithDeceleration(in float speedValue, in float deceleration, in float time)
{
	const float timeCap = min(time, speedValue/deceleration);
	return (speedValue - 0.5*deceleration*timeCap)*timeCap;
}
//перемещение частицы с постоянным торможением до нулевой скорости speed.xyz - направление, speed.w - величина скорости
float3 calcTranslationWithDeceleration(in float4 speed, in float deceleration, in float time)
{
	const float timeCap = min(time, speed.w/deceleration);
	return speed.xyz*(speed.w - 0.5*deceleration*timeCap)*timeCap;
}

#endif