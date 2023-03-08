

local counter_squad = 0
local counter_group = 0
local counter_unit = 0
local counter_point = 0

local function new_group_name()
    counter_group = counter_group + 1
    counter_unit = 0
    if counter_squad == 0 then
        return string.format("Descent group %d",counter_group)
    else
        return string.format("Descent_%d group %d",counter_squad, counter_group)
    end
end

local function new_unit_name()
    counter_unit = counter_unit + 1
    if counter_squad == 0 then
        return string.format("Descent unit_t %d_%d",counter_group, counter_unit)
    else
        return string.format("Descent_%d unit_t %d_%d",counter_squad, counter_group, counter_unit)
    end
end

local function new_point_name()
    counter_point = counter_point + 1
    return string.format("DictKey_WptName_%d",counter_point)
end

local function CASTask()
    return 
    {

        ["id"] = "ComboTask",
        ["params"] = 
        {
            ["tasks"] = 
            {
                [1] = 
                {
                    ["number"] = 1,
                    ["key"] = "CAS",
                    ["id"] = "EngageTargets",
                    ["enabled"] = true,
                    ["auto"] = true,
                    ["params"] = 
                    {
                        ["targetTypes"] = 
                        {
                            [1] = "Helicopters",
                            [2] = "Ground Units",
                            [3] = "Light armed ships",
                        }, -- end of ["targetTypes"]
                        ["priority"] = 0,
                    }, -- end of ["params"]
                }, -- end of [1]
            }, -- end of ["tasks"]
        }, -- end of ["params"]

    }
end

local function CombatTask()
    return {
            ["id"] = "ComboTask",
            ["params"] = 
            {
                ["tasks"] = 
                {
                    [1] = 
                    {
                        ["number"] = 1,
                        ["auto"] = false,
                        ["id"] = "AttackGroup",
                        ["enabled"] = true,
                        ["params"] = 
                        {
                            ["direction"] = 0,
                            ["attackQtyLimit"] = false,
                            ["attackQty"] = 1,
                            ["expend"] = "Auto",
                            ["altitude"] = 1000,
                            ["directionEnabled"] = false,
                            ["groupAttack"] = false,
                            ["weaponType"] = 0,
                            ["altitudeEnabled"] = false,
                        }, -- end of ["params"]
                    }, -- end of [1]
                }, -- end of ["tasks"]
            }, -- end of ["params"]
    }
end

local function PointTask(x_,y_,z_,type,speed, action, task)--speed [km/h]

    local pos = {x = x_, y = y_, z = z_}
    local terra_height = Disposition.getPointHeight(pos)

    local speed_mc = speed/3.6

    if action == nil then
        action = "Turning Point"
    end

    if type == nil then
        type = "Turning Point"
    end

    if task == nil then
        task = 
        {
            ["id"] = "ComboTask",
            ["params"] = 
            {
                ["tasks"] = 
                {
                }, -- end of ["tasks"]
            }, -- end of ["params"]
        }
    end

    return 
    {
        ["type"] = type,
        ["name"] = new_point_name(),
        ["x"] = pos.x,
        ["y"] = pos.z,
        ["alt"] = pos.y + terra_height,
        ["alt_type"] = "BARO",
        ["speed"] = speed_mc,
        ["action"] = action,
        ["task"] = task,
        ["ETA"] = 0,
        ["ETA_locked"] = false,
        ["speed_locked"] = true,
        ["formation_template"] = "",
    }
    
end

local function pointShiftAngleDeg(start_pos, length, course)--prop [-180..180]
    return
    {
        x = start_pos.x + math.cos(math.rad(course)) * length,
        y = start_pos.y,
        z = start_pos.z + math.sin(math.rad(course)) * length
    }
end

local function pointShiftAngleRad(start_pos, length, course)--prop [-pi..pi]
    return
    {
        x = start_pos.x + math.cos(course) * length,
        y = start_pos.y,
        z = start_pos.z + math.sin(course) * length
    }
end

local function pointShiftProp(start_pos, end_pos, prop)--prop [0..1]
    return 
    {
        x = start_pos.x + prop*(end_pos.x - start_pos.x), 
        y = start_pos.y + prop*(end_pos.y - start_pos.y),
        z = start_pos.z + prop*(end_pos.z - start_pos.z) 
    }
end

local function pointShiftAbs(start_pos, end_pos, shift)--shift [m]
    local vector = {
        x = end_pos.x - start_pos.x, 
        y = end_pos.y - start_pos.y,
        z = end_pos.z - start_pos.z 
       }

    local dist = math.sqrt(vector.x*vector.x + vector.y*vector.y + vector.z*vector.z);

    vector.x = start_pos.x + shift * vector.x / dist
    vector.y = start_pos.y + shift * vector.y / dist
    vector.z = start_pos.z + shift * vector.z / dist
    return vector
