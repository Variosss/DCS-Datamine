#include "common/samplers11.hlsl"
#include "common/States11.hlsl"
#include "common/atmosphereSamples.hlsl"
#include "common/context.hlsl"

Texture3D NoiseMap;	//0
Texture2D NormalMap;//1

float c4[16];
float4x4 c0;
float4x4 c1;
float4x4 c9;
float4 c8;
float4 c13;
float4 c14;

float4 p0;
float4 p1;
float4 p2;

static const float scale = 2.0;

// struct VertexIn{
	// float3 vPosition		: POSITION0;
	// float pSize			: PSIZE0;
	// float4 vTexCoord		: TEXCOORD0;
// };

struct VertexInOp{
	float3 vPosition		: POSITION0;
	float pSize				: PSIZE0;
	float pColor			: COLOR0;
	float4 vTexCoord		: TEXCOORD0;
};

struct PFXExplOut{
	float4 vPosition		: SV_POSITION0;
	float4 vTexCoord0		: TEXCOORD0;
	float2 vTexCoord1		: TEXCOORD1;
	float4 vColor			: COLOR0;
};


PFXExplOut vsPFXExplFire2Material(const in VertexInOp i, uniform bool clouds){// i.pColor = 0!
	PFXExplOut o;
	
	float4 c16 = float4(0, 1, 0, 0);
	float4 c15 = float4(0.5, 0, 0, 0);
	
	float4 r0, r1, r2, r3;
	
	int index = i.vTexCoord.x;
	r0.xy = float2(c4[index * 4 + 0], c4[index * 4 + 1]).xy;
	o.vTexCoord1.xy = r0.xy + c15.x;
	r1.xyz = i.vPosition.xyz - c8.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1.0 / sqrt(r0.z);
	r3.xyz = r0.z * r1.xyz;
	r1.xyz = c16.xxy * r3.yzx;
	r1.xyz = c16.yxx * r3.zxy - r1.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1.0 / sqrt(r0.z);
	r2.xyz = r0.z * r1.xyz;
	r1.xyz = r3.zxy * r2.yzx;
	r1.xyz = r3.yzx * r2.zxy - r1.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1.0 / sqrt(r0.z);
	r1.xyz = r0.z * r1.xyz;
	r1.xyz = r1.xyz * r0.y;
	r0.xyz = r2.xyz * r0.x + r1.xyz;
	r0.xyz = r0.xyz * i.pSize;
	r0.xyz = r0.xyz * c13.x + i.vPosition.xyz;
	r0.w = c16.y;
	o.vTexCoord0.xyz = mul(float4(r0.xyz, 0.0), c9).xyz;
	o.vColor.xyz = c16.yyy;
	o.vColor.w = c14.x;
	
	o.vPosition = mul(r0, c0);
	
	if(clouds)
		o.vTexCoord0.w = SamplePrecomputedAtmosphere(0).transmittance.r;
	else
		o.vTexCoord0.w = 1;

	return o;
}

PFXExplOut vsPFXExplFire2MaterialOP(const in VertexInOp i, uniform bool clouds){
	PFXExplOut o;
	
	float4 c16 = float4(0, 1, 0, 0);
	float4 c15 = float4(0.5, 0, 0, 0);
	
	float4 r0, r1, r2, r3;
	
	int index = i.vTexCoord.x;
	r0.xy = float2(c4[index * 4 + 0], c4[index * 4 + 1]).xy;
	o.vTexCoord1.xy = r0.xy + c15.x;
	r1.xyz = i.vPosition.xyz - c8.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1.0 / sqrt(r0.z);
	r3.xyz = r0.z * r1.xyz;
	r1.xyz = c16.xxy * r3.yzx;
	r1.xyz = c16.yxx * r3.zxy - r1.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1.0 / sqrt(r0.z);
	r2.xyz = r0.z * r1.xyz;
	r1.xyz = r3.zxy * r2.yzx;
	r1.xyz = r3.yzx * r2.zxy - r1.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1.0 / sqrt(r0.z);
	r1.xyz = r0.z * r1.xyz;
	r1.xyz = r1.xyz * r0.y;
	r0.xyz = r2.xyz * r0.x + r1.xyz;
	r0.xyz = r0.xyz * i.pSize;
	r0.xyz = r0.xyz * c13.x + i.vPosition.xyz;
	r0.w = c16.y;
	o.vTexCoord0.xyz = mul(float4(r0.xyz, 0.0), c9).xyz;
	o.vColor.xyz = c16.yyy;
	o.vColor.w = c14.x * i.pColor;
	
	o.vPosition = mul(r0, c0);
	
	if(clouds)
		o.vTexCoord0.w = SamplePrecomputedAtmosphere(0).transmittance.r;
	else
		o.vTexCoord0.w = 1;
	return o;
}

float4 cnd(float val, float4 src1, float4 src2){
	// float4 dest;	
	// if (val > 0.5)  dest = src1;
	// else  dest = src2;	  
	// return dest;
	return lerp(src1, src2, step(val, 0.5));
}
//пламя от старого воздушного взрыва
float4 psPFXExplFire2Material(const in PFXExplOut i) : SV_TARGET0 {
	float4 r0;
	
	float4 t0 = NoiseMap.Sample(WrapLinearSampler, float3(i.vTexCoord0.xy, i.vTexCoord0.z));
	float4 t1 = NormalMap.Sample(ClampLinearSampler, i.vTexCoord1.xy);
	
	r0.a = t0.a;
	t1.a = t1.a * saturate(i.vColor.a);
	r0.a = cnd(r0.a, (t0 - 0.5) * 2.0, -((t0 - 0.5) * 2.0)).a;	
	t0.rgb = (r0.a - 0.5) * 2.0 * p1.rgb + p0.rgb;
	t1.rgb = (r0.a * p0.rgb) * 2.0;
	r0.rgb = cnd(r0.a, t0, t1).rgb * 5.0;
	r0.a = t1.a * i.vTexCoord0.w;
	return r0;
}

PixelShader psPFXExplFire2Compiled = CompileShader(ps_4_0, psPFXExplFire2Material());

TECHNIQUE PFXExplFire2Material{
	pass P0{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ADDITIVE_ALPHA_BLEND;	
		VERTEX_SHADER(vsPFXExplFire2Material(false))
		SetPixelShader(psPFXExplFire2Compiled);			
		GEOMETRY_SHADER_PLUG
	}
	pass withClouds{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ADDITIVE_ALPHA_BLEND;	
		VERTEX_SHADER(vsPFXExplFire2Material(true))
		SetPixelShader(psPFXExplFire2Compiled);			
		GEOMETRY_SHADER_PLUG
	}
}

TECHNIQUE PFXExplFire2MaterialOP{
	pass P0{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ADDITIVE_ALPHA_BLEND;	
		VERTEX_SHADER(vsPFXExplFire2MaterialOP(true))
		SetPixelShader(psPFXExplFire2Compiled);	
		GEOMETRY_SHADER_PLUG
	}
	pass withClouds{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ADDITIVE_ALPHA_BLEND;	
		VERTEX_SHADER(vsPFXExplFire2MaterialOP(true))
		SetPixelShader(psPFXExplFire2Compiled);	
		GEOMETRY_SHADER_PLUG
	}	
}
