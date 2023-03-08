local base = _G

module('debriefing')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local print = base.print
local string = base.string
local math = base.math
local table = base.table
local type = base.type
local loadstring = base.loadstring
local setfenv = base.setfenv
local next = base.next
local setmetatable = base.setmetatable
local os = base.os
local assert = base.assert
local tostring = base.tostring

local DebriefingMissionData		= require('DebriefingMissionData')
local DebriefingEventsData		= require('DebriefingEventsData')
local Static					= require('Static')
local ListBoxItem				= require('ListBoxItem')
local DialogLoader				= require('DialogLoader')
local i18n						= require('i18n')
local gettext					= require("i_18n")
local Gui						= require("dxgui")
local GuiWin					= require('dxguiWin')
local textutil					= require('textutil')
local log 						= require('log')
local DCS						= require('DCS')
local UpdateManager				= require('UpdateManager')

setmetatable(Gui, {__index = GuiWin})

i18n.setup(_M)

local function localize(s) 
	if s and s ~= '' then 
		return gettext.dtranslate('missioneditor', s) 
	end
	
	return ''
end

DebriefingMissionData.setLocalizeFunc(localize)
DebriefingEventsData.setLocalizeFunc(localize)

-- максимальное количество сообщений, которое отображается без окна с прогрессбаром
local maxEventCountNoUpdateScreen_ = 200
-- максимальное количество сообщений, добавляемое в таблицу за один цикл обновления
-- влияет на скорость заполнения таблицы и плавность заполнения прогрессбара
local maxEventCountPerUpdate_ = 20
local window_
local windowProgress_
local comboListInitiator_
local comboListEvent_
local comboListSide_
local comboListTarget_
local comboListTargetSide_
local comboListWeapon_
local comboListObject_
local grid_
local cellSkin_
local timeCellSkin_
local coalitionCellSkins_ = {}
local cellPool_
local widgetResults, widgetResultsText, widgetScoreValue
local lossesWidgets_
local currentEvents_ = {}
local deferredEvents_ = {}
local lastDeferredEventIndex_
local filter_ = {}
local rowByEvent = {}

local columnTimeIndex_ 				= 0
local columnInitiatorIndex_ 		= 1
local columnInitiatorCountryIndex_ 	= 2
local columnTargetIndex_ 			= 4 --3
local columnTargetCountryIndex_ 	= 5 --4
local columnEventTypeIndex_ 		= 3 --5
local columnDetailsIndex_ 			= 6

function onChangeCountEvent(a_event) -- вызывается из DebriefingEventsData.lua
	local rowIndex = rowByEvent[a_event]
	
	if rowIndex then
		local details = getEventDetails(a_event) 
		local cell = grid_:getCell(columnDetailsIndex_, rowIndex) 
		cell:setText(details)
	end
end
DebriefingEventsData.setCallbackChangeCountEvent(onChangeCountEvent)


--Callback при вызове show
local visibleChangeCallback = nil

