

matrix WVP;
//float4 Color;
#define PIXELWIDTH 60
float PixelArray[PIXELWIDTH * PIXELWIDTH];


Texture2D RadarPixels;
Texture2D Arm;

Texture2D Background;
Texture2D Returns;

Texture2D ExtraTechTexture;

float t; //ED Time
float ResScale;
float MaxAngle;
float SweepAngle;
float SweepDir;
float MaxDistance;
bool DrawSweepArm;
bool BScope;
bool DrawGrid;
float MaxRangeMarkerDistance; // Max range marker for Rb04
float MinRangeMarkerDistance; // Min range marker for Rb04 + sight for radar bombing
float BScopeDistanceMarker; // in percentage, 1.0 = top of screen
float Brightness;
float ColorShift;

float AngleOffset = 0; // 0.34906585;

float Crossx;
float Crossy;
float BPx;
float BPy;
float BPRadius;
float x1;
float y1;
float x2;
float y2;

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



//Extra effect
float spiral(float2 m) {
	float r = length(m);
	float a = atan2(m.x, m.y);
	float v = sin(100.*(sqrt(r) - 0.02*a - .32*t));
	return clamp(v, 0., 1.);
}


float4 ps_Extra(VS_OUT input) : SV_TARGET0
{
	if (BScope)
	{
		float2 m = float2(0.5, .5);

		float v = spiral(m - input.TexCoords);

		float3 col = float3(v, v*sin(t*1.5), v*sin(t / 2.0));

		return float4(col, 1.);
	}
	else
	{
		float4 temp = ExtraTechTexture.Sample(mySampler, input.TexCoords);
			temp.w = 1;
		return temp;
	}

}




float Point2LineSegDistance(float2 a, float2 b, float2 p)
{
	float2 n = b - a;
	float2 pa = a - p;

	float c = dot(n, pa);

	//Clamp 

	// Closest point is a
	if (c > 0.0f)
		return dot(pa, pa);

	float2 bp = p - b;

	// Closest point is b
	if (dot(n, bp) > 0.0f)
		return dot(bp, bp);

	// Closest point is between a and b
	float2 e = pa - n * (c / dot(n, n));

	return sqrt(dot(e, e));
}




