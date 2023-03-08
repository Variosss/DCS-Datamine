#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/softParticles.hlsl"
#include "common/lightsCommon.hlsl"
#include "common/stencil.hlsl"
#include "ParticleEffects/SoftParticles.hlsl"
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

Texture2D texSmoke;
Texture2D texSmokeGradient;

SamplerState MirrorLinearSampler
{
	Filter        = MIN_MAG_MIP_LINEAR;
	AddressU      = MIRROR;
	AddressV      = MIRROR;
	AddressW      = MIRROR;
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	BorderColor   = float4(0, 0, 0, 0);
};

struct VS_OUTPUT
{
	float4	pos		: POSITION;
	float4	params	: TEXCOORD0;
	float4	nAgeAgeLightAttRelHeight	: TEXCOORD1;
	nointerpolation float isFire : TEXCOORD2;
};

struct PS_INPUT
{
	float4 pos		 : SV_POSITION;
	float4 normalLightAtt	 : NORMAL;
	float4 TextureUV : TEXCOORD0; // UV, temperOffset, transparency
	float4 sunDirM	 : TEXCOORD3;
	float4 projPos : POSITION0;
	nointerpolation float3 isFireNAgeHeight : TEXCOORD1;
};
float normalImportance;
float gFirePower;
float gOpacity;
float4 lightPosRadius;
float3 lightDiffuse;
float3 startOffset;
float lightScattering;
float gInvSoftParticleFactor;
float offsetMax; // максимального расстояния партикла от оси эмиттера
float radiusMax; // максимальный радиус вращения партикла при максимальном удалении от оси эмиттера
float smokeScaleBase;	// глобальный масштаб частицы
float fireScaleBase;	// глобальный масштаб частицы
// float smokeScaleJitter;	// разброс масштабов партиклов в зависимости от удаления от оси эмиттера от [scaleMin] до [scaleMin + smokeScaleJitter]
// float fireScaleJitter;	// разброс масштабов партиклов в зависимости от удаления от оси эмиттера от [scaleMin] до [scaleMin + smokeScaleJitter]

float curTime; // время существования системы частицы

static const float opacityMax = 0.4;
float3 smokeColorBase;// = float3(0.1, 0.12, 0.14)*1.4;


static const float distMax = offsetMax + radiusMax; // максимальное возможное удаление партикла от оси эмиттера с учетом вращения
static const float offsetMaxInv = 1/offsetMax; // 1/квадрат максимального расстояния партикла от оси эмиттера
static const float qDistMaxInvResult = 1/(distMax*distMax); // 1/квадрат максимального расстояния партикла от оси эмиттера c учетом радиуса поворота 


