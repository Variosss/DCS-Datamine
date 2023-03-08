#define quote(x)			#x
#define ADD_POSTFIX(a, b)	a##b
#define GEN_NAME(name)		ADD_POSTFIX(name, postfix)
// #define GEN_NAME(name)		ADD_POSTFIX(ADD_POSTFIX(name, postfix), techPostfix)
#define techName				GEN_NAME(tech)
#define VS_shaderName			GEN_NAME(VS)
#define HSconst_shaderName		GEN_NAME(HSconst)
#define HS_shaderName			GEN_NAME(HS)
#define DS_shaderName			GEN_NAME(DS)
#define GS_shaderName			GEN_NAME(GS)
#define PS_shaderName			GEN_NAME(PS)
#define PS_FLIR_shaderName		GEN_NAME(PS_FLIR)

VS_OUTPUT VS_shaderName(VS_INPUT i)
{
	float3 PARTICLE_POS		= i.params1.xyz;
	float BIRTH_TIME		= i.params1.w;
	float3 SPEED			= i.params2.xyz;
	float LIFETIME			= i.params2.w;
	float2 WIND				= i.params3.xy;
	
	VS_OUTPUT o;
	o.params3.w   = length(SPEED);
	o.params3.xyz = SPEED/o.params3.w;

	const float		speedValue = length(SPEED);
	const float3	speedDir = SPEED/speedValue;
	const float		AGE = (effectTime - BIRTH_TIME);
	
	o.nAge = min(1, AGE / LIFETIME);
	//����������� ������ � �������
#ifndef DEBUG_NO_JITTER
	float nTrailLength = trailLength*0.001; // ����������� � ��������� ����� � 1��
	float isSlowSpeed = max(0, 1 - speedValue/50.0);
	float3 posOffset = float3(noise1D(BIRTH_TIME*0.01+phase*1.4213), 0.0, noise1D(BIRTH_TIME*0.016+0.23543+phase*0.36373))*2-1;
	posOffset.xz *= pow(o.nAge*nTrailLength, 0.7 + 0.6*isSlowSpeed) * 20 * (1 - 0.3*isSlowSpeed);
#else//if DEBUG
	float3 posOffset = 0;
#endif
	
	o.pos.xyz = PARTICLE_POS + mul(posOffset, basis(speedDir)).xyz + float3(WIND.x,0,WIND.y)*AGE - worldOffset;
	
	o.pos.w = asfloat(i.vertId);
	o.params1 = float4(0,0,0, BIRTH_TIME);//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	o.params2 = float4(speedDir, speedValue); // tangent + speedValue
	
	DEBUG_SET_ZERO
	return o;
}

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
	const float coef = 0.33 * len;
	o.p1.xyz = POS_MSK(0) + normalize(TANGENT(0))*coef;
	o.p2.xyz = POS_MSK(1) - normalize(TANGENT(1))*coef;

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
DS_OUTPUT DS_shaderName(HS_PATCH_OUTPUT2 input, OutputPatch<VS_OUTPUT, 2> op, float2 uv : SV_DomainLocation)
{
	#define POS_MSK(x)			op[x].pos.xyz
	#define SPEED_DIR_VALUE(x)	op[x].params2
	float LOD_PARAM				= input.p1.w;
	float VERTEX_FREQUENCY		= input.p2.w;
	
	DS_OUTPUT o;
#ifndef LOD
	//���������
	float t = lerp(uv.x, 1.0 - uv.x, input.orderOffset.x);
	float t2 = lerp(uv.x + 1.0/input.edges[1], 1.0 - (uv.x + 1.0/input.edges[1]), input.orderOffset.x);
#else
	float t = uv.x;
	float t2 = uv.x + 1.0/input.edges[1];
#endif
	float vertexId = round(t*input.edges[1]); //id ��������������� �������
	t *= input.orderOffset.y; //�������� �������, ����� ������ � ��������� ������� �������� ��������� �� ������������� + ����� �������� � ������ �������� �� �������
	t2 *= input.orderOffset.y;
	

	//���������� �������� ��� �������� � ����������� �� ������� �������� � Id �������� � ������ ����
	
	float uniqParam = op[0].params1.w*10 + round(vertexId * VERTEX_FREQUENCY);
	float birthTime = lerp(op[0].params1.w, op[1].params1.w, t);
	float AGE		= effectTime - birthTime;
	float nAgeFull	= min(1.0, lerp(op[0].nAge, op[1].nAge, t) / (0.2+0.8*noise1D(0.5123*phase + uniqParam*0.35127)));
	float nAge		= nAgeFull*trailLength*0.001;

	float nAgeFull2	= min(1.0, lerp(op[0].nAge, op[1].nAge, t2) / (0.2+0.8*noise1D(0.5123*phase + uniqParam*0.35127)));
	float nAge2		= nAgeFull2*trailLength*0.001;
	//����������������� ������� � ���
	float3 pos		= BezierCurve3(t, POS_MSK(0), input.p1.xyz, input.p2.xyz, POS_MSK(1));

	// ����������������� �����������(������ ��������) + �������� �������� � ���
	o.params2   = lerp(SPEED_DIR_VALUE(0),	SPEED_DIR_VALUE(1),	 t);
	o.params2.xyz = normalize(o.params2.xyz); //����������� ������ ��������
	//--------------------------------------------------------------------------
	float4 emitterSpeed = lerp(op[0].params3, op[1].params3, t);
	float  speedValue = emitterSpeed.w;
#ifndef DEBUG_NO_JITTER2
	// pos += emitterSpeed.xyz * translationWithResistanceSimple(emitterSpeed.w, AGE)*0.5;
#endif
	//--------------------------------------------------------------------------
	
	float nScale = scaleBase*0.5;
#if !defined(LOD) && !defined(DEBUG_NO_JITTER)
	float4 RAND = noise4(float4(1.27193, 2.87363, 3.17359, 0.742952)*phase + uniqParam);
	RAND.xyz = RAND.xyz*2-1;
	//������� ������� � ��� + ��������� ��������� ��������
	float p = smoothNoise1(birthTime*50);
	o.pos.xyz = pos + p * RAND.xyz * pow(nAge,0.6)  * mad(nScale,0.7,0.3) * power*15;
#else
	float4 RAND = {0,0,0, 0.5};
	float rnd = noise1(3.421673*phase + uniqParam);
	o.pos.xyz = pos;// + RAND.xyz*nAge*10;
#endif
	float vertId = (float)asuint(op[0].pos.w) + vertexIdOffset;// �������� vertId
	o.pos.w = vertId;// vertId
	
	//���������� �������� ����� ������� ��������
	float nSpeed = min(1, speedValue/400);
	float speedAngle = pow(abs(dot(ViewInv._31_32_33, o.params2.xyz)), 3);
	//float stretchParam = (1-speedAngle) * pow(max(0,1-AGE*0.25),2) * pow(mad(nSpeed,0.6,0.4), 2);
	float stretchParam = (1-speedAngle) * pow(mad(nSpeed,0.6,0.4), 2);
	float speedStretch = 1 + 4 * stretchParam / mad(nScale,0.5,0.5);
	float fadeBySpeedStretch = 1 - stretchParam*0.6;	
	
	//������ ������ ������� � �������� ����� � ����������� �� frac(PARTICLE_LOD)
	float lodOpacity =  1 - (int(vertexId) & 0x01)*LOD_PARAM;
	
//#if true
	const float opacityMax = 0.4;
	o.params1.x = ( 0.35*sqrt(AGE)*RAND.x + RAND.y*0.6 )*PI2;//���� �������� �������� ��������
	o.params1.y = opacityMax * fadeBySpeedStretch * lodOpacity * (1.0-pow(nAge, 2))*(1.0-0.5*vertId*vertexCountInv);// opacity
	//���������� ������������ ��������� ������� ����� ������
	//o.params1.y *= 1 - pow(min(0.85,   saturate(3*(RAND.w-0.5)) * AGE*0.6 ), 2);
	// ���������� ������� ������ �� �������
	float baseScale = 1.3 * scaleBase * ( 1 + mad(RAND.w,2,3)*pow(nAge,0.8)*1.5 ) * mad(power, 0.5, 0.5);// + 1*sin(RAND*61.1654+AGE*6);
	
//#else//if LOD TODO: ��������� ���
	//const float opacityMax = 0.4;// ������������ �������������� LOD 
	//float baseScale = 1.5 * scaleBase * (1 + mad(rnd, 1.8, 0.2)*1.5*pow(AGE, 0.7));
	//o.params1.xy = float2(rnd.x*PI2, saturate(opacityMax * lodOpacity*(1-speedStretch/(6+nScale)) *(1-nAgeFull*0.5) * 6 * (1-(vertId+segmentParam)*vertexCountInv)) );
//#endif

#ifdef DEBUG_FIXED_SIZE
	baseScale = DEBUG_FIXED_SIZE;
#endif
#ifdef DEBUG_NO_STRETCH
	speedStretch = 1;
#endif
	
	o.params1.z = baseScale;
	o.params1.w = nAgeFull;
	o.params2.w = speedStretch;
	float opacityFirst = opacityMax * fadeBySpeedStretch * lodOpacity * (1.0-pow(nAge2, 2))*(1.0-0.5*vertId*vertexCountInv);
	//opacityFirst *= 1 - pow(min(0.85,   saturate(3*(RAND.w-0.5)) * AGE*0.6 ), 2);
	o.opacity.xy = float2(o.params1.y, opacityFirst);
	o.opacity.z = min(1.0, lerp(op[0].nAge, op[1].nAge, t));
#ifdef DEBUG_OUTPUT
	o.debug = op[0].debug;
	o.debug.x = vertexId;
#endif
	#undef SPEED_DIR_VALUE
	#undef POS_MSK
	#undef PARTICLE_LOD
    return o;	
}
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

