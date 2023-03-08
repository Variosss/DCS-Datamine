dofile(LockOn_Options.script_path.."MFCD/indicator/MAV/MFCD_MAV_tools.lua")

AddRender()

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
tv_maverick_origin                 = CreateElement "ceSimple"
tv_maverick_origin.name            = "tv_maverick_origin"
tv_maverick_origin.controllers     = {{"maverick_AGM_65E",0}}
SetScreenSpace(tv_maverick_origin)
Add(tv_maverick_origin)


depression_marks_background ={}
depression_marks ={}
rendered_line_width  = 0.006

rendered_material    	   = MFCD_SOLID_GREY_MAV

grey_fields 			   = CreateElement "ceMeshPoly"
grey_fields.name           = "back"
grey_fields.primitivetype  = "triangles"
grey_fields.material	   = MFCD_SOLID_DARK_GREY
grey_fields.vertices       =   {{-1, 1},
							    { 1, 1},
								{ 1, 0.8},
								{-1, 0.8},
								
								{-1,-1},
								{ 1,-1},
								{ 1,-0.93},
								{-1,-0.93}}
grey_fields.indices        = {0,1,2,2,3,0;4+0,4+1,4+2,4+2,4+3,4+0}
grey_fields.parent_element = tv_maverick_origin.name
SetScreenSpace(grey_fields)
Add(grey_fields)

back    			= CreateElement "ceMeshPoly"
back.name           = "back1"
back.primitivetype  = "triangles"
back.vertices       =  {{-1, 1},
					    { 1, 1},
						{ 1,-1},
						{-1,-1}}
back.indices         = box_ind
back.level		     = DEFAULT_LEVEL
back.h_clip_relation = h_clip_relations.REWRITE_LEVEL
set_as_invisible_mask(back)
back.parent_element = tv_maverick_origin.name
SetScreenSpace(back)
Add(back)

gate    			= CreateElement "ceMeshPoly"
gate.name           = "gate"
gate.primitivetype  = "triangles"
gate.vertices       =  {{-0.05, 0.05},
					    { 0.05, 0.05},
						{ 0.05,-0.05},
						{-0.05,-0.05}}
gate.indices         = box_ind
gate.h_clip_relation = h_clip_relations.INCREASE_LEVEL
gate.controllers     = {{"maverick_force_correlate",-1},{"maverick_frame_size_scale",1/(25/570)}}
set_as_invisible_mask(gate)
SetScreenSpace(gate)
gate.parent_element  = tv_maverick_origin.name
Add(gate)

base				 = CreateElement "ceSimple"
base.name            = "base"
base.controllers     = {{"maverick_frame_position",2,2}}
SetScreenSpace(base)
base.parent_element = tv_maverick_origin.name
Add(base)



for i =1,3 do
depression_marks_background[i]    			 = CreateElement "ceMeshPoly"
depression_marks_background[i].name          = "depression_marks_background"..string.format("%d",i)
depression_marks_background[i].primitivetype = "triangles"
depression_marks_background[i].material	     = rendered_material
depression_marks_background[i].vertices      = {{-(20/570 + 0.006), rendered_line_width},
											    { (20/570 + 0.006), rendered_line_width},
											    { (20/570 + 0.006),-rendered_line_width},
											    {-(20/570 + 0.006),-rendered_line_width}}
depression_marks_background[i].indices        =   box_ind
depression_marks_background[i].init_pos       = {0,-i/6,0}
depression_marks_background[i].controllers    = {{"maverick_polarity_change_color",0,0,0}}
depression_marks_background[i].parent_element =  tv_maverick_origin.name
Add(depression_marks_background[i])
SetScreenSpace(depression_marks_background[i])
end

