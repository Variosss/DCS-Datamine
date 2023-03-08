local DialogLoader		= require('DialogLoader')
local ListBoxItem		= require('ListBoxItem')
local Factory			= require('Factory')
local TabViewBase		= require('Options.TabViewBase')
local i18n				= require('i18n')
local WidgetUtils		= require('Options.WidgetUtils')
local U					= require('me_utilities')
local optionsUtils		= require('Options.optionsUtils')
local Skin				= require('Skin')
local ViewportEditor	= require('ViewportEditor')
local MeSettings		= require('MeSettings')
local DCS				= require('DCS')

local _ = i18n.ptranslate

local resetTooltip = "\n* - ".._("Game restart is required.")

local function loadFromResource(self)
	local localization = {
		graphics				= _("Graphics"),
		textures				= _("TEXTURES"),
		terrainTextures			= _("TERRAIN TEXTURES").." *",
		flatTerrainShadows		= _("Terrain Objects Shadows"),
		terrPreload				= _("TERR PRELOAD"),
		civTraffic				= _("CIV TRAFFIC"),
		water					= _("WATER"),
		visibRange				= _("VISIB RANGE").." *",
		effects					= _("EFFECTS"),
		heatBlur				= _("HEAT BLUR"),
		LensEffects				= _("LENS EFFECTS"),
		shadows					= _("SHADOWS"),
		SecondaryShadows		= _("Secondary Shadows"),
		resolution				= _("RESOLUTION").." *",
		cockpitShadows			= _("COCKPIT SHADOWS"),
		cockpitGI				= _("COCKPIT GLOBAL ILLUMINATION"),
		VSync					= _("VSYNC").." *",
		fullScreen				= _("FULL SCREEN").." *",
		scaleGui				= _("SCALE GUI").." *",
		aspect					= _("ASPECT"),
		multiMonitorSetup		= _("MONITORS").." *",
		resOfCockpitDisplays	= _('RES. OF COCKPIT DISPLAYS'),
		MSAA					= _("MSAA"),
		TranspSSAA				= _("TSSAA"),
		cluttergrass			= _("CLUTTER/GRASS"),
		forestDistanceFactor	= _("Forest Visibility"),
		forestDetailsFactor		= _("Forest Details Factor"),
		preloadRadius			= _("PRELOAD RADIUS"),
		shadowTree				= _("TREE SHADOWS"),
		presets 				= _("PRESETS"),
		low 					= _("LOW"),
		medium 					= _("MEDIUM"),
		high 					= _("HIGH"),
		custom 					= _("CUSTOM"),
		DOF						= _('DEPTH OF FIELD'),
		clouds					= _('Сlouds'),	
		anisotropy				= _('ANISOTROPIC FILTERING'),
		VR						= _("VR"),
		SSAO					= _("SSAO"),
		motionBlur				= _("MOTION BLUR"),
		chimneySmokeDensity		= _("CHIMNEY SMOKES DENSITY"),
		outputGamma				= _("GAMMA"),
		Default_FOV   			= _("External field of view"),
		Current_FOV   			= _("Current field of view"),
		rainDroplets			= _("Rain Droplets"),
		SSAA					= _("SSAA"),
		SSLR					= _("SSLR"),
		SSAO					= _("SSAO"),
		messagesFontScale		= _("Messages font scale"),
		SaveCustom1				= _("SAVE"),
		SaveCustom2				= _("SAVE"),
		SaveCustom3				= _("SAVE"),
		Custom1					= _("Custom1"),
		Custom2					= _("Custom2"),
		Custom3					= _("Custom3"),
		SaveUsersPresets		= _("Save Users Presets"),	
		sceneryDetailsFactor	= _("Scenery Details Factor"),
		box_mouse_cursor		= _('CURSOR CONFINED TO GAME WINDOW'),
		ScreenshotFormat		= _("Screenshot format"),
		
		textures_tooltip		=_('tip_Textures'),
		terrainTextures_tooltip	=_('tip_Textures_terrain')..resetTooltip,
		civTraffic_tooltip		=_('tip_CivTraffic'),
		water_tooltip			=_('tip_Water'),
		visibRange_tooltip		=_('tip_VisibRange')..resetTooltip,
		heatBlur_tooltip		=_('tip_HeatBlur'),
		shadows_tooltip			=_('tip_Shadows'),
		resolution_tooltip		=_('tip_Resolution')..resetTooltip,
		aspect_tooltip			=_('tip_AspectRatio'),
		multiMonitor_tooltip	=_('tip_Monitors')..resetTooltip,
		resOfCockDispl_tooltip	=_('tip_CockpitDisplays'),
		MSAA_tooltip			=_('tip_MSAA'),
		DOF_tooltip				=_('tip_DoF'),
		LensEffects_tooltip		=_('tip_LensEffects'),
		motionBlur_tooltip		=_('tip_MotionBlur'),
		clouds_tooltip			=_('tip_Clouds'),
		SSAA_tooltip			=_('tip_SSAA'),
		SSLR_tooltip			=_('tip_SSLR'),
		SSAO_tooltip			=_('tip_SSAO'),
		
		cluttergrass_tooltip	=_('tip_Grass'),
		forestDistance_tooltip	=_('tip_Forest'),
		forestDetails_tooltip	=_('tip_Forest_details'),
		sceneryDetails_tooltip	=_('tip_SceneDetails'),
		preloadRadius_tooltip	=_('tip_PreloadRad'),
		chimneySmoke_tooltip	=_('tip_Smoke'),
		outputGamma_tooltip		=_('tip_Gamma'),
		Default_FOV_tooltip     =_('tip_defaultFOV'),
		Current_FOV_tooltip     	=_('tip_currentFOV'),
		anisotropy_tooltip		=_('tip_AnisoFilter'),
		flatTerrShadows_tooltip	=_('tip_Shadows_objects'),
		cockpitGI_tooltip		=_('tip_CockpitGlobIllum'),
		messagesFont_tooltip	=_('tip_FontScale'),
		scaleGUI_tooltip		=_('tip_ScaleGUI')..resetTooltip,
		rainDroplets_tooltip	=_('tip_RainDrops'),
		Vsync_tooltip			=_('tip_Vsync')..resetTooltip,
		fullscreen_tooltip		=_('tip_FullScreen')..resetTooltip,
		box_mouse_cur_tooltip	=_('tip_CursorSnappedToWindow'),
		secondaryShadows_tooltip = _('tip_secondaryShadows'),
		ScreenshotFormat_tooltip = _("tip_ScreenshotFormat"),
	}
	local window = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_options_system.dlg', localization)
	local container = window.containerMain.containerSystem
	container:setSize(1280, 635)
	container:updateWidgetsBounds()
	
	window.containerMain:removeWidget(container)
	window:kill()
	
	return container
