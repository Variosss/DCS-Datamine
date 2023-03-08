--The panel for editing action.
--Interface:
--	1. Create.
--	2. Show/hide.
--	3. Set group, waypoint and action.
--  4. Group task change event
--  5. Condition change event
--  6. Handle map unit selection event
--  7. Handle target moved event

local base = _G

module('me_action_edit_panel')

local require 				= base.require
local ipairs				= base.ipairs
local pairs					= base.pairs
local table					= base.table
local print 				= base.print
local string				= base.string

local DialogLoader 			= require('DialogLoader')
local SkinUtils  			= require('SkinUtils')
local SpinWPT				= require('me_spin_wpt')
	
local MapWindow				= require('me_map_window')
local Terrain				= require('terrain')
local TEMPL					= require('me_template')
	
local U 					= require('me_utilities')
local DB					= require('me_db_api')
local crutches 				= require('me_crutches')
	
local widgetFactory 		= require('me_action_panel_widget_factory')
local actionParamPanels 	= require('me_action_param_panels')
local panelActionCondition	= require('me_action_condition')
local actionMapObjects		= require('me_action_map_objects')
local actionDB				= require('me_action_db')
local panel_route = 			require('me_route')
	
local Mission 				= require('me_mission')
local FileDialog 			= require('FileDialog')
local FileDialogFilters		= require('FileDialogFilters')
local MeSettings 			= require('MeSettings')
local vehicle				= require('me_vehicle')
local OptionsData			= require('Options.Data')
local mod_dictionary        = require('dictionary')

local ListBoxItem       	= require('ListBoxItem')
local UpdateManager			= require('UpdateManager')
local Serializer 			= require('Serializer')
local lfs					= require('lfs')
local AirdromeData		    = require('Mission.AirdromeData')
local log      				= require('log')

if base.DEBUG then
	base.dofile('Scripts/Database/db_attributes.lua')
end

require('i18n').setup(_M)

local defaultValueComboListItemTextColor = '0xfff0ffff'
local invalidValueComboListItemTextColor = '0xff0000ff'
local winH = 0

local vdata = {
	group			= nil,
	wpt				= nil,
	task			= nil,
	actionParams	= nil,
	groupTask		= nil,
	curParamPanel	= nil,
	mapObjects		= nil,
	actionsListBox	= nil
}

local staticWidth = 1.5 * U.text_w
local staticHeight = U.widget_h

local function createStatic(text, x, y, w, h)
	-- почти все статики создаются в одном и том же месте
	return widgetFactory.createStatic(text, x or 0, y or 0, w or staticWidth, h or staticHeight)
end

local getUnits = OptionsData.getUnits

--Controls
function create(x, y, w, h)
	local cdata = {
		action_type 			= _('TYPE'),
		action 					= _('ACTION'),
		number 					= _('NUMBER'),
		name 					= _('NAME'),
		enable 					= _('ENABLE TASK'),
		condition 				= _('CONDITION...'),
		stopCondition 			= _('STOP CONDITION...'),
		template				= _('TEMPLATE'),
		actionNumberToolTip		= _('Selects current action of the waypoint'),
		actionNameToolTip		= _('Name of the action in Mission Editor.\nJust a helper.'),
		actionEnableToolTip		= _('Disables / enables the action'),
		conditionToolTip 		= _('Determines will the action be performed or skipped'),
		stopConditionToolTip 	= _('The condition to stop the task'),
        startConditionToolTip 	= _('The condition to start the task'),
		selectActionTypeToolTip = _('Select action type'),
		selectActionToolTip		= _('Select action'),
		vehicleGroup 			= _('VEHICLE GROUP'),
		zoneRadius				= _('ZONE RADIUS'),
		bindingToTransport		= _('Binding to transport'),
		toLargeGroup 			= _('The group is too big for embarking, do you want to reduce it?'),
		yes						= _('Yes'),
		no						= _('No'),
		cancel					= _('Cancel'),
		warning					= _('Warning'),
	}

	--window
	local window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/action_edit_panel.dlg', cdata)
	winH = h
	window:setBounds(x, y, w, h)
	
	widgetFactory.initSkins(window)
	
	--Actions has common parameters and special parameters
	--Section of common action parameters (type, id, name, number, conditions)
	
	--box
	local box = window.panel
	local box_w, box_h = window.panel:getSize()
	
    --1. Action Type	
	local actionTypeComboList = box.actionTypeComboList
	
	do
		local rawItems = {}
		for actionType, data in ipairs(actionDB.actionTypeData) do
			base.table.insert(rawItems, { name = data.displayName, value = actionType} )
		end
		U.fillComboList(actionTypeComboList, rawItems)
	end	
	
    --2. Action
	local actionComboList = box.actionComboList
	
	--3. Number
	local numberSpin = box.numberSpin	
	numberSpin:setTooltipText(cdata.actionNumberToolTip)
	
	--5. Enable
	local enableCheckBox = box.enableCheckBox
	enableCheckBox:setTooltipText(cdata.actionEnableToolTip)
	
	--6. Name	
	local nameEditBox = box.nameEditBox

	--7. Start Conditions
	local conditionButton = box.conditionButton
	
	--8. Stop Conditions
	local stopConditionButton = box.stopConditionButton
	
	--Control handlers
	local paramPanels = {}
	local paramPanelConstructors = nil
	
	--получение панели параметров по id задачи
	local function getParamPanel(actionId)		
		local paramPanel = paramPanels[actionId]
		if paramPanel ~= nil then
			return paramPanel
		else
			local paramPanelConstructor = paramPanelConstructors[actionId]
			if paramPanelConstructor ~= nil then
				paramPanel = paramPanelConstructor()
				base.assert(paramPanel ~= nil)
				base.setmetatable(paramPanel, actionParamPanels.ActionParamHandler)
				paramPanels[actionId] = paramPanel
			end
			return paramPanel
		end
	end
	
	--функция меняющая доступные параметры при смене задачи
	local function changeParamPanel()
	
		if vdata.curParamPanel then
			if vdata.curParamPanel.close ~= nil then
				vdata.curParamPanel:close()
			end
			vdata.curParamPanel:close(false)
		end
		if vdata.task then
			vdata.curParamPanel = getParamPanel(vdata.actionId)
			if vdata.curParamPanel then
				vdata.curParamPanel:open(vdata)
			end			
		end
	end

	--Fill action combo box with actions of assigned type
	local function fillActionComboList(actionType, currentActionId)
		local actions = actionDB.availableActions[vdata.group.type][actionType][vdata.groupTask] or 
						actionDB.availableActions[vdata.group.type][actionType]['Default']
		local rawItems = {}
		local currentActionIsPresent = false
		for actionIndex, actionId in pairs(actions) do
			if actionId == currentActionId then
				currentActionIsPresent = true
			end
			local actionData = actionDB.actionsData[actionId]
			if actionData ~= nil then
				if actionDB.isGroupCapableOfAction(vdata.group, vdata.wpt, actionData) == nil then
					base.table.insert(rawItems, { name = actionData.displayName, value = actionId, toolTip = actionData.desc } )
				end
			else
				base.error('Action \"'..actionId..'\" missed!')
			end
		end		
		if 	currentActionId ~= nil and
			not currentActionIsPresent then
			local actionData = actionDB.actionsData[currentActionId]
			if actionType == actionData.type then
				local comboListSkin = actionComboList:getSkin()
				local itemSkin = SkinUtils.setListBoxItemTextColor(invalidValueComboListItemTextColor, comboListSkin.skinData.skins.item)				
				base.table.insert(rawItems, { name = actionData.displayName, value = currentActionId, skin = itemSkin, toolTip = actionData.desc } )
			end
		end		
		U.fillComboList(actionComboList, rawItems)
		actionComboListmodulationComboList = rawItems
	end
	
	--Wrap task into 'ControlledTask' with conditions
	local function makeControlledTask()
		if vdata.task.id ~= 'ControlledTask' then
			local taskId 		= vdata.task.id
			local taskKey		= vdata.task.key
			local taskParams 	= vdata.task.params
			vdata.task.id 		= 'ControlledTask'
			vdata.task.params 	= {
				condition 		= nil,
				stopCondition 	= nil,						
				task = {
					id 			= taskId,
					key			= taskKey,
					params 		= taskParams
				}
			}
		end
	end	
	
	--Update action condition panel
	local function updateConditionPanel()
		if conditionButton:getState() then
			makeControlledTask()
			vdata.task.params.condition = vdata.task.params.condition or {}
			panelActionCondition.open(	vdata.task.params.condition,
										base.getfenv(),
										panelActionCondition.conditionType.TASK_START_CONDITION,
										vdata.wpt,
										vdata.group)
			stopConditionButton:setState(false)
		elseif stopConditionButton:getState() then		
			makeControlledTask()
			vdata.task.params.stopCondition = vdata.task.params.stopCondition or {}			
			local conditionType = panelActionCondition.conditionType.TASK_STOP_CONDITION
			if vdata.actionType == actionDB.ActionType.ENROUTE_TASK then
				conditionType = panelActionCondition.conditionType.ENROUTE_TASK_STOP_CONDITION
			end
			panelActionCondition.open(	vdata.task.params.stopCondition,
										base.getfenv(),
										conditionType,
										vdata.wpt,
										vdata.group)			
			conditionButton:setState(false)
		end
	end
	
	--Called on every action type change
	local function onActionTypeChange(currentActionId)
		fillActionComboList(vdata.actionType, currentActionId)
		updateConditionPanel()
	end
	
	--Check if 'ControlledTask' still valid
	local function checkControlledTask()
		if vdata.task == nil then
			return
		end
		if vdata.task.id == 'ControlledTask' then
			if 	vdata.task.params.condition and
				not actionDB.isStartConditionDefined(vdata.task.params.condition) then
				vdata.task.params.condition = nil
			end
			if 	vdata.task.params.stopCondition and
				not actionDB.isStopConditionDefined(vdata.task.params.stopCondition) then
				vdata.task.params.stopCondition = nil
			end
			if vdata.task.params.condition == nil and vdata.task.params.stopCondition == nil then
				vdata.task.id = vdata.task.params.task.id
				vdata.task.params = vdata.task.params.task.params
			end
		end
	end	
	
	--Called on every action change
	local function onActionChange()
		local stopConditionAvailable = (vdata.actionType == actionDB.ActionType.TASK) or (vdata.actionType == actionDB.ActionType.ENROUTE_TASK)
		stopConditionButton:setVisible(stopConditionAvailable)		
		if 	not stopConditionAvailable and
			stopConditionButton:getState() then
			panelActionCondition.close()
			checkControlledTask()
			stopConditionButton:setState(false)
		end
		
		local valid = actionDB.isActionValid(vdata.task, vdata.group, vdata.wpt, vdata.groupTask)
        vdata.task.valid = valid
		vdata.actionsListBox:onActionChange()
	end
	
	--Set actionId value to action id combo box
	local function setActionIdComboListValue(actionId)
		base.assert(actionComboListmodulationComboList ~= nil)
		local item = U.getItemByValue(actionComboListmodulationComboList, value)
		if item ~= nil then
			actionComboList:setText(item.name)
		else
			actionComboList:setText(actionDB.actionsData[actionId].displayName)
		end
	end

	--Set action (change param box, notify list box and other modules)
	local function setActionId(actionId)
		vdata.actionId = actionId
		setActionIdComboListValue(actionId)
		changeParamPanel()
		onActionChange()
	end
	
	--Set action to default action of required type
	local function setDefaultActionId(actionType)
		local defaultActionId = actionDB.actionTypeData[actionType].defaultActionId
		actionDB.setTask(vdata.task, vdata.group, defaultActionId)
		vdata.actionParams = actionDB.getActionParams(vdata.task)
		base.assert(vdata.actionParams ~= nil)		
		setActionId(defaultActionId)
	end
	
	--Set action type (update action combo box)
	local function setActionType(actionType, currentActionId)
		actionTypeComboList:setText(actionDB.actionTypeData[actionType].displayName)			
		vdata.actionType = actionType
		onActionTypeChange(currentActionId)
	end
		
	local function openAction(itemNumber, actionType, actionId)
		base.assert(actionType ~= nil)
		setActionType(actionType, actionId)
		base.assert(actionId ~= nil)
		setActionId(actionId)
		numberSpin:setValue(itemNumber)
		nameEditBox:setText(vdata.task.name or '')
		enableCheckBox:setState(vdata.task.enabled)
		updateConditionPanel()
		if not actionDB.allowToEditAutoTasks then
			box:setEnabled(not(vdata.task.auto == true))
			for linde_index, line in pairs(lines) do
				line:setEnabled(not(vdata.task.auto == true))
			end
		end
	end
		
    function actionTypeComboList:onChange(item)                    
		actionDB.defaultActionType = item.itemId.value
        actionParams = actionDB.getActionParams(vdata.task)
        if actionParams.subtitle then
            --очищаем словари от ненужного ключа
            mod_dictionary.removeKey(actionParams.KeyDict_subtitle)            
        end
        if (actionParams.file ~= nil) then
            --удаляем ресурс если больше нигде не используется
            mod_dictionary.removeResource(actionParams.file)          
        end        
		actionMapObjects.onTaskRemove(vdata.task)
		vdata.actionType = item.itemId.value
		onActionTypeChange(vdata.actionId)
		setDefaultActionId(item.itemId.value)
	end	

    function actionComboList:onChange(item)        
		local actionId = item.itemId.value
        actionParams = actionDB.getActionParams(vdata.task)
        if actionParams.subtitle then
            --очищаем словари от ненужного ключа
            mod_dictionary.removeKey(actionParams.KeyDict_subtitle)            
        end
        if (actionParams.file ~= nil) then
            --удаляем ресурс если больше нигде не используется
            mod_dictionary.removeResource(actionParams.file)          
        end     
		actionMapObjects.onTaskRemove(vdata.task)
		actionDB.setTask(vdata.task, vdata.group, actionId)
		
		vdata.task.auto = false

		vdata.actionParams = actionDB.getActionParams(vdata.task)
		base.assert(vdata.actionParams ~= nil)
        if vdata.actionParams.subtitle then
            mod_dictionary.textToME(vdata.actionParams, 'subtitle', mod_dictionary.getNewDictId("subtitle"))
        end
		setActionId(actionId)
		vehicle.groupUnitsTransportCheck(true,okFunction,noFunction)
	end		

    function numberSpin:onChange()
		local itemNumber = self:getValue()
		local item = vdata.actionsListBox:selectItem(itemNumber)
		self:setValue(item.number)
	end	

	function enableCheckBox:onChange()
		vdata.task.enabled = self:getState()
		onActionChange()
	end	

	function nameEditBox:onChange()
		vdata.task.name = self:getText()
		onActionChange()
		if vdata.mapObjects.mark then
			actionMapObjects.mark.updateName(vdata.mapObjects, vdata.group, vdata.wpt)
		end
	end
	
	function conditionButton:onChange()
		if conditionButton:getState() then
			makeControlledTask()
			vdata.task.params.condition = vdata.task.params.condition or {}
			panelActionCondition.open(	vdata.task.params.condition,
										base.getfenv(),
										panelActionCondition.conditionType.TASK_START_CONDITION,
										vdata.wpt,
										vdata.group)
			stopConditionButton:setState(false)
			onActionChange()
		else
			panelActionCondition.close()
			checkControlledTask()
		end
	end

	function stopConditionButton:onChange()
		if stopConditionButton:getState() then
			makeControlledTask()
			vdata.task.params.stopCondition = vdata.task.params.stopCondition or {}
			local conditionType = panelActionCondition.conditionType.TASK_STOP_CONDITION
			if vdata.actionType == actionDB.ActionType.ENROUTE_TASK then
				conditionType = panelActionCondition.conditionType.ENROUTE_TASK_STOP_CONDITION
			end
			panelActionCondition.open(	vdata.task.params.stopCondition,
										base.getfenv(),
										conditionType,
										vdata.wpt,
										vdata.group)
			conditionButton:setState(false)
			onActionChange()
		else
			panelActionCondition.close()
			checkControlledTask()
		end
	end
	
	--Section of specific action parameters	
	--Each action has it's own parameters panel	
	local function createParamPanel(linesQty)
		local top = 8 + box_h + 10
		local height = U.dist_h + (linesQty) * (U.widget_h + U.dist_h) + 5 + (U.widget_h+U.dist_h) + 5
		if height > (winH - 164) then
			height = winH - 164
		end

		local box_w = w-16
		local paramPanel = widgetFactory.createScrollPane(13, top, box_w, height)
		window:insertWidget(paramPanel)
		
		return paramPanel
	end
	
	local function getStrikePoint()
        return MapWindow.getPointMapRelative(0.34,0.5) 
