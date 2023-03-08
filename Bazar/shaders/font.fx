Texture2D FontTexture;
//texture IdTexture;

float4 cv0; //x,y - text screen offset in unit coords, z char height in texture space, w=char geometrical height
float4 cv1; //x - fontTexWidth/targetWidth, 0,0.5/texwidth,0.5/texheight
float4 cv2;
float4 cv3;
float4 cv4; //0,0,0.5,1
float4 cv5;
float4 charArray[128]; //offset,width,tx0,ty0

float worldSpace = 0;
float4x4 MVP;

float4 charcolor;

const float epsilon=0.0001;

// vPos.x - x-координата 
// vPos.y - y-координата 
// vPos.z - номер прямоугольниука в буфере (номер символа в строке, рисуемой буфером)

struct vsOutput {
	float4 vPos			: SV_POSITION;
	float2 uv			: TEXCOORD0;	
};


vsOutput VerText(float3 vPos : POSITION) {

    float4 v = charArray[vPos.z];           // достаем параметры символа по номеру символа

    float xx =  vPos.x * v.y + v.x + cv0.x;
    float yy = -vPos.y * cv0.w + cv0.y;

//    oPos.x=xx;
//    oPos.y=yy;
//    oPos.z=0;
//    oPos.w=1;

//    oTex0.x=vPos.x*v.y*0.5*cv1.x+v.z;//+cv2.x;

//    oTex0.x=vPos.x*v.y*cv1.x+v.z+cv1.z;
//    oTex0.y=vPos.y*cv0.z+v.w+cv1.w;
    
//	  oPos = mul(oPos, MVP);

	vsOutput o;
	
	o.vPos = mul(float4(xx, yy, 0, 1), MVP);
	o.uv = float2(vPos.x*v.y*cv1.x+v.z+cv1.z, vPos.y*cv0.z+v.w+cv1.w);
	return o;
}

/*
sampler2D mySampler = sampler_state
{
	texture   = < FontTexture >;
	MinFilter = POINT;
	MagFilter = POINT;
};
*/

SamplerState mySampler
{
	Filter    = MIN_MAG_MIP_POINT;
	AddressU      = WRAP;
	AddressV      = WRAP;
	BorderColor   = float4(0, 0, 0, 0);
};

float4 PixOut(vsOutput i) : SV_TARGET0
{
//	float4 cod=tex2D(mySampler, tex0);
	float4 cod=FontTexture.Sample(mySampler, i.uv);

	return float4(charcolor.xyz, charcolor.w * cod.w);
}

RasterizerState cullNone
{
	CullMode = None;
	FillMode = Solid;
	MultisampleEnable = FALSE;
};

DepthStencilState depthState
{
	DepthEnable        = FALSE;
};

BlendState blendState
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

technique10 T0
{
    pass P0
    {
	    SetVertexShader(CompileShader(vs_4_0, VerText()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));

		SetDepthStencilState(depthState, 0);
		
		SetBlendState(blendState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
    }
}


/*
technique T0
{
    pass P0
    {
//        PixelShaderConstant1[0] = <charcolor>;

	AlphaBlendEnable = True;
	SrcBlend    = SRCALPHA;
	DestBlend   = INVSRCALPHA;
	AlphaTestEnable = True;
	AlphaRef = 0;
    ALPHAFUNC = GREATER;
	ZEnable = False;
	// StencilEnable = False;
	CullMode = NONE;
    //FillMode = WIREFRAME;

	//texture[0]   = < FontTexture >;

    	VertexShader = compile vs_3_0 VerText(); 	
    	PixelShader = compile ps_3_0 PixOut();
	
    }
 }

 */






    	
