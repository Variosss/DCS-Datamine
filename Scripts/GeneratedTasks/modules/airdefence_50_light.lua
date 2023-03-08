local airbase_name_str = "Kutaisi"


local counter_squad = 0
local counter_group = 0
local counter_unit = 0

local zones = {}
local num_zone = 0
local num_pos = 0


local function get_y(zone,next)
    if zone == nil then
        if num_pos == 0 then
            num_pos = num_pos + 1
        end

        num_zone = num_zone + 1
        if zones[num_zone] == nil or #zones[num_zone] == 0 then
            num_zone = 1
            num_pos = num_pos + 1
        end

        if zones[num_zone][num_pos] == nil then
            num_pos = 1
        end

        return zones[num_zone][num_pos].y
    else
        if next == nil or next == true then
            num_pos = num_pos+1
        end
    
        if zones[zone] == nil then
            return 0
        else 
            if  zones[zone][num_pos] == nil then
                num_pos = 1
            end

            return zones[zone][num_pos].y
        end
    end
end

local function get_x(zone)
    if zone == nil then
        return zones[num_zone][num_pos].x
    else
        if zones[zone] == nil then
            return 0
        else    
            return zones[zone][num_pos].x
        end
    end
end

local function get_course(zone)
    if zone == nil then
        return zones[num_zone][num_pos].course
    else

        if zones[zone] == nil then
            return 0
        else    
            return zones[zone][num_pos].course
        end
    end
end

local function new_group_name()
    counter_group = counter_group + 1
    counter_unit = 0
    if counter_squad == 0 then
        return string.format("Airdefence_Mobile_%d",counter_group)
    else
        return string.format("Airdefence_%d_Mobile_Group_%d",counter_squad, counter_group)
    end
end

local function new_unit_name()
    counter_unit = counter_unit + 1
    if counter_squad == 0 then
        return string.format("Airdefence_Mobile_%d_%d",counter_group, counter_unit)
    else
        return string.format("Airdefence_%d_Mobile_%d_%d",counter_squad, counter_group, counter_unit)
    end
end

local function AirdefenceGroupTest(x,y)
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
                ["type"] = "snr s-125 tr",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = "High",
                ["y"] = y,
                ["x"] = x,
                ["name"] = new_unit_name(),
                ["heading"] = 0,
                ["playerCanDrive"] = false,
            }, -- end of [1]
            [2] = 
            {
                ["type"] = "5p73 s-125 ln",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = "High",
                ["y"] = y + 100,
                ["x"] = x + 100,
                ["name"] = new_unit_name(),
                ["heading"] = 0,
                ["playerCanDrive"] = false,
            }, -- end of [2]
            [3] = 
            {
                ["type"] = "5p73 s-125 ln",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = "High",
                ["y"] = y + 200,
                ["x"] = x + 200,
                ["name"] = new_unit_name(),
                ["heading"] = 0,
                ["playerCanDrive"] = false,
            }, -- end of [3]
        }, -- end of ["units"]
        ["y"] = y,
        ["x"] = x,
        ["name"] = new_group_name(),
        ["start_time"] = 0,
    }
end

local function AirdefenceGroupSecondTest(x,y)
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
                ["type"] = "ZU-23 Emplacement Closed",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = "Excellent",
                ["y"] = y,
                ["x"] = x,
                ["name"] = new_unit_name(),
                ["heading"] = 0,
                ["playerCanDrive"] = false,
            }, -- end of [1]
            [2] = 
            {
                ["type"] = "ZU-23 Emplacement Closed",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = "Excellent",
                ["y"] = y+60,
                ["x"] = x+60,
                ["name"] = new_unit_name(),
                ["heading"] = 0,
                ["playerCanDrive"] = false,
            }, -- end of [2]
        }, -- end of ["units"]
        ["y"] = x,
        ["x"] = y,
        ["name"] = new_group_name(),
        ["start_time"] = 0,
    }
end


local function AirdefenceGroupSecond(current_zones, unit_skill)
    counter_squad = counter_squad + 1
    zones = current_zones
    num_pos = 0
    
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
        }, -- end of ["route"]
        ["hidden"] = false,
        ["units"] = 
        {
            [1] = 
            {
                ["type"] = "ZU-23 Emplacement Closed",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(),
                ["x"] = get_x(),
                ["name"] = new_unit_name(),
                ["heading"] = get_course(),
                ["playerCanDrive"] = false,
            }, -- end of [1]
            [2] = 
            {
                ["type"] = "ZU-23 Emplacement Closed",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(),
                ["x"] = get_x(),
                ["name"] = new_unit_name(),
                ["heading"] = get_course(),
                ["playerCanDrive"] = false,
            }, -- end of [2]
            [3] = 
            {
                ["type"] = "ZU-23 Emplacement Closed",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(),
                ["x"] = get_x(),
                ["name"] = new_unit_name(),
                ["heading"] = get_course(),
                ["playerCanDrive"] = false,
            }, -- end of [3]
            [4] = 
            {
                ["type"] = "ZU-23 Emplacement Closed",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(),
                ["x"] = get_x(),
                ["name"] = new_unit_name(),
                ["heading"] = get_course(),
                ["playerCanDrive"] = false,
            }, -- end of [4]
        }, -- end of ["units"]
        ["y"] = 0,
        ["x"] = 0,
        ["name"] = new_group_name(),
        ["start_time"] = 0,
    }
end
  