[maxvertexcount(4)]
void GS_shaderName(point DS_OUTPUT input[1], inout TriangleStream<PS_INPUT_PARTICLE> outputStream)
{
	#define POS_MSK			input[0].pos.xyz
	#define VERT_ID			input[0].pos.w
	#define ANGLE			input[0].params1.x //id ��������������� �������
	#define OPACITY			input[0].params1.y
	#define SCALE			input[0].params1.z
	#define nAGE			input[0].params1.w
	#define TANGENT_MSK		input[0].params2.xyz
	#define SPEED_STRETCH	input[0].params2.w
	
	PS_INPUT_PARTICLE o;
	
#ifdef DEBUG_OUTPUT
	o.debug = input[0].debug;
#endif

	o.vertId = uint(VERT_ID + 0.5);
	//o.params.z = max(0, 1 - nAGE);
	o.params.z = max(0, 1 - input[0].opacity.z);
	//������������� � ������ ���� � ������
	const float trailBrightness = 0.8;
	float b = trailBrightness*0.5 + 0.4;
	o.params.x = lerp(b, trailBrightness, pow(max(0,1-nAGE * trailLength*0.001), 4));
	
#ifdef LOD
	o.params.x *= 0.9;
#endif
	
#if defined(PS_HALO) && !defined(DEBUG_NO_HALO)
	float sunDot = dot(-sunDir, normalize(POS_MSK - gViewInv._41_42_43))*0.5 + 0.5;
	o.params.y = pow((1-sunDot), 6);
#else
	o.params.y = 0;
#endif	
	
	// float4x4 mBillboard = billboard(POS_MSK, baseScale);//��� ��������
	float4x4 mBillboard = billboardOverSpeed(POS_MSK, TANGENT_MSK, SCALE);//����� ������� ��������
	o.params2 = float4(mBillboard._21_22_23/SCALE, OPACITY*diffuseColor.a*0.8);//�������� ������� �������� �� ����� � ���
#ifndef LOD
	float _sin,_cos;
	//sincos( ANGLE, _sin, _cos );//��� �������� ���������� ��������� ��������
	sincos( 0.0, _sin, _cos );
	o.params3.zw = float2(-_sin, _cos);//��� ��������� �������� ��������
	float2x2 Mtex = {_cos, _sin, -_sin, _cos};
#else
	o.params3.zw = 0;
#endif

	for (int ii = 0; ii < 4; ++ii)
	{
		float4 wPos = {staticVertexData[ii].xy, 0, 1};
	#ifndef LOD
		o.params3.xy = mul(wPos.xy, Mtex) + 0.5;//������ ���������� ����������, ������� ����� �� �����
	#else
		o.params3.xy = wPos.xy + 0.5;//���� �� ������
	#endif
		wPos.y *= SPEED_STRETCH;//����������� ����� ������� ��������
		wPos = mul(wPos, mBillboard);
		o.pos = mul(wPos, VP);
		o.opacity.x = diffuseColor.a*0.8*lerp(input[0].opacity.x*1.0, input[0].opacity.y*1.0, staticVertexData[ii].y);
		o.opacity.y = staticVertexData[ii].x;
		o.opacity.z = staticVertexData[ii].y;
		outputStream.Append(o);
	}
	#undef SPEED_STRETCH
	#undef TANGENT_MSK
	#undef VERT_ID
	#undef ANGLE
	#undef POS_MSK
	#undef OPACITY
	#undef SCALE
}

