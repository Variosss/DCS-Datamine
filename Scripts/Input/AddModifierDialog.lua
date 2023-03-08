local Input 			= require('Input')
local DialogLoader		= require('DialogLoader')
local ListBoxItem		= require('ListBoxItem')
local InputData			= require('Input.Data')
local InputUtils		= require('Input.Utils')
local UpdateManager 	= require('UpdateManager')
local Factory			= require('Factory')
local i18n				= require('i18n')
local Gui 				= require('dxgui')

local _ = i18n.ptranslate

local cdata = {
	ok						= _('OK'										),
	cancel					= _('CANCEL'									),
	deviceName				= _('Device Name'								),
	addModifier				= _('ADD MODIFIER'								),
	addSwitch				= _('ADD SWITCH'								),
	selectModifierButton	= _('Select modifier button'					),
	selectSwitchButton		= _('Select switch button'						),
	modifierButtonName		= _('Modifier button Name'						),
	switchButtonName		= _('Switch button name'						),
	modifierWithNameExists	= _('Modifier with this name already exists!'	),
	switchWithNameExists	= _('Switch with this name already exists!'		),
	modifierNameEmpty		= _('Modifier name cannot be empty!'			),
	switchNameEmpty			= _('Switch name cannot be empty!'				),
	error					= _('ERROR'										),
	keyInUse				= _("Warning! This key is in use!"				),
	keyInUseInUiLayer		= _("Warning! This key is in use in UI Layer!"	),
}

local inputLayerName_ = 'InputOptionsSetModifiers'
-- команды слоя инпута не должны пересекаться с командами симулятора
local maxCommandValue		= 10000

local function checkEventInUse_(self, deviceName, event)
	if deviceName and event then
		if not self.profileKeyCommands_ then
			self.profileKeyCommands_ = InputData.getProfileKeyCommands(self.profileName_)
		end
		
		local keyName = InputUtils.getDeviceEventName(event, deviceName)
		
		for i, command in ipairs(self.profileKeyCommands_) do
			for combo in InputData.commandCombos(command, deviceName) do
				if combo.key == keyName then
					self.staticWarning_:setText(cdata.keyInUse)
					self.staticWarning_:setVisible(true)
				
					return
				end
			end
		end
		
		if InputData.getKeyIsInUseInUiLayer(deviceName, keyName) then
			self.staticWarning_:setText(cdata.keyInUseInUiLayer)
			self.staticWarning_:setVisible(true)
				
			return
		end
	end
	
	self.staticWarning_:setVisible(false)
end

local function getDeviceName_(self)
	local item = self.comboListDevice_:getSelectedItem()
	
	if item then
		return item.deviceName
	end
end

local function getModifierEvent_(self)
	local item = self.comboListModifier_:getSelectedItem()
	
	if item then
		return item.event
	end	
end

local function onModifierChanged_(self)
	local deviceName	= getDeviceName_	(self)
	local event			= getModifierEvent_	(self)
	
	checkEventInUse_(self, deviceName, event)
end

local function updateEditBoxName_(self, text)
	self.editBoxName_:setText(text)
end

local function fillComboListModifier_(self, keys)
	self.comboListModifier_:clear()
	
	for i, key in ipairs(keys) do
		local localizedName = key.localizedName
		local item = ListBoxItem.new(localizedName)
		
		item.event = key.event
		item.localizedName = localizedName
		self.comboListModifier_:insertItem(item)
	end
	
	onModifierChanged_(self)
end

local function createInputLayer_(layerName, deviceName, deviceKeys)
	Input.createLayer(layerName)
	
	local eventsToSkip	= InputUtils.getDeviceEventsToSkip(deviceName)
	local deviceId		= Input.getDeviceId(deviceName)

	for i, deviceKey in ipairs(deviceKeys) do
		local event = deviceKey.event

		if not eventsToSkip[event] then
			local reformerEvents	= nil
			local down				= event + maxCommandValue
			local pressed			= nil
			local up				= nil
		
			Input.addKeyCombo(layerName, event, deviceId, reformerEvents, down, pressed, up)
		end
	end

	Input.setTopLayer(layerName)
end

local function getDeviceNameIndex_(self, deviceNameToFind)
	for i, deviceName in pairs(self.deviceNames_) do
		if deviceName == deviceNameToFind then
			return i
		end
	end
end

local function selectDevice_(self, deviceName)
	local index = getDeviceNameIndex_(self, deviceName)
	
	self.comboListDevice_:selectItem(self.comboListDevice_:getItem(index - 1))
	self.currentDeviceKeys_ = InputUtils.getDeviceKeysNoModifiers(deviceName, self.modifiers_)
	fillComboListModifier_(self, self.currentDeviceKeys_)
	self.editBoxName_:setText()
	createInputLayer_(inputLayerName_, deviceName, self.currentDeviceKeys_)
end

local function getModifierName_(self)
	return self.editBoxName_:getText()
end

local function showErrorWindow_(message)
	MsgWindow.error(message, cdata.error, cdata.ok):show()
end

local function checkModifierNameEmpty_(self, modifierName)
	if not modifierName or '' == modifierName then
		if self.isModifiersDialog_ then
			return cdata.modifierNameEmpty
		else
			return cdata.switchNameEmpty
		end
	end
