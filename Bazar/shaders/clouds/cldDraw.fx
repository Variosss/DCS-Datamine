#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#define FOG_ENABLE 1
#include "enlight/skyCommon.hlsl"

Texture2D texNoise;
Texture2D texTan;
Texture2D PtclMap;
Texture2D GradMap;
Texture2D SkyTex;

float4 const5;
float4 const6;
float4 const7;
float4 const8;

float4 const10;
float4 const11;
float4 const12;
float4 const13;

float4 const14;
float4 const15;

float4 const34;
float4 const40;
float4 const50;
float4 straightMap;

float4x4 cld_rpy;
float4x4 cview;
float4x4 viewproj;

float4 pix_const0;
float4 pix_const1;
float4 pix_const2;
float4 pix_const3;
float4 pix_const4;
float4 pix_const5;
float4 pix_const6;

float4 cldclr;

//float4 fog;

float4 quadclr;



void VertOut(float3 inPos0 : POSITION0, float3 inPos1 : POSITION1,
             float2 inPos2 : POSITION2, float3 inPos3 : POSITION3,

              out float4 oPos : SV_POSITION, out float4 oD0 : COLOR0, out float4 oD1 : COLOR1,
              out float3 oT0 : TEXCOORD0, out float2 oT1 : TEXCOORD1, out float3 oT2 : TEXCOORD2,
              out float2 oT3 : TEXCOORD3, out float4 oT4 : TEXCOORD4,
              out float4 oT5 : TEXCOORD5, out float4 wPos : TEXCOORD6
            )
              