local cdata = {
	all = _('ALL'),
    DEBRIEFING = _('DEBRIEFING'),
    Attrition = _('Attrition'),
    GeneralDebriefingData = _('General Debriefing Data'),
    red = _('RedCoalition'),
    blue = _('BlueCoalition'),
    LogFilters = _('Log Filters'),
    Planes = _('PLANES'),
    Helicopters = _('HELICOPTERS'),
    Ships = _('SHIPS'),
    Armored = _('ARMORED'),
    AirDefence = _('AIR DEFENCE'),
    Vehicles = _('VEHICLES'),
    Buildings = _('BUILDINGS'),
    Bridges = _('BRIDGES'),
    MissionName_ = _('MISSION NAME:'),
    Red_ = _('RedCoalition'),
    Blue_ = _('BlueCoalition'),
    Side_ = _('SIDE:'),
    Time_ = _('TIME:'),
    Pilot_ = _('PILOT:'),
    Unit_ = _('UNIT:'),
    MyVictories = _('MY VICTORIES'),
    Show_ = _('SHOW MY VICTORIES'),
    Task_ = _('TASK:'),
    Initiator = _('INITIATOR'),
    Weapon = _('WEAPON'),
    Object = _('OBJECT'),
    Side = _('SIDE'),
    Event = _('EVENT'),
    Trgside = _('TRGSIDE'),
    Target = _('TARGET'),
    SAVETRACK = _('SAVE TRACK'),
    SAVEDEBRIEFING = _('SAVE DEBRIEFING'),
    Score_    =    _('SCORE:'),
    TimeLogged_    =    _('TIME LOGGED:'),
    Results_    =    _('RESULTS'),
    EDITMISSION = _('MISSION EDITOR'),
	
	-- grid column headers
	TimeHeader = _('Time'),
	InitiatorHeader = _('Initiator'),
	CountryHeader = _('Country'),
	TargetHeader = _('Target_debrief','Target'),
	EventHeader = _('Event'),
	DetailsHeader = _('Details'),
	
	Building = _('Building'),
    WATCHTRACK = _('WATCH TRACK'),
    CLOSE = _('CLOSE'),
    FLYAGAIN = _('FLY AGAIN'),
	ENDMISSION = _('END MISSION'),
}

-- для локализации названий событий  
local eventTypeNames = {
    _("invalid"),
    _("shot"),
    _("hit"),
    _("takeoff"),
    _("land"),
    _("crash"),
    _("eject"),
    _("refuel"),
    _("dead"),
    _("pilot dead"),
    _("mission start"),
    _("mission end"),
    _("took control"),
	_("base captured"),
	_("refuel stop"),
	_("birth"),
	_("failure"),
	_("engine startup"),
	_("engine shutdown"),
	_("under control"),
	_("relinquished"),
    _("comment"),
	_("start shooting"),
	_("end shooting"),
	_("score"),
	_("bda"),
	_("ai abort mission"),
	_("landing quality mark"),
}

if base.LOFAC then
    eventTypeNames[11] = _("mission start-LOFAC")
    eventTypeNames[12] = _("mission end-LOFAC")
    cdata.missionName_ = _('MISSION NAME:-LOFAC')
    cdata.GeneralDebriefingData = _('General Debriefing Data-LOFAC')
    cdata.SaveDebriefing = _('SAVE DEBRIEFING-LOFAC')
end

-- C++ call
function create()
    window_ = DialogLoader.spawnDialogFromFile("./MissionEditor/modules/dialogs/sim_debrief.dlg", cdata)
    
    local width, height = Gui.GetWindowSize()
    window_:setBounds(0,0,width, height)
    window_.containerMain:setBounds((width-1280)/2, (height-768)/2, 1280, 768)
    
    window_.pSimFon:setBounds(0,0,width, height)   
    window_.pSimFon.pSimBorder:setBounds((width-1284)/2, (height-772)/2, 1284, 772)    
    window_.pMeFon:setVisible(false)
    window_.pSimFon:setVisible(true)
	
	function window_:onClose()
        show(false)
    end
	
    local containerMain = window_.containerMain
    local containerLogFilters = containerMain.pRight.containerLogFilters
    
    containerMain.pTop.btnClose.onChange = function()
        show(false)
    end
    
    containerMain.pDown.btnExit.onChange = function()
        show(false)
    end
    
    comboListInitiator_		= containerLogFilters.comboListInitiator
    comboListEvent_			= containerLogFilters.comboListEvent
    comboListSide_			= containerLogFilters.comboListSide
    comboListTarget_		= containerLogFilters.comboListTarget
    comboListTargetSide_	= containerLogFilters.comboListTargetSide
    comboListWeapon_		= containerLogFilters.comboListWeapon
    comboListObject_		= containerLogFilters.comboListObject
	
	grid_ = containerMain.pGrid.grid
	
	cellSkin_ = containerMain.pNoVisible.staticCell:getSkin()
	timeCellSkin_ = containerMain.pNoVisible.staticTimeCell:getSkin()
	coalitionCellSkins_.red = containerMain.pNoVisible.staticRedCoalitionCell:getSkin()
	coalitionCellSkins_.blue = containerMain.pNoVisible.staticBlueCoalitionCell:getSkin()
	
	cellPool_ = {
		[cellSkin_] = {},
		[timeCellSkin_] = {},
		[coalitionCellSkins_.red] = {},
		[coalitionCellSkins_.blue] = {},
	}
    
    checkBoxMyVictories = containerMain.pLeft.containerAttrition.checkBoxMyVictories
	
    function checkBoxMyVictories:onChange()
		if self:getState() then
			fillPlayerVictoriesStatistic()
		else
			fillLossesStatistic()
		end
    end
    
    local containerGeneralDebriefingData = containerMain.pCenter.containerGeneralDebriefingData
    
    widgetResults = containerGeneralDebriefingData.widgetResults
    widgetResultsText = containerGeneralDebriefingData.widgetResultsText
    widgetScoreValue = containerGeneralDebriefingData.widgetScoreValue

	setLossesWidgets()
	setFilterCombolists()
	setMissionDataListener()

    return window_
