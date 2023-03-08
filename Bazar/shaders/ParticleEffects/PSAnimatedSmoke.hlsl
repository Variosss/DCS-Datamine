static const float4 smokeNormOff = float4(0.0,0.0,0.5,0.5);
static const float4 smokeNoiseOff = float4(0.0,0.5,0.5,0.5);
static const float4 smokeNoiseBallOff = float4(0.5,0.0,0.5,0.5);
static const float4 smokeAlphaOff = float4(0.5,0.5,0.25,0.25);
static const float4 smokeBorderAlphaOff = float4(0.75,0.5,0.25,0.25);

float4 psTranslucentAnim(PS_INPUT Input, uniform float ambientC) : SV_TARGET0
{
	float spAlphaC = softParticlesAlpha(Input.screenTex, Input.depth);

	float2 randOff = fmod(float2(0.4687*Input.texcoord[2], 0.3235*Input.texcoord[2]), float2(1.f, 1.f));
	float2 noisetc = texMoveOffset(Input.texcoord.xy+randOff, vecParams.xy, vecParams.z, lifeTime - Input.texcoord.w);
	float4 texNoiseValue = tex2dFromAtlas(noisetc, smokeNoiseOff);
	
	noisetc = texMoveOffset(Input.texcoord.xy, float2(-0.2, 0.5), vecParams.z, lifeTime - Input.texcoord.w);
	texNoiseValue *= tex2dFromAtlas(noisetc, smokeNoiseBallOff);
	
	float2 noisedtc = min(Input.texcoord + texNoiseValue.xy, float2(1.0,1.0));
	
	float alphaNoise = tex2dFromAtlas(noisedtc, smokeAlphaOff).r;
	float alpha = tex2dFromAtlas(Input.texcoord.xy, smokeBorderAlphaOff).r;

	float4 normTexColor = tex2dFromAtlas(Input.texcoord, smokeNormOff) * 2 - 1;
	float4 surfNorm = float4(normTexColor.xy, -normTexColor.z, 0);
	
	float NoL = max(dot(sunDir, surfNorm)*0.65+0.35, 0);
	
	NoL = lerp(NoL, 0.4+0.6*NoL, ambientC);

	float alphaParam = 1 - min(1, 2*alphaNoise*spAlphaC);
	float haloFactor = pow(gSunDirV.z*0.5+0.5, 5) * alphaParam * ambientC;

	alpha *= Input.color.a * alphaNoise * spAlphaC;

	float4 result = float4(shading_AmbientSunHalo(Input.color.rgb*Input.color.rgb, AmbientAverage, sunColor * (gSunIntensity/2.0 * NoL * ambientC / 3.1415), haloFactor), alpha);

	result.rgb = applyFog(result.rgb, gCameraPos, Input.worldPos.xyz);
	return result;
};

float4 psTranslucentAnimFlir(PS_INPUT Input, uniform float ambientC) : SV_TARGET0
{
	float spAlphaC = softParticlesAlpha(Input.screenTex, Input.depth);

	float2 randOff = fmod(float2(0.4687*Input.texcoord[2], 0.3235*Input.texcoord[2]), float2(1.f, 1.f));
	float2 noisetc = texMoveOffset(Input.texcoord.xy+randOff, vecParams.xy, vecParams.z, lifeTime - Input.texcoord.w);
	float4 texNoiseValue = tex2dFromAtlas(noisetc, smokeNoiseOff);
	
	noisetc = texMoveOffset(Input.texcoord.xy, float2(-0.2, 0.5), vecParams.z, lifeTime - Input.texcoord.w);
	texNoiseValue *= tex2dFromAtlas(noisetc, smokeNoiseBallOff);
	
	float2 noisedtc = min(Input.texcoord + texNoiseValue.xy, float2(1.0,1.0));
	
	float alphaNoise = tex2dFromAtlas(noisedtc, smokeAlphaOff).r;
	float alpha = tex2dFromAtlas(Input.texcoord.xy, smokeBorderAlphaOff).r;

	float4 normTexColor = tex2dFromAtlas(Input.texcoord, smokeNormOff) * 2 - 1;
	float4 surfNorm = float4(normTexColor.xy, -normTexColor.z, 0);
	
	float NoL = max(dot(sunDir, surfNorm)*0.65+0.35, 0);
	
	NoL = lerp(NoL, 0.4+0.6*NoL, ambientC);

	float alphaParam = 1 - min(1, 2*alphaNoise*spAlphaC);
	float haloFactor = pow(gSunDirV.z*0.5+0.5, 5) * alphaParam * ambientC;

	alpha *= Input.color.a * alphaNoise * spAlphaC;
	float l;
	if (dot(Input.color.rgb, Input.color.rgb) < 0.1)
		l = 40.0*luminance(Input.color.rgb*Input.color.rgb*(0.7 + 0.0001*gSunIntensity/8.0));
	else
		l = luminance(Input.color.rgb*Input.color.rgb*(0.6 + 0.1*smoothstep(2.0, 20.0, gSunIntensity)*gSunIntensity))/2.0;
	
	return float4(l, l, l, alpha);
};

