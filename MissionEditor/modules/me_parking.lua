local base = _G

module('me_parking')

local require = base.require
local table = base.table
local math = base.math
local pairs = base.pairs
local ipairs = base.ipairs
local print = base.print
local tostring = base.tostring
local debug = base.debug

local Mission           = require('me_mission')
local MapWindow         = require('me_map_window')
local DB                = require('me_db_api')
local Terrain			= require('terrain')

require('i18n').setup(_M)

-------------------------------------------------------------------------------
--
function getStandList(roadnet)
	local sList = Terrain.getStandList(roadnet, {"SHELTER","FOR_HELICOPTERS","FOR_AIRPLANES","WIDTH","LENGTH","HEIGHT"})    
	local listP = {}
	for k, v in pairs(sList) do
		listP[v.crossroad_index] = v	  
        if v.params then
            local params = {}
            for kk, vv in base.pairs(v.params) do
                params[kk] = base.tonumber(vv)
            end
            v.params = params
        end    
	end
	return listP
end

-------------------------------------------------------------------------------
--
function getStandListForShip(a_x, a_y, a_RunWays)
	local listP = {}
							
	for k, RunWay in pairs(a_RunWays) do
		if base.type(k) == 'number' and k > 1 then -- первая для посадки
			base.table.insert(listP, {name = tostring(k-1), numParking = k-1, x = a_x, y = a_y, offsetX = RunWay[1][1], offsetY = RunWay[1][3]})			
		end
	end
	return listP
end

-------------------------------------------------------------------------------
-- получение списка стоянок от фарпа и от кораблей
function getStandListUnit(unit_Id)
	local unit = base.module_mission.unit_by_id[unit_Id]
	local listP = {}

	if unit.boss.type == 'ship' then
		local unitDef = DB.unit_by_type[unit.type]
		
		if unitDef.RunWays then
			listP = getStandListForShip(unit.x, unit.y, unitDef.RunWays)		
		elseif unitDef.numParking then
			for i=1, unitDef.numParking do
				base.table.insert(listP, {name = tostring(i), numParking = i})
			end
		end
		return listP
	end

	if DB.isFARP(unit.type) then
		for i=1, 4 do
			base.table.insert(listP, {name = tostring(i), numParking = i})
		end
		return listP	
	end
end


