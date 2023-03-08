#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"

Texture2D shadowMap: register(t117);
// Texture2D preintegratedGF: register(t124);
TextureCube envMap: register(t123);

float4x4 WVP;
float4x4 World					: WORLD;
float4x3 WorldInverseTranspose	: WORLDINVERSETRANSPOSE;

float4 dbg;

#ifndef AV_DISABLESSS
float4x3 ViewProj;
float4x3 InvViewProj;
#endif

float4 DIFFUSE_COLOR;
float4 SPECULAR_COLOR;
float4 AMBIENT_COLOR;
float4 EMISSIVE_COLOR;

float SPECULARITY = 1;
float SPECULAR_STRENGTH = 1;
#ifdef AV_OPACITY
float TRANSPARENCY;
#endif

// light colors (diffuse and specular)
float4 afLightColor[5];
float4 afLightColorAmbient[5];

// light direction
float3 afLightDir[5];

#define LIGHT_DIR(x) gSunDir
#define LIGHT_COLOR(x) gSunDiffuse

// Bone matrices
#ifdef AV_SKINNING 
float4x4 gBoneMatrix[60];
#endif // AV_SKINNING

#if defined(AV_WRAPU)
	#define ADDRESS_U		AddressU = WRAP;
#elif defined(AV_MIRRORU)
	#define ADDRESS_U		AddressU = MIRROR;
#elif defined(AV_CLAMPU)
	#define ADDRESS_U 		AddressU = CLAMP;
#else
	#define ADDRESS_U
#endif

#if defined(AV_WRAPV)
	#define ADDRESS_V		AddressV = WRAP;
#elif defined(AV_MIRRORV)
	#define ADDRESS_V		AddressV = MIRROR;
#elif defined(AV_CLAMPV)
	#define ADDRESS_V 		AddressV = CLAMP;
#else
	#define ADDRESS_V
#endif



#ifdef AV_DIFFUSE_TEXTURE
	Texture2D DIFFUSE_TEXTURE;	
	SamplerState DIFFUSE_SAMPLER
	{
		Filter = ANISOTROPIC;
		ADDRESS_U
		ADDRESS_V
		MaxAnisotropy = MAXANISOTROPY_DEFAULT;
		BorderColor   = float4(0, 0, 0, 0);
	};
#endif // AV_DIFFUSE_TEXTURETUR

#ifdef AV_DIFFUSE_TEXTURE2
	Texture2D DIFFUSE_TEXTURE2;
	SamplerState DIFFUSE_SAMPLER2
	{
		Filter = ANISOTROPIC;
		MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	};
#endif // AV_DIFFUSE_TEXTURETUR2

#ifdef AV_SPECULAR_TEXTURE
	Texture2D SPECULAR_TEXTURE;
	SamplerState SPECULAR_SAMPLER
	{
		Filter = ANISOTROPIC;
		ADDRESS_U
		ADDRESS_V
		MaxAnisotropy = MAXANISOTROPY_DEFAULT;
	};
#endif // AV_SPECULAR_TEXTURETUR

#ifdef AV_AMBIENT_TEXTURE
	Texture2D AMBIENT_TEXTURE;
	SamplerState AMBIENT_SAMPLER
	{
	};
#endif // AV_AMBIENT_TEXTURETUR

#ifdef AV_LIGHTMAP_TEXTURE
	Texture2D LIGHTMAP_TEXTURE;
	SamplerState LIGHTMAP_SAMPLER
	{
	};
#endif // AV_LIGHTMAP_TEXTURE

#ifdef AV_OPACITY_TEXTURE
	Texture2D OPACITY_TEXTURE;
	SamplerState OPACITY_SAMPLER
	{
	};
#endif // AV_OPACITY_TEXTURE

#ifdef AV_EMISSIVE_TEXTURE
	Texture2D EMISSIVE_TEXTURE;
	SamplerState EMISSIVE_SAMPLER
	{
	};
#endif // AV_EMISSIVE_TEXTURETUR

#ifdef AV_NORMAL_TEXTURE
	Texture2D NORMAL_TEXTURE;
	SamplerState NORMAL_SAMPLER
	{
		ADDRESS_U
		ADDRESS_V
	};
#endif // AV_NORMAL_TEXTURE

