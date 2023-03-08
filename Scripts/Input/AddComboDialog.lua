local Input 			= require('Input')
local InputData			= require('Input.Data')
local DialogLoader 		= require('DialogLoader')
local InputUtils		= require('Input.Utils')
local textutil 			= require('textutil')
local UpdateManager 	= require('UpdateManager')
local Factory			= require('Factory')
local i18n				= require('i18n')
local Gui				= require("dxgui")

local inputLayerName_		= 'InputOptionsAddCombo'
local localizeInputString	= InputUtils.localizeInputString
local windowProgress_
local profilesCommandsHash_
local listBoxItemKeyOffSkin_

-- команды слоя инпута не должны пересекаться с командами симулятора
local maxCommandValue		= 10000

local function getSelectedModifierNames(selectedModifiers)
	local modifierNames = {}
	
	for modifierName, flag in pairs(selectedModifiers) do
		table.insert(modifierNames, modifierName)
	end
	
	table.sort(modifierNames, textutil.Utf8Compare)
	
	return modifierNames
end

local function getModifiersString(modifierNames)
	local result = ''
	
	for i, modifierName in ipairs(modifierNames) do
		if result == '' then
			result = modifierName
		else
			result = string.format('%s + %s', result, modifierName)
		end
	end
	
	return result
end

local function getComboHashes(command, deviceName)
	local comboHashes
	local combos = command.combos
	
	if combos then
		local deviceCombos = combos[deviceName]
		
		if deviceCombos then
			comboHashes = {}
			
			for i, combo in ipairs(deviceCombos) do
				local comboHash = InputUtils.getComboHash(combo.key, combo.reformers)
				
				if comboHash then
					table.insert(comboHashes, comboHash)
				end	
			end
		end
	end
	
	return comboHashes
end

local function findCommandName(self, keyName, modifierNames)
	local comboHash = InputUtils.getComboHash(keyName, modifierNames)
	local result
	
	if comboHash then
		result = self.commandsHash[comboHash]
	end
	
	if not result then
		local uiProfileName = InputData.getUiProfileName()
		
		if self.profileName == uiProfileName then
			for name, commandsHash in pairs(profilesCommandsHash_) do
				local commandName = commandsHash[comboHash]
				
				if commandName then
					if result then
						result = string.format('%s\n%s (%s)',result, commandName, name)
					else
						result = string.format('%s (%s)', commandName, name)
					end
				end
			end
		else
			result = self.uiCommandsHash[comboHash]
			
			if result then
				result = string.format('%s (%s)', result, uiProfileName)
			end			
		end
	end
	
	return result
end

local function updateEditBoxCurrentlyInUse(self, keyName, modifierNames)
	local text = findCommandName(self, keyName, modifierNames)
	
	self.editBoxCurrentlyInUse:setText			(text)
	self.editBoxCurrentlyInUse:setTooltipText	(text)
end

local function addModifier(self, modifierName)
	self.selectedModifiers[modifierName] = true
	
	local modifierNames = getSelectedModifierNames(self.selectedModifiers)
	
	self.editBoxModifiers:setText(getModifiersString(modifierNames))
	updateEditBoxCurrentlyInUse(self, self.selectedKey, modifierNames)
end

local function selectKey(self, keyName)
	self.selectedKey = keyName
	
	local modifierNames = getSelectedModifierNames(self.selectedModifiers)
	
	updateEditBoxCurrentlyInUse(self, keyName, modifierNames)
end

local function reset(self)
	self.selectedKey			= nil
	self.selectedModifiers		= {}
	self.comboListKey			:selectItem(nil)
	self.comboListModifier		:selectItem(nil)
	self.editBoxModifiers		:setText()
	self.editBoxCurrentlyInUse	:setText()
end

local function createResult(self)
	if self.selectedKey then
		self.result = {
			key = self.selectedKey, 
			reformers = getSelectedModifierNames(self.selectedModifiers),
		}
	end
end

