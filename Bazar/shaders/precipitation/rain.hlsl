
//#define DEBUG_HUGE_PARTICLE

static const float raindropScale = 0.015;
static const float raindropLengthFactor = 2.0;
static const float raindropBrightness = 6;

static const float rainSpecularPower = 0.02;
static const float rainSpecularAphaFactor = 0.2;
static const float rainOpacityBase = 0.4;
static const float rainHaloFactor = 1;
//static const float rainHaloAlphaFactor = 0.5333333;
static const float rainHaloAlphaFactor = 0.5333333*0.0;
static const float rainLightsAlphaFactor = 0.1;

static const float rainDiffusePower = 120 * raindropBrightness;

// GEOMETRY SHADER ---------------------------------
//ориентируем партикл вдоль вектора скорости в ћ—  и поворачиваем вокруг него на камеру
[maxvertexcount(4)]
void gsRain(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT_RAIN> outputStream)
{
	float RAND = input[0].pos.w;

	float effectPower = SampleCloudsDensity(input[0].pos.xyz);

	if(effectPower==0 || (float(input[0].vertId) > particlesMax * effectPower))
		return;

	float4 vPos = mul(float4(input[0].pos.xyz,1), gView); vPos /= vPos.w;

	float nDistToCam = min(1, length(input[0].pos.xyz - gCameraPos.xyz)/(clipRadius+clipSphereOffset));
	float scale = raindropScale*(0.5+RAND) * (1+pow(nDistToCam*0.6,1.5)*2) * (0.8+0.2*effectPower);//домножаем на масштаб частицы

	float2 rndVel = 1.5 * (noise2(float2(RAND, RAND+3.4344))*2-1) * effectPower * (0.5+0.5*nDistToCam) * (0.5+0.5*sin((gModelTime*2+RAND)*PI));
	
	float3 speedResult = mul(-cameraVel + rainVel + float3(rndVel.x, 0, rndVel.y), (float3x3)gView);
	float  speedValue = length(speedResult);
	float3 speedDir = speedResult / speedValue;
	float  blurOffset = -(speedDir.z)*0.5;

	//считаем проекцию вектора скорости на экран
	float3 dir = getScreenDirLength(vPos, speedResult);

	float screenDist = dir.z;
	float stretchFactor = max(1 + 15*(1-abs(speedDir.z)), min(60,  screenDist * (1+min(speedValue, 1000)*2)  )) * raindropLengthFactor;
	float opacityFactor = 1.0 / (1 + screenDist + 0.01*(speedValue));
	// float opacityFactor = 1.0 / (1 + stretchFactor*0.005);
#ifdef DEBUG_HUGE_PARTICLE
	stretchFactor = 1.0;
	scale *= 10.0;
#endif
	speedDir = float3(dir.xy, 0) * stretchFactor * scale;
	float2 side = float2(-dir.y, dir.x) * scale * (0.5 + 0.5*nDistToCam);

	PS_INPUT_RAIN o;
	float2x2 M = {dir.yx, -dir.x, dir.y};
	o.sunDirM.xyz = float3(-gSunDirV.x, gSunDirV.yz);
	o.sunDirM.xy = mul(o.sunDirM.xy, M);

	o.wPos.xyz = input[0].pos.xyz - gCameraPos.xyz;
	o.wPos.w = getHaloFactor(gSunDir, o.wPos.xyz, 16);
	o.wPos.w = max(o.wPos.w, getHaloFactor(-gSunDir, o.wPos.xyz, 8) * 0.1 );

	float shadow = getCloudsShadow(input[0].pos.xyz);
	o.wPos.w *= rainHaloFactor * shadow;

	o.params.z = max(0, 1-max(0, nDistToCam-0.8)*5);// fade factor
	o.params.z *= opacityFactor;////////////////////////////////////////////////////////////////////////////////////////
	o.params.w = saturate(vPos.z-0.8);

#if (PRECIPITATION_TILED_LIGHTING)
	o.billboardToWorld = (float3x3(normalize(cross(-speedDir, -o.wPos.xyz)), normalize(-speedDir), normalize(-o.wPos.xyz)));
#endif

	float visibility = o.params.z>3.0e-2 ? 1.0 : 0.0;

	[unroll]
	for (uint ii = 0; ii < 4; ++ii)
	{
		float4 p = {staticVertexData[ii].xy, vPos.z, 1};
		p.xy = vPos.xy + side * p.x + speedDir.xy * (p.y+blurOffset);
		o.pos = mul(p * visibility, gProj);
		o.params.xy = staticVertexData[ii].zw;//uv
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 psRain(in PS_INPUT_RAIN i, uniform bool bLighting = false) : SV_TARGET0
{
	float2 UV			= i.params.xy;
	float  fadeFactor	= i.params.z;
	float  haloFactor	= i.wPos.w;

	float3 toCam = normalize(-i.wPos.xyz); // camera origin space

	float4 normSphere = particleTex.Sample(gTrilinearClampSampler, UV);
	normSphere.a *= fadeFactor; //фэйдинг на краях сферы
	clip(normSphere.a-0.01);
	normSphere.xyz = normalize(normSphere.xyz * 2.0 - 1.0);

	float light = dot(normSphere.xyz, i.sunDirM)*0.25 + 0.75; // освещенка [0.0; 1]

	//преломление
	float3 refractClr = AmbientLight(-toCam) / PI;
	float3 diffuse = (refractClr + refractClr.bbb) * (0.5 * light * raindropBrightness);

	//спекулярчик
	float3 Rspec = reflect(-i.sunDirM, normSphere.xyz);
	float RdotV = max(0, dot(Rspec, toCam));
	
	float3 specular = sunDiffuse.xyz * (pow(RdotV, 3) * rainSpecularPower * gSunIntensity);
	diffuse += specular;

	//---------- ореол ----------------------
	float haloAlpha = haloFactor * haloFactor * (1-normSphere.a) * rainHaloAlphaFactor;
	diffuse += sunDiffuse.xyz * (gSunIntensity * haloFactor);
	//---------------------------------------
	
	float opacity = rainOpacityBase + haloAlpha + specular.r * rainSpecularAphaFactor;
#if !(PRECIPITATION_TILED_LIGHTING)
	if(bLighting)
	{
		float4 additiveLightColor = calculateSumLightingSpecular(toCam, i.wPos.xyz, normSphere.xyz, rainSpecularPower);
		diffuse.rgb += additiveLightColor.rgb * 0.3*0.05;
		opacity += additiveLightColor.a * rainLightsAlphaFactor*0.05;
	}
#else
	{
		float3 normSphereWorld = normalize(mul(normSphere.xyz, i.billboardToWorld).xyz);
		float3 additiveLightColor = CalculateDynamicLightingTiled(i.pos.xy, diffuse, specular,
			0.2f, normSphereWorld.xyz, -toCam, i.wPos.xyz + gCameraPos, 0.0f, float2(rainDiffusePower, 1.0), 0.4f, LL_TRANSPARENT, true, false);
		diffuse.rgb += additiveLightColor.rgb;
	}
#endif

	return float4(diffuse, normSphere.a * opacity * i.params.w);
}