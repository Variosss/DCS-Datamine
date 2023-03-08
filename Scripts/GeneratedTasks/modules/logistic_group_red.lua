
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
        return string.format("Logistic_Group_%d",counter_group)
    else
        return string.format("Logistic_%d_Group_%d",counter_squad, counter_group)
    end
end

local function new_unit_name()
    counter_unit = counter_unit + 1
    if counter_squad == 0 then
        return string.format("Logistic_Group_%d_%d",counter_group, counter_unit)
    else
        return string.format("Logistic_%d_Group_%d_%d",counter_squad, counter_group, counter_unit)
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
        course = math.atan2(vector_xz.z, vector_xz.x)
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

local function LogisticGroup(zone, unit_skill, pos, course)
    counter_squad = counter_squad + 1
    
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
                ["type"] = "Ural-375",
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
                ["type"] = "Ural-375",
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
                ["type"] = "Ural-375",
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
                ["type"] = "Ural-375",
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
                ["type"] = "Ural-375",
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

local function LogisticSupport(zone, unit_skill, pos, course)
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
                ["type"] = "BTR-80",
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
                ["type"] = "BTR-80",
                ["unitId"] = 2,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [2]
        }, -- end of ["units"]
        ["y"] = pos.z,
        ["x"] = pos.x,
        ["name"] = new_group_name(),
        ["start_time"] = 0,
    }
end

local function LogisticAirDefence(zone, unit_skill, course)
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
                ["type"] = "Ural-375 ZU-23",
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
                ["type"] = "Ural-375 ZU-23",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["playerCanDrive"] = false,
            }, -- end of [2]
        }, -- end of ["units"]
        ["y"] = get_y(zone),
        ["x"] = get_x(zone),
        ["name"] = new_group_name(),
        ["start_time"] = 0,
    }
end

local function LogisticShip(zone, unit_skill, pos, course)
    counter_squad = counter_squad + 1
    
    return {
        ["visible"] = false,
        ["tasks"] = 
        {
        }, -- end of ["tasks"]
        ["uncontrollable"] = false,
        ["route"] = 
        {
            ["points"] = 
            {
            }, -- end of ["points"]
        }, -- end of ["route"]
        ["hidden"] = false,
        ["units"] = 
        {
            [1] = 
            {
                ["type"] = "ELNYA",
                ["modulation"] = 0,
                ["skill"] = unit_skill,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["frequency"] = 127500000,
            }, -- end of [1]
            [2] = 
            {
                ["type"] = "ELNYA",
                ["modulation"] = 0,
                ["skill"] = unit_skill,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["frequency"] = 127500000,
            }, -- end of [2]
            [3] = 
            {
                ["type"] = "ELNYA",
                ["modulation"] = 0,
                ["skill"] = unit_skill,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["frequency"] = 127500000,
            }, -- end of [3]
        }, -- end of ["units"]
        ["y"] = pos.z,
        ["x"] = pos.x,
        ["name"] = new_group_name(),
        ["start_time"] = 0,
    }

end

local function LogisticSupportShip(zone, unit_skill, pos, course)
    counter_squad = counter_squad + 1

    return
    {
        ["visible"] = false,
        ["tasks"] = 
        {
        }, -- end of ["tasks"]
        ["uncontrollable"] = false,
        ["route"] = 
        {
            ["points"] = 
            {
            }, -- end of ["points"]
        }, -- end of ["route"]
        ["hidden"] = false,
        ["units"] = 
        {
            [1] = 
            {
                ["type"] = "MOLNIYA",
                ["modulation"] = 0,
                ["skill"] = unit_skill,
                ["y"] = get_y(zone),
                ["x"] = get_x(zone),
                ["name"] = new_unit_name(),
                ["heading"] = course,
                ["frequency"] = 127500000,
            }, -- end of [1]
        }, -- end of ["units"]
        ["y"] = pos.z,
        ["x"] = pos.x,
        ["name"] = new_group_name(),
        ["start_time"] = 0, 

    }
   
end

