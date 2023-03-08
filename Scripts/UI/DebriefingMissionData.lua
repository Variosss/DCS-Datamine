local base = _G

module('DebriefingMissionData', package.seeall)

local DebriefingEventsData = require('DebriefingEventsData')
local i18n = require('i18n')

i18n.setup(_M)

local unitsDatabase_ = {}
local coalitionsStatistic_
local unitsInfoById_
local unitNamesById_
local buildingLocalized_ = _('Building')
local missionName_
local missionStartTime_
local playerUnit_
local playerScore_ = 0
local losses_
local playerVictories_
local deadUnitIds_
local dataChangeListener_
local localize_
local KeyToValue_

function setLocalizeFunc(localizeFunc)
	localize_ = localizeFunc
end

function setUnitsDatabase(unitsDatabase)
	unitsDatabase_ = unitsDatabase
end

function setGetCountryShortName(a_getCountryShortName)
    getCountryShortName = a_getCountryShortName
end

KeyToValue_ = function(a_data)
                        return a_data
                    end
                        

function setKeyToValueFunction(a_KeyToValue)
    KeyToValue_ = a_KeyToValue
end

-- этот объект будет оповещен при изменении полей:
-- local playerUnit_
-- local playerScore_ = 0
-- local losses_
-- local playerVictories_
function setDataChangeListener(dataChangeListener)
	dataChangeListener_ = dataChangeListener
end

function setMissionString(missionString)
	local fun, err = loadstring(missionString)
	
	if fun then 
		local env = { }
		
		setfenv(fun, env)
		
		fun()
		
		setMissionData(env.mission)		
	else
		print("Debriefing loading mission error:", err)
	end
end

local function createCoalitionStatistic_()
	return {
		planeCount = 0,
		helicopterCount = 0,
		shipCount = 0,
		airDefenceCount = 0,
		vehicleCount = 0,
		staticCount = 0,
	}
end

local function createCoalitionsStatistic_()	
	return {
		red = createCoalitionStatistic_(),
		blue = createCoalitionStatistic_(),
	}
end

local function createPlayerUnit_()
	return {
		name = '',
        type = {},
		callsign = '',
		task = {},
		country = {},
		coalition = '',
		unitId = '',
	}
end

local function reset_()
	coalitionsStatistic_ = createCoalitionsStatistic_()
	unitsInfoById_ = {}
	unitNamesById_ = {}
	playerUnit_ = createPlayerUnit_()
	playerScore_ = 0
	losses_ = createCoalitionsStatistic_()
	playerVictories_ = createCoalitionsStatistic_()
	deadUnitIds_ = {}
	DebriefingEventsData.resetPlayerDeathTime()
	
	if dataChangeListener_ then
		dataChangeListener_:onPlayerUnitChange()
		dataChangeListener_:onPlayerScoreChange()
		dataChangeListener_:onLossesChange()
		dataChangeListener_:onPlayerVictoriesChange(getRedCoalitionPlayerVictories(), getBlueCoalitionPlayerVictories())
	end
end

local airDefenseMissionUnits_ = {}

local function getMissionUnitIsAirDefence_(missionUnitType)
	local result = airDefenseMissionUnits_[missionUnitType]
	
	if nil == result then
		result = false
		
		local dbUnit = unitsDatabase_[missionUnitType]
		
		if dbUnit then 			
			local attributes = dbUnit.attribute
			
			if attributes then 
				for i, attribute in pairs(attributes) do
					if attribute == "SAM" or
					   attribute == "Radar" or
					   attribute == "Anti Aircraft Artillery" then
					   
					   result = true
					   break
					end
				end		
			else
				print("Invalid unit attributes " .. missionUnitType) 
			end
		end
		
		airDefenseMissionUnits_[missionUnitType] = result
	end

	return result
end

local function updateCoalitionStatistic_(groupUnits, unitCategoryName, coalitionStatistic)
	local coalitionStatisticKey = unitCategoryName .. 'Count'
	
	if unitCategoryName == 'vehicle' then
		for i, groupUnit in ipairs(groupUnits) do
			if getMissionUnitIsAirDefence_(groupUnit.type) then
				coalitionStatistic.airDefenceCount = coalitionStatistic.airDefenceCount + 1
			else
				coalitionStatistic[coalitionStatisticKey] = coalitionStatistic[coalitionStatisticKey] + 1
			end
		end
	else
		coalitionStatistic[coalitionStatisticKey] = coalitionStatistic[coalitionStatisticKey] + #groupUnits
	end
end

