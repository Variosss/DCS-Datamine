
local counter_squad = 0
local counter_group = 0
local counter_unit = 0

local num_pos = 0

local function get_x(zone)
    if zone == nil then
        return 0
    else
        return zone[num_pos].x
    end
end

local function get_y(zone,next)
    if next == nil or next == true then
        num_pos = num_pos+1
    end

    if zone == nil then
        return 0
    else    
        if  zone[num_pos] == nil then
            num_pos = 1
        end
        return zone[num_pos].y
    end
end

local function get_course(zone)
    if zone == nil then
        return 0
    else
        return zone[num_pos].course
    end
end

local function new_group_name()
    counter_group = counter_group + 1
    counter_unit = 0
    if counter_squad == 0 then
        return string.format("Artillery_Battery_%d",counter_group)
    else
        return string.format("Artillery_%d_Battery_%d",counter_squad, counter_group)
    end
end

local function new_unit_name()
    counter_unit = counter_unit + 1
    if counter_squad == 0 then
        return string.format("Artillery_Battery_%d_%d",counter_group, counter_unit)
    else
        return string.format("Artillery_%d_Battery_%d_%d",counter_squad, counter_group, counter_unit)
    end
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

local function pointCenter(start_pos, end_pos)
    local vector = {
        x = 0.5*(end_pos.x - start_pos.x) + start_pos.x, 
        y = 0.5*(end_pos.y - start_pos.y) + start_pos.y,
        z = 0.5*(end_pos.z - start_pos.z) + start_pos.z
       }

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

    return course
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

local function BaseColumnGroup(zone, pos, course, unit_skill)
    counter_squad = counter_squad + 1
    num_pos = 0
    return 
    {
        ["visible"] = false,
        ["tasks"] = 
        {
        }, -- end of ["tasks"]
        ["uncontrollable"] = false,
        ["task"] = "Ground Nothing",
        ["route"] = 
        {
            ["spans"] = 
            {
            }, -- end of ["spans"]
            ["points"] = 
            {
            }, -- end of ["points"]
        }, -- end of ["route"]
        ["groupId"] = 4,
        ["hidden"] = false,
        ["units"] = 
        {
            [1] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "M 818",
                ["unitId"] = 1,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [1]
            [2] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "M 818",
                ["unitId"] = 2,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [2]
            [3] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "M 818",
                ["unitId"] = 3,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [3]
            [4] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "M 818",
                ["unitId"] = 4,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [4]
            [5] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "M 818",
                ["unitId"] = 5,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [5]
        }, -- end of ["units"]
        ["y"] = pos.z,
        ["x"] = pos.x,
        ["name"] = new_group_name(),
        ["start_time"] = 0,
    }
end

local function BaseColumnSupport(zone, pos, course, unit_skill)
    counter_squad = counter_squad + 1

    return 
    {

        ["visible"] = false,
        ["tasks"] = 
        {
        }, -- end of ["tasks"]
        ["uncontrollable"] = false,
        ["task"] = "Ground Nothing",
        ["taskSelected"] = true,
        ["route"] = 
        {
        }, -- end of ["route"]
        ["groupId"] = 1,
        ["hidden"] = false,
        ["units"] = 
        {
            [1] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "Soldier M4",
                ["unitId"] = 1,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [1]
            [2] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "Soldier M4",
                ["unitId"] = 2,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [2]
            [3] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "Soldier M4",
                ["unitId"] = 3,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [3]
            [4] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "Soldier M4",
                ["unitId"] = 4,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [4]
            [5] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "Soldier M4",
                ["unitId"] = 5,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [5]
            [6] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "Soldier M4",
                ["unitId"] = 6,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [6]
            [7] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "Soldier M4",
                ["unitId"] = 7,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [7]
            [8] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "Soldier M4",
                ["unitId"] = 8,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [8]
            [9] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "Soldier M4",
                ["unitId"] = 9,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [9]
            [10] = 
            {
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["type"] = "Soldier M4",
                ["unitId"] = 10,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [10]
        }, -- end of ["units"]
        ["y"] = pos.z,
        ["x"] = pos.x,
        ["name"] = new_group_name(),
        ["start_time"] = 0,
    }
end

local function BaseColumnAirDefence(zone, course, unit_skill)
    counter_squad = counter_squad + 1

    return {
        ["visible"] = false,
        ["tasks"] = 
        {
        }, -- end of ["tasks"]
        ["uncontrollable"] = false,
        ["task"] = "Ground Nothing",
        ["taskSelected"] = true,
        ["route"] = 
        {
            ["spans"] = 
            {
            }, -- end of ["spans"]
            ["points"] = 
            {
            }, -- end of ["points"]
        }, -- end of ["route"]
        ["hidden"] = false,
        ["units"] = 
        {
            [1] = 
            {
                ["type"] = "Soldier stinger",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = true,
            }, -- end of [1]
            [2] = 
            {
                ["type"] = "Stinger comm",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(zone, false) - 15 * math.sin(course) - 10 * math.cos(course),
                ["x"] = get_x(zone) - 10 * math.cos(course) + 15 * math.sin(course),
                ["name"] = new_unit_name(),
                ["heading"] = course-0.2618,
                ["playerCanDrive"] = false,
            }, -- end of [2]
        }, -- end of ["units"]
        ["y"] = get_y(zone,false),
        ["x"] = get_x(zone),
        ["name"] = new_group_name(),
        ["start_time"] = 0,
    }
end



function RearBasePrepareWithZone(squad_name, unit_skill, zone_pos, course)
    if squad_name ~= nil then
        counter_squad = squad_name
    end
   

    local group_1 = BaseColumnGroup(zone_pos, position, course, unit_skill)
    local group_2 = BaseColumnSupport(zone_pos, position, course, unit_skill)
    --local group_3 = BaseColumnAirDefence(zone_pos, course, unit_skill)
    --local group_4 = BaseColumnAirDefence(zone_pos, course, unit_skill)

    return {group_1, group_2}--, group_3, group_4}
