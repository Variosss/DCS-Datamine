--[[
local my_base = _G

guiBindPath = './dxgui/bind/?.lua;' .. 
              './dxgui/loader/?.lua;' ..
              './dxgui/skins/skinME/?.lua;' .. 
              './dxgui/skins/common/?.lua;'
package.path = 
	''
	.. guiBindPath
	.. './MissionEditor/?.lua;'
	.. './MissionEditor/modules/?.lua;'
	.. './Scripts/?.lua;'
	--]]
local base = _G
local DB = base.require('me_db_api')
--local loadout = require('me_loadout')
--local loadoutUtils = base.require('me_loadoututils')
--local loadLiveries = my_base.require('loadLiveries')

function getCountriesTable()
    local countries = {}
    for i, country in ipairs(DB.db.Countries) do
        table.insert(countries, {name = country.OldID, id = country.WorldID})
    end
    return countries
end

--function getLiveriesTable()
--    local liveriesByUnit = {}
--    fillDefaultLiveries("planes", liveriesByUnit)
--    fillDefaultLiveries("helicopters", liveriesByUnit)
--    return liveriesByUnit
--end

function getPylonsEnumeration(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.pylons_enumeration then
		return unitTypeDesc.pylons_enumeration
	end
	return 0
end


function getTypeUnitsLevel1(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.attribute and unitTypeDesc.attribute[1] then
		return unitTypeDesc.attribute[1]
	end
	return 0
end

function getAttributes(unitName)
	local result = {}
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.attribute then
		result = unitTypeDesc.attribute
	end
	return result;
end

function getTypeUnitsLevel2(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.attribute and unitTypeDesc.attribute[2] then
		return unitTypeDesc.attribute[2]
	end
	return 0
end

function getTypeUnitsLevel3(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.attribute and unitTypeDesc.attribute[3] then
		return unitTypeDesc.attribute[3]
	end
	return 0
end

function getTypeUnitsLevel4(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.attribute and unitTypeDesc.attribute[4] then
		return unitTypeDesc.attribute[4]
	end
	return 0
end

function getCountryOfOrigin(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.country_of_origin then
		return unitTypeDesc.country_of_origin
	end
	return ""
end

function getSingleInFlight(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.singleInFlight then
		return unitTypeDesc.singleInFlight
	end
	return 0
end

function getMobile(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.mobile then
		return unitTypeDesc.mobile
	end
	return false
end

function getCategory(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.category then
		return unitTypeDesc.category
	end
	return ""
end

function getArdDistanceMin(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.ThreatRangeMin then
		return unitTypeDesc.ThreatRangeMin
	end
	return 0
end
function getArdDistanceMax(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.ThreatRange then
		return unitTypeDesc.ThreatRange
	end
	return 0
end

function getPayloadsUseTaskDB(unitType,taskWorldID)
	local pylons = {}
	local payloads = loadoutUtils.getUnitPayloads(unitType)
	for i, payload in pairs(payloads) do
		local taskIds = payload.tasks		
		for j, tasksId in pairs(taskIds) do
			if taskWorldID == tasksId then
				pylons = {}
				for j, pylon in pairs(payload.pylons) do
					pylons[pylon.num] = pylon.CLSID
				end
				break
			end
		end
	end

	return pylons
end

function getTasksTable(unitName)
    local tasks = {}
	local utasks = {}
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.Tasks then
		for i, task in pairs(unitTypeDesc.Tasks) do
			utasks = task
			--utasks.payloads = getPayloadsUseTaskDB(unitName,task.WorldID)
			table.insert(tasks, utasks)
		end
	end
    return tasks
end

function getPylonsTable(unitName)
	local pylons = {}
	local unitTypeDesc = DB.unit_by_type[unitName]
	for i, pylon in pairs(unitTypeDesc.Pylons) do
		table.insert(pylons, pylon)
	end
	return pylons
end

function getDefaultTaskID(unitName)
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.DefaultTask and unitTypeDesc.DefaultTask.WorldID >= 0 then
		return unitTypeDesc.DefaultTask.WorldID
	end
	return -1
end

function getFrequencyDB(unitType, isHuman)
	local unitTypeDesc = DB.unit_by_type[unitType]
	return DB.getDefaultRadioFor(unitTypeDesc, isHuman)
end

function getDefaultRadioDB(a_type)
    local unitTypeDesc = DB.unit_by_type[a_type]
    local Radio = {}
    
    if (unitTypeDesc.panelRadio ~= nil) then
        for k, radio in ipairs(unitTypeDesc.panelRadio) do
            Radio[k] = {}
            Radio[k].channels = {}
            if radio.channels then
                for kk, channel in ipairs(radio.channels) do
                    Radio[k].channels[kk] = channel.default
                end
            end
        end
    end 
    return Radio
end
--[[
function getLiveryDB(unitType, countryOldName)
    local country 		= DB.getCountryByOldID(countryOldName)
	if country == nil then
		return ""
	end
	local unitTypeDesc  = DB.unit_by_type[unitType]
	
	local liveryEntry = unitType
	if  unitTypeDesc and unitTypeDesc.livery_entry then 
		liveryEntry = unitTypeDesc.livery_entry
	end

	local schemes = loadLiveries.loadSchemes(liveryEntry,country.ShortName)
    if #schemes > 0 then
        return schemes[math.random(#schemes)].itemId
    end
    return ""
end
--]]
function getLiveryEntryDB(unitType)
	local livery_entry = ""
	local unitTypeDesc  = DB.unit_by_type[unitType]
	if  unitTypeDesc and unitTypeDesc.livery_entry then
		livery_entry =  unitTypeDesc.livery_entry
	end
	return livery_entry
end

function fillAircraftsData(unitsType, result)
    local subtable1, subtable2
    if (unitsType == "planes") then
        subtable1 = "Planes"
        subtable2 = "Plane"
    else
        subtable1 = "Helicopters"
        subtable2 = "Helicopter"
    end        
    
    for i, unit in ipairs(DB.db.Units[subtable1][subtable2]) do
		local ChaffDefault = 0
		local FlareDefault = 0
		local TypeUnit3 = 0
		local TypeUnit2 = 0
		local TypeUnit1 = 0

		if unit.passivCounterm ~= nil then
			ChaffDefault = unit.passivCounterm.chaff.default
			FlareDefault = unit.passivCounterm.flare.default
		end
		
		TypeUnit3 = getTypeUnitsLevel3(unit.type)
		TypeUnit2 = getTypeUnitsLevel2(unit.type)
		TypeUnit1 = getTypeUnitsLevel1(unit.type)
		local cof = getCountryOfOrigin(unit.type)
		local sif = getSingleInFlight(unit.type)

		local unitData = 
		{
			fuel = 0.8*tonumber(unit.MaxFuelWeight),
			chaff = ChaffDefault, 
			flare = FlareDefault,
			wTypeUnit1 = TypeUnit1,
			wTypeUnit2 = TypeUnit2,
			wTypeUnit3 = TypeUnit3,
			country_of_origin = cof,
			sName = unit.type,
			singleInFlight = sif,
			countries = {},
			tasks = getTasksTable(unit.type),
			pylons = getPylonsTable(unit.type),
			pylons_enumeration = getPylonsEnumeration(unit.type),
			attributes = getAttributes(unit.type),
			defTaskId = getDefaultTaskID(unit.type),
			dFrequency = getFrequencyDB(unit.type, false),
			dFrequencyIsHuman = getFrequencyDB(unit.type, true),
			radio = getDefaultRadioDB(unit.type),
			livery_entry = getLiveryEntryDB(unit.type),
		}
		
		--TODO почему unit.Name - локализовано?
		--откуда взялся unit.type
		result[unit.type] = unitData
	end
	
	for i, country in ipairs(DB.db.Countries) do
        for j, unit in ipairs(country.Units[subtable1][subtable2]) do
            if result[unit.Name] ~= nil then
				local nStart, nEnd = getYearsLocal( unit.Name, country.OldID)
				result[unit.Name].countries[country.OldID] = {}
				result[unit.Name].countries[country.OldID].nDateStart = nStart
				result[unit.Name].countries[country.OldID].nDateEnd = nEnd
				result[unit.Name].countries[country.OldID].sName = country.OldID
				result[unit.Name].countries[country.OldID].WorldID = country.WorldID
				local countryDB = DB.getCountryByOldID(country.OldID)
				if countryDB and countryDB.ShortName then
					result[unit.Name].countries[country.OldID].ShortName = country.ShortName
				end
				--result[unit.Name].countries[country.OldID].liveryId =  getLiveryDB(unit.Name, country.OldID)
            end
        end
    end
    
end

function getAircraftsData()
	local result = {}
    fillAircraftsData("planes", result)
    fillAircraftsData("helicopters", result)
	return result
end

function getChassis(unitName)
	local result = {}
	local unitTypeDesc = DB.unit_by_type[unitName]
	if unitTypeDesc and unitTypeDesc.chassis then
		result = unitTypeDesc.chassis
	end
	return result;
end

function getVehiclesData()
    local result = {}
	for i, country in ipairs(DB.db.Countries) do
        for j, unit in ipairs(country.Units.Cars.Car) do
			local unitData = result[unit.Name]
			if unitData == nil then 
				unitData = {
					countries = {},
					wType1 = getTypeUnitsLevel1(unit.Name),
					wType2 = getTypeUnitsLevel2(unit.Name),
					wType3 = getTypeUnitsLevel3(unit.Name),
					wType4 = getTypeUnitsLevel4(unit.Name),
					country_of_origin = getCountryOfOrigin(unit.Name),
					attributes = getAttributes(unit.Name),
					tasks = getTasksTable(unit.Name),
					mobile = getMobile(unit.Name),
					category = getCategory(unit.Name),
					threatRangeMin = getArdDistanceMin(unit.Name),
					threatRangeMax = getArdDistanceMax(unit.Name),
					chassis = getChassis(unit.Name),
				} 

				result[unit.Name] = unitData
			end
			--table.insert(unitData.countries, country.OldID)
			local nStart, nEnd = getYearsLocal( unit.Name, country.OldID)
			result[unit.Name].countries[country.OldID] = {}
			result[unit.Name].countries[country.OldID].nDateStart = nStart
			result[unit.Name].countries[country.OldID].nDateEnd = nEnd
			result[unit.Name].countries[country.OldID].sName = country.OldID
			result[unit.Name].countries[country.OldID].WorldID = country.WorldID
        end
    end
	return result
end

function getShipsData()
    local result = {}
	for i, country in ipairs(DB.db.Countries) do
        for j, unit in ipairs(country.Units.Ships.Ship) do
			local unitData = result[unit.Name]
			local TypeUnit1 = getTypeUnitsLevel1(unit.Name)
			local TypeUnit2 = getTypeUnitsLevel2(unit.Name)
			local TypeUnit3 = getTypeUnitsLevel3(unit.Name)
			local TypeUnit4 = getTypeUnitsLevel4(unit.Name)
			local cof = getCountryOfOrigin(unit.Name)
			local nStart, nEnd = getYearsLocal( unit.Name, country.OldID)
			if unitData == nil then 
				unitData = {
					countries = {},
					wType1 = TypeUnit1,
					wType2 = TypeUnit2,
					wType3 = TypeUnit3,
					wType4 = TypeUnit4,
					country_of_origin = cof,
					attributes = getAttributes(unit.Name),
					tasks = getTasksTable(unit.Name),
					category = getCategory(unit.Name),
					threatRangeMin = getArdDistanceMin(unit.Name),
					threatRangeMax = getArdDistanceMax(unit.Name),
				} 
				result[unit.Name] = unitData
			end
			result[unit.Name].countries[country.OldID] = {}
			result[unit.Name].countries[country.OldID].nDateStart = nStart
			result[unit.Name].countries[country.OldID].nDateEnd = nEnd
			result[unit.Name].countries[country.OldID].sName = country.OldID
			result[unit.Name].countries[country.OldID].WorldID = country.WorldID
        end
    end
	return result
end

countriesData = getCountriesTable()
aircraftsData = getAircraftsData()
vehiclesData = getVehiclesData()
shipsData = getShipsData()