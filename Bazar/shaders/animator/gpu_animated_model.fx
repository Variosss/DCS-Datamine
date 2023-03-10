#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/ShadowStates.hlsl"
#include "common/stencil.hlsl"
#include "deferred/GBuffer.hlsl"
#include "deferred/atmosphere.hlsl"
#include "deferred/shading.hlsl"
#include "deferred/shadows.hlsl"

#include "animator_common.hlsl"
#include "quaternion.hlsl"

struct FlatShadowParams
{
    float3 ground_point;
    float3 ground_normal;
};

StructuredBuffer    <uint>          instance_indices;
StructuredBuffer    <InstanceData>  per_instance_data;
StructuredBuffer    <float4x4>      positions;
StructuredBuffer    <float4x4>      prev_frame_transforms;
StructuredBuffer    <float4x4>      model_transforms;
StructuredBuffer    <float4x4>      bone_offset;
StructuredBuffer    <uint>          transform_indices; /// Буфер индексов трансформов. В шейдер передаётся буфер со всеми трансформами модели. Не все из них кости. Буфер перевод номер кости в номер трансформа

StructuredBuffer    <FlatShadowParams>      flat_shadow_params;

Texture2DArray  diffuse_texture;
Texture2DArray  normal_texture;
Texture2DArray  rm_texture;

float4x4 mesh_matrix = {100, 0, 0, 0,   0, 100, 0, 0,   0, 0, 100, 0,   0, 0, 0, 1.0};
//float4x4 mesh_matrix;

struct VS_INPUT
{
    float3 Position : POSITION0;
    float3 Normal   : NORMAL0;
    float3 Tangent  : NORMAL1;
    float3 BiTangent: NORMAL2;
    float3 TexCoord : TEXCOORD0;
    float4 weights  : TEXCOORD1;
    uint ids        : TEXCOORD2;
    uint instance_id : SV_InstanceID;
};

struct VS_INPUT_SHADOW
{
    float3 Position : POSITION0;
    float4 weights  : TEXCOORD1;
    uint ids        : TEXCOORD2;
    uint instance_id : SV_InstanceID;
};

struct VS_OUT
{
    float4  Position    : SV_POSITION0;
    float4  ProjPos     : POSITION0;
    float4  prevProjPos : POSITION1;
    float2  TexCoord    : TEXCOORD0;
    float3  Normal      : NORMAL0;
    float3  Tangent     : NORMAL1;
    float3  BiTangent   : NORMAL2;
    uint3   livery_id   : TEXCOORD1;
};

float4 get_blended_pos(uint instance_id, float3 Position, float4 weights, uint ids, out float4x4 m)
{
    uint i3 =  ids & 0xFF;
    uint i2 = (ids >> 8) & 0xFF;
    uint i1 = (ids >> 16) & 0xFF;
    uint i0 = (ids >> 24) & 0xFF;
    
    uint instance_offset = instance_id*NUM_NODES;
    
    //float4x4 ones = {1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1};
    float4x4 m0 = mul(bone_offset[i0], model_transforms[instance_offset + transform_indices[i0]]);
    float4x4 m1 = mul(bone_offset[i1], model_transforms[instance_offset + transform_indices[i1]]);
    float4x4 m2 = mul(bone_offset[i2], model_transforms[instance_offset + transform_indices[i2]]);
    float4x4 m3 = mul(bone_offset[i3], model_transforms[instance_offset + transform_indices[i3]]);

    m = m0*weights.x + m1*weights.y + m2*weights.z + m3*weights.w;

    float4 p = float4(Position, 1.0);
    float4 blended_pos = mul(p, m);
    return blended_pos;
}

VS_OUT vs_main(VS_INPUT vs_input)
{
    uint instance_id            = instance_indices[vs_input.instance_id];
    InstanceData data           = per_instance_data[instance_id];
    float4x4 world_mat          = transpose(positions[instance_id]);
    float4x4 prevFrameTransform = prev_frame_transforms[instance_id];
    
    float4x4 m;
    float4 blended_pos = get_blended_pos(instance_id, vs_input.Position, vs_input.weights, vs_input.ids, m);
    blended_pos = mul(blended_pos, mesh_matrix);

    float4 n = float4(vs_input.Normal, 0.0);
    float4 blended_normal = mul(n, m);
    blended_normal = mul(blended_normal, mesh_matrix);

    float4 tg = float4(vs_input.Tangent, 0.0);
    float4 blended_t = mul(tg, m);
    blended_t = mul(blended_t, mesh_matrix);

    float4 bt = float4(vs_input.BiTangent, 0.0);
    float4 blended_bt = mul(bt, m);
    blended_bt = mul(blended_bt, mesh_matrix);
    
    float4x4 wvp = mul(world_mat, gViewProj);

    VS_OUT OUT;
    OUT.Position    = mul(float4(blended_pos.xyz, 1),       wvp);
    //OUT.Position    = mul(p,       wvp);
    OUT.Normal      = mul(float4(blended_normal.xyz, 0),    world_mat).xyz;
    OUT.Tangent     = mul(float4(blended_t.xyz, 0),         world_mat).xyz;
    OUT.BiTangent   = mul(float4(blended_bt.xyz, 0),        world_mat).xyz;

    OUT.ProjPos     = OUT.Position;
    float4 pw       = mul(float4(blended_pos.xyz, 1),       world_mat);
    OUT.prevProjPos = mul(mul(pw, prevFrameTransform),      gPrevFrameViewProj);
    OUT.TexCoord.xy = vs_input.TexCoord.xy;
    OUT.livery_id   = data._livery_id;
    return OUT;
}