cross_hair_background    			 = CreateElement "ceMeshPoly"
cross_hair_background.name           = "cross_hair_background"
cross_hair_background.primitivetype  = "triangles"
cross_hair_background.material	     = rendered_material
cross_hair_background.parent_element = "base"
cross_hair_background.controllers    = {{"maverick_polarity_change_color",0,0,0}}
set_cross(cross_hair_background,5,rendered_line_width)
SetScreenSpace(cross_hair_background)
SetDefaultClipWithLevel(cross_hair_background)
Add(cross_hair_background)


narrow_width = 10 * 4/570
narrow_delta = rendered_line_width
narrow_field_background = {}

for i = 1,4 do
narrow_field_background[i] 			  	  = CreateElement "ceMeshPoly"
narrow_field_background[i].name           = "narrow_field_background"..string.format("%d",i)
narrow_field_background[i].primitivetype  = "triangles"
narrow_field_background[i].material	   	  = rendered_material
narrow_field_background[i].vertices       = {{-narrow_delta					 ,-narrow_delta},--0
											 {-narrow_delta					 , narrow_width },	--1
											 { 0				  			 ,(narrow_width + narrow_delta)},--2
											 { narrow_delta					 , narrow_width} ,		--3
											 { narrow_width     			 , narrow_delta},	--4
											 {(narrow_width + narrow_delta)	 , 0},
											 { narrow_width    			 	 ,-narrow_delta},
											 { narrow_delta				 	 , narrow_delta}}
narrow_field_background[i].indices        =  {0,1,7;1,3,7;1,2,3;0,7,6;7,4,6;4,5,6}
narrow_field_background[i].parent_element =  tv_maverick_origin.name
SetScreenSpace(narrow_field_background[i])
narrow_field_background[i].controllers    = {{"maverick_FOV"},{"maverick_polarity_change_color",0,0,0}}
Add(narrow_field_background[i])
use_mipfilter(narrow_field_background[i])
end


narrow_field_background[1].init_pos       = {-1/2,-1/2,0}
narrow_field_background[2].init_pos       = {-1/2, 1/2,0}
narrow_field_background[2].init_rot       = {-90,0,0}
narrow_field_background[3].init_pos       = { 1/2, 1/2,0}
narrow_field_background[3].init_rot       = {180,0,0}
narrow_field_background[4].init_pos       = { 1/2,-1/2,0}
narrow_field_background[4].init_rot       = {90,0,0}

local cross_size  = 0.1
local cross_delta = rendered_line_width * 1.5
local k = (1/6)/math.rad(5)

maverick_position 	   			 = CreateElement "ceMeshPoly"
maverick_position.name 			 = "cross"
maverick_position.primitivetype  = "triangles"
maverick_position.material	   	 = rendered_material
maverick_position.parent_element = tv_maverick_origin.name
set_cross(maverick_position,1/6,rendered_line_width)
maverick_position.controllers   = {{"maverick_view_angle",k,k},{"maverick_lock_blinking"},{"maverick_polarity_change_color",0,0,0}}									 
SetScreenSpace(maverick_position)
Add(maverick_position)
use_mipfilter(maverick_position)
SetDefaultClipWithLevel(maverick_position)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--[[  ------------------------------------ AGM-65E/L block-------------------------------------------------------------------------------------------------------------
--
--
--
--]] ----------------------------------------------------------------------------------------------------------------------------------------------------------------------]


local soi_up_border          = (max_pixels_count - 30) / (max_pixels_count/2)
local soi_down_border        = 30/(max_pixels_count/2)
local soi_area_size_vertical = soi_up_border - soi_down_border -- 422
local size_of_25_deg         = (195 / 422) * soi_area_size_vertical
local origin_or_grid         = soi_down_border


local sz_25_deg       = (195 / 422) * soi_area_size_vertical
local sz_1_deg        = sz_25_deg / 25
local sz_15_deg       = 15 * sz_1_deg

local sz_grid         = (256/240) * sz_15_deg
local grid_tex_params = {0.5,0.5, GetScale() *  1/(2*sz_grid) , GetScale() * 1/(2*sz_grid) }  

local use_agm65e_rescale = true