end

local function checkModifierNameExists_(self, modifierNameToCheck)
	for modifierName, modifier in pairs(self.modifiers_) do
		if modifierName == modifierNameToCheck then
			local text

			if self.isModifiersDialog_ then
				text = cdata.modifierWithNameExists
			else
				text = cdata.switchWithNameExists
			end

			return text .. ' [' .. modifier.deviceName .. ']'
		end
	end
end

local function getModifierNameValid_(self, modifierName)	
	local errorMsg = checkModifierNameEmpty_(self, modifierName)
	
	if not errorMsg then
		errorMsg = checkModifierNameExists_(self, modifierName)
	end
	
	if errorMsg then
		showErrorWindow_(errorMsg)
		
		return false
	else
		return true
	end
end

local function construct(self)
	local window = DialogLoader.spawnDialogFromFile('./Scripts/Input/AddModifierDialog.dlg', cdata)
	
	self.window_				= window
    local containerMain         = window.containerMain
	self.staticSelectButton_	= containerMain.staticSelectButton
	self.staticButtonName_		= containerMain.staticButtonName
	self.comboListModifier_		= containerMain.comboModifierSwitch
	self.comboListDevice_		= containerMain.comboDevice
	self.editBoxName_			= containerMain.editboxModifierButtonName
	self.staticWarning_			= containerMain.staticWarning
    
    local w, h = Gui.GetWindowSize()  
    local wC, hC = containerMain:getSize()   
    window:setBounds(0, 0, w, h)
    containerMain:setBounds((w-wC)/2, (h-hC)/2, wC, hC)
	
	self.comboListModifier_:addChangeCallback(function()
		local item = self.comboListModifier_:getSelectedItem()
		
		updateEditBoxName_(self, item.localizedName)
		onModifierChanged_(self)
	end)
	
	self.comboListDevice_:addChangeCallback(function()
		local item = self.comboListDevice_:getSelectedItem()
		
		selectDevice_(self, item.deviceName)
	end)
	
	self.editBoxName_:addFocusCallback(function()
		self.allowInput_ = not self.editBoxName_:getFocused()
	end)

	containerMain.pDown.buttonOk:addChangeCallback(function()
		local modifierEvent = getModifierEvent_(self)
		
		if modifierEvent then
			local modifierName = getModifierName_(self)

			if getModifierNameValid_(self, modifierName) then
				local deviceName = getDeviceName_(self)
				local eventName = InputUtils.getDeviceEventName(modifierEvent, deviceName)
				
				self.result_ = {name = modifierName, key = eventName, deviceName = deviceName}
				
				window:close()
			end
		end
	end)

	containerMain.pDown.buttonCancel:addChangeCallback(function()
		window:close()
	end)
end

local function setWindowCaptions_(self)
	if self.isModifiersDialog_ then
		self.window_				:setText(cdata.addModifier)
		self.staticSelectButton_	:setText(cdata.selectModifierButton)
		self.staticButtonName_		:setText(cdata.modifierButtonName)
	else
		self.window_				:setText(cdata.addSwitch)
		self.staticSelectButton_	:setText(cdata.selectSwitchButton)
		self.staticButtonName_		:setText(cdata.switchButtonName)
	end
end

local function fillComboListDevice_(self, deviceNames)
	self.comboListDevice_:clear()

	for i, deviceName in ipairs(deviceNames) do	 
		local item = ListBoxItem.new(deviceName)
		
		item.deviceName = deviceName
		self.comboListDevice_:insertItem(item)
	end
end

local function onProcessInput_(self)
	local inputActions = Input.getInputActions()
	
	if self.allowInput_ then
		for i, inputAction in ipairs(inputActions) do 
			local event = inputAction.action - maxCommandValue

			for i, deviceKey in ipairs(self.currentDeviceKeys_) do
				if deviceKey.event == event then
					self.comboListModifier_:selectItem(self.comboListModifier_:getItem(i - 1))
					updateEditBoxName_(self, deviceKey.localizedName)
					onModifierChanged_(self)
					
					return
				end
			end
		end
	end
end

local function show(self, profileName, modifiers, isModifiersDialog)
	self.profileName_ = profileName
	self.profileKeyCommands_ = nil
	
	self.isModifiersDialog_ = isModifiersDialog
	setWindowCaptions_(self)
	
	self.modifiers_ = modifiers
	self.deviceNames_ = InputUtils.getDevices()
	fillComboListDevice_(self, self.deviceNames_)
	
	local currentDeviceName = self.deviceNames_[1]
	
	selectDevice_(self, currentDeviceName)
	
	self.allowInput_ = true
	
	createInputLayer_(inputLayerName_, currentDeviceName, self.currentDeviceKeys_)
	
	local onProcessInput = function()
		onProcessInput_(self)
	end
	
	UpdateManager.add(onProcessInput)
	
	self.result_ = nil
	
	self.window_:setVisible(true)
	
	UpdateManager.delete(onProcessInput)
	
	Input.deleteLayer(inputLayerName_)
	
	return self.result_
end

local function kill(self)
	self.window_:kill()
	self.window_ = nil
end

return Factory.createClass({
	construct	= construct,
	show		= show,
	kill		= kill,
})