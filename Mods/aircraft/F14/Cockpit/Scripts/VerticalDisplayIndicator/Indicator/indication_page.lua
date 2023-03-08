dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(MILLYRADIANS)

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL

--local __USE_SCREENSPACE = true
--local SHOW_DEBUG_CLIP_BOXES = true
--local DISABLE_CLIP_BOXES = true


local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2)

local scale = 625.0

local _screen_origin = {0,0,0}
local _screen_rotation = {0,0,0}

local _local_clip_level = 0

function AddElement(object)
	object.use_mipfilter = true
	object.additive_alpha = false
	object.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--object.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	object.level			= VDI_DEFAULT_LEVEL
	--object.level			= VDI_DEFAULT_LEVEL + 1
	Add(object)
end

function AddBoxedHUDElement(object)
	if DISABLE_CLIP_BOXES ~= nil then
		AddElement(object)
		return
	end
	object.use_mipfilter = true
	object.additive_alpha = false
	object.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--object.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	--object.level			= VDI_DEFAULT_LEVEL
	object.level			= VDI_DEFAULT_LEVEL + _local_clip_level
	Add(object)
end

function AddHUDElement(object)
	AddElement(object) -- <R> some like to call AddHUDElement
end

function push_clip_level()
	_local_clip_level = _local_clip_level + 1
end

function pop_clip_level()
	_local_clip_level = _local_clip_level - 1
end

--------------------------------------------------------------
--- screen space hud
--------------------------------------------------------------
if __USE_SCREENSPACE ~= nil then

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end
	scale = 1.0
end

--------------------------------------------------------------
--------------------------------------------------------------

function create_textured_box(UL_X,UL_Y,DR_X,DR_Y, texture_size, my_custom_scale)

	local my_scale = scale
	if my_custom_scale ~= nil then
		my_scale = my_custom_scale
	end

	local size_per_pixel = 1.0 / texture_size * my_scale
	local W = DR_X - UL_X
	local H = DR_Y - UL_Y
	
	local texture_size_x = texture_size
	local texture_size_y = texture_size

	local half_x = 0.5 * W * size_per_pixel
	local half_y = 0.5 * H * size_per_pixel
	local ux 	 = UL_X / texture_size_x
	local uy 	 = UL_Y / texture_size_y
	local w 	 = W / texture_size_x
	local h 	 = H / texture_size_y

	local object = CreateElement "ceTexPoly"
	object.vertices = {{-half_x, half_y},
						{ half_x, half_y},
						{ half_x,-half_y},
						{-half_x,-half_y}}
	object.indices	 = {0,1,2,0,2,3}
	object.tex_coords = {{ux ,uy},
						 {ux + w ,uy},
						 {ux + w ,uy + h},
						 {ux 	 ,uy + h}}	 
					 
	return object
end

function my_create_textured_box_2k(UL_X,UL_Y,DR_X,DR_Y)
	return create_textured_box(UL_X,UL_Y,UL_X+DR_X,UL_Y+DR_Y, 2048)
end

function my_create_textured_box_2k_font(UL_X,UL_Y,DR_X,DR_Y, custom_scaling)
	return create_textured_box(UL_X,UL_Y,UL_X+DR_X,UL_Y+DR_Y, 2048, scale * custom_scaling)
end