#ifdef AV_SKYBOX_LOOKUP
	TextureCube lw_TEXTURE_envmap;
	SamplerState EnvironmentMapSampler
	{
		AddressU = CLAMP;
		AddressV = CLAMP;
		AddressW = CLAMP;

		Filter = MIN_MAG_MIP_LINEAR;
		MaxAnisotropy = 1;
	};
#endif // AV_SKYBOX_LOOKUP

// Vertex shader input structure
struct VS_INPUT
{
	float3 Position : POSITION0;
	float3 Normal : NORMAL0;
	float4 Color : COLOR0;
	float3 Tangent   : TANGENT0;
	float3 Bitangent : BINORMAL0;
	float2 TexCoord0 : TEXCOORD0;
// #ifdef AV_TWO_UV 
	float2 TexCoord1 : TEXCOORD1;
// #endif 
// #ifdef AV_SKINNING 
	float4 BlendIndices : BLENDINDICES0;
	float4 BlendWeights : BLENDWEIGHT0;
// #endif // AV_SKINNING 
};

// #undef AV_NORMAL_TEXTURE

// Vertex shader output structure for pixel shader usage
struct VS_OUTPUT
{
	float4 Position : SV_POSITION0;
	float4 wPos : TEXCOORD0;
	float4 Color : COLOR0;

	float3 Normal  : NORMAL0;
#ifdef AV_NORMAL_TEXTURE
	float3 Tangent   : TANGENT0;
	float3 Bitangent : BINORMAL0;
#endif

	float2 TexCoord0 : TEXCOORD2;
#ifdef AV_TWO_UV 
	float2 TexCoord1 : TEXCOORD3;
#endif
	
	uint instId: TEXCOORD4;
};

struct GBuffer
{
	float4 diffuse:		SV_Target0;
	float4 specular:	SV_Target1;
	float4 emissive:	SV_Target2;
	float4 normal:		SV_Target3;
};



#include "viewer/customShading.hlsl"




// Selective SuperSampling in screenspace for reflection lookups
#define GetSSSCubeMap(_refl) (lw_TEXTURE_envmap.Sample(EnvironmentMapSampler, float3(_refl)).rgb)


// #undef AV_NORMAL_TEXTURE

// Vertex shader for pixel shader usage and one light
VS_OUTPUT MaterialVShader_D1(VS_INPUT IN, uint vertId: SV_vertexID, uint instId: SV_InstanceID, uniform bool bSpheres)
// VS_OUTPUT MaterialVShader_D1(VS_INPUT IN, uint vertId: SV_vertexID, uint instId: SV_InstanceID)
// VS_OUTPUT MaterialVShader_D1(VS_INPUT IN, uint vertId: SV_vertexID)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	if(bSpheres)
	{
		Out.instId = instId;
		uint columns = 8;
		uint rows = 3;
		float radius = 5;
		uint2 size = {columns, rows};
		IN.Position.x += float(instId % size.x) * 10 * 1.1 - (size.x-1) * radius * 1.1;
		IN.Position.z += float(instId / size.x) * 10 * 1.3;
	}
	
	float4 objPos = float4(IN.Position, 1); 
	
#ifdef AV_SKINNING
	// uint d = IN.BlendIndices;
	// uint4 blendIndices = uint4(d, d >> 8, d >> 16, d >> 24) & 0xff;
	uint4 blendIndices = IN.BlendIndices*255;// протащить в рендер DXGI_FORMAT_R8G8B8A8_UINT
	float4 weights = IN.BlendWeights;
	weights.w = 1.0f - dot(weights.xyz, 1);
	
	float4x4 mPose = weights.x * gBoneMatrix[blendIndices.x];
	mPose += weights.y * gBoneMatrix[blendIndices.y];
	mPose += weights.z * gBoneMatrix[blendIndices.z];
	mPose += weights.w * gBoneMatrix[blendIndices.w];
	
	objPos = mul(objPos, mPose);
#else 
	float4x4 mPose = World;
#endif

	Out.Position = mul(objPos, WVP);
	Out.wPos = mul(Out.Position, gViewProjInv);
	
	mPose = mul(mPose, World);
	
	Out.TexCoord0 = IN.TexCoord0;
#ifdef AV_TWO_UV 
	Out.TexCoord1 = IN.TexCoord1;
#endif
	Out.Color = IN.Color;
	
	Out.Normal = mul(IN.Normal, (float3x3)mPose);
	
#ifdef AV_NORMAL_TEXTURE
	Out.Tangent = mul(IN.Tangent, (float3x3)mPose);
	Out.Bitangent = mul(IN.Bitangent, (float3x3)mPose);
