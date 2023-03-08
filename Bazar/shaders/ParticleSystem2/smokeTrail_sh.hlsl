#define quote(x)			#x
#define ADD_POSTFIX(a, b)	a##b
// #define GEN_NAME(name)		ADD_POSTFIX(name, postfix)
#define GEN_NAME(name)		ADD_POSTFIX(ADD_POSTFIX(name, postfix), techPostfix)

#define techName			GEN_NAME(tech)
#define VS_shaderName		GEN_NAME(VS)
#define HSconst_shaderName	GEN_NAME(HSconst)
#define HS_shaderName		GEN_NAME(HS)
#define DS_shaderName		GEN_NAME(DS)
#define GS_shaderName		GEN_NAME(GS)
#define GS2_shaderName		GEN_NAME(GS2)
#define PS2_shaderName		GEN_NAME(PS2)
#define PS_shaderName		GEN_NAME(PS)
#define PS_shaderName_flir		GEN_NAME(PS_FLIR)
#define PS2_shaderName_flir		GEN_NAME(PS2_FLIR)

#include "smokeTrail_vs.hlsl"
#include "smokeTrail_gs.hlsl"

/////////////////////////////////////////////////////////////////
//////////////////// HULL SHADER ////////////////////////////////
/////////////////////////////////////////////////////////////////

