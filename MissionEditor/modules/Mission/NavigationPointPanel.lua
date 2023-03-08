local base = _G

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

local DialogLoader			= require('DialogLoader')
local CoalitionController	= require('Mission.CoalitionController')
local CoalitionUtils		= require('Mission.CoalitionUtils')
local i18n					= require('i18n')
local Button				= require('Button')
local Skin					= require('Skin')
local SkinUtils				= require('SkinUtils')
local U             		= require('me_utilities')
local UpdateManager 		= require('UpdateManager')
local DB 					= require('me_db_api')
local ComboList				= require('ComboList')
local ListBoxItem			= require('ListBoxItem')

local _ = i18n.ptranslate

local initialBounds_
local window_
local comboListCoalition_
local comboBoxCallsign_
local editBoxDescription_
local comboListScale_
local comboListSteer_
local comboListVnav_
local comboListVangle_
local spinBoxAngle_
local controller_
local navigationPointId_
local properties_
local navPointTypes = nil
local navPointTypesById_ = me_db_api.getTypesNavPointsById()
local clType
local pDefault	
local panelCustom 			
local Grid 					
local btnAdd 				
local buttonUp 				
local buttonDown 			
local eItemSkin 			
local btnDelSkin				
local bItemSkin				
local clItemSkin	
local insertRow			
local updateGrid


local function setController(controller)
	controller_ = controller
end

local function create(...)
	initialBounds_ = {...}
end

local function fillComboListCoalition()
	local coalitionNames = {
		CoalitionController.blueCoalitionName(),
		CoalitionController.redCoalitionName(),
		CoalitionController.neutralCoalitionName(),
	}
	
	CoalitionUtils.fillComboListCoalition(comboListCoalition_, coalitionNames, function(coalitionName)
		controller_.setNavigationPointCoalition(navigationPointId_, coalitionName)
	end)
end

local function fillClType()	
	if navPointTypes then
		for k, v in base.pairs(navPointTypes) do
			local item = ListBoxItem.new(v.displayName)
			clType:insertItem(item)
			item.id = v.id		
		end
	end

	clType:selectItem(clType:getItem(0))
end

local function getSelectedCoalition()
	return CoalitionUtils.getComboListCoalition(comboListCoalition_, true)
end

local function getSelectedType()
	return clType:getSelectedItem().id
end

local function fillComboBoxCallsign()
	local callsignNames = {}
	
	for name, worldId in pairs(controller_.getCallsigns()) do
		table.insert(callsignNames, name)
	end

	table.sort(callsignNames)
	
	for i, callsignName in ipairs(callsignNames) do
		comboBoxCallsign_:insertItem(ListBoxItem.new(callsignName))
	end
end

local function getSelectedCallsign()
	local item = comboBoxCallsign_:getSelectedItem() or comboBoxCallsign_:getItem(0)
	
	if item then
		return item:getText()
	end
	
	return ''
end

local function fillComboListScale()
	local infos = {
		{name = _('ENROUTE'),	scale = 0},
		{name = _('TERMINAL'),	scale = 1},		   
		{name = _('APPROACH'),	scale = 2},
		{name = _('HIGH ACC'),	scale = 3},
		{name = _('none'),		scale = 4}
	}
	
	for i, info in ipairs(infos) do
		local item = ListBoxItem.new(info.name)
		
		item.scale = info.scale
		
		comboListScale_:insertItem(item)
	end
	
	function comboListScale_:onChange(item)
		controller_.setNavigationPointScale(navigationPointId_, item.scale)
	end
end

local function fillComboListSteer()
	local infos = {
		{name = _('TO FROM'),  steer = 0},
		{name = _('DIRECT'),   steer = 1},
		{name = _('TO TO'),	   steer = 2},
		{name = _('none'),	   steer = 3}
	}
	
	for i, info in ipairs(infos) do
		local item = ListBoxItem.new(info.name)
		
		item.steer = info.steer
		
		comboListSteer_:insertItem(item)
	end
	
	function comboListSteer_:onChange(item)
		controller_.setNavigationPointSteer(navigationPointId_, item.steer)
	end
end

local function fillComboListVnav()
	local infos = {
		{name = _('2D'),	vnav = 0},
		{name = _('3D'),	vnav = 1},
		{name = _('none'),	vnav = 3}
	}
	
	for i, info in ipairs(infos) do
		local item = ListBoxItem.new(info.name)
		
		item.vnav = info.vnav
		
		comboListVnav_:insertItem(item)
	end
	
	function comboListVnav_:onChange(item)
		controller_.setNavigationPointVnav(navigationPointId_, item.vnav)
	end
