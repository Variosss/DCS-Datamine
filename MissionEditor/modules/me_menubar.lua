local base = _G

module('me_menubar') -- top header&toolbar

local require = base.require
local ipairs = base.ipairs

local MapWindow					= require('me_map_window')
local DialogLoader				= require('DialogLoader')
local Menu						= require('Menu')
local MenuItem					= require('MenuItem')
local MenuBarItem				= require('MenuBarItem')
local Gui						= require('dxgui')
local AutoBriefingModule		= require('me_autobriefing')
local payload					= require('me_payload')
local MissionModule				= require('me_mission')
local Logbook					= require('me_logbook')
local i18n						= require('i18n')
local MsgWindow					= require('MsgWindow')
local NodesManager				= require('me_nodes_manager')
local TemplatesManager			= require('me_templates_manager')
local toolbar					= require('me_toolbar')
local panel_generator			= require('me_generator_dialog')
local panel_about				= require('me_about')
local panel_record_avi 			= require('record_avi')
local panel_campaign_editor 	= require('me_campaign_editor')
local panel_campaign			= require('me_campaign')
local MissionOptionsView		= require('Options.MissionOptionsView')
local OptionsDialog				= require('me_options')
local MapController				= require('Mission.MapController')
local MapLayerController		= require('Mission.MapLayerController')
local NavigationPointController	= require('Mission.NavigationPointController')
local AirdromeController 		= require('Mission.AirdromeController')
local waitScreen	        	= require('me_wait_screen')
local pPayload_vehicles		    = require('me_payload_vehicles')
local panel_server_list         = require('mul_server_list')  
local staticTemplate			= require('me_staticTemplate') 
local staticTemplateSave 		= require('me_staticTemplateSave') 
local staticTemplateLoad 		= require('me_staticTemplateLoad') 
local setCoordPanel 			= require('me_setCoordPanel')
local Terrain					= require('terrain')
local panelSelectUnit			= require('me_selectUnit')
local MeSettings				= require('MeSettings')
local FileDialog 				= require('FileDialog')
local FileDialogFilters 		= require('FileDialogFilters')
local TriggerZoneController 	= require('Mission.TriggerZoneController')
local module_mission 			= require('me_mission')
local panel_vehicle				= require('me_vehicle')
local panel_dataCartridge 	  	= require('me_dataCartridge')
local panel_aircraft 			= require('me_aircraft')
local panel_auth				= require('me_authorization')
local panelContextMenu			= require('me_contextMenu')
local statusbar 				= require('me_statusbar')
local music						= require('me_music')
local sound						= require('sound')
local UpdateManager				= require('UpdateManager')
local optionsEditor 			= require('optionsEditor')
local OptionsData    			= require('Options.Data')
local coords_info				= require('me_coords_info')
local ProductType 				= require('me_ProductType') 
local net               		= require('net')
local panel_ChangingCoalitions 	= require('me_changingCoalitions') 
local CoalitionPanel			= require('Mission.CoalitionPanel')
local progressBar 				= require('ProgressBarDialog')
local lfs						= require('lfs')
local panelBeaconsInfo			= require('me_beaconsInfo')
local panel_backup				= require('me_backup')
local Create_server     		= require('mul_create_server')
local managerModulesME 			= require('me_managerModulesME')
local flightPlans				= require('me_flightPlans')


i18n.setup(_M)

