dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

local color_red = {255, 0, 0, 255}
local arcade_red_material = MakeMaterial("Bazar/Textures/AvionicsCommon/arcade.tga", color_red)
local color_white = {255, 255, 255, 255}
local arcade_white_material = MakeMaterial("Bazar/Textures/AvionicsCommon/arcade.tga", color_white)
local color_grey = {190, 190, 190, 255}
local arcade_grey_material = MakeMaterial("Bazar/Textures/AvionicsCommon/arcade.tga", color_grey)

local mask_material = MakeMaterial(nil, {255, 0, 255, 30})

local font_xsz = 49
local font_ysz = 57
local fontdesc = {	
	texture    = LockOn_Options.script_path.."../../Common/Resources/IndicationTextures/font_gen.tga",	
	size       = {9, 9},
	resolution = {512, 512},
	default    = {font_xsz, font_ysz},
	chars	   = {
		{32, font_xsz, font_ysz}, --[space]
		{33, font_xsz, font_ysz}, --!
		{34, font_xsz, font_ysz}, --"
		{43, font_xsz, font_ysz}, --+
		{45, font_xsz, font_ysz}, ---
		{46, 30, font_ysz}, --.
		{47, font_xsz, font_ysz}, --/
		{48, font_xsz, font_ysz}, --0
		{49, font_xsz, font_ysz}, --1
		{50, font_xsz, font_ysz}, --2
		{51, font_xsz, font_ysz}, --3
		{52, font_xsz, font_ysz}, --4
		{53, font_xsz, font_ysz}, --5
		{54, font_xsz, font_ysz}, --6
		{55, font_xsz, font_ysz}, --7
		{56, font_xsz, font_ysz}, --8
		{57, font_xsz, font_ysz}, --9
		{58, font_xsz, font_ysz}, --:
		{65, font_xsz, font_ysz}, --A
		{66, font_xsz, font_ysz}, --B
		{67, font_xsz, font_ysz}, --C
		{68, font_xsz, font_ysz}, --D
		{69, font_xsz, font_ysz}, --E
		{70, font_xsz, font_ysz}, --F
		{71, font_xsz, font_ysz}, --G
		{72, font_xsz, font_ysz}, --H
		{73, font_xsz, font_ysz}, --I
		{74, font_xsz, font_ysz}, --J
		{75, font_xsz, font_ysz}, --K
		{76, font_xsz, font_ysz}, --L
		{77, font_xsz, font_ysz}, --M
		{78, font_xsz, font_ysz}, --N
		{79, font_xsz, font_ysz}, --O
		{80, font_xsz, font_ysz}, --P
		{81, font_xsz, font_ysz}, --Q
		{82, font_xsz, font_ysz}, --R
		{83, font_xsz, font_ysz}, --S
		{84, font_xsz, font_ysz}, --T
		{85, font_xsz, font_ysz}, --U
		{86, font_xsz, font_ysz}, --V
		{87, font_xsz, font_ysz}, --W
		{88, font_xsz, font_ysz}, --X
		{89, font_xsz, font_ysz}, --Y
		{90, font_xsz, font_ysz}, --Z
		{92, font_xsz, font_ysz}, --\
		{124, font_xsz, font_ysz}, --|
	}
}

local controlsIndicatorFont = MakeFont(fontdesc, color_red, "controlsIndicatorFont")
 
SetCustomScale(1.0)

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end


local pitch_stick_real_range	= 9.03125

local pitch_stick_range_up = 14
local pitch_stick_range_down = 26
local pitch_stick_range_equalizer = 6 --6.5 -- positive value moves center down
local pitch_stick_part_positive	= (pitch_stick_range_up + pitch_stick_range_equalizer) / (pitch_stick_range_up + pitch_stick_range_down)
local pitch_stick_part_negative	= (pitch_stick_range_down - pitch_stick_range_equalizer) / (pitch_stick_range_up + pitch_stick_range_down)

local roll_stick_real_range		= 11.875
local roll_stick_part_left		= 0.5
local roll_stick_part_right		= 0.5


local aspect			= LockOn_Options.screen.aspect
local size_x			= 0.15	-- +-size_x
local size_y_positive	= size_x * 2.0 * pitch_stick_real_range / roll_stick_real_range * pitch_stick_part_positive
local size_y_negative	= size_x * 2.0 * pitch_stick_real_range / roll_stick_real_range * pitch_stick_part_negative
local tex_scale			= 0.25/size_x
local line_width		= (4.5/512)/tex_scale * 0.3
local rudder_y_gap      = 0.1 * size_x