end

local function fillComboListVangle()
	local infos = {
		{name = _('COMPUTED'),	vangle = 0},
		{name = _('ENTERED'),	vangle = 1},
	}
	
	for i, info in ipairs(infos) do
		local item = ListBoxItem.new(info.name)
		
		item.vangle = info.vangle
		
		comboListVangle_:insertItem(item)
	end
	
	function comboListVangle_:onChange(item)
		controller_.setNavigationPointVangle(navigationPointId_, item.vangle)
	end
end

local function getDefaulName(rowIndex)
	local result = "PROPERTY_"..rowIndex 

	return result
end

local function updateType(navigationPointId)
	local typeId = controller_.getNavigationPointType(navigationPointId)

	for i = 0, clType:getItemCount() - 1 do
		local item = clType:getItem(i)
		
		if item.id == typeId then
			clType:selectItem(item)			
			break
		end
	end
	
	if typeId == "Default" then
		panelCustom:setVisible(false)
		pDefault:setVisible(true)
	else
		panelCustom:setVisible(true)
		pDefault:setVisible(false)
	end
end

local function updateComboListCoalition(navigationPointId)
	local coalition = controller_.getNavigationPointCoalition(navigationPointId)
	
	CoalitionUtils.setComboListCoalition(comboListCoalition_, coalition)
end

local function updateComboBoxCallsign(navigationPointId)
	local name = controller_.getNavigationPointName(navigationPointId)
	
	-- иначе после каждого нажатия кнопки каретка перепрыгивает в начало строки
	if comboBoxCallsign_:getText() ~= name then
		comboBoxCallsign_:setText(name)
	end	
end

local function updateEditBoxDescription(navigationPointId)
	local description = controller_.getNavigationPointDescription(navigationPointId)
	
	editBoxDescription_:setText(description)
end

local function updateComboListScale(navigationPointId)
	local scale = controller_.getNavigationPointScale(navigationPointId)
	
	for i = 0, comboListScale_:getItemCount() - 1 do
		local item = comboListScale_:getItem(i)
		
		if item.scale == scale then
			comboListScale_:selectItem(item)
			
			break
		end
	end
end

local function updateComboListSteer(navigationPointId)
	local steer = controller_.getNavigationPointSteer(navigationPointId)
	
	for i = 0, comboListSteer_:getItemCount() - 1 do
		local item = comboListSteer_:getItem(i)
		
		if item.steer == steer then
			comboListSteer_:selectItem(item)
			
			break
		end
	end
end

local function updateComboListVnav(navigationPointId)
	local vnav = controller_.getNavigationPointVnav(navigationPointId)
	
	for i = 0, comboListVnav_:getItemCount() - 1 do
		local item = comboListVnav_:getItem(i)
		
		if item.vnav == vnav then
			comboListVnav_:selectItem(item)
			
			break
		end
	end
end

local function updateComboListVangle(navigationPointId)
	local vangle = controller_.getNavigationPointVangle(navigationPointId)
	
	for i = 0, comboListVangle_:getItemCount() - 1 do
		local item = comboListVangle_:getItem(i)
		
		if item.vangle == vangle then
			comboListVangle_:selectItem(item)
			
			break
		end
	end
end

local function updateSpinBoxAngle(navigationPointId)
	spinBoxAngle_:setValue(controller_.getNavigationPointAngle(navigationPointId))	
	spinBoxAngle_:setEnabled(controller_.getNavigationPointVangle(navigationPointId) == 1)
end

local function updateWidgets(navigationPointId)
	updateType(navigationPointId)
	updateComboListCoalition(navigationPointId)
	updateComboBoxCallsign(navigationPointId)
	updateEditBoxDescription(navigationPointId)
	
	local typeId = clType:getSelectedItem().id
	if typeId == 'Default' or typeId == nil then
		updateComboListScale(navigationPointId)
		updateComboListSteer(navigationPointId)
		updateComboListVnav(navigationPointId)
		updateComboListVangle(navigationPointId)
		updateSpinBoxAngle(navigationPointId)	
	end
		
	updateGrid()
end

