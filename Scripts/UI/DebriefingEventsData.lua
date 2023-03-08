module('DebriefingEventsData', package.seeall)

local DebriefingMissionData = require('DebriefingMissionData')

local events_ = {}
local initiatorMissionIds_ = {}
local targetMissionIds_ = {}
local totalMissionIds_ = {}
local weaponIds_ = {}
local eventTypes_ = {}
local shotEventLastTimeInfos_ = {}
local shotEventCount_ = {}
local hitEventLastTimeInfos_ = {}
local startShootingEventLastTimeInfos_ = {}
local hitEventCount_ = {}
local startShootingEventCount_ = {}
local endShootingEventLastTimeInfos_ = {}
local endShootingEventCount_ = {}
local hitInfos_ = {}
local hugeTimeValue_ = 1e09
local playerDeathTime_ = hugeTimeValue_
local filterChangeListener_
local localize_
local start_time = 0

function setLocalizeFunc(localizeFunc)
	localize_ = localizeFunc
end

function clearData()
    events_ = {}
    initiatorMissionIds_ = {}
    targetMissionIds_ = {}
    totalMissionIds_ = {}
    weaponIds_ = {}
    eventTypes_ = {}
    shotEventLastTimeInfos_ = {}
    shotEventCount_ = {}
    hitEventLastTimeInfos_ = {}
    hitEventCount_ = {}
	startShootingEventLastTimeInfos_ = {}
	startShootingEventCount_ = {}
	endShootingEventLastTimeInfos_ = {}
	endShootingEventCount_ = {}
    hitInfos_ = {}
    playerDeathTime_ = hugeTimeValue_
end

local function checkEventIsNext_(event, eventLastTimeInfos, eventCountTable)
	local isNextEvent = false
	local weapon = event.weapon
	
	if weapon then
		local eventKey = (event.initiatorMissionID or "nil") .. "_" .. (event.targetMissionID or "nil") .. "_" .. weapon
		local eventLastTimeInfo = eventLastTimeInfos[eventKey]
		local eventTime = event.t
		local maxEventDelayInSeconds = 1
		
		-- группируются события, между которыми прошло менее 1 секунд
		isNextEvent = eventLastTimeInfo and eventTime - eventLastTimeInfo.time < maxEventDelayInSeconds 
		
		if isNextEvent then
			local startEvent = eventLastTimeInfo.event
			
			eventCountTable[startEvent] = eventCountTable[startEvent] + 1
			eventLastTimeInfo.time = eventTime
			
			if onChangeCountEvent then
				onChangeCountEvent(startEvent)
			end
		else
			eventCountTable[event] = 1
			eventLastTimeInfos[eventKey] = {event = event, time = eventTime}
		end
	end
	
	return isNextEvent
end

local function checkEventIsNextShot_(event)
	return checkEventIsNext_(event, shotEventLastTimeInfos_, shotEventCount_)
end

local function checkEventIsNextHit_(event)
	return checkEventIsNext_(event, hitEventLastTimeInfos_, hitEventCount_)
end

local function checkEventIsNextStartShooting_(event)
	return checkEventIsNext_(event, startShootingEventLastTimeInfos_, startShootingEventCount_)
end

local function checkEventIsNextEndShooting_(event)
	return checkEventIsNext_(event, endShootingEventLastTimeInfos_, endShootingEventCount_)
end

local function checkEventIsNextHitOrShot_(event)
	local eventType = event.type
	
	if 'hit' == eventType then
		return checkEventIsNextHit_(event)
	elseif 'shot' == eventType then
		return checkEventIsNextShot_(event)
	elseif "start shooting" == eventType then
		return checkEventIsNextStartShooting_(event)	
	elseif "end shooting" == eventType then
		return checkEventIsNextEndShooting_(event)		
	else
		return false
	end
end