{

//;
//;scale position (in particle)
//mul r2.x,v2.x,c40.x				//D3DXVECTOR4 vY(cld->ptcl_size,0,0,0);
									//m_pd3dDevice->SetVertexShaderConstantF(  40, vY,   1 );
//mul r0.x, v0.x,r2.x;c5.x ;
//mul r0.y, v0.y,r2.x;c5.x ;
//mul r0.z, v0.z,r2.x;c5.x ;
//mov r0.w, c4.w       ; 1

float4 r0=float4(inPos0*inPos2.x*const40.x,0);


//;/////////////////////////////////////////
//;transform to cld_rpy
//dp3 r1.x,r0,c30
//dp3 r1.y,r0,c31
//dp3 r1.z,r0,c32
//mov r1.w, c4.w       ; 1
float4 r1=mul(r0,cld_rpy);
//;///////////////////////////////
//;normalize
//;get y in tangent space
//rcp r2.w,c5.x		//D3DXVECTOR4 vB(cld->size,0,NoiseRepeat,0.35f); m_pd3dDevice->SetVertexShaderConstantF(  5, vB,   1 );
//mul r3,r1,r2.w      ;r3=normalized position in world coords
//mul r3,r3,c34.w		//D3DXVECTOR4 vZ(cld->cld_rpy._43,cld->cld_rpy._34,cld->cld_rpy._44,1.0f);
						//m_pd3dDevice->SetVertexShaderConstantF(  34, vZ,   1 );


float4 r3=r1/const5.x;


//dp3 r2.y,r3,v1	;height along normal 
//max r2.y,r2.y,-r2.y

float r2y=abs(dot(r3,inPos1));

//mul oT2.z,r2.y,c6.x		//D3DXVECTOR4 vC(1.3f,0.25f,0.45f,0.4f);
							//m_pd3dDevice->SetVertexShaderConstantF(  6, vC,   1 );
oT2.z=1.3*r2y;

//;///////////////////////////////
                 
//add r1.xyz,r0.xyz,c34.xyz
r1.xyz=r0.xyz+const34.xyz;

//;sling into place
//mad r1.xyz,v3.xyz,c5.x,r1.xyz
r1.xyz+=inPos3.xyz*const5.x; //

//rcp r1.w,c5.x
//mul r1,r1,r1.w
r1.w=const5.x;
r1/=r1.w;

//mul r8.x, r1.x,c5.z ;
//mul r8.y, r1.y,c5.z;,c5.y; ;
//mul r8.z, r1.z,c5.z ;
float4 r8=r1*const5.z;
/////////////////////////////////////////

//;transform to face camera
//
//dp3 r1.x,r0,c20
//dp3 r1.y,r0,c21
//dp3 r1.z,r0,c22
//mov r1.w, c4.w 

r1=mul(cview,r0);

//;
//;move into place in the cloud
//mad r0.xyz,v3.xyz,c5.x,r1.xyz
r0.xyz=inPos3.xyz*const5.x+r1.xyz;

//add r1,r0,c14    //m_pd3dDevice->SetVertexShaderConstantF(  14, cld->pos,  1 );
r1=r0+const14;



oT1.x=(inPos0.xy*0.5)+0.5;


//oT1.y=1-(r1.y-2100)/2100;
oT1.y=1-(r1.y-const14.y+const5.x)/(1.0*const5.x);//2100;

oT1.y *= 0.9 + 0.8*frac(inPos1.y*4817.857163951);


//add r3,-r1,c8  //	m_pd3dDevice->SetVertexShaderConstantF(  8, cameraPos,   1 );
//dp3 r3.w,r3,r3
//rsq r3.w,r3.w
//mul r3,r3,r3.w
//dp3 r3.w,r3,c7  //c7 - light vector
r3=const8-r1;
normalize(r3.xyz);
r3.w=dot(r3.xyz,const7.xyz);

//min r3.w,r3.w,c4.y
//mul r3.w,-r3.w,c6.w
//mul oD1.xyz,r3.w,c50 //cloud color

r3.w=min(r3.w,0);
r3.w*=-0.4;
oD1.xyz=r3.w*const50.xyz; //


//dp4 r5.x,r0,c0
//dp4 r5.y,r0,c1
//dp4 r5.z,r0,c2
//dp4 r5.w,r0,c3  ;post-projection space

r0.w=1;
r0.y+=0.3*const5.x;

oT5=r1;
float4 r5=mul(r0,viewproj);

//mov r7,r5
float4 r7=r5;

//rcp r6.w,r5.w
//mul r5.xy,r5.xy,r6.w
r5.xy/=r5.w;


//add r5.xy,r5.xy,c10.xy   ;shift to port
//mul r5.xy,r5.xy,c11.xy	 ;scale to 0..1 range
//add r5.xy,r5.xy,c12.xy   ;shift to window

r5.xy=(r5.xy+const10.xy)*const11.xy+const12.xy;

//mad r5.x,r5.x,c13.w,-c13.z ;bring to -1..1 range
//mad r5.y,r5.y,-c13.w,c13.z ;bring to -1..1 range
r5.x=r5.x*const13.w-const13.z;
r5.y=-r5.y*const13.w+const13.z;

//mul r5.xy,r5.xy,r5.w
r5.xy*=r5.w;

//mul r5,r5,c15.x  //D3DXVECTOR4 c15;
	               //if (!(cld->straightMap)) c15=D3DXVECTOR4(1.0f,0,0,0);else c15=D3DXVECTOR4(0,1.0f,0,0);
//mul r7,r7,c15.y
//add r5,r5,r7


r5*=const15.x;
r7*=const15.y;
//oPos.xy=inPos0.xy*0.5+0.5;//r5+r7;
//oPos.z=0;
//oPos.w=1;

float4 finpos=r5+r7;
oPos=finpos;

oT4.x=-finpos.x*0.5+0.5*finpos.w;
oT4.y=-finpos.y*0.5+0.5*finpos.w;
oT4.zw=finpos.zw;
//oT4=finpos;
//oT6=const8;



//--


//dp3 r1.w,v1,c7
//mul r2.w,r1.w,c7.w

//max r2.w,r2.w,-c4.w
//min r2.w,r2.w,c4.w
//add r2.w,r2.w,c4.w
//mul oD1.w,r2.w,c4.z

r1.w=dot(inPos1,const7);
oD1.w=(min(max(4*r1.w,-1),1)+1)*0.5;


//min r1.w,r1.w,-r1.w
//mul r1.w,r1.w,c6.y ;0.125
//
//add oD0.xyz,r1.w,c6.z ;0.625
oD0.xyz=-abs(r1.w)*0.25+0.45;


oD0.w=finpos.w;


//mov oT1.x,c4.w
//mov oT1.y,c4.y
//mov oT1.z,c4.y
//
//mov oT2.x,c4.y
//mov oT2.y,c4.y

//mad oT3.xy,v0.xy,c4.z,c4.z
oT3.xy=(inPos0.xy*0.5)+0.5;
oT0.xyz=r8.xyz;
oT2.xy=0;
	
	wPos = mul(oPos, gViewProjInv);

}

