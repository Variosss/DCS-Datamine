
VS_OUTPUT VS_shaderName(VS_INPUT i, uniform bool bNozzle, uniform bool bGRAVITATION=false, uniform bool bUnderWater=false)
{
	float3 PARTICLE_POS			= i.params1.xyz;
	float  BIRTH_TIME			= i.params1.w;
	float3 NOZZLE_SPEED			= i.params2.xyz;
	float  LIFETIME				= i.params2.w;
	float3 TANGENT				= i.params3.xyz; //w - ��������
	float2 DISSIPATION_DIR_ENC	= i.params4.xy; // encoded
	float2 WIND					= i.params4.zw;
	float3 PARTICLE_COLOR		= i.params5.rgb;
	
	VS_OUTPUT o;
	o.params3.w   = length(TANGENT);//�������� ��������
	o.params3.xyz = TANGENT/o.params3.w;//����������� � �������
	float3	speedResult;
	if(bNozzle)
		speedResult = normalize(NOZZLE_SPEED) * (length(NOZZLE_SPEED) + o.params3.w);
	else
		speedResult = TANGENT;

	const float		speedValue = length(speedResult);
	const float3	speedDir = speedResult/speedValue;
	const float		AGE = (effectTime - BIRTH_TIME);

	o.nAge = saturate(AGE / LIFETIME);
	//����������� ������ � �������
	float3 dir = float3(noise1D(BIRTH_TIME*0.01+phase*1.4213), 0.5, noise1D(BIRTH_TIME*0.016+0.23543+phase*0.36373))*2-1;	
	float3 posOffset = dir;

#ifdef MISSILE
	float param = pow(o.nAge, 0.8);
	posOffset.xz *= param * (1 - 0.7*saturate((o.params3.w-200)/400.0)) * dissipationFactor * 50 * (scaleBase / 4);
	/*
	//������ ����������� � ��������� ������������ ������� ��������
	float3 up = normalize(cross(dir, o.params3.xyz));
	float3x3 M = {normalize(cross(up, o.params3.xyz)), up, o.params3.xyz};
	float _sin, _cos;
	sincos(param*PI*0.5, _sin, _cos);
	float3x3 M2 = {
		1, 	0, 	  0,
		0,  _cos, _sin,
		0, -_sin, _cos};
	o.params3.xyz = mul(M, M2)._31_32_33;
	*/
#else
	float _sin, _cos;
	float turbulenceParam = smoothstep(0,5,AGE);
	float vortexAngle = (spinDir*(AGE*0.03 + turbulenceParam*0.4) + posOffset.x*0.05) * PI2;
	sincos( vortexAngle, _sin, _cos );
	posOffset.xz = float2(posOffset.x*_cos - posOffset.y*_sin, posOffset.x*_sin + posOffset.y*_cos) * dissipationFactor;
	posOffset.xz *= AGE*0.2 + turbulenceParam*0.5 * power;//��� ���������������	
#endif
	
#ifdef DEBUG_NO_JITTER	//if DEBUG
	posOffset = 0;
#endif
	posOffset *= podSmallSpeed;
	o.pos.xyz = PARTICLE_POS + mul(posOffset, basis(speedDir)).xyz + float3(WIND.x, 0, WIND.y)*AGE- worldOffset;
	
#ifndef MISSILE	
	float3 dissipationDir = decodeSMT(DISSIPATION_DIR_ENC.xyxx);
	o.pos.xyz += dissipationDir * (AGE*0.3 + smoothstep(0,1.0,AGE)*2)*spinDir;//������������ � �������
#endif
float nAge = o.nAge;
	


if(bGRAVITATION){
	o.pos.y -= AGE*AGE*9.8/2.0*pow(1.0-saturate(speedValue/50), 2.0)*0.35;
}

if(bUnderWater){
	float yrange = max((-PARTICLE_POS.y)-1, 0.0);
	o.pos.y += nAge*yrange;
}
	//o.pos.xyz = PARTICLE_POS + mul(posOffset, basis(speedDir)).xyz*0 + float3(WIND.x, 0, WIND.y)*AGE*0 - worldOffset;

	o.pos.w = asfloat(i.vertId);
	o.params1 = float4(PARTICLE_COLOR, BIRTH_TIME);
	o.params2 = float4(speedDir, speedValue); // tangent + speedValue
	
	DEBUG_SET_ZERO
	return o;
}
