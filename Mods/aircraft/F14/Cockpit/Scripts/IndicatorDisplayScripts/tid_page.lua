--[[
local background = CreateElement "ceMeshPoly"
    background.name = create_guid_string()
    background.primitivetype = "triangles"
    background.vertices = { {-1,-aspect},
                      {-1,aspect},
                      { 1,aspect},
                      {1,-aspect}}
    background.indices = default_box_indices
    background.material = MakeMaterial(nil,{0,0,0,255})
AddElement(background)
--]]

local TID_fontsize=0.056 * half_height

function create_root(name)
	local root_origin = create_origin(name)
    root_origin.controllers = {{name}}
    return root_origin
end

local tactical_symbols = create_root("tactical_symbols")

local aircraft_origin = create_origin("TID_ownAC")
aircraft_origin.parent_element = tactical_symbols.name
aircraft_origin.controllers = {{"TID_origin"}}

-- aircraft reticle
local aircraft_reticle = my_create_textured_box_1k(200,400,200,200,nil,nil,1/4)
    aircraft_reticle.name = create_guid_string()
    aircraft_reticle.material = "TID_MAT2"
    aircraft_reticle.parent_element = aircraft_origin.name
    aircraft_reticle.isdraw = true
    aircraft_reticle.isvisible = true
AddElement(aircraft_reticle)
local aircraft_reticle2 = my_create_textured_box_1k(800,0,200,200,nil,nil,1/4)
    aircraft_reticle2.name = create_guid_string()
    aircraft_reticle2.material = "TID_MAT2"
    aircraft_reticle2.parent_element = aircraft_origin.name
    aircraft_reticle2.isdraw = true
    aircraft_reticle2.isvisible = true
AddElement(aircraft_reticle2)
local ac_code           = CreateElement "ceStringPoly"
    ac_code.name            = create_guid_string()
    ac_code.material        = "font_TID"
    ac_code.parent_element = aircraft_origin.name
    ac_code.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    ac_code.init_pos = {-0.03,0}
    ac_code.alignment     = "RightCenter"
    ac_code.controllers = {{"TID_own_code"}}
    ac_code.isdraw = false
AddElement(ac_code)

local steer_ref = create_origin()
steer_ref.controllers = {{"TID_steer_ref"}}
steer_ref.parent_element = tactical_symbols.name
local vertical_line = my_create_textured_box_1k(800,600,200,200,nil,nil,1/4)
    vertical_line.name = create_guid_string()
    vertical_line.material = "TID_MAT2"
    vertical_line.parent_element = steer_ref.name
    vertical_line.isdraw = true
    vertical_line.isvisible = true
AddElement(vertical_line)
local horizontal_line = my_create_textured_box_1k(0,800,200,200,nil,nil,1/4)
    horizontal_line.name = create_guid_string()
    horizontal_line.material = "TID_MAT2"
    horizontal_line.parent_element = steer_ref.name
    horizontal_line.isdraw = true
    horizontal_line.isvisible = true
AddElement(horizontal_line)

local ownshipvec = create_textured_line_2k(22, 10, 880, 12)
    ownshipvec.name 	= create_guid_string()
    ownshipvec.material = "TID_MAT"
    ownshipvec.parent_element = aircraft_origin.name
    ownshipvec.controllers = {{"TID_ownshipvec"}}
    ownshipvec.isvisible = true
AddElement(ownshipvec)

-- line from center to ownship in gnd stab when offscreen
local lineto_ownship = my_create_textured_box_2k(2033,23,8,2007,2036.5,2025)
    lineto_ownship.name = create_guid_string()
    lineto_ownship.parent_element = tactical_symbols.name
    lineto_ownship.material = "TID_MAT"
    lineto_ownship.isdraw = true
    lineto_ownship.isvisible = true
    lineto_ownship.controllers = {{"TID_lineto_ownship"}}
AddElement(lineto_ownship)

local center_plus = my_create_textured_box_2k(546,897,47,47)
    center_plus.name = create_guid_string()
    center_plus.parent_element = tactical_symbols.name
    center_plus.material = "TID_MAT"
    center_plus.isdraw = false
    center_plus.isvisible = true
    --center_plus.controllers = {{"TID_centerplus"}}
AddElement(center_plus)

