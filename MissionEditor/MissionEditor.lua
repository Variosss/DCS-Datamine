__DO_NOT_ERASE_DEBRIEF_LOG__ = true;

-- добавлять коды команд в тултип для команды
OPTIONS_ADD_COMMAND_CODES_TO_TOOLTIP = false


test_topdown_view_models = true
--test_Visible_Map_Bounds = true
--test_localizationMG = true
--test_dyn_missions = true
--test_DataCartridge = true
--test_requiredUnits = true
--test_showNotYearsUnits = true

guiBindPath = './dxgui/bind/?.lua;' .. 
              './dxgui/loader/?.lua;' .. 
              './dxgui/skins/skinME/?.lua;' .. 
              './dxgui/skins/common/?.lua;'

package.path = 
       ''
    .. guiBindPath
    .. './MissionEditor/?.lua;'
    .. './MissionEditor/modules/?.lua;'	
    .. './Scripts/?.lua;'
    .. './LuaSocket/?.lua;'
	.. './Scripts/UI/?.lua;'
	.. './Scripts/UI/Multiplayer/?.lua;'
	.. './Scripts/DemoScenes/?.lua;'

local function get_file_config(a_file)
    local b = lfs.attributes(a_file) 
    if not b or b.mode ~= 'file' then  
        return
    end
        
    local func, err = loadfile(a_file)            
    if func then
        local env = {}		
        setfenv(func, env)
        local ok, err = pcall(func)
        if ok then
            return env
        else
            print("ERROR pcall: ", err, a_file)
        end
    else
        print("ERROR loadfile: ", err, a_file)
    end    
    return nil
end


if not guiVariant then
	guiVariant = "DCS"
	local guiCfg = get_file_config("./Config/gui.cfg")
	if 	guiCfg then 
		guiVariant = guiCfg.typeGui
	end 
end

local realMissionName

START_PARAMS.command    = '--quit'
main_w                  = 1024
main_h                  = 768
defaultReturnScreen     = 'mainmenu'
tempMissionName         = 'tempMission.miz'
trackFileName           = 'LastMissionTrack.trk'
watchTrackFileName      = '_LastMissionTrack.trk'

initTer 				= false
openMainMenu			= false


DEBUG = true

local textutil = require('textutil')

-- FIXME: remove it
local old_sort = table.sort
table.sort = function(tbl, fun)
    if (type(tbl[1]) == 'string') and (fun == nil) then
        old_sort(tbl, function(op1, op2) return textutil.Utf8Compare(op1, op2) end)
    else
        old_sort(tbl, fun)
    end
end

lfs = require('lfs')  -- Lua File System
local T = require('tools')
local ImageSearchPath = require('image_search_path')
local ProductType = require('me_ProductType') 

absolutPath			= lfs.currentdir()
missionDir			= lfs.writedir() .. 'Missions/'
moviesDir			= lfs.writedir() .. 'Movies/'
userDataDir			= lfs.writedir() .. 'MissionEditor/'
userThemeDir		= lfs.writedir() .. 'MissionEditor/themes/'
tempDataDir			= lfs.tempdir()
liveriesDir         = lfs.writedir() .. 'Liveries/'
tempMissionPath 	= tempDataDir .. 'Mission/' -- путь к временной папке ресурсов миссий
tempCampaignPath 	= tempDataDir .. 'Campaign/' -- путь к временной папке ресурсов миссий
userFiles 			= T.safeDoFileWithRequire('Scripts/UserFiles.lua')
--configHelper 		= T.safeDoFileWithRequire('Scripts/ConfigHelper.lua')    


--__KA50_VERSION__ = true
--__HUMAN_PLANE__ = true
--__FINAL_VERSION__ = true 
--__A10C_VERSION__ = true

--__BETA_VERSION__ = true

--print("*****__FINAL_VERSION__=",__FINAL_VERSION__)
--print("*****__A10C_VERSION__=",__A10C_VERSION__)  

