#include "common/samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "deferred/atmosphere.hlsl"
#include "ParticleSystem2/common/psShading.hlsl"

Texture3D NoiseMap;	//0
Texture2D NormalMap;//1

float4x4 WVP;
float4x4 VP;
float4x4 c1;//World
float4x4 c9;
float4 c8; //eye pos
float alpha;

//static const float3 light0color = {0.9, 0.4, 0.1};

//static const float3 light0color = {0.59, 0.59, 0.75};

static const float3 light0pos = {0,0,0};
float3 light0atten;

//static const float3 light1color = {0.36, 0.25, 0.10}; //Adjusts color of the dust

//static const float3 light1color = {1.0, 1.0, 1.0}; //Adjusts color of the dust

//float3 light1color = {0.50, 0.59, 0.75};
float3 light1color;

static const float3 light0color = light1color;

float3 light1dir;// = {0,1,0}; //������ � �� ������
float3 sunDirW;
float time;

float frequency;
float noiseVariance;

float3 ambientColor;
//float4 p2;

static const float scale = 2.0;
static const float noiseScale = 1;

static const float4 vCorners[4] = {{-0.5f, -0.5f, 0, 0},
									{0.5f, -0.5f, 0, 0},
									{0.5f, 0.5f, 0, 0},
									{-0.5f, 0.5f, 0, 0 }};

static const float2 vCorners2[4] = {{0, 0},
									{1, 0},
									{1, 1},
									{0, 1}};

struct VertexInOp{
	float3 vPosition		: POSITION0;
	float pSize				: PSIZE0;
	float pColor			: COLOR0;
};

struct PFXDustOut{
	float4 vPosition		: SV_POSITION0;
	float4 vColor0			: COLOR0;
	float4 vColor1			: COLOR1; //sun color * brightness
	float3 vTexCoord0		: TEXCOORD0;
	float2 vTexCoord1		: TEXCOORD1;
	float3 vTexCoord2		: TEXCOORD2;
	float3 vTexCoord3		: TEXCOORD3;
};

float getSunBrightness()
{
	return max(0.05, 0.666*(0.5 + sunDirW.y));
}

PFXDustOut vsPFXDustMaterial(const in VertexInOp i, uint vertId: SV_VertexID){
	PFXDustOut o;
	
	float4 c24 = float4(0, 1, 0, 0);
	float4 c23 = float4(0.5, 0, 0, 0);
	
	float4 pos, r2, r3, r4, r5;

	float3 r1;// = {0,0,0};
	//float4 r3 = {0,0,0,1};
	
	o.vColor1.xyz = light1color * getSunBrightness();
	o.vColor1.w = saturate((sunDirW.y+0.05)*10);//��������� ��������
	
	uint index = vertId % 4;
	r2 = vCorners[index] + 0.5;

	o.vTexCoord1 = r2.xy;

	pos.xyz = i.vPosition.xyz * noiseVariance;
	pos = r2.xyyy * frequency + pos.xyzz;
	o.vTexCoord0.xyz = float3(pos.xy, pos.z + time);

	r3.xyz = normalize(i.vPosition - c8.xyz); 	// viewDir = pos - (camPos in model space)
	r2.xyz = float3(r3.z,0, -r3.x);				// side
	r2.w = length(r2.xyz);
	r2.xyz /= r2.w;//normalize
	r1 = normalize(cross(r3.xyz, r2.xyz)); 		// up
	pos.xyz = i.vPosition.xyz + (r1*vCorners[index].y + r2.xyz*vCorners[index].x)*i.pSize; // position in LOCAL CoordSys

	r5.xyz = normalize(light0pos - pos.xyz);

	float3x3 M = {r3.xyz, r1.xyz, r2.xyz};
	o.vTexCoord2.xyz = mul(M, r5.xyz)*0.5 + 0.5;
	o.vTexCoord3.xyz = mul(M, light1dir)*0.5 + 0.5;
	
	r1.xy = float2(light0atten.y * r2.w + light0atten.x, light0atten.z * r2.w);
	r1.x = r1.y * r2.w + r1.x;
	o.vColor0.xyz = light0color * rcp(r1.x);
	o.vColor0.xyz *= max(0, 1-time*5);//������� ��� ���� �� �����, ��� ����� �� ������, � ������� �������� �������� � �������
	o.vColor0.w = alpha;
	o.vColor0 = saturate(o.vColor0);
	pos.w = 1;
	
	o.vPosition = mul(pos, WVP);	

	return o;
}

float4 getTextureFrameUV16x8(uint phase)
{
	float4 uvOffsetScale;
	uvOffsetScale.xy = float2(1.0/16.0, 1.0/8.0);
	uvOffsetScale.zw = uvOffsetScale.xy * float2((float)(phase & 15), (float)((phase>>4) & 7) );
	return uvOffsetScale;
}

