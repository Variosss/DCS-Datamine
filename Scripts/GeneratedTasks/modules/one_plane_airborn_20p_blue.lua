local test = false

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


local function addGroundRoutePoints(airbase_name, runway_num, threshold_num)

    local airbase =  Airbase.getByName(airbase_name)
    local airbase_runway = airbase:getRunways()
    local airbase_tower = airbase:getTechObjectPos("towers")
    local runway = airbase_runway[runway_num]
    if runway == nil then
        runway = airbase_runway[0]
    end

    --if runway == nil then
    --    return nil

    local threshold_pos = runway.position
    if threshold_num == 0 then
        threshold_pos = pointShiftAngleRad(runway.position, runway.length*0.5, runway.course)
        threshold_pos = pointShiftAngleRad(threshold_pos, 500, runway.course)
    else
        threshold_pos = pointShiftAngleRad(runway.position, -runway.length*0.5, runway.course)
        threshold_pos = pointShiftAngleRad(threshold_pos, -500, runway.course)
    end

    local threshold_pos = pointShiftAbs(airbase_tower.pos, threshold_pos, 1500)

    --local is_water = Disposition.getPointWater(threshold_pos,500,20)

    local is_water = false
    
    is_water = Disposition.getRouteAwayWater(threshold_pos,airbase_tower.pos,50,20)

    local course_to_threshold = pointCourseRad(airbase_tower.pos, threshold_pos)
    local shift_rad = math.asin(1/3);--вращаем точку начала маршрута десанта вокруг башни по кругу с шагом 500м на радиусе 1500м пока не найдем место без воды

    for i = 2, 18 do 
        
        if true == is_water then break end
        local n = math.floor(0.5*i)
        local sign = i%2;
        local next_shift_rad
        if sign == 0 then
            next_shift_rad = -shift_rad * n
        else
            next_shift_rad = shift_rad * n
        end 

        local next_course_to_threshold = rotateCourseRad(course_to_threshold, next_shift_rad)
        threshold_pos = pointShiftAngleRad(airbase_tower.pos, 1500, next_course_to_threshold)
        is_water = Disposition.getRouteAwayWater(threshold_pos,airbase_tower.pos,50,20)
        --is_water = Disposition.getPointWater(threshold_pos,500,20)
    end

    local points =
    {
        [1] = PointTask(threshold_pos.x,threshold_pos.y,threshold_pos.z,nil,14,"Cone"),
        [2] = PointTask(airbase_tower.pos.x, airbase_tower.pos.y, airbase_tower.pos.z,nil,14,"Cone"),
    }

    return points
end

local function getTaskAirborn(pos, alt, groups, script)

    local terra_height = Disposition.getPointHeight(pos)

    return
    {
        ["id"] = "ComboTask",
        ["params"] = 
        {
            ["tasks"] = 
            {
                [1] = 
                {
                    ["enabled"] = true,
                    ["auto"] = false,
                    ["id"] = "ParatroopersDrop",
                    ["number"] = 1,
                    ["params"] = 
                    {
                        ["groupAttack"] = false,
                        ["attackQtyLimit"] = false,
                        ["attackQty"] = 1,
                        ["attackType"] = "Carpet",
                        ["altitude"] = alt + terra_height,
                        ["groupsOnBoard"] = groups,
                        ["carpetLength"] = 500,
                        ["altitudeEnabled"] = true,
                        ["y"] = pos.z,
                        ["x"] = pos.x,
                        ["scriptFileName"] = "",
                        ["altitudeEdited"] = true,
                    }, -- end of ["params"]
                }, -- end of [1]
            }, -- end of ["tasks"]
        }
    }
end

local function addPlaneRoutePoints_test(airbase_name_start, airbase_name_target, groups, first_descent_pos)
    
    local airbase =  Airbase.getByName(airbase_name_target)
    local airbase_runway = airbase:getRunways()

    --ближайший конец полосы
    local find_pos = { dist = 9999999 , pos = first_descent_pos}

    local course_to_base = airbase_runway[1].course

    local point_3 = pointShiftAngleRad(find_pos.pos, 14000, rotateCourseRad(course_to_base, math.rad(-60)))

    local point_task_4 = pointShiftAbs(find_pos.pos, point_3, 4000)

    local point_5 = pointShiftAngleRad(find_pos.pos, 10000, rotateCourseRad(course_to_base, math.rad(70)))

    local point_drop = pointShiftAbs(find_pos.pos, point_3, 1000)

    local PN = 0
    local function point_num(b_current)
        if PN == 0 or b_current == nil or b_current == false then
            PN = PN + 1
        end
        return PN
    end

    local points =  {
            [point_num()] = PointTask(point_3.x, 1000, point_3.z,nil,600),
            [point_num()] = PointTask(point_task_4.x, 500, point_task_4.z,nil,400, nil, getTaskAirborn(point_drop, 400, groups)),
            [point_num()] = PointTask(point_5.x, 500, point_5.z,nil,400),
    }
    
    points[1]["psi"] = pointCourseRad(point_3,point_task_4)

    return points, point_num(true), 2
