dofile(LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/definitions.lua")


--[[-- -- working tests

clip_box_in(0,0,75,25,DBG_GREEN)

create_box(30,30,100,100,DBG_RED, nil, h_clip_relations.DECREASE_IF_LEVEL ,HUD_DEFAULT_LEVEL + 1, true)--, nil, HUD_DEFAULT_LEVEL + 1)

clip_box_out(0,0,75,25,DBG_GREEN)

clip_box_in(0,100,75,25,DBG_GREEN)

create_box(30,30,100,100,DBG_GREEN, nil, h_clip_relations.DECREASE_IF_LEVEL ,HUD_DEFAULT_LEVEL + 1, true)--, nil, HUD_DEFAULT_LEVEL + 1)

clip_box_out(0,100,75,25,DBG_GREEN)

--]]--

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

clip_box_in(0,-25,200,200)

local grid_origin = create_origin()

local ac_reticle_origin = create_origin()
ac_reticle_origin.init_pos = {0, -5.03*_one_degree, 0}

-- aircraft reticle
-- 60mil wide, 10 mil high
local static_plane 			= my_create_textured_box_2k(13,452,255,69,nil,139,470)
	static_plane.name 	= create_guid_string() 
	static_plane.material = "HUD_MAT"
	static_plane.init_pos = {0, 0, 0}
	static_plane.parent_element = ac_reticle_origin.name
    static_plane.controllers = {{"hud_aircraft_reticle"}}
AddBoxedHUDElement(static_plane)

-- 20mil high, 5mil wide
local aoa_error = my_create_textured_box_2k(93,163,51,103,nil,119,212)
    aoa_error.name = create_guid_string()
    aoa_error.material = "HUD_MAT"
    aoa_error.init_pos = {-1*_one_degree, 0, 0}
    aoa_error.parent_element = static_plane.name
    aoa_error.controllers = {{"hud_aoa_error"}}
AddBoxedHUDElement(aoa_error)

-- 30mil wide, 15mil high
local velocity_vector 			= my_create_textured_box_2k(37,328,168,95,nil,119,386)
	velocity_vector.name 	= create_guid_string() 
	velocity_vector.material = "HUD_MAT"
	velocity_vector.init_pos = {0, 0, 0}
	velocity_vector.parent_element = grid_origin.name
	velocity_vector.controllers = {{"hud_velocity_vector"}}
AddBoxedHUDElement(velocity_vector)

--[[
-- TODO: use texture with ceSimpleLineObject, or texture with ceHWLine
local ccip_bomb_fall_line = CreateElement "ceSimpleLineObject"
    ccip_bomb_fall_line.name 	= create_guid_string()
    ccip_bomb_fall_line.material	 		= "HUD_GREEN" -- MakeMaterial(nil,{220,120,20,255}) --"HUD_GREEN"
    ccip_bomb_fall_line.width        		= 1 -- 0.002 --1
    ccip_bomb_fall_line.isvisible = true
    ccip_bomb_fall_line.controllers  		= {{"hud_ccip_bfl"}}
    ccip_bomb_fall_line.parent_element = grid_origin.name
    --ccip_bomb_fall_line.additive_alpha = false
    --ccip_bomb_fall_line.use_mipfilter = false
AddBoxedHUDElement(ccip_bomb_fall_line)
--]]

local bomb_fall_line 			= my_create_textured_box_2k(0,0,2045,18,nil,1024,9)
	bomb_fall_line.name 	= create_guid_string()
	bomb_fall_line.material = "HUD_MAT"
	bomb_fall_line.init_pos = {0, 0, 0}
	bomb_fall_line.parent_element = grid_origin.name
	bomb_fall_line.controllers = {{"hud_ccip_bfl"}}
AddBoxedHUDElement(bomb_fall_line)