cdata = {
	missionEditor 		= _('MISSION EDITOR'),
	missionEditorLOFAC 	= _('MISSION EDITOR LOFAC'),
	yes					= _('YES'),
	no					= _('NO'),
	cancel				= _('CANCEL'),
	question			= _('QUESTION'),
	
	-- menu items
	file				= _('FILE'),
	new					= _('NEW'),
	open				= _('OPEN'),
	save				= _('SAVE'),
	saveAs				= _('SAVE AS'),
	openBackup			= _('OPEN BACKUP'),
	exit				= _('EXIT'),
	
	-- menu View
	View				= _('VIEW'),	
	Metric				= _('METRIC-MEmenu'		, 'METRIC'	),
	Imperial			= _('IMPERIAL-MEmenu'	, 'IMPERIAL'),
	iconsNato			= _('Icons NATO'					),
	iconsRussia			= _('Icons Russia'					),	
	
	
	edit				= _('EDIT-MEmenu', 'EDIT'),
	addAirplane			= _('ADD AIRPLANE'),
	addHelicopter		= _('ADD HELICOPTER'),
	addShip				= _('ADD SHIP'),
	addVehicle			= _('ADD VEHICLE'),
	addStatic			= _('ADD STATIC'),
	addTemplate			= _('ADD TEMPLATE'),
	remove				= _('REMOVE'),
	centerOnPlayer		= _('CENTER ON PLAYER'),
	
	flight				= _('FLIGHT'),
	recordAvi			= _('RECORD AVI'),
	replay				= _('REPLAY-EDITOR', 'REPLAY'),
	startServer			= _('LAUNCH MULTIPLAYER SERVER'),
	
	campaign			= _('CAMPAIGN'),
	campaignEditor		= _('CAMPAIGN BUILDER'),
	
	customize			= _('CUSTOMIZE'),
	
	mapOptions			= _('MAP OPTIONS'),
	langPanel			= _('LOCAL PANEL'),
	setPosition			= _('SET POSITION'),
	logbook				= _('LOGBOOK'),
	beaconsInfo			= _('BEACONS INFO'),
	
	generate			= _('GENERATE...'),
	nodes				= _('NODES'),
	templates			= _('TEMPLATES'),	
	saveGen				= _('SAVE'),

	help 				= _('MISC'),
	encyclopedia 		= _('ENCYCLOPEDIA'),
    trainingNetwork 	= _('TRAINING NETWORK'),
	
	dynMission 			= _('DYNAMIC MISSION'),
	generateDyn 		= _('GENERATE'),
	rts_on 				= _('RTS ON'),
	rts_off 			= _('RTS OFF'),
	rts_saveDCM 		= _('SAVE DCM'),
	rts_openDCM 		= _('OPEN DCM'),
	
	openDynMission 		= _('Open dynamic mission:'),
	saveDynMission 		= _('Save dynamic mission:'),
	
	openDCM 			= _('Open DCM:'),
	saveDCM 			= _('Save DCM:'),
	
	loadStaticTemplate 	= _('LOAD STATIC TEMPLATE'),
	saveStaticTemplate 	= _('SAVE STATIC TEMPLATE'),
	
	options				= _('OPTIONS-MenuBar', 'OPTIONS'),
	
	historical 			= _("Historical list of units"),
	
	viewDetectionAreas 	= _('View detection areas'),
	viewEngagementAreas	= _('View engagement areas'),
}

	
if ProductType.getType() == "LOFAC" then
	cdata.about             = _('ABOUT MISSION EDITOR-LOFAC')
    cdata.generator         = _('MISSION GENERATOR MENU-LOFAC')
    cdata.missionOptions    = _('MISSION OPTIONS-LOFAC')
    cdata.flyMission        = _('FLY MISSION-LOFAC')
	cdata.prepareMission    = _('PREPARE MISSION-LOFAC')
    cdata.saveCahnges	= _(
        'Mission contains unsaved changes! All changes will be lost!\
        Press "Yes" to save your changes\
        Press "No" to discard and continue unsaved\
        Press "Cancel" to cancel flight-LOFAC')
	cdata.saveCahnges2	= _(
        'Mission contains unsaved changes! Your changes may be lost!\
        Press "Yes" to save your changes\
        Press "No" to quit without saving\
        Press "Cancel" to cancel-LOFAC')
	cdata.new_mission = _('Creating new mission-LOFAC')
	cdata.new_mission_msg = _('Are you sure you want to create new mission? \nAll unsaved changes will be lost!-LOFAC')
	cdata.open_mission_msg = _('Are you sure you want to open new mission? \nAll unsaved changes will be lost!-LOFAC')
    cdata.missionPlanner = _('MISSION PLANNER-LOFAC') 
    cdata.flight = _('STARTING THE EPISODES-LOFAC')
else
	cdata.about             = _('ABOUT MISSION EDITOR')
    cdata.generator         = _('MISSION GENERATOR MENU')
    cdata.missionOptions    = _('MISSION OPTIONS')
    cdata.flyMission        = _('FLY MISSION')
	cdata.prepareMission    = _('PREPARE MISSION')
    cdata.saveCahnges	= _(
        'Mission contains unsaved changes! All changes will be lost!\
        Press "Yes" to save your changes\
        Press "No" to discard and continue unsaved\
        Press "Cancel" to cancel flight')
	cdata.saveCahnges2	= _(
        'Mission contains unsaved changes! Your changes may be lost!\
        Press "Yes" to save your changes\
        Press "No" to quit without saving\
        Press "Cancel" to cancel')
	cdata.new_mission = _('Creating new mission')
	cdata.new_mission_msg = _('Are you sure you want to create new mission? \nAll unsaved changes will be lost!')
	cdata.open_mission_msg = _('Are you sure you want to open new mission? \nAll unsaved changes will be lost!')	 
    cdata.missionPlanner = _('MISSION PLANNER')
end

local x_, y_, w_, h_
local enabledSave = true
local removedMenuItems = {}

function create(x, y, w, h)
	x_ = x
	y_ = y
	w_ = w
	h_ = h
end

function hotCallback(a_fun)
	panelSelectUnit.show(false)
	if panel_ChangingCoalitions.isVisible() ~= true 
			and CoalitionPanel.isVisible() ~= true then
		a_fun()
	end
end

local function addWindowHotKeys()
	window:addHotKeyCallback('Ctrl+O', function() hotCallback(onOpen) end)
	window:addHotKeyCallback('Ctrl+N', function() hotCallback(onNew) end)
	window:addHotKeyCallback('Ctrl+S', function() hotCallback(onSave) end)
	window:addHotKeyCallback('Ctrl+P', function() hotCallback(function() onFly('--mission') end) end)
	window:addHotKeyCallback('Ctrl+W', function() hotCallback(onSetPosition) end)
	window:addHotKeyCallback('Ctrl+Y', function() hotCallback(onCoordsInfo) end)
	window:addHotKeyCallback('C', 	   function() hotCallback(onCenterOnPlayer) end)
	
	
	if ProductType.getType() ~= "LOFAC" and base.__PRODUCT_ID__ ~= 2 then
		window:addHotKeyCallback('Ctrl+M', function() hotCallback(function() onFly('--prepare') end) end)
	end
	
	window:addHotKeyCallback('Ctrl+R', function() hotCallback(onRecordAVI) end)	
	window:addHotKeyCallback('delete', function() hotCallback(onRemove) end)