end

local function addPlaneRouteInPath(group_path, groups, first_descent_pos, coalition)

    local PN = 0
    local function point_num(b_current)
        if PN == 0 or b_current == nil or b_current == false then
            PN = PN + 1
        end
        return PN
    end

    local points = {}
    local descent_point_num = 0
    local prev_point = {}

    for i=1, #group_path do
        local point_ = group_path[i]
        if point_.action ~= nil and point_.action == 1 then
            descent_point_num = point_num()
            first_descent_pos.y = point_.y
            local point_drop = pointShiftAbs(first_descent_pos, prev_point, 1000)
            points[descent_point_num] = PointTask(first_descent_pos.x, first_descent_pos.y, first_descent_pos.z,nil,point_.speed, nil, getTaskAirborn(point_drop, 400, groups))
        else
            points[point_num()] = PointTask(point_.x,point_.y,point_.z,nil,point_.speed)
            prev_point = point_
        end
    end

    return points, point_num(true), descent_point_num
end

local function addPlaneRoutePoints(airbase_name_start, airbase_name_target, groups, first_descent_pos, coalition)
    
    local enemy_coalition = 0
    if coalition == 1 then
        enemy_coalition = 2
    elseif coalition == 2 then
        enemy_coalition = 1
    end
    
    local b_find_base = false
    local airbase_start_pos = {}
    if airbase_name_start ~= nil and airbase_name_start ~= "" then
        local airbase_start =  Airbase.getByName(airbase_name_start)
        if airbase_start ~= nil then
            airbase_start_pos = Object.getPosition(airbase_start).p
            b_find_base = true
        end
    end

    local b_enemy_base = false
    local near_enemy_airbase_pos = {}
    local near_enemy_airbase =  Airbase.getNearset(first_descent_pos,enemy_coalition)
    if near_enemy_airbase ~= nil then
        near_enemy_airbase_pos = Object.getPosition(near_enemy_airbase).p
        b_enemy_base = true
    end

    if b_find_base == false then
        local course_out_of_enemy = 0
        if b_enemy_base == true then
            course_out_of_enemy = pointCourseRad(near_enemy_airbase_pos, first_descent_pos)
        end
        airbase_start_pos = pointShiftAngleRad(first_descent_pos, 50000, course_out_of_enemy)
    end

    local course_to_target = pointCourseRad(airbase_start_pos,first_descent_pos)
    local course_to_base = pointCourseRad(first_descent_pos, airbase_start_pos)
    
    local course_prepare_descent
    local course_finish_descent
    if b_enemy_base == true then
        local course_enemy_to_target = pointCourseRad(near_enemy_airbase_pos,first_descent_pos)
        local d_course = d_CourseRad(course_to_base, course_enemy_to_target)
        d_course = clampTo(d_course, -math.rad(45) , math.rad(45))
        course_prepare_descent = rotateCourseRad(course_enemy_to_target, d_course)
        if d_course < 0 and d_course > -math.rad(50) then
            d_course = -math.rad(45)
        elseif d_course > 0 and d_course < math.rad(50) then
            d_course  = math.rad(45)
        end
        course_finish_descent = rotateCourseRad(course_enemy_to_target, -d_course)
    else
        course_prepare_descent = rotateCourseRad(course_to_base, math.rad(-60))
        course_finish_descent = rotateCourseRad(course_to_base, math.rad(70))
    end

    local point_3 = pointShiftAngleRad(first_descent_pos, 18000, course_prepare_descent)

    local point_2_dist_from_airbase = 4000
    local dist_to_statr_desc_miss = pointDistanceXZ(airbase_start_pos, point_3)
    if dist_to_statr_desc_miss < 4000 then
        point_2_dist_from_airbase = 0.5*dist_to_statr_desc_miss
    end

    local point_2 = pointShiftAbs(airbase_start_pos, point_3, point_2_dist_from_airbase)
    
    local drift_points_2_3 = Disposition.DriftRoute(point_2,point_3,coalition)

    local point_task_4 = pointShiftAbs(first_descent_pos, point_3, 4000)

    local point_5 = pointShiftAngleRad(first_descent_pos, 10000, course_finish_descent)

    local point_end = pointShiftAbs(airbase_start_pos, first_descent_pos, -1000)

    local drift_points_5_e = Disposition.DriftRoute(point_5,point_end,coalition)

    --local point_drop = pointShiftAbs(first_descent_pos, airbase_start_pos, 500)
    --      point_drop = pointShiftAbs(point_drop, point_3, 500)
    local point_drop = pointShiftAbs(first_descent_pos, point_3, 1000)

    local PN = 0
    local function point_num(b_current)
        if PN == 0 or b_current == nil or b_current == false then
            PN = PN + 1
        end
        return PN
    end

    local points = {}
    
        --[point_num()] = PointTask(airbase_start_pos.x,airbase_start_pos.y,airbase_start_pos.z,"TakeOffParkingHot",750,nil,"From Parking Area Hot"),
        points[point_num()] = PointTask(airbase_start_pos.x,1000,airbase_start_pos.z,nil,700)

        if drift_points_2_3 ~= nil then
            for i, point_ in pairs(drift_points_2_3) do
                points[point_num()] = PointTask(point_.x,1000,point_.z,nil,700)
            end
        else
            points[point_num()] = PointTask(point_2.x,1000,point_2.z,nil,700)
            points[point_num()] = PointTask(point_3.x, 1000, point_3.z,nil,700)
        end

        local descent_point_num = point_num()
        points[descent_point_num] = PointTask(point_task_4.x, 500, point_task_4.z,nil,400, nil, getTaskAirborn(point_drop, 400, groups))
        
        if drift_points_5_e ~= nil then
            for i, point_ in pairs(drift_points_5_e) do
                points[point_num()] = PointTask(point_.x,1000,point_.z,nil,700)
            end
        else
            points[point_num()] = PointTask(point_5.x, 500, point_5.z,nil,700)
            points[point_num()] = PointTask(point_end.x,1000,point_end.z,nil,700)
        end


        --change end point position
        local summ_course = 0
        for i = 2, #points-1 do
            local point = {x = points[i].x, y = 0, z = points[i].y}
            local course_to_point = pointCourseRad(airbase_start_pos, point)
            if i == 2 then
                summ_course = course_to_point
            else
                summ_course = average_CourseRad(course_to_point, summ_course)
            end
        end
        local point_end_2 = pointShiftAngleRad(airbase_start_pos, -5000, summ_course)
        points[point_num(true)].x = point_end_2.x
        points[point_num(true)].y = point_end_2.z


    points[1]["psi"] = pointCourseRad(airbase_start_pos,point_2)--course_to_target-- 
    --points[1]["airdromeId"] = airbase_start_id

    return points, point_num(true), descent_point_num
