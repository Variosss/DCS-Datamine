static const float4 fireOff = float4(0,0,0.5,0.5);
static const float4 noiseOff = float4(0,0.5,0.25,0.25);
static const float4 fogOff = float4(0.5,0.0,0.5,0.5);
static const float4 grad1Off = float4(0.25,0.5,0.125,0.125);
static const float4 grad2Off = float4(0.375,0.5,0.125,0.125);

float4 psAnimatedFire(PS_INPUT Input) : SV_TARGET0
{
	float spAlphaC = softParticlesAlpha(Input.screenTex, Input.depth);

	float2 firetc = texMoveOffset(Input.texcoord, float2(-0.3, vecParams[0]), lifeTime+0.3235*Input.texcoord[2]);
	float2 noisetc = texMoveOffset(Input.texcoord, float2(0.3, vecParams[0]), lifeTime+0.3235*Input.texcoord[2]);

	float4 baseC = tex2dFromAtlas(firetc, fireOff);
	float alpha = tex2dFromAtlas(noisetc, noiseOff);
	float gradSmallC = tex2dFromAtlas(Input.texcoord, grad1Off).r;
	float gradBigC = tex2dFromAtlas(Input.texcoord, grad2Off).r;
	alpha = lerp(gradSmallC, gradBigC, alpha);
	alpha *= tex2dFromAtlas(Input.texcoord, fogOff).r;
	alpha *= baseC.r*spAlphaC;

	float4 result = float4(baseC.rgb*1.5, alpha) * Input.color;	
	result.rgb = applyFog(result.rgb, gCameraPos, Input.worldPos.xyz);
	return result;
}

float4 psAnimatedFireFlir(PS_INPUT Input) : SV_TARGET0
{
	float spAlphaC = softParticlesAlpha(Input.screenTex, Input.depth);

	float2 firetc = texMoveOffset(Input.texcoord, float2(-0.3, vecParams[0]), lifeTime+0.3235*Input.texcoord[2]);
	float2 noisetc = texMoveOffset(Input.texcoord, float2(0.3, vecParams[0]), lifeTime+0.3235*Input.texcoord[2]);

	float4 baseC = tex2dFromAtlas(firetc, fireOff);
	float alpha = tex2dFromAtlas(noisetc, noiseOff);
	float gradSmallC = tex2dFromAtlas(Input.texcoord, grad1Off).r;
	float gradBigC = tex2dFromAtlas(Input.texcoord, grad2Off).r;
	alpha = lerp(gradSmallC, gradBigC, alpha);
	alpha *= tex2dFromAtlas(Input.texcoord, fogOff).r;
	alpha *= baseC.r*spAlphaC;

	float l = luminance(applyFog(Input.color.rgb*baseC.rgb*1.5, gCameraPos, Input.worldPos.xyz))/2.0;
	return float4(l, l, l, alpha);

	float4 result = float4(baseC.rgb*1.5, alpha) * Input.color;	
	result.rgb = applyFog(result.rgb, gCameraPos, Input.worldPos.xyz);
	return result;
}