end

local function pointCourseRad(start_pos, end_pos)--return [radians]
    local vector_xz = {
        x = end_pos.x - start_pos.x, 
        z = end_pos.z - start_pos.z 
       }

    local course = 0
    if vector_xz.x < 0.01 or vector_xz.x < -0.01 then
        if  vector_xz.z > 0 then
            course = - 0.5 * math.pi
        else
            course =   0.5 * math.pi
        end
    else
        course = math.atan2(-vector_xz.z, vector_xz.x)
    end

    return course
end

local function pointCourseDeg(start_pos, end_pos)--return [degris]
    
    local course = pointCourseRad(start_pos, end_pos)
    return math.deg(course)
end

local function rotateCourseRad(course, angle)--course[radians] angle[radians] return [radians]
    local new_course = math.fmod(course,math.pi) + angle
    if new_course > math.pi then
        new_course = 2 * math.pi - new_course
    elseif new_course < -math.pi then
        new_course = 2 * math.pi + new_course
    end

    return new_course
end

local function addTriggerDeactivateInZone(diactivate_obj, zone_obj)

    if diactivate_obj == nil or zone_obj == nil then
        return nil
    end

    return
    {
        ["actions"] = string.format("a_deactivate_group(%d);", diactivate_obj),
        ["func"] = "if mission.trig.conditions[*]() then if not mission.trig.flag[*] then mission.trig.actions[*](); mission.trig.flag[*] = true;end; else mission.trig.flag[*] = false; end;",
        ["flag"] = true,
        ["conditions"] = string.format("return(c_part_of_group_in_zone(%d, %d) )", diactivate_obj, zone_obj),
    }
end

local function addTriggerZone(name, x, y, radius, color, link_obj)

    if radius == nil then
        radius = 100
    end

    local color_ = {}

    if color == nil then
        color_ = {
            [1] = 1,
            [2] = 0,
            [3] = 0,
            [4] = 1,
        }
    else
        color_ = {
            [1] = color[1],
            [2] = color[2],
            [3] = color[3],
            [4] = color[4],
        }
    end

    if link_obj == nil then
        link_obj = 0
    end

    return {
        ["y"] = y,
        ["x"] = x,
        ["radius"] = radius,
        ["color"] = color_,
        ["properties"] = 
        {
            [1] = 
            {
                ["key"] = name,
                ["value"] = "",
            }, -- end of [1]
        }, -- end of ["properties"]
        ["hidden"] = false,
        ["name"] = name,
        ["linked_object_name"] = link_obj,
    }
end

local function addPlaneRoutePoints(airbase_name_start, airbase_name_target)
    
    local airbase =  Airbase.getByName(airbase_name_target)
    local airbase_target_pos = Object.getPosition(airbase).p

    local airbase_start_pos = {}
    if airbase_name_start == nil or airbase_name_start == "" then
        airbase_start_pos = pointShiftAngleDeg(airbase_target_pos, 50000, 0)
    else
        local airbase_start =  Airbase.getByName(airbase_name_start)
        airbase_start_pos = Object.getPosition(airbase_start).p
    end

    --local airbase_start_id = airbase_start:getWorldID()

    local course_to_target = pointCourseRad(airbase_start_pos,airbase_target_pos)
    
    local point_start = pointShiftAbs(airbase_target_pos, airbase_start_pos, 20000)

    local point_end = pointShiftAbs(airbase_target_pos, airbase_start_pos, -10000)

    local PN = 0
    local function point_num(b_current)
        if PN == 0 or b_current == nil or b_current == false then
            PN = PN + 1
        end
        return PN
    end


    local points =
    {
        [point_num()] = PointTask(point_start.x,1000,point_start.z,nil,800,nil,CASTask()),
        [point_num()] = PointTask(airbase_target_pos.x,1000,airbase_target_pos.z,nil,800,nil,CombatTask()),
        [point_num()] = PointTask(point_end.x,1000,point_end.z,nil,800),
    }
    
    points[1]["psi"] = course_to_target

    return points, point_num(true)
end