end

local function updateMenu()
	local menu = menuBar.flight.menu
	
	if net.NO_SERVER ~= true then
		if removedMenuItems['startServer'] then
			menu:insertItem(removedMenuItems['startServer'])
			removedMenuItems['startServer'] = nil
		end	
	else
		removedMenuItems['startServer'] = menu.startServer
		menu:removeItem(menu.startServer)
	end	
end

local function setMenuCallback(menu)	
	function menu:onChange(item)
		if item.func then
			item.func()
		end
	end
end

local function setFileMenu()
	local menu = menuBar.file.menu
	
	setMenuCallback(menu)
	
	menu.new.func       	= onNew
	menu.open.func      	= onOpen
	menu.saveAs.func   	 	= onSaveAs
    menu.save.func      	= onSave
	menu.openBackup.func  	= onOpenBackup
	menu.exit.func      	= onExit
end

local function setViewMenu()
	local menu = menuBar.view.menu
	
	setMenuCallback(menu)
	
	menu.mrMetric.func 		= onUnitSys
	menu.mrImperial.func 	= onUnitSys
	
	if base.__PRODUCT_ID__ == 2 then
		menu:removeItem(menu.mrNato)
		menu.mrNato = nil
		menu:removeItem(menu.mrRussia)
		menu.mrRussia = nil
	else
		menu.mrNato.func 		= onIconsTheme
		menu.mrRussia.func 		= onIconsTheme
	end
		
	menu.beaconsInfo.func 	= onBeaconsInfo
end

local function setEditMenu()
	local menu = menuBar.edit.menu
	
	setMenuCallback(menu)
	
	menu.addAirplane.func = onAddAirplane
	menu.addHelicopter.func = onAddHelicopter
	menu.addShip.func = onAddShip
	menu.addVehicle.func = onAddVehicle
	menu.addStatic.func = onAddStatic
	menu.addTemplate.func = onAddTemplate
	menu.remove.func = onRemove	
	menu.saveStaticTemplate.func = onSaveStaticTemplate
	menu.loadStaticTemplate.func = onLoadStaticTemplate
	menu.centerOnPlayer.func = onCenterOnPlayer
end


local function setFlightMenu()
	local menu = menuBar.flight.menu
	
	setMenuCallback(menu)
	
	menu.flyMission.func = function() onFly('--mission') end
	
	if base.__PRODUCT_ID__ == 2 or ProductType.getType() == "LOFAC" then
		menu:removeItem(menu.prepareMission)
		menu.prepareMission = nil
		if not (net.NO_SERVER and net.NO_CLIENT) then
			menu.trainingNetwork.func = onNetworkTraining
		else
			menu:removeItem(menu.trainingNetwork)
	    end
	else
		menu.prepareMission.func = function() onFly('--prepare') end
        menu:removeItem(menu.trainingNetwork)
	end
	
	if base.__PRODUCT_ID__ == 2 then
		menu:removeItem(menu.recordAvi)
		menu.recordAvi = nil
	else
		menu.recordAvi.func = onRecordAVI
	end
	
	menu.replay.func = onShowReplays
	
	menu.startServer.func = onStartServer

	if base.__PRODUCT_ID__ ~= 2 then
		menu:removeItem(menu.flightPlans)
		menu.flightPlans = nil
	else
		menu.flightPlans.func  = onFlightPlans	
	end		
end

local function setCampaignMenu()	
	if ProductType.getType() == "LOFAC"  then
		menuBar:removeItem(menuBar.campaign)
		menuBar.campaign = nil
	elseif base.__PRODUCT_ID__ == 2 then
		local menu = menuBar.campaign.menu
		
		setMenuCallback(menu)
		menu.campaign.func = onCampaign
		
		menu:removeItem(menu.campaignEditor)
		menu.campaignEditor = nil
	else
		local menu = menuBar.campaign.menu
		
		setMenuCallback(menu)
		
		menu.campaign.func = onCampaign
		menu.campaignEditor.func = onCampaignEditor
	end
end

local function setCustomizeMenu()
	local menu = menuBar.customize.menu
	
	setMenuCallback(menu)
	
	menu.missionOptions.func = onOptions
	menu.mapOptions.func = onMapOptions
    menu.langPanel.func = onLangPanel
	menu.setPosition.func = onSetPosition
	menu.logbook.func = onLogbook	
	
end

local function setGeneratorMenu()
	local menu = menuBar.generator.menu
	local MGModule = require('me_generator')
	
	setMenuCallback(menu)
	
	menu.generate.func = onGeneratorDialog
	menu.nodes.func = onNodes
	menu.templates.func = onGeneratorTemplates
	menu.save.func = MGModule.saveAll
end

local function setHelpMenu()
	local menu = menuBar.help.menu
	
	setMenuCallback(menu)
	
	menu.encyclopedia.func = onEncyclopedia
	
	if ProductType.getType() == "LOFAC" or base.__PRODUCT_ID__ == 2 then
		menu:removeItem(menu.about)
		menu.about = nil
	else	
		menu.about.func = onAbout
	end
	
end

