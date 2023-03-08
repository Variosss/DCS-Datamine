local InputData				= require('Input.Data')
local InputUtils			= require('Input.Utils')
local AddModifierDialog 	= require('Input.AddModifierDialog')
local DialogLoader			= require('DialogLoader')
local ListBoxItem			= require('ListBoxItem')
local textutil 				= require('textutil')
local Factory				= require('Factory')
local i18n					= require('i18n')
local Gui					= require("dxgui")

local invalidItemSkin_

local function removeModifierFromListBox_(self, listBox)
	local item = listBox:getSelectedItem()
	
	if item then
		self.modifiers_[item.modifierName] = nil
		listBox:removeItem(item)
	end
end

local function getModifierInvalid_(modifier)
	return not InputUtils.getKeyNameValid(modifier.key)
end

local function getModifierInfos_(modifiers)
	local result = {}
	
	for modifierName, modifier in pairs(modifiers) do
		table.insert(result, {name = modifierName, modifier = modifier})
	end
	
	table.sort(result, function(modifier1, modifier2)
		return textutil.Utf8Compare(modifier1.name, modifier2.name)
	end)
	
	return result
end

local function fillLists_(self, modifiers)
	self.listBoxModifiers_:clear()
	self.listBoxSwitches_:clear()
	
	local modifierInfos = getModifierInfos_(modifiers)
	
	for i, modifierInfo in pairs(modifierInfos) do
		local modifierName = modifierInfo.name
		local item = ListBoxItem.new(modifierName)
		local modifier = modifierInfo.modifier
		
		item.modifier = modifier
		item.modifierName = modifierName

		if getModifierInvalid_(modifier) then  
			item:setSkin(invalidItemSkin_)
		end
		
		if modifier.switch then
			self.listBoxSwitches_:insertItem(item)
		else
			self.listBoxModifiers_:insertItem(item)
		end
	end
end

local function construct(self)
	local _ = i18n.ptranslate
	local localization = {
		ok				= _('OK'),
		cancel			= _('CANCEL'),
		add				= _('ADD'),
		remove			= _('REMOVE'),
		modifiers		= _('Modifiers'),
		switches		= _('Switches'),
		multiswitch		= _('Multiswitch'),
		modifiersPanel	= _('MODIFIERS PANEL'),
		warning			= _('Warning'),
		yes				= _('Yes'),
		no				= _('No'),
	}
	local window = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_options_controls_modifiers.dlg', localization)

	self.window_			= window
    local containerMain     = window.containerMain
	self.listBoxModifiers_	= containerMain.listboxModifiers
	self.listBoxSwitches_	= containerMain.listboxSwitches
    
    local w, h = Gui.GetWindowSize()  
    local wC, hC = containerMain:getSize()   
    window:setBounds(0, 0, w, h)
    containerMain:setBounds((w-wC)/2, (h-hC)/2, wC, hC)
	
	invalidItemSkin_		= containerMain.listBoxItemInvalid:getSkin()

	containerMain.buttonAddModifier:addChangeCallback(function()
		local addModifierDialog = AddModifierDialog.new()
		local result = addModifierDialog:show(self.profileName_, self.modifiers_, true)
		
		if result then
			self.modifiers_[result.name] = InputData.createModifier(result.key, result.deviceName, false)
			fillLists_(self, self.modifiers_)
		end
		
		addModifierDialog:kill()
	end)

	containerMain.buttonRemoveModifier:addChangeCallback(function()
		removeModifierFromListBox_(self, self.listBoxModifiers_)
	end)
	
	containerMain.buttonAddSwitch:addChangeCallback(function()
		local addModifierDialog = AddModifierDialog.new()
		local result = addModifierDialog:show(self.profileName_, self.modifiers_, false)
		
		if result then
			self.modifiers_[result.name] = InputData.createModifier(result.key, result.deviceName, true)
			fillLists_(self, self.modifiers_)		
		end
		
		addModifierDialog:kill()
	end)
	
	containerMain.buttonRemoveSwitch:addChangeCallback(function()
		removeModifierFromListBox_(self, self.listBoxSwitches_)
	end)

	containerMain.pDown.buttonCancel:addChangeCallback(function()
		window:close()
	end)
	
	containerMain.pDown.buttonOk:addChangeCallback(function()
		self.result_ = self.modifiers_
		window:close()
	end)
end

local function show(self, profileName)
	self.profileName_ = profileName
	self.modifiers_ = InputData.getProfileModifiers(profileName)
	fillLists_(self, self.modifiers_)
	
	self.result_ = nil
	
	self.window_:setVisible(true)
	
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