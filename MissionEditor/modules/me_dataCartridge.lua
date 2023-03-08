local base = _G

module('me_dataCartridge')

local require = base.require

-- Модули LuaGUI
local DialogLoader 		= require('DialogLoader')
local DB 				= require('me_db_api')
local U 				= require('me_utilities')	-- Утилиты создания типовых виджетов
local panel_aircraft 	= require('me_aircraft')
local Static 			= require('Static')
local CheckBox 			= require('CheckBox')
local ComboList 		= require('ComboList')
local Slider 			= require('HorzSlider')
local SpinBox 			= require('SpinBox')
local EditBox 			= require('EditBox')
local ListBoxItem 		= require('ListBoxItem')
local crutches 			= require('me_crutches')  
local panel_loadout		= require('me_loadout')
local Gui               = require('dxgui')
local SpinWPT      		= require('me_spin_wpt')
local MapWindow         = require('me_map_window')
local Terrain			= require('terrain')
local MsgWindow			= require('MsgWindow')
local module_mission	= require('me_mission')
local OptionsData    	= require('Options.Data')
local panel_route 		= require('me_route')

require('i18n').setup(_M)

cdata = 
{
	WaypointNumberAndType 	= _("Waypoint number and type:"),
	WaypointName 			= _("WaypointName:"),
	Longitude				= _("Longitude"),
	Latitude				= _("Latitude"),	
	AltitudeMSL				= _("ALTITUDE MSL"),
	MGRS					= _("MGRS"),
	ImpactHeading			= _("IMPACT HEADING:"),
	ImpactAngle				= _("IMPACT ANGLE:"),
	ImpactSpeed				= _("IMPACT SPEED:"),
	copy					= _("COPY"),
	add						= _("ADD"),
	ins						= _("INS"),
	waypoint				= _("WAYPOINT"),
	of 						= _('OF'),
	name 					= _('NAME'),
	AddPoint				= _('ADD POINT'),
	clone					= _('CLONE'),
	edit					= _('EDIT'),
	addDual					= _('ADD DUAL'),
	addDualIns				= _('ADD DUAL INS'),
	del						= _('DEL'),
	up						= _('UP'),
	down					= _('DOWN'),
	TerminalData			= _('TERMINAL DATA'),
	
	
}

local pointsTypes =
{
	{id = "Start Location", 	dispName = _("Start Location"), 	maxPoints = 1},--Start  Location (white circle) (1)
	{id = "Sequence 1 Blue", 	dispName = _("Sequence 1 Blue"), 	maxPoints = 15},--Sequence 1 Blue (blue circle) (15)
	{id = "Sequence 2 Red", 	dispName = _("Sequence 2 Red"), 	maxPoints = 15},--Sequence 2 Red (red circle) (15)
	{id = "Sequence 3 Yellow", 	dispName = _("Sequence 3 Yellow"), 	maxPoints = 15},--Sequence 3 Yellow (yellow circle) (15)
	{id = "Initial Point", 		dispName = _("Initial Point"), 		maxPoints = 1},--Initial Point (white square) (1)
	{id = "A/A Waypoint", 		dispName = _("A/A Waypoint"), 		maxPoints = 1},--A/A Waypoint (Bullseye) (white circle with north arrow on Mission Editor) (1)
	{id = "PP", 				dispName = _("PP"), 				maxPoints = 6},--PP (red triangle on Mission Editor) (6)
	{id = "PB", 				dispName = _("PB"), 				maxPoints = 6},--PB (red triangle on Mission Editor) (6)
}
local pointsTypesById = {}
for k,v in base.pairs(pointsTypes) do
	pointsTypesById[v.id] = v
end

local curPointsTypesId = nil
local unit = nil
local curPointNum = nil -- индекс в массиве 
local linesForMap =  nil


