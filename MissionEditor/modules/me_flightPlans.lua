local base = _G

module('me_flightPlans')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local print = base.print
local table = base.table
local string = base.string
local tonumber = base.tonumber
local tostring = base.tostring
local assert = base.assert
local math = base.math

local DialogLoader				= require('DialogLoader')
local U 						= require('me_utilities')
local ListBoxItem				= require('ListBoxItem')
local NavigationPointController	= require('Mission.NavigationPointController')
local module_mission 			= require('me_mission')
local Static            		= require('Static')
local MapWindow					= require('me_map_window')
local ColorSelector				= require('me_select_color')
local BuddyWindow 				= require('BuddyWindow')
local SkinUtils 				= require('SkinUtils')
local UC						= require('utils_common')
local Panel 					= require('Panel')
local SpinBox					= require('SpinBox')
local OptionsData 				= require('Options.Data')
local UpdateManager 			= require('UpdateManager')

local flightPlans
local countName = 0
local curFlightPlan
local selectedPlans = {}

local cdata = 
	{
	
	}
	
function create()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_flightPlans.dlg', cdata)
	window:setBounds(100, 100, 520, 550)
	window:addSizeCallback(windowSizeCallback)
	
	pFPlans 		= window.pFPlans
	pEditFPlan		= window.pEditFPlan
	pPoints			= window.pPoints
	pNoVisible		= window.pNoVisible
		
	bAddPlan		= pFPlans.bAddPlan	
	spFPlans		= pFPlans.spFPlans
	bDelSelected	= pFPlans.bDelSelected
	bExportSelected = pFPlans.bExportSelected
	bAddPoint		= pEditFPlan.bAddPoint
	bToFPlans		= pEditFPlan.bToFPlans
	bToEditFPlans	= pPoints.bToEditFPlans
	lbListPoints	= pPoints.lbListPoints
	pFPlansTmpl		= window.pFPlansTmpl
	gridPoints		= pEditFPlan.gridPoints
	eName			= pEditFPlan.eName
	
	
	
	gridStaticSkin		= pNoVisible.gridStatic:getSkin()
	pFPlansNormalSkin	= pNoVisible.pFPlansNormal:getSkin()
	pFPlansSelSkin		= pNoVisible.pFPlansSel:getSkin()
	pCellGridSkin		= pNoVisible.pCellGrid:getSkin()
	sbGridCellSkin		= pNoVisible.sbGridCell:getSkin()
	sGridCellUnitSkin	= pNoVisible.sGridCellUnit:getSkin()
	
	
	bAddPlan.onChange 		= onChange_bAddPlan
	bAddPoint.onChange 		= onChange_bAddPoint
	bToFPlans.onChange 		= onChange_bToFPlans
	bToEditFPlans.onChange 	= onChange_bToEditFPlans
	lbListPoints.onChange 	= onChange_lbListPoints
	bDelSelected.onChange 	= onChange_bDelSelected
	eName.onFocus			= onFocus_eName
	
	
	
	pEditFPlan:setVisible(false)
	pPoints:setVisible(false)
	pEditFPlan:setPosition(0,0)
	pPoints:setPosition(0,0)
	
	colorSelector_		= ColorSelector.new()
	windowColor_		= BuddyWindow.new()
						
	local colorPanel	= colorSelector_:getPanel()
	
	windowColor_:setBuddyWidget	(colorPanel)
	windowColor_:insertWidget	(colorPanel)
	windowColor_:setSize		(colorPanel:getSize())
	
	windowColor_:addKeyDownCallback(function(self, key, unicode)
		if 	'escape' == key or 
			'return' == key then
			windowColor_:setVisible(false)
			
			return true -- чтобы по escape не закрывалась панель рисования
		end
	end)

	reSize()
end	


function show(b)
	if b then
		if not window then
			create()
		end			
	else
		if window then
			window:setVisible(false)
		end
		return
	end
	
	module_mission.mission.flightPlans = module_mission.mission.flightPlans or {}
	flightPlans = module_mission.mission.flightPlans
	onChange_bToFPlans()
	
	window:setVisible(b)
	
	if b then
		updateUnitSystem()
	end