-- pullup cue  30mil wide, 10 mil high
local pullup_cue 			= my_create_textured_box_2k(323,457,141,63,nil,395,508)
	pullup_cue.name 	= create_guid_string()
	pullup_cue.material = "HUD_MAT"
	pullup_cue.init_pos = {0, 0, 0}
	pullup_cue.parent_element = velocity_vector.name
	pullup_cue.controllers = {{"hud_pullup_cue"}}
AddBoxedHUDElement(pullup_cue)

local upper_solution_cue 			= my_create_textured_box_2k(331,522,130,17,nil,395,530)
	upper_solution_cue.name 	= create_guid_string()
	upper_solution_cue.material = "HUD_MAT"
	upper_solution_cue.init_pos = {0, 0, 0}
	upper_solution_cue.parent_element = grid_origin.name
	upper_solution_cue.controllers = {{"hud_upper_solution_cue",180*GetScale()}}
AddBoxedHUDElement(upper_solution_cue)

local lower_solution_cue 			= my_create_textured_box_2k(332,538,90,16,nil,376,545)
	lower_solution_cue.name 	= create_guid_string()
	lower_solution_cue.material = "HUD_MAT"
	lower_solution_cue.init_pos = {0, 0, 0}
	lower_solution_cue.parent_element = grid_origin.name
	lower_solution_cue.controllers = {{"hud_lower_solution_cue",180*GetScale()}}
AddBoxedHUDElement(lower_solution_cue)

local steering_tee 			= my_create_textured_box_2k(51,549,134,64,nil,117,594)
	steering_tee.name 	= create_guid_string()
	steering_tee.material = "HUD_MAT"
	steering_tee.init_pos = {0, 0, 0}
	steering_tee.parent_element = static_plane.name
	steering_tee.controllers = {{"hud_steering_tee"}}
AddBoxedHUDElement(steering_tee)

local movable_reticle 			= my_create_textured_box_2k(272,135,258,258,nil,400,262)
	movable_reticle.name 	= create_guid_string()
	movable_reticle.material = "HUD_MAT"
	movable_reticle.init_pos = {0, 0, 0}
	movable_reticle.parent_element = grid_origin.name
	movable_reticle.controllers = {{"hud_movable_reticle"}}
AddBoxedHUDElement(movable_reticle)

local boresight 			= my_create_textured_box_2k(73,771,94,90,nil,119,814)
	boresight.name 	= create_guid_string()
	boresight.material = "HUD_MAT"
	boresight.init_pos = {0, 0, 0}
	boresight.parent_element = grid_origin.name
	boresight.controllers = {{"hud_boresight"}}
AddBoxedHUDElement(boresight)

local target_designator 			= my_create_textured_box_2k(66,1029,110,110,nil,120.5,1082.5)
	target_designator.name 	= create_guid_string()
	target_designator.material = "HUD_MAT"
	target_designator.init_pos = {0, 0, 0}
	target_designator.parent_element = grid_origin.name
	target_designator.controllers = {{"hud_target_designator"}}
AddBoxedHUDElement(target_designator)

--[[
-- 40 milliradian (2.3deg) PLM radar mode indicator
local radar_plm 			= my_create_textured_box_2k(40,1330,168,168)
	radar_plm.name 	= create_guid_string()
	radar_plm.material = "HUD_MAT"
	radar_plm.init_pos = {0, 0, 0}
	radar_plm.parent_element = grid_origin.name
	radar_plm.controllers = {{"hud_radar_plm"}}
AddBoxedHUDElement(radar_plm)

-- 12deg sparrow flood indicator
local sparrow_flood 			= my_create_textured_box_2k(390,720,412,412)
	sparrow_flood.name 	= create_guid_string()
	sparrow_flood.material = "HUD_MAT"
	sparrow_flood.init_pos = {0, 0, 0}
	sparrow_flood.parent_element = grid_origin.name
	sparrow_flood.controllers = {{"hud_sparrow_flood"}}
AddBoxedHUDElement(sparrow_flood)
--]]

