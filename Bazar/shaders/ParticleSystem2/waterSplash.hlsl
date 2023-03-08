[maxvertexcount(4*particlesCount)]
void GSSplash(point VS_OUTPUT_SPLASH input[1], inout TriangleStream<PS_INPUT_SPLASH> outputStream)
{
	float3 startPos		= input[0].pos.xyz;
	float  age			= input[0].pos.w;
	float3 speedDir		= input[0].speed.xyz;
	float  speedValue	= input[0].speed.w; //*(0.5+power*0.5)
	float  nAge			= input[0].params.x;
	float  Rand			= input[0].params.y;

	float  Radius		= input[0].params.z;

	float3 windSpeedDir = wind;
	//float3(0.3, 0.01, 0.2);
	float wndInf = 3;
	float3 startOffset = float3(0.0, 0.0, 0.0);
	PS_INPUT_SPLASH o;
	
#ifdef LOD
	o.params2 = 0;
#endif

	//o.v_id = input[0].v_id;
	o.sunColor = getPrecomputedSunColor(0);

	//o.sunDirM = float4(-getSunDirInNormalMapSpace(rotMatrix2x2(angle)), getHaloFactor(gSunDirV.xyz, posOffset, 10) * 0.21 * 0.7);

	[unroll]
	for(float i=0; i<particlesCount; i+=1.0f)
	{
		float param = sqrt(i/(particlesCount-1.0f)); //1 - ������� ����

		float uniqRand = noise1D(Rand+param);
		float uniqRand2 = noise1D(Rand+param*3.14);

		float uniqAge = min(1, nAge*(1+0.3*step(0.5, uniqRand)));

		o.params2.zw = float2(0.8*pow(nAge,0.3), (1-pow(uniqAge, 2-power/2.5f))*0.8);//����������� ������� ��������� / ������������
		
	#ifdef LOD
		o.params2.w *= 2.5;
	#endif

		float airResistance = 2+0.1*(1-param);

		float3 startSpeed = speedDir * speedValue;
		float2 speedValues =  float2( length(startSpeed.xz), startSpeed.y ) * (0.8+0.2*param);
		float3 offset = speedDir;
		float3 trans;
		float start_spray_age = 1.0;
		if (i < 1) {
			trans = calcTranslationWithAirResistanceSplash(startSpeed, 0.5, airResistance, max(0,age));
		}
		else {
			if (age < start_spray_age) {
				trans = startOffset;
			}
			else {
				float vSp = calcVerticalSpeed(1*startSpeed.y, 0.5, airResistance, start_spray_age);
				float3 startOffset2 = calcTranslationWithAirResistanceSplash(float3(calcHorisontalSpeed(startSpeed.x, 0.5, airResistance, start_spray_age), vSp, calcHorisontalSpeed(startSpeed.z, 0.5, airResistance, start_spray_age)), 0.5, airResistance, max(0,age - start_spray_age));

				float taau = clamp(age - start_spray_age, 0.0, 10.0);
				taau = 1.0 - taau;
				trans = calcTranslationWithAirResistanceSpray(startSpeed, 0.5, airResistance, max(0,age - start_spray_age));
				trans = startOffset;
			}
		}


		offset.y = max(0,trans.y);
		offset.xz = trans.xz;


		float scale = 1.0;
		if (i > 0) {
			o.id_particle = 1.0;
			float3 vel = noise3(startPos*i/particlesCount*3.14);
			vel.y /= 5.0;
			offset += (windSpeedDir+0.5*vel)*wndInf*uniqRand2*age;

			o.params2.w *= 0.62*clamp(offset.y, 0.0, 0.1)*3.0*calcNewOpacity(abs(age) , 3.0);

			scale *= clamp(age, 0.0, 0.5)*pow(abs(age),0.3)*10*clamp(offset.y/5.0, 0.0, 1.0)+2.0/max(age,1.0);
		}

		else {
			o.id_particle = 0.0;
			startOffset = offset;
			scale *= (0.3+0.7*power)*abs(1.0-Radius)*0.5;
			scale = 0.1;
			o.params2.w *= 0.0;
		}

		float4x4 mBillboard = mul(billboard(startPos+offset, scale), gViewProj);

	#ifndef LOD
		float ang = (Rand+param*3.62174)*PI2+age*0.3*(step(0.5,uniqRand)*2-1)*2;
		float _sin, _cos;
		sincos(ang, _sin, _cos);
		o.params2.xy = float2(-_sin, _cos);//������� ��������
	#endif

		[unroll]
		for (int i = 0; i < 4; ++i)
		{
			float4 vPos = {staticVertexData[i].x, staticVertexData[i].y, 0, 1};
		#ifndef LOD
			o.uv = float2( vPos.x*_cos - vPos.y*_sin, vPos.x*_sin + vPos.y*_cos ) + 0.5;
		#else
			o.uv = vPos.xy + 0.5;
		#endif

			o.pos = mul(vPos, mBillboard);
			outputStream.Append(o);
		}
		outputStream.RestartStrip();
	}
}