--[[	local dist = 5000
        
        if vdata.wpt ~= nil then
			if vdata.wpt.index > 1 then
				local prevWpt = vdata.group.route.points[vdata.wpt.index - 1]                
				local dx = vdata.wpt.x - prevWpt.x
				local dy = vdata.wpt.y - prevWpt.y
				local segLen = base.math.sqrt(dx * dx + dy * dy)
				return vdata.wpt.x + dx / segLen * dist, vdata.wpt.y + dy / segLen * dist
			else
				return vdata.wpt.x + dist, vdata.wpt.y + dist
			end
		else
			local firstWpt = vdata.group.route.points[1]
			return firstWpt.x + dist, firstWpt.y + dist
		end]]
	end	

	local function selectDefaultItem(comboList, defaultValue)
		local counter = comboList:getItemCount() - 1
		
		for i = 0, counter do
			local item = comboList:getItem(i)
			
			if item.itemId.value == defaultValue then
				local skin = SkinUtils.setListBoxItemTextColor(defaultValueComboListItemTextColor, item:getSkin())
				
				item:setSkin(skin)
				
				break
			end
		end
	end
	
	local optionValue = _('VALUE')
	
	--Flag
	local getFlagHandler = nil
	do
	
		local handler = nil
		
		getFlagHandler = function()
			if handler == nil then
				local panel = createParamPanel(1)
				local valueLabel = createStatic(optionValue, 18, 0, 1.5 * U.text_w, U.widget_h)
				panel:insertWidget(valueLabel)				
				local flagCheckBox = widgetFactory.createCheckBox('', 1.5 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
				panel:insertWidget(flagCheckBox)
				handler = {
					open = function(self, data)
						actionParamPanels.ActionParamHandler.open(self, data)
						if data.actionParams.value == nil then
							data.actionParams.value = data.actionParams.flag
						end
						if data.actionParams.value == nil then
							data.actionParams.value = true
						end
						flagCheckBox:setState(data.actionParams.value)
					end,
					panel = panel,
				}
				function flagCheckBox.onChange(theCheckBox)
					handler.data.actionParams.value = theCheckBox:getState()
					onActionChange()
				end
			end
			return handler
		end
	end
	
	--Numeric value
	local getNumericHandler = nil
	
	do
	
		local handler = nil
		
		getNumericHandler = function()
			if handler == nil then
				local panel = createParamPanel(1)
				local left, top, width, height = panel:getBounds()				
				local valueLabel = createStatic(optionValue, 0, 0, 1.5 * U.text_w, U.widget_h)
				panel:insertWidget(valueLabel)
				local flagCheckBox = widgetFactory.createCheckBox(nil, 1.5 * U.text_w, 0, U.text_w / 4, U.widget_h)
				panel:insertWidget(flagCheckBox)
				local spinBoxPosX =  1.5 * U.text_w + U.dist_w + U.text_w / 4 + U.dist_w
				local valueSpinBox = widgetFactory.createSpinBox(1, 1000000, spinBoxPosX, 0, width - spinBoxPosX - U.text_w - U.dist_w, U.widget_h)
				panel:insertWidget(valueSpinBox)
				local valueUnitLabel = createStatic(nil, width - U.text_w, 0, U.text_w-2, U.widget_h)
				panel:insertWidget(valueUnitLabel)				
				local valueUnitSpinBox = U.createUnitSpinBox(valueUnitLabel, valueSpinBox, nil, 0, 250000.0)				
				handler = {
					open = function(self, data)					
						actionParamPanels.ActionParamHandler.open(self, data)
						local optionName = data.actionParams.name
						local optionData =  actionDB.optionValues[optionName][data.group.type] ~= nil
												and
											actionDB.optionValues[optionName][data.group.type]
												or
											actionDB.optionValues[optionName]
						if optionData.DisplayNameValue	then
							valueLabel:setText(optionData.DisplayNameValue)
						else
							valueLabel:setText(optionValue)
						end
						valueSpinBox:setRange(optionData.min, optionData.max)
						valueUnitSpinBox.measureUnits = optionData.units
						valueUnitSpinBox:setUnitSystem(getUnits())						
						valueSpinBox:setEnabled(data.actionParams.value ~= nil)
						flagCheckBox:setState(data.actionParams.value ~= nil)
						valueUnitSpinBox:setValue(data.actionParams.value ~= nil and data.actionParams.value or optionData.default)
					end,
					panel = panel,
				}
				function flagCheckBox.onChange(theCheckBox)
					if theCheckBox:getState() then						
						local optionName = handler.data.actionParams.name
						local optionData =  actionDB.optionValues[optionName][handler.data.group.type] ~= nil
												and
											actionDB.optionValues[optionName][handler.data.group.type]
												or
											actionDB.optionValues[optionName]						
						handler.data.actionParams.value = optionData.default
					else
						handler.data.actionParams.value = nil
					end
					valueSpinBox:setEnabled(theCheckBox:getState())					
					onActionChange()
				end				
				function valueSpinBox.onChange(theSpinBox)
					handler.data.actionParams.value = valueUnitSpinBox:getValue()
					onActionChange()
				end
			end
			return handler
		end
	
	end
	
	--Enum
	local getOptionEnumHandler = nil
	do
		local handler = nil
		
		local getEnumHandlerCommon = function()
			if handler == nil then
				local panel = createParamPanel(1)
				local comboList = widgetFactory.createComboList()
				actionParamPanels.addChild(comboList, panel, 0, 1, 0, 1)
				handler = {
					open = function(self, data)
						actionParamPanels.ActionParamHandler.open(self, data)						
						local rawItems = handler.getComboListItems(data)
						U.fillComboList(comboList, rawItems)
						selectDefaultItem(comboList,  self.getDefaultValue(data))					
						data.actionParams.value = data.actionParams.value or self.getDefaultValue(data) --move to DB
						U.setComboBoxValue(comboList, data.actionParams.value)
					end,
					panel = panel
				}
				function comboList:onChange(item)
					handler.data.actionParams.value = item.itemId.value
					onActionChange()
				end
			end
			
			return handler
		end
		
		--Option enum handler
		
		local getOptionEnumValues = function(data)
			local optionName = data.actionParams.name
			return  actionDB.optionValues[optionName][data.group.type] ~= nil and
							actionDB.optionValues[optionName][data.group.type]
								or
							actionDB.optionValues[optionName]
		end
		
		getDefaultOptionEnumValue = function(data)
			return getOptionEnumValues(data).default
		end		
		
		getOptionEnumComboListItems = function(data)
			local optionName = data.actionParams.name
			local byGroupType = actionDB.optionValues[optionName][data.group.type] ~= nil
			local items = {}
			if 	items[optionName] == nil or
				(byGroupType and items[optionName][data.group.type] == nil) then
				local itemsToFill = {}
				local list = getOptionEnumValues(data).list
				for index, optionValue in pairs(list) do
					base.table.insert(	itemsToFill, 
										{ 	name = actionDB.optionValueDisplayName[optionName][optionValue], 
											value = optionValue })
				end
				if byGroupType then
					items[optionName] = items[optionName] or {}
					items[optionName][data.group.type] = itemsToFill
				else
					items[optionName] = itemsToFill
				end
			end
			return byGroupType and items[optionName][data.group.type] or items[optionName]
		end
		
		getOptionEnumHandler = function()
		
			local handler = getEnumHandlerCommon()
			
			handler.getComboListItems = getOptionEnumComboListItems
			handler.getDefaultValue = getDefaultOptionEnumValue
			
			return handler
		
		end
	
	end
	
	--Attack Group
	
	local function attackGroup(fac)
		local attackGroupBox = createParamPanel(fac and 9 or 8)		
		local handler = {
			openChilds = function(self, data)
				self.childs.attackGroupParamHandler:open(data)
				local group = base.module_mission.group_by_id[self.data.actionParams.groupId]
				if fac then
					self.childs.weaponParamBox:open(data, group and group.type)
					self.childs.FAC:open(data, group, true)
				else
					self.childs.strike:open(data, group and group.type)		
				end					
			end,
			onMapUnitSelected = function(self, unit)
				return self.childs.attackGroupParamHandler:onMapUnitSelected(unit, true)
			end,
			onTargetMoved = function(self, x, y)
				return self.childs.attackGroupParamHandler:onTargetMoved(x, y)
			end,
			--callbacks
			onChangeGroup = function(self, group)
				if fac then
					self.childs.weaponParamBox:setTargetType(group and group.type)	
					self.childs.FAC:setGroup(group)
				else
					self.childs.strike:setTargetType(group and group.type)
				end
				onActionChange()
			end,
			panel = attackGroupBox,
		}
		handler.childs = {
			attackGroupParamHandler = actionParamPanels.AttackGroupParamHandler:create(handler, 1, false),
			weaponParamBox 			= fac and actionParamPanels.WeaponParamBox:create(handler, 2, fac),	
			FAC						= fac and actionParamPanels.FAC:create(handler, 3, true),
			strike					= (not fac) and actionParamPanels.Strike:create(handler, 2, true)
		}		
		return handler
	end
	
	--Engage Group
	
	local function engageGroup(fac)
		local attackGroupBox = createParamPanel(fac and 10 or 4)	
		local handler = {
			openChilds = function(self, data)
				self.childs.attackGroupParamHandler:open(data)
				self.childs.visibleParamBox:open(data)
				local group = base.module_mission.group_by_id[self.data.actionParams.groupId]
				self.childs.weaponParamBox:open(data, group and group.type)
				self.childs.priorityParamBox:open(data)
				if fac then
					self.childs.FAC:open(data, group, true)
				end
			end,			
			onMapUnitSelected = function(self, unit)
				return self.childs.attackGroupParamHandler:onMapUnitSelected(unit)
			end,	
			--callbacks
			onChangeGroup = function(self, group)
				self.childs.weaponParamBox:setTargetType(group and group.type)
				if fac then
					self.childs.FAC:setGroup(group)
				end
				onActionChange()
			end,
			panel = attackGroupBox,
		}
		handler.childs = {
			attackGroupParamHandler = actionParamPanels.AttackGroupParamHandler:create(handler, 1, false),
			visibleParamBox 		= actionParamPanels.VisibleParamBox:create(handler, 2),
			weaponParamBox 			= actionParamPanels.WeaponParamBox:create(handler, 3, fac),
			priorityParamBox 		= actionParamPanels.PriorityParamBox:create(handler, 4),
			FAC						= fac and actionParamPanels.FAC:create(handler, 5, true)
		}
		return handler
	end
	
	local function addEwrData()
		local attackGroupBox = createParamPanel(2)
		local handler = {
			openChilds = function(self, data)
				--local group = base.module_mission.group_by_id[self.data.actionParams.groupId]
				self.childs.EWR:open(data, false)
			end,
			--callbacks
			onChangeGroup = function(self, group)
				onActionChange()
			end,
			panel = attackGroupBox,
		}
		handler.childs = {
			EWR = actionParamPanels.EWR:create(handler, 1, false)
		}		
		return handler
	end
	
	local function addFacData()
		local attackGroupBox = createParamPanel(4)
		local handler = {
			openChilds = function(self, data)
				local group = base.module_mission.group_by_id[self.data.actionParams.groupId]
				self.childs.FAC:open(data, group, false)
			end,
			--callbacks
			onChangeGroup = function(self, group)
				onActionChange()
			end,
			panel = attackGroupBox,
		}
		handler.childs = {
			FAC						= actionParamPanels.FAC:create(handler, 1, false)
		}		
		return handler
	end
	
	
	local function openFileDlgCallback(filename, edit)
		if filename then
            mod_dictionary.setValueToResource(edit.resId, U.extractFileName(filename), filename)            

            edit:setText(U.extractFileName(filename))
            edit:onChange()
		end
	end
	
	--Table with constructors of action parameter panels
	paramPanelConstructors = {
		[actionDB.ActionId.ATTACK_GROUP] = function()
			return attackGroup(false)
		end,
		[actionDB.ActionId.ATTACK_UNIT] = function()
			local attackUnitBox = createParamPanel(9)
			local handler = {
				openChilds = function(self, data)
					self.childs.attackUnitParamBox:open(data)
					local unit = base.module_mission.unit_by_id[self.data.actionParams.unitId]
					local group = unit and unit.boss
					self.childs.strike:open(data, group and group.type)
				end,
				onMapUnitSelected = function(self, unit)
					return self.childs.attackUnitParamBox:onMapUnitSelected(unit)
				end,	
				--callbacks
				onChangeGroup = function(self, group)
					self.childs.strike:setTargetType(group and group.type)
				end,
				onChangeUnit = function(self, unit)
					self:onChangeGroup(unit and unit.boss)
					onActionChange()
				end,
				panel = attackUnitBox,
			}
			handler.childs = {
				attackUnitParamBox	= actionParamPanels.AttackUnitParamBox:create(handler, 1),
				strike				= actionParamPanels.Strike:create(handler, 4, true)
			}
			return handler
		end,
		[actionDB.ActionId.ORBIT] = function()
			
			local cdata = {
				pattern = _('PATTERN')
			}
			
			local orbitPattern = {
				circle		= 'Circle',
				raceTrack	= 'Race-Track'
			}
		
			local orbitParamBox = createParamPanel(3)
			local lines = actionParamPanels.addLines(orbitParamBox, 1, 1)
			
			lines[1]:insertWidget(createStatic(cdata.pattern))
				
			local orbitTypeComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			
			local patterns = {
				circle		= { name = _('Circle'), 	value = orbitPattern.circle },
				raceTrack 	= { name = _('Race-Track'), value = orbitPattern.raceTrack }
			}
			local bothPatterns = {
				patterns.circle,
				patterns.raceTrack
			}
			local onlyCirclePattern = {
				patterns.circle
			}

			lines[1]:insertWidget(orbitTypeComboList)
			
			local handler = {
				open = function(self, data) 
					local allowRaceTrack = data.wpt == nil or data.group.route.points[data.wpt.index + 1] ~= nil --move to DB
					if allowRaceTrack then
						U.fillComboList(orbitTypeComboList, bothPatterns)
					else
						U.fillComboList(orbitTypeComboList, onlyCirclePattern)
					end
					actionParamPanels.ActionParamHandler.open(self, data)
					data.actionParams.pattern = data.actionParams.pattern or (allowRaceTrack and orbitPattern.raceTrack or orbitPattern.circle) --move to DB
					U.setComboBoxValue(orbitTypeComboList, data.actionParams.pattern)			
				end,
				onAltitudeChange = function(self)
					onActionChange()
				end,
				panel = orbitParamBox
			}
			handler.childs = {
				speedAndHeight = actionParamPanels.SpeedAndHeight:create(handler, 2)
			}
			function orbitTypeComboList:onChange(item)
				handler.data.actionParams.pattern = item.itemId.value
			end
			return handler
		end,
		[actionDB.ActionId.LAND] = function()
		
			local cdata = {
				duration = _('ON LAND')
			}
		
			local landParamBox = createParamPanel(1)
			local lines = actionParamPanels.addLines(landParamBox, 1, 1)
		
			local durationCheckBox = widgetFactory.createCheckBox(cdata.duration, 0, 0, 2 * U.text_w, U.widget_h)
			lines[1]:insertWidget(durationCheckBox)
			
			local durationPanel = U.create_time_panel()
			durationPanel:setBounds(1.5 * U.text_w, 0, w - 1.5 * U.text_w, U.widget_h)
			durationPanel:setTime(5 * 60 + 0)
			lines[1]:insertWidget(durationPanel)
            
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					if not(data.actionParams.x and data.actionParams.y) then
						data.actionParams.x, data.actionParams.y = getStrikePoint()
					end
                    data.actionParams.x, data.actionParams.y = MapWindow.findValidStrikePoint(data.actionParams.x, data.actionParams.y)
					actionMapObjects.mark.set(vdata.mapObjects, data.actionParams.x, data.actionParams.y, 0.0, vdata.group, vdata.wpt, vdata.task)
					durationCheckBox:setState(data.actionParams.durationFlag)
					durationPanel:setEnabled(data.actionParams.durationFlag)
					durationPanel:setTime(data.actionParams.duration)
				end,
				onTargetMoved = function(self, x, y)
					return false
				end,
				panel = landParamBox
			}
			
			function durationCheckBox:onChange()				
				handler.data.actionParams.durationFlag = self:getState()
				durationPanel:setEnabled(handler.data.actionParams.durationFlag)
			end
			
			function durationPanel:onChange()
				handler.data.actionParams.duration = self:getTime()
			end
			
			return handler
		end,
		[actionDB.ActionId.BOMBING] = function()		
			local bombingParamBox = createParamPanel(7)			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					if not(data.actionParams.x and data.actionParams.y) then
						data.actionParams.x, data.actionParams.y = getStrikePoint()
					end
					actionMapObjects.mark.set(vdata.mapObjects, data.actionParams.x, data.actionParams.y, 0.0, vdata.group, vdata.wpt, vdata.task)
				end,
				openChilds = function(self, data)
					self.childs.strike:open(data, 'point')
				end,
				onTargetMoved = function(self, x, y)
					return false
				end,
				panel = bombingParamBox,
			}
			handler.childs = {
				strike = actionParamPanels.Strike:create(handler, 1, false, true)
			}
			return handler
		end,
				
		[actionDB.ActionId.ATTACK_MAP_OBJECT] = function()		
			local bombingParamBox = createParamPanel(6)
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					if not(data.actionParams.x and data.actionParams.y) then
						data.actionParams.x, data.actionParams.y = getStrikePoint()
					end
					actionMapObjects.mark.set(vdata.mapObjects, data.actionParams.x, data.actionParams.y, 0.0, vdata.group, vdata.wpt, vdata.task)
				end,
				openChilds = function(self, data)
					self.childs.strike:open(data, 'point')
				end,
				onTargetMoved = function(self, x, y)
					return false
				end,
				panel = bombingParamBox,
			}
			handler.childs = {
				strike = actionParamPanels.Strike:create(handler, 1, true)
			}
			return handler
		end,
		[actionDB.ActionId.BOMBING_RUNWAY] = function()
			local bombingRunwayParamBox = createParamPanel(7)
			local lines = actionParamPanels.addLines(bombingRunwayParamBox, 1, 1)
			
			local cdata = {
				runway = _('RUNWAY')
			}
			
			--Runway
			lines[1]:insertWidget(createStatic(cdata.runway))
			
			local runwayComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			lines[1]:insertWidget(runwayComboList)
			
			local function makeAirdromeItems(airdromes)
				local items = {}
				for i, v in pairs(airdromes) do			
					items[i] = { name = v.Name, value = v }
				end
				return items
			end
			
			local function buildAirdromes()
				local airdromesHashTbl = AirdromeData.getTblOriginalAirdromes() or {}
				local airdromes = {}
				for i,v in pairs(airdromesHashTbl) do
                    local nameAirdrome
                    if v.display_name then
                        nameAirdrome = _(v.display_name) 
                    else
                        nameAirdrome = v.names[locale] or v.names['en']
                    end
					airdromes[#airdromes + 1] = {	WorldID = i ,
													Name 	=  nameAirdrome , 
													x 		= v.reference_point.x,
													y 		= v.reference_point.y }
				end
				return airdromes
			end
			
			local function sortAirdromes(airdromes, x, y)
				local function sorter(left, right)
					local left_d = DB.getDist(x, y, left.x, left.y)
					local right_d = DB.getDist(x, y, right.x, right.y)			
					return left_d < right_d
				end	
				base.table.sort(airdromes, sorter)
				return airdromes
			end
			
			local airdromes = buildAirdromes()
			U.fillComboList(runwayComboList, makeAirdromeItems(airdromes))
			
			local function getNearestAirdrome(airdromes, x, y)
				local result = nil
				local minDist = nil
				for i, v in pairs(airdromes) do
					local runway  = v
					local dist = DB.getDist(x, y, runway.x, runway.y)								
					if  result == nil or 
						dist < minDist then
						result  = runway
						minDist = dist
					end
				end	
				return result
			end
					
			local handler =  {				
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					self:update()
					local runway = nil			
					if data.actionParams.runwayId ~= nil then 
						runway = nil
						for i, v in pairs(self.airdromes) do
							if v.WorldID == data.actionParams.runwayId then
								runway = v
								break
							end					
						end
						--runway = self.airdromes[data.actionParams.runwayId]
						base.assert(runway ~= nil)
					else
						if self.data.wpt then
							runway = getNearestAirdrome(self.airdromes, self.data.wpt.x, self.data.wpt.y)
							if runway then
								data.actionParams.runwayId = runway.WorldID
							end
						end				
					end
					if runway then
						runwayComboList:setText(runway.Name)				
						actionMapObjects.mark.set(vdata.mapObjects, runway.x, runway.y, 0.0, vdata.group, vdata.wpt, vdata.task)
					end
				end,
				openChilds = function(self, data)
					self.childs.strike:open(data, 'runway')
				end,
				onTargetMoved = function(self, x, y)
					local runway = getNearestAirdrome(self.airdromes, x, y)
					if runway then
						self.data.actionParams.runwayId = runway.WorldID
						U.setComboBoxValue(runwayComboList, runway)
						if vdata.mapObjects.mark then
							actionMapObjects.mark.move(vdata.mapObjects, runway.x, runway.y)
						end
						return true
					end
					return false
				end,				
				update = function(self)
					if self.data.wpt then
						self.airdromes = buildAirdromes()
						sortAirdromes(self.airdromes, self.data.wpt.x, self.data.wpt.y)
						U.fillComboList(runwayComboList, makeAirdromeItems(self.airdromes))
					end			
				end,
				panel = bombingRunwayParamBox,
				airdromes = airdromes
			}
			handler.childs = {
				strike = actionParamPanels.Strike:create(handler, 2, false)
			}
			
			function runwayComboList:onChange(item)
				local runway = item.itemId.value
				handler.data.actionParams.runwayId = runway.WorldID
				if vdata.mapObjects.mark then
					actionMapObjects.mark.move(vdata.mapObjects, runway.x, runway.y)
				end
			end
			return handler
		end,
		[actionDB.ActionId.FAC_ATTACK_GROUP] = function()
			return attackGroup(true)
		end,
		[actionDB.ActionId.FIRE_AT_POINT] = function()
			local fireAtPointParamBox = createParamPanel(4)
			local handler = {
				open = function(self, data)
					if not(data.actionParams.x and data.actionParams.y) then
						data.actionParams.x, data.actionParams.y = getStrikePoint()
					end
					
					actionParamPanels.ActionParamHandler.open(self, data)
					
					actionMapObjects.mark.set(	data.mapObjects,
												data.actionParams.x, data.actionParams.y,
												data.actionParams.zoneRadius,
												vdata.group, vdata.wpt, vdata.task, self.childs.altAirDefense.callbackMove)                
                    base.module_mission.update_target_zone(data.mapObjects.mark)
				end,
				openChilds = function(self, data)
					self.childs.zoneRadius:open(data)
					self.childs.altAirDefense:open(data)
					self.childs.strike:open(data, 'point')
				end,
				onTargetMoved = function(self, x, y)
					self.childs.altAirDefense:move(x, y)
				end,
				panel = fireAtPointParamBox,
			}
			handler.childs = {
				zoneRadius = actionParamPanels.ZoneRadius:create(handler, 1, true, 1000.0),
				altAirDefense = actionParamPanels.AltAirDefense:create(handler, 2),
				strike = actionParamPanels.Strike2:create(handler, 3, false)
			}
						
			return handler
		end,
		[actionDB.ActionId.HOLD] = function()
			local holdBox = createParamPanel(1)
			local lines = actionParamPanels.addLines(holdBox, 1, 1)
			
			lines[1]:insertWidget(createStatic(cdata.template, 0, 0, box_w*0.5-10, U.widget_h))
			
			local templateCombo = widgetFactory.createComboList(box_w*0.5-10, 0, box_w*0.5, U.widget_h)
			lines[1]:insertWidget(templateCombo)
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					--TODO обновлять комбобокс только при изменении шаблонов 
					U.fillTemplatesCombo(TEMPL.templates, templateCombo, true)
					templateCombo:setText(data.actionParams.templateId)
				end,
				panel = holdBox
			}			
			
			function templateCombo:onChange(item)
				handler.data.actionParams.templateId = item.itemId.name
			end
			
			return handler
			
		end,
		[actionDB.ActionId.FOLLOW] = function()
		
			local cdata = {
				lastWptIndex	= _('LAST WPT')
			}
		
			local followGroupBox = createParamPanel(5)
			local lines = actionParamPanels.addLines(followGroupBox, 5, 1)
			
			local lastWptCheckBox = widgetFactory.createCheckBox(cdata.lastWptIndex, 0, 0, 1.7 * U.text_w, U.widget_h)
			lines[1]:insertWidget(lastWptCheckBox)
			
			local lastWptSpinBox = SpinWPT.new()
			local con_wpt = lastWptSpinBox:create(1.7 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
			lines[1]:insertWidget(con_wpt)

			local handler = {
				openChilds = function(self, data)
					self.childs.attackGroupParamHandler:open(data)
					self.childs.position3DParamHandler:open(data)
					local group = base.module_mission.group_by_id[self.data.actionParams.groupId]
					self:onChangeGroup(group)
				end,
				onMapUnitSelected = function(self, unit)
					return self.childs.attackGroupParamHandler:onMapUnitSelected(unit)
				end,
				onTargetMoved = function(self, x, y)
					return self.childs.attackGroupParamHandler:onTargetMoved(x, y)
				end,
				--callbacks
				onChangeGroup = function(self, group)					
					local lastWptIndex = nil
					if group ~= nil then
						if #group.route.points > 1 then
							lastWptIndex = #group.route.points
							--[[
							if group.route.points[#group.route.points].type.type ~= 'Land' then
								lastWptIndex = #group.route.points
							elseif #group.route.points > 2 then
								lastWptIndex = #group.route.points - 1
							end
							--]]
						end						
					end
					if lastWptIndex ~= nil then
						self.data.actionParams.lastWptIndex = self.data.actionParams.lastWptIndex or lastWptIndex
						self.data.actionParams.lastWptIndexFlag = self.data.actionParams.lastWptIndex <= #group.route.points and self.data.actionParams.lastWptIndexFlagChangedManually
						local lastWptIndexToSet = base.math.min(self.data.actionParams.lastWptIndex, #group.route.points)
						lastWptSpinBox:setWPT(lastWptIndexToSet, #group.route.points, group.boss.name, base.math.min(2, self.data.actionParams.lastWptIndex))
						lastWptSpinBox:setCurIndex(lastWptIndexToSet)
					else
						self.data.actionParams.lastWptIndexFlag = false
					end
					lastWptCheckBox:setEnabled(lastWptIndex ~= nil)					
					lastWptCheckBox:setState(self.data.actionParams.lastWptIndexFlag)
					lastWptSpinBox:setEnabled(self.data.actionParams.lastWptIndexFlag)
					onActionChange()
				end,
				panel = followGroupBox
			}
			
			handler.childs = {
				attackGroupParamHandler = actionParamPanels.AttackGroupParamHandler:create(handler, 1, true),
				position3DParamHandler = actionParamPanels.Position3D:create(handler, 2)
			}
			
			function lastWptCheckBox.onChange(self)
				handler.data.actionParams.lastWptIndexFlag = self:getState()
				handler.data.actionParams.lastWptIndexFlagChangedManually = handler.data.actionParams.lastWptIndexFlag
				handler.data.actionParams.lastWptIndex = lastWptSpinBox:getCurIndex()
				lastWptSpinBox:setEnabled(handler.data.actionParams.lastWptIndexFlag)
			end
			
			function lastWptSpinBox.onChange(self)
				handler.data.actionParams.lastWptIndex = self:getCurIndex()
			end
			
			return handler
		end,
		[actionDB.ActionId.ESCORT] = function()
		
	
			local cdata = {
				lastWptIndex		= _('LAST WPT'),
				maxEngageDistance	= _('ENGAGE DIST')
			}
		
			local escortGroupBox = createParamPanel(10)
			local lines = actionParamPanels.addLines(escortGroupBox, 5, 2)
			
			local lastWptCheckBox = widgetFactory.createCheckBox(cdata.lastWptIndex, 0, 0, 2 * U.text_w, U.widget_h)
			lines[1]:insertWidget(lastWptCheckBox)
			
			local lastWptSpinBox = SpinWPT.new()
			local con_wpt = lastWptSpinBox:create(2 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
			lines[1]:insertWidget(con_wpt)

			lines[2]:insertWidget(createStatic(cdata.maxEngageDistance, 0, 0, 3 * U.text_w, U.widget_))
				
			local maxDistSpinBox = widgetFactory.createSpinBox(1, 250, 1.5 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
			maxDistSpinBox:setStep(1000)
			lines[2]:insertWidget(maxDistSpinBox)
			
			local distUnitLabel = createStatic('', 1.5 * U.text_w + U.spin_long_w - 15 + U.dist_w, 0, U.text_w / 3, U.widget_h)
			lines[2]:insertWidget(distUnitLabel)						
			
			local maxDistUnitSpinBox = U.createUnitSpinBox(distUnitLabel, maxDistSpinBox, U.distanceUnits, 0, 250000.0)
						
			local handler = {
				openChilds = function(self, data)
					self.childs.attackGroupParamHandler:open(data)
					self.childs.position3DParamHandler:open(data)
					self.childs.targetTypes:open(data)
					maxDistUnitSpinBox:setUnitSystem(getUnits())
					maxDistUnitSpinBox:setValue(data.actionParams.engagementDistMax)
					local group = base.module_mission.group_by_id[self.data.actionParams.groupId]
					self:onChangeGroup(group)
				end,
				onMapUnitSelected = function(self, unit)
					return self.childs.attackGroupParamHandler:onMapUnitSelected(unit)
				end,
				onTargetMoved = function(self, x, y)
					return self.childs.attackGroupParamHandler:onTargetMoved(x, y)
				end,
				--callbacks
				onChangeGroup = function(self, group)
					local lastWptIndex = nil
					if group ~= nil then
						if #group.route.points > 1 then
							lastWptIndex = #group.route.points
							--[[
							if group.route.points[#group.route.points].type.type ~= 'Land' then
								lastWptIndex = #group.route.points
							elseif #group.route.points > 2 then
								lastWptIndex = #group.route.points - 1
							end
							--]]
						end						
					end
					
					if lastWptIndex ~= nil then
						self.data.actionParams.lastWptIndex = self.data.actionParams.lastWptIndex or lastWptIndex
						self.data.actionParams.lastWptIndexFlag = self.data.actionParams.lastWptIndex <= #group.route.points and (self.data.actionParams.lastWptIndexFlagChangedManually or false)
						local lastWptIndexToSet = base.math.min(self.data.actionParams.lastWptIndex, #group.route.points)
						lastWptSpinBox:setWPT(lastWptIndexToSet, #group.route.points, group.boss.name, base.math.min(2, self.data.actionParams.lastWptIndex))
						lastWptSpinBox:setCurIndex(lastWptIndexToSet)
					else
						self.data.actionParams.lastWptIndexFlag = false
					end
					lastWptCheckBox:setEnabled(lastWptIndex ~= nil)						
					lastWptCheckBox:setState(self.data.actionParams.lastWptIndexFlag)
				
					lastWptSpinBox:setEnabled(self.data.actionParams.lastWptIndexFlag)
					onActionChange()
				end,
				panel = escortGroupBox
			}
			handler.childs = {
				attackGroupParamHandler = actionParamPanels.AttackGroupParamHandler:create(handler, 1, true),
				position3DParamHandler	= actionParamPanels.Position3D:create(handler, 2),
				targetTypes				= actionParamPanels.TargetTypes:create(handler, 7, 5),
			}
			
			function lastWptCheckBox.onChange(self)
				handler.data.actionParams.lastWptIndexFlag = self:getState()
				handler.data.actionParams.lastWptIndexFlagChangedManually = handler.data.actionParams.lastWptIndexFlag
				handler.data.actionParams.lastWptIndex = lastWptSpinBox:getCurIndex()
				lastWptSpinBox:setEnabled(handler.data.actionParams.lastWptIndexFlag)
			end
			
			function lastWptSpinBox.onChange(self)
				handler.data.actionParams.lastWptIndex = self:getCurIndex()
			end
			
			function maxDistSpinBox.onChange(self)
				handler.data.actionParams.engagementDistMax = maxDistUnitSpinBox:getValue()
			end
			
			return handler
		end,		
		[actionDB.ActionId.EMBARK_TO_TRANSPORT] = function()
			local embarkToTransportPanel = createParamPanel(2)
			
			--заголовок панели
			local handler = {
				panel = embarkToTransportPanel,
				open = function(self, data)
					--взятие координат радиуса посдаки, если не указаны
					if not(data.actionParams.x and data.actionParams.y) then
						if vdata.wpt then 
							data.actionParams.x, data.actionParams.y = vdata.wpt.x, vdata.wpt.y
						else
							data.actionParams.x, data.actionParams.y = getStrikePoint()
						end
					end
					--работа с графикой на карте
					actionMapObjects.mark.set(	data.mapObjects,
					data.actionParams.x, data.actionParams.y,
					data.actionParams.zoneRadius,
					vdata.group, vdata.wpt, vdata.task)
					
					actionParamPanels.ActionParamHandler.open(self, data)
				end,
				openChilds = function(self, data)
					self.childs.AvalibleTipes:open(data)
					self.childs.zoneRadius:open(data)
				end
			}
			
			handler.childs = {
				AvalibleTipes = actionParamPanels.AvalibleTipes:create(handler,1),
				zoneRadius = actionParamPanels.ZoneRadius:create(handler, 2, true, 2000.0)
			}
			--тип транспорта
			return handler
			
		end,
		[actionDB.ActionId.GO_TO_WAYPOINT] 	= function()
		
			local cdata = {
				to_waypoint		= _('TO WAYPOINT'),
				from_waypoint	= _('FROM WAYPOINT'),
				current			= _('CURRENT')
			}
		
			local switchWaypointBox = createParamPanel(2)
			local lines = actionParamPanels.addLines(switchWaypointBox, 1, 2)
			
			lines[1]:insertWidget(createStatic(cdata.to_waypoint))		

            goToWaypointNumberSpin = SpinWPT.new()
            local con_wpt = goToWaypointNumberSpin:create(1.5 * U.text_w, 0, U.text_w*1.5, U.widget_h)
            lines[1]:insertWidget(con_wpt)
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)						
                            
					data.actionParams.fromWaypointIndex = data.actionParams.fromWaypointIndex or (self.data.wpt and self.data.wpt.index) --move to DB
					data.actionParams.nWaypointIndx = data.actionParams.nWaypointIndx or (self.data.wpt and self.data.wpt.index + 1 or 1) --move to DB
					if data.actionParams.nWaypointIndx > #self.data.group.route.points then
						data.actionParams.nWaypointIndx = 1
					end

                    if (data.actionParams.nWaypointIndx == data.actionParams.fromWaypointIndex) then
                        goToWaypointNumberSpin:setEnabled(false)
                    else
                        goToWaypointNumberSpin:setEnabled(true)
                        goToWaypointNumberSpin:setWPT(data.actionParams.nWaypointIndx, #self.data.group.route.points, 
                                               self.data.group.boss.name, nil, nil,{data.actionParams.fromWaypointIndex})
                    end					
				end,
				panel = switchWaypointBox
			}
			
			function goToWaypointNumberSpin:onChange()
				local old = handler.data.actionParams.nWaypointIndx
				handler.data.actionParams.nWaypointIndx = self:getCurIndex()
				if handler.data.actionParams.nWaypointIndx == handler.data.actionParams.fromWaypointIndex then
					local delta = handler.data.actionParams.nWaypointIndx - old
					if delta > 0 then
						if handler.data.actionParams.nWaypointIndx < #handler.data.group.route.points - 1 then
							handler.data.actionParams.nWaypointIndx = handler.data.actionParams.nWaypointIndx + 1
						else
							handler.data.actionParams.nWaypointIndx = handler.data.actionParams.nWaypointIndx - 1
						end
					elseif delta < 0 then
						if handler.data.actionParams.nWaypointIndx > 1 then
							handler.data.actionParams.nWaypointIndx = handler.data.actionParams.nWaypointIndx - 1
						else
							handler.data.actionParams.nWaypointIndx = handler.data.actionParams.nWaypointIndx + 1
						end
					end
                    goToWaypointNumberSpin:setCurIndex(handler.data.actionParams.nWaypointIndx)
				end
				onActionChange()
			end
			
			return handler

		end,
		
		[actionDB.ActionId.EMBARKING] = function()			
			local embarkingPanel = createParamPanel(11)
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					if not(data.actionParams.x and data.actionParams.y) then
						if vdata.wpt then 
							data.actionParams.x, data.actionParams.y = MapWindow.findValidStrikePoint(vdata.wpt.x, vdata.wpt.y)
						else
							data.actionParams.x, data.actionParams.y = MapWindow.findValidStrikePoint(getStrikePoint())
						end
					end
					actionMapObjects.mark.set(vdata.mapObjects, data.actionParams.x, data.actionParams.y, 0.0, vdata.group, vdata.wpt, vdata.task)
				end,
				onTargetMoved = function(self, x, y)
					return false
				end,
				openChilds = function(self, data)
					self.childs.groupsForEmbarking:open(data)
				end,
				panel = embarkingPanel,
				
				--callbacks
				onChangeEmbarkingGroup = function(self)
					onActionChange()
				end,
			}
			
			handler.childs = {
				groupsForEmbarking = actionParamPanels.GroupsForEmbarking:create(handler,10),
			}

			return handler
		end,
		[actionDB.ActionId.DISEMBARKING] = function()
			local embarkingPanel = createParamPanel(10)
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					if not(data.actionParams.x and data.actionParams.y) then
						if vdata.wpt then 
							data.actionParams.x, data.actionParams.y = MapWindow.findValidStrikePoint(vdata.wpt.x, vdata.wpt.y)
						else
							data.actionParams.x, data.actionParams.y = MapWindow.findValidStrikePoint(getStrikePoint())
						end
					end
					actionMapObjects.mark.set(vdata.mapObjects, data.actionParams.x, data.actionParams.y, 0.0, vdata.group, vdata.wpt, vdata.task)
				end,
				onTargetMoved = function(self, x, y)
					return false
				end,
				openChilds = function(self, data)
					self.childs.GroupsForDisembarking:open(data)
				end,
				panel = embarkingPanel,
				--callbacks
				onChangeEmbarkingGroup = function(self)
					onActionChange()
				end,
			}
			
			handler.childs = {
				GroupsForDisembarking = actionParamPanels.GroupsForDisembarking:create(handler,10),
			}

			return handler
			
			
		end,
		
		[actionDB.ActionId.CARGO_TRANSPORTATION] = function()
			local CargoTransportationBox = createParamPanel(2)		
			local handler = {
				openChilds = function(self, data)
					self.childs.cargoDeliviryParamHandler:open(data)
					self.childs.zargoZonesParamHandler:open(data)
				end,
				onMapUnitSelected = function(self, unit)
					return self.childs.cargoDeliviryParamHandler:onMapUnitSelected(unit)
				end,
				onTargetMoved = function(self, x, y)
					return self.childs.cargoDeliviryParamHandler:onTargetMoved(x, y)
				end,
				--callbacks
				onChangeGroup = function(self, group)
					onActionChange()
				end,
				onChangeZone = function(self, zoneId)
					onActionChange()
				end,
				
				panel = CargoTransportationBox,
			}
			handler.childs = {
				cargoDeliviryParamHandler = actionParamPanels.CargoDeliveryParamHandler:create(handler, 1),
				zargoZonesParamHandler = actionParamPanels.CargoZonesParamHandler:create(handler, 2),
			}		
			return handler
		end,
		[actionDB.ActionId.CARGO_TRANSPORTATION_PLANE] = function()
			local CargoTransportationBox = createParamPanel(2)		
			local handler = {
				openChilds = function(self, data)
					self.childs.cargoDeliviryParamHandler:open(data)
				end,
				onMapUnitSelected = function(self, unit)
					return self.childs.cargoDeliviryParamHandler:onMapUnitSelected(unit)
				end,
				onTargetMoved = function(self, x, y)
					return self.childs.cargoDeliviryParamHandler:onTargetMoved(x, y)
				end,
				--callbacks
				onChangeGroup = function(self, group)
					onActionChange()
				end,
				
				panel = CargoTransportationBox,
			}
			handler.childs = {
				cargoDeliviryParamHandler = actionParamPanels.CargoDeliveryParamHandler:create(handler, 1),
			}		
			return handler
		end,
		[actionDB.ActionId.CARGO_UNLOAD_PLANE] = function()
			local CargoTransportationBox = createParamPanel(2)		
			local handler = {
				openChilds = function(self, data)
					self.childs.cargoUnloadPlaneParamHandler:open(data)
				end,
				onMapUnitSelected = function(self, unit)
					return self.childs.cargoUnloadPlaneParamHandler:onMapUnitSelected(unit)
				end,
				onTargetMoved = function(self, x, y)
					return self.childs.cargoUnloadPlaneParamHandler:onTargetMoved(x, y)
				end,
				--callbacks
				onChangeGroup = function(self, group)
					onActionChange()
				end,
				
				panel = CargoTransportationBox,
			}
			handler.childs = {
				cargoUnloadPlaneParamHandler = actionParamPanels.CargoUnloadPlaneParamHandler:create(handler, 1),
			}		
			return handler
		end,
		
		[actionDB.ActionId.AEROBATICS] = function()			
            cdata = 
            {
                Maneuvers_sequency  = _("Maneuver sequence"),
                Maneuver_parameters = _("Maneuver parameters"),
                DELETE              = _("DEL"),
                UP                  = _("UP"),
                DOWN                = _("DOWN"),
                Save_preset         = _("Save sequence"),
                Load_preset         = _("Load sequence"),
                tooltip             = _("Add maneuver to sequency"),
            }
			local function createManeuversPanel_()				
				local result = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_aerobatics2.dlg', cdata)
				return result
			end

			-- добавляем панель со списком манёвров
			local function showManeuversPanel_()
				if not ManeuversPanel then
					ManeuversPanel = createManeuversPanel_()
				end			
				local box_x,box_y,box_w, box_h = window:getBounds()
				local x,y,w,h = ManeuversPanel:getBounds(x, y, w, h)
				ManeuversPanel:setBounds(box_x -w , box_y, w, box_h)
				ManeuversPanel.box:setSize(w, box_h)				
				ManeuversPanel:setVisible(true)
				return ManeuversPanel
			end	
			
			local aerobaticsPanel = showManeuversPanel_()
			
			-- fill combo list with maneuvers				
			local rawItems = {}
			for AerobaticsManeuversName, data in pairs(actionDB.AerobaticsManeuversData) do
				base.table.insert(rawItems, { 	name = data.displayName, 
												ManeuverId = AerobaticsManeuversName, 
												toolTip = data.desc } )
			end
						
			local comboListAerobaticManeuveres 	= aerobaticsPanel.box.ManeuverSelect_CB
			local AerobaticsSeqenceListBox 		= aerobaticsPanel.box.ManeuverSeq
			local ManeuverPlusBtn 				= aerobaticsPanel.box.AddManeuver
			local ManeuverAddBtn  				= aerobaticsPanel.box.Add_Btn
			local ManeuverRemoveBtn  			= aerobaticsPanel.box.Rmv_Btn
			local ManeuverUpBtn		  			= aerobaticsPanel.box.Up_Btn
			local ManeuverDownBtn		  		= aerobaticsPanel.box.Down_Btn
			local ManeuverSaveBtn		  		= aerobaticsPanel.box.Save
			local ManeuverLoadBtn		  		= aerobaticsPanel.box.Load
			local ManeuverParamPanel			= aerobaticsPanel.box.Maneuver_param_panel			
			
			local MinSpeed	= 100
			local MaxSpeed	= 2000		
			local MaxAlt	= 20000
			local WptSpeed  = 500
			local WptAlt    = 2000
			
			local ManeuversSequency = {}
			
			comboListAerobaticManeuveres:clear()
			ManeuverParamPanel:clear()
			comboListAerobaticManeuveres:clear()
			
			local first_update = true
			-- fill comboListAerobaticManeuveres - list of maneuvers
			for i, rawItem in ipairs(rawItems) do
				local item = ListBoxItem.new(rawItem.name)				
				item.maneuverData = rawItem
				item:setTooltipText(rawItem.toolTip)
				comboListAerobaticManeuveres:insertItem(item)
				if first_update then
					comboListAerobaticManeuveres:selectItem(item)
					first_update = false
				end
			end
			
			-- fill specific maneuver with common parameters and parameters for only this maneuver from actionDB.AerobaticsManeuversData
			local function GetDefaultManeuverParams(ManeuverName)				
				local params = {
					RepeatQty 			= {value = 1, min_v = 1,max_v = 10, order = 1,},	-- order используется для порядка вывода параметров в панели параметров
					InitAltitude 		= {value = WptAlt, order = 2,},
					InitSpeed 			= {value = WptSpeed, order = 3,},
					UseSmoke			= {value = 1, order = 4,},
					StartImmediatly		= {value = 0, order = 5,},
				}							
				local default_params = {}
                U.recursiveCopyTable(default_params, actionDB.AerobaticsManeuversData[ManeuverName].param)
				for k,v in pairs(default_params) do
					params[k] = v
				end		
				return params 
			end
						
			-- creation of maneuver
			local function CreateNewManeuver(ManeuverName)				
				local newManeuver = {name = ManeuverName, params = GetDefaultManeuverParams(ManeuverName) }
				--debug
				--[[print('*  Maneuver '.. newManeuver.name ..' = '..newManeuver.displayName ..' created')
				for k,v in pairs(newManeuver.params) do
					print('	param '.. k ..' = ' .. v.value )
				end--]]
				--debug
				return newManeuver
			end
			
			-- get step,min/max and so on for spinBox
			local function GetSpinBoxParams(ParamName,Param)
				local v_min, v_max, v_step = 1,100,1
				if Param.min_v then v_min  = Param.min_v end 
				if Param.step  then v_step = Param.step  end 
				if Param.max_v then 
					v_max = Param.max_v 
				elseif string.find( string.lower(ParamName) , 'speed') then
						v_max = MaxSpeed or 2000/3.6
						if v_min  == 1 then v_min  = MinSpeed end
						if v_step == 1 then v_step = 20 end
				elseif string.find( string.lower(ParamName) , 'altitude') then
						v_max = MaxAlt
						if v_min  == 1 then v_min  = 50 end
						if v_step == 1 then v_step = 100 end
				elseif string.find( string.lower(ParamName) , 'repeatqty') then
						v_max = 99
				elseif string.find( string.lower(ParamName) , 'sector') then
						v_max = 360						
						if v_step == 1 then v_step = 30 end
						if v_min  == 0 then v_min  = 1 end
				elseif string.find( string.lower(ParamName) , 'roll') then
						v_max = 90						
						if v_step == 1 then v_step = 5 end	
				elseif string.find( string.lower(ParamName) , 'ny_req') then
						v_max = 15						
						if v_step == 1 then v_step = 0.1 end	
				end 
				return v_min, v_max, v_step
			end
			
			local handler = {				
				open = function(self, data)
					self.data = data	
                    data.actionParams.maneuversSequency = data.actionParams.maneuversSequency or {}
					
					local toRemove = {}
					for k,v in base.pairs(data.actionParams.maneuversSequency) do
						if actionDB.AerobaticsManeuversData[v.name] == nil then
							base.table.insert(toRemove, k)
						end
					end
					for i = #toRemove, 1, -1 do	
						base.table.remove(data.actionParams.maneuversSequency, toRemove[i])
					end
					
					ManeuversSequency = data.actionParams.maneuversSequency
                    UpdateManeuverParamPanel(nil)
					
					local unit = self.data.group.units[1]
					local unitDesc = DB.unit_by_type[unit.type]				
					local minSpeed = data.group.type == 'plane' and 150 or 0.0
					local maxSpeed = unitDesc.MaxSpeed
					MaxAlt = unitDesc.MaxHeight or 20000
					local wpt = self.data.wpt or self.data.group.route.points[1]	
					WptSpeed  = wpt.speed*3.6 or 500
					WptAlt    = wpt.alt or 2000
					
					ManeuversPanel:setVisible(true)
					UpdateAerobaticsSeqenceListBox(1)
				end,				
				panel = aerobaticsPanel,
			}			
			
			function SpinBoxOnChange(self)				
				local curItem = AerobaticsSeqenceListBox:getSelectedItem()						
				if 	curItem  then
					local SelectedItemIndex = AerobaticsSeqenceListBox:getItemIndex(curItem) + 1
					ManeuversSequency[SelectedItemIndex].params[self.Param_Name].value = self:getValue()
					--print('SpinBoxOnChange Maneuver.name = '..ManeuversSequency[SelectedItemIndex].name)
					--print('SpinBoxOnChange self.Param_Name = '..self.Param_Name)
					if ManeuversSequency[SelectedItemIndex].name == 'TURN' then
						if  self.Param_Name == 'Ny_req' then
							ManeuversSequency[SelectedItemIndex].params['ROLL'].value = base.math.deg(base.math.acos(1/self:getValue()))
							local widgetCount = ManeuverParamPanel.getWidgetCount(ManeuverParamPanel)
							for i = 0, widgetCount - 1 do								
								if ManeuverParamPanel.getWidget(ManeuverParamPanel,i).Param_Name and string.find( ManeuverParamPanel.getWidget(ManeuverParamPanel,i).Param_Name , 'ROLL')  then
									--print('SpinBoxOnChange paramList i = '..i..' Name = '..ManeuverParamPanel.getWidget(ManeuverParamPanel,i).Param_Name)
									ManeuverParamPanel.getWidget(ManeuverParamPanel,i).setValue(ManeuverParamPanel.getWidget(ManeuverParamPanel,i), ManeuversSequency[SelectedItemIndex].params['ROLL'].value)
								end
							end
						end
						if  self.Param_Name == 'ROLL' then
							ManeuversSequency[SelectedItemIndex].params['Ny_req'].value = 1/base.math.cos(base.math.rad(self:getValue()))
							local widgetCount = ManeuverParamPanel.getWidgetCount(ManeuverParamPanel)
							for i = 0, widgetCount - 1 do								
								if ManeuverParamPanel.getWidget(ManeuverParamPanel,i).Param_Name and string.find( ManeuverParamPanel.getWidget(ManeuverParamPanel,i).Param_Name , 'Ny_req')  then
									--print('SpinBoxOnChange paramList i = '..i..' Name = '..ManeuverParamPanel.getWidget(ManeuverParamPanel,i).Param_Name)
									ManeuverParamPanel.getWidget(ManeuverParamPanel,i).setValue(ManeuverParamPanel.getWidget(ManeuverParamPanel,i), ManeuversSequency[SelectedItemIndex].params['Ny_req'].value)
								end
							end
						end
					end
					handler.data.actionParams.maneuversSequency = ManeuversSequency						
				end
			end
			
			function ComboListOnChange(self)
				local curItem = AerobaticsSeqenceListBox:getSelectedItem()						
				if 	curItem  then
					local SelectedItemIndex = AerobaticsSeqenceListBox:getItemIndex(curItem) + 1                   
					ManeuversSequency[SelectedItemIndex].params[self.Param_Name].value = self:getSelectedItem().value
                    
					handler.data.actionParams.maneuversSequency = ManeuversSequency					
				end
			end
			
			function CheckBoxOnChange(self)
				local curItem = AerobaticsSeqenceListBox:getSelectedItem()						
				if 	curItem  then
					local SelectedItemIndex = AerobaticsSeqenceListBox:getItemIndex(curItem) + 1
					ManeuversSequency[SelectedItemIndex].params[self.Param_Name].value = (self:getState()) and 1 or 0
					handler.data.actionParams.maneuversSequency = ManeuversSequency					
					UpdateManager.add(function()
							UpdateManeuverParamPanel(ManeuversSequency[SelectedItemIndex])
							return true
						end
					)
				end
			end
			
			-- update current maneuver params panel			
			function UpdateManeuverParamPanel(ManeuverParams)
                local cdata = {
                    StartImmediatly         = _('StartImmediately'),
                    UseSmoke                = _('UseSmoke'),
                    RepeatQty 			    = _('RepeatQty'),
                    InitAltitude 		    = _('InitAltitude'),
                    InitSpeed               = _('InitSpeed'),
					FlightTime				= _('Flight time'),
					SIDE					= _('Side'),
					ROLL               		= _('aero_Roll','Roll'),
					Ny_req               	= _('G-load'),
					SECTOR               	= _('Sector'),
					MinSpeed                = _('Min speed'),
					RollRate               	= _('Roll rate'),
					FIXSECTOR               = _('FixSector'),
					FinalSpeed              = _('Final speed'),
					Angle               	= _('Angle'),
					FinalAltitude           = _('Final altitude'),
					UPDOWN               	= _('Up down'),
                }
				ManeuversPanel:setVisible(true)
				ManeuverParamPanel:clear()
				if ManeuverParams then
					--print('*  Maneuver '.. ManeuverParams.name ..' = '..ManeuverParams.displayName ..' update ManeuverParamPanel')
					local startImmediatly = ManeuverParams.params['StartImmediatly'].value == 1
					local yPos = 5
					local sortedParams = {}		-- отсортированная по order таблица параметров
					for paramName, paramData in pairs(ManeuverParams.params) do
						table.insert(sortedParams, { paramName = paramName, paramData = paramData })
					end
					
					table.sort(sortedParams, function(param1, param2)
						return param1.paramData.order < param2.paramData.order 
					end)
					
					for i, paramInfo in ipairs(sortedParams) do
						local paramData = paramInfo.paramData -- v
						local paramName = paramInfo.paramName -- k
						if base.type(paramData.value) == 'number' then
							local paramNameLabelText = cdata[paramName]
							if not paramNameLabelText then
								paramNameLabelText = paramName
							end
							--print('**  paramName = '.. paramNameLabelText)
							local paramNameLabel = createStatic(paramNameLabelText, 5, yPos, 80, U.widget_h)
							ManeuverParamPanel:insertWidget(paramNameLabel)
							if string.find( string.lower(paramName) , 'side') then
								local paramNameComboList = widgetFactory.createComboList( 190 - U.spin_long_w , yPos, U.spin_long_w - 15, U.widget_h)
								paramNameComboList.Param_Name = paramName
								local item = ListBoxItem.new(_('Left_turn', 'Left'))
								item.value = 0
								paramNameComboList:insertItem(item)
								if paramData.value == 0 then paramNameComboList:selectItem(item) end
								item = ListBoxItem.new(_('Right_turn', 'Right'))
								item.value = 1
								paramNameComboList:insertItem(item)
								if paramData.value == 1 then paramNameComboList:selectItem(item) end
								paramNameComboList.onChange = ComboListOnChange
								ManeuverParamPanel:insertWidget(paramNameComboList)
							elseif string.find( string.lower(paramName) , 'updown') then
								local paramNameComboList = widgetFactory.createComboList( 190 - U.spin_long_w , yPos, U.spin_long_w - 15, U.widget_h)
								paramNameComboList.Param_Name = paramName
								local item = ListBoxItem.new(_('Up'))
								item.value = 0
								paramNameComboList:insertItem(item)
								if paramData.value == 0 then paramNameComboList:selectItem(item) end
								item = ListBoxItem.new(_('Down'))
								item.value = 1
								paramNameComboList:insertItem(item)
								if paramData.value == 1 then paramNameComboList:selectItem(item) end
								paramNameComboList.onChange = ComboListOnChange
								ManeuverParamPanel:insertWidget(paramNameComboList)
							elseif ( string.find( paramName , 'UseSmoke') or string.find( paramName , 'StartImmediatly')) then
								--print('here we are paramName = '..paramName)
								local paramNameLabel = createStatic(cdata[paramName], 5, yPos, 110, U.widget_h)
								ManeuverParamPanel:insertWidget(paramNameLabel)								
								local paramNameCheckBox = widgetFactory.createCheckBox('',159  , yPos, 24, U.widget_h)
								paramNameCheckBox.Param_Name = paramName
								paramNameCheckBox:setState(paramData.value == 1)
								paramNameCheckBox.onChange = CheckBoxOnChange
								ManeuverParamPanel:insertWidget(paramNameCheckBox)
							else	
								local v_min, v_max, v_step = GetSpinBoxParams(paramName,paramData)
								local paramNameSpinBox = widgetFactory.createSpinBox(v_min, v_max, 190 - U.spin_long_w , yPos, U.spin_long_w - 15, U.widget_h)
								paramNameSpinBox:setStep(v_step)
								if v_step < 1 then
									paramNameSpinBox:setAcceptDecimalPoint(true)
								end
								paramNameSpinBox:setValue(paramData.value)								
								--paramNameSpinBox:setUnitSystem(getUnits())
								paramNameSpinBox.Param_Name = paramName
								paramNameSpinBox.onChange = SpinBoxOnChange
								if   string.find( string.lower(paramName) , 'initaltitude') or string.find( string.lower(paramName) , 'initspeed') then 
									paramNameSpinBox:setEnabled(not startImmediatly)
								end
								ManeuverParamPanel:insertWidget(paramNameSpinBox)
								--print('	*** param type is number:'.. k ..' = ' .. v.value .. 'min = '..v_min..';max = '..v_max..';step = '..v_step)
							end
						end
						yPos = yPos + U.widget_h + 4
						--print('	param '.. k ..' = ' .. v.value .. ' type k = '..base.type(k).. ' type v.value = '.. base.type(v.value))
					end					
				end
			end
			
			function AerobaticsSeqenceListBox:onChange(self)
				local curItem = AerobaticsSeqenceListBox:getSelectedItem()						
				if 	curItem  then
					local SelectedItemIndex = AerobaticsSeqenceListBox:getItemIndex(curItem) + 1
					UpdateManeuverParamPanel(ManeuversSequency[SelectedItemIndex])
				end
			end
			
			--update list
			function UpdateAerobaticsSeqenceListBox(SelectedIdx)
				AerobaticsSeqenceListBox:clear()
				for k,v in ipairs(ManeuversSequency) do
					local NewManeuverItem  = ListBoxItem.new(actionDB.AerobaticsManeuversData[v.name].displayName)
					NewManeuverItem.ManeuverId = v.name
					AerobaticsSeqenceListBox:insertItem(NewManeuverItem, -1 )					
				end
				AerobaticsSeqenceListBox:selectItem(AerobaticsSeqenceListBox:getItem(SelectedIdx-1))
				AerobaticsSeqenceListBox:setItemVisible(AerobaticsSeqenceListBox:getItem(SelectedIdx-1))
				AerobaticsSeqenceListBox:onChange()
				handler.data.actionParams.maneuversSequency = ManeuversSequency				
			end
						
			
			-- Add maneuver to sequence
			function ManeuverPlusBtn:onChange(self)
				local CB_SelectedItem = comboListAerobaticManeuveres:getSelectedItem()
				
				if CB_SelectedItem then
					local maneuverData = CB_SelectedItem.maneuverData						
					local NewManeuverItem  = ListBoxItem.new(maneuverData.name)
					NewManeuverItem.ManeuverId = CB_SelectedItem.maneuverData.ManeuverId
									
					local newManeuverData = CreateNewManeuver(CB_SelectedItem.maneuverData.ManeuverId)
					
					local curItem = AerobaticsSeqenceListBox:getSelectedItem()
					local newItemIndex = nil
					if 	curItem  then
						newItemIndex = AerobaticsSeqenceListBox:getItemIndex(curItem) + 2
						table.insert(ManeuversSequency, newItemIndex, newManeuverData)
					else
						table.insert(ManeuversSequency, newManeuverData)
					end	
					UpdateAerobaticsSeqenceListBox(newItemIndex or #ManeuversSequency)
				end
			end
			
			ManeuverAddBtn.onChange = ManeuverPlusBtn.onChange
			
			--remove maneuver
			function ManeuverRemoveBtn:onChange(self)
				local curItem = AerobaticsSeqenceListBox:getSelectedItem()						
				if 	curItem  then
					local removeItemIndex = AerobaticsSeqenceListBox:getItemIndex(curItem) + 1
					table.remove(ManeuversSequency,removeItemIndex)
					if removeItemIndex > #ManeuversSequency then removeItemIndex = #ManeuversSequency end
					UpdateAerobaticsSeqenceListBox(removeItemIndex)
				end
			end
			
			--move maneuver in list up
			function ManeuverUpBtn:onChange(self)
				local curItem = AerobaticsSeqenceListBox:getSelectedItem()				
				if 	curItem  then
					local curItemIndex = AerobaticsSeqenceListBox:getItemIndex(curItem) + 1
					if curItemIndex > 1 then
						local cloneItem = ManeuversSequency[curItemIndex]
						table.remove(ManeuversSequency,curItemIndex)
						table.insert(ManeuversSequency, curItemIndex - 1, cloneItem)
						UpdateAerobaticsSeqenceListBox( curItemIndex - 1)	
					end
				end
			end
			
			--move maneuver in list down
			function ManeuverDownBtn:onChange(self)
				local curItem = AerobaticsSeqenceListBox:getSelectedItem()				
				if 	curItem  then
					local curItemIndex = AerobaticsSeqenceListBox:getItemIndex(curItem) + 1
					if curItemIndex < (AerobaticsSeqenceListBox:getItemCount() ) then
						local cloneItem = ManeuversSequency[curItemIndex]
						
						table.remove(ManeuversSequency,curItemIndex)
						table.insert(ManeuversSequency, curItemIndex + 1, cloneItem)
						UpdateAerobaticsSeqenceListBox( curItemIndex + 1)							
					end
				end
			end
			
			--save preset
			function ManeuverSaveBtn:onChange(self)
				--print('ManeuverSaveBtn:onChange')			
				local path = lfs.writedir()
				local filters = {FileDialogFilters.aerobaticPreset()}				
				local filename = FileDialog.save(path, filters, _('Choose maneuvers sequence preset:'))				
				
				if filename then
					if ManeuversSequency then
						local f, err = base.io.open(filename, 'w')
						
						if f then
							local serializer = Serializer.new(f)							
							f:write('local ')
							serializer:serialize_sorted('ManeuversSequency', ManeuversSequency)
							f:write('return ManeuversSequency\n')
							f:close()
						else
							log.error('ERROR: saving ManeuversSequency failed: '..err)	
							return false
						end 
					else
						print('No ManeuversSequency to save')
					end
					
					return true
				end
			end
			
			--load preset
			function ManeuverLoadBtn:onChange(self)
				--print('ManeuverLoadBtn:onChange')
				local path = lfs.writedir()
				local filters = {FileDialogFilters.aerobaticPreset()}
				local filename = FileDialog.open(path, filters, _('Choose maneuvers sequence preset:'))
								
				if filename then
					ManeuversSequency = base.dofile(filename)					
					--[[print('ManeuverLoadBtn:file name = '..filename)
					print('ManeuverLoadBtn __ ManeuversSequency size = '..#ManeuversSequency)
					print('ManeuverLoadBtn __ ManeuversSequency keys')
					for k , v in pairs(ManeuversSequency) do print(k..', name = '..v.name)end--]]
					UpdateAerobaticsSeqenceListBox(1)
				end
			end
			
			
			return handler
		end,
		
		[actionDB.ActionId.CARPET_BOMBING] = function()		
			local bombingParamBox = createParamPanel(6)
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					if not(data.actionParams.x and data.actionParams.y) then
						data.actionParams.x, data.actionParams.y = getStrikePoint()
					end
					actionMapObjects.mark.set(vdata.mapObjects, data.actionParams.x, data.actionParams.y, 0.0, vdata.group, vdata.wpt, vdata.task)
				end,
				openChilds = function(self, data)
					self.childs.strike:open(data, 'point')
				end,
				onTargetMoved = function(self, x, y)
					return false
				end,
				panel = bombingParamBox,
			}
			handler.childs = {
				strike = actionParamPanels.CarpetStrike:create(handler, 1, false)
			}
			return handler
		end,
		
		[actionDB.ActionId.WW2_BIG_FORMATION] = function()
		
			local cdata = {
				lastWptIndex	= _('LAST WPT'),
				formationType	= _('Formation Type')
			}
		
			local followGroupBox = createParamPanel(9)
			local lines = actionParamPanels.addLines(followGroupBox, 5, 5)							
			
			lines[1]:insertWidget(createStatic(cdata.formationType))
			local formationTypeComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			
			local formationTypes = {}			
			for k,v in pairs(DB.db.Formations['big_formations'].list) do
				table.insert(formationTypes, {
					value = k,
					name = v.Name,
				})
			end			
			lines[1]:insertWidget(formationTypeComboList)
						
			lines[2]:insertWidget(createStatic('Wing'))
			local wnNumberComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)			
			lines[2]:insertWidget(wnNumberComboList)
			
			lines[3]:insertWidget(createStatic('Group'))
			local grNumberComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			lines[3]:insertWidget(grNumberComboList)
			
			lines[4]:insertWidget(createStatic('Combat box pos', 0 ,0 ,1.7 * U.text_w))
			local cbNumberComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)			
			lines[4]:insertWidget(cbNumberComboList)
			
			local lastWptCheckBox = widgetFactory.createCheckBox(cdata.lastWptIndex, 0, 0, 1.7 * U.text_w, U.widget_h)
			lines[5]:insertWidget(lastWptCheckBox)
			
			local lastWptSpinBox = SpinWPT.new()
			local con_wpt = lastWptSpinBox:create(1.7 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
			lines[5]:insertWidget(con_wpt)

			local handler = {
				openChilds = function(self, data)
					self.childs.attackGroupParamHandler:open(data)
					self.childs.position3DParamHandler:open(data)
												
					local group = base.module_mission.group_by_id[self.data.actionParams.groupId]
					self:onChangeGroup(group)
					
					if (self.data.actionParams.formationType == 0 or self.data.actionParams.formationType == 14) then
						self.data.actionParams.formationType = formationTypes[1].value
						--print('~~~~~~~~~~ self.data.actionParams.formationType == 0, new formationType =',self.data.actionParams.formationType == 0)
					end
					
					U.fillComboList(formationTypeComboList, formationTypes)				
					U.setComboBoxValue(formationTypeComboList, self.data.actionParams.formationType)		
					fillComboLists()
				end,
				onMapUnitSelected = function(self, unit)					
					updateMapPosition()
					return self.childs.attackGroupParamHandler:onMapUnitSelected(unit)
				end,
				onTargetMoved = function(self, x, y)
					return self.childs.attackGroupParamHandler:onTargetMoved(x, y)
				end,
				--callbacks
				onChangeGroup = function(self, group)					
					local lastWptIndex = nil
					if group ~= nil then
						if #group.route.points > 1 then
							lastWptIndex = #group.route.points
						end						
					end
					if lastWptIndex ~= nil then
						self.data.actionParams.lastWptIndex = self.data.actionParams.lastWptIndex or lastWptIndex
						self.data.actionParams.lastWptIndexFlag = self.data.actionParams.lastWptIndex <= #group.route.points and self.data.actionParams.lastWptIndexFlagChangedManually
						local lastWptIndexToSet = base.math.min(self.data.actionParams.lastWptIndex, #group.route.points)
						lastWptSpinBox:setWPT(lastWptIndexToSet, #group.route.points, group.boss.name, base.math.min(2, self.data.actionParams.lastWptIndex))
						lastWptSpinBox:setCurIndex(lastWptIndexToSet)
					else
						self.data.actionParams.lastWptIndexFlag = false
					end
					lastWptCheckBox:setEnabled(lastWptIndex ~= nil)					
					lastWptCheckBox:setState(self.data.actionParams.lastWptIndexFlag)
					lastWptSpinBox:setEnabled(self.data.actionParams.lastWptIndexFlag)
					
					onActionChange()					
				end,
				panel = followGroupBox
			}
			
			handler.childs = {
				attackGroupParamHandler = actionParamPanels.AttackGroupParamHandler:create(handler, 1, true),
				position3DParamHandler = actionParamPanels.Position3D:create(handler, 2)				
			}
			
			function lastWptCheckBox.onChange(self)
				handler.data.actionParams.lastWptIndexFlag = self:getState()
				handler.data.actionParams.lastWptIndexFlagChangedManually = handler.data.actionParams.lastWptIndexFlag
				handler.data.actionParams.lastWptIndex = lastWptSpinBox:getCurIndex()
				lastWptSpinBox:setEnabled(handler.data.actionParams.lastWptIndexFlag)
			end
			
			function lastWptSpinBox.onChange(self)
				handler.data.actionParams.lastWptIndex = self:getCurIndex()
			end
			
			function formationTypeComboList:onChange(item)
				handler.data.actionParams.formationType = item.itemId.value
				--print('~~ formationTypeComboList:onChange(item)',item)
				fillComboLists()
			end
			
			function cbNumberComboList:onChange(item)
				--print('~~ cbNumberComboList:onChange(item)',item)
				handler.data.actionParams.posInBox = item.itemId.value
				updateMapPosition()						
			end
			
			function grNumberComboList:onChange(item)
				--print('~~ grNumberComboList:onChange(item)',item)
				handler.data.actionParams.posInGroup = item.itemId.value
				updateMapPosition()
			end
			
			function wnNumberComboList:onChange(item)
				--print('~~ wnNumberComboList:onChange(item)',item)
				handler.data.actionParams.posInWing = item.itemId.value
				updateMapPosition()
			end
			
			function fillComboLists()
				--print('~~ fillComboLists()')
				local formation = DB.db.Formations['big_formations'].list[handler.data.actionParams.formationType]
				local cbNumbers = {
					{ name = _('Leader'), 	value = 0 }
				}
				for k,v in pairs(formation.positions[1].positions) do				
					table.insert(cbNumbers, {
						value = k,
						name = v.name,
					})
				end
				
				local grNumbers = {
					{ name = _('Leader'), 	value = 0 }
				}
				for k,v in pairs(formation.positions[2].positions) do					
					table.insert(grNumbers, {
						value = k,
						name = v.name,
					})
				end
				
				local wnNumbers = {
					{ name = _('Leader'), 	value = 0 }
				}
				for k,v in pairs(formation.positions[3].positions) do					
					table.insert(wnNumbers, {
						value = k,
						name = v.name,
					})
				end
				
				lines[2]:getWidget(0):setText(formation.positions[3].name)			
				lines[3]:getWidget(0):setText(formation.positions[2].name)
				lines[4]:getWidget(0):setText(formation.positions[1].name)				
				
				U.fillComboList(cbNumberComboList,cbNumbers)
				if U.setComboBoxValue(cbNumberComboList,handler.data.actionParams.posInBox) == false then
					handler.data.actionParams.posInBox = 0
				end
				
				U.fillComboList(grNumberComboList,grNumbers)
				if U.setComboBoxValue(grNumberComboList,handler.data.actionParams.posInGroup) == false then
					handler.data.actionParams.posInGroup = 0
				end
				
				U.fillComboList(wnNumberComboList,wnNumbers)
				if U.setComboBoxValue(wnNumberComboList,handler.data.actionParams.posInWing) == false then
					handler.data.actionParams.posInWing = 0
				end
			end
			
			function updateMapPosition()
				--print('~~ updateMapPosition()')
				local formationWing 	= { x = 0, y = 0, z = 0 }
				local formationGroup 	= { x = 0, y = 0, z = 0 }
				local formationBox 		= { x = 0, y = 0, z = 0 }
				local formation			= { x = 0, y = 0, z = 0 }
				if handler.data.actionParams.posInWing ~= 0 then
					formationWing = DB.db.Formations['big_formations'].list[handler.data.actionParams.formationType].positions[3].positions[handler.data.actionParams.posInWing].positions
				end	
				if handler.data.actionParams.posInGroup ~= 0 then
					formationGroup = DB.db.Formations['big_formations'].list[handler.data.actionParams.formationType].positions[2].positions[handler.data.actionParams.posInGroup].positions
				end	
				if handler.data.actionParams.posInBox ~= 0 then
					formationBox = DB.db.Formations['big_formations'].list[handler.data.actionParams.formationType].positions[1].positions[handler.data.actionParams.posInBox].positions
				end
				
				formation.x = formationWing.x + formationGroup.x + formationBox.x
				formation.y = formationWing.y + formationGroup.y + formationBox.y
				formation.z = formationWing.z + formationGroup.z + formationBox.z

				handler.data.actionParams.pos.x = formation.x
				handler.data.actionParams.pos.y = formation.y
				handler.data.actionParams.pos.z = formation.z
				
				handler.childs.position3DParamHandler:open(handler.data)
				
				local group = nil
				if handler.data.actionParams.groupId then
					group = base.module_mission.group_by_id[handler.data.actionParams.groupId]
				end		
				if group ~= nil and group.units[1] ~= nil and vdata.wpt ~= nil then
					--print('~~~~~ Linking waypoit to Leader')						
					base.module_mission.linkWaypoint(vdata.wpt, vdata.group, group.units[1])
					local heading = group.units[1].heading															
					local sinHeading = base.math.sin(heading)
					local cosHeading = base.math.cos(heading)
					local offsetX = formation.x*cosHeading - formation.z*sinHeading
					local offsetZ = formation.z*cosHeading + formation.x*sinHeading
					
					MapWindow.move_waypoint(vdata.group, 1, group.x + offsetX , group.y + offsetZ, false)

					vdata.wpt.alt = group.route.points[1].alt + formation.y
					vdata.wpt.speed  = group.route.points[1].speed

					for k,v in pairs(group.units) do
						v.heading = heading
						v.psi = -heading
					end					
					panel_route.update()												
					base.module_mission.updateHeading(group)
					base.module_mission.update_group_map_objects(group)
				end	
			end
			
			return handler
		end,
					
		
		[actionDB.ActionId.GROUND_ESCORT] = function()	
	
			local cdata = {
				lastWptIndex		= _('LAST WPT'),
				maxEngageDistance	= _('FORWARD DIST')
			}
		
			local escortGroupBox = createParamPanel(9)
			local lines = actionParamPanels.addLines(escortGroupBox, 4, 2)
			
			local lastWptCheckBox = widgetFactory.createCheckBox(cdata.lastWptIndex, 0, 0, 1.7 * U.text_w, U.widget_h)
			lines[1]:insertWidget(lastWptCheckBox)
			
			local lastWptSpinBox = SpinWPT.new()
			local con_wpt = lastWptSpinBox:create(3.7 * U.text_w+6, 0, U.spin_long_w - 15, U.widget_h)
			lines[1]:insertWidget(con_wpt)

			lines[2]:insertWidget(createStatic(cdata.maxEngageDistance, 0, 0, 3 * U.text_w, U.widget_))
				
			local maxDistSpinBox = widgetFactory.createSpinBox(1, 250, 3.5 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
			lines[2]:insertWidget(maxDistSpinBox)
			
			local distUnitLabel = createStatic('', 3.5 * U.text_w + U.spin_long_w - 15 + U.dist_w, 0, U.text_w / 3, U.widget_h)
			lines[2]:insertWidget(distUnitLabel)						
			
			local maxDistUnitSpinBox = U.createUnitSpinBox(distUnitLabel, maxDistSpinBox, U.altitudeUnits, 500.0, 2500.0)
						
			local handler = {
				openChilds = function(self, data)
					--self.childs.EscortGroupParamHandler:open(data)
					self.childs.attackGroupParamHandler:open(data)
					maxDistUnitSpinBox:setUnitSystem(getUnits())
					maxDistUnitSpinBox:setValue(data.actionParams.engagementDistMax)
					local group = base.module_mission.group_by_id[self.data.actionParams.groupId]
					self:onChangeGroup(group)
				end,
				onMapUnitSelected = function(self, unit)
					return self.childs.attackGroupParamHandler:onMapUnitSelected(unit)
				end,
				onTargetMoved = function(self, x, y)
					return self.childs.attackGroupParamHandler:onTargetMoved(x, y)
				end,
				--callbacks
				onChangeGroup = function(self, group)
					local lastWptIndex = nil
					if group ~= nil then
						if #group.route.points > 1 then
							lastWptIndex = #group.route.points
						end						
					end
					if lastWptIndex ~= nil then
						self.data.actionParams.lastWptIndex = self.data.actionParams.lastWptIndex or lastWptIndex
						self.data.actionParams.lastWptIndexFlag = self.data.actionParams.lastWptIndex <= #group.route.points and self.data.actionParams.lastWptIndexFlagChangedManually
						local lastWptIndexToSet = base.math.min(self.data.actionParams.lastWptIndex, #group.route.points)
						lastWptSpinBox:setWPT(lastWptIndexToSet, #group.route.points, group.boss.name, base.math.min(2, self.data.actionParams.lastWptIndex))
						lastWptSpinBox:setCurIndex(lastWptIndexToSet)
					else
						self.data.actionParams.lastWptIndexFlag = false
					end
					lastWptCheckBox:setEnabled(lastWptIndex ~= nil)					
					lastWptCheckBox:setState(self.data.actionParams.lastWptIndexFlag)
					lastWptSpinBox:setEnabled(self.data.actionParams.lastWptIndexFlag)
					onActionChange()
				end,
				panel = escortGroupBox
			}
			handler.childs = {
				attackGroupParamHandler = actionParamPanels.AttackGroupParamHandler:create(handler, 1, true, true)
				--EscortGroupParamHandler = actionParamPanels.EscortGroupParamHandler:create(handler, 1, true)
			}
			
			function lastWptCheckBox.onChange(self)
				handler.data.actionParams.lastWptIndexFlag = self:getState()
				handler.data.actionParams.lastWptIndexFlagChangedManually = handler.data.actionParams.lastWptIndexFlag
				handler.data.actionParams.lastWptIndex = lastWptSpinBox:getCurIndex()
				lastWptSpinBox:setEnabled(handler.data.actionParams.lastWptIndexFlag)
			end
			
			function lastWptSpinBox.onChange(self)
				handler.data.actionParams.lastWptIndex = self:getCurIndex()
			end
			
			function maxDistSpinBox.onChange(self)
				handler.data.actionParams.engagementDistMax = maxDistUnitSpinBox:getValue()
			end
			
			return handler
		end,	
		
		
		--actionDB.ActionType.ENROUTE_TASK
		[actionDB.ActionId.ENGAGE_TARGETS] = function()
			
			local cdata = {
				maxEngageDistance	= _('ENGAGE DIST')
			}
		
			local engageTargetsParamBox = createParamPanel(9)
			local lines = actionParamPanels.addLines(engageTargetsParamBox, 1, 1)
		
			local maxDistCheckBox = widgetFactory.createCheckBox(cdata.maxEngageDistance, 0, 0, 2 * U.text_w, U.widget_h)
			lines[1]:insertWidget(maxDistCheckBox)
					
			local maxDistSpinBox = widgetFactory.createSpinBox(1, 250, 2 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
			maxDistSpinBox:setStep(1000)
			lines[1]:insertWidget(maxDistSpinBox)
			
			local distUnitLabel = createStatic('', 2 * U.text_w +  U.spin_long_w - 15 + U.dist_w, 0, U.text_w, U.widget_h)
			lines[1]:insertWidget(distUnitLabel)
			
			local maxDistUnitSpinBox = U.createUnitSpinBox(distUnitLabel, maxDistSpinBox, U.distanceUnits, 0, 500000.0)
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					
					maxDistCheckBox:setState(data.actionParams.maxDistEnabled)
					
					maxDistUnitSpinBox:setUnitSystem(getUnits())
					maxDistSpinBox:setEnabled(data.actionParams.maxDistEnabled)
					maxDistUnitSpinBox:setValue(data.actionParams.maxDist)
				end,
				panel = engageTargetsParamBox,
			}
			handler.childs = {
				targetTypes			= actionParamPanels.TargetTypes:create(handler,2, 7, true),
				priorityParamBox	= actionParamPanels.PriorityParamBox:create(handler, 9)
			}
			
			function maxDistCheckBox:onChange()
				maxDistSpinBox:setEnabled(self:getState())
				handler.data.actionParams.maxDistEnabled = self:getState()
			end
			function maxDistSpinBox:onChange()
				handler.data.actionParams.maxDist = maxDistUnitSpinBox:getValue()
			end	
			
			return handler
		end,
		[actionDB.ActionId.ENGAGE_TARGETS_IN_ZONE] = function()
			local engageTargetsInZoneParamBox = createParamPanel(9)
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					if not(data.actionParams.x and data.actionParams.y) then
						data.actionParams.x, data.actionParams.y = getStrikePoint()
					end
					actionMapObjects.mark.set(	data.mapObjects,
												data.actionParams.x, data.actionParams.y,
												data.actionParams.zoneRadius,
												vdata.group, vdata.wpt, vdata.task)
				end,
				panel = engageTargetsInZoneParamBox,
			}
			handler.childs = {
				actionParamPanels.ZoneRadius:create(handler, 1, true, 500000.0),
				actionParamPanels.TargetTypes:create(handler, 2, 7, true),
				actionParamPanels.PriorityParamBox:create(handler, 9)
			}
			return handler			
		end,
		[actionDB.ActionId.ENGAGE_GROUP] 		= function()
			return engageGroup(false)
		end,
		[actionDB.ActionId.ENGAGE_UNIT]			= function()
			local engageUnitBox = createParamPanel(11)
			local handler = {
				openChilds = function(self, data)
					self.childs.attackUnitParamBox:open(data)
					self.childs.visibleParamBox:open(data)
					local unit = base.module_mission.unit_by_id[self.data.actionParams.unitId]
					local group = unit and unit.boss
					self.childs.strike:open(data, group and group.type)			
					self.childs.priorityParamBox:open(data)
				end,
				onMapUnitSelected = function(self, unit)
					return self.childs.attackUnitParamBox:onMapUnitSelected(unit)
				end,
				--callbacks
				onChangeGroup = function(self, group)
					self.childs.strike:setTargetType(group and group.type)
					onActionChange()
				end,
				onChangeUnit = function(self, unit)
					self:onChangeGroup(unit and unit.boss)
					onActionChange()
				end,
				panel = engageUnitBox,
			}
			handler.childs = {
				attackUnitParamBox	= actionParamPanels.AttackUnitParamBox:create(handler, 1),
				visibleParamBox 	= actionParamPanels.VisibleParamBox:create(handler, 4),
				strike 				= actionParamPanels.Strike:create(handler, 5, true),
				priorityParamBox	= actionParamPanels.PriorityParamBox:create(handler, 11)
			}
			return handler
		end,
		[actionDB.ActionId.EWR]= function()
			return addEwrData()		
		end,
		[actionDB.ActionId.FAC]= function()
			return addFacData()		
		end,
		[actionDB.ActionId.FAC_ENGAGE_GROUP]= function()
			return engageGroup(true)
		end,

		[actionDB.ActionId.PARATROOPERS_DROP] = function()		
			local bombingParamBox = createParamPanel(6)
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					if not(data.actionParams.x and data.actionParams.y) then
						data.actionParams.x, data.actionParams.y = getStrikePoint()
					end
					actionMapObjects.mark.set(vdata.mapObjects, data.actionParams.x, data.actionParams.y, 0.0, vdata.group, vdata.wpt, vdata.task)
				end,
				openChilds = function(self, data)
					self.childs.strike:open(data, 'point')
				end,
				onTargetMoved = function(self, x, y)
					return false
				end,
				panel = bombingParamBox,
			}
			handler.childs = {
				strike = actionParamPanels.ParatroopersDrop:create(handler, 1, false)
			}
			return handler
		end,
		
		[actionDB.ActionId.RECOVERY_TANKER] = function()	
	
			local cdata = {
				lastWptIndex		= _('LAST WPT'),
			}
		
			local escortGroupBox = createParamPanel(9)
			local lines = actionParamPanels.addLines(escortGroupBox, 4, 2)
			
			local lastWptCheckBox = widgetFactory.createCheckBox(cdata.lastWptIndex, 0, 0, 1.7 * U.text_w, U.widget_h)
			lines[1]:insertWidget(lastWptCheckBox)
			
			local lastWptSpinBox = SpinWPT.new()
			local con_wpt = lastWptSpinBox:create(3.7 * U.text_w+6, 0, U.spin_long_w - 15, U.widget_h)
			lines[1]:insertWidget(con_wpt)
						
			local handler = {
				openChilds = function(self, data)
					self.childs.recoveryTankerGroupParamHandler:open(data)
					local group = base.module_mission.group_by_id[self.data.actionParams.groupId]
					self:onChangeGroup(group)
					self.childs.speedAndHeight:open(data)
				end,
				onMapUnitSelected = function(self, unit)
					return self.childs.recoveryTankerGroupParamHandler:onMapUnitSelected(unit)
				end,
				onTargetMoved = function(self, x, y)
					return self.childs.recoveryTankerGroupParamHandler:onTargetMoved(x, y)
				end,
				--callbacks
				onChangeGroup = function(self, group)
					local lastWptIndex = nil
					if group ~= nil then
						if #group.route.points > 1 then
							lastWptIndex = #group.route.points
						end						
					end
					if lastWptIndex ~= nil then
						self.data.actionParams.lastWptIndex = self.data.actionParams.lastWptIndex or lastWptIndex
						self.data.actionParams.lastWptIndexFlag = self.data.actionParams.lastWptIndex <= #group.route.points and self.data.actionParams.lastWptIndexFlagChangedManually
						local lastWptIndexToSet = base.math.min(self.data.actionParams.lastWptIndex, #group.route.points)
						lastWptSpinBox:setWPT(lastWptIndexToSet, #group.route.points, group.boss.name, base.math.min(2, self.data.actionParams.lastWptIndex))
						lastWptSpinBox:setCurIndex(lastWptIndexToSet)
					else
						self.data.actionParams.lastWptIndexFlag = false
					end
					lastWptCheckBox:setEnabled(lastWptIndex ~= nil)					
					lastWptCheckBox:setState(self.data.actionParams.lastWptIndexFlag)
					lastWptSpinBox:setEnabled(self.data.actionParams.lastWptIndexFlag)
					onActionChange()
				end,
				panel = escortGroupBox
			}
			handler.childs = {
				recoveryTankerGroupParamHandler = actionParamPanels.recoveryTankerGroupParamHandler:create(handler, 1, true),
				speedAndHeight = actionParamPanels.SpeedAndHeight:create(handler, 2)
			}
			
			function lastWptCheckBox.onChange(self)
				handler.data.actionParams.lastWptIndexFlag = self:getState()
				handler.data.actionParams.lastWptIndexFlagChangedManually = handler.data.actionParams.lastWptIndexFlag
				handler.data.actionParams.lastWptIndex = lastWptSpinBox:getCurIndex()
				lastWptSpinBox:setEnabled(handler.data.actionParams.lastWptIndexFlag)
			end
			
			function lastWptSpinBox.onChange(self)
				handler.data.actionParams.lastWptIndex = self:getCurIndex()
			end			
			
			return handler
		end,	
		
		[actionDB.ActionId.SHIP_HOLD_POINT] = function()	
			local holdBox = createParamPanel(6)
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
				end,
				panel = holdBox
			}
			
			return handler
		end,

		--actionDB.ActionType.ACTION
		[actionDB.ActionId.SCRIPT] 			= function()
			local scriptBox = createParamPanel(6)
			
			local scriptMemo = widgetFactory.createEditBox()
			scriptMemo:setMultiline(true)
			actionParamPanels.addChild(scriptMemo, scriptBox, 5, 2, 5, 5)
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					scriptMemo:setText(data.actionParams.command)
				end,
				panel = scriptBox
			}
			function scriptMemo:onChange()
				handler.data.actionParams.command = self:getText()
			end
			
			return handler
		end,
		[actionDB.ActionId.SCRIPT_FILE] 			= function()
			
			local cdata = {
				file = _('FILE'),
				select = _('SELECT')
			}
			
			local scriptFileBox = createParamPanel(2)
			local lines = actionParamPanels.addLines(scriptFileBox, 1, 2)
			
			lines[1]:insertWidget(createStatic(cdata.file))			
		
			local fileEditBox = widgetFactory.createEditBox(0, 0, box_w - U.text_w-50, U.widget_h)
			fileEditBox:setReadOnly(false)
			lines[2]:insertWidget(fileEditBox)
			
			local buttonFile = widgetFactory.createButton(cdata.select, box_w - U.text_w-50, 0, U.text_w+40, U.widget_h)	
			lines[2]:insertWidget(buttonFile)
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
                    if not data.actionParams.file or data.actionParams.file == "" then
                        fileEditBox.resId = mod_dictionary.getNewResourceId("advancedFile")                      
                    end
					fileEditBox:setText(mod_dictionary.getValueResource(data.actionParams.file))
				end,
				panel = scriptFileBox
			}
			
			function buttonFile:onChange()			
				local path = MeSettings.getScriptPath()
				local filters = {FileDialogFilters.script()}
				local filename = FileDialog.open(path, filters, _('Choose Lua script:'))
				
				if filename then
					MeSettings.setScriptPath(filename)
				end
				
				openFileDlgCallback(filename, fileEditBox)
				handler.data.actionParams.file = fileEditBox.resId
				onActionChange()
			end			
			
			return handler
		end,
		[actionDB.ActionId.SET_CALLSIGN] 		= function()
		
			local setCallsignBox = createParamPanel(2)
			local lines = actionParamPanels.addLines(setCallsignBox, 1, 2)
			
			local cdata = {
				callsign	= _('CALLSIGN'),
				number		= _('NUMBER')
			}
			
			local function getCallnames(group)
				local unitType = group.units[1].type
				return	DB.db.getCallnames(group.boss.id, unitType) or		
						DB.db.getUnitCallnames(group.boss.id, DB.unit_by_type[unitType].attribute)	
			end
			
			lines[1]:insertWidget(createStatic(cdata.callsign))
			
			local callsignComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			lines[1]:insertWidget(callsignComboList)
			
			local callsignEditBox = widgetFactory.createEditBox(1.7 * U.text_w, 0, 220, U.widget_h)
			lines[1]:insertWidget(callsignEditBox)			
			
			lines[2]:insertWidget(createStatic(cdata.number))		
			
			local numberSpin = widgetFactory.createSpinBox(1, 9, 1.4 * U.text_w, 0, 85, U.widget_h)
			lines[2]:insertWidget(numberSpin)
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
				
					local westernCountry = U.isWesternCountry(data.group.boss.name)
					
					callsignComboList:setVisible(westernCountry)
					callsignEditBox:setVisible(not westernCountry)					
					lines[2]:setVisible(westernCountry)
					
					if westernCountry then
						local callsigns = getCallnames(data.group)
						if callsigns then
							local callsignTable = {}
							for i, v in pairs(callsigns) do
								callsignTable[i] = { name = _(v.Name), value = v.WorldID }
							end
							U.fillComboList(callsignComboList, callsignTable)
							U.setComboBoxValue(callsignComboList, data.actionParams.callname)
						else
							callsignComboList:clear()							
						end
						numberSpin:setValue(data.actionParams.number)						
					else
						callsignEditBox:setText(data.actionParams.callsign)						
					end
				end,
				panel = setCallsignBox
			}
			
			function callsignComboList:onChange(item)
				handler.data.actionParams.callname = item.itemId.value
				onActionChange()
			end
			function callsignEditBox:onChange()
				handler.data.actionParams.callsign = base.tonumber(self:getText())
				onActionChange()
			end
			function numberSpin:onChange()
				handler.data.actionParams.number = self:getValue()
				onActionChange()
			end
			
			return handler			
		end,
		[actionDB.ActionId.SET_FREQUENCY] 		= function()
			
			local cdata = {
				frequency 		= _('FREQUENCY'),
				modulation		= _('MODULATION'),
                power           = _('POWER'),
				MHz				= _('MHz'),
                W               = _('W_editor'),
			}
			
			local setFrequencyBox = createParamPanel(3)
			local lines = actionParamPanels.addLines(setFrequencyBox, 1, 3)

			lines[1]:insertWidget(createStatic(cdata.frequency))
			
			local freqEditBox = widgetFactory.createEditBox(1.5 * U.text_w, 0, box_w - 2.0 * U.text_w-U.dist_w - 5, U.widget_h)
			lines[1]:insertWidget(freqEditBox)	
			
			lines[1]:insertWidget(createStatic(cdata.MHz, box_w - 0.5 * U.text_w-U.dist_w, 0, U.text_w, U.widget_h))
			
			lines[2]:insertWidget(createStatic(cdata.modulation))
			
			local modulationTypeTable = {
				{name = _('AM'),	value = 0},
				{name = _('FM'),	value = 1}
			}
			
			local modulationComboList = widgetFactory.createComboList(1.5 * U.text_w, 0, box_w - 2.0 * U.text_w-U.dist_w - 5, U.widget_h)
			U.fillComboList(modulationComboList, modulationTypeTable)
			lines[2]:insertWidget(modulationComboList)
			
            lines[3]:insertWidget(createStatic(cdata.power))			
			local powerEditBox = widgetFactory.createEditBox(1.5 * U.text_w, 0, box_w - 2.0 * U.text_w-U.dist_w - 5, U.widget_h)
            powerEditBox:setNumber(true)
            powerEditBox:setAcceptDecimalPoint(true)
			lines[3]:insertWidget(powerEditBox)				
			lines[3]:insertWidget(createStatic(cdata.W, box_w - 0.5 * U.text_w-U.dist_w, 0, U.text_w, U.widget_h))
            
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					freqEditBox:setText(data.actionParams.frequency  / 1000000.0)
                    powerEditBox:setText(data.actionParams.power)
					U.setComboBoxValue(modulationComboList, data.actionParams.modulation)
				end,
				panel = setFrequencyBox
			}
			
			function freqEditBox:onChange()
				local freq = base.tonumber(self:getText())
				handler.data.actionParams.frequency = (freq or 0.0) * 1000000.0
				onActionChange()
			end
            
            function powerEditBox:onChange()
				local power = base.tonumber(self:getText()) or 10.0
                if power < 0.1 then
                    power = 0.1
                end
                if power > 10000 then
                    power = 10000
                end
				handler.data.actionParams.power = power
				onActionChange()
			end
            
			function modulationComboList:onChange(item)
				handler.data.actionParams.modulation = item.itemId.value
				onActionChange()
			end
			
			return handler
			
		end,		
		[actionDB.ActionId.SET_FREQUENCYFORUNIT] 		= function()
			
			local cdata = {
				frequency 		= _('FREQUENCY'),
				modulation		= _('MODULATION'),
                power           = _('POWER'),
				MHz				= _('MHz'),
                W               = _('W_editor'),
				unit			= _('UNIT'),
				nothing			= _('NOTHING'),	
			}
			
			local setFrequencyBox = createParamPanel(4)
			local lines = actionParamPanels.addLines(setFrequencyBox, 1, 4)

			lines[1]:insertWidget(createStatic(cdata.frequency))
			
			local freqEditBox = widgetFactory.createEditBox(1.5 * U.text_w, 0, 220, U.widget_h)
			lines[1]:insertWidget(freqEditBox)	
			
			lines[1]:insertWidget(createStatic(cdata.MHz, 330, 0, U.text_w, U.widget_h))
			
			lines[2]:insertWidget(createStatic(cdata.modulation))
			
			local modulationTypeTable = {
				{name = _('AM'),	value = 0},
				{name = _('FM'),	value = 1}
			}
			
			local modulationComboList = widgetFactory.createComboList(1.5 * U.text_w, 0, 220, U.widget_h)
			U.fillComboList(modulationComboList, modulationTypeTable)
			lines[2]:insertWidget(modulationComboList)
			
            lines[3]:insertWidget(createStatic(cdata.power))			
			local powerEditBox = widgetFactory.createEditBox(1.5 * U.text_w, 0, 220, U.widget_h)
            powerEditBox:setNumber(true)
            powerEditBox:setAcceptDecimalPoint(true)
			lines[3]:insertWidget(powerEditBox)				
			lines[3]:insertWidget(createStatic(cdata.W, 330, 0, U.text_w, U.widget_h))
            
			local unitStatic = createStatic(cdata.unit)
			lines[4]:insertWidget(unitStatic)	
			local unitComboList	= widgetFactory.createComboList(1.5 * U.text_w, 0, 220, U.widget_h)	
			lines[4]:insertWidget(unitComboList)
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					freqEditBox:setText(data.actionParams.frequency  / 1000000.0)
                    powerEditBox:setText(data.actionParams.power)
					fillGroupUnits(unitComboList, data.group)					
					U.setComboBoxValue(modulationComboList, data.actionParams.modulation)
				end,
				panel = setFrequencyBox
			}
			
			function fillGroupUnits(unitComboList, group)
				unitComboList:clear()	
				unitStatic:setVisible(false)
				unitComboList:setVisible(false)
				
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				unitComboList:insertItem(voidItem)		
		
				local curUnitId = handler.data.actionParams.unitId
				handler.data.actionParams.unitId = nil
				local selectItem = voidItem	
				if group then	
					for unitIndex, unit in base.ipairs(group.units) do
						local unitDesc = DB.unit_by_type[unit.type]
						unitStatic:setVisible(true)
						unitComboList:setVisible(true)
						
						local newUnitItem = ListBoxItem.new(unit.name)
						newUnitItem.itemId = { name = unit.name, value = unit.unitId }
						unitComboList:insertItem(newUnitItem)						
							
						if newUnitItem.itemId.value == curUnitId then
							selectItem = newUnitItem
						end
					end
				end
				if selectItem then
					handler.data.actionParams.unitId = selectItem.itemId.value
					unitComboList:selectItem(selectItem)
				end
			end
				
			function freqEditBox:onChange()
				local freq = base.tonumber(self:getText())
				handler.data.actionParams.frequency = (freq or 0.0) * 1000000.0
				onActionChange()
			end
            
            function powerEditBox:onChange()
				local power = base.tonumber(self:getText()) or 10.0
                if power < 0.1 then
                    power = 0.1
                end
                if power > 10000 then
                    power = 10000
                end
				handler.data.actionParams.power = power
				onActionChange()
			end
            
			function modulationComboList:onChange(item)
				handler.data.actionParams.modulation = item.itemId.value
				onActionChange()
			end
			
			function unitComboList:onChange(item)
				handler.data.actionParams.unitId = item.itemId.value
					
				onActionChange()
			end			
			
			return handler
		end,		
		[actionDB.ActionId.TRANSMIT_MESSAGE] 	= function()
		
			local cdata = {
				file = _('FILE'),
				select = _('SELECT'),
				subtitle = _('SUBTITLE'),
				loop = _('LOOP'),
				duration = _('DURATION')
			}
			
			local transmitMessageBox = createParamPanel(9)
			local lines = actionParamPanels.addLines(transmitMessageBox, 1, 9)
			
			lines[1]:insertWidget(createStatic(cdata.file))		
		
			local fileEditBox = widgetFactory.createEditBox(0, 0, box_w - U.text_w-50, U.widget_h)
			fileEditBox:setReadOnly(false)
			lines[2]:insertWidget(fileEditBox)                         
			
			local buttonFile = widgetFactory.createButton(cdata.select, box_w - U.text_w-50, 0, U.text_w+40, U.widget_h)
			lines[2]:insertWidget(buttonFile)
			
			lines[3]:insertWidget(createStatic(cdata.subtitle))	   
			
			local scriptMemo = widgetFactory.createEditBox()
			scriptMemo:setMultiline(true)
			actionParamPanels.addChild(scriptMemo, transmitMessageBox, 5, 4, 5, 4)            
			
			local loopCheckBox = widgetFactory.createCheckBox(cdata.loop, 0, 0, 2 * U.text_w, U.widget_h)
			lines[8]:insertWidget(loopCheckBox)

			lines[9]:insertWidget(createStatic(cdata.duration, 0, 0, 1.5 * U.text_w)) 
				
			local durationSpin = widgetFactory.createSpinBox(1, 3600, 1.5 * U.text_w, 0, 85, U.widget_h)
			lines[9]:insertWidget(durationSpin)                        
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
                    if not data.actionParams.file or data.actionParams.file == "" then
                        fileEditBox.resId = mod_dictionary.getNewResourceId("advancedFile")
                    else
                        fileEditBox.resId = data.actionParams.file
                    end
					fileEditBox:setText(mod_dictionary.getValueResource(data.actionParams.file))
					scriptMemo:setText(data.actionParams.subtitle)                    
					loopCheckBox:setState(data.actionParams.loop)
					durationSpin:setEnabled(not data.actionParams.loop)
					durationSpin:setValue(data.actionParams.duration)
				end,
				panel = transmitMessageBox
			}
			
			function buttonFile:onChange()				
				local path = MeSettings.getSoundPath()
				local filters = {FileDialogFilters.sound()}
				local filename = FileDialog.open(path, filters, _('Choose sound sile:'))
				
				if filename then
					MeSettings.setSoundPath(filename)

                    openFileDlgCallback(filename, fileEditBox)
                    handler.data.actionParams.file = fileEditBox.resId
                    onActionChange()
                end
			end
			
			function scriptMemo:onChange()
				handler.data.actionParams.subtitle = self:getText()
				onActionChange()
			end
			
			function loopCheckBox:onChange()
				handler.data.actionParams.loop = self:getState()
				durationSpin:setEnabled(not handler.data.actionParams.loop)
				onActionChange()
			end
			
			function durationSpin:onChange()
				handler.data.actionParams.duration = self:getValue()
			end
			
			return handler
		end,		
		
		[actionDB.ActionId.SWITCH_WAYPOINT] 	= function()
		
			local cdata = {
				to_waypoint		= _('TO WAYPOINT'),
				from_waypoint	= _('FROM WAYPOINT'),
				current			= _('CURRENT')
			}
		
			local switchWaypointBox = createParamPanel(2)
			local lines = actionParamPanels.addLines(switchWaypointBox, 1, 2)
			
			lines[1]:insertWidget(createStatic(cdata.to_waypoint))		

            goToWaypointNumberSpin = SpinWPT.new()
            local con_wpt = goToWaypointNumberSpin:create(1.5 * U.text_w, 0, U.text_w*1.5, U.widget_h)
            lines[1]:insertWidget(con_wpt)
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)						
                            
					data.actionParams.fromWaypointIndex = data.actionParams.fromWaypointIndex or (self.data.wpt and self.data.wpt.index) --move to DB
					data.actionParams.goToWaypointIndex = data.actionParams.goToWaypointIndex or (self.data.wpt and self.data.wpt.index + 1 or 1) --move to DB
					if data.actionParams.goToWaypointIndex > #self.data.group.route.points then
						data.actionParams.goToWaypointIndex = 1
					end

                    if (data.actionParams.goToWaypointIndex == data.actionParams.fromWaypointIndex) then
                        goToWaypointNumberSpin:setEnabled(false)
                    else
                        goToWaypointNumberSpin:setEnabled(true)
                        goToWaypointNumberSpin:setWPT(data.actionParams.goToWaypointIndex, #self.data.group.route.points, 
                                               self.data.group.boss.name, nil, nil,{data.actionParams.fromWaypointIndex})
                    end					
				end,
				panel = switchWaypointBox
			}
			
			function goToWaypointNumberSpin:onChange()
				local old = handler.data.actionParams.goToWaypointIndex
				handler.data.actionParams.goToWaypointIndex = self:getCurIndex()
				if handler.data.actionParams.goToWaypointIndex == handler.data.actionParams.fromWaypointIndex then
					local delta = handler.data.actionParams.goToWaypointIndex - old
					if delta > 0 then
						if handler.data.actionParams.goToWaypointIndex < #handler.data.group.route.points - 1 then
							handler.data.actionParams.goToWaypointIndex = handler.data.actionParams.goToWaypointIndex + 1
						else
							handler.data.actionParams.goToWaypointIndex = handler.data.actionParams.goToWaypointIndex - 1
						end
					elseif delta < 0 then
						if handler.data.actionParams.goToWaypointIndex > 1 then
							handler.data.actionParams.goToWaypointIndex = handler.data.actionParams.goToWaypointIndex - 1
						else
							handler.data.actionParams.goToWaypointIndex = handler.data.actionParams.goToWaypointIndex + 1
						end
					end
                    goToWaypointNumberSpin:setCurIndex(handler.data.actionParams.goToWaypointIndex)
				end
				onActionChange()
			end
			
			return handler

		end,
		[actionDB.ActionId.SWITCH_ITEM] 		= function()
			
			local switchItemBox = createParamPanel(2)
			local lines = actionParamPanels.addLines(switchItemBox, 1, 1)
			
			lines[1]:insertWidget(createStatic(cdata.action))

			local actionComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			lines[1]:insertWidget(actionComboList)
			
			local function buildtasksList(handler, fromWaypointIndex)			
				local actionComboListItems = {}
				local comboTask = handler.data.group.route.points[fromWaypointIndex].task
				if comboTask and comboTask.params.tasks then
					for taskIndex, task in ipairs(comboTask.params.tasks) do
						if taskIndex ~= vdata.task.number then
							local actionDescription = task.number..'. '..actionDB.getTaskDescription(handler.data.group, handler.data.wpt, task)
							actionComboListItems[#actionComboListItems + 1] = { name = actionDescription, value = taskIndex }
						end
					end
				end
				U.fillComboList(actionComboList, actionComboListItems)
				actionComboList.rawItems = actionComboListItems			
			end
			
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					if data.wpt ~= nil then
						buildtasksList(self, data.wpt.index)
						U.setComboBoxValue(actionComboList, data.actionParams.actionIndex)				
					end
				end,
				panel = switchItemBox
			}
			
			function actionComboList:onChange(item)
				local actionIndex = item.itemId.value
				handler.data.actionParams.actionIndex = actionIndex
				onActionChange()
			end			
			
			return handler
		
		end,
		[actionDB.ActionId.INVISIBLE] 			= getFlagHandler,
		[actionDB.ActionId.IMMORTAL] 			= getFlagHandler,
		[actionDB.ActionId.LOADING_SHIP]		= function()
		
			local cdata  = {
				unit		= _('UNIT'),
				nothing		= _('NOTHING'),	
				cargo		= _('CARGO'),
			}
			
			local LOADINGbox = createParamPanel(6)
			local lines = actionParamPanels.addLines(LOADINGbox, 1, 6)
			
			lines[1]:insertWidget(createStatic(cdata.cargo))				
			local cargoSpin = widgetFactory.createSpinBox(0, 100, 1.5 * U.text_w, 0, 70, U.widget_h)
			lines[1]:insertWidget(cargoSpin)
			cargoSpin:setStep(10)
			lines[1]:insertWidget(createStatic("%", 1.5 * U.text_w + 75, 0, 30, U.widget_h))	

			local unitStatic = createStatic(cdata.unit)
			lines[2]:insertWidget(unitStatic)	
			local unitComboList	= widgetFactory.createComboList(1.5 * U.text_w, 0, box_w - 1.5 * U.text_w-U.dist_w - 5, U.widget_h)	
			lines[2]:insertWidget(unitComboList)
					
			local handler = {
				open = function(self, data)					
					actionParamPanels.ActionParamHandler.open(self, data)
					fillGroupUnitsLOADING(unitComboList, data.group)
										
					cargoSpin:setValue(data.actionParams.cargo)										
				end,
				panel = LOADINGbox
			}

			function fillGroupUnitsLOADING(unitComboList, group)
				unitComboList:clear()	

				unitStatic:setVisible(false)
				unitComboList:setVisible(false)
				
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				unitComboList:insertItem(voidItem)		
		
				local curUnitId = handler.data.actionParams.unitId
				handler.data.actionParams.unitId = nil
				local selectItem = voidItem	
				if group then	
					for unitIndex, unit in base.ipairs(group.units) do
						local unitDesc = DB.unit_by_type[unit.type]
						if unitDesc.deltaWaterline ~= nil  then
							unitStatic:setVisible(true)
							unitComboList:setVisible(true)
						
							local newUnitItem = ListBoxItem.new(unit.name)
							newUnitItem.itemId = { name = unit.name, value = unit.unitId }
							unitComboList:insertItem(newUnitItem)						
							
							if newUnitItem.itemId.value == curUnitId then
								selectItem = newUnitItem
							end
						end
					end
				end

				if selectItem then
					handler.data.actionParams.unitId = selectItem.itemId.value
					unitComboList:selectItem(selectItem)
				end
			end

			
			function cargoSpin:onChange()
				handler.data.actionParams.cargo = self:getValue()
				onActionChange()
			end	
		
			function unitComboList:onChange(item)
				handler.data.actionParams.unitId = item.itemId.value
				onActionChange()
			end
			
			return handler
		
		end,
		[actionDB.ActionId.ACTIVATE_TACAN]		= function()
		
			local cdata  = {
				name 		= _('NAME'),
				BEARING		= _('BEARING'),
				channelMode	= _('CHANNEL MODE'),
				channel		= _('CHANNEL'),
				callsign	= _('CALLSIGN'),
				unit		= _('UNIT'),
				nothing		= _('NOTHING'),	
			}
			
			local function calcFrequencyMHz(AA, modeChannel, channel)
				return actionDB.calcTACANFrequencyMHz(AA, modeChannel, channel)
			end 

			local function calcFrequencyMHz2(actionParams)
				return calcFrequencyMHz(actionParams.AA, actionParams.modeChannel, actionParams.channel)
			end
			

			local activateTACANbox = createParamPanel(6)
			local lines = actionParamPanels.addLines(activateTACANbox, 1, 6)
			
			lines[1]:insertWidget(createStatic(cdata.name))			
			
			local nameEditBox = widgetFactory.createEditBox(1.5 * U.text_w, 0, box_w-1.5 * U.text_w-U.dist_w-5, U.widget_h)
			lines[1]:insertWidget(nameEditBox)
			
			local bearingCheckBox = widgetFactory.createCheckBox(cdata.BEARING, 0, 0, 1.5 * U.text_w, U.widget_h)
			lines[2]:insertWidget(bearingCheckBox)

			lines[3]:insertWidget(createStatic(cdata.channelMode))
			
			local modeTable = {
				U.makeSimpleItem('X'),
				U.makeSimpleItem('Y')
			}
			
			local modeComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, box_w - 1.7 * U.text_w-U.dist_w - 5, U.widget_h)
			U.fillComboList(modeComboList, modeTable)
			lines[3]:insertWidget(modeComboList)

			lines[4]:insertWidget(createStatic(cdata.channel))			
			
			local numberSpin = widgetFactory.createSpinBox(1, 126, 1.5 * U.text_w, 0, box_w-1.5 * U.text_w-U.dist_w-5, U.widget_h)
			lines[4]:insertWidget(numberSpin)
			
			lines[5]:insertWidget(createStatic(cdata.callsign))			
			
			local callsignEditBox = widgetFactory.createEditBox(1.5 * U.text_w, 0, box_w-1.5 * U.text_w-U.dist_w-5, U.widget_h)
			lines[5]:insertWidget(callsignEditBox)	

			local unitStatic = createStatic(cdata.unit)
			lines[6]:insertWidget(unitStatic)	
			local unitComboList	= widgetFactory.createComboList(1.5 * U.text_w, 0, box_w - 1.5 * U.text_w-U.dist_w - 5, U.widget_h)	
			lines[6]:insertWidget(unitComboList)
			
		
			local handler = {
				open = function(self, data)					
					actionParamPanels.ActionParamHandler.open(self, data)
					nameEditBox:setText(data.actionParams.name)	
					fillGroupUnitsTACAN(unitComboList, data.group)
										
					U.setComboBoxValue(modeComboList, data.actionParams.modeChannel)
					modeComboList:setEnabled(data.group.type == 'plane' or data.group.type == 'vehicle');
					numberSpin:setValue(data.actionParams.channel)
					callsignEditBox:setText(data.actionParams.callsign)										
				end,
				panel = activateTACANbox
			}

			function fillGroupUnitsTACAN(unitComboList, group)
				unitComboList:clear()	
				bearingCheckBox:setState(false)
				bearingCheckBox:setVisible(false)
				unitStatic:setVisible(false)
				unitComboList:setVisible(false)
				
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				unitComboList:insertItem(voidItem)		
		
				local curUnitId = handler.data.actionParams.unitId
				handler.data.actionParams.unitId = nil
				local selectItem = voidItem	
				if group then	
					for unitIndex, unit in base.ipairs(group.units) do
						local unitDesc = DB.unit_by_type[unit.type]
						if unitDesc.TACAN == true or unitDesc.TACAN_AA == true then
							bearingCheckBox:setState(handler.data.actionParams.bearing)
							bearingCheckBox:setVisible(true)
							unitStatic:setVisible(true)
							unitComboList:setVisible(true)
						
							local newUnitItem = ListBoxItem.new(unit.name)
							newUnitItem.itemId = { name = unit.name, value = unit.unitId }
							unitComboList:insertItem(newUnitItem)						
							
							if newUnitItem.itemId.value == curUnitId then
								selectItem = newUnitItem
							end
						end
					end
				end

				local unitFilled = false
				if selectItem then
					handler.data.actionParams.unitId = selectItem.itemId.value
					unitComboList:selectItem(selectItem)
					if selectItem.itemId.value then
						fill_TACAN(base.module_mission.unit_by_id[selectItem.itemId.value])
						unitFilled = true
					end
				end
				
				if unitFilled == false and group.units[1] then
					fill_TACAN(group.units[1])
				end
				
				--onActionChange()
			end
			
			function fill_TACAN(a_unit)
				U.recursiveCopyTable(handler.data.actionParams, actionDB.fill_TACAN(a_unit, handler.data.actionParams))
			end	
			
			function nameEditBox:onChange()
				handler.data.actionParams.name = self:getText()
				onActionChange()
			end	
			
			function bearingCheckBox:onChange()
				handler.data.actionParams.bearing = self:getState()
				handler.data.actionParams.frequency = 1000000 * calcFrequencyMHz2(handler.data.actionParams)
				onActionChange()
			end
			
			function modeComboList:onChange(item)
				local modeChannel = item.itemId.value
				handler.data.actionParams.modeChannel = modeChannel
				
				--[[
				handler.data.actionParams.frequency = 1000000 * calcFrequencyMHz2(handler.data.actionParams)
				local unitDesc = DB.unit_by_type[handler.data.group.units[1].type]
				if unitDesc.TACAN == true then
					if 'vehicle' == handler.data.group.type then
						if modeChannel == 'Y'then
							handler.data.actionParams.system = 19
						elseif modeChannel == 'X' then
							handler.data.actionParams.system = 18
						end
					else	
						if modeChannel == 'X' then
							handler.data.actionParams.system = 4
						elseif modeChannel == 'Y' then
							handler.data.actionParams.system = 5
						end
					end
				else
					if modeChannel == 'X' then
						handler.data.actionParams.system = 13
					elseif modeChannel == 'Y' then
						handler.data.actionParams.system = 14
					end
				end
				--]]
				
				fill_TACAN(handler.data.group.units[1])
				
				onActionChange()
			end
			
			function numberSpin:onChange()
				handler.data.actionParams.channel = self:getValue()
				handler.data.actionParams.frequency = 1000000 * calcFrequencyMHz2(handler.data.actionParams)
				onActionChange()
			end	

			function callsignEditBox:onChange()
				handler.data.actionParams.callsign = self:getText()
				onActionChange()
			end	
			
			function unitComboList:onChange(item)
				handler.data.actionParams.unitId = item.itemId.value
				if item.itemId.value then
					fill_TACAN(base.module_mission.unit_by_id[item.itemId.value])
				end
					
				onActionChange()
			end
			
			return handler
		
		end,
		[actionDB.ActionId.ATTACH_TRAILER]		= function()
			local cdata  = {
				name 		= _('NAME'),
				who			= _('TRACTOR UNIT'),
				whom 		= _('TRAILER UNIT'),
				nothing		= _('NOTHING'),	
				start		= _('FROM START'),	
			}
			
		
			local attachTrailerBox = createParamPanel(6)
			local lines = actionParamPanels.addLines(attachTrailerBox, 1, 6)

			local unitWhoStatic = createStatic(cdata.who)
			lines[1]:insertWidget(unitWhoStatic)	
			local unitWhoComboList	= widgetFactory.createComboList(1.5 * U.text_w, 0, box_w - 1.5 * U.text_w-U.dist_w - 5, U.widget_h)	
			lines[1]:insertWidget(unitWhoComboList)
			
			local unitWhomStatic = createStatic(cdata.whom)
			lines[2]:insertWidget(unitWhomStatic)	
			local unitWhomComboList	= widgetFactory.createComboList(1.5 * U.text_w, 0, box_w - 1.5 * U.text_w-U.dist_w - 5, U.widget_h)	
			lines[2]:insertWidget(unitWhomComboList)
			
			
			local startLabel = createStatic(cdata.start)
			lines[3]:insertWidget(startLabel)				
			local startCheckBox = widgetFactory.createCheckBox('', 1.5 * U.text_w, 0, U.spin_long_w - 15, U.widget_h)
			lines[3]:insertWidget(startCheckBox)
	
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					fillGroupAttachTractor(unitWhoComboList, data.group)
					fillGroupAttachTrailer(unitWhomComboList)
					startCheckBox:setState(data.actionParams.onStartMission)					
				end,
				panel = attachTrailerBox
			}		
	
			function startCheckBox.onChange(theCheckBox)
				handler.data.actionParams.onStartMission = theCheckBox:getState()
				onActionChange()
			end
				
			function fillGroupAttachTractor(unitComboList, group)
				unitComboList:clear()	

			--	local voidItem = ListBoxItem.new(cdata.nothing)
			--	voidItem.itemId = { name = cdata.nothing, value = nil }
			--	unitComboList:insertItem(voidItem)	
		
				local curUnitId = handler.data.actionParams.unitIdTractor
				handler.data.actionParams.unitIdTractor = nil
				local selectItem --= voidItem	
				local firstItem
				if group then	
					for unitIndex, unit in base.ipairs(group.units) do
						local unitDesc = DB.unit_by_type[unit.type]
						if unitDesc.canTow ~= nil then
							local newUnitItem = ListBoxItem.new(unit.name)
							newUnitItem.itemId = { name = unit.name, value = unit.unitId }
							unitComboList:insertItem(newUnitItem)						
							
							if newUnitItem.itemId.value == curUnitId then
								selectItem = newUnitItem
							end
							
							if firstItem == nil then
								firstItem = newUnitItem
							end
						end
					end
				end

				if selectItem then
					handler.data.actionParams.unitIdTractor = selectItem.itemId.value
					unitComboList:selectItem(selectItem)
				elseif firstItem then
					handler.data.actionParams.unitIdTractor = firstItem.itemId.value
					unitComboList:selectItem(firstItem)
				end
			end
			
			function fillGroupAttachTrailer(unitComboList)
				unitComboList:clear()	
		
				local curUnitId = handler.data.actionParams.unitIdTrailer
				handler.data.actionParams.unitIdTrailer = nil
				local selectItem
				local firstItem

				local unitWho = base.module_mission.unit_by_id[handler.data.actionParams.unitIdTractor]			
				if unitWho then
					local unitDescWho = DB.unit_by_type[unitWho.type]
					if unitDescWho.canTow ~= nil then
						for k, unit in base.pairs(base.module_mission.unit_by_id) do
							local unitDescWhom = DB.unit_by_type[unit.type]							
							if unitDescWhom.canBeTowedBy ~= nil then							
								local bEnable = false
								for kWho, tagWho in base.pairs(unitDescWho.canTow) do
									for kWhom, tagWhom in base.pairs(unitDescWhom.canBeTowedBy) do									
										if tagWho == tagWhom then
											bEnable = true
										end
									end
								end
								
								if bEnable then
									local newUnitItem = ListBoxItem.new(unit.name)
									newUnitItem.itemId = { name = unit.name, value = unit.unitId }
									unitComboList:insertItem(newUnitItem)						
									
									if newUnitItem.itemId.value == curUnitId then
										selectItem = newUnitItem
									end
									
									if firstItem == nil then
										firstItem = newUnitItem
									end
								end
							end
						end
					end	
				end
				
				if selectItem then
					handler.data.actionParams.unitIdTrailer = selectItem.itemId.value
					unitComboList:selectItem(selectItem)
				elseif firstItem then
					handler.data.actionParams.unitIdTrailer = firstItem.itemId.value
					unitComboList:selectItem(firstItem)
				end
			end
			
			
			function unitWhoComboList:onChange(item)
				handler.data.actionParams.unitIdTractor = item.itemId.value
				
				fillGroupAttachTrailer(unitWhomComboList)				
				onActionChange()			
			end
			
			function unitWhomComboList:onChange(item)
				handler.data.actionParams.unitIdTrailer = item.itemId.value
					
				onActionChange()
			end
			
			return handler 
		
		end,
		
		[actionDB.ActionId.DETACH_TRAILER]		= function()
			local cdata  = {
				name 		= _('NAME'),
				who			= _('TRACTOR UNIT'),
				whom 		= _('TRAILER UNIT'),
				nothing		= _('NOTHING'),	
				direction	= _('DIRECTION'),	
			}
			
		
			local attachTrailerBox = createParamPanel(6)
			local lines = actionParamPanels.addLines(attachTrailerBox, 1, 6)

			local unitWhoStatic = createStatic(cdata.who)
			lines[1]:insertWidget(unitWhoStatic)	
			local unitWhoComboList	= widgetFactory.createComboList(1.5 * U.text_w, 0, box_w - 1.5 * U.text_w-U.dist_w - 5, U.widget_h)	
			lines[1]:insertWidget(unitWhoComboList)
			
		--	lines[2]:insertWidget(createStatic(cdata.direction))
			
		--	local attackCourseDial = widgetFactory.createDial(1.7 * U.text_w + U.dist_w + U.text_w / 4 + U.dist_w, 0, U.widget_h, U.widget_h)
		--	attackCourseDial:setRange(0, 359)
		--	attackCourseDial:setCyclic(true)
		--	lines[2]:insertWidget(attackCourseDial)
					
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					fillGroupDetachTrailer(unitWhoComboList, data.group)

					if not(data.actionParams.x and data.actionParams.y) then
						data.actionParams.x, data.actionParams.y = vdata.wpt.x+100, vdata.wpt.y+100
					end
					
					actionMapObjects.mark.set(vdata.mapObjects, data.actionParams.x, data.actionParams.y, 0.0, vdata.group, vdata.wpt, vdata.task)		
				end,
				panel = attachTrailerBox
			}

			--function attackCourseDial.onChange(self)
			--	handler.data.actionParams.direction = U.toRadians(self:getValue())
			--end
			
			function fillGroupDetachTrailer(unitComboList, group)
				unitComboList:clear()	
		
				local curUnitId = handler.data.actionParams.unitIdTractor
				handler.data.actionParams.unitIdTractor = nil
				local selectItem 
				local firstItem
				if group then	
					for unitIndex, unit in base.ipairs(group.units) do
						local unitDesc = DB.unit_by_type[unit.type]
						if unitDesc.canTow ~= nil then
							local newUnitItem = ListBoxItem.new(unit.name)
							newUnitItem.itemId = { name = unit.name, value = unit.unitId }
							unitComboList:insertItem(newUnitItem)						
							
							if newUnitItem.itemId.value == curUnitId then
								selectItem = newUnitItem
							end
							
							if firstItem == nil then
								firstItem = newUnitItem
							end
						end
					end
				end

				if selectItem then
					handler.data.actionParams.unitIdTractor = selectItem.itemId.value
					unitComboList:selectItem(selectItem)
				elseif firstItem then
					handler.data.actionParams.unitIdTractor = firstItem.itemId.value
					unitComboList:selectItem(firstItem)
				end
			end			
			
			function unitWhoComboList:onChange(item)
				handler.data.actionParams.unitIdTractor = item.itemId.value
					
				onActionChange()
			end
			
			
			return handler 
		
		end,
		
		
		[actionDB.ActionId.ACTIVATE_ICLS]		= function()
		
			local cdata  = {
				name 		= _('NAME'),
				channel		= _('CHANNEL'),
				callsign	= _('CALLSIGN'),
				unit		= _('UNIT'),
				nothing		= _('NOTHING'),	
			}			
		
			local activateICLSbox = createParamPanel(5)
			local lines = actionParamPanels.addLines(activateICLSbox, 1, 5)
			
			lines[1]:insertWidget(createStatic(cdata.name))			
			
			local nameEditBox = widgetFactory.createEditBox(1.5 * U.text_w, 0, box_w-1.5 * U.text_w-U.dist_w-5, U.widget_h)
			lines[1]:insertWidget(nameEditBox)

			lines[2]:insertWidget(createStatic(cdata.channel))			
			
			local numberSpin = widgetFactory.createSpinBox(1, 20, 1.5 * U.text_w, 0, box_w-1.5 * U.text_w-U.dist_w-5, U.widget_h)
			lines[2]:insertWidget(numberSpin)
			
			local unitStatic = createStatic(cdata.unit)
			lines[3]:insertWidget(unitStatic)	
			local unitComboList	= widgetFactory.createComboList(1.5 * U.text_w, 0, box_w - 1.5 * U.text_w-U.dist_w - 5, U.widget_h)	
			lines[3]:insertWidget(unitComboList)
				
		
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					nameEditBox:setText(data.actionParams.name)

					fillGroupUnitsICLS(unitComboList, data.group)
					
					numberSpin:setValue(data.actionParams.channel)
				end,
				panel = activateICLSbox
			}
			
			function fillGroupUnitsICLS(unitComboList, group)
				unitComboList:clear()	
				unitStatic:setVisible(false)
				unitComboList:setVisible(false)
				
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				unitComboList:insertItem(voidItem)		
		
				local curUnitId = handler.data.actionParams.unitId
				handler.data.actionParams.unitId = nil
				local selectItem = voidItem	
				if group then	
					for unitIndex, unit in base.ipairs(group.units) do
						local unitDesc = DB.unit_by_type[unit.type]
						if unitDesc.ICLS == true then
							unitStatic:setVisible(true)
							unitComboList:setVisible(true)
						
							local newUnitItem = ListBoxItem.new(unit.name)
							newUnitItem.itemId = { name = unit.name, value = unit.unitId }
							unitComboList:insertItem(newUnitItem)						
							
							if newUnitItem.itemId.value == curUnitId then
								selectItem = newUnitItem
							end
						end
					end
				end

				if selectItem then
					handler.data.actionParams.unitId = selectItem.itemId.value
					unitComboList:selectItem(selectItem)
					--if selectItem.itemId.value then
					--	setDefaultSystemICLS(base.module_mission.unit_by_id[selectItem.itemId.value])
					--end
				end
			end
			
			function setDefaultSystemICLS(a_unit)
				local unitDesc = DB.unit_by_type[a_unit.type]
				if unitDesc.TACAN == true then				
					if 'ship' == handler.data.group.type then
						handler.data.actionParams.system = 3
					elseif 'vehicle' == handler.data.group.type then
						if handler.data.actionParams.modeChannel == 'Y'then
							handler.data.actionParams.system = 19
						else
							handler.data.actionParams.system = 18
						end	
					else
						handler.data.actionParams.system = 4
					end
				else
					handler.data.actionParams.system = 13
				end
			end	
			
			function nameEditBox:onChange()
				handler.data.actionParams.name = self:getText()
				onActionChange()
			end	
					
			function numberSpin:onChange()
				handler.data.actionParams.channel = self:getValue()
				onActionChange()
			end	
			
			function unitComboList:onChange(item)
				handler.data.actionParams.unitId = item.itemId.value
				--if item.itemId.value then
				--	setDefaultSystemICLS(base.module_mission.unit_by_id[item.itemId.value])
				--end
					
				onActionChange()
			end
			
			return handler
		
		end,	
		[actionDB.ActionId.ACTIVATE_LINK4] = function()		
			local cdata  = {
				name 		= _('NAME'),
				unit		= _('UNIT'),
				nothing		= _('NOTHING'),	
				frequency 	= _('FREQUENCY'),
				MHz			= _('MHz'),
			}			
		
			local activateBox = createParamPanel(5)
			local lines = actionParamPanels.addLines(activateBox, 1, 5)
			
			lines[1]:insertWidget(createStatic(cdata.name))			
			
			local nameEditBox = widgetFactory.createEditBox(1.5 * U.text_w, 0, box_w-1.5 * U.text_w-U.dist_w-5, U.widget_h)
			lines[1]:insertWidget(nameEditBox)

			lines[2]:insertWidget(createStatic(cdata.frequency))			
			
			local numberSpin = widgetFactory.createSpinBox(225.0, 399.9, 1.5 * U.text_w, 0, 70, U.widget_h)
			numberSpin:setAcceptDecimalPoint(true)
			numberSpin:setFormatString("%0.1f")
			lines[2]:insertWidget(numberSpin)
			
			lines[2]:insertWidget(createStatic(cdata.MHz, 1.5 * U.text_w+75, 0, U.text_w, U.widget_h))
			
			local unitStatic = createStatic(cdata.unit)
			lines[3]:insertWidget(unitStatic)	
			local unitComboList	= widgetFactory.createComboList(1.5 * U.text_w, 0, box_w - 1.5 * U.text_w-U.dist_w - 5, U.widget_h)	
			lines[3]:insertWidget(unitComboList)
				
		
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					nameEditBox:setText(data.actionParams.name)

					fillGroupUnitsLINK4(unitComboList, data.group)
					
					data.actionParams.frequency = data.actionParams.frequency or 336000000
					numberSpin:setValue(data.actionParams.frequency/1000000)
				end,
				panel = activateBox
			}
			
			function fillGroupUnitsLINK4(unitComboList, group)
				unitComboList:clear()	
				unitStatic:setVisible(false)
				unitComboList:setVisible(false)
				
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				unitComboList:insertItem(voidItem)		
		
				local curUnitId = handler.data.actionParams.unitId
				handler.data.actionParams.unitId = nil
				local selectItem = voidItem	
				if group then	
					for unitIndex, unit in base.ipairs(group.units) do
						local unitDesc = DB.unit_by_type[unit.type]
						if (DB.findAttribute(unitDesc.attribute, 'Aircraft Carriers') == true
							or unitDesc.attribute[3] == base.wsType_AirCarrier)
								and DB.findAttribute(unitDesc.attribute, 'Link4') == true then
							unitStatic:setVisible(true)
							unitComboList:setVisible(true)
						
							local newUnitItem = ListBoxItem.new(unit.name)
							newUnitItem.itemId = { name = unit.name, value = unit.unitId }
							unitComboList:insertItem(newUnitItem)						
							
							if newUnitItem.itemId.value == curUnitId then
								selectItem = newUnitItem
							end
						end
					end
				end

				if selectItem then
					handler.data.actionParams.unitId = selectItem.itemId.value
					unitComboList:selectItem(selectItem)
				end
			end		
			
			function nameEditBox:onChange()
				handler.data.actionParams.name = self:getText()
				onActionChange()
			end	
					
			function numberSpin:onChange()
				handler.data.actionParams.frequency = base.math.floor(self:getValue() * 10)*100000
				onActionChange()
			end	
			
			function unitComboList:onChange(item)
				handler.data.actionParams.unitId = item.itemId.value					
				onActionChange()
			end
			
			return handler
		
		end,
		[actionDB.ActionId.ACTIVATE_ACLS] = function()		
			local cdata  = {
				name 		= _('NAME'),
				unit		= _('UNIT'),
				nothing		= _('NOTHING'),	
			}			
		
			local activateBox = createParamPanel(5)
			local lines = actionParamPanels.addLines(activateBox, 1, 5)
			
			lines[1]:insertWidget(createStatic(cdata.name))			
			
			local nameEditBox = widgetFactory.createEditBox(1.5 * U.text_w, 0, box_w-1.5 * U.text_w-U.dist_w-5, U.widget_h)
			lines[1]:insertWidget(nameEditBox)
			
			local unitStatic = createStatic(cdata.unit)
			lines[2]:insertWidget(unitStatic)	
			local unitComboList	= widgetFactory.createComboList(1.5 * U.text_w, 0, box_w - 1.5 * U.text_w-U.dist_w - 5, U.widget_h)	
			lines[2]:insertWidget(unitComboList)
				
		
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					nameEditBox:setText(data.actionParams.name)

					fillGroupUnitsACLS(unitComboList, data.group)
				end,
				panel = activateBox
			}
			
			function fillGroupUnitsACLS(unitComboList, group)
				unitComboList:clear()	
				unitStatic:setVisible(false)
				unitComboList:setVisible(false)
				
				local voidItem = ListBoxItem.new(cdata.nothing)
				voidItem.itemId = { name = cdata.nothing, value = nil }
				unitComboList:insertItem(voidItem)		
		
				local curUnitId = handler.data.actionParams.unitId
				handler.data.actionParams.unitId = nil
				local selectItem = voidItem	
				if group then	
					for unitIndex, unit in base.ipairs(group.units) do
						local unitDesc = DB.unit_by_type[unit.type]
						if (DB.findAttribute(unitDesc.attribute, 'Aircraft Carriers') == true
							or unitDesc.attribute[3] == base.wsType_AirCarrier)
								and DB.findAttribute(unitDesc.attribute, 'ACLS') == true then
							unitStatic:setVisible(true)
							unitComboList:setVisible(true)
						
							local newUnitItem = ListBoxItem.new(unit.name)
							newUnitItem.itemId = { name = unit.name, value = unit.unitId }
							unitComboList:insertItem(newUnitItem)						
							
							if newUnitItem.itemId.value == curUnitId then
								selectItem = newUnitItem
							end
						end
					end
				end

				if selectItem then
					handler.data.actionParams.unitId = selectItem.itemId.value
					unitComboList:selectItem(selectItem)
				end
			end		
			
			function nameEditBox:onChange()
				handler.data.actionParams.name = self:getText()
				onActionChange()
			end					
			
			function unitComboList:onChange(item)
				handler.data.actionParams.unitId = item.itemId.value					
				onActionChange()
			end
			
			return handler
		
		end,
		[actionDB.ActionId.EPLRS] 				= getFlagHandler,
		[actionDB.ActionId.SMOKE_ON_OFF]		= getFlagHandler,
		
		--actionDB.ActionType.OPTION
		[actionDB.ActionId.ROE]					= getOptionEnumHandler,
		[actionDB.ActionId.ALARM_STATE]			= getOptionEnumHandler,
        [actionDB.ActionId.ENGAGE_AIR_WEAPONS]	= getFlagHandler,
		--[actionDB.ActionId.AWARNESS_LEVEL]		= getOptionEnumHandler,
		[actionDB.ActionId.REACTION_ON_THREAT]	= getOptionEnumHandler,
		[actionDB.ActionId.RADAR_USING]			= getOptionEnumHandler,
		[actionDB.ActionId.FLARE_USING]			= getOptionEnumHandler,
		[actionDB.ActionId.RESTRICT_TARGET]		= getOptionEnumHandler,
		[actionDB.ActionId.FORMATION]			= 
		
		function()
		
			local function getVariantComboListItems(variants)
				local itemsToFill = {}
				for index, variant in pairs(variants) do
					base.table.insert(	itemsToFill, 
										{ 	name = variant.name, 
											value = index })
				end
				return itemsToFill
			end
			
			local function getDefaultParams(formation)
				local zInverse = formation.zInverse and 0 or nil
				local variantIndex = formation.variants ~= nil and formation.defaultVariantIndex or nil
				return zInverse, variantIndex
			end
			
			local function recalcValue(actionParams)
				actionParams.value = actionParams.formationIndex * 256 * 256 + (actionParams.zInverse or 0) * 256 + (actionParams.variantIndex or 0)
			end
					
			local panel = createParamPanel(3)
			local lines = actionParamPanels.addLines(panel, 1, 3)
			
			local cdata = {
				type = _('TYPE'),
				side = _('SIDE'),
				variant = _('VARIANT')
			}
			
			lines[1]:insertWidget(createStatic(cdata.type))			
			local typeComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			lines[1]:insertWidget(typeComboList)			
			
			local sideStatic = createStatic(cdata.side)
			lines[2]:insertWidget(sideStatic)
			
			local sideComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			lines[2]:insertWidget(sideComboList)			
			
			local sideComboListItems = {
				{ name = _('Right_turn', 'Right'), 	value = 0 },
				{ name = _('Left_turn', 'Left'), 	value = 1 }
			}			
					
			local variantStatic = createStatic(cdata.variant)			
			lines[3]:insertWidget(variantStatic)
			
			local variantComboList = widgetFactory.createComboList(1.7 * U.text_w, 0, 220, U.widget_h)
			lines[3]:insertWidget(variantComboList)	
			
			local function updateParams(formation, data)				
				if formation.zInverse then
					U.fillComboList(sideComboList, sideComboListItems)
					U.setComboBoxValue(sideComboList, data.actionParams.zInverse)
					sideComboList:setVisible(true)
					sideStatic:setVisible(true)
				else
					sideComboList:clear()
					sideComboList:setVisible(false)
					sideStatic:setVisible(false)
				end
				sideComboList:setEnabled(formation.zInverse == true)
				
				if formation.variants ~= nil then
					local variantItems = getVariantComboListItems(formation.variants)
					U.fillComboList(variantComboList, variantItems)							
					U.setComboBoxValue(variantComboList, data.actionParams.variantIndex)
					variantComboList:setVisible(true)
					variantStatic:setVisible(true)
				else
					variantComboList:clear()
					variantComboList:setVisible(false)
					variantStatic:setVisible(false)
				end
				variantComboList:setEnabled(formation.variants ~= nil)
			end			
			
			local handler = {
			
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)						
					local rawTypeItems = getOptionEnumComboListItems(data)
					U.fillComboList(typeComboList, rawTypeItems)
					selectDefaultItem(typeComboList, getDefaultOptionEnumValue(data))									
					data.actionParams.value = data.actionParams.value or getDefaultOptionEnumValue(data) --move to DB						
					data.actionParams.variantIndex = data.actionParams.variantIndex or data.actionParams.intervalIndex --move to DB
					local defaultParams = false;
					if data.actionParams.formationIndex == nil then
						data.actionParams.formationIndex = data.actionParams.value						
						defaultParams = true						
					end
					U.setComboBoxValue(typeComboList, data.actionParams.formationIndex)
					
					local formation = DB.db.Formations[data.group.type].list[data.actionParams.formationIndex]
					if defaultParams then
						data.actionParams.zInverse, data.actionParams.variantIndex = getDefaultParams(formation)
					end
					
					updateParams(formation, data)

				end,
				panel = panel
			}
			function typeComboList:onChange(item)
				if handler.data.actionParams.formationIndex ~= item.itemId.value then
					handler.data.actionParams.formationIndex = item.itemId.value
					local formation = DB.db.Formations[handler.data.group.type].list[handler.data.actionParams.formationIndex]
					handler.data.actionParams.zInverse, handler.data.actionParams.variantIndex = getDefaultParams(formation)
					recalcValue(handler.data.actionParams)				
					updateParams(formation, handler.data)
					onActionChange()
				end
			end
			function sideComboList:onChange(item)
				handler.data.actionParams.zInverse = item.itemId.value
				recalcValue(handler.data.actionParams)
				onActionChange()
			end
			function variantComboList:onChange(item)
				handler.data.actionParams.variantIndex = item.itemId.value
				recalcValue(handler.data.actionParams)
				onActionChange()
			end
			return handler
		end,
		
		[actionDB.ActionId.RTB_ON_BINGO]		= getFlagHandler,
		[actionDB.ActionId.RTB_ON_OUT_OF_AMMO]	= getOptionEnumHandler,
		[actionDB.ActionId.SILENCE]				= getFlagHandler,
		[actionDB.ActionId.DISPERSE_ON_ATTACK]	= getNumericHandler,
		[actionDB.ActionId.ECM_USING]			= getOptionEnumHandler,
		
		[actionDB.ActionId.PROHIBIT_AA]				= getFlagHandler,
		[actionDB.ActionId.PROHIBIT_JETT]			= getFlagHandler,
		[actionDB.ActionId.PROHIBIT_AB]				= getFlagHandler,
		[actionDB.ActionId.PROHIBIT_AG]				= getFlagHandler,
		
		[actionDB.ActionId.MISSILE_ATTACK]			= getOptionEnumHandler,
		[actionDB.ActionId.PROHIBIT_WP_PASS_REPORT]	= getFlagHandler,		
		[actionDB.ActionId.RADIO_USAGE_CONTACT] 		= function()
								
			local engageTargetsParamBox = createParamPanel(9)
			local lines = actionParamPanels.addLines(engageTargetsParamBox, 1, 1)
		
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
				end,
				panel = engageTargetsParamBox,
			}
			handler.childs = {
				targetTypes			= actionParamPanels.TargetTypes:create(handler, 2, 7, true, true)
			}			
						
			return handler
		end,
		[actionDB.ActionId.RADIO_USAGE_ENGAGE] 		= function()
								
			local engageTargetsParamBox = createParamPanel(9)
			local lines = actionParamPanels.addLines(engageTargetsParamBox, 1, 1)
		
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
				end,
				panel = engageTargetsParamBox,
			}
			handler.childs = {
				targetTypes			= actionParamPanels.TargetTypes:create(handler, 2, 7, true, true)
			}
						
			return handler
		end,
		[actionDB.ActionId.RADIO_USAGE_KILL] 		= function()
								
			local engageTargetsParamBox = createParamPanel(9)
			local lines = actionParamPanels.addLines(engageTargetsParamBox, 1, 1)
		
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
				end,
				panel = engageTargetsParamBox,
			}
			handler.childs = {
				targetTypes			= actionParamPanels.TargetTypes:create(handler, 2, 7, true, true)
			}
						
			return handler
		end,
		
		[actionDB.ActionId.AIRCRAFT_INTERCEPT_RANGE] 		= function()
								
			local panel = createParamPanel(2)
			local lines = actionParamPanels.addLines(panel, 1, 1)
			
			lines[1]:insertWidget(createStatic(_("Range")))
			local valueSpin = widgetFactory.createSpinBox(1, 100, 1.7 * U.text_w, 0, 70, U.widget_h)
			lines[1]:insertWidget(valueSpin)
			lines[1]:insertWidget(createStatic("%", 1.7 * U.text_w + 75, 0, 30, U.widget_h))			
		
			local handler = {
				open = function(self, data)
					actionParamPanels.ActionParamHandler.open(self, data)
					local optionData = actionDB.optionValues[data.actionParams.name]
					valueSpin:setRange(optionData.min, optionData.max)	
					data.actionParams.value = data.actionParams.value or optionData.default	
					valueSpin:setValue(data.actionParams.value)	
				end,
				panel = panel,
			}
			
			function valueSpin:onChange()
				handler.data.actionParams.value = self:getValue()
				onActionChange()
			end
						
			return handler
		end,
		
		[actionDB.ActionId.JETT_TANKS_IF_EMPTY]		= getFlagHandler,
		[actionDB.ActionId.FORCED_ATTACK]			= getFlagHandler,
		
		[actionDB.ActionId.ALT_RESTRICTION_MIN] 	= getNumericHandler,
		[actionDB.ActionId.ALT_RESTRICTION_MAX] 	= getNumericHandler,
	}

	function setActionsListBox(actionsListBoxIn)
		vdata.actionsListBox = actionsListBoxIn
	end
		
	function show(b)	
		if b then
			window:setVisible(true)
			return true
		else
			window:setVisible(false)
			if vdata.curParamPanel then
				vdata.curParamPanel:close()		
				vdata.curParamPanel = nil
			end
			panelActionCondition.close()
			checkControlledTask()
			conditionButton:setState(false)
			stopConditionButton:setState(false)	
			vdata.group = nil
			vdata.wpt = nil
			vdata.task = nil
			return true
		end
	end
	
	function open(itemNumber, group, wpt, task)
		vdata.group = group
		vdata.wpt = wpt
		vdata.task = task        
		vdata.groupTask = crutches.taskToId(vdata.group.task) or 'Default'
		vdata.actionParams = actionDB.getActionParams(task)
		base.assert(vdata.actionParams ~= nil)
		vdata.mapObjects = actionMapObjects.getMapElements(task)
		base.assert(vdata.mapObjects ~= nil)
		local actionId = actionDB.getActionIdByTask(task)
		local actionType = actionDB.actionsData[actionId].type
		if wpt == nil then
			conditionButton:setState(false)
		end
		conditionButton:setVisible(wpt ~= nil)        
		openAction(itemNumber, actionType, actionId)
		--onActionChange()
	end
	
	function setItemCount(itemCount)
		numberSpin:setRange(1, itemCount)
	end
	
	function isVisible()
		return window:isVisible()
	end

	function update()
		
	end

	function onGroupTaskChange()
		if window:isVisible() then
			vdata.groupTask = crutches.taskToId(vdata.group.task) or 'Default'
			fillActionComboList(vdata.actionType, vdata.actionId)
			setActionIdComboListValue(vdata.actionId)
			onActionChange()
		end
	end
	
	function onUnitTypeChange()
		if window:isVisible() then
			fillActionComboList(vdata.actionType, vdata.actionId)
			setActionIdComboListValue(vdata.actionId)
			onActionChange()
		end
	end
	
	function onConditionsChange()
		vdata.actionsListBox:onActionChange()
	end

	function onMapUnitSelected(unit)
		if 	vdata.curParamPanel and
			vdata.curParamPanel.onMapUnitSelected then
			return vdata.curParamPanel:onMapUnitSelected(unit)
		end
		return false
	end

	function onTargetMoved(x, y)
		if 	vdata.curParamPanel and
			vdata.curParamPanel.onTargetMoved then
			return vdata.curParamPanel:onTargetMoved(x, y)
		end
		return window:isVisible()
	end

end