VS_OUTPUT VS
(			 float4 startPos	: TEXCOORD0, // начальная позиция партикла в мировой СК
			 float4 params		: TEXCOORD1, // dist, angle, random[0..1], age
			 float4 startSpeedIn: TEXCOORD2, // начальная скорость партикла в мировой СК, lifetime
			 float4 params2		: TEXCOORD3,// ветер, конвекция, angleOffset
			 float4 addSpeed	: TEXCOORD4,
			 float2 params3 : POSITION0, 
			 uniform bool bFuelLeakage = false, 
			 uniform bool bCar = false)
{
	#define freqency startPos.w
	#define lifetime startSpeedIn.w;
	#define DIST params.x
	#define ANGLE params.y
	#define RAND params.z //рандомное число для партикла
	#define START_AGE params.w //время жизни партикла в секундах
	#define WIND params2.xyz
	#define convectionSpeed params2.y
	#define angleOffset params2.w
	float deceleration = params3.x;
	float scaleJitter = params3.y;
	VS_OUTPUT o;
	float _sin, _cos;

	float3 windGround = float3(WIND.x, 0, WIND.z);
	float relativeTmpSpeed = length(startSpeedIn.xyz + addSpeed.xyz - windGround);
	const float nConv = 1-saturate(relativeTmpSpeed*3.6/60);	//конвекция
	WIND.y *= nConv;

	float3 emitterSpeedTrue = startSpeedIn.xyz;
	float3 particleSpeedRelative;
	if (bCar)
		particleSpeedRelative = (emitterSpeedTrue + addSpeed.xyz + 0.00001 + float3(0.0, 12.0, 0.0));
	else 
		particleSpeedRelative = emitterSpeedTrue + addSpeed.xyz + 0.00001;//стартовая скорость партикла относительно ветра
	float speedValue = length(particleSpeedRelative);

    const float age = (curTime - START_AGE);
    const float nAge = age / lifetime;
	float scaleBaseTrue = (addSpeed.w == 1.0) ? fireScaleBase*1.1 : smokeScaleBase*0.75;

	// нормализованная проекция смещения партикла в плоскости XZ
	sincos(ANGLE, _sin, _cos );
	const float3 offsetProj = float3(_sin, 0, _cos);
	
	//нормализованная длина проекции партикла к радиусу эмиттера
	float nDist = DIST*offsetMaxInv;

	float3 offsetRot;
	
	//крутим вектор проекции в плоскости, проходящей через ось эмиттера и сам вектор
    sincos(angleOffset + freqency * age, _sin, _cos);
	offsetRot = radiusMax * nDist * (axisY*_sin + -offsetProj*_cos);
	

	float cNAge = 0.75;
	// получаем итоговое смещение партикла в XYZ локальной СК с учетом вращения
	float3 posOffset;
	posOffset = lerp(age*0.75, 1.0, saturate(speedValue+addSpeed.w)+addSpeed.w*15*nAge)*DIST*offsetProj*scaleBaseTrue*scaleJitter*0.08 + offsetRot;	
	//posOffset = 0;
	if(bFuelLeakage)
		posOffset *= 1 - nConv;

	// вычисляем новое положение по Y с учетом изменения скорости партикла
    
	float ageCap = speedValue/deceleration;
	if (age < ageCap)
	{
		ageCap = age;
	}

	if (bCar)
		posOffset.y += (0.2*speedValue - 0.1*deceleration*ageCap)*ageCap;
	else 
		posOffset.y += (speedValue - 0.5*deceleration*ageCap)*ageCap;	
	// считаем итоговую нормализованную длину проекции смещения партикла на плоскость XZ
	nDist = dot(posOffset.xz, posOffset.xz) * qDistMaxInvResult;
	float3x3 speedBasis = basis(normalize(particleSpeedRelative));


	float wSpeed = length(WIND);
	float3 newWind = normalize(WIND);
	if ( length (newWind.xz) > 0.95)
		newWind.y = 0.22;

	newWind = normalize(newWind);
	
	if (bCar)
		 o.pos.xyz = startPos.xyz + mul(posOffset, speedBasis) + wSpeed*newWind * age;
	else 
		o.pos.xyz = startPos.xyz + mul(posOffset, speedBasis) + WIND * age;


	float3 lightDir = (lightPosRadius.xyz - o.pos.xyz);
	float lightAtt = distAttenuation(lightPosRadius.w, length(lightDir));

	float l = length(o.pos.xyz+startOffset);
	o.pos.xyz -= worldOffset; // 

	if(!bFuelLeakage)
        o.pos.xz += float2(noise1D(RAND) - 0.5, noise1D(ANGLE) - 0.5) * age * 0.65; //рандомный разброс партиклов чтобы на емле дым был не таким ровным

	float scaleMin = scaleBaseTrue*2;// 20-100 km/h
	
	float scale;
	scale  = scaleBaseTrue;
	float nAgeT = nAge;
	if(addSpeed.w != 1.0){
		scale *=  saturate(age*1.0)*4.5;
		float newNAge = ((curTime - START_AGE)-1)/lifetime;
		nAgeT = saturate(newNAge)+age*0.3;
	}	
	scale += (scaleMin+scaleBaseTrue*scaleJitter*(RAND*0.8+0.2))*nAgeT;


	const float rotateCoef = (1 - saturate(speedValue*(1.0/20.0)));
    o.pos.w = atan(age) * (RAND - 0.2) * (1 + 2 * rotateCoef) + 2 * PI * RAND + (step(PI, ANGLE) - 0.5) * age * 1; // angle

	//прозрачность партикла	
	/* fade-in прозрачность в зависимости от скорости, чем меньше скорость, тем короче по отношению к нормализованному времени жизни партикла длина перехода*/
	const float nSpeed2000 = min(1,speedValue*(1.0/555.5));//нормализованая скорость до 2000км/ч
	const float speedOpacity = lerp(10*rcp(0.9 + 0.1*scaleBaseTrue), 1, nSpeed2000);
	const float speedConvOpacity =  30*rcp(0.95 + 0.05*scaleBaseTrue);//начальное условие прозрачности партиклов при нулевой скорости

	o.params.z = saturate(nAge*lerp(speedOpacity, speedConvOpacity, nConv));// если у нас нет конвекции, то saturate(speedOpacity*nAge)	
	o.params.z =  o.params.z * o.params.z * pow(abs(1-nAge), 1.5) * opacityMax/(age*0.15);
	
	 o.params.xyw = float3(scale, step(0.5, RAND), 0);


	o.nAgeAgeLightAttRelHeight = float4(nAge, age, lightAtt, l);

	o.isFire = addSpeed.w;

    return o;   
}

// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream)
{
	#define posOffset input[0].pos.xyz
	#define angle input[0].pos.w
	#define scale input[0].params.x
	#define Rand input[0].params.y

	PS_INPUT o;

	float2 sc;
	sincos(angle, sc.x, sc.y);
	sc *= scale;

	float2x2 M = {
	sc.y, sc.x,
	-sc.x,  sc.y};

	float4 vPos = mul(float4(posOffset,1), gView);
	vPos.xyz /= vPos.w;

	o.TextureUV.zw = input[0].params.zw;
	o.TextureUV.z *= saturate(vPos.z-1.3);
	float nAge = input[0].nAgeAgeLightAttRelHeight.x;
	
	if(input[0].isFire == 1.0f){
		if(nAge > 0.60){
			o.TextureUV.z =saturate((0.23-(nAge-0.60))/0.4);
			
		}
		else{
			o.TextureUV.z = 1.0f;
		}
		
	}

	o.isFireNAgeHeight.x = input[0].isFire;
	o.isFireNAgeHeight.y = input[0].nAgeAgeLightAttRelHeight.x;
	o.isFireNAgeHeight.z = input[0].nAgeAgeLightAttRelHeight.w;
	o.sunDirM = float4(-getSunDirInNormalMapSpace(rotMatrix2x2(angle)), getHaloFactor(gSunDirV.xyz, posOffset, 10) * 0.21 * 0.7);

	
	float4 uvOffsetScale = (input[0].isFire == 1.0) ? 
	getTextureFrameUV8x8(min(pow((input[0].nAgeAgeLightAttRelHeight.x-0.35)/0.65*2.0, 0.5)*63, 63)) :
	getTextureFrameUV16x8(pow(input[0].nAgeAgeLightAttRelHeight.x, 0.5)*(16*8-1));

	[unroll]
	for (int i = 0; i < 4; ++i)
	{	//UV
		o.TextureUV.xy = staticVertexData[i].zw * uvOffsetScale.xy + uvOffsetScale.zw;
		//position
		float4 p = float4(mul(staticVertexData[i].xy, M), vPos.z, 1);
		o.normalLightAtt.xyz = float3(p.xy, -0.6);
		o.normalLightAtt.w = input[0].nAgeAgeLightAttRelHeight.z;
		p.xy += vPos.xy;
		o.pos = mul(p, gProj);
		o.projPos = o.pos;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}



static const float3 fireTint = float3(1.0, 0.655, 0.4455);
static const float3 fireTintCold = float3(1.0, 0.4655, 0.3355);


float4 PS(PS_INPUT i, uniform bool bClouds) : SV_TARGET0
{
	
	float nAge = i.isFireNAgeHeight.y;
	//return float4(nAge, 0.0, 0.0, 1.0);
	if(i.isFireNAgeHeight.x == 1.0)
	{
	
	
		float TRANSPARENCY = i.TextureUV.z*0.5;
		float4 clrFire = tex.Sample(gTrilinearClampSampler, i.TextureUV.xy).rgba;
		clrFire.rgb *= clrFire.rgb;
		clrFire.a  *= clrFire.a;
	 	clip(clrFire.a*TRANSPARENCY - 0.01);
		//clrFire.rgb  = 0;
		//clrFire.rgb = fireColor*fireColor;
		
	 	clrFire.rgb *= lerp(fireTintCold*fireTintCold, fireTint*fireTint, min(1, clrFire.a*clrFire.a*1.5))*10.0*gFirePower;
	 	clrFire.rgb *= 1.0 + pow(1.0-i.isFireNAgeHeight.y, 3)*4;
	 	clrFire *= clrFire.a*TRANSPARENCY;
		clrFire.r *= clamp(1.0/clrFire.a*TRANSPARENCY, 1.0, 2.0);
		

		float d = clrFire.a*(gInvSoftParticleFactor+(-gInvSoftParticleFactor*2+1.0)*depthAlpha(i.projPos, 0.7));

		//d = 1.0f;
		clrFire.a *= d;
		clip(d - 0.001);
	 	return float4(clrFire.rgb* d, clrFire.a*TRANSPARENCY);	
		 
	}
	else
	{
		
		float TRANSPARENCY = i.TextureUV.z*gOpacity*2.0;
		float4 data = texSmoke.Sample(gTrilinearClampSampler, i.TextureUV.xy);
		data.xyz = data.xyz * 2 - 1.0;// convert from compressed format [0, 255] -> [-1.0, 1.0]

		data.a *= saturate(TRANSPARENCY*8);
	    data.a = applyDepthAlpha(data.a, i.projPos, 1.0);
		clip(data.a - 0.001);
		float k = lerp(1.0, 0.4, nAge);
		float NoL = max(dot(data.xyz, i.sunDirM.xyz), 0)*normalImportance*k+(1.0-normalImportance*k);
		float cof = 0.7*k;
		float ambient = max(dot(data.xyz, float3(0.0, 0.0, -1.0)), 0)*cof+(1.0-cof);
		float absorbed = 0.55;
		
		float3 finalColor = shading_AmbientSun(smokeColorBase, AmbientTop*ambient*absorbed, getPrecomputedSunColor(0)*NoL/PI*absorbed);
		// float3 finalColor = shading_AmbientSun(smokeColorBase, AmbientTop*ambient*absorbed, 1*NoL/PI*absorbed);
		finalColor = applyPrecomputedAtmosphere(finalColor, 0);

		//FIXME: make it for hybridAlphaBlend
		// if(bClouds)
		// 	applyCloudsColor(finalColor, getCloudsColorLerp(nAge));

		return float4(finalColor*data.a, data.a);
	}
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}


float4 PSFLIR(PS_INPUT i, uniform bool bClouds) : SV_TARGET0
{
	
	float nAge = i.isFireNAgeHeight.y;
	//return float4(nAge, 0.0, 0.0, 1.0);
	if(i.isFireNAgeHeight.x == 1.0)
	{
	
	
		float TRANSPARENCY = i.TextureUV.z*0.5;
		float4 clrFire = tex.Sample(gTrilinearClampSampler, i.TextureUV.xy).rgba;
		clrFire.rgb *= clrFire.rgb;
		clrFire.a  *= clrFire.a;
	 	clip(clrFire.a*TRANSPARENCY - 0.01);
		//clrFire.rgb  = 0;
		//clrFire.rgb = fireColor*fireColor;
		
	 	clrFire.rgb *= lerp(fireTintCold*fireTintCold, fireTint*fireTint, min(1, clrFire.a*clrFire.a*1.5))*10.0*gFirePower;
	 	clrFire.rgb *= 1.0 + pow(1.0-i.isFireNAgeHeight.y, 3)*4;
	 	clrFire *= clrFire.a*TRANSPARENCY;
		clrFire.r *= clamp(1.0/clrFire.a*TRANSPARENCY, 1.0, 2.0);
	
		float d = clrFire.a*(gInvSoftParticleFactor+(-gInvSoftParticleFactor*2+1.0)*depthAlpha(i.projPos, 0.7));

		//d = 1.0f;
		
		clrFire.a *= d;
		clip(d - 0.001);
		float l = luminance( clrFire.rgb* d);
	 	return float4(l, l,l , clrFire.a*TRANSPARENCY);	
		 
	}
	else
	{
		
		float TRANSPARENCY = i.TextureUV.z*gOpacity*2.0;
		float4 data = texSmoke.Sample(gTrilinearClampSampler, i.TextureUV.xy);
		data.xyz = data.xyz * 2 - 1.0;// convert from compressed format [0, 255] -> [-1.0, 1.0]

		data.a *= saturate(TRANSPARENCY*8);
	    data.a = applyDepthAlpha(data.a, i.projPos, 1.0);
		clip(data.a - 0.001);
		float k = lerp(1.0, 0.4, nAge);
		float NoL = max(dot(data.xyz, i.sunDirM.xyz), 0)*normalImportance*k+(1.0-normalImportance*k);
		float cof = 0.7*k;
		float ambient = max(dot(data.xyz, float3(0.0, 0.0, -1.0)), 0)*cof+(1.0-cof);
		float absorbed = 0.55;
		
		float3 finalColor = shading_AmbientSun(smokeColorBase, AmbientTop*ambient*absorbed, getPrecomputedSunColor(0)*NoL/PI*absorbed);
		finalColor.rgb += (sqrt(1.0-nAge)+0.1)*0.3*(NoL*0.7+0.3);
		

		// float3 finalColor = shading_AmbientSun(smokeColorBase, AmbientTop*ambient*absorbed, 1*NoL/PI*absorbed);
		finalColor = applyPrecomputedAtmosphere(finalColor, 0);

		//FIXME: make it for hybridAlphaBlend
		// if(bClouds)
		// 	applyCloudsColor(finalColor, getCloudsColorLerp(nAge));
			float l = luminance(finalColor*data.a);

		return float4(l, l, l, data.a);
	}
}



BlendState hybridAlphaBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = ZERO;
	DestBlendAlpha = INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};