local function bindControls()	
	function comboBoxCallsign_:onChange()
		if controller_ then
			controller_.setNavigationPointName(navigationPointId_, self:getText())
		end
	end
	
	function comboBoxCallsign_:onFocus(focused)
		if not focused then
			self:setText(controller_.getNavigationPointName(navigationPointId_))
		end
	end
	
	function editBoxDescription_:onFocus(focused)
		if not focused then
			if controller_ then
				controller_.setNavigationPointDescription(navigationPointId_, self:getText())
			end
		end
	end
	
	function editBoxDescription_:onKeyDown(key, unicode)
		if 'return' == key then
			local lineBegin, indexBegin, lineEnd, indexEnd = self:getSelectionNew()
			
			if controller_ then
				controller_.setNavigationPointDescription(navigationPointId_, self:getText())
				self:setSelectionNew(lineBegin, indexBegin, lineEnd, indexEnd)
			end
		end
	end
	
	fillClType()
	fillComboListCoalition()
	fillComboBoxCallsign()
	fillComboListScale()
	fillComboListSteer()
	fillComboListVnav()
	fillComboListVangle()
	
	function spinBoxAngle_:onChange()
		if controller_ then
			controller_.setNavigationPointAngle(navigationPointId_, self:getValue())
		end
	end
	
	function btnAdd:onChange(self)
		properties_ = properties_ or {}
		local cell1 = insertRow(getDefaulName(Grid:getRowCount()+1), "")
		Grid:selectRow(Grid:getRowCount()-1)
		Grid:setRowVisible(Grid:getRowCount()-1)
		cell1:setFocused(true)
		cell1:setSelectionNew(0, cell1:getLineTextLength(0), 0, cell1:getLineTextLength(0))
	end
	
	function buttonUp:onChange(self)
		local index = Grid:getSelectedRow()

		if index > 0 then
			UpdateManager.add(function()
				local index = Grid:getSelectedRow()
				local tmp = {}
				U.recursiveCopyTable(tmp, properties_[index+1]) 
				properties_[index+1] = properties_[index]
				properties_[index] = tmp
				if controller_ then
					controller_.setNavigationPointPropertiesCustom(navigationPointId_, properties_)
				end
				updateGrid()
				Grid:selectRow(index-1)
				return true
			end) 
		end
	end

	function buttonDown:onChange(self)
		local index = Grid:getSelectedRow()

		if index >= 0 and index < Grid:getRowCount()-1 then
			UpdateManager.add(function()
				local index = Grid:getSelectedRow()
				local tmp = {}
				U.recursiveCopyTable(tmp, properties_[index+2]) 
				properties_[index+2] = properties_[index+1]
				properties_[index+1] = tmp
				if controller_ then
					controller_.setNavigationPointPropertiesCustom(navigationPointId_, properties_)
				end
				updateGrid()
				Grid:selectRow(index+1)
				return true
			end) 
		end
	end	

	function Grid:onMouseDown(x, y, button)
		if 1 == button then
			local col
			col, rowLast = self:getMouseCursorColumnRow(x, y)
			if -1 < col and -1 < rowLast then
				self:selectRow(rowLast)
			end
		end
	end
	
	function clType:onChange()
		local item = clType:getSelectedItem()
		if navigationPointId_ then
			controller_.setNavigationPointType(navigationPointId_, item.id)
			local propertiesCustom = navPointTypesById_[item.id].propertiesCustom
			controller_.setNavigationPointPropertiesCustom(navigationPointId_, propertiesCustom)
			updateWidgets(navigationPointId_)
			controller_.navigationPointTypeChanged(navigationPointId_)
		end
		
		updateType(navigationPointId_)
	end
end

local hide
local function create_()
	local localization = {
		title		= _('INITIAL POINT'),
		coalition	= _('Coalition'),
		callsign	= _('Callsign'),
		comment		= _('Comment'),

		scale		= _('SCALE'),
		steer		= _('STEER'),
		vnav		= _('VNAV'),
		vangle		= _('VANGLE'),
		angle		= _('ANGLE'),
		
		Name		= _('Name'),
		Value		= _('Value'),
		add 		= _('Add'),
		Type		= _('Type'),
	}
	
	window_ = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_nav_point_panel.dlg', localization)
	
	if initialBounds_ then
		window_:setBounds(unpack(initialBounds_))
		w_=initialBounds_[3]
	end
	
	function window_:onClose()
		hide()
		MapWindow.expand()
	end	
	
	clType					= window_.clType
	pDefault				= window_.pDefault
	comboListCoalition_		= window_.comboListCoalition
	comboBoxCallsign_		= window_.comboBoxCallsign
	editBoxDescription_		= window_.editBoxDescription
	comboListScale_			= pDefault.comboListScale
	comboListSteer_			= pDefault.comboListSteer
	comboListVnav_			= pDefault.comboListVnav
	comboListVangle_		= pDefault.comboListVangle
	spinBoxAngle_			= pDefault.spinBoxAngle
	panelCustom 			= window_.panelCustom
	Grid 					= panelCustom.Grid
	btnAdd 					= panelCustom.btnAdd
	buttonUp 				= panelCustom.buttonUp
	buttonDown 				= panelCustom.buttonDown
	
	eItemSkin 				= window_.pNoVisible.eItem:getSkin()
	btnDelSkin				= window_.pNoVisible.btnDel:getSkin()
	bItemSkin				= window_.pNoVisible.bItem:getSkin()
	clItemSkin				= window_.pNoVisible.clItem:getSkin()
	
	navPointTypes = DB.getTypesNavPoints()

	bindControls()
