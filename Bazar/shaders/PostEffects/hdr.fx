#include "../common/samplers11.hlsl"
#include "../common/states11.hlsl"

Texture2D DiffuseMap;
Texture2D ResampleMap;
Texture2D ResampleToLumMap;
Texture2D LastLumMap;
Texture2D LumMap;
Texture2D AvgMap;
Texture2D AdaptAvgMap;
Texture2D Rays;
Texture2D Glow;


float widthTX;
float heightTX; 
float time;
float2 offsets[8];
float3 weights[8];
float4x4 matSun;
float4 LightPos;
float4 SunColor;
float SunPower;

float glowRadius;
float3 SUN_SHIFT;
float minL;
float maxL;
float sunMagn;
float blurMagn;
float aTime;
float level;
float bLevel;

float overcast;

const float3 LUM = {0.2125, 0.7154, 0.0721};

////////////////////
// Helper function {0.2125, 0.7154, 0.0721};
////////////////////

float3 resample4x4(Texture2D Map, float2 uv){
	float dx = 1.0 / widthTX;
	float dy = 1.0 / heightTX;
	
	float3 sample = float3(0, 0, 0);
	
	for(int y = 0; y < 4; y++)
		for(int x = 0; x < 4; x++){
			float2 duv = float2((x - 1.5f) * dx, (y - 1.5f) * dy);
			sample += Map.Sample(ClampLinearSampler, duv + uv).rgb;
	}
	
	sample /= 16;
//default: sample /= 16;  less= stronger HDR 
	return sample;
}

float3 resample2x2(Texture2D Map, float2 uv){
//	const float2 du = {1.5 / widthTX, 0.0};
//	const float2 dv = {0.0, 1.5 / heightTX};

	const float2 du = {1.0 / widthTX, 0.0};
	const float2 dv = {0.0, 1.0 / heightTX};

	float3 sample = Map.Sample(ClampLinearSampler, uv).rgb +
        			Map.Sample(ClampLinearSampler, uv + du).rgb +
					Map.Sample(ClampLinearSampler, uv + dv).rgb +
					Map.Sample(ClampLinearSampler, uv + du + dv).rgb;

	sample *= 0.25;
//default: sample *= 0.25;	
	return sample;
}

////////////////////

struct vAP_Output{
	float4 vPosition	:SV_POSITION;
	float2 vTexCoords	:TEXCOORD0;
};

vAP_Output vsMain(const float2 pos: POSITION0) {
	vAP_Output res;
	
	res.vPosition = float4(pos, 0, 1.0);
	res.vTexCoords = float2(pos.x*0.5+0.5, -pos.y*0.5+0.5);
	
	return res;
}

float4 psMain(const vAP_Output v): SV_TARGET0 {
	
	float3 diffuse = DiffuseMap.Sample(ClampSampler, v.vTexCoords.xy).rgb;
	float3 blur = ResampleMap.Sample(ClampLinearSampler, v.vTexCoords.xy).rgb;
	float2 lum = AdaptAvgMap.Sample(WrapPointSampler, float2(0.5, 0.5)).rg;
	float3 sStar = float3(1, 1, 1);
	
	float2 lp = LightPos.xy / LightPos.w;
	
	float2 wUV = (v.vTexCoords.xy - 0.5) * 2.0;
	wUV.y =- wUV.y;
	float lGlow = clamp(1.0 - distance(wUV, lp) / glowRadius, 0.0, 1.0);
	// position of the sunglare
	float aspect = widthTX / heightTX;
	lp.x = -lp.x;
	lp.xy = lp.xy * 0.5;  
	float2 lightUV;
	lightUV.y = lp.y + v.vTexCoords.y;
	lightUV.x = (lp.x + v.vTexCoords.x) * aspect - (aspect * 0.5 - 0.5);
	
	float4 rays = Rays.Sample(ClampSampler, lightUV);
	float3 glow = Glow.Sample(ClampSampler, lightUV) / 1.0;
	float2 sunPUV = LightPos.xy / LightPos.w;
	sunPUV.y = -sunPUV.y;
	sunPUV = sunPUV * 0.5 + 0.5;
	float sunP = ResampleMap.Sample(ClampLinearSampler, sunPUV);
	sunP = saturate(sunP - 1.0);
	
	float I = clamp(lum.x, minL, maxL);
	float l = saturate(dot(LUM, diffuse));
	float gVal = saturate(lum.y - 0.8) * 4.0 * clamp(SunPower, 0.1, 1.0);
	
	if(LightPos.w < 0){ 
		lGlow = 0.0;
		glow = float3(0.0, 0.0, 0.0);
		rays.rgba = float4(0.0, 0.0, 0.0, 0.0);
	}
	
	float3 O_SHIFT = float3(1.5, 1.39, 1);
	float3 color = SunColor * O_SHIFT;
	
	float3 BLUE_SHIFT = SUN_SHIFT;

	float mask = clamp(lGlow * pow(abs(1), glowRadius), 0.0, 0.6) * 0.8 * (1.0 - clamp(SunPower, 0.6, 1.0));
	
	float isOvercast = ((overcast - 0.5) * 2.0);
	
		
	float3 composite = diffuse.rgb;
	
#ifdef HARD
	composite = lerp(diffuse, diffuse * l + diffuse * 0.6, SunPower * 0.7) / I;
	composite = composite + (color * sunP * rays.rgb * rays.a + color * mask * 0.5) * isOvercast;
	composite = composite + blur * isOvercast * 2.0;
	
	float OV = min(overcast + 0.4, 1.0);
	return float4(composite * OV * 0.95, 1.0);
#endif

#ifdef NORMAL
	composite = lerp(diffuse * 1.2, l * BLUE_SHIFT, 0.25) / I;
	composite = composite + (color * mask + blur * mask * 2.0 / I) * isOvercast;
	composite = composite + color * sunP * rays.rgb * isOvercast * rays.a / clamp(lum.x, 1.0, 2.0);
	composite = composite + blur;	
	
	float OV = min(overcast + 0.4, 1.0);
	return float4(composite * OV * 0.90, 1.0);
#endif

#ifdef SOFT
	composite = lerp(diffuse * 0.75, BLUE_SHIFT * l, bLevel * 0.9) / I;
	composite = composite + (color * mask + blur * mask * 2.0 / I) * isOvercast;
	composite = composite + color * sunP * rays.rgb * isOvercast * rays.a / clamp(lum.x, 1.0, 2.0);
	composite = composite + blur * blurMagn;	
	
	float OV = min(overcast + 0.4, 1.0);
	return float4(composite * OV * 0.90, 1.0);
#endif

	return float4(composite , 1.0);
			
}