end

local function bindPercentSlider(self, slider, static, optionName, getFunc, setFunc, getDbValuesFunc)
	local dbValues = getDbValuesFunc(optionName)
	local range = dbValues[1]
	local minValue = range.min
	local maxValue = range.max
	
	WidgetUtils.fillSlider(slider, dbValues)
	
	local getPercents = function(value)	
		return math.floor((value / maxValue) * 100)
	end
	
	function slider:onChange()
		local value = self:getValue()

		setFunc(optionName, value)
		
		static:setText(getPercents(value) .. '%')
	end	
	
	self.updateFunctions_[optionName] = function()
		local value = getFunc(optionName)
		
		slider:setValue(value)
		static:setText(getPercents(value) .. '%')
	end
end

local function bindDegreeSlider(self, slider, static, optionName, getFunc, setFunc, getDbValuesFunc)
	local dbValues = getDbValuesFunc(optionName)
	
	WidgetUtils.fillSlider(slider, dbValues)
	
	function slider:onChange()
		local value = self:getValue()

		setFunc(optionName, value)
		
		static:setText(string.format('%d\194\176', math.floor(value + 0.5)))	-- utf-8 degree symbol
	end	
	
	self.updateFunctions_[optionName] = function()
		local value = getFunc(optionName)
		
		slider:setValue(value)
		static:setText(string.format('%d\194\176', math.floor(value + 0.5)))
	end
end


local function makeResolutionString(width, height)
	return width .. 'x' .. height
end

local function fillResolutionComboBox(resolutionComboBox, widthOptionName, heightOptionName, getValuesFunc)
	local screenWidths = getValuesFunc(widthOptionName)
	local screenHeights = getValuesFunc(heightOptionName)
	
	for i, screenWidth in ipairs(screenWidths) do
		local screenHeight = screenHeights[i]
		local item = ListBoxItem.new(makeResolutionString(screenWidth, screenHeight))
		
		item.width = screenWidth
		item.height = screenHeight
		
		resolutionComboBox:insertItem(item)
	end
end

local aspect_values = 
{
{16/10	 ,'16:10'},
{16/9	 ,'16:9'},
{1366/768,'16:9'},
{3*16/10 ,'48:10'},
{3*16/9	 ,'48:9'},
{2*16/9	 ,'32:9'},
{2*16/10 ,'32:10'},
{4/3	 ,'4:3'},
{3/2	 ,'3:2'},
{5/4	 ,'5:4'},
{21/9	 ,'21:9'},
}

local function gcd(a, b)
	if b == 0 then
		return a
	else 
		return gcd(b, a%b)
	end
end

