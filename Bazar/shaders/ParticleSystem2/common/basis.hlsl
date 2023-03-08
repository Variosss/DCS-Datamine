#ifndef _OP_BASIS_HLSL_
#define _OP_BASIS_HLSL_

/*возвращает нормаль к вершине билборда в МСК, заданного от -0.5 до 0.5 в плоскости XY камеры*/
void billboardNormal(in float2 pos, out float3 normal)
{
	//const float coef = 2; // 0 - полусфера, N - плоскость
	const float coef = -0.5; // 0 - полусфера, N - плоскость
	normal.xy = pos;
	normal.z = coef;
	normal = normalize(normal);
	//normal = mul(normal, gViewInv);
}

/*цилиндрическая форма для направленного партикла по вектору*/
void cylindricNormal(in float2 pos, out float3 normal)
{
	const float coef = -0.2; // 0 - полусфера, N - плоскость
	normal.x = pos.x;
	normal.y = 0;
	normal.z = coef;
	normal = normalize(normal);
}


/*билборд в позиции pos, с масштабом scale и углом поворота roll*/
float4x4 billboard(float3 pos, float scale, float roll) 
{
	float _sin, _cos;  
	sincos(roll, _sin, _cos);
	_sin *= scale;
	_cos *= scale;

	float4x4 M = {
	_cos, _sin, 0, 0, 
	-_sin,  _cos, 0, 0, 
	  0,	 0, 1, 0, 
	  0,	 0, 0, 1};

	M = mul(M,gViewInv);	
	M[3][0] = pos.x;
	M[3][1] = pos.y;
	M[3][2] = pos.z;
	return M;
}

/*билборд в позиции pos, с масштабом scale и углом поворота roll*/
float4x4 billboardView(float3 posV, float scale, float roll) 
{
	float _sin, _cos;  
	sincos(roll, _sin, _cos);
	_sin *= scale;
	_cos *= scale;

	float4x4 M = {
	_cos, _sin, 0, 0, 
	-_sin,  _cos, 0, 0, 
	  0,	 0, 1, 0, 
	  posV.x,	 posV.y, posV.z, 1};

	return M;
}

/*билборд в позиции pos, с масштабом scale и углом поворота roll*/
float4x4 billboard(float3 pos, float2 scale, float roll) 
{
	float _sin, _cos;  
	sincos(roll, _sin, _cos);

	float4x4 M = {
	_cos*scale.x, _sin*scale.x, 0, 0, 
	-_sin*scale.y,  _cos*scale.y, 0, 0, 
	  0,	 0, 1, 0, 
	  0,	 0, 0, 1};

	M = mul(M,gViewInv);	
	M[3][0] = pos.x;
	M[3][1] = pos.y;
	M[3][2] = pos.z;
	return M;
}

/*билборд в позиции pos, с масштабом scale и углом поворота roll*/
float4x4 billboard(float3 pos, float scale, float roll, inout float3 normal) 
{
	float _sin, _cos;  
	sincos(roll, _sin, _cos);
	_sin *= scale;
	_cos *= scale;

	float4x4 M = {
	_cos, _sin, 0, 0, 
	-_sin,  _cos, 0, 0, 
	  0,	 0, 1, 0, 
	  0,	 0, 0, 1};

	normal = mul(float4(normal,1), M).xyz;

	M = mul(M, gViewInv);	
	M[3][0] = pos.x;
	M[3][1] = pos.y;
	M[3][2] = pos.z;
	return M;
}

/*билборд в позиции pos, с масштабом scale */
float4x4 billboard(float3 pos, float scale) 
{
	float4x4 M = {
	scale, 0, 0, 0, 
	0, scale, 0, 0, 
	0,	 0, 1, 0, 
	0,	 0, 0, 1};

	M = mul(M, gViewInv);	
	M[3][0] = pos.x;
	M[3][1] = pos.y;
	M[3][2] = pos.z;
	return M;
}

