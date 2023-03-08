local DialogLoader		= require('DialogLoader')
local DbOption			= require('Options.DbOption')
local OptionsController	= require('Options.Controller')
local WidgetUtils		= require('Options.WidgetUtils')
local i18n				= require('i18n')

local _ = i18n.ptranslate

local window_
local updateFunctions_ = {}
local initialBounds_

local function bindCheckBox(optionName, getFunc, getDbValuesFunc)
	local enforceCheckBox	= window_.spPanel[optionName .. 'Enforce']
	local optionCheckBox	= window_.spPanel[optionName .. 'Check']
	local dbValues = getDbValuesFunc(optionName)
	
	function enforceCheckBox:onChange()
		local active = self:getState()
		
		optionCheckBox:setEnabled(active)
		
		if active then
			WidgetUtils.enableCheckBoxArch64(optionCheckBox, dbValues)
			
			OptionsController.setForced(optionName, optionCheckBox:getState())
		else
			OptionsController.setForced(optionName, nil)
		end
	end
	
	WidgetUtils.setCheckBoxInputHandler(optionCheckBox, optionName, OptionsController.setForced, dbValues)
	
	updateFunctions_[optionName] = function()
		local value = OptionsController.getForced(optionName)
		local forced = (nil ~= value)
		
		enforceCheckBox:setState(forced)
		optionCheckBox:setEnabled(forced)
		
		if not forced then
			value = getFunc(optionName)
		end
		
		optionCheckBox:setState(dbValues[2].value == value)
	end
end

local function bindRadioButton(radioButton, optionName, dbValue, getFunc)
	WidgetUtils.enableRadioButtonArch64(radioButton, dbValue)
	WidgetUtils.setRadioButtonInputHandler(radioButton, optionName, OptionsController.setForced, dbValue)
	
	updateFunctions_[optionName .. tostring(dbValue.value)] = function()
		local value = OptionsController.getForced(optionName)
		
		if nil == value then
			value = getFunc(optionName)
		end
		
		radioButton:setState(value == dbValue.value)
	end
end

local function bindF10RadioButtons(getFunc, getDbValuesFunc)
	local optionName = 'optionsView'
	local container = window_.spPanel.containerOptionsView
	local radioButtonInfos = {}
	
	for i, dbValue in ipairs(getDbValuesFunc(optionName)) do	
		local radioButtonName = dbValue.name .. DbOption.radioName()
		local radioButton = container[radioButtonName]
		
		if radioButton then
			bindRadioButton(radioButton, optionName, dbValue, getFunc)
			
			table.insert(radioButtonInfos, {radioButton, dbValue.value})
		end	
	end

	local enforceCheckBox = window_.spPanel[optionName .. 'Enforce']
	
	function enforceCheckBox:onChange()
		local active = self:getState()
		
		container:setEnabled(active)
		
		if active then
			local value = OptionsController.getForced(optionName)
		
			if nil == value then
				value = getFunc(optionName)
			end
			
			for i, radioButtonInfo in ipairs(radioButtonInfos) do
				if radioButtonInfo[1]:getState() then
					OptionsController.setForced(optionName, radioButtonInfo[2])
					
					break
				end
			end
		else
			OptionsController.setForced(optionName, nil)
		end
	end
	
	updateFunctions_[optionName] = function()
		local value = OptionsController.getForced(optionName)
		local forced = (nil ~= value)
		
		enforceCheckBox:setState(forced)
		container:setEnabled(forced)
	end
end

local function bindCombo(optionName, getFunc, getDbValuesFunc)
	local enforceCheckBox	= window_.spPanel[optionName .. 'Enforce']
	local comboList			= window_.spPanel[optionName .. 'Combo']
	
	function enforceCheckBox:onChange()
		local value
		local active = self:getState()
		comboList:setEnabled(active)

		if active then
			local item = comboList:getSelectedItem()
			if item then
				value = item.value
			end
		end
		
		OptionsController.setForced(optionName, value)
	end
	
	local dbValues = getDbValuesFunc(optionName)
	
	WidgetUtils.fillComboList(comboList, dbValues)
	WidgetUtils.setComboListInputHandler(comboList, optionName, nil, OptionsController.setForced)
	
	updateFunctions_[optionName] = function()
		local value = OptionsController.getForced(optionName)
		local forced = (nil ~= value)
		
		enforceCheckBox:setState(forced)
		comboList:setEnabled(forced)
		
		if not forced then
			value = getFunc(optionName)			
		end
		
		if  type(value) == "boolean" then
			if value == true then
				value = 1
			elseif value == false then
				value = 0	
			end
		end
		
		local counter = comboList:getItemCount() - 1
		local item = nil
		
		for i = 0, counter do
			local currItem = comboList:getItem(i)
			
			if currItem.value == value then
				item = currItem
				break
			end
		end
		
		comboList:selectItem(item)
	end
