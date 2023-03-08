#ifndef CUSTOM_DEPTH_FXH
#define CUSTOM_DEPTH_FXH

float CustomDepth(float4 NDCPOS, float near, float far)
{
	float newZ=NDCPOS.z/far;
	return newZ;
}

#endif	//CUSTOM_DEPTH_FXH
