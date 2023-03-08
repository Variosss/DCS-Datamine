#include "../common/samplers11.hlsl"
#include "../common/states11.hlsl"
#include "common/quat.hlsl"

#define GROUP_DIM 32

#define MAX_DROPLETS 1024
#define TEX_SIZE 2048

#define DROPLET_SIZE 7.0
#define AFFINITY_SCALE 50
#define VELOCITY_SCALE 0.15

Texture2D src;
Texture2D surface;
Texture2D wiperFields;

float	timeDelta;
float3	wind;
float	windForce;
float	dropletScale;
float2	wipers;

#define DROPLET_SCALE (dropletScale * DROPLET_SIZE / TEX_SIZE)

struct Droplet {
	float2	pos, vel, force;
	float	mass, walk;
};

uint countAdd;
StructuredBuffer<Droplet> simAdd;
StructuredBuffer<Droplet> simSrc;
RWStructuredBuffer<Droplet> simDst;
RWStructuredBuffer<uint> dropletCount;
RWTexture2D<float> result;

groupshared uint gCount;


static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

struct VS_OUTPUT {
	float4 pos:		SV_POSITION;
	float4 projPos:	TEXCOORD0;
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.projPos = o.pos = float4(quad[vid], 0, 1);
	return o;
}

float4 COPY_PS(const VS_OUTPUT i): SV_TARGET0 {
	float2 uv = float2(i.projPos.x*0.5 + 0.5, -i.projPos.y*0.5 + 0.5);
	return float4(src.SampleLevel(ClampLinearSampler, uv, 0).xyz, 1);
//	return float4(surface.SampleLevel(ClampLinearSampler, float3(uv, 0), 0).xyz, 1);
//	return src.Load(int3(i.pos.xy, 0));
}

[numthreads(1, 1, 1)]
void INIT_CS(uint3 gid: SV_GroupId, uint3 gtid : SV_GroupThreadID) {
	dropletCount[0] = 0;
}

[numthreads(32, 32, 1)]
void ADD_CS(uint3 gid: SV_GroupId, uint3 gtid : SV_GroupThreadID) {

	uint gIdx = gtid.y * GROUP_DIM + gtid.x;

	uint dCount = dropletCount[0];
	uint cntAdd = min(countAdd, MAX_DROPLETS - dCount);

	if (gIdx < cntAdd) 
		simDst[dCount + gIdx] = simAdd[gIdx];

	GroupMemoryBarrierWithGroupSync();

	if (gIdx == 0)
		dropletCount[0] = min(dCount + cntAdd, MAX_DROPLETS);
}

///////////// SOLVER

static const float a1 = 1, a2 = 1, b = 0;// .75;

#define HASHSCALE1 .1031
#define HASHSCALE3 float3(.1031, .1030, .0973)
#define HASHSCALE4 float4(.1031, .1030, .0973, .1099)

float hash12(float2 p) {
	float3 p3 = frac(float3(p.xyx) * HASHSCALE1);
	p3 += dot(p3, p3.yzx + 19.19);
	return frac((p3.x + p3.y) * p3.z);	
}

float2 hash22(float2 p) {
	float3 p3 = frac(float3(p.xyx) * HASHSCALE3);
	p3 += dot(p3, p3.yzx + 19.19);
	return frac((p3.xx + p3.yz)*p3.zy);

}

float4 getTangentSpace(float2 uv) {
	return normalize((surface.SampleLevel(ClampPointSampler, uv, 0) - 127.0 / 255) * 2);
}

bool surfacePresent(float2 pos) {
	return any(surface.SampleLevel(ClampPointSampler, pos*0.5 + 0.5, 0).xyz);
}

float3 getForce(float3 normal) {
	return float3(0, -1, 0)+wind*0.1;
}

float getAffinity(float2 pos) {
	return saturate(hash12(pos))*0.8 + 0.1;
	return 0.25;
}

float3 normalFromTangentSpace(float4 q) {
	return float3(2 * q.x*q.z - 2 * q.y*q.w, 2 * q.y*q.z + 2 * q.x*q.w, 1 - 2 * q.x*q.x - 2 * q.y*q.y);
}