end

local function enableWidgets(enabled)
	comboListCoalition_	:setEnabled(enabled)
	comboBoxCallsign_	:setEnabled(enabled)
	editBoxDescription_	:setEnabled(enabled)
	comboListScale_		:setEnabled(enabled)
	comboListSteer_		:setEnabled(enabled)
	comboListVnav_		:setEnabled(enabled)
	comboListVangle_	:setEnabled(enabled)
	spinBoxAngle_		:setEnabled(enabled)
	clType				:setEnabled(enabled)
end

local function needUpdate()
	return window_ and window_:getVisible() and controller_
end

local function update(navigationPointId)
	if needUpdate() then
		if navigationPointId then
			enableWidgets(true)
			updateWidgets(navigationPointId)
		else
			enableWidgets(false)
		end
	end	
end

local function navigationPointNameChanged(navigationPointId)
	if needUpdate() and navigationPointId_ == navigationPointId then
		updateComboBoxCallsign(navigationPointId)
	end
end

local function navigationPointDescriptionChanged(navigationPointId)
	if needUpdate() and navigationPointId_ == navigationPointId then
		updateEditBoxDescription(navigationPointId)
	end
end

local function navigationPointScaleChanged(navigationPointId)
	if needUpdate() and navigationPointId_ == navigationPointId then
		updateComboListScale(navigationPointId)
	end	
end

local function navigationPointSteerChanged(navigationPointId)
	if needUpdate() and navigationPointId_ == navigationPointId then
		updateComboListSteer(navigationPointId)
	end	
end

local function navigationPointVnavChanged(navigationPointId)
	if needUpdate() and navigationPointId_ == navigationPointId then
		updateComboListVnav(navigationPointId)
	end	
end

local function navigationPointVangleChanged(navigationPointId)
	if needUpdate() and navigationPointId_ == navigationPointId then
		updateComboListVangle(navigationPointId)
		updateSpinBoxAngle(navigationPointId)
	end	
end

local function navigationPointAngleChanged(navigationPointId)
	if needUpdate() and navigationPointId_ == navigationPointId then
		updateSpinBoxAngle(navigationPointId)
	end	
end

local function navigationPointCoalitionChanged(navigationPointId)
	if needUpdate() and navigationPointId_ == navigationPointId then
		updateComboListCoalition(navigationPointId)
	end	
end

local function show()
	if not window_ then
		create_()
	end
	
	if not window_:getVisible() then
		MapWindow.collapse(w_, 0)
		window_:setVisible(true)
		
		update(navigationPointId_)
		
		if controller_ then
			controller_.onNavigationPointPanelShow()
		end		
	end
end

-- объявлена выше
hide = function()
	if window_ then		
		if window_:getVisible() then
			MapWindow.expand()
			window_:setVisible(false)
			
			if controller_ then
				controller_.onNavigationPointPanelHide()
			end			
		end	
	end
end

local function setNavigationPointId(navigationPointId)
	navigationPointId_ = navigationPointId
	update(navigationPointId_)
end

local function getNavigationPointId()
	return navigationPointId_
end

local function navigationPointPropertiesChanged()
	if needUpdate() and navigationPointId_ then
		updateGrid()
	end	
end	

local function compareThreats(tab1, tab2)
	return tab1.name < tab2.name
end

