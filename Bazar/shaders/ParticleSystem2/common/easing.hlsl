#ifndef EASING
#define EASING


float ease_exp(float x, float mul=1.0, float add=0.0){ return exp(x)*mul+add;}
float2 ease_exp(float x, float2 mul=1.0, float2 add=0.0){ return exp(x)*mul+add;}
float3 ease_exp(float x, float3 mul=1.0, float3 add=0.0){ return exp(x)*mul+add;}
float4 ease_exp(float x, float4 mul=1.0, float4 add=0.0){ return exp(x)*mul+add;}

float ease_quad(float x, float mul=1.0, float add=0.0){ return (x*x)*mul+add; }
float2 ease_quad(float x, float2 mul=1.0, float2 add=0.0){ return (x*x)*mul+add; }
float3 ease_quad(float x, float3 mul=1.0, float3 add=0.0){ return (x*x)*mul+add; }
float4 ease_quad(float x, float4 mul=1.0, float4 add=0.0){ return (x*x)*mul+add; }

float lerp_exp(float1 v0, float1 v1, float x){	return lerp(v0, v1, exp(x));}
float2 lerp_exp(float2 v0, float2 v1, float x){	return lerp(v0, v1, exp(x));}
float3 lerp_exp(float3 v0, float3 v1, float x){	return lerp(v0, v1, exp(x));}
float4 lerp_exp(float4 v0, float4 v1, float x){	return lerp(v0, v1, exp(x));}

float lerp_quad(float1 v0, float1 v1, float x){return lerp(v0, v1, x*x);}
float2 lerp_quad(float2 v0, float2 v1, float x){return lerp(v0, v1, x*x);}
float3 lerp_quad(float3 v0, float3 v1, float x){return lerp(v0, v1, x*x);}
float4 lerp_quad(float4 v0, float4 v1, float x){return lerp(v0, v1, x*x);}

float lerp_pow(float1 v0, float1 v1, float x, uniform float e){return lerp(v0, v1, pow(x, e));}
float2 lerp_pow(float2 v0, float2 v1, float x, uniform float e){return lerp(v0, v1, pow(x, e));}
float3 lerp_pow(float3 v0, float3 v1, float x, uniform float e){return lerp(v0, v1, pow(x, e));}
float4 lerp_pow(float4 v0, float4 v1, float x, uniform float e){return lerp(v0, v1, pow(x, e));}


//float4 lerp_cubic(float4 v0, float4 v1, float x) { return lerp(v0, v1, ease_quad(x)); }


#endif