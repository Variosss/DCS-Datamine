#include "common/States11.hlsl"
#include "common/context.hlsl"
#include "common/random.hlsl"
#include "common\samplers11.hlsl"
#include "../common/quat.hlsl"
#define _width 1280
#define _height 960  

float4x4 World;
float4x4 WorldInv;
#define NUM_STEPS 1024 // num steps for ray marching
float4 params0;
float4 params1;
float4 params2;

uint bEnableIntensityMask;

#define densityFactor params2.x
#define time params2.x
#define topRadius params0.x
#define lightIntensity params0.y


#define baseRadius params1.x
#define gHAngleAttenuation params1.y
#define height params1.z
//#define gHAngleIntensive params1.w


// for backed:
#define lightColor params0.yzw
#define lightIntensityFactor params1.w
#define illumination params1.x
RWTexture3D<float>	dst;
Texture2D<float> src;
Texture2D<float> intensityMask;
Texture3D<float> bakedLighting;
static const float PI = 3.14159265;

struct VS_OUTPUT
{
    float4 cOut : SV_POSITION0;
    float3 posP : POSITION;
};

static const float2 quad[4] =
{
	float2(-1, -1), float2(1, -1),
	float2(-1, 1),	float2(1, 1),
};

struct VS_OUTPUT_DEBUG{
    float3 PosP: POSITION0;
};

struct GS_OUTPUT_DEBUG{
    float4 PosP: SV_POSITION0;
};


VS_OUTPUT_DEBUG VS_Debug(uint vid: SV_VertexID)
{
    VS_OUTPUT_DEBUG Out;
    Out.PosP = float3(1.0, 1.0, 1.0);
    //Out.PosP = src.SampleLevel(gPointWrapSampler, float2(vid/1024.0, phi/32.0), 0).xzy;
    return Out;
}

[maxvertexcount(4)]
void GS_Debug(point VS_OUTPUT_DEBUG gin[1],
            uint primID: SV_PRIMITIVEID,
            inout LineStream<GS_OUTPUT_DEBUG> lineStream)
{
    GS_OUTPUT_DEBUG gout[2];

    float3 o = -gOrigin;
    float3 dir = gin[0].PosP;
    gout[0].PosP = mul(float4(o, 1.0), gViewProj);
    gout[1].PosP = mul(float4(o+4*dir, 1.0), gViewProj);
    
    lineStream.Append(gout[0]);
    lineStream.Append(gout[1]);
}

float4 PS_Debug(GS_OUTPUT_DEBUG Out) : SV_TARGET0
{
    return float4(1.0, 0.0, 0.0, 1.0);
}


struct VS_INPUT{
    float3 Pos: POSITION0;
};




float getLight(float3 a, float3 b)
{
    float3 diff = b-a;
    float l = sqrt(dot(diff, diff));
    float k = 0.000125;
    float m = 0.01;
    return exp(k)*l*(exp(-b.z*m)-exp(-a.z*m))/(a.z*m-b.z*m);
}