local function setDynMissionMenu()
	local menu = menuBar.dymMission.menu
	setMenuCallback(menu)
	
--	menu.load.func = onLoadDynMission
--	menu.save.func = onSaveDynMission
--	menu.upload.func = onUploadDynMission
	menu.generate.func = onGenerateDynMission
	menu.rts_on.func = onRtsOn
	menu.rts_off.func = onRtsOff
	menu.rts_saveDCM.func = onRtsSaveDCM
	menu.rts_openDCM.func = onRtsOpenDCM
end

local function setModMEMenu()
	for k,modul in base.pairs(managerModulesME.modulesME) do
		base.print("--addMenu-",modul.addMenu)
		if modul.addMenu then
			for kk, tbl in base.pairs(modul.addMenu) do
				base.print("--tbl.mainMenu-",tbl.mainMenu)
				local menu = menuBar
				if tbl.mainMenu then
					menu = menuBar[tbl.mainMenu].menu
					local menuSubItem = menu:newItem(tbl.newMenu, tbl.pos)	
					menuSubItem:setSkin(itemSkin)
					base.print("--add menuSubItem-",tbl.newMenu)					
					menuSubItem.func = modul[tbl.callback]
				end
			end	
		end
	end
end

function updateTimeBackup(a_str)
	local   wdg = pInfo.sTimeBackup 
	if wdg then
		if a_str ~= "" then 
			wdg:setText(a_str)
			wdg:setTooltipText(_("backup in")..a_str)
			wdg:setVisible(true)
			
			local xx,yy,ww,hh = wdg:getBounds()
			t_file_pos = xx + ww;
		else
			wdg:setVisible(false)
			t_file_pos = 0;
		end
	end	
	if  t_file and t_file_pos ~= nil then 
		local xx,yy = t_file:getPosition()
		t_file:setPosition(t_file_pos,yy)
	end
end


local function create_()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_menubar.dlg', cdata)
	window:setBounds(x_, y_, w_, h_)

	pInfo 		= window.pInfo
	t_file 		= pInfo.t_file
	local xx,yy = t_file:getPosition()
	t_file_pos  = xx
	
	window.pLeft.buttonClose.onChange 		= onChangeExit
	window.pLeft.bOptions.onChange 			= onGlobalOptions
	window.pLeft.tbShowEngAreas.onChange 	= onChange_tbShowEngAreas
	window.pLeft.tbShowDetAreas.onChange 	= onChange_tbShowDetAreas
	window.pLeft.tbSnap.onChange 			= onChange_tbSnap
	
	window.pLeft.tbShowEngAreas:setState(MeSettings.getShowEngAreas())	
	window.pLeft.tbShowDetAreas:setState(MeSettings.getShowDetAreas())
	window.pLeft.tbSnap:setState(MeSettings.getSnap())
	
	itemSkin = window.menuBar.file.menu.new:getSkin()
	
	menuBar = window.menuBar
	
	setFileMenu()
	setViewMenu()
	setEditMenu()
	setFlightMenu()
	setCampaignMenu()
	setCustomizeMenu()
	setGeneratorMenu()
	setHelpMenu()
	setDynMissionMenu()
	
	setModMEMenu()
	
	updateMenu()

	addWindowHotKeys()
	
	
	if base.test_dyn_missions == true then
		menuBar.dymMission:setVisible(true)
	else
		menuBar.dymMission:setVisible(false)
	end
	
	if ProductType.getType() ~= "LOFAC" and base.__PRODUCT_ID__ ~= 2 then
		window.pLeft.bOptions:setVisible(false)
	end
	
	if base.__PRODUCT_ID__ ~= 2 then
		window.pLeft.tbSnap:setVisible(false)
		MeSettings.setSnap(false)
	end
	
	local wl,hl = window.pLeft:getSize()
	window.pLeft:setPosition(w_ - wl,0)
	
	updateTimeBackup("")
	t_file:setText("")
end

function setAutorization(result)
	if window then
		updateMenu()
	end
end
	
function setEnabled(b)
	if (base.isPlannerMission() == false) then
		menuBar:setVisible(b)
	end
end

function setPlannerMission(planner_mission)
	if planner_mission == true then
--		pInfo:setText(cdata.missionPlanner)
		menuBar:setVisible(false)		
	else
--[[		if ProductType.getType() == "LOFAC" then
			pInfo:setText(cdata.missionEditorLOFAC)
		else
			pInfo:setText(cdata.missionEditor)
		end	
]]		
		menuBar:setVisible(true)
	end
	
	local layout = window:getLayout()
	
	if layout then
		layout:updateSize()
	end
end

	
function show(b)
	if not window then
		create_()
	end

    updateEnabledButtons()
	
	setPlannerMission(base.isPlannerMission())
	
	local menu = menuBar.view.menu

	if OptionsData.getDifficulty('units') == 'metric' then
		menu.mrMetric:setState(true)
	else
		menu.mrImperial:setState(true)
	end
	
	if menu.mrNato and menu.mrRussia then
		if OptionsData.getDifficulty('iconsTheme') == 'nato' then
			menu.mrNato:setState(true)
		else
			menu.mrRussia:setState(true)
		end
	end
	
	window:setVisible(b)
end

function showOnExitSavePrompt(yes, no, cancel)
	local result = cancel
	local handler = MsgWindow.question(cdata.saveCahnges2, cdata.question, yes, no, cancel)
	
	function handler:onChange(button)
		result = button
	end
	
	handler:show()
	
	return result
