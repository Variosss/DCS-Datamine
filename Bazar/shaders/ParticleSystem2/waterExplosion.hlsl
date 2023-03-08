
[maxvertexcount(4*particlesCount)]
void GSname(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float3 startPos		= input[0].pos.xyz;
	float  age			= input[0].pos.w;
	float3 speedDir		= input[0].speed.xyz;
	float  speedValue	= input[0].speed.w; //*(0.5+power*0.5)
	float  nAge			= input[0].params.x;
	float  Rand			= input[0].params.y;

	PS_INPUT o;
	
#ifdef LOD
	o.params2 = 0;
#endif

	o.sunColor = getPrecomputedSunColor(0);

	[unroll]
	for(float i=0; i<particlesCount; i+=1.0f)
	{
		float param = sqrt(i/(particlesCount-1.0f)); //1 - вершина пика

		float uniqRand = noise1D(Rand+param);
		float uniqAge = min(1, nAge*(1+0.3*step(0.5, uniqRand)));

		o.params2.zw = float2(0.8*pow(nAge,0.3), (1-pow(uniqAge, 2-power/2.5f))*0.8);//смешнивание текстур партиклов / прозрачность
	#ifdef LOD
		o.params2.w *= 2.5;
	#endif

		float airResistance = 2+0.1*(1-param);

		float3 startSpeed = speedDir * speedValue;
		float2 speedValues =  float2( length(startSpeed.xz), startSpeed.y ) * (0.8+0.2*param);
		float2 trans = calcTranslationWithAirResistance(speedValues, 1*(0.9+0.1*power), airResistance, max(0,age));//увеличиваем коэффициент сопротивления для центральной части
		
		float3 offset = speedDir;
		offset.xz *= trans.x;
		offset.y = max(0,trans.y);
		offset.xz += float2(uniqRand-0.5, noise1D(Rand*param+5.3218325)-0.5) * (age*param*0.3*power);
		offset.xz += speedDir.xz * (saturate(1-offset.y/4) * nAge*(1-speedValue/speedMax)*5*(0.8+0.2*power));//сдвигаем от центра 

		float scale = 0.9*(1+3*pow(abs(nAge),2)) + (1-param)*4 +  param*pow(nAge, 2)*5;
		scale *= (0.3+0.7*power);
		
		float4x4 mBillboard = mul(billboard(startPos+offset, scale), gViewProj);
	#ifndef LOD
		float ang = (Rand+param*3.62174)*PI2+age*0.3*(step(0.5,uniqRand)*2-1)*2;
		float _sin, _cos;
		sincos(ang, _sin, _cos);
		o.params2.xy = float2(-_sin, _cos);//поворот нормалей
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