int intersectCylinder(in float3 eyePosP, in float3 eyeDirP, out float3 interNear, out float3 interFar)
{
    float baseRadius2 = baseRadius*baseRadius;
    
    float eyeDirP_z_inv = 1.0/eyeDirP.z;
    
    // cylinder intersection. quadratic equation
    float b_2 = eyeDirP.x*eyePosP.x + eyeDirP.y*eyePosP.y;
    float a = eyeDirP.x*eyeDirP.x + eyeDirP.y*eyeDirP.y;
    float c = eyePosP.x*eyePosP.x + eyePosP.y*eyePosP.y-baseRadius2;
    float d_4 =  b_2*b_2-a*c;
    
    if(d_4 < 0)
    return 0;
          

    d_4 = sqrt(d_4);
    float a_inv = 1.0/a;
    float tf = (-b_2 + d_4)*a_inv;
    float tn = (-b_2 - d_4)*a_inv;

    
    if(tf < 0)
    return 0;

    interNear = eyePosP + tn*eyeDirP;
    interFar = eyePosP + tf*eyeDirP;


    
    if(tf-tn < 0)
    return 0;


    if(tn < 0) // eye inside the cylinder
    {
        interNear = eyePosP;
    }

    if(interNear.z < 0 || interNear.z > height) // checks intersections with  top and down caps
    {
        float td = (interNear.z < 0)  ? -eyePosP.z : (height -eyePosP.z);
        td *= eyeDirP_z_inv;
            
        interNear = eyePosP + td*eyeDirP;

        
        if(baseRadius2 - interNear.x*interNear.x-interNear.y*interNear.y < 0)
            return 0;
    }

    if(interFar.z < 0 || interFar.z > height) // checks intersections with top and down caps
    {
        float td = (interFar.z < 0)  ? -eyePosP.z : (height -eyePosP.z);
        td *= eyeDirP_z_inv;

        interFar = eyePosP + td*eyeDirP;

        if(baseRadius2 - interFar.x*interFar.x-interFar.y*interFar.y < 0)
            return 0;
    }

    return 1;
}

int intersectCone(in float3 eyePosP, in float3 eyeDirP, in float offset, out float3 interNear, out float3 interFar)
{
    float baseRadius2 = baseRadius*baseRadius;
    float topRadius2 = pow(tan(gHAngleAttenuation)*(height+offset), 2);

    float3 coneDirP = float3(0.0, 0.0, 1.0);
    
    float cosAngle2 = pow(cos(gHAngleAttenuation), 2);
    float dot_CD_EYED = dot(coneDirP, eyeDirP);
    float dot_CO_CD = dot(coneDirP, eyePosP);

    float a = pow(dot_CD_EYED, 2) - cosAngle2;
    float b_2 = (dot_CD_EYED*dot_CO_CD)-dot(eyeDirP,eyePosP)*cosAngle2;
    float c = pow(dot_CO_CD,2)-dot(eyePosP, eyePosP)*cosAngle2;

    float d_4 =  b_2*b_2-a*c;
    
    if(d_4< 0)
        return 0;
        //discard;       

    d_4 = sqrt(d_4);
    float a_inv = 1.0/a;
    float tf = (-b_2 + d_4)*a_inv;
    float tn = (-b_2 - d_4)*a_inv;


    if(tf < tn){
        float c = tf;
        tf = tn;
        tn = c;
    }


    if(tf < 0.0)
            return 0;

        //discard;
    
    if(tn*eyeDirP.z + eyePosP.z < offset && tf*eyeDirP.z + eyePosP.z < offset){
        //discard;       
                return 0;

    }

    if(tn*eyeDirP.z + eyePosP.z < offset){
        interNear = eyePosP + tf*eyeDirP;
        interFar.z = 100000;
    }
    else{
        if(tf*eyeDirP.z+eyePosP.z < offset)
        {
            if(tn < 0.0){
                return 0;
            }
            
            //interNear = eyePosP;
            //interFar = eyePosP + tn*eyeDirP; 
        }
        else{
            if(tn < 0.0){
                interNear = eyePosP;
            }
            else{
                interNear = eyePosP + tn*eyeDirP;
            }
            interFar = eyePosP + tf*eyeDirP;
        }
    }

    float eyeDirP_z_inv = 1.0/eyeDirP.z;

    if(dot(interNear, coneDirP) <= 0)
            return 0;

    ////clip(dot(interNear,coneDirP));

   // ////clip(dot(interNear,coneDirP));

    if(interNear.z < offset) // checks intersections with  top and down caps
    {
       

        float td = (offset-eyePosP.z) *eyeDirP_z_inv;
        interNear = eyePosP + td*eyeDirP;
               
        if(baseRadius2 - interNear.x*interNear.x-interNear.y*interNear.y< 0){
                return 0;
        }
    }
    
    if(interNear.z > height+offset) // checks intersections with  top and down caps
    {
        float td = (height+offset -eyePosP.z)*eyeDirP_z_inv;
            
        interNear = eyePosP + td*eyeDirP;
       
        if(topRadius2 - interNear.x*interNear.x-interNear.y*interNear.y< 0){
                    return 0;
        }
  } 


    if(interFar.z < offset) // checks intersections with  top and down caps
    {
        float td = (offset-eyePosP.z) * eyeDirP_z_inv;
        interFar = eyePosP + td*eyeDirP;

        if(baseRadius2 - interFar.x*interFar.x-interFar.y*interFar.y< 0){
            return 0;

        }
    }

    if(interFar.z > height+offset) // checks intersections with  top and down caps
    {
        float td = (height+offset - eyePosP.z)*eyeDirP_z_inv;
            
        interFar = eyePosP + td*eyeDirP;

        if(topRadius2 - interFar.x*interFar.x-interFar.y*interFar.y< 0){
                    return 0;

        }
    }
    return 1;
}


