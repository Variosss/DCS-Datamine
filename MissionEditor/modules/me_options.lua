local base = _G
local i18n 					= base.require('i18n')
local _ 					= i18n.ptranslate

local OptionsController		= base.require('Options.Controller')
local InputDataController	= base.require('Input.Controller')
local DialogLoader		    = base.require('DialogLoader')
local i18n				    = base.require('i18n')
local TabsView		        = base.require('Options.TabsView')
local InputData			    = base.require('Input.Data')
local Gui                   = base.require('dxgui')
local HMD                   = base.HMD
local Analytics				= base.require("Analytics")
local DCS    				= base.require('DCS')


local form_
local listener_
local changedScreenSettings_		= false
local changedCoordSettings_			= false 
local changedUnitsSettings_			= false
local changedIconsThemeSettings_	= false
local changedPixelDensity_          = false
local changedDeferredShading_		= false
local changedLanguage_				= false
local changedDatum_					= false 

local localization = {
		rightBtn 		= _("OK"),
		system 			= _("SYSTEM"),
		controls 		= _("CONTROLS-OptionsDialog", "CONTROLS"),
		gameplay 		= _("GAMEPLAY"),
		audio 			= _("AUDIO"),
		miscellaneous	= _("MISCELLANEOUS"),
		plugins			= _("SPECIAL"),
        VR              = _("VR"),
        options			= _("OPTIONS"),
        cancel          = _("CANCEL"),
        ok              = _("OK"),
	}
    
local function getScreenSettingsChanged()
	return changedScreenSettings_
end

local function getLanguageChanged()
	return changedLanguage_
end

local function getDeferredShadingChanged()
	return changedDeferredShading_
end

local function getEnableVRChanged()
	return changedEnableVR_
end

local function getCoordSettingsChanged()
	return changedCoordSettings_
end

local function getDatumChanged()
	return changedDatum_
end

local function getUnitsSettingsChanged()
	return changedUnitsSettings_
end

local function getIconsThemeChanged()
	return changedIconsThemeSettings_
end

local function hide()
	if window then
		TabsView.onHide()
        window:setVisible(false)
	end
end

local function onCancel()
	-- скрываем окно, чтобы избежать лишних обновлений
	hide()
	
	OptionsController.undoChanges()
	InputDataController.undoChanges()
	
	OptionsController.saveChanges() --   для сохранения VR который не отменяется
	
	if listener_.onSoundMusic then
		listener_.onSoundMusic(OptionsController.getSound('music'))
	end
	
	if listener_.onSoundGui then
		listener_.onSoundGui(OptionsController.getSound('gui'))
	end
	
	if listener_.onCancel then
		listener_.onCancel()
	end
end

local function onOk()
	hide()	
	
	local getGraphicsChanged = OptionsController.getGraphicsChanged
    local getVRChanged = OptionsController.getVRChanged
	
	changedScreenSettings_ = 	getGraphicsChanged('width')
							or	getGraphicsChanged('height')
							or (getGraphicsChanged('terrainTextures') and base.isInitTerrain())
							or 	getGraphicsChanged('fullScreen')
							or 	getGraphicsChanged('scaleGui')
							or 	getGraphicsChanged('multiMonitorSetup')
                            or 	getGraphicsChanged('sync')
							or 	getGraphicsChanged('visibRange')
                            or 	(getVRChanged('pixel_density') and (HMD.isActive() == true))

--	changedDeferredShading_ = 	getGraphicsChanged('useDeferredShading')
	
	changedEnableVR_ = 	getVRChanged('enable') or getVRChanged('prefer_built_in_audio')
	
	changedLanguage_ = OptionsController.getLanguageChanged()
	
	DCS.setScreenShotExt(OptionsController.getGraphics('ScreenshotExt'))
	
	OptionsController.saveChanges()
	
	if listener_.onOk then
		listener_.onOk()
	end
end

