#include "../common/samplers11.hlsl"
#include "../common/states11.hlsl"

#include "ParticleSystem2/common/perlin.hlsl"


Texture2D DiffuseMap;
Texture2D ResampleMap;
Texture3D Noise;
Texture2D Mask;

float4	viewport;
float widthTX;
float heightTX; 
float time;
float blurM;
float magn;

const float3 LUM = {1.0, 0.0721f, 0.0721f};


struct vAP_Output{
	noperspective float4 vPosition	:SV_POSITION0;
	noperspective float4 vTexCoords	:TEXCOORD0;
};

struct main_out 
{
	float3 scene;
	float3 color;
};

#define LOW_NOISE

main_out main_base(const vAP_Output v)
{
	main_out ret_val;
	
	float2 uv = v.vTexCoords.xy;
	
	ret_val.scene = DiffuseMap.Sample(ClampLinearSampler, v.vTexCoords.zw).rgb;	
	float3 blur   = ResampleMap.Sample(ClampLinearSampler, uv).rgb;
   
	float R = 0.89;
	float L = pow(dot(ret_val.scene, LUM), R);	

	float K = 0.08;
	
#ifdef LOW_NOISE
	float noise = 0.6*noise2D(frac(uv+time));
	noise = lerp(noise, 0, L);	   	
	ret_val.color = float3(0, K * ((L * magn + blur.r * blurM) + noise), 0);	
#else
	ret_val.color = float3(0, min(1, K * (L * magn + blur.r * blurM)), 0);// без шума
#endif
	
	return ret_val;
};

main_out main_alternative(const vAP_Output v)
{
	main_out ret_val;

	float2 uv = v.vTexCoords.xy;
	
	ret_val.scene = DiffuseMap.Sample(ClampLinearSampler, v.vTexCoords.zw).rgb;
	float3 noiseUV = float3(uv * float2(widthTX / 75.0, heightTX / 75.0), frac((time * 10.0) / 64.0));
//	float noise   = tex3D(sNoise, noiseUV).r;
	float noise   = Noise.Sample(WrapLinearSampler, noiseUV).r;
	float3 blur   = ResampleMap.Sample(ClampLinearSampler, uv).rgb;

	float dst = frac(uv.y + time);
	dst *= (1 - dst);

	noise = pow((1.0 - dst), 4.0) * noise;
	
	float R = 1.0;
	float L = pow(dot(ret_val.scene, LUM), R);

	float3 color = float3(0.08 * (L * magn + blur.r * blurM),
						  0.08 * (L * magn + blur.r * blurM),
						  0.08 * (L * magn + blur.r * blurM));
 	ret_val.color = color * saturate(0.7 + 0.3 * noise);

	return ret_val;
};

vAP_Output vsMain(const float2 pos: POSITION0) {
	vAP_Output res;
	
	res.vPosition = float4(pos, 0, 1.0);
	res.vTexCoords.xy = float2(pos.x*0.5+0.5, -pos.y*0.5+0.5);
	res.vTexCoords.zw = res.vTexCoords.xy*viewport.zw + viewport.xy;	
	
	return res;
}

float4 psMain(const vAP_Output v): SV_TARGET0 {
	main_out data = main_base(v);
	float mask    = Mask.Sample(ClampLinearSampler, v.vTexCoords.xy).r;
	data.color    = lerp(data.scene,data.color, mask);
	return(float4(data.color, 1.0f));
}

float4 psMainNoMask(const vAP_Output v): SV_TARGET0 {
	main_out data = main_base(v);	
	return(float4(data.color, 1.0f));
}

float4 psMain_alternative(const vAP_Output v): SV_TARGET0 {
	main_out data = main_alternative(v);
	float mask    = Mask.Sample(ClampLinearSampler, v.vTexCoords.xy).r;
	data.color    = lerp(data.scene,data.color, mask);
	return(float4(data.color, 1.0f));
}

float4 psMainNoMask_alternative(const vAP_Output v): SV_TARGET0 {
	main_out data = main_alternative(v);
	return(float4(data.color, 1.0f));
}

float4 ResampleLum4x4(const vAP_Output v): SV_TARGET0 {
	const float dx = 1.0 / widthTX;
	const float dy = 1.0 / heightTX;
	
	float2 uv = v.vTexCoords.xy;
	
	float lSum = 0;
	
	for(int y = 0; y < 4; y++)
		for(int x = 0; x < 4; x++){
			float2 duv = float2((x - 1.5f) * dx, (y - 1.5f) * dy);
			lSum += dot( DiffuseMap.Sample(ClampLinearSampler, duv + v.vTexCoords.zw).rgb, LUM);
	}
	
	lSum /= 16;
	if(lSum < 0.2) lSum = 0.0;
	
	return float4(lSum, lSum, lSum, 1.0);
}

float4 BlurX_gauss(const vAP_Output v): SV_TARGET0 {
	float2 tx = v.vTexCoords.xy;
    float2 dx  = float2(1.0 / widthTX, 0.0);
    float2 sdx = dx;
    
    float3 sum = ResampleMap.Sample(ClampLinearSampler, tx).rgb * 0.134598;
		
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.127325;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.107778;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.081638;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.055335;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.033562;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.018216;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx ).rgb)* 0.008847;
    sdx += dx;
    
    return float4(sum, 1.0);
}

float4 BlurY_gauss(const vAP_Output v): SV_TARGET0 {
	float2 tx = v.vTexCoords.xy;
    float2 dx  = float2(0.0, 1.0 / heightTX);
    float2 sdx = dx;
    
    float3 sum = ResampleMap.Sample(ClampLinearSampler, tx).rgb * 0.134598;
		
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.127325;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.107778;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.081638;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.055335;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.033562;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx).rgb)* 0.018216;
    sdx += dx;
    sum += (ResampleMap.Sample(ClampLinearSampler, tx + sdx).rgb + ResampleMap.Sample(ClampLinearSampler, tx - sdx ).rgb)* 0.008847;
    sdx += dx;
    
    return float4(sum, 1.0);
}

technique10 FinalPass{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psMain()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

technique10 FinalPassNoMask{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psMainNoMask()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

technique10 Resample{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ResampleLum4x4()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

technique10 BlurX{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, BlurX_gauss()));
	}
}

technique10 BlurY{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, BlurY_gauss()));
	}
}

technique10 FinalPassAlternative{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psMain_alternative()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

technique10 FinalPassNoMaskAlternative{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psMainNoMask_alternative()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}
