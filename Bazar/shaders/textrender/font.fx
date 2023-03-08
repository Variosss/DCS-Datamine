#ifdef DIRECTX11
Texture2D FontTexture;

SamplerState linearWrapSampler
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Wrap;
	AddressV = Wrap;
};
#else
texture FontTexture;

sampler2D mySampler = sampler_state
{
	MinFilter = LINEAR;
	MagFilter = LINEAR;
};
#endif

float4 cv0;
float4 cv1;
float4 cv2;
//float4 cv3;
//float4 cv4;
//float4 cv5;
float4 charArray[64];

float4 MyPixelParamsZero;

struct VS_INPUT
{
	float3 vPos  : POSITION;
};

struct VS_OUTPUT
{
#ifdef DIRECTX11
	float4 oPos  : SV_POSITION;
#else
	float4 oPos  : POSITION;
#endif
	float2 oTex0 : TEXCOORD0;
};

// void VerText(float3 vPos : POSITION, out float4 oPos : POSITION, out float2 oTex0 : TEXCOORD0)
VS_OUTPUT VerText(VS_INPUT vsInput)
{
	VS_OUTPUT vsOutput = (VS_OUTPUT)0;
	
	float tmp=vsInput.vPos.z*cv0.z+cv0.x;
	vsOutput.oPos.x=vsInput.vPos.x*cv0.z+tmp;
	vsOutput.oPos.y=-vsInput.vPos.y*cv0.w+cv0.y;
	vsOutput.oPos.z=cv1.z;
	vsOutput.oPos.w=1;
	
	float charlie=vsInput.vPos.z*0.25f;
	float charFrac=frac(charlie);
	float charFloor=charlie-charFrac;
	float4 selector;
	if (charFrac>=0.75) selector.w=1.0;else selector.w=0;
	if (charFrac>=0.5) selector.z=1.0;else selector.z=0;
	if (charFrac>=0.25) selector.y=1.0;else selector.y=0;
	if (charFrac<0.25) selector.x=1.0;else selector.x=0;
	
	selector.yz-=selector.w;
	selector.y-=selector.z;
	
	float charId=dot(selector,charArray[charFloor]);
	charId-=cv1.x;
	charId*=cv1.y;
	float charGo=vsInput.vPos.x*cv1.z+charId;
	
#ifdef DIRECTX11
	vsOutput.oTex0.x = charGo;
	vsOutput.oTex0.y = vsInput.vPos.y;
#else
	vsOutput.oTex0.x = charGo+cv2.x;
	vsOutput.oTex0.y = vsInput.vPos.y+cv2.y;
#endif
	
	return vsOutput;
}

#ifdef DIRECTX11
float4 PixOut(VS_OUTPUT psInput) : SV_TARGET0
{
	float4 t = FontTexture.Sample(linearWrapSampler, psInput.oTex0);
	t.rgb = float3(0.0f, 1.0f, 1.0f);
	float4 C = float4(t.rgb*MyPixelParamsZero,t.a*MyPixelParamsZero.a);
	return C;
}
#else
float4 PixOut(VS_OUTPUT psInput) : COLOR0
{
	float4 t = tex2D(mySampler, psInput.oTex0);
	float4 C = float4(t.rgb*MyPixelParamsZero,t.a*MyPixelParamsZero.a);
	return C;
}
#endif

#ifdef DIRECTX11
BlendState enableAlphaBlend
{
	BlendEnable[0] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = ONE;
	DestBlendAlpha = ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0F;
};

DepthStencilState disableDepthBuffer
{
	DepthEnable = FALSE;
};

RasterizerState cullNone
{
	CullMode = None;
};

technique10 T0
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, VerText()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
#else
technique T0
{
	pass P0
	{
		PixelShaderConstant1[0] = <MyPixelParamsZero>;

	AlphaBlendEnable = True;
	SrcBlend    = SRCALPHA;
	DestBlend   = INVSRCALPHA;
	AlphaTestEnable = True;
	AlphaRef =0;
	ZEnable = False;
	StencilEnable = False;

	texture[0]   = < FontTexture >;

		VertexShader = compile vs_3_0 VerText(); 	
//    	PixelShader = compile ps_3_0 PixOut();
		PixelShader = compile ps_3_0 PixOut();
	
/*	PixelShader = asm
	{
		ps.1.1

		tex t0

		mul r0.rgb,t0,c0
		+mov r0.a,t0.a
	};*/
	}
 }
#endif
 








		
