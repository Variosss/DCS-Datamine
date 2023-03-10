#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

#define Smplr WrapLinearSampler

Texture2D s1;

Texture2D s2;
Texture2D s3;

Texture2D s4;
Texture2D s5;
Texture2D s6;
Texture2D s7;
Texture2D s8;
Texture2D s9;
Texture2D s10;
Texture2D s11;
Texture2D s12;
Texture2D s13;
Texture2D s14;
Texture2D s15;
Texture2D s16;
Texture2D s17;
Texture2D s18;
Texture2D s19;

float4x4 matWorldViewProj;
float4x4 matWorld;

float s_d;
float s_p;
int m;
float s_w;
float s_a;

float m_r_1;
float ma_r_1;

float m_r_2;
float ma_r_2;

int a_rn;
float a_rs;

float gamma;

static const bool olp = false;

struct VertexInput{
	float3 vPosition:	POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

struct VertexOutput{
	float4 vPosition:	SV_POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

VertexOutput vsSimple(const VertexInput i)
{
	VertexOutput o;

	o.vPosition = mul(float4(i.vPosition, 1.0), matWorldViewProj);	
	o.vTexCoord0 = float3(i.vTexCoord0.xy, i.vPosition.x);
	
	return o;
}

float4 mp(const float4 p1, const float4 p2)
{
	return float4(max(p1.r, p2.r), max(p1.g, p2.g), max(p1.b, p2.b), max(p1.a, p2.a));
}

float4 mpp(const float4 p1, const float4 p2)
{
	if (olp)
		return p1 + p2;
	else
		return float4(max(p1.r, p2.r), max(p1.g, p2.g), max(p1.b, p2.b), max(p1.a, p2.a));
}

float st(const float v, const float k)
{
	return (v - 0.5f) * k + 0.5f;
}

float4 gp(const float2 cc, int s_n)
{
	float4 pxc;
	
	switch(s_n)
	{
		case 1:
			pxc = s1.Sample(Smplr, cc);
			break;
			
		case 2:
			pxc = s2.Sample(Smplr, cc);
			break;
		case 3:
			pxc = s3.Sample(Smplr, cc);
			break;
			
		case 4:
			pxc = s4.Sample(Smplr, cc);
			break;
		case 5:
			pxc = s5.Sample(Smplr, cc);
			break;
		case 6:
			pxc = s6.Sample(Smplr, cc);
			break;
		case 7:
			pxc = s7.Sample(Smplr, cc);
			break;
		case 8:
			pxc = s8.Sample(Smplr, cc);
			break;
		case 9:
			pxc = s9.Sample(Smplr, cc);
			break;
		case 10:
			pxc = s10.Sample(Smplr, cc);
			break;
		case 11:
			pxc = s11.Sample(Smplr, cc);
			break;
		case 12:
			pxc = s12.Sample(Smplr, cc);
			break;
		case 13:
			pxc = s13.Sample(Smplr, cc);
			break;
		case 14:
			pxc = s14.Sample(Smplr, cc);
			break;
		case 15:
			pxc = s15.Sample(Smplr, cc);
			break;
		case 16:
			pxc = s16.Sample(Smplr, cc);
			break;
		case 17:
			pxc = s17.Sample(Smplr, cc);
			break;
		case 18:
			pxc = s18.Sample(Smplr, cc);
			break;
		case 19:
			pxc = s19.Sample(Smplr, cc);
			break;
			
		default:
			pxc = s1.Sample(Smplr, cc);
			break;
	}
	
	pxc.rgb = pow(pxc.rgb, gamma);
	//pxc.a = 1.0f;
	
	return pxc;
}

float4 gpa(const float2 cc, bool p)
{
	const float a_rn_f = float(a_rn);
	const float f_w = 1.0f / a_rn_f;
	
	const float x = max(0.0f, min(st(cc.x, 1.0f / (s_w * m_r_2)), 1.0f));
	
	/*
	const float x = st(cc.x, 1.0f / (s_w * m_r_2));
	
	if (x < 0.0f || x > 1.0f)
		return float4(0.0f, 0.3f, 0.0f, 1.0f);
	else
		return float4(0.0f, 0.0f, 0.0f, 1.0f);
	*/
	
	int r = min(floor(x * a_rn_f), a_rn - 1);
	int s_n;
	if (p)
		s_n = 4 + r;
	else
		s_n = 4 + a_rn * 2 - r - 1;
	
	/*
	if (s_n != 4 + 0 && s_n != 4 + 1)
		return float4(0.0f, 0.0f, 0.0f, 0.0f);
	*/
	
	float x_p = x / f_w - float(r);
	x_p = st(x_p, 1.0f / a_rs);
	
	return gp(float2(x_p, cc.y), s_n);
	
	/*
	const float4 pxi = gp(float2(x_p, cc.y), s_n);
	
	if (r > 0)
	{
		int s_n1;
		if (p)
			s_n1 = s_n - 1;
		else
			s_n1 = s_n + 1;
		
		float xx_o = x / f_w - float(r - 1);
		
		if (xx_o >= 1.0f)
		{
			xx_o = st(xx_o, 1.0f / a_rs);
		
			if (xx_o <= 1.0f)
				return mpp(pxi, gp(float2(xx_o, cc.y), s_n1));
		}
	}
	
	if (r < a_rn - 1)
	{
		int s_n2;
		if (p)
			s_n2 = s_n + 1;
		else
			s_n2 = s_n - 1;
		
		float xx_o = x / f_w - float(r + 1);
		
		if (xx_o <= 0.0f)
		{
			xx_o = st(xx_o, 1.0f / a_rs);
		
			if (xx_o >= 0.0f)
				return mpp(pxi, gp(float2(xx_o, cc.y), s_n2));
		}
	}
	
	return pxi;
	*/
}

/*
float4 ps1(const VertexOutput i): SV_TARGET0
{
	return float4(1.0f, 1.0f, 0.0f, 1.0f);
}
*/

float4 ps1(const VertexOutput i): SV_TARGET0
//float4 psxxx(const VertexOutput i): SV_TARGET0
{
	//return float4(0.0f, 0.0f, 0.0f, 0.0f);
	
	float4 pxc_b;
	
	if (m == 3)
	{
		float4 pxc_s = gp(i.vTexCoord0, 1);
		pxc_b = mp(gpa(i.vTexCoord0, true), gpa(i.vTexCoord0, false));
		
		return mp(pxc_s, pxc_b);
	}
	
	//float di = s_d;
	const float p = s_p;
	float p_e = ma_r_2;
		
	/*
	float ph_sh = 0.0f;
	float p = s_p + ph_sh;
	if (p < 0.0f)
	{
		p = 1.0f + p;
		di *= -1.0f;
	}
	*/
	
	//bool d_p = di > 0.5f;
	bool d_p = s_d > 0.5f;
	
	float px_p_x;
	if (d_p)
		px_p_x = i.vTexCoord0.x;
	else
		px_p_x = 1.0f - i.vTexCoord0.x;

	float px_r = 1.0f - i.vTexCoord0.y;
	
	if (m == 1)
	{
		float s = s_w * m_r_1 * m_r_2;
		
		float ct;
		if (d_p)
			ct = ma_r_1;
		else
			ct = -ma_r_1;
		
		px_p_x = st(px_p_x, 1.0f / s) - ct;
	}
	else if (m == 2)
	{
		float y = px_r - 0.085f;
		if (y < 0.0001f)
			return float4(0.0f, 0.0f, 0.0f, 0.0f);
		
		float x = px_p_x - 0.5f;
		
		px_p_x = (s_w + atan(x / y)) / (s_w * 2.0f);
		
		float x_s = i.vTexCoord0.x - 0.5f;
		
		if (abs(x_s) < 0.0001f)
			px_r = y;
		else
			px_r = x_s / sin(atan(x_s / y));
	}
		
	if (abs(s_d) < 0.5f)
		return float4(0.0f, 0.0f, 0.0f, 0.0f);
	
	bool bco = false;
	
	float b_e_m;
	if (m == 2)
		b_e_m = 0.003f;
	else
		b_e_m = 0.0f;
	
	if (px_p_x < -b_e_m || px_p_x > 1.0f + b_e_m)
	{
		pxc_b.rgba = 0.0f;
		bco = true;
	}
	
	bool n_s = px_p_x <= p;

	float d;
	
	if (m == 1)
	{
		const bool p_e_p = p_e >= 0.0f;
		
		p_e = abs(p_e);
		
		if (d_p == p_e_p)
		{		
			if (n_s)
				d = p + p_e - px_p_x;
			else
				d = p + px_p_x;
		}
		else
		{
			if (n_s)
				d = p - px_p_x;
			else
				d = p + p_e + px_p_x;
		}
	}
	else
	{
		if (n_s)
			d = p - px_p_x;
		else
			d = p + px_p_x;
	}
	
	float c = 1.0f - d + s_a;
	if (c <= 0.0f)
		return float4(0.0f, 0.0f, 0.0f, 0.0f);
	else if (c > 1.0f)
		c = 1.0f;
	
	if (!bco)
	{
		if (m == 1)
		{
			pxc_b = gpa(i.vTexCoord0, d_p == n_s);
		}
		else
		{
			float m_r, ma_r;
			if (d_p == n_s)
			{
				m_r = m_r_1;
				ma_r = ma_r_1;
			}
			else
			{
				m_r = m_r_2;
				ma_r = ma_r_2;
			}

			if (px_r < m_r || px_r > ma_r)
			{
				pxc_b.rgba = 0.0f;
			}
			else
			{
				const float u_e_k = 0.2f;
				
				float e_k;
				
				if (px_r > 1.0f - u_e_k)
					e_k = (1.0f - px_r) / u_e_k;
				else
					e_k = 1.0f;
					
				const float f_m = 0.05f;
				
				float res = 1.0f;
				
				if (px_r < m_r + f_m)
					res = (px_r - m_r) / f_m;
				else if (px_r > ma_r - f_m)
					res = (ma_r - px_r) / f_m;
				
				res *= e_k * e_k * e_k;
				
				int s_n;
				if (d_p == n_s)
					s_n = 2;
				else
					s_n = 3;
					
				pxc_b = gp(i.vTexCoord0, s_n);
				pxc_b.rgb *= res * res * res;
			}
		}
	}
		
	/*
	if (m == 1)
		return gp(i.vTexCoord0, 1);
	*/
	
	float4 pxc = mp(pxc_b, gp(i.vTexCoord0, 1));
	//float4 pxc = pxc_b;
	pxc.rgb *= c * c * c;
	return pxc;
}

technique10 T0
{	
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, vsSimple()));
		SetPixelShader(CompileShader(ps_4_0, ps1()));
		SetGeometryShader(NULL);
		SetRasterizerState(cullNone);
    }
}