local breakaway 			= my_create_textured_box_2k(48,1735,235,232,nil,165,1853)
	breakaway.name 	= create_guid_string()
	breakaway.material = "HUD_MAT"
	breakaway.init_pos = {0, 0, 0}
	breakaway.parent_element = ac_reticle_origin.name
	breakaway.controllers = {{"hud_breakaway"}}
AddBoxedHUDElement(breakaway)

local weapon_indicator= my_create_textured_box_2k(1706,25,216,84)
    weapon_indicator.name 	= create_guid_string()
    weapon_indicator.material = "HUD_MAT"
    weapon_indicator.init_pos = {0, -7.9*_one_degree, 0}
    weapon_indicator.parent_element = grid_origin.name
    weapon_indicator.controllers = {{"hud_weapons_indicator"}}
    weapon_indicator.state_tex_coords = {
        --get_tex_coord(1706,25,216,84,2048,2048), -- G
        get_tex_coord(1505,25,216,84,2048,2048), -- SW
        get_tex_coord(1302,25,216,84,2048,2048), -- SP
        get_tex_coord(1094,25,216,84,2048,2048), -- PH
        get_tex_coord(870,25,216,84,2048,2048), -- ORD
    }
AddBoxedHUDElement(weapon_indicator)

local ammo_indicator= my_create_textured_box_2k(20,25,58,80)
    ammo_indicator.name 	= create_guid_string()
    ammo_indicator.material = "HUD_MAT"
    ammo_indicator.init_pos = {0, -8.9*_one_degree, 0}
    ammo_indicator.parent_element = grid_origin.name
    ammo_indicator.controllers = {{"hud_ammo_indicator"}}
    ammo_indicator.state_tex_coords = {
        --get_tex_coord(20,25,58,80,2048,2048), -- 0
        get_tex_coord(20+1*55.55,25,58,80,2048,2048), -- 1
        get_tex_coord(20+2*55.55,25,58,80,2048,2048), -- 2
        get_tex_coord(20+3*55.55,25,58,80,2048,2048), -- 3
        get_tex_coord(20+4*55.55,25,58,80,2048,2048), -- 4
        get_tex_coord(20+5*55.55,25,58,80,2048,2048), -- 5
        get_tex_coord(20+6*55.55,25,58,80,2048,2048), -- 6
        get_tex_coord(20+7*55.55,25,58,80,2048,2048), -- 7
        get_tex_coord(20+8*55.55,25,58,80,2048,2048), -- 8
        get_tex_coord(20+9*55.55,25,58,80,2048,2048), -- 9

    }
AddBoxedHUDElement(ammo_indicator)

local armoff_indicator 			= my_create_textured_box_2k(988,449,216,92,nil,1095,495)
	armoff_indicator.name 	= create_guid_string()
	armoff_indicator.material = "HUD_MAT"
	armoff_indicator.init_pos = {0, -7.9*_one_degree, 0}
	armoff_indicator.parent_element = grid_origin.name
	armoff_indicator.controllers = {{"hud_armoff_indicator"}}
AddBoxedHUDElement(armoff_indicator)

local vert_precision_course = my_create_textured_box_2k(442,1274,314,20,nil,599,1284)
    vert_precision_course.name = create_guid_string()
    vert_precision_course.material = "HUD_MAT"
    vert_precision_course.init_pos = {0, 0, 0}
    vert_precision_course.parent_element = static_plane.name
    vert_precision_course.controllers = {{"hud_vert_course"}}
AddBoxedHUDElement(vert_precision_course)

local horiz_precision_course = my_create_textured_box_2k(359,1272,17,311)
    horiz_precision_course.name = create_guid_string()
    horiz_precision_course.material = "HUD_MAT"
    horiz_precision_course.init_pos = {0, 0, 0}
    horiz_precision_course.parent_element = static_plane.name
    horiz_precision_course.controllers = {{"hud_horiz_course"}}
    horiz_precision_course.state_tex_coords = {
        --get_tex_coord(359,1272,17,311,2048,2048), -- solid line
        get_tex_coord(339,1272,17,311,2048,2048), -- dashed line
    }