local function find_aspect_string_by_value(width,height)
	local closest
	local error_f = 100
	
	local value   = width/height
	
	for i,o in ipairs(aspect_values) do 
		local e = math.abs(value - o[1])
		if math.abs(value - o[1]) < error_f then
		   error_f = e
		   closest = o
		end
		if e < 1e-7 then 
			break
		end
	end
	if error_f < 1e-3 then
		return  closest[2]
	end
	
	g = gcd(width,height)

	local rw =  width/g
	local rh = height/g
	
	local val = string.format("%d:%d",rw,rh)

	if error_f < 0.05 then
		val = val .. "~("..closest[2]..")"
	end

	return val
end

local function bindResolutionComboBox(self, resolutionComboBox,aspectWidget, getFunc, setFunc, getValuesFunc)
	local widthOptionName = 'width'
	local heightOptionName = 'height'
	local aspectOptionName = 'aspect'
	local width = getFunc(widthOptionName)
	local height = getFunc(heightOptionName)

	fillResolutionComboBox(resolutionComboBox, widthOptionName, heightOptionName, getValuesFunc)
	resolutionComboBox:setText(makeResolutionString(width, height))

	local function submit(w,h)
		if  not(getFunc(widthOptionName)  == w 
			and getFunc(heightOptionName) == h) then	
			setFunc(widthOptionName,  w)
			setFunc(heightOptionName, h)
			setFunc(aspectOptionName, w / h)
		end
	end

	function resolutionComboBox:onChangeListBox()
		local item = self:getSelectedItem()
		submit(item.width,item.height)
	end
	
	local applyUserInput = function(text)
		-- ожидаем два целых числа, разделенных латинскими 'x' или 'X'
		local width, height = string.match(text, '(%d+)[xX](%d+)')
		local valuesAreValid = false
		
		if width and height then
			width  = tonumber(width)
			height = tonumber(height)
			
			if width >= 1024 and height >= 768 then
				valuesAreValid = true
			end
		end	

		if valuesAreValid then
			submit(width,height)
		else
			local width  = getFunc(widthOptionName)
			local height = getFunc(heightOptionName)
			
			resolutionComboBox:setText(makeResolutionString(width, height))
		end
	end
	
	function resolutionComboBox:onKeyDown(key, unicode)
		if 'return' == key then
			applyUserInput(self:getText())
		end
	end
	
	function resolutionComboBox:onFocus(focused)
		if not focused then
			applyUserInput(self:getText())
		end
	end
	
	local updateFunction = function()
		local width = getFunc(widthOptionName)
		local height = getFunc(heightOptionName)
		local counter = resolutionComboBox:getItemCount() - 1
		local item = nil

		for i = 0, counter do
			local currItem = resolutionComboBox:getItem(i)
			
			if currItem.width == width and currItem.height == height then
				item = currItem
				break
			end
		end

		local value = find_aspect_string_by_value(width,height)
	
		aspectWidget:setText(value)
			
		if item then
			resolutionComboBox:selectItem(item)
		else
			resolutionComboBox:setText(makeResolutionString(width, height))
		end
	end
	
	self.updateFunctions_[widthOptionName] = updateFunction
	self.updateFunctions_[heightOptionName] = updateFunction
end

local function bindPresetButtons(self)
	local container = self:getContainer()
	local controller = self.controller_
	
	function container.pPresets.lowBtn:onChange()
		controller.setGraphicsLow()
		controller.setViewsCockpitLow()
	end
	
	function container.pPresets.mediumBtn:onChange()
		controller.setGraphicsMedium()
		controller.setViewsCockpitMedium()
	end	
	
	function container.pPresets.highBtn:onChange()
		controller.setGraphicsHigh()
		controller.setViewsCockpitHigh()
	end
    
    function container.pPresets.VRBtn:onChange()
		controller.setGraphicsVR()
		controller.setViewsCockpitVR()
	end
	
	function container.pPresets.SaveCustom1Btn:onChange()
		controller.saveGraphicsCustom1()
		container.pPresets.Custom1Btn:setSkin(Skin.buttonSkinGrayNew_Rel())
	end
	
	function container.pPresets.SaveCustom2Btn:onChange()
		controller.saveGraphicsCustom2()	
		container.pPresets.Custom2Btn:setSkin(Skin.buttonSkinGrayNew_Rel())
	end
	
	function container.pPresets.SaveCustom3Btn:onChange()
		controller.saveGraphicsCustom3()
		container.pPresets.Custom3Btn:setSkin(Skin.buttonSkinGrayNew_Rel())
	end
	
	function container.pPresets.Custom1Btn:onChange()
		controller.setGraphicsCustom1()
	end
	
	function container.pPresets.Custom2Btn:onChange()
		controller.setGraphicsCustom2()
	end
	
	function container.pPresets.Custom3Btn:onChange()
		controller.setGraphicsCustom3()
	end
