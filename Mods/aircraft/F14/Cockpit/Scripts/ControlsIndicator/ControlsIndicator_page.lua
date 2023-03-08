dofile(LockOn_Options.common_script_path.."elements_defs.lua")

local texture_lightgreen = MakeMaterial("arcade.tga",{128, 255, 128, 255})
local texture_blue = MakeMaterial("arcade.tga",{19, 60, 176, 255})
local texture_red = MakeMaterial("arcade.tga",{255, 0, 176, 255})

SetCustomScale(1.0)

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end


local pitch_stick_real_range	= 9.03125
local pitch_stick_part_positive	= 0.375
local pitch_stick_part_negative	= 0.625
local roll_stick_real_range		= 11.875
local roll_stick_part_left		= 0.5
local roll_stick_part_right		= 0.5


local aspect			= LockOn_Options.screen.aspect
local size_x			= 0.15	-- +-size_x
local size_y_positive	= size_x * 2.0 * pitch_stick_real_range / roll_stick_real_range * pitch_stick_part_positive
local size_y_negative	= size_x * 2.0 * pitch_stick_real_range / roll_stick_real_range * pitch_stick_part_negative
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
local rud_shift			= 0.1*size_x
local rud_base_shift	= 0.3*size_x
local orange_mat		= MakeMaterial("", {0, 255, 0, 50})
local rudder_shift		= 0.1*size_x

local stickDX = 0.05
local stickDY = 0.05

local sizeX = 0.15
local sizeY = 0.15

local totalSizeX = sizeX + stickDX
local totalSizeY = sizeY + stickDY

-- ¡¿«¿ -----------------------------------------------------------------------------
base				= CreateElement "ceMeshPoly"
base.name			= "base"
base.primitivetype	= "triangles"
base.material		= orange_mat -- "GREEN_TRANSPARENT"
base.vertices		= {{-totalSizeX,	-totalSizeY},
                       {-totalSizeX,	totalSizeY}, 
                       { totalSizeX, 	totalSizeY},
                       { totalSizeX, 	-totalSizeY}}        
base.indices		= default_box_indices
base.init_pos		= {0,-(1 - 1.5*totalSizeX)}
base.controllers	= {{"show"},{"screenspace_position",2,-(aspect - 2*totalSizeX),0},
                                {"screenspace_position",1,0,0}}
base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
base.level			= DEFAULT_LEVEL
AddElement(base)

-- ÿ ¿À€ –”— ----------------------------------------------------------------
pitch_scale					= CreateElement "ceTexPoly"
pitch_scale.name			= "pitch_scale"
pitch_scale.vertices		= {	{-sizeY,	-line_width},
								{-sizeY,	line_width},
								{sizeY,	line_width},
								{sizeY,	-line_width}}
pitch_scale.indices			= default_box_indices
pitch_scale.material		= texture_lightgreen
pitch_scale.init_rot		= {90,0,0}
pitch_scale.init_pos		= {stickDX / 2, stickDY / 2}
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
roll_scale.material			= texture_lightgreen
roll_scale.init_pos		= {stickDX / 2, stickDY / 2}
roll_scale.tex_params		= {256/512, 176.5/512, tex_scale, 2*tex_scale}
roll_scale.parent_element	= base.name
AddElement(roll_scale)

-- –”— ------------------------------------------------------------------
local stick_index_size = 0.1 * size_x

stick_position				= CreateElement "ceTexPoly"
stick_position.name			= "stick_position"
stick_position.vertices		= {	{-stick_index_size, -stick_index_size},
								{-stick_index_size,  stick_index_size},
								{ stick_index_size,  stick_index_size},
								{ stick_index_size, -stick_index_size}}