HS_PATCH_OUTPUT2 HSconst_shaderName(InputPatch<VS_OUTPUT, 2> ip)
{
	#define POS_MSK(x)	ip[x].pos.xyz
	#define TANGENT(x)	ip[x].params3.xyz

	float len = distance(POS_MSK(0), POS_MSK(1));
	float isFirstSegment = asuint(ip[0].pos.w) == 1;
	
	//TODO: �������� ��� ����������� lodMax ��� ���� � low �������
	#ifdef MISSILE
		float lod = max(1, (lodMax + 0.9999) * (1 - ip[0].nAge * ip[0].nAge) );
	#else
		float lod = max(1, (lodMax + 0.9999) * (1 - pow(max(0,ip[0].nAge), 1.1)) );
	#endif
	HS_PATCH_OUTPUT2 o;
	float particlesPerSegment = round(exp2(floor(lod)));//2,4,8...
	
	//������� ������ �������� � ������ �������, � ��������� ������ �� ���������
	o.edges[0] = 1; // detail factor
	o.edges[1] = round(clamp((particlesPerSegment * min(1, len*segmentLengthInv) - 1.0), 1.0, 63.0)); //��������� �� 1 ������ ��� ��������� - 1,3,7...
	
	float particlesInSegmentReal = floor(o.edges[1] + 1.0);
	float maxParticlesInSegment = exp2(lodMax);
	o.p1.w = 1 - frac(lod);
	// o.p2.w = round(exp2(floor(lodMax + 0.9999 - lod)));
	o.p2.w = round(maxParticlesInSegment/particlesInSegmentReal);
	
	//�����������
	const float coef = -0.33 * len;
	o.p1.xyz = POS_MSK(0) - TANGENT(0)*coef;
	o.p2.xyz = POS_MSK(1) + TANGENT(1)*coef;

	//x - ����������, y - ������ ��������� ��� ��� ��������������
	o.orderOffset.x = step( length(POS_MSK(0)-gViewInv._41_42_43), length(POS_MSK(1)-gViewInv._41_42_43) );
	o.orderOffset.y = o.edges[1] / (o.edges[1] + 1.0);
	
#ifndef LOD
	//������� ��������� ��� ��������� t, ����� ��� ��������� ������� �������� 
	//������������ � ��� ������� ��������� �� �������������, � ���������� �� �����
	float distBetweenParticles = 1.0 / ((particlesPerSegment) * segmentLengthInv);//�������� ��������� ����� ���������� � ��������
	o.orderOffset.y *= isFirstSegment ? (o.edges[1]+1) * distBetweenParticles / max(distBetweenParticles, len) : 1.0;
#endif
	return o;
	#undef POS_MSK
	#undef TANGENT
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(2)]
[patchconstantfunc(quote(HSconst_shaderName))]
VS_OUTPUT HS_shaderName(InputPatch<VS_OUTPUT, 2> ip, uint id : SV_OutputControlPointID)
{
	VS_OUTPUT o;
	o = ip[id];
	return o;
}
/////////////////////////////////////////////////////////////////
//////////////////// DOMAIN SHADER //////////////////////////////
/////////////////////////////////////////////////////////////////
//����� ��� ����� ���
[domain("isoline")]
DS_OUTPUT DS_shaderName(HS_PATCH_OUTPUT2 input, OutputPatch<VS_OUTPUT, 2> op, float2 uv : SV_DomainLocation, uniform bool bNozzle)
{
	#define POS_MSK(x)			op[x].pos.xyz
	#define SPEED_DIR_VALUE(x)	op[x].params2
	#define SPEED_DIR(x)		op[x].params2.xyz
	float LOD_PARAM				= input.p1.w;
	float VERTEX_FREQUENCY		= input.p2.w;
	
	DS_OUTPUT o;
#ifndef LOD
	//���������
	float t = lerp(uv.x, 1.0 - uv.x, input.orderOffset.x);
	float vertexId = round(t*input.edges[1]); //id ��������������� �������
	t *= input.orderOffset.y; //�������� �������, ����� ������ � ��������� ������� �������� ��������� �� ������������� + ����� �������� � ������ �������� �� ������� 
#else
	float t = uv.x;
	float vertexId = 0;
#endif
	
	//���������� �������� ��� �������� � ����������� �� ������� �������� � Id �������� � ������ ����
	float uniqParam = op[0].params1.w*10 + round(vertexId * VERTEX_FREQUENCY);
	
	o.params1 = lerp(op[0].params1, op[1].params1, t);//COLOR, birthTime
	const float birthTime = o.params1.w;
	const float AGE = max(0, effectTime - o.params1.w);
	
	//����������������� ������� � ���
	float3 pos = BezierCurve3(t, POS_MSK(0), input.p1.xyz, input.p2.xyz, POS_MSK(1));

	const float nAge = lerp(op[0].nAge, op[1].nAge, t) / (0.2+0.8*noise1D(0.5123*phase + uniqParam*0.35127));
	o.params1.w = max(0, 1 - nAge);
	
	// ����������������� �����������(������ ��������) + �������� �������� � ���
	float4 emitterSpeed	 = lerp(op[0].params3, op[1].params3, t);//����������� � �������� ��������
	float  emitterSpeedValue = emitterSpeed.w;//�������� ��������
	float4 speedDirValue = lerp(SPEED_DIR_VALUE(0),	SPEED_DIR_VALUE(1),	 t);//����������� � �������� � ������ ����� (���� ��� ����), ����� == emitterSpeed
	speedDirValue.xyz = normalize(speedDirValue.xyz);
	
	//--------------------------------------------------------------------------
#ifndef DEBUG_NO_JITTER2
	float4 speedResult = speedDirValue;
	if(bNozzle)
		//����� ������� �������� ����� ����� ������������ � ������� missleFlame.fx!!!
		pos += speedDirValue.xyz * (translationWithResistance(speedDirValue.w, AGE) * lerp(0.75, 0.15, min(1, emitterSpeedValue*(1.0/1000))) * mad(scaleBase, 0.267, 0.2));
	else
		pos += speedDirValue.xyz * (translationWithResistanceSimple(speedDirValue.w, AGE) * 0.5);
#endif
	o.params3.xyz = lerp(speedDirValue.xyz, normalize(-emitterSpeed.xyz), 1-exp(-AGE*5));
	//o.params3.xyz = (1.0 - podSmallSpeed)*float3(0.0, 1.0, 0.0)+podSmallSpeed*o.params3.xyz;
	o.params3.w = speedDirValue.w;
	//--------------------------------------------------------------------------
	//o.params4.x = effectTime-o.params1.w;
	o.params4.x = 0.0;
	float nScale = scaleBase*0.5;
#if !defined(LOD) && !defined(DEBUG_NO_JITTER)
	float4 RAND = noise4(float4(1.27193, 2.87363, 3.17359, 0.742952)*phase + uniqParam);
	RAND.xyz = RAND.xyz*2-1;
	
	//������� ������� � ��� + ��������� ��������� ��������
	#ifdef MISSILE
		float p = smoothNoise1(birthTime*80);
		o.pos.xyz = pos + RAND.xyz * (p * pow(nAge,0.6)  * mad(nScale,0.7,0.3) * power * dissipationFactorBase);
	#else
		o.pos.xyz = pos + podSmallSpeed*RAND.xyz * ((nAge + smoothstep(0, 5.5, AGE)*0.5) * mad(nScale,0.7,0.3) * power * dissipationFactorBase);
	#endif
#else
	o.pos.xyz = pos;
	float4 RAND = {0,0,0, 0.5};
#endif
	//o.pos.xyz = pos;
	float vertId = (float)asuint(op[0].pos.w) + vertexIdOffset;// �������� vertId
	o.pos.w = op[0].pos.w;
	//o.pos.xyz = pos;
	//���������� �������� ����� ������� ��������
#ifdef MISSILE
	float nSpeed = min(1, emitterSpeedValue*(1.0/400));
	float stretchParam = max(0,1-AGE*0.25) * mad(nSpeed,0.6,0.4);
#else
	float nSpeed = min(1, emitterSpeedValue*(1.0/200));
	float stretchParam = max(0,1-nAge*0.25) * mad(nSpeed,0.6,0.4);
#endif
	float speedAngle = pow(abs(dot(ViewInv._31_32_33, speedDirValue.xyz)), 3);
	float speedStretch = (6 - 6*speedAngle) * stretchParam * stretchParam * rcp( mad(nScale,0.5,0.5));
	float speedStretch1 = 1 + speedStretch;
	
#if !defined(MISSILE) && !defined(DEBUG_NO_JITTER2)
	//�������� ���� ���� ����� ����� ������� �������� ����� ������� �����, ����� �������� ���������
	//�������� �� ��������� �� �������������� ��� �����
	o.pos.xyz -= speedResult.xyz * (speedStretch*0.2);
#endif

	float fadeInOpacity = min(1, AGE * mad(emitterSpeedValue,0.9,0.1) * fadeInInv * rcp( mad(nScale,0.8,0.2)) );
	float fadeBySpeedStretch = 1 - stretchParam*0.6;
	
#ifdef DEBUG_NO_FADEIN
	fadeInOpacity = 1;
#endif
	
#ifndef LOD
	#ifndef LOW
	const float opacityMax = 0.4;// ������������ �������������� HIGH
	#else
	const float opacityMax = 1;// ������������ �������������� LOW
	#endif
	
	//������ ������ ������� � �������� ����� � ����������� �� LOD_PARAM
	float lodOpacity =  1 - (uint(vertexId) & 0x01)* LOD_PARAM;
	float AGE08 = pow(AGE, 0.8);
	
	o.params2.y = fadeInOpacity * opacityMax * fadeBySpeedStretch * lodOpacity * saturate(6 - 6*((vertId+segmentParam)*vertexCountInv));// opacity

	#ifdef MISSILE
		float baseScale = 1.5 * scaleBase * (1 + mad(RAND.w,7.5,7.5)*nAge);// ���������� ������� ������ �� �������
		o.params2.x = ( 0.3*AGE08*RAND.x + RAND.y*0.6 )*PI2;//���� �������� �������� ��������
	#else
		float baseScale = step(nAge, 1.0)*0.6 * scaleBase * (1 + mad(RAND.w,3,3)*pow(AGE*sideSpeed, 0.7));// ���������� ������� ������ �� �������
		//baseScale = lerp(step(nAge, 1.0)*0.6 * scaleBase * (1 + mad(RAND.w,3,3)*pow((nAge+0.1*min(1.0, nAge*100))*sideSpeed*8.0, 0.7)), baseScale, podSmallSpeed);
		o.pos.y += (RAND.w-0.15)*AGE08*2.5 * mad(nScale,0.5,0.5);
		o.params2.x = ( 0.08*AGE08*RAND.x + RAND.y*0.6 )*PI2;//���� �������� �������� ��������
		o.params2.x = lerp(0, o.params2.x, podSmallSpeed);
		o.params2.y *= 1.0 - smoothstep(0.9, 1.0, min(nAge, 1.0));
	#endif
	
	//o.params2.y = fadeInOpacity * opacityMax * fadeBySpeedStretch * lodOpacity * saturate(6 - 6*((vertId+segmentParam)*vertexCountInv));// opacity
	//���������� ������������ ��������� ������� ����� ������
	float opacityFactor = min(0.85, saturate(3*(RAND.w-0.5)) * AGE * 0.25 );
	o.params2.y *= 1 - opacityFactor*opacityFactor;
	const float fadeOutRange = 1.0/400.0;
	float2 fadeByHeight = (float2(o.pos.y, -o.pos.y) + fadingHeights.xy) * float2(fadingHeights.z, fadeOutRange);
	o.params2.y *= saturate(fadeByHeight.x*fadeByHeight.y);
	o.params2.y *= gOpacity;

	
#else//if LOD
	#ifdef MISSILE
		const float opacityMax = 0.2;// ������������ �������������� LOD
		//float baseScale = 1.1 * scaleBase * (1 + 2.5*pow(AGE*sideSpeed, 0.6));

		float baseScale = 0.8 * scaleBase * (1 + 2.0*pow(nAge*10.0*sideSpeed, 0.7));
		o.params2.x = 0;
		o.params2.y = saturate(fadeInOpacity * opacityMax * (1-speedStretch1*rcp(6+nScale)) * (1-nAge*0.1) * saturate(10 - 10*((vertId+segmentParam)*vertexCountInv)));
		//baseScale = 0.5* scaleBase * (1 + 2.5*pow(AGE*sideSpeed, 0.6));
	#else
		const float opacityMax = 0.4;// ������������ �������������� LOD
		float baseScale = step(nAge, 1.0)* 0.8 * scaleBase * (1 + 3*pow(AGE*sideSpeed, 0.7));
		//baseScale = lerp(step(nAge, 1.0)*0.6 * scaleBase * (1 + mad(RAND.w,3,3)*pow((nAge+0.1)*sideSpeed*8.0, 0.7)), baseScale, podSmallSpeed);

		//o.pos.y += (RAND.w-0.15)*AGE08*2.5 * mad(nScale,0.5,0.5);

	
		//baseScale = 0.5 * scaleBase * (1 + 8*pow((AGE)*sideSpeed, 0.6));
		//baseScale = 1.1* scaleBase * (1 + 8*pow(nAge*sideSpeed*10+2.0, 0.7));
		//baseScale = pow(saturate(3*nAge-0.4)+0.1, 1.0)*150*scaleBase*pow(sideSpeed, -0.6); //default

		//baseScale = pow(saturate(0.6*nAge-0.4)*pow(sideSpeed, -1.0)+0.2, 0.5)*100*scaleBase; //contrail

		//baseScale = pow(saturate(0.6*nAge-0.4)*pow(sideSpeed, -1.0)+0.2, 1.0)*200*scaleBase; 
		o.params2.x = 0;
		
		//o.params2.y = saturate(fadeInOpacity * opacityMax * (1-speedStretch1*rcp(6+nScale)) * (1-AGE*0.01*0.5) * saturate(10 - 1*((vertId+segmentParam)*vertexCountInv)));

		//o.params2.y = saturate(fadeInOpacity* opacityMax *5* (1-speedStretch1*rcp(6+nScale)) * (1-AGE*0.01*0.5) * saturate(10 - 1*((vertId+segmentParam)*vertexCountInv)));


		//o.params2.y = fadeInOpacity * opacityMax * fadeBySpeedStretch * 2 * saturate(6 - 6*((vertId+segmentParam)*vertexCountInv));
		//o.params2.y = saturate(fadeInOpacity * opacityMax * 50 * (1-speedStretch1*2*rcp(3+nScale)) * (1-nAge*0.5) * saturate(10 -1*((vertId+segmentParam)*vertexCountInv)+0.1));

		//o.params2.y = 1.0;
		
		//o.params2.y = fadeInOpacity * opacityMax * fadeBySpeedStretch *(saturate (1-nAge*0.5)+0.2) * saturate(10 - 2*((vertId+segmentParam)*vertexCountInv));

		o.params2.y = saturate(0.4*fadeInOpacity * opacityMax * (1-speedStretch1*rcp(6+nScale)) * (1-AGE*0.01*0.5) * saturate(8 - 8*((vertId+segmentParam)*vertexCountInv)));
		o.params2.y *= 1.0 - smoothstep(0.9, 1.0, min(nAge, 1.0));

		//o.params2.y = 1;
		//o.params2.y = 0.7;
		//baseScale = (AGE-0.1)*9.0;
		//baseScale = scaleBase*5*pow((AGE-0.2)*sideSpeed, 0.5);
		//baseScale = 1.0* scaleBase * (1 + 5*pow(nAge*50*sideSpeed, 0.6));
	#endif
		//const float fadeOutRange = 1.0/400.0;
		//float2 fadeByHeight = (float2(o.pos.y, -o.pos.y) + fadingHeights.xy) * float2(fadingHeights.z, fadeOutRange);
		//o.params2.y *= saturate(fadeByHeight.x*fadeByHeight.y);
		o.params2.y *= gOpacity;
	
	
#endif
	
	// float curHeight = o.pos.y;
	// o.params2.y *= saturate((curHeight - fadingHeight.x)*fadingHeight.z);
	// o.params2.y *=  pow(saturate((fadingHeights.y - curHeight)/300.f), 2);
	baseScale *= mad(power, 0.5, 0.5);

#ifdef DEBUG_FIXED_SIZE
	baseScale = DEBUG_FIXED_SIZE;
#endif
	
	o.params2.z = baseScale*(1.0+(lifeScaleFactor-1.0)*saturate(pow(nAge, lifeScalePow)));
	o.params3.w = speedStretch1;

#ifdef DEBUG_OUTPUT
	o.debug = op[0].debug;
	o.debug.x = vertexId;
	o.debug.y = uniqParam;
#endif

	#undef SPEED_DIR_VALUE
	#undef POS_MSK
	#undef SPEED_DIR
	return o;
}
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

