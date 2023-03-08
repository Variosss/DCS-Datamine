

struct PS_INPUT_DIRT
{
	noperspective float4 vPosition	:SV_POSITION;
	noperspective float4 vTexCoords	:TEXCOORD0;
	noperspective float4 wPos		:TEXCOORD1;
	noperspective float3 colorFactor:TEXCOORD2;
};

PS_INPUT_DIRT vsDirt(in float2 pos: POSITION0)
{
	float4 Pos = mul(float4(pos.x, pos.y, 1, 1), gProjInv);

	PS_INPUT_DIRT o;
	o.wPos.xyz = Pos.xyz/Pos.w;
	o.wPos.w = saturate((gSunDir.y+0.08)*20);
	o.vPosition = float4(pos, 0, 1);
	o.vTexCoords.xy = (float2(pos.x, -pos.y)*0.5+0.5)*viewport.zw + viewport.xy;
	o.vTexCoords.zw = pos.xy;
	o.colorFactor = LinearToScreenSpace(sunColor) * sbShadow * gSunIntensity * 0.2;
	return o;
}

float4 psDirt(in PS_INPUT_DIRT i): SV_TARGET0
{
	float4 res  = DiffuseMap.SampleLevel(gBilinearClampSampler, i.vTexCoords.xy, 0);
	float3 dirt = dirtTex.SampleLevel(gBilinearClampSampler, i.vTexCoords.xy, 0).rgb;
	
	float dotSun = dot(sunDirV, normalize(i.wPos.xyz));
	

	float3 bloom = bloomMap.SampleLevel(gBilinearClampSampler, i.vTexCoords.xy, 0).rgb;
	float3 lightAmount = i.colorFactor.rgb * pow(max(0, dotSun), 10);

	res.rgb += dirt * (lightAmount + LinearToScreenSpace(bloom)) * 0.05;//грязища

	return res;
}