end

function getShowTotalLosses()
	return not checkBoxMyVictories:getState()
end

function getShowPlayerVictories()
	return checkBoxMyVictories:getState()
end

function setLossesWidgets()
	local container = window_.containerMain.pLeft.containerAttrition
	
	lossesWidgets_ = {
		red = {
			planes 		= container.widgetPlanesRedVal,
			helicopters = container.widgetHelicoptersRedVal,
			ships 		= container.widgetShipsRedVal,
			airDefences = container.widgetAirDefenceRedVal,
			vechicles 	= container.widgetVehiclesRedVal,
		},
	
		blue = {
			planes 		= container.widgetPlanesBlueVal,
			helicopters = container.widgetHelicoptersBlueVal,
			ships 		= container.widgetShipsBlueVal,
			airDefences = container.widgetAirDefenceBlueVal,
			vechicles 	= container.widgetVehiclesBlueVal,
		}
	}
end

function fillStatistic(statistic, totalStatistic, lossesWidgets)
	lossesWidgets.planes:setText(string.format('%d/%d', statistic.planeCount, totalStatistic.planeCount))
	lossesWidgets.helicopters:setText(string.format('%d/%d', statistic.helicopterCount, totalStatistic.helicopterCount))
	lossesWidgets.ships:setText(string.format('%d/%d', statistic.shipCount, totalStatistic.shipCount))
	lossesWidgets.airDefences:setText(string.format('%d/%d', statistic.airDefenceCount, totalStatistic.airDefenceCount))
	lossesWidgets.vechicles:setText(string.format('%d/%d', statistic.vehicleCount, totalStatistic.vehicleCount))
end

function fillLossesStatistic()
	local redCoalitionLosses = DebriefingMissionData.getRedCoalitionLosses()
	local blueCoalitionLosses = DebriefingMissionData.getBlueCoalitionLosses()
	local redCoalitionStatistic = DebriefingMissionData.getRedCoalitionStatistic()
	local blueCoalitionStatistic = DebriefingMissionData.getBlueCoalitionStatistic()

	fillStatistic(redCoalitionLosses, redCoalitionStatistic, lossesWidgets_.red)
	fillStatistic(blueCoalitionLosses, blueCoalitionStatistic, lossesWidgets_.blue)
end

function fillPlayerVictoriesStatistic()
	local redCoalitionPlayerVictories = DebriefingMissionData.getRedCoalitionPlayerVictories()
	local blueCoalitionPlayerVictories = DebriefingMissionData.getBlueCoalitionPlayerVictories()
	local redCoalitionStatistic = DebriefingMissionData.getRedCoalitionStatistic()
	local blueCoalitionStatistic = DebriefingMissionData.getBlueCoalitionStatistic()
	
	fillStatistic(redCoalitionPlayerVictories, redCoalitionStatistic, lossesWidgets_.red)
	fillStatistic(blueCoalitionPlayerVictories, blueCoalitionStatistic, lossesWidgets_.blue)