function create_waypoint(name,text_x,text_y,xsize,ysize,xcenter,ycenter,show_alt,show_dot,num)
    local wp_origin
    if (num ~= nil) then
        wp_origin= create_origin("TID_wp_"..tostring(num))
        wp_origin.controllers = {{"TID_waypoint",num}, {"TID_wp_bright",num}}
    else
        -- used for TWS AUTO steering centroid
        wp_origin= create_origin("wp_"..name)
        wp_origin.controllers = {{"TID_tws_steering"}}
    end
    wp_origin.parent_element = tactical_symbols.name
    local waypoint = my_create_textured_box_1k(text_x,text_y,xsize,ysize,xcenter,ycenter,1/4)
        waypoint.name = create_guid_string()
        waypoint.parent_element = wp_origin.name
        if (num ~= nil) then
            waypoint.controllers = {{"TID_wp_bright",num},{"TID_wp_sym",num}}
        end
        waypoint.material = "TID_MAT2"
        waypoint.isdraw = true
        waypoint.isvisible = true
    AddElement(waypoint)
    if (num == nil) then
        return
    end
    if (show_alt) then
        local wp_alt_str           = CreateElement "ceStringPoly"
            wp_alt_str.name            = create_guid_string()
            wp_alt_str.material        = "font_TID"
            wp_alt_str.parent_element = wp_origin.name
            wp_alt_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
            wp_alt_str.init_pos = {-0.03,0}
            wp_alt_str.alignment     = "RightCenter"
            wp_alt_str.controllers = {{"TID_wp_alt",num},{"TID_wp_bright",num}}
            wp_alt_str.isdraw = true
        AddElement(wp_alt_str)
    end
    local waypoint_dot = my_create_textured_box_1k(0,0,200,200,xcenter,ycenter,1/4)
        waypoint_dot.name = create_guid_string()
        waypoint_dot.parent_element = wp_origin.name
        waypoint_dot.material = "TID_MAT2"
        waypoint_dot.isdraw = true
        waypoint_dot.isvisible = true
        local b_show_dot = show_dot and 1 or 0
        waypoint_dot.controllers = {{"TID_wp_bright",num},{"TID_wp_dot",num,b_show_dot}}
    AddElement(waypoint_dot)
    if (name == "DP") then
        -- special case
        local diagonal_line = my_create_textured_box_1k(800,200,200,200,xcenter,ycenter,1/4)
            diagonal_line.name = create_guid_string()
            diagonal_line.parent_element = wp_origin.name
            diagonal_line.init_rot = {90,0,0}
            diagonal_line.controllers = {{"TID_wp_bright",num},{"TID_wp_sym",num}}
            diagonal_line.material = "TID_MAT2"
            diagonal_line.isdraw = true
            diagonal_line.isvisible = true
            --diagonal_line.controllers = {{"TID_diagonal_line",num}}
        AddElement(diagonal_line)
    end
    if (name == "DLHB" or name == "DLST") then
        -- special case
        local diagonal_line = my_create_textured_box_1k(800,200,200,200,xcenter,ycenter,1/4)
            diagonal_line.name = create_guid_string()
            diagonal_line.parent_element = wp_origin.name
            diagonal_line.controllers = {{"TID_wp_bright",num},{"TID_wp_sym",num}}
            diagonal_line.material = "TID_MAT2"
            diagonal_line.isdraw = true
            diagonal_line.isvisible = true
            --diagonal_line.controllers = {{"TID_diagonal_line",num}}
        AddElement(diagonal_line)
    end
    if (name == "DLFP") then
        -- special case
        local vertical_line = my_create_textured_box_1k(800,600,200,200,xcenter,ycenter,1/4)
            vertical_line.name = create_guid_string()
            vertical_line.parent_element = wp_origin.name
            vertical_line.controllers = {{"TID_wp_bright",num},{"TID_wp_sym",num}}
            vertical_line.material = "TID_MAT2"
            vertical_line.isdraw = true
            vertical_line.isvisible = true
            --vertical_line.controllers = {{"TID_vertical_line",num}}
        AddElement(vertical_line)
    end
    if (name:sub(1, #"WP") == "WP") then
        local wp_num_str           = CreateElement "ceStringPoly"
            wp_num_str.name            = create_guid_string()
            wp_num_str.material        = "font_TID"
            wp_num_str.parent_element = wp_origin.name
            wp_num_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
            wp_num_str.init_pos = {-0.03,0}
            wp_num_str.alignment     = "RightCenter"
            wp_num_str.controllers = {{"TID_wp_bright",num},{"TID_wp_sym",num}}
            wp_num_str.value = name:sub(3, -1)
            wp_num_str.isdraw = true
        AddElement(wp_num_str)
    end
    if (name:sub(1, #"DLWP") == "DLWP") then
        local wp_num_str           = CreateElement "ceStringPoly"
            wp_num_str.name            = create_guid_string()
            wp_num_str.material        = "font_TID"
            wp_num_str.parent_element = wp_origin.name
            wp_num_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
            wp_num_str.init_pos = {-0.03,0}
            wp_num_str.alignment     = "RightCenter"
            wp_num_str.controllers = {{"TID_wp_bright",num},{"TID_wp_sym",num}}
            wp_num_str.value = name:sub(5, -1)
            wp_num_str.isdraw = true
        AddElement(wp_num_str)
    end
    local waypointvec = create_textured_line_2k(22, 10, 880, 12)
        waypointvec.name 	= create_guid_string()
        waypointvec.material = "TID_MAT"
        waypointvec.parent_element = wp_origin.name
        waypointvec.controllers = {{"TID_wp_vec",num}, {"TID_wp_bright",num}}
        waypointvec.isvisible = true
    AddElement(waypointvec)
end

create_waypoint("WP1",0,400,200,200,nil,nil,false,true,1) -- WP1
create_waypoint("WP2",0,400,200,200,nil,nil,false,true,2) -- WP2
create_waypoint("WP3",0,400,200,200,nil,nil,false,true,3) -- WP3
create_waypoint("FP",0,600,200,200,nil,nil,true,false,4) -- FP (fixed point)
create_waypoint("IP",800,0,200,200,nil,nil,true,false,5) -- IP (initial/indication point)
create_waypoint("ST",600,200,200,200,nil,nil,true,false,6) -- ST (surface target)
create_waypoint("HB",200,200,200,200,nil,nil,true,true,7) -- HB (home base)
create_waypoint("DP",200,400,200,200,nil,nil,true,true,8) -- DP (defended point)
create_waypoint("HA",600,0,200,200,nil,nil,true,true,9) -- HA (hostile area)
create_waypoint("DLHB",200,200,200,200,nil,nil,false,true,10) -- TDS datalink HB (home base)
create_waypoint("DLWP1",200,600,200,200,nil,nil,false,true,11) -- TDS datalink WP1
create_waypoint("DLWP2",200,600,200,200,nil,nil,false,true,12) -- TDS datalink WP2
create_waypoint("DLWP3",200,600,200,200,nil,nil,false,true,13) -- TDS datalink WP3
create_waypoint("DLST",600,200,200,200,nil,nil,true,false,14) -- TDS datalink ST (surface target)
create_waypoint("DLFP",0,600,200,200,nil,nil,true,false,15) -- TDS datalink FP (fixed point)
create_waypoint("TWS",0,600,200,200,nil,nil,false,false,nil) -- TWS auto steering centroid

-- left radar azimuth
local left_radar_az = my_create_textured_box_2k(2012,23,8,2007,2015.5,2025)
    left_radar_az.name = create_guid_string()
    left_radar_az.material = "TID_MAT"
    left_radar_az.parent_element = aircraft_origin.name
    left_radar_az.isdraw = true
    left_radar_az.isvisible = true
    left_radar_az.controllers = {{"TID_left_az"}}
    left_radar_az.state_tex_coords = {
        --get_tex_coord(2012,23,8,2007,2048,2048), -- 25nm
        get_tex_coord(1991,23,8,2007,2048,2048), -- 50nm
        get_tex_coord(1971,23,8,2007,2048,2048), -- 100nm
        get_tex_coord(1953,23,8,2007,2048,2048), -- 200nm
        get_tex_coord(1934,23,8,2007,2048,2048), -- 400nm
    }
AddElement(left_radar_az)

-- right radar azimuth
local right_radar_az = my_create_textured_box_2k(2012,23,8,2007,2015.5,2025)
    right_radar_az.name = create_guid_string()
    right_radar_az.material = "TID_MAT"
    right_radar_az.parent_element = aircraft_origin.name
    right_radar_az.isdraw = true
    right_radar_az.isvisible = true
    right_radar_az.controllers = {{"TID_right_az"}}
    right_radar_az.state_tex_coords = {
        --get_tex_coord(2012,23,8,2007,2048,2048), -- 25nm
        get_tex_coord(1991,23,8,2007,2048,2048), -- 50nm
        get_tex_coord(1971,23,8,2007,2048,2048), -- 100nm
        get_tex_coord(1953,23,8,2007,2048,2048), -- 200nm
        get_tex_coord(1934,23,8,2007,2048,2048), -- 400nm
    }
AddElement(right_radar_az)

-- artifical horizon
local artif_horiz = my_create_textured_box_2k(19,5,2003,10)
    artif_horiz.name = create_guid_string()
    artif_horiz.material = "TID_MAT"
    artif_horiz.parent_element = tactical_symbols.name
    artif_horiz.isdraw = true
    artif_horiz.isvisible = true
    artif_horiz.controllers = {{"TID_horizon"}}
AddElement(artif_horiz)

local steering_cue = my_create_textured_box_1k(600,600,200,200,nil,nil,1/4)
    steering_cue.name = create_guid_string()
    steering_cue.material = "TID_MAT2"
    steering_cue.isdraw = true
    steering_cue.isvisible = true
    steering_cue.parent_element = tactical_symbols.name
    steering_cue.controllers = {{"TID_steering_cue"}}
AddElement(steering_cue)

--local testcircle  = create_textured_circle_2k(22, 10, 880, 12)
--[[local ASE = CreateElement "ceCircleHB"
    ASE.width = 0.003 --3mm
    ASE.name 	= create_guid_string()
    --ASE.material = "TID_MAT" -- for textured circle
    ASE.material = "TID_COLOR" -- for untextured circle
    ASE.controllers = {{"TID_ase"}}
    ASE.isvisible = true
    ASE.isdraw = true
AddElement(ASE)--]]

local ASE_circle = add_stroke_circle(create_guid_string(), 0.2, nil, tactical_symbols.name, {{"TID_ase"}}, nil, nil, nil, nil, "TID_ASE_COLOR")

-- radar sweep
local radar_sweep = my_create_textured_box_2k(2033,23,8,2007,2036.5,2025)
    radar_sweep.name = create_guid_string()
    radar_sweep.material = "TID_MAT"
    radar_sweep.parent_element = aircraft_origin.name
    radar_sweep.isdraw = true
    radar_sweep.isvisible = true
    radar_sweep.controllers = {{"TID_sweep"}}
AddElement(radar_sweep)

-- TCS track symbol
local tcs_track = create_textured_line_2k(22, 10, 880, 12)
    tcs_track.name = create_guid_string()
    tcs_track.material = "TID_MAT"
    tcs_track.parent_element = aircraft_origin.name
    tcs_track.isdraw = true
    tcs_track.isvisible = true
    tcs_track.controllers = {{"TID_tcstrack"}}
AddElement(tcs_track)
local tcs_track_circle = my_create_textured_box_1k(200,400,200,200,nil,nil,1/4)
    tcs_track_circle.name = create_guid_string()
    tcs_track_circle.material = "TID_MAT2"
    tcs_track_circle.isdraw = true
    tcs_track_circle.isvisible = true
    tcs_track_circle.init_pos = {0.333,0}  -- 1.5"
    tcs_track_circle.parent_element = tcs_track.name
AddElement(tcs_track_circle)

function make_target(targetnum)
    local target_origin = create_origin("TID_tgt_"..tostring(targetnum))
    target_origin.controllers = {{"TID_target",targetnum}}
    target_origin.parent_element = tactical_symbols.name
    local target= my_create_textured_box_1k(400,200,200,200,500,300,1/4)
        target.name 	= create_guid_string()
        target.material = "TID_MAT2"
        target.parent_element = target_origin.name
        target.init_rot = {180,0,0}
        target.controllers = {{"TID_targettype",targetnum,0}, {"TID_targetbright",targetnum}}
        target.state_tex_coords = {
            --get_tex_coord(400,200,200,200,1024,1024), -- unknown target symbol
            get_tex_coord(600,400,200,200,1024,1024), -- enemy target symbol
            get_tex_coord(400,400,200,200,1024,1024), -- friendly target symbol
        }
        target.isvisible = true
    AddElement(target)
    local datalinktarget= my_create_textured_box_1k(400,200,200,200,500,300,1/4)
        datalinktarget.name 	= create_guid_string()
        datalinktarget.material = "TID_MAT2"
        datalinktarget.parent_element = target_origin.name
        datalinktarget.init_rot = {0,0,0}
        datalinktarget.controllers = {{"TID_targettype",targetnum,1}, {"TID_targetbright",targetnum}}
        datalinktarget.state_tex_coords = {
            --get_tex_coord(400,200,200,200,1024,1024), -- unknown datalinktarget symbol
            get_tex_coord(600,400,200,200,1024,1024), -- enemy datalinktarget symbol
            get_tex_coord(400,400,200,200,1024,1024), -- friendly datalinktarget symbol
        }
        datalinktarget.isvisible = true
    AddElement(datalinktarget)
    local target_dot = my_create_textured_box_1k(0,0,200,200,nil,nil,1/4)
        target_dot.name = create_guid_string()
        target_dot.parent_element = target_origin.name
        target_dot.controllers = {{"TID_targetbright",targetnum}}
        target_dot.material = "TID_MAT2"
        target_dot.isdraw = true
        target_dot.isvisible = true
    AddElement(target_dot)
    local adr_track = my_create_textured_box_1k(400,600,200,200,nil,nil,1/4)
        adr_track.name = create_guid_string()
        adr_track.parent_element = target_origin.name
        adr_track.controllers = {{"TID_adrtrack",targetnum},{"TID_targetbright",targetnum}}
        adr_track.material = "TID_MAT2"
        adr_track.init_rot = {180,0,0}
        adr_track.isdraw = false
        adr_track.isvisible = true
    AddElement(adr_track)
    local target_multi = my_create_textured_box_1k(0,200,200,200,150,325,1/4)
        target_multi.name = create_guid_string()
        target_multi.parent_element = target_origin.name
        target_multi.controllers = {{"TID_tgt_multi",targetnum},{"TID_targetbright",targetnum}}
        target_multi.material = "TID_MAT2"
        target_multi.isdraw = false
        target_multi.isvisible = true
    AddElement(target_multi)
    local target_dont_attk = my_create_textured_box_1k(800,600,200,200,nil,nil,1/4)
        target_dont_attk.name = create_guid_string()
        target_dont_attk.parent_element = target_origin.name
        target_dont_attk.controllers = {{"TID_tgt_do_not_attk",targetnum},{"TID_targetbright",targetnum}}
        target_dont_attk.material = "TID_MAT2"
        target_dont_attk.isdraw = false
        target_dont_attk.isvisible = true
    AddElement(target_dont_attk)
    local target_mand_attk = my_create_textured_box_1k(0,800,200,200,nil,nil,1/4)
        target_mand_attk.name = create_guid_string()
        target_mand_attk.parent_element = target_origin.name
        target_mand_attk.controllers = {{"TID_tgt_mand_attk",targetnum},{"TID_targetbright",targetnum}}
        target_mand_attk.material = "TID_MAT2"
        target_mand_attk.isdraw = false
        target_mand_attk.isvisible = true
    AddElement(target_mand_attk)
    local targetvec = create_textured_line_2k(22, 10, 880, 12)
        targetvec.name 	= create_guid_string()
        targetvec.material = "TID_MAT"
        targetvec.parent_element = target_origin.name
        targetvec.controllers = {{"TID_targetvec",targetnum}, {"TID_targetbright",targetnum}}
        targetvec.isvisible = true
    AddElement(targetvec)
    local launchzone= create_textured_line_2k(22, 34, 880, 24)
        launchzone.name 	= create_guid_string()
        launchzone.material = "TID_MAT"
        launchzone.parent_element = target_origin.name
        launchzone.controllers = {{"TID_LZ",targetnum}, {"TID_targetbright",targetnum}}
        launchzone.isvisible = true
    AddElement(launchzone)
    local Rmax= my_create_textured_box_2k(145,841,17,17)
        Rmax.name 	= create_guid_string()
        Rmax.material = "TID_MAT"
        Rmax.parent_element = target_origin.name
        Rmax.controllers = {{"TID_Rmax",targetnum}, {"TID_targetbright",targetnum}}
        Rmax.isvisible = true
    AddElement(Rmax)
    local lostX= my_create_textured_box_2k(266,901,47,54)
        lostX.name 	= create_guid_string()
        lostX.material = "TID_MAT"
        lostX.parent_element = target_origin.name
        lostX.controllers = {{"TID_lostX",targetnum}, {"TID_targetbright",targetnum}}
        lostX.isvisible = true
    AddElement(lostX)
    local tgt_alt_str           = CreateElement "ceStringPoly"
        tgt_alt_str.name            = create_guid_string()
        tgt_alt_str.material        = "font_TID"
        tgt_alt_str.parent_element = target_origin.name
        tgt_alt_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
        tgt_alt_str.init_pos = {-0.03,0}
        tgt_alt_str.alignment     = "RightCenter"
        tgt_alt_str.controllers 		= {{"TID_tgt_alt",targetnum}, {"TID_targetbright",targetnum}}
        tgt_alt_str.isdraw = false
    AddElement(tgt_alt_str)
    local tgt_prio_str           = CreateElement "ceStringPoly"
        tgt_prio_str.name            = create_guid_string()
        tgt_prio_str.material        = "font_TID"
        tgt_prio_str.parent_element = target_origin.name
        tgt_prio_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
        tgt_prio_str.init_pos = {0.03,0}
        tgt_prio_str.alignment     = "LeftCenter"
        tgt_prio_str.controllers 		= {{"TID_tgt_prio",targetnum}, {"TID_targetbright",targetnum}}
        tgt_prio_str.isdraw = false
    AddElement(tgt_prio_str)

----    local targetvec= create_textured_box(8161,31,8161+5,31+460,8192,512,nil,nil,31)
--    local targetvec= create_textured_box(8138,1,8191,1+460,8192,512,nil,nil,1)
--        targetvec.element_params={28/8192,5/8192,(8163-28)/143} -- middle X texcoord of shortest line, width, distance to next
--        targetvec.name 	= create_guid_string()
--        targetvec.material = TID_LINE_FLIP
--        targetvec.parent_element = target_origin.name
--        targetvec.controllers = {{"TID_targetvec",targetnum}, {"TID_targetbright",targetnum}}
--        targetvec.isvisible = true
--    AddElement(targetvec)
end

for targetnum = 1,32 do
    make_target(targetnum)
end

-- cursor
local tid_cursor = my_create_textured_box_1k(200,400,200,200,nil,nil,1/4)
    tid_cursor.name = create_guid_string()
    tid_cursor.material = "TID_MAT2"
    tid_cursor.isdraw = true
    tid_cursor.isvisible = true
    tid_cursor.controllers = {{"TID_cursor"}}
    tid_cursor.parent_element = tactical_symbols.name
AddElement(tid_cursor)

local radar_elev_str           = CreateElement "ceStringPoly"
    radar_elev_str.name            = create_guid_string()
    radar_elev_str.material        = "font_TID"
    radar_elev_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    radar_elev_str.init_pos = {-0.75,0.04}
    --radar_elev_str.init_rot         = {0, 0, 0}
    radar_elev_str.alignment     = "CenterCenter"
    radar_elev_str.parent_element = tactical_symbols.name
    --radar_elev_str.formats		= {"%02.1f"}
    radar_elev_str.controllers 		= {{"TID_radar_el"}}
    --radar_elev_str.value         = "028.0"
    radar_elev_str.isdraw = false
AddElement(radar_elev_str)

local radar_upper_str           = CreateElement "ceStringPoly"
    radar_upper_str.name            = create_guid_string()
    radar_upper_str.parent_element = tactical_symbols.name
    radar_upper_str.material        = "font_TID"
    radar_upper_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    radar_upper_str.init_pos = {-0.75,0.16}
    radar_upper_str.alignment     = "CenterCenter"
    radar_upper_str.controllers 		= {{"TID_radar_ext",0}}
    radar_upper_str.isdraw = false
AddElement(radar_upper_str)

local radar_lower_str           = CreateElement "ceStringPoly"
    radar_lower_str.name            = create_guid_string()
    radar_lower_str.parent_element = tactical_symbols.name
    radar_lower_str.material        = "font_TID"
    radar_lower_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    radar_lower_str.init_pos = {-0.75,-0.08}
    radar_lower_str.alignment     = "CenterCenter"
    radar_lower_str.controllers 		= {{"TID_radar_ext",1}}
    radar_lower_str.isdraw = false
AddElement(radar_lower_str)

local nav_status_str           = CreateElement "ceStringPoly"
    nav_status_str.name            = create_guid_string()
    nav_status_str.parent_element = tactical_symbols.name
    nav_status_str.material        = "font_TID"
    nav_status_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    nav_status_str.init_pos = {0.5,-0.36}
    nav_status_str.alignment     = "CenterCenter"
    nav_status_str.controllers 		= {{"TID_nav_status"}}
    nav_status_str.isdraw = false
AddElement(nav_status_str)

local ownspeed_str           = CreateElement "ceStringPoly"
    ownspeed_str.name            = create_guid_string()
    ownspeed_str.parent_element = tactical_symbols.name
    ownspeed_str.material        = "font_TID"
    ownspeed_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    ownspeed_str.init_pos = {-0.6,-0.28}
    ownspeed_str.alignment     = "CenterCenter"
    ownspeed_str.controllers 		= {{"TID_ownspeed"}}
    ownspeed_str.isdraw = false
AddElement(ownspeed_str)

local wpn_status_str           = CreateElement "ceStringPoly"
    wpn_status_str.name            = create_guid_string()
    wpn_status_str.parent_element = tactical_symbols.name
    wpn_status_str.material        = "font_TID"
    wpn_status_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    wpn_status_str.init_pos = {0.40,-0.70}
    wpn_status_str.alignment     = "CenterCenter"
    wpn_status_str.controllers 		= {{"TID_wpn_status"}}
    wpn_status_str.isdraw = false
AddElement(wpn_status_str)

local closure_str           = CreateElement "ceStringPoly"
    closure_str.name            = create_guid_string()
    closure_str.parent_element = tactical_symbols.name
    closure_str.material        = "font_TID"
    closure_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    closure_str.init_pos = {0.75,0.04}
    closure_str.alignment     = "CenterCenter"
    closure_str.controllers 		= {{"TID_closure"}}
    closure_str.isdraw = false
AddElement(closure_str)

local run_indicator           = CreateElement "ceStringPoly"
    run_indicator.name            = create_guid_string()
    run_indicator.parent_element = tactical_symbols.name
    run_indicator.material        = "font_TID"
    run_indicator.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    run_indicator.init_pos = {0.75,-0.08}
    run_indicator.alignment     = "CenterCenter"
    run_indicator.controllers 		= {{"TID_run_indicator"}}
    run_indicator.isdraw = false
AddElement(run_indicator)

local readout_symbols = create_root("readout_symbols")

local buffer_register           = CreateElement "ceStringPoly"
    buffer_register.name            = create_guid_string()
    buffer_register.parent_element = readout_symbols.name
    buffer_register.material        = "font_TID"
    buffer_register.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    buffer_register.init_pos = {0,0.8}
    buffer_register.alignment     = "CenterCenter"
    --buffer_register.value     = "BUFFER"
    buffer_register.controllers 		= {{"TID_buffer_register"}}
    buffer_register.isdraw = false
AddElement(buffer_register)
local left_readout           = CreateElement "ceStringPoly"
    left_readout.name            = create_guid_string()
    left_readout.parent_element = readout_symbols.name
    left_readout.material        = "font_TID"
    left_readout.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    left_readout.init_pos = {-0.5,0.74}
    left_readout.alignment     = "LeftCenter"
    --left_readout.value     = "LEFT"
    left_readout.controllers 		= {{"TID_readout",0}}
    left_readout.isdraw = false
AddElement(left_readout)
local right_readout           = CreateElement "ceStringPoly"
    right_readout.name            = create_guid_string()
    right_readout.parent_element = readout_symbols.name
    right_readout.material        = "font_TID"
    right_readout.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    right_readout.init_pos = {0.5,0.74}
    right_readout.alignment     = "RightCenter"
    --right_readout.value     = "RIGHT"
    right_readout.controllers 		= {{"TID_readout",1}}
    right_readout.isdraw = false
AddElement(right_readout)
local left_readout_extra           = CreateElement "ceStringPoly"
    left_readout_extra.name            = create_guid_string()
    left_readout_extra.parent_element = readout_symbols.name
    left_readout_extra.material        = "font_TID"
    left_readout_extra.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    left_readout_extra.init_pos = {-0.5,0.66}
    left_readout_extra.alignment     = "LeftCenter"
    --left_readout_extra.value     = "L EXTRA"
    left_readout_extra.controllers 		= {{"TID_readout",2}}
    left_readout_extra.isdraw = false
AddElement(left_readout_extra)
local right_readout_extra           = CreateElement "ceStringPoly"
    right_readout_extra.name            = create_guid_string()
    right_readout_extra.parent_element = readout_symbols.name
    right_readout_extra.material        = "font_TID"
    right_readout_extra.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    right_readout_extra.init_pos = {0.5,0.66}
    right_readout_extra.alignment     = "RightCenter"
    --right_readout_extra.value     = "R EXTRA"
    right_readout_extra.controllers 		= {{"TID_readout",3}}
    right_readout_extra.isdraw = false
AddElement(right_readout_extra)
local flycatcher           = CreateElement "ceStringPoly"
    flycatcher.name            = create_guid_string()
    flycatcher.parent_element = readout_symbols.name
    flycatcher.material        = "font_TID"
    flycatcher.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    flycatcher.init_pos = {0,0.58}
    flycatcher.alignment     = "CenterCenter"
    --flycatcher.value     = "FLYCATCHER"
    flycatcher.controllers 		= {{"TID_flycatcher"}}
    flycatcher.isdraw = false
AddElement(flycatcher)

local align_symbols = create_root("align_symbols")
local align_time           = CreateElement "ceStringPoly"
    align_time.name            = create_guid_string()
    align_time.parent_element = align_symbols.name
    align_time.material        = "font_TID"
    align_time.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    align_time.init_pos = {-0.72,0.56}
    align_time.alignment     = "CenterCenter"
    align_time.controllers 		= {{"TID_aligntime"}}
    align_time.isdraw = false
AddElement(align_time)

local align_status           = CreateElement "ceStringPoly"
    align_status.name            = create_guid_string()
    align_status.parent_element = align_symbols.name
    align_status.material        = "font_TID"
    align_status.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    align_status.init_pos = {0,0.56}
    align_status.alignment     = "CenterCenter"
    align_status.controllers 		= {{"TID_alignstatus"}}
    align_status.isdraw = false
AddElement(align_status)

local align_ash           = CreateElement "ceStringPoly"
    align_ash.name            = create_guid_string()
    align_ash.parent_element = align_symbols.name
    align_ash.material        = "font_TID"
    align_ash.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    align_ash.init_pos = {0.36,0.56}
    align_ash.alignment     = "CenterCenter"
    align_ash.controllers 		= {{"TID_alignASH"}}
    align_ash.isdraw = false
AddElement(align_ash)

local coarse_align_marker = my_create_textured_box_1k(75,294,51,12,nil,nil,1/4)
    coarse_align_marker.name = create_guid_string()
    coarse_align_marker.material = "TID_MAT2"
    coarse_align_marker.parent_element = align_symbols.name
    coarse_align_marker.isdraw = true
    coarse_align_marker.isvisible = true
    coarse_align_marker.init_pos = {-0.3,0.56}
    coarse_align_marker.init_rot = {90,0,0}
AddElement(coarse_align_marker)
local alert_align_marker = my_create_textured_box_1k(75,294,51,12,nil,nil,1/4)
    alert_align_marker.name = create_guid_string()
    alert_align_marker.material = "TID_MAT2"
    alert_align_marker.parent_element = align_symbols.name
    alert_align_marker.isdraw = true
    alert_align_marker.isvisible = true
    alert_align_marker.init_pos = {0.17,0.56}
    alert_align_marker.init_rot = {90,0,0}
AddElement(alert_align_marker)
local fine_align_marker = my_create_textured_box_1k(75,294,51,12,nil,nil,1/4)
    fine_align_marker.name = create_guid_string()
    fine_align_marker.material = "TID_MAT2"
    fine_align_marker.parent_element = align_symbols.name
    fine_align_marker.isdraw = true
    fine_align_marker.isvisible = true
    fine_align_marker.init_pos = {0.57,0.56}
    fine_align_marker.init_rot = {90,0,0}
AddElement(fine_align_marker)
local align_caret = my_create_textured_box_1k(837,466,120,68,898,474,1/4)
    align_caret.name = create_guid_string()
    align_caret.material = "TID_MAT2"
    align_caret.parent_element = align_symbols.name
    align_caret.isdraw = true
    align_caret.isvisible = true
    align_caret.init_pos = {-0.57,0.6}
    align_caret.controllers = {{"TID_aligncaret", 0.57-(-0.57)}} -- range from -0.57 to 0.57
AddElement(align_caret)
local align_caret_top = my_create_textured_box_1k(837,466,120,68,898,474,1/4) -- complete the diamond with upside down caret
    align_caret_top.name = create_guid_string()
    align_caret_top.material = "TID_MAT2"
    align_caret_top.parent_element = align_caret.name
    align_caret_top.isdraw = true
    align_caret_top.isvisible = true
    align_caret_top.init_pos = {0,0} -- relative to caret
    align_caret_top.init_rot = {180,0,0}
    align_caret_top.controllers = {{"TID_aligndiamond"}}
AddElement(align_caret_top)
local align_dot = my_create_textured_box_1k(0,0,200,200,nil,nil,1/4)
    align_dot.name = create_guid_string()
    align_dot.material = "TID_MAT2"
    align_dot.parent_element = align_caret.name
    align_dot.isdraw = true
    align_dot.isvisible = true
    align_dot.init_pos = {0,0} -- relative to caret
    align_dot.controllers = {{"TID_aligndot"}}
AddElement(align_dot)

local mtm_symbols = create_root("mtm_symbols")
local mtm_status           = CreateElement "ceStringPoly"
    mtm_status.name            = create_guid_string()
    mtm_status.parent_element = mtm_symbols.name
    mtm_status.material        = "font_TID"
    mtm_status.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    mtm_status.init_pos = {-0.5,-0.5}   -- "lower left quadrant"
    mtm_status.alignment     = "CenterCenter"
    mtm_status.controllers 		= {{"TID_mtmstatus"}}
    mtm_status.isdraw = true
AddElement(mtm_status)


local spinwarn_symbols = create_root("spinwarn_symbols")
local yaw_diamond = create_origin()
local rates_half_size = 0.7
yaw_diamond.controllers = {{"TID_yawdiamond",2*rates_half_size}}
yaw_diamond.parent_element = spinwarn_symbols.name
yaw_diamond.init_pos = {-rates_half_size,-0.22}
    local yawdiamondbot = my_create_textured_box_1k(837,466,120,68,898,474,1/4)
        yawdiamondbot.name = create_guid_string()
        yawdiamondbot.material = "TID_MAT2"
        yawdiamondbot.parent_element = yaw_diamond.name
        yawdiamondbot.isdraw = true
        yawdiamondbot.isvisible = true
    AddElement(yawdiamondbot)
    local yawdiamondtop = my_create_textured_box_1k(837,466,120,68,898,474,1/4) -- complete the diamond with upside down caret
        yawdiamondtop.name = create_guid_string()
        yawdiamondtop.material = "TID_MAT2"
        yawdiamondtop.parent_element = yawdiamondbot.name
        yawdiamondtop.isdraw = true
        yawdiamondtop.isvisible = true
        yawdiamondtop.init_pos = {0,0} -- relative to bottom caret
        yawdiamondtop.init_rot = {180,0,0}
    AddElement(yawdiamondtop)
local rates={"30", "50", "70", "90", "110", "+"}
for num, rate in ipairs(rates) do
    local yawrate           = CreateElement "ceStringPoly"
    yawrate.name            = create_guid_string()
    yawrate.parent_element = spinwarn_symbols.name
    yawrate.material        = "font_TID"
    yawrate.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    yawrate.init_pos = {-rates_half_size+(num-1)*(2*rates_half_size/5),-0.3}
    yawrate.alignment     = "CenterCenter"
    yawrate.controllers = {{"TID_yawratenums"}}
    yawrate.isdraw = true
    yawrate.value = rate
    AddElement(yawrate)
end

local spinarrow = create_textured_box(20,75,20+1540,75+120,2048,2048,nil,1020,nil)
spinarrow.name = create_guid_string()
spinarrow.material = "TID_MAT"
spinarrow.parent_element = spinwarn_symbols.name
spinarrow.isdraw = true
spinarrow.isvisible = true
spinarrow.init_pos = {0,0.4}
spinarrow.controllers = {{"TID_spinarrow"}}
AddElement(spinarrow)

-- nav grid
--local grid_heading = 0 -- aka threat axis
--local coverage_angle = 62
local navgrid_origin_toplevel = create_origin()
navgrid_origin_toplevel.parent_element = tactical_symbols.name
navgrid_origin_toplevel.isdraw = false
navgrid_origin_toplevel.isvisible = true
--navgrid_origin_toplevel.init_pos = {-math.sin(math.rad(grid_heading)), -math.cos(math.rad(grid_heading))}
navgrid_origin_toplevel.controllers = {{"TID_navgrid_pos"}}
local navgrid_origin = create_origin() -- to allow rotation around navgrid_origin_toplevel, otherwise rotates around tactical_symbols point
navgrid_origin.controllers = {{"TID_navgrid_origin"}}
navgrid_origin.parent_element = navgrid_origin_toplevel.name
--navgrid_origin.init_rot = {-grid_heading,0,0}
-- (name, length, pos, rot, parent, controllers, dashed, stroke, gap, material)
local ranges = {25, 50, 100, 200, 400}
for tidrange = 1,5 do -- 25,50,100,200,400NM
    local current_range = ranges[tidrange]
    local strobe_origin = create_origin("navgrid_range_"..tostring(tidrange))
    strobe_origin.parent_element = navgrid_origin.name
    strobe_origin.controllers = {{"TID_navgrid_range", tidrange}}
    for num = 1,7 do
        --local navgrid_strobe = my_create_textured_box_2k(2033,23,8,2007,2036.5,2025,1.024)   -- hack scale factor because strobe texture line doesn't cover full texture extents
        --local navgrid_strobe = my_create_textured_box_2k(1934,23,8,2007,1937.5,2025)
        local navgrid_strobe = add_stroke_line(create_guid_string(), 2.0*4, nil, nil, strobe_origin.name, {{"TID_navgrid_strobe", num}}, 0.9, 0.6, "TID_NAVGRID_COLOR")
            --navgrid_strobe.name = create_guid_string()
            --navgrid_strobe.parent_element = strobe_origin.name
            --navgrid_strobe.material = "TID_MAT"
            --navgrid_strobe.controllers = {{"TID_navgrid_strobe", num}}
            --navgrid_strobe.init_rot = {(-(coverage_angle/2)+(num-1)*(coverage_angle/6)), 0, 0}
            --navgrid_strobe.isdraw = true
            --navgrid_strobe.isvisible = true
        --AddElement(navgrid_strobe)
            for sides = 1,2 do -- ticks on both sides of each line
                local ticks_origin = create_origin()
                ticks_origin.controllers = {{"TID_ticks", num, sides}}
                ticks_origin.parent_element = navgrid_strobe.name
                for tick50 = 1,4 do -- 50,150,250,350
                    if ( (50+(tick50-1)*100) <= current_range) then
                        local horizontal_line = my_create_textured_box_1k(44,897,115/4,8,45,900.5,1/3)
                            horizontal_line.name = create_guid_string()
                            horizontal_line.material = "TID_MAT2"
                            horizontal_line.parent_element = ticks_origin.name
                            horizontal_line.isdraw = true
                            horizontal_line.isvisible = true
                            horizontal_line.init_pos = {0, 2.0*((50+(tick50-1)*100)/current_range)}
                        if sides==1 then
                            horizontal_line.init_rot = {180,0,0}
                        end
                        AddElement(horizontal_line)
                    end
                end
                for tick100 = 1,3 do -- 100,200,300
                    if ( (tick100*100) <= current_range) then
                        local horizontal_line = my_create_textured_box_1k(44,897,115/2,8,45,900.5,1/3)
                            horizontal_line.name = create_guid_string()
                            horizontal_line.material = "TID_MAT2"
                            horizontal_line.parent_element = ticks_origin.name
                            horizontal_line.isdraw = true
                            horizontal_line.isvisible = true
                            horizontal_line.init_pos = {0, 2.0*(tick100*100/current_range)}
                        if sides==1 then
                            horizontal_line.init_rot = {180,0,0}
                        end
                        AddElement(horizontal_line)
                    end
                end
            end
    end
end

-- AVIA: AOA, VV, ILS, ACLS
local avia_symbols = create_root("avia_symbols")

local avia_center_plus = my_create_textured_box_2k(773,907,56,56)
    avia_center_plus.name = create_guid_string()
    avia_center_plus.parent_element = avia_symbols.name
    avia_center_plus.material = "TID_MAT"
    avia_center_plus.isdraw = false
    avia_center_plus.isvisible = true
    avia_center_plus.controllers = {{"TID_avia_landing"}}
AddElement(avia_center_plus)

local avia_vert_needle = my_create_textured_box_2k(749,736,10,399)
    avia_vert_needle.name = create_guid_string()
    avia_vert_needle.parent_element = avia_center_plus.name
    avia_vert_needle.material = "TID_MAT"
    --avia_vert_needle.init_pos = {-0.19,0}
    avia_vert_needle.isdraw = false
    avia_vert_needle.isvisible = true
    avia_vert_needle.controllers = {{"TID_avia_vertneedle", 0.19}}
AddElement(avia_vert_needle)

local avia_horiz_needle = my_create_textured_box_2k(749,736,10,399)
    avia_horiz_needle.name = create_guid_string()
    avia_horiz_needle.parent_element = avia_center_plus.name
    avia_horiz_needle.material = "TID_MAT"
    avia_horiz_needle.init_rot = {90,0,0}
    --avia_horiz_needle.init_pos = {0,0.19}
    avia_horiz_needle.isdraw = false
    avia_horiz_needle.isvisible = true
    avia_horiz_needle.controllers = {{"TID_avia_horizneedle", 0.19}}
AddElement(avia_horiz_needle)

local acl_value           = CreateElement "ceStringPoly"
    acl_value.name            = create_guid_string()
    acl_value.material        = "font_TID"
    acl_value.parent_element = avia_center_plus.name
    acl_value.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    acl_value.init_pos = {0.0,-0.65}
    acl_value.alignment     = "CenterCenter"
    acl_value.controllers = {{"TID_acl_value"}}
    acl_value.value = "ACL"
    acl_value.isdraw = true
AddElement(acl_value)

local ils_value           = CreateElement "ceStringPoly"
    ils_value.name            = create_guid_string()
    ils_value.material        = "font_TID"
    ils_value.parent_element = avia_center_plus.name
    ils_value.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    ils_value.init_pos = {0.0,-0.71}
    ils_value.alignment     = "CenterCenter"
    ils_value.controllers = {{"TID_ils_value"}}
    ils_value.value = "ILS"
    ils_value.isdraw = true
AddElement(ils_value)

local ils_error           = CreateElement "ceStringPoly"
    ils_error.name            = create_guid_string()
    ils_error.material        = "font_TID"
    ils_error.parent_element = avia_center_plus.name
    ils_error.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    ils_error.init_pos = {0.0,0.4}
    ils_error.alignment     = "CenterCenter"
    ils_error.controllers = {{"TID_ils_error"}}
    ils_error.isdraw = true
AddElement(ils_error)

local tacan_value           = CreateElement "ceStringPoly"
    tacan_value.name            = create_guid_string()
    tacan_value.material        = "font_TID"
    tacan_value.parent_element = avia_symbols.name
    tacan_value.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    tacan_value.init_pos = {-0.8,0.03}
    tacan_value.alignment     = "LeftCenter"
    --tacan_value.value = "OFF"
    tacan_value.controllers = {{"TID_tacan_range"}}
    tacan_value.isdraw = true
AddElement(tacan_value)

local radalt_value           = CreateElement "ceStringPoly"
    radalt_value.name            = create_guid_string()
    radalt_value.material        = "font_TID"
    radalt_value.parent_element = avia_symbols.name
    radalt_value.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    radalt_value.init_pos = {0.60,0.03}
    radalt_value.alignment     = "LeftCenter"
    --radalt_value.value = "OFF"
    radalt_value.controllers = {{"TID_radalt"}}
    radalt_value.isdraw = true
AddElement(radalt_value)

local vv_label           = CreateElement "ceStringPoly"
    vv_label.name            = create_guid_string()
    vv_label.material        = "font_TID"
    vv_label.parent_element = avia_symbols.name
    vv_label.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    vv_label.init_pos = {-0.32,0.5}
    vv_label.alignment     = "LeftCenter"
    vv_label.controllers = {{"TID_vv_label"}}
    vv_label.isdraw = true
AddElement(vv_label)
local vv_first_v = my_create_textured_box_1k(837,466,120,68,898,474,1/4)
    vv_first_v.name = create_guid_string()
    vv_first_v.material = "TID_MAT2"
    vv_first_v.parent_element = avia_symbols.name
    vv_first_v.isdraw = true
    vv_first_v.isvisible = true
    vv_first_v.init_pos = {-0.45,0.505}
AddElement(vv_first_v)
local vv_second_v = my_create_textured_box_1k(837,466,120,68,898,474,1/4)
    vv_second_v.name = create_guid_string()
    vv_second_v.material = "TID_MAT2"
    vv_second_v.parent_element = avia_symbols.name
    vv_second_v.isdraw = true
    vv_second_v.isvisible = true
    vv_second_v.init_pos = {-0.39,0.505}
AddElement(vv_second_v)
local vv_x = my_create_textured_box_2k(260,896,59,64,nil,nil,0.8)
    vv_x.name = create_guid_string()
    vv_x.material = "TID_MAT"
    vv_x.parent_element = avia_symbols.name
    vv_x.isdraw = true
    vv_x.isvisible = true
    vv_x.init_pos = {-0.33,0.495}
AddElement(vv_x)

local aoa_label           = CreateElement "ceStringPoly"
    aoa_label.name            = create_guid_string()
    aoa_label.material        = "font_TID"
    aoa_label.parent_element = avia_symbols.name
    aoa_label.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    aoa_label.init_pos = {0.26,0.5}
    aoa_label.alignment     = "LeftCenter"
    aoa_label.value = "AOA"
    aoa_label.isdraw = true
AddElement(aoa_label)

local scale_top = 0.42
local scale_bottom = -0.6
local vv_caret = my_create_textured_box_1k(837,466,120,68,898,474,1/4)
    vv_caret.name = create_guid_string()
    vv_caret.material = "TID_MAT2"
    vv_caret.parent_element = avia_symbols.name
    vv_caret.isdraw = true
    vv_caret.isvisible = true
    vv_caret.init_pos = {-0.27,-0.6}
    vv_caret.init_rot = {270,0,0}
    vv_caret.controllers = {{"TID_vv_caret", scale_top-(scale_bottom)}}
AddElement(vv_caret)

local vv_caret_dot = my_create_textured_box_1k(82,82,38,35,nil,nil,1/4)
    vv_caret_dot.name = create_guid_string()
    vv_caret_dot.material = "TID_MAT2"
    vv_caret_dot.parent_element = vv_caret.name
    vv_caret_dot.isdraw = true
    vv_caret_dot.isvisible = true
    vv_caret_dot.controllers = {{"TID_vv_caret_dot"}}
AddElement(vv_caret_dot)

local aoa_caret = my_create_textured_box_1k(837,466,120,68,898,474,1/4)
    aoa_caret.name = create_guid_string()
    aoa_caret.material = "TID_MAT2"
    aoa_caret.parent_element = avia_symbols.name
    aoa_caret.isdraw = true
    aoa_caret.isvisible = true
    aoa_caret.init_pos = {0.27,-0.6}
    aoa_caret.init_rot = {90,0,0}
    aoa_caret.controllers = {{"TID_aoa_caret", scale_top-(scale_bottom)}}
AddElement(aoa_caret)

local aoa_caret_dot = my_create_textured_box_1k(82,82,38,35,nil,nil,1/4)
    aoa_caret_dot.name = create_guid_string()
    aoa_caret_dot.material = "TID_MAT2"
    aoa_caret_dot.parent_element = aoa_caret.name
    aoa_caret_dot.isdraw = true
    aoa_caret_dot.isvisible = true
    aoa_caret_dot.controllers = {{"TID_aoa_caret_dot"}}
AddElement(aoa_caret_dot)

local avia_landing_scale = create_root("TID_avia_landing")
avia_landing_scale.parent_element = avia_symbols.name

for vvdot = -15,5 do
    local vvdot_element = my_create_textured_box_1k(82,82,38,35,nil,nil,1/6)
        vvdot_element.name = create_guid_string()
        vvdot_element.material = "TID_MAT2"
        vvdot_element.parent_element = avia_landing_scale.name
        vvdot_element.isdraw = true
        vvdot_element.isvisible = true
        vvdot_element.init_pos = {-0.33, scale_bottom+((vvdot-(-15))/20)*(scale_top-(scale_bottom))}
    AddElement(vvdot_element)
    if ((vvdot%5) == 0) then
        local vvdot_label           = CreateElement "ceStringPoly"
            vvdot_label.name            = create_guid_string()
            vvdot_label.material        = "font_TID"
            vvdot_label.parent_element = avia_landing_scale.name
            vvdot_label.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
            vvdot_label.init_pos = {-0.36,scale_bottom+((vvdot-(-15))/20)*(scale_top-(scale_bottom))}
            vvdot_label.alignment     = "RightCenter"
            vvdot_label.value = tostring(vvdot)
            vvdot_label.isdraw = true
        AddElement(vvdot_label)
    end
end

for aoadot = 10,20,0.5 do
    if (aoadot ~= 15) then  -- skip dot on AoA reference line
        local aoadot_element = my_create_textured_box_1k(82,82,38,35,nil,nil,1/6)
            aoadot_element.name = create_guid_string()
            aoadot_element.material = "TID_MAT2"
            aoadot_element.parent_element = avia_landing_scale.name
            aoadot_element.isdraw = true
            aoadot_element.isvisible = true
            aoadot_element.init_pos = {0.33, scale_bottom+((aoadot-(10))/10)*(scale_top-(scale_bottom))}
        AddElement(aoadot_element)
    end
    if ((aoadot%2) == 0) then
        local aoadot_label           = CreateElement "ceStringPoly"
            aoadot_label.name            = create_guid_string()
            aoadot_label.material        = "font_TID"
            aoadot_label.parent_element = avia_landing_scale.name
            aoadot_label.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
            aoadot_label.init_pos = {0.36,scale_bottom+((aoadot-(10))/10)*(scale_top-(scale_bottom))}
            aoadot_label.alignment     = "LeftCenter"
            aoadot_label.value = tostring(aoadot)
            aoadot_label.isdraw = true
        AddElement(aoadot_label)
    end
end
-- 15 AoA reference
local horizontal_line = my_create_textured_box_1k(0,800,200,200,nil,nil,1/4)
    horizontal_line.name = create_guid_string()
    horizontal_line.material = "TID_MAT2"
    horizontal_line.parent_element = avia_landing_scale.name
    horizontal_line.init_pos = {0.33,scale_bottom+((15-(10))/10)*(scale_top-(scale_bottom))}
    horizontal_line.isdraw = true
    horizontal_line.isvisible = true
AddElement(horizontal_line)

local avia_nonlanding_scale = create_root("TID_avia_nonlanding")
avia_nonlanding_scale.parent_element = avia_symbols.name

for vvdot = -5,5 do
    local vvdot_element = my_create_textured_box_1k(82,82,38,35,nil,nil,1/6)
        vvdot_element.name = create_guid_string()
        vvdot_element.material = "TID_MAT2"
        vvdot_element.parent_element = avia_nonlanding_scale.name
        vvdot_element.isdraw = true
        vvdot_element.isvisible = true
        vvdot_element.init_pos = {-0.33, scale_bottom+((vvdot-(-5))/10)*(scale_top-(scale_bottom))}
    AddElement(vvdot_element)
    local vvdot_label           = CreateElement "ceStringPoly"
        vvdot_label.name            = create_guid_string()
        vvdot_label.material        = "font_TID"
        vvdot_label.parent_element = avia_nonlanding_scale.name
        vvdot_label.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
        vvdot_label.init_pos = {-0.36,scale_bottom+((vvdot-(-5))/10)*(scale_top-(scale_bottom))}
        vvdot_label.alignment     = "RightCenter"
        vvdot_label.value = tostring(vvdot)
        vvdot_label.isdraw = true
    AddElement(vvdot_label)
end

for aoadot = 0,20,2 do
    local aoadot_element = my_create_textured_box_1k(82,82,38,35,nil,nil,1/6)
        aoadot_element.name = create_guid_string()
        aoadot_element.material = "TID_MAT2"
        aoadot_element.parent_element = avia_nonlanding_scale.name
        aoadot_element.isdraw = true
        aoadot_element.isvisible = true
        aoadot_element.init_pos = {0.33, scale_bottom+((aoadot-(0))/20)*(scale_top-(scale_bottom))}
    AddElement(aoadot_element)
    local aoadot_label           = CreateElement "ceStringPoly"
        aoadot_label.name            = create_guid_string()
        aoadot_label.material        = "font_TID"
        aoadot_label.parent_element = avia_nonlanding_scale.name
        aoadot_label.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
        aoadot_label.init_pos = {0.36,scale_bottom+((aoadot-(0))/20)*(scale_top-(scale_bottom))}
        aoadot_label.alignment     = "LeftCenter"
        local val = tostring(aoadot)
        if (aoadot < 10) then
            val = "0"..val
        end
        aoadot_label.value = val
        aoadot_label.isdraw = true
    AddElement(aoadot_label)
end
-- 15 AoA reference
local horizontal_line = my_create_textured_box_1k(0,800,200,200,nil,nil,1/4)
    horizontal_line.name = create_guid_string()
    horizontal_line.material = "TID_MAT2"
    horizontal_line.parent_element = avia_nonlanding_scale.name
    horizontal_line.init_pos = {0.33,scale_bottom+((15-(0))/20)*(scale_top-(scale_bottom))}
    horizontal_line.isdraw = true
    horizontal_line.isvisible = true
AddElement(horizontal_line)

-- jamming strobes
local jam_strobe_origin = create_origin()
jam_strobe_origin.controllers = {{"TID_jam_strobes"}}
jam_strobe_origin.parent_element = tactical_symbols.name
for jam_num = 1,32 do
    local jam_strobe = add_stroke_line(create_guid_string(), 2.0*4, nil, nil, jam_strobe_origin.name, {{"TID_jam_strobe", jam_num}}, 0.9, 0.6, "TID_NAVGRID_COLOR")
    local angle_track = my_create_textured_box_1k(600,400,200,200,nil,nil,1/4)
    angle_track.name = "TID_jamangle_"..tostring(jam_num)
    angle_track.material = "TID_MAT2"
    angle_track.isdraw = false
    angle_track.isvisible = true
    angle_track.init_rot = {-90,0,0}
    --angle_track.init_pos = {0,0.222}  -- 1.0"
    angle_track.controllers = {{"TID_jam_angletrack",jam_num}}
    angle_track.parent_element = tactical_symbols.name
    AddElement(angle_track)
    local target_dot = my_create_textured_box_1k(0,0,200,200,nil,nil,1/4)
        target_dot.name = create_guid_string()
        target_dot.parent_element = angle_track.name
        --target_dot.controllers = {{"TID_jam_angletrack",jam_num}}
        target_dot.material = "TID_MAT2"
        target_dot.isdraw = true
        target_dot.isvisible = true
    AddElement(target_dot)
end

--[[
local testhwline  = create_textured_line_2k(22, 10, 880, 12)
    testhwline.name 	= create_guid_string()
    testhwline.material = "TID_MAT"
    testhwline.controllers = {{"TID_testhwline"}}
    testhwline.isvisible = true
    testhwline.isdraw = false
AddElement(testhwline)
--]]

--make_ruler_grid()