float4  PS_shaderName(PS_INPUT_PARTICLE i, uniform bool bAtmosphere) : SV_TARGET0
{
	float	PARTICLE_COLOR	 = i.params.x;
	float	HALO_FACTOR		 = i.params.y;
	float	nAgeInv			 = i.params.z; // 1 - ������, 0 - �����
	float3	SPEED_PROJ		 = i.params2.xyz;
	float	OPACITY			 = i.params2.w;
	float2	UVparticle		 = i.params3.xy;
	float2	sinCos			 = i.params3.zw;
	uint	VERT_ID			 = i.vertId;

	OPACITY = 0.2*i.opacity.x;

	//������� + �����
	float4 normSphere = normalSphereTex.Sample(ClampLinearSampler, UVparticle);
	normSphere.a *= mad(nAgeInv,0.5,0.5); clip(normSphere.a-0.06);
	normSphere.xyz = normalize(normSphere.xyz*2-1);

	const float IBL_intensity = 0.5;
	uint id = (uint)(VERT_ID+0.5);

	float3 sunColor = getPrecomputedSunColor(0/*VERT_ID*/);

	#if defined(PS_NORMAL_LIGHT) && !defined(DEBUG_NO_LIGHTING)
		//---------- ������� ----------------------	
		//������ ������� ������ �������� �������� � ������������ ����� �������� ������� �������� �� �����
		float3 norm = alignNormalToDirection(normSphere, sinCos, SPEED_PROJ);
		//---------- ��������� --------------------	
		float NoL = max(0, dot(norm,  gSunDir)*0.5 + 0.5);
		NoL = lerp(1, pow(NoL,0.7), pow(normSphere.a,0.36));//��������� ��������� �� ����� �������� � � ������
		//-----------------------------------------	
		sunColor *= NoL;
	#endif
	
	float4 finalColor = float4(PARTICLE_COLOR.xxx, normSphere.a * OPACITY);
	
	#if defined(PS_HALO) && !defined(DEBUG_NO_HALO)
		finalColor.rgb = shading_AmbientSunHalo(finalColor.rgb, AmbientAverage, sunColor/PI, HALO_FACTOR * (1 - min(1, 6*finalColor.a)) );
	#else
		finalColor.rgb = shading_AmbientSun(finalColor.rgb, AmbientAverage, sunColor/PI);
	#endif
	
	//glow
	float glowFactor = saturate(1 - (1 - nAgeInv) * 8);
	glowFactor *= glowFactor * glowFactor;
	glowFactor += params2.z*20.0*saturate(1 - (1 - nAgeInv) * 200);
	finalColor.rgb += diffuseColor.rgb * diffuseColor.rgb * (glowFactor * 0.5);

	finalColor.a = 6.0*saturate(1 - (1 - nAgeInv) * 100)*normSphere.a * i.opacity.x*(1.0-smoothstep(0.0, 0.4, 0.9*abs(i.opacity.y)))*(1.0-smoothstep(0.0, 0.2, 0.5*abs(i.opacity.z))) + (1.0-saturate(1 - (1 - nAgeInv) * 100))*finalColor.a;

	if(bAtmosphere)
		finalColor.rgb = applyPrecomputedAtmosphereLerp(finalColor.rgb, 0, 1-nAgeInv);

	#ifdef DEBUG_OPAQUE
		finalColor.rgb = 1;
		finalColor.a = 0.25;
	#endif
	return finalColor;
}


