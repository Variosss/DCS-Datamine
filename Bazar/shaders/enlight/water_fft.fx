#include "common/states11.hlsl"
#include "common/samplers11.hlsl"


static const float2 quad[4] = {
	float2(-1, -1), float2(1, -1),
	float2(-1, 1),	float2(1, 1),
};

struct VS_OUTPUT {
	float4 pos:			SV_POSITION;
	float2 projPos:		TEXCOORD0;
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.pos = float4(quad[vid], 0, 1);
	o.projPos = o.pos.xy;
	return o;
}

/////////////////////////////////////////////////////

Texture2D u_phases;
Texture2D u_initialSpectrum;
Texture2D u_input;

Texture2DArray u_windmap;
float u_windmapLerp;

float2 u_wind;
float u_resolution;
float u_size;
float u_deltaTime;
float u_choppiness;
float u_subtransformSize;

static const float PI = 3.14159265359;
static const float G = 9.81;
static const float KM = 370.0;
static const float CM = 0.23;

float square(float x) {
	return x * x;
}

float omega(float k) {
	return sqrt(G * k * (1.0 + square(k / KM)));
}

float tanh(float x) {
	return (1.0 - exp(-2.0 * x)) / (1.0 + exp(-2.0 * x));
}

float rand(float2 co) {  
	return frac(sin(dot(co.xy, float2(12.9898,78.233))) * 43758.5453);
}

float2 multiplyComplex(float2 a, float2 b) {
	return float2(a[0] * b[0] - a[1] * b[1], a[1] * b[0] + a[0] * b[1]);
}

float2 multiplyByI(float2 z) {
	return float2(-z[1], z[0]);
}

float spectrumInit(float2 coordinates) {
	float n = (coordinates.x < u_resolution * 0.5) ? coordinates.x : coordinates.x - u_resolution;
	float m = (coordinates.y < u_resolution * 0.5) ? coordinates.y : coordinates.y - u_resolution;
	float2 waveVector = (2.0 * PI * float2(n, m)) / u_size;
	float k = length(waveVector) + 1e-9;

	float U10 = length(u_wind);

	float Omega = 0.84;
	float kp = G * square(Omega / U10);

	float c = omega(k) / k;
	float cp = omega(kp) / kp;

	float Lpm = exp(-1.25 * square(kp / k));
	float gamma = 1.7;
	float sigma = 0.08 * (1.0 + 4.0 * pow(Omega, -3.0));
	float Gamma = exp(-square(sqrt(k / kp) - 1.0) / 2.0 * square(sigma));
	float Jp = pow(gamma, Gamma);
	float Fp = Lpm * Jp * exp(-Omega / sqrt(10.0) * (sqrt(k / kp) - 1.0));
	float alphap = 0.006 * sqrt(Omega);
	float Bl = 0.5 * alphap * cp / c * Fp;

	float z0 = 0.000037 * square(U10) / G * pow(U10 / cp, 0.9);
	float uStar = 0.41 * U10 / log(10.0 / z0);
	float alpham = 0.01 * ((uStar < CM) ? (1.0 + log(uStar / CM)) : (1.0 + 3.0 * log(uStar / CM)));
	float Fm = exp(-0.25 * square(k / KM - 1.0));
	float Bh = 0.5 * alpham * CM / c * Fm * Lpm;

	float a0 = log(2.0) / 4.0;
	float am = 0.13 * uStar / CM;
	float Delta = tanh(a0 + 4.0 * pow(c / cp, 2.5) + am * pow(CM / c, 2.5));

	float cosPhi = dot(normalize(u_wind), waveVector / k);

	float S = (1.0 / (2.0 * PI)) * pow(k, -4.0) * (Bl + Bh) * (1.0 + Delta * (2.0 * cosPhi * cosPhi - 1.0));

	float dk = 2.0 * PI / u_size;
	return sqrt(S / 2.0) * dk;
}

float PS_SPECTRUM_INIT(VS_OUTPUT i): SV_TARGET0 {
	return spectrumInit(i.pos.xy);
}

float4 PS_PHASE_INIT(VS_OUTPUT i): SV_TARGET0 {
	float2 uv = i.projPos.xy*0.5+0.5;
	return float4(rand(uv)*2*PI, 0, 0, 0); 
}

