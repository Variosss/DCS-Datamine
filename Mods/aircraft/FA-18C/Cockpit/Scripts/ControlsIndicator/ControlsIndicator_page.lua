dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetCustomScale(1.0)

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end


local pitch_stick_real_range	= 7.5--9.03
local pitch_stick_part_positive	= 2.5/pitch_stick_real_range
local pitch_stick_part_negative	= 5.0/pitch_stick_real_range
local roll_stick_real_range		= 6.0
local roll_stick_part_left		= 0.5
local roll_stick_part_right		= 0.5


local aspect			= LockOn_Options.screen.aspect
local size_x			= 0.15	-- +-size_x
local size_y_positive	= size_x * 1.5 * pitch_stick_real_range / roll_stick_real_range * pitch_stick_part_positive
local size_y_negative	= size_x * 1.5 * pitch_stick_real_range / roll_stick_real_range * pitch_stick_part_negative
local tex_scale			= 0.25/size_x
local line_width		= (4.5/512)/tex_scale * 0.3


local roll_stick_movement           = 140
local k                             = size_x / roll_stick_movement
local pitch_stick_movement_positive = 0.76 * roll_stick_movement * 0.625 * k
local pitch_stick_movement_negative = 0.76 * roll_stick_movement * 0.375 * k
--[[
    CURR_SCREENSPACE_NONE = 0,
    CURR_SCREENSPACE_HUD_ONLY_VIEW = 1,
    CURR_SCREENSPACE_ARCADE = 2,
--]]

local ds				= 0.05 * size_x
local rud_shift			= 2*0.1*size_x
local rud_base_shift	= rud_shift --0.05*size_x
local orange_mat		= MakeMaterial("", {255, 100, 0, 50})
local rudder_shift		= 0.1*size_x

-- BASE -----------------------------------------------------------------------
base				= CreateElement "ceMeshPoly"
base.name			= "base"
base.primitivetype	= "triangles"
base.material		= orange_mat -- "GREEN_TRANSPARENT"
base.vertices		= {{-(size_x + rud_base_shift + 2*ds),	-(size_y_negative + 2 * ds + rud_base_shift)},	-- lower left, CW
                       {-(size_x + rud_base_shift + 2*ds),	size_y_positive  + ds},
                       { size_x  + ds,						size_y_positive  + ds},
                       { size_x  + ds,						-(size_y_negative + 2 * ds + rud_base_shift)}}        
