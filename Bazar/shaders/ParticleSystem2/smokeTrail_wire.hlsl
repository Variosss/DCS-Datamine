
struct VS_WIRE_OUTPUT
{
	float4 params1: TEXCOORD0; 
	float4 params2: TEXCOORD1;
	float4 params3: TEXCOORD2; 
	float4 params4: TEXCOORD3;
	float4 params5: TEXCOORD4;
	float3 pos	  : TEXCOORD5;
	float nAge	  : TEXCOORD6;
};

struct HS_PATCH_OUTPUT
{
	float edges[2] : SV_TessFactor;
	float3 p1	: TEXCOORD5;
	float3 p2	: TEXCOORD6;
};

struct PS_WIRE_INPUT // для рисования линий и квадратиков в узлах сплайна
{
	float4 pos	 : SV_POSITION;
	float4 color : COLOR0;
};

//считаем итоговую мировую позицию и относительное время жизни, остальные параметры просто передаем дальше
VS_WIRE_OUTPUT VS_wire(VS_INPUT i, uniform bool bNozzle = true)
{	
	float3 PARTICLE_POS		= i.params1.xyz;
	float  BIRTH_TIME		= i.params1.w;
	float3 NOZZLE_SPEED		= i.params2.xyz;
	float3 SPEED			= i.params3.xyz;
	float  LIFETIME			= i.params2.w;
	float3 TANGENT			= i.params3.xyz; //w - свободен
	// #define DISSIPATION_DIR_ENC = i.params4.xy; // encoded
	float2 WIND				= i.params4.zw;
	// #define PARTICLE_COLOR		= i.params5.rgb;
	
	float3	speedResult;
	if(bNozzle)
		speedResult = normalize(NOZZLE_SPEED) * (length(NOZZLE_SPEED) + length(TANGENT));
	else
		speedResult = TANGENT;

	const float		speedValue = length(speedResult);
	const float3	speedDir = speedResult/speedValue;
	const float		AGE = (effectTime - BIRTH_TIME);
	
	float3 posOffset = 0;
#ifndef DEBUG_NO_JITTER2
	//из основного DS шейдера
	if(bNozzle)	{
		posOffset += speedDir * translationWithResistance(speedValue, AGE) * lerp(0.5, 0.1, min(1,length(TANGENT)/1000))*1.5*mad(scaleBase*0.333, 0.8, 0.2);		
	} else {
		posOffset += normalize(TANGENT) * translationWithResistanceSimple(speedValue, AGE)*0.5;
	}
#endif

	VS_WIRE_OUTPUT o;
	o.nAge = min(1, AGE / LIFETIME);
	o.pos = PARTICLE_POS + float3(WIND.x,0,WIND.y)*AGE + posOffset - worldOffset;
	o.params1 = i.params1;
	o.params2 = mul(float4(o.pos,1), View);
	o.params3 = float4(normalize(NOZZLE_SPEED), speedValue); // tangent + speedValue
	o.params4 = float4(normalize(TANGENT), 0); //spline dir;
	o.params5 = float4(speedDir, speedValue);
	return o;
}

HS_PATCH_OUTPUT HSconst_wire(InputPatch<VS_WIRE_OUTPUT, 2> ip)
{
	#define POS_MSK(x)	ip[x].pos.xyz
	#define TANGENT(x) ip[x].params4.xyz
	HS_PATCH_OUTPUT o;
	o.edges[0] = o.edges[1] = 1;
	float len = distance(POS_MSK(0), POS_MSK(1));
	const float coef = -0.33 * len;
	o.p1.xyz = POS_MSK(0) - TANGENT(0)*coef;
	o.p2.xyz = POS_MSK(1) + TANGENT(1)*coef;
	return o;
	#undef POS_MSK
	#undef TANGENT
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("line")]
[outputcontrolpoints(2)]
[patchconstantfunc("HSconst_wire")]
VS_WIRE_OUTPUT HS_wire(InputPatch<VS_WIRE_OUTPUT, 2> ip, uint id : SV_OutputControlPointID)
{
	VS_WIRE_OUTPUT o;
	o = ip[id];
	return o;
}