local agm65e_Kx = 1
if use_agm65e_rescale then
	agm65e_Kx = 1 / 1.15
end

function ResizeAGM65E_Symbol(Object)
	if use_agm65e_rescale then
		Resize(Object, agm65e_Kx, 1)
	end	
end

agm_65e_origin                 = CreateElement "ceSimple"
agm_65e_origin.controllers     = {{"maverick_AGM_65E",1}}
agm_65e_origin.init_pos        = {0,-(1.0 - origin_or_grid)}
SetScreenSpace(agm_65e_origin)
Add(agm_65e_origin)

back_agm_65e    			= CreateElement "ceMeshPoly"
back_agm_65e.primitivetype  = "triangles"
back_agm_65e.material	    = "TGP_STBY_DARK_GREY"
back_agm_65e.vertices       =  {{-1, 1},
        					    { 1, 1},
        						{ 1,-1},
        						{-1,-1}}
back_agm_65e.indices         = box_ind
back_agm_65e.parent_element  = agm_65e_origin.name
back_agm_65e.init_pos        = {0, 1.0 - origin_or_grid}
SetScreenSpace(back_agm_65e)
Add(back_agm_65e)


grid                = CreateElement "ceSimple"

grid.init_pos 		= {2.5 * sz_1_deg * agm65e_Kx, sz_25_deg}
grid.parent_element = agm_65e_origin.name
SetScreenSpace(grid)
Add(grid)

grid_image  				= CreateElement "ceTexPoly"
grid_image.vertices		    = {{-sz_grid, sz_grid},
        					   { sz_grid, sz_grid},
        					   { sz_grid,-sz_grid},
        					   {-sz_grid,-sz_grid}}
grid_image.indices		    = box_ind
grid_image.material		    = "AGM_65E_GRID"
grid_image.tex_params		= grid_tex_params
grid_image.parent_element   = grid.name
grid_image.controllers     = {{"maverick_agm_65e_grid_available", 1}}
use_mipfilter(grid_image) 
SetScreenSpace(grid_image)
ResizeAGM65E_Symbol(grid_image)
Add(grid_image)


tick_20_deg 	   			 = CreateElement "ceMeshPoly"
tick_20_deg.primitivetype    = "triangles"
tick_20_deg.material	   	 = rendered_material
tick_20_deg.vertices         = {{-2.5 * sz_1_deg, rendered_line_width},
                                { 2.5 * sz_1_deg, rendered_line_width},
                                { 2.5 * sz_1_deg,-rendered_line_width},
                                {-2.5 * sz_1_deg,-rendered_line_width}}
tick_20_deg.indices          = box_ind                         
tick_20_deg.parent_element   = grid.name
tick_20_deg.init_pos         = {0,-20 * sz_1_deg}
SetScreenSpace(tick_20_deg)
Add(tick_20_deg)
ResizeAGM65E_Symbol(tick_20_deg)
use_mipfilter(tick_20_deg)

agm_65e_los_position               = CreateElement "ceSimple"
agm_65e_los_position.controllers   = {{"maverick_view_angle", (sz_15_deg / agm65e_Kx / math.rad(15)), (sz_15_deg / math.rad(15))}}
agm_65e_los_position.parent_element = grid.name
SetScreenSpace(agm_65e_los_position)
Add(agm_65e_los_position)

local agm_65e_sym_size = 2 * sz_1_deg

agm_65e_cross 	   			 = CreateElement "ceMeshPoly"
agm_65e_cross.primitivetype  = "triangles"
agm_65e_cross.material	   	 = rendered_material
agm_65e_cross.parent_element = agm_65e_los_position.name
set_cross_X(agm_65e_cross,agm_65e_sym_size,rendered_line_width)
agm_65e_cross.controllers    = {{"maverick_lock",-1},{"maverick_agm_65e_have_valid_target"}}									 
SetScreenSpace(agm_65e_cross)
ResizeAGM65E_Symbol(agm_65e_cross)
Add(agm_65e_cross)
use_mipfilter(agm_65e_cross)

