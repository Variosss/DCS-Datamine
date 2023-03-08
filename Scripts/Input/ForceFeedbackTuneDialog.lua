local DialogLoader			= require('DialogLoader')
local InputData				= require('Input.Data')
local Factory				= require('Factory')
local i18n					= require('i18n')
local Gui					= require("dxgui")

local function createResult_(self)
	return {
		trimmer		= self.spinBoxTrimmer_:getValue() / 100, 
		shake		= self.spinBoxShake_:getValue() / 100, 
		swapAxes	= self.checkBoxSwapAxes_:getState(),
		invertX		= self.checkBoxInvertX_:getState(),
		invertY		= self.checkBoxInvertY_:getState(),
	}
end

local function construct(self)
	local _ = i18n.ptranslate
	local localization = {
		ok						= _('OK'),
		cancel					= _('CANCEL'),
		deviceName				= _('Device Name'),
		trimmerForce			= _('Trimmer Force [0..100]'),
		shake					= _('Shake [0..100]'),
		forceFeedbackTunePanel	= _('Force Feedback Tune Panel'),
		swapAxes				= _('Swap Axes'),    
		invertX					= _('Invert X'),    
		invertY					= _('Invert Y'),    
	}
	
	local window = DialogLoader.spawnDialogFromFile('./Scripts/Input/ForceFeedbackTuneDialog.dlg', localization)	
  
    self.window_			= window
    local containerMain     = window.containerMain
	self.spinBoxTrimmer_	= containerMain.spinTrimmer
	self.spinBoxShake_		= containerMain.spinShake
    
	containerMain.pDown.buttonCancel:addChangeCallback(function()
		window:close()
	end)
	
	containerMain.pDown.buttonOk:addChangeCallback(function()
		self.result_ = createResult_(self)
		window:close()
	end)

	self.checkBoxSwapAxes_	= containerMain.checkboxSwapAxes
	self.checkBoxInvertX_	= containerMain.checkboxInvertX
	self.checkBoxInvertY_	= containerMain.checkboxInvertY
    
    local w, h = Gui.GetWindowSize()  
    local wC, hC = containerMain:getSize()   
    window:setBounds(0, 0, w, h)
    containerMain:setBounds((w-wC)/2, (h-hC)/2, wC, hC)
end

local function initialize_(self, forceFeedback)
	forceFeedback = InputData.createForceFeedbackSettings(forceFeedback)
	
	self.spinBoxTrimmer_	:setValue(forceFeedback.trimmer * 100)
	self.spinBoxShake_		:setValue(forceFeedback.shake * 100)
	self.checkBoxSwapAxes_	:setState(forceFeedback.swapAxes) 
	self.checkBoxInvertX_	:setState(forceFeedback.invertX) 
	self.checkBoxInvertY_	:setState(forceFeedback.invertY) 
end

local function show(self, forceFeedback)	
	initialize_(self, forceFeedback)
	
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