local DialogLoader		= require('DialogLoader'		)
local AxesTuneWidget	= require('AxesTuneWidget'		)
local WizardUtils		= require('Input.WizardUtils'	)
local InputUtils 		= require('Input.Utils'			)
local i18n				= require('i18n'				)

local _ = i18n.ptranslate

local panelMain_
local toggleButtonThrustUp_
local toggleButtonThrustDown_
local toggleButtonThrust_
local axesTuneWidget_
local thrustUpCombo_	= WizardUtils.makeKeyCombo()
local thrustDownCombo_	= WizardUtils.makeKeyCombo()
local thrustCombo_		= WizardUtils.makeKeyCombo()
local cdata = {
	thrustDescription	= (
[[THRUST
Thrust controls the RPM setting of the engine(s) and propels the aircraft forward. This is generally controlled by the aircraft’s throttle.
Move your control forward and back or press the desired increase thrust and decrease thrust keys.
]]),
	changeBind			= _('To change a bind, click on the relevant button and repeat the above.'),
	thrustUp			= _('THRUST UP'		),
	thrustDown			= _('THRUST DOWN'	),
	thrust				= _('THRUST'		),
}

local function getPanelMain()
	if not panelMain_ then

		local dialog = DialogLoader.spawnDialogFromFile('./Scripts/Input/WizardThrustPage.dlg', cdata)
		
		panelMain_				= dialog.panelMain
		toggleButtonThrustUp_	= panelMain_.toggleButtonThrustUp
		toggleButtonThrustDown_	= panelMain_.toggleButtonThrustDown
		toggleButtonThrust_		= panelMain_.toggleButtonThrust

		dialog:removeWidget(dialog.panelMain)
		dialog:kill()
		
		panelMain_:setPosition(0, 0)
		
		WizardUtils.toggleButtonsSetCallback(toggleButtonThrustUp_, toggleButtonThrustDown_, toggleButtonThrust_, thrustUpCombo_, thrustDownCombo_, thrustCombo_)
		
		axesTuneWidget_ = AxesTuneWidget.new()
		axesTuneWidget_:setBounds(panelMain_.staticAxisTuneWidgetPlaceholder:getBounds())
		panelMain_:insertWidget(axesTuneWidget_)
	end
	
	return panelMain_ 
end

local function handleKey(name, deviceId, isModifier)
	WizardUtils.toggleButtonHandleKey(toggleButtonThrustUp_		, thrustUpCombo_	, name, deviceId, isModifier)
	WizardUtils.toggleButtonHandleKey(toggleButtonThrustDown_	, thrustDownCombo_	, name, deviceId, isModifier)
end

local function handleAxis(name, deviceId, value)
	WizardUtils.toggleButtonHandleAxis(toggleButtonThrust_		, thrustCombo_		, name, deviceId, value		)
end

local function getCombos()
	return {
		['thrust up'	] = thrustUpCombo_	,
		['thrust down'	] = thrustDownCombo_,
		['thrust'		] = thrustCombo_	,
	}
end

local function resetCombos()
	WizardUtils.toggleButtonReset(toggleButtonThrustUp_		, thrustUpCombo_	)
	WizardUtils.toggleButtonReset(toggleButtonThrustDown_	, thrustDownCombo_	)
	WizardUtils.toggleButtonReset(toggleButtonThrust_		, thrustCombo_		)
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