local function AirdefenceGroupSupport(current_zones, unit_skill)
    counter_squad = counter_squad + 1
    zones = current_zones
    num_pos = 0
    
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
        }, -- end of ["route"]
        ["hidden"] = false,
        ["units"] = 
        {
            [1] = 
            {
                ["type"] = "S-60_Type59_Artillery",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(),
                ["x"] = get_x(),
                ["name"] = new_unit_name(),
                ["heading"] = get_course(),
                ["playerCanDrive"] = true,
            }, -- end of [1]
            [2] = 
            {
                ["type"] = "S-60_Type59_Artillery",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(),
                ["x"] = get_x(),
                ["name"] = new_unit_name(),
                ["heading"] = get_course(),
                ["playerCanDrive"] = true,
            }, -- end of [2]
            [3] = 
            {
                ["type"] = "S-60_Type59_Artillery",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(),
                ["x"] = get_x(),
                ["name"] = new_unit_name(),
                ["heading"] = get_course(),
                ["playerCanDrive"] = true,
            }, -- end of [3]
            [4] = 
            {
                ["type"] = "S-60_Type59_Artillery",
                ["transportable"] = 
                {
                    ["randomTransportable"] = false,
                }, -- end of ["transportable"]
                ["skill"] = unit_skill,
                ["y"] = get_y(),
                ["x"] = get_x(),
                ["name"] = new_unit_name(),
                ["heading"] = get_course(),
                ["playerCanDrive"] = true,
            }, -- end of [4]
        }, -- end of ["units"]
        ["y"] = 0,
        ["x"] = 0,
        ["name"] = new_group_name(),
        ["start_time"] = 0,
    }
end

function AirdefenceGroups_for_test(squad_name, group_country, airbase_name)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    local airbase
    if airbase_name == nil then
        return
    end

    local airbase =  Airbase.getByName(airbase_name)
    local airbase_pos = Object.getPosition(airbase).p
    local airbase_tower = airbase:getTechObjectPos("towers")

    local group2 = coalition.addGroup(group_country, Group.Category.GROUND, AirdefenceGroupSecondTest(airbase_tower.pos.x-30, airbase_tower.pos.z-30))
    local group1 = coalition.addGroup(group_country, Group.Category.GROUND, AirdefenceGroupTest(airbase_pos.x, airbase_pos.z))
    local groups_id = {group1:getID(), group2:getID()}

    return groups_id
end


function AirdefenceGroupsPrepareWithZone(squad_name, zone_pos, unit_skill)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    -- случайным образом перемешивает позиции в массиве
    --local order_zone = Disposition.getRandomSort({1, 2, 3}) 

    --Disposition.getPrintData("zone_pos ",zone_pos)

    --local group_1 = AirdefenceGroupFirst(zone_pos[order_zone[1]])
    local group_2 = AirdefenceGroupSecond(zone_pos[2], unit_skill)
    local group_3 = AirdefenceGroupSupport(zone_pos[3], unit_skill)

    return {group_2,group_3}
end


function AirdefenceGroupsPrepare(squad_name, airbase_name, unit_skill)
    if squad_name ~= nil then
        counter_squad = squad_name
    end

    local airbase
    if airbase_name == nil then
        airbase =  Airbase.getByName("Kutaisi")
    else
        airbase =  Airbase.getByName(airbase_name)
    end

    local airbase_runway = airbase:getRunways()

    local perim = Disposition.getRunwayPerimetr(airbase_runway)

    local calc_zones = 
    {
        [1] = 
        {
            -- количество областей вокруг полос ВПП
            size = 4,
            -- расчет 4х обласлей расстановки вокруг полос ВПП (perim) на 7 позиций в каждой
            -- первая область смещается от курса полосы ВПП на 22.5 градуса почасовой стрелке по дуге элипса
            -- области рассчитываются по элипсу с отношением радиусов 0.5 (больший радиус равен половине длинны полосы)
            zone = Disposition.getElipsSideZones(4, 7, perim, 22.5, 0.5),
        },
        [2] = 
        {
            -- количество областей вокруг полос ВПП
            size = 4,
            -- расчет 4х обласлей расстановки вокруг полос ВПП (perim) на 7 позиций в каждой
            -- первая область смещается от курса полосы ВПП на 45 градусов почасовой стрелке по дуге элипса
            -- области рассчитываются по элипсу с отношением радиусов 1 (больший радиус равен половине длинны полосы)
            zone = Disposition.getElipsSideZones(4, 7, perim, 45),
        },
    }


    local group_1 = AirdefenceGroupSecond(calc_zones[1].zone, unit_skill)
    local group_2 = AirdefenceGroupSupport(calc_zones[2].zone, unit_skill)

    return {group_1,group_2}
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

function AirdefenceGroups(squad_name, group_country, airbase_name, unit_skill)

    local groups_to_create = AirdefenceGroupsPrepare(squad_name, airbase_name, unit_skill)

    if groups_to_create == nil then
        return
    end

    return CreateGroups(group_country,groups_to_create)
end


function CreateGroupsWithZone(squad_name, group_country, zone_pos, unit_skill)
    if zone_pos == nil then
        return
    end

    local groups_to_create = AirdefenceGroupsPrepareWithZone(squad_name, zone_pos, unit_skill)

    if groups_to_create == nil then
        return
    end

    return CreateGroups(group_country,groups_to_create)
end

--defence = AirdefenceGroups(nul, country.id.RUSSIA, airbase_name_str, "Good")




