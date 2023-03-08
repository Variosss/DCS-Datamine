float4 psTranslucent(PS_INPUT Input) : SV_TARGET0
{
	float spAlphaC = softParticlesAlpha(Input.screenTex, Input.depth);

	//TODO id должен иметь произвольное смещение при старте эффекта
	float normTC = (round(Input.texcoord[2]) % randTexSize.x)/randTexSize.x;
	float2 normedIds = randTex.Sample(WrapPointSampler, float2(normTC, 0));
	float2 randTexInd = normedIds % float2(vecParams.x, vecParams.y);
	float2 oneTexSize = float2(1.f/vecParams.x, 1.f/vecParams.y);
	float4 texColor = tex2dFromAtlas(Input.texcoord.xy, float4(randTexInd*oneTexSize, oneTexSize));
	
	float alpha = Input.color.a  * texColor.a * spAlphaC;
	if (alpha < 1.0/255)
		discard;

	float3 diffuse = (texColor.rgb*texColor.rgb * Input.color.rgb*Input.color.rgb);
	float4 result = float4(shading_AmbientSun(diffuse.rgb, AmbientTop.rgb, 0.6*sunColor*gSunIntensity / 3.1415), alpha);	
	
	result.rgb = applyFog(result.rgb, gCameraPos, Input.worldPos.xyz);
	return result;
};

float4 psTranslucentFlir(PS_INPUT Input) : SV_TARGET0
{
	float spAlphaC = softParticlesAlpha(Input.screenTex, Input.depth);

	//TODO id должен иметь произвольное смещение при старте эффекта
	float normTC = (round(Input.texcoord[2]) % randTexSize.x)/randTexSize.x;
	float2 normedIds = randTex.Sample(WrapPointSampler, float2(normTC, 0));
	float2 randTexInd = normedIds % float2(vecParams.x, vecParams.y);
	float2 oneTexSize = float2(1.f/vecParams.x, 1.f/vecParams.y);
	float4 texColor = tex2dFromAtlas(Input.texcoord.xy, float4(randTexInd*oneTexSize, oneTexSize));
	
	float alpha = Input.color.a  * texColor.a * spAlphaC;
	if (alpha < 1.0/255)
		discard;

	float3 diffuse = (texColor.rgb*texColor.rgb * Input.color.rgb*Input.color.rgb);
	//float l = 10.0*luminance(Input.color.rgb*Input.color.rgb*min((1.0 + 0.8*gSunIntensity/8.0), 1.3))/2.0;
	float l = 10.0*luminance(Input.color.rgb*Input.color.rgb*(0.6 + 0.1*smoothstep(2.0, 20.0, gSunIntensity)*gSunIntensity))/2.0;
	return float4(l, l, l, alpha);

	float4 result = float4(shading_AmbientSun(diffuse.rgb, AmbientTop.rgb, 0.6*sunColor*gSunIntensity / 3.1415), alpha);	
	

	result.rgb = applyFog(result.rgb, gCameraPos, Input.worldPos.xyz);
	return result;
};