AddBoxedHUDElement(horiz_precision_course)

function Create_ArtificialHorizon()

    local artificial_horizon	 = CreateElement "ceSimple"
        artificial_horizon.name = create_guid_string()
        artificial_horizon.collimated = true
        artificial_horizon.init_pos = {0, 0, 0}
        artificial_horizon.parent_element = static_plane.name
        artificial_horizon.controllers = {{"hud_artificial_horizon"}}
    AddBoxedHUDElement(artificial_horizon)

    local plus_line 		= my_create_textured_box_2k(486,1386,513,18,nil,742,1395)
        plus_line.name 		= create_guid_string()
        plus_line.material 	= "HUD_MAT"
        plus_line.init_pos 	= {0, 0, 0}
        plus_line.parent_element = artificial_horizon.name
    AddBoxedHUDElement(plus_line)

    for i = 1, 180 / 5 do
        local plus_line 		= my_create_textured_box_2k(486,1386,513,18,nil,742,1395)
            plus_line.name 		= create_guid_string()
            plus_line.material 	= "HUD_MAT"
            plus_line.init_pos 	= {0, i * _five_degrees, 0}
            plus_line.parent_element = artificial_horizon.name
        AddBoxedHUDElement(plus_line)

        local minus_line 		= my_create_textured_box_2k(486,1480,513,16,nil,742,1488)
            minus_line.name 	= create_guid_string()
            minus_line.material = "HUD_MAT"
            minus_line.init_pos = {0, -i * _five_degrees, 0}
            minus_line.parent_element = artificial_horizon.name
        AddBoxedHUDElement(minus_line)
    end

    for i = 1, 90 /5 do
        create_custom_number_element(5*i, -68, i * _five_degrees - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(5*i, 68, i * _five_degrees - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(-5*i, -68, -i * _five_degrees - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(-5*i, 68, -i * _five_degrees - 5, 0, artificial_horizon, 0, true, 0.5)

        create_custom_number_element(90 - 5*i, -68, (90 / 5 + i) * _five_degrees - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(90 - 5*i, 68, (90 / 5 + i) * _five_degrees - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(-90 + 5*i, -68, (-90 / 5 -i) * _five_degrees - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(-90 + 5*i, 68,(-90 / 5 -i) * _five_degrees - 5, 0, artificial_horizon, 0, true, 0.5)
    end

end
Create_ArtificialHorizon()

function Create_ArtificialHorizonCompressed()
    local quarter30deg = math.rad(30/4) * 1000
    local artificial_horizon	 = CreateElement "ceSimple"
        artificial_horizon.name = create_guid_string()
        artificial_horizon.collimated = true
        artificial_horizon.init_pos = {0, 0, 0}
        artificial_horizon.parent_element = static_plane.name
        artificial_horizon.controllers = {{"hud_artificial_horizon_compressed"}}
    AddBoxedHUDElement(artificial_horizon)

    local plus_line 		= my_create_textured_box_2k(486,1386,513,18,nil,742,1395)
        plus_line.name 		= create_guid_string()
        plus_line.material 	= "HUD_MAT"
        plus_line.init_pos 	= {0, 0, 0}
        plus_line.parent_element = artificial_horizon.name
    AddBoxedHUDElement(plus_line)

    for i = 1, 90 / 3 do
        local plus_line 		= my_create_textured_box_2k(486,1386,513,18,nil,742,1395)
            plus_line.name 		= create_guid_string()
            plus_line.material 	= "HUD_MAT"
            plus_line.init_pos 	= {0, i * quarter30deg, 0}
            plus_line.parent_element = artificial_horizon.name
        AddBoxedHUDElement(plus_line)

        local minus_line 		= my_create_textured_box_2k(486,1480,513,16,nil,742,1488)
            minus_line.name 	= create_guid_string()
            minus_line.material = "HUD_MAT"
            minus_line.init_pos = {0, -i * quarter30deg, 0}
            minus_line.parent_element = artificial_horizon.name
        AddBoxedHUDElement(minus_line)
    end

    for i = 1, 90 / 30 do
        create_custom_number_element(30*i, -68, i * quarter30deg - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(30*i, 68, i * quarter30deg - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(-30*i, -68, -i * quarter30deg - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(-30*i, 68, -i * quarter30deg - 5, 0, artificial_horizon, 0, true, 0.5)

        create_custom_number_element(90 - 30*i, -68, (90 / 7.5 + i) * quarter30deg - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(90 - 30*i, 68, (90 / 7.5 + i) * quarter30deg - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(-90 + 30*i, -68, (-90 / 7.5 -i) * quarter30deg - 5, 0, artificial_horizon, 0, true, 0.5)
        create_custom_number_element(-90 + 30*i, 68,(-90 / 7.5 -i) * quarter30deg - 5, 0, artificial_horizon, 0, true, 0.5)
    end

end
Create_ArtificialHorizonCompressed()

clip_box_out(0,-25,200,200)

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

local compass_scale = 0.23 -- binds directly to scale speed in code

local compass_clipbox = clip_box_in(0,7,17 * _one_degree * compass_scale,40, "compassclip_"..create_guid_string()) -- hud_compass_num controller searches for this name

local grid_origin = create_origin(compass_clipbox)

function Create_Compass(PosX, PosY)

local compass_holder	 = CreateElement "ceSimple"
	compass_holder.name = "compassholder_"..create_guid_string()
	compass_holder.collimated = true
	compass_holder.init_pos = {PosX, PosY, 0}
	compass_holder.parent_element = grid_origin.name
	compass_holder.controllers = {{"hud_compass_scale"}}
AddBoxedHUDElement(compass_holder)

local compassY = 0

local compass	 = CreateElement "ceSimple"
	compass.name = "compass_"..create_guid_string()
	compass.collimated = true
	compass.init_pos = {0, 0, 0}
	compass.parent_element = compass_holder.name
	compass.controllers = {{"hud_compass", compass_scale}}
AddBoxedHUDElement(compass)

local compass_pointer 		= my_create_textured_box_2k(1313,469,70,57,nil,1347,475)
	compass_pointer.name 	= create_guid_string() 
	compass_pointer.material = "HUD_MAT"
	compass_pointer.init_pos = {0, compassY-6, 0}
	compass_pointer.parent_element = compass_holder.name
AddBoxedHUDElement(compass_pointer)

for i = -2, 38 do -- -20 to 380

	local compass_10mark 		= my_create_textured_box_2k(1540,467,17,53,nil,1548,495)
		compass_10mark.name 	= create_guid_string() 
		compass_10mark.material = "HUD_MAT"
		compass_10mark.init_pos = {i * 2 * _five_degrees * compass_scale, compassY, 0}
		compass_10mark.parent_element = compass.name
        compass_10mark.controllers = {{"hud_compass_mark", i * 2 * _five_degrees_rad}}
	AddBoxedHUDElement(compass_10mark)
	
	local compass_5mark 		= my_create_textured_box_2k(1724,482,18,18,nil,1733,491)
		compass_5mark.name 	= create_guid_string() 
		compass_5mark.material = "HUD_MAT"
		compass_5mark.init_pos = {(i * 2 + 1 ) * _five_degrees * compass_scale, compassY, 0}
		compass_5mark.parent_element = compass.name
		compass_5mark.controllers = {{"hud_compass_mark", (i * 2 + 1 ) * _five_degrees_rad}}
	AddBoxedHUDElement(compass_5mark)
	
	
	local index = i
	if i >= 36 then
		index = i - 36
	end	
	if i < 0 then
		index = i + 36
	end

    create_custom_number_element(index, 0, 12.0, 0, compass_10mark,1,nil,1.0,"compass_"..tostring(index).."-"..tostring(i)..create_guid_string(),{{"hud_compass_num", index*10}})
end

end
Create_Compass(0, 0)

clip_box_out(0,7,15 * _one_degree * compass_scale,40)

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

clip_box_in(-95,-88,25,120)

local grid_origin = create_origin()

function Create_VerticalSpeed(PosX, PosY)

-- vertical velocity indicator
-- range displayed +- 1500 ft/min
-- gradations 500 ft / min

--      .
--    +1.
--      .
--     0.
--      .
--    -1.
--      .

local vertical_speed	 			= CreateElement "ceSimple"
	vertical_speed.name 			= create_guid_string()
	vertical_speed.collimated 	= true
	vertical_speed.init_pos 		= {PosX, PosY, 0}
	vertical_speed.parent_element = grid_origin.name
	vertical_speed.controllers = {{"hud_vertical_speed_scale"}}
AddBoxedHUDElement(vertical_speed)

local vvel_distance = 15.0
for i = 0, 6 do

	local vvel_mark 		= my_create_textured_box_2k(1724,482,18,18,nil,1733,491)
			vvel_mark.name 	= create_guid_string() 
			vvel_mark.material = "HUD_MAT"
			vvel_mark.init_pos = { 0, (i - 7 / 2) * vvel_distance, 0}
			vvel_mark.parent_element = vertical_speed.name
	AddBoxedHUDElement(vvel_mark)

end

create_custom_number_element( 1, -15, (5 - 7 / 2) * vvel_distance, 0, vertical_speed,0,true,1.0)
create_custom_number_element( 0, -10, (3 - 7 / 2) * vvel_distance, 0, vertical_speed,0,true,1.0)
create_custom_number_element(-1, -15, (1 - 7 / 2) * vvel_distance, 0, vertical_speed,0,true,1.0)

-- 10mil x 10mil
local vvel_pointer 		= my_create_textured_box_2k(1903,463,57,60,nil,1930,493)
	vvel_pointer.name 	= create_guid_string() 
	vvel_pointer.material = "HUD_MAT"
	vvel_pointer.init_pos = {10, (3 - 7 / 2) * vvel_distance, 0}
	vvel_pointer.parent_element = vertical_speed.name
	vvel_pointer.controllers = {{"hud_vertical_speed", (6 - 7 / 2) * vvel_distance - (3 - 7 / 2) * vvel_distance }}
AddBoxedHUDElement(vvel_pointer)

end
Create_VerticalSpeed(-90, -80)

function Create_ClosureRate(PosX, PosY)

-- closure rate indicator
-- range displayed -200 to 1000 knots
-- gradations 200
-- top 10 aligned to boresight cross
-- 0 aligned to a/c reticle

--    10.      +
--      .
--      .
--      .
--      .
--     0.     _ _
--    -2.      "

local closure_rate	 			= CreateElement "ceSimple"
	closure_rate.name 			= create_guid_string()
	closure_rate.collimated 	= true
	closure_rate.init_pos 		= {PosX, PosY, 0}
	closure_rate.parent_element = grid_origin.name
	closure_rate.controllers = {{"hud_closure_rate_scale"}}
AddBoxedHUDElement(closure_rate)

local clos_distance = 17.55
for i = 0, 6 do

	local clos_mark 		= my_create_textured_box_2k(1724,482,18,18,nil,1733,491)
			clos_mark.name 	= create_guid_string()
			clos_mark.material = "HUD_MAT"
			clos_mark.init_pos = { 0, (i - 1) * clos_distance, 0}
			clos_mark.parent_element = closure_rate.name
	AddBoxedHUDElement(clos_mark)

end

create_custom_number_element(10, -20, (clos_distance*5), 0, closure_rate,0,nil,1.0)
create_custom_number_element(0,  -10, 0, 0, closure_rate,0,nil,1.0)
create_custom_number_element(-2, -15, -clos_distance, 0, closure_rate,0,true,1.0)

-- 10mil x 10mil
local clos_pointer 		= my_create_textured_box_2k(1903,463,57,60,nil,1930,493)
	clos_pointer.name 	= create_guid_string()
	clos_pointer.material = "HUD_MAT"
	clos_pointer.init_pos = {10, -clos_distance, 0}
	clos_pointer.parent_element = closure_rate.name
	clos_pointer.controllers = {{"hud_closure_rate", 6*clos_distance}}
AddBoxedHUDElement(clos_pointer)

end
Create_ClosureRate(-90, -5.03*_one_degree)


function Create_IASindicator(PosX, PosY)
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

-- ias indicator
-- range displayed - 100kn
-- range 0 - 600 kn
-- gradations 10kn
-- values show x100kn

--      . 100
--     >.
--      . 0
end

clip_box_out(-95,-88,25,120)

clip_box_in(95,-88,25,120)

local grid_origin = create_origin()

function Create_Altimeter(PosX, PosY)

-- barometric altitude indicator
-- range displayed 0 - 14000 ft
-- range 0 - 14000 ft
-- gradations 2000 ft

-- radar altitude indicator
-- range displayed - 1400 ft
-- gradations 200 ft

--      .
--      .
--      .10
--      .
--      .
--      .
--      .
--      .0

local altimeter_element	 = CreateElement "ceSimple"
	altimeter_element.name = create_guid_string()
	altimeter_element.collimated = true
	altimeter_element.init_pos = {PosX, PosY, 0}
	altimeter_element.parent_element = grid_origin.name
	altimeter_element.controllers = {{"hud_altimeter_scale"}}
AddBoxedHUDElement(altimeter_element)

local alt_distance = 15.0

for i = 0, 7 do

	local altimeter_mark 		= my_create_textured_box_2k(1724,482,18,18,nil,1733,491)
			altimeter_mark.name 	= create_guid_string()
			altimeter_mark.material = "HUD_MAT"
			altimeter_mark.init_pos = { 0, i * alt_distance, 0}
			altimeter_mark.parent_element = altimeter_element.name
	AddBoxedHUDElement(altimeter_mark)

end

-- 10mil x 10mil
local altimeter_pointer 		= my_create_textured_box_2k(1900,239,53,58,nil,1928,268)
	altimeter_pointer.name 	= create_guid_string()
	altimeter_pointer.material = "HUD_MAT"
	altimeter_pointer.init_pos = {-10, 0, 0}
	altimeter_pointer.parent_element = altimeter_element.name
	altimeter_pointer.controllers = {{"hud_altimeter",5*alt_distance}}
AddBoxedHUDElement(altimeter_pointer)

local num_elem, digits = create_custom_number_element(10, 15, 5*alt_distance, 0, altimeter_element, 2, nil, 1.0) -- digit at 10k/1k feet
digits[2].controllers = {{"hud_baro_radar_digit"}} -- control visibility of 0 of "10" for either baro or radar altimeter
create_custom_number_element(0, 10, 0, 0, altimeter_element, nil, nil, 1.0)
end
Create_Altimeter(90, -163)

function Create_TargetRange(PosX, PosY, mark_distance)
-- target range indicator
-- 5,10,20,50,100,200 nautical miles scale determined by RIO (range pushbuttons on DDD panel),
-- 1,5,10,20 range scale in gun STT mode

-- +    .20   .10    .5             10
--      .     .                     9
--      ._    ._     ._     .1      8
--      .     .     >       .       7
--      .     .      .      .       6
--_ _   .     .             ._      5
-- "    .     .      .      .       4
--      ._    ._           >.       3
--     >.    >.      ._     ._      2
--      .     .                     1
--                                  0
local targetrange_element	 = CreateElement "ceSimple"
	targetrange_element.name = create_guid_string()
	targetrange_element.collimated = true
	targetrange_element.init_pos = {PosX, PosY, 0}
	targetrange_element.parent_element = grid_origin.name
	targetrange_element.controllers = {{"hud_targetrange_scale"}}
AddBoxedHUDElement(targetrange_element)

for i = 1, 10 do

	local targetrange_mark 		= my_create_textured_box_2k(1724,482,18,18,nil,1733,491)
			targetrange_mark.name 	= create_guid_string()
			targetrange_mark.material = "HUD_MAT"
			targetrange_mark.init_pos = { 0, i * mark_distance, 0}
			targetrange_mark.controllers = {{"hud_targetrange_dot", i}}
			targetrange_mark.parent_element = targetrange_element.name
	AddBoxedHUDElement(targetrange_mark)

end

-- 10mil x 10mil
local targetrange_pointer 		= my_create_textured_box_2k(1900,239,53,58,nil,1928,268)
	targetrange_pointer.name 	= create_guid_string()
	targetrange_pointer.material = "HUD_MAT"
	targetrange_pointer.init_pos = {-10, 0 * mark_distance, 0}
	targetrange_pointer.parent_element = targetrange_element.name
	targetrange_pointer.controllers = {{"hud_targetrange", 10*mark_distance}}
AddBoxedHUDElement(targetrange_pointer)

local r1=create_custom_number_element(1, 10, 8*mark_distance, 0, targetrange_element, nil, nil, 1.0)
r1.controllers = {{"hud_targetrange_max",1}}
r1.isdraw = false
local r5=create_custom_number_element(5, 10, 10*mark_distance, 0, targetrange_element, nil, nil, 1.0)
r5.controllers = {{"hud_targetrange_max",2}}
r5.isdraw = false
local r10=create_custom_number_element(10, 15, 10*mark_distance, 0, targetrange_element, nil, nil, 1.0)
r10.controllers = {{"hud_targetrange_max",3}}
r10.isdraw = false
local r20=create_custom_number_element(20, 15, 10*mark_distance, 0, targetrange_element, nil, nil, 1.0)
r20.controllers = {{"hud_targetrange_max",4}}
r20.isdraw = false
local r50=create_custom_number_element(50, 15, 10*mark_distance, 0, targetrange_element, nil, nil, 1.0)
r50.controllers = {{"hud_targetrange_max",5}}
r50.isdraw = false
local r100=create_custom_number_element(100, 20, 10*mark_distance, 0, targetrange_element, nil, nil, 1.0)
r100.controllers = {{"hud_targetrange_max",6}}
r100.isdraw = false
local r200=create_custom_number_element(200, 20, 10*mark_distance, 0, targetrange_element, nil, nil, 1.0)
r200.controllers = {{"hud_targetrange_max",7}}
r200.isdraw = false

local target_rmin 		= my_create_textured_box_2k(1900,374,56,17,nil,1931,382)
	target_rmin.name 	= create_guid_string()
	target_rmin.material = "HUD_MAT"
	target_rmin.init_pos = {10, 0 * mark_distance, 0}
	target_rmin.parent_element = targetrange_element.name
	target_rmin.controllers = {{"hud_dlz", 10*mark_distance, 0}}
AddBoxedHUDElement(target_rmin)

local target_rmax 		= my_create_textured_box_2k(1900,374,56,17,nil,1931,382)
	target_rmax.name 	= create_guid_string()
	target_rmax.material = "HUD_MAT"
	target_rmax.init_pos = {10, 0 * mark_distance, 0}
	target_rmax.parent_element = targetrange_element.name
	target_rmax.controllers = {{"hud_dlz", 10*mark_distance, 1}}
AddBoxedHUDElement(target_rmax)

end
Create_TargetRange(90, -5.03*_one_degree - (5*17.55),17.55)

clip_box_out(95,-88,25,120)