end

local function trooperGroupFirst(points, first_point_shift, unit_skill)

    local start_pos = { x = points[1].x, y = 0, z = points[1].y}
    if first_point_shift ~= nil then
        start_pos = pointShiftAbs(start_pos, {x = points[2].x, y = 0, z = points[2].y}, -first_point_shift)
    end
    counter_squad = counter_squad + 1
    return {
        ["visible"] = false,
        ["lateActivation"] = true,
        ["tasks"] = 
        {
        }, -- end of ["tasks"]
        ["uncontrollable"] = false,
        ["task"] = "Без задачи",
        ["taskSelected"] = true,
        ["route"] = 
        {
            ["spans"] = 
            {
            }, -- end of ["spans"]
            ["points"] = points,
            ["routeRelativeTOT"] = true,
        }, -- end of ["route"]
        ["hidden"] = false,
        ["units"] = 
        {
            [1] = 
            {
                ["type"] = "Soldier M4",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = start_pos.z,
                ["x"] = start_pos.x,
                ["name"] = new_unit_name(),
                ["heading"] = 0,
                ["playerCanDrive"] = false,
            }, -- end of [1]
        }, -- end of ["units"]
        ["y"] = start_pos.z,
        ["x"] = start_pos.x,
        ["name"] = new_group_name(),
        ["start_time"] = 0,
        ["hiddenOnPlanner"] = false,
    }
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
                ["livery_id"] = "usaf standard",
                ["skill"] = unit_skill,
                --["parking"] = 6,
                ["speed"] = points[1].speed,
                ["type"] = "C-17A",
                ["psi"] = points[1].psi,
                --["parking_id"] = "05",
                ["x"] = points[1].x,
                ["name"] = new_unit_name(),
                ["payload"] = 
                {
                    ["pylons"] = 
                    {
                    }, -- end of ["pylons"]
                    ["fuel"] = 71499,
                    ["flare"] = 60,
                    ["chaff"] = 120,
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
        }, -- end of ["units"]
        ["y"] = points[1].y,
        ["x"] = points[1].x,
        ["name"] = new_group_name(),
        ["communication"] = true,
        ["start_time"] = 0,
        ["frequency"] = 251,
    }