local function planeGroupFirst(points, unit_skill)
    counter_squad = counter_squad + 1
    return
    {
        ["modulation"] = 0,
        ["tasks"] = 
        {
        }, -- end of ["tasks"]
        ["radioSet"] = false,
        ["task"] = "CAS",
        ["uncontrolled"] = false,
        ["route"] = 
        {
            ["points"] = points,
        }, -- end of ["route"]
        ["hidden"] = false,
        ["units"] = 
        {
            [1] = 
            {
                ["alt"] = points[1].alt,
                ["alt_type"] = "BARO",
                ["livery_id"] = "usaf standard",
                ["skill"] = unit_skill,
                --["parking"] = 6,
                ["speed"] = points[1].speed,
                ["type"] = "A-10C",
                ["psi"] = points[1].psi,
                --["parking_id"] = "05",
                ["x"] = points[1].x,
                ["name"] = new_unit_name(),
                ["payload"] = 
                {
                    ["pylons"] = 
                    {
                        [1] = 
                        {
                            ["CLSID"] = "ALQ_184",
                        }, -- end of [1]
                        [2] = 
                        {
                            ["CLSID"] = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}",
                        }, -- end of [2]
                        [3] = 
                        {
                            ["CLSID"] = "LAU_88_AGM_65H_2_L",
                        }, -- end of [3]
                        [4] = 
                        {
                            ["CLSID"] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",
                        }, -- end of [4]
                        [5] = 
                        {
                            ["CLSID"] = "{GBU-38}",
                        }, -- end of [5]
                        [7] = 
                        {
                            ["CLSID"] = "{GBU-38}",
                        }, -- end of [7]
                        [8] = 
                        {
                            ["CLSID"] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",
                        }, -- end of [8]
                        [9] = 
                        {
                            ["CLSID"] = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}",
                        }, -- end of [9]
                        [10] = 
                        {
                            ["CLSID"] = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}",
                        }, -- end of [10]
                        [11] = 
                        {
                            ["CLSID"] = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}",
                        }, -- end of [11]
                    }, -- end of ["pylons"]
                    ["fuel"] = 5029,
                    ["flare"] = 120,
                    ["ammo_type"] = 1,
                    ["chaff"] = 240,
                    ["gun"] = 100,
                }, -- end of ["payload"]
                ["y"] = points[1].y,
                ["heading"] = points[1].psi,
                ["callsign"] = 
                {
                    [1] = 1,
                    [2] = 1,
                    [3] = 1,
                    ["name"] = "Enfield11",
                }, -- end of ["callsign"]
                ["onboard_num"] = "010",
            }, -- end of [1]
            [2] = 
            {
                ["alt"] = points[1].alt,
                ["alt_type"] = "BARO",
                ["livery_id"] = "usaf standard",
                ["skill"] = unit_skill,
                --["parking"] = 6,
                ["speed"] = points[1].speed,
                ["type"] = "A-10C",
                ["psi"] = points[1].psi,
                --["parking_id"] = "05",
                ["x"] = points[1].x+50,
                ["name"] = new_unit_name(),
                ["payload"] = 
                {
                    ["pylons"] = 
                    {
                        [1] = 
                        {
                            ["CLSID"] = "ALQ_184",
                        }, -- end of [1]
                        [2] = 
                        {
                            ["CLSID"] = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}",
                        }, -- end of [2]
                        [3] = 
                        {
                            ["CLSID"] = "LAU_88_AGM_65H_2_L",
                        }, -- end of [3]
                        [4] = 
                        {
                            ["CLSID"] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",
                        }, -- end of [4]
                        [5] = 
                        {
                            ["CLSID"] = "{GBU-38}",
                        }, -- end of [5]
                        [7] = 
                        {
                            ["CLSID"] = "{GBU-38}",
                        }, -- end of [7]
                        [8] = 
                        {
                            ["CLSID"] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",
                        }, -- end of [8]
                        [9] = 
                        {
                            ["CLSID"] = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}",
                        }, -- end of [9]
                        [10] = 
                        {
                            ["CLSID"] = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}",
                        }, -- end of [10]
                        [11] = 
                        {
                            ["CLSID"] = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}",
                        }, -- end of [11]
                    }, -- end of ["pylons"]
                    ["fuel"] = 5029,
                    ["flare"] = 120,
                    ["ammo_type"] = 1,
                    ["chaff"] = 240,
                    ["gun"] = 100,
                }, -- end of ["payload"]
                ["y"] = points[1].y,
                ["heading"] = points[1].psi,
                ["callsign"] = 
                {
                    [1] = 1,
                    [2] = 1,
                    [3] = 1,
                    ["name"] = "Enfield11",
                }, -- end of ["callsign"]
                ["onboard_num"] = "010",
            }, -- end of [2]
            [3] = 
            {
                ["alt"] = points[1].alt,
                ["alt_type"] = "BARO",
                ["livery_id"] = "usaf standard",
                ["skill"] = unit_skill,
                --["parking"] = 6,
                ["speed"] = points[1].speed,
                ["type"] = "A-10C",
                ["psi"] = points[1].psi,
                --["parking_id"] = "05",
                ["x"] = points[1].x+100,
                ["name"] = new_unit_name(),
                ["payload"] = 
                {
                    ["pylons"] = 
                    {
                        [1] = 
                        {
                            ["CLSID"] = "ALQ_184",
                        }, -- end of [1]
                        [2] = 
                        {
                            ["CLSID"] = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}",
                        }, -- end of [2]
                        [3] = 
                        {
                            ["CLSID"] = "LAU_88_AGM_65H_2_L",
                        }, -- end of [3]
                        [4] = 
                        {
                            ["CLSID"] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",
                        }, -- end of [4]
                        [5] = 
                        {
                            ["CLSID"] = "{GBU-38}",
                        }, -- end of [5]
                        [7] = 
                        {
                            ["CLSID"] = "{GBU-38}",
                        }, -- end of [7]
                        [8] = 
                        {
                            ["CLSID"] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",
                        }, -- end of [8]
                        [9] = 
                        {
                            ["CLSID"] = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}",
                        }, -- end of [9]
                        [10] = 
                        {
                            ["CLSID"] = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}",
                        }, -- end of [10]
                        [11] = 
                        {
                            ["CLSID"] = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}",
                        }, -- end of [11]
                    }, -- end of ["pylons"]
                    ["fuel"] = 5029,
                    ["flare"] = 120,
                    ["ammo_type"] = 1,
                    ["chaff"] = 240,
                    ["gun"] = 100,
                }, -- end of ["payload"]
                ["y"] = points[1].y,
                ["heading"] = points[1].psi,
                ["callsign"] = 
                {
                    [1] = 1,
                    [2] = 1,
                    [3] = 1,
                    ["name"] = "Enfield11",
                }, -- end of ["callsign"]
                ["onboard_num"] = "010",
            }, -- end of [3]
            [4] = 
            {
                ["alt"] = points[1].alt,
                ["alt_type"] = "BARO",
                ["livery_id"] = "usaf standard",
                ["skill"] = unit_skill,
                --["parking"] = 6,
                ["speed"] = points[1].speed,
                ["type"] = "A-10C",
                ["psi"] = points[1].psi,
                --["parking_id"] = "05",
                ["x"] = points[1].x+150,
                ["name"] = new_unit_name(),
                ["payload"] = 
                {
                    ["pylons"] = 
                    {
                        [1] = 
                        {
                            ["CLSID"] = "ALQ_184",
                        }, -- end of [1]
                        [2] = 
                        {
                            ["CLSID"] = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}",
                        }, -- end of [2]
                        [3] = 
                        {
                            ["CLSID"] = "LAU_88_AGM_65H_2_L",
                        }, -- end of [3]
                        [4] = 
                        {
                            ["CLSID"] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",
                        }, -- end of [4]
                        [5] = 
                        {
                            ["CLSID"] = "{GBU-38}",
                        }, -- end of [5]
                        [7] = 
                        {
                            ["CLSID"] = "{GBU-38}",
                        }, -- end of [7]
                        [8] = 
                        {
                            ["CLSID"] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",
                        }, -- end of [8]
                        [9] = 
                        {
                            ["CLSID"] = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}",
                        }, -- end of [9]
                        [10] = 
                        {
                            ["CLSID"] = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}",
                        }, -- end of [10]
                        [11] = 
                        {
                            ["CLSID"] = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}",
                        }, -- end of [11]
                    }, -- end of ["pylons"]
                    ["fuel"] = 5029,
                    ["flare"] = 120,
                    ["ammo_type"] = 1,
                    ["chaff"] = 240,
                    ["gun"] = 100,
                }, -- end of ["payload"]
                ["y"] = points[1].y,
                ["heading"] = points[1].psi,
                ["callsign"] = 
                {
                    [1] = 1,
                    [2] = 1,
                    [3] = 1,
                    ["name"] = "Enfield11",
                }, -- end of ["callsign"]
                ["onboard_num"] = "010",
            }, -- end of [4]
        }, -- end of ["units"]
        ["y"] = points[1].y,
        ["x"] = points[1].x,
        ["name"] = new_group_name(),
        ["communication"] = true,
        ["start_time"] = 0,
        ["frequency"] = 251,
    }