local function updateUnitsInfoById_(group, unitCategoryName, countryShortName, coalitionName)
	--составляем таблицу для юнитов из миссии
	for i, groupUnit in ipairs(group.units) do
		local unitInfoFailures = {}
		local unitInfo = {
			name = KeyToValue_(groupUnit.name),
			type = groupUnit.type,
            unitId = tostring(groupUnit.unitId),
			category = unitCategoryName,
			country = countryShortName, --localize_(countryName),
			coalition = coalitionName,
			task = localize_(group.task),
			failures = unitInfoFailures,
			callsign = groupUnit.callsign,
			rate = 0,
		}
		
		local dbUnit = unitsDatabase_[groupUnit.type]
		
		if dbUnit then
			unitInfo.localizedType = dbUnit.DisplayName
			unitInfo.rate = dbUnit.Rate or 0
			
			local dbUnitFailures = dbUnit.Failures
			
			if dbUnitFailures then
				for i, failure in ipairs(dbUnitFailures) do
					unitInfoFailures[failure.id] = failure.label
				end
			end
		end

		unitsInfoById_[tostring(groupUnit.unitId)] = unitInfo
	end
end

local function getUnitInfo_(unitId)
	if unitId then
		return unitsInfoById_[unitId]
	end
end

function getUnitName(unitId)
	if unitId then
		local name = unitNamesById_[unitId]
		
		if not name then
			local unitInfo = getUnitInfo_(unitId)
			
			if unitInfo then
				local unitName = unitInfo.name
				
				if unitName then
					local unitType = unitInfo.type
					local unitLocalizedType = unitInfo.localizedType
					
					if unitLocalizedType then
						name = unitName .. " (" .. unitLocalizedType .. ")"
					elseif unitType then
						name = unitName .. " (" .. unitType .. ")"
					elseif unitName == 'Building' then 
						name = buildingLocalized_
					else
						name = unitId
					end
				end
			else
				name = unitId
			end
			
			unitNamesById_[unitId] = name
		end

		return name
	end
end

function getUnitCoalitionName(unitId)
	local unitInfo = getUnitInfo_(unitId)
	
	if unitInfo then
		return unitInfo.coalition
	end
end

function getUnitCountryName(unitId)
	local unitInfo = getUnitInfo_(unitId)
	
	if unitInfo then
		return unitInfo.country
	end
end

function setMissionData(missionData)
	reset_()

	local unitCategoryNames = {
		'plane',
		'helicopter',
		'ship',
		'vehicle',
		'static',
	}
	
	local missionCoalitions = missionData.coalition
	if missionCoalitions then
		for coalitionName, coalitionStatistic in pairs(coalitionsStatistic_) do
			local coalition = missionCoalitions[coalitionName]
			if coalition then
				for i, country in ipairs(coalition.country) do
					for i, unitCategoryName in ipairs(unitCategoryNames) do
						local countryUnits = country[unitCategoryName]
						
						if countryUnits then
							local countryUnitsGroups = countryUnits.group
							
							if countryUnitsGroups then
								local countryShortName =   country.name
								if getCountryShortName then                    
									countryShortName = getCountryShortName(country.id)
								end
								
								for i, group in ipairs(countryUnitsGroups) do 							
									updateCoalitionStatistic_(group.units, unitCategoryName, coalitionStatistic)
									updateUnitsInfoById_(group, unitCategoryName, countryShortName, coalitionName)
								end
							end
						end
					end
				end
			end
		end	
	end
	
	missionName_ = KeyToValue_(missionData.sortie)
	missionStartTime_ = missionData.start_time
	
	if dataChangeListener_ then
		dataChangeListener_:onMissionDataChange()
	end
end

local function getCoalitionStatistic_(coalitionsStatistic)
	local statistic = createCoalitionStatistic_()
	
	for key, value in pairs(coalitionsStatistic) do
		statistic[key] = value
	end
	
	return statistic
end

function getRedCoalitionStatistic()
	return getCoalitionStatistic_(coalitionsStatistic_.red)
end

function getBlueCoalitionStatistic()
	return getCoalitionStatistic_(coalitionsStatistic_.blue)
end

function getRedCoalitionLosses()
	return getCoalitionStatistic_(losses_.red)
end

function getBlueCoalitionLosses()
	return getCoalitionStatistic_(losses_.blue)
end

function getRedCoalitionPlayerVictories()
	return getCoalitionStatistic_(playerVictories_.red)
end

function getBlueCoalitionPlayerVictories()
	return getCoalitionStatistic_(playerVictories_.blue)
end

function getMissionName()
	return missionName_
end

function getMissionStartTime()
	return missionStartTime_
end

local function replacePlayerUnit_(unitInfo, playerId)
	playerUnit_.name			= unitInfo.name -- имя юнита из миссии
	playerUnit_.coalition		= unitInfo.coalition
	playerUnit_.unitId 			= playerId   
    
    playerUnit_.type                        = {}
    playerUnit_.type[unitInfo.type]         = unitInfo.localizedType --localize_(unitInfo.type)
    
    playerUnit_.task                        = {}
    playerUnit_.task[unitInfo.task]         = localize_(unitInfo.task)
    
    playerUnit_.country                     = {}
    playerUnit_.country[unitInfo.country]   = localize_(unitInfo.country)
end