-------------------------------------------------------------------------------
-- возвращает число свободных мест на фарпе, корабле
function getFreeParkingOnHelipad(a_group, a_helipadId)
	local unitHelipad = base.module_mission.unit_by_id[a_helipadId]
	local numParking = 0 
	local unitDef = DB.unit_by_type[unitHelipad.type]
	
	if unitHelipad.boss.type == "static" and DB.isFARP(unitHelipad.type) then
		numParking = unitDef.numParking
	elseif unitHelipad.boss.type == "ship" then
		local unitDef = DB.unit_by_type[unitHelipad.type]
		if unitDef.numParking then
			numParking = unitDef.numParking
		end	
		--if a_group.units[1].type == "Su-33" then
		--	if not (#a_group.units <= 1 or (numParking >= 4)) then  -- на 1 меньше потомучто юнит в процессе добавления
		--		numParking = 2
		--	end	
		--end
	end
	
	for i,v in pairs(Mission.mission.coalition) do
		for j,u in pairs(v.country) do		
			if (u.plane) and (u.plane.group) then
				for num, pl in pairs(u.plane.group) do						
					for numU, unit in pairs(pl.units) do                        
                        if pl.route.points[1].helipadId == a_helipadId then
							numParking = numParking - 1
                        end
					end
				end
			end
			
			if (u.helicopter) and (u.helicopter.group) then
				for num, pl in pairs(u.helicopter.group) do				
					for numU, unit in pairs(pl.units) do	
						if pl.route.points[1].helipadId == a_helipadId then
                            numParking = numParking - 1
                        end
					end
				end
			end		 
		end
	end
	
	return numParking
end


-------------------------------------------------------------------------------
--
function getFreeParkingForAircraft(group, roadnet)
	local listP ={}
	listP = getStandList(roadnet)
	listP = getKeepParkingAirport(group.route.points[1].airdromeId, listP, nil)
	listP = getRightParkingAirport(listP, group)

	local numlistP = 0
	for _,_ in pairs(listP) do
		numlistP = numlistP + 1
	end

	return numlistP
end


local function isNotEnableParking(unit, a_airdromeId, a_unit, a_bLanding, a_reParkingGroup)
    local index
    local isEnableType = false
    if a_bLanding == true then
        index = #unit.boss.route.points
        isEnableType = base.panel_route.isLanding(unit.boss.route.points[index].type)
    else   
        index = 1
        isEnableType = base.panel_route.isTakeOffParking(unit.boss.route.points[index].type)
    end
    
    if isEnableType == true and(unit.boss.route.points[1].airdromeId == a_airdromeId) then        
        if (a_reParkingGroup == true) then
            if((a_unit == nil) or (unit.boss.groupId ~= a_unit.boss.groupId)) then
                return true
            end    
        elseif ((a_unit == nil) or (unit ~= a_unit)) then
            return true
        end    
    end
    return false
end

local function isNotEnableParkingForShip(unit, a_shipId, a_unit, a_bLanding, a_reParkingGroup)
    local index
    local isEnableType = false
    if a_bLanding == true then
        index = #unit.boss.route.points
        isEnableType = base.panel_route.isLanding(unit.boss.route.points[index].type)
    else   
        index = 1
        isEnableType = base.panel_route.isTakeOffParking(unit.boss.route.points[index].type)
    end
    
    if isEnableType == true and(unit.boss.route.points[1].helipadId == a_shipId) then        
        if (a_reParkingGroup == true) then
            if((a_unit == nil) or (unit.boss.groupId ~= a_unit.boss.groupId)) then
                return true
            end    
        elseif ((a_unit == nil) or (unit ~= a_unit)) then
            return true
        end    
    end
    return false
end
-------------------------------------------------------------------------------
--формирование списка свободных стоянок у аэродрома
--a_unit - если не nil не учитывает данный юнит
function getKeepParkingAirport(a_airdromeId, a_listP, a_unit, a_bLanding, a_reParkingGroup)
	local keepList = {}
	for i,v in pairs(Mission.mission.coalition) do
		for j,u in pairs(v.country) do
						
			if (u.plane) and (u.plane.group) then
				for num, pl in pairs(u.plane.group) do						
					for numU, unit in pairs(pl.units) do 
                        if isNotEnableParking(unit,a_airdromeId,a_unit,a_bLanding, a_reParkingGroup) == true then
                            table.insert(keepList, unit.parking or unit.parking_landing)
                        end
					end
				end
			end
			
			if (u.helicopter) and (u.helicopter.group) then
				for num, pl in pairs(u.helicopter.group) do				
					for numU, unit in pairs(pl.units) do	
						if isNotEnableParking(unit,a_airdromeId,a_unit,a_bLanding, a_reParkingGroup) == true then
                            table.insert(keepList, unit.parking or unit.parking_landing)
                        end
					end
				end
			end		 
		end
	end
	
	for k,v in pairs(keepList) do
		--print("v=",v)
		a_listP[base.tonumber(v)] = nil
	end
	
	return a_listP
end

-------------------------------------------------------------------------------
--формирование списка свободных стоянок у корабля
--a_unit - если не nil не учитывает данный юнит
function getKeepParkingShip(a_shipId, a_listP, a_unit, a_bLanding, a_reParkingGroup)
	local keepList = {}
	--[[ временно отключаем проверку парковок на занятость
	for i,v in pairs(Mission.mission.coalition) do
		for j,u in pairs(v.country) do					
			if (u.plane) and (u.plane.group) then
				for num, pl in pairs(u.plane.group) do						
					for numU, unit in pairs(pl.units) do                        
                        if isNotEnableParkingForShip(unit,a_shipId,a_unit,a_bLanding, a_reParkingGroup) == true then
                            table.insert(keepList, unit.parking or unit.parking_landing)
                        end
					end
				end
			end
			
			if (u.helicopter) and (u.helicopter.group) then
				for num, pl in pairs(u.helicopter.group) do				
					for numU, unit in pairs(pl.units) do	
						if isNotEnableParkingForShip(unit,a_shipId,a_unit,a_bLanding, a_reParkingGroup) == true then
                            table.insert(keepList, unit.parking or unit.parking_landing)
                        end
					end
				end
			end		 
		end
	end
	]]
	for k,v in pairs(keepList) do
		--print("v=",v)
		a_listP[base.tonumber(v)] = nil
	end
	
	return a_listP
end

-------------------------------------------------------------------------------
--возвращает список подходящих стоянок для ЛА
function getRightParkingAirportOld(a_listP, group)
	function bitCompare(a_flag, a_bit)
		function decToBit(a_num)
			local bit = ''
			while a_num > 0 do
				bit = base.tostring(a_num % 2)..bit
				a_num = math.floor(a_num/2)
			end
			
			if bit == '' then
				bit = '0'
			end
			
			return bit
		end
	
		local bit_flag = decToBit(a_flag)
		local bit_bit  = decToBit(a_bit)
		
		--print('bit_flag, bit_bit=',bit_flag,bit_bit)
		
		local len_flag = base.string.len(bit_flag)
		local len_bit = base.string.len(bit_bit)
		if (len_bit > len_flag) then
			return false
		end
		
		for i = len_bit, 1, -1 do
			local num_bit = base.string.sub(bit_bit, i ,i)
			--print('num_bit=',num_bit)
			if (num_bit == '1') then
				local num_flag = base.string.sub(bit_flag, len_flag-len_bit+i , len_flag-len_bit+i)
				--print('---------num_flag=',num_flag)
				--print('---------num_flag=',base.string.sub(bit_flag, len_flag-len_bit+i))
				if (num_flag ~= '1') then
					return false
				end
			end
		end
		
		return true
	end
	
	local keepList = {}
    
    local bigAC = DB.unit_by_type[group.units[1].type].bigParkingRamp
	
	for k, v in pairs(a_listP) do	     
		if ((bigAC == true) and (not bitCompare(v.flag, 8))) 
			or ((group.type == 'helicopter') and (bitCompare(v.flag, 2))) then
			--print("bigAC,v.flag,group.type",bigAC,v.flag,group.type)
			table.insert(keepList, k)
		end
	end
	
	for k,v in pairs(keepList) do
		a_listP[base.tonumber(v)] = nil
	end
	
	return a_listP
end

-------------------------------------------------------------------------------
--возвращает список подходящих стоянок для ЛА
function getRightParkingAirport(a_listP, group)    
    if (Terrain.GetTerrainConfig("standDescriptionVersion") == 1) then
        return getRightParkingAirportOld(a_listP, group)
    end
	local keepList = {}
    
    local unitDesc = DB.unit_by_type[group.units[1].type]  
    
    local HEIGHT = unitDesc.height
    local WIDTH  = unitDesc.wing_span or unitDesc.rotor_diameter
    local LENGTH = unitDesc.length
    
    for k, v in pairs(a_listP) do
        --base.print("------name---",v.name)
        --base.print("---type=",group.units[1].type,"--WIDTH=",WIDTH,"--LENGTH=",LENGTH,"--HEIGHT",HEIGHT)
        --base.print("---in terrain-----WIDTH=",v.params.WIDTH,"--LENGTH=",v.params.LENGTH,"--HEIGHT",v.params.HEIGHT,"---FOR_HELICOPTERS---",v.params.FOR_HELICOPTERS)
		if (not((WIDTH < v.params.WIDTH) 
                and (LENGTH < v.params.LENGTH)
                and (HEIGHT < (v.params.HEIGHT or 1000)))) 
			or ((group.type == 'helicopter') and (v.params.FOR_HELICOPTERS == 0))
            or ((group.type == 'plane') and (v.params.FOR_AIRPLANES == 0))    then
			table.insert(keepList, k)
		end
	end
	
	for k,v in pairs(keepList) do
		a_listP[base.tonumber(v)] = nil
	end
	
	return a_listP
end

-------------------------------------------------------------------------------
--
function addUnitsInGroupOnAirport(group, roadnet, numAddAircrafts)
	local listP ={}
	listP = getStandList(roadnet)
	listP = getKeepParkingAirport(group.route.points[1].airdromeId, listP, nil)
	listP = getRightParkingAirport(listP, group)
	
	local numlistP = 0
	for _,_ in pairs(listP) do
		numlistP = numlistP + 1
	end

	if (numAddAircrafts > numlistP) then
		return false
	end
	setToParking(group, listP, group.route.points[1].airdromeId, nil, nil)
	return true
end

-------------------------------------------------------------------------------
--Установка ЛА на аэродром по номеру стоянки
function setAirUnitOnAirport(unit, index, bLanding)
	listP 	= {}
	listP = getStandList(MapWindow.listAirdromes[unit.boss.route.points[1].airdromeId].roadnet)
	
    if bLanding == true then
        unit.x 	= listP[base.tonumber(unit.parking_landing)].x
        unit.y 	= listP[base.tonumber(unit.parking_landing)].y	
    else
        unit.x 	= listP[base.tonumber(unit.parking)].x
        unit.y 	= listP[base.tonumber(unit.parking)].y	
    end
	if index ~= 1 then
		MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
	else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
		unit.boss.mapObjects.units[1].x = unit.x
		unit.boss.mapObjects.units[1].y = unit.y  
		MapWindow.move_waypoint(unit.boss, 1, unit.x, unit.y, nil, true, true);
		Mission.update_group_map_objects(unit.boss)
	end;
end

-------------------------------------------------------------------------------
--Установка ЛА на корабль по номеру стоянки
function setAirUnitOnShip(a_unit, a_index, a_ship)
	listP 	= {}
	local unitDefShip = DB.unit_by_type[a_ship.type]

	if unitDefShip.RunWays == nil then
		for i=1, unitDefShip.numParking do
			base.table.insert(listP, {name = tostring(i), numParking = i, x = a_ship.x, y = a_ship.y})
		end
	else
		listP = getStandListForShip(a_ship.x, a_ship.y, unitDefShip.RunWays)
	end	

	local sinHdg = 0
	local cosHdg = 0
	if a_ship and a_ship.boss.type == "ship" then
		sinHdg = base.math.sin(a_ship.heading)
		cosHdg = base.math.cos(a_ship.heading)
	end
				
	local parking = listP[base.tonumber(a_unit.parking)]
	a_unit.x 	= parking.x + (listP[base.tonumber(a_unit.parking)].offsetX or 0)*cosHdg - (listP[base.tonumber(a_unit.parking)].offsetY or 0)*sinHdg
	a_unit.y 	= parking.y	+ (listP[base.tonumber(a_unit.parking)].offsetY or 0)*cosHdg + (listP[base.tonumber(a_unit.parking)].offsetX or 0)*sinHdg

	if a_index ~= 1 then
		MapWindow.move_unit(a_unit.boss, a_unit, a_unit.x, a_unit.y, false)
	else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
		a_unit.boss.mapObjects.units[1].x = a_unit.x
		a_unit.boss.mapObjects.units[1].y = a_unit.y  
		MapWindow.move_waypoint(a_unit.boss, 1, a_unit.x, a_unit.y, nil, true, true);
		Mission.update_group_map_objects(a_unit.boss)
	end;
end


-------------------------------------------------------------------------------
--Установка группы ЛА на ближайший аэродром имеющий достаточное колличество 
--мест стоянок (расстановка по стоянкам)
function setAirGroupOnAirportRunway(group, x, y)
	local listP ={}
	local airdrom = nil
    local findItem = {}
    local farp = nil
	
	airdrom, listP = findAirport(group, x, y, true)
    
    if airdrom == nil then
        return false
    end
    
    findItem.type   = "airdrom"
    findItem.dist   = airdrom.dist
	
	local unitDef = DB.unit_by_type[group.units[1].type]
	
	if (group.type == 'helicopter') or unitDef.takeoff_and_landing_type == "VTOL" then
		local listPf ={}
		
		farp,listPf = findFarp(group, x, y)

		if (farp) and (farp.dist < findItem.dist) then
            findItem.type   = "farp"
            findItem.dist   = farp.dist			
		end
	end
    
    local grassAirfield = findGrassAirfield(group, x, y)
    if (grassAirfield) and (grassAirfield.dist < findItem.dist) then
        findItem.type   = "GrassAirfield"
        findItem.dist   = grassAirfield.dist			
    end
    
	local listPs ={}
    local ship, listPs = findShip(group, x, y)
    if (ship) and (ship.dist < findItem.dist) then
        findItem.type   = "ship"
        findItem.dist   = ship.dist			
    end
    
    --print("findItem.type, findItem.dist=",findItem.type, findItem.dist)
    if (findItem.type == "airdrom") then
        --print("airdrom.roadnet, airdrom.ID=",airdrom.roadnet, airdrom.ID)
        return setAirGroupOnRunway(group, airdrom, listP)
    elseif (findItem.type == "farp") then  
        return setAirGroupOnFarpRunway(group, farp) 
    elseif (findItem.type == "GrassAirfield") then
        return setAirGroupOnGrassAirfieldRunway(group, grassAirfield)
    else
        return setAirGroupOnShipRunway(group, ship, listPs)     
    end 
end

-------------------------------------------------------------------------------
--Установка группы ЛА на ближайший аэродром имеющий достаточное колличество 
--мест стоянок (расстановка по стоянкам)
function setAirGroupOnAirport(group, x, y)
	local listP ={}
	local airdrom = nil
    local findItem = {}
    local farp = nil
	
	airdrom, listP = findAirport(group, x, y, false)
    
    if airdrom == nil then
        return false
    end
    
    findItem.type   = "airdrom"
    findItem.dist   = airdrom.dist
	
	local unitDef = DB.unit_by_type[group.units[1].type]
	
	if (group.type == 'helicopter') or unitDef.takeoff_and_landing_type == "VTOL" then
		local listPf ={}
		
		farp,listPf = findFarp(group, x, y)

		if (farp) and (farp.dist < findItem.dist) then
            findItem.type   = "farp"
            findItem.dist   = farp.dist			
		end
	end
    
    local grassAirfield = findGrassAirfield(group, x, y)
    if (grassAirfield) and (grassAirfield.dist < findItem.dist) then
        findItem.type   = "GrassAirfield"
        findItem.dist   = grassAirfield.dist			
    end
    
	local listPs ={}
    local ship, listPs = findShip(group, x, y)
    if (ship) and (ship.dist < findItem.dist) then
        findItem.type   = "ship"
        findItem.dist   = ship.dist			
    end
    
    --print("findItem.type, findItem.dist=",findItem.type, findItem.dist)
    if (findItem.type == "airdrom") then
        --print("airdrom.roadnet, airdrom.ID=",airdrom.roadnet, airdrom.ID)
        return setAirGroupOnParking(group, airdrom, listP, true)
    elseif (findItem.type == "farp") then  
        return setAirGroupOnFarp(group, farp) 
    elseif (findItem.type == "GrassAirfield") then
        return setAirGroupOnGrassAirfield(group, grassAirfield)
    else
        return setAirGroupOnShip(group, ship, listPs)     
    end    
end


-------------------------------------------------------------------------------
--
function setAirGroupOnFarpRunway(group, farp)
	if (farp == nil) then
		--print("(airdrom == nil)")
		return false
	end

	Mission.unlinkSnap(group.route.points[1])
	Mission.unlinkWaypoint(group.route.points[1])
	Mission.linkWaypoint(group.route.points[1], farp.group, farp.unit)
	
	-- расставляем по стоянкам
	for k_u, unit in pairs(group.units) do
		unit.parking = nil
        unit.parking_landing = nil
        unit.parking_id = nil
        unit.parking_landing_id = nil
		unit.x 	     = farp.sx	
		unit.y 	     = farp.sy	
		unit.boss.route.points[1].helipadId 	    = farp.unit.unitId --farp.ID
		unit.boss.route.points[1].airdromeId 	    = nil
        unit.boss.route.points[1].grassAirfieldId   = nil
		
		if k_u == 1 then
			group.route.points[1].x = farp.sx
			group.route.points[1].y = farp.sy
		end
		if k_u ~= 1 then
			MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
		else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
			group.mapObjects.units[1].x = unit.x
			group.mapObjects.units[1].y = unit.y 
			MapWindow.move_waypoint(group, 1, unit.x, unit.y, nil, true, true);
			Mission.update_group_map_objects(group)					
		end;			
	end
	
	local listP = {}
	for i=1, 4 do
		base.table.insert(listP, {name = tostring(i), numParking = i, x = farp.unit.x, y = farp.unit.y})
	end
	
	setToParking(group, listP, nil, group.route.points[1].helipadId,  nil)
	
	return true, farp.ID
end


-------------------------------------------------------------------------------
--
function setAirGroupOnFarp(group, farp)
	if (farp == nil) then
		--print("(airdrom == nil)")
		return false
	end

	Mission.unlinkSnap(group.route.points[1])
	Mission.unlinkWaypoint(group.route.points[1])
	Mission.linkWaypoint(group.route.points[1], farp.group, farp.unit)
	
	-- расставляем по стоянкам
	for k_u, unit in pairs(group.units) do
		unit.parking = nil
        unit.parking_landing = nil
        unit.parking_id = nil
        unit.parking_landing_id = nil
		unit.x 	     = farp.sx	
		unit.y 	     = farp.sy	
		unit.boss.route.points[1].helipadId 	    = farp.unit.unitId --farp.ID
		unit.boss.route.points[1].airdromeId 	    = nil
        unit.boss.route.points[1].grassAirfieldId   = nil
		
		if k_u == 1 then
			group.route.points[1].x = farp.sx
			group.route.points[1].y = farp.sy
		end
		if k_u ~= 1 then
			MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
		else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
			group.mapObjects.units[1].x = unit.x
			group.mapObjects.units[1].y = unit.y 
			MapWindow.move_waypoint(group, 1, unit.x, unit.y, nil, true, true);
			Mission.update_group_map_objects(group)					
		end;			
	end
	
	local listP = {}
	for i=1, 4 do
		base.table.insert(listP, {name = tostring(i), numParking = i, x = farp.unit.x, y = farp.unit.y})
	end
	
	setToParking(group, listP, nil, group.route.points[1].helipadId,  nil)
		
	return true, farp.ID
end

-------------------------------------------------------------------------------
--
function setAirGroupOnGrassAirfieldRunway(group, grassAirfield)
	if (grassAirfield == nil) then
		--print("(airdrom == nil)")
		return false
	end

	Mission.unlinkSnap(group.route.points[1])
	Mission.unlinkWaypoint(group.route.points[1])
	Mission.linkWaypoint(group.route.points[1], grassAirfield.group, grassAirfield.unit)
	
	-- расставляем по стоянкам
	for k_u, unit in pairs(group.units) do
		unit.parking = nil
        unit.parking_landing = nil
        unit.parking_id = nil
        unit.parking_landing_id = nil
		unit.x 	     = grassAirfield.sx	
		unit.y 	     = grassAirfield.sy	
        unit.boss.route.points[1].grassAirfieldId   = grassAirfield.unit.unitId 
		unit.boss.route.points[1].helipadId 	    = nil
		unit.boss.route.points[1].airdromeId 	    = nil
		
		if k_u == 1 then
			group.route.points[1].x = grassAirfield.sx
			group.route.points[1].y = grassAirfield.sy
		end
		if k_u ~= 1 then
			MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
		else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
			group.mapObjects.units[1].x = unit.x
			group.mapObjects.units[1].y = unit.y 
			MapWindow.move_waypoint(group, 1, unit.x, unit.y, nil, true, true);
			Mission.update_group_map_objects(group)					
		end;			
	end
		
	return true, grassAirfield.ID
end

-------------------------------------------------------------------------------
--
function setAirGroupOnGrassAirfield(group, grassAirfield)
	if (grassAirfield == nil) then
		--print("(airdrom == nil)")
		return false
	end

	Mission.unlinkSnap(group.route.points[1])
	Mission.unlinkWaypoint(group.route.points[1])
	Mission.linkWaypoint(group.route.points[1], grassAirfield.group, grassAirfield.unit)
	
	-- расставляем по стоянкам
	for k_u, unit in pairs(group.units) do
		unit.parking = nil
        unit.parking_landing = nil
        unit.parking_id = nil
        unit.parking_landing_id = nil
		unit.x 	     = grassAirfield.sx	
		unit.y 	     = grassAirfield.sy	
        unit.boss.route.points[1].grassAirfieldId   = grassAirfield.unit.unitId 
		unit.boss.route.points[1].helipadId 	    = nil
		unit.boss.route.points[1].airdromeId 	    = nil
		
		if k_u == 1 then
			group.route.points[1].x = grassAirfield.sx
			group.route.points[1].y = grassAirfield.sy
		end
		if k_u ~= 1 then
			MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
		else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
			group.mapObjects.units[1].x = unit.x
			group.mapObjects.units[1].y = unit.y 
			MapWindow.move_waypoint(group, 1, unit.x, unit.y, nil, true, true);
			Mission.update_group_map_objects(group)					
		end;			
	end
		
	return true, grassAirfield.ID
end


-------------------------------------------------------------------------------
--
function setAirGroupOnShipRunway(group, ship, listP)
    if (ship == nil) then
		return false
	end
    
	Mission.unlinkSnap(group.route.points[1])
    Mission.unlinkWaypoint(group.route.points[1])
    Mission.linkWaypoint(group.route.points[1], ship.group, ship.unit)
    
    group.route.points[1].x = ship.sx
	group.route.points[1].y = ship.sy
    group.route.points[1].airdromeId        = nil
    group.route.points[1].grassAirfieldId   = nil
    group.route.points[1].helipadId         = ship.unit.unitId   --helipadId - не ошибка
    
    for k_u, unit in pairs(group.units) do
        unit.x 	     = ship.sx	
		unit.y 	     = ship.sy	
        unit.parking = nil
        unit.parking_landing = nil
        unit.parking_id = nil
        unit.parking_landing_id = nil
        
        if k_u == 1 then
			group.route.points[1].x = ship.sx
			group.route.points[1].y = ship.sy
		end
		if k_u ~= 1 then
			MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
		else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
			group.mapObjects.units[1].x = unit.x
			group.mapObjects.units[1].y = unit.y 
			MapWindow.move_waypoint(group, 1, unit.x, unit.y, nil, true, true);
			Mission.update_group_map_objects(group)					
		end;
    end    

	local unitDef = DB.unit_by_type[ship.unit.type]
	if unitDef.RunWays == nil then
		if unitDef.numParking then
			for i=1, unitDef.numParking do
				base.table.insert(listP, {name = tostring(i), numParking = i, x = ship.unit.x, y = ship.unit.y})
			end
		end	
	else
	
	end
	
	setToParking(group, listP, nil, group.route.points[1].helipadId,  nil)
	
    return true, ship.ID
end

-------------------------------------------------------------------------------
--
function setAirGroupOnShip(group, ship, listP)
    if (ship == nil) then
		return false
	end
    
	Mission.unlinkSnap(group.route.points[1])
    Mission.unlinkWaypoint(group.route.points[1])
    Mission.linkWaypoint(group.route.points[1], ship.group, ship.unit)
    
    group.route.points[1].x = ship.sx
	group.route.points[1].y = ship.sy
    group.route.points[1].airdromeId        = nil
    group.route.points[1].grassAirfieldId   = nil
    group.route.points[1].helipadId         = ship.unit.unitId   --helipadId - не ошибка
    
    for k_u, unit in pairs(group.units) do
        unit.x 	     = ship.sx	
		unit.y 	     = ship.sy	
        unit.parking = nil
        unit.parking_landing = nil
        unit.parking_id = nil
        unit.parking_landing_id = nil
        
        if k_u == 1 then
			group.route.points[1].x = ship.sx
			group.route.points[1].y = ship.sy
		end
		if k_u ~= 1 then
			MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
		else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
			group.mapObjects.units[1].x = unit.x
			group.mapObjects.units[1].y = unit.y 
			MapWindow.move_waypoint(group, 1, unit.x, unit.y, nil, true, true);
			Mission.update_group_map_objects(group)					
		end;
    end    
	
	

	local unitDef = DB.unit_by_type[ship.unit.type]
	if unitDef.RunWays == nil then
		local listP = {}
		if unitDef.numParking then
			for i=1, unitDef.numParking do
				base.table.insert(listP, {name = tostring(i), numParking = i, x = ship.unit.x, y = ship.unit.y})
			end
		end
	else

	end

	setToParking(group, listP, nil, group.route.points[1].helipadId,  nil)
	
    return true, ship.ID
end


-------------------------------------------------------------------------------
--
function resetAirGroupOnShip(a_group, a_ship)
	local listP ={}
	local unitDef = DB.unit_by_type[a_ship.type]	
	if unitDef.RunWays == nil then
		for i=1, unitDef.numParking do
			base.table.insert(listP, {name = tostring(i), numParking = i, x = a_ship.x, y = a_ship.y})
		end
	else
		listP = getStandListForShip(a_ship.x, a_ship.y, unitDef.RunWays)
	end	
	
	for k_u, unit in pairs(a_group.units) do
		if (unit.parking ~= nil) then
			local parking = listP[base.tonumber(unit.parking)]
			local offsetX = 0
			local offsetY = 0	
			local sinHdg = 0
			local cosHdg = 0
			if a_ship and a_ship.boss.type == "ship" then
				sinHdg = base.math.sin(a_ship.heading)
				cosHdg = base.math.cos(a_ship.heading)
			end
			if listP[base.tonumber(unit.parking)].offsetX then
				offsetX = (listP[base.tonumber(unit.parking)].offsetX or 0)*cosHdg - (listP[base.tonumber(unit.parking)].offsetY or 0)*sinHdg
				offsetY = (listP[base.tonumber(unit.parking)].offsetY or 0)*cosHdg + (listP[base.tonumber(unit.parking)].offsetX or 0)*sinHdg
			end		
				
			unit.x 	     = a_ship.x + offsetX	
			unit.y 	     = a_ship.y + offsetY	
			
			if k_u == 1 then
				a_group.route.points[1].x = unit.x
				a_group.route.points[1].y = unit.y
			end
			if k_u ~= 1 then
				MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
			else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
				a_group.mapObjects.units[1].x = unit.x
				a_group.mapObjects.units[1].y = unit.y 
				MapWindow.move_waypoint(a_group, 1, unit.x, unit.y, nil, true, true);								
			end						
		end
	end
	Mission.update_group_map_objects(a_group)
end

function fixParking(a_unit, a_airdromeId, key_type)
    local roadnet = DB.getRoadnetAirdrome(a_airdromeId)
    if roadnet then
        listP = getStandList(roadnet)
        
        local sortListP = {}
        for k, v in pairs(listP) do
            v.key = k
            v.name = v.name
            v.distToPlayer = DB.getDist(a_unit.x, a_unit.y, v.x, v.y)	
            base.table.insert(sortListP,v)       
        end  
       
        local function compDistPl(tab1, tab2)
            if (tab1.distToPlayer < tab2.distToPlayer) then
                return true
            end
            return false
        end
        
        table.sort(sortListP, compDistPl)
        
        if sortListP[1] then
            a_unit[key_type]    = sortListP[1].key
            a_unit[key_type.."_id"] = sortListP[1].name
            --base.print("---parking---",a_unit[key_type], a_unit[key_type.."_id"])
            return true
        end
    end
    return false
end

-------------------------------------------------------------------------------
--
function setAirGroupOnRunway(group, airdrom, listP)
	if (airdrom == nil) then
		return false
	end
	
	Mission.unlinkSnap(group.route.points[1])
	Mission.unlinkWaypoint(group.route.points[1])
	
	for k_u, unit in pairs(group.units) do
		unit.parking = nil
		unit.parking_landing = nil
		unit.parking_id = nil
		unit.parking_landing_id = nil
	end

		-- расставляем по взлетным полосам
	setToRunway(group, a_listP, airdrom.ID, airdrom.sx, airdrom.sy)
    
  --  перекрашиваем аэродром
	base.panel_route.changeAirdromeCoalition(airdrom.ID, group.boss.boss.name)
    
	--print("airdrom.roadnet, airdrom.ID=",airdrom.roadnet, airdrom.ID)
	return true, airdrom.ID

end

-------------------------------------------------------------------------------
--
function setAirGroupOnParking(group, airdrom, listP, reParking)
--print("setAirGroupOnParking(group, airdrom, listP)")

--U.traverseTable(listP,3)
	if (airdrom == nil) then
		--print("(airdrom == nil)")
		return false
	end

	Mission.unlinkSnap(group.route.points[1])
	Mission.unlinkWaypoint(group.route.points[1])
	
	if (reParking == true) then
		for k_u, unit in pairs(group.units) do
			unit.parking = nil
            unit.parking_landing = nil
            unit.parking_id = nil
            unit.parking_landing_id = nil
		end
	end
	
	-- расставляем по стоянкам
	setToParking(group, listP, airdrom.ID, nil, nil)
    
  --  перекрашиваем аэродром
	base.panel_route.changeAirdromeCoalition(airdrom.ID, group.boss.boss.name)
    
	--print("airdrom.roadnet, airdrom.ID=",airdrom.roadnet, airdrom.ID, group.boss.boss.name)
	return true, airdrom.ID
end

-------------------------------------------------------------------------------
--расставляем по стоянкам
function setToParking(group, a_listP, airdromeId, helipadId, grassAirfield)
    local listP = {}
    local x
    local y
    local firstUnit = group.units[1]
    if firstUnit and firstUnit.boss.route.points[1].airdromeId == (airdromeId or helipadId or grassAirfield)  then
        x = firstUnit.x
        y = firstUnit.y
    else 
        x = group.x
        y = group.y
    end
    
    for k, v in pairs(a_listP) do
        v.key = k
        v.distToPlayer = DB.getDist(x, y, v.x, v.y)	
        base.table.insert(listP,v)       
    end  
   
    local function compDistPl(tab1, tab2)
		if (tab1.distToPlayer < tab2.distToPlayer) then
			return true
		end
		return false
	end
    
    table.sort(listP, compDistPl)
	
	local unitHelipad = base.module_mission.unit_by_id[helipadId]

	local sinHdg = 0
	local cosHdg = 0
	if unitHelipad and unitHelipad.boss.type == "ship" then
		sinHdg = base.math.sin(unitHelipad.heading)
		cosHdg = base.math.cos(unitHelipad.heading)
	end
	
	local function parkingUnit(unit, indexUnit, a_parking)
	--print("unit.parking =",unit.parking,indexUnit, a_parking.name)
		if (unit.parking == nil) then
			unit.parking = base.tostring(a_parking.key)
			unit.parking_id = a_parking.name
			
			local offsetX = 0
			local offsetY = 0	
			if a_listP[base.tonumber(unit.parking)].offsetX then
				offsetX = (a_listP[base.tonumber(unit.parking)].offsetX or 0)*cosHdg - (a_listP[base.tonumber(unit.parking)].offsetY or 0)*sinHdg
				offsetY = (a_listP[base.tonumber(unit.parking)].offsetY or 0)*cosHdg + (a_listP[base.tonumber(unit.parking)].offsetX or 0)*sinHdg
			end		
			unit.x 	     = a_parking.x + offsetX	
			unit.y 	     = a_parking.y + offsetY
			unit.boss.route.points[1].airdromeId 	= airdromeId
			unit.boss.route.points[1].helipadId 	= helipadId
			unit.boss.route.points[1].grassAirfield = grassAirfield
			
			if indexUnit == 1 then
				group.route.points[1].x = a_listP[base.tonumber(unit.parking)].x + offsetX
				group.route.points[1].y = a_listP[base.tonumber(unit.parking)].y + offsetY
			end
			if indexUnit ~= 1 then
				MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
			else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
				group.mapObjects.units[1].x = unit.x
				group.mapObjects.units[1].y = unit.y 
				MapWindow.move_waypoint(group, 1, unit.x, unit.y, nil, true, true);
				Mission.update_group_map_objects(group)					
			end;			
			--print("unit,parking,x,y=", indexUnit, unit.parking, unit.x , unit.y)
			return true	
		else
			return false
		end
	end
	
	if #listP > 0 then
		local x
		local y 	
		if parkingUnit(group.units[1], 1, listP[1]) == true then
			x = listP[1].x
			y = listP[1].y		
			base.table.remove(listP,1)
		else
			x = group.units[1].x
			y = group.units[1].y
		end
		
		for k,v in base.pairs(listP) do
			v.distToPlayer = DB.getDist(x, y, v.x, v.y)	
		end
		
		table.sort(listP, compDistPl)
		
		local indexPark = 1
		
		if #listP > 0 then
			for k_u, unit in ipairs(group.units) do
				if k_u > 1 then
					if indexPark > #listP and airdromeId == nil then
						indexPark = 1
					end
					
					if parkingUnit(unit,k_u, listP[indexPark]) == true then
						indexPark = indexPark + 1
					end
				end
			end
		end	
	end	
end

function setToRunway(group, a_listP, airdromeId, a_x, a_y)

	for k_u, unit in ipairs(group.units) do
		unit.x 	     = a_x
		unit.y 	     = a_y	
		unit.boss.route.points[1].airdromeId 	= airdromeId
		unit.boss.route.points[1].helipadId 	= nil
		unit.boss.route.points[1].grassAirfield = nil
		
		if k_u == 1 then
			group.route.points[1].x = a_x
			group.route.points[1].y = a_y
		end
		if k_u ~= 1 then
			MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
		else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
			group.mapObjects.units[1].x = unit.x
			group.mapObjects.units[1].y = unit.y 
			MapWindow.move_waypoint(group, 1, unit.x, unit.y, nil, true, true);
			Mission.update_group_map_objects(group)					
		end;			

	end
end

-------------------------------------------------------------------------------
--
function resetAirGroupOnParking(group, roadnet)
--print("resetAirGroupOnParking(group, roadnet)")
	local listP ={}
	listP = getStandList(roadnet)
	
	for k_u, unit in pairs(group.units) do
		if (unit.parking ~= nil) then
			local parking = listP[base.tonumber(unit.parking)]
			unit.x 	     = parking.x	
			unit.y 	     = parking.y
			
			if k_u == 1 then
				group.route.points[1].x = listP[base.tonumber(unit.parking)].x
				group.route.points[1].y = listP[base.tonumber(unit.parking)].y
			end
			if k_u ~= 1 then
				MapWindow.move_unit(unit.boss, unit, unit.x, unit.y, false)
			else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
				group.mapObjects.units[1].x = unit.x
				group.mapObjects.units[1].y = unit.y 
				MapWindow.move_waypoint(group, 1, unit.x, unit.y, nil, true, true);							
			end		
			--print("unit,parking,x,y=", k_u, unit.parking, unit.x , unit.y)
			--break
		end
	end
	Mission.update_group_map_objects(group)		
end


-------------------------------------------------------------------------------
--
function findFarp(group, x, y)
	local farps = getFarps(group.boss.boss, x, y)
	if (farps == nil) then
		return false
	end
	
	local numUnit = #group.units

	local listPf ={}
	local farp = nil
	
	for k, v in pairs(farps) do
		listPf = {}
		for i = 1, v.numParking do
			base.table.insert(listPf,i)
		end

		local numlistP = 0
		for _,_ in pairs(listPf) do
			numlistP = numlistP + 1
		end

--  	на любой фарп любое число ЛА
--		if (numlistP >= numUnit) then
			farp = v
			break
--		end	
	end
	return farp, listPf
end

-------------------------------------------------------------------------------
--
function findGrassAirfield(group, x, y)
    local GrassAirfields = getGrassAirfields(group.boss.boss, x, y)
    	
    if (GrassAirfields == nil) then
		return false
	end
	
	local numUnit = #group.units

	local plane = DB.unit_by_type[group.units[1].type]

	local listPf ={}
	local grassAirfield = nil
	
	for k, v in pairs(GrassAirfields) do
		listPf = {1,2,3,4};

		local numlistP = 0
		for _,_ in pairs(listPf) do
			numlistP = numlistP + 1
		end

		if (numlistP >= numUnit) then
			grassAirfield = v
			break
		end
	end
    
	return grassAirfield, listPf
end

-------------------------------------------------------------------------------
--
function findShip(group, x, y)
    local ships = getShip(group, x, y)
    
    if (ships == nil) then
		return false
	end
	
	local numUnit = #group.units	
	local listP ={}
	local ship = nil
	
	for k,v in base.ipairs(ships) do
		if v.RunWays then
			listP = getStandListForShip(v.sx, v.sy, v.RunWays)

			listP = getKeepParkingShip(v.ID, listP, group.units[1], false, true)

		--	listP = getRightParkingAirport(listP, group)
			--U.traverseTable(listP) 
			--print("================+++++")
			
			local numlistP = 0
			for _,_ in pairs(listP) do
				numlistP = numlistP + 1
			end
			--U.traverseTable(listP,1)
			--print("====numlistP=",numlistP)
		--	if (numlistP >= numUnit) then --  	на любой фарп любое число ЛА
				return v, listP
		--	end
		--------------------------------
		else
		--	if v.numParking >= #group.units then --  	на любой фарп любое число ЛА
				return v, listP
			--end
		end
	end

    return false, listP
end


-------------------------------------------------------------------------------
--
function getGrassAirfields(a_coalition,x,y)
    local grassAirfieldsList = {}
    for j,u in pairs(a_coalition.country) do			
        if (u.static)  then
            for num, st in pairs(u.static.group) do	
                --U.traverseTable(st.units[1],2)
                base.print("---st.units[1].type---",st.units[1].type,st.units[1].type == "GrassAirfield")
                if (st.units) and (st.units[1]) and (st.units[1].type == "GrassAirfield") then
                    --U.traverseTable(grassAirfieldsList)
                    local farp = 
                    {
                        sx = st.units[1].x,
                        sy = st.units[1].y,
                        ID = st.groupId,
                        dist = DB.getDist(x, y, st.units[1].x, st.units[1].y),
                        group = st,
                        unit = st.units[1],
                    }
                    table.insert(grassAirfieldsList,farp)
                end
            end
        end
    end

	
	local function compDist(tab1, tab2)
		if (tab1.dist < tab2.dist) then
			return true
		end
		return false
	end
	
	table.sort(grassAirfieldsList, compDist)
	
	return grassAirfieldsList;
end


-------------------------------------------------------------------------------
--
function getFarps(a_coalition,x,y)
	local farpList = {}
    for j,u in pairs(a_coalition.country) do			
        if (u.static)  then
            for num, st in pairs(u.static.group) do	
                --U.traverseTable(st.units[1],2)
				for k,unit in base.pairs(st.units) do
					if DB.isFARP(unit.type) then
						--U.traverseTable(farpList)
						local unitDef = DB.unit_by_type[unit.type]		
						local farp = 
						{
							sx = unit.x,
							sy = unit.y,
							ID = st.groupId,
							numParking = unitDef.numParking,
							dist = DB.getDist(x, y, unit.x, unit.y),
							group = st,
							unit = unit,
						}
						table.insert(farpList,farp)
					end
				end
            end
        end
    end

	
	local function compDist(tab1, tab2)
		if (tab1.dist < tab2.dist) then
			return true
		end
		return false
	end
	
	table.sort(farpList, compDist)
	
	--U.traverseTable(farpList)
	return farpList;
end

-------------------------------------------------------------------------------
--
function getShip(a_group, a_x, a_y)
    local coalition = a_group.boss.boss
	local shipList = {}
    local wptType	  = base.panel_route.actions.takeoffParking
    local allowedCats = DB.getLandCategories(base.panel_route.getWptType(wptType),a_group.units[1].type)

    for j,u in pairs(coalition.country) do			
        if (u.ship)  then                    
            for num, st in pairs(u.ship.group) do	
                for _tmp, u in pairs(st.units) do
                    if DB.isShipSuitable(u, allowedCats) then
                        --U.traverseTable(shipList)
						local unitDef = DB.unit_by_type[u.type]	

                        local ship = 
                        {
                            sx 			= u.x,
                            sy 			= u.y,
                            ID 			= st.groupId,
                            dist 		= DB.getDist(a_x, a_y, u.x, u.y),
                            group 		= st,
                            unit 		= u,
							numParking 		= unitDef.numParking or 0,
							RunWays 		= unitDef.RunWays,
							TaxiForTORoutes	= unitDef.TaxiForTORoutes,
							unitId		= u.unitId,
                        }
                        table.insert(shipList,ship)
                    end
                end
            end
        end
    end

	
	local function compDist(tab1, tab2)
		if (tab1.dist < tab2.dist) then
			return true
		end
		return false
	end
	
	table.sort(shipList, compDist)
	
	--U.traverseTable(shipList)
	return shipList;
end

-------------------------------------------------------------------------------
--
function findAirport(group, x, y, noRightParking)
	local airdromes = DB.getNearestAirdromes(x,y)
	
	if (airdromes == nil) then
		--print("(airdromes == nil)")
		return false
	end
	
	if noRightParking == true then
		return airdromes[1]
	end
	
	local numUnit = #group.units
	--print("==========numUnit=",numUnit)
	--U.traverseTable(group , 3)
	local plane = DB.unit_by_type[group.units[1].type]
	--U.traverseTable(plane , 3)
	local listP ={}
	local airdrom = nil
	
	for k, v in pairs(airdromes) do
		listP = getStandList(v.roadnet)
		--U.traverseTable(listP)  
		--print("==================================================",v.roadnet)
		listP = getKeepParkingAirport(v.ID, listP, group.units[1], false, true)
		--U.traverseTable(listP,2)
        --print("================+++++")
		listP = getRightParkingAirport(listP, group)
		--U.traverseTable(listP,2)
		local numlistP = 0
		for _,_ in pairs(listP) do
			numlistP = numlistP + 1
		end
		--U.traverseTable(listP,1)
		--print("====numlistP=",numlistP)
		if (numlistP >= numUnit) then
			airdrom = v
			break
		end
	end
	return airdrom, listP
end