end

local function updateLists(self)
	local container		= self:getContainer()
	local GraphicsDb	= self.controller_.getGraphicsDb()
	local dbValues		= GraphicsDb['multiMonitorSetup']
	local values		= optionsUtils.getMultiMonitorSetupValues()
	
	dbValues.values		= values
	container.multiMonitorSetupComboList:clear()
	WidgetUtils.fillComboList(container.multiMonitorSetupComboList, values)
end

local function bindControls(self, a_style, a_w, a_h)
	local container = self:getContainer()
	
	self:bindOptionsContainer(container, 'Graphics')
	self:bindOptionsContainer(container, 'ViewsCockpit')
	
	container.pPresets:setPosition(655, a_h-70)
	
	local controller 			= self.controller_
	local getGraphics			= controller.getGraphics
	local setGraphics			= controller.setGraphics
	local getGraphicsValues		= controller.getGraphicsValues

	bindResolutionComboBox(self, container.resolutionCombo, container.aspectWidget , getGraphics, setGraphics, getGraphicsValues)
	
	bindPercentSlider(self, container.forestDistanceFactorSlider, container.forestDistanceFactorWidget, 'forestDistanceFactor', getGraphics, setGraphics, getGraphicsValues)

	bindDegreeSlider(self, container.defaultFOVSlider, container.defaultFOVWidget, 'defaultFOV', getGraphics, setGraphics, getGraphicsValues)
	
	local sim_style = (a_style == 'sim')
	container.currentFOVSlider:setVisible(sim_style)
	container.currentFOVWidget:setVisible(sim_style)
	container.currentFOVLabel:setVisible(sim_style)
	container.currentFOVSlider:setEnabled(sim_style)
	container.currentFOVWidget:setEnabled(sim_style)
	container.currentFOVLabel:setEnabled(sim_style)
	container.defaultFOVSlider:setVisible(not sim_style)
	container.defaultFOVWidget:setVisible(not sim_style)
	container.defaultFOVLabel:setVisible(not sim_style)
	container.defaultFOVSlider:setEnabled(not sim_style)
	container.defaultFOVWidget:setEnabled(not sim_style)
	container.defaultFOVLabel:setEnabled(not sim_style)
	
	bindPresetButtons(self)
	
	if MeSettings.getEnabledViewportEditor() == true then
		container.buttonViewportEditor:setVisible(true)
	else
		container.buttonViewportEditor:setVisible(false)
	end	

	if controller.isGraphicsCustom1() then
		container.pPresets.Custom1Btn:setSkin(Skin.buttonSkinGrayNew_Rel())
	else
		container.pPresets.Custom1Btn:setSkin(Skin.buttonSkinGrayNew_Dis())
	end
	
	if controller.isGraphicsCustom2() then
		container.pPresets.Custom2Btn:setSkin(Skin.buttonSkinGrayNew_Rel())
	else
		container.pPresets.Custom2Btn:setSkin(Skin.buttonSkinGrayNew_Dis())
	end
	
	if controller.isGraphicsCustom3() then
		container.pPresets.Custom3Btn:setSkin(Skin.buttonSkinGrayNew_Rel())
	else
		container.pPresets.Custom3Btn:setSkin(Skin.buttonSkinGrayNew_Dis())
	end
	
	local tab = self
	
	function container.buttonViewportEditor:onChange()
		local comboList = container.multiMonitorSetupComboList
		-- после вызова редактора текущее значение может исчезнуть
		local currValue = controller.getGraphics('multiMonitorSetup')
		
		ViewportEditor.show()
		updateLists(tab)
		
		local values	= optionsUtils.getMultiMonitorSetupValues()
		local found		= false
		
		for i, dbValue in ipairs(values) do		
			if dbValue.value == currValue then
				found = true
				
				break
			end
		end
		
		if found then
			controller.setGraphics('multiMonitorSetup', currValue)
		else
			controller.setGraphics('multiMonitorSetup', values[1].value)
		end
	end
	
	container.box_mouse_cursorCheckbox.callbackUpdate = function(self)
		if  not HMD.isActive() then
			visualizer.boxMouseCursor(self:getState())
		end
	end
end

local function setStyle(self, a_style)
	local container = self:getContainer()
	if a_style == 'sim' then
		getOptionsDbFunc = self.controller_.getGraphicsDb
		
		self:updateEditable(true, getOptionsDbFunc())
	else
		self:updateEditable(nil)
	end
end


return Factory.createClass({
	construct = construct,
	bindControls = bindControls,
	loadFromResource = loadFromResource,
	setStyle = setStyle,
	updateLists	= updateLists,
}, TabViewBase)
