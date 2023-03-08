local DialogLoader	= require('DialogLoader'		)
local InputUtils	= require('Input.Utils'			)
local WizardUtils	= require('Input.WizardUtils'	)
local i18n			= require('i18n'				)

local _ = i18n.ptranslate

local panelMain_
local commands_ = {
	{name = 'toggle landing gear'				, caption = _('Toggle Landing Gear'					), combo = WizardUtils.makeKeyCombo() },
	{name = 'raise flaps'						, caption = _('Raise Flaps'							), combo = WizardUtils.makeKeyCombo() },
	{name = 'lower flaps'						, caption = _('Lower Flaps'							), combo = WizardUtils.makeKeyCombo() },
	{name = 'toggle airbrake'					, caption = _('Toggle Airbrake'						), combo = WizardUtils.makeKeyCombo() },
	{name = 'trim nose up'						, caption = _('Trim Nose Up'						), combo = WizardUtils.makeKeyCombo() },
	{name = 'trim nose down'					, caption = _('Trim Nose Down'						), combo = WizardUtils.makeKeyCombo() },
	{name = 'trim right wing down'				, caption = _('Trim Right Wing Down'				), combo = WizardUtils.makeKeyCombo() },
	{name = 'trim left wing down'				, caption = _('Trim Left Wing Down'					), combo = WizardUtils.makeKeyCombo() },
	{name = 'both wheel brakes'					, caption = _('Both Wheel Brakes'					), combo = WizardUtils.makeKeyCombo() },
	{name = 'left wheel brake'					, caption = _('Left Wheel Brake'					), combo = WizardUtils.makeKeyCombo() },
	{name = 'right wheel brake'					, caption = _('Right Wheel Brake'					), combo = WizardUtils.makeKeyCombo() },
	{name = 'eject'								, caption = _('Eject'								), combo = WizardUtils.makeKeyCombo() },
	{name = 'select navigation mode'			, caption = _('Select Navigation Mode'				), combo = WizardUtils.makeKeyCombo() },
	{name = 'select air-to-ground mode'			, caption = _('Select Air-to-Ground Mode'			), combo = WizardUtils.makeKeyCombo() },
	{name = 'select air-to-air mode'			, caption = _('Select Air-to-Air Mode'				), combo = WizardUtils.makeKeyCombo() },
	{name = 'lock target'						, caption = _('Lock Target'							), combo = WizardUtils.makeKeyCombo() },
	{name = 'unlock target'						, caption = _('Unlock Target'						), combo = WizardUtils.makeKeyCombo() },
	{name = 'select next weapon'				, caption = _('Select Next Weapon'					), combo = WizardUtils.makeKeyCombo() },
	{name = 'trigger'							, caption = _('Trigger'								), combo = WizardUtils.makeKeyCombo() },
	{name = 'weapon release button'				, caption = _('Weapon Release Button'				), combo = WizardUtils.makeKeyCombo() },
	{name = 'release chaff'						, caption = _('Release Chaff'						), combo = WizardUtils.makeKeyCombo() },
	{name = 'release flare'						, caption = _('Release Flare'						), combo = WizardUtils.makeKeyCombo() },
	{name = 'electronic countermeasures toggle'	, caption = _('Electronic Countermeasures Toggle'	), combo = WizardUtils.makeKeyCombo() },
	{name = 'radio menu'						, caption = _('Radio Menu'							), combo = WizardUtils.makeKeyCombo() },
	{name = 'view map'							, caption = _('View Map'							), combo = WizardUtils.makeKeyCombo() },
	{name = 'chat'								, caption = _('Chat'								), combo = WizardUtils.makeKeyCombo() },
}
local currCommand_ = 1

local function selectCommand()
	local command = commands_[currCommand_]
	
	panelMain_.staticCommand:setText(command.caption)
	panelMain_.staticCombo	:setText()
end

local function getPanelMain()
	if not panelMain_ then
		local localization 	= {
			select			= _('Select the keyboard key or button for:'),
			assigned		= _('Assigned:'),
		}
		local dialog = DialogLoader.spawnDialogFromFile('./Scripts/Input/WizardKeysPage.dlg', localization)
		
		panelMain_ = dialog.panelMain
		panelMain_:setPosition(0, 0)
		
		dialog:removeWidget(dialog.panelMain)
		dialog:kill()
		
		selectCommand()
	end
	
	return panelMain_ 
end

local function handleKey(name, deviceId, isModifier)
	local combo = commands_[currCommand_].combo
	
	if isModifier then
		WizardUtils.setComboReformerName(combo, name)
	else
		combo.key		= name
		combo.deviceId	= deviceId
	end
	
	panelMain_.staticCombo:setText(WizardUtils.getComboString(combo))
	
	if not isModifier then
		panelMain_.staticCombo:setTooltipText(InputUtils.getDeviceTemplateName(InputUtils.getDeviceNameById(deviceId)))
	end	
end

local function handleAxis(name, deviceId, value)
end

local function getCombos()
	local combos = {}
	local command = commands_[currCommand_]
	
	if command then
		combos[command.name] = command.combo
	end
	
	return combos
end

local function getCombosToSave()
	local combos = {}
	
	for i, command in ipairs(commands_) do
		combos[command.name] = command.combo
	end

	return combos
end

local function resetCombos()
	for i, command in ipairs(commands_) do
		WizardUtils.resetCombo(command.combo)
	end
	
	currCommand_ = 1
	selectCommand()
end

local function onOk()
	-- to next command
	local result = false -- return true if handle 
	local Wizard = require('Input.Wizard')
	
	if Wizard.assignCombos() then
		Wizard.changeProgress(1)
		
		currCommand_ = currCommand_ + 1
	
		if currCommand_ <= #commands_ then
			selectCommand()
			
			result = true
		end
	else
		result = true
	end

	return result 
end

local function onCancel()
	return false -- return true if handle 	
end

local function changeProgress() -- Progress changes on press Ok button
end

return {
	getPanelMain 	= getPanelMain		,
	handleKey		= handleKey			,
	handleAxis		= handleAxis		,
	getCombos		= getCombos			,
	getCombosToSave	= getCombosToSave	,
	resetCombos		= resetCombos		,
	changeProgress	= changeProgress	,
	onOk			= onOk				,
	onCancel		= onCancel			,
}