float4 vs_main_shadow(VS_INPUT_SHADOW vs_input): SV_POSITION0
{
    uint instance_id    = instance_indices[vs_input.instance_id];
    InstanceData data   = per_instance_data[instance_id];
    float4x4 world_mat  = transpose(positions[instance_id]);
    
    float4x4 m;
    float4 blended_pos = get_blended_pos(instance_id, vs_input.Position, vs_input.weights, vs_input.ids, m);
    blended_pos = mul(blended_pos, mesh_matrix);

    float4x4 wvp = mul(world_mat, gViewProj);

    return mul(float4(blended_pos.xyz, 1),       wvp);
}

float4 vs_main_flat_shadow(VS_INPUT_SHADOW vs_input): SV_POSITION0
{
    uint instance_id    = instance_indices[vs_input.instance_id];
    InstanceData data   = per_instance_data[instance_id];
    float4x4 world_mat  = transpose(positions[instance_id]);
    
    float4x4 m;
    float4 blended_pos = get_blended_pos(instance_id, vs_input.Position, vs_input.weights, vs_input.ids, m);
    blended_pos = mul(blended_pos, mesh_matrix);
    
    float3 ground_point     = flat_shadow_params[instance_id].ground_point;
    float3 ground_normal    = flat_shadow_params[instance_id].ground_normal;
    float3 light_dir        = gSunDir;    
    float4 p = mul(blended_pos, world_mat);
    
    float d = dot((ground_point - p.xyz), ground_normal)/dot(light_dir, ground_normal);
    float3 proj_point = p.xyz + light_dir*d;
    
    float4 result = mul(float4(proj_point, 1), gViewProj);
    return result;
}

float4 ps_main_flat_shadow(): SV_TARGET0 
{
	return 0;
}

struct Ps_Params
{
    float2 tex_coord;
    float4 diffuse_color;
    float4 rm_color;
    float3 normal;
    float ao;
};

Ps_Params make_params(VS_OUT i)
{
    Ps_Params o;
    float tx                = i.TexCoord.x;
    float ty                = 1 - i.TexCoord.y;
    float2 tex_coord        = float2(tx, ty);
    float4 diffuse_color    = diffuse_texture.Sample (gTrilinearWrapSampler, float3(tex_coord, i.livery_id.x));
    float4 rm_color         = rm_texture.Sample (gTrilinearWrapSampler, float3(tex_coord, i.livery_id.y));

    float4 n                = normal_texture.Sample   (gTrilinearWrapSampler, float3(tex_coord, i.livery_id.z))*float4(2, 2, 2, 0) - float4(1, 1, 1, 0);
    float3x3 NM             = float3x3(normalize(i.Tangent), normalize(i.BiTangent), normalize(i.Normal));
    float3 normal           = mul(n, NM);
    
    o.tex_coord        = tex_coord;
    o.diffuse_color    = diffuse_color;
    o.rm_color         = rm_color;
    o.normal           = normal;
#if USE_SEPARATE_AO
	o.ao = rm_color.x;
#else
	o.ao = 1;
#endif    
    return o;
}

GBuffer ps_main(
    VS_OUT i
#if USE_SV_SAMPLEINDEX
    , uint sv_sampleIndex: SV_SampleIndex
#endif
) 
{
    Ps_Params pp = make_params(i);
    
    float2 motion = calcMotionVector(i.ProjPos, i.prevProjPos);

    float b = 0.01;
    float3 base_stripes_color = float3(b, b, b);
    float brightness = pp.diffuse_color.a;
    float3 stripes_color = base_stripes_color*float3(brightness, brightness, brightness);
    return BuildGBuffer(
        i.Position.xy, 
	#if USE_SV_SAMPLEINDEX
        sv_sampleIndex,         
	#endif
        pp.diffuse_color*pp.rm_color.r,
        pp.normal.xyz, 
        float4(pp.ao, pp.rm_color.gb, 1),         
        stripes_color, 
        motion
	);
}

