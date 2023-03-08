local DialogLoader	= require('DialogLoader')
local i18n			= require('i18n'		)

local _ = i18n.ptranslate

local panelMain_

local function getPanelMain()
	if not panelMain_ then
		local localization = {
			finish 			= _(
[[Congratulations!
Controls tuning has done.
Press Ok to close Controls Wizard.
]]),
		}
		local dialog = DialogLoader.spawnDialogFromFile('./Scripts/Input/WizardFinishPage.dlg', localization)
		
		panelMain_ = dialog.panelMain
		panelMain_:setPosition(0, 0)
		
		dialog:removeWidget(dialog.panelMain)
		dialog:kill()
	end
	
	return panelMain_ 
end

local function handleKey(name, deviceId, isModifier)
end

local function handleAxis(name, deviceId, value)
end

local function getCombos()
	return {}
end

local function resetCombos()
end

local function changeProgress()
end

return {
	getPanelMain 	= getPanelMain	,
	handleKey		= handleKey		,
	handleAxis		= handleAxis	,
	getCombos		= getCombos		,
	getCombosToSave	= getCombos		,
	resetCombos		= resetCombos	,
	changeProgress	= changeProgress,
}