end

-- menu callbacks
function onExit()
	if ((base.__PRODUCT_ID__ == 2 and managerModulesME.moduleMainMenu == nil) or ProductType.getType() == "LOFAC")
		and base.isPlannerMission() ~= true  then
		local exit_dialog = require('me_exit_dialog')
		
		if exit_dialog.show() then
			UpdateManager.add(Gui.doQuit)
		end
	else
		if MapWindow.isEmptyME() ~= true and MissionModule.isSignedMission() ~= true and MissionModule.isMissionModified() then
			local result = showOnExitSavePrompt(cdata.yes, cdata.no, cdata.cancel)
			
			if result == cdata.yes then
				toolbar.saveMission(true)
				Exit()
			elseif result == cdata.no then
				Exit()
			end
		else		
			Exit()
		end
	end	
--	MapWindow.closeNewMapView()
end

function Exit()
    MapWindow.unselectAll()	
	if ((base.__PRODUCT_ID__ == 2 and managerModulesME.moduleMainMenu == nil) or ProductType.getType() == "LOFAC") and base.isPlannerMission() ~= true then
		MapWindow.unselectAll()	
        toolbar.untoggle_all_except()
        MapController.onExit()
        hideME()
        base.START_PARAMS.command = '--quit'
        Gui.doQuit() 
		return
	end
	
	toolbar.untoggle_all_except()
    hideME()
	
    if MapWindow.isEmptyME() ~= true and MapWindow.isCreated() and (base.isPlannerMission() ~= true) then
        MapWindow.selectedGroup = nil
        MissionModule.create_new_mission()							
    end
	MapController.onExit()
	
	base.mmw.show(true)	
end 

function hideME()
	MapWindow.unselectAll()
    MapWindow.show(false)
	base.statusbar.show(false)
    base.mapInfoPanel.show(false)
	base.setCoordPanel.show(false)
	toolbar.untoggle_tape()
	toolbar.show(false)
	base.panel_bullseye.show(false)
	base.panel_roles.show(false)
	base.panel_units_list.show(false)
	base.panel_aircraft.show(false)
	base.panel_summary.show(false)
	base.panel_triggered_actions.show(false)
	base.panel_targeting.show(false)
    base.panel_paramFM.show(false)
	base.panel_radio.show(false)
	base.panel_route.show(false)
	base.panel_suppliers.show(false)
	base.panel_wpt_properties.show(false)
	base.panel_loadout.show(false)
    base.panel_wagons.show(false)
	base.panel_payload.show(false)
    pPayload_vehicles.show(false)
	base.panel_ship.show(false)
	base.panel_vehicle.show(false)
	base.panel_static.show(false)
	base.panel_goal.showGoals(false)
	MissionOptionsView.hide()
	base.panel_openfile.show(false)
	panel_campaign.show(false)
	base.panel_briefing.show(false)
	base.panel_debriefing.show(false)
	base.panel_failures.show(false)
	panel_dataCartridge.show(false)
	base.panel_weather.show(false)
	OptionsDialog.hide()
	panel_about.show(false)
	panel_record_avi.hide()
	base.panel_template.show(false)
	NavigationPointController.hidePanel()
	AirdromeController.hideWarehousePanel()
    MapController.onToolbarTriggerZone(false)
	MapController.onToolbarTriggerZoneList(false)
    MapController.onToolbarMapOptions(false)
	NodesManager.show(false)
	TemplatesManager.show(false)
	panelContextMenu.show(false)
	coords_info.show(false)
	panelBeaconsInfo.show(false)
	panel_backup.show(false)
	flightPlans.show(false)
	show(false)
	
	if base.test_dyn_missions == true then		
		base.rts.closeAll()
	end
end
 
function onNew()
	toolbar.newMission()
end

function onOpen()
	toolbar.openMission()
end

function onSave()
	if MapWindow.isEmptyME() ~= true then
		toolbar.saveMission()
	end
end

function onOpenBackup()
	base.toolbar.untoggle_all_except()
	MapWindow.unselectAll()
	panelContextMenu.show(false)
	coords_info.show(false)
	flightPlans.show(false)
	panel_backup.show(true)
end

function onUnitSys()
	local menu = menuBar.view.menu
	if menu.mrMetric:getState() == true then
		optionsEditor.setOption("difficulty.units", "metric")
		OptionsData.setDifficulty("units", "metric")
	elseif menu.mrImperial:getState() == true then
		optionsEditor.setOption("difficulty.units", "imperial")
		OptionsData.setDifficulty("units", "imperial")
	end
	toolbar.untoggle_all_except()
	statusbar.updateOptions()
end

function onIconsTheme()
	local menu = menuBar.view.menu
	
	if menu.mrNato:getState() == true then
		optionsEditor.setOption('difficulty.iconsTheme', 'nato')
		OptionsData.setDifficulty('iconsTheme', 'nato')
	elseif menu.mrRussia:getState() == true then
		optionsEditor.setOption('difficulty.iconsTheme', 'russian')
		OptionsData.setDifficulty('iconsTheme', 'russian')
	end
	
	MapWindow.onIconsThemeChange()
end

function onSetPosition()
	setCoordPanel.show(not setCoordPanel:getVisible())