///////////////////////////////////////
// Resample pass (down filter 4x4)
// resample scene

float4 ResampleScene4x4(const vAP_Output v): SV_TARGET0{
	float3 sample = resample4x4(DiffuseMap, v.vTexCoords.xy);
	return float4(sample, 1.0);
}

////////////////////////////////////////////

////////////////////////////////////////////
// Resample scene to lum

float4 ResampleToLum4x4(const vAP_Output v): SV_TARGET0{
	float3 sample = ResampleMap.Sample(ClampLinearSampler, v.vTexCoords.xy);
	float L = dot(sample, sample);
	return float4(L, L, L, L);
}

/////////////////////////////////////////////

float4 ResampleLum4x4(const vAP_Output v): SV_TARGET0{
	float3 sample = resample4x4(LumMap, v.vTexCoords.xy).r;
	return float4(sample, 1.0);
}

float4 ResampleLum2x2(const vAP_Output v): SV_TARGET0{
	float3 sample = resample2x2(LumMap, v.vTexCoords.xy);
	return float4(sample, 1.0);
}


float4 AdaptationPS(const vAP_Output v): SV_TARGET0{
	float newLum = AvgMap.Sample(WrapPointSampler, float2(0.5, 0.5)); //default: 0.5, 0.5
	float curLum = AdaptAvgMap.Sample(WrapPointSampler, float2(0.5, 0.5)); //default: 0.5, 0.5
		
	float T = aTime;
	if(newLum > curLum) T = aTime - 10.0;
	
	float A = curLum + (newLum - curLum) * (1.0 - pow(0.98f, T * time));
	float B = saturate(newLum);
	return float4(A, B, B, B); // default : A, B, B, B
}

float4 BlurX_gauss(const vAP_Output v): SV_TARGET0{
	float2 tx = v.vTexCoords.xy;
	float X = widthTX / 0.26;
    float2 dx  = float2(1.0 / X, 0.0);
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
    sdx += dx;;
    
    return float4(sum, 1.0);
}

float4 BlurY_gauss(const vAP_Output v): SV_TARGET0{
	float2 tx = v.vTexCoords.xy;
	float Y = heightTX / 0.26;
    float2 dx  = float2(0.0, 1.0 / Y);
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

float4 ClampResample1x1(const vAP_Output v): SV_TARGET0{

	float3 diffuse = ResampleMap.Sample(ClampLinearSampler, v.vTexCoords.xy).rgb;
	
#ifdef HARD	
	float l = dot(diffuse, LUM);
	float OV = overcast > 0.6 ? 1 : 0;
	if(l < 3.0)  diffuse = float3(0, 0, 0);
#endif

#ifdef NORMAL	
	float l = dot(diffuse, LUM);
	float OV = overcast > 0.6 ? 1 : 0;
	if(l < 3.0)  diffuse = float3(0, 0, 0);
#endif

#ifdef SOFT	
	float l = dot(diffuse, LUM);
	if(l < 0.0)  diffuse = float3(0, 0, 0);
#endif
	
	return float4(diffuse, 1.0);
	
}

technique10 FinalPass{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psMain()));
	}
}


technique10 ResampleScene{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ResampleScene4x4()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
	}
}

technique10 ResampleToLum{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ResampleToLum4x4()));
	}
}

technique10 ResampleLum{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ResampleLum4x4()));
	}
}

technique10 ResampleLum2{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ResampleLum2x2()));
	}
}

technique10 Adaptation{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, AdaptationPS()));
	}
}

technique10 ClampResample{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ClampResample1x1()));
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
