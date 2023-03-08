#ifndef NOISE_4D
#define NOISE_4D

#include "noise/noiseCommon.hlsl"

float snoise(float4 v)
  {
  const float4  C = float4( 0.138196601125011,  // (5 - sqrt(5))/20  G4
                        0.276393202250021,  // 2 * G4
                        0.414589803375032,  // 3 * G4
                       -0.447213595499958); // -1 + 4 * G4

// First corner
  float4 i  = floor(v + dot(v, float4(F4, F4, F4, F4)) );
  float4 x0 = v -   i + dot(i, C.xxxx);

// Other corners

// Rank sorting originally contributed by Bill Licea-Kane, AMD (formerly ATI)
  float4 i0;
  float3 isX = step( x0.yzw, x0.xxx );
  float3 isYZ = step( x0.zww, x0.yyz );
//  i0.x = dot( isX, float3( 1.0 ) );
  i0.x = isX.x + isX.y + isX.z;
  i0.yzw = 1.0 - isX;
//  i0.y += dot( isYZ.xy, float2( 1.0 ) );
  i0.y += isYZ.x + isYZ.y;
  i0.zw += 1.0 - isYZ.xy;
  i0.z += isYZ.z;
  i0.w += 1.0 - isYZ.z;

  // i0 now contains the unique values 0,1,2,3 in each channel
  float4 i3 = clamp( i0, 0.0, 1.0 );
  float4 i2 = clamp( i0-1.0, 0.0, 1.0 );
  float4 i1 = clamp( i0-2.0, 0.0, 1.0 );

  //  x0 = x0 - 0.0 + 0.0 * C.xxxx
  //  x1 = x0 - i1  + 1.0 * C.xxxx
  //  x2 = x0 - i2  + 2.0 * C.xxxx
  //  x3 = x0 - i3  + 3.0 * C.xxxx
  //  x4 = x0 - 1.0 + 4.0 * C.xxxx
  float4 x1 = x0 - i1 + C.xxxx;
  float4 x2 = x0 - i2 + C.yyyy;
  float4 x3 = x0 - i3 + C.zzzz;
  float4 x4 = x0 + C.wwww;

// Permutations
  i = mod289(i); 
  float j0 = permute( permute( permute( permute(i.w) + i.z) + i.y) + i.x);
  float4 j1 = permute( permute( permute( permute (
             i.w + float4(i1.w, i2.w, i3.w, 1.0 ))
           + i.z + float4(i1.z, i2.z, i3.z, 1.0 ))
           + i.y + float4(i1.y, i2.y, i3.y, 1.0 ))
           + i.x + float4(i1.x, i2.x, i3.x, 1.0 ));

// Gradients: 7x7x6 points over a cube, mapped onto a 4-cross polytope
// 7*7*6 = 294, which is close to the ring size 17*17 = 289.
  float4 ip = float4(1.0/294.0, 1.0/49.0, 1.0/7.0, 0.0) ;

  float4 p0 = grad4(j0,   ip);
  float4 p1 = grad4(j1.x, ip);
  float4 p2 = grad4(j1.y, ip);
  float4 p3 = grad4(j1.z, ip);
  float4 p4 = grad4(j1.w, ip);

// Normalise gradients
  float4 norm = taylorInvSqrt(float4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;
  p4 *= taylorInvSqrt(dot(p4,p4));

// Mix contributions from the five corners
  float3 m0 = max(0.6 - float3(dot(x0,x0), dot(x1,x1), dot(x2,x2)), 0.0);
  float2 m1 = max(0.6 - float2(dot(x3,x3), dot(x4,x4)            ), 0.0);
  m0 = m0 * m0;
  m1 = m1 * m1;
  return 49.0 * ( dot(m0*m0, float3( dot( p0, x0 ), dot( p1, x1 ), dot( p2, x2 )))
               + dot(m1*m1, float2( dot( p3, x3 ), dot( p4, x4 ) ) ) ) ;

  }

// Classic Perlin noise
float cnoise(float4 P)
{
  float4 Pi0 = floor(P); // Integer part for indexing
  float4 Pi1 = Pi0 + 1.0; // Integer part + 1
  Pi0 = mod289(Pi0);
  Pi1 = mod289(Pi1);
  float4 Pf0 = frac(P); // Fractional part for interpolation
  float4 Pf1 = Pf0 - 1.0; // Fractional part - 1.0
  float4 ix = float4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  float4 iy = float4(Pi0.yy, Pi1.yy);
  float4 iz0 = float4(Pi0.zzzz);
  float4 iz1 = float4(Pi1.zzzz);
  float4 iw0 = float4(Pi0.wwww);
  float4 iw1 = float4(Pi1.wwww);

  float4 ixy = permute(permute(ix) + iy);
  float4 ixy0 = permute(ixy + iz0);
  float4 ixy1 = permute(ixy + iz1);
  float4 ixy00 = permute(ixy0 + iw0);
  float4 ixy01 = permute(ixy0 + iw1);
  float4 ixy10 = permute(ixy1 + iw0);
  float4 ixy11 = permute(ixy1 + iw1);

  float4 gx00 = ixy00 * (1.0 / 7.0);
  float4 gy00 = floor(gx00) * (1.0 / 7.0);
  float4 gz00 = floor(gy00) * (1.0 / 6.0);
  gx00 = frac(gx00) - 0.5;
  gy00 = frac(gy00) - 0.5;
  gz00 = frac(gz00) - 0.5;
  float4 gw00 = float4(0.75,0.75,0.75,0.75) - abs(gx00) - abs(gy00) - abs(gz00);
  float4 sw00 = step(gw00, float4(0.0,0.0,0.0,0.0));
  gx00 -= sw00 * (step(0.0, gx00) - 0.5);
  gy00 -= sw00 * (step(0.0, gy00) - 0.5);

  float4 gx01 = ixy01 * (1.0 / 7.0);
  float4 gy01 = floor(gx01) * (1.0 / 7.0);
  float4 gz01 = floor(gy01) * (1.0 / 6.0);
  gx01 = frac(gx01) - 0.5;
  gy01 = frac(gy01) - 0.5;
  gz01 = frac(gz01) - 0.5;
  float4 gw01 = float4(0.75,0.75,0.75,0.75) - abs(gx01) - abs(gy01) - abs(gz01);
  float4 sw01 = step(gw01, float4(0.0,0.0,0.0,0.0));
  gx01 -= sw01 * (step(0.0, gx01) - 0.5);
  gy01 -= sw01 * (step(0.0, gy01) - 0.5);

  float4 gx10 = ixy10 * (1.0 / 7.0);
  float4 gy10 = floor(gx10) * (1.0 / 7.0);
  float4 gz10 = floor(gy10) * (1.0 / 6.0);
  gx10 = frac(gx10) - 0.5;
  gy10 = frac(gy10) - 0.5;
  gz10 = frac(gz10) - 0.5;
  float4 gw10 = float4(0.75,0.75,0.75,0.75) - abs(gx10) - abs(gy10) - abs(gz10);
  float4 sw10 = step(gw10, float4(0.0,0.0,0.0,0.0));
  gx10 -= sw10 * (step(0.0, gx10) - 0.5);
  gy10 -= sw10 * (step(0.0, gy10) - 0.5);

  float4 gx11 = ixy11 * (1.0 / 7.0);
  float4 gy11 = floor(gx11) * (1.0 / 7.0);
  float4 gz11 = floor(gy11) * (1.0 / 6.0);
  gx11 = frac(gx11) - 0.5;
  gy11 = frac(gy11) - 0.5;
  gz11 = frac(gz11) - 0.5;
  float4 gw11 = float4(0.75,0.75,0.75,0.75) - abs(gx11) - abs(gy11) - abs(gz11);
  float4 sw11 = step(gw11, float4(0.0,0.0,0.0,0.0));
  gx11 -= sw11 * (step(0.0, gx11) - 0.5);
  gy11 -= sw11 * (step(0.0, gy11) - 0.5);

  float4 g0000 = float4(gx00.x,gy00.x,gz00.x,gw00.x);
  float4 g1000 = float4(gx00.y,gy00.y,gz00.y,gw00.y);
  float4 g0100 = float4(gx00.z,gy00.z,gz00.z,gw00.z);
  float4 g1100 = float4(gx00.w,gy00.w,gz00.w,gw00.w);
  float4 g0010 = float4(gx10.x,gy10.x,gz10.x,gw10.x);
  float4 g1010 = float4(gx10.y,gy10.y,gz10.y,gw10.y);
  float4 g0110 = float4(gx10.z,gy10.z,gz10.z,gw10.z);
  float4 g1110 = float4(gx10.w,gy10.w,gz10.w,gw10.w);
  float4 g0001 = float4(gx01.x,gy01.x,gz01.x,gw01.x);
  float4 g1001 = float4(gx01.y,gy01.y,gz01.y,gw01.y);
  float4 g0101 = float4(gx01.z,gy01.z,gz01.z,gw01.z);
  float4 g1101 = float4(gx01.w,gy01.w,gz01.w,gw01.w);
  float4 g0011 = float4(gx11.x,gy11.x,gz11.x,gw11.x);
  float4 g1011 = float4(gx11.y,gy11.y,gz11.y,gw11.y);
  float4 g0111 = float4(gx11.z,gy11.z,gz11.z,gw11.z);
  float4 g1111 = float4(gx11.w,gy11.w,gz11.w,gw11.w);

  float4 norm00 = taylorInvSqrt(float4(dot(g0000, g0000), dot(g0100, g0100), dot(g1000, g1000), dot(g1100, g1100)));
  g0000 *= norm00.x;
  g0100 *= norm00.y;
  g1000 *= norm00.z;
  g1100 *= norm00.w;

  float4 norm01 = taylorInvSqrt(float4(dot(g0001, g0001), dot(g0101, g0101), dot(g1001, g1001), dot(g1101, g1101)));
  g0001 *= norm01.x;
  g0101 *= norm01.y;
  g1001 *= norm01.z;
  g1101 *= norm01.w;

  float4 norm10 = taylorInvSqrt(float4(dot(g0010, g0010), dot(g0110, g0110), dot(g1010, g1010), dot(g1110, g1110)));
  g0010 *= norm10.x;
  g0110 *= norm10.y;
  g1010 *= norm10.z;
  g1110 *= norm10.w;

  float4 norm11 = taylorInvSqrt(float4(dot(g0011, g0011), dot(g0111, g0111), dot(g1011, g1011), dot(g1111, g1111)));
  g0011 *= norm11.x;
  g0111 *= norm11.y;
  g1011 *= norm11.z;
  g1111 *= norm11.w;

  float n0000 = dot(g0000, Pf0);
  float n1000 = dot(g1000, float4(Pf1.x, Pf0.yzw));
  float n0100 = dot(g0100, float4(Pf0.x, Pf1.y, Pf0.zw));
  float n1100 = dot(g1100, float4(Pf1.xy, Pf0.zw));
  float n0010 = dot(g0010, float4(Pf0.xy, Pf1.z, Pf0.w));
  float n1010 = dot(g1010, float4(Pf1.x, Pf0.y, Pf1.z, Pf0.w));
  float n0110 = dot(g0110, float4(Pf0.x, Pf1.yz, Pf0.w));
  float n1110 = dot(g1110, float4(Pf1.xyz, Pf0.w));
  float n0001 = dot(g0001, float4(Pf0.xyz, Pf1.w));
  float n1001 = dot(g1001, float4(Pf1.x, Pf0.yz, Pf1.w));
  float n0101 = dot(g0101, float4(Pf0.x, Pf1.y, Pf0.z, Pf1.w));
  float n1101 = dot(g1101, float4(Pf1.xy, Pf0.z, Pf1.w));
  float n0011 = dot(g0011, float4(Pf0.xy, Pf1.zw));
  float n1011 = dot(g1011, float4(Pf1.x, Pf0.y, Pf1.zw));
  float n0111 = dot(g0111, float4(Pf0.x, Pf1.yzw));
  float n1111 = dot(g1111, Pf1);

  float4 fade_xyzw = fade(Pf0);
  float4 n_0w = lerp(float4(n0000, n1000, n0100, n1100), float4(n0001, n1001, n0101, n1101), fade_xyzw.w);
  float4 n_1w = lerp(float4(n0010, n1010, n0110, n1110), float4(n0011, n1011, n0111, n1111), fade_xyzw.w);
  float4 n_zw = lerp(n_0w, n_1w, fade_xyzw.z);
  float2 n_yzw = lerp(n_zw.xy, n_zw.zw, fade_xyzw.y);
  float n_xyzw = lerp(n_yzw.x, n_yzw.y, fade_xyzw.x);
  return 2.2 * n_xyzw;
}

// Classic Perlin noise, periodic version
float pnoise(float4 P, float4 rep)
{
  float4 Pi0 = mod(floor(P), rep); // Integer part modulo rep
  float4 Pi1 = mod(Pi0 + 1.0, rep); // Integer part + 1 mod rep
  Pi0 = mod289(Pi0);
  Pi1 = mod289(Pi1);
  float4 Pf0 = frac(P); // Fractional part for interpolation
  float4 Pf1 = Pf0 - 1.0; // Fractional part - 1.0
  float4 ix = float4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  float4 iy = float4(Pi0.yy, Pi1.yy);
  float4 iz0 = float4(Pi0.zzzz);
  float4 iz1 = float4(Pi1.zzzz);
  float4 iw0 = float4(Pi0.wwww);
  float4 iw1 = float4(Pi1.wwww);

  float4 ixy = permute(permute(ix) + iy);
  float4 ixy0 = permute(ixy + iz0);
  float4 ixy1 = permute(ixy + iz1);
  float4 ixy00 = permute(ixy0 + iw0);
  float4 ixy01 = permute(ixy0 + iw1);
  float4 ixy10 = permute(ixy1 + iw0);
  float4 ixy11 = permute(ixy1 + iw1);

  float4 gx00 = ixy00 * (1.0 / 7.0);
  float4 gy00 = floor(gx00) * (1.0 / 7.0);
  float4 gz00 = floor(gy00) * (1.0 / 6.0);
  gx00 = frac(gx00) - 0.5;
  gy00 = frac(gy00) - 0.5;
  gz00 = frac(gz00) - 0.5;
  float4 gw00 = float4(0.75,0.75,0.75,0.75) - abs(gx00) - abs(gy00) - abs(gz00);
  float4 sw00 = step(gw00, float4(0.0,0.0,0.0,0.0));
  gx00 -= sw00 * (step(0.0, gx00) - 0.5);
  gy00 -= sw00 * (step(0.0, gy00) - 0.5);

  float4 gx01 = ixy01 * (1.0 / 7.0);
  float4 gy01 = floor(gx01) * (1.0 / 7.0);
  float4 gz01 = floor(gy01) * (1.0 / 6.0);
  gx01 = frac(gx01) - 0.5;
  gy01 = frac(gy01) - 0.5;
  gz01 = frac(gz01) - 0.5;
  float4 gw01 = float4(0.75,0.75,0.75,0.75) - abs(gx01) - abs(gy01) - abs(gz01);
  float4 sw01 = step(gw01, float4(0.0,0.0,0.0,0.0));
  gx01 -= sw01 * (step(0.0, gx01) - 0.5);
  gy01 -= sw01 * (step(0.0, gy01) - 0.5);

  float4 gx10 = ixy10 * (1.0 / 7.0);
  float4 gy10 = floor(gx10) * (1.0 / 7.0);
  float4 gz10 = floor(gy10) * (1.0 / 6.0);
  gx10 = frac(gx10) - 0.5;
  gy10 = frac(gy10) - 0.5;
  gz10 = frac(gz10) - 0.5;
  float4 gw10 = float4(0.75,0.75,0.75,0.75) - abs(gx10) - abs(gy10) - abs(gz10);
  float4 sw10 = step(gw10, float4(0.0,0.0,0.0,0.0));
  gx10 -= sw10 * (step(0.0, gx10) - 0.5);
  gy10 -= sw10 * (step(0.0, gy10) - 0.5);

  float4 gx11 = ixy11 * (1.0 / 7.0);
  float4 gy11 = floor(gx11) * (1.0 / 7.0);
  float4 gz11 = floor(gy11) * (1.0 / 6.0);
  gx11 = frac(gx11) - 0.5;
  gy11 = frac(gy11) - 0.5;
  gz11 = frac(gz11) - 0.5;
  float4 gw11 = float4(0.75,0.75,0.75,0.75) - abs(gx11) - abs(gy11) - abs(gz11);
  float4 sw11 = step(gw11, float4(0.0,0.0,0.0,0.0));
  gx11 -= sw11 * (step(0.0, gx11) - 0.5);
  gy11 -= sw11 * (step(0.0, gy11) - 0.5);

  float4 g0000 = float4(gx00.x,gy00.x,gz00.x,gw00.x);
  float4 g1000 = float4(gx00.y,gy00.y,gz00.y,gw00.y);
  float4 g0100 = float4(gx00.z,gy00.z,gz00.z,gw00.z);
  float4 g1100 = float4(gx00.w,gy00.w,gz00.w,gw00.w);
  float4 g0010 = float4(gx10.x,gy10.x,gz10.x,gw10.x);
  float4 g1010 = float4(gx10.y,gy10.y,gz10.y,gw10.y);
  float4 g0110 = float4(gx10.z,gy10.z,gz10.z,gw10.z);
  float4 g1110 = float4(gx10.w,gy10.w,gz10.w,gw10.w);
  float4 g0001 = float4(gx01.x,gy01.x,gz01.x,gw01.x);
  float4 g1001 = float4(gx01.y,gy01.y,gz01.y,gw01.y);
  float4 g0101 = float4(gx01.z,gy01.z,gz01.z,gw01.z);
  float4 g1101 = float4(gx01.w,gy01.w,gz01.w,gw01.w);
  float4 g0011 = float4(gx11.x,gy11.x,gz11.x,gw11.x);
  float4 g1011 = float4(gx11.y,gy11.y,gz11.y,gw11.y);
  float4 g0111 = float4(gx11.z,gy11.z,gz11.z,gw11.z);
  float4 g1111 = float4(gx11.w,gy11.w,gz11.w,gw11.w);

  float4 norm00 = taylorInvSqrt(float4(dot(g0000, g0000), dot(g0100, g0100), dot(g1000, g1000), dot(g1100, g1100)));
  g0000 *= norm00.x;
  g0100 *= norm00.y;
  g1000 *= norm00.z;
  g1100 *= norm00.w;

  float4 norm01 = taylorInvSqrt(float4(dot(g0001, g0001), dot(g0101, g0101), dot(g1001, g1001), dot(g1101, g1101)));
  g0001 *= norm01.x;
  g0101 *= norm01.y;
  g1001 *= norm01.z;
  g1101 *= norm01.w;

  float4 norm10 = taylorInvSqrt(float4(dot(g0010, g0010), dot(g0110, g0110), dot(g1010, g1010), dot(g1110, g1110)));
  g0010 *= norm10.x;
  g0110 *= norm10.y;
  g1010 *= norm10.z;
  g1110 *= norm10.w;

  float4 norm11 = taylorInvSqrt(float4(dot(g0011, g0011), dot(g0111, g0111), dot(g1011, g1011), dot(g1111, g1111)));
  g0011 *= norm11.x;
  g0111 *= norm11.y;
  g1011 *= norm11.z;
  g1111 *= norm11.w;

  float n0000 = dot(g0000, Pf0);
  float n1000 = dot(g1000, float4(Pf1.x, Pf0.yzw));
  float n0100 = dot(g0100, float4(Pf0.x, Pf1.y, Pf0.zw));
  float n1100 = dot(g1100, float4(Pf1.xy, Pf0.zw));
  float n0010 = dot(g0010, float4(Pf0.xy, Pf1.z, Pf0.w));
  float n1010 = dot(g1010, float4(Pf1.x, Pf0.y, Pf1.z, Pf0.w));
  float n0110 = dot(g0110, float4(Pf0.x, Pf1.yz, Pf0.w));
  float n1110 = dot(g1110, float4(Pf1.xyz, Pf0.w));
  float n0001 = dot(g0001, float4(Pf0.xyz, Pf1.w));
  float n1001 = dot(g1001, float4(Pf1.x, Pf0.yz, Pf1.w));
  float n0101 = dot(g0101, float4(Pf0.x, Pf1.y, Pf0.z, Pf1.w));
  float n1101 = dot(g1101, float4(Pf1.xy, Pf0.z, Pf1.w));
  float n0011 = dot(g0011, float4(Pf0.xy, Pf1.zw));
  float n1011 = dot(g1011, float4(Pf1.x, Pf0.y, Pf1.zw));
  float n0111 = dot(g0111, float4(Pf0.x, Pf1.yzw));
  float n1111 = dot(g1111, Pf1);

  float4 fade_xyzw = fade(Pf0);
  float4 n_0w = lerp(float4(n0000, n1000, n0100, n1100), float4(n0001, n1001, n0101, n1101), fade_xyzw.w);
  float4 n_1w = lerp(float4(n0010, n1010, n0110, n1110), float4(n0011, n1011, n0111, n1111), fade_xyzw.w);
  float4 n_zw = lerp(n_0w, n_1w, fade_xyzw.z);
  float2 n_yzw = lerp(n_zw.xy, n_zw.zw, fade_xyzw.y);
  float n_xyzw = lerp(n_yzw.x, n_yzw.y, fade_xyzw.x);
  return 2.2 * n_xyzw;
}

#endif