float4 PixShader( float4 pos : SV_POSITION, float4 dif :COLOR0, float4 spec :COLOR1,
                     float3 tex0 : TEXCOORD0,float2 tex1 : TEXCOORD1,float3 tex2 : TEXCOORD2,
                     float2 tex3 : TEXCOORD3,float4 tex4 : TEXCOORD4, float4 objPos : TEXCOORD5, float4 wPos : TEXCOORD6, uniform bool isImpostor):
					 SV_TARGET0
{
	clipInCockpit(wPos);
	float4 t0   = texNoise.Sample(WrapLinearSampler, tex0.xy);
	float4 grad = GradMap.Sample(ClampLinearSampler, tex1.xy)*0.5+0.5;

	float2 td;
	td.x=t0.x;
	td.y=1-tex2.z;


	float t2 = texTan.Sample(WrapLinearSampler, td.xy).x;
// 	cOut = t2;
// 	return Out;
//float4(1.0,0,0,1); //
	float4 t3=PtclMap.Sample(ClampLinearSampler, tex3);

	//dp3_sat t1.xyz, c4, t3_bx2
	//+ mul r1.w, t0.w, c0.w

	float3 t1=min(1,dot(pix_const4,(t3.xyz-0.5)*2));
	float r1w=t0.w*pix_const0.w;


	//mad_sat r0.xyz, 1-t0.w, v0, r1.w
	//+ sub_sat r1.w, v1.w, c1.w

	float3 r0=min(1,(1-t0.w)*dif+r1w);
	r1w=max(0,spec.w-pix_const1.w);

	//mad r1.xyz, 1-r0, c5,c0
	//+ add_sat t0.w, -v1.w, c2.w

	float3 r1=(1-r0)*pix_const5+pix_const0;
	float t0w=min(1,pix_const2.w-spec.w);


	//mad r1.xyz, 1-t2.w, v1, r1
	//+ add_sat r0.w, t0.w, r1.w

	r1+=(1-0.6*t2.x);//*spec;
	float r0w=min(1,t0.w+r1w);


	//mad r0.xyz, r0, c5,c1
	//+ sub_x4_sat r1.w, 1-r0.w, c3.w

	r0=r0*pix_const5+pix_const1;
	r1w=min(1,((1-r0w)*pix_const3.w)*4);

	//mad r0.xyz, v1, c2, r0
	//+ mad_sat r1.w, r1.w, 1-t2.w, v1.w
	r0+=spec*pix_const2;
	r1w=r1w*(1-t2.x)+spec.w;


	//lrp r0.xyz, r1.w, r1, r0
	r0=r1;//lerp(r1,r0,r1w);

	//mad r0.xyz, t1, c6, r0
	//+ mul_x2 r0.w, t2.w, t3.w
	
	// return float4(r0, t2.x*t3.x);
	// return grad;

	float4 color;
	color.rgb = grad;
	color.a = min(t2.x*t3.x, 1.0);

	if(!isImpostor)
	{
		color.rgb *= cldclr * 0.3 * gSunIntensity;
		// float3 VoL = const50.x;
		// color.rgb += gSunDiffuse.rgb * VoL * saturate(1-color.a*4) * gSunIntensity;// halo
		float dist = distance(const8.xyz, objPos.xyz);
		color.xyz = applyFog(color.xyz, (objPos.y-const8.y)/dist, dist);
	}
	return color;
}

technique10 AlphaPass
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixShader(true)));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlendWriteMaskAlpha, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone); 
    }
 }

technique10 ColorPass
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixShader(true)));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlendWriteMaskRGB, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone); 
    }
 }

technique10 ParticlesPass
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixShader(false)));
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlendWriteMaskRGB, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone); 
    }
 }