[numthreads(32, 32, 1)]
void SIM_CS(uint3 gid: SV_GroupId, uint3 gtid : SV_GroupThreadID, uniform bool clearEmpty) {

	uint gIdx = gtid.y * GROUP_DIM + gtid.x;

	if (gIdx == 0)
		gCount = 0;						// init new count
	GroupMemoryBarrierWithGroupSync();

	uint dCount = dropletCount[0];
	if (gIdx < dCount) {

		Droplet d = simSrc[gIdx];

		float4 q = getTangentSpace(d.pos*0.5 + 0.5);
		float3 normal = normalFromTangentSpace(q);

		float cForce = b*getAffinity(d.pos);		// critical force
		float3 force = getForce(normal)*d.mass;		// world space

		if (length(force) > cForce) {
			float3 Vs = force - normal*dot(force, normal);	// world space along surface
			d.force = mulQuatVec3(q, Vs).xy;				// texture space

			float2 a = d.force / d.mass;
			float2 da = saturate(hash22(round(d.pos * AFFINITY_SCALE) / AFFINITY_SCALE)) - 0.5;
			a += da * step(0,dot(a,da));

			d.vel += a;
			float l = max(length(d.vel), 1e-9);
			d.vel *= max(0, l - (1 - exp(-l))) / l;		// friction

			float2 dp = d.vel * timeDelta * VELOCITY_SCALE;
			d.pos += dp;
			d.walk += length(dp) * 2;
		}

//		if (d.pos.x > -1 && d.pos.y > -1 && d.pos.x < 1 && d.pos.y < 1) {
		if(surfacePresent(d.pos)) {
			uint idx;
			InterlockedAdd(gCount, 1, idx);
			simDst[idx] = d;
		}

	}

	GroupMemoryBarrierWithGroupSync();
	if (gIdx == 0) {
		dropletCount[0] = gCount;	// save new droplet count
		if (clearEmpty) {
			for (uint i = gCount; i < MAX_DROPLETS; ++i)
				simDst[i].mass = 0;
		}
	}
}


[numthreads(32, 32, 1)]
void COLLISION_CS(uint3 gid: SV_GroupId, uint3 gtid : SV_GroupThreadID) {
	
	uint gIdx = gtid.y * GROUP_DIM + gtid.x;

	if (gIdx == 0) 
		gCount = 0;						// init new count
	GroupMemoryBarrierWithGroupSync();

	uint dCount = dropletCount[0];
	if (gIdx < dCount) {

		Droplet d = simSrc[gIdx];
		float r = pow(abs(d.mass), 0.33) * DROPLET_SCALE;

#if 1
		[loop]
		for (uint i = 0; i < dCount; ++i) {

			Droplet d2 = simSrc[i];

			if (i == gIdx)// || d2.mass >= 2)
				continue;

			float r2 = pow(abs(d2.mass), 0.33) * DROPLET_SCALE;

//				if ((length(d2.pos - d.pos) < r + r2) && (dot(d2.pos - d.pos, d.vel) < 0)) { //	collide
			if (length(d2.pos - d.pos) < (r + r2)) { //	collide
				if (d.mass > d2.mass) {
					d.vel = (d.vel*d.mass + d2.vel*d2.mass) / (d.mass + d2.mass);
					d.mass = min(2, d.mass + d2.mass);		// eat droplet
				}
				else {
					d.mass = 0;				// kill self droplet
					break;
				}
			}
		}
#endif					
		if (d.mass > 0) {
			uint idx;
			InterlockedAdd(gCount, 1, idx);
			simDst[idx] = d;
		}
	}

	GroupMemoryBarrierWithGroupSync();
	if (gIdx == 0) {						// save new droplet count
		for (uint i = gCount; i < MAX_DROPLETS; ++i) {
			simDst[i].mass = 0;
		}
		dropletCount[0] = gCount;
	}

}

[numthreads(32, 32, 1)]
void SPLIT_CS(uint3 gid: SV_GroupId, uint3 gtid : SV_GroupThreadID) {

	uint gIdx = gtid.y * GROUP_DIM + gtid.x;

	uint dCount = dropletCount[0];

	if (gIdx == 0)
		gCount = dCount;				// init new count
	GroupMemoryBarrierWithGroupSync();

	if (gIdx < dCount) {

		Droplet d = simSrc[gIdx];
		if (d.walk > 0.2) {
			uint idx;
			InterlockedAdd(gCount, 1, idx);
			if (idx < MAX_DROPLETS) {

				Droplet d2 = d;
				d2.mass = d.walk;
				d2.walk = 0;
				d2.pos -= d.vel * timeDelta * VELOCITY_SCALE;
//				d2.vel = 0;

				simDst[idx] = d2;

				d.mass -= d.walk;
				d.walk = 0;
			}
		}
		simDst[gIdx] = d;
	}

	GroupMemoryBarrierWithGroupSync();
	if (gIdx == 0)						// save new droplet count
		dropletCount[0] = gCount;

}


/////////////////////////////////  clear

float wipersValue(float2 uv) {
	float2 w = wiperFields.SampleLevel(ClampLinearSampler, uv, 0).yz * wipers;
	return max(w.x, w.y);
}

