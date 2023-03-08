#ifndef _OP_QUAT_HLSL_
#define _OP_QUAT_HLSL_

//строит кватернион по оси и углу поворота
float4 makeQuat(in float3 axis, in float ang)
{
	float2 sc;
	sincos(ang/2, sc.x,sc.y);
	return float4(axis*sc.x, sc.y);
}

//поворачивает вектор v на кватернион q
float3 qTransform( in float4 q, in float3 v )
{ 
	return v + 2.0*cross(cross(v, q.xyz ) + q.w*v, q.xyz);
}

#endif