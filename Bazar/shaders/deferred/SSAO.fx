#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "deferred/Decoder.hlsl"

#define KERNEL 32
#define GAUSS_KERNEL 4
#define SMOOTH_NORMALS 1
#define SIGMA (GAUSS_KERNEL - 1)*1.4

float radius;
uint4 viewport;

Texture2D<float> src;
Texture2D<float> srcDist;

struct VS_OUTPUT {
	float4 pos:			SV_POSITION;
	float4 projPos:		TEXCOORD0;
};

static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

static const int2 offs[4] = {
	{0, 0}, {0, 1},
	{1, 1}, {1, 0}
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.projPos = o.pos = float4(quad[vid], 0, 1);
	return o;
}

float hash(float3 n) {
	return frac(sin(dot(n, float3(311.7, 269.5, 183.3))) * 43758.5453);
}

float3x3 vecToMatrix(float3 vZ) {
	float3 vX = lerp(cross(vZ, float3(0, 0, 1)), cross(float3(0, -1, 0), vZ), step(abs(vZ.y), 0.7));
	vX = normalize(vX);
	float3 vY = cross(vZ, vX);
	float3x3 m = { vX, vY, vZ };
	return m;
}

uint2 proj2pix(float2 projXY) {
	return (float2(projXY.x, -projXY.y) * 0.5 + 0.5) * viewport.zw + viewport.xy - 0.5;
}

float2 SSAOSample(const VS_OUTPUT i) {
	float2 projXY = i.projPos.xy / i.projPos.w;
	uint2 pix = proj2pix(projXY);

	float depth = SampleMap(DepthMap, pix, 0).x;
	float4 p = mul(float4(projXY, depth, 1), gProjInv);
	float3 vPos = p.xyz/p.w;

	if (vPos.z > 50000)
		return float2(1, vPos.z);
	
	float3 vNormal = DecodeNormal(pix, 0);
#if SMOOTH_NORMALS
	[unroll]
	for (uint j = 1; j < 4; ++j)
		vNormal += DecodeNormal(pix + offs[j], 0) * 0.9;
#endif
	vNormal = mul(normalize(vNormal), (float3x3)gView);

#if 1
	float distFactor = (10 + vPos.z)*0.005; 
#else
	float distFactor = 0.1 + smoothstep(2.0, 10.0, vPos.z);
#endif

	const float bias = vPos.z*0.001;
	vPos += vNormal * bias;

	float3x3 lm = vecToMatrix(vNormal);
	float offset = 1.0 / KERNEL;
	static const float incr = 3.1415926535897932384626433832795 * (3.0 - sqrt(5.0));
	float acc = 0;
	
	for (uint k = 0; k < KERNEL; ++k) {
		float z = 1 - k * offset;
		float r = sqrt(1 - z * z);
		float s, c;
		sincos(k * incr, s, c);
		float3 v = mul(float3(c * r, s * r, z), lm);

		float rnd = 0.1 + 0.9 * hash(float3(i.pos.xy, k));
		float rad = radius * rnd * distFactor;
		float3 pos = vPos + v * rad;

		float4 NDC = mul(float4(pos, 1), gProj);
		NDC.xy /= NDC.w;
		uint2 pixelPos = proj2pix(NDC.xy);
		float depth = SampleMap(DepthMap, pixelPos, 0).x;
		float4 p = mul(float4(NDC.xy, depth, 1), gProjInv);
		p.z /= p.w;
		acc += step(p.z, pos.z) * step(pos.z - p.z, rad);
	}
	acc = 1 - acc / KERNEL;
	acc = acc * acc;

//	acc = lerp(1, acc, exp(-vPos.z*0.005));
	return float2(acc, vPos.z);
}

float gaussian(float x, float s) {
	return exp(-x*x / (2*s*s));
}

float gaussianBlur(uint2 uv) {
	float aw = 0;
	float acc = 0;
	for (int iy = -GAUSS_KERNEL; iy <= GAUSS_KERNEL; ++iy) {
		float gy = gaussian(iy, SIGMA);
		for (int ix = -GAUSS_KERNEL; ix <= GAUSS_KERNEL; ++ix) {
			float gx = gaussian(ix, SIGMA);
			float w = gx * gy;
			acc += src.Load(uint3(uv.x + ix, uv.y + iy, 0)).x * w;
			aw += w;
		}
	}
	return acc / aw;
}

float joinedBilateralGaussianBlur(uint2 uv) {
	float pz = srcDist.Load(uint3(uv, 0)).x * 1000;
	float aw = 0;
	float acc = 0;
	for (int iy = -GAUSS_KERNEL; iy <= GAUSS_KERNEL; ++iy) {
		float gy = gaussian(iy, SIGMA);
		for (int ix = -GAUSS_KERNEL; ix <= GAUSS_KERNEL; ++ix) {
			float gx = gaussian(ix, SIGMA);
			float vz = srcDist.Load(uint3(uv.x + ix, uv.y + iy, 0)).x * 1000;
			float gv = gaussian(abs((pz - vz) / pz * 1000.0), SIGMA);
			float w = gx * gy * gv;
			acc += src.Load(uint3(uv.x + ix, uv.y + iy, 0)).x * w;
			aw += w;
		}
	}
	return acc / aw;
}

struct PS_OUTPUT {
	float4 ssao: SV_TARGET0;
	float4 dist: SV_TARGET1;
};

PS_OUTPUT PS(const VS_OUTPUT i) {
	float2 ssao = SSAOSample(i);
	PS_OUTPUT o;
	o.ssao = float4(ssao.x, 0, 0, 1);
	o.dist = float4(ssao.y*0.001, 0, 0, 1);
	return o;
}

float4 PS_BLUR(const VS_OUTPUT i): SV_TARGET0 {
//	return float4(gaussianBlur(i.pos.xy), 0, 0, 1);
	return float4(joinedBilateralGaussianBlur(i.pos.xy), 0, 0, 1);
}

#define COMMON_PART			SetVertexShader(CompileShader(vs_5_0, VS()));				\
		SetGeometryShader(NULL);														\
		SetDepthStencilState(disableDepthBuffer, 0);									\
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
		SetRasterizerState(cullNone);

technique10 SSAO {
	pass P0 {
		SetPixelShader(CompileShader(ps_5_0, PS()));
		COMMON_PART
	}
	pass P1 {
		SetPixelShader(CompileShader(ps_5_0, PS_BLUR()));
		COMMON_PART
	}
}