float4  PS_FLIR_shaderName(PS_INPUT_PARTICLE i, uniform bool bAtmosphere) : SV_TARGET0
{

	float3 sunColor = getPrecomputedSunColor(0/*VERT_ID*/);

	float	PARTICLE_COLOR	 = i.params.x;
	float	HALO_FACTOR		 = i.params.y;
	float	nAgeInv			 = i.params.z; // 1 - ������, 0 - �����
	float3	SPEED_PROJ		 = i.params2.xyz;
	float	OPACITY			 = i.params2.w;
	float2	UVparticle		 = i.params3.xy;
	float2	sinCos			 = i.params3.zw;
	uint	VERT_ID			 = i.vertId;


	//������� + �����
	float4 normSphere = normalSphereTex.Sample(ClampLinearSampler, UVparticle);
	normSphere.a *= mad(nAgeInv,0.5,0.5); clip(normSphere.a-0.06);
	normSphere.xyz = normalize(normSphere.xyz*2-1);
	
	float4 finalColor = float4(PARTICLE_COLOR.xxx, normSphere.a * OPACITY);
	
	
	//glow
	float glowFactor = saturate(1 - (1 - nAgeInv) * 6);
	glowFactor *= glowFactor * glowFactor;
	finalColor.rgb += diffuseColor.rgb * diffuseColor.rgb * (glowFactor * 0.5);

	if(bAtmosphere)
		finalColor.rgb = applyPrecomputedAtmosphereLerp(finalColor.rgb, 0, 1-nAgeInv);

	#ifdef DEBUG_OPAQUE
		finalColor.rgb = 1;
		finalColor.a = 0.25;
	#endif

	float l = float3(0.3, 0.59, 0.11)*finalColor.rgb*0.4*clamp(gSunIntensity, 1.0, 1.5);
	return float4(l, l, l, finalColor.a*0.8);
}


