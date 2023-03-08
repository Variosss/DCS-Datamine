#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/softParticles.hlsl"
#include "ParticleEffects/SoftParticles.hlsl"

#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

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
	float	nAge	: TEXCOORD1;
};

struct PS_INPUT
{
	float4 pos		 : SV_POSITION;
	float4 projPos   : POSITION0;
	float3 normal	 : NORMAL;
	float4 TextureUV : TEXCOORD0; // UV, temperOffset, transparency
	nointerpolation float3 sunDirN: TEXCOORD3;
	nointerpolation float nAge: TEXCOORD4;
};

float offsetMax; // ������������� ���������� �������� �� ��� ��������
float radiusMax; // ������������ ������ �������� �������� ��� ������������ �������� �� ��� ��������
float scaleBase;	// ���������� ������� �������
float scaleJitter;	// ������� ��������� ��������� � ����������� �� �������� �� ��� �������� �� [scaleMin] �� [scaleMin + scaleJitter]
float curTime; // ����� ������������� ������� �������
float opacity;
float3 smokeColorBase; 

static const float opacityMax = 0.4;


static const float distMax = offsetMax + radiusMax; // ������������ ��������� �������� �������� �� ��� �������� � ������ ��������
static const float offsetMaxInv = 1/offsetMax; // 1/������� ������������� ���������� �������� �� ��� ��������
static const float qDistMaxInvResult = 1/(distMax*distMax); // 1/������� ������������� ���������� �������� �� ��� �������� c ������ ������� �������� 


VS_OUTPUT VS(float4 params		: TEXCOORD0, // dist, angle, random[0..1], age
			 float4 startPos	: TEXCOORD1, // ��������� ������� �������� � ������� ��
			 float4 startSpeedIn: TEXCOORD2, // ��������� �������� �������� � ������� ��, lifetime
			 float4 params2		: TEXCOORD3,// �����, ���������, angleOffset
			 float3 addSpeed	: TEXCOORD4,
			 uniform bool bFuelLeakage = false)
{
	#define freqency startPos.w
	#define lifetime startSpeedIn.w;
	#define DIST params.x
	#define ANGLE params.y
	#define RAND params.z //��������� ����� ��� ��������
	#define START_AGE params.w //����� ����� �������� � ��������
	#define WIND params2.xyz
	#define convectionSpeed params2.y
	#define angleOffset params2.w

	VS_OUTPUT o;
	float _sin, _cos;

	float3 windGround = float3(WIND.x, 0, WIND.z);
	float relativeTmpSpeed = length(startSpeedIn.xyz + addSpeed.xyz - windGround);
	const float nConv = 1-saturate(relativeTmpSpeed*3.6/60);	//���������
	WIND.y *= nConv;

	float3 emitterSpeedTrue = startSpeedIn.xyz;
	float3 particleSpeedRelative = emitterSpeedTrue + addSpeed.xyz - WIND;//��������� �������� �������� ������������ �����
	float speedValue = length(particleSpeedRelative);
	float emitterSpeedRelative  = length(emitterSpeedTrue - WIND);//�������� �������� ������������ �����

    const float age = max(0, curTime - START_AGE);
    const float nAge = age / lifetime;
	const float nSpeed2000 = min(1,speedValue*(1.0/555.5));//�������������� �������� �� 2000��/�
	//��������� ����������
	const float deceleration = lerp(25, 400, nSpeed2000);

	// ��������������� �������� �������� �������� � ��������� XZ
	sincos(ANGLE, _sin, _cos );
	const float3 offsetProj = float3(_sin, 0, _cos);
	
	//��������������� ����� �������� �������� � ������� ��������
	float nDist = DIST*offsetMaxInv;
	
	//������ ������ �������� � ���������, ���������� ����� ��� �������� � ��� ������
    sincos(angleOffset + freqency * age, _sin, _cos);
	const float3 offsetRot = radiusMax * nDist * (axisY*_sin + -offsetProj*_cos);

	// �������� �������� �������� �������� � XYZ ��������� �� � ������ ��������
	float3 posOffset = DIST*offsetProj + offsetRot;
	
	if(bFuelLeakage)
		posOffset *= 1 - nConv;

	// ��������� ����� ��������� �� Y � ������ ��������� �������� ��������
    const float ageCap = min(age, speedValue * rcp(deceleration)); // ��
	posOffset.y += (speedValue - 0.5*deceleration*ageCap)*ageCap;
	
	// ������� �������� ��������������� ����� �������� �������� �������� �� ��������� XZ
	nDist = dot(posOffset.xz, posOffset.xz) * qDistMaxInvResult;
	//nDist = (posOffset.x*posOffset.x + posOffset.z*posOffset.z) * qDistMaxInvResult;

	float3x3 speedBasis = basis(normalize(particleSpeedRelative));
	//��������� ������� � ������ �� � ���������� � ��������� �������
    o.pos.xyz = startPos.xyz + mul(posOffset, speedBasis) + WIND * age - worldOffset;

	if(!bFuelLeakage)
        o.pos.xz += float2(noise1D(RAND) - 0.5, noise1D(ANGLE) - 0.5) * age * 0.65; //��������� ������� ��������� ����� �� ���� ��� ��� �� ����� ������

	float scaleMin = 1 - 0.5*min(1, emitterSpeedRelative)*(1.25/27.77);// 20-100 km/h

	//������� �������
	emitterSpeedRelative = max(25.0, emitterSpeedRelative);
	float scale  =	scaleBase * 
					max(scaleMin+scaleJitter*nDist, 2*(scaleMin+scaleJitter*RAND) *
					(pow(nAge, 0.3))) * 
					(1 + 0.5*nAge*(1-saturate(emitterSpeedRelative/277.77-1)));
					
	if(bFuelLeakage)
		scale *= 1 - 0.9*nConv;

	const float rotateCoef = (1 - saturate(speedValue*(1.0/20.0)));
    o.pos.w = atan(age) * (RAND - 0.2) * (1 + 2 * rotateCoef) + 2 * PI * RAND + (step(PI, ANGLE) - 0.5) * age * 1; // angle

	//������������ ��������	
	/* fade-in ������������ � ����������� �� ��������, ��� ������ ��������, ��� ������ �� ��������� � ���������������� ������� ����� �������� ����� ��������*/
	const float speedOpacity = lerp(10*rcp(0.9 + 0.1*scaleBase), 1, nSpeed2000);
	const float speedConvOpacity =  30*rcp(0.95 + 0.05*scaleBase);//��������� ������� ������������ ��������� ��� ������� ��������

	o.params.z = saturate(nAge*lerp( speedOpacity, speedConvOpacity, nConv));// ���� � ��� ��� ���������, �� saturate(speedOpacity*nAge)	
	o.params.z = min(saturate((1-nAge)+1-nConv),  o.params.z * o.params.z * pow(abs(1-nAge*0.95), 1.5) * opacityMax);
	o.params.z = max(o.params.z, 0.275*(1.0-nAge));


	//scale *= 1.0/(o.params.z/opacityMax*5);

	o.params.xyw = float3(scale, step(0.5, RAND), 0);
	
	o.nAge = nAge;

    return o;   
}