end	

function onFocus_eName(self, focused)
	if not focused then
		local newName = self:getText()
	
		while verifyName(newName, curFlightPlan.name) ~= true do
			countName = countName + 1
			newName = self:getText().." "..countName
		end
		curFlightPlan.name = newName
	end
end
	
function onChange_bAddPlan()
	pFPlans:setVisible(false)
	pEditFPlan:setVisible(true)
	pPoints:setVisible(false)
	
	createFPlan()
	updateGridPoints()
end

function onChange_bAddPoint()
	pFPlans:setVisible(false)	
	pEditFPlan:setVisible(false)
	pPoints:setVisible(true)
	 
	updateListPoints()
end

function onChange_bToFPlans()
	pFPlans:setVisible(true)
	pEditFPlan:setVisible(false)
	pPoints:setVisible(false)
	
	updateListFPlans()
end

function onChange_bToEditFPlans()
	pFPlans:setVisible(false)
	pEditFPlan:setVisible(true)		
	pPoints:setVisible(false)

	updateGridPoints()	
end

function insert_wpt(a_id)
	local navPoint = NavigationPointController.getNavigationPoint(a_id)		
	local wpt = {pointId = a_id, boss = curFlightPlan, alt = 1000, speed = 300}
	wpt.x, wpt.y = navPoint:getPosition()
	base.table.insert(curFlightPlan.points,	wpt)	
	local symbol = module_mission.create_flightPoint_symbol(wpt)
	base.table.insert(curFlightPlan.mapObjects.points, symbol)
	
	return wpt
end

function onChange_lbListPoints(self)
	local selectedItem = self:getSelectedItem()
	if selectedItem then
		local wpt = insert_wpt(selectedItem.id)
		onChange_bToEditFPlans()
		module_mission.linkToSnap(wpt, selectedItem.id, "navPoint")
		module_mission.build_fp_route_line(curFlightPlan)
		module_mission.update_flightPlan_map_objects(curFlightPlan)
	end
end

function onChange_bDelSelected(self)
	local toRemove = {}
	for k,v in base.pairs(selectedPlans) do
		for kk,vv in base.pairs(flightPlans) do
			if vv.name == k then
				base.table.insert(toRemove, kk)
			end
		end
	end
	
	base.table.sort(toRemove)
	
	for i = #toRemove, 1, -1 do	
		base.table.remove(flightPlans, toRemove[i])
	end
	
	selectedPlans = {}
	
	updateListFPlans()
end

function onChange_bSetPosToFirst(self)
	if self.FPlan.points[1] then
		local navPoint = NavigationPointController.getNavigationPoint(self.FPlan.points[1].pointId)
		local x,y = navPoint:getPosition()
		MapWindow.focusPointMap(x, y)
	end
end

function onChange_tbHide(self)
	if self:getState() == true then
		self.FPlan.hidden = true
	else
		self.FPlan.hidden = false
	end
	module_mission.update_flightPlan_map_objects(self.FPlan)
end

function onChange_bSelect(self)
	self.parent.isSelect = not self.parent.isSelect
	if self.parent.isSelect == false then
		self.parent:setSkin(pFPlansNormalSkin)
		selectedPlans[self.parent.k] = nil
	else
		self.parent:setSkin(pFPlansSelSkin)
		selectedPlans[self.parent.FPlan.name] = self.parent.FPlan
	end
end
	
function onChange_buttonColor(self)
	local bw, bh = self:getSize()
	local wx, wy = self:widgetToWindow(0, bh)
	local colorString

	function onColorChange(r, g, b, a)
		local colorString = string.format('0x%.2x%.2x%.2x%.2x', r, g, b, a)

		self:setSkin(SkinUtils.setButtonColor(colorString, self:getSkin()))
		self.parent.FPlan.color = colorString
		for k,v in base.pairs(self.parent.FPlan.mapObjects.points) do
			v.color = UC.colorFromString(colorString)
		end
		
		self.parent.FPlan.mapObjects.line.color = UC.colorFromString(colorString)
		
		module_mission.update_flightPlan_map_objects(self.parent.FPlan)
	end

	colorSelector_	:setCallback(onColorChange)
	colorSelector_	:setColor	(UC.parseColorString(self.parent.FPlan.color))
	windowColor_	:setPosition(wx, wy)
	windowColor_	:setVisible	(true)