float4 PS_shaderName(PS_INPUT_PARTICLE i, uniform bool bAtmosphere) : SV_TARGET0
{
	float3 UVW				= i.params.xyz;
	float nAgeInv			= i.params.w; // 1 - ������, 0 - �����
	float3 SPEED_PROJ		= i.params2.xyz;
	float OPACITY			= i.params2.w;
	float2 UVparticle		= i.params3.xy;
	float2 sinCos			= i.params3.zw;
	float3 PARTICLE_COLOR	= i.posW.rgb;
	float HALO_FACTOR		= i.posW.w;
	uint VERT_ID			= i.vertId;
	float alpha 			= i.alpha.x*max((1.0-2.0*abs(i.alpha.y)), 0.0);
	/*
	#ifdef LOD
		OPACITY *= abs(i.pos.z)*100000;
	#endif
	*/

	float thres_z = -0.2;

	float b = (thres_z+1.0)/2.0;
	float a = 1/(1- b);

	//OPACITY *= 1.0 - ((max(i.pos.z, thres_z)+1.0)/2.0 -b)*a;
#ifdef LOD
	//OPACITY *= 1.0 -  smoothstep(0.0, 1.0, 1.5*i.pos.w/100000.0);
#endif
	//������� + �����
	float4	normSphere	= normalSphereTex.Sample(ClampLinearSampler, UVparticle);
	normSphere.a *= mad(nAgeInv, 0.5, 0.5); clip(normSphere.a-0.06);
	normSphere.xyz = normalize(normSphere.xyz*2-1);//���������
#ifdef DEBUG_RENDER
	return debugOutput(i);
#endif

	float3 sunColor = getPrecomputedSunColor(VERT_ID);
	
	//�������������� ������ ��� �����
	float	alphaSlow = noiseTex.Sample(WrapLinearSampler, UVW).r;
	float4	finalColor = float4(PARTICLE_COLOR, lerp(alphaSlow, 1, pow(nAgeInv, 4)) * normSphere.a);

#if defined(PS_NORMAL_LIGHT) && !defined(DEBUG_NO_LIGHTING)
	float3 norm = alignNormalToDirection(normSphere.xyz, sinCos, SPEED_PROJ);
	float NoL = max(0, dot(norm,  gSunDir)*0.5 + 0.5);
	NoL = lerp(1, pow(NoL, 0.7), pow(finalColor.a, 0.36) );
	sunColor *= NoL;
#endif

	finalColor.a *= OPACITY;


#if defined(PS_HALO) && !defined(DEBUG_NO_HALO)
	finalColor.rgb = shading_AmbientSunHalo(finalColor.rgb, AmbientAverage, sunColor/PI, HALO_FACTOR * (1 - min(1, 6*finalColor.a)) );
#else
	finalColor.rgb = shading_AmbientSun(finalColor.rgb, AmbientAverage, sunColor/PI);
#endif

	if(bAtmosphere)
		return float4(applyPrecomputedAtmosphereLerp(finalColor.rgb, VERT_ID, 1-nAgeInv), alpha*finalColor.a);

	return float4(finalColor.rgb, alpha*finalColor.a); 
}


