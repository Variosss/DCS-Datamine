#ifndef IMPOSTOR_HLSL
#define IMPOSTOR_HLSL

struct PS_IMPOSTOR_OUTPUT
{
	float4 diffuse : SV_TARGET0;
	float4 normal : SV_TARGET1;
};

BlendState impostorBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = FALSE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f;
};

PS_IMPOSTOR_OUTPUT impostor_ps(VS_OUTPUT input)
{

#ifdef BANO_MATERIAL
	discard;
#endif

	PS_IMPOSTOR_OUTPUT o;

	float3 pos = input.Pos.xyz / input.Pos.w;

	float camDist = distance(pos, gCameraPos.xyz);
	camDist *= gNearFarFovZoom.w; // as forest doesn't support changing of camera fov

	float3 normal = calculateNormal2(input);
	o.normal = float4(0.5f * normal + 0.5f, 1.0);

	// specular values
	float4 s;
	// sp, sf, reflValue, reflBlur
	calculateSpecular(input, s);

	o.diffuse = extractDiffuse(GET_DIFFUSE_UV(input));
	float decalMask = addDecal(o.diffuse, input, s.z);
	float4 aorms = 0;
	addDamage(input,camDist, o.diffuse, normal,aorms);

	// hack for buildings
#if defined(BUILDING_MATERIAL)
	o.diffuse.rgb *= SURFACECOLORGAIN; //????
#endif

	float4 vpos = mul(input.Pos, gView);
	float zn = gProj._m23/gProj._m22;
	o.normal.a = 1-(vpos.z/vpos.w+zn)*gProj._m22;

	return o;
}


#endif
