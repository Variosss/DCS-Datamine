local DialogLoader		= require('DialogLoader')
local Factory			= require('Factory')
local ListBoxItem		= require('ListBoxItem')
local TabViewBase		= require('Options.TabViewBase')
local PluginsInfo		= require('Options.PluginsInfo')
local lfs				= require('lfs')
local i18n				= require('i18n')
local MeSettings		= require('MeSettings')
local WidgetUtils		= require('Options.WidgetUtils')
local ProductType 		= require('me_ProductType')

local _ = i18n.ptranslate

local function loadFromResource(self)
	local localization = {
		viewopt					= _("VIEWS"),
		externalViews			= _("Player external views"),
		snapview				= _("ENABLE USER SNAP-VIEW SAVING"),
		synchronize				= _("Synchronize Controls on Mission Start"),
		headmove				= _("Head Movement by G-Forces in Cockpit"),
		accidentalfailures		= _("Random System Failures"),
		f5_nearest_ac			= _("F5 Nearest AC View"),
		f10_awacs				= _("F10 AWACS View"),
		f11_free_camera			= _("F11 Free Camera"),
		force_feedback_enabled	= _("Force Feedback Enabled"),
		Coordinate_Display		= _("COORDINATE DISPLAY:"),
		METheme					= _('GUI THEME'),
		Wallpapers				= _('THEME:'),
		show_pilot_body			= _('Show Pilot Body in Cockpit (when available)'),
        F2_view_effects         = _("F2 view effects"),
        SpectatorExternalViews  = _("Spectator external views"),
        TrackIRExternalViews    = _("TrackIR external views"),
        chat_window_at_start    = _("Chat window at start"), 
		AutoLogin				= _('Autologin'), 	
		CollectStatistics		= _('Collect statistics'), 
		controlsIndicator		= _('Controls Indicator'),
		cockpitStatusBarAllowed	= _("Cockpit Status Bar"),		
		RBDAI					= _('Battle Damage Assessment'),	
		overlays				= _('Overlays'),
		allow_server_screenshots= _('Allow servers to take my screenshots'),	
		DynamicRadio			= _("Dynamic Radio"),
		Language				= _("Language"),
		backup					= _("Editor Auto-Save Interval"),
		time					= "",
		Use_Datum				= _("Use Datum"),
		
		tip_externalViews			= _('Tips.Misc.externalViews'),
		tip_snapview				= _('Tips.Misc.snapview'),
		tip_synchronize				= _('Tips.Misc.synchronize'),
		tip_headmove				= _('Tips.Misc.headmove'),
		tip_accidentalfailures		= _('Tips.Misc.accidentalfailures'),
		tip_f5_nearest_ac			= _('Tips.Misc.f5_nearest_ac'),
		tip_f10_awacs				= _('Tips.Misc.f10_awacs'),
		tip_f11_free_camera			= _('Tips.Misc.f11_free_camera'),
		tip_force_feedback_enabled	= _('Tips.Misc.force_feedback_enabled'),
		tip_Coordinate_Display		= _('Tips.Misc.Coordinate_Display'),
		tip_Wallpapers				= _('Tips.Misc.Wallpapers'),
		tip_show_pilot_body			= _('Tips.Misc.show_pilot_body'),
		tip_F2_view_effects 		= _('Tips.Misc.F2_view_effects'),
		tip_SpectatorExternalViews  = _('Tips.Misc.SpectatorExternalViews'),
        tip_TrackIRExternalViews    = _('Tips.Misc.TrackIRExternalViews'),
        tip_chat_window_at_start    = _('Tips.Misc.chat_window_at_start'), 
		tip_AutoLogin				= _('Tips.Misc.AutoLogin'), 	
		tip_CollectStatistics		= _('Tips.Misc.CollectStatistics'), 
		tip_controlsIndicator		= _('Tips.Misc.controlsIndicator'),
		tip_cockpitStatusBar		= _('Tips.Misc.cockpitStatusBar'),		
		tip_RBDAI					= _('Tips.Misc.RBDAI'),			
		tip_allow_server_screenshots = _('Tips.Misc.allow_server_scrn'), 		
		-- tip_Language				= _('Tips.Misc.Language'), 				-- not enabled yet
		tip_backup					= _('Tips.Misc.backup'),
	}
	local window = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_options_miscellaneous.dlg', localization)
	local container = window.containerMain.containerMiscellaneous
	
	window.containerMain:removeWidget(container)
	window:kill()
	
	return container
end

local function fillWallpaperComboList(comboList)
	local item = ListBoxItem.new(_('Default theme'))
	item.dir = "./MissionEditor/images/"
	item.id = "default"
	comboList:insertItem(item)

	--итем
	item = ListBoxItem.new(_('USER THEME'))
	item.dir = lfs.writedir() .. "MissionEditor/images/"
	item.id = "user"
	comboList:insertItem(item)
	
	for i, info in ipairs(PluginsInfo.getSkinsInfo()) do
		for j, skinInfo in pairs(info.skins) do
			local item 	= ListBoxItem.new(skinInfo.name)
	
			item.info		= info
			item.skinInfo	= skinInfo
			item.id 		= info.id .. skinInfo.index		
			
			comboList:insertItem(item)
		end
	end
