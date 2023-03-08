#ifndef TEXTURE_SAMPLERS_HLSL
#define TEXTURE_SAMPLERS_HLSL

// We expect to get this define from engine.
#ifndef MAXANISOTROPY_DEFAULT
#define MAXANISOTROPY_DEFAULT 16
#endif

// В dx11 мы могли б подставлять ANISOTROPIC "как есть", но в dx9 его все-равно пришлось б
// дефайнить, а это кейворд, которые для избежания недоразумений луше не передефайнивать,
// поэтому используйте MIN_MAG_MIP_ANISOTROPIC
#define MIN_MAG_MIP_ANISOTROPIC ANISOTROPIC

// Фильтрации:
// MIN_MAG_MIP_POINT
// MIN_MAG_POINT_MIP_LINEAR
// MIN_POINT_MAG_LINEAR_MIP_POINT
// MIN_POINT_MAG_MIP_LINEAR
// MIN_LINEAR_MAG_MIP_POINT
// MIN_LINEAR_MAG_POINT_MIP_LINEAR
// MIN_MAG_LINEAR_MIP_POINT
// MIN_MAG_MIP_LINEAR
// MIN_MAG_MIP_ANISOTROPIC

#define TEXTURE_SAMPLER(textureName, filter, addressU, addressV) SamplerState textureName##Sampler\
{\
	Filter        = filter;\
	AddressU      = addressU;\
	AddressV      = addressV;\
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;\
	BorderColor   = float4(0, 0, 0, 0);\
}

#define TEXTURE_SAMPLER_CUBE(textureName, filter, addressU, addressV) SamplerState textureName##Sampler\
{\
	Filter        = filter;\
	AddressU      = addressU;\
	AddressV      = addressV;\
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;\
	BorderColor   = float4(0, 0, 0, 0);\
}

#define TEXTURE_SAMPLER_CUBE(textureName, filter, addressU, addressV) SamplerState textureName##Sampler\
{\
	Filter        = filter;\
	AddressU      = addressU;\
	AddressV      = addressV;\
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;\
	BorderColor   = float4(0, 0, 0, 0);\
}

#define TEXTURE_SAMPLER_WHITEBORDER(textureName, filter, addressU, addressV) SamplerState textureName##Sampler\
{\
	Filter        = filter;\
	AddressU      = addressU;\
	AddressV      = addressV;\
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;\
	BorderColor   = float4(1, 1, 1, 1);\
}

#define TEXTURE_SAMPLER_DEFAULT(textureName, address) SamplerState textureName##Sampler\
{\
	Filter        = ANISOTROPIC;\
	AddressU      = address;\
	AddressV      = address;\
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;\
	BorderColor   = float4(0, 0, 0, 0);\
}

#define TEXTURE_SAMPLER3D_FILTER(textureName, filter, addressU, addressV, addressW) SamplerState textureName##Sampler\
{\
	Filter        = filter;\
	AddressU      = addressU;\
	AddressV      = addressV;\
	AddressW      = addressW;\
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;\
	BorderColor   = float4(0, 0, 0, 0);\
}

#define TEXTURE_SAMPLER3D(textureName, addressU, addressV, addressW) SamplerState textureName##Sampler\
{\
	Filter        = ANISOTROPIC;\
	AddressU      = addressU;\
	AddressV      = addressV;\
	AddressW      = addressW;\
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;\
	BorderColor   = float4(0, 0, 0, 0);\
}

#define TEXTURE_SAMPLER3D_DEFAULT(textureName, address) SamplerState textureName##Sampler\
{\
	Filter        = ANISOTROPIC;\
	AddressU      = address;\
	AddressV      = address;\
	AddressW      = address;\
	MaxAnisotropy = MAXANISOTROPY_DEFAULT;\
	BorderColor   = float4(0, 0, 0, 0);\
}

#define TEX2D(textureName, texCoord) textureName.Sample(textureName##Sampler, (texCoord).xy)
#define TEX3D(textureName, texCoord) textureName.Sample(textureName##Sampler, (texCoord).xyz)
#define TEX2DLOD(textureName, texCoord) textureName.SampleLevel(textureName##Sampler, (texCoord).xy, (texCoord).w)
#define TEX2DPROJ(textureName, texCoord) textureName.Sample(textureName##Sampler, (texCoord).xy / (texCoord).w)
#define TEX2DARRAY(textureName, texCoord, index) textureName.Sample(textureName##Sampler, float3((texCoord).xy, index))
#define TEXCUBE(textureName, texCoord) textureName.Sample(textureName##Sampler, (texCoord).xyz)
#define TEX3DLOD(textureName, texCoord) textureName.SampleLevel(textureName##Sampler, (texCoord).xyz, (texCoord).w)

// Для ручной выборки
#define TEX2DMS(textureName, texCoord, sample) textureName.Load(texCoord, sample)

#endif
