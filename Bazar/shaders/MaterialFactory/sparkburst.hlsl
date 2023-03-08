#include "ParticleSystem2/common/perlin.hlsl"

float corners[8];
float3 meye;
float time;

float minspeed;
float maxspeed;
float3 accel;
float2 streaksize;

float onemcosetamax;
float4x4 orient;

float3x3 segm_basis(float3 axis, float3 meye) {
	float3x3 basis;
	basis[0] = axis;				// major axis is x
	basis[1] = normalize(cross(basis[0], meye));	// y is "up"
	basis[2] = cross(basis[0], basis[1]);		// z is "out-of-billboard"

	return basis;
}

struct vsSparkInput {
	float4 vPosition:		POSITION0;
	float2 vTexCoord0:		TEXCOORD0;
};

struct vsSparkOutput{
	float4 vPosition:	SV_POSITION;
	float3 vTexCoord:	TEXCOORD0;
};

vsSparkOutput vsSpark(in const vsSparkInput i)
{
	vsSparkOutput o;
	float2 st;

	float4 rand = i.vPosition;
	int cornidx = int(i.vTexCoord0.x);
	
	float t = rand.z*32.63167 + time;		// current time
	
	float randByRebirth = noise1D(int(t)+rand.x);
	float randByRebirth2 = noise1D(randByRebirth);
	float randByRebirth3 = noise1D(randByRebirth2);
	
	t = frac(t);
	
	float sinphi, cosphi;
	sincos((randByRebirth+1)*3.1415926f, sinphi, cosphi);//верхняя полусфера

	float coseta = 1 - randByRebirth2 * onemcosetamax;
	float sineta = sqrt(1 - coseta * coseta);

	// Generate random direction within solid angle around y axis
	float3 v = normalize(float3(sineta * cosphi, randByRebirth2+0.005, sineta * sinphi*1.1));
	float speedValue = lerp(minspeed, maxspeed, randByRebirth3);
	float3 vel0 = speedValue * mul(orient, float4(v, 0.0)).xyz;		// initial velocity
	
	vel0.y += 2;

	// Calculate spark position

	float3 pos = vel0 * t + accel * t * t * 0.5f;	// current position in modelspace
	float3 vel = vel0 + accel * t;			// current velocity
	float3 vmag = length(vel);			// velocity magnitude
	float3 dir = vel / vmag;			// normalized flight direction

	// Calculate current corner vertex position
	float2 corner = float2(corners[cornidx * 2], corners[cornidx * 2 + 1]);
	st.xy = corner;//UV
	st.x *= 0.5;
	st.y += 0.5f;
	float alpha = uOpacity*step(0.5, st.x);
	
	corner *= streaksize;
	float3x3 sbasis = segm_basis(dir, meye - pos);
	pos += vmag * corner.x * sbasis[0] + corner.y * sbasis[1];	// current vertex position in modelspace

	o.vPosition = mul(float4(pos, 1), matWorldViewProj);
	o.vTexCoord = float3(st, alpha);//UV, alpha
	
	return o;
}

float4 psSpark(in vsSparkOutput i) : SV_TARGET0 
{
	return float4(DiffuseMap.Sample(WrapLinearSampler, i.vTexCoord.xy).rgb, i.vTexCoord.z);
}

technique10 transparent {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, vsSpark()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSpark()));

		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		// SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
	}
}