end

function fillPlayerUnitInfo()
	local container = window_.containerMain.pCenter.containerGeneralDebriefingData
	local playerUnitInfo = DebriefingMissionData.getPlayerUnitInfo()	
	
	container.widgetPilot:setText(playerUnitInfo.callsign)
	container.widgetAircraft:setText(playerUnitInfo.aircraft)
	container.widgetTask:setText(playerUnitInfo.task)
	container.widgetSide:setText(playerUnitInfo.country)
end

function fillPlayerScore()
	local score = DebriefingMissionData.getPlayerScore()
	
	widgetScoreValue:setText(score)
end

function fillMissionData()
	local container = window_.containerMain.pCenter.containerGeneralDebriefingData
	
	container.widgetMissionName:setText(DebriefingMissionData.getMissionName())
	container.widgetTime:setText(getTimeString(DebriefingMissionData.getMissionStartTime()))
end

function setMissionDataListener()
	local listener = {}
	local container = window_.containerMain.pCenter.containerGeneralDebriefingData
	
	function listener:onPlayerUnitChange()
		if isVisible() then
			fillPlayerUnitInfo()
		end
	end
	
	function listener:onPlayerScoreChange()
		fillPlayerScore()
	end
	
	function listener:onMissionDataChange()
		fillMissionData()
	end
	
	function listener:onLossesChange()
		if isVisible() and getShowTotalLosses() then
			fillLossesStatistic()
		end
	end
	
	function listener:onPlayerVictoriesChange()
		if isVisible() and getShowPlayerVictories() then 
			fillPlayerVictoriesStatistic()
		end
	end
	
	DebriefingMissionData.setDataChangeListener(listener)
end

function setFilterCombolists()
	setFilterChangeListener()
	setCoalitionCombolist(comboListSide_, 'initiatorCoalition')
	setCoalitionCombolist(comboListTargetSide_, 'targetCoalition')
end

function setCoalitionCombolist(combolist, filterFieldName)
	local item = ListBoxItem.new(cdata.all)
	
	combolist:insertItem(item)
	combolist:selectItem(item)
	
	function combolist:onChange(item)
		filter_[filterFieldName] = item.coalition
		fillGrid()
	end
	
	item = ListBoxItem.new(cdata.red)
	item.coalition = 'red'
	
	combolist:insertItem(item)
	
	item = ListBoxItem.new(cdata.blue)
	item.coalition = 'blue'
	
	combolist:insertItem(item)
end

-- поиск позиции для вставки в отсортированную таблицу
function findPositionInSortedArray(value, array, fcomp)
	-- взято http://lua-users.org/wiki/OrderedAssociativeTable функция table.binsert()
	-- Initialise Compare function
	local fcomp = fcomp or function( a, b ) return a < b end

	--  Initialise Numbers
	local iStart = 1
	local iEnd = table.getn( array )
	local iMid = 1
	local iState = 0

	-- Get Insertposition
	while iStart <= iEnd do
		-- calculate middle
		iMid = math.floor( ( iStart + iEnd )/2 )

		-- compare
		if fcomp( value , array[iMid] ) then
			iEnd = iMid - 1
			iState = 0
		else
			iStart = iMid + 1
			iState = 1
		end
	end

	return iMid + iState
end

function setInitiatorMissionIdListener(listener, combolist)
	local names = {}
	local compareFunc = textutil.Utf8CompareNoCase
	local item = ListBoxItem.new(cdata.all)
	
	combolist:insertItem(item)
	combolist:selectItem(item)
	
	function combolist:onChange(item)
		filter_.initiatorId = item.id
		fillGrid()
	end
	
	function listener:onInitiatorMissionIdChange(id)
		local unitName = DebriefingMissionData.getUnitName(id)
		local position = findPositionInSortedArray(unitName, names, compareFunc)

		table.insert(names, position, unitName)
		
		local item = ListBoxItem.new(unitName)
		item.id = id
		
		combolist:insertItem(item, position)
	end