local function loadInternationalization()
  i18 = require('i18n')

  i18.setLocale("l10n")
  i18.gettext.add_package("about")
  i18.gettext.add_package("input")
  i18.gettext.add_package("inputEvents")
  i18.gettext.add_package("payloads")

  -- ЗАГРУЗКА ПЕРЕВОДОВ ИЗ ПЛАГИНОВ 	
	local function loadTranslatePlugins(a_path)
		for dir in lfs.dir(a_path) do
			local fullNameDir  = a_path .. '/' .. dir
			local d = lfs.attributes(fullNameDir)
			if (d and (d.mode == 'directory') and (dir ~= '.') and (dir~='..')) then
				local ldir = lfs.attributes(fullNameDir.. '/l10n')
				if (ldir and (ldir.mode == 'directory')) then
					i18.gettext.add_package("messages", '/' .. fullNameDir.. '/'.. "l10n")
				end
			end
		end
	end
	
	loadTranslatePlugins("Mods/aircraft")
	loadTranslatePlugins("Mods/tech")
end

loadInternationalization() -- НЕ ПЕРЕНОСИТЬ !

OptionsData				= require('Options.Data')
OptionsData.setController(require('Options.Controller'))
local OptionsController		= require('Options.Controller')

local function createGUI()  
  Gui.CreateGUI('./dxgui/skins/skinME/skin.lua')
  
  ImageSearchPath.pushPath('MissionEditor/images/')
 
  Gui.SetBackground('./MissionEditor/images/loading-window.png', true)
  Gui.Redraw()
end

local function createUsersDirs()
	lfs.mkdir(userDataDir)
	lfs.mkdir(userThemeDir)
	lfs.mkdir(userThemeDir..'main/ME/')
	lfs.mkdir(userThemeDir..'main/Sounds/EditorMusic')
	lfs.mkdir(tempDataDir)
	lfs.mkdir(tempMissionPath)
	lfs.mkdir(tempCampaignPath)
    lfs.mkdir(moviesDir)
	
	lfs.mkdir(userFiles.userMissionPath)
	lfs.mkdir(userFiles.userCampaignPath..'\\en')
	lfs.mkdir(userFiles.userCampaignPath..'\\ru')
    lfs.mkdir(userFiles.userCampaignPath..'\\MultiLang')
	lfs.mkdir(userFiles.userTrackPath)
	lfs.mkdir(userFiles.userMgPath)
	lfs.mkdir(userFiles.userOptionsPresetsPath)
	lfs.mkdir(lfs.writedir().."Backup/")
end

function createProgressBar()
	StartProgressBar = require('StartProgressBar')
	StartProgressBar.create(0, 0, main_w, main_h)
	Gui.Redraw()
end

local function addPathTex()
    ImageSearchPath.pushPath("MissionEditor/data/images/Loadout/Units")
    ImageSearchPath.pushPath("MissionEditor/data/images/Loadout/Weapon")

    for k,v in pairs(plugins) do
        if v.applied == true then
            local pathTex = v.dirName.."/".."ImagesGui/"
            local a, err = lfs.attributes(pathTex)
            if a and a.mode == 'directory' then
                ImageSearchPath.pushPath(pathTex)
            end
        end
    end    
end

local function startMusic()
	music = require('me_music')
	music.init('./Sounds', './Sounds/sdef')
	
	music.setMusicVolume(OptionsData.getSound('music'))
	music.setEffectsVolume(OptionsData.getSound('gui'))
end

-- загружаем скин GUI
dofile('./dxgui/skins/skinME/skin.lua')

Gui = require('dxgui')
GuiWin = require('dxguiWin')

setmetatable(dxgui, {__index = dxguiWin})

createUsersDirs()

OptionsData.load(Gui.GetVideoModes())

me_db = require('me_db_api')
me_db.create() -- чтение и обработка БД редактора

-- база данных по плагинам загружается в me_db_api
-- после ее загрузки можно загрузить настройки для плагинов
OptionsData.loadPluginsDb()
OptionsController.saveChanges()

if __PRODUCT_ID__ ~= 2 then
	OptionsData.setMiscellaneous('Datum', 1)
	OptionsData.setDifficulty('heading_units', 1)
end

createGUI() 

FileDialogFilters	= require('FileDialogFilters')
managerModulesME = require('me_managerModulesME')
managerModulesME.init()



