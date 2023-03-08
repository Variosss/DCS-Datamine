dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_RENDER_SCREEN_DEFS.lua")

local compass_x  = (2*(max_pixels_count - 120)/(max_pixels_count) - 1)*(max_pixels_count/2)
local compass_y  =  0.7*(max_pixels_count/2)

CompassSizeK = 1.6
local size_N_x	 = (0.5*(74.5 - 44.5)/ 512)
local size_N_y	 = (0.5*(496  - 462)/ 512)
local x_N		 =  44.5/512  + size_N_x
local y_N	 	 =  462/512   + size_N_y

compass_N 	   		  = CreateElement "ceTexPoly"
compass_N.name 		  = "compass_N"
compass_N.material	  = MFCD_GREY_2 
compass_N.vertices    = {{-size_N_x*(max_pixels_count/2) * CompassSizeK,  size_N_y*(max_pixels_count/2) * CompassSizeK}, 
			 			 { size_N_x*(max_pixels_count/2) * CompassSizeK,  size_N_y*(max_pixels_count/2) * CompassSizeK},
				 		 { size_N_x*(max_pixels_count/2) * CompassSizeK, -size_N_y*(max_pixels_count/2) * CompassSizeK},
					 	 {-size_N_x*(max_pixels_count/2) * CompassSizeK, -size_N_y*(max_pixels_count/2) * CompassSizeK}}
compass_N.indices     = box_ind
compass_N.tex_params  = {x_N, y_N, 2/(max_pixels_count) / CompassSizeK, 2/(max_pixels_count) / CompassSizeK,}
compass_N.init_pos    = {compass_x, compass_y, 0}
compass_N.controllers = {{"tgp_compass_rose_is_available", 1}}
Add(compass_N)
use_mipfilter(compass_N)	


CompassLineNS					= CreateElement "ceSimpleLineObject"
CompassLineNS.name				= "CompassLineNS"
CompassLineNS.material			= MFCD_GREY_2
CompassLineNS.width				= 2.2 * 1.3
CompassLineNS.tex_params		= {{0.1, 503.5 / 512}, {0.9, 503.5 / 512}, {texture_scale / 1.3, texture_scale * 2 / 1.3}}
CompassLineNS.vertices			= {{0, -1}, {0, 1}}
CompassLineNS.parent_element    = compass_N.name
Add(CompassLineNS)
use_mipfilter(CompassLineNS)

CompassLineWE = Copy(CompassLineNS)

CompassLineNS.controllers       = {{"tgp_compass_rose_NS_line"}}
CompassLineWE.controllers       = {{"tgp_compass_rose_WE_line"}}
Add(CompassLineWE)

local arrow_length  	= 0.03   * (max_pixels_count/2)

compass_arrow  				 = CreateElement "ceMeshPoly"
compass_arrow.name 			 = "compass_arrow"
compass_arrow.primitivetype  = "triangles"
compass_arrow.material	   	 = rendered_material 
compass_arrow.vertices  	 = {{ 0, arrow_length},
								{-arrow_length/2, 0},
								{ arrow_length/2, 0}}
compass_arrow.indices		 = {0,1,2} 
compass_arrow.parent_element = compass_N.name
compass_arrow.controllers    = {{"tgp_compass_arrow_pos"}}
Add(compass_arrow)

sz_los = 0.75

back2    			  = CreateElement "ceMeshPoly"
back2.name            = "back2"
back2.primitivetype   = "triangles"
back2.vertices        = {{0, 0},
					     {0, max_pixels_count},
						 {max_pixels_count, max_pixels_count},
						 {max_pixels_count, 0}}
back2.indices         = box_ind
back2.level		      = DEFAULT_LEVEL
back2.h_clip_relation = h_clip_relations.REWRITE_LEVEL
set_as_invisible_mask(back2)
SetLowerLeftCornerOrigin(back2)
Add(back2)


-- situational awareness cue should be clipped in the center area of TGP cross
los_clip_side = 13.5