end

function setTargetMissionIdListener(listener, combolist)
	local names = {}
	local compareFunc = textutil.Utf8CompareNoCase
	local item = ListBoxItem.new(cdata.all)
	
	combolist:insertItem(item)
	combolist:selectItem(item)

	function combolist:onChange(item)
		filter_.targetId = item.id
		fillGrid()
	end
	
	function listener:onTargetMissionIdChange(id)
		local unitName = DebriefingMissionData.getUnitName(id)
	
		local position = findPositionInSortedArray(unitName, names, compareFunc)

		table.insert(names, position, unitName)
		
		local item = ListBoxItem.new(unitName)
		item.id = id
		
		combolist:insertItem(item, position)
	end
end

function setTotalMissionIdListener(listener, combolist)
	local names = {}
	local compareFunc = textutil.Utf8CompareNoCase
	local item = ListBoxItem.new(cdata.all)
	
	combolist:insertItem(item)
	combolist:selectItem(item)
	
	function combolist:onChange(item)
		filter_.objectId = item.id
		fillGrid()
	end
	
	function listener:onTotalMissionIdChange(id)
		local unitName = DebriefingMissionData.getUnitName(id)
		local position = findPositionInSortedArray(unitName, names, compareFunc)
		
		table.insert(names, position, unitName)
		
		local item = ListBoxItem.new(unitName)
		item.id = id
		
		combolist:insertItem(item, position)
	end
end

function setWeaponIdListener(listener, combolist)
	local names = {}
	local compareFunc = textutil.Utf8CompareNoCase
	local item = ListBoxItem.new(cdata.all)
	
	combolist:insertItem(item)
	combolist:selectItem(item)
	
	function combolist:onChange(item)
		filter_.weaponId = item.weaponId
		fillGrid()
	end
	
	function listener:onWeaponIdChange(weaponId)
		local position = findPositionInSortedArray(weaponId, names, compareFunc)

		table.insert(names, position, weaponId)
		
		local item = ListBoxItem.new(weaponId)
		item.weaponId = weaponId
		
		combolist:insertItem(item, position)
	end
end

function setEventTypeListener(listener, combolist)
	local names = {}
	local compareFunc = textutil.Utf8CompareNoCase
	local item = ListBoxItem.new(cdata.all)
	
	combolist:insertItem(item)
	combolist:selectItem(item)
	
	function combolist:onChange(item)
		filter_.eventType = item.eventType
		fillGrid()
	end
	
	function listener:onEventTypeChange(eventType)
		local localizedEventType = localize(eventType)
		local position = findPositionInSortedArray(localizedEventType, names, compareFunc)

		table.insert(names, position, localizedEventType)
		
		local item = ListBoxItem.new(localizedEventType)
		item.eventType = eventType
		
		combolist:insertItem(item, position)
	end
end

function setFilterChangeListener()
	local listener = {}
	
	setInitiatorMissionIdListener(listener, comboListInitiator_)
	setTargetMissionIdListener(listener, comboListTarget_)
	setTotalMissionIdListener(listener, comboListObject_)
	setWeaponIdListener(listener, comboListWeapon_)
	setEventTypeListener(listener, comboListEvent_)
		
	DebriefingEventsData.setFilterChangeListener(listener)
end

function getEventVisible(event, filter)
	if filter.initiatorId then
		if filter.initiatorId ~= event.initiatorMissionID then
			return false
		end
	end

	if filter.targetId then
		if (event.targetMissionID ~= "0" and filter.targetId ~= event.targetMissionID) or (event.targetMissionID == "0"  and filter.targetId ~= event.target) then
			return false
		end
	end
	
	if filter.objectId then
		if (event.targetMissionID ~= "0" and event.initiatorMissionID ~= filter.objectId and event.targetMissionID ~= filter.objectId)
			or (event.targetMissionID == "0" and event.initiatorMissionID ~= filter.objectId and event.target ~= filter.objectId) then
			return false
		end
	end
	
	if filter.weaponId then
		if filter.weaponId ~= event.weapon then
			return false
		end
	end
	
	if filter.eventType then
		if filter.eventType ~= event.type then
			return false
		end 
	end
	
	if filter.initiatorCoalition then
		if filter.initiatorCoalition ~= DebriefingMissionData.getUnitCoalitionName(event.initiatorMissionID) then
			return false
		end
	end
	
	if filter.targetCoalition then
		if filter.targetCoalition ~= DebriefingMissionData.getUnitCoalitionName(event.targetMissionID) then
			return false
		end
	end
	
	return true
