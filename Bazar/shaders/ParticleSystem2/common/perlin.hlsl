#ifndef _OPS_PERLIN_
#define _OPS_PERLIN_

//using:
//float createPerlinNoise1D(float x)
//float createPerlinNoise2D(float x, float y)

float cosInterpolation( float x, float y, float fractional ) 
{
   float ft = 3.141592f * fractional;
   float f = ( 1.0f - cos( ft ) ) * 0.5f;

   return x * ( 1.0f - f ) + y * f;
}

float noise2D(float2 xy)
{
    float2 noise = (frac(sin(dot(xy ,float2(12.9898,78.233)*2.0)) * 43758.5453));
    return abs(noise.x + noise.y) * 0.5;
}

float noise1D(float x)
{
    //float2 noise = (frac(sin(dot(float2(x,0) ,float2(12.9898,78.233)*2.0)) * 43758.5453));
	float noise = frac(sin(x*78.233*2.0) * 43758.5453);
    //return abs(noise.x + noise.y) * 0.5;
	return noise;
}


float smoothNoise1D(float integer_x) 
{
   return noise1D(integer_x)/2 + noise1D(integer_x-1)/4 + noise1D(integer_x+1)/4;
}

float smoothNoise2D(float integer_x, float integer_y) 
{
   float corners = ( noise2D( float2(integer_x - 1, integer_y - 1) ) + noise2D( float2(integer_x + 1, integer_y + 1 )) + noise2D( float2(integer_x + 1, integer_y - 1 )) + noise2D( float2(integer_x - 1, integer_y + 1 )) ) / 16.0f;
   float sides = ( noise2D( float2(integer_x, integer_y - 1 )) + noise2D( float2(integer_x, integer_y + 1 )) + noise2D( float2(integer_x + 1, integer_y )) + noise2D( float2(integer_x - 1, integer_y )) ) / 8.0f;
   float center = noise2D( float2(integer_x, integer_y )) / 4.0f;

   return corners + sides + center;
}

float interpolatedNoise1D(float x) 
{
   float integer_x = x - frac(x), fractional_x = frac(x);

   float v1 = smoothNoise1D(integer_x);
   float v2 = smoothNoise1D(integer_x + 1);  

   return cosInterpolation( v1, v2, fractional_x );
}

float interpolatedNoise2D(float x, float y) 
{
   float integer_x = x - frac(x), fractional_x = frac(x);
   float integer_y = y - frac(y), fractional_y = frac(y);

   float v1 = smoothNoise2D(integer_x, integer_y);
   float v2 = smoothNoise2D(integer_x + 1, integer_y);
   float v3 = smoothNoise2D(integer_x, integer_y + 1);
   float v4 = smoothNoise2D(integer_x + 1, integer_y + 1);

   v1 = cosInterpolation(v1, v2, fractional_x);
   v2 = cosInterpolation(v3, v4, fractional_x);

   return cosInterpolation(v1, v2, fractional_y );
}



// одномерный 
float createPerlinNoise1D(float x) 
{
    float result = 0.0f, amplitude = 0.0f, frequency = 0.0f;

    for ( int i = 0; i < 3; ++i ) {
       frequency += 2;
       amplitude += 0.2;

       result += interpolatedNoise1D( x * frequency) * amplitude;
    }
    return result;
}

// двухмерный
float createPerlinNoise2D(float x, float y) 
{
    float result = 0.0f, amplitude = 0.0f, frequency = 0.0f;

    for ( int i = 0; i < 4; ++i ) {
       frequency += 2;
       amplitude += 0.1;

       result += interpolatedNoise2D( x * frequency, y * frequency ) * amplitude;
    }
    return result;
}



#endif