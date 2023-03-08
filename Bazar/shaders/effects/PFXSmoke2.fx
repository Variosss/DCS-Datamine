#include "common/samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/atmosphereSamples.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"
#include "ParticleSystem2/common/psShading.hlsl"

Texture3D NoiseMap;	//0
Texture2D NormalMap;//1

float c4[16];
float4x4 c0;
float4x4 c1;
//float4x4 c9;
float4 c8;

float4 c14;
float4 c15;
float4 c16;
float4 c17;
float4 c18;
float4 c19;
float4 c20;
float frequency;
float4 c22;

float4 p0;
float4 p2;

float particleScale;
float opacity;

#define lightColor0		c15.rgb
#define lightColor1		c18.rgb
#define lightAmbient	p0.rgb
#define particleColor	p2.rgb

static const float scale = 2;

// struct VertexIn{
	// float3 vPosition		: POSITION;
	// float pSize				: PSIZE;
	// float4 vTexCoord		: TEXCOORD0;
// };

struct VertexInOp{
	float3 vPosition		: POSITION0;
	float pSize				: PSIZE0;
	float pColor			: COLOR0;
	float4 vTexCoord		: TEXCOORD0;
};

struct PFXSmoke2Out{
	float4 vPosition		: SV_POSITION0;
	float4 vColor0			: COLOR0;
	// float3 vColor1			: COLOR1;
	float4 vTexCoord0		: TEXCOORD0;
	float4 vTexCoord1		: TEXCOORD1;
	float4 vTexCoord2		: TEXCOORD2;
	float3 vTexCoord3		: TEXCOORD3;
};



PFXSmoke2Out vsPFXSmoke2Material(const in VertexInOp i, uniform bool clouds){
	PFXSmoke2Out o;
	
	float4 c24 = {0, 1, 0, 0};
	float4 c23 = {0.5, 0, 0, 0};
	
	float4 r0, r1, r2, r3, r4, r5;
	
	// o.vColor1.xyz = c18.xyz;
	r1.w = 0.5;
	int index = i.vTexCoord.x;
	r2 = float4(c4[index * 4 + 0], c4[index * 4 + 1], c4[index * 4 + 1], c4[index * 4 + 1]) + 0.5;
	o.vTexCoord1.xy = r2.xy;
	r0.xyz = i.vPosition.xyz * c22.xxx;
	r0 = r2.xyyy * frequency + r0.xyzz;
	o.vTexCoord0.xyz = float3(r0.xy, r0.z + c20.x);

	r3.xyz = normalize(i.vPosition.xyz - c8.xyz);
	r2.xyz = normalize(float3(r3.z,0,-r3.x));
	r1.xyz = normalize(cross(r3.xyz, r2.xyz));
	//r0.xyz = r1.xyz * c4[index * 4 + 1];
	//r0.xyz = r2.xyz * c4[index * 4 + 0] + r0.xyz;
	//r0.xyz = r0.xyz * i.pSize;								
	//r0.xyz = r0.xyz * scale + i.vPosition.xyz;	
	r0.xyz = i.vPosition.xyz + (r1.xyz*c4[index*4 + 1] + r2.xyz*c4[index*4 + 0])*i.pSize*scale*particleScale;
	
	r4.xyz = c16.xyz - r0.xyz;
	r2.w = dot(r4.xyz, r4.xyz);
	r2.w = 1.0 / sqrt(r2.w);
	r5.xyz = r4.xyz * r2.w;
	r4.x = dot(r2.xyz, r5.xyz);
	r4.y = dot(r1.xyz, r5.xyz);
	r4.z = dot(r3.xyz, r5.xyz);
	o.vTexCoord2.xyz = normalize(r4.xyz) * r1.w + r1.w;
	r2.x = dot(r2.xyz, c19.xyz);
	r2.y = dot(r1.xyz, c19.xyz);
	r2.z = dot(r3.xyz, c19.xyz);
	o.vTexCoord3.xyz = normalize(r2.xyz) * r1.w + r1.w;
	r1.z = 1.0 / r2.w;
	r1.y = c17.z * r1.z;
	r1.x = c17.y * r1.z + c17.x;
	r1.x = r1.y * r1.z + r1.x;
	r1.x = 1.0 / r1.x;
	o.vColor0.xyz = lightColor0 * r1.x;
	o.vColor0.w = c14.x;
	r0.w = c24.y;
	
	float4 vPos = mul(float4(c4[index * 4 + 0] * i.pSize, c4[index * 4 + 1] * i.pSize * scale, 0.0, 0.0) * c8.w, c1);
	vPos = float4(vPos.xyz+i.vPosition, 1);
	
	o.vPosition = mul(r0, c0);
	
	if(clouds){
		AtmosphereSample atm = SamplePrecomputedAtmosphere(0);
		o.vTexCoord0.w = atm.inscatter.r;
		o.vTexCoord1.zw = atm.inscatter.gb;
		o.vTexCoord2.w = atm.transmittance.r;
	}
	else o.vTexCoord1.zw = o.vTexCoord0.w = o.vTexCoord2.w = 0;

	return o;
}

