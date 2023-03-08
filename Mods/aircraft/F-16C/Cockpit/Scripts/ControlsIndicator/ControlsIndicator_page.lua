dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetCustomScale(1.0)

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end


local pitch_stick_fwd = 40.0
local pitch_stick_aft = 40.0
local pitch_stick_range = pitch_stick_fwd + pitch_stick_aft

local pitch_stick_real_range	= 9.03125
local pitch_stick_part_positive	= pitch_stick_fwd / pitch_stick_range
local pitch_stick_part_negative	= pitch_stick_aft / pitch_stick_range
local roll_stick_real_range		= 11.875
local roll_stick_part_left		= 0.5
local roll_stick_part_right		= 0.5

local throttleIdle				= 0.1
local throttleMil				= 0.775

local aspect			= LockOn_Options.screen.aspect
local size_x			= 0.15	-- +-size_x
local size_y_positive	= size_x * 2.2 * pitch_stick_real_range / roll_stick_real_range * pitch_stick_part_positive
local size_y_negative	= size_x * 2.2 * pitch_stick_real_range / roll_stick_real_range * pitch_stick_part_negative
local tex_scale			= 0.25/size_x
local line_width		= (4/512)/tex_scale * 0.5


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


local function add_line(name, pos, length, _width05, rot, parent, controllers)
	local width05 = line_width
	if _width05 ~= nil then
		width05 = _width05
	end

	local elem			= CreateElement "ceTexPoly"
	elem.name			= name
	elem.material		= "ARCADE"
	elem.vertices		= {	{ 0,		-width05},
							{ 0,		 width05},
							{ length,	 width05},
							{ length,	-width05} }
	elem.indices		= default_box_indices
	elem.tex_params		= {(128 + 64)/512, 176.5/512, 0.25/tex_scale, 0.015625/(width05*2)}

	elem.init_pos		= {pos[1], pos[2], 0}

	if rot ~= nil then
		elem.init_rot		= {rot,0,0}
	end

	if parent ~= nil then
		elem.parent_element	= parent
	end

	if controllers ~= nil then
		elem.controllers	= controllers
	end

	AddElement(elem)

	return elem
end






-- BASE -----------------------------------------------------------------------
base				= CreateElement "ceMeshPoly"
base.name			= "base"
base.primitivetype	= "triangles"
base.material		= orange_mat
base.vertices		= {{-(size_x + rud_shift + rud_base_shift + 2*ds),	-(size_y_negative + 2 * ds + rudder_shift)},	-- lower left, CW
                       {-(size_x + rud_shift + rud_base_shift + 2*ds),	size_y_positive  + ds},
                       { size_x  + ds,									size_y_positive  + ds},
                       { size_x  + ds,									-(size_y_negative + 2 * ds + rudder_shift)}}        
base.indices		= default_box_indices
base.init_pos		= {0,-(1 - 1.3*size_x)}
base.controllers	= {{"show"},{"screenspace_position",2,-(aspect - 2*size_x),0},
                                {"screenspace_position",1,0,0}}
base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
base.level			= DEFAULT_LEVEL
AddElement(base)


-- STICK SCALE-----------------------------------------------------------------
local pitch_scale = add_line("pitch_scale", {0, -size_y_negative}, size_y_negative + size_y_positive, nil, 90, base.name)
local roll_scale = add_line("roll_scale", {-size_x, 0}, size_x * 2, nil, nil, base.name)

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

trimmer10					= CreateElement "ceTexPoly"
trimmer10.name				= "trimmer10"
trimmer10.vertices			= {	{-rud_shift*0.5,	-line_width},
								{-rud_shift*0.5,	line_width},
								{rud_shift*0.5,	line_width},
								{rud_shift*0.5,	-line_width}}
trimmer10.indices			= default_box_indices
trimmer10.material			= "ARCADE"
trimmer10.tex_params		= {256/512, 176.5/512, tex_scale, 2*tex_scale}
trimmer10.controllers		= {	{"move",	-10.0/17.0*size_y_negative},
								{"rotate",	math.rad(90)},
								{"scale",0.7,1.0}}
trimmer10.parent_element	= pitch_scale.name
--AddElement(trimmer10)


-- PEDALS ---------------------------------------------------------------------
local rudder_scale = add_line("rudder_scale", {-size_x, -(size_y_negative + rudder_shift)}, size_x * 2, nil, nil, base.name)
local rudder_index = add_line("rudder_index", {0, -(size_y_negative + rudder_shift * 2)}, rudder_shift * 2, nil, nil, base.name, {{"rudder",size_x}, {"rotate",math.rad(90)}})


-- THROTTLE SCALE -------------------------------------------------------------
local throttle_px = -(size_x + rud_base_shift + ds)
local throttle_py = -(size_y_negative + rudder_shift * 2)
local throttle_scale_length = size_y_negative + size_y_positive + rudder_shift * 2

local throttle_scale = add_line("throttle_scale", {throttle_px, throttle_py}, throttle_scale_length, nil, 90, base.name)
local idle_scale = add_line("idle_scale", {throttle_px - rud_shift * 0.5, throttle_py + throttle_scale_length * throttleIdle}, rud_shift, nil, nil, base.name)
local ab_scale = add_line("ab_scale", {throttle_px - rud_shift * 0.5, throttle_py + throttle_scale_length * throttleMil}, rud_shift, nil, nil, base.name)

-- THROTTLE
local throttle_index = add_line("throttle_index", {throttle_px - rud_shift * 1.5 * 0.5, throttle_py}, rud_shift * 1.5, line_width * 2, nil, base.name, {{"throttle", throttle_scale_length}--[[,{"scale",1.0,2.0}]]})


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
			wheel_brake_mask.material	    = "MASK_MATERIAL"
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