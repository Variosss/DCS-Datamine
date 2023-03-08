dofile(LockOn_Options.script_path.."MFCD/indicator/MAV/MFCD_MAV_tools.lua")

AddRender()

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
tv_maverick_origin                 = CreateElement "ceSimple"
tv_maverick_origin.name            = "tv_maverick_origin"
tv_maverick_origin.controllers     = {{"maverick_AGM_65E",-1}}
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