end

function windowSizeCallback()
	reSize()
end

function reSize()
	local wWin, hWin = window:getSize()
	
	pFPlans:setSize(wWin, hWin-50)
	pEditFPlan:setSize(wWin, hWin-50)
	pPoints:setSize(wWin, hWin-50)
	
	spFPlans:setSize(wWin-10, hWin-140)
	gridPoints:setSize(wWin-10, hWin-140)
	lbListPoints:setSize(wWin-20, hWin-140)
	
	bDelSelected:setPosition((wWin-230)/2, hWin-70)
	bExportSelected:setPosition((wWin-230)/2+125, hWin-70)
	
	
	
end


function updateListPoints()
	lbListPoints:clear()
	
	for k,id in pairs(NavigationPointController.getNavigationPointIds()) do
		local navPoint = NavigationPointController.getNavigationPoint(id)

		local item = ListBoxItem.new(navPoint:getName())
		item.id = navPoint:getId()
		lbListPoints:insertItem(item)
	end
end

function verifyName(a_name, a_excludePlan)
	for i, plan in ipairs(flightPlans) do
		if plan.name == a_name and a_excludePlan ~= plan.name then
			return false
		end
	end
	
	return true
end

function createFPlan()
	local newName = "Flight Plan "..countName
	
	while verifyName(newName) ~= true do
		countName = countName + 1
		newName = "Flight Plan "..countName
	end
	
	local date 	= base.os.date('*t')
	local dateStr 	= string.format("%2i/%02i/%i %i:%02i", date.day, date.month, date.year, date.hour, date.min)
	
	local FPlan = {
		name 	= newName,
		dateStr = dateStr,
		points	= {},
		mapObjects = {},
		color 	= '0x00ff00ff',
		type	= 'FlightPlan',
		hidden 	= false
	}
	FPlan.mapObjects.points = {}
	FPlan.mapObjects.line	= {}
	
	curFlightPlan = FPlan
	
	base.table.insert(flightPlans, FPlan)
end

function updateListFPlans()
	spFPlans:clear()
	local wWin, hWin = window:getSize()
	
	local offsetY = 0
	if flightPlans then
		for k,v in base.ipairs(flightPlans) do
			offsetY = (k-1)*120
			local pFPlansTmp = pFPlansTmpl:clone()
		
			pFPlansTmp.sName:setText(v.name)
			pFPlansTmp.sDate:setText(v.dateStr)
			pFPlansTmp:setVisible(true)
			pFPlansTmp:setBounds(0, offsetY, 490, 120)
			pFPlansTmp.bSetPosToFirst.FPlan = v
			pFPlansTmp.tbHide.FPlan = v
			pFPlansTmp.k = k
			pFPlansTmp.FPlan = v
			pFPlansTmp:addMouseUpCallback(function(self, x, y, button)
				if button == 1 then
					curFlightPlan = v
					onChange_bToEditFPlans()
				end
			end)		
			pFPlansTmp.bSetPosToFirst:addChangeCallback(onChange_bSetPosToFirst)			
			pFPlansTmp.tbHide:setState(v.hidden)
			pFPlansTmp.tbHide:addChangeCallback(onChange_tbHide)
			pFPlansTmp.isSelect = false
			pFPlansTmp.bSelect.parent = pFPlansTmp
			pFPlansTmp.bSelect:addChangeCallback(onChange_bSelect)
			if selectedPlans[v.name] ~= nil then
				pFPlansTmp:setSkin(pFPlansSelSkin)
			else
				pFPlansTmp:setSkin(pFPlansNormalSkin)
			end
			
			pFPlansTmp.bFillColor.parent = pFPlansTmp
			pFPlansTmp.bFillColor:addChangeCallback(onChange_buttonColor)		
			if v.color then
				pFPlansTmp.bFillColor:setSkin(SkinUtils.setButtonColor(v.color, pFPlansTmp.bFillColor:getSkin()))
			end
			
			spFPlans:insertWidget(pFPlansTmp)
		end
	end	