float4 PS_PHASE(VS_OUTPUT i): SV_TARGET0 {
	float2 v_coordinates = float2(i.projPos.x*0.5+0.5, -i.projPos.y*0.5+0.5);

	float2 coordinates = i.pos.xy/i.pos.w;

	float deltaTime = 1.0 / 60.0;
	float n = (coordinates.x < u_resolution * 0.5) ? coordinates.x : coordinates.x - u_resolution;
	float m = (coordinates.y < u_resolution * 0.5) ? coordinates.y : coordinates.y - u_resolution;
	float2 waveVector = (2.0 * PI * float2(n, m)) / u_size;

	float phase = u_phases.SampleLevel(gPointClampSampler, v_coordinates, 0).r;
	float deltaPhase = omega(length(waveVector)) * u_deltaTime;
	phase = fmod(phase + deltaPhase, 2.0 * PI);

	return float4(phase,0,0,0);
}


float4 PS_SPECTRUM(VS_OUTPUT i): SV_TARGET0 {
	float2 v_coordinates = float2(i.projPos.x*0.5+0.5, -i.projPos.y*0.5+0.5);

	float2 coordinates = i.pos.xy/i.pos.w;

	float n = (coordinates.x < u_resolution * 0.5) ? coordinates.x : coordinates.x - u_resolution;
	float m = (coordinates.y < u_resolution * 0.5) ? coordinates.y : coordinates.y - u_resolution;
	float2 waveVector = (2.0 * PI * float2(n, m)) / u_size;

	float phase = u_phases.SampleLevel(gPointClampSampler, v_coordinates, 0).r;
	float2 phaseVector = float2(cos(phase), sin(phase));

#if 0
	float2 h0 = spectrumInit(coordinates);
	float2 h0Star = spectrumInit(u_resolution - coordinates);
#else
	float2 h0 = float2(u_initialSpectrum.SampleLevel(gPointWrapSampler, v_coordinates, 0).r, 0);
	float2 h0Star = float2(u_initialSpectrum.SampleLevel(gPointWrapSampler, 1.0 - v_coordinates, 0).r, 0);
#endif
	h0Star.y *= -1.0;

	float2 h = multiplyComplex(h0, phaseVector) + multiplyComplex(h0Star, float2(phaseVector.x, -phaseVector.y));

	float rwv = 1.0 / (length(waveVector) + 1e-9);
	float2 hX = -multiplyByI(h * waveVector.x * rwv) * u_choppiness;
	float2 hZ = -multiplyByI(h * waveVector.y * rwv) * u_choppiness;

	return float4(hX + multiplyByI(h), hZ);
}

float4 PS_TRANSFORM(VS_OUTPUT i, uniform bool HORIZONTAL, uniform bool buildWindmap = false): SV_TARGET0 {
	float2 v_coordinates = float2(i.projPos.x*0.5+0.5, -i.projPos.y*0.5+0.5);
	float2 coordinates = i.pos.xy/i.pos.w;

	float index;
	if(HORIZONTAL)
		index = v_coordinates.x * u_resolution - 0.5;
	else
		index = v_coordinates.y * u_resolution - 0.5;
	
	float evenIndex = floor(index / u_subtransformSize) * (u_subtransformSize * 0.5) + fmod(index, u_subtransformSize * 0.5);
				
	//transform two complex sequences simultaneously
	float4 even, odd;
	if(HORIZONTAL) {
		even = u_input.SampleLevel(gPointClampSampler, float2(evenIndex + 0.5, coordinates.y) / u_resolution, 0);
		odd =  u_input.SampleLevel(gPointClampSampler, float2(evenIndex + u_resolution * 0.5 + 0.5, coordinates.y) / u_resolution, 0);
	} else {
		even = u_input.SampleLevel(gPointClampSampler, float2(coordinates.x, evenIndex + 0.5) / u_resolution, 0);
		odd = u_input.SampleLevel(gPointClampSampler, float2(coordinates.x, evenIndex + u_resolution * 0.5 + 0.5) / u_resolution, 0);
	}

	float twiddleArgument = -2.0 * PI * (index / u_subtransformSize);
	float2 twiddle = float2(cos(twiddleArgument), sin(twiddleArgument));

	float2 outputA = even.xy + multiplyComplex(twiddle, odd.xy);
	float2 outputB = even.zw + multiplyComplex(twiddle, odd.zw);

	float4 result = float4(outputA, outputB);

	if (buildWindmap) {
		float c0 = u_windmap.SampleLevel(gPointClampSampler, float3(v_coordinates, 0), 0).x;
		float c1 = u_windmap.SampleLevel(gPointClampSampler, float3(v_coordinates, 1), 0).x;
		float mul = 1.5 - abs(u_windmapLerp - 0.5);
		result = float4(result.xzy, lerp(c0, c1, u_windmapLerp) * mul);
		result.y *= 1.5;
	}

	return result;
}