-- объявлена выше
function insertRow(a_prop)
	local rowIndex = Grid:getRowCount()
	local optIndex = rowIndex + 1
    Grid:insertRow(20,rowIndex)
	properties_[optIndex] = properties_[optIndex] or {}
	
    ------1
	local cell_1	
	cell_1 = EditBox.new()
	cell_1:setSkin(eItemSkin)   
	cell_1:setText(a_prop.key)	
	cell_1:setTooltipText(a_prop.key)	
	cell_1.propName = a_prop.key
	cell_1.optIndex = optIndex

	cell_1.onChange = function(self)
		properties_[self.optIndex]["key"] = self:getText()
		if controller_ then
			controller_.setNavigationPointPropertiesCustom(navigationPointId_, properties_)
		end
		self.propName = self:getText()
	end
	
	if a_prop.noEditKey == true then
		cell_1:setEnabled(false)
	else
		cell_1:setTabOrder(tabOrderIndex) 
		tabOrderIndex = tabOrderIndex + 1
	end
    Grid:setCell(0, rowIndex, cell_1)
	properties_[optIndex]["key"] = cell_1:getText()  
    
    ------2
	local cell_2
	if a_prop.type == "button" then
		cell_2 = Button.new()
		cell_2:setSkin(bItemSkin) 
		cell_2.firstCall = cell_1
		cell_2.propName = a_prop.key
		
		cell_2:setTabOrder(tabOrderIndex) 
		tabOrderIndex = tabOrderIndex + 1
		
		for k,modul in base.pairs(managerModulesME.modulesME) do
			if a_prop.callbackShowTypesThreats and modul[a_prop.callbackShowTypesThreats] ~= nil then
				cell_2.onChange = function(self)
					local function callbackThreat(a_value)
						properties_[self.firstCall.optIndex]["value"] = a_value
						propertiesByKey["Horizontal Range"].value = nil
						propertiesByKey["Vertical Range"].value = nil	
						propertiesByKey["Minimum Slant Angle"].value = nil 
						propertiesByKey["Maximum Slant Angle"].value = nil	
						if controller_ then
							controller_.setNavigationPointPropertiesCustom(navigationPointId_, properties_)
						end
						UpdateManager.add(function()
							updateGrid() 
							return true
						end) 						
					end
					local x,y =Grid:widgetToWindow(0, 0)
					modul[a_prop.callbackShowTypesThreats](x-355, y, callbackThreat)					
				end
			elseif a_prop.callbackShowSelectingDialog and modul[a_prop.callbackShowSelectingDialog] ~= nil then
				cell_2.onChange = function(self)
					local function callbackBtn(a_value)
						properties_[self.firstCall.optIndex]["value"] = a_value
						if controller_ then
							controller_.setNavigationPointPropertiesCustom(navigationPointId_, properties_)
						end
						UpdateManager.add(function()
							updateGrid() 
							return true
						end) 						
					end
					local x,y =Grid:widgetToWindow(0, 0)
					modul[a_prop.callbackShowSelectingDialog](x-375, y, callbackBtn, a_prop.key)					
				end
			end
			
		end
		cell_2:setText(a_prop.value)
		properties_[optIndex]["value"] = cell_2:getText()	
	elseif a_prop.type == "comboList" then	
		cell_2 = ComboList.new()
		cell_2:setSkin(clItemSkin) 
		cell_2.firstCall = cell_1
		cell_2.propName = a_prop.key
		
		cell_2:setTabOrder(tabOrderIndex) 
		tabOrderIndex = tabOrderIndex + 1

		local curThreatType
		local curThreatId
		for k,modul in base.pairs(managerModulesME.modulesME) do
			if a_prop.callbackGetThreats and modul[a_prop.callbackGetThreats] ~= nil then				
				curThreatType = propertiesByKey["ThreatType"].value
				curThreatId = propertiesByKey["Threat"].value
				
				base.print("--curThreatType--",curThreatType, curThreatId)
				local threats = modul[a_prop.callbackGetThreats](curThreatType)
				base.table.sort(threats, compareThreats)
				
				local curItemIndex							
				for kk, vv in base.ipairs(threats) do
					local item = ListBoxItem.new(vv.name)
					item.id = vv.id
					item["Horizontal Range"] 	= vv.range[1]
					item["Vertical Range"] 		= vv.range[2]
					item["Minimum Slant Angle"] = vv.slant[1]
					item["Maximum Slant Angle"] = vv.slant[2]
					cell_2:insertItem(item)
					
					if curItemIndex == nil then 
						curItemIndex = kk
					end
					if vv.id == curThreatId then
						curItemIndex = kk
					end
				end

				cell_2:selectItem(cell_2:getItem(curItemIndex-1))
				properties_[cell_1.optIndex]["value"] = cell_2:getSelectedItem().id	
				local selectedItem = cell_2:getItem(curItemIndex-1)
				propertiesByKey["Horizontal Range"].value 		= propertiesByKey["Horizontal Range"].value or selectedItem["Horizontal Range"] 
				propertiesByKey["Vertical Range"].value 		= propertiesByKey["Vertical Range"].value or selectedItem["Vertical Range"] 	
				propertiesByKey["Minimum Slant Angle"].value 	= propertiesByKey["Minimum Slant Angle"].value or selectedItem["Minimum Slant Angle"] 
				propertiesByKey["Maximum Slant Angle"].value 	= propertiesByKey["Maximum Slant Angle"].value or selectedItem["Maximum Slant Angle"] 
											
				if controller_ then
					controller_.setNavigationPointPropertiesCustom(navigationPointId_, properties_)
				end
			end
			
			cell_2.onChange = function(self)
				local selectedItem = self:getSelectedItem()
				properties_[self.firstCall.optIndex]["value"] = selectedItem.id
				propertiesByKey["Horizontal Range"].value = selectedItem["Horizontal Range"] 
				propertiesByKey["Vertical Range"].value = selectedItem["Vertical Range"] 	
				propertiesByKey["Minimum Slant Angle"].value = selectedItem["Minimum Slant Angle"] 
				propertiesByKey["Maximum Slant Angle"].value = selectedItem["Maximum Slant Angle"] 	

				if controller_ then
					controller_.setNavigationPointPropertiesCustom(navigationPointId_, properties_)
				end	
				UpdateManager.add(function()
					updateGrid() 
					return true
				end) 			
			end	
		end
		properties_[optIndex]["value"] = cell_2:getSelectedItem().id
	else
		cell_2 = EditBox.new()
		cell_2:setSkin(eItemSkin)
		cell_2.firstCall = cell_1
		cell_2.propName = a_prop.key
		
		cell_2:setText(a_prop.value)
		
		cell_2.onChange = function(self)
			properties_[self.firstCall.optIndex]["value"] = self:getText()
			if controller_ then
				controller_.setNavigationPointPropertiesCustom(navigationPointId_, properties_)
			end
		end
		
		cell_2:setTabOrder(tabOrderIndex) 
		tabOrderIndex = tabOrderIndex + 1

		properties_[optIndex]["value"] = cell_2:getText()
	end

    Grid:setCell(1, rowIndex, cell_2)
	
	------3
	local cell_3
    cell_3 = Button.new()
	cell_3:setSkin(btnDelSkin) 
	cell_3.propName = a_prop.key	
	
	if a_prop.noEditKey == true then
		cell_3:setEnabled(false)
	end
	
    cell_3.onChange = function(self)
		UpdateManager.add(function()
			local index = Grid:getSelectedRow()
			table.remove(properties_, index+1)
			if controller_ then
				controller_.setNavigationPointPropertiesCustom(navigationPointId_, properties_)
			end
			UpdateManager.add(function()
				updateGrid() 
				return true
			end) 
			return true 
		end) 
    end
	cell_3:setText(a_prop.value)
    Grid:setCell(2, rowIndex, cell_3)
	

	return cell_1
