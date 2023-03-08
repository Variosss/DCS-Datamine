#include "common\States11.hlsl"
#include "common\TextureSamplers.hlsl"


Texture2D VelocityTexture;
Texture2D TheField;
Texture2D jacobiX;
Texture2D jacobiB;
Texture2D Pressure;
Texture2D OffsetLookup;

float4 offsetTable[34];


float       timestep;   
float       dissipation; // mass dissipation constant.
float       rdx;         // 1 / grid scale.
float 		halfrdx;

float revtexsize;	// 1 /tex size
float revOffsetTableSize; //=1/34

float alpha;
float rBeta;
float scale;

float4 bcOffset;

float4 impDir;
float4 impCoords;

float4 dxscale;

float lerpFactor;


//-----------------------------
SamplerState clampSampler
{
    Filter   = MIN_MAG_MIP_POINT;
    AddressU = CLAMP;
    AddressV = CLAMP;
};


float4 f4texRECTbilerp(Texture2D tex, float2 s)
{
  float4 st;
  st.xy = floor(s/revtexsize - 0.5) + 0.5;
  st.zw = st.xy + 1;
  
  float2 t = s/revtexsize - st.xy; 
  
  st*=revtexsize;
    
  float4 tex11 = tex.Sample(clampSampler, st.xy);
  float4 tex21 = tex.Sample(clampSampler, st.zy);
  float4 tex12 = tex.Sample(clampSampler, st.xw);
  float4 tex22 = tex.Sample(clampSampler, st.zw);

  return lerp(lerp(tex11, tex21, t.x), lerp(tex12, tex22, t.x), t.y);
}

void h4texRECTneighbors(Texture2D tex, float2 s,
                        out float4 left,
                        out float4 right,
                        out float4 bottom,
                        out float4 top)
{
  left   = tex.Sample(clampSampler, s - float2(1*revtexsize, 0)); 
  right  = tex.Sample(clampSampler, s + float2(1*revtexsize, 0));
  bottom = tex.Sample(clampSampler, s - float2(0, 1*revtexsize));
  top    = tex.Sample(clampSampler, s + float2(0, 1*revtexsize));
}

void h1texRECTneighbors(Texture2D tex, float2 s,
                        out float left,
                        out float right,
                        out float bottom,
                        out float top)
{
  left   = tex.Sample(clampSampler, s - float2(1*revtexsize, 0)); 
  right  = tex.Sample(clampSampler, s + float2(1*revtexsize, 0));
  bottom = tex.Sample(clampSampler, s - float2(0, 1*revtexsize));
  top    = tex.Sample(clampSampler, s + float2(0, 1*revtexsize));
}


void advect(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 xNew : SV_TARGET0)
{
  float2 p = coords - timestep * rdx * VelocityTexture.Sample(clampSampler, coords);
  xNew = dissipation * f4texRECTbilerp(TheField, p);
} 

void divergence(float4 pos : SV_POSITION, float2 coords : TEXCOORD0,  out  float4 div : SV_TARGET0)
{
  float4 vL, vR, vB, vT;
  h4texRECTneighbors(TheField, coords, vL, vR, vB, vT);
  div = halfrdx * (vR.x - vL.x + vT.y - vB.y);
}

void jacobi(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 xNew : SV_TARGET0)
{
 
  float4 xL, xR, xB, xT;
  h4texRECTneighbors(jacobiX, coords, xL, xR, xB, xT);
  
  float4 bC = jacobiB.Sample(clampSampler, coords);

  xNew = (xL + xR + xB + xT + alpha * bC) * rBeta;
} 

void gradient(float4 pos : SV_POSITION,float2 coords  : TEXCOORD0, out float4 uNew : SV_TARGET0)
{
  float pL, pR, pB, pT;
  
  h1texRECTneighbors(Pressure, coords, pL, pR, pB, pT);

  float2 grad = float2(pR - pL, pT - pB) * halfrdx;

  uNew = TheField.Sample(clampSampler, coords);
  uNew.xy -= grad;
}

void boundary(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 bv : SV_TARGET0)
{
  bv = scale * TheField.Sample(clampSampler, coords + (bcOffset.xy+float2(0.0,0.0))*revtexsize); 
} 

void copy(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 bv : SV_TARGET0)
{
  bv = TheField.Sample(clampSampler, coords); 
} 

void copy2(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 bv : SV_TARGET0)
{
  bv = (TheField.Sample(clampSampler, coords)*1*0.5+0.5);
  bv.z=0;
}

void copy3(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 bv : SV_TARGET0)
{
  bv = (TheField.Sample(clampSampler, coords)*2-1); 
}

void copy4(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 bv : SV_TARGET0)
{

float4 vL, vR, vB, vT;
  h4texRECTneighbors(jacobiX, coords, vL, vR, vB, vT);

  float r=1-0.25*(vL+vR+vB+vT);
  bv = (TheField.Sample(clampSampler, coords)*0.5+0.5)*r;
  bv.z=r*0.5;
}



