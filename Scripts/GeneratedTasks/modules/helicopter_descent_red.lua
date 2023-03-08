local test = false

local counter_squad = 0
local counter_group = 0
local counter_unit = 0
local counter_point = 0

local function new_group_name()
    counter_group = counter_group + 1
    counter_unit = 0
    if counter_squad == 0 then
        return string.format("HeliDescent group %d",counter_group)
    else
        return string.format("HeliDescent_%d group %d",counter_squad, counter_group)
    end
end

local function new_unit_name()
    counter_unit = counter_unit + 1
    if counter_squad == 0 then
        return string.format("HeliDescent unit_t %d_%d",counter_group, counter_unit)
    else
        return string.format("HeliDescent_%d unit_t %d_%d",counter_squad, counter_group, counter_unit)
    end
end

local function new_point_name()
    counter_point = counter_point + 1
    return string.format("WP_%d",counter_point)
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
        z = start_pos.z - math.sin(math.rad(course)) * length
    }
end

local function pointShiftAngleRad(start_pos, length, course)--prop [-pi..pi]
    return
    {
        x = start_pos.x + math.cos(course) * length,
        y = start_pos.y,
        z = start_pos.z - math.sin(course) * length
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

local function pointDistanceXZ(start_pos, end_pos)
    local vector = {
        x = end_pos.x - start_pos.x, 
        z = end_pos.z - start_pos.z 
       }

    local dist = math.sqrt( vector.x*vector.x + vector.z*vector.z )
    return dist
end

local function pointCourseRad(start_pos, end_pos)--return [radians]
    local vector_xz = {
        x = end_pos.x - start_pos.x, 
        z = end_pos.z - start_pos.z 
       }

    local course = 0
    if vector_xz.x < 0.01 and vector_xz.x > -0.01 then
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
        new_course = new_course - 2 * math.pi
    elseif new_course < -math.pi then
        new_course = 2 * math.pi + new_course
    end

    return new_course
end

local function d_CourseRad(course1, course2)--course1[radians] course2[radians] return [radians]
    local d_course = course1 - course2
    local side = 0
    if d_course > math.pi then
        d_course = -(2 * math.pi - d_course)
        side = 1
    elseif d_course < -math.pi then
        d_course = (2 * math.pi + d_course)
        side = -1
    end

    return d_course, side
end

local function clampTo(value, min, max)
    local result = value;
    if value < min then
        result = min
    elseif value > max then
        result = max
    end

    return result
end

local function average_CourseRad(course1, course2)--course1[radians] course2[radians] return [radians]

    local d_course, side = d_CourseRad(course1, course2)
    local average_course = course1

    if d_course >= 0 then
        average_course = rotateCourseRad(course2, 0.5*d_course*side)
    else
        average_course = rotateCourseRad(course1, -0.5*d_course*side)
    end
    
    return average_course
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

local function addTriggerDeactivateAllInZone(diactivate_obj, zone_obj)

    if diactivate_obj == nil or zone_obj == nil then
        return nil
    end

    return
    {
        ["actions"] = string.format("a_deactivate_group(%d);", diactivate_obj),
        ["func"] = "if mission.trig.conditions[*]() then if not mission.trig.flag[*] then mission.trig.actions[*](); mission.trig.flag[*] = true;end; else mission.trig.flag[*] = false; end;",
        ["flag"] = true,
        ["conditions"] = string.format("return(c_all_of_group_in_zone(%d, %d) )", diactivate_obj, zone_obj),
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

local function addHelicopterRoutePoints(airbase_name_start, course, dist)
    
    
    local b_find_base = false
    local airbase_start_pos = {}
    if airbase_name_start ~= nil and airbase_name_start ~= "" then
        local airbase_start =  Airbase.getByName(airbase_name_start)
        if airbase_start ~= nil then
            airbase_start_pos = Object.getPosition(airbase_start).p
            b_find_base = true
        end
    end

    if b_find_base == false then
       return nil, nil 
    end

    local point_2 = pointShiftAngleRad(airbase_start_pos, dist, course)

    local point_3 = pointShiftAngleRad(point_2, 2000, course + 0.7 * math.pi)

    local point_end = pointShiftAngleRad(airbase_start_pos, -1000, course)

    local PN = 0
    local function point_num(b_current)
        if PN == 0 or b_current == nil or b_current == false then
            PN = PN + 1
        end
        return PN
    end

    local points = {}
    
    points[point_num()] = PointTask(airbase_start_pos.x, 400, airbase_start_pos.z, nil, 200)
    points[point_num()] = PointTask(point_2.x, 400, point_2.z, nil, 200)
    points[point_num()] = PointTask(point_3.x, 400, point_3.z, nil, 200)
    points[point_num()] = PointTask(point_end.x, 400, point_end.z, nil, 200)


    points[1]["psi"] = pointCourseRad(airbase_start_pos,point_2)--course_to_target-- 

    return points, point_num(true)
end


local function helicopterGroupFirst(points, unit_skill)
    counter_squad = counter_squad + 1
    return
    {
        ["modulation"] = 0,
        ["tasks"] = 
        {
        }, -- end of ["tasks"]
        ["radioSet"] = false,
        ["task"] = "Transport",
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
                ["livery_id"] = "Russia_VVS_Standard",
                ["skill"] = unit_skill,
                ["speed"] = points[1].speed,
                ["type"] = "Mi-8MT",
                ["psi"] = points[1].psi,
                ["x"] = points[1].x,
                ["y"] = points[1].y,
                ["heading"] = points[1].psi,
                ["name"] = new_unit_name(),
                ["payload"] = 
                {
                    ["pylons"] = 
                    {
                        [8] = 
                        {
                            ["CLSID"] = "PKT_7_62",
                        }, -- end of [8]
                        [7] = 
                        {
                            ["CLSID"] = "KORD_12_7",
                        }, -- end of [7]
                    }, -- end of ["pylons"]
                    ["fuel"] = "1929",
                    ["flare"] = 128,
                    ["chaff"] = 0,
                    ["gun"] = 100,
                }, -- end of ["payload"]
                ["AddPropAircraft"] = 
                {
                    ["ExhaustScreen"] = true,
                    ["CargoHalfdoor"] = true,
                    ["GunnersAISkill"] = 90,
                    ["AdditionalArmor"] = true,
                    ["NS430allow"] = true,
                }, -- end of ["AddPropAircraft"]
                ["callsign"] = 100,
                ["onboard_num"] = "010",
            }, -- end of [1]
            [2] = 
            {
                ["alt"] = points[1].alt + 50,
                ["alt_type"] = "BARO",
                ["livery_id"] = "Russia_VVS_Standard",
                ["skill"] = unit_skill,
                ["speed"] = points[1].speed,
                ["type"] = "Mi-8MT",
                ["psi"] = points[1].psi,
                ["x"] = points[1].x,
                ["y"] = points[1].y,
                ["heading"] = points[1].psi,
                ["name"] = new_unit_name(),
                ["payload"] = 
                {
                    ["pylons"] = 
                    {
                        [8] = 
                        {
                            ["CLSID"] = "PKT_7_62",
                        }, -- end of [8]
                        [7] = 
                        {
                            ["CLSID"] = "KORD_12_7",
                        }, -- end of [7]
                    }, -- end of ["pylons"]
                    ["fuel"] = "1929",
                    ["flare"] = 128,
                    ["chaff"] = 0,
                    ["gun"] = 100,
                }, -- end of ["payload"]
                ["AddPropAircraft"] = 
                {
                    ["ExhaustScreen"] = true,
                    ["CargoHalfdoor"] = true,
                    ["GunnersAISkill"] = 90,
                    ["AdditionalArmor"] = true,
                    ["NS430allow"] = true,
                }, -- end of ["AddPropAircraft"]
                ["callsign"] = 100,
                ["onboard_num"] = "012",
            }, -- end of [2]
            [3] = 
            {
                ["alt"] = points[1].alt - 50,
                ["alt_type"] = "BARO",
                ["livery_id"] = "Russia_VVS_Standard",
                ["skill"] = unit_skill,
                ["speed"] = points[1].speed,
                ["type"] = "Mi-8MT",
                ["psi"] = points[1].psi,
                ["x"] = points[1].x,
                ["y"] = points[1].y,
                ["heading"] = points[1].psi,
                ["name"] = new_unit_name(),
                ["payload"] = 
                {
                    ["pylons"] = 
                    {
                        [8] = 
                        {
                            ["CLSID"] = "PKT_7_62",
                        }, -- end of [8]
                        [7] = 
                        {
                            ["CLSID"] = "KORD_12_7",
                        }, -- end of [7]
                    }, -- end of ["pylons"]
                    ["fuel"] = "1929",
                    ["flare"] = 128,
                    ["chaff"] = 0,
                    ["gun"] = 100,
                }, -- end of ["payload"]
                ["AddPropAircraft"] = 
                {
                    ["ExhaustScreen"] = true,
                    ["CargoHalfdoor"] = true,
                    ["GunnersAISkill"] = 90,
                    ["AdditionalArmor"] = true,
                    ["NS430allow"] = true,
                }, -- end of ["AddPropAircraft"]
                ["callsign"] = 100,
                ["onboard_num"] = "014",
            }, -- end of [3]
            [4] = 
            {
                ["alt"] = points[1].alt - 100,
                ["alt_type"] = "BARO",
                ["livery_id"] = "Russia_VVS_Standard",
                ["skill"] = unit_skill,
                ["speed"] = points[1].speed,
                ["type"] = "Mi-8MT",
                ["psi"] = points[1].psi,
                ["x"] = points[1].x,
                ["y"] = points[1].y,
                ["heading"] = points[1].psi,
                ["name"] = new_unit_name(),
                ["payload"] = 
                {
                    ["pylons"] = 
                    {
                        [8] = 
                        {
                            ["CLSID"] = "PKT_7_62",
                        }, -- end of [8]
                        [7] = 
                        {
                            ["CLSID"] = "KORD_12_7",
                        }, -- end of [7]
                    }, -- end of ["pylons"]
                    ["fuel"] = "1929",
                    ["flare"] = 128,
                    ["chaff"] = 0,
                    ["gun"] = 100,
                }, -- end of ["payload"]
                ["AddPropAircraft"] = 
                {
                    ["ExhaustScreen"] = true,
                    ["CargoHalfdoor"] = true,
                    ["GunnersAISkill"] = 90,
                    ["AdditionalArmor"] = true,
                    ["NS430allow"] = true,
                }, -- end of ["AddPropAircraft"]
                ["callsign"] = 100,
                ["onboard_num"] = "016",
            }, -- end of [4]
        }, -- end of ["units"]
        ["y"] = points[1].y,
        ["x"] = points[1].x,
        ["name"] = new_group_name(),
        ["communication"] = true,
        ["start_time"] = 0,
        ["frequency"] = 127.5,
    }