/*билборд в позиции pos, построенный по вектору в СК камеры*/
float4x4 billboard2(float3 pos, float3 X) 
{
	float4x4 M = {
	-X.y, X.x, 0, 0, 
	-X.x,  -X.y, 0, 0, 
	  0,	 0, 1, 0, 
	  0,	 0, 0, 1};

	M = mul(M, gViewInv);	
	M[3][0] = pos.x;
	M[3][1] = pos.y;
	M[3][2] = pos.z;
	return M;
}

/*билборд в позиции pos, направленный по вектору скорости с заданным масштабом*/
float4x4 billboardOverSpeed(float3 pos, float3 speed, float scale) 
{
	float3 speedProjX = mul(speed, (float3x3)gView).xyz;
	speedProjX.z = 0;
	speedProjX = normalize(speedProjX);
	speedProjX.xy *= scale;

	float4x4 M = {
	-speedProjX.y, speedProjX.x, 0, 0, 
	-speedProjX.x,  -speedProjX.y, 0, 0, 
	  0,	 0, 1, 0, 
	  0,	 0, 0, 1};

	M = mul(M, gViewInv);	
	M[3][0] = pos.x;
	M[3][1] = pos.y;
	M[3][2] = pos.z;
	return M;
}


/*билборд в позиции pos, направленный по вектору скорости с заданным масштабом*/
float4x4 billboardOverSpeedNorm(float3 pos, float3 speed, float scale, inout float3 normal) 
{
	float3 speedProjX = mul(float4(speed,0), gView).xyz;
	speedProjX.z = 0;
	speedProjX = normalize(speedProjX);
	speedProjX.xy *= scale;

	float4x4 M = {
	-speedProjX.y, speedProjX.x, 0, 0, 
	-speedProjX.x,  -speedProjX.y, 0, 0, 
	  0,	 0, 1, 0, 
	  0,	 0, 0, 1};

	normal = mul(float4(normal,1), M).xyz;

	M = mul(M, gViewInv);
	M[3][0] = pos.x;
	M[3][1] = pos.y;
	M[3][2] = pos.z;
	return M;
}

/*построение базиса 3х3*/
float3x3 basis(float3 Z)
{
	float3 X,Y;
	if(abs(Z.y) < 0.99f) 
	{
	  X = normalize(cross(float3(0,1,0), Z));
	  Y = cross(X, Z);
	} 
	else 
	{
	  Y = normalize(cross(Z, float3(1,0,0)));
	  X = cross(Y, Z);
	}
	return float3x3(X,Z,Y);
}

/*базиса 4х4, сначала поворот, потом сдвиг*/
float4x4 basis(float3 Z, float3 pos)
{
	float3 X,Y;
	if(abs(Z.y) < 0.99f) 
	{
	  X = normalize(cross(float3(0,1,0), Z));
	  Y = cross(X, Z);
	} 
	else 
	{
	  Y = normalize(cross(Z, float3(1,0,0)));
	  X = cross(Y, Z);
	}
	return float4x4(
		X.x, X.y, X.z, 0, 
		Z.x, Z.y, Z.z, 0, 
		Y.x, Y.y, Y.z, 0, 
		pos.x, pos.y, pos.z, 1);
}

/*построение базиса 3х3 для эффектов корабликов*/
float3x3 basisShip(float3 X)
{
	float3 Y,Z;
	X = normalize(X);
	Z = float3(X.z, 0, -X.x);

	float3x3 M = {
		X.x, X.y, X.z,
		0,1,0, 
		Z.x, Z.y, Z.z
	};
	return M;
}

//поворт номали на sinCos и ориентация ее вдоль вектора speedProj
float3 alignNormalToDirection(in float3 normal, in float2 sinCos, in float3 speedProj)
{
	//крутим нормаль против поворота текстуры
	float2x2 M = {sinCos.y, sinCos.x, -sinCos.x, sinCos.y};
	normal.xy = mul(normal.xy, M);
	float3 norm = normal.z * gViewInv._31_32_33;
	norm += normal.y * speedProj;
	norm += -normal.x * cross(speedProj, gViewInv._31_32_33);
	return norm;
}

