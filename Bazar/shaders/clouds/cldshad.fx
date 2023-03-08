
#include "common\States11.hlsl"
#include "common\samplers11.hlsl"
Texture2D diffTex;

float4x4 viewproj;
float4x4 invView;
float4 pos;
float4x4 rot;

float3 cameraSpacePos;

struct VS_OUTPUT
{
	float4 oPos : SV_POSITION;
    float4 oT0 : TEXCOORD0;
};

VS_OUTPUT VertOut(float2 inPos0 : POSITION0)
{
	VS_OUTPUT OUT = (VS_OUTPUT)0;
	float4 r0;
	r0.x=inPos0.x*pos.w;
	r0.y=inPos0.y*pos.w;
	r0.z=0;
	r0.w=1;

	r0=mul(r0,rot);

	r0=mul(r0,invView);

	OUT.oT0.z = length(r0.xyz+cameraSpacePos.xyz)*0.001;

	r0.xyz+=pos.xyz;
	
	OUT.oPos=mul(r0,viewproj);

	OUT.oT0.x=inPos0.x*0.5+0.5;
	OUT.oT0.y=inPos0.y*0.5+0.5;

	
	return OUT;

}

float4 PixOut( VS_OUTPUT input): SV_TARGET0
{ 
	float c = diffTex.Sample(WrapLinearSampler, input.oT0).x;
	c = 0.7*(1-c.x) * saturate((50.0-input.oT0.z)*0.5); // view distance 50km

	if (c < 0.001) 
		discard;

	return float4(0,0,0,c);
}

technique10 blya_Mityai_u_menya_tolko_odna_technika_nahui_ya_dolzhen_ee_vystavlyat //spasibo - porzhal
{
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, VertOut()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetComputeShader(NULL);

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone); 
    }
 }