local function construct(self)
	local _ = i18n.ptranslate
	local localization = {
		add_assignment_panel	= _('ADD ASSIGNMENT PANEL'),
		action					= _('Action:'),
		key_button				= _('Key, Button'),
		add_modifier			= _('Add Modifier'),
		added_modifiers			= _('Added Modifiers'),
		currently_in_use		= _('Currently in Use'),
		ok						= _('OK'),
		cancel					= _('CANCEL'),
		reset					= _('RESET'),
		axisCommands			= _('Axis Commands'),
	}
	local window = DialogLoader.spawnDialogFromFile('./Scripts/Input/AddComboDialog.dlg', localization)
	
	self.window					= window
	
    local containerMain         = window.containerMain
	
	self.comboListKey			= window.containerMain.comboKeyButton
	self.comboListModifier		= window.containerMain.comboAddModifier
	self.editBoxAction			= window.containerMain.editboxAction
	self.editBoxModifiers		= window.containerMain.editboxAddedModifiers
	self.editBoxCurrentlyInUse	= window.containerMain.editboxCurrentSetting
	self.listBoxItemKeyOffSkin	= window.containerMain.listBoxItemKeyOff:getSkin()
    
    local w, h = Gui.GetWindowSize()  
    local wC, hC = containerMain:getSize()   
	
    window:setBounds(0, 0, w, h)
    containerMain:setBounds((w-wC)/2, (h-hC)/2, wC, hC)
	
	local comboListKeyChangeCallback = function()
		local item = self.comboListKey:getSelectedItem()
		
		selectKey(self, item.name)
	end
	
	self.comboListKey:addChangeCallback(comboListKeyChangeCallback)
	self.comboListKey.callback = comboListKeyChangeCallback
	
	local comboListModifierChangeCallback = function()
		local item = self.comboListModifier:getSelectedItem()
		
		addModifier(self, item.name)
	end
	
	self.comboListModifier:addChangeCallback(comboListModifierChangeCallback)
	self.comboListModifier.callback = comboListModifierChangeCallback
	
	window.containerMain.pDown.buttonCancel:addChangeCallback(function()
		window:close()
	end)
	
	window.containerMain.pDown.buttonReset:addChangeCallback(function()
		window.containerMain.pDown.buttonReset:setFocused(false)
		reset(self)
	end)
	
	window.containerMain.pDown.buttonOk:addChangeCallback(function()
		createResult(self)
		window:close()
	end)
	
	return window
end

local function fillComboListKey(self, deviceName, isAxisCommand, modifiers)
	self.comboListKey:clear()
	
	local actions
	
	if isAxisCommand then
		actions = InputUtils.getDeviceAxes(deviceName)
	else
		actions = InputUtils.getDeviceKeysNoModifiers(deviceName, modifiers)
	end
	
	local deviceId = Input.getDeviceId(deviceName)
	
	for i, action in ipairs(actions) do
		local item = self.comboListKey:newItem(action.localizedName)
		
		if InputUtils.getDeviceKeyIsOff(action.name) then
			item:setSkin(self.listBoxItemKeyOffSkin)
		end

		item.name		= action.name
		item.event		= action.event
		item.deviceId	= deviceId
	end
end

local function fillComboListModifier(self, modifiers)
	self.comboListModifier:clear()

	local modifierNames = {}

	for modifierName, modifier in pairs(modifiers) do
		table.insert(modifierNames, modifierName)
	end

	table.sort(modifierNames, textutil.Utf8Compare)

	for i, modifierName in ipairs(modifierNames) do
		local item		= self.comboListModifier:newItem(modifierName)

		item.name		= modifierName
		item.event		= modifiers[modifierName].event
		item.deviceId	= modifiers[modifierName].deviceId
	end	
end

local function createCommandsHash(commands, deviceName)
	local commandsHash = {}
	
	for i, command in ipairs(commands) do
		local comboHashes = getComboHashes(command, deviceName)
		
		if comboHashes then
			for j, comboHash in ipairs(comboHashes) do
				commandsHash[comboHash] = localizeInputString(command.name)
			end	
		end	
	end
	
	return commandsHash
end

local function getCommands(isAxisCommand, profileName)
	if isAxisCommand then
		return InputData.getProfileAxisCommands(profileName)
	else
		return InputData.getProfileKeyCommands(profileName)
	end
end

local function addInputModifierKeys(layerName, modifiers)
	for modifierName, modifier in pairs(modifiers) do
		local event = modifier.event

		if event then
			local deviceId			= modifier.deviceId
			local reformers			= nil
			local down				= event + maxCommandValue
			local pressed			= nil
			local up				= nil

			Input.addKeyCombo(layerName, event, deviceId, reformers, down, pressed, up)
		end
	end
end

local function addInputDeviceKeys(layerName, deviceName, modifiers)
	local deviceKeys	= InputUtils.getDeviceKeysNoModifiers(deviceName, modifiers)
	local eventsToSkip	= InputUtils.getDeviceEventsToSkip(deviceName)
	local deviceId		= Input.getDeviceId(deviceName) 

	for i, deviceKey in ipairs(deviceKeys) do
		local event = deviceKey.event

		if not eventsToSkip[event] then
			local reformers			= nil
			local down				= event + maxCommandValue
			local pressed			= nil
			local up				= nil
			
			Input.addKeyCombo(layerName, event, deviceId, reformers, down, pressed, up)
		end
	end
end

local function addInputDeviceAxes(layerName, deviceName)
	local deviceAxes	= InputUtils.getDeviceAxes(deviceName)
	local eventsToSkip	= InputUtils.getDeviceEventsToSkip(deviceName)
	local deviceId		= Input.getDeviceId(deviceName)

	for i, deviceAxis in ipairs(deviceAxes) do
		local event = deviceAxis.event

		if not eventsToSkip[event] then
			local reformers			= nil
			local action			= event + maxCommandValue
			local filter			= nil
			
			Input.addAxisCombo(layerName, event, deviceId, reformers, action, filter)
		end
	end