float4 PS_shaderName_flir(PS_INPUT_PARTICLE i, uniform bool bAtmosphere) : SV_TARGET0
{
	float3 UVW				= i.params.xyz;
	float nAgeInv			= i.params.w; // 1 - ������, 0 - �����
	float3 SPEED_PROJ		= i.params2.xyz;
	float OPACITY			= i.params2.w;
	float2 UVparticle		= i.params3.xy;
	float2 sinCos			= i.params3.zw;
	float3 PARTICLE_COLOR	= i.posW.rgb;
	float HALO_FACTOR		= i.posW.w;
	uint VERT_ID			= i.vertId;

	float alpha 			= i.alpha.x;
	/*
	#ifdef LOD
		OPACITY *= abs(i.pos.z)*100000;
	#endif
	*/

	float thres_z = -0.2;

	float b = (thres_z+1.0)/2.0;
	float a = 1/(1- b);

	//OPACITY *= 1.0 - ((max(i.pos.z, thres_z)+1.0)/2.0 -b)*a;
#ifdef LOD
	OPACITY *= 1.0 -  smoothstep(0.0, 1.0, 1.5*i.pos.w/100000.0);
#endif
	//������� + �����
	float4	normSphere	= normalSphereTex.Sample(ClampLinearSampler, UVparticle);
	normSphere.a *= mad(nAgeInv, 0.5, 0.5); clip(normSphere.a-0.06);
	normSphere.xyz = normalize(normSphere.xyz*2-1);//���������
#ifdef DEBUG_RENDER
	return debugOutput(i);
#endif

	float3 sunColor = getPrecomputedSunColor(VERT_ID);
	
	//�������������� ������ ��� �����
	float	alphaSlow = noiseTex.Sample(WrapLinearSampler, UVW).r;
	float4	finalColor = float4(PARTICLE_COLOR, lerp(alphaSlow, 1, pow(nAgeInv, 4)) * normSphere.a);

#if defined(PS_NORMAL_LIGHT) && !defined(DEBUG_NO_LIGHTING)
	float3 norm = alignNormalToDirection(normSphere.xyz, sinCos, SPEED_PROJ);
	float NoL = max(0, dot(norm,  gSunDir)*0.5 + 0.5);
	NoL = lerp(1, pow(NoL, 0.7), pow(finalColor.a, 0.36) );
	sunColor *= NoL;
#endif

	finalColor.a *= OPACITY;

	float l = max(luminance(finalColor.rgb)*1.2, 1.0);
	return float4(l, l, l, finalColor.a);


	if(bAtmosphere)
		return float4(applyPrecomputedAtmosphereLerp(finalColor.rgb, VERT_ID, 1-nAgeInv), i.alpha.x*finalColor.a);

	return float4(finalColor.rgb, i.alpha.x*finalColor.a); 
}