local function create()
	OptionsController.setWallpaper	= function(a_id)
		if listener_.setWallpaper then
			listener_.setWallpaper(a_id)
		end
	end
	
	local prevDifficultyChangedFunc = OptionsController.difficultyChanged
	
	OptionsController.difficultyChanged = function(name)
		changedUnitsSettings_		= OptionsController.getDifficultyChanged('units')
		changedIconsThemeSettings_	= OptionsController.getDifficultyChanged('iconsTheme')
        
		prevDifficultyChangedFunc(name)
	end
	
	local prevMiscellaneousChangedFunc = OptionsController.miscellaneousChanged
	
	OptionsController.miscellaneousChanged = function(name)
		changedCoordSettings_ = OptionsController.getMiscellaneousChanged('Coordinate_Display')
		changedDatum_ = OptionsController.getMiscellaneousChanged('Datum')
		
		prevMiscellaneousChangedFunc(name)
	end
	
	local prevVRChangedFunc = OptionsController.VRChanged
	OptionsController.VRChanged = function(name)
		if listener_.onVRSetting then
			listener_.onVRSetting(name, OptionsController.getVR(name))
		end

		prevVRChangedFunc(name)
	end
	
	local prevGraphicsChangedFunc = OptionsController.graphicsChanged
	OptionsController.graphicsChanged = function(name)
		if listener_.onGraphicsSetting then
			listener_.onGraphicsSetting(name, OptionsController.getGraphics(name))
		end

		prevGraphicsChangedFunc(name)
	end
	
	local prevSoundChangedFunc = OptionsController.soundChanged
	OptionsController.soundChanged = function(name)
		if listener_.onSoundSetting then
			listener_.onSoundSetting(name, OptionsController.getSound(name))
		end

		prevSoundChangedFunc(name)
	end
	
--	local form = OptionsForm.new(OptionsController, InputDataController)
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_options_main.dlg', localization)
    windowOptionsSkin = window:getSkin()
    containerMain = window.containerMain
	containerWide = window.containerWide
    local screenWidth, screenHeight = Gui.GetWindowSize()
    window:setBounds(0, 0, screenWidth, screenHeight)
    local xp,yp,wp,hp = containerMain:getBounds()

    window:setSkin(window:getSkin())
    
	local mainH = screenHeight
	
	window.panelborder:setBounds((screenWidth-1284)/2, (screenHeight-mainH-4)/2, wp+4, mainH+4)
	containerMain:setSize(wp, mainH)
	containerMain:setPosition((screenWidth-wp)/2, 0)
	containerMain.staticDown:setPosition(0, mainH-50)
	containerMain.btnCancel:setPosition(10, mainH-41)
	containerMain.btnOk:setPosition(1140, mainH-41)
	containerMain.containerCentral:setSize(wp, mainH-98)
	containerMain.containerCentral.fon:setSize(wp, mainH-98)
	
	local wBorder =  math.min(35, math.floor((screenWidth-1280)/2))
	containerWide:setBounds(wBorder, (screenHeight-mainH)/2+83, screenWidth-2*wBorder, mainH-98-34) 

	TabsView.setOptionsController(OptionsController)
	TabsView.create(window)

	OptionsController.setView(TabsView)
	
	InputData.setController(InputDataController)
	InputDataController.setView(TabsView)
	
    containerMain.btnClose.onChange = onCancel
    containerMain.btnCancel.onChange = onCancel
    containerMain.btnOk.onChange = onOk
	
	window:addHotKeyCallback('escape', onCancel)
	window:addHotKeyCallback('return', onOk)

end

local function show(listener, style)
	listener_ = listener or {}
    
    --это только для запуска игры в обход МЕ 
	local OptionsData		= require('Options.Data')
	if OptionsData.isController() == false then		
        OptionsData.setController(OptionsController)
	end
	
	OptionsData.load(Gui.GetVideoModes())
	if base.me_db == nil then        
		base.me_db = require('me_db_api')
		base.me_db.create() -- чтение и обработка БД редактора			
	end
	OptionsData.loadPluginsDb()
	
	if not window then
		create()
	end
	
	changedScreenSettings_		= false
	changedCoordSettings_		= false
	changedUnitsSettings_		= false
	changedIconsThemeSettings_	= false
	changedDatum_				= false
	
	TabsView.onShow(style)
    if style == 'sim' then
        window:setSkin(Skin.windowOptionsSimSkin())
        window.panelborder:setVisible(true)
    else
        window:setSkin(windowOptionsSkin)
        window.panelborder:setVisible(false)
    end
   
    Analytics.pageview(Analytics.Settings)
	window:setVisible(true)
end

local function getVisible()
    if window then
        return window:getVisible()
    end
    return false
end


return {
	show = show,
	hide = hide,
	getScreenSettingsChanged	= getScreenSettingsChanged,
	getDeferredShadingChanged	= getDeferredShadingChanged,
	getCoordSettingsChanged		= getCoordSettingsChanged,
	getDatumChanged				= getDatumChanged,
	getUnitsSettingsChanged		= getUnitsSettingsChanged,
	getIconsThemeChanged		= getIconsThemeChanged,
	getEnableVRChanged			= getEnableVRChanged,
	getLanguageChanged			= getLanguageChanged,
    getVisible                  = getVisible,
    onCancel                    = onCancel,
}