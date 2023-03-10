
static const float snowflakeScale = 0.02;
static const float snowflakeBrightness = 0.7;

static const float snowSpecularPower = 0.2;
static const float snowSpecularAphaFactor = 0.1;
static const float snowOpacityBase = 0.2;
static const float snowHaloFactor = 1.5;
static const float snowHaloAlphaFactor = 0.15;
static const float snowLightsAlphaFactor = 0.1;

static const float snowDiffusePower = 1000.0f * snowflakeBrightness;

// GEOMETRY SHADER ---------------------------------
//ориентируем партикл вдоль вектора скорости в МСК и поворачиваем вокруг него на камеру
[maxvertexcount(4)]
void gsSnow(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT_RAIN> outputStream)
{
	float density = SampleCloudsDensity(input[0].pos.xyz, true);

	if(density==0 || (float(input[0].vertId) > particlesMax * density))
		return;

	float RAND = input[0].pos.w;
	
	float nDistToCam = min(1, length(input[0].pos.xyz - gCameraPos.xyz) / (clipRadius+clipSphereOffset) );
	float scale = snowflakeScale * (0.5+RAND) * (1 + 3*pow(nDistToCam*0.6,1.5));

	float4 vPos = mul(float4(input[0].pos.xyz,1), gView); vPos /= vPos.w;

	float3 velocityResult = mul(-cameraVel + rainVel, (float3x3)gView);
	float speedValue = length(velocityResult);
	float blurOffset = -(velocityResult.z / speedValue) * 0.5;

	//считаем проекцию вектора скорости на экран
	float3 dir = getScreenDirLength(vPos, velocityResult);
	
	float screenDist = dir.z;
	// float stretchFactor = max(1, min(60,  screenDist * (1+min(speedValue, 1000)*0.08)  ));
	float stretchFactor = max(1, min(60,  screenDist * (1+min(speedValue, 1000)*0.12)  ));
	float opacityFactor = 1.0 / (1 + 0.5 * screenDist + 0.02*(speedValue));

	float3 speedDir = float3(dir.xy, 0) * stretchFactor * scale;
	float3 side = float3(-dir.y, dir.x, 0) * scale;
	
	PS_INPUT_RAIN o;
	//o.randomSeed = input[0].vertId;
	o.sunDirM = 0;
	o.wPos.xyz = input[0].pos.xyz - gCameraPos.xyz;
	o.wPos.w = getHaloFactor(gSunDir, o.wPos.xyz, 16);

	float shadow = getCloudsShadow(input[0].pos.xyz)*0.9+0.1;
	o.wPos.w *= shadow;

	o.params.z = max(0, 1 - max(0, nDistToCam-0.8)*5);// fade factor
	o.params.z *= opacityFactor;
	o.params.w = saturate(vPos.z-1);

#if (PRECIPITATION_TILED_LIGHTING)
	o.billboardToWorld = transpose(float3x3(normalize(-speedDir), normalize(cross(-speedDir, -o.wPos.xyz)), normalize(-o.wPos.xyz)));
#endif 

	[unroll]
	for (uint ii = 0; ii < 4; ++ii)
	{
		float4 p = {staticVertexData[ii].xy, vPos.z, 1};
		p.xy = vPos.xy + side.xy * p.x + speedDir.xy * (p.y+blurOffset);
		o.pos = mul(p, gProj);
		o.params.xy = staticVertexData[ii].zw;//uv
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 psSnow(in PS_INPUT_RAIN i, uniform bool bLighting = false) : SV_TARGET0
{
	float opacityFactor = i.params.z;
	float haloFactor = i.wPos.w;
	
	float4 normSphere = particleTex.Sample(gTrilinearClampSampler, i.params.xy);
	normSphere.a *= opacityFactor;
	clip(normSphere.a-0.01);
	float3 toCam = normalize(-i.wPos.xyz);

	float3 diffuse = (AmbientTop + sunDiffuse.xyz * gSunIntensity) * (snowflakeBrightness / PI);

	//---------- ореол ----------------------
	float haloAlpha = haloFactor * (1-normSphere.a);
	diffuse += sunDiffuse.xyz * haloFactor * (1-normSphere.a*0.5) * gSunIntensity * snowHaloFactor;
	//---------------------------------------

	float opacity = snowOpacityBase + haloAlpha*snowHaloAlphaFactor;
#if !(PRECIPITATION_TILED_LIGHTING)
	if(bLighting)
	{
		float4 additiveLightColor = calculateSumLighting(toCam, i.wPos.xyz);
		diffuse.rgb += additiveLightColor.rgb*0.4;
		opacity += additiveLightColor.a * snowLightsAlphaFactor;
		return float4(min(1,diffuse), normSphere.a * opacity * i.params.w );
	}
#else
	{
		float3 normSphereWorld = normalize(mul(normSphere.xyz, i.billboardToWorld).xyz);
		float3 additiveLightColor = CalculateDynamicLightingTiled(i.pos.xy, diffuse, 0.25,
			0.2f, normSphereWorld.xyz, -toCam, i.wPos.xyz + gCameraPos, 0.0f, float2(snowDiffusePower, 1.0), 1.0f, LL_TRANSPARENT, false, false);
		diffuse.rgb += additiveLightColor.rgb;
		return float4(min(1.0f, diffuse), normSphere.a * opacity * i.params.w );
	}
#endif

	return float4(diffuse, normSphere.a * opacity * i.params.w );
}