float RayMarch(float3 interNearP, float3 interFarP, float3 eyeDirP)
{
    float3 heightBasis= WorldInv._21_22_23;

    // start from the farest intersection to the nearest intersection
    float stepSize = length(interFarP-interNearP)/NUM_STEPS;
    float3 step = stepSize*eyeDirP;
    // fixed possible precision-error
    float3 curSamplePos = interNearP+0.001*eyeDirP;

    float heightStep = 10.0;
    float attenCoef = 0.0;
    //float cosMaxIntensity = cos(gHAngleIntensive);

    float cosAttenuation = cos(gHAngleAttenuation);
    float overalLight = 0.0;
    float transmitance = 1.0;

    for(uint i=0; i < NUM_STEPS; ++i){
        float curLightIntensity;

        float r = length(curSamplePos);
        float3 lightDir = normalize(curSamplePos);
        float cosP = lightDir.z;


        float x = 1.0-(cosP - cosAttenuation)/(1.0-cosAttenuation);
        
        curLightIntensity = (cosP-cosAttenuation)/(1.0-cosAttenuation);
        curLightIntensity = pow(curLightIntensity, 4)/(r*r);

        if(bEnableIntensityMask != 0){
            float m = intensityMask.SampleLevel(gTrilinearClampSampler, float2(x, 0.5), 0).r;
            curLightIntensity *= m;
        }

        curLightIntensity *= lightIntensity;
        //m = 1.0;

        float curAbsoluteHeight = dot(heightBasis, curSamplePos);
        float g = -(1.0-exp(-0.0001*curAbsoluteHeight*7))*0.5 + 0.7;
        float density = (30.0- 30*exp(-0.0001*curAbsoluteHeight) )/curAbsoluteHeight*densityFactor;

        float trInS = exp(-r*density);
        float cosa = dot(lightDir, -eyeDirP);
        float pInS = 0.5*(1-g*g)/pow(1+g*g-2*g*cosa, 1.5);
        
        float inLight =trInS*curLightIntensity; 
        overalLight += pInS*inLight*transmitance*stepSize;
        transmitance *= exp(-stepSize*density*1.0);

        curSamplePos += step;
    }
    return overalLight;
}

VS_OUTPUT VS_RayMarched(uint vid: SV_VertexID)
{
    VS_OUTPUT Out;
    
	Out.cOut.xy = quad[vid];
	Out.cOut.z = 0.0;  // computes near plane
	Out.cOut.w = 1.0;

    return Out;
}

