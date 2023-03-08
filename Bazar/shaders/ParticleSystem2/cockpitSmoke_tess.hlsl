
struct HS_CONST_OUTPUT
{
	float edges[4] : SV_TessFactor;
	float inside[2]: SV_InsideTessFactor;
};

VS_OUTPUT VS_tess(float4 params	: TEXCOORD0, float3 params2	: TEXCOORD1)
{
	#define DIST		params.x//относительное расстояние от оси эмиттера
	#define PERLIN		params.y
	#define RAND		params.z //рандомное число для партикла
	#define BIRTH_TIME	params.w //время жизни партикла в секундах
	#define lifetime	params2.x
	#define corner		params2.yz

	VS_OUTPUT o;
	
	float _sin, _cos;
	const float AGE = time/2.0 - BIRTH_TIME;
	const float nAge = AGE / lifetime;
		
	float angle = RAND*PI2;
	float scale = scaleBase;
	
	float2 dir, sc;
	sincos(angle, dir.x, dir.y);//направление на партикл от оси эмиттера в плоскости XZ
	
	float2 d = 2*dir;
	float2 f = emitterPos;
	
	float a = 4;//  = dot(d,d), ибо dir единичный
	float b = dot(f,d) * 2;
	float c = dot(f,f) - 0.25;//0.25 - квадрат радиуса 

	float disc = sqrt(b*b-4*a*c);
	float2 t = float2(-b - disc, -b + disc) / (2*a);
	// float2 p0 = emitterPos + t[0]*d;
	// float2 p1 = emitterPos + t[1]*d;	
	float2 p = emitterPos + max(t[0], t[1])*d;//позиция на окружности
	float2 rotCenter = (p+emitterPos)*0.5;
	float radius = length(emitterPos + dir*DIST-rotCenter) * 0.5;// length(max(t[0], t[1])*d) * 0.5;

	sincos(AGE*PI2/(0.2+0.8*radius)*0.05, sc[0], sc[1]);//циркуляция партикла
	
	o.pos = 1;//итоговая позиция
	o.pos.xz = rotCenter + dir*sc[0]*radius;
	o.pos.y = sc[1]*radius;
	o.pos = mul(o.pos, World);
	o.pos = mul(o.pos, gView);
	
	//particle tex coord
	int phase = (AGE + angle)*40;
	const float2 uvScaleFactor = 1.0 / float2(16, 8);
	float2 uvOffset = float2((float)(phase & 15), (float)((phase>>4) & 7) );
	o.params.xy = (corner + 0.5 + uvOffset) * uvScaleFactor;
	
	//add particle corner in view space
	float2x2 M = {dir.y, dir.x, -dir.x,  dir.y};
	corner = mul(corner, M);
	corner *= scale;
	o.pos.xy += corner;

	o.params.z = max(0.1, 0.666*(0.5 + dot(sunDir,axisY)));
	o.params.w = 1;

	return o;
}

HS_CONST_OUTPUT hsConstant( InputPatch<VS_OUTPUT, 4> ip, uint pid : SV_PrimitiveID )
{
	HS_CONST_OUTPUT o; 
	float factor = 6.0;
	o.edges[0] = o.edges[1] = o.edges[2] = o.edges[3] = factor;
	o.inside[0] = o.inside[1] = factor;	
	return o;
}

[domain("quad")]
[partitioning("integer")]
[outputcontrolpoints(4)]
[outputtopology("triangle_cw")]
[patchconstantfunc("hsConstant")]
VS_OUTPUT HS( InputPatch<VS_OUTPUT, 4> ip, uint cpid : SV_OutputControlPointID)
{
	VS_OUTPUT o;
	o = ip[cpid];
	return o;
}

[domain("quad")]
PS_INPUT DS( HS_CONST_OUTPUT input, float2 UV : SV_DomainLocation, const OutputPatch<VS_OUTPUT, 4> patch )
{
	PS_INPUT o;
	float3 topMidpoint = lerp(patch[0].pos.xyz, patch[1].pos.xyz, UV.x);
	float3 bottomMidpoint = lerp(patch[2].pos.xyz, patch[3].pos.xyz, UV.x);

	o.pos = float4(lerp(topMidpoint, bottomMidpoint, UV.y), patch[0].pos.w);
	float4 wPos = mul(o.pos, gViewInv);
	o.pos = mul(o.pos, gProj);
	
	// o.projPos = o.pos;
	// o.projPos.xyz /= o.projPos.w;
	// o.projPos.xy = float2(o.projPos.x, -o.projPos.y)*0.5+0.5;
	
	float2 tcTop = lerp(patch[0].params.xy, patch[1].params.xy, UV.x);
	float2 tcBottom = lerp(patch[2].params.xy, patch[3].params.xy, UV.x);
	o.params.xy = lerp(tcTop, tcBottom, UV.y);
	o.params.z = patch[0].pos.z;//глубина для софт партиклов
	o.params.w = SampleShadowCascadeVertex(wPos.xyz, o.pos.z/o.pos.w);//shadows

	return o;
}