struct DROPS_CLEAR_VS_OUTPUT {
	float4 pos:		TEXCOORD0;
	float  mass:	TEXCOORD1;
};

struct DROPS_CLEAR_PS_INPUT {
	float4 pos:		SV_POSITION;
	float2 uv:		TEXCOORD0;
	float2 uv2:		TEXCOORD1;
};

DROPS_CLEAR_VS_OUTPUT DROPS_CLEAR_VS(uint vid: SV_VertexID) {
	DROPS_CLEAR_VS_OUTPUT o;
	Droplet d = simSrc[vid];
	o.pos = float4(d.pos.x, -d.pos.y, float2(d.vel.x, -d.vel.y) * timeDelta * VELOCITY_SCALE);
	o.mass = d.mass;
	return o;
}

[maxvertexcount(4)]
void DROPS_CLEAR_GS(point DROPS_CLEAR_VS_OUTPUT i[1], inout TriangleStream<DROPS_CLEAR_PS_INPUT> os) {
	DROPS_CLEAR_PS_INPUT o;
	if (i[0].mass == 0)
		return;

	float2 d = i[0].pos.zw;
	float2 p[2] = { i[0].pos.xy, i[0].pos.xy-d };
	float scale = pow(abs(i[0].mass), 0.33)*DROPLET_SCALE;

	float2 dn = any(d) ? normalize(d) : float2(0, 1);
//	float2x2 m = float2x2(dn.y, dn.x, -dn.x, dn.y);
	float2x2 m = float2x2(-dn.y, dn.x, -dn.x, -dn.y);

	[unroll]
	for (int k = 0; k < 4; ++k) {
		float2 dp = mul(quad[k], m);
		o.pos = float4(p[k/2] + dp * scale, 0, 1);
		o.uv = dp;
		o.uv2 = float2(o.pos.x * 0.5 + 0.5, -o.pos.y * 0.5 + 0.5);
		os.Append(o);
	}
	os.RestartStrip();
}

float4 DROPS_CLEAR_PS(const DROPS_CLEAR_PS_INPUT i, uniform bool useWipers) : SV_TARGET0 {
//	return float4(0, 0, 0, 1);
	
	float2 uv = i.uv; uv.y = abs(0.2*uv.y);

	float d2 = 1 - dot(uv, uv);
	if (d2 < 0)
		return float4(0.5, 0.5, 1, 1);
	float3 n = normalize(float3(uv, sqrt(d2) + 20 ));
//	float3 n = normalize(float3(uv, sqrt(d2) + max(5, 50 - length(wind) * 2)));

	n = normalize(lerp(n, float3(0, 0, 1), saturate(windForce*0.01)));

	if (useWipers) 
		n = lerp(n, float3(0, 0, 1), wipersValue(i.uv2));

	return float4(n*0.5 + 0.5, 1);
}

/////////////////////////////////  dropsAdd

float2 DROPS_ADD_VS(uint vid: SV_VertexID): TEXCOORD0 {
	Droplet d = simAdd[vid];
	return d.pos;
}

#define MICRO_DROPLETS 5

[maxvertexcount(4 * MICRO_DROPLETS)]
void DROPS_ADD_GS(point float2 i[1]: TEXCOORD0, inout TriangleStream<DROPS_CLEAR_PS_INPUT> os) {
	DROPS_CLEAR_PS_INPUT o;
	float2 p = i[0];

	[unroll]
	for (uint j = 0; j < MICRO_DROPLETS; ++j) {
		float2 d = hash22(p+j)-0.5;
//		d = float2(cos(j*6.28 / MICRO_DROPLETS), sin(j*6.28 / MICRO_DROPLETS));
		float2 dn = normalize(d);
		float2x2 dm = float2x2(-dn.y, dn.x, -dn.x, -dn.y);

		float2 pd = p + d*0.1;
		[unroll]
		for (uint k = 0; k < 4; ++k) {
			float2 q = quad[k];
			float2 qq = mul(float2(q.x, q.y*2), dm);
			o.pos = float4(pd + qq * 0.2 * DROPLET_SCALE, 0, 1);
			o.uv = mul(q, dm);
			o.uv2 = float2(o.pos.x * 0.5 + 0.5, -o.pos.y * 0.5 + 0.5);
			os.Append(o);
		}
		os.RestartStrip();
	}
}

