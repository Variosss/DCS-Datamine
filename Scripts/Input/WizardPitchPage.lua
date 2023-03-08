local DialogLoader		= require('DialogLoader'		)
local AxesTuneWidget	= require('AxesTuneWidget'		)
local WizardUtils		= require('Input.WizardUtils'	)
local InputUtils 		= require('Input.Utils'			)
local i18n				= require('i18n'				)

local _ = i18n.ptranslate

local panelMain_
local toggleButtonPitchUp_
local toggleButtonPitchDown_
local toggleButtonPitch_
local axesTuneWidget_
local pitchUpCombo_		= WizardUtils.makeKeyCombo()
local pitchDownCombo_	= WizardUtils.makeKeyCombo()
local pitchCombo_		= WizardUtils.makeKeyCombo()
local cdata = {
	pitchDescription	= (
[[PITCH
Pitch is the movement of the nose of your aircraft up and down and is most often controlled by the elevators. 
Move your control forward and back or press the desired pitch up and pitch down keys.
]]),
	changeBind			= _('To change a bind, click on the relevant button and repeat the above.'),
	pitchUp				= _('PITCH UP'		),
	pitchDown			= _('PITCH DOWN'	),
	pitch				= _('PITCH'			),
}

local function getPanelMain()
	if not panelMain_ then

		local dialog = DialogLoader.spawnDialogFromFile('./Scripts/Input/WizardPitchPage.dlg', cdata)
		
		panelMain_				= dialog.panelMain
		toggleButtonPitchUp_	= panelMain_.toggleButtonPitchUp
		toggleButtonPitchDown_	= panelMain_.toggleButtonPitchDown
		toggleButtonPitch_		= panelMain_.toggleButtonPitch

		dialog:removeWidget(dialog.panelMain)
		dialog:kill()
		
		panelMain_:setPosition(0, 0)
		
		WizardUtils.toggleButtonsSetCallback(toggleButtonPitchUp_, toggleButtonPitchDown_, toggleButtonPitch_, pitchUpCombo_, pitchDownCombo_, pitchCombo_)
		
		axesTuneWidget_ = AxesTuneWidget.new()
		axesTuneWidget_:setBounds(panelMain_.staticAxisTuneWidgetPlaceholder:getBounds())
		panelMain_:insertWidget(axesTuneWidget_)
	end
	
	return panelMain_ 
end

local function handleKey(name, deviceId, isModifier)
	WizardUtils.toggleButtonHandleKey(toggleButtonPitchUp_	, pitchUpCombo_		, name, deviceId, isModifier)
	WizardUtils.toggleButtonHandleKey(toggleButtonPitchDown_, pitchDownCombo_	, name, deviceId, isModifier)
end

local function handleAxis(name, deviceId, value)
	WizardUtils.toggleButtonHandleAxis(toggleButtonPitch_	, pitchCombo_		, name, deviceId, value		)
end

local function getCombos()
	return {
		['pitch up'		] = pitchUpCombo_	,
		['pitch down'	] = pitchDownCombo_	,
		['pitch'		] = pitchCombo_		,
	}
end

local function resetCombos()
	WizardUtils.toggleButtonReset(toggleButtonPitchUp_	, pitchUpCombo_		)
	WizardUtils.toggleButtonReset(toggleButtonPitchDown_, pitchDownCombo_	)
	WizardUtils.toggleButtonReset(toggleButtonPitch_	, pitchCombo_		)
end

local function changeProgress()
	require('Input.Wizard').changeProgress(WizardUtils.getComboCount(getCombos()))
end

return {
	getPanelMain	= getPanelMain	,
	handleKey		= handleKey		,
	handleAxis		= handleAxis	,
	getCombos		= getCombos		,
	getCombosToSave	= getCombos		,
	resetCombos		= resetCombos	,
	changeProgress	= changeProgress,
}