-- open new level
los_clip_rect1 				   = CreateElement "ceMeshPoly"
los_clip_rect1.name            = "los_clip_rect1"
los_clip_rect1.primitivetype   = "triangles"
los_clip_rect1.vertices        =  {{-los_clip_side, -los_clip_side},
								   {-los_clip_side, los_clip_side},
								   {los_clip_side, los_clip_side},
								   {los_clip_side, -los_clip_side}}
los_clip_rect1.indices         = box_ind
los_clip_rect1.level		   = DEFAULT_LEVEL
los_clip_rect1.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
set_as_invisible_mask(los_clip_rect1)
Add(los_clip_rect1)


los_az_K = 1.08

los_position 	   			 = CreateElement "ceMeshPoly"
los_position.name 			 = "los_position"
los_position.primitivetype   = "triangles"
los_position.material	   	 =  rendered_material
los_position.vertices        = {{-0.013 * sz_los * geom_k, 0.013 *sz_los * geom_k},
								{ 0.013 * sz_los * geom_k, 0.013 *sz_los * geom_k},
								{ 0.013 * sz_los * geom_k,-0.013 *sz_los * geom_k},
								{-0.013 * sz_los * geom_k,-0.013 *sz_los * geom_k}}
los_position.indices		 = box_ind 
los_position.controllers   = {{"tgp_azimuth",-1},
							  {"move", 0, sz_los * geom_k * scale * los_az_K, 0},
							  {"tgp_elevation", sz_los * geom_k * scale * los_az_K / math.rad(90), 0}}
Add(los_position)
SetDefaultClipWithLevel(los_position)
use_mipfilter(los_position)

-- return everything back to the initial state
los_clip_rect2 				   = CreateElement "ceMeshPoly"
los_clip_rect2.name            = "los_clip_rect2"
los_clip_rect2.primitivetype   = "triangles"
los_clip_rect2.vertices        =  {{-los_clip_side, -los_clip_side},
								   {-los_clip_side, los_clip_side},
								   {los_clip_side, los_clip_side},
								   {los_clip_side, -los_clip_side}}
los_clip_rect2.indices         = box_ind
los_clip_rect2.level		   = DEFAULT_LEVEL + 1
los_clip_rect2.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
set_as_invisible_mask(los_clip_rect2)
Add(los_clip_rect2)


mils_per_half_size = 570 / 69.9 -- for 4 degrees area

function add_narrow(sz,controllers)

local base_obj 			  	   = CreateElement "ceSimple"
	  base_obj.controllers     = controllers
	  Add(base_obj)

local narrow_width = 10 * 4/570 * geom_k
local narrow_delta = rendered_line_width

local narrow_field_background = {}
	local tex_param = 2/570
	local narrow_tex = {}

	for i = 1,4 do
		narrow_tex[i] 			  	 = CreateElement "ceTexPoly"
		narrow_tex[i].material	   	 = MFCD_GREY_2
		narrow_tex[i].vertices       = {{-2 ,0},
										{-2 ,28},	
										{ 28,28},
										{ 28,-2}}
		narrow_tex[i].indices         =  box_ind
		narrow_tex[i].parent_element  =  base_obj.name
		narrow_tex[i].tex_params      = {461/512,495/512,tex_param,tex_param}
		Add(narrow_tex[i])
		use_mipfilter(narrow_tex[i])
	end
	narrow_tex[1].init_pos       = {-sz,-sz,0}
	narrow_tex[2].init_pos       = {-sz, sz,0}
	narrow_tex[2].init_rot       = {-90,0,0}
	narrow_tex[3].init_pos       = { sz, sz,0}
	narrow_tex[3].init_rot       = {180,0,0}
	narrow_tex[4].init_pos       = { sz,-sz,0}
	narrow_tex[4].init_rot       = {90,0,0}
	
end

