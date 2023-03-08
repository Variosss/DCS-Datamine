local DialogLoader		= require('DialogLoader'		)
local AxesTuneWidget	= require('AxesTuneWidget'		)
local WizardUtils		= require('Input.WizardUtils'	)
local i18n				= require('i18n'				)

local _ = i18n.ptranslate

local panelMain_
local toggleButtonYawLeft_
local toggleButtonYawRight_
local toggleButtonYaw_
local axesTuneWidget_
local yawLeftCombo_		= WizardUtils.makeKeyCombo()
local yawRightCombo_	= WizardUtils.makeKeyCombo()
local yawCombo_			= WizardUtils.makeKeyCombo()
local cdata = {
	yawDescription		= (
[[YAW
Yaw is the lateral movement of the nose side to side. This is useful for taxi, takeoff, and landings. This is generally controlled by the aircraft’s rudder pedals and vertical stabilizer.
Mover your control side to side or press the desired yaw left and yaw right keys.
]]),
	changeBind			= _('To change a bind, click on the relevant button and repeat the above.'),
	yawLeft				= _('YAW LEFT'	),
	yawRight			= _('YAW RIGHT'	),
	yaw					= _('YAW'		),
}

local function getPanelMain()
	if not panelMain_ then

		local dialog = DialogLoader.spawnDialogFromFile('./Scripts/Input/WizardYawPage.dlg', cdata)
		
		panelMain_				= dialog.panelMain
		toggleButtonYawLeft_	= panelMain_.toggleButtonYawLeft
		toggleButtonYawRight_	= panelMain_.toggleButtonYawRight
		toggleButtonYaw_		= panelMain_.toggleButtonYaw

		dialog:removeWidget(dialog.panelMain)
		dialog:kill()
		
		panelMain_:setPosition(0, 0)
		
		WizardUtils.toggleButtonsSetCallback(toggleButtonYawLeft_, toggleButtonYawRight_, toggleButtonYaw_, yawLeftCombo_, yawRightCombo_, yawCombo_)
		
		axesTuneWidget_ = AxesTuneWidget.new()
		axesTuneWidget_:setBounds(panelMain_.staticAxisTuneWidgetPlaceholder:getBounds())
		panelMain_:insertWidget(axesTuneWidget_)
	end
	
	return panelMain_ 
end

local function handleKey(name, deviceId, isModifier)
	WizardUtils.toggleButtonHandleKey(toggleButtonYawLeft_	, yawLeftCombo_	, name, deviceId, isModifier)
	WizardUtils.toggleButtonHandleKey(toggleButtonYawRight_	, yawRightCombo_, name, deviceId, isModifier)
end

local function handleAxis(name, deviceId, value)
	WizardUtils.toggleButtonHandleAxis(toggleButtonYaw_		, yawCombo_		, name, deviceId, value		)
end

local function getCombos()
	return {
		['yaw left'	] = yawLeftCombo_	,
		['yaw right'] = yawRightCombo_	,
		['yaw'		] = yawCombo_		,
	}
end

local function resetCombos()
	WizardUtils.toggleButtonReset(toggleButtonYawLeft_	, yawLeftCombo_	)
	WizardUtils.toggleButtonReset(toggleButtonYawRight_	, yawRightCombo_)
	WizardUtils.toggleButtonReset(toggleButtonYaw_		, yawCombo_		)
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