float4 DROPS_ADD_PS(const DROPS_CLEAR_PS_INPUT i, uniform bool useWipers) : SV_TARGET0 {
	float d2 = 1 - dot(i.uv, i.uv);
	if (d2 < 0)
		discard;
//	return float4(1, 0, 0, 1);
	float3 n = normalize(float3(i.uv, sqrt(d2)));

	n = lerp(n, float3(0, 0, 1), saturate((windForce-15)*0.1));

	if (useWipers)
		n = lerp(n, float3(0, 0, 1), wipersValue(i.uv2)*0.7);

	return float4(n*0.5 + 0.5, 1);
}

/////////////////////////////////  drops

struct DROPS_VS_OUTPUT {
	float3 pos:		TEXCOORD0;
	float4 vel:		TEXCOORD1;
};

struct DROPS_PS_INPUT {
	float4 pos:		SV_POSITION;
	float2 uv:		TEXCOORD0;
	float2 uv2:		TEXCOORD1;
	float  mass:	TEXCOORD2;
	float2 force:	TEXCOORD3;
};

static const float2 strip[6] = {
	{ -1, -1 },{ 1, -1 },
	{ -1,  0 },{ 1,  0 },
	{ -1,  1 },{ 1,  1 }
};

DROPS_VS_OUTPUT DROPS_VS(uint vid: SV_VertexID) {
	Droplet d = simSrc[vid];
	DROPS_VS_OUTPUT o;
	o.pos = float3(d.pos.x, -d.pos.y, d.mass);
	o.vel = float4(d.vel, d.force);
	return o;
}

[maxvertexcount(6)]
void DROPS_GS(point DROPS_VS_OUTPUT i[1], inout TriangleStream<DROPS_PS_INPUT> os) {
	DROPS_PS_INPUT o;
	float mass = i[0].pos.z;
	if(mass == 0)
		return;
	float2 p = i[0].pos.xy;
	float2 v = i[0].vel.xy;
	float2 f = i[0].vel.zw;
	float scale = pow(mass, 0.33)*DROPLET_SCALE;

	float2 fn = any(f) ? normalize(f) : float2(0, 1);
	float2x2 m = float2x2(fn.y, fn.x, -fn.x, fn.y);
//	float2x2 m = float2x2(-fn.y, fn.x, -fn.x, -fn.y);

	[unroll]
	for (int k = 0; k < 6; ++k) {
		float2 dp = mul(strip[k], m);
		float2 dv = k > 3 ? float2(-f.x, f.y * (1 + windForce*0.1))*0.01 : float2(0, 0);
		o.pos = float4(p + dv + dp * scale, 0, 1);
		o.uv = dp;
		o.mass = mass;
		o.force = f;
		o.uv2 = float2(o.pos.x * 0.5 + 0.5, -o.pos.y * 0.5 + 0.5);
		os.Append(o);
	}
	os.RestartStrip();
}

float3x3 rotMatrix(float3 from, float3 to) {
	float3 c = cross(from, to);
	float e = dot(from, to);
	float h = 1.0 / (1.0 + e);      

	return float3x3(
		e + h * c[0] * c[0],
		h * c[0] * c[1] - c[2],
		h * c[0] * c[2] + c[1],

		h * c[0] * c[1] + c[2],
		e + h * c[1] * c[1],
		h * c[1] * c[2] - c[0],

		h * c[0] * c[2] - c[1],
		h * c[1] * c[2] + c[0],
		e + h * c[2] * c[2]
		);
}

float4 DROPS_PS(const DROPS_PS_INPUT i, uniform bool useWipers) : SV_TARGET0 {
	float d2 = 1 - dot(i.uv, i.uv);
	if (d2 < 0)
		discard;

	float2 f2 = i.force.xy / i.mass; 
	float3 f = normalize(float3(f2, sqrt(1 - min(1,dot(f2, f2)) )));
	float3x3 rm = rotMatrix(float3(0, 0, 1), normalize(float3(0, 0, 1) + f));

	float3 n = mul(float3(i.uv, sqrt(d2)), rm);

	float tf = saturate(dot(-f, n));

	n = normalize( lerp(n, float3(0, 0, 1), saturate(sqrt(tf) + windForce*0.02)) );

	if (useWipers)
		n = lerp(n, float3(0, 0, 1), wipersValue(i.uv2));

	return float4(n*0.5 + 0.5, 1);
}

/////////////////////////////////////////////////////////////////////////////////