#endif
	return Out;
}

// #undef AV_NORMAL_TEXTURE



void getMaterialParams(VS_OUTPUT IN, out float4 diffuse, out float4 specular, out float4 emissive, out float3 Normal)
{
#if defined(AV_NORMAL_TEXTURE) && 1
	float3x3 TBN = float3x3(normalize(IN.Tangent), normalize(IN.Bitangent), normalize(IN.Normal));
	Normal = 2.0*pow(NORMAL_TEXTURE.Sample(NORMAL_SAMPLER, IN.TexCoord0).rgb, 1.0) - 1.0;
	// Normal.y = -Normal.y;
	Normal = normalize(mul(normalize(Normal), TBN));
#else
	Normal = normalize(IN.Normal).xzy * float3(1, -1, 1);
	// Normal = normalize(IN.Normal).xyz;
#endif

	#define AV_LIGHT_0 LIGHT_DIR(0)

#ifdef AV_DIFFUSE_TEXTURE
	diffuse = float4(IN.Color.rgb, 1) * DIFFUSE_TEXTURE.Sample(DIFFUSE_SAMPLER,IN.TexCoord0).rgba;
	// diffuse = IN.Color.rgb * shadowMap.Sample(DIFFUSE_SAMPLER,IN.TexCoord0).rgb;
#else
	diffuse.rgb = IN.Color.rgb * DIFFUSE_COLOR.rgb;
	diffuse.a = 1;
#endif

#ifdef AV_SKYBOX_LOOKUP
	float3 ViewDir = normalize(gCameraPos.xyz - IN.wPos.xyz/IN.wPos.w);
	float3 Reflect = normalize(reflect (-ViewDir, Normal));
	float3 reflectionColor = GetSSSCubeMap(Reflect).rgb;
#else
	float3 reflectionColor = 0;
#endif

	specular = 0;
#ifdef AV_SPECULAR_COMPONENT
	#ifdef AV_SPECULAR_TEXTURE
	// specular = SPECULAR_COLOR.rgb * SPECULAR_STRENGTH * (1-SPECULAR_TEXTURE.Sample(SPECULAR_SAMPLER,IN.TexCoord0).rgb);
	specular.rgb = SPECULAR_TEXTURE.Sample(SPECULAR_SAMPLER,IN.TexCoord0).rgb;
	#else
	specular.rgb = SPECULAR_COLOR.rgb * SPECULAR_STRENGTH;
	#endif // !AV_SPECULAR_TEXTURE
#endif

// #ifdef AV_AMBIENT_TEXTURE
	// ambient = AMBIENT_COLOR.rgb * afLightColorAmbient[0].rgb * AMBIENT_TEXTURE.Sample(AMBIENT_SAMPLER,IN.TexCoord0).rgb;
// #else
	// ambient = AMBIENT_COLOR.rgb * afLightColorAmbient[0].rgb + AmbientLight(Normal);
// #endif

	emissive = 0;
#ifdef AV_EMISSIVE_TEXTURE
	emissive.rgb = EMISSIVE_COLOR.rgb * EMISSIVE_TEXTURE.Sample(EMISSIVE_SAMPLER,IN.TexCoord0).rgb;
#else 
	emissive.rgb = EMISSIVE_COLOR.rgb;
#endif
	
#if defined(AV_OPACITY) && !defined(AV_DIFFUSE_TEXTURE)
	diffuse.a = TRANSPARENCY;
#endif

#ifdef AV_LIGHTMAP_TEXTURE
	OUT.rgb *= LIGHTMAP_TEXTURE.Sample(LIGHTMAP_SAMPLER,AV_LIGHTMAP_TEXTURE_UV_COORD).rgb*LM_STRENGTH;
#endif
#ifdef AV_OPACITY_TEXTURE
	OUT.a *= OPACITY_TEXTURE.Sample(OPACITY_SAMPLER,IN.TexCoord0). AV_OPACITY_TEXTURE_REGISTER_MASK;
#endif
}


