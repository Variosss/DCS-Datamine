

matrix WVP;


Texture2D Video;

float t; //ED Time
float BoxWidth;
float BoxHeight;
bool Invert;
float Contrast;
float Brightness;


struct VS_INPUT
{
	float4 pos : POSITION;
	float2  uv : TEXCOORD0;
};

struct VS_OUT
{
	float4 oPos : SV_POSITION;
	float2 TexCoords  : TEXCOORD0;
	float2 objectPosition : TEXCOORD1;
};


VS_OUT vs_main(VS_INPUT IN)
{
	VS_OUT vs_out;
	vs_out.oPos = mul(IN.pos, WVP);
	vs_out.TexCoords = IN.uv;
	vs_out.objectPosition = IN.pos;
	return vs_out;
}



SamplerState mySampler{
	Filter = MIN_MAG_MIP_LINEAR; //sets min/mag/mip filter to linear
	AddressU = Wrap;
	AddressV = Wrap;
};


float rand(float2 co)
{
	float a = 12.9898;
	float b = 78.233;
	float c = 43758.5453;
	float dt = dot(co.xy, float2(a, b));
	float sn = fmod(dt, 3.14);
	return frac(sin(sn) * c);
}


float4 Distort(float2 uv)
{

	float magnitude = 0.0015;


	// Set up offset
	float2 offsetRedUV = uv;
	offsetRedUV.x = uv.x + rand(float2(t*0.03, uv.y*0.42)) * 0.001;
	offsetRedUV.x += sin(rand(float2(t*0.2, uv.y)))*magnitude;

	float2 offsetGreenUV = uv;
	offsetGreenUV.x = uv.x + rand(float2(t*0.004, uv.y*0.002)) * 0.004;
	offsetGreenUV.x += sin(t*9.0)*magnitude;

	float2 offsetBlueUV = uv;
	offsetBlueUV.x = uv.y;
	offsetBlueUV.x += rand(float2(cos(t*0.01), sin(uv.y)));

	//Shift
	const float RADIUS = 0.85;
	const float SOFTNESS = 0.65;


	float2 position = uv / float2(0.6, 1.0) - float2(0.8, 0.5);
	float len = length(position);
	float vignette = 1.0 - smoothstep(RADIUS, RADIUS - SOFTNESS, len);
	float angle = dot(position, uv) / (length(position)*length(uv));
	float2 screenPos = float2(1,0) - uv;




	// Load Texture
	float r = Video.Sample(mySampler, offsetRedUV - (vignette*(position*(len*0.215)))); // texture2D(iChannel0, offsetRedUV).r;
	float g = Video.Sample(mySampler, offsetGreenUV);  //texture2D(iChannel0, offsetGreenUV).g;
	float b = Video.Sample(mySampler, uv + (vignette*(position*(len*0.415)))); // texture2D(iChannel0, offsetRedUV).r; //texture2D(iChannel0, uv).b;

	float4 col = float4(r, g, b, 1);

	// ragnars invert 
	if ( Invert )
	{
		col.rgb = 1.0 - col.rgb;
	}

	//Scanlines
	float scanline = sin(uv.y*1600.0)*0.04;
	col -= scanline;

	// vignette
	col *= 1.0 - length(uv - float2(0.5, 0.5)) *0.5;

	col.rgb /= col.a;

	// ragnars contrast.
	col.rgb = ((col.rgb) * max(Contrast, 0));

	// ragnars brightness.
	col.rgb += Brightness;

	// Return final pixel color.
	col.rgb *= col.a;

	return col;
	//return float4(1.0,0.0,0.0,1.0);
}




float4 ps_ep13(VS_OUT input) : SV_TARGET0
{
	float4 res = Distort(input.TexCoords);
	//return float4(1, 0, 0, 1);


	const float fade = 0.004;
	float fadealpha = 1;
	float4 crosshaircolor = float4(1, 1, 1, 1);
	if (Invert)
	{
		crosshaircolor = float4(0, 0, 0, 1);
	}
	//Vertical
	if (((input.TexCoords.x < 0.5 + fade) && (input.TexCoords.x > 0.5 - fade)) && ((input.TexCoords.y < 0.5 - BoxWidth) || (input.TexCoords.y > 0.5 + BoxWidth)))
	{
		//Distance from center
		fadealpha = abs(input.TexCoords.x - 0.5) / fade;

	}

	//Horizontal
	if (((input.TexCoords.y < 0.5 + fade) && (input.TexCoords.y > 0.5 - fade)) && ((input.TexCoords.x < 0.5 - BoxHeight) || (input.TexCoords.x > 0.5 + BoxHeight)))
	{
		fadealpha = abs(input.TexCoords.y - 0.5) / fade;
	}

	float invalpha = 1 - fadealpha;
	return float4(fadealpha * res.x + invalpha * crosshaircolor.x, fadealpha * res.y + invalpha * crosshaircolor.y, fadealpha * res.z + invalpha * crosshaircolor.z, 1); //Alpha blend

}





technique10 EP13
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetPixelShader(CompileShader(ps_4_0, ps_ep13()));

	}
}