float4 BLUR_PS(const VS_OUTPUT i, uniform bool useWipers) : SV_TARGET0 {

//	return float4(0.5, 0.5, 1, 1);

	float2 uv = float2(i.projPos.x*0.5 + 0.5, -i.projPos.y*0.5 + 0.5);

	float4 q = getTangentSpace(uv);
	float3 normal = normalFromTangentSpace(q);
	float3 Vs = wind - normal*dot(wind, normal);	// world space along surface
	float2 wind_uv = mulQuatVec3(q, Vs).xy;			// texture space

	float amount = saturate(windForce * 0.01);
	float3 c = lerp(src.SampleLevel(ClampLinearSampler, uv, 0).xyz, src.SampleLevel(ClampLinearSampler, uv-wind_uv/TEX_SIZE*0.15, 0).xyz, amount);

	if (useWipers) 
		c = lerp(c, float3(0.5, 0.5, 1), wipersValue(uv)*0.5);

	c = lerp(c, float3(0.5, 0.5, 1), 0.0025*(1 + windForce) );	// vaporization

	return float4(c, 1);
}

/////////////////////////////////////////////////////////////////////////////////

#define COMMON_COMPUTE	SetVertexShader(NULL);		\
						SetGeometryShader(NULL);	\
						SetPixelShader(NULL);

#define COMMON_DROPS	SetDepthStencilState(disableDepthBuffer, 0);									\
						SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
						SetRasterizerState(cullNone);

#define COMMON_PART		SetVertexShader(CompileShader(vs_4_0, VS()));	\
						SetGeometryShader(NULL);						\
						COMMON_DROPS

technique10 Sim {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, INIT_CS()));
		COMMON_COMPUTE
	}
	pass P1 {
		SetComputeShader(CompileShader(cs_5_0, ADD_CS()));
		COMMON_COMPUTE
	}
	pass P2 {
		SetComputeShader(CompileShader(cs_5_0, SIM_CS(false)));
		COMMON_COMPUTE
	}
	pass P3 {
		SetComputeShader(CompileShader(cs_5_0, SIM_CS(true)));
		COMMON_COMPUTE
	}
	pass P4 {
		SetComputeShader(CompileShader(cs_5_0, COLLISION_CS()));
		COMMON_COMPUTE
	}
	pass P5 {
		SetComputeShader(CompileShader(cs_5_0, SPLIT_CS()));
		COMMON_COMPUTE
	}
}

technique10 Drops {
	pass P0 {		// clear droplet tracks
		SetVertexShader(CompileShader(vs_5_0, DROPS_CLEAR_VS()));
		SetGeometryShader(CompileShader(gs_5_0, DROPS_CLEAR_GS()));
		SetPixelShader(CompileShader(ps_5_0, DROPS_CLEAR_PS(false)));
		COMMON_DROPS
	}
	pass P1 {		// clear droplet tracks
		SetVertexShader(CompileShader(vs_5_0, DROPS_CLEAR_VS()));
		SetGeometryShader(CompileShader(gs_5_0, DROPS_CLEAR_GS()));
		SetPixelShader(CompileShader(ps_5_0, DROPS_CLEAR_PS(true)));
		COMMON_DROPS
	}
	pass P2 {		// add micro droplets
		SetVertexShader(CompileShader(vs_5_0, DROPS_ADD_VS()));
		SetGeometryShader(CompileShader(gs_5_0, DROPS_ADD_GS()));
		SetPixelShader(CompileShader(ps_5_0, DROPS_ADD_PS(false)));
		COMMON_DROPS
	}
	pass P3 {		// add micro droplets
		SetVertexShader(CompileShader(vs_5_0, DROPS_ADD_VS()));
		SetGeometryShader(CompileShader(gs_5_0, DROPS_ADD_GS()));
		SetPixelShader(CompileShader(ps_5_0, DROPS_ADD_PS(true)));
		COMMON_DROPS
	}
	pass P4 {		// add big droplets
		SetVertexShader(CompileShader(vs_5_0, DROPS_VS()));
		SetGeometryShader(CompileShader(gs_5_0, DROPS_GS()));
		SetPixelShader(CompileShader(ps_5_0, DROPS_PS(false)));
		COMMON_DROPS
	}
	pass P5 {		// add big droplets
		SetVertexShader(CompileShader(vs_5_0, DROPS_VS()));
		SetGeometryShader(CompileShader(gs_5_0, DROPS_GS()));
		SetPixelShader(CompileShader(ps_5_0, DROPS_PS(true)));
		COMMON_DROPS
	}
}

technique10 Blur {
	pass P0 {		
		SetPixelShader(CompileShader(ps_5_0, BLUR_PS(false)));
		COMMON_PART
	}
	pass P1 {
		SetPixelShader(CompileShader(ps_5_0, BLUR_PS(true)));
		COMMON_PART
	}
}

technique10 Copy {
	pass P0 {
		SetPixelShader(CompileShader(ps_4_0, COPY_PS()));
		COMMON_PART
	}
}