void vorticity(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 v : SV_TARGET0)
{
  float4 uL, uR, uB, uT;
  h4texRECTneighbors(TheField, coords, uL, uR, uB, uT);
  
  v = halfrdx * ((uR.y - uL.y) - (uT.x - uB.x));
}

void vortForce(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 uNew : SV_TARGET0)

{
  float vL, vR, vB, vT, vC;
  h1texRECTneighbors(TheField, coords, vL, vR, vB, vT); //vort
  vC = TheField.Sample(clampSampler, coords);
  
  float2 force = halfrdx * float2(abs(vT) - abs(vB), abs(vR) - abs(vL));
  

  static const float EPSILON = 2.4414e-4; // 2^-12
  float magSqr = max(EPSILON, dot(force, force)); 
  force/= sqrt(magSqr); 
  
  force *= dxscale.xy * vC * float2(1, -1);

  uNew = VelocityTexture.Sample(clampSampler, coords);

  uNew.xy += timestep * force;
} 
//////////

void updateOffsets(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 offsets : SV_TARGET0)
{
  float bW, bE, bN, bS;
  h1texRECTneighbors(TheField, coords, bW, bE, bS, bN);
  float bC = TheField.Sample(clampSampler, coords);

  float index = 3 * bN + bE + 5 * bS + 7 * bW + 17 * bC;

  offsets = offsetTable[index];
}

void arbitraryVelocityBoundary(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 uNew : SV_TARGET0)
{
  float4 scaleoffset = OffsetLookup.Sample(clampSampler, coords);
  
  uNew.x = scaleoffset.x * TheField.Sample(clampSampler, coords + float2(0, scaleoffset.y)*revtexsize);
  uNew.y = scaleoffset.z * TheField.Sample(clampSampler, coords + float2(scaleoffset.w, 0)*revtexsize).y;
  uNew.zw = 0;
}

void arbitraryPressureBoundary(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 pNew : SV_TARGET0)
{
  float4 offset = OffsetLookup.Sample(clampSampler, coords);

  pNew = 0.5 * (TheField.Sample(clampSampler, coords + offset.xy*revtexsize) + 
                TheField.Sample(clampSampler, coords + offset.zw*revtexsize));
}

void updateTempAndMoist(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 pNew : SV_TARGET0)
{

  float4 prev = jacobiX.Sample(clampSampler, coords);
  float4 cur = TheField.Sample(clampSampler, coords); //theta, qv, qc
  
  float p=Pressure.Sample(clampSampler, coords);
  
  
  
  float Exner=pow(1/exp(-p*0.5),0.286); //
  
  float T=(prev.x)*Exner;//min(2,(prev.x)*Exner);
  
  float sp=(1.0+0.02*p);
 
  float qvs=-380.16/sp*exp(min(0.5,17.67*T/(T+243.5))); //max(p,1.02)
  
  float dqv=qvs-cur.y;//min(qvs-cur.y,cur.z);
  pNew.y=cur.y+dqv;
  pNew.z=cur.z-dqv;
  
  float dC=-dqv;
  
  
  pNew.x=cur.x+2.501*dC/(1005*Exner); //2.501 - latent heat of vaporization, J/kg
  pNew.w=0;

}

void copy5(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 bv : SV_TARGET0)
{
  float4 vL, vR, vB, vT;
  h4texRECTneighbors(jacobiX, coords, vL, vR, vB, vT);

  float v=1-0.25*(vL+vR+vB+vT);

  //float qc=(TheField.Sample(clampSampler, coords)).z;
  //
  //float m=min(1,qc/440);//550);
 

  //float r=max(0,pow(m,8)-0.6)*4;

  float4 mmm=f4texRECTbilerp(TheField,coords);

  float r=max(0,mmm.x);

  bv = min(1,r*v);//lerp(float4(0.05,0.1,0.18,1),float4(1,1,1,1),min(1,r*v));//>0.5 ? 1: 0;//lerp(float4(0.5,0.6,0.8,1),1,r); 
}

void dumbLerp(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 bv : SV_TARGET0)
{
	float4 bv1 = TheField.Sample(clampSampler, coords); 
	float4 bv2 = jacobiX.Sample(clampSampler, coords);
	bv = lerp(bv2,bv1,lerpFactor);
} 

//=========================================================================
void impulseP(float4 pos : SV_POSITION,float2 coords : TEXCOORD0, out float4 bv : SV_TARGET0)
{
	float2 rr=coords;
	rr/=max(0.0001,pow(length(rr),4));


	bv.xy=impDir.xy*length(rr);
	bv.zw=0;
}

void impulseV(float2 vPos : POSITION, out float4 oPos : SV_POSITION, out float2 oT0 : TEXCOORD0)
{
	float2 oo=vPos.xy*impCoords.zw+impCoords.xy;
	oPos.xy=oo;
	oPos.z=0;
	oPos.w=1.0;//cv4.z;
	oT0.xy=vPos.xy;
}
//------------------------------------------------------------
void VertOut(float2 vPos : POSITION, out float4 oPos : SV_POSITION, out float2 oT0 : TEXCOORD0)
{
	float2 oo=vPos;
	
	oPos.xy=oo;
	
	oPos.z=0;
	oPos.w=1.0;
	oT0.x=(oo.x*0.5+0.5)+0.0*revtexsize;
	oT0.y=(-oo.y*0.5+0.5)+0.0*revtexsize;
}

