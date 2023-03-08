
#define cbuStartParticle	30u
#define cbuBranchSize		5u
static const float speedMax = 50.0;
static const float cbuBranchSizeInv	= 1.0 / (cbuBranchSize - 1);

void simulateCBU97(uint gi)
{
	if(sbParticles[gi].clusterLightAge.z < sbParticles[gi].sizeLifeOpacityRnd.y)
	{
		float age = sbParticles[gi].clusterLightAge.z;
		float nAge = age / sbParticles[gi].sizeLifeOpacityRnd.y;
		float effectOpacityFactor =  1 - max(0, nEffectAge-0.5)*2;
		float nDist = length(sbParticles[gi].posRadius.xz) / puffRadius;
		float2 dir = normalize(sbParticles[gi].posRadius.xz);

		float Rand = sbParticles[gi].sizeLifeOpacityRnd.w;
		float param = sbParticles[gi].reserved.w * cbuBranchSizeInv;
		float3 speedDir = sbParticles[gi].reserved.xyz;
		float speedValue = sbParticles[gi].sizeLifeOpacityRnd.w * speedMax;
		
		float power = 1;

		float popupFactor = saturate(10*(age-0.2*nDist));
		float opacityFactor = saturate(2*age)*(1-nDist*0.5);


		// float param = i/(particlesCount-1.f); //1 - вершина пика
		param = pow(param,0.5);

		float uniqRand = noise1D(Rand+param);
		float uniqAge = min(1,nAge*(1+0.3*step(0.5,uniqRand)));
		float airResistance = 2.5+0.1*(1-param);
		float3 startSpeed = speedDir * speedValue;
		float2 speedValues =  float2( length(startSpeed.xz), startSpeed.y ) *(0.8+0.2*param);
		float2 trans = calcTranslationWithAirResistance(speedValues, 1*(0.9+0.1*power), airResistance, max(0,age));//увеличиваем коэффициент сопротивления для центральной части

		float3 offset = speedDir;
		offset.xz *= trans.x;
		offset.y = max(-3,trans.y) + 2;

		offset.xz += float2(uniqRand-0.5, noise1D(Rand*param+5.3218325)-0.5)*age*param*0.3*power;
		offset.xz += speedDir.xz*pow(saturate(1-offset.y/4), 1)*nAge*(1-speedValue/speedMax)*5*(0.8+0.2*power);//сдвигаем от центра 

		float scale = 0.9*(1+3*pow(abs(nAge),2)) + (1-param)*4 + param*pow(nAge, 2)*5;
		scale *= (0.3+0.7*power);


		// sbParticles[gi].posRadius.xz += dir * dT * 0.45 * sbParticles[gi].sizeLifeOpacityRnd.w;
		sbParticles[gi].posRadius.xyz = offset;
		sbParticles[gi].posRadius.xz += windDir * age * sbParticles[gi].posRadius.y * mad(sbParticles[gi].sizeLifeOpacityRnd.w, 0.8, 0.2);

		sbParticles[gi].sizeLifeOpacityRnd.x += dT*1;	// scale
		// sbParticles[gi].sizeLifeOpacityRnd.x = scale;	// scale
		sbParticles[gi].sizeLifeOpacityRnd.z = opacityFactor * saturate((1-nAge)*1.5) * 0.8 * effectOpacityFactor; // opacity

		sbParticles[gi].mToWorld = getCircleVortexRotation(sbParticles[gi].mLocalToWorld, sbParticles[gi].posRadius.xyz, sbParticles[gi].ang);
		sbParticles[gi].ang += dT*3 / (1 + 0.25*sbParticles[gi].clusterLightAge.z);
	}
	else if(emitterTime < effectLifetime*0.3)
	{	//new
		float uniqueKey = gModelTime + gi*0.7927153927;
		float4 rnd = noise4(uniqueKey.xxxx + float4(0, 1.272136, 1.642332, 0.6812683));
		
		float2 sc;
		sincos(rnd.y*6.28, sc.x, sc.y);

		initParticle( gi,
			float3(sc.x*0.1, rnd.z*0.4*(1-0.9*rnd.w)*10, sc.y*0.1)*(1+(puffRadius-1)*rnd.w),//position
			2.5,//size
			effectLifetime*(0.5 + rnd.x*0.45),//lifetime
			rnd.w*45.125481//angle
			);

		uint branchId = (gi - cbuStartParticle) / cbuBranchSize;
		uniqueKey = gModelTime + branchId*2.38273351;
		float3 dir = noise3(uniqueKey.xxx + 3.21*float3(0.321, 1.85624, 1.2643));
		dir.xz = dir.xz*2-1;
		dir.y = 2*dir.y + 0.7;
		dir = normalize(dir);
		sbParticles[gi].reserved.xyz = dir;
		sbParticles[gi].reserved.w = (gi - cbuStartParticle) % cbuBranchSize; //id
	}
}

//CBU-97 | CBU-105
[numthreads(THREAD_X, THREAD_Y, 1)]
void csUpdateCBU97(uint gi : SV_GroupIndex)
{
	sbParticles[gi].clusterLightAge.z += dT;
	[branch]
	if(gi<cbuStartParticle){
		simulateGroundPuff(gi, 0.0);
	} else {
		simulateCBU97(gi);
	}
}

technique11 techUpdateCBU97
{
	pass { SetComputeShader( CompileShader( cs_5_0, csUpdateCBU97() ) ); }
}