local roll_stick_movement           = 140
local k                             = size_x / roll_stick_movement
local pitch_stick_movement_positive = 0.76 * roll_stick_movement * 0.625 * k
local pitch_stick_movement_negative = 0.76 * roll_stick_movement * 0.375 * k

local ds				= 0.05 * size_x
local rud_shift			= 2*0.1*size_x
local rud_base_shift	= rud_shift --0.05*size_x
local orange_mat		= MakeMaterial("", {255, 100, 0, 50})
local rudder_shift		= 0.1*size_x
local AB_detent_width	= rud_shift * 0.2

-- BASE -----------------------------------------------------------------------
base				= CreateElement "ceMeshPoly"
base.name			= "base"
base.primitivetype	= "triangles"
base.material		= orange_mat -- "GREEN_TRANSPARENT"
base.vertices		= {{-(size_x + rud_shift + rud_base_shift + 2*ds),	-(size_y_negative + 2 * ds + rudder_shift + rudder_y_gap)},	-- lower left, CW
                       {-(size_x + rud_shift + rud_base_shift + 2*ds),	size_y_positive  + ds},
                       { size_x  + ds,					size_y_positive  + ds},
                       { size_x  + ds,					-(size_y_negative + 2 * ds + rudder_shift + rudder_y_gap)}}        
base.indices		= default_box_indices
base.init_pos		= {0,-(1 - 1.5*size_x)}
base.controllers	= {{"show"},{"screenspace_position",2,-(aspect - 2*size_x),0},
                                {"screenspace_position",1,0,0}}
base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
base.level			= DEFAULT_LEVEL
AddElement(base)

-- STICK SCALE-----------------------------------------------------------------
pitch_scale					= CreateElement "ceTexPoly"
pitch_scale.name			= "pitch_scale"
pitch_scale.vertices		= {	{-size_y_negative,	-line_width},
								{-size_y_negative,	line_width},
								{size_y_positive,	line_width},
								{size_y_positive,	-line_width}}
pitch_scale.indices			= default_box_indices
pitch_scale.material		= arcade_red_material
pitch_scale.init_rot		= {90}
pitch_scale.tex_params		= {256/512,176.5/512,0.5*tex_scale,2*tex_scale}
pitch_scale.parent_element	= base.name
AddElement(pitch_scale)

roll_scale					= CreateElement "ceTexPoly"
roll_scale.name				= "roll_scale"
roll_scale.vertices			= {	{-size_x,	-line_width},
								{-size_x,	line_width},
								{size_x,	line_width},
								{size_x,	-line_width}}
roll_scale.indices			= default_box_indices
roll_scale.material			= arcade_red_material
roll_scale.tex_params		= {256/512, 176.5/512, tex_scale, 2*tex_scale}
roll_scale.parent_element	= base.name
AddElement(roll_scale)

-- STICK ----------------------------------------------------------------------
local stick_index_size = 0.1 * size_x

trimmer_stick_position					= CreateElement "ceTexPoly"
trimmer_stick_position.name				= "trimmer_stick_position"
trimmer_stick_position.vertices			= {	{-stick_index_size, -stick_index_size},
											{-stick_index_size,  stick_index_size},
											{ stick_index_size,  stick_index_size},
											{ stick_index_size, -stick_index_size}}