add_narrow(1/3.5 * geom_k,{{"tgp_FOV"}, {"tgp_video_mode",0}})
add_narrow(0.25  * geom_k,{{"tgp_FOV"}, {"tgp_flir"}})
add_frame()
add_priority_target()

texture_scale = 1 / 570

function set_cross_hair(gate_sz, cross_hair_sz)

local   base_cross_hair 			  	= CreateElement "ceSimple"
	    Add(base_cross_hair)
        
        local lines ={}
		for i = 1, 4 do
			lines[i] = line_2_pixel({{0.5 * gate_sz,0},{cross_hair_sz,0}},MFCD_GREY_2)
			lines[i].parent_element  = base_cross_hair.name
			lines[i].init_rot        = {90 * (i - 1),0,0}
		end
		return base_cross_hair
end


-- for CCD  Wide = 61.1 mils Narrow = 17.45


function add_ir_brackets(parent,gate_sz,cross_hair_sz)

local   base_brackets 			  	= CreateElement "ceSimple"
		base_brackets.controllers	= {{"tgp_designator_type",1,2}}
		base_brackets.parent_element = parent.name
	    Add(base_brackets)

local  cross_sz					 = cross_hair_sz * mils_per_half_size
local  tick_sz					 = 0.5 * gate_sz * mils_per_half_size
local  lines ={}
		for i = 1,4 do
			lines[i] = line_2_pixel({{cross_sz,-tick_sz},{cross_sz, tick_sz}},MFCD_GREY_2)
			lines[i].parent_element  = base_brackets.name
			lines[i].init_rot        = {90 * (i - 1),0,0}
		end
end

function add_yardstick(parent,gate_sz,cross_hair_sz)

local   yardstick_sz 		   =  mils_per_half_size *  (cross_hair_sz - 0.5 * gate_sz)  / 570	
local   tgp_yardstick 		   = {}
local 	tgp_yardstick_formats  = {{"%.fM"},{"%.fF"}}
local   tgp_yardstick_control  = {{"tgp_yardstick_value", 0, yardstick_sz, 1},
								  {"tgp_yardstick_value", 0, yardstick_sz, 3.28084}}

	for i = 1, 2 do
		tgp_yardstick[i]						= CreateElement "ceStringPoly"
		tgp_yardstick[i].material				= font_TGP
		tgp_yardstick[i].alignment				= "RightBottom"
		tgp_yardstick[i].stringdefs				= rendered_font_defs
		tgp_yardstick[i].init_pos           	= {0.65 * geom_k,0.03 * geom_k,0}
		tgp_yardstick[i].formats 				= tgp_yardstick_formats[i]
		tgp_yardstick[i].controllers			= {{"tgp_master_mode_is_AA", 0}, 
		                                           {"tgp_yardstick_metric", i},
												   tgp_yardstick_control[i]}
		tgp_yardstick[i].parent_element 		= parent.name
		Add(tgp_yardstick[i])
		use_mipfilter(tgp_yardstick[i])
	end
end

function cross_and_gate(parent, gate_sz, cross_hair_sz)

local   base_cross_hair 			  	= CreateElement "ceSimple"
		base_cross_hair.parent_element  = parent.name
	    base_cross_hair.controllers     = {{"tgp_enlarged_cross_hair",0}, {"tgp_lss_active",0}}
	    Add(base_cross_hair)
	
local   base_cross_hair_enlarged 			  	 = Copy(base_cross_hair)
	    base_cross_hair_enlarged.controllers     = {{"tgp_enlarged_cross_hair"}, {"tgp_lss_active",0}}
	    Add(base_cross_hair_enlarged)	
		
		local normal   = set_cross_hair(gate_sz * mils_per_half_size, cross_hair_sz * mils_per_half_size)
			  normal.parent_element =  base_cross_hair.name
			  normal.controllers =  {{"tgp_masked_blinking", 64}}
			  
		local enlarged = set_cross_hair(gate_sz * mils_per_half_size, 2 * cross_hair_sz * mils_per_half_size)
			  enlarged.parent_element =  base_cross_hair_enlarged.name
			  enlarged.controllers =  {{"tgp_masked_blinking", 64}}
			  
		local lss_lst  = set_cross_hair(gate_sz * mils_per_half_size, 569/2)
			  lss_lst.controllers =  {{"tgp_lss_active"}, {"tgp_masked_blinking", 64}}
	  
		add_ir_brackets(normal, gate_sz, cross_hair_sz)
		add_ir_brackets(enlarged, gate_sz, 2 * cross_hair_sz)
		add_yardstick(base_cross_hair, gate_sz, cross_hair_sz)
		add_yardstick(base_cross_hair_enlarged, gate_sz, 2 * cross_hair_sz)