function LogisticGroupPrepareWithZone(squad_name, unit_skill, zone_pos, position, course)
    if squad_name ~= nil then
        counter_squad = squad_name
    end
   
    num_pos = 0
    local group_1 = LogisticGroup(zone_pos, unit_skill, position, course)
    local group_2 = LogisticGroup(zone_pos, unit_skill, position, course)
    local group_3 = LogisticSupport(zone_pos, unit_skill, position, course)
    local group_4 = LogisticAirDefence(zone_pos, unit_skill, course)
    

    return {group_1, group_2, group_3, group_4}
end

function LogisticGroupPrepare(squad_name, unit_skill, position, course, calc_zone)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    num_pos = 0

    local group_1 = LogisticGroup(calc_zone, unit_skill, position, course)
    local group_2 = LogisticGroup(calc_zone, unit_skill, position, course)
    local group_3 = LogisticSupport(calc_zone, unit_skill, position, course)
    local group_4 = LogisticAirDefence(calc_zone, unit_skill, course)

    return {group_1, group_2, group_3, group_4}
end

function LogisticShipPrepare(squad_name, position, course)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    -- найти в области с координатой и радиусом 5000м чистые 10 позиций радиусом 500м для размещения морских юнитов
    local calc_zone = Disposition.getSimpleZones(position, 5000, 500, 10, true)

    --Disposition.getPrintData("zone_pos ",calc_zone)

    num_pos = 0

    local group_1 = LogisticShip(calc_zone, position, course)
    local group_2 = LogisticSupportShip(calc_zone, position, course)

    return {group_1, group_2}
end

function CreateGroup(group_country,group_data, group_category)
    --Group.Category.GROUND
    local group = coalition.addGroup(group_country, group_category, group_data)
    return group:getID()
end

function CreateGroups(group_country,groups_to_create, group_category)
    local groun_num = 0
    local groups_id = {}
    
    for i = 1, #groups_to_create do
         groun_num = groun_num + 1
         groups_id[groun_num] = CreateGroup(group_country, groups_to_create[i], group_category)
    end

    return groups_id
end

function Logistic(squad_name, group_country, unit_skill, airbase_name_str_to, course, dist)

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
    local is_first_water_pos = false
    local first_water_pos = {}
    local calc_zone = {}

    -- найти в области с координатой и радиусом 500м чистые 20 позиций радиусом 40м для размещения юнитов
    calc_zone = Disposition.getSimpleZones(pos, 500, 40, 20)

    local shift_angle = 1/3 --вращаем точку вокруг аэродрома с радиусом dist со сдвигом 20гр
    if dist > 1500 then
        shift_angle = 500/dist
    end

    local shift_rad = math.atan(shift_angle)
    local count = math.floor(math.pi/shift_rad)--1/2 круга
    for i = 2, count do 
        
        print('~~~~~~~~~~ logistic ~~~~~~', i, '  ', #calc_zone)

        if #calc_zone >= 20 then break end--выход из цыкла

        --нет мест на суше - ищем блоьшую воду
        if is_first_water_pos == false then

            local big_water = Disposition.getPointWater(pos,5000,100)
            if big_water == true then
                is_first_water_pos = true
                first_water_pos = pos
            end
        end

        -- меняем позицию
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
        
        -- ищем место на новой позиции
        calc_zone = Disposition.getSimpleZones(pos, 500, 40, 20)
    end

    local groups_to_create = {}
    local group_category = 0

    if is_water == true then
        group_category = 3--Group.Category.NAVAL
        local course_to_base = pointCourseRad(first_water_pos, airbase_pos_to)
        groups_to_create = LogisticShipPrepare(squad_name, unit_skill, first_water_pos, course_to_base)
    else
        group_category = Group.Category.GROUND
        local course_to_base = pointCourseRad(pos, airbase_pos_to)
        groups_to_create = LogisticGroupPrepare(squad_name, unit_skill, pos, course_to_base, calc_zone)
    end

    if groups_to_create == nil then
        return nil
    end

    return CreateGroups(group_country,groups_to_create, group_category)
end

function CreateGroupsWithZone(squad_name, group_country, unit_skill, zone_pos, position, course)
    if zone_pos == nil then
        return
    end

    local groups_to_create = LogisticGroupPrepareWithZone(squad_name, unit_skill, zone_pos, position, course)

    if groups_to_create == nil then
        return
    end

    return CreateGroups(group_country,groups_to_create)
end

--logistic = Logistic(nil, country.id.RUSSIA, "Senaki-Kolkhi", "Good", math.rad(-135), 5000)