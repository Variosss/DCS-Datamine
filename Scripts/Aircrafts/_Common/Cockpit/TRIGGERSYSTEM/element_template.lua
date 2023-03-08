dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetCustomScale(1.0)

symbol_size      	  	  = 0.1

if LockOn_Options.screen.oculus_rift then
	symbol_size = 0.025
end

local min_size 	    	   = symbol_size
local texture_size		   = 512
local texture_size_symbol  = 0.25 * texture_size
local scaled_texture_scale = texture_size_symbol / texture_size
local tex_scale  		   = (texture_size_symbol / texture_size)/symbol_size


local function AddElem(elem)
	if not LockOn_Options.screen.oculus_rift then
		elem.screenspace   = ScreenType.SCREENSPACE_TRUE
	else
		elem.z_enabled 	   = false
	end
	Add(elem)
end

local material =   MakeMaterial("triggers.tga",{255,161,45,255})

highlight                 = CreateElement "ceSimple"
highlight.name            = "highlight"
highlight.controllers     = {{"highlight_position"},
							 {"start_and_fade_out_animation",1,2*math.pi,0.5}}
AddElem(highlight)

local arrow_sz = math.sqrt(2) * symbol_size

function add_anchor_indication(obj)
local 	anchor           	   = CreateElement "ceMeshPoly"
		anchor.primitivetype   = "lines"
		anchor.material        = "INDICATION_COMMON_RED"
		anchor.parent_element  = obj.name
		anchor.vertices 	   ={{-0.01,0},
								 { 0.01,0},
							     { 0,-0.01},
								 { 0, 0.01}}
		anchor.indices 		   = {0,1,2,3}

		AddElem(anchor)
end

direction_arrow                 = CreateElement "ceTexPoly"
direction_arrow.name            = "direction_arrow"
direction_arrow.vertices        = {{0		 ,0},
								   {-symbol_size,-symbol_size},
								   {-2 * symbol_size,0},
								   {-symbol_size ,symbol_size}}
direction_arrow.indices         = default_box_indices
direction_arrow.material		= material
direction_arrow.controllers     = {{"direction_arrow"}}

direction_arrow.tex_coords	    = {{0		 			,0},
								   {scaled_texture_scale,0},
								   {scaled_texture_scale,scaled_texture_scale},
								   {0					,scaled_texture_scale}}					   								   
				   								   
direction_arrow.additive_alpha  = true
direction_arrow.use_mipfilter   = true
direction_arrow.parent_element  = highlight.name
AddElem(direction_arrow)

upper_left                 = CreateElement "ceTexPoly"
upper_left.vertices        = {{0,-symbol_size},
                             { 0,0},
                             { symbol_size,0},
                             { symbol_size,-symbol_size}}
upper_left.indices         = default_box_indices
upper_left.material		   = material
upper_left.controllers     = {{"size_of_element",-1,-1,min_size,min_size}}
							 
upper_left.tex_params	   =  {0,0,tex_scale,tex_scale}
upper_left.additive_alpha  = true
upper_left.use_mipfilter   = true
upper_left.parent_element  = highlight.name
AddElem(upper_left)

upper_right				    = Copy(upper_left)
upper_right.vertices        = {{0			,0},
                               {0		    ,-symbol_size},
                               {-symbol_size,-symbol_size},
                               {-symbol_size,0}}
upper_right.controllers     = {{"size_of_element",1,-1,min_size,min_size}}
upper_right.tex_params	  	=  {2 * scaled_texture_scale,0,tex_scale,tex_scale}
Add(upper_right)

lower_left				   = Copy(upper_left)
lower_left.vertices        = {{0,symbol_size},
                             { 0,0},
                             { symbol_size,0},
                             { symbol_size,symbol_size}}
lower_left.controllers     = {{"size_of_element",-1,1,min_size,min_size}}
lower_left.tex_params	   =  {0,2 * scaled_texture_scale,tex_scale,tex_scale}
Add(lower_left)

lower_right				    = Copy(upper_left)
lower_right.vertices        = {{0			,0},
                               {0		    ,symbol_size},
                               {-symbol_size,symbol_size},
                               {-symbol_size,0}}
lower_right.controllers     = {{"size_of_element",1,1,min_size,min_size}}
lower_right.tex_params	  	=  {2 * scaled_texture_scale,2 * scaled_texture_scale,tex_scale,tex_scale}
Add(lower_right)

--[[
add_anchor_indication(upper_left)
add_anchor_indication(lower_right)
--]]