HullShader		GEN_NAME(hsCompiled)		= CompileShader(hs_5_0, HS_shaderName());
GeometryShader	GEN_NAME(gsCompiled)		= CompileShader(gs_5_0, GS_shaderName());

VertexShader	GEN_NAME(vsWithoutNozzle)	= CompileShader(vs_5_0, VS_shaderName());
// VertexShader	GEN_NAME(vsWithNozzle)		= CompileShader(vs_5_0, VS_shaderName(true));

DomainShader	GEN_NAME(dsWithoutNozzle)	= CompileShader(ds_5_0, DS_shaderName());
// DomainShader	GEN_NAME(dsWithNozzle)		= CompileShader(ds_5_0, DS_shaderName(true));

PixelShader		GEN_NAME(psWithoutClouds)	= CompileShader(ps_4_0, PS_shaderName(false));
PixelShader		GEN_NAME(psWithClouds)		= CompileShader(ps_4_0, PS_shaderName(true));
PixelShader		GEN_NAME(psFlirWithoutClouds)	= CompileShader(ps_4_0, PS_FLIR_shaderName(false));
PixelShader		GEN_NAME(psFlirWithClouds)	= CompileShader(ps_4_0, PS_FLIR_shaderName(false));

#define SET_SHADERS(vs,hs,ds,gs,ps) \
		SetVertexShader(GEN_NAME(vs));\
		SetHullShader(GEN_NAME(hs));\
		SetDomainShader(GEN_NAME(ds));\
		SetGeometryShader(GEN_NAME(gs));\
		SetPixelShader(GEN_NAME(ps))
		
#define SET_PASS(name, vs,hs,ds,gs,ps, blendingStruct)  pass name {	SET_SHADERS(vs,hs,ds,gs,ps); DISABLE_CULLING; \
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT; SetBlendState(blendingStruct, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);}	

#define enableAlphaBlend2 enableAlphaBlend

technique10 techName
{
	//NO CLOUDS
	SET_PASS(main,				vsWithoutNozzle, hsCompiled, dsWithoutNozzle, gsCompiled, psWithoutClouds,	enableAlphaBlend2)
	// SET_PASS(mainWithNozzle,	vsWithNozzle, hsCompiled, dsWithNozzle, gsCompiled, psWithoutClouds, 		enableAlphaBlend)
	
	//WITH CLOUDS
	SET_PASS(mainClouds,		vsWithoutNozzle, hsCompiled, dsWithoutNozzle, gsCompiled, psWithClouds,		enableAlphaBlend2)
	// SET_PASS(mainNozzleClouds,	vsWithNozzle, hsCompiled, dsWithNozzle, gsCompiled, psWithClouds,			enableAlphaBlend)

	SET_PASS(mainFlir,		vsWithoutNozzle, hsCompiled, dsWithoutNozzle, gsCompiled, psFlirWithoutClouds,		enableAlphaBlend)

	SET_PASS(mainCloudsFlir,		vsWithoutNozzle, hsCompiled, dsWithoutNozzle, gsCompiled, psFlirWithClouds,		enableAlphaBlend)
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
#undef PS_FLIR_shaderName
#undef GEN_NAME
#undef quote