end

function AirbornGroups_for_test(squad_name, group_country, airbase_name_start, airbase_name)
    test = true
    local groups = AirbornGroups(squad_name, group_country, airbase_name_start, airbase_name)
    test = false
    return groups
end

function AirbornGroupsPrepare(squad_name, group_country, airbase_name_start, airbase_name, unit_skill)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    if  airbase_name == nil then
        return nil
    end

    if test == false and airbase_name_start == nil then
        return nil
    end

    local group_coalition = coalition.getCountryCoalition(group_country)
    
    local points_troopers = addGroundRoutePoints(airbase_name, 1, 0)

    local groups_descent = {  trooperGroupFirst(points_troopers, 0, unit_skill)
                            , trooperGroupFirst(points_troopers, 1, unit_skill)
                            , trooperGroupFirst(points_troopers, 2, unit_skill)
                            , trooperGroupFirst(points_troopers, 3, unit_skill)
                            , trooperGroupFirst(points_troopers, 4, unit_skill)
                            , trooperGroupFirst(points_troopers, 5, unit_skill)
                            , trooperGroupFirst(points_troopers, 6, unit_skill)
                            , trooperGroupFirst(points_troopers, 7, unit_skill)
                            , trooperGroupFirst(points_troopers, 8, unit_skill)
                            , trooperGroupFirst(points_troopers, 9, unit_skill)
                            , trooperGroupFirst(points_troopers, 10, unit_skill)
                            , trooperGroupFirst(points_troopers, 11, unit_skill)
                            , trooperGroupFirst(points_troopers, 12, unit_skill)
                            , trooperGroupFirst(points_troopers, 13, unit_skill)
                            , trooperGroupFirst(points_troopers, 14, unit_skill)
                            , trooperGroupFirst(points_troopers, 15, unit_skill)
                            , trooperGroupFirst(points_troopers, 16, unit_skill)
                            , trooperGroupFirst(points_troopers, 17, unit_skill)
                            , trooperGroupFirst(points_troopers, 18, unit_skill)
                            , trooperGroupFirst(points_troopers, 19, unit_skill)
                        }


    local zone_tower = addTriggerZone("Tower", points_troopers[2].x, points_troopers[2].y, 120, {0,0,0,1})
    

    local first_troops_point = {x=points_troopers[1].x,y=points_troopers[1].alt,z=points_troopers[1].y}

    local plane_points = {}
    local count_points = 0
    if test == true then
        plane_points, count_points, descent_point_num = addPlaneRoutePoints_test(airbase_name_start,airbase_name, groups_descent, first_troops_point)
    else
        plane_points, count_points, descent_point_num = addPlaneRoutePoints(airbase_name_start,airbase_name, groups_descent, first_troops_point, group_coalition)
    end

    local plane_1 = planeGroupFirst(plane_points, unit_skill)

    local zone_plane = addTriggerZone("PlaneComplite", plane_points[count_points].x, plane_points[count_points].y, 500, {0,0,0,1})

    counter_squad = 0
    
    return {
        ["ground_groups"] = groups_descent,
        ["tower_trigger"] = zone_tower,
        ["plane_groups"] = plane_1,
        ["descent_point"] = descent_point_num,
        ["plane_trigger"] = zone_plane
    }
end