base.indices		= default_box_indices
base.init_pos		= {0,-(1 - 2.0*size_x)}
base.controllers	= {{"show"},{"screenspace_position",2,-(aspect - 2.0*size_x),0},
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
pitch_scale.material		= "ARCADE"
pitch_scale.init_rot		= {90,0,0}
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
roll_scale.material			= "ARCADE"
roll_scale.tex_params		= {256/512, 176.5/512, tex_scale, 2*tex_scale}
roll_scale.parent_element	= base.name
AddElement(roll_scale)

-- STICK ----------------------------------------------------------------------
local stick_index_size = 0.1 * size_x

stick_position				= CreateElement "ceTexPoly"
stick_position.name			= "stick_position"
stick_position.vertices		= {	{-stick_index_size, -stick_index_size},
								{-stick_index_size,  stick_index_size},
								{ stick_index_size,  stick_index_size},
								{ stick_index_size, -stick_index_size}}
stick_position.indices		= default_box_indices
stick_position.material		= "ARCADE"
stick_position.tex_params	= {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
stick_position.controllers	= {	{"stick_pitch",	size_y_negative},
								{"stick_roll",	size_x}}
stick_position.parent_element	= base.name
AddElement(stick_position)

-- STICK TRIMMER --------------------------------------------------------------
trimmer_position				= CreateElement "ceTexPoly"
trimmer_position.name			= "trimmer_position"
trimmer_position.vertices		= {	{-stick_index_size, -stick_index_size},
								{-stick_index_size,  stick_index_size},
								{ stick_index_size,  stick_index_size},
								{ stick_index_size, -stick_index_size}}
trimmer_position.indices		= default_box_indices
trimmer_position.material		= "ARCADE"
trimmer_position.tex_params	= {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
trimmer_position.controllers	= {	{"trimmer_stick_pitch",	size_y_negative},
									{"trimmer_stick_roll",	size_x},
									{"scale",0.7,0.7}}
trimmer_position.parent_element	= base.name
AddElement(trimmer_position)

fcc_trim_base				= CreateElement "ceSimple"
fcc_trim_base.controllers	= {	{"fcc_trimmer_stick_pitch",	size_y_negative},
								{"fcc_trimmer_stick_roll",	size_x},
								{"scale",0.7,0.7}}
fcc_trim_base.name			= "fcc_trim_base"
fcc_trim_base.parent_element	= base.name
AddElement(fcc_trim_base)

fcc_trim_hor				= CreateElement "ceTexPoly"
fcc_trim_hor.name			= "fcc_trim_hor"
fcc_trim_hor.vertices		= {	{-rud_shift*0.5,	-line_width},
								{-rud_shift*0.5,	line_width},
								{rud_shift*0.5,	line_width},
								{rud_shift*0.5,	-line_width}}
fcc_trim_hor.indices		= default_box_indices
fcc_trim_hor.material		= "ARCADE"
fcc_trim_hor.tex_params		= {256/512, 176.5/512, tex_scale, 2*tex_scale}
fcc_trim_hor.parent_element	= fcc_trim_base.name
AddElement(fcc_trim_hor)

fcc_trim_ver				= Copy(fcc_trim_hor)
fcc_trim_ver.name			= "fcc_trim_ver"
fcc_trim_ver.init_rot		= {-90,0,0}
AddElement(fcc_trim_ver)

-- PEDALS ---------------------------------------------------------------------
rudder_scale				= Copy(roll_scale)
rudder_scale.name			= "rudder_scale"
rudder_scale.init_pos		= {0, -(size_y_negative + rudder_shift)}
AddElement(rudder_scale)

rudder_index				= Copy(roll_scale)
rudder_index.vertices		= {	{-rudder_shift,	-line_width},
								{-rudder_shift,	line_width},
								{rudder_shift,	line_width},
								{rudder_shift,	-line_width}}
rudder_index.controllers	= {{"rudder",size_x},{"rotate",math.rad(90)}}
rudder_index.parent_element	= rudder_scale.name
AddElement(rudder_index)


-- THROTTLE SCALE -------------------------------------------------------------
throttle_scale					= Copy(pitch_scale)
throttle_scale.name				= "throttle_scale"
throttle_scale.vertices		= {	{-size_y_negative*1.15,	-line_width},
								{-size_y_negative*1.15,	line_width},
								{size_y_positive,	line_width},
								{size_y_positive,	-line_width}}
throttle_scale.init_pos			= {-(size_x + rud_base_shift + ds), 0}
throttle_scale.parent_element	= base.name
AddElement(throttle_scale)

local throttleScaleL = size_y_negative*1.15 + size_y_positive
local throttleScaleD = -size_y_negative*1.15
idle_scale					= Copy(rudder_scale)
idle_scale.name				= "idle_scale"
idle_scale.vertices		= {	{-rud_shift*0.5,	-line_width},
							{-rud_shift*0.5,	line_width},
							{rud_shift*0.5,	line_width},
							{rud_shift*0.5,	-line_width}}
idle_scale.init_pos			= {0.1 * throttleScaleL + throttleScaleD, 0}
idle_scale.init_rot			= {-90,0,0}
idle_scale.parent_element	= throttle_scale.name
AddElement(idle_scale)

ab_scale				= Copy(idle_scale)
ab_scale.name			= "ab_scale"
ab_scale.vertices		= {	{-rud_shift*0.5,	-line_width},
							{-rud_shift*0.5,	line_width},
							{rud_shift*0.5,	line_width},
							{rud_shift*0.5,	-line_width}}
ab_scale.init_pos		= {0.77 * throttleScaleL + throttleScaleD, 0}
ab_scale.init_rot		= {-90,0,0}
ab_scale.parent_element	= throttle_scale.name
AddElement(ab_scale)

-- THROTTLE LEFT
throttleLeft_index					= Copy(roll_scale)
throttleLeft_index.vertices			= {	{-rud_shift,	-2*line_width},
										{-rud_shift,	2*line_width},
										{0*rud_shift,		2*line_width},
										{0*rud_shift,		-2*line_width}}
throttleLeft_index.init_pos			= {throttleScaleD, 0}
throttleLeft_index.init_rot			= {-90,0,0}
throttleLeft_index.controllers		= {{"throttlePos", 0, throttleScaleL},
									{"scale",1.0, 2.0}}
throttleLeft_index.parent_element	= throttle_scale.name
AddElement(throttleLeft_index)

-- THROTTLE RIGHT
throttleRight_index					= Copy(roll_scale)
throttleRight_index.vertices		= {	{-0*rud_shift,	-2*line_width},
										{-0*rud_shift,	2*line_width},
										{rud_shift,		2*line_width},
										{rud_shift,		-2*line_width}}
throttleRight_index.init_pos		= {throttleScaleD, 0}
throttleRight_index.init_rot		= {-90,0,0}
throttleRight_index.controllers		= {{"throttlePos", 1, throttleScaleL},
									{"scale",1.0, 2.0}}
throttleRight_index.parent_element	= throttle_scale.name
AddElement(throttleRight_index)

-- WHEEL BRAKES ---------------------------------------------------------------

local brakes_pos 		   = {size_x,rudder_scale.init_pos[2]}

local sz_wheel_brake       = 2.0 * pitch_stick_movement_negative

for i = 1,2 do

	local signum = {-1,1}
	local 	wheel_brake_mask                = CreateElement "ceMeshPoly"
			wheel_brake_mask.name		    = "wheel_brake_mask_"..tostring(i)
			wheel_brake_mask.primitivetype  = "triangles"
			wheel_brake_mask.vertices       = {{0                    ,0},
											   {0                    ,sz_wheel_brake},
											   {-signum[i] * 0.3 * sz_wheel_brake ,sz_wheel_brake},
											   {-signum[i] * 0.3 * sz_wheel_brake ,0}}
			wheel_brake_mask.indices		= {0,1,2,0,2,3}
			wheel_brake_mask.material	    = "MASK_MATERIAL_PURPLE"
			wheel_brake_mask.init_pos       = {signum[i] * brakes_pos[1],brakes_pos[2]}
			wheel_brake_mask.parent_element = base.name
			wheel_brake_mask.controllers    = {{"brakes_value",i,sz_wheel_brake}}
			wheel_brake_mask.h_clip_relation  = h_clip_relations.INCREASE_LEVEL
			wheel_brake_mask.isvisible      = false
			AddElement(wheel_brake_mask)

	local	wheel_brake                = CreateElement "ceMeshPoly"
			wheel_brake.name		   = "wheel_brake_"..tostring(i)
			wheel_brake.primitivetype  = "triangles"
			wheel_brake.vertices       = {{0 ,0},
										  {0 ,sz_wheel_brake},
										  { -signum[i] * 0.3 * sz_wheel_brake,sz_wheel_brake}}
			wheel_brake.indices		   = {0,1,2}
			wheel_brake.material	   = "ARCADE"
			wheel_brake.init_pos       =  wheel_brake_mask.init_pos
			wheel_brake.parent_element  = base.name
			wheel_brake.h_clip_relation = h_clip_relations.COMPARE
			wheel_brake.level		    = DEFAULT_LEVEL
			AddElement(wheel_brake)
			
	local 	wheel_brake_actual                = CreateElement "ceMeshPoly"
			wheel_brake_actual.name		   	  = "wheel_brake_actual_"..tostring(i)
--			wheel_brake_actual.primitivetype  = "triangles"
			wheel_brake_actual.vertices       = {{0                    ,-0.05 * sz_wheel_brake},
											     {0                    ,0.05 * sz_wheel_brake},
											     {-signum[i] * 0.3 * sz_wheel_brake ,0.05 * sz_wheel_brake},
											     {-signum[i] * 0.3 * sz_wheel_brake ,-0.05 * sz_wheel_brake}}
			wheel_brake_actual.indices	      = default_box_indices
			wheel_brake_actual.material	      = "ARCADE_WHITE"
			wheel_brake_actual.init_pos       = {signum[i] * brakes_pos[1],brakes_pos[2]}
			wheel_brake_actual.parent_element = base.name
			wheel_brake_actual.controllers    = {{"brakes_value_actual",i,sz_wheel_brake}}
			AddElement(wheel_brake_actual)

end