local function getEventUseful_(event)
	local eventType = event.type
	local initiatorMissionId = event.initiatorMissionID
	
	if 'relinquished' == eventType or "pilot discard chair" == eventType 
		or "trigger zone" == eventType then
		return false
	end

	if 'hit' == eventType then
		if 	nil == initiatorMissionId or 
			'' == initiatorMissionId or 
			'Building' == initiatorMissionId then
				return false
		end
	end
	
	if 'failure' == eventType then
		return event.t < playerDeathTime_ - 1
	end

	return true
end

local function addTotalMissionId_(missionId)
	if not totalMissionIds_[missionId] then
		totalMissionIds_[missionId] = true
		
		if filterChangeListener_ then
			filterChangeListener_:onTotalMissionIdChange(missionId)
		end
	end
end

local function addInitiatorMissionId_(event)
	local initiatorMissionId = event.initiatorMissionID
	
	if initiatorMissionId then
		if not initiatorMissionIds_[initiatorMissionId] then
			initiatorMissionIds_[initiatorMissionId] = true
			
			if filterChangeListener_ then
				filterChangeListener_:onInitiatorMissionIdChange(initiatorMissionId)
			end
		end
		
		addTotalMissionId_(initiatorMissionId)
	end
end

local function addTargetMissionId_(event)
	local eventType = event.type
	
	if 	'takeoff' == eventType or 
		'land' == eventType or 
		'base captured' == eventType then
			local eventPlace	 = event.place
			local eventPlaceDisp = event.placeDisplayName
			if  eventPlaceDisp ~= nil then
				event.targetMissionID = eventPlaceDisp
			elseif eventPlace and eventPlace ~= ''then
				event.targetMissionID = localize_(eventPlace)
			end
	end

	local targetMissionId = event.targetMissionID
	if targetMissionId and targetMissionId == "0"  then
		targetMissionId = event.target
	end
	
	if targetMissionId then
		if not targetMissionIds_[targetMissionId] then
			targetMissionIds_[targetMissionId] = true
			
			if filterChangeListener_ then
				filterChangeListener_:onTargetMissionIdChange(targetMissionId)
			end
		end	
		
		addTotalMissionId_(targetMissionId)
	end
end

local function addWeaponId_(event)
	local weaponId = event.weapon
	
	if weaponId then
		if not weaponIds_[weaponId] then
			weaponIds_[weaponId] = true
			
			if filterChangeListener_ then
				filterChangeListener_:onWeaponIdChange(weaponId)
			end
		end
	end
end

local function addEventType_(event)
	local eventType = event.type
	
	if not eventTypes_[eventType] then
		eventTypes_[eventType] = true
		
		if filterChangeListener_ then
			filterChangeListener_:onEventTypeChange(eventType)
		end
	end
end

local function processHitEvent_(event)
	if 'hit' == event.type then
		local initiatorMissionId = event.initiatorMissionID 
		local targetMissionId = event.targetMissionID
		local hitInfo = hitInfos_[targetMissionId]
		
		if not hitInfo then
			hitInfo = {}
			hitInfos_[targetMissionId] = hitInfo
		end
		
		-- TODO:
		-- здесь можно собирать статистику по попаданиям
		local initiatorHitTimes = hitInfo[initiatorMissionId]
		
		if not initiatorHitTimes then
			initiatorHitTimes = {}
			hitInfo[initiatorMissionId] = initiatorHitTimes
		end
		
		-- флаг hitByPlayer мы должны сохранять здесь, 
		-- поскольку playerUnitId может поменяться
		table.insert(initiatorHitTimes, 1, {time = event.t, hitByPlayer = DebriefingMissionData.getPlayerUnitId() == initiatorMissionId})
	end
end

function processPlayerChangeUnit_(event)
    if 'under control' == event.type then
        DebriefingMissionData.changePlayerUnit(event.targetMissionID)
		resetPlayerDeathTime()
    end
end

function processDeadCrashKillEvents_(event)
	local eventType = event.type
	
	if 'dead' == eventType or 'crash' == eventType then
		if event.initiatorMissionID == DebriefingMissionData.getPlayerUnitId() then
			playerDeathTime_ = event.t
		end
	end
	
	if 'kill' == eventType then
		DebriefingMissionData.processUnitKill(event.targetMissionID, event.initiatorMissionID)	
	end