float4 PS_RayMarched(VS_OUTPUT i) : SV_TARGET0
{
     float2 ncdPos = float2((i.cOut.x)/_width*2 - 1.0, -((i.cOut.y)/_height*2 -1.0));

    float hHeight =1.0/gProj._22*gNearClip;
	float hWidth = gProj._22/gProj._11*hHeight;
	float3 eyeDirV = float3(hWidth*ncdPos.x, hHeight*ncdPos.y, gNearClip);
	eyeDirV = normalize(eyeDirV);
	float3 eyeDirW = mul(eyeDirV, (float3x3)(gViewInv));

    // in the primitive coordinate system

    float3 eyeDirP = mul(eyeDirW, (float3x3)(WorldInv));
    float3 eyePosP = mul(float4(gCameraPos+gOrigin, 1.0), WorldInv).xyz; 

    float3 interNearP, interFarP;
    float offset = baseRadius/tan(gHAngleAttenuation);
    int a = intersectCone(eyePosP, eyeDirP, offset, interNearP, interFarP);    
    //return float4(a, 0.0, 0.0, 1.0);
    
    //return float4(a*frac(interFarP.z/5), 0.0, 0.0, 1.0);

    if(a == 0){
        return 0;
    }

    float light = RayMarch(interNearP, interFarP, eyeDirP);
    return float4(1.0, 1.0, 1.0, light);
}

[numthreads(16, 48, 1)]
void CS_Baking(uint3 gid: SV_GroupId, uint3 gtid: SV_GroupThreadID) 
{	
    uint3 idx = uint3(gid.x*16+gtid.x, gid.y*48+gtid.y, gid.z);
    float offset = baseRadius/tan(gHAngleAttenuation);

    float relHeight = idx.z/47.0*height + offset; //log(idx.z/47.0*(exp(height/3000.0)-1.0) + 1.0)*3000 + offset;

    // Hack!! For zero radiance 
    if(idx.z == 0){
        relHeight += 150.0*(1.0-idx.y/47.0); 
    }
    float phi = 0.0;
    float alpha = idx.x/15.0*0.97; // alpha and beta spherical coordinates of intersection direction
    alpha = clamp(alpha, 0.01, 0.99)*0.5*PI;
    float beta = idx.y/47.0*0.97; // alpha - around Z axis. [0; 2pi]; beta - around X axis [-pi/2.0; pi/2.0]
    beta = clamp(beta, 0.01, 0.99)*PI;
    float3 heightBasis= WorldInv._21_22_23;

    float3 eyeDirP = float3(sin(beta)*cos(alpha), sin(alpha)*sin(beta), cos(beta)); // spherical coordinates to rectangular
    float3x3 zAxisRotation =
    {
        cos(phi), -sin(phi),0.0,
        sin(phi), cos(phi), 0.0,
        0.0, 0.0, 1.0
    };

    float3x3 yAxisRotation =
    {
        cos(gHAngleAttenuation), 0.0, -sin(gHAngleAttenuation),
        0.0, 1.0, 0.0,
        sin(gHAngleAttenuation), 0.0, cos(gHAngleAttenuation)
    };
    
    float curRadius = tan(gHAngleAttenuation)*relHeight;
    float3 eyePosP = float3(curRadius*cos(phi), -curRadius*sin(phi), relHeight);
    eyeDirP = -mul(mul(eyeDirP, zAxisRotation), yAxisRotation);
    eyePosP -= eyeDirP*35; // hack

    float3 interNearP, interFarP;
    intersectCone(eyePosP, eyeDirP, offset, interNearP, interFarP);

    dst[idx] = RayMarch(interNearP, interFarP, eyeDirP);
}

VS_OUTPUT VS_Textured( VS_INPUT In)
{ 
    VS_OUTPUT Out;
    
    float radius = (In.Pos.z==0) ? baseRadius : topRadius;
	Out.posP = In.Pos;
    Out.posP.z *= height;
    Out.posP.xy *= radius;

    Out.cOut = mul(float4(Out.posP, 1.0), World);
    Out.cOut = mul(float4(Out.cOut.xyz-gOrigin, 1.0), gViewProj);

    return Out;
}