end

function onLogbook()
	toolbar.untoggle_all_except()
    hideME()
	base.panel_logbook.show(true, 'editor')
end

function onBeaconsInfo()
	panelBeaconsInfo.show(true)
end

function onCoordsInfo()
	if MapWindow.isEmptyME() ~= true then
		coords_info.show(true)
	end
end

function onSaveAs()
	toolbar.untoggle_all_except()
	toolbar.saveMissionFileDialog()
end

function onManagerResource()
	base.panel_manager_resource.show(true)
end

function onAddAirplane()
	toolbar.addAirplane()
end

function onAddHelicopter()
	toolbar.addHelicopter()
end

function onAdd()
	toolbar.addVehicle()
end

function onNodes()
	NodesManager.show(true)
	panelContextMenu.show(false)
	coords_info.show(false)
	flightPlans.show(false)
end

function onGeneratorTemplates()
	TemplatesManager.show(true)
	panelContextMenu.show(false)
	coords_info.show(false)
	flightPlans.show(false)
end

function onGeneratorDialog()
	toolbar.untoggle_all_except()
    hideME()
	panel_generator.show(true, 'editor')
end

function onAddShip()
	toolbar.addShip()
end

function onAddVehicle()
	toolbar.addVehicle()
end

function onAddStatic()
	toolbar.addStatic()
end

function onAddTemplate()
	toolbar.addTemplate()
end

function onSaveStaticTemplate()
	staticTemplateSave.show(true)
--	staticTemplate.save()
	panelContextMenu.show(false)
	coords_info.show(false)
	flightPlans.show(false)
end

function onLoadStaticTemplate()
	--staticTemplate.load()
	staticTemplateLoad.show(true)
	panelContextMenu.show(false)
	coords_info.show(false)
	flightPlans.show(false)
end

function onCenterOnPlayer()
	MapWindow.focusPlayer()
end

function onRemove()
	if MapWindow.isMouseDown() == true then
		return
	end
	
	MapController.onToolbarDelete()
	
	panelSelectUnit.show(false)

	local groups = MapWindow.getSelectedGroups()
	
	if MapWindow.selectedGroup == nil 
		or groups[MapWindow.selectedGroup.groupId] ~= nil then	
		for k, groupId in base.pairs(groups) do
			local group = base.module_mission.group_by_id[groupId]
			if group then
				MapWindow.setState(MapWindow.getPanState())
				MapWindow.selectedGroup = nil
				base.panel_units_list.saveSelection()
				base.module_mission.remove_group(group)
				
				if base.panel_units_list.window:isVisible() then		
					base.panel_units_list.selectNextGroup()
				else
					toolbar.untoggle_all_except()
					toolbar.untoggleButtons()
				end
			end
		end
	elseif MapWindow.selectedGroup and MapWindow.selectedGroup.groupId then
		MapWindow.setState(MapWindow.getPanState())		
		base.panel_units_list.saveSelection()
		base.module_mission.remove_group(MapWindow.selectedGroup)
		MapWindow.selectedGroup = nil
		
		if base.panel_units_list.window:isVisible() then		
			base.panel_units_list.selectNextGroup()
		else
			toolbar.untoggle_all_except()
		end
	end
end

function onSelect()
	MapWindow.setState(MapWindow.getPanState())
end

function onFly(flight_type)
	if MapWindow.isEmptyME() == true then
		return
	end
	
	toolbar.untoggle_all_except()	
	toolbar.untoggle_tape()
	toolbar.untoggleButtons()
	coords_info.show(false)
	flightPlans.show(false)
	panel_backup.show(false)
	MapController.onFly()
	
	function showSavePrompt()
		local handler = MsgWindow.question(cdata.saveCahnges, cdata.question, cdata.yes, cdata.no, cdata.cancel)
		
		function handler:onChange(button)
            handler:hide()
			if button == cdata.yes then                
				toolbar.saveMission()
                Run(flight_type)
			elseif button == cdata.no then
				local path = MissionModule.getTempMissionPath()					
                
				if MissionModule.save_mission(path, false) then
					--MissionModule.mission.path = path
                    handler:close()
					Run(flight_type)
				end
			end
		end
		
		handler:show()
	end 
		
	if MissionModule.isSignedMission() ~= true and (MissionModule.isMissionModified() or not MissionModule.getMissionPathIsSaved()) then
		showSavePrompt()
    else
        Run(flight_type)
	end
end

function setEnabledSave(a_enable)
    enabledSave = a_enable 
    updateEnabledButtons()    
end

function updateEnabledButtons()
	if menuBar then
		if MapWindow.isEmptyME() == true then
			menuBar.file.menu.new:setEnabled(false)
			menuBar.file.menu.open:setEnabled(false)
			menuBar.view:setEnabled(false)
			menuBar.edit:setEnabled(false)
			menuBar.flight:setEnabled(false)
			menuBar.file.menu.saveAs:setEnabled(false)
			menuBar.file.menu.save:setEnabled(false)
			
			menuBar.customize:setEnabled(false)
			
			menuBar.generator.menu.nodes:setEnabled(false)
			menuBar.generator.menu.templates:setEnabled(false)
			menuBar.generator.menu.save:setEnabled(false)			
		else
			menuBar.file.menu.new:setEnabled(true)
			menuBar.file.menu.open:setEnabled(true)
			menuBar.view:setEnabled(true)
			menuBar.edit:setEnabled(true)
			menuBar.flight:setEnabled(true)
			menuBar.file.menu.saveAs:setEnabled(enabledSave)
			menuBar.file.menu.save:setEnabled(enabledSave)
			
			menuBar.customize:setEnabled(true)
			
			menuBar.generator.menu.nodes:setEnabled(true)
			menuBar.generator.menu.templates:setEnabled(true)
			menuBar.generator.menu.save:setEnabled(true)
		end
	end
	
    