stick_position.indices		= default_box_indices
stick_position.material		= texture_lightgreen
stick_position.init_pos		= {stickDX / 2, stickDY / 2}
stick_position.tex_params	= {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
stick_position.controllers	= {	{"stick_pitch",	size_y_negative},
								{"stick_roll",	size_x}}
stick_position.parent_element	= base.name
AddElement(stick_position)

trimmer_stick_position					= CreateElement "ceTexPoly"
trimmer_stick_position.name				= "trimmer_stick_position"
trimmer_stick_position.vertices			= {	{-stick_index_size, -stick_index_size},
											{-stick_index_size,  stick_index_size},
											{ stick_index_size,  stick_index_size},
											{ stick_index_size, -stick_index_size}}
trimmer_stick_position.indices			= default_box_indices
trimmer_stick_position.material			= texture_lightgreen
trimmer_stick_position.init_pos		= {stickDX / 2, stickDY / 2}
trimmer_stick_position.tex_params		= {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
trimmer_stick_position.controllers		= {	{"trimmer_stick_pitch", size_y_negative},
											{"trimmer_stick_roll" , size_x},
											{"scale",0.5,0.5}}
trimmer_stick_position.parent_element	= base.name
AddElement(trimmer_stick_position)


-- œ≈ƒ¿À» -----------------------------------------------------------------------------------
rudder_scale				= Copy(roll_scale)
rudder_scale.name			= "rudder_scale"
rudder_scale.vertices		= {	{-size_x*0.8,	-line_width},
								{-size_x*0.8,	line_width},
								{size_x*0.8,	line_width},
								{size_x*0.8,	-line_width}}
rudder_scale.init_pos		= {stickDX / 2, -(sizeY)}
AddElement(rudder_scale)

rudder_index				= Copy(roll_scale)
rudder_index.vertices		= {	{-rudder_shift,	-line_width},
								{-rudder_shift,	line_width},
								{rudder_shift,	line_width},
								{rudder_shift,	-line_width}}
rudder_index.init_pos		= {0, 0}
rudder_index.controllers	= {{"rudder",sizeX*0.8},{"rotate",math.rad(90)},{"scale", 0.75}}
rudder_index.parent_element	= rudder_scale.name
AddElement(rudder_index)


rudder_index				= Copy(roll_scale)
rudder_index.vertices		= {	{-rudder_shift,	-line_width},
								{-rudder_shift,	line_width},
								{rudder_shift,	line_width},
								{rudder_shift,	-line_width}}
rudder_index.init_pos		= {0, 0}
rudder_index.controllers	= {{"trimmer_rudder",sizeX*0.8},{"rotate",math.rad(90)},{"scale", 0.45}}
rudder_index.parent_element	= rudder_scale.name
AddElement(rudder_index)


-- –”ƒ -------------------------------------------------------------------------------------
throttle_scale					= Copy(pitch_scale)
throttle_scale.name				= "throttle_scale_l"
throttle_scale.init_pos			= {-(sizeX + stickDX / 2), stickDY / 2}
throttle_scale.parent_element	= base.name
AddElement(throttle_scale)

throttle_index					= Copy(roll_scale)
throttle_index.vertices			= {	{-rud_shift,	-line_width},
									{-rud_shift,	line_width},
									{rud_shift,		line_width},
									{rud_shift,		-line_width}}
throttle_index.init_pos			= {-sizeY, 0}
throttle_index.init_rot			= {-90,0,0}
throttle_index.material			= texture_lightgreen
throttle_index.controllers		= {{"throttle_l", 2 * sizeY}}
throttle_index.parent_element	= throttle_scale.name
AddElement(throttle_index)

AB_mark					= Copy(roll_scale)
AB_mark.vertices			= {	{-rud_shift*0.8,	-line_width*0.6},
									{-rud_shift*0.8,	line_width*0.6},
									{rud_shift*0.8,		line_width*0.6},
									{rud_shift*0.8,		-line_width*0.6}}
AB_mark.init_pos			= {-sizeY + 0.8*(2*sizeY), 0}
AB_mark.init_rot			= {-90,0,0}
AB_mark.material			= texture_red
AB_mark.parent_element	= throttle_scale.name
AddElement(AB_mark)

local zones = { 83, 85, 88.6, 92 }

if get_aircraft_type() ~= "F-14B" then
  -- extra AB zones left
  for i = 1,#zones do
    AB_mark					= Copy(roll_scale)
    AB_mark.vertices			= {	{-rud_shift*0.5,	-line_width*0.6},
                                        {-rud_shift*0.5,	line_width*0.6},
                                        {rud_shift*0.5,		line_width*0.6},
                                        {rud_shift*0.5,		-line_width*0.6}}
    AB_mark.init_pos			= {-sizeY + (zones[i]*0.01)*(2*sizeY), 0}
    AB_mark.init_rot			= {-90,0,0}
    AB_mark.material			= texture_red
    AB_mark.parent_element	= throttle_scale.name
    AddElement(AB_mark)
  end
end

throttle_scale					= Copy(pitch_scale)
throttle_scale.name				= "throttle_scale_r"
throttle_scale.init_pos			= {-(sizeX + stickDX / 2 - 0.04), stickDY / 2}
throttle_scale.parent_element	= base.name
AddElement(throttle_scale)

throttle_index					= Copy(roll_scale)
throttle_index.vertices			= {	{-rud_shift,	-line_width},
									{-rud_shift,	line_width},
									{rud_shift,		line_width},
									{rud_shift,		-line_width}}
throttle_index.init_pos			= {-sizeY, 0}
throttle_index.init_rot			= {-90,0,0}
throttle_index.material			= texture_lightgreen
throttle_index.controllers		= {{"throttle_r", 2 * sizeY}}
throttle_index.parent_element	= throttle_scale.name
AddElement(throttle_index)

AB_mark					= Copy(roll_scale)
AB_mark.vertices			= {	{-rud_shift*0.8,	-line_width*0.6},
									{-rud_shift*0.8,	line_width*0.6},
									{rud_shift*0.8,		line_width*0.6},
									{rud_shift*0.8,		-line_width*0.6}}
AB_mark.init_pos			= {-sizeY + 0.8*(2*sizeY), 0}
AB_mark.init_rot			= {-90,0,0}
AB_mark.material			= texture_red
AB_mark.parent_element	= throttle_scale.name
AddElement(AB_mark)

if get_aircraft_type() ~= "F-14B" then
  -- extra AB zones left
  for i = 1,#zones do
    AB_mark					= Copy(roll_scale)
    AB_mark.vertices			= {	{-rud_shift*0.5,	-line_width*0.6},
                                        {-rud_shift*0.5,	line_width*0.6},
                                        {rud_shift*0.5,		line_width*0.6},
                                        {rud_shift*0.5,		-line_width*0.6}}
    AB_mark.init_pos			= {-sizeY + (zones[i]*0.01)*(2*sizeY), 0}
    AB_mark.init_rot			= {-90,0,0}
    AB_mark.material			= texture_red
    AB_mark.parent_element	= throttle_scale.name
    AddElement(AB_mark)
  end
end

-- WHEEL BRAKE ------------------------------------------------------------------------------
brake_scale						= Copy(pitch_scale)
brake_scale.name				= "wheel_brake_l"
brake_scale.init_pos			={(-sizeX + stickDX / 2), -(sizeY)}
brake_scale.vertices			= {	{-sizeY*0.15,	-line_width},
								{-sizeY*0.15,	line_width},
								{sizeY*0.15,	line_width},
								{sizeY*0.15,	-line_width}}
brake_scale.parent_element		= base.name
AddElement(brake_scale)

brake_index						= Copy(roll_scale)
brake_index.vertices			= {	{-sizeY*0.05,	-line_width},
								{-sizeY*0.05,	line_width},
								{sizeY*0.05,	line_width},
								{sizeY*0.05,	-line_width}}
brake_index.init_pos			= {0, 0}
brake_index.init_rot			= {-90,0,0}
brake_index.material			= texture_lightgreen
brake_index.controllers			= {{"wheel_brake_l", sizeY*0.15*2}}
brake_index.parent_element		= brake_scale.name
AddElement(brake_index)





brake_scale						= Copy(pitch_scale)
brake_scale.name				= "wheel_brake_r"
brake_scale.init_pos			={(sizeX + stickDX / 2), -(sizeY)}
brake_scale.vertices			= {	{-sizeY*0.15,	-line_width},
								{-sizeY*0.15,	line_width},
								{sizeY*0.15,	line_width},
								{sizeY*0.15,	-line_width}}
brake_scale.parent_element		= base.name
AddElement(brake_scale)

brake_index						= Copy(roll_scale)
brake_index.vertices			= {	{-sizeY*0.05,	-line_width},
								{-sizeY*0.05,	line_width},
								{sizeY*0.05,	line_width},
								{sizeY*0.05,	-line_width}}
brake_index.init_pos			= {0, 0}
brake_index.init_rot			= {-90,0,0}
brake_index.material			= texture_lightgreen
brake_index.controllers			= {{"wheel_brake_r", sizeY*0.15*2}}
brake_index.parent_element		= brake_scale.name
AddElement(brake_index)

local BASE_COLOR2 = {121, 250, 78, 255}
local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2)

local DebugText           = CreateElement "ceStringPoly"
DebugText.name            = "DebugText"
DebugText.material        = FONT_
DebugText.init_pos        = {-0.16,0.25}--{stickDX / 2, stickDY / 2}
DebugText.alignment       = "CenterLeft"
DebugText.stringdefs      = {line_width,line_width, 0, 0}
DebugText.formats         = {"%s","%s"}
DebugText.controllers     = {{"DebugText",0}} 
DebugText.parent_element		= base.name
DebugText.additive_alpha  = false
DebugText.collimated     = false
AddElement(DebugText)






--[[

--Carrier approach
base				= CreateElement "ceMeshPoly"
base.name			= "baseApproach"
base.primitivetype	= "triangles"
base.material		= MakeMaterial("", {255, 0, 0, 150}) 
base.vertices		= {{-totalSizeX,	-1.6/3.5*totalSizeY},
                       {-totalSizeX,	 1.3/3.5*totalSizeY}, 
                       { totalSizeX, 	 1.3/3.5*totalSizeY},
                       { totalSizeX, 	-1.6/3.5*totalSizeY}}        
base.indices		= default_box_indices
base.init_pos		= {0,-(1 - 1.5*totalSizeX)}
base.controllers	= {{"show"},{"screenspace_position",2,(aspect - 2*totalSizeX),0},
                                {"screenspace_position",1,0,0}}
base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
base.level			= DEFAULT_LEVEL
AddElement(base)


yellow				= CreateElement "ceMeshPoly"
yellow.name			= "yellowApproach"
yellow.primitivetype	= "triangles"
yellow.material		= MakeMaterial("", {255, 255, 0, 150}) 
yellow.vertices		= {{-2.5/3.5*totalSizeX,	-0.8/3.5*totalSizeY},
                       {-2.5/3.5*totalSizeX,	 0.8/3.5*totalSizeY}, 
                       { 2.5/3.5*totalSizeX, 	 0.8/3.5*totalSizeY},
                       { 2.5/3.5*totalSizeX, 	-0.8/3.5*totalSizeY}}        
yellow.indices		= default_box_indices
yellow.init_pos		= {0,0}
yellow.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
yellow.level				= DEFAULT_LEVEL
yellow.parent_element		= base.name
AddElement(yellow)

green				= CreateElement "ceMeshPoly"
green.name			= "greenApproach"
green.primitivetype	= "triangles"
green.material		= MakeMaterial("", {6, 130, 56, 150}) 
green.vertices		= {{-1.5/3.5*totalSizeX,	-0.3/3.5*totalSizeY},
                       {-1.5/3.5*totalSizeX,	 0.3/3.5*totalSizeY}, 
                       { 1.5/3.5*totalSizeX, 	 0.3/3.5*totalSizeY},
                       { 1.5/3.5*totalSizeX, 	-0.3/3.5*totalSizeY}}        
green.indices		= default_box_indices
green.init_pos		= {0,0}
green.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
green.level				= DEFAULT_LEVEL
green.parent_element		= base.name
AddElement(green)


local stick_index_size = 0.1 * size_x

stick_position				= CreateElement "ceTexPoly"
stick_position.name			= "stick_position"
stick_position.vertices		= {	{-stick_index_size, -stick_index_size},
								{-stick_index_size,  stick_index_size},
								{ stick_index_size,  stick_index_size},
								{ stick_index_size, -stick_index_size}}
stick_position.indices		= default_box_indices
stick_position.material		= texture_lightgreen
stick_position.init_pos		= {0,0}
stick_position.tex_params	= {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
stick_position.controllers	= {	{"GlideSlopeHorizontal",	totalSizeY},
								{"GlideSlopeVertical",	totalSizeX}}
stick_position.parent_element	= base.name
AddElement(stick_position)
--]]