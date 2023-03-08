dofile(LockOn_Options.common_script_path.."elements_defs.lua")

local texture_red = MakeMaterial("Bazar/Textures/AvionicsCommon/arcade.tga",{255, 0, 0, 255})
local texture_white = MakeMaterial("Bazar/Textures/AvionicsCommon/arcade.tga",{255, 255, 255, 255})
local texture_black = MakeMaterial("Bazar/Textures/AvionicsCommon/arcade.tga",{0, 0, 0, 255})

SetCustomScale(1.0)

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end


local pitch_stick_real_range	= 9.03125
local pitch_stick_part_positive	= (14+6.5)/(14+26)
local pitch_stick_part_negative	= (26-6.5)/(14+26)
local roll_stick_real_range		= 11.875
local roll_stick_part_left		= 0.5
local roll_stick_part_right		= 0.5


local aspect			= LockOn_Options.screen.aspect
local size_x			= 0.15	-- +-size_x
local size_y_positive	= size_x * 2.0 * pitch_stick_real_range / roll_stick_real_range * pitch_stick_part_positive
local size_y_negative	= size_x * 2.0 * pitch_stick_real_range / roll_stick_real_range * pitch_stick_part_negative
local tex_scale			= 0.25/size_x
local line_width		= (4.5/512)/tex_scale * 0.3
local line_width_trim		= (4.5/512)/tex_scale * 0.2