/*матрица поворота 2х2*/
float2x2 rotMatrix2x2(float angle)
{
	float2 sc;
	sincos(angle, sc.x, sc.y);
	return float2x2(sc.y, sc.x, -sc.x, sc.y);
}

float3x3 rotMatrixY(float angle)
{
	float2 sc; sincos(angle, sc.x, sc.y);
	return float3x3(
		sc.y,	0,	sc.x,
		0,		1,	0,
		-sc.x,	0,	sc.y
	);
}

float3x3 rotMatrixZ(float angle)
{
	float2 sc; sincos(angle, sc.x, sc.y);
	return float3x3(
		sc.y,	sc.x,	0,
		-sc.x,	sc.y,	0,
		0,		0,		1
	);
}

float3x3 rotMatrixX(float angle)
{
	float2 sc; sincos(angle, sc.x, sc.y);
	return float3x3(
		1.0,	0,	0,
		0,	sc.y,	-sc.x,
		0,		sc.x,	sc.y
	);
}

float4x4 enlargeMatrixTo4x4(float3x3 M, float3 pos)
{
	return float4x4(
		float4(M._11_12_13, 0),
		float4(M._21_22_23, 0),
		float4(M._31_32_33, 0),
		float4(pos, 1)
	);
}


// phi - angle(Z-vector, XY-plane)
// theta - angle(X-vector, ZY-plane)
float3 convertSphericalToRect(float theta, float phi, float radius){
	float2 scTheta, scPhi;
	sincos(theta, scTheta.x, scTheta.y);
	sincos(phi, scPhi.x, scPhi.y);
	
	float3 dir = float3(scTheta.x*scPhi.y, scTheta.x*scPhi.x, scTheta.y);
	return dir*radius;
}

/*mRot - матрица поворота партикла в плоскости экрана*/
float3 getSunDirInNormalMapSpace(float2x2 mRot)
{
	float3 sunDirM = float3(-gSunDirV.x, gSunDirV.yz);
	sunDirM.xy = mul(sunDirM.xy, mRot);
	return sunDirM;
}

/*mRot - матрица поворота партикла в мировой СК*/
float3 getSunDirInObjectSpace(float3x3 mRot)
{
	float3 sunDirM = mul(mRot, gSunDir.xyz);
	return float3(-sunDirM.x, sunDirM.z, sunDirM.y);
}


/* faster than mul(float4(v0, 1.0), v1)*/
float mul_v3xv4(float3 v0, float4 v1){
	return v0.z*v1.z+(v0.y*v1.y +(v0.x*v1.x+v1.w));
}

/* faster than mul(float4(v0, 1.0), m)*/
float4 mul_v3xm44(float3 v0, float4x4 m){
	float4 v;
	v.x = mul_v3xv4(v0, m._11_21_31_41);
    v.y = mul_v3xv4(v0, m._12_22_32_42);
    v.z = mul_v3xv4(v0, m._13_23_33_43);
    v.w = mul_v3xv4(v0, m._14_24_34_44);
	return v;
}

/* faster than mul(float4(v0, 1.0), (float3x4)m)*/
float3 mul_v3xm34(float3 v0, float4x4 m){
	float3 v;
	v.x = mul_v3xv4(v0, m._11_21_31_41);
    v.y = mul_v3xv4(v0, m._12_22_32_42);
    v.z = mul_v3xv4(v0, m._13_23_33_43);
	return v;
}

/*1.0/sqrt(dot(v, v))*/
float4 normfactor(float3 v){
	return rsqrt(dot(v, v));
}

/* if len(v) > l => v = normalize(v)*l */
float3 clampTo(float3 v, float l){
	precise float normFactor = saturate(l*rsqrt(dot(v, v)));
	return v*normFactor;
}

#endif