void PS_NORMAL(VS_OUTPUT i, out float4 out_normal: SV_TARGET0, out float4 out_displace: SV_TARGET1) {
	float2 v_coordinates = float2(i.projPos.x*0.5+0.5, -i.projPos.y*0.5+0.5);

	float texel = 1.0 / u_resolution;
	float texelSize = u_size / u_resolution;

	out_displace = u_input.SampleLevel(gPointClampSampler, v_coordinates, 0);
	float3 center = out_displace.xyz;
#if 1
	float3 dx = float3(texelSize, 0, 0) + u_input.SampleLevel(gPointClampSampler, v_coordinates + float2(texel, 0), 0).xyz - center;
	float3 dy = float3(0, 0, texelSize) + u_input.SampleLevel(gPointClampSampler, v_coordinates + float2(0, texel), 0).xyz - center;
	float3 normal = normalize(cross(dy, dx));
#else
	float3 right =  float3( texelSize, 0.0, 0.0) + u_input.SampleLevel(gPointClampSampler, v_coordinates + float2( texel, 0.0), 0).xyz - center;
	float3 left =   float3(-texelSize, 0.0, 0.0) + u_input.SampleLevel(gPointClampSampler, v_coordinates + float2(-texel, 0.0), 0).xyz - center;
	float3 top =    float3(0.0, 0.0, texelSize) + u_input.SampleLevel(gPointClampSampler, v_coordinates + float2(0.0, texel), 0).xyz - center;
	float3 bottom = float3(0.0, 0.0, -texelSize) + u_input.SampleLevel(gPointClampSampler, v_coordinates + float2(0.0, -texel), 0).xyz - center;

	float3 topRight = cross(right, top);
	float3 topLeft = cross(top, left);
	float3 bottomLeft = cross(left, bottom);
	float3 bottomRight = cross(bottom, right);

	float3 normal = normalize(topRight + topLeft + bottomLeft + bottomRight);
#endif

	float tx = texel * 30;// gDev0.x;
	float fx1 = u_input.SampleLevel(gTrilinearWrapSampler, v_coordinates + float2(tx, 0), 0).y - center.y;
	float fx2 = u_input.SampleLevel(gTrilinearWrapSampler, v_coordinates + float2(-tx, 0), 0).y - center.y;
	float fy1 = u_input.SampleLevel(gTrilinearWrapSampler, v_coordinates + float2(0, tx), 0).y - center.y;
	float fy2 = u_input.SampleLevel(gTrilinearWrapSampler, v_coordinates + float2(0, -tx), 0).y - center.y;

	float foam = max(-fx1 - fx2 - fy1 - fy2, 0) * max(center.y, 0) * (u_resolution / 256.0 * 0.025); // gDev0.y;

	out_normal = float4(normal.xz, center.y*0.25, saturate(foam));
}

float4 PS_COPY(VS_OUTPUT i) : SV_TARGET0 {
	return u_input.Load(uint3(i.pos.xy, 0)).x;
}

#define COMMON_PART 		SetVertexShader(CompileShader(vs_5_0, VS()));	\
							SetHullShader(NULL);							\
							SetDomainShader(NULL);							\
							SetGeometryShader(NULL);						\
							SetComputeShader(NULL);							\
							SetDepthStencilState(disableDepthBuffer, 0);	\
							SetRasterizerState(cullNone);					\
							SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);

technique10 SpectrumInit {
    pass P0	{          
		SetPixelShader(CompileShader(ps_5_0, PS_SPECTRUM_INIT()));
		COMMON_PART
    }
}

technique10 PhaseInit {
    pass P0	{          
		SetPixelShader(CompileShader(ps_5_0, PS_PHASE_INIT()));
		COMMON_PART
	}
}

technique10 Phase {
    pass P0 {          
		SetPixelShader(CompileShader(ps_5_0, PS_PHASE()));
		COMMON_PART
	}
}

technique10 Spectrum {
    pass P0 {          
		SetPixelShader(CompileShader(ps_5_0, PS_SPECTRUM()));
		COMMON_PART
	}
}

technique10 Transform {
    pass P0	{          
		SetPixelShader(CompileShader(ps_5_0, PS_TRANSFORM(true)));
		COMMON_PART
	}
    pass P1	{          
		SetPixelShader(CompileShader(ps_5_0, PS_TRANSFORM(false)));
		COMMON_PART
	}
	pass P2 {
		SetPixelShader(CompileShader(ps_5_0, PS_TRANSFORM(false, true)));
		COMMON_PART
	}
}

technique10 Normal {
    pass P0	{          
		SetPixelShader(CompileShader(ps_5_0, PS_NORMAL()));
		COMMON_PART
	}
}

technique10 WindMap {
	pass P0 {
		SetPixelShader(CompileShader(ps_5_0, PS_COPY()));
		COMMON_PART
	}
}