end

local function bindSlider(optionName, getFunc, getDbValuesFunc)
	local enforceCheckBox	= window_.spPanel[optionName .. 'Enforce']
	local slider			= window_.spPanel[optionName .. 'Slider']
	local static			= window_.spPanel[optionName .. 'Widget']
	
	function enforceCheckBox:onChange()
		local active = self:getState()
		
		slider:setEnabled(active)
		
		if static then
			static:setEnabled(active)
		end	

		local value
		
		if active then
			value = slider:getValue()
		end
		
		OptionsController.setForced(optionName, value)
	end
	
	local dbValues = getDbValuesFunc(optionName)
	
	WidgetUtils.fillSlider(slider, dbValues)
	WidgetUtils.setSliderInputHandler(slider, static, optionName, OptionsController.setForced)
	
	updateFunctions_[optionName] = function()
		local value = OptionsController.getForced(optionName)
		local forced = (nil ~= value)
		
		enforceCheckBox:setState(forced)
		slider:setEnabled(forced)
		
		if not forced then
			value = getFunc(optionName)
		end
		
		slider:setValue(value)
		
		if static then
			static:setText(value)
		end		
	end
end

local function bindControls()
	local getDifficulty					= OptionsController.getDifficulty
	local getDifficultyValues			= OptionsController.getDifficultyValues
	local getGraphics					= OptionsController.getGraphics
	local getGraphicsValues				= OptionsController.getGraphicsValues
	local getMiscellaneous				= OptionsController.getMiscellaneous
	local getMiscellaneousValues		= OptionsController.getMiscellaneousValues
	
	bindCheckBox('permitCrash',			getDifficulty,		getDifficultyValues)
	bindCheckBox('externalViews',		getDifficulty,		getDifficultyValues)
	bindCheckBox('padlock', 			getDifficulty,		getDifficultyValues)
	bindCheckBox('fuel', 				getDifficulty,		getDifficultyValues)
	bindCheckBox('weapons',				getDifficulty,		getDifficultyValues)
	bindCheckBox('radio',				getDifficulty,		getDifficultyValues)
	bindCheckBox('immortal',			getDifficulty,		getDifficultyValues)
	bindCombo	('labels',				getDifficulty,		getDifficultyValues)
	bindCheckBox('easyFlight',			getDifficulty,		getDifficultyValues)
	bindCheckBox('easyCommunication',	getDifficulty,		getDifficultyValues)
	bindCheckBox('miniHUD',				getDifficulty,		getDifficultyValues)
	bindCheckBox('cockpitVisualRM',		getDifficulty,		getDifficultyValues)
	bindCheckBox('accidental_failures',	getMiscellaneous,	getMiscellaneousValues)
	bindCheckBox('unrestrictedSATNAV',	getDifficulty,		getDifficultyValues)
	
	bindCombo('civTraffic',				getGraphics,		getGraphicsValues)
	bindCombo('geffect',				getDifficulty,		getDifficultyValues)
	
	bindSlider('birds',					getDifficulty,		getDifficultyValues)
	
	bindF10RadioButtons(getDifficulty, getDifficultyValues)
    bindCheckBox('userMarks',				getDifficulty,		getDifficultyValues)
	
	bindCheckBox('RBDAI',				getDifficulty,		getDifficultyValues)
	bindCheckBox('cockpitStatusBarAllowed',	getDifficulty,	getDifficultyValues)
	bindCheckBox('wakeTurbulence',		getDifficulty,		getDifficultyValues)
	
end

