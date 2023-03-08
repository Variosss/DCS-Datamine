
//вихревое кольцо в плоскости XZ с центром в vortexPos, с радиусом vortexRadius
float3 getCircleVortexForce(in float vortexRadius, in float3 vortexPos, in float3 particlePos)
{
	float2 vortexDirProj = normalize(particlePos.xz)*vortexRadius;
	float3 vortexPosLocal = float3(vortexDirProj.x, vortexPos.y, vortexDirProj.y);
	float3 dir = particlePos - vortexPosLocal;
	float dist = length(dir);
	float3 side = float3(-vortexDirProj.y, 0, vortexDirProj.x);
	return normalize(cross(dir, side)) * max(0, 1 - dist / vortexRadius * 0.4);
}

//вихрь вокруг оси Y с центром в vortexPos
float3 getSwirlForce(in float vortexRadius, in float3 vortexPos, in float3 particlePos)
{
	float2 dirProj = particlePos.xz - vortexPos.xz;
	float3 dir = normalize(float3(-dirProj.y, 0, dirProj.x));
	float force = max(0, 1 - length(dirProj) / vortexRadius);
	return dir * force;
}

float3x3 makeRotY(in float2 sc)
{
	return float3x3(sc.y,	0,	sc.x,
			0,		1,	0,
			-sc.x,	0,	sc.y);
}

//поворот mLocal для позиции pos в вихревом кольце на угол angle
float3x3 getCircleVortexRotation(in float3x3 mLocal, in float3 pos, in float angle)
{
	float3 x = normalize(float3(pos.x, 0, pos.z));
	float3x3 mRot = {x, float3(-x.z, 0, x.x), float3(0,1,0)};
	sincos(angle, x.x, x.y);
	float3x3 M = makeRotY(x.xy);
	return mul(mul(mLocal, M), mRot);
}

float3x3 axisAngleToMatrix(float3 axis, float ang)
{
	float s, c;
	sincos(ang, s, c);	
#if 1
	float3 axisS = axis*s;
	float3 axisT = axis*(1-c);
	return float3x3(
		axis.x*axisT.x+c,			axis.x*axisT.y-axisS.z,		axis.x*axisT.z+axisS.z,
		axis.y*axisT.x+axisS.z,		axis.y*axisT.y+c,			axis.y*axisT.z-axisS.x,
		axis.z*axisT.x-axisS.y,		axis.z*axisT.y+axisS.x,		axis.y*axisT.z+c
	);
#else
	float t = 1.0 - c;
	return float3x3(
		axis.x*axis.x*t+c,			axis.x*axis.y*t-axis.z*s,	axis.x*axis.z*t+axis.z*s,
		axis.y*axis.x*t+axis.z*s,	axis.y*axis.y*t+c,			axis.y*axis.z*t-axis.x*s,
		axis.z*axis.x*t-axis.y*s,	axis.z*axis.y*t+axis.x*s,	axis.y*axis.z*t+c
	);
#endif
}
