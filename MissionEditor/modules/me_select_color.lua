local DialogLoader		= require('DialogLoader')
local Factory			= require('Factory'		)
local SkinUtils			= require('SkinUtils'	)

local function callbackStub(r, g, b, a)
end

local function updateColorWidgets(self, r, g, b, a)
	local panel = self.panel
	
	panel.spinBoxRed	:setValue(r)
	panel.spinBoxGreen	:setValue(g)
	panel.spinBoxBlue	:setValue(b)
	panel.spinBoxAlpha	:setValue(a)
	
	panel.sliderRed		:setValue(r)
	panel.sliderGreen	:setValue(g)
	panel.sliderBlue	:setValue(b)
	panel.sliderAlpha	:setValue(a)
	
	local hexColor = string.format('0x%.2x%.2x%.2x%.2x', r, g, b, a)

	panel.staticColorView:setSkin(SkinUtils.setStaticColor(hexColor, self.staticColorViewSkin))
end

local function createColorButtons(self)
	local panel		= self.panel.panelColorButtons
	local colors	= {
		{{	0,	 0,	  0},	{128, 128, 128},	{128,	0,	 0},	{128, 128,	 0}},
		{{	0, 128,	  0},	{  0, 128, 128},	{  0,	0, 128},	{128,	0, 128}},
		{{128, 128,	 64},	{  0,  64,	64},	{  0, 128, 255},	{  0,  64, 128}},
		{{128,	 0, 255},	{128,  64,	 0},	{255, 255, 255},	{192, 192, 192}},
		{{255,	 0,	  0},	{255, 255,	 0},	{  0, 255,	 0},	{  0, 255, 255}},
		{{	0,	 0, 255},	{255,	0, 255},	{255, 255, 128},	{  0, 255, 128}},
		{{128, 255, 255},	{128, 128, 255},	{255,	0, 128},	{225, 128, 164}},
	}
	local width, height = panel:getSize()
	local buttonHeight	= height / #colors
	local buttonWidth	= width / #colors[1]
	local buttonSkin	= self.buttonColorSeed:getSkin()
	
	for i, colorRow in ipairs(colors) do
		for j, color in ipairs(colorRow) do
			local button	= self.buttonColorSeed:clone()
			local x			= buttonWidth	* (j - 1)
			local y			= buttonHeight	* (i - 1)
			
			button:setBounds(x , y, buttonWidth, buttonHeight)
			panel:insertWidget(button)
			
			button:setSkin(SkinUtils.setButtonColor(string.format('0x%.2x%.2x%.2xff', color[1], color[2], color[3]), buttonSkin))
			
			button:addChangeCallback(function()
				local r = color[1]
				local g = color[2]
				local b = color[3]
				local a = self.panel.spinBoxAlpha:getValue()
				
				updateColorWidgets(self, r, g, b, a)
				self.callback(r, g, b, a)
			end)
		end
	end
end

local function construct(self)
	self.callback = callbackStub
	
	local localization = {
	}
	local window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_select_color.dlg', localization)
	
	self.panel = window.panelColor
	window:removeWidget(window.panelColor)
	
	self.buttonColorSeed = window.panelColor.buttonColor
	window.panelColor:removeWidget(window.panelColor.buttonColor)
	
	window:kill()
	
	createColorButtons(self)
	
	self.staticColorViewSkin = self.panel.staticColorView:getSkin()
	
	local onSpinBoxChange = function()
		local panel	= self.panel
		local r		= panel.spinBoxRed	:getValue()
		local g		= panel.spinBoxGreen:getValue()
		local b		= panel.spinBoxBlue	:getValue()
		local a		= panel.spinBoxAlpha:getValue()
		
		updateColorWidgets(self, r, g, b, a)		
		self.callback(r, g, b, a)
	end
	
	function self.panel.spinBoxRed:onChange()
		onSpinBoxChange()
	end
	
	function self.panel.spinBoxGreen:onChange()
		onSpinBoxChange()
	end
	
	function self.panel.spinBoxBlue:onChange()
		onSpinBoxChange()
	end
	
	function self.panel.spinBoxAlpha:onChange()
		onSpinBoxChange()
	end
	
	local function onSliderChange()
		local panel	= self.panel
		local r		= panel.sliderRed	:getValue()
		local g		= panel.sliderGreen	:getValue()
		local b		= panel.sliderBlue	:getValue()
		local a		= panel.sliderAlpha	:getValue()

		updateColorWidgets(self, r, g, b, a)
		self.callback(r, g, b, a)
	end	
	
	function self.panel.sliderRed:onChange()
		onSliderChange()
	end
		
	function self.panel.sliderGreen:onChange()
		onSliderChange()
	end		
	
	function self.panel.sliderBlue:onChange()
		onSliderChange()
	end
		
	function self.panel.sliderAlpha:onChange()
		onSliderChange()
	end
end

local function getPanel(self)
	return self.panel
end

local function setCallback(self, callback)
	self.callback = callback or callbackStub
end

return Factory.createClass({
	construct	= construct,
	getPanel	= getPanel,
	setColor	= updateColorWidgets,
	setCallback	= setCallback,
})