end

-- C++ call
function showMissionResults(visible)  
	if window_ == nil then
		return
	end
    widgetResults:setVisible(visible)
    widgetResultsText:setVisible(visible)
end

-- C++ call
function setVisibleChangeCallback(callback)
    visibleChangeCallback = callback
end

-- C++ call
function setDBUnitsByType(unitsTable)
	DebriefingMissionData.setUnitsDatabase(unitsTable)
end

-- C++ call
function destroy()
	if window_ == nil then
		return
	end
    window_:kill()
	window_ = nil
end

-- C++ call
function setKeyToValueFunction(a_KeyToValue)
    DebriefingMissionData.setKeyToValueFunction(a_KeyToValue)
end

local updateScrollgridFunction
function updateScrollgridFunction()
	local deferredEventCount	= #currentEvents_
	local beginEventIndex		= lastDeferredEventIndex_ + 1
	local endEventIndex			= beginEventIndex + maxEventCountPerUpdate_
	local progressBar			= windowProgress_.progressBar
	
	progressBar:setRange(0, deferredEventCount)

	for i = beginEventIndex, endEventIndex do
		if i > deferredEventCount then
		
			Gui.EnableHighSpeedUpdate(false)
			Gui.RemoveUpdateCallback(updateScrollgridFunction)

			currentEvents_ = {}
			lastDeferredEventIndex_ = nil
			windowProgress_:setVisible(false)

			return
		end
		
		lastDeferredEventIndex_ = i
		
		addEventToGrid(currentEvents_[i])
		progressBar:setValue(i)
	end
end

function setUpdateScrollgridFunction()
	Gui.SetupApplicationUpdateCallback()

	if not windowProgress_ then
		local cdata = {
			wait = _('Please wait while the list is being populated...')
		}
		
		windowProgress_ = DialogLoader.spawnDialogFromFile("./Scripts/UI/DebriefingProgressDialog.dlg", cdata)
	end
	
	windowProgress_:centerWindow()
	windowProgress_:setVisible(true)
	
	local progressBar = windowProgress_.progressBar
	
	if not lastDeferredEventIndex_ then
		lastDeferredEventIndex_ = 0
	end	
	
	Gui.EnableHighSpeedUpdate(true)
	Gui.AddUpdateCallback(updateScrollgridFunction)
	
	windowProgress_:setVisible(true)
end

function appendEventsToGrid(events)
	currentEvents_ = events
	
	if #currentEvents_ > maxEventCountNoUpdateScreen_ then
		setUpdateScrollgridFunction()
	else
		for i, event in ipairs(currentEvents_) do
			addEventToGrid(event)
		end
	end
end

function getFilteredEvents(filter)
	local filteredEvents = {}
	local events = DebriefingEventsData.getEvents()

	for i, event in ipairs(events) do
		if getEventVisible(event, filter) then
			table.insert(filteredEvents, event)
		end
	end
	
	return filteredEvents
end

function fillGrid()
	clearGrid()
	appendEventsToGrid(getFilteredEvents(filter_))
end

function fillAttrition()
	if getShowTotalLosses() then
		fillLossesStatistic()
	else
		fillPlayerVictoriesStatistic()
	end
end

-- C++ call
function isVisible()
    return window_ and window_:getVisible()
end