-- Создание и размещение виджетов
-- Префиксы названий виджетов: t - text, b - button, c - combo, sp - spin, sl - slider, e - edit, d - dial 
function create()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_dataCartridge.dlg', cdata)
	
	local w, h = Gui.GetWindowSize()
 
	pBox 		= window.pBox
	pPoint 		= pBox.pPoint
	eName 		= pPoint.eName
	eAlt		= pPoint.eAlt
	sAlt		= pPoint.sAlt
	bCopy		= pBox.bCopy
	bClone		= pBox.bClone
	tbAddPoint 	= pBox.tbAddPoint
	tbAddDual	= pBox.tbAddDual
	tbAddDualIns= pBox.tbAddDualIns
	tbEdit		= pBox.tbEdit
	bDelPoint	= pBox.bDelPoint
	clTypePoint	= pBox.clTypePoint
	lbPoints	= pBox.lbPoints
	bUp			= pBox.bUp
	bDown		= pBox.bDown
	bAdd		= pBox.bAdd
	bIns		= pBox.bIns
	bDel		= pBox.bDel
	pDataPoint	= pBox.pDataPoint
	cbTerminal	= pDataPoint.cbTerminal
	pDataPP		= pDataPoint.pDataPP
	spHeading	= pDataPP.spHeading
	spAngle		= pDataPP.spAngle
	spSpeed		= pDataPP.spSpeed
	sSpeed		= pDataPP.sSpeed
	dialHeading	= pDataPP.dialHeading
	eOfPoints	= pBox.eOfPoints
	spPoint		= pBox.spPoint


	window:setBounds(w - base.right_toolbar_width, base.right_bottom_panel_y, base.right_toolbar_width,  base.right_panel_height - base.right_toolbar_h)
	pBox:setBounds(0, 0, base.right_toolbar_width,  base.right_panel_height - base.right_toolbar_h)

	altEditBox = U.createUnitEditBox(sAlt, eAlt, U.altitudeUnits, 1)
	speedSpinBox = U.createUnitSpinBox(sSpeed, spSpeed, U.speedUnitsAlt, spSpeed:getRange())
	
	fillPointsType()
	verifyShowDataPoint()
	
	bDelPoint.onChange = onChange_bDelPoint
	
	tbAddPoint.onChange 	= onChange_tbAddPoint
	tbAddDual.onChange 		= onChange_tbAddDual
	tbAddDualIns.onChange 	= onChange_tbAddDualIns
	tbEdit.onChange 		= onChange_tbEdit
	bCopy.onChange 			= onChange_bCopy
	bClone.onChange 		= onChange_bClone
	
	bAdd.onChange 	= onChange_bAdd
	bIns.onChange 	= onChange_bIns
	bDel.onChange 	= onChange_bDel
	bUp.onChange 	= onChange_bUp
	bDown.onChange 	= onChange_bDown
	
	clTypePoint.onChange 	= onChange_clTypePoint
	spPoint.onChange 		= onChange_spPoint
	lbPoints.onChange 		= onChange_lbPoints
	eName.onChange			= onChange_eName
	
	cbTerminal.onChange		= onChange_cbTerminal
	spHeading.onChange 		= onChange_spHeading
	spAngle.onChange 		= onChange_spAngle
	spSpeed.onChange 		= onChange_spSpeed
	dialHeading.onChange	= onChange_dialHeading

	updateButtonsCurGroup()
end

-- Открытие/закрытие панели
function show(b)
	if window == nil then
		create()
	end	
	
    if b then
		updateUnitSystem()		
	else
		if window:getVisible() == true then
			tbAddPoint:setState(false)
			tbAddDual:setState(false)
			tbAddDualIns:setState(false)
			tbEdit:setState(false)
			MapWindow.setState(MapWindow.getPanState()) -- карту в обычный режим
		end	
    end
    
	window:setVisible(b)
	
	updatePointsSymbols()
	updateLines()
 
end


