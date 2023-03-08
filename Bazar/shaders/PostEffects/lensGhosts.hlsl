static const float2 vertexData[4] = {
    float2( -1,  1),
    float2( 1,  1),
    float2( -1, -1),
    float2( 1, -1)
};

static const float4 ghostColors[] =
{
	float4(255/255.f, 153/255.f, 3/255.f, 1),//рыжий
	float4(0/255.f, 102/255.f, 255/255.f, 0.6),//голубой
	float4(9/255.f, 255/255.f, 133/255.f, 0.4),//зеленый
	float4(255/255.f, 96/255.f, 0/255.f,  1),//оранжевый
	float4(126/255.f, 0/255.f, 255/255.f, 1),//фиолетовый
};

struct PS_INPUT_GHOST 
{
	noperspective float4 vPosition	:SV_POSITION;
	noperspective float3 vTexCoords	:TEXCOORD0;// UV, dotViewSun, screenDistance
	noperspective float2 tcOffset	:TEXCOORD1; // float2 uvOffset,
	noperspective float3 color		:COLOR0;
};

struct PS_INPUT_SUN 
{
	float4 vPosition	:SV_POSITION;
	float4 vTexCoords	:TEXCOORD0;// UV, dotViewSun, luminance
};

PS_INPUT_GHOST vsGhost(in uint vertId: SV_VertexID, in uint instanceId: SV_InstanceID)
{
	#define SCALE sbGhosts[instanceId].coefs.y
	float opacityFadeout = (1-pow(max(0,gSunDirV.z-0.95)*20, 12));
	float sunPosScreenLength = length(sunPosScreen.xy);
	float2 sunDirScreen = sunPosScreen.xy / sunPosScreenLength;//направление на солнце на экране
	float dist = min(20, length(sunPosScreen.xy));//относительное расстояние солнца от центра экрана
	float coef = -sbGhosts[instanceId].coefs.x;// плюс - на солнце
	
	float2 vert = vertexData[vertId] * 0.14 * SCALE * (1 + 2*pow(max(0, gSunDirV.z), 40));
	
	PS_INPUT_GHOST res;
	res.vPosition = float4(vert.xy, 0.0, 1.0);
	res.vPosition.x /= viewportAspect;
	res.vTexCoords.xy = (vertexData[vertId]*0.6 + 0.5);//чтобы свиг для аберрации влезал в текстуру
	res.vTexCoords.z = pow(max(0,gSunDirV.z-0.1)*1.111, 3) * mad(opacityFadeout,0.9,0.1) * sbShadow;//opacity
	res.vTexCoords.z *= 0.15 * (1+0.65*(1-1.25*(SCALE-0.2)));

	res.vPosition.xy += sunDirScreen*coef*dist;
	float4 color = ghostColors[sbGhosts[instanceId].coefs.z];
	res.color = pow(sunColor, 1/2.2) * color.rgb;//linear to gamma space
	res.vTexCoords.z *= color.a;

	float aberrationDepth = min(1, length(res.vPosition.xy)) * (1.2-SCALE) * 0.08;//сила сдвига текстурных координат
	res.tcOffset.xy = min(1, sunPosScreen.xy) * mad(step(0,sbGhosts[instanceId].coefs.x), 2, -1) * aberrationDepth;	

	return res;
#undef SCALE
}

float4 psGhost(const PS_INPUT_GHOST i): SV_TARGET0 
{	
	float b = ghostTex.SampleLevel(gBilinearClampSampler, i.vTexCoords.xy, 0).a;
	float g = ghostTex.SampleLevel(gBilinearClampSampler, i.vTexCoords.xy + i.tcOffset.xy, 0).a;
	float r = ghostTex.SampleLevel(gBilinearClampSampler, i.vTexCoords.xy + i.tcOffset.xy * 2, 0).a;

	return float4( float3(r,g,b) * i.color.rgb, 1) * i.vTexCoords.z;
}

// SUN -------------------------------------------------------------------------------
PS_INPUT_SUN vsSun(in uint vertId: SV_VertexID)
{
	PS_INPUT_SUN res;
	float2 vert = vertexData[vertId] * 0.8 * (1 + 1.5*pow(max(0,gSunDirV.z),30));
	res.vPosition = float4(vert.x, vert.y, 0.0, 1.0);
	res.vPosition.x /= viewportAspect;
	res.vPosition.xy += sunPosScreen.xy;
	res.vTexCoords.xy = (vertexData[vertId]*0.5 + 0.5);	
	res.vTexCoords.z = min(1, pow(max(0, gSunDirV.z-0.1) * 1.111, 3) * sbShadow * 0.5);
	res.vTexCoords.w = 0.0;
	return res;
}

float4 psSun(const PS_INPUT_SUN i): SV_TARGET0
{
	float alpha = sunTex.SampleLevel(gBilinearClampSampler, i.vTexCoords.xy, 0).a;
	clip(alpha>0.02);
	return float4(LinearToScreenSpace(lerp(sunColor, 1, alpha*i.vTexCoords.w)), alpha*i.vTexCoords.z);
}

BlendState aberrationBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_COLOR;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};