local roll_stick_movement           = 140
local k                             = size_x / roll_stick_movement
local pitch_stick_movement_positive = 0.76 * roll_stick_movement * 0.625 * k
local pitch_stick_movement_negative = 0.76 * roll_stick_movement * 0.375 * k

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
base.vertices		= {{-(size_x + rud_shift + rud_base_shift + 2*ds),	-(size_y_negative + 2 * ds + rudder_shift)},	-- lower left, CW
                       {-(size_x + rud_shift + rud_base_shift + 2*ds),	size_y_positive  + ds},
                       { size_x  + ds,					size_y_positive  + ds},
                       { size_x  + ds,					-(size_y_negative + 2 * ds + rudder_shift)}}        
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
pitch_scale.material		= texture_red
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
roll_scale.material			= texture_red
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
stick_position.material		= texture_red
stick_position.tex_params	= {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
stick_position.controllers	= {	{"stick_pitch",	-size_y_negative},
								{"stick_roll", size_x}}
stick_position.parent_element	= base.name
AddElement(stick_position)

trimmer_stick_position					= CreateElement "ceTexPoly"
trimmer_stick_position.name				= "trimmer_stick_position"
trimmer_stick_position.vertices			= {	{-stick_index_size, -stick_index_size},
											{-stick_index_size,  stick_index_size},
											{ stick_index_size,  stick_index_size},
											{ stick_index_size, -stick_index_size}}
trimmer_stick_position.indices			= default_box_indices
trimmer_stick_position.material			= texture_white
trimmer_stick_position.tex_params		= {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
trimmer_stick_position.controllers		= {	{"trimmer_stick_pitch", size_y_negative},
											{"trimmer_stick_roll" , size_x},
											{"scale",0.5,0.5}}
trimmer_stick_position.parent_element	= base.name
AddElement(trimmer_stick_position)

ap_stick_position					    = CreateElement "ceTexPoly"
ap_stick_position.name				= "ap_stick_position"
ap_stick_position.vertices			= {	{-stick_index_size, -stick_index_size},
										{-stick_index_size,  stick_index_size},
										{ stick_index_size,  stick_index_size},
										{ stick_index_size, -stick_index_size}}
ap_stick_position.indices			= default_box_indices
ap_stick_position.material			= texture_white
ap_stick_position.tex_params		= {330/512, 365.5 / 512, 1*tex_scale, 1*tex_scale/0.8}
ap_stick_position.controllers		= {	{"ap_stick_pitch", size_y_negative},
										{"ap_stick_roll" , size_x},
										{"scale",1.0,1.0}}
ap_stick_position.parent_element	= base.name
AddElement(ap_stick_position)

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

trimmer_rudder_index				= Copy(roll_scale)
trimmer_rudder_index.vertices		= {	{-rudder_shift,	-line_width},
								{-rudder_shift,	line_width},
								{rudder_shift,	line_width},
								{rudder_shift,	-line_width}}
trimmer_rudder_index.material			= texture_white
trimmer_rudder_index.controllers	= {{"trimmer_rudder",size_x},
									   {"rotate",math.rad(90)},
									   {"scale",0.75,0.75}}
trimmer_rudder_index.parent_element	= rudder_scale.name
AddElement(trimmer_rudder_index)

-- THROTTLE SCALE -------------------------------------------------------------
local throttleIdle          = 0.15
local throttleMil           = 0.90

throttle_scale					= Copy(pitch_scale)
throttle_scale.name				= "throttle_scale"
throttle_scale.init_pos			= {-(size_x + rud_base_shift + ds), 0}
throttle_scale.parent_element	= base.name
AddElement(throttle_scale)

idle_scale					= Copy(rudder_scale)
idle_scale.name				= "idle_scale"
idle_scale.vertices		= {	{-rud_shift*0.5,	-line_width},
							{-rud_shift*0.5,	line_width},
							{rud_shift*0.5,	line_width},
							{rud_shift*0.5,	-line_width}}
idle_scale.init_pos			= {-(1.0-throttleIdle)*size_y_negative + throttleIdle*size_y_positive, 0}
idle_scale.init_rot			= {-90,0,0}
idle_scale.parent_element	= throttle_scale.name
AddElement(idle_scale)

ab_scale				= Copy(idle_scale)
ab_scale.name			= "ab_scale"
ab_scale.vertices		= {	{-rud_shift*0.5,	-line_width},
							{-rud_shift*0.5,	 line_width},
							{rud_shift*0.5,		 line_width},
							{rud_shift*0.5,		-line_width}}
ab_scale.init_pos		= {-(1.0-throttleMil)*size_y_negative + throttleMil*size_y_positive, 0}
ab_scale.init_rot		= {-90,0,0}
ab_scale.parent_element	= throttle_scale.name
AddElement(ab_scale)

-- THROTTLE
throttle_index				= Copy(roll_scale)
throttle_index.vertices			= {	{-rud_shift,	-line_width},
									{-rud_shift,	 line_width},
									{rud_shift,		 line_width},
									{rud_shift,		-line_width}}
throttle_index.init_pos			= {-size_y_negative, 0}
throttle_index.init_rot			= {-90,0,0}
throttle_index.controllers		= {{"throttle", size_y_positive + size_y_negative},
									{"scale",1.0, 2.0}}
throttle_index.parent_element	= throttle_scale.name
AddElement(throttle_index)

-- WHEEL BRAKES ---------------------------------------------------------------

local brakes_pos 		   = {size_x,rudder_scale.init_pos[2]}

local sz_wheel_brake       = 1.5 * pitch_stick_movement_negative

local signum = 1
local 	wheel_brake_mask                = CreateElement "ceMeshPoly"
		wheel_brake_mask.name		    = "wheel_brake_mask_right"
		wheel_brake_mask.primitivetype  = "triangles"
		wheel_brake_mask.vertices       = {{0                    ,0},
										   {0                    ,sz_wheel_brake},
										   {-signum * 0.3 * sz_wheel_brake ,sz_wheel_brake},
										   {-signum * 0.3 * sz_wheel_brake ,0}}
		wheel_brake_mask.indices		= {0,1,2,0,2,3}
		wheel_brake_mask.material	    = "MASK_MATERIAL"
		wheel_brake_mask.init_pos       = {signum * brakes_pos[1],brakes_pos[2]}
		wheel_brake_mask.parent_element = base.name
		wheel_brake_mask.controllers    = {{"brakes_value_right",i,sz_wheel_brake}}
		wheel_brake_mask.h_clip_relation  = h_clip_relations.INCREASE_LEVEL
		wheel_brake_mask.isvisible      = false
		AddElement(wheel_brake_mask)

local	wheel_brake                = CreateElement "ceMeshPoly"
		wheel_brake.name		   = "wheel_brake_right"
		wheel_brake.primitivetype  = "triangles"
		wheel_brake.vertices       = {{0 ,0},
									  {0 ,sz_wheel_brake},
									  { -signum * 0.3 * sz_wheel_brake,sz_wheel_brake}}
		wheel_brake.indices		   = {0,1,2}
		wheel_brake.material	   = texture_white
		wheel_brake.init_pos       =  wheel_brake_mask.init_pos
		wheel_brake.parent_element  = base.name
		wheel_brake.h_clip_relation = h_clip_relations.COMPARE
		wheel_brake.level		    = DEFAULT_LEVEL
		AddElement(wheel_brake)
		
local 	wheel_brake_actual                = CreateElement "ceMeshPoly"
		wheel_brake_actual.name		   	  = "wheel_brake_actual_right"
		wheel_brake_actual.vertices       = {{0                    ,-0.05 * sz_wheel_brake},
											 {0                    ,0.05 * sz_wheel_brake},
											 {-signum * 0.3 * sz_wheel_brake ,0.05 * sz_wheel_brake},
											 {-signum * 0.3 * sz_wheel_brake ,-0.05 * sz_wheel_brake}}
		wheel_brake_actual.indices	      = {0,1,2,0,2,3}
		wheel_brake_actual.material	      = texture_red
		wheel_brake_actual.init_pos       = {signum * brakes_pos[1],brakes_pos[2]}
		wheel_brake_actual.parent_element = base.name
		wheel_brake_actual.controllers    = {{"brakes_value_actual_right",i,sz_wheel_brake}}
		AddElement(wheel_brake_actual)
		
signum = -1
local 	wheel_brake_mask_left                = CreateElement "ceMeshPoly"
		wheel_brake_mask_left.name		    = "wheel_brake_mask_left"
		wheel_brake_mask_left.primitivetype  = "triangles"
		wheel_brake_mask_left.vertices       = {{0                    ,0},
										   {0                    ,sz_wheel_brake},
										   {-signum * 0.3 * sz_wheel_brake ,sz_wheel_brake},
										   {-signum * 0.3 * sz_wheel_brake ,0}}
		wheel_brake_mask_left.indices		= {0,1,2,0,2,3}
		wheel_brake_mask_left.material	    = "MASK_MATERIAL"
		wheel_brake_mask_left.init_pos       = {signum * brakes_pos[1],brakes_pos[2]}
		wheel_brake_mask_left.parent_element = base.name
		wheel_brake_mask_left.controllers    = {{"brakes_value_left",i,sz_wheel_brake}}
		wheel_brake_mask_left.h_clip_relation  = h_clip_relations.INCREASE_LEVEL
		wheel_brake_mask_left.isvisible      = false
		AddElement(wheel_brake_mask_left)

local	wheel_brake_left                = CreateElement "ceMeshPoly"
		wheel_brake_left.name		   = "wheel_brake_left"
		wheel_brake_left.primitivetype  = "triangles"
		wheel_brake_left.vertices       = {{0 ,0},
									  {0 ,sz_wheel_brake},
									  { -signum * 0.3 * sz_wheel_brake,sz_wheel_brake}}
		wheel_brake_left.indices		   = {0,1,2}
		wheel_brake_left.material	   = texture_white
		wheel_brake_left.init_pos       =  wheel_brake_mask_left.init_pos
		wheel_brake_left.parent_element  = base.name
		wheel_brake_left.h_clip_relation = h_clip_relations.COMPARE
		wheel_brake_left.level		    = DEFAULT_LEVEL
		AddElement(wheel_brake_left)
		
local 	wheel_brake_actual_left                = CreateElement "ceMeshPoly"
		wheel_brake_actual_left.name		   	  = "wheel_brake_actual_left"
		wheel_brake_actual_left.vertices       = {{0                    ,-0.05 * sz_wheel_brake},
											 {0                    ,0.05 * sz_wheel_brake},
											 {-signum * 0.3 * sz_wheel_brake ,0.05 * sz_wheel_brake},
											 {-signum * 0.3 * sz_wheel_brake ,-0.05 * sz_wheel_brake}}
		wheel_brake_actual_left.indices	      = {0,1,2,0,2,3}
		wheel_brake_actual_left.material	      = texture_red
		wheel_brake_actual_left.init_pos       = {signum * brakes_pos[1],brakes_pos[2]}
		wheel_brake_actual_left.parent_element = base.name
		wheel_brake_actual_left.controllers    = {{"brakes_value_actual_left",i,sz_wheel_brake}}
		AddElement(wheel_brake_actual_left)