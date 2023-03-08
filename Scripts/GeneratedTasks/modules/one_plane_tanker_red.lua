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

    --Disposition.getPrintData('course',course)
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

local function getTaskInvisible()
    return
    {
        ["id"] = "ComboTask",
        ["params"] = 
        {
            ["tasks"] = 
            {
                --[1] = 
                --{
                --    ["enabled"] = true,
                --    ["auto"] = false,
                --    ["id"] = "WrappedAction",
                --    ["number"] = 1,
                --    ["params"] = 
                --    {
                --        ["action"] = 
                --        {
                --            ["id"] = "SetInvisible",
                --            ["params"] = 
                --            {
                --                ["value"] = true,
                --            }, -- end of ["params"]
                --        }, -- end of ["action"]
                --    }, -- end of ["params"]
                --}, -- end of [1]
                [2] = 
                {
                    ["enabled"] = true,
                    ["auto"] = false,
                    ["id"] = "WrappedAction",
                    ["number"] = 2,
                    ["params"] = 
                    {
                        ["action"] = 
                        {
                            ["id"] = "SetImmortal",
                            ["params"] = 
                            {
                                ["value"] = true,
                            }, -- end of ["params"]
                        }, -- end of ["action"]
                    }, -- end of ["params"]
                }, -- end of [2]
            }, -- end of ["tasks"]
        }, -- end of ["params"]
    }
end

local function getTaskTanker(speed, alt)
    return {
        ["id"] = "ComboTask",
        ["params"] = 
        {
            ["tasks"] = 
            {
                [1] = 
                {
                    ["enabled"] = true,
                    ["auto"] = false,
                    ["id"] = "Tanker",
                    ["number"] = 1,
                    ["params"] = 
                    {
                    }, -- end of ["params"]
                }, -- end of [1]
                [2] = 
                {
                    ["number"] = 2,
                    ["auto"] = false,
                    ["id"] = "Orbit",
                    ["enabled"] = true,
                    ["params"] = 
                    {
                        ["altitude"] = alt,
                        ["pattern"] = "Race-Track",
                        ["speed"] = speed/3.6,
                    }, -- end of ["params"]
                }, -- end of [2]
            }, -- end of ["tasks"]
        }, -- end of ["params"]
    }
end

local function addPlaneRoutePoints(airbase_name_start, course, distance)
    
    local b_find_base = false
    local airbase_start_pos = {}
    if airbase_name_start ~= nil and airbase_name_start ~= "" then
        local airbase_start =  Airbase.getByName(airbase_name_start)
        if airbase_start ~= nil then
            airbase_start_pos = Object.getPosition(airbase_start).p
            b_find_base = true
        end
    end

    local point_start = pointShiftAngleRad(airbase_start_pos, distance, course)
    local point_tank = pointShiftAngleRad(airbase_start_pos, distance + 1000, course)
    local point_end = pointShiftAngleRad(airbase_start_pos, distance + 8000, course)

    local PN = 0
    local function point_num(b_current)
        if PN == 0 or b_current == nil or b_current == false then
            PN = PN + 1
        end
        return PN
    end

    local points = {
    
        [point_num()] = PointTask(point_start.x,4000,point_start.z,nil,600,nil,getTaskInvisible()),
        [point_num()] = PointTask(point_tank.x, 4000, point_tank.z,nil,600, nil, getTaskTanker(600,4000)),
        [point_num()] = PointTask(point_end.x,4000,point_end.z,nil,800),
    }

    points[1]["psi"] = course

    return points
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
        ["task"] = "Refueling",
        ["uncontrolled"] = false,
        ["taskSelected"] = true,
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
                ["livery_id"] = "RF Air Force",
                ["skill"] = unit_skill,
                --["parking"] = 6,
                ["speed"] = points[1].speed,
                ["type"] = "IL-78M",
                ["psi"] = points[1].psi,
                --["parking_id"] = "05",
                ["x"] = points[1].x,
                ["name"] = new_unit_name(),
                ["payload"] = 
                {
                    ["pylons"] = 
                    {
                    }, -- end of ["pylons"]
                    ["fuel"] = "90000",
                    ["flare"] = 96,
                    ["chaff"] = 96,
                    ["gun"] = 100,
                }, -- end of ["payload"]
                ["y"] = points[1].y,
                ["heading"] = points[1].psi,
                ["callsign"] = 
                {
                    [1] = 1,
                    [2] = 1,
                    [3] = 1,
                    ["name"] = "Texaco11",
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


function AirTankerGroupsPrepare(squad_name, group_country, unit_skill, airbase_name_start, course, distance)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    if airbase_name_start == nil then
        return nil
    end

    local group_coalition = coalition.getCountryCoalition(group_country)
    
    local plane_points = addPlaneRoutePoints(airbase_name_start, course, distance)

    local plane_1 = planeGroupFirst(plane_points, unit_skill )

    counter_squad = 0
    
    return plane_1
end

local function CreateGroup(group_country,group_data)
    local group = coalition.addGroup(group_country, Group.Category.GROUND,group_data)
    return group:getID()
end


local function taskAirbornInsertGroup(task, groups)

    for i=1, #task.params.tasks do
        if task.params.tasks[i].id == "ParatroopersDrop" then
            task.params.tasks[i].params.groupsOnBoard = groups
        end
    end

    return task
end

function CreateGroups(group_country, plane)
    local groun_num = 0
    local groups_id = {}
    
    local plane_1 = coalition.addGroup(group_country, Group.Category.AIRPLANE, plane)

    return plane_1:getID()
    
end

function AirTankerGroups(squad_name, group_country, unit_skill, airbase_name_start, course, distance)

    local plane = AirTankerGroupsPrepare(squad_name, group_country, unit_skill, airbase_name_start, course, distance)

    return CreateGroups(group_country, plane)

end

--groups_mission_id = AirTankerGroups(200,country.id.RUSSIA,"Good", "Senaki-Kolkhi", -1, 5000)
--groups_mission_id = AirbornGroups(200,country.id.USA,"Good", "Kutaisi", "Senaki-Kolkhi")
--groups_mission_id = AirbornGroups(200,country.id.USA,"Good", "Novorossiysk", "Gelendzhik")


--country.id.RUSSIA
--country.id.USA