local hide
local function create_()
	local localization = {
		labels = _('LABELS'),
		aliases = _('ALIASES'),
		option = _('OPTION'),
		enemies = _('ENEMIES'),
		unlimitedFuel = _('UNLIMITED FUEL'),
		permitCrashRcr = _('PERMIT CRASH RCVR'),
		enforce = _('ENFORCE'),
		immortal = _('IMMORTAL'),
		unlimitedWeapons = _('UNLIMITED WEAPONS'),
		myPlane = _('MY PLANE'),
		value = _('VALUE'),
		geffect = _('G-EFFECT'),
		externalViews = _('EXTERNAL VIEWS'),
		padlock = _('PADLOCK'),
		easyFlight = _('EASY FLIGHT'),
		easyAvionics = _('EASY AVIONICS'),
		easyCommunication = _('EASY COMMUNICATION'),
		missionOptions = _('MISSION OPTIONS'),
		tooltips = _('TOOL TIPS'),
		radio = _("RADIO ASSIST"),
		civTraffic = _("CIV TRAFFIC"),
		accidentalfailures = _('RANDOM SYSTEM FAILURES-MISOPT', 'Random System Failures'),
		cockpitVisualRM     = _('COCKPIT VISUAL RECON MODE'),
		miniHUD = _("MINI HUD"),
		birds = _('birds'),
		aftSwitching = _("AIRCRAFT SWITCHING"),
		f10opt = _("F10 VIEW OPTIONS"),
		unrestrictedSATNAV = _('Unrestricted SATNAV'),
		
		mapOnly	 	= _("MAP ONLY"),
		myAC	 	= _("MY A/C"),
		allies   	= _('FOG OF WAR'),
		alliesOnly	= _("ALLIES ONLY"),
		all		 	= _("ALL_gui", "ALL"),
        
        userMarks   = _('F10 Map User Marks'),
		
		Overlays				= _('Overlays'),
		cockpitStatusBarAllowed	= _("Cockpit Status Bar"),
		RBDAI					= _('Battle Damage Assessment'),	
		wakeTurbulence			= _('Wake turbulence'),
		
		permitCrash_tooltip	= _('Tips.GameOpt.Dfclty.RCVR'),
		mapOnly_tooltip		= _('Tips.GameOpt.F10.MapOnly'),
		myPlane_tooltip		= _('Tips.GameOpt.F10.MyAC'),
		allies_tooltip		= _('Tips.GameOpt.F10.FoW'),
		alliesOnly_tooltip	= _('Tips.GameOpt.F10.Allies'),
		all_tooltip			= _('Tips.GameOpt.F10.AllOpts'),
		labels_tooltip		= _('Tips.GameOpt.Dfclty.Labels'),
		easyFlight_tooltip  = _('Tips.GameOpt.Dfclty.GFM'),
		immortal_tooltip	= _('Tips.GameOpt.Dfclty.Immortal'),
		fuel_tooltip		= _('Tips.GameOpt.Dfclty.UnlimFuel'),
		weapons_tooltip		= _('Tips.GameOpt.Dfclty.UnlimWpn'),
		easyComm_tooltip	= _('Tips.GameOpt.Dfclty.EasyComm'),
		radio_tooltip		= _('Tips.GameOpt.Dfclty.RadAssist'),
		SATNAV_tooltip		= _('Tips.GameOpt.Dfclty.SATNAV'),
		padlock_tooltip		= _('Tips.GameOpt.Dfclty.Padlock'),
		wakeTurbulence_tooltip	= _('Tips.GameOpt.Others.WakeTurbs'),
		geffect_tooltip			= _('Tips.GameOpt.Others.GEffects'),
		miniHUD_tooltip			= _('Tips.GameOpt.Others.mHUD'),
		cVRM_tooltip			= _('Tips.GameOpt.Dfclty.CVRM'),
		userMarks_tooltip		= _('Tips.GameOpt.Others.UserMarks'),
		birds_tooltip			= _('Tips.GameOpt.Others.Birds'),	
		
		optionsView_tooltip 	= _('Tips.MEOpt.ViewOpts'),
		externalViews_tooltip	= _('Tips.MEOpt.ExtView '),
		accidentalfailures_tooltip	= _('Tips.MEOpt.RandomFail'),
		civTraffic_tooltip		= _('Tips.MEOpt.Traffic'),
		cockpitStatusBar_tooltip= _('Tips.MEOpt.StatBar '),
		RBDAI_tooltip			= _('Tips.MEOpt.BDA'),
	}

	window_ = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/misoptions.dlg', localization)
	

	window_:setBounds(x_, y_, w_, h_)
	spPanel = window_.spPanel
	spPanel:setBounds(0, 50, w_-2, h_-80)
	spPanel:updateWidgetsBounds() 
	
	function window_:onClose()
		hide()
	end
	
	bindControls()
end

local function create(x, y, w, h)
	x_, y_, w_, h_ = x, y, w, h
end

local function updateWidgets()
	for name, func in pairs(updateFunctions_) do
		func()
	end
end

local Module = {}

local function show()
	if not window_ then
		create_()
	end
	
	if not window_:getVisible() then
		window_:setVisible(true)
		
		updateWidgets()
		
		OptionsController.setForcedView(Module)
		OptionsController.onMissionOptionsViewShow()
	end
end

-- объ€влена выше
hide = function()
	if window_ then
		window_:setVisible(false)
	end
	
	OptionsController.setForcedView()
	OptionsController.onMissionOptionsViewHide()
end

local function forcedChanged(optionName)
	if optionName then
		updateFunctions_[optionName]()
	else
		updateWidgets()
	end
end

Module.create			= create
Module.show				= show
Module.hide				= hide
Module.forcedChanged	= forcedChanged

return Module