float4 PS2_shaderName(PS_INPUT_PARTICLE i, uniform bool bClouds) : SV_TARGET0
{
	float3 UVW				= i.params.xyz;
	float nAgeInv			= i.params.w; // 1 - ������, 0 - �����
	float3 SPEED_PROJ		= i.params2.xyz;
	float OPACITY			= i.params2.w;
	float2 UVparticle		= i.params3.xy;
	float2 sinCos			= i.params3.zw;
	float3 PARTICLE_COLOR	= i.posW.rgb;
	float HALO_FACTOR		= i.posW.w;
	uint VERT_ID			= i.vertId;

	float thres_z = -0.2;

	float b = (thres_z+1.0)/2.0;
	float a = 1/(1- b);

	OPACITY *= 1.0 - ((max(i.pos.z, thres_z)+1.0)/2.0 -b)*a;

	float4 data = normalSphereTex.Sample(gTrilinearClampSampler, UVparticle);  // normal + alpha
	data.xyz = data.xyz * 2 - 1.0;// convert from compressed format [0, 255] -> [-1.0, 1.0]
	//������� + �����
	float3 sunColor = getPrecomputedSunColor(0);

	//PARTICLE_COLOR = float3(1.0*1.2, 1.0, 1.0); //- FUEL
	//PARTICLE_COLOR = float3(0.165, 0.15, 0.15)*0.1; //- OIL
	//PARTICLE_COLOR = float3(1.0, 1.0, 1.0*1.05); //- WATER
	//PARTICLE_COLOR = float3(1.0, 1.0, 1.0); //- STEAM
	//PARTICLE_COLOR*=PARTICLE_COLOR;
	float4 finalColor = float4(PARTICLE_COLOR,  data.a);
	float3 norm = normalize(data.xyz);
	float NoL =saturate(dot(norm, gSunDir))*0.05+0.1;
	finalColor.a *= saturate(OPACITY); // - OIL
	finalColor.rgb = (finalColor.rgb*(AmbientAverage+sunColor*NoL/PI));
	return float4(applyPrecomputedAtmosphere(finalColor.rgb, 0), finalColor.a);
}

