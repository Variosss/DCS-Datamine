
static const float mistScale = 20; //размер партикла дымки

static const float rainMistBrightness = 0.5;
static const float rainMistOpacityBase = 0.06;//минимальная непрозрачность частицы
static const float rainMistHaloAlphaFactor = 0.01;//сила прибавки к альфе в зависимости от гало
static const float rainMistLightsPower = 0.1;
static const float rainMistLightsAlphaFactor = 0.02;//сила прибавки к альфе в зависимости от освещенности лампочками

static const float rainMistDiffusePower = 20 * rainMistBrightness;

static const float snowMistBrightness = 1.0;
static const float snowMistOpacityBase = 0.1;//минимальная непрозрачность частицы
static const float snowMistHaloAlphaFactor = 0.1;//сила прибавки к альфе в зависимости от гало
static const float snowMistLightsAlphaFactor = 0.1;//сила прибавки к альфе в зависимости от освещенности лампочками

static const float snowMistDiffusePower = snowMistBrightness;

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void gsMist(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float density = SampleCloudsDensity(input[0].pos.xyz);

	if(density==0 || (float(input[0].vertId) > mistParticlesMax * density))
		return;

	float RAND = input[0].pos.w;
	
	float4 vPos = mul(float4(input[0].pos.xyz,1), gView); vPos /= vPos.w;
	
	PS_INPUT o;
	o.shadow = getCloudsShadow(input[0].pos.xyz)*0.9 + 0.1;
	o.params.w = (0.2+0.8*noise1D(RAND*5.321))*saturate((rainPower-0.2)*3);//opacityFactor
	o.params.w *= saturate(vPos.z - 2.5);

	float3 spherePos = gCameraPos.xyz + gView._13_23_33*clipSphereOffsetMist;//позици€ клип сферы
	o.params.z = min(1, distance(input[0].pos.xyz, spherePos)*clipRadiusMistInv);
	o.params.z = 1-max(0, o.params.z-0.8)*5;// fade factor

	float nDistMax = min(1, length(input[0].pos.xyz - gCameraPos.xyz)/(clipSphereOffsetMist+clipRadiusMist));

	float2 sc;
	sincos(RAND*PI2, sc.x, sc.y);
	sc *= mistScale * (0.5 + RAND + nDistMax * nDistMax);
	float2x2 M = {sc.x, sc.y, -sc.y, sc.x};

	//имитируем Mie рассеивание
	float3 wpos = input[0].pos.xyz - gCameraPos.xyz;
	o.wPos.w = max(getHaloFactor(gSunDir, wpos, 32), 0.1*getHaloFactor(-gSunDir, wpos, 8));

#if (PRECIPITATION_TILED_LIGHTING)
	o.billboardToWorld = 1.0;//transpose(float3x3(normalize(-speedDir), normalize(cross(-speedDir, -o.wPos.xyz)), normalize(-o.wPos.xyz)));
#endif

	float visibility = (o.params.w*o.params.z)>5.0e-2 ? 1.0 : 0.0;

	[unroll]
	for (uint ii = 0; ii < 4; ++ii)
	{
		float4 p = {mul(staticVertexData[ii].xy, M), vPos.z, 1};
		o.wPos.xyz = wpos + gViewInv._11_12_13*p.x + gViewInv._21_22_23*p.y;

		p.xy += vPos.xy;
		o.pos = mul(p*visibility, gProj);
	#ifdef SOFT_MIST
		o.projPos = o.pos;
	#endif
		o.params.xy = staticVertexData[ii].zw;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

//RAIN MIST
float4 psMistRain(in PS_INPUT i, uniform bool bLighting = false) : SV_TARGET0
{
	float2 UV			= i.params.xy;
	float  fadeFactor	= i.params.z;
	float  opacityFactor= i.params.w;
	float  haloFactor	= i.wPos.w;	

	float4 normSphere = mistTex.Sample(gTrilinearClampSampler, UV);
	normSphere.a *= fadeFactor;//фэйдинг на краях сферы
	clip(normSphere.a*opacityFactor-0.01);
	
	float3 sunColor = sunDiffuse * gSunIntensity * i.shadow;
	float3 diffuse = rainMistBrightness * (AmbientTop.bbb + sunColor * 0.4) / PI;
	//---------- ореол ----------------------
	float haloAlpha = haloFactor * (1-normSphere.a);
	diffuse += sunColor * haloFactor * (1-normSphere.a*0.5) * 1.0;
	//---------------------------------------

	float opacity = rainMistOpacityBase + haloAlpha * rainMistHaloAlphaFactor;
	float3 toCam = normalize(-i.wPos.xyz);
#if !(PRECIPITATION_TILED_LIGHTING)
	if(bLighting)
	{
		float4 additiveLight = calculateMistSumLighting(toCam, i.wPos.xyz);
		diffuse += additiveLight.rgb * rainMistLightsPower;
		opacity += additiveLight.a * rainMistLightsAlphaFactor;
	}
#else
	{
		float3 normSphereWorld = normalize(mul(normSphere.xyz, i.billboardToWorld).xyz);
		float3 additiveLightColor = CalculateDynamicLightingTiled(i.pos.xy, diffuse, 0.25f,
			0.2f, normSphereWorld.xyz, -toCam, i.wPos.xyz + gCameraPos, 0.0f, float2(rainMistDiffusePower, 1.0), 0.4f, LL_TRANSPARENT, true, false);
		diffuse.rgb += additiveLightColor.rgb;
		//opacity += additiveLightColor.a * rainLightsAlphaFactor*0.05;
	}
#endif

	float alpha = normSphere.a*opacity*opacityFactor;
	
#ifdef SOFT_MIST
	alpha *= depthAlpha(i.projPos, 1.0/20.0);
	clip(alpha - 0.4/255.0);
	// if (alpha < 1.0 / 255)
		// discard;
#endif
	return float4(diffuse, alpha);
}


//SNOW MIST
float4 psMistSnow(in PS_INPUT i, uniform bool bLighting = false) : SV_TARGET0
{
	float2 UV			= i.params.xy;
	float  fadeFactor	= i.params.z;
	float  opacityFactor= i.params.w;
	float  haloFactor	= i.wPos.w;

	float4 normSphere = mistTex.Sample(gTrilinearClampSampler, UV);
	clip(normSphere.a-0.04);

	normSphere.a *= fadeFactor; //фэйдинг на краях сферы	

	float3 ambient = AmbientTop.xyz;
	float3 sunColor = sunDiffuse * gSunIntensity * i.shadow;
	float3 diffuse = snowMistBrightness * (lerp(ambient, ambient.bbb, 0.6) + 0.5 * sunColor) / PI;	
	//---------- ореол ----------------------
	float haloAlpha = haloFactor * (1-normSphere.a);
	diffuse += sunDiffuse * haloFactor * (1-normSphere.a*0.5) * gSunIntensity;
	//---------------------------------------

	float opacity = snowMistOpacityBase + haloAlpha * snowMistHaloAlphaFactor;
    float3 toCam = normalize(-i.wPos.xyz);

#if !(PRECIPITATION_TILED_LIGHTING)
	if(bLighting)
	{
		float4 additiveLight = calculateMistSumLighting(toCam, i.wPos.xyz)*0.3;
		diffuse += diffuse+additiveLight.rgb;
		opacity += additiveLight.a * snowMistLightsAlphaFactor;
	}
#else
    {
        float3 normSphereWorld = normalize(mul(normSphere.xyz, i.billboardToWorld).xyz);
        float3 additiveLightColor = CalculateDynamicLightingTiled(i.pos.xy, diffuse, 0.25f,
            0.2f, normSphereWorld.xyz, -toCam, i.wPos.xyz + gCameraPos, 0.0f, float2(snowMistDiffusePower, 1.0), 0.4f, LL_TRANSPARENT, true, false);
        diffuse.rgb += additiveLightColor.rgb;
		//opacity += additiveLightColor.a * rainLightsAlphaFactor*0.05;
    }
#endif

	float alpha = normSphere.a*opacity*opacityFactor;	

#ifdef SOFT_MIST
	alpha *= depthAlpha(i.projPos, 1.0/20.0);
	clip(alpha - 0.4/255.0);
#endif
	return float4(diffuse, alpha);
}