float4 RadarData(VS_OUT input)
{
	float4 retval = Returns.Sample(mySampler, input.TexCoords);
	float4 backval = Background.Sample(mySampler, input.TexCoords);


	//Scale
	float2 TexCoords = input.TexCoords - float2(0.5,0.5); //center around 0,0
	TexCoords = TexCoords / 0.7; //Scale to 90%
	TexCoords = TexCoords + float2(0.5, 0.5); //move almost back, but a little bit offest up

	//Translate pixel coordinate to correct mapping in texture
	float xoffset = TexCoords.x - 0.5;
	float yoffset = 1 - TexCoords.y;
	float angleorig = atan2(xoffset, yoffset);
	float angle = angleorig * 0.94615384615; //for some reason viggen seems to draw 123 as 130, hence the correction factor...


	//Make some stuff black
	if ((TexCoords.x > 0.96) || (TexCoords.x < 0.04)
		|| (TexCoords.y > 1) || (TexCoords.y < 0))
		return retval;// float4(0, 0, 0, 0);



	float distance = sqrt(xoffset*xoffset + yoffset*yoffset);

	
	if ((abs(angle) > MaxAngle) || (distance > 1))
		return retval;// float4(0, 0, 0, 0);

	float2 coords = float2((0.5 + angle / (MaxAngle * 2))*ResScale, distance);


	//Blend between textures based on return strength
	float4 strength = RadarPixels.Sample(mySampler, coords); //Only use alpha

	//Grid
	if (DrawGrid)
	{
		if (distance > 0)
		{
			float adiff = asin(0.005 / (2 * distance)) * 2;
			float Afix = abs(angle - AngleOffset);
			
			if ((Afix > 0.523598776 - adiff) && (Afix < 0.523598776 + adiff)
				|| (Afix > 0 - adiff) && (Afix < 0 + adiff)
				)
			{
				float a1 = Afix;
				float a2 = abs((Afix - 0.523598776));
				float fact = (1 - min(a1, a2) / adiff);

				strength.w = fact * 0.8 + (1 - fact) * strength.w;
			}

			const float markerwidth = 0.2617993877;//(15.0 / 180.0)*M_PI;
			const float disdiff = 0.005;
			if (((distance > 10000 / MaxDistance - disdiff) && (distance < 10000 / MaxDistance + disdiff))
				|| ((distance > 20000 / MaxDistance - disdiff) && (distance < 20000 / MaxDistance + disdiff))
				|| ((distance > 40000 / MaxDistance - disdiff) && (distance < 40000 / MaxDistance + disdiff))
				|| ((distance > 80000 / MaxDistance - disdiff) && (distance < 80000 / MaxDistance + disdiff))
				|| ((Afix < markerwidth && Afix > -markerwidth && MinRangeMarkerDistance > 0)
					&& (distance > (MinRangeMarkerDistance / MaxDistance) - disdiff)
					&& (distance < (MinRangeMarkerDistance / MaxDistance) + disdiff)) 
				|| ((Afix < markerwidth && Afix > -markerwidth && MaxRangeMarkerDistance > 0)
						&& (distance > (MaxRangeMarkerDistance / MaxDistance) - disdiff)
						&& (distance < (MaxRangeMarkerDistance / MaxDistance) + disdiff)))
			{
				float d1 = abs(distance - 10000 / MaxDistance);
				float d2 = abs(distance - 20000 / MaxDistance);
				float d3 = abs(distance - 40000 / MaxDistance);
				float d4 = abs(distance - 80000 / MaxDistance);
				float d5 = abs(distance - MinRangeMarkerDistance / MaxDistance);
				float d6 = abs(distance - MaxRangeMarkerDistance / MaxDistance);
				float d = min(min(min(d1, d2), min(d3, d4)), min(d5, d6));
				float fact = (1 - d / disdiff);
				strength.w = fact * 0.8 + (1 - fact) * strength.w;
			}

		}
	}

	float alpha = strength.w;

	//
	//Symbology
	//
	float augx = distance * (sin(angle) - sin(angleorig));
	float augy = distance * (cos(angle) - cos(angleorig));
	float xm = (xoffset + augx)*MaxDistance;
	float ym = (yoffset + augy)*MaxDistance;

	//BP Circle
	const float percentthickness = 0.004;
	float thickness = percentthickness*MaxDistance;
	float diffx = (BPx - xm);
	float diffy = (BPy - ym);
	float tempdist = sqrt(diffx * diffx + diffy *diffy);

	if ((tempdist > BPRadius - thickness) && (tempdist <  BPRadius + thickness))
		return float4(0.388, 0.769, 0.541, 0.745)*1.35;

	//Cross
	float crossangle = atan2(Crossx, Crossy);
	float crossdistance = sqrt(Crossx*Crossx + Crossy*Crossy) / MaxDistance;
	float adiff = asin(0.004 / (2 * distance)) * 2;
	float adiffw = asin(0.1 / (2 * distance)) * 2;

	if ((angle < crossangle + adiffw) && (angle > crossangle - adiffw)
		&& (distance > crossdistance - percentthickness) && (distance < crossdistance + percentthickness)
		||
		(angle < crossangle + adiff) && (angle > crossangle - adiff)
		&& (distance > crossdistance - 0.1) && (distance < crossdistance + 0.1)
		)
		return float4(0.388, 0.769, 0.541, 0.745)*1.35;

	// Rb04 min distance or radar bombing indication (only a range marker)
	//const float markerwidth = 0.2617993877;//(15.0 / 180.0)*M_PI;
	//if ((angle < markerwidth && angle > -markerwidth)
	//	&& (distance > (3000/MaxDistance) - 0.01)
	//	&& (distance < (3000 / MaxDistance) + 0.01))
	//{
	//	return float4(0.388, 0.769, 0.541, 0.745)*1.35;
	//}

	//Line
	float dist2line = Point2LineSegDistance(float2(x1, y1), float2(x2, y2), float2(xm, ym));
	if (dist2line < thickness)
		return float4(0.388, 0.769, 0.541, 0.745)*1.35;

	//
	//Blend
	//
	float invalpha = 1 - alpha;


	float4 result = float4(alpha * retval.x + invalpha * backval.x, alpha * retval.y + invalpha * backval.y, alpha * retval.z + invalpha * backval.z, 1); //Alpha blend

	// Night filter
	//output.r = (ColorShift * output.g) + ((1-ColorShift)*output.r);
	result.g *= ColorShift;
	result.b *= ColorShift;

	//Brighten up if swooped
	float brightenfactor = 0;
	if (DrawSweepArm)
	{
		const float brightfade = 0.383972435;
		float adiff = angle - SweepAngle / 0.94615384615;
		if ((adiff < brightfade) && (adiff > 0) && (SweepDir < 0))
			brightenfactor = 1 - (adiff) / brightfade;

		if ((adiff > -brightfade) && (adiff < 0) && (SweepDir > 0))
			brightenfactor = 1 - (adiff) / -brightfade;
	}



	return result * (1 + brightenfactor);

}