-- C++ call
function show(visible)
	if not window_ then 
		return
	end
	
	window_.containerMain.pDown.btnEndMission:setVisible(false)
	
	if visible ~= isVisible() then
		if visible then
			fillAttrition()
			fillPlayerUnitInfo()
			fillPlayerScore()
			fillMissionData()
			
			appendEventsToGrid(deferredEvents_)
			deferredEvents_ = {}			
		end
		
		window_:setVisible(visible)
		
		if visibleChangeCallback then 
			visibleChangeCallback(visible) 
		end
	end
end


-- C++ call
function setGetCountryShortName(a_getCountryShortName)
    DebriefingMissionData.setGetCountryShortName(a_getCountryShortName)
end

-- C++ call
function updateMissionData(missionString)
    clearData()
	DebriefingMissionData.setMissionString(missionString)
	updateMissionResults(0)
end

function extractMissionData(missionData)
    clearData()
	DebriefingMissionData.setMissionData(missionData)
	updateMissionResults(0)
end

-- C++ call
function setPlayerUnit(playerId, callsign)
	DebriefingMissionData.setPlayerUnit(playerId, callsign)
end

-- C++ call
function updateMissionResults(results)
	if window_ == nil then
		return
	end
    widgetResults:setText(results)
end

function getTimeString(t_sec)

	local timeInSeconds = t_sec or 0
	local secondsPerDay = 60 * 60 * 24
	
	timeInSeconds = timeInSeconds - math.floor(timeInSeconds / secondsPerDay) * secondsPerDay

	local hours = math.floor(timeInSeconds / 3600)

	timeInSeconds = timeInSeconds % 3600

	local minutes = math.floor(timeInSeconds / 60)
	local seconds = timeInSeconds % 60		

	return string.format("%i:%02i:%02i", hours, minutes, seconds)
end

local localizedEventTypeNames_ = {}

function getLocalizedEventTypeName(eventType)
	local localizedEventTypeName = localizedEventTypeNames_[eventType]
	
	if not localizedEventTypeName then
		localizedEventTypeName = localize(eventType)
		localizedEventTypeNames_[eventType] = localizedEventTypeName
	end
	
	return localizedEventTypeName
end

local localizedWeaponNames_ = {}

function getLocalizedWeaponName(weapon)
	if weapon and '' ~= weapon then
		local localizedWeaponName = localizedWeaponNames_[weapon]
		
		if not localizedWeaponName then
			localizedWeaponName = localize(weapon)
			localizedWeaponNames_[weapon] = localizedWeaponName
		end
		
		return localizedWeaponName
	end
end

function getFailureName(event)
	local failureName = event.failureDisplayName
	
	if '' == failureName then
		failureName = DebriefingMissionData.getFailureName(event.initiatorMissionID, event.failure)
	end

	return failureName
end

function getEventDetails(event)
	local details
	local weaponName = getLocalizedWeaponName(event.weapon)

	if event.type == 'score' then 
		return event.amount
	end

	if event.type == 'landing quality mark' then 
		return event.comment
	end

	if weaponName and event.failure == nil then
		details = weaponName
		
		local hitCount = DebriefingEventsData.getEventHitCount(event)
		
		if hitCount and hitCount > 1 then
			details = string.format('%s (%d)', weaponName, hitCount)
		else
			local shotCount = DebriefingEventsData.getEventShotCount(event)
		
			if shotCount and shotCount > 1 then
				details = string.format('%s (%d)', weaponName, shotCount)
			end
		end
	else
		details = getFailureName(event)
		
		if not details then
			if event.type == 'comment' then
				details = event.comment
			end
		end
	end
	
	return details
end

function clearGrid()
	grid_:removeAllRows()
	
	rowByEvent = {}
	
	for skin, cellInfosBySkin in pairs(cellPool_) do
		for text, cellInfosByText in pairs(cellInfosBySkin) do
			for i, cellInfo in ipairs(cellInfosByText) do
				cellInfo.free = true
			end
		end
	end
end

