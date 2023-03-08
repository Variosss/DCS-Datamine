local base = _G
local DB = require('me_db_api')
local localizationMG = require('me_localizationMG')
--local loadLiveries = require('loadLiveries')
--local loadout = require('me_loadout')
--local loadoutUtils = require('me_loadoututils')
--[[
local squadrons = {}
local freeCallsigns = {}

local function getFreeCalsign(country, unitType)
	if freeCallsigns[country] == nil then freeCallsigns[country] = {} end
	if freeCallsigns[country][unitType] == nil or #freeCallsigns[country][unitType] == 0 then 
		local allCallsigns = DB.db.getUnitCallnames(DB.country_by_OldID[country].WorldID, DB.unit_by_type[unitType].attribute)
		local callsignsData = {}
		for i, v in ipairs(allCallsigns) do
			table.insert(callsignsData, {index = i, name = v.Name})
		end
		if #callsignsData == 0 then print('helpers:: no callsigns for '..country..', '..unitType) return 0, "" end
		
		freeCallsigns[country][unitType] = callsignsData
	end
	
	local callsigns = freeCallsigns[country][unitType]
	local callsign = table.remove(callsigns, math.random(#callsigns))
	return callsign.index, callsign.name
end

local function getSquadron(country, unitType)
	if squadrons[country] == nil then squadrons[country] = {} end
	if squadrons[country][unitType] == nil then 
		local squadron = 
		{
			callsignIndex = 0,
			callsign = "",
			groups = {},
			lastGroupIndex = 0,
		}
		squadron.callsignIndex, squadron.callsign = getFreeCalsign(country, unitType)
		
		squadrons[country][unitType] = squadron
	end
	return squadrons[country][unitType]
end

function getYearsAircraft(type,country)
	--local startDate, endDate = getYearsLocal(type,country)
	return getYearsLocal(type,country)
end

function getTypeCallsign(country)   
    if DB.db.isWesternCallnames(country) then
        return 1
    else
        return 2
    end
end

function getCallsign(country, unitType, groupId)
	local squadron = getSquadron(country, unitType)
	if squadron.groups[groupId] == nil then
		squadron.lastGroupIndex = squadron.lastGroupIndex + 1
		squadron.groups[groupId] = {unitIndex = 0, groupIndex = squadron.lastGroupIndex}
	end
	
	local groupData = squadron.groups[groupId]
	groupData.unitIndex = groupData.unitIndex + 1
	
	return squadron.callsign..groupData.groupIndex..groupData.unitIndex, squadron.callsignIndex, groupData.groupIndex, groupData.unitIndex
end

local availableJTACCallsigns = {}
local jtacFrequency = 29000000
function getJTACCallsign()
	if #availableJTACCallsigns == 0 then
		local callsigns = DB.db.getCallnames(country.USA, 'Ground Units')
		for i, v in ipairs(callsigns) do
			table.insert(availableJTACCallsigns, {i, v.Name})
		end
	end
	
	if #availableJTACCallsigns == 0 then return 0, '', 0 end
	local callsignData = table.remove(availableJTACCallsigns, math.random(#availableJTACCallsigns))
	jtacFrequency = jtacFrequency + 1000000

	return callsignData[1], callsignData[2], jtacFrequency
end
--]]


--[[
function getFrequency(unitType, isHuman)
	local unitTypeDesc = DB.unit_by_type[unitType]
	return DB.getDefaultRadioFor(unitTypeDesc, isHuman)
end

--TODO заранее закешировать раскраски
function getLivery(unitType, countryOldName)
    local country 		= DB.getCountryByOldID(countryOldName)
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

function getPayloadsUseTask(unitType,taskWorldID)
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

function getPayloadsUseDefaultTask(unitType)
	local unitTypeDesc = DB.unit_by_type[unitType]
	if unitTypeDesc then
		return getPayloadsUseTask(unitType,unitTypeDesc.DefaultTask.WorldID)
	else
		local mgPayloads = {}
		return mgPayloads
	end
end

function getDefaultPayloads(unitType)
	local allPayloads = loadout.getUnitsPayload()
	local unitTaskPayloads = unitTypeDesc and allPayloads 
							and allPayloads[unitType] and allPayloads[unitType]["tasks"]
							and allPayloads[unitType]["tasks"][unitTypeDesc.DefaultTask.WorldID] or nil
	local mgPayloads = {}
	if unitTaskPayloads ~= nil then
		local ind = math.random(#unitTaskPayloads)
		local payloads = unitTaskPayloads[ind]
		for i,v in ipairs(payloads.pylons) do
			mgPayloads[v.num] = v.launcherCLSID
		end
	end
	return mgPayloads
end

function getDefaultRadio(a_type)
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

function isFighterPlane(unitType)
	local unitTypeDesc = DB.unit_by_type[unitType]
	return unitTypeDesc and unitTypeDesc.attribute[3] == wsType_Fighter
end
]]
--[[
function hasUnitAttribute(unitType, attr)
	local unitTypeDesc = DB.unit_by_type[unitType]
	if unitTypeDesc and unitTypeDesc.attribute and unitTypeDesc.attribute[5] then
		if unitTypeDesc.attribute[5] == attr then
			return true
		end
		if unitTypeDesc.attribute[6] and unitTypeDesc.attribute[6] == attr then
			return true
		end
	end
	return false
end

function getListTypeUnits(wsTypeUnit)
	local list_units = {}
	for k, unitTypeDesc in pairs(DB.unit_by_type) do
		--if  unitTypeDesc.attribute[3] == wsType_Fighter then
		if unitTypeDesc and unitTypeDesc.attribute and unitTypeDesc.attribute[3] and unitTypeDesc.attribute[3] == wsTypeUnit then
			table.insert(list_units,k)
		end
	end
	return list_units
end

function getTerrainPathByName(strName)
	return base.getTerrainConfigPath(strName)
end

function getDisplayName(unitType)    
	local unitTypeDesc = DB.unit_by_type[unitType]
	return unitTypeDesc.DisplayName
end
]]
-------------------------------------------------------
-- ME
-------------------------------------------------------
function getLocalizedStrings()
	return localizationMG.getLocalizedStrings()
end

function isTestLocalizationMG()
	return localizationMG.isTestLocalizationMG()
end

function addTexts(a_text1, a_text2, a_text3, a_text4)
	return localizationMG.addTexts(a_text1, a_text2, a_text3, a_text4)
end

function getDicts()
	return localizationMG.getDicts()
end
-------------------------------------------------------