float4 PS2_shaderName_flir(PS_INPUT_PARTICLE i, uniform bool bClouds) : SV_TARGET0
{
	float3 UVW				= i.params.xyz;
	float nAgeInv			= i.params.w; // 1 - ������, 0 - �����
	float3 SPEED_PROJ		= i.params2.xyz;
	float OPACITY			= i.params2.w;
	float2 UVparticle		= i.params3.xy;
	float2 sinCos			= i.params3.zw;
	float3 PARTICLE_COLOR	= i.posW.rgb;
	float HALO_FACTOR		= i.posW.w;
	uint VERT_ID			= i.vertId;

	float thres_z = -0.2;

	float b = (thres_z+1.0)/2.0;
	float a = 1/(1- b);

	OPACITY *= 1.0 - ((max(i.pos.z, thres_z)+1.0)/2.0 -b)*a;

	float4 data = normalSphereTex.Sample(gTrilinearClampSampler, UVparticle);  // normal + alpha
	data.xyz = data.xyz * 2 - 1.0;// convert from compressed format [0, 255] -> [-1.0, 1.0]
	//������� + �����
	float3 sunColor = getPrecomputedSunColor(0);

	//PARTICLE_COLOR = float3(1.0*1.2, 1.0, 1.0); //- FUEL
	//PARTICLE_COLOR = float3(0.165, 0.15, 0.15)*0.1; //- OIL
	//PARTICLE_COLOR = float3(1.0, 1.0, 1.0*1.05); //- WATER
	//PARTICLE_COLOR = float3(1.0, 1.0, 1.0); //- STEAM
	//PARTICLE_COLOR*=PARTICLE_COLOR;
	float4 finalColor = float4(PARTICLE_COLOR,  data.a);
	float3 norm = normalize(data.xyz);
	float NoL =saturate(dot(norm, gSunDir))*0.05+0.1;
	finalColor.a *= saturate(OPACITY); // - OIL
	float l = max(luminance(finalColor.rgb), 1.0);
	return float4(l, l, l, finalColor.a);
}