if test_showNotYearsUnits == true then
	print("---NotYearsUnits---")
	for typeUnit,v in pairs(me_db.unit_by_type) do
		local countres = me_db.db.getHistoricalCountres(typeUnit)
		local num = 0		
		for kk,vv in pairs(countres) do
			num = num + 1
		end	
		if num == 0 then
			print(string.format("--typeUnit=%-25s     --modul=%-20s", typeUnit, v._origin or "unknow"))
		end
	end
end

if (START_PARAMS and START_PARAMS.returnScreen and START_PARAMS.returnScreen == "") then
    if _SendHWReport then 
        _SendHWReport() 
    end 
end


-- поскольку fullscreen у нас не настоящий, то после вызова Gui.Create() нужно вызвать 
-- Gui.GetWindowSize(), который вернет настоящие размеры окна (для fullscreen это разрешение десктопа)
main_w, main_h = Gui.GetWindowSize()
createProgressBar()
StartProgressBar.setValue(1)
StartProgressBar.setValue(5)

startMusic()

StartProgressBar.setValue(10)

local panel_infoPlugin 	= require('me_infoPlugin')
-- Создание главного меню

mmw = require('MainMenu')
mmw.create(0, 0, main_w, main_h)

addPathTex()

-- Создание модулей
local TheatreOfWarData = require('Mission.TheatreOfWarData')

TheatreOfWarData.load()
	
StartProgressBar.setValue(11)

Terrain = require('terrain')

local CoalitionData					= require('Mission.CoalitionData')
local CoalitionController			= require('Mission.CoalitionController')
local CoalitionUtils				= require('Mission.CoalitionUtils')
local CoalitionPanel				= require('Mission.CoalitionPanel')

CoalitionUtils.setController(CoalitionController)
CoalitionData.setController(CoalitionController)
CoalitionData.setDefaultCoalitions()
CoalitionPanel.setController(CoalitionController)


MapWindow = require('me_map_window')
menubar = require('me_menubar')
toolbar = require('me_toolbar')
statusbar = require('me_statusbar')
panel_manager_resource = require('me_manager_resource')
panel_aircraft = require('me_aircraft')
panel_ship = require('me_ship')
panel_vehicle = require('me_vehicle')
panel_summary = require('me_summary')
panel_radio = require('me_panelRadio')
panel_paramFM = require('me_paramFM')
panel_wagons = require('me_wagons')
panel_suppliers = require('me_suppliers')
panel_triggered_actions = require('me_triggered_actions')
panel_targeting = require('me_targeting')
panel_route = require('me_route')
panel_wpt_properties = require('me_wpt_properties')
panel_actions = require('me_action_edit_panel')
panel_action_condition = require('me_action_condition')
panel_loadout = require('me_loadout')
panel_loadout_vehicles = require('me_loadout_vehicles')
panel_payload_vehicles = require('me_payload_vehicles')
panel_payload = require('me_payload')
panel_nav_target_fix_points = require('me_nav_target_fix_points')
panel_static = require('me_static')
local NavigationPointPanel = require('Mission.NavigationPointPanel')
panel_bullseye = require('me_bullseye')
panel_weather = require('me_weather')
local MapLayerPanel			= require('Mission.MapLayerPanel')
local MissionOptionsView	= require('Options.MissionOptionsView')
local TriggerZoneList		= require('Mission.TriggerZoneList')
local TriggerZonePanel		= require('Mission.TriggerZonePanel')
local AirdromePanel			= require('Mission.AirdromePanel')
module_mission = require('me_mission')
panel_briefing = require('me_briefing')
panel_autobriefing = require('me_autobriefing')
panel_debriefing = require('me_debriefing')
panel_openfile = require('me_openfile')
local panel_record_avi = require('record_avi')
panel_failures = require('me_failures')
panel_enc = require('me_encyclopedia')
local panel_about = require('me_about')
local panel_aboutModules = require('me_aboutModules')
panel_goal = require('me_goal')
panel_roles = require('me_roles')
panel_setImage = require('me_setImage')
MGModule = require('me_generator')
module_updater =  require('me_updater')
langPanel = require('me_langPanel')
showId = require('me_showId')
mapInfoPanel = require('me_mapInfoPanel')
setCoordPanel = require('me_setCoordPanel')
panel_auth                = require('me_authorization')
modulesInfo  = require('me_modulesInfo')
FileDialog 			= require('FileDialog')
panel_server_list = require('mul_server_list')   
panel_quickstart            = require('me_quickstart') 
panel_draw            = require('me_draw_panel') 
local panelContextMenu			= require('me_contextMenu')
panel_backup           = require('me_backup') 
loadoutUtils		= require('me_loadoututils')
local MsgWindow					= require('MsgWindow')