// GEOMETRY SHADER ---------------------------------
[maxvertexcount(4)]
void GS(point VS_OUTPUT input[1], inout TriangleStream<PS_INPUT> outputStream, uniform bool bClouds)
{
	#define posOffset input[0].pos.xyz
	#define angle input[0].pos.w
	#define scale input[0].params.x
	#define Rand input[0].params.y

	PS_INPUT o;
	o.nAge = input[0].nAge;
	float2 sc;
	sincos(angle, sc.x, sc.y);
	sc *= scale;

	float2x2 M = {
	sc.y, sc.x,
	-sc.x,  sc.y};

	float4 vPos = mul(float4(posOffset,1), gView);
	vPos.xyz /= vPos.w;

	
	//float4 uvOffsetScale = getTextureFrameUV16x8(pow(input[0].nAge, 0.5)*(16*8-1));

	o.TextureUV.zw = input[0].params.zw;
	o.TextureUV.z *= saturate(vPos.z-1.3)*opacity;
	o.sunDirN = getSunDirInNormalMapSpace(rotMatrix2x2(angle));
	[unroll]
	for (int i = 0; i < 4; ++i)
	{	//UV
		o.TextureUV.xy = float2(staticVertexData[i].z + Rand, staticVertexData[i].w);
		//o.TextureUV.xy = staticVertexData[i].zw * uvOffsetScale.xy + uvOffsetScale.zw;
		//position
		float4 p = float4(mul(staticVertexData[i].xy, M), vPos.z, 1);
		o.normal.xyz = float3(p.xy, -0.6);
		p.xy += vPos.xy;
		o.projPos = mul(p, gProj);
		o.pos = o.projPos;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}


float4 PS(PS_INPUT i, uniform bool bAtmosphere, uniform bool bSoftParticle=false) : SV_TARGET0
{
	// float TRANSPARENCY = i.TextureUV.z;
	// float4 data = tex.Sample(gTrilinearClampSampler, i.TextureUV.xy);
	// data.xyz = data.xyz * 2 - 1.0;// convert from compressed format [0, 255] -> [-1.0, 1.0]
	// data.a *= saturate(TRANSPARENCY*1.4);
	// clip(data.a - 0.01);

	// float NoL = max(dot(data.xyz, i.sunDirN.xyz), 0)*0.8+0.2;
	// float ambient = max(dot(data.xyz, float3(0.0, 0.0, -1.0)), 0)*0.5+0.5;
	// float absorbed = 0.8;

	// 	//float3 s = texSmokeGradient.Sample(gTrilinearClampSampler, float2(min(pow(f, 1/2.0), 1.0), 0.5)).rgb;//*pow(i.isFireNAge.y, 0.5)*0.8;	
	// float3 finalColor = shading_AmbientSun(smokeColorBase, AmbientTop*ambient*absorbed, getPrecomputedSunColor(0)*NoL/PI*absorbed);
	// 	//finalColor += s;
	// data.a = applyDepthAlpha(data.a, i.projPos, 2.5);
	// return float4(applyPrecomputedAtmosphere(finalColor, 0), data.a);

	float TRANSPARENCY = i.TextureUV.z;

	float4 clrSmoke = tex.Sample(MirrorLinearSampler, i.TextureUV.xy).a;
	clrSmoke.a *= TRANSPARENCY * 1.1;
	clip(clrSmoke.a-0.01);

	float light = max(0, dot(normalize(i.normal.xyz), i.sunDirN));
	float dotSun = -gSunDirV.z*0.5 + 0.5;//TODO: ���������� �� ������� ��������
	float alphaParam = 1 - 10*clrSmoke.a;
	float haloFactor = saturate(pow((1-dotSun),5) * alphaParam*0.2);
	
#ifdef USE_DCS_DEFERRED
	float3 smokeColor = smokeColorBase * smokeColorBase * (2.0 - saturate((clrSmoke.a-0.02)*20.0));
	float3 sunColor = getPrecomputedSunColor(0) *light ;
	clrSmoke.rgb = shading_SunHalo(smokeColor, sunColor, haloFactor);
#else
	clrSmoke.rgb = smokeColorBase * 1.85 * (light*0.75 + 0.25) * (1-TRANSPARENCY);
	clrSmoke.rgb = lerp(clrSmoke.rgb, sunDiffuse,  haloFactor );
#endif
	
	if(bSoftParticle)
	{
	// 	clrSmoke.a *= depthAlpha(i.projPos, 1.0);
	}

	if(bAtmosphere)
		return float4(applyPrecomputedAtmosphereLerp(clrSmoke.rgb, 0, i.nAge), clrSmoke.a);

	return clrSmoke;
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

float4 PSFlir(PS_INPUT i, uniform bool bAtmosphere, uniform bool bSoftParticle=false) : SV_TARGET0
{
	float TRANSPARENCY = i.TextureUV.z;

	float4 clrSmoke = tex.Sample(MirrorLinearSampler, i.TextureUV.xy).a;
	clrSmoke.a *= TRANSPARENCY * 1.1;
	clip(clrSmoke.a-0.01);

	
	if(bSoftParticle)
	{
	// 	clrSmoke.a *= depthAlpha(i.projPos, 1.0);
	}

	if(bAtmosphere) {
		float l = 0.5*luminance(applyPrecomputedAtmosphereLerp(clrSmoke.rgb, 0, i.nAge));
		return float4(l, l, l, clrSmoke.a);
	}
	float l = 0.5*luminance(clrSmoke.rgb);

	return float4(l, l, l, clrSmoke.a);
}


float4 PSSteam(PS_INPUT i, uniform bool bAtmosphere, uniform bool bNormalTexture=false) : SV_TARGET0
{
	float TRANSPARENCY = i.TextureUV.z;

	
	float3 normal;
	float3 sunDir;
	float4 clr;
	if(bNormalTexture){
		float4 data = tex.Sample(MirrorLinearSampler, i.TextureUV.xy).rgba;  // normal + alpha
		clr = float4(1, 1, 1, data.a);

		normal.xyz  = data.xyz * 2 - 1.0;// convert from compressed format [0, 255] -> [-1.0, 1.0]
		sunDir = i.sunDirN;
	}
	else{
		clr = float4(1,1,1,	tex.Sample(MirrorLinearSampler, i.TextureUV.xy).a*TRANSPARENCY*0.8 );
		normal = i.normal;
		sunDir = gSunDirV;
	}
	clip(clr.a-0.01);

	float light = max(dot(normalize(normal), gSunDirV), 0.0) * 0.7 + 0.3;
	
	float dotSun = -gSunDirV.z*0.5 + 0.5;//TODO: ���������� �� ������� ��������
	float alphaParam = 1 - 10*clr.a;
	float haloFactor = saturate(pow(1 - dotSun, 5) * alphaParam);

#ifdef USE_DCS_DEFERRED
	float3 sunColor = getPrecomputedSunColor(0) * light;
	clr.rgb = shading_AmbientSunHalo(/*baseColor*/0.8, AmbientAverage, sunColor/PI, haloFactor);
#else
	clr.rgb *= lerp(AmbientTop*ambientAmount*0.5, gSunDiffuse.rgb*1.2, light);
	clr.rgb = lerp(clr.rgb, sunDiffuse, haloFactor);
#endif

	if(bAtmosphere)
		return float4(applyPrecomputedAtmosphereLerp(clr.rgb, 0, i.nAge), clr.a);

	return clr;
}

float4  PS_solid(PS_INPUT i) : SV_TARGET0
{
	return float4(i.TextureUV.zzz*2, 1);
}

VertexShader vsCompiled = CompileShader(vs_4_0, VS(false));
VertexShader vsFuelLeakageCompiled = CompileShader(vs_4_0, VS(true));

GeometryShader gsComp = CompileShader(gs_4_0, GS(false));
GeometryShader gsCloudsComp = CompileShader(gs_4_0, GS(true));

technique10 Solid
{
	pass P0
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PS_solid())
		ENABLE_RO_DEPTH_BUFFER;
		//ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass P0Flir
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PS_solid())
		ENABLE_RO_DEPTH_BUFFER;
		//ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass P1 {

	}
}