end

function updateGridPoints()
	eName:setText(curFlightPlan.name)
	gridPoints:removeAllRows()

	local rowIndex = 0
	local prevPoint = nil
	local dist = 0
    for k,v in base.ipairs(curFlightPlan.points) do
		local navPoint = NavigationPointController.getNavigationPoint(v.pointId)
		
		propertiesC = NavigationPointController.getNavigationPointPropertiesCustom(v.pointId)
	
        gridPoints:insertRow(20)

        local cell = Static.new()
        cell:setSkin(gridStaticSkin)
        cell:setText(navPoint:getName())
        gridPoints:setCell(0, rowIndex, cell)
		
		cell = Panel.new()
        cell:setSkin(pCellGridSkin)
        cell:setText(navPoint:getName())
        gridPoints:setCell(1, rowIndex, cell)
		
		local sbAlt = SpinBox.new()
		sbAlt:setSkin(sbGridCellSkin)
		sbAlt:setBounds(0,0,80,18)
		sbAlt:setRange(0, 999999)
		sbAlt.parentCell = cell
		sbAlt.onChange = function(self)
			v.alt = self.parentCell.altSpinBox:getValue()
		end
		sbAlt:addFocusCallback(function(self)
			if self:getFocused() == true then
			else
				UpdateManager.add(function()			
					updateGridPoints()	
					return true 		
				end)
			end
		end)
		cell:insertWidget(sbAlt)
		
		local sAltUnit = Static.new("m")
		sAltUnit:setSkin(sGridCellUnitSkin)
		sAltUnit:setBounds(85,0,40,18)			
		cell:insertWidget(sAltUnit)
		
		cell.altSpinBox = U.createUnitSpinBox(sAltUnit, sbAlt, U.altitudeUnits, sbAlt:getRange())
		cell.altSpinBox:setValue(v.alt or 0)
		
		cell = Panel.new()
        cell:setSkin(pCellGridSkin)
        cell:setText(navPoint:getName())
        gridPoints:setCell(2, rowIndex, cell)
		
		local sbSpd = SpinBox.new()
		sbSpd:setSkin(sbGridCellSkin)
		sbSpd:setBounds(0,0,70,18)
		sbSpd:setRange(0, 9999)
		sbSpd.parentCell = cell
		sbSpd.onChange = function(self)
			v.speed = self.parentCell.speedSpinBox:getValue()		
		end
		cell:insertWidget(sbSpd)
		
		local sSpdUnit = Static.new("m/c")
		sSpdUnit:setSkin(sGridCellUnitSkin)
		sSpdUnit:setBounds(75,0,40,18)
		cell:insertWidget(sSpdUnit)
		
		cell.speedSpinBox = U.createUnitSpinBox(sSpdUnit, sbSpd, U.speedUnits, sbSpd:getRange())
		cell.speedSpinBox:setValue(v.speed or 0)

		local cell = Static.new("123456789")
        cell:setSkin(gridStaticSkin)
        gridPoints:setCell(3, rowIndex, cell)
		
		if prevPoint == nil then
			cell:setText(0)
		else
			local dx = prevPoint.x - v.x
			local dy = prevPoint.y - v.y
			local dz = prevPoint.alt - v.alt
			local distLastSegment = base.math.sqrt(dx * dx + dy * dy + dz * dz)
			dist = base.math.floor(dist + distLastSegment+0.5)
			cell:setText(dist)
		end
		
		prevPoint = v
		
        rowIndex = rowIndex + 1
    end
	updateUnitSystem()
end

function updateUnitSystem()
	local unitSystem = OptionsData.getUnits()
	
	for i = 1, gridPoints:getRowCount() do
		gridPoints:getCell(2, i-1).speedSpinBox:setUnitSystem(unitSystem)
		gridPoints:getCell(1, i-1).altSpinBox:setUnitSystem(unitSystem)		
	end

end