end


function HelicopterDescentPrepare(squad_name, airbase_name_start, unit_skill, course, dist)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    if airbase_name_start == nil then
        return nil
    end

    local helic_points = {}
    local count_points = 0

    helic_points, count_points = addHelicopterRoutePoints(airbase_name_start, course, dist)

    local helic = helicopterGroupFirst(helic_points, unit_skill )

    local zone_helic = addTriggerZone("PlaneComplite", helic_points[count_points].x, helic_points[count_points].y, 500, {0,0,0,1})

    counter_squad = 0
    
    return {
        ["plane_groups"] = helic,
        ["plane_trigger"] = zone_helic
    }
end

local function CreateTrigger(group_id, zone_id)
    trigger.misc.addTrigger(addTriggerDeactivateInZone(group_id, zone_id))
end

local function CreateZone(zone_data)
    return trigger.misc.addZone(zone_data)
end

function CreateGroups(group_country,groups_to_create)
    
    local trigger_zone_helic = CreateZone(groups_to_create.plane_trigger)

    local helic = coalition.addGroup(group_country, Group.Category.HELICOPTER, groups_to_create.plane_groups)
    CreateTrigger(helic:getID(), trigger_zone_helic.zoneId)

    return {
        helic:getID(),
        trigger_zone_helic.zoneId
    }
end

function HelicopterDescent(squad_name, group_country, airbase_name_start, unit_skill, course, dist)

    local groups_data = HelicopterDescentPrepare(squad_name, airbase_name_start, unit_skill, course, dist)

    if groups_data == nil then
        return
    end

    return CreateGroups(group_country,groups_data)

end


--groups_mission_id = HelicopterDescent(200,country.id.USA, "Krymsk", math.rad(-135), 5000)
--groups_mission_id = HelicopterDescent(200,country.id.RUSSIA, "Kutaisi", math.rad(135), 5000)
--groups_mission_id = HelicopterDescent(200,country.id.USA, "Novorossiysk", math.rad(45), 5000)

--country.id.RUSSIA
--country.id.USA