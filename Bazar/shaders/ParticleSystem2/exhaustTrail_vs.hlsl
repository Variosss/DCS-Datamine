(VS_INPUT i, uint vertId: SV_VertexId, uniform bool bClouds, uniform bool bLOD = false, uniform bool bGravitation=false)
{
	#define PARTICLE_POS	i.params1.xyz
	#define HEIGHT			i.params1.w

	#define EMITTER_SPEED	i.params2.x	
	#define OPACITY			i.params2.y
	#define BIRTH_TIME		i.params2.z
	//#define AGE				i.params1.w

	#define PARTICLE_VEL	i.params3.xyz
	#define LIFETIME		i.params3.w	
	
	#define SPIN_DIR		i.params4.x
	#define DISSIPATION_DIR i.params4.yzw
		
	const float nHeight = saturate(HEIGHT * HEIGHT / 100000000.0); //квадратичная нормализованная высота к 10км

	const float3 startVel = (bGravitation) ? PARTICLE_VEL*(0.20+0.8*pow(nHeight, 0.5)) : PARTICLE_VEL;
	const float3 dissipationDir = normalize(DISSIPATION_DIR);
	const float speed = length(startVel);

	const float RAND = noise1D(BIRTH_TIME*2);
	const float AGE = time-BIRTH_TIME;
	const float nSpeed = speed/277.75; //нормализуем к 1000км/ч
	const float nAge = AGE / LIFETIME;
#ifdef GROUND
	const float nConv = (bGravitation) ? (1-saturate(EMITTER_SPEED*3.6/100))*(0.1+0.9*pow(nHeight, 0.5)) : (1-saturate(EMITTER_SPEED*3.6/100));
	const float nConvInv = 1-nConv;
#endif
	const float3 startPos = PARTICLE_POS - worldOffset;
	
	// угол поворота текстурных координаты
#ifdef GROUND
	const float UVangle = -SPIN_DIR*log(AGE*(0.7+0.3*RAND)+0.2)*nConvInv*halfPI - RAND*PI2; // angle
#else
	const float UVangle = -SPIN_DIR*log(AGE*(0.7+0.3*RAND)+0.2)*halfPI - RAND*PI2; // angle
#endif

	//крутим вихрь вдоль вектора скорости
	float _sin, _cos;
	float vortexAngle = (SPIN_DIR*AGE*0.2 + RAND*0.05) * PI2;
	sincos( vortexAngle, _sin, _cos );

	//тащим по перлину
	static const float timeScale = 8;
	const float perlin = createPerlinNoise1D(BIRTH_TIME*timeScale);
	float2 perlinOffset = 1.5*( float2( perlin, createPerlinNoise1D(BIRTH_TIME*timeScale*1.1 + 0.1*RAND) ) - 0.5);
	perlinOffset = float2(perlinOffset.x*_cos - perlinOffset.y*_sin, perlinOffset.x*_sin + perlinOffset.y*_cos);

	float3 posOffset;

	const float nSpeed2 = max(0,nSpeed-0.1);
#ifdef GROUND
	posOffset.xz = distMax * (AGE*0.35) * perlinOffset * scaleBase * (0.05 + 0.95*nSpeed2) * nConvInv;//движение от вектора скорости
	posOffset.z +=  SPIN_DIR*AGE*(0.6 + 0.3*nConv + nSpeed2*2);//растаскиваем следы в стороны друг от друга 
#else
	posOffset.xz = distMax * (AGE*0.35) * perlinOffset * scaleBase * (0.05 + 0.95*nSpeed2);	
	posOffset.z +=  SPIN_DIR*AGE*(0.6 + nSpeed2*2);
#endif 

	//-------- скорость частицы вдоль вектора скорости ---------------
	const float offset = -2 * (1 + (speed - 55.556)/100 );
	const float xMin = exp(offset);
#ifdef GROUND
	posOffset.y = 2*(log(xMin+AGE*2)-offset) * scaleBase*(1+1*nConv) + nConv*AGE*(0.3+1.0*RAND);
#else
	posOffset.y = 2*(log(xMin+AGE*2)-offset) * scaleBase;
#endif 
	//----------------------------------------------------------------

	//строим СК по вектору скорости
	float3x3 speedBasis = {normalize(cross(startVel,dissipationDir)), startVel/speed, dissipationDir};

	//переводим партикл в МСК и прибавляем к стартовой позиции
#ifdef GROUND
	sincos( (vortexAngle + PI2*(perlin + RAND))*2, _sin, _cos );
	posOffset = startPos + mul(posOffset, speedBasis) + float3(_sin,0, _cos) * AGE * (1-0.8*RAND) * nConv*1.5;//дополнительно поркучиваем в горизонтальной плоскости мира
	posOffset.y += nConv * pow(abs(AGE*0.3),3)*(2.3*RAND - 0.2); 	//добавляем конвекцию в МСК
#else
	posOffset = startPos + mul(posOffset, speedBasis);
#endif

	if(bGravitation){
		posOffset.y -= AGE*AGE*9.8/2.0*1.2;
	}

	//масштаб частицы
	float scale = scaleBase;
#ifdef GROUND
	float scaleFadeIn = min(1, nAge*40*(1+nConvInv*nSpeed*4));
#else
	float scaleFadeIn = min(1, nAge*40*(1+nSpeed*4));
#endif
	scaleFadeIn = pow(abs(scaleFadeIn), 0.3);
	scale *= 1 + (7+3*nHeight)*pow(abs(AGE),0.65)*nSpeed + (1 + sin((RAND+AGE)*PI2)) * scaleFadeIn * (1+nHeight); //чем дольше живет, тем шире * чем меньше скорость тем медленнее нарастает толщина + рандомное масштабирование по синусу	scale *= 1 + 4*AGE*nSpeed + (1+sin((RAND+AGE)*PI2)) * scaleFadeIn; //чем дольше живет, тем шире * чем меньше скорость тем медленнее нарастает толщина + рандомное масштабирование по синусу
	
	
	//растягиваем по вектору скорости если надо	
	float speedAngle = pow(abs(dot(ViewInv._31_32_33, normalize(startVel))), 3);
	float speedStretch = 1 + (6 - 6*speedAngle) * max(0, 0.5-AGE) * pow(abs(0.4+0.6*nSpeed), 2); //добавил больше размытия на минимальной скорости

	//для зеркал ресуем 1 из 10 партиклов и уменьшаем прозрачность,
	// чтобы в таргете R10G11B10 при высокой прзрачности следа цвет дыма не уезжал в зеленый
	float lodFactor = bLOD? saturate((int)(vertId%10)-8) : 1;

	VS_OUTPUT o;
	o.params1 = float4(posOffset*lodFactor, UVangle);
	o.params2 = float4(startVel, scale*lodFactor);
	o.params3.x = speedStretch;

	//прозрачность партикла	=  fadeOut * общая альфа * (чем больше высота тем прозрачнее след)
	float opacity = saturate(OPACITY * opacityMax * (bLOD? 17 : 1));
#ifdef GROUND
	o.params3.y  = pow(abs(min(1, 1.3-1.3*nAge)), 1-0.5*nConv) *(0.5+0.5*(1-nHeight)) * opacity;
#else
	o.params3.y  = min(1, 1.3*(1-nAge)) * (0.5+0.5*(1-nHeight)) * opacity;
#endif
	if(bClouds)
		o.params3.y *= getAtmosphereTransmittanceLerp(0, nAge).r;//убиваем прозрачность партикла против альфы облаков

	//освещенность
	o.params3.z = getSunBrightness() * 0.4*gColorBrightness.w;
	o.params3.w = 2*step(0.5, RAND) - 1; 

	return o;
}