StartProgressBar.setValue(12)

local MissionData					= require('Mission.Data')
local TriggerZoneData				= require('Mission.TriggerZoneData')
local NavigationPointData			= require('Mission.NavigationPointData')
local AirdromeData					= require('Mission.AirdromeData')

MissionData.setTriggerZoneData(TriggerZoneData)
MissionData.setNavigationPointData(NavigationPointData)
MissionData.setCoalitionData(CoalitionData)
MissionData.setAirdromeData(AirdromeData)

TriggerZoneData.setMissionData(MissionData)
NavigationPointData.setMissionData(MissionData)
AirdromeData.setMissionData(MissionData)

GDData = require('me_generator_dialog_data')
GDData.initData()
nodes_manager = require('me_nodes_manager')
nodes_manager.initNodes()
templates_manager = require('me_templates_manager')
templates_manager.initData()

panel_trigrules = require('me_trigrules')
panel_template = require('me_template')
panel_training = require('me_training')
panel_logbook = require('me_logbook')
panel_units_list = require('me_units_list')
panel_startEditor = require('me_startEditor')
mod_copy_paste = require('me_copy_paste')
panel_news = require('me_news')
panel_modulesmanager = require('me_modulesmanager')
panel_waitDsbweb = require('me_waitDsbweb')

local planner_mission = false

U = require('me_utilities')

-- Фиксированные размеры панелей Редактора миссий
top_toolbar_h = U.top_toolbar_h
left_toolbar_w = U.left_toolbar_w
bottom_toolbar_h = U.bottom_toolbar_h
right_toolbar_width = U.right_toolbar_width
right_toolbar_h = U.right_toolbar_h
actions_toolbar_w = U.actions_toolbar_w
condition_bar_h = right_toolbar_h - 28 - 50
actions_bar_h = main_h - top_toolbar_h - bottom_toolbar_h  - condition_bar_h
right_panel_height = main_h - top_toolbar_h - bottom_toolbar_h