void VertOut2(float2 vPos : POSITION, out float4 oPos : SV_POSITION, out float2 oT0 : TEXCOORD0)
{
	float2 oo=vPos;
	//if(vPos.x>0)
		oo.x*=(1-revtexsize);
	//if(vPos.y<0)
		oo.y*=(1-revtexsize);
	
	oPos.xy=oo;

	oPos.z=0;
	oPos.w=1.0;
	oT0.x=(oo.x*0.5+0.5);
	oT0.y=(-oo.y*0.5+0.5);
}

struct PS_OUTPUT
{
    float4 cOut : SV_TARGET0;  // Pixel color
};

PS_OUTPUT PixOut( float4 pos : SV_POSITION,float2 tex0 : TEXCOORD0)
{ 
    PS_OUTPUT Out;

        Out.cOut.xyzw = float4(1,0,0,1);

    return Out;
}

//#ifndef DIRECTX11
//technique T0
//{
//    pass P0
//    {
//	AlphaBlendEnable =True;
//	SrcBlend=SrcAlpha;
//    DestBlend=InvSrcAlpha;
//
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
// 
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 PixOut();
//
//    }
// }
///////////////////
//technique tAdvect
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
// 
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 advect();
//
//    }
// }
// 
//technique tDiverge
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
//
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 divergence();
//
//    }
// }
// 
//technique tJacobi
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
// 
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 jacobi();
//
//    }
// }
// 
//technique tGradient
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
//
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 gradient();
//
//    }
// }
//
// technique tBoundary
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
//
//    VertexShader = compile vs_3_0 VertOut2();
//	PixelShader = compile ps_3_0 boundary();
//
//    }
// }
// 
//technique tCopy
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
//
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 copy();
//
//    }
// }
// 
//technique tCopy2
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
//
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 copy2();
//
//    }
// }
//
// technique tCopy3
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
//
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 copy3();
//
//    }
// }
//
//technique tCopy4
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
//
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 copy4();
//
//    }
// }
// 
//technique tCopy5
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
//
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 copy5();
//
//    }
// }
// 
//technique tImpulse
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
// 
//    VertexShader = compile vs_3_0 impulseV();
//	PixelShader = compile ps_3_0 impulseP();
//
//    }
//}
//technique tVorticity
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
// 
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 vorticity();
//
//    }
//} 
//
//technique tVortConf
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
// 
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 vortForce();
//
//    }
//} 
///////
//
//technique tUpdateOffsets
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
// 
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 updateOffsets();
//
//    }
//}
//
//technique tArbitraryVelocityBoundary
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
// 
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 arbitraryVelocityBoundary();
//
//    }
//}
//
//technique tArbitraryPressureBoundary
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
// 
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 arbitraryPressureBoundary();
//
//    }
//}
//
//technique tTempAndMoist
//{
//    pass P0
//    {
//	AlphaBlendEnable =False;
//	AlphaTestEnable = False;
//	ZEnable = False;
//	CullMode = NONE;
// 
//    VertexShader = compile vs_3_0 VertOut();
//	PixelShader = compile ps_3_0 updateTempAndMoist();
//
//    }
//}
//
//#else

//technique10 T0
//{
//    pass P0
//    {
//		SetVertexShader(CompileShader(vs_4_0, VertOut()));
//		SetGeometryShader(NULL);
//		SetPixelShader(CompileShader(ps_4_0, PixOut()));
//		SetDepthStencilState(disableDepthBuffer, 0);
//		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
//		SetRasterizerState(cullNone);      
//    }
// }
/////////////////
technique10 tAdvect
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, advect()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }
 
technique10 tDiverge
{
     pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, divergence()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }
 
technique10 tJacobi
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, jacobi()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }
 
technique10 tGradient
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, gradient()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }

technique10 tBoundary
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut2()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, boundary()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }
 
technique10 tCopy
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, copy()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }
 
technique10 tCopy2
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, copy2()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }

 technique10 tCopy3
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, copy3()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }

technique10 tCopy4
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, copy4()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }
 
technique10 tCopy5
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, copy5()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }

technique10 tLerp
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, dumbLerp()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
 }

technique10 tImpulse
{
     pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, impulseV()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, impulseP()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
}
technique10 tVorticity
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, vorticity()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
} 

technique10 tVortConf
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, vortForce()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
} 
/////

technique10 tUpdateOffsets
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, updateOffsets()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
}



technique10 tArbitraryVelocityBoundary
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, arbitraryVelocityBoundary()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
}

technique10 tArbitraryPressureBoundary
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, arbitraryPressureBoundary()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
}

technique10 tTempAndMoist
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, updateTempAndMoist()));
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);      
    }
}

//#endif