HullShader		GEN_NAME(hsCompiled)		= CompileShader(hs_5_0, HS_shaderName());
GeometryShader	GEN_NAME(gsCompiled)		= CompileShader(gs_5_0, GS_shaderName());
GeometryShader	GEN_NAME(gs2Compiled)		= CompileShader(gs_5_0, GS2_shaderName());
GeometryShader	GEN_NAME(gsCompiledWater)	= CompileShader(gs_5_0, GS_shaderName(true));

VertexShader	GEN_NAME(vsWithoutNozzle)	= CompileShader(vs_5_0, VS_shaderName(false));
VertexShader	GEN_NAME(vsWithoutNozzleGravity)	= CompileShader(vs_5_0, VS_shaderName(false, true));
VertexShader	GEN_NAME(vsWithoutNozzleUnderWater)	= CompileShader(vs_5_0, VS_shaderName(false, false, true));

VertexShader	GEN_NAME(vsWithNozzle)		= CompileShader(vs_5_0, VS_shaderName(true));

DomainShader	GEN_NAME(dsWithoutNozzle)	= CompileShader(ds_5_0, DS_shaderName(false));
DomainShader	GEN_NAME(dsWithNozzle)		= CompileShader(ds_5_0, DS_shaderName(true));


#ifdef FLIR
	PixelShader		GEN_NAME(psWithoutClouds)	= CompileShader(ps_4_0, PS_shaderName_flir(false));
#else
	PixelShader		GEN_NAME(psWithoutClouds)	= CompileShader(ps_4_0, PS_shaderName(false));
#endif
#ifdef FLIR
	PixelShader		GEN_NAME(psWithClouds)	= CompileShader(ps_4_0, PS_shaderName_flir(true));
#else
	PixelShader		GEN_NAME(psWithClouds)	= CompileShader(ps_4_0, PS_shaderName(true));
#endif

#ifdef FLIR
	PixelShader		GEN_NAME(ps2WithoutClouds)	= CompileShader(ps_5_0, PS2_shaderName_flir(false));
#else
	PixelShader		GEN_NAME(ps2WithoutClouds)	= CompileShader(ps_5_0, PS2_shaderName(false));
#endif