//через все круги ада
[domain("isoline")]
VS_WIRE_OUTPUT DS_wire(HS_PATCH_OUTPUT input, OutputPatch<VS_WIRE_OUTPUT, 2> op, float2 uv : SV_DomainLocation)
{
	#define WPOS(x)	op[x].pos.xyz
	VS_WIRE_OUTPUT o; o = op[0];
	float t = uv.x;
	float3 pos = BezierCurve3(t, WPOS(0), input.p1.xyz, input.p2.xyz, WPOS(1));
	float4 nozzleSpeed = float4(normalize(lerp(op[0].params3.xyz, op[1].params3.xyz,t)), 0);
	float4 tangent = float4(normalize(lerp(op[0].params4.xyz, op[1].params4.xyz,t)), 0);
	float4 speedResult = float4(normalize(lerp(op[0].params5.xyz, op[1].params5.xyz,t)), 0);
	o.pos = mul(float4(pos, 1), View).xyz;//в камере
	o.params1.z = 0;
	o.params1.w = lerp(op[0].params1.w, op[1].params1.w, t);//время рождения
	o.params3.xyz = mul(nozzleSpeed, View).xyz;
	o.params4.xyz = mul(tangent, View).xyz;
	o.params5.xyz = mul(speedResult, View).xyz;
	#undef WPOS
	return o;
}

void addLine(inout LineStream<PS_WIRE_INPUT> outputStream, inout PS_WIRE_INPUT o,
			in float3 pos0, in float3 dir, in float4 color)
{
	o.color = color;
	o.pos = mul(float4(pos0, 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(pos0 + dir, 1), Proj);
	outputStream.Append(o);
	outputStream.RestartStrip();
}

[maxvertexcount(10+6)]
void GS_wire(line VS_WIRE_OUTPUT input[2], inout LineStream<PS_WIRE_INPUT> outputStream)
{	
	#define BIRTH_TIME(x) input[x].params1.w
	#define POS_VIEW(x) input[x].pos.xyz
	PS_WIRE_INPUT o;

#ifdef DEBUG_FIXED_SIZE
	const float scale = 2.0 * DEBUG_FIXED_SIZE/3.0;// ширина линии
#else
	const float scale = 2.0;// ширина линии
#endif
	const float pointSize = 0.5;//размер квадратика
	const float tangentScale = 7.0;//длина касательных

	const float AGE = effectTime - BIRTH_TIME(0);
	const float dAge = BIRTH_TIME(1) - BIRTH_TIME(0);
	o.color = float4(0,0,0,1);

	//первый квад
	float3 dir = input[0].params3.xyz;
	float2 dirProj = normalize(float2(dir.x, dir.y));
	float3 offset = {dirProj.y*scale, -dirProj.x*scale, 0};	

	float3 offsetResult =  offset * (1 + sqrt(AGE*sideSpeed)*1.5);

	o.pos = mul(float4(POS_VIEW(0) + offsetResult, 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(POS_VIEW(0) - offsetResult, 1), Proj);
	outputStream.Append(o);
	outputStream.RestartStrip();

	//последний квад совмещаем с первым квадом следующего отрезка
	dir = input[1].params3.xyz;
	dirProj = normalize(float2(dir.x, dir.y));
	offset.xy = float2(dirProj.y*scale, -dirProj.x*scale);

	offsetResult =  offset * (1 + pow((AGE+dAge)*sideSpeed, 0.5)*1.5);

	o.pos = mul(float4(POS_VIEW(1) + offsetResult, 1), Proj);
	outputStream.Append(o);	
	o.pos = mul(float4(POS_VIEW(1) - offsetResult, 1), Proj);
	outputStream.Append(o);
	outputStream.RestartStrip();

	//квадратик
	float3 vertexPos = POS_VIEW(0);
	o.pos = mul(float4(vertexPos + pointSize * float3(staticVertexData[0].xy, 0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + pointSize * float3(staticVertexData[1].xy, 0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + pointSize * float3(staticVertexData[3].xy, 0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + pointSize * float3(staticVertexData[2].xy, 0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + pointSize * float3(staticVertexData[0].xy, 0), 1), Proj);
	outputStream.Append(o);
	outputStream.RestartStrip();

	//касательная к сплайну	
#ifdef SHOW_NOZZLE_DIR
	addLine(outputStream, o, vertexPos, input[0].params3.xyz*tangentScale, float4(1,0,0,1));
#endif
#ifdef SHOW_TANGENT
	addLine(outputStream, o, vertexPos, input[0].params4.xyz*tangentScale, float4(0,1,0,1));
#endif
#ifdef SHOW_RESULT_SPEED
	addLine(outputStream, o, vertexPos, input[0].params5.xyz*tangentScale, float4(0,0,1,1));
#endif
	
	#undef POS_VIEW
	#undef BIRTH_TIME
}

float4  PS_black(PS_WIRE_INPUT i) : SV_TARGET0
{
	return i.color;
}