end

local function planeClient(country,name,type, airbase_id, airbase_pos, pylons)

    local pylons_ = pylons or {}

    return {
        ["lateActivation"] = false,
        ["coalition"] = "red",
        ["country"] = country,
        ["category"] = "plane",
        ["groupCategory"] = 0,
        ["modulation"] = 0,
        ["tasks"] = 
        {
        }, -- end of ["tasks"]
        --["task"] = "CAS",
        ["uncontrolled"] = false,
        ["route"] = 
        {
            ["points"] = 
            {
                [1] = 
                {
                    ["alt"] = airbase_pos.y,
                    ["action"] = "From Parking Area Hot",
                    ["alt_type"] = "BARO",
                    ["properties"] = 
                    {
                        ["vnav"] = 1,
                        ["addopt"] = 
                        {
                        }, -- end of ["addopt"]
                        ["scale"] = 0,
                        ["vangle"] = 0,
                        ["angle"] = 0,
                        ["steer"] = 2,
                    }, -- end of ["properties"]
                    ["speed"] = 0,--138.88888888889,
                    ["task"] = 
                    {
                        ["enabled"] = false,
                    }, -- end of ["task"]
                    ["type"] = "TakeOffParkingHot",--"TakeOff",--
                    ["ETA"] = 0,
                    ["ETA_locked"] = true,
                    ["y"] = airbase_pos.z,
                    ["x"] = airbase_pos.x,
                    ["name"] = "DictKey_WptName_27",
                    ["formation_template"] = "",
                    ["airdromeId"] = airbase_id,
                    ["speed_locked"] = true,
                }, -- end of [1]
            }, -- end of ["points"]
        }, -- end of ["route"]
        ["hidden"] = false,
        ["units"] = 
        {
            [1] = 
            {
                ["alt"] = airbase_pos.y,
                ["alt_type"] = "BARO",
                ["skill"] = "Client",
                ["parking"] = 0,
                ["speed"] = 138.88888888889,
                ["type"] = type,--"A-10C_2",
                ["psi"] = 0,
                ["parking_id"] = "01",
                ["x"] = airbase_pos.x,
                ["name"] = name,
                ["payload"] = 
                {
                    ["pylons"] = pylons_,
                    ["fuel"] = 5029,
                    ["flare"] = 120,
                    ["ammo_type"] = 1,
                    ["chaff"] = 240,
                    ["gun"] = 100,
                }, -- end of ["payload"]
                ["y"] = airbase_pos.z,
                ["heading"] = 0,
                ["callsign"] = 
                {
                    [1] = 1,
                    [2] = 1,
                    [3] = 1,
                    ["name"] = "Enfield11",
                }, -- end of ["callsign"]
                ["onboard_num"] = "010",
            }, -- end of [1]
        }, -- end of ["units"]
        ["y"] = airbase_pos.z,
        ["x"] = airbase_pos.x,
        ["name"] = new_group_name(),
        ["communication"] = true,
        ["start_time"] = 0,
        ["frequency"] = 251,
  }