end

local function createInputLayer(layerName, deviceName, modifiers)
	Input.createLayer(layerName)

	addInputModifierKeys(layerName, modifiers)
	addInputDeviceKeys(layerName, deviceName, modifiers)
	addInputDeviceAxes(layerName, deviceName)

	Input.setTopLayer(layerName)
end

local axesData

local function getAxisSelected(event, value)
	local result = false
	-- чтобы была выбрана ось, 
	-- пользователь должен перевести ее от минимального положения к максимальному
	local minValue = -0.8
	local maxValue = 0.8

	axesData = axesData or {}
	axesData[event] = axesData[event] or {minValue = false, maxValue = false}

	local eventData = axesData[event]

	if value < minValue then
		eventData.minValue = true
	elseif value > maxValue then
		eventData.maxValue = true
	end

	if eventData.minValue and eventData.maxValue then
		eventData.minValue = false
		eventData.maxValue = false
		
		result = true
	end

	return result
end

local function selectComboItem(comboList, event, deviceId)
	local count = comboList:getItemCount()
	
	for i = 1, count do
		local item = comboList:getItem(i - 1)
		
		if	item.event == event and 
			item.deviceId == deviceId then
			
			comboList:selectItem(item)
			comboList.callback()
			
			return true
		end
	end
	
	return false
end

local function onProcessInput(self)
	local inputActions	= Input.getInputActions()

	for i, inputAction in ipairs(inputActions) do
		local event		= inputAction.action - maxCommandValue
		
		if inputAction.hasValue then
			local value = inputAction.value
			
			if inputAction.deviceId == self.deviceId and getAxisSelected(event, value) then
				if selectComboItem(self.comboListKey	, event, inputAction.deviceId) then
				
					break
				end
			end
		else
			if 	selectComboItem(self.comboListKey		, event, inputAction.deviceId) or	
				selectComboItem(self.comboListModifier	, event, inputAction.deviceId) then
			
				break
			end
		end
	end
end

local function show(self, commandName, isAxisCommand, deviceName, profileName)
	self.profileName	= profileName
	self.deviceId		= Input.getDeviceId(deviceName)
	
	self.editBoxAction:setText(commandName)
	
	local modifiers = InputData.getProfileModifiers(profileName)
	
	fillComboListKey(self, deviceName, isAxisCommand, modifiers)
	fillComboListModifier(self, modifiers)
	
	local commands = getCommands(isAxisCommand, profileName)
	
	self.commandsHash = createCommandsHash(commands, deviceName)
	
	local uiProfileName	= InputData.getUiProfileName()
	local uiCommands	= getCommands(isAxisCommand, uiProfileName)
	
	self.uiCommandsHash = createCommandsHash(uiCommands, deviceName)
	
	if profileName == uiProfileName then
		if not profilesCommandsHash_ then	
			profilesCommandsHash_ = {}

			if not windowProgress_ then
				local cdata = {
					wait = _('Collect unit profile commands...')
				}
				
				windowProgress_ = DialogLoader.spawnDialogFromFile("./Scripts/UI/DebriefingProgressDialog.dlg", cdata)
			end
			
			windowProgress_:centerWindow()
			
			local window				= self.window
			local names					= InputData.getProfileNames()
			local count					= #names
			local i						= 0
			
			windowProgress_.progressBar:setRange(0, count - 1) -- except uiProfileName
			
			local func = function()
				windowProgress_:setVisible(true)
				
				i = i + 1
				
				local name = names[i]
				
				if name ~= uiProfileName then
					if not profilesCommandsHash_[name] or InputData.getProfileChanged(name) then
						profilesCommandsHash_[name] = createCommandsHash(getCommands(isAxisCommand, name), deviceName)
					end
				end
				
				windowProgress_.progressBar:setValue(i)
				windowProgress_.progressBar:setText	(name)
				
				if i == count then
					windowProgress_	:setVisible(false)
					window			:setVisible(true)

					return true -- удалить функцию из UpdateManager
				end
			end
			
			UpdateManager.add(func)
		else
			for name, commandsHash in pairs(profilesCommandsHash_) do
				if InputData.getProfileChanged(name) then
					profilesCommandsHash_[name] = createCommandsHash(getCommands(isAxisCommand, name), deviceName)
				end
			end
		end
	end
	
	reset(self)
	self.result = nil
	
	createInputLayer(inputLayerName_, deviceName, modifiers)
	
	local func = function()
		onProcessInput(self)
	end
	
	UpdateManager.add(func)
	
	self.window:setVisible(true)
	
	Input.deleteLayer(inputLayerName_)	
	UpdateManager.delete(func)
	
	return self.result
end

local function kill(self)
	self.window:kill()
	self.window = nil
end

return Factory.createClass({
	construct	= construct,
	show		= show,
	kill		= kill,
})