PFXSmoke2Out vsPFXSmoke2MaterialOP(const in VertexInOp i, uniform bool clouds){
	PFXSmoke2Out o;
	
	float4 c24 = {0, 1, 0, 0};
	float4 c23 = {0.5, 0, 0, 0};
	
	float4 r0, r1, r2, r3, r4, r5;
	
	// o.vColor1.xyz = c18.xyz;					// color
	r1.w = 0.5;								// 0.5
	int index = i.vTexCoord.x;					// vertex index
	r2 = float4(c4[index * 4 + 0], c4[index * 4 + 1], c4[index * 4 + 1], c4[index * 4 + 1]) + 0.5; 
	o.vTexCoord1.xy = r2.xy;						
	r0.xyz = i.vPosition.xyz * c22.xxx;			
	r0 = r2.xyyy * frequency + r0.xyzz;			
	o.vTexCoord0.xyz = float3(r0.xy, r0.z + c20.x);	

	r3.xyz = normalize(i.vPosition.xyz - c8.xyz);
	r2.xyz = normalize(float3(r3.z,0,-r3.x));
	r1.xyz = normalize(cross(r3.xyz, r2.xyz));
	r0.xyz = i.vPosition.xyz + (r1.xyz*c4[index*4 + 1] + r2.xyz*c4[index*4 + 0])*i.pSize*scale*particleScale;	
	
	r4.xyz = c16.xyz - r0.xyz;
	r2.w = dot(r4.xyz, r4.xyz);
	r2.w = 1.0 / sqrt(r2.w);
	r5.xyz = r4.xyz * r2.w;
	r4.x = dot(r2.xyz, r5.xyz);
	r4.y = dot(r1.xyz, r5.xyz);
	r4.z = dot(r3.xyz, r5.xyz);
	o.vTexCoord2.xyz = normalize(r4.xyz) * r1.w + r1.w;
	r2.x = dot(r2.xyz, c19.xyz);
	r2.y = dot(r1.xyz, c19.xyz);
	r2.z = dot(r3.xyz, c19.xyz);
	o.vTexCoord3.xyz = normalize(r2.xyz) * r1.w + r1.w;
	r1.z = 1.0 / r2.w;
	r1.y = c17.z * r1.z;
	r1.x = c17.y * r1.z + c17.x;
	r1.x = r1.y * r1.z + r1.x;
	r1.x = 1.0 / r1.x;
	o.vColor0.xyz = lightColor0 * r1.x;
	o.vColor0.w = c14.x * i.pColor;						
	r0.w = c24.y;					
	o.vPosition = mul(r0, c0);
	
	if(clouds){
		AtmosphereSample atm = SamplePrecomputedAtmosphere(0);
		o.vTexCoord0.w = atm.inscatter.r;
		o.vTexCoord1.zw = atm.inscatter.gb;
		o.vTexCoord2.w = atm.transmittance.r;
	}
	else o.vTexCoord1.zw = o.vTexCoord0.w = o.vTexCoord2.w = 0;

	return o;
}

//дым от старого воздушного взрыва
float4 psPFXSmoke2Material(const in PFXSmoke2Out i, uniform bool clouds) : SV_TARGET0 {

	float4 r0;
	float4 t0 = NoiseMap.Sample(WrapLinearSampler, i.vTexCoord0.xyz);
	float4 t1 = NormalMap.Sample(WrapLinearSampler, i.vTexCoord1.xy);	

	float mask = t1.a;
	
	float3 t2 = i.vTexCoord2.xyz;
	float3 t3 = i.vTexCoord3;
	
	float alpha = saturate(mask - t0.a) * saturate(i.vColor0.a) * opacity;

	float NoL0 = saturate(dot((t2.xyz - 0.5) * 2.0, (t1.xyz - 0.5) * 2.0));
	// float NoL1 = saturate(dot((t3.xyz - 0.5) * 2.0, (t1.xyz - 0.5) * 2.0));

	t0.rgb = i.vColor0.rgb * NoL0;
	r0 = float4(t0.rgb + lightColor1, alpha);
	r0.rgb = shading_AmbientSun(r0.rgb*r0.rgb*particleColor, AmbientAverage, gSunDiffuse*gSunIntensity/3.1415);
	
	if(clouds){
		// float4 cld = float4(i.vTexCoord0.w, i.vTexCoord1.zw, i.vTexCoord2.w);	
		r0.rgb = lerp(r0.rgb, float3(i.vTexCoord0.w, i.vTexCoord1.zw), i.vTexCoord2.w);	
	}
	
	return r0;
}

TECHNIQUE PFXSmoke2Material{
	pass main{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ENABLE_ALPHA_BLEND;
		
		VERTEX_SHADER(vsPFXSmoke2Material(false))
		PIXEL_SHADER(psPFXSmoke2Material(false))	
		GEOMETRY_SHADER_PLUG	
	}
	pass withClouds{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ENABLE_ALPHA_BLEND;
		
		VERTEX_SHADER(vsPFXSmoke2Material(true))
		PIXEL_SHADER(psPFXSmoke2Material(true))	
		GEOMETRY_SHADER_PLUG	
	}	
}

TECHNIQUE PFXSmoke2MaterialOP{
	pass main{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ENABLE_ALPHA_BLEND;		
		VERTEX_SHADER(vsPFXSmoke2MaterialOP(false))
		PIXEL_SHADER(psPFXSmoke2Material(false))	
		GEOMETRY_SHADER_PLUG 
	}
	pass withClouds{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ENABLE_ALPHA_BLEND;		
		VERTEX_SHADER(vsPFXSmoke2MaterialOP(true))
		PIXEL_SHADER(psPFXSmoke2Material(true))	
		GEOMETRY_SHADER_PLUG 
	}	
}
