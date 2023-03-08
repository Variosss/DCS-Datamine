#ifndef QUAT_HLSL
#define QUAT_HLSL

float4 makeQuat(in float3 axis, in float ang)
{
	float2 sc;
	sincos(ang/2, sc.x,sc.y);
	return float4(axis*sc.x, sc.y);
}

float4 mulQuatQuat(float4 q1, float4 q2) { 
	return float4(q1.w * q2.xyz + q2.w * q1.xyz + cross(q1.xyz, q2.xyz), q1.w * q2.w - dot(q1.xyz, q2.xyz));
}

float3 mulQuatVec3(float4 q, float3 v) {
	float3 t = 2.0 * cross(q.xyz, v);
	return v + q.w * t + cross(q.xyz, t);
}

float4 matrixToQuat(float3x3 m) {
	float4 q;
	q.w = sqrt(max(0, 1 + m._m00 + m._m11 + m._m22));
	q.x = sqrt(max(0, 1 + m._m00 - m._m11 - m._m22)) * sign(m._m21 - m._m12);
	q.y = sqrt(max(0, 1 - m._m00 + m._m11 - m._m22)) * sign(m._m02 - m._m20);
	q.z = sqrt(max(0, 1 - m._m00 - m._m11 + m._m22)) * sign(m._m10 - m._m01);
	return q*0.5;
}

float3x3 quatToMatrix(float4 q) {
	return float3x3(1 - 2 * (q.y*q.y - q.z*q.z), 2 * (q.x*q.y - q.z*q.w), 2 * (q.x*q.z + q.y*q.w),
					2 * (q.x*q.y + q.z*q.w), 1 - 2 * (q.x*q.x - q.z*q.z), 2 * (q.y*q.z - q.x*q.w),
					2 * (q.x*q.z - q.y*q.w), 2 * (q.y*q.z + q.x*q.w), 1 - 2 * (q.x*q.x - q.y*q.y));
}

#endif