end

function RearBasePrepare(squad_name, unit_skill, airbase_pos_to, position, course)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    -- найти в области с координатой и радиусом 500м чистые 20 позиций радиусом 40м для размещения юнитов
    local calc_zone = Disposition.getSimpleZones(position, 500, 40, 20)

    --Disposition.getPrintData("zone_pos ",calc_zone)

    local group_1 = BaseColumnGroup(calc_zone, position, course, unit_skill)
    local group_2 = BaseColumnSupport(calc_zone, position, course, unit_skill)
    --local group_3 = BaseColumnAirDefence(calc_zone, course, unit_skill)
    --local group_4 = BaseColumnAirDefence(calc_zone, course, unit_skill)

    return {group_1, group_2}--, group_3, group_4}
end

function CreateGroup(group_country,group_data)
    local group = coalition.addGroup(group_country, Group.Category.GROUND,group_data)
    return group:getID()
end

function CreateGroups(group_country,groups_to_create)
    local groun_num = 0
    local groups_id = {}
    
    for i = 1, #groups_to_create do
         groun_num = groun_num + 1
         groups_id[groun_num] = CreateGroup(group_country, groups_to_create[i])
    end

    return groups_id
end

function RearBase(squad_name, group_country, unit_skill, airbase_name_str_to, course, dist)

    local b_find_base = false

    local airbase_pos_to = {}
    if airbase_name_str_to ~= nil and airbase_name_str_to ~= "" then
        local airbase_to =  Airbase.getByName(airbase_name_str_to)
        if airbase_to ~= nil then
            airbase_pos_to = Object.getPosition(airbase_to).p
            b_find_base = true
        end
    end

    if b_find_base == false then
        return nil
    end

    local pos = pointShiftAngleRad(airbase_pos_to, dist, course)

    local is_water = false
    is_water = Disposition.getPointWater(pos,500,20)
    if is_water == true and dist < 600 then
        return nil
    end
    
    local shift_rad = math.asin(1/3)--вращаем точку вокруг аэродрома с радиусом dist со сдвигом 20гр
    local count = math.floor(1.5*math.pi/shift_rad)--3/4 круга
    for i = 2, count do 
        
        if false == is_water then break end
        local n = math.floor(0.5*i)
        local sign = i%2;
        local next_shift_rad
        if sign == 0 then
            next_shift_rad = -shift_rad * n
        else
            next_shift_rad = shift_rad * n
        end 
        local next_course_to_base = rotateCourseRad(course, next_shift_rad)
        pos = pointShiftAngleRad(airbase_pos_to, dist, next_course_to_base)
        is_water = Disposition.getPointWater(pos,500,20)
    end
    if is_water == true then
        return nil
    end

    local course_to_base = pointCourseRad(pos, airbase_pos_to)

    local groups_to_create = RearBasePrepare(squad_name, unit_skill, airbase_pos_to, pos, course_to_base)

    if groups_to_create == nil then
        return nil
    end

    return CreateGroups(group_country,groups_to_create)
end

function CreateGroupsWithZone(squad_name, group_country, unit_skill, zone_pos, course)
    if zone_pos == nil then
        return
    end

    local groups_to_create = RearBasePrepareWithZone(squad_name, unit_skill, zone_pos, course)

    if groups_to_create == nil then
        return
    end

    return CreateGroups(group_country,groups_to_create)
end

--arta = RearBase(nil, country.id.RUSSIA, "Good", "Senaki-Kolkhi", math.rad(-135), 5000)