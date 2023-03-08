#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/context.hlsl"
#include "common/random.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"
#define ATMOSPHERE_COLOR


RWTexture2D<float3> destNormals;
RWTexture2D<float> destAlphas;
    
float3 getSource(float i, in float nTime) {
    float offset = 2.3;
    if(i == 0.0){        return float3(0.0, 0.8+offset, 40.0);
    }
    else{
        float period = 0.58;
        float modTime = nTime*period;
        
        if(i == 1.0){
    		return float3(0.0, 0.8+offset, 40.0) + float3(0.0, -(-exp(0.8*6.0)/exp(6.0)+exp((modTime+0.8)*6.0)/exp(6.0)), 0.0);
        }
        else{
            if(i == 2.0){
                if(modTime < 0.01){
       				return float3(-10000.0, -1000.0, -1000.0);
                }
                else{
    				return float3(0.0, 0.8+offset+11.0, 40.0) - float3(0.0, sin((modTime-0.15)/(period-0.15)*3.14/2.0)*11.0, 0.0);
                }
            }
        }
    }
    return 0;
    
}


float getFieldIntensity(in float3 m, out float3 normal, in float nTime) {
    
    normal = float3(0,0,0);
    float 	fieldIntensity = 0.0;
    
    for(float i=0.0; i<3; i+=1.0) {
        
        float3 source = getSource(i, nTime);
        float d = length(m - source);
        
        float intensity = 1.0 / (d*d);
        float3 localNormal = normalize(m - source);
        
        normal += localNormal * intensity;
        fieldIntensity += intensity;
    }
    
    normal = normalize(normal);
    return fieldIntensity;
}

bool rayMarching(in float3 origin, in float3 ray, out float3 m, out float3 normal, in float nTime) {
    
    float	marchingDist = 38.0;
    float 	nbIter 		 = 0.0;

 	m = origin;   
    
    for(int i=0; i<200; i++) {
        
    	float fieldIntensity = getFieldIntensity(m, normal, nTime);
        
        if(fieldIntensity > 0.8) {
            return true;
        }
        else {
            marchingDist += 0.075;
        	m = origin + ray * marchingDist;    
        }
    }
    
	return false;    
}

#define WIDTH 64
#define HEIGHT 128
#define NUM_FRAMES 64

[numthreads(32, 32, 1)]
void CS_Baking(uint3 gid: SV_GroupId, uint3 gtid: SV_GroupThreadID) 
{	
    uint2 idx = uint2(gid.x*32+gtid.x, gid.y*32+gtid.y);
    
    uint time = idx.x/WIDTH+(uint)8*idx.y/HEIGHT;
    float nTime = time/64.0*0.75;
    float2 ncd = float2(float(idx.x%WIDTH)/(WIDTH-1.0), float(idx.y%HEIGHT)/(HEIGHT-1.0));
    ncd.y = 1.0 - ncd.y;
    float3	eye	= float3(ncd.x*3.5-1.75, ncd.y*6.2-3.1, -0.8);
    float3	ray	= float3(0.0, 0.0, 1.0);
    float3	light = float3(-15.0, 5.0, 5.0);
    
    float3	m;
    float3 	normal;
    
    float4 fragColor;
    if(rayMarching(eye, ray, m, normal, nTime)) {
        fragColor = float4(normal, 1.0);
    }
    else {
        fragColor = float4(0.0, 0.0, 0.0, 0.0);
    }

    fragColor.z *= -1;
    destNormals[idx] = fragColor.xyz;
    destAlphas[idx] = fragColor.a;
}

technique10 TechBakingAnimation
{
	pass main
	{
		SetComputeShader(CompileShader(cs_5_0, CS_Baking()));
        SetVertexShader(NULL);
        SetGeometryShader(NULL);
        SetPixelShader(NULL);
	}
}

