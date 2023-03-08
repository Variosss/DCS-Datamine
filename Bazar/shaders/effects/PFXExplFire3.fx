#include "PFXExplFire2.fx"

//пламя от старого воздушного взрыва
float4 psPFXExplFire3Material(const in PFXExplOut i) : SV_TARGET0 {
	float4 r0;
	float4 t0 = NoiseMap.Sample(WrapLinearSampler, float3(i.vTexCoord0.xy, i.vTexCoord0.z));
	float4 t1 = NormalMap.Sample(ClampLinearSampler, i.vTexCoord1.xy);
	
	t0.rgb = t1.a * saturate(i.vColor.a);
	t0.a = (t0.a - 0.5) * 2.0 + p1.a;
	r0.rgb = p0.rgb * t0.a * 5.0;
	r0.a = t0.b*i.vTexCoord0.w;
	return r0;
}

PixelShader psPFXExplFire3Compiled = CompileShader(ps_4_0, psPFXExplFire3Material());

TECHNIQUE PFXExplFire3{
	pass P0{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ADDITIVE_ALPHA_BLEND;	
		VERTEX_SHADER(vsPFXExplFire2Material(false))
		SetPixelShader(psPFXExplFire3Compiled);	
		GEOMETRY_SHADER_PLUG
	}
	pass withClouds{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ADDITIVE_ALPHA_BLEND;	
		VERTEX_SHADER(vsPFXExplFire2Material(true))
		SetPixelShader(psPFXExplFire3Compiled);		
		GEOMETRY_SHADER_PLUG
	}
}

TECHNIQUE PFXExplFire3OP{
	pass P0{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ADDITIVE_ALPHA_BLEND;	
		VERTEX_SHADER(vsPFXExplFire2MaterialOP(false))
		SetPixelShader(psPFXExplFire3Compiled);	
		GEOMETRY_SHADER_PLUG
	}
	pass withClouds{
		ENABLE_RO_DEPTH_BUFFER;
		DISABLE_CULLING;
		ADDITIVE_ALPHA_BLEND;	
		VERTEX_SHADER(vsPFXExplFire2MaterialOP(true))
		SetPixelShader(psPFXExplFire3Compiled);		
		GEOMETRY_SHADER_PLUG
	}	
}
