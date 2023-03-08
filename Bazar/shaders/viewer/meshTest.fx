#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/shadingCommon.hlsl"

float4x4 World;
float4 color0;
float4 color1;
float4 color2;
float4 color3;

Texture2D tex0;
Texture2D tex1;
Texture2D tex2;
Texture2D tex3;

struct VSOutput
{
	float4 pos:		SV_POSITION0;
	float4 wPos:	POSITION0;
	float3 norm:	NORMAL0;
	float2 uv:		TEXCOORD0;
};

VSOutput VS(float3 pos: POSITION0)
{
	VSOutput o;
	o.wPos = mul(float4(pos,1), World);
	o.wPos /= o.wPos.w;
	o.pos = mul(o.wPos, gViewProj);
	o.norm = mul(float3(0,1,0), (float3x3)World);
	o.uv = pos.xz+0.5;
	return o;
}

struct PSOutput
{
	float4 colorAdd: SV_TARGET0;
	float3 colorMul: SV_TARGET1;
};

PSOutput BuildTransparency(float3 diffuseColor, float3 specularColor, float alpha, float3 filterColor)
{
	PSOutput o;
	o.colorAdd = float4(diffuseColor * alpha + specularColor, alpha);
	o.colorMul = (filterColor) * (1-alpha);
	return o;
}

float3 ShadeSolid2(float3 sunColor, float3 diffuseColor, float3 specularColor, float3 normal, float roughness, float metallic, float shadow, float AO, float3 viewDir, float2 energyLobe = float2(1,1))
{
	float NoL = max(0, dot(normal, gSunDir));
	float3 lightAmount = sunColor * gSunIntensity * NoL * shadow;
	float3 finalColor = ShadingDefault(diffuseColor, specularColor, roughness, normal, viewDir, gSunDir, energyLobe) * lightAmount;	

	//diffuse IBL
	finalColor += diffuseColor * SampleEnvironmentMapDetailed(normal, environmentMipsCount) * gIBLIntensity * AO * energyLobe.x;

	//specular IBL
	float NoV = max(0, dot(normal, viewDir));
	float a = roughness * roughness;
	float3 R = normal*NoV*2 - viewDir;
	// float3 R = -reflect(viewDir, normal);
	R = normalize( lerp( normal, R, (1 - a) * ( sqrt(1 - a) + a ) ) );
	float3 envLightColor = SampleEnvironmentMapDetailedByRoughness(R, roughness);
	finalColor += envLightColor * EnvBRDFApprox(specularColor, roughness, normal, viewDir) * energyLobe.y;

	return finalColor;
}

PSOutput PSTransmittance(VSOutput i)
{
	// return float4(i.uv, 0, 1);
	float alpha = tex0.SampleLevel(gAnisotropicWrapSampler, i.uv.xy, 0).a;
	// float  alpha = color0.a;
	
	float3 baseColor = GammaToLinearSpace(tex0.SampleLevel(gAnisotropicWrapSampler, i.uv.xy, 0).rgb);
	// float3 baseColor = GammaToLinearSpace(color0.rgb);
	
	float3 filterColor = GammaToLinearSpace(tex1.SampleLevel(gAnisotropicWrapSampler, i.uv.xy, 0).rgb);
	// float3 filterColor = GammaToLinearSpace(color1.rgb);
	
	float3 normal = normalize(i.norm);
	float4 emissive = 0;
	float2 rm = color2.xy;
	rm.x = alpha;
	// rm.y = 0;
	float shadow = 1;
	float AO = 1;
	float viewDir = normalize(i.wPos.xyz/i.wPos.w - gCameraPos.xyz);
	
	rm.x = clamp(rm.x, 0.02, 0.99);

	float3 diffuseColor = baseColor * (1.0 - rm.y);
	float3 specularColor = lerp(0.04, baseColor, rm.y);	

	float3 diffuseLobe  = ShadeSolid2(gSunDiffuse, diffuseColor, specularColor, normal, rm.x, rm.y, shadow, AO, viewDir, float2(1,0));
	float3 specularLobe = ShadeSolid2(gSunDiffuse, diffuseColor, specularColor, normal, rm.x, rm.y, shadow, AO, viewDir, float2(0,1));
	
	float3 H = normalize(gSunDir + viewDir);
	float HdotN = max(0, dot(H, normal));
    float3 S = pow(HdotN, (200 + 0.0001)) * gSunIntensity;
	
	diffuseLobe += GammaToLinearSpace(emissive);
	
	return BuildTransparency(diffuseLobe, S, alpha, filterColor);
	// return BuildTransparency(diffuseLobe, specularLobe, alpha, filterColor);
	// return BuildTransparency(0, float3(i.uv.xy,0), 1, filterColor);
	// return BuildTransparency(0, float3(normal), 1, filterColor);
}

BlendState transparentAlphaBlend
{
	BlendEnable[0] = true;
	SrcBlend = ONE;
	DestBlend = SRC1_COLOR;
	BlendOp = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

technique10 tech
{
    pass transparensyWithTransmittance
    {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PSTransmittance()));
		
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(transparentAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
    }
}