end


function AirAttackGroups(squad_name, group_country, airbase_name_start, airbase_name, unit_skill)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    if airbase_name == nil then
        return
    end

    local plane_points, count_points = addPlaneRoutePoints(airbase_name_start,airbase_name)
    local plane_1 = coalition.addGroup(group_country, Group.Category.AIRPLANE, planeGroupFirst(plane_points, unit_skill ))

    local zone_plane = addTriggerZone("AtackComplite", plane_points[count_points].x, plane_points[count_points].y, 500, {0,0,0,1})
    local trigger_zone_plane = trigger.misc.addZone(zone_plane)
    trigger.misc.addTrigger(addTriggerDeactivateInZone(plane_1:getID(), trigger_zone_plane.zoneId))

    counter_squad = 0
    return plane_1:getID(), trigger_zone_plane.zoneId
end

function AirClients(squad_name, group_country, airbase_name, type)
    if squad_name == nil then
        squad_name = new_group_name()
    end

    if airbase_name == nil then
        return
    end

    local airbase =  Airbase.getByName(airbase_name)
    local airbase_id =  airbase:getID()
    local airbase_pos = Object.getPosition(airbase).p

    
    local client = coalition.add_dyn_group2(planeClient(group_country,squad_name,type,airbase_id,airbase_pos))

    return client

end

--groups_mission_id = AirAttackGroups(100,country.id.RUSSIA, "Kutaisi", "Senaki-Kolkhi","Good")

--client_mission_id = AirClients(nil,country.id.RUSSIA, "Kutaisi", "A-10C_2")
--country.id.RUSSIA
--country.id.USA