trimmer_stick_position.indices			= default_box_indices
trimmer_stick_position.material			= arcade_red_material
trimmer_stick_position.tex_params		= {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
trimmer_stick_position.controllers		= {	{"trimmer_stick_pitch", size_y_negative},
											{"trimmer_stick_roll" , size_x},
											{"scale",0.5,0.5}}
trimmer_stick_position.parent_element	= base.name
AddElement(trimmer_stick_position)

stick_aux2_position				= CreateElement "ceTexPoly"
stick_aux2_position.name		= "stick_aux2_position"
stick_aux2_position.vertices	= {	{-stick_index_size, -stick_index_size},
									{-stick_index_size,  stick_index_size},
									{ stick_index_size,  stick_index_size},
									{ stick_index_size, -stick_index_size}}
stick_aux2_position.indices		= default_box_indices
stick_aux2_position.material	= arcade_grey_material
stick_aux2_position.tex_params	= {394/512, 257 / 512, 2*tex_scale, 2*tex_scale}
stick_aux2_position.controllers	= {	{"combined_controls_enabled"},
									{"stick_pitch", 2, -size_y_negative},
									{"stick_roll", 2, size_x}}
stick_aux2_position.parent_element	= base.name
AddElement(stick_aux2_position)

stick_aux1_position				= CreateElement "ceTexPoly"
stick_aux1_position.name		= "stick_aux1_position"
stick_aux1_position.vertices	= {	{-stick_index_size, -stick_index_size},
									{-stick_index_size,  stick_index_size},
									{ stick_index_size,  stick_index_size},
									{ stick_index_size, -stick_index_size}}
stick_aux1_position.indices		= default_box_indices
stick_aux1_position.material	= arcade_white_material
stick_aux1_position.tex_params	= {394/512, 257 / 512, 2*tex_scale, 2*tex_scale}
stick_aux1_position.controllers	= {	{"combined_controls_enabled"},
									{"stick_pitch", 1, -size_y_negative},
									{"stick_roll", 1, size_x}}
stick_aux1_position.parent_element	= base.name
AddElement(stick_aux1_position)

stick_position					= CreateElement "ceTexPoly"
stick_position.name				= "stick_position"
stick_position.vertices			= {	{-stick_index_size, -stick_index_size},
									{-stick_index_size,  stick_index_size},
									{ stick_index_size,  stick_index_size},
									{ stick_index_size, -stick_index_size}}
stick_position.indices			= default_box_indices
stick_position.material			= arcade_red_material
stick_position.tex_params		= {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
stick_position.controllers		= {	{"stick_pitch", 0, -size_y_negative},
									{"stick_roll", 0, size_x}}
stick_position.parent_element	= base.name
AddElement(stick_position)

-- PEDALS ---------------------------------------------------------------------
rudder_scale						= Copy(roll_scale)
rudder_scale.name					= "rudder_scale"
rudder_scale.init_pos				= {0, -(size_y_negative + rudder_shift + rudder_y_gap)}
AddElement(rudder_scale)

rudder_index_aux_2					= Copy(roll_scale)
rudder_index_aux_2.vertices			= {	{-rudder_shift,	-line_width},
										{-rudder_shift,	line_width},
										{rudder_shift,	line_width},
										{rudder_shift,	-line_width}}
rudder_index_aux_2.material			= arcade_grey_material
rudder_index_aux_2.controllers		= {{"combined_controls_enabled"}, {"rudder", 2, size_x}, {"rotate",math.rad(90)}}
rudder_index_aux_2.parent_element	= rudder_scale.name
AddElement(rudder_index_aux_2)

rudder_index_aux_1					= Copy(rudder_index_aux_2)
rudder_index_aux_1.material			= arcade_white_material
rudder_index_aux_1.controllers		= {{"combined_controls_enabled"}, {"rudder", 1, size_x}, {"rotate",math.rad(90)}}
AddElement(rudder_index_aux_1)

rudder_index						= Copy(rudder_index_aux_1)
rudder_index.controllers			= {{"rudder", 0, size_x}, {"rotate", math.rad(90)}}
rudder_index.material				= arcade_red_material
AddElement(rudder_index)


-- THROTTLE SCALE -------------------------------------------------------------
throttle_scale						= Copy(pitch_scale)
throttle_scale.name					= "throttle_scale"
throttle_scale.init_pos				= {-(size_x + rud_base_shift + ds), 0}
throttle_scale.parent_element		= base.name
AddElement(throttle_scale)

-- THROTTLE
throttle_index_aux_2				= Copy(roll_scale)
throttle_index_aux_2.vertices		= {	{-0*rud_shift,	-line_width},
										{-0*rud_shift,	 line_width},
										{rud_shift,		 line_width},
										{rud_shift,		-line_width}}
throttle_index_aux_2.init_pos		= {-size_y_negative, 0}
throttle_index_aux_2.init_rot		= {-90}
throttle_index_aux_2.material		= arcade_grey_material
throttle_index_aux_2.controllers	= {{"combined_controls_enabled"}, {"throttle", 2, size_y_positive + size_y_negative},
										{"scale", 1.0, 2.0}}
throttle_index_aux_2.parent_element	= throttle_scale.name
AddElement(throttle_index_aux_2)

throttle_index_aux_1				= Copy(throttle_index_aux_2)
throttle_index_aux_1.material		= arcade_white_material
throttle_index_aux_1.controllers	= {{"combined_controls_enabled"}, {"throttle", 1, size_y_positive + size_y_negative},
										{"scale", 1.0, 2.0}}
AddElement(throttle_index_aux_1)

throttle_index						= Copy(throttle_index_aux_1)
throttle_index.material				= arcade_red_material
throttle_index.controllers			= {{"throttle", 0, size_y_positive + size_y_negative},
										{"scale", 1.0, 2.0}}
AddElement(throttle_index)

AB_detent							= Copy(throttle_index)
AB_detent.vertices					= {	{-AB_detent_width,	-line_width},
										{-AB_detent_width,	 line_width},
										{AB_detent_width,	 line_width},
										{AB_detent_width,	-line_width}}
AB_detent.init_pos					= {-size_y_negative, -AB_detent_width}
AB_detent.controllers				= {{"AB_detentPos", size_y_positive + size_y_negative}}
AddElement(AB_detent)

local parking_brake_pos = {-size_x, 1.5 * pitch_stick_movement_negative - ds}

txt_brakes                 = CreateElement "ceStringPoly"
txt_brakes.name            = "txt_brakes"
txt_brakes.material        = controlsIndicatorFont
txt_brakes.init_pos		   = parking_brake_pos
txt_brakes.alignment       = "LeftBottom"
txt_brakes.stringdefs      = {0.0035, 0.0035, 0, 0}
txt_brakes.value           = "B"
txt_brakes.controllers     = {{"parking_brake"}}
txt_brakes.parent_element  = base.name
AddElement(txt_brakes)


-- WHEEL BRAKES ---------------------------------------------------------------

local brakes_pos 		   = {size_x, rudder_scale.init_pos[2]}
local sz_wheel_brake       = 2.0 * pitch_stick_movement_negative

for i = 1,2 do

	local signum = {-1,1}
	local 	wheel_brake_mask                	= CreateElement "ceMeshPoly"
			wheel_brake_mask.name		    	= "wheel_brake_mask_"..tostring(i)
			wheel_brake_mask.primitivetype  	= "triangles"
			wheel_brake_mask.vertices       	= {{0, 0},
												   {0, sz_wheel_brake},
												   {-signum[i] * 0.3 * sz_wheel_brake, sz_wheel_brake},
												   {-signum[i] * 0.3 * sz_wheel_brake, 0}}
			wheel_brake_mask.indices			= default_box_indices
			wheel_brake_mask.material	    	= mask_material
			wheel_brake_mask.init_pos       	= {signum[i] * brakes_pos[1],brakes_pos[2]}
			wheel_brake_mask.parent_element 	= base.name
			wheel_brake_mask.controllers    	= {{"brakes_value",i,sz_wheel_brake}}
			wheel_brake_mask.h_clip_relation  	= h_clip_relations.INCREASE_LEVEL
			wheel_brake_mask.isvisible      	= false
			AddElement(wheel_brake_mask)

	local	wheel_brake                			= CreateElement "ceMeshPoly"
			wheel_brake.name		   			= "wheel_brake_"..tostring(i)
			wheel_brake.primitivetype  			= "triangles"
			wheel_brake.vertices       			= {{0 ,0},
												   {0 ,sz_wheel_brake},
												   { -signum[i] * 0.3 * sz_wheel_brake,sz_wheel_brake}}
			wheel_brake.indices		   			= {0,1,2}
			wheel_brake.material	   			= arcade_red_material
			wheel_brake.init_pos       			=  wheel_brake_mask.init_pos
			wheel_brake.parent_element  		= base.name
			wheel_brake.h_clip_relation 		= h_clip_relations.COMPARE
			wheel_brake.level		    		= DEFAULT_LEVEL
			AddElement(wheel_brake)

	local 	wheel_brake_actual                	= CreateElement "ceMeshPoly"
			wheel_brake_actual.name		   	  	= "wheel_brake_actual_"..tostring(i)
			wheel_brake_actual.vertices       	= {{0, -0.05 * sz_wheel_brake},
													{0, 0.05 * sz_wheel_brake},
													{-signum[i] * 0.3 * sz_wheel_brake, 0.05 * sz_wheel_brake},
													{-signum[i] * 0.3 * sz_wheel_brake, -0.05 * sz_wheel_brake}}
			wheel_brake_actual.indices	      	= default_box_indices
			wheel_brake_actual.material	      	= arcade_red_material
			wheel_brake_actual.init_pos       	= {signum[i] * brakes_pos[1],brakes_pos[2]}
			wheel_brake_actual.parent_element 	= base.name
			wheel_brake_actual.controllers    	= {{"brakes_value_actual",i,sz_wheel_brake}}
			AddElement(wheel_brake_actual)

end

txt_control_priority                 = CreateElement "ceStringPoly"
txt_control_priority.name            = "txt_control_priority"
txt_control_priority.material        = controlsIndicatorFont
txt_control_priority.init_pos		 = {0.75 * size_x, 1.5 * pitch_stick_movement_negative - ds}
txt_control_priority.alignment       = "LeftBottom"
txt_control_priority.stringdefs      = {0.0035, 0.0035, 0, 0}
txt_control_priority.value           = "F"
txt_control_priority.controllers     = {{"control_priority"}}
txt_control_priority.parent_element  = base.name
AddElement(txt_control_priority)