end



--Narrow cross hair and gap
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
base_narrow = dummy({{"tgp_FOV",1}})
base_wide_CCD = dummy({{"tgp_FOV"}, {"tgp_video_mode", 0}})
base_wide_FLIR = dummy({{"tgp_FOV"}, {"tgp_flir"}})

cross_and_gate(base_narrow, 0.85 * 4, 1.9 * 4)
cross_and_gate(base_wide_CCD, 3.1 * 4 / 3.5, 6.6 * 4 / 3.5)
cross_and_gate(base_wide_FLIR, 3.5, 7.6)

txt_track_mode = {}

for i = 1, 6 do
	txt_track_mode[i]					= CreateElement "ceStringPoly"
	txt_track_mode[i].name				= "txt_track_mode"..string.format("%d",i)
	txt_track_mode[i].material			= font_TGP
	txt_track_mode[i].init_pos			= {0, -0.5 * geom_k, 0}
	txt_track_mode[i].alignment			= "RightCenter"
	txt_track_mode[i].stringdefs		= rendered_font_defs
	txt_track_mode[i].controllers 		= {{"tgp_lss_active",0},{"tgp_track_mode",i}}
	use_mipfilter(txt_track_mode[i])
	Add(txt_track_mode[i])
end

txt_track_mode[1].value = "AREA"
txt_track_mode[2].value = "POINT"
txt_track_mode[3].value = "INR"
txt_track_mode[4].value = "INR-A"
txt_track_mode[5].value = "INR-P"
txt_track_mode[6].value = "RATES"
	

txt_LSS_mode = {}

for i = 1,4 do
	txt_LSS_mode[i]						= CreateElement "ceStringPoly"
	txt_LSS_mode[i].name				= "txt_LSS_mode"..string.format("%d",i)
	txt_LSS_mode[i].material			= font_TGP
	txt_LSS_mode[i].init_pos			= {0, -0.5 * geom_k, 0}
	txt_LSS_mode[i].alignment			= "CenterCenter"
	txt_LSS_mode[i].stringdefs			= rendered_font_defs
	txt_LSS_mode[i].controllers 		= {{"tgp_lss_mode",i}}
	use_mipfilter(txt_LSS_mode[i])
	Add(txt_LSS_mode[i])
end

txt_LSS_mode[1].value = "NOLSR"
txt_LSS_mode[2].value = "LSRCH"
txt_LSS_mode[3].value = "DETECT"
txt_LSS_mode[4].value = "LTRACK"

	
TGP_current_designator_OSB = {}
for i = 0, 2 do
	TGP_current_designator_OSB[i]						= CreateElement "ceStringPoly"
	TGP_current_designator_OSB[i].name					= "TGP_current_designator_OSB"..string.format("%d",i)
	TGP_current_designator_OSB[i].material				= font_TGP
	TGP_current_designator_OSB[i].alignment				= "RightCenter"
	TGP_current_designator_OSB[i].stringdefs			= rendered_font_defs
	TGP_current_designator_OSB[i].init_pos           	= {0.25* geom_k, -0.5 * geom_k, 0}
	TGP_current_designator_OSB[i].controllers			= {{"tgp_master_mode_is_AA", 0},
															{"tgp_lss_active", 0},
															{"tgp_designator_type", i},
															{"tgp_designator_fire_blinking", 16}}
	Add(TGP_current_designator_OSB[i])
	use_mipfilter(TGP_current_designator_OSB[i])
