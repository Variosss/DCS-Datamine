dofile(LockOn_Options.script_path.."HUD/HUD_definitions.lua")
--[[
grid            = CreateElement "ceTexPoly"
grid.name       = "grid"
grid.vertices   = {{-0.54, -0.837}, {-0.54, 0.295}, {0.54, 0.295}, {0.54, -0.837}}
grid.indices    = default_box_indices
grid.material   = "INDICATION_HUD_KA50"
grid.tex_params = {0.52658, 0.22868, tex_scale, tex_scale}
Add(grid)
--]]

SetScale(METERS)
radius_ring         = (198.5 - 140 )/256
radius_ring_meters  = math.tan(2.0 /(180/math.pi))
scale_helmet_x      = radius_ring/radius_ring_meters
scale_multiplier_y  = 2/(139/128)

local frame_size = 4 * radius_ring_meters
local frame_k     = (55/128)        /(frame_size * GetScale())
local frame_y     = ((512 - 57)/512)/(frame_k/4)
local frame_x_min = (60/128) /(frame_k)
local frame_x_max =-(68/128) /(frame_k)


helmet_base             = CreateElement "ceSimple"
helmet_base.controllers = {{"displacement"}}
Add(helmet_base)


frame_mover           = CreateElement "ceSimple"
frame_mover.name      = "frame_mover"
frame_mover.init_pos  = {0,frame_y,0}
frame_mover.controllers = {{"frame_moving",math.rad(90)}}
frame_mover.parent_element = helmet_base.name
Add(frame_mover)

frame           = CreateElement "ceTexPoly"
frame.name      = "frame"
frame.vertices  =   {{-frame_size,frame_x_min},
					 {-frame_size,frame_x_max},
					 { frame_y   ,frame_x_max},
					 { frame_y   ,frame_x_min}}
frame.indices   = default_box_indices
frame.material  = "HELMET_FRAME"
frame.parent_element = "frame_mover"
frame.tex_params= {57/512,
                   60/128,
                   (frame_k/4),
                    frame_k}                  
frame.init_pos  = {0,-frame_y,0}
frame.init_rot  = {90,0,0}
Add(frame)

local STENCIL_LEVEL = 8

frame_stencil                 = CreateElement "ceMeshPoly"
frame_stencil.name            = "frame_stencil"
frame_stencil.primitivetype   = "triangles"
set_circle(frame_stencil,0.75*frame_size)
frame_stencil.material        = "GREEN_2"
frame_stencil.parent_element  = "frame"
frame_stencil.h_clip_relation = h_clip_relations.REWRITE_LEVEL
frame_stencil.level			  = STENCIL_LEVEL
frame_stencil.isvisible       = false
Add(frame_stencil)



ring             = CreateElement "ceTexPoly"
ring.name        = "ring"
ring.vertices    = {{-radius_ring_meters,-radius_ring_meters},
				   {-radius_ring_meters, radius_ring_meters},
				   { radius_ring_meters, radius_ring_meters},
				   { radius_ring_meters,-radius_ring_meters}}
ring.indices     = default_box_indices
ring.material    = "INDICATION_HELMET_KA50"
ring.tex_params  = {198.5/256,0.5,scale_helmet_x,scale_helmet_x*scale_multiplier_y}
ring.controllers = {{"ring_logic"}}
ring.additive_alpha	= true
ring.parent_element = helmet_base.name
ring.h_clip_relation = h_clip_relations.COMPARE
ring.level			  = STENCIL_LEVEL
Add(ring)

cross_size       =(69.5/256)/scale_helmet_x

cross            = CreateElement "ceTexPoly"
cross.name       = "cross"
cross.vertices   = {{-cross_size,-cross_size},
				   {-cross_size, cross_size},
				   { cross_size, cross_size},
				   { cross_size,-cross_size}}
cross.indices    = default_box_indices
cross.init_rot   = {45.0,0,0}
cross.material   = "INDICATION_HELMET_KA50"
cross.tex_params = {69.5/256,0.5,scale_helmet_x,scale_helmet_x*scale_multiplier_y}
cross.controllers = {{"cross_logic"}}
cross.additive_alpha	= true
cross.parent_element = helmet_base.name
cross.h_clip_relation = h_clip_relations.COMPARE
cross.level			  = STENCIL_LEVEL
Add(cross) 