float4 ps_forward(VS_OUT i) : SV_TARGET0
{
    Ps_Params pp = make_params(i);
    
    float3 pos              = i.Position.xyz / i.Position.w;
	float3 toCamera = gCameraPos.xyz - pos;
	toCamera /= length(toCamera);
    float3 emissive         = 0;
	float2 cloudsShadowAO	= SampleShadowClouds(pos);
    float shadow            = cloudsShadowAO.x;
    
    float3 sunColor         = SampleSunRadiance(pos, gSunDir);
    float3 sHDR             = ShadeHDR(
		i.Position.xy,
        sunColor, 
        pp.diffuse_color.rgb, 
        pp.normal, 
        pp.rm_color.y, 
        pp.rm_color.z, 
        emissive, 
        shadow, 
        pp.ao,
		cloudsShadowAO,
        toCamera, 
        pos, 
        float2(1, pp.rm_color.w));

    return float4(applyAtmosphereLinear(gCameraPos.xyz, pos, i.ProjPos, sHDR), pp.diffuse_color.a);
}

struct VS_INPUT_STATIC
{
    float3 Position : POSITION0;
    float3 Normal   : NORMAL0;
    float3 Tangent  : NORMAL1;
    float3 BiTangent: NORMAL2;
    float3 TexCoord : TEXCOORD0;
    uint instance_id : SV_InstanceID;
};

struct VS_OUT_STATIC
{
    float4  Position    : SV_POSITION0;
    float4  ProjPos     : POSITION0;
    float4  prevProjPos : POSITION1;
    float2  TexCoord    : TEXCOORD0;
    float3  Normal      : NORMAL0;
    float3  Tangent     : NORMAL1;
    float3  BiTangent   : NORMAL2;
    uint3   livery_id   : TEXCOORD1;
};

VS_OUT_STATIC vs_main_static(VS_INPUT_STATIC vs_input)
{
    VS_OUT_STATIC OUT;
    uint instance_id    = instance_indices[vs_input.instance_id];
    InstanceData data   = per_instance_data[instance_id];
    
    float4x4 world_mat = transpose(positions[instance_id]);
    
    uint instance_offset = instance_id*NUM_NODES;
    
    float4 p = float4(vs_input.Position, 1.0);
    float4 blended_pos = mul(p, mesh_matrix);

    float4 n = float4(vs_input.Normal, 0.0);
    float4 blended_normal = mul(n, mesh_matrix);

    float4x4 wvp = mul(world_mat, gViewProj);

    OUT.Position    = mul(float4(blended_pos.xyz, 1),       wvp);
    OUT.Normal      = mul(float4(blended_normal.xyz, 0),    world_mat).xyz;
    OUT.ProjPos     = mul(float4(blended_pos.xyz, 1), wvp);
    OUT.prevProjPos = OUT.ProjPos;
    OUT.TexCoord.xy = vs_input.TexCoord.xy;

    float4 t = float4(vs_input.Tangent, 0.0);
    float4 blended_t = mul(t, mesh_matrix);

    float4 bt = float4(vs_input.BiTangent, 0.0);
    float4 blended_bt = mul(bt, mesh_matrix);

    OUT.Tangent     = mul(float4(blended_t.xyz, 0),         world_mat).xyz;
    OUT.BiTangent   = mul(float4(blended_bt.xyz, 0),        world_mat).xyz;
    OUT.livery_id   = data._livery_id;    
    return OUT;
}

float4 vs_main_static_shadow(VS_INPUT_STATIC vs_input): SV_POSITION0
{
    uint instance_id    = instance_indices[vs_input.instance_id];
    float4x4 world_mat = transpose(positions[instance_id]);

    float4 p = float4(vs_input.Position, 1.0);
    float4 blended_pos = mul(p, mesh_matrix);

    float4x4 wvp = mul(world_mat, gViewProj);

    float4 Position    = mul(float4(blended_pos.xyz, 1),       wvp);
    return Position;
}

float4 vs_main_flat_static_shadow(VS_INPUT_STATIC vs_input): SV_POSITION0
{
    uint instance_id        = instance_indices[vs_input.instance_id];
    float4x4 world_mat      = transpose(positions[instance_id]);
    
    float3 ground_point     = flat_shadow_params[instance_id].ground_point;
    float3 ground_normal    = flat_shadow_params[instance_id].ground_normal;
    float3 light_dir        = gSunDir; 
    
    float4 p = float4(vs_input.Position, 1.0);
    p = mul(p, mesh_matrix);
    p = mul(p, world_mat);
    
    float d = dot((ground_point - p.xyz), ground_normal)/dot(light_dir, ground_normal);
    float3 proj_point = p.xyz + light_dir*d;
    
    float4 result = mul(float4(proj_point, 1), gViewProj);
    return result;
}