float4 PS_Textured(VS_OUTPUT i) : SV_TARGET0
{
    

    float3 eyePosP = mul(float4(gCameraPos+gOrigin, 1.0), WorldInv).xyz; 
    float3 eyeDirP = normalize(eyePosP - i.posP);
    //return float4(eyeDirP*0.5 + 0.5, 1.0);
    float offset = baseRadius/tan(gHAngleAttenuation);

    float PI2 = PI*0.5;

    float3 forward = float3(normalize(i.posP.xy), 0);
    float3 bottomOrigin = float3(forward.xy*baseRadius,0.0);
    float3 up = normalize(i.posP-bottomOrigin);
    float beta = acos(dot(up, eyeDirP));

    float3 right0 = cross( up, forward);
    float4 q0 = makeQuat(right0, -gHAngleAttenuation);
    eyeDirP = mulQuatVec3(q0, eyeDirP);

    float3 right1 = normalize(cross(float3(0.0, 0.0, 1.0), eyeDirP));
    float4 q1 = makeQuat(right1, (PI2-beta));

    eyeDirP = mulQuatVec3(q1, eyeDirP);
    float alpha = acos(dot(eyeDirP, forward));

	float hF = (exp((i.posP.z) / 3000) - 1.0) / (exp((height) / 3000.0) - 1.0);
    hF = (i.posP.z-offset)/height;
    float3 coord = float3(alpha/PI2,beta/PI, hF);
    float light = bakedLighting.Sample(gTrilinearClampSampler, coord);
    float g = -(1.0-exp(-0.0001*8000*7))*0.5 + 0.7;
    
    float r = noise1(0.06*(i.posP.x+i.posP.y+i.posP.z)+ 0.00009*time);
    float cosa = dot(float3(0.0, 0.0, 1.0), -eyeDirP);
    float pInS = 0.5*(1-g*g)/pow(1+g*g-2*g*cosa, 1.5);
    if(r < 0.90){
        pInS = 0.0;
    }

    pInS*=0.15*(1+(r-0.90)*40);

    return float4(lightColor, light*(1.0+clamp(pInS, 0.0, 50.0))*lightIntensityFactor);
}

float4 PS_WhiteIllusion(VS_OUTPUT i) : SV_TARGET0
{
    return float4(lightColor, illumination*lightIntensityFactor);
}


BlendState overcastAlphaBlend
{
	BlendEnable[0]	= TRUE;
	SrcBlend		= SRC_ALPHA;
	DestBlend		= INV_SRC_ALPHA;
};

DepthStencilState overcastDepthStencil
{
	DepthEnable        = FALSE;
	DepthWriteMask     = ZERO;
	DepthFunc          = ALWAYS;

	StencilEnable      = FALSE;
	StencilReadMask    = 0;
	StencilWriteMask   = 0;
};

technique10 Textured{
    pass P0
    {
ENABLE_RO_DEPTH_BUFFER;
        SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
        SetRasterizerState(cullBack);
        SetVertexShader(CompileShader(vs_5_0, VS_Textured()));
        SetPixelShader(CompileShader(ps_5_0, PS_Textured()));
		SetGeometryShader(NULL);
    }
}

technique10 Baking
{
	pass P0
	{
        SetComputeShader(CompileShader(cs_5_0, CS_Baking()));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}

technique10 WhiteIllusion
{
	pass P0
	{
        SetVertexShader(CompileShader(vs_4_0, VS_RayMarched()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS_WhiteIllusion()));
        DISABLE_DEPTH_BUFFER;
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	}
}

technique10 RayMarched
{
    pass P0
    {
        SetDepthStencilState(overcastDepthStencil, 0);
        SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		VERTEX_SHADER(VS_RayMarched())
		PIXEL_SHADER(PS_RayMarched())
		SetGeometryShader(NULL);
    }
}


technique10 Debug
{
    pass P0
    {
        SetVertexShader(CompileShader(vs_4_0, VS_Debug()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, GS_Debug()));
		SetPixelShader(CompileShader(ps_4_0, PS_Debug()));
	    SetDepthStencilState(overcastDepthStencil, 0);
		SetBlendState(overcastAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	//	SetRasterizerState(cullNone);
    }
}