end

TGP_current_designator_OSB[0].value	= "L"
TGP_current_designator_OSB[1].value	= "P"
TGP_current_designator_OSB[2].value	= "B"

TGP_current_designator_mode				= Copy(TGP_current_designator_OSB[0])
TGP_current_designator_mode.value		= "T "
TGP_current_designator_mode.controllers	= {{"tgp_master_mode_is_AA", 0},
											{"tgp_lss_active", 0},
											{"tgp_laser_arm_training"},
											{"tgp_designator_type",0,2}}
Add(TGP_current_designator_mode)


TGP_mask_zone_ID					= CreateElement "ceStringPoly"
TGP_mask_zone_ID.name				= "TGP_mask_zone_ID"
TGP_mask_zone_ID.material			= font_TGP
TGP_mask_zone_ID.alignment			= "RightCenter"
TGP_mask_zone_ID.stringdefs			= rendered_font_defs
TGP_mask_zone_ID.init_pos           = {-0.67 * geom_k, 0.69 * geom_k, 0}
TGP_mask_zone_ID.value				= "M4"
TGP_mask_zone_ID.controllers        = {{"tgp_master_mode_is_AA", 0}}
Add(TGP_mask_zone_ID)
use_mipfilter(TGP_mask_zone_ID)


TGP_AlignmentQualityIndicator			   = Copy(TGP_mask_zone_ID)
TGP_AlignmentQualityIndicator.init_pos     = {-0.729 * geom_k,-0.38 * geom_k, 0}
TGP_AlignmentQualityIndicator.formats      = {"%d"}
TGP_AlignmentQualityIndicator.controllers  = {{"tgp_master_mode_is_AA", 0}, {"tgp_AlignmentQualityIndicator"}}
Add(TGP_AlignmentQualityIndicator)

TGP_LaserMasked			  	= Copy(TGP_mask_zone_ID)
TGP_LaserMasked.init_pos    = {0.35 * geom_k, -0.5 * geom_k, 0}
TGP_LaserMasked.value	 	= "M"
TGP_LaserMasked.controllers = {{"tgp_master_mode_is_AA", 0}, {"tgp_masked", 1}}
Add(TGP_LaserMasked)

tgp_distance_source 				= {}
for i = 1, 3 do
	tgp_distance_source[i]						= CreateElement "ceStringPoly"
	tgp_distance_source[i].name					= "tgp_distance_source"..string.format("%d",i)
	tgp_distance_source[i].material				= font_TGP
	tgp_distance_source[i].alignment			= "RightCenter"
	tgp_distance_source[i].stringdefs			= rendered_font_defs
	tgp_distance_source[i].init_pos           	= {0.45 * geom_k, -0.5 * geom_k, 0}
	tgp_distance_source[i].controllers			= {{"tgp_master_mode_is_AA", 0}, {"tgp_range_source",i}}
	Add(tgp_distance_source[i])
	use_mipfilter(tgp_distance_source[i])
end
tgp_distance_source[1].value = "L"
tgp_distance_source[2].value = "T"
tgp_distance_source[3].value = "E"

tgp_distance 						= CreateElement "ceStringPoly"
tgp_distance.name					= "tgp_distance"
tgp_distance.material				= font_TGP
tgp_distance.alignment				= "RightCenter"
tgp_distance.stringdefs				= rendered_font_defs
tgp_distance.init_pos           	= {0.8 * geom_k, -0.5 * geom_k, 0}
tgp_distance.formats				= {"%.1f"}
tgp_distance.controllers			= {{"tgp_master_mode_is_AA", 0}, {"tgp_range", 0, 1/1852.0}}
Add(tgp_distance)
use_mipfilter(tgp_distance)