technique10 Textured
{
	pass main
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PS(false))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}
	
	pass mainFlir
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PSFlir(false))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass withClouds
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsCloudsComp);
		PIXEL_SHADER(PS(true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING; 
	}

	pass withCloudsFlir
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsCloudsComp);
		PIXEL_SHADER(PSFlir(true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING; 
	}

	pass softParticles
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PS(false, true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass softParticlesFlir
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PSFlir(false, true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass withCloudsSoftParticles
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsCloudsComp);
		PIXEL_SHADER(PS(true, true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass withCloudsSoftParticlesFlir
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsCloudsComp);
		PIXEL_SHADER(PSFlir(true, true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}



}



//��� �� ���������
technique10 TechSteam
{
	pass main
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PSSteam(false))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass mainFlir
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PSSteam(false))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass withClouds
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsCloudsComp);
		PIXEL_SHADER(PSSteam(true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING; 
	}


	pass withCloudsFlir
	{
		SetVertexShader(vsCompiled);
		SetGeometryShader(gsCloudsComp);
		PIXEL_SHADER(PSSteam(true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING; 
	}

}


//������/���� �������
technique10 TechFuelLeakage
{
	pass main
	{
		SetVertexShader(vsFuelLeakageCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PSSteam(false))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass mainFlir
	{
		SetVertexShader(vsFuelLeakageCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PSSteam(false))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass withClouds
	{
		SetVertexShader(vsFuelLeakageCompiled);
		SetGeometryShader(gsCloudsComp);
		PIXEL_SHADER(PSSteam(true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING; 
	}

	pass withCloudsFlir
	{
		SetVertexShader(vsFuelLeakageCompiled);
		SetGeometryShader(gsCloudsComp);
		PIXEL_SHADER(PSSteam(true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING; 
	}
}

//������/���� �������
technique10 TechLiquidLeakage
{
	pass main
	{
		SetVertexShader(vsFuelLeakageCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PSSteam(false, true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass mainFlir
	{
		SetVertexShader(vsFuelLeakageCompiled);
		SetGeometryShader(gsComp);
		PIXEL_SHADER(PSSteam(false, true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
	}

	pass withClouds
	{
		SetVertexShader(vsFuelLeakageCompiled);
		SetGeometryShader(gsCloudsComp);
		PIXEL_SHADER(PSSteam(true, true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING; 
	}

	pass withCloudsFlir
	{
		SetVertexShader(vsFuelLeakageCompiled);
		SetGeometryShader(gsCloudsComp);
		PIXEL_SHADER(PSSteam(true, true))
		
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING; 
	}


}