end

local function bindWallpaperComboList(self, comboList)
	fillWallpaperComboList(comboList)
	
	local controller = self.controller_
	
	function comboList:onChange(item)
		if controller.setWallpaper then
			controller.setWallpaper(item.id)
		end
	end
	
	self.updateFunctions_['wallpaper'] = function()
		-- TODO: переделать сохранение последнего выбранного скина
		local pluginItem = comboList:getItem(0) -- дефолтные обои
		local skinId = MeSettings.getMainMenuSkinName()
		
		if skinId then
			local count = comboList:getItemCount()

			for i = 0, count - 1 do
				local item = comboList:getItem(i)
				
				if item.id == skinId or item.id == skinId or (item.info and item.info.id .. '1' == skinId) then
					pluginItem = item
					break
				end
			end
		end
		
		comboList:selectItem(pluginItem)
	end
end

local function isValidLang(a_langs, a_lang)
	if a_lang == nil then
		return false
	end
	
	for k,v in pairs(a_langs) do
		if v.locale == a_lang then
			return true
		end
	end
	return false
end

local function loadLang(a_path)
	local curLang
	local b = lfs.attributes(a_path) 
	if b and b.mode == "file" then
		local file = io.open(a_path, "r")
		if file then
			curLang = file:read('*a')
			file:close()
			curLang = string.gsub(curLang, "%s+", "")
		end
	end
	return curLang
end

local function fillLanguageComboList(comboList, a_controller)
	local defaultCfgPath = lfs.currentdir().."Config/lang.cfg"
	local userCfgPath = lfs.writedir().."Config/lang.cfg"
	
	-- загружаем список языков
	local f = loadfile(lfs.currentdir().."MissionEditor/data/scripts/Langs.lua")
	local env = {}	
    local langs = {}
    if f then
        setfenv(f, env)
        f()
        langs = env.locales
    end    
    
    function compareLocales(tab1, tab2)
        return tab1.locale < tab2.locale
    end
    
    table.sort(langs, compareLocales)
	---
	
	local curLang 	
	curLang = loadLang(userCfgPath)
	if isValidLang(langs, curLang) == false then
		curLang = loadLang(defaultCfgPath) 
	end	
	if isValidLang(langs, curLang) == false then
		curLang = "EN" 
	end	
	
	local curItem
	for i, lang in ipairs(langs) do
		local item 	= ListBoxItem.new(lang.locale.." "..lang.name)
		item.id 	= lang.locale		
		comboList:insertItem(item)	
		
		if curLang == lang.locale then
			curItem = item
		end
	end
	
	if curItem then
		comboList:selectItem(curItem)

		if a_controller.setLanguage then
			a_controller.setLanguage(curItem.id)
		end
	end
end

local function bindLanguageComboList(self, comboList)
	local controller = self.controller_
	fillLanguageComboList(comboList, controller)

	function comboList:onChange(item)
		if controller.setLanguage then
			controller.setLanguage(item.id)
		end
	end
end

local function bindSlider(self, slider, static, optionName, getFunc, setFunc, getDbValuesFunc)
	local dbValues = getDbValuesFunc(optionName)
	local range = dbValues[1]
	local minValue = range.min
	local maxValue = range.max
	
	WidgetUtils.fillSlider(slider, dbValues)
	
	
	function slider:onChange()
		local value = self:getValue()

		setFunc(optionName, value)
		
		static:setText(value .." ".. _('min'))
	end	
	
	self.updateFunctions_[optionName] = function()
		local value = getFunc(optionName)
		
		slider:setValue(value)
		static:setText(value .." ".. _('min'))
	end
end

local function bindControls(self, a_style, a_w, a_h)
	local container = self:getContainer()
	local controller = self.controller_
	
	self:bindOptionsContainer(container, 'Miscellaneous')
	self:bindOptionsContainer(container, 'Difficulty')

	bindWallpaperComboList(self, container.WallpapersComboList)
	
	if _G.__PRODUCT_ID__ == 2 then
		container.WallpapersComboList:setVisible(false)
		container.WallpapersLabel:setVisible(false)	
		container.collect_statCheckbox:setVisible(false)	
	end
	
--	bindLanguageComboList(self, container.LanguageComboList)-- отключаем пока не доделаем 
	container.LanguageLabel:setVisible(false) 				-- отключаем пока не доделаем
	container.LanguageComboList:setVisible(false)			-- отключаем пока не доделаем
	
	bindSlider(self, container.backupTimeSlider, container.backupTimeWidget, 'backupTime', controller.getMiscellaneous, controller.setMiscellaneous, controller.getMiscellaneousValues)
	
	container.bDynamicRadio.onChange = function()
		local dynamicRadio 		= require('me_dynamicRadio')
		dynamicRadio.show(true)
	end
	
	if _G.__PRODUCT_ID__ ~= 2 then
		container.DatumComboList:setVisible(false)
		container.DatumDisplayLabel:setVisible(false)
	end
	
end

return Factory.createClass({
	construct = construct,
	bindControls = bindControls,
	loadFromResource = loadFromResource,
}, TabViewBase)
