local DialogLoader		= require('DialogLoader'		)
local AxesTuneWidget	= require('AxesTuneWidget'		)
local WizardUtils		= require('Input.WizardUtils'	)
local i18n				= require('i18n'				)

local _ = i18n.ptranslate

local panelMain_
local toggleButtonRollLeft_
local toggleButtonRollRight_
local toggleButtonRoll_
local axesTuneWidget_
local rollLeftCombo_	= WizardUtils.makeKeyCombo()
local rollRightCombo_	= WizardUtils.makeKeyCombo()
local rollCombo_		= WizardUtils.makeKeyCombo()
local cdata = {
	rollDescription	= (
[[ROLL
Roll is the rotation of the longitudinal axis of the aircraft that results in one wing lowering while the other raises. This is generally controlled by the aircraft’s ailerons.
Mover your control side to side or press the desired roll left and roll right keys.
]]),
	changeBind		= _('To change a bind, click on the relevant button and repeat the above.'),
	rollLeft		= _('ROLL LEFT'	),
	rollRight		= _('ROLL RIGHT'),
	roll			= _('ROLL'		),
}

local function getPanelMain()
	if not panelMain_ then

		local dialog = DialogLoader.spawnDialogFromFile('./Scripts/Input/WizardRollPage.dlg', cdata)
		
		panelMain_				= dialog.panelMain
		toggleButtonRollLeft_	= panelMain_.toggleButtonRollLeft
		toggleButtonRollRight_	= panelMain_.toggleButtonRollRight
		toggleButtonRoll_		= panelMain_.toggleButtonRoll

		dialog:removeWidget(dialog.panelMain)
		dialog:kill()
		
		panelMain_:setPosition(0, 0)
		
		WizardUtils.toggleButtonsSetCallback(toggleButtonRollLeft_, toggleButtonRollRight_, toggleButtonRoll_, rollLeftCombo_, rollRightCombo_, rollCombo_)
		
		axesTuneWidget_ = AxesTuneWidget.new()
		axesTuneWidget_:setBounds(panelMain_.staticAxisTuneWidgetPlaceholder:getBounds())
		panelMain_:insertWidget(axesTuneWidget_)
	end
	
	return panelMain_ 
end

local function handleKey(name, deviceId, isModifier)
	WizardUtils.toggleButtonHandleKey(toggleButtonRollLeft_	, rollLeftCombo_	, name, deviceId, isModifier)
	WizardUtils.toggleButtonHandleKey(toggleButtonRollRight_, rollRightCombo_	, name, deviceId, isModifier)
end

local function handleAxis(name, deviceId, value)
	WizardUtils.toggleButtonHandleAxis(toggleButtonRoll_	, rollCombo_		, name, deviceId, value		)
end

local function getCombos()
	return {
		['roll left'	] = rollLeftCombo_	,
		['roll right'	] = rollRightCombo_	,
		['roll'			] = rollCombo_		,
	}
end

local function resetCombos()
	WizardUtils.toggleButtonReset(toggleButtonRollLeft_	, rollLeftCombo_	)
	WizardUtils.toggleButtonReset(toggleButtonRollRight_, rollRightCombo_	)
	WizardUtils.toggleButtonReset(toggleButtonRoll_		, rollCombo_		)
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