function loadPanels(endProgressValue)
	local panelInfo = {}
	
	local addPanelInfo = function(panel, x, y, w, h)
        if panel then
            table.insert(panelInfo, function() panel.create(x, y, w, h) end)
        end
	end
	
	right_bottom_panel_height = right_panel_height  - right_toolbar_h
	right_panel_x = main_w - right_toolbar_width
	right_panel_y = top_toolbar_h
	right_bottom_panel_y = top_toolbar_h + right_toolbar_h

	addPanelInfo(panel_modulesmanager, 0, 0, main_w, main_h)
	addPanelInfo(MapWindow, left_toolbar_w, top_toolbar_h, main_w - left_toolbar_w, right_panel_height)
	addPanelInfo(menubar,  0, 0, main_w, top_toolbar_h )	
	addPanelInfo(panel_briefing, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height)
	addPanelInfo(panel_record_avi, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height)
	addPanelInfo(panel_about, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height) 
	addPanelInfo(panel_aboutModules,  0, 0, main_w, main_h) 
	addPanelInfo(panel_failures, main_w - 650, right_bottom_panel_y, 650,  right_panel_height - right_toolbar_h) 
	addPanelInfo(panel_weather, right_panel_x-20, right_panel_y, right_toolbar_width+20, right_panel_height) 
	addPanelInfo(statusbar, 0, main_h-bottom_toolbar_h, main_w, bottom_toolbar_h)
	addPanelInfo(MapLayerPanel, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height) 
	addPanelInfo(MissionOptionsView, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height)
	addPanelInfo(TriggerZoneList, left_toolbar_w, main_h - bottom_toolbar_h - 300, right_panel_x - left_toolbar_w,  300)
	addPanelInfo(panel_summary, right_panel_x, right_bottom_panel_y, right_toolbar_width, right_bottom_panel_height)
	addPanelInfo(panel_radio, right_panel_x, right_bottom_panel_y, right_toolbar_width, right_bottom_panel_height)
    addPanelInfo(panel_paramFM, right_panel_x, right_bottom_panel_y, right_toolbar_width, right_bottom_panel_height) 
    addPanelInfo(panel_wagons, right_panel_x, right_bottom_panel_y, right_toolbar_width, right_bottom_panel_height) 
	addPanelInfo(panel_suppliers, right_panel_x, right_bottom_panel_y, right_toolbar_width, right_bottom_panel_height)
	addPanelInfo(panel_triggered_actions, right_panel_x, right_bottom_panel_y, right_toolbar_width, right_bottom_panel_height)
	addPanelInfo(panel_targeting, right_panel_x, right_bottom_panel_y, right_toolbar_width, right_bottom_panel_height)
	addPanelInfo(panel_route, right_panel_x, right_bottom_panel_y, right_toolbar_width, right_bottom_panel_height)
	addPanelInfo(panel_wpt_properties, right_panel_x, right_bottom_panel_y, right_toolbar_width, right_bottom_panel_height)
	addPanelInfo(panel_actions, right_panel_x - actions_toolbar_w, main_h - bottom_toolbar_h - actions_bar_h, right_toolbar_width,  actions_bar_h)		
	addPanelInfo(panel_action_condition, right_panel_x - actions_toolbar_w, main_h - bottom_toolbar_h - actions_bar_h - condition_bar_h, right_toolbar_width, condition_bar_h)
	addPanelInfo(panel_loadout, left_toolbar_w, top_toolbar_h, main_w - left_toolbar_w - right_toolbar_width, right_panel_height)
    addPanelInfo(panel_loadout_vehicles, left_toolbar_w, top_toolbar_h, main_w - left_toolbar_w - right_toolbar_width, right_panel_height)
    addPanelInfo(panel_payload_vehicles, right_panel_x, right_bottom_panel_y, right_toolbar_width,  right_bottom_panel_height)
	addPanelInfo(panel_payload, right_panel_x, right_bottom_panel_y, right_toolbar_width,  right_bottom_panel_height)
	addPanelInfo(panel_nav_target_fix_points, right_panel_x, right_bottom_panel_y, right_toolbar_width, right_bottom_panel_height)	
	addPanelInfo(panel_aircraft, right_panel_x, right_panel_y, right_toolbar_width, right_toolbar_h)
	addPanelInfo(panel_ship, right_panel_x, right_panel_y, right_toolbar_width, right_toolbar_h)
	addPanelInfo(panel_vehicle, right_panel_x, right_panel_y, right_toolbar_width, right_toolbar_h)
    addPanelInfo(panel_manager_resource, main_w - 1037+left_toolbar_w+1, top_toolbar_h, 1037-left_toolbar_w-1-right_toolbar_width, right_panel_height)
	addPanelInfo(panel_static, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height)
	addPanelInfo(AirdromePanel, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height)
	addPanelInfo(NavigationPointPanel, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height)	
	
	addPanelInfo(panel_bullseye, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height)
	addPanelInfo(panel_goal, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height) 
	addPanelInfo(panel_roles, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height) 
	addPanelInfo(panel_trigrules, 0, top_toolbar_h, main_w,  right_panel_height) 
	addPanelInfo(TriggerZonePanel, right_panel_x, top_toolbar_h, right_toolbar_width,  right_panel_height) 
	addPanelInfo(panel_template, right_panel_x, top_toolbar_h, right_toolbar_width,  right_panel_height) 
	addPanelInfo(panel_units_list, left_toolbar_w, main_h - bottom_toolbar_h - 350, right_panel_x - left_toolbar_w,  350)
	addPanelInfo(panel_startEditor, left_toolbar_w, top_toolbar_h, main_w-left_toolbar_w,  right_panel_height)
    addPanelInfo(panel_server_list, 0, 0, main_w, main_h)    
    addPanelInfo(panel_waitDsbweb, 0, 0, main_w, main_h)    
    addPanelInfo(panel_setImage, right_panel_x-840, top_toolbar_h, 840, right_panel_height)
    addPanelInfo(langPanel, 0, 0, main_w, main_h)
    addPanelInfo(showId, right_panel_x-391, right_panel_y)
    addPanelInfo(mapInfoPanel, left_toolbar_w, main_h-100, main_w-left_toolbar_w, 40)
	addPanelInfo(setCoordPanel, left_toolbar_w, top_toolbar_h, 570, 165)
	addPanelInfo(panel_quickstart, 0, 0, main_w, main_h)
	addPanelInfo(panel_draw, right_panel_x, right_panel_y, right_toolbar_width, right_panel_height)
	addPanelInfo(panel_backup, right_panel_x, right_panel_y, 400, 600)
	
    addPanelInfo(FileDialog)
	
	local infoCount = #panelInfo
	local progressValue = StartProgressBar.getValue()
	local progressDelta = (endProgressValue - progressValue) / infoCount
	
	for i, func in ipairs(panelInfo) do
		func()
		progressValue = progressValue + progressDelta
		StartProgressBar.setValue(math.floor(progressValue))
	end
	
	FileDialog.initSoundPlayer()
	
	panel_logbook.updateUnitsData()