function createCell(text, skin)	
	local cell
	local cellInfosBySkin = cellPool_[skin]
	local cellInfosByText = cellInfosBySkin[text]
	
	if not cellInfosByText then
		cellInfosByText = {}
		cellInfosBySkin[text] = cellInfosByText
	end
	
	local i, cellInfo = next(cellInfosByText)
	
	if cellInfo and cellInfo.free then
		cell = cellInfo.cell
		cellInfo.free = false
		
		table.remove(cellInfosByText, i)
		table.insert(cellInfosByText, cellInfo)
	else
		cell = Static.new()
		cell:setSkin(skin)
		
		table.insert(cellInfosByText, {cell = cell, free = false})		
	end
	
	cell:setText(text)
	cell:setTooltipText(text)
	
	return cell
end

function addEventToGrid(event)
	local rowIndex = grid_:getRowCount()
	local rowHeight = 15
	
	grid_:insertRow(rowHeight)
	
	grid_:setCell(columnTimeIndex_, rowIndex, createCell(getTimeString(event.t), timeCellSkin_))
	
	local initiatorName = DebriefingMissionData.getUnitName(event.initiatorMissionID)
	
	if initiatorName then
		grid_:setCell(columnInitiatorIndex_, rowIndex, createCell(initiatorName, cellSkin_))
	end	
	
	local initiatorCountryName = DebriefingMissionData.getUnitCountryName(event.initiatorMissionID)
	
	if initiatorCountryName then
		local initiatorCoalitionName = DebriefingMissionData.getUnitCoalitionName(event.initiatorMissionID)
		
		
		grid_:setCell(columnInitiatorCountryIndex_, rowIndex, createCell(initiatorCountryName, coalitionCellSkins_[initiatorCoalitionName]))
	end
	
	local targetName 
	
	if event.targetMissionID and event.targetMissionID ~= "0" then
		targetName = DebriefingMissionData.getUnitName(event.targetMissionID)
	else
		targetName = event.target	
	end	
	
	if targetName then
		grid_:setCell(columnTargetIndex_, rowIndex, createCell(targetName, cellSkin_))
	end
	
	local targetCountryName = DebriefingMissionData.getUnitCountryName(event.targetMissionID)
	
	if targetCountryName then
		local targetCoalitionName = DebriefingMissionData.getUnitCoalitionName(event.targetMissionID)

		grid_:setCell(columnTargetCountryIndex_, rowIndex, createCell(targetCountryName, coalitionCellSkins_[targetCoalitionName]))
	end
	
	grid_:setCell(columnEventTypeIndex_, rowIndex, createCell(getLocalizedEventTypeName(event.type), cellSkin_))
	
	local details = getEventDetails(event)
	
	if details then
		grid_:setCell(columnDetailsIndex_, rowIndex, createCell(details, cellSkin_))
	end
	
	rowByEvent[event] = rowIndex
end

function addEventToDialog(event)
	if getEventVisible(event, filter_) then
		addEventToGrid(event)
	end
end

function clearData()
    deferredEvents_ = {}
    DebriefingEventsData.clearData()
	
	if grid_ then
		clearGrid()
		
		comboListInitiator_:clear()
		comboListEvent_:clear()
		comboListSide_:clear()
		comboListTarget_:clear()
		comboListTargetSide_:clear()
		comboListWeapon_:clear()
		comboListObject_:clear()
		
		filter_ = {}
		setFilterCombolists()
	end
end

local function log_debriefing(event)
	if DCS.isMultiplayer() and 
	   DCS.isServer() then
		local log_mess = "event:"
		for i,o in pairs(event) do
			log_mess = log_mess..tostring(i).."="..tostring(o)..","
		end
		log.info(log_mess)
	end
end

-- C++ call
function addEvent(event)
	
	log_debriefing(event)
	if DebriefingEventsData.addEvent(event) then
		if isVisible() then
			if lastDeferredEventIndex_ then
				-- таблица еще не заполнена
				table.insert(currentEvents_, event)
			else
				addEventToDialog(event)
			end
		else
			if getEventVisible(event, filter_) then
				table.insert(deferredEvents_, event)
			end
		end	
	end
end


