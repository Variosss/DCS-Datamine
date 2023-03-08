#ifndef OP_SPLINES_HLSL
#define OP_SPLINES_HLSL

void calcCathmullRom4(in float4 knot0, float4 tangent0, float4 knot1, float4 tangent1, out float4 v[4]) 
{
	v[0] = knot0*2;
	v[1] = knot1 - tangent0;
	v[2] = tangent0*2 - knot0*5 + knot1*4 - tangent1;
	v[3] = knot0*3 - tangent0 - knot1*3 + tangent1;
	//для первой производной
	//a = 1.5f*(knot0 - knot1) + 0.5f*(tangent1 - tangent0);
	//b = -(2.5f*knot0 - 2.f*knot1) - (0.5f*tangent1 + tangent0);
	//c = (knot1 - tangent0)*0.5f;
	//d = knot0;
}

float4 CathmullRomCurve4(in float4 v[4], float t) 
{
	//для первой производной
	//return ((v[0]*t + v[1])*t + v[2])*t + v[3];   
	const float t2 = t*t;
	return (v[0] + v[1]*t + v[2]*t2 + v[3]*t2*t) * 0.5;
}

//интерполяция сплайна Безье. t - параметр [0;1],	p1,p2,p3,p4 - контрольные точки
float3 BezierCurve3(in float t, in float3 p1, in float3 p2, in float3 p3, in float3 p4)
{
	const float t2 = t*t;
	const float tInv = 1-t;
	const float tInv2 = tInv*tInv;
	return tInv2*tInv*p1 + 3*tInv2*t*p2 + 3*tInv*t2*p3 + t2*t*p4;
}

//интерполяция сплайна Безье. t - параметр [0;1],	p1,p2,p3,p4 - контрольные точки
float4 BezierCurve4(in float t, in float4 p1, in float4 p2, in float4 p3, in float4 p4)
{
	const float t2 = t*t;
	const float tInv = 1-t;
	const float tInv2 = tInv*tInv;
	return tInv2*tInv*p1 + 3*tInv2*t*p2 + 3*tInv*t2*p3 + t2*t*p4;
}

float LinearInterp(in float t, in float p0, in float p1, in float p2, in float p3)
{
	if(t<0.3333)
		return lerp(p0, p1, t*3);
	else if(t<0.6666)
		return lerp(p1, p2, max(0,(t-0.3333))*3);
	else
		return lerp(p2, p3, max(0,(t-0.6666))*3);
}

float4 LinearInterp4(in float t, in float4 p0, in float4 p1, in float4 p2, in float4 p3)
{
	if(t<0.3333)
		return lerp(p0, p1, t*3);
	else if(t<0.6666)
		return lerp(p1, p2, max(0,(t-0.3333))*3);
	else
		return lerp(p2, p3, max(0,(t-0.6666))*3);
}

/*//

// XYZW--------------------------------------
void calcBSK4(in VS_INPUT i[4], out float4 v[4]) 
{	
	#define _POS .params1
	v[3] = (-i[0]_POS + (i[1]_POS-i[2]_POS)*3.0 + i[3]_POS) / 6.0;
	v[2] = (i[0]_POS - i[1]_POS*2.0 + i[2]_POS) / 2.0;
	v[1] = (i[2]_POS - i[0]_POS) / 2.0;
	v[0] = (i[0]_POS + i[1]_POS*4.0+i[2]_POS) / 6.0;
	#undef _POS
}

float4 pointBS4(in float4 v[4], float t) 
{
	return ((v[3]*t+v[2])*t+v[1])*t+v[0];   
}

// XYZ--------------------------------------
void calcBSK3(in VS_OUTPUT2 i[4], out float3 v[4]) 
{	
	
	#define _POS .params1.xyz
	v[3] = (-i[0]_POS + (i[1]_POS-i[2]_POS)*3.0 + i[3]_POS) / 6.0;
	v[2] = (i[0]_POS - i[1]_POS*2.0 + i[2]_POS) / 2.0;
	v[1] = (i[2]_POS - i[0]_POS) / 2.0;
	v[0] = (i[0]_POS + i[1]_POS*4.0+i[2]_POS) / 6.0;
	#undef _POS
}

float3 pointBS3(in float3 v[4], float t) 
{
	return ((v[3]*t+v[2])*t+v[1])*t+v[0];   
}
//------------------------------------------

// XYZ - Cathmull-Rom spline ---------------
void calcCathmullRom3(in VS_OUTPUT2 i[4], out float3 v[4]) 
{
	#define _POS .params1.xyz
	v[0] = i[1]_POS*2;
	v[1] = i[2]_POS - i[0]_POS;
	v[2] = i[0]_POS*2 - i[1]_POS * 5 + i[2]_POS*4 - i[3]_POS;
	v[3] = (i[1]_POS*3 - i[0]_POS - i[2]_POS*3 + i[3]_POS);
	//для первой производной
	//v[0] = 1.5*(i[1]_POS - i[2]_POS) + 0.5*(i[3]_POS - i[0]_POS);
	//v[1] = -(2.5*i[1]_POS + 2*i[2]_POS) - (0.5*i[3]_POS + i[0]_POS);
	//v[2] = (i[2]_POS - i[0]_POS) / 2.0;
	//v[3] = i[1]_POS;
	#undef _POS
}

float3 pointCathmullRom3(in float3 v[4], float t) 
{
	//для первой производной
	//return ((v[0]*t + v[1])*t + v[2])*t + v[3];   
	const float t2 = t*t;
	return (v[0] + v[1]*t + v[2]*t2 + v[3]*t2*t) / 2;
}
*/
//------------------------------------------


#endif