end


function loading()
    module_updater.init()
	
	toolbar.create(0, top_toolbar_h, left_toolbar_w, right_panel_height) 
	left_toolbar_w = toolbar.getWidth()

	loadPanels(90)
	
	templates_manager.init(0, top_toolbar_h, main_w,  right_panel_height)
	StartProgressBar.setValue(91)	
	
	nodes_manager.setParams(0, top_toolbar_h, main_w,  right_panel_height) 

	StartProgressBar.setValue(95)	
end

function CheckActivation(a_param)
    return _CheckActivation(a_param)
end

function prepareMissionPath()
    function trimQuotes(str)
        if string.find(str, '^"') and string.find(str, '"$') then
            local res = string.sub(str, 2, -2)
            return res
        else
            return str
        end        
    end
        
    START_PARAMS.missionPath = trimQuotes(START_PARAMS.missionPath)
    if START_PARAMS.missionPath and ('' ~= START_PARAMS.missionPath) then

        realMissionName = START_PARAMS.realMissionPath
        realMissionName = trimQuotes(realMissionName or '')
        module_mission.load(START_PARAMS.missionPath) -- надо грузить временную миссию, так как туда записано имя пилота из логбука
        module_mission.mission.path = realMissionName
		MISSION_PATH = realMissionName
        menubar.setFileName(U.extractFileName(realMissionName))
    else
        local path = tempDataDir .. tempMissionName
        print('removing', path)
        os.remove(path)
        module_mission.clearTempFolder()
    end
end