function AirbornGroupsPrepareWithPath(squad_name, group_country, airbase_name, group_path, unit_skill)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    if  group_path == nil then
        return nil
    end

    local group_coalition = coalition.getCountryCoalition(group_country)
    
    local points_troopers = addGroundRoutePoints(airbase_name, 1, 0)

    local groups_descent = {  trooperGroupFirst(points_troopers, 0, unit_skill)
                            , trooperGroupFirst(points_troopers, 1, unit_skill)
                            , trooperGroupFirst(points_troopers, 2, unit_skill)
                            , trooperGroupFirst(points_troopers, 3, unit_skill)
                            , trooperGroupFirst(points_troopers, 4, unit_skill)
                            , trooperGroupFirst(points_troopers, 5, unit_skill)
                            , trooperGroupFirst(points_troopers, 6, unit_skill)
                            , trooperGroupFirst(points_troopers, 7, unit_skill)
                            , trooperGroupFirst(points_troopers, 8, unit_skill)
                            , trooperGroupFirst(points_troopers, 9, unit_skill)
                            , trooperGroupFirst(points_troopers, 10, unit_skill)
                            , trooperGroupFirst(points_troopers, 11, unit_skill)
                            , trooperGroupFirst(points_troopers, 12, unit_skill)
                            , trooperGroupFirst(points_troopers, 13, unit_skill)
                            , trooperGroupFirst(points_troopers, 14, unit_skill)
                            , trooperGroupFirst(points_troopers, 15, unit_skill)
                            , trooperGroupFirst(points_troopers, 16, unit_skill)
                            , trooperGroupFirst(points_troopers, 17, unit_skill)
                            , trooperGroupFirst(points_troopers, 18, unit_skill)
                            , trooperGroupFirst(points_troopers, 19, unit_skill)
                        }


    local zone_tower = addTriggerZone("Tower", points_troopers[2].x, points_troopers[2].y, 120, {0,0,0,1})
    

    local first_troops_point = {x=points_troopers[1].x,y=points_troopers[1].alt,z=points_troopers[1].y}

    local plane_points = {}
    local count_points = 0

    plane_points, count_points, descent_point_num = addPlaneRouteInPath(group_path, groups_descent, first_troops_point, group_coalition)

    local plane_1 = planeGroupFirst(plane_points, unit_skill )

    local zone_plane = addTriggerZone("PlaneComplite", plane_points[count_points].x, plane_points[count_points].y, 500, {0,0,0,1})

    counter_squad = 0
    
    return {
        ["ground_groups"] = groups_descent,
        ["tower_trigger"] = zone_tower,
        ["plane_groups"] = plane_1,
        ["descent_point"] = descent_point_num,
        ["plane_trigger"] = zone_plane
    }
end


local function CreateGroup(group_country,group_data)
    local group = coalition.addGroup(group_country, Group.Category.GROUND,group_data)
    return group:getID()
end

local function CreateTrigger(group_id, zone_id)
    trigger.misc.addTrigger(addTriggerDeactivateAllInZone(group_id, zone_id))
end

local function CreateZone(zone_data)
    return trigger.misc.addZone(zone_data)
end


local function taskAirbornInsertGroup(task, groups)

    for i=1, #task.params.tasks do
        if task.params.tasks[i].id == "ParatroopersDrop" then
            task.params.tasks[i].params.groupsOnBoard = groups
        end
    end

    return task
end

function CreateGroups(group_country,groups_to_create)
    local groun_num = 0
    local groups_id = {}
    
    local trigger_zone_tower = CreateZone(groups_to_create.tower_trigger)

    for i = 1, #groups_to_create.ground_groups do
         groun_num = groun_num + 1
         groups_id[groun_num] = CreateGroup(group_country, groups_to_create.ground_groups[i])
         CreateTrigger(groups_id[groun_num], trigger_zone_tower.zoneId)
    end

    local trigger_zone_plane = CreateZone(groups_to_create.plane_trigger)

    groups_to_create.plane_groups.route.points[groups_to_create.descent_point].task 
    = taskAirbornInsertGroup(groups_to_create.plane_groups.route.points[groups_to_create.descent_point].task,groups_id)

    local plane_1 = coalition.addGroup(group_country, Group.Category.AIRPLANE, groups_to_create.plane_groups)
    CreateTrigger(plane_1:getID(), trigger_zone_plane.zoneId)

    return {
        ["ground_groups"] = groups_id,
        ["tower_trigger"] = trigger_zone_tower.zoneId,
        ["plane_groups"] = plane_1:getID(),
        ["plane_trigger"] = trigger_zone_plane.zoneId
    }
end

function AirbornGroups(squad_name, group_country, airbase_name_start, airbase_name, unit_skill)

    local groups_data = AirbornGroupsPrepare(squad_name, group_country, airbase_name_start, airbase_name, unit_skill)

    if groups_data == nil then
        return
    end

    return CreateGroups(group_country,groups_data)

end

function AirbornGroupsWithPath(squad_name, group_country, airbase_name, group_path, unit_skill)
    
    local groups_data = AirbornGroupsPrepareWithPath(squad_name, group_country, airbase_name, group_path, unit_skill)

    if groups_data == nil then
        return
    end

    return CreateGroups(group_country,groups_data)

end

--groups_mission_id = AirbornGroups(200,country.id.USA, "Krymsk", "Novorossiysk","Good")
--groups_mission_id = AirbornGroups(200,country.id.USA, "Kutaisi", "Senaki-Kolkhi","Good")
--groups_mission_id = AirbornGroups(200,country.id.USA, "Novorossiysk", "Gelendzhik","Good")
--groups_mission_id = AirbornGroups_for_test(200,country.id.USA, nil, "Gelendzhik","Good")

--country.id.RUSSIA
--country.id.USA