float4 psSmokeMarker(PS_INPUT Input, uniform float ambientC) : SV_TARGET0
{
	float spAlphaC = softParticlesAlpha(Input.screenTex, Input.depth);

	float2 randOff = fmod(float2(0.4687*Input.texcoord[2], 0.3235*Input.texcoord[2]), float2(1.f, 1.f));
	float2 noisetc = texMoveOffset(Input.texcoord.xy+randOff, vecParams.xy, vecParams.z, lifeTime - Input.texcoord.w);
	float4 texNoiseValue = tex2dFromAtlas(noisetc, smokeNoiseOff);
	
	noisetc = texMoveOffset(Input.texcoord.xy, float2(-0.2, 0.5), vecParams.z, lifeTime - Input.texcoord.w);
	texNoiseValue *= tex2dFromAtlas(noisetc, smokeNoiseBallOff);
	
	float2 noisedtc = min(Input.texcoord + texNoiseValue.xy, float2(1.0,1.0));
	
	float alphaNoise = tex2dFromAtlas(noisedtc, smokeAlphaOff).r;
	float alpha = tex2dFromAtlas(Input.texcoord.xy, smokeBorderAlphaOff).r;
   
	float4 normTexColor = tex2dFromAtlas(Input.texcoord, smokeNormOff) * 2 - 1;
	float4 surfNorm = float4(normTexColor.xy, -normTexColor.z, 0);
	
	float NoL = max(dot(sunDir, surfNorm)*0.5+0.5, 0);

	float alphaParam = 1 - min(1, 2*alphaNoise*spAlphaC);
	float haloFactor = pow(gSunDirV.z*0.5+0.5, 5) * alphaParam * ambientC;

	alpha *= Input.color.a * alphaNoise * spAlphaC;

	float4 result = float4(shading_AmbientSunHalo(Input.color.rgb*Input.color.rgb, AmbientAverage, sunColor * (gSunIntensity * NoL * ambientC / 3.1415), haloFactor), alpha);

	result.rgb = applyFog(result.rgb, gCameraPos, Input.worldPos.xyz);	
	return result;
};

float4 psSmokeMarkerFlir(PS_INPUT Input, uniform float ambientC) : SV_TARGET0
{
	float spAlphaC = softParticlesAlpha(Input.screenTex, Input.depth);

	float2 randOff = fmod(float2(0.4687*Input.texcoord[2], 0.3235*Input.texcoord[2]), float2(1.f, 1.f));
	float2 noisetc = texMoveOffset(Input.texcoord.xy+randOff, vecParams.xy, vecParams.z, lifeTime - Input.texcoord.w);
	float4 texNoiseValue = tex2dFromAtlas(noisetc, smokeNoiseOff);
	
	noisetc = texMoveOffset(Input.texcoord.xy, float2(-0.2, 0.5), vecParams.z, lifeTime - Input.texcoord.w);
	texNoiseValue *= tex2dFromAtlas(noisetc, smokeNoiseBallOff);
	
	float2 noisedtc = min(Input.texcoord + texNoiseValue.xy, float2(1.0,1.0));
	
	float alphaNoise = tex2dFromAtlas(noisedtc, smokeAlphaOff).r;
	float alpha = tex2dFromAtlas(Input.texcoord.xy, smokeBorderAlphaOff).r;
   
	float4 normTexColor = tex2dFromAtlas(Input.texcoord, smokeNormOff) * 2 - 1;
	float4 surfNorm = float4(normTexColor.xy, -normTexColor.z, 0);
	
	float NoL = max(dot(sunDir, surfNorm)*0.5+0.5, 0);

	float alphaParam = 1 - min(1, 2*alphaNoise*spAlphaC);
	float haloFactor = pow(gSunDirV.z*0.5+0.5, 5) * alphaParam * ambientC;

	alpha *= Input.color.a * alphaNoise * spAlphaC;

	float l = luminance(applyFog(float3(1.0, 1.0, 1.0), gCameraPos, Input.worldPos.xyz))/2.0;
	return float4(l, l, l, alpha);

	float4 result = float4(shading_AmbientSunHalo(Input.color.rgb*Input.color.rgb, AmbientAverage, sunColor * (gSunIntensity * NoL * ambientC / 3.1415), haloFactor), alpha);

	result.rgb = applyFog(result.rgb, gCameraPos, Input.worldPos.xyz);	
	return result;
};