end

function Run(flight_type)
	AutoBriefingModule.returnToME = true
	AutoBriefingModule.fly = flight_type or '--mission'
	
	if '--prepare' == flight_type then 
		local path = MissionModule.mission.path or base.tempDataDir .. base.tempMissionName
		show(false)
		waitScreen.setUpdateFunction(function()
			if (MissionModule.play({ file = path, command = flight_type}, 'prepare', MissionModule.mission.path) == false) then
				show(true)
			end
		end)
	else
		base.panel_autobriefing.setDoSave(true)
		AutoBriefingModule.show(true, 'editor')
	end	
end 


function onNetworkTraining()
    MapWindow.unselectAll()	
    toolbar.untoggle_all_except()
	MapController.onExit()
    hideME()
    panel_server_list.show(true)
end

function onShowReplays()

	local handler = MsgWindow.question(cdata.saveCahnges, cdata.question, cdata.yes, cdata.no, cdata.cancel)
    
    function openReplays()
		toolbar.untoggle_all_except()
		hideME()
		
        MapWindow.selectedGroup = nil
        MissionModule.create_new_mission()							

		MapController.onExit()
            
        waitScreen.setUpdateFunction(function()
			base.panel_openfile.show(true, 'editor', true)        
        end)
    end
		
    function handler:onChange(button)
        if button == cdata.yes then                
            toolbar.saveMissionFileDialog()
        end
        
        if button ~= cdata.cancel then                
            openReplays()
        end
    end
	
    if enabledSave == true then    
        handler:show()
    else
        openReplays()
    end    
end

function onStartServer()
	toolbar.untoggle_all_except()	
	toolbar.untoggle_tape()
	toolbar.untoggleButtons()
	coords_info.show(false)
	flightPlans.show(false)
	panel_backup.show(false)
   
	function showSavePrompt()
		local handler = MsgWindow.question(cdata.saveCahnges, cdata.question, cdata.yes, cdata.no, cdata.cancel)
		
		function handler:onChange(button)
            handler:hide()
			if button == cdata.yes then                
				toolbar.saveMission()
				local path = MissionModule.mission.path or base.tempDataDir .. base.tempMissionName
                hideME()
				MapController.onExit()
				Create_server.show(true, "editor", path)
			elseif button == cdata.no then
				local path = MissionModule.getTempMissionPath()					
                
				if MissionModule.save_mission(path, false) then
					--MissionModule.mission.path = path
                    handler:close()
					hideME()
					MapController.onExit()
					Create_server.show(true, "editor", path)
				end
			end
		end
		
		handler:show()
	end 
		
	if MissionModule.isSignedMission() ~= true and (MissionModule.isMissionModified() or not MissionModule.getMissionPathIsSaved()) then
		showSavePrompt()
    else
		hideME()
		MapController.onExit()
		local path = MissionModule.mission.path or base.tempDataDir .. base.tempMissionName
        Create_server.show(true, "editor", path)
	end

end

function onFlightPlans()
	flightPlans.show(true)
end
	
function onRecordAVI()
	toolbar.untoggle_all_except()
	panel_record_avi.show()
	panelContextMenu.show(false)
	coords_info.show(false)
	flightPlans.show(false)
end

function onOptions()
	toolbar.untoggle_all_except()
	MissionOptionsView.show()
end

function onGlobalOptions()
	local listener = {
		onOk = function()
			if 	OptionsDialog.getScreenSettingsChanged() or 
				OptionsDialog.getEnableVRChanged() then	
				
				if MapWindow.isEmptyME() ~= true and MissionModule.isSignedMission() ~= true and MissionModule.isMissionModified() then
					local result = showOnExitSavePrompt(cdata.yes, cdata.no, cdata.cancel)
					
					if result == cdata.yes then
						toolbar.saveMission(true)
						base.restartME()
					elseif result == cdata.no then
						base.restartME()
					end
				else		
					base.restartME()
				end
				
                return
			end

			if OptionsDialog.getIconsThemeChanged() then
				MapWindow.onIconsThemeChange()
			end
			
			if 	OptionsDialog.getCoordSettingsChanged() or 
				OptionsDialog.getUnitsSettingsChanged() or
				OptionsDialog.getDatumChanged() then
				
				statusbar.updateOptions()
			end
			
			panel_backup.reset()
			show(true) 
		end,
		
		onCancel = function()
			show(true) 
		end,
		
		onSoundSetting = function(name, value)
			if name == 'music' then
				music.setMusicVolume(value)
			elseif name == 'gui' then
				music.setEffectsVolume(value)
			elseif (name == 'voice_chat' or 
					name == 'voice_chat_output' or 
					name == 'voice_chat_input') then
				sound.updateVoiceChatSettings{ [name] = value }					
			end
			sound.updateSettings{ [name] = value }
		end,
		
		setWallpaper = function()  end,
	}
	
	waitScreen.setUpdateFunction(function()
		toolbar.untoggle_all_except()
		OptionsDialog.show(listener)
	end)