function create_custom_number_element(number, posX, posY, posZ, parent_element, min_digits, signed, font_scaling, controllers)

	if font_scaling == nil then
		font_scaling = 1.0
	end

	local digit_start_X = 79
	local digit_start_Y = 973
	local digit_sizeX = 23
	local digit_sizeY = 34
	local digit_spacing = 16
	
	local digit_spacing_screen = 8 * font_scaling

	local digits = {}
	
	local theSign = 0
	if number > 0 then 
		theSign = 10 -- plus sign(+)
	end
	
	if number < 0 then
		theSign = 11 -- minus sign (-)
	end
	
	number = math.abs(number)
	
	if number ~= 0 then
		while number > 0 do
			digits[#digits+1] = number - math.floor(number/10) * 10
			number = math.floor(number/10)
		end
	else
		digits[1] = 0
	end
	
	if (min_digits ~= nil) and (min_digits > #digits) then
		local digits2 = {}
		for i = 1, min_digits do
			digits2[i] = 0
		end
		for i = 1, #digits do
			digits2[i] = digits[i]
		end
		
		digits = digits2
	end

	if signed ~= nil then
		if theSign > 0 or theSign < 0 then
			digits[#digits + 1] = theSign
		end		
	end

	local anchor = (#digits - 1) * digit_spacing_screen / 2
	
	for i = 1, #digits do
		local digit = my_create_textured_box_2k_font(digit_start_X + (digit_sizeX + digit_spacing) * digits[#digits - i + 1] ,digit_start_Y,digit_sizeX,digit_sizeY, font_scaling)
			digit.name 	= create_guid_string() 
			digit.material = "VDI_WHITE_MAT"
			digit.init_pos = {digit_spacing_screen * (i - 1) - anchor + posX, posY ,posZ}
			digit.parent_element = parent_element.name
            digit.controllers = controllers
		AddBoxedHUDElement(digit)
	end
end

function create_box(PosX, PosY, SizeX, SizeY, material, parent, clipRelation, clipLevel, showbox)
	local box = CreateElement "ceMeshPoly"
	box.name = "SymbologyBox"
	box.primitivetype = "triangles"

	box.vertices	= { {-SizeX,-SizeY},
								{-SizeX,SizeY},
								{ SizeX,SizeY},
								 {SizeX,-SizeY}}

	box.indices		 = default_box_indices
	box.init_pos		 = {_screen_origin[1] + PosX, _screen_origin[2] + PosY, _screen_origin[3]}
	box.init_rot		 = _screen_rotation
	box.material		 = material
	
	if parent ~= nil then
		box.parent_element = parent.name
	end
	
	box.use_mipfilter = true
	box.additive_alpha = false
	box.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--box.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	box.level			= VDI_DEFAULT_LEVEL
	--box.level			= VDI_DEFAULT_LEVEL + 1
	--Add(box)
    if showbox ~= nil then
    		box.isvisible		 = showbox
    end
	
	if clipRelation ~= nil then
		box.h_clip_relation = clipRelation
		box.level			 = clipLevel
		box.isdraw			 = true
		box.change_opacity	 = false
		--Add(box)
	else
		if clipLevel ~= nil then
			box.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
			box.clipLevel = clipLevel
		end
		--AddHUDElement(box)
	end
	Add(box)
end

__clip_box = {}  --stack
-- must always having a closing clip_box_pop somewhere later
function clip_box_push(PosX, PosY, SizeX, SizeY, parent)
	if DISABLE_CLIP_BOXES ~= nil then
		return
	end
    local entry = {PosX, PosY, SizeX, SizeY, parent}
    table.insert(__clip_box, entry)
	create_box(PosX, PosY, SizeX, SizeY, "DBG_GREEN", parent, h_clip_relations.INCREASE_IF_LEVEL ,VDI_DEFAULT_LEVEL + _local_clip_level, false)
    push_clip_level()
end

function clip_box_pop()
	if DISABLE_CLIP_BOXES ~= nil then
		return
	end
	if #__clip_box == 0 then
		return
	end
    local entry = table.remove(__clip_box)
	local PosX = entry[1]
	local PosY = entry[2]
	local SizeX = entry[3]
	local SizeY = entry[4]
    local parent = entry[5]

	if SHOW_DEBUG_CLIP_BOXES ~= nil then
		create_box(PosX,PosY,SizeX,SizeY,"DBG_TRANSPARENT", parent, h_clip_relations.DECREASE_IF_LEVEL ,VDI_DEFAULT_LEVEL + _local_clip_level, false)
	end

	create_box(PosX, PosY, SizeX, SizeY, "DBG_GREEN", parent, h_clip_relations.DECREASE_IF_LEVEL ,VDI_DEFAULT_LEVEL + _local_clip_level, false)
    pop_clip_level()
end

function create_origin()
	local grid_origin	 = CreateElement "ceSimple"
		grid_origin.name = create_guid_string()
		grid_origin.collimated = false
		grid_origin.init_pos = _screen_origin -- PNT not centered, so i'll use this value
		grid_origin.init_rot = _screen_rotation
		grid_origin.controllers = {{"vdi_visible"}}
	AddBoxedHUDElement(grid_origin)
	return grid_origin
end

function enable_box_rotation()
	_screen_rotation = {0,0,0}
end

function disable_box_rotation()
	_screen_rotation = {0,0,0}
end

--[[-- -- working tests

clip_box_push(0,0,75,25,DBG_GREEN)

create_box(30,30,100,100,DBG_RED, nil, h_clip_relations.DECREASE_IF_LEVEL ,VDI_DEFAULT_LEVEL + 1, true)--, nil, VDI_DEFAULT_LEVEL + 1)

clip_box_pop(0,0,75,25,DBG_GREEN)

clip_box_push(0,100,75,25,DBG_GREEN)

create_box(30,30,100,100,DBG_GREEN, nil, h_clip_relations.DECREASE_IF_LEVEL ,VDI_DEFAULT_LEVEL + 1, true)--, nil, VDI_DEFAULT_LEVEL + 1)

clip_box_pop(0,100,75,25,DBG_GREEN)

--]]--


-- artificial horizon has 1 / 4 scaling on the horizon lines

-- artificial horizon vertical fov is 70*

local artificial_horizon__vertical_fov_factor = 0.4 -- eyballed

clip_box_push(0,0,140,140)

local grid_origin = create_origin()

function Create_ArtificialHorizon()

local artificial_horizon	 = CreateElement "ceSimple"
	artificial_horizon.name = create_guid_string() 
	artificial_horizon.collimated = false
	artificial_horizon.init_pos = {0, 0, 0}
	artificial_horizon.parent_element = grid_origin.name
	artificial_horizon.controllers = {{"artificial_horizon"}}
AddBoxedHUDElement(artificial_horizon)

local horizonBox_width = 300
local horizonBox_height = artificial_horizon__vertical_fov_factor * _one_degree * 180

local horizonBox_PosX = horizonBox_width
local horizonBox_PosY = horizonBox_height
local horizon_gap = artificial_horizon__vertical_fov_factor * _one_degree * 180 * 0.002

create_box(0,horizonBox_PosY+horizon_gap,horizonBox_width, horizonBox_height, "LIGHT_GREEN_MAT", artificial_horizon, h_clip_relations.COMPARE, VDI_DEFAULT_LEVEL+1, true)
create_box(0,-horizonBox_PosY-horizon_gap,horizonBox_width, horizonBox_height, "DARK_GREEN_MAT", artificial_horizon, h_clip_relations.COMPARE, VDI_DEFAULT_LEVEL+1, true)

local artificial_roll	 = CreateElement "ceSimple"
	artificial_roll.name = create_guid_string()
	artificial_roll.collimated = false
	artificial_roll.init_pos = {0, 0, 0}
	artificial_roll.parent_element = grid_origin.name
	artificial_roll.controllers = {{"artificial_roll"}}
AddBoxedHUDElement(artificial_roll)

clip_box_push(0,-horizonBox_PosY-horizon_gap,horizonBox_width, horizonBox_height, artificial_horizon)
local ground_holder	 = CreateElement "ceSimple"
	ground_holder.name = "GND_"..create_guid_string()
	ground_holder.collimated = false
	ground_holder.init_pos = {0, 0, 0}
	ground_holder.parent_element = artificial_horizon.name
	--ground_holder.controllers = {{"artificial_horizon"}}
AddBoxedHUDElement(ground_holder)

local gnd_vertical_space = 15 * _one_degree * artificial_horizon__vertical_fov_factor * 0.5
for i = 0,3 do

    local slightleft 			= my_create_textured_box_2k(414,94,322,176)
        slightleft.name 	= create_guid_string()
        slightleft.material = "VDI_VDARKGREEN_MAT"
        slightleft.init_pos = {-20, -(i*gnd_vertical_space*2), 0}
        slightleft.parent_element = ground_holder.name
        slightleft.controllers = {{"ground1",i*3}}
    AddBoxedHUDElement(slightleft)

    local rightmost 			= my_create_textured_box_2k(414,94,322,176)
        rightmost.name 	= create_guid_string()
        rightmost.material = "VDI_VDARKGREEN_MAT"
        rightmost.init_pos = {80, -(i*gnd_vertical_space*2 + gnd_vertical_space), 0}
        rightmost.parent_element = ground_holder.name
        rightmost.controllers = {{"ground1",i*3+1}}
    AddBoxedHUDElement(rightmost)

    local leftmost 			= my_create_textured_box_2k(414,94,322,176)
        leftmost.name 	= create_guid_string()
        leftmost.material = "VDI_VDARKGREEN_MAT"
        leftmost.init_pos = {-80, -(i*gnd_vertical_space*2 + gnd_vertical_space), 0}
        leftmost.parent_element = ground_holder.name
        leftmost.controllers = {{"ground1",i*3+2}}
    AddBoxedHUDElement(leftmost)

end

clip_box_pop()

--[[
local horizon_line 		= my_create_textured_box_2k(18,8,1211,13)
    horizon_line.name 		= create_guid_string()
    horizon_line.material 	= "VDI_BLACK_MAT"
    horizon_line.init_pos 	= {0, 0}
    horizon_line.parent_element = artificial_horizon.name
AddBoxedHUDElement(horizon_line)
--]]

local cruise_takeoff_landing = create_origin()
cruise_takeoff_landing.parent_element = artificial_horizon.name
cruise_takeoff_landing.controllers = {{"pitch_ctl"}}

for i = 1, 180 / 10 do
	if (i - math.floor(i/3) * 3) ~= 0 then
        if (i < 6) then
            local plus_line 		= my_create_textured_box_2k(188,786,173,10)
                plus_line.name 		= create_guid_string()
                plus_line.material 	= "VDI_WHITE_MAT"
                plus_line.init_pos 	= {0, i * _five_degrees * artificial_horizon__vertical_fov_factor}
                plus_line.parent_element = cruise_takeoff_landing.name
                --plus_line.controllers = {{"pitch_mark", i * _five_degrees}}
            AddBoxedHUDElement(plus_line)

            local minus_line 		= my_create_textured_box_2k(188,841,173,10)
                minus_line.name 	= create_guid_string()
                minus_line.material = "VDI_WHITE_MAT"
                minus_line.init_pos = {0, -i * _five_degrees * artificial_horizon__vertical_fov_factor}
                minus_line.parent_element = cruise_takeoff_landing.name
                --minus_line.controllers = {{"pitch_mark", -i * _five_degrees}}
            AddBoxedHUDElement(minus_line)
        end
	else

		local plus_line 		= my_create_textured_box_2k(109,739,116,12)
			plus_line.name 		= create_guid_string() 
			plus_line.material 	= "VDI_WHITE_MAT"
			plus_line.init_pos 	= {-30, i * _five_degrees * artificial_horizon__vertical_fov_factor}
			plus_line.parent_element = cruise_takeoff_landing.name
            --plus_line.controllers = {{"pitch_mark", i * _five_degrees}}
		AddBoxedHUDElement(plus_line)
		
		local plus_line 		= my_create_textured_box_2k(109,739,116,12)
			plus_line.name 		= create_guid_string() 
			plus_line.material 	= "VDI_WHITE_MAT"
			plus_line.init_pos 	= {30, i * _five_degrees * artificial_horizon__vertical_fov_factor}
			plus_line.parent_element = cruise_takeoff_landing.name
            --plus_line.controllers = {{"pitch_mark", i * _five_degrees}}
		AddBoxedHUDElement(plus_line)
		
		local minus_line 		= my_create_textured_box_2k(217,894,115,10)
			minus_line.name 	= create_guid_string() 
			minus_line.material = "VDI_WHITE_MAT"
			minus_line.init_pos = {-30, -i * _five_degrees * artificial_horizon__vertical_fov_factor}
			minus_line.parent_element = cruise_takeoff_landing.name
            --minus_line.controllers = {{"pitch_mark", -i * _five_degrees}}
		AddBoxedHUDElement(minus_line)

		local minus_line 		= my_create_textured_box_2k(217,894,115,10)
			minus_line.name 	= create_guid_string() 
			minus_line.material = "VDI_WHITE_MAT"
			minus_line.init_pos = {30, -i * _five_degrees * artificial_horizon__vertical_fov_factor}
			minus_line.parent_element = cruise_takeoff_landing.name
            --minus_line.controllers = {{"pitch_mark", -i * _five_degrees}}
		AddBoxedHUDElement(minus_line)		
		
	
	
	end 
end

for i = 1,3 do
		local plus_line 		= my_create_textured_box_2k(109,739,116,12)
			plus_line.name 		= create_guid_string()
			plus_line.material 	= "VDI_WHITE_MAT"
			plus_line.init_pos 	= {0, (i-0.5) * _five_degrees * artificial_horizon__vertical_fov_factor}
			plus_line.parent_element = cruise_takeoff_landing.name
            --plus_line.controllers = {{"pitch_5deg"}, {"pitch_mark", (i-0.5) * _five_degrees}}
            plus_line.controllers = {{"pitch_5deg"}}
		AddBoxedHUDElement(plus_line)

		local minus_line 		= my_create_textured_box_2k(217,894,115,10)
			minus_line.name 	= create_guid_string()
			minus_line.material = "VDI_WHITE_MAT"
			minus_line.init_pos = {0, -(i-0.5) * _five_degrees * artificial_horizon__vertical_fov_factor}
			minus_line.parent_element = cruise_takeoff_landing.name
            --minus_line.controllers = {{"pitch_5deg"}, {"pitch_mark", -(i-0.5) * _five_degrees}}
            minus_line.controllers = {{"pitch_5deg"}}
		AddBoxedHUDElement(minus_line)

end

for i = 1, 3 do
	create_custom_number_element(3*i, 0, 3 * i * _five_degrees * artificial_horizon__vertical_fov_factor, 0, cruise_takeoff_landing, 0, true, 1.5)
	create_custom_number_element(-3*i, 0, - 3 * i * _five_degrees * artificial_horizon__vertical_fov_factor, 0, cruise_takeoff_landing, 0, true, 1.5)
	
	create_custom_number_element(9 - 3*i, 0, (9 + 3 * i) * _five_degrees * artificial_horizon__vertical_fov_factor, 0, cruise_takeoff_landing, 0, true, 1.5)
	create_custom_number_element(-9 + 3*i, 0, (-9 - 3 * i) * _five_degrees * artificial_horizon__vertical_fov_factor, 0, cruise_takeoff_landing, 0, true, 1.5)
end

local a2a_a2g = create_origin()
a2a_a2g.parent_element = artificial_horizon.name
a2a_a2g.controllers = {{"pitch_a2a_a2g"}}

for i = 1, 180 / 10 do
	if (i - math.floor(i/3) * 3) == 0 then
		local plus_line 		= my_create_textured_box_2k(109,739,116,12)
			plus_line.name 		= create_guid_string()
			plus_line.material 	= "VDI_WHITE_MAT"
			plus_line.init_pos 	= {-30, 0.5 * i * _five_degrees * artificial_horizon__vertical_fov_factor}
			plus_line.parent_element = a2a_a2g.name
            --plus_line.controllers = {{"pitch_mark", 0.5 *i * _five_degrees}}
		AddBoxedHUDElement(plus_line)

		local plus_line 		= my_create_textured_box_2k(109,739,116,12)
			plus_line.name 		= create_guid_string()
			plus_line.material 	= "VDI_WHITE_MAT"
			plus_line.init_pos 	= {30, 0.5 * i * _five_degrees * artificial_horizon__vertical_fov_factor}
			plus_line.parent_element = a2a_a2g.name
            --plus_line.controllers = {{"pitch_mark", 0.5 * i * _five_degrees}}
		AddBoxedHUDElement(plus_line)

		local minus_line 		= my_create_textured_box_2k(217,894,115,10)
			minus_line.name 	= create_guid_string()
			minus_line.material = "VDI_WHITE_MAT"
			minus_line.init_pos = {-30, -0.5 * i * _five_degrees * artificial_horizon__vertical_fov_factor}
			minus_line.parent_element = a2a_a2g.name
            --minus_line.controllers = {{"pitch_mark", -0.5 * i * _five_degrees}}
		AddBoxedHUDElement(minus_line)

		local minus_line 		= my_create_textured_box_2k(217,894,115,10)
			minus_line.name 	= create_guid_string()
			minus_line.material = "VDI_WHITE_MAT"
			minus_line.init_pos = {30, -0.5 * i * _five_degrees * artificial_horizon__vertical_fov_factor}
			minus_line.parent_element = a2a_a2g.name
            --minus_line.controllers = {{"pitch_mark", -0.5 * i * _five_degrees}}
		AddBoxedHUDElement(minus_line)



	end
end

for i = 1, 3 do
	create_custom_number_element(3*i, 0, 0.5 * 3 * i * _five_degrees * artificial_horizon__vertical_fov_factor, 0, a2a_a2g, 0, true, 1.5)
	create_custom_number_element(-3*i, 0, -0.5 *  3 * i * _five_degrees * artificial_horizon__vertical_fov_factor, 0, a2a_a2g, 0, true, 1.5)

	create_custom_number_element(9 - 3*i, 0, 0.5 * (9 + 3 * i) * _five_degrees * artificial_horizon__vertical_fov_factor, 0, a2a_a2g, 0, true, 1.5)
	create_custom_number_element(-9 + 3*i, 0, 0.5 * (-9 - 3 * i) * _five_degrees * artificial_horizon__vertical_fov_factor, 0, a2a_a2g, 0, true, 1.5)
end

--[[--
create_custom_number_element(12314324, 0, 15, 0, artificial_horizon, 0, true)
create_custom_number_element(12314324, 0, 0, 0, artificial_horizon, 0, false)
create_custom_number_element(-12314324, 0, -15, 0, artificial_horizon, 0, true)
create_custom_number_element(-12314324, 0, -45, 0, artificial_horizon, 0, true, 2)
--]]--


local roll_pointer = my_create_textured_box_2k(1183,1190,27,227,1197,1316)
	roll_pointer.name = create_guid_string()
	roll_pointer.material = "VDI_WHITE_MAT"
	roll_pointer.init_pos = {0, -120, 0}
    roll_pointer.collimated = false
	roll_pointer.parent_element = artificial_roll.name
    roll_pointer.controllers = {{"roll_pointer_adjust"}}
    roll_pointer.isdraw = true
    roll_pointer.isvisible = true
AddBoxedHUDElement(roll_pointer)

disable_box_rotation()
--create_box(0,horizonBox_PosY,horizonBox_width, horizonBox_height, "LIGHT_GREEN_MAT", artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,VDI_DEFAULT_LEVEL + 1, true)
--create_box(0,-horizonBox_PosY,horizonBox_width, horizonBox_height, "DARK_GREEN_MAT", artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,VDI_DEFAULT_LEVEL + 1, true)
--create_box(0, 30, 50, 30, DARK_GREEN_MAT, artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,VDI_DEFAULT_LEVEL + 1, true)
enable_box_rotation()


end
Create_ArtificialHorizon()

clip_box_pop()

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

local compass_scale = 0.12 -- binds directly to scale speed in code

clip_box_push(0,78,36 * _one_degree * compass_scale,30)
--clip_box_push(0,0,30 * _one_degree * compass_scale,120)

local grid_origin = create_origin()

function Create_Compass(PosX, PosY)

local compass_holder	 = CreateElement "ceSimple"
	compass_holder.name = create_guid_string() 
	compass_holder.collimated = false
	compass_holder.init_pos = {PosX, PosY, 0}
	compass_holder.parent_element = grid_origin.name
AddBoxedHUDElement(compass_holder)

local compass	 = CreateElement "ceSimple"
	compass.name = create_guid_string() 
	compass.collimated = false
	compass.init_pos = {0, 0, 0}
	compass.parent_element = compass_holder.name
	compass.controllers = {{"compass", compass_scale}}
AddBoxedHUDElement(compass)

-- command heading marker
local command_heading 		= my_create_textured_box_2k(679,321,43,29)
	command_heading.name 	= create_guid_string()
	command_heading.material = "VDI_WHITE_MAT"
	command_heading.init_pos = {0, 2, 0}
	command_heading.parent_element = compass_holder.name
    command_heading.controllers = {{"command_heading", compass_scale}}
AddBoxedHUDElement(command_heading)

local compass_pointer 		= my_create_textured_box_2k(632,322,42,29)
	compass_pointer.name 	= create_guid_string()
	compass_pointer.material = "VDI_WHITE_MAT"
	compass_pointer.init_pos = {0, 30, 0}
	compass_pointer.parent_element = compass_holder.name
AddBoxedHUDElement(compass_pointer)

---[[
local compassY = 28
local text_offset = -15

for i = -5, 41 do -- -50 to 410 degrees

	local compass_10mark 		= my_create_textured_box_2k(1197,362,8,38)
		compass_10mark.name 	= create_guid_string() 
		compass_10mark.material = "VDI_WHITE_MAT"
		compass_10mark.init_pos = {i * 2 * _five_degrees * compass_scale, compassY, 0}
		compass_10mark.parent_element = compass.name
        compass_10mark.controllers = {{"compass_mark", i * 2 * _five_degrees_rad}}
	AddBoxedHUDElement(compass_10mark)
	
	local compass_5mark 		= my_create_textured_box_2k(1225,363,8,38)
		compass_5mark.name 	= create_guid_string() 
		compass_5mark.material = "VDI_WHITE_MAT"
		compass_5mark.init_pos = {(i * 2 + 1 ) * _five_degrees * compass_scale, compassY, 0}
		compass_5mark.parent_element = compass.name
        compass_5mark.controllers = {{"compass_mark", (i * 2 + 1 ) * _five_degrees_rad}}
	AddBoxedHUDElement(compass_5mark)
	
	local index = i
	if i >= 36 then
		index = i - 36
	end	
	if i < 0 then
		index = i + 36
	end

    create_custom_number_element(index, 0, text_offset, 0, compass_10mark,1)
end


--]]--

create_custom_number_element(1234, 0, 0, 0, grid_origin, 6)

end
Create_Compass(0, 73)

-- TODO: steering tee
-- TODO: VDI pitch compression: "pitch lines determined by the total amount of pitch attitude displayed on the VDI.
--                               For A/A  and A/G, 130° of pitch is displayed with the pitch lines every 30°. Takeoff,
--                               cruise, and landing display a total of 65°. However, takeoff and cruise have pitch lines
--                               graduated every 10° between ±60°; the landing displays are also graduated every 5° between ±30°."


clip_box_pop()

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------