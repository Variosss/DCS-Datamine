
//aliases for primitives
#define			primitiveColor	    fontBlurColor

struct GS_IN {};

struct GS_OUT
{
    float4 pos: SV_POSITION0;
};

struct GS_COLOR_OUT
{
    float4 pos: SV_POSITION0;
    nointerpolation float4 color: TEXCOORD0;
};

[maxvertexcount(64)]
void gs_cicle(point GS_IN ii[1], inout LineStream<GS_OUT> outputStream)
{
    const float primitiveRadius = params.x;

    //from UnitsLayerCircle::setRadius()
    const uint	minSegmentCount = 4;
    const uint	maxSegmentCount = 63;
    const float PI = 3.1415926535897932384626433832795;
    const uint	segmentCount = max(minSegmentCount, min(maxSegmentCount, primitiveRadius * 2));

    float		deltaAngle = 2 * PI / segmentCount;
    float		angle = 0;

    GS_OUT o;
    for (uint i = 0; i <= segmentCount; ++i, angle += deltaAngle)
    {
        float2 sc;
        sincos(angle, sc.x, sc.y);
        o.pos = float4(position.xy + sc.xy * primitiveRadius, 0, 1);
		o.pos = mul(o.pos, WVP);
        outputStream.Append(o);
    }
	outputStream.RestartStrip();
}

[maxvertexcount(8)]
void gs_lifeBar(point GS_IN ii[1], inout TriangleStream<GS_COLOR_OUT> outputStream)
{
    const float2 size = params.xy;
    const float life = params.z;

    //from UnitsLayer::updateLifeGeometry()    
	const float4 bkgColor = {70.0f / 255.0f, 67.0f / 255.0f, 67.0f / 255.0f, 1.0f};
	const float2 iconCenterPosition = 0;
	const float2 lifebarSize = {size.x - 2, 3};
	const float gap = 1;

	const float x1  = iconCenterPosition.x - lifebarSize.x / 2;
	const float y1  = iconCenterPosition.y - size.y / 2 - gap;
	const float x2  = x1 + lifebarSize.x;
	const float y2  = y1 + lifebarSize.y;
	const float x3  = x1 + lifebarSize.x * life;

    GS_COLOR_OUT o;
    o.color = bkgColor;
    o.pos = mul(float4(position.xy + float2(x1 - 1, y1 - 1), 0, 1), WVP); outputStream.Append(o);
    o.pos = mul(float4(position.xy + float2(x2 + 1, y1 - 1), 0, 1), WVP); outputStream.Append(o);
    o.pos = mul(float4(position.xy + float2(x1 - 1, y2 + 1), 0, 1), WVP); outputStream.Append(o);
    o.pos = mul(float4(position.xy + float2(x2 + 1, y2 + 1), 0, 1), WVP); outputStream.Append(o);
	outputStream.RestartStrip();

    o.color = primitiveColor;
    o.pos = mul(float4(position.xy + float2(x1, y1), 0, 1), WVP); outputStream.Append(o);
    o.pos = mul(float4(position.xy + float2(x3, y1), 0, 1), WVP); outputStream.Append(o);
    o.pos = mul(float4(position.xy + float2(x1, y2), 0, 1), WVP); outputStream.Append(o);    
    o.pos = mul(float4(position.xy + float2(x3, y2), 0, 1), WVP); outputStream.Append(o);
	outputStream.RestartStrip();
}

float4 ps_primitive() : SV_TARGET0
{
	float4 color = correctGammaAndBrightness(primitiveColor);
	color.a *= opacity;
	return color;
}

float4 ps_lifeBar(GS_COLOR_OUT i): SV_TARGET0
{
    float4 color = correctGammaAndBrightness(i.color);
	color.a *= opacity;
	return color;
}
