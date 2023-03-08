[maxvertexcount(4*particlesCount)]
void GSTerrains(point VS_OUTPUT_SPLASH input[1], inout TriangleStream<PS_INPUT_TERRAINS> outputStream)
{
	float3 startPos		= input[0].pos.xyz;
	float  age			= input[0].pos.w;
	float3 speedDir		= input[0].speed.xyz;
	float  speedValue	= input[0].speed.w; //*(0.5+power*0.5)
	float  nAge			= input[0].params.x;
	float  Rand			= input[0].params.y;

	float  Radius		= input[0].params.z;

	float3 windSpeedDir = wind;
	float wndInf = 3;
	float3 startOffset = float3(0.0, 0.0, 0.0);
	PS_INPUT_TERRAINS o;
	
	o.v_id = input[0].v_id;

#ifdef LOD
	o.params2 = 0;
#endif

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

		trans = calcTranslationWithAirResistanceTerrains(1*startSpeed, 2.0, airResistance, max(0,age));


		offset.y = max(0,trans.y);
		offset.xz = trans.xz;


		float scale = 1.0;
			scale *= (0.3+0.7*power)*abs(1.0-Radius);
			scale *= 6.0*(log(nAge+0.1)-log(0.1));
			o.params2.w *= 2.0* calcNewOpacity(abs(age) , 5.0)*clamp(offset.y/10.0, 0.0, 1.0);
			float3 vel = noise3(startPos*i/particlesCount*3.14);
			vel.y /= 5.0;
			offset += (windSpeedDir+0.1*vel)*wndInf*uniqRand2*age;


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