PFXDustOut vsPFXDustMaterialOP(const in VertexInOp i, uint vertId: SV_VertexID)
{
	PFXDustOut o;
	
	float4 c24 = float4(0, 1, 0, 0);
	float4 c23 = float4(0.5, 0, 0, 0);
	
	float4 pos, r2, r4, r5;
	float3 r1 = {0,0,0};
	float4 r3 = {0,0,0,0};
	
	o.vColor1.xyz = light1color * getSunBrightness();
	o.vColor1.w = saturate((sunDirW.y+0.05)*10);//��������� ��������

	uint index = vertId % 4;
	r2 = vCorners[index] + 0.5;
	//o.vTexCoord1 = r2.xy;
	float4 uvOffset = getTextureFrameUV16x8(pow(i.pSize, 0.5)*0.16*(128)%128);
	o.vTexCoord1 = uvOffset.zw+vCorners2[index]*uvOffset.xy;

	pos.xyz = i.vPosition.xyz * noiseVariance;
	pos = r2.xyyy * frequency + pos.xyzz;
	o.vTexCoord0.xyz = float3(pos.xy, pos.z + time);
	
	r3.xyz = normalize(i.vPosition - c8.xyz); 	// viewDir = pos - (camPos in model space)
	r2.xyz = float3(r3.z,0, -r3.x);	// side
	r2.w = length(r2.xyz);
	r2.xyz /= r2.w;//normalize
	r1 = normalize(cross(r3.xyz, r2.xyz));		// up
	
	pos.xyz = i.vPosition.xyz + (r1*vCorners[index].y + r2.xyz*vCorners[index].x)*i.pSize; // position in LOCAL CoordSys
	
	r5.xyz = normalize(light0pos - pos.xyz);

	float3x3 M = {r3.xyz, r1.xyz, r2.xyz};
	o.vTexCoord2.xyz = mul(M, r5.xyz)*0.5 + 0.5;
	o.vTexCoord3.xyz = mul(M, light1dir)*0.5 + 0.5;	
	r1.xy = float2(light0atten.y * r2.w + light0atten.x, light0atten.z * r2.w);	
	r1.x = r1.y * r2.w + r1.x;	
	// o.vColor0.xyz = light0color * rcp(r1.x);
	// o.vColor0.xyz *= max(0, 1-time*6);
	o.vColor0 = 0;
	o.vColor0.w = saturate(alpha * i.pColor);
	pos.w = 1;
	o.vPosition = mul(pos, WVP);

	return o;
}

float4 psPFXDustMaterial(const in PFXDustOut i) : SV_TARGET0 
{
	float4 t0 = NoiseMap.Sample(WrapLinearSampler, float3(i.vTexCoord0.xy, i.vTexCoord0.z));
	float4 normal = NormalMap.Sample(ClampLinearSampler, i.vTexCoord1);
	normal.xyz = normal.xyz*2 - 1;
	
	float3 lightDir = normalize(i.vTexCoord2*2-1);//light in model space
	float3 sunDir = normalize(i.vTexCoord3*2-1);//sun in model space

	float dotLight = max(0, dot(lightDir, normal)*0.5+0.5);
	float dotSun   = max(0, dot(sunDir, normal)*0.4+0.6);

	//const float3 smokeAlbedo = 0.25 * light1color;
	const float3 smokeAlbedo = 0.2 * light1color;

	float4 res = 0;
	res.rgb = shading_AmbientSun(smokeAlbedo/3.1415, AmbientAverage.rgb, gSunDiffuse.rgb * dotSun * gSunIntensity); //Adjust the multiplier 0.4 at the front for brightness.  0.12 adjusts shading.
	// res.rgb += i.vColor0.rgb * dotLight * 1.0; //light from the effect center
	res.a = 0.9*(saturate(normal.a - t0.a*noiseScale)*i.vColor0.a); //Adjust multiplier at the front for opacity.

	return res;
}

TECHNIQUE PFXDustMaterial{
	pass P0{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ENABLE_ALPHA_BLEND;
		VERTEX_SHADER(vsPFXDustMaterial())
		PIXEL_SHADER(psPFXDustMaterial())
		GEOMETRY_SHADER_PLUG
	}
}

TECHNIQUE PFXDustMaterialOP{
	pass P0{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ENABLE_ALPHA_BLEND;
		VERTEX_SHADER(vsPFXDustMaterialOP())
		PIXEL_SHADER(psPFXDustMaterial())
		GEOMETRY_SHADER_PLUG
	}
}