function openReturnScreen()   
print("---- openReturnScreen=",START_PARAMS.returnScreen)

    music.start()   
	
    --START_PARAMS.startME = "G:\\test\\1.miz" -- TEST  DCS.exe --editor "G:\\test\\1.miz"

    if nil ~= START_PARAMS.startME then 
		panel_auth.openAutorization(mmw.setAutorization)
		modulesInfo.init()  
		modulesInfo.setCallback(mmw.callbackMainMenu)
		
		local startMEPath = START_PARAMS.startME		
		local a = lfs.attributes(startMEPath)
		if a == nil then
			startMEPath = missionDir..startMEPath
			a = lfs.attributes(startMEPath)
		end

		if a ~= nil then		
			mmw.showMissionEditor()
			toolbar.loadMission(startMEPath)		
		else
			MsgWindow.warning(_("Mission").." "..START_PARAMS.startME.." ".._("not found."), _("WARNING"), _("OK")):show()
			mmw.showMissionEditorEmpty()
		end	
		START_PARAMS.startME = nil
		return	
	end
	
	if '' == START_PARAMS.returnScreen then 
		if (__PRODUCT_ID__ == 2 or ProductType.getType() == "LOFAC")
			and managerModulesME.moduleMainMenu == nil then
			mmw.showMissionEditorEmpty()
			openMainMenu = false
		else
            mmw.show(true)
			openMainMenu = true
			MapWindow.initMapAfterSim()
			panel_auth.openAutorization(mmw.setAutorization)
            modulesInfo.init()  
			modulesInfo.setCallback(mmw.callbackMainMenu)
        end 
	elseif START_PARAMS.returnScreen == 'quickstart' then
		panel_debriefing.returnScreen = defaultReturnScreen
        panel_debriefing.show(true)
		openMainMenu = false
    elseif START_PARAMS.returnScreen == 'multiplayer' then
        mmw.show(true, true)
		MapWindow.initMapAfterSim()
        panel_server_list.show(true) 
		mmw.show(false)	
		openMainMenu = false		
    elseif 'prepare' == START_PARAMS.returnScreen  then
        if realMissionName == nil then
            print('realMissionName == nil')
            return
        end
        module_mission.copyMission(realMissionName, START_PARAMS.missionPath)
        module_mission.load(realMissionName)
        openMainMenu = false
		
        MapWindow.show(true)
	elseif 'record_avi' == START_PARAMS.returnScreen then
        MapWindow.initTerrain(true, false, "ME", module_mission.getDefaultDate())
		module_mission.create_new_mission()
		MapWindow.show(true)
		panel_record_avi.show(true)
		openMainMenu = false		
    elseif 'LoadAndBriefing' == START_PARAMS.returnScreen  then
        local path = START_PARAMS.missionPath  
        START_PARAMS.returnScreen = ""
        
        mmw.show(false) 
		openMainMenu = false		
        toolbar.setOpenButtonState(false)
        statusbar.t_file:setText(U.extractFileName(path))
		
		local waitScreen = require('me_wait_screen')
		
        waitScreen.setUpdateFunction(function()
            panel_autobriefing.missionFileName = path
            panel_autobriefing.returnToME = false
            -- грузим миссию без редактора
            if module_mission.load(path) then
                panel_autobriefing.show(true, 'openmission')
            else
                mmw.show(true) 
            end
        end)
    elseif 'quit' == START_PARAMS.returnScreen  then    

    else
		if ProductType.getType() == "LOFAC" then
			panel_debriefing.returnScreen = 'editor'
		elseif __PRODUCT_ID__ == 2 then
			if 'campaign' == START_PARAMS.returnScreen then
				panel_debriefing.returnScreen = 'campaign'
			else
				panel_debriefing.returnScreen = 'editor'
			end
		else
			panel_debriefing.returnScreen = START_PARAMS.returnScreen
		end
		openMainMenu = false
        panel_debriefing.show(true)
    end
end


function loadingFirstTime()
    loading()
    prepareMissionPath()
    StartProgressBar.setValue(100)
end

-- used in  __EMBEDDED__
function onShowMainInterface()
--print("--onShowMainInterface()---")
	prepareMissionPath()
	mmw.setLastWallpaper()
	openReturnScreen()
end

function onShowIntermission()
--print("--onShowIntermission()---")

end

function setPlannerMission(pm)
	planner_mission = pm
end

function isPlannerMission()
	return planner_mission
end

local UpdateManager = require('UpdateManager')


Gui.SetupApplicationUpdateCallback()

-- Данная функция будет вызываться на каждом кадре отрисовки GUI.
Gui.AddUpdateCallback(UpdateManager.update)

UpdateManager.add(music.update)

function restartME()
    START_PARAMS.command = '--restart'
    START_PARAMS.missionPath = ''

    START_PARAMS.returnScreen = ''

    MISSION_PATH = ''
    Gui.doQuit()    
end

function onQuit()
	local exit_dialog = require('me_exit_dialog')
	
	if exit_dialog.show() then
		UpdateManager.add(Gui.doQuit)
	end
end 

Gui.SetupApplicationOnQuitCallback()
Gui.SetQuitCallback(onQuit)

local function uninitializeDemoscenes()	
	local EncyclopediaForm = require('me_encyclopedia')
	EncyclopediaForm.uninitialize()
    panel_loadout.uninitialize()
    panel_loadout_vehicles.uninitialize()
    panel_static.uninitialize()
end