local function supplementPlayerUnit_(unitInfo, playerId)
	playerUnit_.name			= unitInfo.name -- имя юнита из миссии
	playerUnit_.coalition		= string.format('%s, %s', playerUnit_.coalition, unitInfo.coalition or '')
	playerUnit_.unitId 			= playerId
	playerUnit_.lastCoalition	= unitInfo.coalition or ''
    
    playerUnit_.type[unitInfo.type] = unitInfo.localizedType--localize_(unitInfo.type)
    playerUnit_.country[unitInfo.country] = localize_(unitInfo.country)
    playerUnit_.task[unitInfo.task] = localize_(unitInfo.task)
end

-- только для МАК
function getPlayerUnitCoalition()
	return playerUnit_.lastCoalition
end

local function changePlayerUnit_(unitInfo, playerId)
	local playerUnitType = playerUnit_.type
	
	if '' == playerUnitType then
		replacePlayerUnit_(unitInfo, playerId)
	else
		supplementPlayerUnit_(unitInfo, playerId)
	end
	
	if dataChangeListener_ then
		dataChangeListener_:onPlayerUnitChange()
	end
end

function changePlayerUnit(playerId)
	local unitInfo = getUnitInfo_(playerId)
	
	if unitInfo then
		changePlayerUnit_(unitInfo, playerId)
		DebriefingEventsData.resetPlayerDeathTime()
	end
end

function setPlayerUnit(playerId, callsign)
	local unitInfo = getUnitInfo_(playerId)
	
	if unitInfo then
		replacePlayerUnit_(unitInfo, playerId)
		playerUnit_.callsign = callsign or unitInfo.callsign.name
	else
		playerUnit_ = createPlayerUnit_()
	end
	
	if dataChangeListener_ then
		dataChangeListener_:onPlayerUnitChange()
	end
	
	DebriefingEventsData.resetPlayerDeathTime()
end

function getPlayerUnitInfo()
    local result = 
        {
            callsign = playerUnit_.callsign,
        }
    
    for k,v in base.pairs(playerUnit_.type) do
        if result.aircraft == nil then
            result.aircraft = v
        else
            result.aircraft = result.aircraft .. ", "..v
        end        
    end
    
    for k,v in base.pairs(playerUnit_.task) do
        if result.task == nil then
            result.task = v
        else
            result.task = result.task .. ", "..v
        end        
    end
    
    for k,v in base.pairs(playerUnit_.country) do
        if result.country == nil then
            result.country = v
        else
            result.country = result.country .. ", "..v
        end        
    end
    
    if result.aircraft == nil then
        result.aircraft = ""
    end
    
    if result.task == nil then
        result.task = ""
    end
    
    if result.country == nil then
        result.country = ""
    end
    
    return result
end

local function getUnitStatisticFieldName_(unitInfo)
	if unitInfo.category == 'vehicle' and getMissionUnitIsAirDefence_(unitInfo.type) then
		return 'airDefenceCount'
	end
		
	return unitInfo.category .. 'Count'
end

local function updatePlayerScore_(deadUnitInfo)
	local deadUnitRate = deadUnitInfo.rate

    if deadUnitInfo.unitId ~= playerUnit_.unitId then
        if deadUnitInfo.coalition == playerUnit_.coalition then
            playerScore_ = playerScore_ - deadUnitRate
        else
            playerScore_ = playerScore_ + deadUnitRate
        end
	end
    
	if dataChangeListener_ then
		dataChangeListener_:onPlayerScoreChange()
	end
end

function getPlayerScore()
	return playerScore_
end

-- игрок убил юнит
function processUnitKill(unitId, a_initiatorMissionID)
	if not deadUnitIds_[unitId] then
		local deadUnitInfo = getUnitInfo_(unitId)
		
		if deadUnitInfo then
			local coalitionName = deadUnitInfo.coalition
			local coalitionLosses = losses_[coalitionName]
			local statisticFieldName = getUnitStatisticFieldName_(deadUnitInfo)
			
			coalitionLosses[statisticFieldName] = coalitionLosses[statisticFieldName] + 1
			
			if dataChangeListener_ then
				dataChangeListener_:onLossesChange()
			end	
			
			if a_initiatorMissionID == getPlayerUnitId() then
				local playerCoalitionVictories = playerVictories_[coalitionName]
				
				playerCoalitionVictories[statisticFieldName] = playerCoalitionVictories[statisticFieldName] + 1
				
				if dataChangeListener_ then
					dataChangeListener_:onPlayerVictoriesChange(getRedCoalitionPlayerVictories(), getBlueCoalitionPlayerVictories())
				end
				
				updatePlayerScore_(deadUnitInfo)
			end
		end
		
		deadUnitIds_[unitId] = true
	end
end

function getPlayerUnitId()
    if playerUnit_ then
        return playerUnit_.unitId
    end
    return nil    
end

function getFailureName(unitId, failureId)
	local unitInfo = getUnitInfo_(unitId)
	
	if unitInfo and failureId then
		return unitInfo.failures[failureId]
	end
end

