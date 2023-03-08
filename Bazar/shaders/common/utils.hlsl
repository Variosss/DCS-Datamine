#ifndef _COMMON_UTILS_HLSL_
#define _COMMON_UTILS_HLSL_

float3 fromRedToGreen( float interpolant )
{
	if( interpolant < 0.5 )
	{
		return float3(1.0, 2.0 * interpolant, 0.0); 
	}
	else
	{
		return float3(2.0 - 2.0 * interpolant, 1.0, 0.0 );
	}
}

float3 fromGreenToBlue( float interpolant )
{
	if( interpolant < 0.5 )
	{
		return float3(0.0, 1.0, 2.0 * interpolant); 
	}
	else
	{
		return float3(0.0, 2.0 - 2.0 * interpolant, 1.0 );
	}
}

//heat mapping, 5 colors
float3 heat5( float interpolant )
{
	float invertedInterpolant = interpolant;
	if( invertedInterpolant < 0.5 )
	{
		float remappedFirstHalf = 1.0 - 2.0 * invertedInterpolant;
		return fromGreenToBlue( remappedFirstHalf );
	}
	else
	{
	 	float remappedSecondHalf = 2.0 - 2.0 * invertedInterpolant; 
		return fromRedToGreen( remappedSecondHalf );
	}
}
//heat mapping, 5 colors + b/w
float3 heat7( float interpolant )
{
	if( interpolant < 1.0 / 6.0 )
	{
		float firstSegmentInterpolant = 6.0 * interpolant;
		return ( 1.0 - firstSegmentInterpolant ) * float3(0.0, 0.0, 0.0) + firstSegmentInterpolant * float3(0.0, 0.0, 1.0);
	}
	else if( interpolant < 5.0 / 6.0 )
	{
		float midInterpolant = 0.25 * ( 6.0 * interpolant - 1.0 );
		return heat5( midInterpolant );
	}
	else
	{
		float lastSegmentInterpolant = 6.0 * interpolant - 5.0; 
		return ( 1.0 - lastSegmentInterpolant ) * float3(1.0, 0.0, 0.0) + lastSegmentInterpolant * float3(1.0, 1.0, 1.0);
	}
}

#endif