DepthStencilState enableDepthBufferCP
{
	DepthEnable        = TRUE;
	DepthWriteMask     = ALL;
	DepthFunc          = DEPTH_FUNC;

	WRITE_COMPOSITION_TYPE_TO_STENCIL;
};

technique10 Deferred
{
    pass P0
    {          
        SetVertexShader(CompileShader(vs_5_0, vs_main()));
        SetPixelShader(CompileShader(ps_5_0, ps_main()));
        SetGeometryShader(NULL);
        SetDepthStencilState(enableDepthBufferCP, STENCIL_COMPOSITION_MODEL);
        //SetDepthStencilState(enableDepthBuffer, 0);
        SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
        SetRasterizerState(cullFront);
    }
}

technique10 Forward
{
    pass P0
    {          
        SetVertexShader(CompileShader(vs_5_0, vs_main()));
        SetPixelShader(CompileShader(ps_5_0, ps_forward()));
        SetGeometryShader(NULL);
        SetDepthStencilState(enableDepthBuffer, 0);
        SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
        SetRasterizerState(cullFront);
    }
}

RasterizerState CharacterShadowmapRasterizerState
{
	CullMode = Back;
	FillMode = SOLID;
	MultisampleEnable = FALSE;
	DepthBias = 0;
	SlopeScaledDepthBias = 0;
	DepthClipEnable = FALSE;
};

technique10 Shadow
{
    pass P0
    {          
        SetVertexShader(CompileShader(vs_5_0, vs_main_shadow()));
        SetPixelShader(NULL);
        SetGeometryShader(NULL);
        SetDepthStencilState(shadowmapDepthState, 0);
        //SetDepthStencilState(enableDepthBuffer, 0);
        SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
        //SetRasterizerState(CharacterShadowmapRasterizerState);     
        SetRasterizerState(shadowmapRasterizerState);
    }
}

RasterizerState modelFlatShadowsRasterizerState {
	CullMode = Front;
	FillMode = Solid;
	MultisampleEnable = TRUE;
	DepthBias = 200.0;
	SlopeScaledDepthBias = 0.0;
};

#ifdef MSAA
    #define ENABLE_FLAT_SHADOW_DEPTH_BUFFER SetDepthStencilState(disableDepthBuffer, 0)
#else
    #define ENABLE_FLAT_SHADOW_DEPTH_BUFFER SetDepthStencilState(enableDepthBufferNoWrite, 0)
#endif

technique10 FlatShadow
{
    pass P0
    {          
		SetRasterizerState(modelFlatShadowsRasterizerState);
		SetBlendState(enableFlatShadowAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		ENABLE_FLAT_SHADOW_DEPTH_BUFFER;
    
        SetVertexShader(CompileShader(vs_5_0, vs_main_flat_shadow()));
        SetPixelShader(CompileShader(ps_5_0, ps_main_flat_shadow()));
        SetGeometryShader(NULL);
    }
}

technique10 StaticModel
{
    pass P0
    {          
        SetVertexShader(CompileShader(vs_5_0, vs_main_static()));
        SetPixelShader(CompileShader(ps_5_0, ps_main()));
        SetGeometryShader(NULL);
        SetDepthStencilState(enableDepthBuffer, 0);
        SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
        SetRasterizerState(cullFront);
    }
}

technique10 ShadowStatic
{
    pass P0
    {          
        SetRasterizerState(CharacterShadowmapRasterizerState);     
        SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
        //SetRasterizerState(cullBack);
        SetVertexShader(CompileShader(vs_5_0, vs_main_static_shadow()));
        SetPixelShader(NULL);
        SetGeometryShader(NULL);    
    }
}

technique10 FlatShadowStatic
{
    pass P0
    {          
        SetRasterizerState(modelFlatShadowsRasterizerState);     
        SetBlendState(enableFlatShadowAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
        ENABLE_FLAT_SHADOW_DEPTH_BUFFER;
        
        SetVertexShader(CompileShader(vs_5_0, vs_main_flat_static_shadow()));
        SetPixelShader(CompileShader(ps_5_0, ps_main_flat_shadow()));
        SetGeometryShader(NULL);      
    }
}

technique10 StaticForward
{
    pass P0
    {          
        SetVertexShader(CompileShader(vs_5_0, vs_main_static()));
        SetPixelShader(CompileShader(ps_5_0, ps_forward()));
        SetGeometryShader(NULL);
        SetDepthStencilState(enableDepthBuffer, 0);
        SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
        SetRasterizerState(cullFront);
    }
}