end

-- объявлена выше
function updateGrid() 
	Grid:clearRows()
	properties_ = {}
	propertiesByKey = {}
	tabOrderIndex = 1
	if navigationPointId_ then
		properties_ = controller_.getNavigationPointPropertiesCustom(navigationPointId_)
	end
	
	if properties_ then
		for k,v in ipairs(properties_) do
			propertiesByKey[v.key] = v
		end
		for k,v in ipairs(properties_) do
			insertRow(v)
		end
	end	
end	


return {
	setController						= setController,
	create								= create,
	show								= show,
	hide								= hide,
	setNavigationPointId				= setNavigationPointId,
	getNavigationPointId				= getNavigationPointId,
	getSelectedCoalition				= getSelectedCoalition,
	getSelectedCallsign					= getSelectedCallsign,
	getSelectedType						= getSelectedType,
	navigationPointNameChanged			= navigationPointNameChanged,
	navigationPointDescriptionChanged	= navigationPointDescriptionChanged,
	navigationPointScaleChanged			= navigationPointScaleChanged,
	navigationPointSteerChanged			= navigationPointSteerChanged,
	navigationPointVnavChanged			= navigationPointVnavChanged,
	navigationPointVangleChanged		= navigationPointVangleChanged,
	navigationPointAngleChanged			= navigationPointAngleChanged,
	navigationPointCoalitionChanged		= navigationPointCoalitionChanged,
	navigationPointPropertiesChanged	= navigationPointPropertiesChanged,
}