float4 BScopeRadar(VS_OUT input)
{
	float4 retval = Returns.Sample(mySampler, input.TexCoords);
	float4 backval = Background.Sample(mySampler, input.TexCoords);

	// Night filter
	//output.r = (ColorShift * output.g) + ((1-ColorShift)*output.r);
	retval.g *= ColorShift;
	retval.b *= ColorShift;

	backval.g *= ColorShift;
	backval.b *= ColorShift;

	//Scale
	float2 TexCoords = input.TexCoords - float2(0.5, 0.5); //center around 0,0
	TexCoords = TexCoords / 0.63; //Scale to 63%
	
	//Sweep angle offset, B scope only sows +-20 deg
	TexCoords.x = TexCoords.x * 0.34906585 / MaxAngle;

	//Limit shit for 20 deg
	if (abs(TexCoords.x) > 0.174532925/MaxAngle) // 20/30 * 0.5
		return retval;// float4(0, 0, 0, 0);

	//move almost back, but a little bit offest up
	TexCoords = TexCoords + float2(0.5, 0.5); 


	//Offset according to 
//	(0.5 + angle / (MaxAngle * 2))*ResScale

	//Limits
	if ((TexCoords.x > 1) || (TexCoords.x < 0)
		|| (TexCoords.y > 1) || (TexCoords.y < 0))
		return retval;// float4(0, 0, 0, 0);


	float4 strength = RadarPixels.Sample(mySampler, float2(TexCoords.x*ResScale, 1 - TexCoords.y)); //Only use alpha

	//Translate pixel coordinate to correct mapping in texture
	float xoffset = TexCoords.x - 0.5;
	float yoffset = 1 - TexCoords.y;
	float angleorig = atan2(xoffset, yoffset);
	float angle = angleorig * 0.94615384615; //for some reason viggen seems to draw 123 as 130, hence the correction factor...


	//Make some stuff black
	if ((TexCoords.x > 0.96) || (TexCoords.x < 0.04)
		|| (TexCoords.y > 1) || (TexCoords.y < 0))
		return retval;// float4(0, 0, 0, 0);



	float distance = yoffset;//sqrt(xoffset*xoffset + yoffset * yoffset);
	// TODO Should show bombing indication (vertical line extending whole screen in the middle and hor line extending whole screen at 3km)
	// Rb04 also show vertical line (which is wind compensated but we are not going to do that) and the min max lines should also be displayed
	if (MinRangeMarkerDistance > 0)
	{
		float adiff = asin(0.005 / (2 * distance)) * 2;
		float Afix = abs(angle - AngleOffset);

		// Middle line
		if ((Afix > 0 - adiff) && (Afix < 0 + adiff)
			)
		{
			float a1 = Afix;
			float a2 = abs((Afix - 0.523598776));
			float fact = (1 - min(a1, a2) / adiff);

			strength.w = fact * 0.8 + (1 - fact) * strength.w;
		}

		// Distance lines
		const float disdiff = 0.005;
		if (((BScopeDistanceMarker > 0)
				&& (distance > BScopeDistanceMarker - disdiff)
				&& (distance < BScopeDistanceMarker + disdiff)))
		{
			float d = abs(distance - BScopeDistanceMarker);
			float fact = (1 - d / disdiff);
			strength.w = fact * 0.8 + (1 - fact) * strength.w;
		}

	}
	float alpha = strength.w;
	float invalpha = 1 - strength.w;

	float4 output = float4(alpha * retval.x + invalpha * backval.x, alpha * retval.y + invalpha * backval.y, alpha * retval.z + invalpha * backval.z, 1); //Alpha blend

	//Brightness FIXED: Brightness setting doesnt work in B-Scope mode.
	output *= Brightness;	

	return output;
}


float2 rotate_point(float2 pivot, float angle, float2 uv)
{
	float s = sin(angle);
	float c = cos(angle);

	// translate point back to origin:
	uv.x -= pivot.x;
	uv.y -= pivot.y;

	// rotate point
	float xnew = uv.x * c - uv.y * s;
	float ynew = uv.x * s + uv.y * c;

	// translate point back:
	uv.x = xnew + pivot.x;
	uv.y = ynew + pivot.y;

	return uv;
}


float4 SweepArm(VS_OUT input)
{
	if (SweepDir < 1) //Inverse direction?
	{
		input.TexCoords.x = 1 - input.TexCoords.x;
		
	}
	float CurrSweepAngle = SweepDir*SweepAngle;

	//Sweep arm
	float4 ArmPix = Arm.Sample(mySampler, rotate_point(float2(0.5, 0.854), -1 * CurrSweepAngle / 0.94615384615, input.TexCoords)); //factor is for 123 to 130 deg

	return ArmPix;
}


//Main radar effect
float4 ps_Radar(VS_OUT input) : SV_TARGET0
{
	if (BScope)
	{

		return BScopeRadar(input);
	}
	else
	{
		float4 A = float4(0, 0, 0, 0);
			if (DrawSweepArm)
				A = SweepArm(input);

		float4 R = RadarData(input);


		float4 output = float4(min(A.x + R.x, 1), min(A.y + R.y, 1), min(A.z + R.z, 1), min(A.w + R.w, 1));  //additive blend

		//Brightness
		output *= Brightness;

		// Night filter
		//output.r = (ColorShift * output.g) + ((1-ColorShift)*output.r);
		output.g *= ColorShift;
		output.b *=  ColorShift;

		return output;

	}
}





technique10 Radar
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetPixelShader(CompileShader(ps_4_0, ps_Radar()));

	}
}

technique10 Extra
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetPixelShader(CompileShader(ps_4_0, ps_Extra()));

	}
}