//PixelShader		GEN_NAME(psWithoutClouds)	= CompileShader(ps_4_0, PS_shaderName(false));
//PixelShader		GEN_NAME(psWithClouds)		= CompileShader(ps_4_0, PS_shaderName(true));
//PixelShader		GEN_NAME(ps2WithoutClouds)	= CompileShader(ps_5_0, PS2_shaderName(false));

#define SET_SHADERS(vs,hs,ds,gs,ps) \
		SetVertexShader(GEN_NAME(vs));\
		SetHullShader(GEN_NAME(hs));\
		SetDomainShader(GEN_NAME(ds));\
		SetGeometryShader(GEN_NAME(gs));\
		SetPixelShader(GEN_NAME(ps))
		
//
#define SET_PASS(name, vs,hs,ds,gs,ps, blendingStruct)  pass name {	SET_SHADERS(vs,hs,ds,gs,ps); DISABLE_CULLING; \
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT; SetBlendState(blendingStruct, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);}

#define SET_PASS_MFD(name, vs,hs,ds,gs,ps, blendingStruct)  pass name {	SET_SHADERS(vs,hs,ds,gs,ps); DISABLE_CULLING; \
		ENABLE_RO_DEPTH_BUFFER; SetBlendState(blendingStruct, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);}

technique10 techName
{
	//NO CLOUDS
	SET_PASS(main,				vsWithoutNozzle, hsCompiled, dsWithoutNozzle, gsCompiled, psWithoutClouds,	enableAlphaBlend)
	SET_PASS(mainWithNozzle,	vsWithNozzle, hsCompiled, dsWithNozzle, gsCompiled, psWithoutClouds, 		enableAlphaBlend)
	
	//WITH CLOUDS
	SET_PASS(mainClouds,		vsWithoutNozzle, hsCompiled, dsWithoutNozzle, gsCompiled, psWithClouds,		enableAlphaBlend)
	SET_PASS(mainNozzleClouds,	vsWithNozzle, hsCompiled, dsWithNozzle, gsCompiled, psWithClouds,			enableAlphaBlend)
	SET_PASS(mainNew,	vsWithoutNozzleGravity, hsCompiled, dsWithoutNozzle, gs2Compiled, ps2WithoutClouds,	enableAlphaBlend)
	

	SET_PASS(mainWater,	vsWithoutNozzleUnderWater, hsCompiled, dsWithoutNozzle, gsCompiledWater, psWithoutClouds,	enableAlphaBlend)

	SET_PASS_MFD(mainMFD,				vsWithoutNozzle, hsCompiled, dsWithoutNozzle, gsCompiled, psWithoutClouds,	enableAlphaBlend)
	SET_PASS_MFD(mainWithNozzleMFD,	vsWithNozzle, hsCompiled, dsWithNozzle, gsCompiled, psWithoutClouds, 		enableAlphaBlend)	
	//WITH CLOUDS
	SET_PASS_MFD(mainCloudsMFD,		vsWithoutNozzle, hsCompiled, dsWithoutNozzle, gsCompiled, psWithClouds,		enableAlphaBlend)
	SET_PASS_MFD(mainNozzleCloudsMFD,	vsWithNozzle, hsCompiled, dsWithNozzle, gsCompiled, psWithClouds,			enableAlphaBlend)
	SET_PASS_MFD(mainNewMFD,	vsWithoutNozzleGravity, hsCompiled, dsWithoutNozzle, gs2Compiled, ps2WithoutClouds,	enableAlphaBlend)
	SET_PASS_MFD(mainWaterMFD,	vsWithoutNozzleUnderWater, hsCompiled, dsWithoutNozzle, gsCompiledWater, psWithoutClouds,	enableAlphaBlend)

#ifdef TECH_HIGH
	pass wireframe
	{
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
		VERTEX_SHADER(VS_wire())
		SetHullShader(CompileShader(hs_5_0, HS_wire()));
		SetDomainShader(CompileShader(ds_5_0, DS_wire()));
		GEOMETRY_SHADER(GS_wire())
		PIXEL_SHADER(PS_black())
	}
#else
	pass wireframe {}
#endif


}

#undef postfix
#undef TECH_HIGH

#undef techName
#undef VS_shaderName
#undef HSconst_shaderName
#undef HS_shaderName
#undef DS_shaderName
#undef GS_shaderName
#undef PS_shaderName
#undef PS_shaderName_flir
#undef PS2_shaderName_flir
#undef GEN_NAME
#undef quote