end

function onChange_tbShowEngAreas(self)
	MeSettings.setShowEngAreas(self:getState())
	
	for k,group in base.pairs(base.module_mission.group_by_id) do
		if group.type ~= 'static' then
			for i,unit in ipairs(group.units) do 
				module_mission.updateUnitZones(unit)
			end
		end
	end
end

function onChange_tbShowDetAreas(self)
	MeSettings.setShowDetAreas(self:getState())
	
	for k,group in base.pairs(base.module_mission.group_by_id) do
		if group.type ~= 'static' then
			for i,unit in ipairs(group.units) do 
				module_mission.updateUnitZones(unit)
			end
		end
	end
end

function onChange_tbSnap(self)
	MeSettings.setSnap(self:getState())
end

function onMapOptions()
	toolbar.untoggle_all_except()
	MapLayerController.showMapLayerPanel()
end

function onLangPanel()
    toolbar.untoggle_all_except()
	MapController.triggerZoneHidePanel()
	base.langPanel.show(true)
end

function onEncyclopedia()
	toolbar.untoggle_all_except()
    hideME()
	base.panel_enc.show(true, true)
end

function onAbout()
	toolbar.untoggle_all_except()
	panel_about.show(true)
end

function onCampaign()
	toolbar.untoggle_all_except()
    hideME()

	waitScreen.setUpdateFunction(function()
		panel_campaign.show(true, 'editor')
    end)
end

function onCampaignEditor()
	toolbar.untoggle_all_except()
    hideME()
	panel_campaign_editor.show(true, 'editor')
end

function onChangeExit()
	if (base.isPlannerMission() == true) then
		Exit()
		base.setPlannerMission(false)
		base.panel_autobriefing.setDoSave(true)
		base.panel_autobriefing.show(true, base.panel_autobriefing.returnScreen)
	else            
		onExit()
	end
end		

function onLoadDynMission()
	local path = MeSettings.getRTSPath()
		
	local filters = {FileDialogFilters.rts()}
	local filename = FileDialog.open(path, filters, cdata.openDynMission)

	if filename then		
		local res = base.rts.open(filename)
	end
end

function onSaveDynMission()
	local path = MeSettings.getRTSPath()
	local filters = {FileDialogFilters.rts()}
	local filename = FileDialog.save(path, filters, cdata.saveDynMission)
	
	if filename then
		local res = base.rts.save(filename)
		MeSettings.setRTSPath(filename)
	end
	
	return filename
end

function onUploadDynMission ()
	local data = base.rts.upload()	
	
	if MapWindow.isCreated() then
		MapWindow.selectedGroup = nil
	end		
	TriggerZoneController.removeAllZones()
	
	if data and data.zones then
		for k,v in base.pairs(data.zones) do
			--v.radius = 10000
			--v.hidden = false
			--v.color[2] = 1
			
			local zoneId = TriggerZoneController.addTriggerZone(v.name, v.x, v.y, v.radius, v.properties, v.color)
		end
	end
end

function onGenerateDynMission()
	local data = {}
--	data.zones = TriggerZoneController.saveTriggerZones()
	data = module_mission.unload()
	base.U.traverseTable(data)
	base.rts.generate(data)
end

function onRtsOn()
	MapWindow.unselectAll()
    MapWindow.setState(MapWindow.getRtsState())
end

function onRtsOff()
	MapWindow.setState(MapWindow.getPanState())
end

function onRtsOpenDCM()
	toolbar.untoggle_all_except()
	--toolbar.saveMissionFileDialog()
	local path = MeSettings.getRTSPath()
		
	local filters = {FileDialogFilters.dcm()}
	local filename = FileDialog.open(path, filters, cdata.openDCM)

	if filename then	
		setFileName(base.U.extractFileName(filename))
		if MapWindow.isCreated() then
			MapWindow.selectedGroup = nil
		end		
		module_mission.removeMission()
		progressBar.setUpdateFunction(function()
			base.print('Loading DCM ', filename)
			
			local result, err, theatre = module_mission.load(filename)
			MapWindow.show(true)
		end)
		
		
		UpdateManager.add(function()
			base.rts.openDCM()
			-- удаляем себя из UpdateManager
			return true
		end)
		
		
	end
end

function onRtsSaveDCM()
	toolbar.untoggle_all_except()
	base.rts.saveDCM()
	
	local path = MeSettings.getMissionPath()
	local filters = {FileDialogFilters.dcm()}
	local filename = FileDialog.save(path, filters, cdata.saveDCM)
	
	if filename then
		local showError = true	
		
		if module_mission.save_mission_safe(filename, showError) then
			UpdateManager.add(function()				
				MapWindow.show(true)
				base.rts.openDCM()
				-- удаляем себя из UpdateManager
				return true
			end)
			
		end
	end
end


function setFileName(a_fileName)
	if  t_file then
		t_file:setText(a_fileName)
		t_file:setTooltipText(a_fileName)
	end
end

function getFileName()
	if  t_file then
	return t_file:getText()
	else
	return ""	
	end
end