function setData(a_unit)
	unit = a_unit
	if unit then
		unit.dataCartridge = unit.dataCartridge or {}
		unit.dataCartridge.Points = unit.dataCartridge.Points or {}
		unit.dataCartridge.GroupsPoints = unit.dataCartridge.GroupsPoints or {}
		
		for i, v in base.ipairs(pointsTypes) do
			unit.dataCartridge.GroupsPoints[v.id] = unit.dataCartridge.GroupsPoints[v.id] or {}
		end
		
		
		if curPointNum and (curPointNum > #unit.dataCartridge.Points) then
			if #unit.dataCartridge.Points == 0 then
				curPointNum = nil
			else
				curPointNum = 1
			end	
		end

		updateRangeSpPoint()
		spPoint:setValue(curPointNum or 1)
		updatePointData()
		updateButtonsCurGroup()
		updateListPoints()
		updatePointsSymbols()
		updateLines()
	end
end



function createObject_Point(a_unit, x, y)
	return {
			boss = a_unit.boss,
			unit = a_unit,
			x = x,
			y = y,
			name = _("Default name"),
			alt = 1000,
		  }
end

function setAlt(a_point)
	a_point.alt = U.getAltitude(a_point.x, a_point.y)
	altEditBox:setValue(a_point.alt)
end

function insertPoint(unit, x, y)	
	local dataCartridgePoint = createObject_Point(unit, x, y)
	base.table.insert(unit.dataCartridge.Points, dataCartridgePoint)
	reBuildIndexsPoints()
	updateRangeSpPoint()
	
	curPointNum = dataCartridgePoint.index
	spPoint:setValue(dataCartridgePoint.index) 
	setAlt(dataCartridgePoint)

	updateButtonsCurGroup()
	updatePointData()
	
	if tbAddDual:getState() == true then
		onChange_bAdd()
	elseif tbAddDualIns:getState() == true then
		onChange_bIns()
	end
	
	return dataCartridgePoint
end

-------------------------------------------------------------------------------
--
function removePointSymbol(a_point)
	local toRemove = {}
	if (a_point.symbol ~= nil) then
	   base.table.insert(toRemove, a_point.symbol.textObj)
	   base.table.insert(toRemove, a_point.symbol.numberObj)
	   base.table.insert(toRemove, a_point.symbol.iconObj)
	end
		
	MapWindow.removeUserObjects(toRemove) 
	a_point.symbol = nil
end

function moveSelectedPoint(a_x, a_y)
	local curPoint = unit.dataCartridge.Points[curPointNum]
	if curPoint then
		movePoint(curPoint, a_x, a_y)
		updateLines()
	end
end

local function movePointData(a_point, a_x, a_y)
	if (a_point.symbol ~= nil) then
		a_point.symbol.textObj.x = a_point.symbol.textObj.x - a_point.symbol.iconObj.x + a_x
		a_point.symbol.textObj.y = a_point.symbol.textObj.y - a_point.symbol.iconObj.y + a_y
		
		a_point.symbol.numberObj.x = a_point.symbol.numberObj.x - a_point.symbol.iconObj.x + a_x
		a_point.symbol.numberObj.y = a_point.symbol.numberObj.y - a_point.symbol.iconObj.y + a_y
		
		a_point.symbol.iconObj.x = a_x
		a_point.symbol.iconObj.y = a_y
	end
	a_point.x = a_x
	a_point.y = a_y
end

function movePoint(a_point, a_x, a_y)
	movePointData(a_point, a_x, a_y)	
	base.module_mission.update_group_map_objects(a_point.boss)
	updatePointData()
end

function reBuildIndexsPoints()
	for k,v in base.ipairs(unit.dataCartridge.Points) do
		unit.dataCartridge.Points[k].index = k
	end
end

function onChange_bDelPoint(self)
--------------------------
	local curPoint = unit.dataCartridge.Points[curPointNum]

	if curPoint then
		removePointSymbol(curPoint)
		
		for k,groupPoint in base.pairs(unit.dataCartridge.GroupsPoints) do
			for kk,v in base.pairs(groupPoint) do
				if curPoint == v then
					base.table.remove(unit.dataCartridge.GroupsPoints[curPointsTypesId], kk)					
					break
				end
			end
		end	
		base.table.remove(unit.dataCartridge.Points, curPointNum)	
		if curPointNum > #unit.dataCartridge.Points then
			curPointNum = #unit.dataCartridge.Points
		end

	end
	reBuildIndexsPoints()
	updateListPoints()
	updateRangeSpPoint()
	updatePointData()
	updateButtonsCurGroup()
	verifyShowDataPoint()
end

function onChange_tbAddPoint(self)
	if self:getState() == true then
		MapWindow.setState(MapWindow.getCreatingDataCartridgePointState()) -- режим добавления точек
		tbAddDual:setState(false)
		tbEdit:setState(false)
		tbAddDualIns:setState(false)
	else
		MapWindow.setState(MapWindow.getPanState()) -- карту в обычный режим
	end
end

function onChange_tbAddDual(self)
	if self:getState() == true then
		MapWindow.setState(MapWindow.getCreatingDataCartridgePointState()) -- режим добавления точек
		tbAddPoint:setState(false)
		tbEdit:setState(false)
		tbAddDualIns:setState(false)
	else
		MapWindow.setState(MapWindow.getPanState()) -- карту в обычный режим
	end
end

function onChange_tbAddDualIns(self)
	if self:getState() == true then
		MapWindow.setState(MapWindow.getCreatingDataCartridgePointState()) -- режим добавления точек
		tbAddPoint:setState(false)
		tbEdit:setState(false)
		tbAddDual:setState(false)
	else
		MapWindow.setState(MapWindow.getPanState()) -- карту в обычный режим
	end
end

function onChange_tbEdit(self)
	if self:getState() == true then
		MapWindow.setState(MapWindow.getPanState()) -- карту в обычный режим
		tbAddPoint:setState(false)
		tbAddDual:setState(false)
		tbAddDualIns:setState(false)
	end
end

function onChange_bCopy(self)
	if #unit.dataCartridge.Points > 0 then
		handler_ = MsgWindow.question(_('overwrite or add to end'), _('QUESTION'), _('overwrite'), _('to end'))
		
		function handler_:onChange(buttonText)
			if (buttonText == _('overwrite')) then
				copyPointsOfRoute(1)
			elseif (buttonText == _('to end')) then
				copyPointsOfRoute(#unit.dataCartridge.Points+1)
			end
		end
		
		handler_:show()
		
		handler_ = nil
	else
		copyPointsOfRoute(1)
	end
end

function onChange_bClone()
	local routeWpt = panel_route.getSelectedWaypoint()
	if routeWpt then
		local pt = module_mission.insert_DataCartridgePoint(unit, routeWpt.x, routeWpt.y)	
		pt.name = routeWpt.name or ""
		pt.symbol.textObj.title = pt.name

		module_mission.update_group_map_objects(unit.boss)
		
		updateRangeSpPoint()
		updatePointData()
		updateButtonsCurGroup()
		updateListPoints()
		updateLines()
		selectedItemByPoint(pt)
	end
end

function fillPointsType()
	clTypePoint:clear()
	
	local selectItem = nil
	for i, v in base.ipairs(pointsTypes) do
		local item = ListBoxItem.new(v.dispName)
		item.id = v.id
		clTypePoint:insertItem(item)
		if curPointsTypesId and curPointsTypesId == v.id then
			selectItem = item
		end
	end	
	if selectItem == nil then
		selectItem = clTypePoint:getItem(0)
		curPointsTypesId = selectItem.id
	end
	clTypePoint:selectItem(selectItem)		
end

function verifyShowDataPoint()
	if curPointsTypesId == "PP" and lbPoints:getSelectedItem() ~= nil then
		pDataPoint:setVisible(true)
	else
		pDataPoint:setVisible(false)
	end	
	pBox:updateWidgetsBounds()
end

function onChange_clTypePoint()
	curPointsTypesId = clTypePoint:getSelectedItem().id
	verifyShowDataPoint()
	updateListPoints()
	updateButtonsCurGroup()
	updatePointsSymbols()
	updateLines()
end

function onChange_bAdd()
	local curPoint = unit.dataCartridge.Points[curPointNum]

	if curPoint and curPointsTypesId then
		base.table.insert(unit.dataCartridge.GroupsPoints[curPointsTypesId], curPoint)
		
		if curPointsTypesId == "A/A Waypoint" then
			local coalition = unit.boss.boss.boss.name
			local x, y = module_mission.getCoordsBullseye(coalition)
			movePoint(curPoint, x, y)
		end
		
		updateButtonsCurGroup()
		updateListPoints()
		selectedItemByIndex(#unit.dataCartridge.GroupsPoints[curPointsTypesId]-1)
		updateLines()
		updatePointsSymbols()
		verifyShowDataPoint()
	end
end

function onChange_bIns()
	local curPoint = unit.dataCartridge.Points[curPointNum]

	if curPoint and curPointsTypesId then
		local selectedItem = lbPoints:getSelectedItem()		
		local curItemIndex = #unit.dataCartridge.GroupsPoints[curPointsTypesId]
		if selectedItem then
			
			curItemIndex = lbPoints:getItemIndex(selectedItem)
			base.table.insert(unit.dataCartridge.GroupsPoints[curPointsTypesId], curItemIndex+1, curPoint)
		else
			base.table.insert(unit.dataCartridge.GroupsPoints[curPointsTypesId], curPoint)
		end
		updateLines()
		updatePointsSymbols()
		updateButtonsCurGroup()
		updateListPoints()
		selectedItemByIndex(curItemIndex)
		verifyShowDataPoint()
	end
end

function onChange_bDel(self)
	local selectedItem = lbPoints:getSelectedItem()
	if selectedItem then
		local curIndex = lbPoints:getItemIndex(selectedItem)	
		local indexRemove = lbPoints:getItemIndex(selectedItem) + 1
		base.table.remove(unit.dataCartridge.GroupsPoints[curPointsTypesId],indexRemove)
		updatePointsSymbols()
		updateButtonsCurGroup()
		updateListPoints()		
		updateLines()
		verifyShowDataPoint()
		if curIndex <= (lbPoints:getItemCount()-1) then
			selectedItemByIndex(curIndex)
		elseif curIndex > 1 then
			selectedItemByIndex(curIndex-1)
		end
	end
end

function onChange_bUp(self)
	local selectedItem = lbPoints:getSelectedItem()
	local pt = selectedItem.refPoint
	if selectedItem then	
		local curIndex = lbPoints:getItemIndex(selectedItem)	
		if curIndex > 0 then
			swapPoints(unit.dataCartridge.GroupsPoints[curPointsTypesId], curIndex+1, curIndex) -- +1 изза разници нумерации в луи и листбоксе
			updateLines()
		end
		updateListPoints()
		selectedItemByPoint(pt)
	end
end

function onChange_bDown(self)
	local selectedItem = lbPoints:getSelectedItem()
	local pt = selectedItem.refPoint
	if selectedItem then
		local curIndex = lbPoints:getItemIndex(selectedItem)		
		if curIndex < (lbPoints:getItemCount()-1) then
			local postSelectedItem = lbPoints:getItem(curIndex+1)
			swapPoints(unit.dataCartridge.GroupsPoints[curPointsTypesId], curIndex+1, curIndex+2) -- +1 изза разници нумерации в луи и листбоксе
			updateLines()
		end
		updateListPoints()
		selectedItemByPoint(pt)
	end
end	



function onChange_spPoint(self)
	curPointNum = self:getValue()
	updateButtonsCurGroup()
	updatePointData()
end

function onChange_eName(self)
	local curPoint = unit.dataCartridge.Points[curPointNum]
	curPoint.name = self:getText()
	if curPoint.symbol then
		curPoint.symbol.textObj.title = curPoint.name
		module_mission.update_group_map_objects(unit.boss)
	end
	updateListPoints()
end


function onChange_lbPoints(self)
	curPointNum = self:getSelectedItem().refPoint.index
	spPoint:setValue(curPointNum)
	updatePointData() 
	updateButtonsCurGroup()
	verifyShowDataPoint()	
	updatePPData()
	updatePointsSymbols()
end

function updatePPData()
	local item = lbPoints:getSelectedItem()
	if item then
		local point = lbPoints:getSelectedItem().refPoint	 
		
		point.ppData = point.ppData or {}
		point.ppData.bTerminal = point.ppData.bTerminal or false
		cbTerminal:setState(point.ppData.bTerminal)
		
		if point.ppData.bTerminal == false then
			point.ppData.heading 	= nil
			point.ppData.angle		= nil
			point.ppData.speed		= nil

			spHeading:setValue(0)
			dialHeading:setValue(0)
			spAngle:setValue(0)
			speedSpinBox:setValue(30)
		
			pDataPP:setVisible(false)
		else
			pDataPP:setVisible(true)			
			point.ppData.heading 	= point.ppData.heading or 0
			point.ppData.angle		= point.ppData.angle or 0
			point.ppData.speed		= point.ppData.speed or 30
			
			spHeading:setValue(point.ppData.heading)
			dialHeading:setValue(point.ppData.heading)
			spAngle:setValue(point.ppData.angle)
			speedSpinBox:setValue(point.ppData.speed)
		end
	end
end

function onChange_cbTerminal(self)
	local item = lbPoints:getSelectedItem()
	if item then
		local point = item.refPoint	
		point.ppData = point.ppData or {}
		point.ppData.bTerminal = self:getState()
	end	
	updatePPData()
end

function onChange_spHeading(self)
	local item = lbPoints:getSelectedItem()
	
	if item then
		local point = item.refPoint
		
		local value = self:getValue()
		
		if value == -1 then
			value = 359
			self:setValue(value)
		elseif value == 360 then
			value = 0
			self:setValue(value)
		end
		
		point.ppData.heading = value
		dialHeading:setValue(value)
	end	
end

function onChange_dialHeading(self)
	local item = lbPoints:getSelectedItem()
	if item then
		local point = item.refPoint
		point.ppData.heading = self:getValue()
		spHeading:setValue(point.ppData.heading)
	end	
end

function onChange_spAngle(self)
	local item = lbPoints:getSelectedItem()
	if item then
		local point = item.refPoint
		point.ppData.angle = self:getValue()
	end
end

function onChange_spSpeed(self)
	local item = lbPoints:getSelectedItem()
	if item then
		local point = item.refPoint	
		point.ppData.speed = speedSpinBox:getValue()
	end
end

-- для точек внутри группы
function swapPoints(a_tbl, a_index1, a_index2)
	if a_index1 and a_index2 then
		local tmp = a_tbl[a_index1]
		a_tbl[a_index1] = a_tbl[a_index2]
		a_tbl[a_index2] = tmp
	end
end

function selectedItemByIndex(a_index)
	local item = lbPoints:getItem(a_index)
	lbPoints:selectItem(item)
	lbPoints:setItemVisible(item)
	updatePPData()
end

function selectedItemByPoint(a_point)
	for i = 0, lbPoints:getItemCount()-1 do
		local item = lbPoints:getItem(i)
		if item.refPoint == a_point then
			lbPoints:selectItem(item)
			lbPoints:setItemVisible(item)
			updatePPData()
			return
		end
	end
end

function updateRangeSpPoint()
	spPoint:setRange(1, #unit.dataCartridge.Points)	
end

function updatePointData()
	-- обновляем имя, координаты, высоту
	local curPoint = unit.dataCartridge.Points[curPointNum]
	if curPoint then
		eName:setText(curPoint.name)
		setAlt(curPoint)		
		eOfPoints:setText(#unit.dataCartridge.Points or 0)
		
		eOfPoints:setEnabled(true)
		spPoint:setEnabled(true)
		pPoint:setEnabled(true)
	else
		eOfPoints:setText(0)
		eOfPoints:setEnabled(false)
		spPoint:setEnabled(false)
		pPoint:setEnabled(false)
	end
end

function updateButtonsCurGroup()
	local maxPoints
	local curGroupPoints
	local curPoint
	local isEnabled
	
	tbAddDual:setEnabled(true)
	tbAddPoint:setEnabled(true)
	tbAddDualIns:setEnabled(true)
	
	if curPointsTypesId and curPointNum and unit then
		maxPoints = pointsTypesById[curPointsTypesId].maxPoints
		curPoint = unit.dataCartridge.Points[curPointNum]
		curGroupPoints = unit.dataCartridge.GroupsPoints[curPointsTypesId]
		
		isEnabled = false
		for k,v in base.pairs(curGroupPoints) do
			if v == curPoint then
				isEnabled = true
			end
		end
	end
	
	if curGroupPoints then
		if curPoint and (#curGroupPoints >= maxPoints or isEnabled == true) then
			bAdd:setEnabled(false)
			bIns:setEnabled(false)	
		else
			bAdd:setEnabled(true)
			bIns:setEnabled(true)
		end

		if #curGroupPoints >= maxPoints then
			if tbAddDual:getState() == true then
				tbAddDual:setState(false)
				tbAddPoint:setState(true)
			end
			if tbAddDualIns:getState() == true then
				tbAddDualIns:setState(false)
				tbAddPoint:setState(true)
			end
			
			tbAddDual:setEnabled(false)
			tbAddDualIns:setEnabled(false)
		end	
	end
	
	if unit and unit.dataCartridge and unit.dataCartridge.Points
		and #unit.dataCartridge.Points >= 60 then
		tbAddDual:setState(false)
		tbAddPoint:setState(false)
		tbAddDualIns:setState(false)
		
		tbAddDual:setEnabled(false)
		tbAddPoint:setEnabled(false)
		tbAddDualIns:setEnabled(false)
		
		tbEdit:setState(true)
		
		if MapWindow.getState() == MapWindow.getCreatingDataCartridgePointState() then
			MapWindow.setState(MapWindow.getPanState()) -- карту в обычный режим
		end		
	end
end

function updateListPoints()
	lbPoints:clear()
	
	for k,v in base.ipairs(unit.dataCartridge.GroupsPoints[curPointsTypesId]) do
		local item = ListBoxItem.new(v.index.."    "..v.name)
		item.refPoint = v
		lbPoints:insertItem(item)
	end
	updateButtonsCurGroup()
end

function isEditState()
	return window and window:getVisible() == true and tbEdit:getState() == true
end

function selectPoint(a_point)
	for k,v in base.pairs(unit.dataCartridge.Points) do
		if v == a_point then
			curPointNum = k
		end
	end
	spPoint:setValue(curPointNum)
	updateButtonsCurGroup()
	updatePointData()
end

function copyPointsOfRoute(a_startIndex)
	local index = a_startIndex
	
	local routePoins = unit.boss.route.points
	
	for k,v in base.pairs(routePoins) do
		if index > 60 then
			break
		end
		local pt
		if unit.dataCartridge.Points[index] == nil then
			pt = module_mission.insert_DataCartridgePoint(unit, v.x, v.y)			
		else
			pt = unit.dataCartridge.Points[index] 
			movePoint(pt, v.x, v.y)
		end
		pt.name = v.name or ""
		pt.symbol.textObj.title = pt.name
		index = index + 1
	end
	
	module_mission.update_group_map_objects(unit.boss)
	
	updateRangeSpPoint()
	updatePointData()
	updateButtonsCurGroup()
	updateListPoints()
	updateLines()
	selectedItemByPoint(pt)
end

function updatePointsSymbols()
	if unit and unit.dataCartridge and  unit.dataCartridge.Points then
		for k,point in base.pairs(unit.dataCartridge.Points) do
			local inCurGroup = false
			for kk,vv in base.pairs(unit.dataCartridge.GroupsPoints[curPointsTypesId]) do
				if vv == point then
					inCurGroup = true
				end
			end
			
			if inCurGroup == true then
				setIconsGroup(point)
			else
				setIconsDefault(point)
			end
		end
		updateLines()
		base.module_mission.update_group_map_objects(unit.boss)
	end
end

-- красим и меняем иконки точки под группу
function setIconsGroup(point)
	if point.symbol then	
		if window:getVisible() == true then
			if  curPointsTypesId == "Sequence 1 Blue" then			
				point.symbol.iconObj.classKey = 'POINTDATACARTRIDGE_ROUND'
				point.symbol.iconObj.color = {0, 0, 1, 1}
			elseif curPointsTypesId == "Sequence 2 Red" then			
				point.symbol.iconObj.classKey = 'POINTDATACARTRIDGE_ROUND'
				point.symbol.iconObj.color = {1, 0, 0, 1}
			elseif curPointsTypesId == "Sequence 3 Yellow" then			
				point.symbol.iconObj.classKey = 'POINTDATACARTRIDGE_ROUND'
				point.symbol.iconObj.color = {1, 1, 0, 1}
			elseif curPointsTypesId == "Initial Point" then	
				point.symbol.iconObj.classKey = 'POINTDATACARTRIDGE_SQUARE'
				point.symbol.iconObj.color = {1, 1, 1, 1}
			elseif curPointsTypesId == "PP" or curPointsTypesId == "PB" then	
				point.symbol.iconObj.classKey = 'POINTDATACARTRIDGE_TRIANGLE'
				point.symbol.iconObj.color = {1, 0, 0, 1}	
			elseif curPointsTypesId == "Start Location" then	
				point.symbol.iconObj.classKey = 'POINTDATACARTRIDGE_ROUND'
				point.symbol.iconObj.color = {1, 1, 1, 1}		
			else			
				point.symbol.iconObj.classKey = 'POINTDATACARTRIDGE_ROUND'
				point.symbol.iconObj.color = {1, 0, 1, 1}
			end
			
			local selectedItem = lbPoints:getSelectedItem()
			if selectedItem and selectedItem.refPoint == point then
				point.symbol.iconObj.color = {0, 0, 0, 1}
			end
		else
			point.symbol.iconObj.classKey = 'POINTDATACARTRIDGE_ROUND'
			point.symbol.iconObj.color = {1, 1, 1, 1}
		end	
	end
end
				
-- красим и меняем иконки точки в дефолт 
function setIconsDefault(point)
	if point.symbol then
		point.symbol.iconObj.classKey = 'POINTDATACARTRIDGE_ROUND'
		point.symbol.iconObj.color = {1, 1, 1, 1}
	end
end

function hideLines()
	if linesForMap and linesForMap.Sequence1 then
		MapWindow.removeUserObjects({linesForMap.Sequence1, linesForMap.Sequence2, linesForMap.Sequence3})
		linesForMap.Sequence1.points = {}
		linesForMap.Sequence2.points = {}	
		linesForMap.Sequence3.points = {}
	end	
end

function createLinesForMap()
	linesForMap = module_mission.create_DataCartridgeLines()
end


function updateLines()
	if window == nil or window:getVisible() == false then
		hideLines()
		return
	end
	local line = {}
	if  curPointsTypesId == "Sequence 1 Blue" then
		line= linesForMap.Sequence1		
		line.color = {0, 0, 1, 1}	
	elseif curPointsTypesId == "Sequence 2 Red" then
		line= linesForMap.Sequence2	
		line.color = {1, 0, 0, 1}	
	elseif curPointsTypesId == "Sequence 3 Yellow" then
		line= linesForMap.Sequence3	
		line.color = {1, 1, 0, 1}	
	else
		
	end
	
	local GroupsPoints = unit.dataCartridge.GroupsPoints[curPointsTypesId]
	line.points = {}
	base.U.traverseTable(GroupsPoints,2)
	for i = 1, #GroupsPoints - 1 do
		local wpt = GroupsPoints[i]
		local wptn = GroupsPoints[i + 1]


		base.table.insert(line.points, wpt)
		base.table.insert(line.points, wptn)		
    end
	MapWindow.removeUserObjects({linesForMap.Sequence1, linesForMap.Sequence2, linesForMap.Sequence3})
    MapWindow.addUserObjects({line})
end

function updateUnitSystem()
	local unitSystem = OptionsData.getUnits()
	
	altEditBox:setUnitSystem(unitSystem)
	speedSpinBox:setUnitSystem(unitSystem)
end

-- функция для всех ла в миссии, не связана с текущим ла панели
function moveBullseyeInAllUnits(a_x, a_y)
	for k,v in base.pairs(module_mission.unit_by_id) do
		if v.dataCartridge then
			if v.dataCartridge.GroupsPoints 
				and v.dataCartridge.GroupsPoints["A/A Waypoint"] 
				and #v.dataCartridge.GroupsPoints["A/A Waypoint"] > 0 then
				local pt = v.dataCartridge.GroupsPoints["A/A Waypoint"][1]
				movePointData(pt, a_x, a_y)
				base.U.traverseTable(pt,2)
			end
		
		end
	end
end

