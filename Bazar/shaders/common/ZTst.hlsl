#ifndef _Z_TST_HLSL_H_
#define _Z_TST_HLSL_H_

float nearPlane;
float farPlane;
Texture2D ScreenDepthMap;

float ZSmoothTest(float4 ppsPos, float nearPlane, float farPlane, float dist)
{
	float2 uv=ppsPos.xy/ppsPos.w*0.5+0.5;//0..1
	uv.y=1.0-uv.y;//flip y

	float2 DIM;
	ScreenDepthMap.GetDimensions(DIM.x,DIM.y);
	
	float fZt=ScreenDepthMap.Load(int3(DIM.x*uv.x,DIM.y*uv.y,0));
	float fZr=ppsPos.z/ppsPos.w;

	float fDt=nearPlane*farPlane/(farPlane-fZt*(farPlane-nearPlane));
	float fDr=nearPlane*farPlane/(farPlane-fZr*(farPlane-nearPlane));

	float fDz=fDt-fDr;
	if(fDz<0.0)
		discard;

	fDz=saturate(fDz/dist);

	return fDz;
}

#endif	//_Z_TST_HLSL_H_