end

-- публичный интерфейс
function addEvent(event)
	if (not _G.__FINAL_VERSION__) and 'hit' == event.type then
		if 	nil == event.initiatorMissionID then
			event.initiatorMissionID = "no name"			
		end
	end
	
	if 'mission start' == event.type then	
		start_time = event.ta or 0
	end
	
	if event.t then
		event.t = event.t + start_time
	end
	
	local result = getEventUseful_(event)
	
	if result then
		addInitiatorMissionId_(event)
		addTargetMissionId_(event)
		addWeaponId_(event)
		addEventType_(event)
		processHitEvent_(event)
		processPlayerChangeUnit_(event)
		processDeadCrashKillEvents_(event)
		
		result = not checkEventIsNextHitOrShot_(event)
		
		if result then
			table.insert(events_, event)
		end	
		
	end
	
	return result
end

function getEventCount()
	return #events_
end

-- этот объект будет оповещен при изменении таблиц:
-- local initiatorMissionIds_ = {}
-- local targetMissionIds_ = {}
-- local weaponIds_ = {}
-- local eventTypes_ = {}
function setFilterChangeListener(filterChangeListener)
	filterChangeListener_ = filterChangeListener
end

function getInitiatorMissionIds()
	local result = {}
	
	for initiatorMissionId, flag in pairs(initiatorMissionIds_) do
		table.insert(result, initiatorMissionId)
	end
	
	return result
end

function getTargetMissionIds()
	local result = {}
	
	for targetMissionId, flag in pairs(targetMissionIds_) do
		table.insert(result, targetMissionId)
	end
	
	return result
end

function getWeaponIds()
	local result = {}
	
	for weaponId, flag in pairs(weaponIds_) do
		table.insert(result, weaponId)
	end
	
	return result
end

function getEventTypes()
	local result = {}
	
	for eventType, flag in pairs(eventTypes_) do
		table.insert(result, eventType)
	end
	
	return result
end

function getEvents()
	local tableInsertFunc = table.insert
	local events = {}
	
	for i, event in ipairs(events_) do
		tableInsertFunc(events, event)
	end
	
	return events
end

function getEventsByType(eventType, events)		
	local filterFunc = function(event)
		if eventType then
			return event.type == eventType
		end
		
		return true
	end

	return getEventsByFilter(events, filterFunc)
end

function getEventsByInitiatorMissionId(initiatorMissionId, events)	
	local filterFunc = function(event)
		if initiatorMissionId then
			return event.initiatorMissionID == initiatorMissionId
		end
		
		return true
	end

	return getEventsByFilter(events, filterFunc)
end

function getEventsByTargetMissionId(targetMissionId, events)	
	local filterFunc = function(event)
		if targetMissionId then
			return event.targetMissionID == targetMissionId
		end
		
		return true
	end

	return getEventsByFilter(events, filterFunc)
end

function getEventsByWeaponId(weaponId, events)
	local filterFunc = function(event)
		if weaponId then
			return event.weapon == weaponId
		end
		
		return true
	end
	
	return getEventsByFilter(events, filterFunc)
end

function getEventsByFilter(events, filterFunc)
	events = events or events_
	
	local result = {}
	local tableInsertFunc = table.insert
	
	for i, event in ipairs(events) do
		if filterFunc(event) then
			tableInsertFunc(result, event)
		end
	end

	return result
end

-- возвращает количество выстрелов для события 'shot'
function getEventShotCount(event)
	return shotEventCount_[event]
end

-- возвращает количество столкновений для события 'hit'
function getEventHitCount(event)
	return hitEventCount_[event]
end

function resetPlayerDeathTime()
	playerDeathTime_ = hugeTimeValue_
end

function setCallbackChangeCountEvent(a_onChangeCountEvent)	
	onChangeCountEvent = a_onChangeCountEvent
end