// Pixel shader - one light
GBuffer psDeferred(VS_OUTPUT IN, uniform bool bSpheres = false)
{
	GBuffer gbuffer;
	
	getMaterialParams(IN, gbuffer.diffuse, gbuffer.specular, gbuffer.emissive, gbuffer.normal.xyz);
	
	gbuffer.normal = float4(mul(gbuffer.normal.xyz, (float3x3)gView)*0.5+0.5, 0);	
	gbuffer.specular.a = dbg.x/100;
	gbuffer.emissive.a = dbg.y/100;
	
	return 	gbuffer;
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

PSOutput BuildTransparency(float3 finalColor, float alpha, float3 filterColor)
{
	PSOutput o;
	o.colorAdd = float4(finalColor, alpha);
	o.colorMul = (filterColor) * (1-alpha);
	return o;
}

// float4 psForward(VS_OUTPUT IN, uniform bool bSpheres = false): SV_Target0
PSOutput psForward(VS_OUTPUT IN, uniform bool bSpheres = false)
{
	GBuffer gb;
	
	getMaterialParams(IN, gb.diffuse, gb.specular, gb.emissive, gb.normal.xyz);
	
	float3 baseColor = pow(gb.diffuse.rgb, 2.2);
	// baseColor.rgb *= gb.diffuse.a;////////////////////////////////////
	
	float3 normal = gb.normal.xyz;

	float roughness = clamp(gb.specular.x, 0.01, 0.999)*0.8+0.2;
	
	float cavity = gb.specular.z*2.0;
	cavity = 1;
	float metallic = gb.specular.y; //baseColor.y;
	
	gb.emissive = 0;
	float3 finalColor = ShadeCustom(gb.normal.xyz, baseColor, roughness, metallic, cavity, 1, gb.emissive.rgb, IN.wPos.xyz/IN.wPos.w, float2(gb.diffuse.a, 1));
	
// #ifdef AV_OPACITY
	return BuildTransparency(finalColor, gb.diffuse.a, baseColor);
// #else
	// return BuildTransparency(finalColor, gb.diffuse.a, float3(0,0.5,1));
// #endif
	PSOutput o;
	o.colorAdd = float4(gb.diffuse.aaa, 1);
	o.colorMul = 0;
	return o;
	// return float4(finalColor, 1);
	// return float4(gb.diffuse.aaa, 1);
}

float4 psShadow(VS_OUTPUT IN) : SV_TARGET0
{
	return 1;
}

#if defined(AV_OPACITY_TEXTURE) || defined(AV_OPACITY)
#define BLEND_STATE enableAlphaBlend
#else
#define BLEND_STATE disableAlphaBlend
#endif

#define BLEND_STATE disableAlphaBlend

BlendState transparentAlphaBlend
{
	BlendEnable[0] = true;
	SrcBlend = ONE;
	DestBlend = SRC1_COLOR;
	BlendOp = ADD;
};


// Technique for the material effect
technique10 MaterialFXSpecular_D1
{
	pass deferred
	{
		DISABLE_CULLING;
		ENABLE_DEPTH_BUFFER;// DISABLE_DEPTH_BUFFER;
		SetBlendState(BLEND_STATE, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_5_0, MaterialVShader_D1(false)));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psDeferred(false)));
	}
	pass forward
	{
		// DISABLE_CULLING;
		FRONT_CULLING;
		ENABLE_DEPTH_BUFFER;// DISABLE_DEPTH_BUFFER;
		SetBlendState(transparentAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_5_0, MaterialVShader_D1(false)));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psForward(false)));
	}
	pass BALLS
	{
		DISABLE_CULLING;
		ENABLE_DEPTH_BUFFER;
		SetBlendState(BLEND_STATE, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_5_0, MaterialVShader_D1(true)));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psDeferred(true)));
	}
};

BlendState shadowmapBlend {
	BlendEnable[0] = TRUE;
	BlendEnable[1] = FALSE;
	SrcBlend = ONE;
	DestBlend = ONE;
	BlendOp = MIN;
	RenderTargetWriteMask[0] = 0x03; 
};

RasterizerState shadowmapRasterizerState
{
	CullMode = None;
	FillMode = SOLID;
	MultisampleEnable = FALSE;
	DepthBias = 0;
	SlopeScaledDepthBias = 0;
	DepthClipEnable = FALSE;

};

technique10 ShadowTech
{
	pass p0
	{
		DISABLE_CULLING;
		DISABLE_DEPTH_BUFFER;
		// SetBlendState(BLEND_STATE, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetBlendState(shadowmapBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(shadowmapRasterizerState); 
		
		SetVertexShader(CompileShader(vs_4_0, MaterialVShader_D1(false)));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psShadow()));
	}
};