technique10 Textured
{
	pass main
	{
		SetVertexShader( CompileShader(vs_4_0, VS()));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PS(false)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainWithClouds
	{
		SetVertexShader( CompileShader(vs_4_0, VS()));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PS(true)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainFLIR
	{
		SetVertexShader( CompileShader(vs_4_0, VS()));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PSFLIR(false)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainWithCloudsFLIR
	{
		SetVertexShader( CompileShader(vs_4_0, VS()));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PSFLIR(true)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}


	pass mainCar
	{
		SetVertexShader( CompileShader(vs_4_0, VS(false, true)));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PS(false)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainWithCloudsCar
	{
		SetVertexShader( CompileShader(vs_4_0, VS(false, true)));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PS(true)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainFLIRCar
	{
		SetVertexShader( CompileShader(vs_4_0, VS(false, true)));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PSFLIR(false)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainWithCloudsFLIRCar
	{
		SetVertexShader( CompileShader(vs_4_0, VS(false, true)));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PSFLIR(true)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}


}

technique10 TextureMFD
{
	pass main
	{
		SetVertexShader( CompileShader(vs_4_0, VS()));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PS(false)));
		
		ENABLE_RO_DEPTH_BUFFER;
		//ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainWithClouds
	{
		SetVertexShader( CompileShader(vs_4_0, VS()));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PS(true)));
		
		ENABLE_RO_DEPTH_BUFFER;
		//ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}

		pass mainFLIR
	{
		SetVertexShader( CompileShader(vs_4_0, VS()));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PSFLIR(false)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainWithCloudsFLIR
	{
		SetVertexShader( CompileShader(vs_4_0, VS()));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PSFLIR(true)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}


	pass mainCar
	{
		SetVertexShader( CompileShader(vs_4_0, VS(false, true)));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PS(false)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainWithCloudsCar
	{
		SetVertexShader( CompileShader(vs_4_0, VS(false, true)));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PS(true)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainFLIRCar
	{
		SetVertexShader( CompileShader(vs_4_0, VS(false, true)));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PSFLIR(false)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}
	pass mainWithCloudsFLIRCar
	{
		SetVertexShader( CompileShader(vs_4_0, VS(false, true)));
		SetGeometryShader( CompileShader(gs_4_0, GS()));
		SetPixelShader( CompileShader(ps_4_0, PSFLIR(true)));
		
			//ENABLE_RO_DEPTH_BUFFER;
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(hybridAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		DISABLE_CULLING;
	}


}
