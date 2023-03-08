#ifndef FILIC_CURVE_HLSL
#define FILIC_CURVE_HLSL

struct CurveParamsDirect
{
	float m_x0;
	float m_y0;
	float m_x1;
	float m_y1;
	float m_W;

	float m_overshootX;
	float m_overshootY;

	float m_gamma;
};
	
struct CurveSegment
{
	float m_offsetX;
	float m_offsetY;
	float m_scaleX; // always 1 or -1
	float m_scaleY;
	float m_lnA;
	float m_B;
	
	float2 csDummy;
};

void ResetCurveSegment(inout CurveSegment s)
{
	s.m_offsetX = 0.0f;
	s.m_offsetY = 0.0f;
	s.m_scaleX = 1.0f; // always 1 or -1
	s.m_scaleY = 1.0f;
	s.m_lnA = 0.0f;
	s.m_B = 1.0f;
	s.csDummy = 0.0f;
}

struct FullCurve
{
	float m_W;
	float m_invW;

	float m_x0;
	float m_x1;
	float m_y0;
	float m_y1;

	CurveSegment m_segments[3];
	CurveSegment m_invSegments[3];
};

void ResetFullCurve(inout FullCurve c)
{
	c.m_W = 1.0f;
	c.m_invW = 1.0f;
	c.m_x0 = .25f;
	c.m_y0 = .25f;
	c.m_x1 = .75f;
	c.m_y1 = .75f;
	[unroll]
	for(uint i = 0; i < 3; ++i)
	{
		ResetCurveSegment(c.m_segments[i]);
		ResetCurveSegment(c.m_invSegments[i]);
	}
}



float CurveSegmentEval(CurveSegment s, float x)
{	
	float x0 = (x - s.m_offsetX)*s.m_scaleX;
	float y0 = 0.0f;

	// log(0) is undefined but our function should evaluate to 0. There are better ways to handle this,
	// but it's doing it the slow way here for clarity.
	if (x0 > 0)
	{
		y0 = exp(s.m_lnA + s.m_B*log(x0));
	}
	
	return y0*s.m_scaleY + s.m_offsetY;
}

float CurveSegmentEvalInv(CurveSegment s, float y)
{
	float y0 = (y-s.m_offsetY)/s.m_scaleY;
	float x0 = 0.0f;
	
	// watch out for log(0) again
	if (y0 > 0)
	{
		x0 = exp((log(y0) - s.m_lnA)/s.m_B);
	}
	float x = x0/s.m_scaleX + s.m_offsetX;

	return x;
}

float FullCurveEval(const in FullCurve c, float srcX)
{
	float normX = srcX * c.m_invW;
	uint index = (normX < c.m_x0) ? 0u : ((normX < c.m_x1) ? 1u : 2u);
	return CurveSegmentEval(c.m_segments[index], normX);
}

float FullCurveEvalInv(const in FullCurve c, float y)
{
	uint index = (y < c.m_y0) ? 0u : ((y < c.m_y1) ? 1u : 2u);
	return CurveSegmentEvalInv(c.m_segments[index], y) * c.m_W;
}

// find a function of the form:
//   f(x) = e^(lnA + Bln(x))
// where
//   f(0)   = 0; not really a constraint
//   f(x0)  = y0
//   f'(x0) = m
void SolveAB(inout float lnA, inout float B, float x0, float y0, float m)
{
	B = (m*x0) / y0;
	lnA = log(y0) - B*log(x0);
}

// convert to y=mx+b
void AsSlopeIntercept(inout float m, inout float b, float x0, float x1, float y0, float y1)
{
	float dy = (y1-y0);
	float dx = (x1-x0);
	if (dx == 0)
		m = 1.0f;
	else
		m = dy/dx;

	b = y0 - x0*m;
}

// f(x) = (mx+b)^g
// f'(x) = gm(mx+b)^(g-1)
float EvalDerivativeLinearGamma(float m, float b, float g, float x)
{
	float ret = g*m*pow(max(0,m*x+b), g-1.0f);
	return ret;
}