tgp_flir_autofocus						= CreateElement "ceStringPoly"
tgp_flir_autofocus.name					= "tgp_flir_autofocus"
tgp_flir_autofocus.material				= font_TGP
tgp_flir_autofocus.alignment			= "RightCenter"
tgp_flir_autofocus.stringdefs			= rendered_font_defs
tgp_flir_autofocus.init_pos           	= {0.25 * geom_k, 0.5 * geom_k, 0}
tgp_flir_autofocus.formats				= {"FOCUS  %.f"}
tgp_flir_autofocus.controllers			= {{"tgp_flir"},
										   {"tgp_focus_adjustment",1},
										   {"tgp_focus",0}}
Add(tgp_flir_autofocus)
use_mipfilter(tgp_flir_autofocus)			

tgp_flir_focus						= CreateElement "ceStringPoly"
tgp_flir_focus.name					= "tgp_flir_focus"
tgp_flir_focus.material				= font_TGP
tgp_flir_focus.alignment			= "CenterCenter"
tgp_flir_focus.stringdefs			= rendered_font_defs
tgp_flir_focus.init_pos           	= {0, 0.5 * geom_k, 0}
tgp_flir_focus.formats				= {"%.fF"}
tgp_flir_focus.controllers			= {{"tgp_test_gray_scale"},
									   {"tgp_focus_adjustment",0},
									   {"tgp_test_gray_focus"},
									   {"tgp_focus",0}}
Add(tgp_flir_focus)
use_mipfilter(tgp_flir_focus)	

--TODO: to adjust the font. Looks slightly ugly.
--
TGP_FLIR_HOT						= CreateElement "ceStringPoly"
TGP_FLIR_HOT.name					= "TGP_FLIR_HOT"
TGP_FLIR_HOT.material				= font_TGP
TGP_FLIR_HOT.alignment				= "CenterCenter"
TGP_FLIR_HOT.stringdefs				= rendered_font_defs
TGP_FLIR_HOT.value					= "FLIR HOT"
TGP_FLIR_HOT.init_pos           	= {-0.025 * geom_k, 0.45 * geom_k, 0}
TGP_FLIR_HOT.controllers			= {{"tgp_flir_hot"}, {"tgp_power"}}
Add(TGP_FLIR_HOT)
use_mipfilter(TGP_FLIR_HOT)	

tgp_gimbal_roll						=  CreateElement "ceStringPoly"
tgp_gimbal_roll.name				= "tgp_flir_autofocus1"
tgp_gimbal_roll.material			= font_TGP
tgp_gimbal_roll.alignment			= "CenterCenter"
tgp_gimbal_roll.stringdefs			= rendered_font_defs
tgp_gimbal_roll.init_pos           	= {0 * 0.25 * geom_k, 0.5 * geom_k, 0}
tgp_gimbal_roll.value				= "GIMB ROLL"
tgp_gimbal_roll.controllers			= {{"tgp_gimbal_roll",math.rad(500)}}
Add(tgp_gimbal_roll)
use_mipfilter(tgp_gimbal_roll)			

tgp_gimbal_roll_positive 					=  CreateElement "ceStringPoly"
tgp_gimbal_roll_positive.name				= "tgp_gimbal_roll_positive"
tgp_gimbal_roll_positive.material			= font_TGP
tgp_gimbal_roll_positive.alignment			= "CenterCenter"
tgp_gimbal_roll_positive.stringdefs			= rendered_font_defs
tgp_gimbal_roll_positive.value				= "          >"
tgp_gimbal_roll_positive.controllers		= {{"tgp_roll_sign"}}
tgp_gimbal_roll_positive.parent_element 	= tgp_gimbal_roll.name									   
Add(tgp_gimbal_roll_positive)
use_mipfilter(tgp_gimbal_roll_positive)			

tgp_gimbal_roll_negative = Copy(tgp_gimbal_roll_positive)
tgp_gimbal_roll_negative.value = "<          "
tgp_gimbal_roll_negative.controllers		= {{"tgp_roll_sign",-1}}
Add(tgp_gimbal_roll_negative)