agm_65e_rect 	   			 = CreateElement "ceMeshPoly"
agm_65e_rect.primitivetype   = "triangles"
agm_65e_rect.material	   	 = rendered_material
agm_65e_rect.parent_element  = agm_65e_los_position.name
agm_65e_rect.vertices        = {{-agm_65e_sym_size, agm_65e_sym_size},
                                { agm_65e_sym_size, agm_65e_sym_size},
                                { agm_65e_sym_size,-agm_65e_sym_size},
                                {-agm_65e_sym_size,-agm_65e_sym_size}}
agm_65e_rect.indices         = box_ind  
agm_65e_rect.controllers     = {{"maverick_lock", 1}}									 
SetScreenSpace(agm_65e_rect)
ResizeAGM65E_Symbol(agm_65e_rect)
Add(agm_65e_rect)
use_mipfilter(agm_65e_rect)

--[[
agm_65e_slaved_rect                 = Copy(agm_65e_rect)
agm_65e_slaved_rect.controllers     = {{"maverick_slaved"},{"maverick_agm_65e_have_valid_target",-1}}	
Add(agm_65e_slaved_rect)		 

agm_65e_slaved_cross                 =  Copy(agm_65e_cross)
agm_65e_slaved_cross.controllers     = {{"maverick_slaved"},{"maverick_agm_65e_have_valid_target",1},{"blinking"}}
Add(agm_65e_slaved_cross)    
--]]


local font_sz  = 0.0155
local fnt_h    = 11.8*font_sz

local agm_65e_font_def = {font_sz,font_sz,(3/5)*font_sz, 0}
code						= CreateElement "ceStringPoly"
code.name					= "code_value"
code.material				= "font_AGM_65E"
code.alignment				= "LeftCenter"
code.init_pos				= {-(4 + 5/6) * 0.6 * fnt_h, 22 * sz_1_deg, 0}
code.stringdefs				= agm_65e_font_def
code.formats                = {"%d"}
code.controllers            = {{"maverick_agm_65e_code",0}}
code.parent_element         = grid.name
SetScreenSpace(code)
Add(code)

code_C						    = Copy(code)
code_C.value					= "    C"
code_C.parent_element           = code.name
code_C.init_pos                 = {0,0,0}
code_C.controllers              = {{"maverick_agm_65e_countermeasure_mode"}}
Add(code_C)

agm_65e_cursor 	   			    = CreateElement "ceMeshPoly"
agm_65e_cursor.primitivetype    = "triangles"
agm_65e_cursor.material	   	    = rendered_material
agm_65e_cursor.vertices         = {{0.6 * fnt_h, 2 * rendered_line_width},
                                   {0, 2 * rendered_line_width},
                                   {0, -2 * rendered_line_width},
                                   {0.6 * fnt_h, -2 * rendered_line_width}}
agm_65e_cursor.indices          = box_ind                         
agm_65e_cursor.parent_element   = code.name
agm_65e_cursor.controllers      = {{"maverick_agm_65e_code_cursor", 2 * (3/5) * fnt_h}}
agm_65e_cursor.init_pos         = {0, -0.7 * fnt_h}
SetScreenSpace(agm_65e_cursor)
Add(agm_65e_cursor)
use_mipfilter(agm_65e_cursor)

slave_symbol						= CreateElement "ceStringPoly"
slave_symbol.name					= "slave_symbol"
slave_symbol.material				= "font_AGM_65E"
slave_symbol.alignment				= "CenterCenter"
slave_symbol.value					= "S"
slave_symbol.init_pos				= {20 * sz_1_deg, 5 * sz_1_deg, 0}
slave_symbol.stringdefs				= agm_65e_font_def
slave_symbol.controllers            = {{"maverick_slaved"}}
slave_symbol.parent_element         = grid.name
SetScreenSpace(slave_symbol)
Add(slave_symbol)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