function Gui.doQuit()  

	print('~~~Gui.doQuit() ')
    if __DO_NOT_ERASE_DEBRIEF_LOG__ ~= true then 
        os.remove(lfs.writedir()..'Logs\\debrief.log');
    end;

	uninitializeDemoscenes()
     
	mmw.show(false)
	
	if MapWindow.getVisible() == true then
		MapWindow.show(false)
	end
	
	require('utils_common').saveMissionTheatreCache()
	
	--START_PARAMS.command = '--quit'	
	__EMBEDDED__.doAction()
end

function backupTrackMission()
    local dir = 'temp\\history'
    if not lfs.dir(dir)() then
        print('creating history dir '..dir)
        local res, err = lfs.mkdir(dir)
        print('lfs: ',res, err)
    end
    
    local timeTbl = os.date('*t')
    local timeStr = tostring(timeTbl.month) .. '-' .. tostring(timeTbl.day) ..
        '-' .. tostring(timeTbl.hour) .. '-' .. tostring(timeTbl.min) .. 
        '-' .. tostring(timeTbl.sec)

    local source = 'temp\\' .. tempMissionName
    local dest = dir .. '\\tempMission_' .. timeStr .. '.miz'
    local str = string.format('copy %s %s >> nul', source, dest)
    print(str)
    os.execute(str)
    
    local source = 'temp\\' .. trackFileName
    local dest = dir .. '\\LastMissionTrack_' .. timeStr .. '.trk'
    local str = string.format('copy %s %s >> nul', source, dest)
    print(str)
    os.execute(str)
    --mission:close()

    local source = 'temp\\debrief.log'
    local dest = dir .. '\\debrief_' .. timeStr .. '.log'
    local str = string.format('copy %s %s >> nul', source, dest)
    print(str)
    os.execute(str)
end 

function createListsUnitsPlugins()
	enableModules = {}
    
	for k,v in pairs(plugins) do
		enableModules[v.id] = v.applied
	end
    
    aircraftFlyableInPlugins = {}
	aircraftsFlyableByPluginId = {}
    pluginsById = {}
	for k,module_ in pairs(plugins) do
        if module_.applied then
            for type,unit_setting in pairs(module_.various_unit_settings) do
                if unit_setting and unit_setting.HumanCockpit == true then 
                    aircraftFlyableInPlugins[type] = aircraftFlyableInPlugins[type] or {}
                    aircraftFlyableInPlugins[type] = module_.id
					aircraftsFlyableByPluginId[module_.id] = aircraftsFlyableByPluginId[module_.id] or {}
					table.insert(aircraftsFlyableByPluginId[module_.id],type)
                end
            end
            pluginsById[module_.id] = module_
        end
	end
end

createListsUnitsPlugins()
loadingFirstTime()

local function loadUiInputlayer()
	local Input				= require('Input')
	local InputData			= require('Input.Data')
	local InputLoader		= require('Input.Loader')
	local userConfigPath 	= lfs.writedir() .. 'Config/Input/'
	local sysConfigPath 	= './Config/Input/'

	InputData.initialize(userConfigPath, sysConfigPath)
	InputLoader.loadUiLayer(sysConfigPath)
end

loadUiInputlayer()


-- выгружаем картинку задника
Gui.SetBackground()
Gui.SetWaitCursor(false)
-- Gui.EnableDebugDraw(true)  -- DEBUG

function onWindowFocused(focused)
	if OptionsData.getSound('play_audio_while_minimized') == false then
		if focused then
			music.resume()
		else
			music.pause()
		end
	end
end

isDCM = false
if test_dyn_missions == true then
	rts.Fly = function()
		UpdateManager.add(function()			
			isDCM = true
			print("---rts.Fly---")
			rts.closeAll()

			panelContextMenu.show(false)
			menubar.onFly()
			
			isDCM = false
			-- удаляем себя из UpdateManager
			return true
		end)
		
	end
end


Gui.SetupApplicationOnActivateCallback()
Gui.SetActivateCallback(onWindowFocused)

StartProgressBar.kill()

require('utils_common').loadMissionTheatreCache()

----------------------------------------------------------------------------------
function forceServer()
    local server = require("mul_create_server")
    return server.forceServer()
end
----------------------------------------------------------------------------------
function silentAutorizationSync()
    local server = require("mul_create_server")
    return server.silentAutorizationSync()
end
----------------------------------------------------------------------------------

function isInitTerrain()
	return initTer
end