void CreateCurve(inout FullCurve dstCurve, const CurveParamsDirect srcParams)
{
	CurveParamsDirect params = srcParams;
	
	// FullCurve dstCurve;
	ResetFullCurve(dstCurve);
	dstCurve.m_W = srcParams.m_W;
	dstCurve.m_invW = 1.0f / srcParams.m_W;

	// normalize params to 1.0 range
	params.m_W = 1.0f;
	params.m_x0 /= srcParams.m_W;
	params.m_x1 /= srcParams.m_W;
	params.m_overshootX = srcParams.m_overshootX / srcParams.m_W;

	float toeM = 0.0f;
	float shoulderM = 0.0f;
	float endpointM = 0.0f;
	{
		float m, b;
		AsSlopeIntercept(m,b,params.m_x0,params.m_x1,params.m_y0,params.m_y1);

		float g = srcParams.m_gamma;
		
		// base function of linear section plus gamma is
		// y = (mx+b)^g

		// which we can rewrite as
		// y = exp(g*ln(m) + g*ln(x+b/m))

		// and our evaluation function is (skipping the if parts):
		/*
			float x0 = (x - m_offsetX)*m_scaleX;
			y0 = expf(m_lnA + m_B*logf(x0));
			return y0*m_scaleY + m_offsetY;
		*/

		CurveSegment midSegment; ResetCurveSegment(midSegment);
		midSegment.m_offsetX = -(b/m);
		midSegment.m_offsetY = 0.0f;
		midSegment.m_scaleX = 1.0f;
		midSegment.m_scaleY = 1.0f;
		midSegment.m_lnA = g * log(m);
		midSegment.m_B = g;

		dstCurve.m_segments[1] = midSegment;

		toeM = EvalDerivativeLinearGamma(m,b,g,params.m_x0);
		shoulderM = EvalDerivativeLinearGamma(m,b,g,params.m_x1);

		// apply gamma to endpoints
		params.m_y0 = max(1e-5f, pow(abs(params.m_y0), params.m_gamma));
		params.m_y1 = max(1e-5f, pow(abs(params.m_y1), params.m_gamma));

		params.m_overshootY = pow(max(0, 1.0f + params.m_overshootY), params.m_gamma) - 1.0f;
	}

	dstCurve.m_x0 = params.m_x0;
	dstCurve.m_x1 = params.m_x1;
	dstCurve.m_y0 = params.m_y0;
	dstCurve.m_y1 = params.m_y1;

	// toe section
	{
		CurveSegment toeSegment; ResetCurveSegment(toeSegment);
		toeSegment.m_offsetX = 0;
		toeSegment.m_offsetY = 0.0f;
		toeSegment.m_scaleX = 1.0f;
		toeSegment.m_scaleY = 1.0f;

		SolveAB(toeSegment.m_lnA,toeSegment.m_B,params.m_x0,params.m_y0,toeM);
		dstCurve.m_segments[0] = toeSegment;
	}

	// shoulder section
	{
		// use the simple version that is usually too flat 
		CurveSegment shoulderSegment; ResetCurveSegment(shoulderSegment);

		float x0 = (1.0f + params.m_overshootX) - params.m_x1;
		float y0 = (1.0f + params.m_overshootY) - params.m_y1;

		float lnA = 0.0f;
		float B = 0.0f;
		SolveAB(lnA,B,x0,y0,shoulderM);

		shoulderSegment.m_offsetX = (1.0f + params.m_overshootX);
		shoulderSegment.m_offsetY = (1.0f + params.m_overshootY);

		shoulderSegment.m_scaleX = -1.0f;
		shoulderSegment.m_scaleY = -1.0f;
		shoulderSegment.m_lnA = lnA;
		shoulderSegment.m_B = B;

		dstCurve.m_segments[2] = shoulderSegment;
	}

	// Normalize so that we hit 1.0 at our white point. We wouldn't have do this if we 
	// skipped the overshoot part.
	{
		// evaluate shoulder at the end of the curve
		float scale = CurveSegmentEval(dstCurve.m_segments[2], 1.0f);
		float invScale = 1.0f / scale;

		dstCurve.m_segments[0].m_offsetY *= invScale;
		dstCurve.m_segments[0].m_scaleY *= invScale;

		dstCurve.m_segments[1].m_offsetY *= invScale;
		dstCurve.m_segments[1].m_scaleY *= invScale;

		dstCurve.m_segments[2].m_offsetY *= invScale;
		dstCurve.m_segments[2].m_scaleY *= invScale;
	}
}

#endif
