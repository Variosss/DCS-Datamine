local base = _G

module('me_toolbar') -- left toolbar

local require = base.require
local print = base.print
local string = base.string
local pairs = base.pairs

local DialogLoader				= require('DialogLoader'				)
local U							= require('me_utilities'				)
local MapWindow					= require('me_map_window'				)
local MsgWindow					= require('MsgWindow'					)
local MissionModule				= require('me_mission'					)
local NodesManager				= require('me_nodes_manager'			)
local TemplatesManager			= require('me_templates_manager'		)
local mod_tabs					= require('me_tabs'						)
local FileDialog				= require('FileDialog'					)
local FileDialogFilters			= require('FileDialogFilters'			)
local MeSettings				= require('MeSettings'					)
local statusbar					= require('me_statusbar'				)
local waitScreen				= require('me_wait_screen'				)
local module_mission			= require('me_mission'					)
local lfs						= require('lfs'							)
local panel_aircraft			= require('me_aircraft'					)
local panel_summary				= require('me_summary'					)
local panel_triggered_actions	= require('me_triggered_actions'		)
local panel_targeting			= require('me_targeting'				)
local panel_route				= require('me_route'					)
local panel_loadout				= require('me_loadout'					)
local panel_payload				= require('me_payload'					)
local panel_vehicle				= require('me_vehicle'					)
local panel_ship				= require('me_ship'						)
local panel_static				= require('me_static'					)
local panel_autobriefing		= require('me_autobriefing'				)
local panel_weather				= require('me_weather'					)
local panel_briefing			= require('me_briefing'					)
local panel_failures			= require('me_failures'					)
local panel_nav_target_fix_points = require('me_nav_target_fix_points')
local panel_roles				= require('me_roles'					)
local panel_wpt_properties		= require('me_wpt_properties'			)
local panel_suppliers			= require('me_suppliers'				)
local panel_paramFM				= require('me_paramFM'					)
local panel_radio				= require('me_panelRadio'				)
local panel_template			= require('me_template'					)
local panel_units_list			= require('me_units_list'				)
local panel_bullseye			= require('me_bullseye'					)
local panel_goal				= require('me_goal'						)
local panel_trigrules			= require('me_trigrules'				)
local panel_about				= require('me_about'					)
local panel_draw				= require('me_draw_panel'				)
local menubar					= require('me_menubar'					)
local panel_manager_resource	= require('me_manager_resource'			)
local panel_record_avi			= require('record_avi'					)
local MapController				= require('Mission.MapController'		)
local CoalitionController		= require('Mission.CoalitionController'	)
local AirdromeController		= require('Mission.AirdromeController'	)
local pPayload_vehicles			= require('me_payload_vehicles'			)
local panel_wagons				= require('me_wagons'					)
local progressBar				= require('ProgressBarDialog'			)
local panel_dataCartridge		= require('me_dataCartridge'			)
local TheatreOfWarData			= require('Mission.TheatreOfWarData'	)
local panelContextMenu			= require('me_contextMenu'				)
local ProductType				= require('me_ProductType'				) 
local panel_ChangingCoalitions	= require('me_changingCoalitions'		) 
local CoalitionPanel			= require('Mission.CoalitionPanel'		)
local coords_info				= require('me_coords_info'				)
local panelBeaconsInfo			= require('me_beaconsInfo')
local managerModulesME 			= require('me_managerModulesME')
local ToggleButton				= require('ToggleButton')
local flightPlans				= require('me_flightPlans')

require('i18n').setup(_M)

local cdata = {
    file = _('FILE'),
    mis = _('MIS'),
    obj = _('OBJ'),
    map = _('MAP'),
    
    exitTooltip 			= _('Exit the editor-tooltip', 'Exit the editor'),    
    openTooltip 			= _('Open file-tooltip', 'Open file'),
    coalitionsTooltip 		= _('Coalitions-tooltip', 'Coalitions'),    
    weatherTooltip 			= _('Weather-tooltip', 'Weather'),
	rolesTooltip 			= _('Roles-tooltip', 'Roles'),
    airplaneTooltip 		= _('Airplanes-tooltip', 'Airplanes'),
    helicopterTooltip 		= _('Helicopters-tooltip', 'Helicopters'),
    shipTooltip 			= _('Ships-tooltip', 'Ships'),
    vehicleTooltip 			= _('Ground units-tooltip', 'Ground units'),
    zoneTooltip 			= _('Trigger zones-tooltip', 'Trigger zones'),
    delTooltip 				= _('Remove group/object-tooltip', 'Remove group/object'),
    mapTooltip 				= _('Map options-tooltip', 'Map options'),
    trigZonesListTooltip 	= _('Trigger zones list-tooltip', 'Trigger zones list'),
    unitListTooltip 		= _('Units list-tooltip', 'Units list'),
    trigrulesTooltip 		= _('Trigger rules-tooltip', 'Trigger rules'),
    staticTooltip 			= _('Static object-tooltip', 'Static object'),
	bullseyeTooltip 		= _('Bullseye object-tooltip', 'Bullseye object'),
	navpointTooltip 		= _('Initial Point object-tooltip', 'Initial Point object'),    
    templateTooltip 		= _('Templates-tooltip', 'Templates'),
    tapeTooltip 			= _('Ruler-tooltip', 'Ruler'),
	ChangingCoalitionsTooltip = _('Changing coalitions-tooltip', 'Changing coalitions'),
	drawTooltip				= _('Draw tool'), 

    ok = _('OK'),
	
    yes = _('YES'),
    no = _('NO'),  
    warning = _('WARNING'),
}

if ProductType.getType() == "LOFAC" then
    cdata.exitPlannerTooltip = _('Exit the mission planner-tooltip', 'Exit the mission planner-LOFAC')
    cdata.newTooltip = _('Create new mission-tooltip-LOFAC', 'Create new mission')
    cdata.openMission = _('Open mission:-LOFAC')
	cdata.saveMission = _('Save mission:-LOFAC') 
    cdata.messageNoTerrain = _('Need terrain for load this mission: -LOFAC')
    cdata.new_mission = _('CREATING NEW MISSION-LOFAC')
    cdata.new_mission_msg = _('Are you sure you want to create new mission? \nAll unsaved changes will be lost!-LOFAC')
    cdata.open_mission_msg = _('Are you sure you want to open new mission? \nAll unsaved changes will be lost!-LOFAC')
    cdata.optionsTooltip = _('Mission options-tooltip-LOFAC', 'Mission options')
    cdata.goalTooltip = _('Mission goal-tooltip-LOFAC', 'Mission goal')
    cdata.runTooltip = _('Fly mission-tooltip-LOFAC', 'Fly mission')
    cdata.briefingTooltip = _('Mission briefing-tooltip-LOFAC', 'Mission briefing')
    cdata.saveTooltip = _('Save mission file-tooltip-LOFAC', 'Save mission file')
else
    cdata.exitPlannerTooltip = _('Exit the mission planner-tooltip', 'Exit the mission planner')
    cdata.newTooltip = _('Create new mission-tooltip', 'Create new mission')
    cdata.openMission = _('Open mission:')
	cdata.saveMission = _('Save mission:')
    cdata.messageNoTerrain = _('Need terrain for load this mission: ')
    cdata.new_mission = _('CREATING NEW MISSION')
    cdata.new_mission_msg = _('Are you sure you want to create new mission? \nAll unsaved changes will be lost!')
    cdata.open_mission_msg = _('Are you sure you want to open new mission? \nAll unsaved changes will be lost!')
    cdata.optionsTooltip = _('Mission options-tooltip', 'Mission options')
    cdata.goalTooltip = _('Mission goal-tooltip', 'Mission goal')
    cdata.runTooltip = _('Fly mission-tooltip', 'Fly mission')
    cdata.briefingTooltip = _('Mission briefing-tooltip', 'Mission briefing')
    cdata.saveTooltip = _('Save mission file-tooltip', 'Save mission file')   
end


local enabledSave = true
local width = 100

local function createPanelsList()
    -- в таблицу заносим функции, которые должны быть вызваны при отключении кнопки
    panels = {
        buttonDelete = {},
        buttonRun = {},
        toggleButtonBriefing = {panel_briefing.show},
        b_failures = {panel_failures.show},
        toggleButtonWeather = {panel_weather.show},
        toggleButtonAirplane = {
                        panel_aircraft.show,
                        panel_summary.show,
						panel_triggered_actions.show,
                        panel_targeting.show,
                        panel_route.show,
                        panel_loadout.show,
                        panel_payload.show,
						panel_nav_target_fix_points.show,
        },
        toggleButtonHelicopter = {
                        panel_aircraft.show,
                        panel_loadout.show,
                        panel_summary.show,
						panel_triggered_actions.show,
                        panel_route.show,
                        panel_targeting.show,
                        panel_payload.show,
						panel_nav_target_fix_points.show,
                        },
        toggleButtonShip = {
                    panel_ship.show,
                    panel_summary.show,
					panel_triggered_actions.show,
                    panel_route.show,
                    panel_targeting.show,
					panel_suppliers.show,},
        toggleButtonVehicle = {
                        panel_vehicle.show,
                        panel_summary.show,
						panel_triggered_actions.show,
                        panel_route.show,
						pPayload_vehicles.show,
                        panel_targeting.show},
        toggleButtonRoles = {panel_roles.show},
        toggleButtonStatic = {panel_static.show},
		toggleButtonBullsEye = {panel_bullseye.show},
        toggleButtonGoal = {panel_goal.showGoals},
        b_exit = {},
        toggleButtonUnitList = {handleUnitList},
        toggleButtonTape = {
            function() 
              MapWindow.removeTapeObjects() 
            end
            },
        toggleButtonTemplate = {panel_template.show},
        toggleButtonTrigRules = {panel_trigrules.show},
        b_about = {panel_about.show},
		toggleButtonDraw = {panel_draw.show},
    }
end

function setTrigrulesButtonState(state)
	toggleButtonTrigRules:setState(state)
end

function setNewButtonState(state)
	toggleButtonNew:setState(state)
end

function setOpenButtonState(state)
	toggleButtonOpen:setState(state)
end

function setAirplaneButtonState(state)
	toggleButtonAirplane:setState(state)	
end

function setHelicopterButtonState(state)
	toggleButtonHelicopter:setState(state)	
end

function setShipButtonState(state)
	toggleButtonShip:setState(state)	
end

function setVehicleButtonState(state)
	toggleButtonVehicle:setState(state)	
end

function setStaticButtonState(state)
	toggleButtonStatic:setState(state)	
end

function setTemplateButtonState(state)
	toggleButtonTemplate:setState(state)	
end

function setBriefingButtonState(state)
	toggleButtonBriefing:setState(state)
end

function setUnitListButtonState(state)
	toggleButtonUnitList:setState(state)
end

function setWeatherButtonState(state)
	toggleButtonWeather:setState(state)
end

function createMission(a_returnScreen, a_curTerrain)
	if MapWindow.isEmptyME() ~= true and MissionModule.isSignedMission() ~= true and MissionModule.isMissionModified() then
		local handler = MsgWindow.question(cdata.new_mission_msg, cdata.new_mission, cdata.yes, cdata.no)
		local result = false
		
		function handler:onChange(buttonText)
			result = (buttonText == cdata.yes)
		end
		
		handler:show()
				
		if not result then
			return 
		end
	end
	
	
	CoalitionController.setDefaultCoalitions()
	CoalitionController.showPanel(a_returnScreen, a_curTerrain)
	if MapWindow.isEmptyME() ~= true then
		module_mission.create_new_mission(true)
	end
end

local toggleButtonCallbacks_ = {}

local function untoggleButton(button, callback, buttonToExcept)
	if button ~= buttonToExcept then
		button:setState(false)
		callback(false)
	end
end	
	
function untoggleButtons(buttonToExcept)	
	MapWindow.setState(MapWindow.getPanState())
	
	for button, callback in pairs(toggleButtonCallbacks_) do
		if button ~= buttonToExcept then
			button:setState(false)
			callback(false)
		end
	end
end	

function newMission()
	coords_info.show(false)
	flightPlans.show(false)
	toggleButtonNew:setState(true)
	toggleButtonNew:onChange()
end

function addAirplane()
	toggleButtonAirplane:setState(true)
	untoggle_all_except(toggleButtonAirplane)
	untoggleButtons(toggleButtonAirplane)
	
	if checkAircraftCoalitionCountries('plane') then
		showAirplanePanels()
		panel_aircraft.show(true)
	else
		toggleButtonAirplane:setState(false)
		hideAirplanePanels()
	end
end

function showAirplanePanels()
	panel_aircraft.setView('plane')	
	panel_aircraft.vdata.unit.number = 1
	panel_aircraft.vdata.unit.cur = 1
	MapWindow.unselectAll()
	-- Перед созданием новой группы нужно проинициализировать
	-- исходные данные в ее диалогах и обновить контролы.
	toggleButtonHelicopter:setState(false)
	statusbar.updateState()
	panel_aircraft.vdata.group = nil
	panel_route.setGroup(nil)
	panel_suppliers.setGroup(nil)
	panel_triggered_actions.setGroup(nil)
	panel_payload.vdata.group = nil
	panel_targeting.vdata.group = nil
	panel_summary.vdata.group = nil
	MapWindow.setState(MapWindow.getCreatingPlaneState())
	panel_route.show(true)
	panel_triggered_actions.show(false)
	panel_aircraft.setSafeMode(true)
	panel_route.setSafeMode(true)
end

function hideAirplanePanels()
	MapWindow.setState(MapWindow.getPanState())
	panel_summary.show(false)
    panel_paramFM.show(false)
	panel_radio.show(false)
	panel_triggered_actions.show(false)
	panel_targeting.show(false)
	panel_route.show(false)
	panel_suppliers.show(false)
	panel_wpt_properties.show(false)
	panel_loadout.show(false)
	panel_payload.show(false)
    pPayload_vehicles.show(false)
	panel_dataCartridge.show(false)
end

function checkAircraftCoalitionCountries(a_typePanel)
	panel_aircraft.setView(a_typePanel)
	return panel_aircraft.updateCountries() ~= false
end

function addHelicopter()
	toggleButtonHelicopter:setState(true)
	untoggle_all_except(toggleButtonHelicopter)
	untoggleButtons(toggleButtonHelicopter)
	
	if checkAircraftCoalitionCountries('helicopter') then
		showHelicopterPanels()
		panel_aircraft.show(true)
	else
		toggleButtonHelicopter:setState(false)
		hideHelicopterPanels()
	end
end

function showHelicopterPanels()
	MapWindow.unselectAll()
	panel_aircraft.setView('helicopter')
	panel_aircraft.vdata.unit.number = 1
	panel_aircraft.vdata.unit.cur = 1
	-- Перед созданием новой группы нужно проинициализировать
	-- исходные данные в ее диалогах и обновить контролы.
	toggleButtonAirplane:setState(false)
	MapWindow.unselectAll()
	statusbar.updateState()		
	panel_aircraft.vdata.group = nil
	panel_route.setGroup(nil)
	panel_suppliers.setGroup(nil)
	panel_triggered_actions.setGroup(nil)
	panel_payload.vdata.group = nil
	panel_targeting.vdata.group = nil
	panel_summary.vdata.group = nil
	MapWindow.setState(MapWindow.getCreatingHelicopterState())
	panel_route.show(true)
	panel_triggered_actions.show(false)
	panel_aircraft.setSafeMode(true)
	panel_route.setSafeMode(true)
end

function hideHelicopterPanels()
    panel_paramFM.show(false)
	panel_radio.show(false)
	panel_summary.show(false)
	panel_triggered_actions.show(false)
	panel_targeting.show(false)
	panel_route.show(false)
	panel_suppliers.show(false)
	panel_wpt_properties.show(false)
	panel_loadout.show(false)
	panel_payload.show(false)
    pPayload_vehicles.show(false)
	panel_dataCartridge.show(false)
end

function checkVehicleCoalitionCountries()
	return panel_vehicle.updateCountries() ~= false
end

function addVehicle()
	toggleButtonVehicle:setState(true)
	untoggle_all_except(toggleButtonVehicle)
	untoggleButtons(toggleButtonVehicle)
	
	if checkVehicleCoalitionCountries() then
		showVehiclePanels()
		panel_vehicle.show(true)
	else
		toggleButtonVehicle:setState(false)
	end
end

function showVehiclePanels()
	MapWindow.unselectAll()
	panel_vehicle._tabs:selectTab('route')
	panel_aircraft.vdata.unit.number = 1
	panel_aircraft.vdata.unit.cur = 1
	-- Перед созданием новой группы нужно проинициализировать
	-- исходные данные в ее диалогах и обновить контролы.
	panel_vehicle.vdata.group = nil
	panel_route.setGroup(nil)
	panel_suppliers.setGroup(nil)
	panel_triggered_actions.setGroup(nil)
	panel_targeting.vdata.group = nil
	panel_summary.vdata.group = nil
	MapWindow.setState(MapWindow.getCreatingVehicleState())
	panel_route.show(true)
	panel_vehicle.setSafeMode(true)
	panel_route.setSafeMode(true)
end

function hideVehiclePanels()
    panel_paramFM.show(false)
	panel_radio.show(false)
	panel_route.show(false)
	panel_suppliers.show(false)
	panel_wpt_properties.show(false)
	panel_summary.show(false)
	panel_triggered_actions.show(false)
	panel_targeting.show(false)
	panel_dataCartridge.show(false)
end

function checkShipCoalitionCountries()
	return panel_ship.updateCountries() ~= false
end

function addShip()
	toggleButtonShip:setState(true)
	untoggle_all_except(toggleButtonShip)
	untoggleButtons(toggleButtonShip)
	
	if checkShipCoalitionCountries() then
		showShipPanels()
		panel_ship.show(true)
	else
		toggleButtonVehicle:setState(false)
	end
end

function showShipPanels()
	MapWindow.unselectAll()
	panel_ship._tabs:selectTab('route')
	panel_aircraft.vdata.unit.number = 1
	panel_aircraft.vdata.unit.cur = 1
	-- Перед созданием новой группы нужно проинициализировать
	-- исходные данные в ее диалогах и обновить контролы.
	panel_ship.vdata.group = nil
	panel_route.setGroup(nil)
	panel_suppliers.setGroup(nil)
	panel_triggered_actions.setGroup(nil)
	panel_targeting.vdata.group = nil
	panel_summary.vdata.group = nil
	MapWindow.setState(MapWindow.getCreatingShipState())
	panel_route.show(true)
	panel_triggered_actions.show(false)
	panel_ship.setSafeMode(true)
	panel_route.setSafeMode(true)
	panelContextMenu.show(false)
end

function hideShipPanels()
    panel_paramFM.show(false)
	panel_radio.show(false)
	panel_route.show(false)
	panel_suppliers.show(false)
	panel_wpt_properties.show(false)
	panel_summary.show(false)
	panel_triggered_actions.show(false)
	panel_targeting.show(false)
end

function checkStaticCoalitionCountries()
	return panel_static.updateCountries() ~= false
end

function addStatic()
	toggleButtonStatic:setState(true)
	untoggle_all_except(toggleButtonStatic)
	untoggleButtons(toggleButtonStatic)
	
	if checkStaticCoalitionCountries() then
		showStaticPanels()
		panel_static.show(true)
	end
end

function showStaticPanels()
	MapWindow.unselectAll()
	-- Перед созданием новой группы нужно проинициализировать
	-- исходные данные в ее диалогах и обновить контролы.
	panel_static.vdata.group = nil
	MapWindow.setState(MapWindow.getCreatingStaticState())
	panel_static.setSafeMode(true)
	panelContextMenu.show(false)
end

function addTemplate()
	toggleButtonTemplate:setState(true)
	untoggle_all_except(toggleButtonTemplate)
	untoggleButtons(toggleButtonTemplate)
	MapWindow.setState(MapWindow.getCreatingTemplateState())
    panel_template.show(true)
	panelContextMenu.show(false)
	coords_info.show(false)
	flightPlans.show(false)
end

function registerToggleButtonCallback(button, callback)
	toggleButtonCallbacks_[button] = callback
	
	function button:onChange()
		untoggleButtons(self)
		untoggle_all_except()
		
		toggleButtonCallbacks_[self](self:getState())
	end
end

local function registerToggleButtonCallbacks()
	registerToggleButtonCallback(toggleButtonZone,				MapController.onToolbarTriggerZone)
	registerToggleButtonCallback(toggleButtonTrigZonesList, 	MapController.onToolbarTriggerZoneList)
	registerToggleButtonCallback(toggleButtonNavPoint, 			MapController.onToolbarNavigationPoint)
	registerToggleButtonCallback(toggleButtonMap, 				MapController.onToolbarMapOptions)
	registerToggleButtonCallback(toggleButtonMissionOptions, 	MapController.onToolbarMissionOptions)
end

function setEnabledSave(a_enable)
    enabledSave = a_enable 
    updateEnabledButtons()
end

function loadMission(filename)
	menubar.setFileName(U.extractFileName(filename))
	if MapWindow.isCreated() then
		MapWindow.selectedGroup = nil
	end		
	module_mission.removeMission()
	progressBar.setUpdateFunction(function()
		
		print('Loading mission ', filename)

		local result, err, errMsg = module_mission.load(filename)
		--print("----result=",result, err, errMsg)
		
		if result == false and err == "no terrain" then
			MsgWindow.warning(cdata.messageNoTerrain..errMsg, cdata.warning, cdata.ok):show()			
		end
		
		if result == false and err == "no threats" then
			MsgWindow.warning(errMsg, cdata.warning, cdata.ok):show()
		end
		
		if base.isInitTerrain() == true then
			if result == false then
				module_mission.create_new_mission()
			end
			
			MapWindow.show(true)
			MeSettings.setMissionPath(filename)
		end
	end)
end

function create(x, y, w, h)
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_toolbar.dlg', cdata)
	local panel = window.panel
	height = h
	
    window:setBounds(x, y, w, h)
	panel:setBounds(0, 0, w, h)
	
	pModME = window.pModME
	pModME:setSize(0,0)
	btnSkin = window.panel.toggleButtonNew:getSkin()
	
	pMap = window.pMap
	
    toggleButtonNew = panel.toggleButtonNew
    toggleButtonOpen = panel.toggleButtonOpen
    toggleButtonSave = panel.toggleButtonSave
    staticMission = panel.staticMission
    toggleButtonBriefing = panel.toggleButtonBriefing
    toggleButtonWeather = panel.toggleButtonWeather
    toggleButtonTrigRules = panel.toggleButtonTrigRules
    toggleButtonGoal = panel.toggleButtonGoal
    toggleButtonRoles = panel.toggleButtonRoles
    toggleButtonMissionOptions = panel.toggleButtonOptions
	toggleButtonChangingCoalitions = panel.toggleButtonChangingCoalitions
    buttonRun = panel.buttonRun
    staticObjects = panel.staticObjects
    toggleButtonAirplane = panel.toggleButtonAirplane
    toggleButtonHelicopter = panel.toggleButtonHelicopter
    toggleButtonShip = panel.toggleButtonShip
    toggleButtonVehicle = panel.toggleButtonVehicle
    toggleButtonStatic = panel.toggleButtonStatic
    toggleButtonNavPoint = panel.toggleButtonNavPoint
    toggleButtonBullsEye = panel.toggleButtonBullsEye
    toggleButtonZone = panel.toggleButtonZone
    toggleButtonTemplate = panel.toggleButtonTemplate
    toggleButtonTrigZonesList = panel.toggleButtonTrigZonesList
    toggleButtonUnitList = panel.toggleButtonUnitList
    buttonDelete = panel.buttonDelete
    staticMap = panel.staticMap
    toggleButtonMap = pMap.toggleButtonMap
    toggleButtonTape = pMap.toggleButtonTape
    toggleButtonDraw = pMap.toggleButtonDraw
    b_exit = panel.b_exit	
	
	for k,modul in base.pairs(managerModulesME.modulesME) do
		if modul.addBtnToolbar ~= nil then
			local offsetH = 0
			for kk, vv in base.pairs(modul.addBtnToolbar) do 
				local btn = ToggleButton.new()
				btn:setBounds(3, offsetH, 44, 18)
				btn:setSkin(vv.skin)
				registerToggleButtonCallback(btn, modul[vv.callback])
									
				pModME:insertWidget(btn)
				offsetH = offsetH + 23
				pModME:setSize(56,offsetH)				
			end
		end
	end
	
	width = w
	local nw,nh = pModME:getSize()
	
	if (h-nh) < 700 then
		window:setBounds(x, y, w*2, h)
		panel:setBounds(0, 0, w*2, h)
		pMap:setPosition(50,0)
		width = w*2
		pModME:setPosition(50,93)
	else
		pMap:setPosition(0,603)
		pModME:setPosition(0,693)
	end
	
	b_exit:setPosition(0, h-40)
	
	createPanelsList()
	registerToggleButtonCallbacks()

    function b_exit:onChange()        
		if (base.isPlannerMission() == true) then
			menubar.Exit()
            base.setPlannerMission(false)
			panel_autobriefing.setDoSave(true)
			panel_autobriefing.show(true, panel_autobriefing.returnScreen)
		else            
			menubar.onExit()
		end
    end
-- toggle buttons

	function saveMissionFileDialog(a_bNoSaveTmp)
		panelContextMenu.show(false)
		coords_info.show(false)
		flightPlans.show(false)
		local path = MeSettings.getMissionPath()
		local filters = {FileDialogFilters.mission(), FileDialogFilters.track()}
		local filename = FileDialog.save(path, filters, cdata.saveMission)
        
		if filename then
			local showError = true	
			
			if module_mission.save_mission_safe(filename, showError) then
				MeSettings.setMissionPath(filename)
				MapWindow.show(true)
			end
        else
            if a_bNoSaveTmp ~= true then
                MissionModule.save_mission(MissionModule.getTempMissionPath(), false)
				MapWindow.show(true)
            end    
		end
		
		return filename
	end
    
	function saveMission(a_bNoSaveTmp)
		local result = true
		
		toggleButtonSave:setState(true)
		MapWindow.unselectAll()
		untoggle_all_except(self)
		untoggle_tape()
		untoggleButtons(self)
		flightPlans.show(false)
		
		MapWindow.updateMissionMapCenter()
		
		MapController.onToolbarSave()
		
		local missionPath = module_mission.mission.path
		
		if module_mission.getMissionPathIsSaved() then
			local showError = true
			
			module_mission.save_mission_safe(missionPath, showError)
			MapWindow.show(true)
		else
			result = (nil ~= saveMissionFileDialog(a_bNoSaveTmp))
		end
				
		toggleButtonSave:setState(false)
		
		return result
	end
	
	function toggleButtonSave:onChange()
		coords_info.show(false)
        saveMission() 
	end 
  
	function openMissionFileDialog()
		panelContextMenu.show(false)
		coords_info.show(false)
		flightPlans.show(false)
		local path = MeSettings.getMissionPath()
		
		local filters = {FileDialogFilters.mission(), FileDialogFilters.track()}
		local filename = FileDialog.open(path, filters, cdata.openMission)

		if filename then
			loadMission(filename)
		end
	end
	
	
  
	local function saveModifiedMission()
		panelContextMenu.show(false)
		coords_info.show(false)
		flightPlans.show(false)
		setButtonsEnabled(nil, false)
		local handler = MsgWindow.question(cdata.open_mission_msg, cdata.new_mission, cdata.yes, cdata.no)
		local result = false
			
		function handler:onChange(buttonText)
			result = (buttonText == cdata.yes)
			if result then
				openMissionFileDialog()
			else
				toggleButtonOpen:setState(false)
			end
								
			setButtonsEnabled(nil, true)
		end
		
		handler:show()
		
		if not result then -- закрыто крестиком
			toggleButtonOpen:setState(false)
			setButtonsEnabled(nil, true)
			return 
		end
	end
  
	function openMission()
		panelContextMenu.show(false)
		coords_info.show(false)
		flightPlans.show(false)
		toggleButtonOpen:setState(true)
		toggleButtonOpen:onChange()
	end
  
	function toggleButtonOpen:onChange()
		untoggle_all_except(self)
		untoggle_tape()
		untoggleButtons(self)

		MapWindow.unselectAll()
		MapController.onToolbarOpen()
		
		if MapWindow.isEmptyME() ~= true and MissionModule.isSignedMission() ~= true and MissionModule.isMissionModified() then
			saveModifiedMission()
		else
			openMissionFileDialog()
		end
		
		self:setState(false)        
	end
  
  function toggleButtonNew:onChange()
       	untoggle_all_except(self)
		untoggle_tape()
		untoggleButtons(self)
		MapWindow.unselectAll()
		panelContextMenu.show(false)
		coords_info.show(false)
		flightPlans.show(false)
		
		createMission("MissionEditor", TheatreOfWarData.getName())
		
		self:setState(false)
  end
  
	function toggleButtonChangingCoalitions:onChange()
       	untoggle_all_except(self)
		untoggle_tape()
		untoggleButtons(self)
		MapWindow.unselectAll()
		panelContextMenu.show(false)
		coords_info.show(false)
		flightPlans.show(false)
		
		panel_ChangingCoalitions.show(true)
		
		self:setState(false)
  end
  function buttonDelete:onChange()
    menubar.onRemove()
	panelContextMenu.show(false)
  end
  
  function buttonRun:onChange()	
	self:setFocused(false)
	untoggleButtons()
	panelContextMenu.show(false)
    menubar.onFly()
  end
  
  function toggleButtonBriefing:onChange()
    untoggle_all_except(self)
	untoggleButtons(self)
    panel_briefing.show(self:getState())
	panelContextMenu.show(false)	
  end

  function toggleButtonWeather:onChange()
    untoggle_all_except(self)
	untoggleButtons(self)
    panel_weather.show(self:getState())
    if self:getState() then
        MapWindow.unselectAll()
    end
	panelContextMenu.show(false)
  end
  
	function toggleButtonTrigRules:onChange()
		untoggle_all_except(self)
		untoggleButtons(self)
		panel_trigrules.show(self:getState())
		panelContextMenu.show(false)
		coords_info.show(false)
		flightPlans.show(false)
	end

	function toggleButtonVehicle:onChange()
		untoggle_all_except(self)
		untoggleButtons(self)
		
		if self:getState() then
			if checkVehicleCoalitionCountries() then
				showVehiclePanels()
			else
				self:setState(false)
			end
		else
			hideVehiclePanels()
		end
		
		panel_vehicle.show(self:getState())
		panelContextMenu.show(false)
	end

	function toggleButtonStatic:onChange()
		untoggle_all_except(self)
		untoggleButtons(self)

		if self:getState() then
			if checkStaticCoalitionCountries() then
				showStaticPanels()
			else
				self:setState(false)
			end	
		end
		
		panel_static.show(self:getState())
		panelContextMenu.show(false)
	end

  function toggleButtonBullsEye:onChange()
      untoggle_all_except(self)
	  untoggleButtons(self)

      if self:getState() then
        MapWindow.unselectAll()
      end
      panel_bullseye.show(self:getState())
	  panelContextMenu.show(false)
  end

  function toggleButtonGoal:onChange()
      untoggle_all_except(self)
	  untoggleButtons(self)
	  panel_goal.showGoals(self:getState())
	  panelContextMenu.show(false)
  end

  if toggleButtonRoles then
    function toggleButtonRoles:onChange()
        untoggle_all_except(self)
		untoggleButtons(self)
        panel_roles.show(self:getState())
		panelContextMenu.show(false)
    end
  end

  function toggleButtonTemplate:onChange()
    untoggle_all_except(self)
	untoggleButtons(self)
    if self:getState() then
      MapWindow.setState(MapWindow.getCreatingTemplateState())
    end
    panel_template.show(self:getState())
	panelContextMenu.show(false)
  end
  
	function toggleButtonShip:onChange()
		untoggle_all_except(self)
		untoggleButtons(self)

		if self:getState() then
			if checkShipCoalitionCountries() then
				showShipPanels()
			else
				self:setState(false)
			end
		else
			hideShipPanels()
		end
		
		panel_ship.show(self:getState())
		panelContextMenu.show(false)
	end

	function toggleButtonHelicopter:onChange()
		untoggle_all_except(self)
		untoggleButtons(self)

		if self:getState() then
			if checkAircraftCoalitionCountries('helicopter') then
				showHelicopterPanels()
			else
				self:setState(false)
				hideHelicopterPanels()
			end
		else
			hideHelicopterPanels()
		end
		
		panel_aircraft.show(self:getState())
		panelContextMenu.show(false)
	end

	function toggleButtonAirplane:onChange()		
		untoggle_all_except(self)
		untoggleButtons(self)
		
		if self:getState() then
			if checkAircraftCoalitionCountries('plane') then
				showAirplanePanels()
			else
				self:setState(false)
				hideAirplanePanels()
			end
		else
			hideAirplanePanels()
		end
		
		panel_aircraft.show(self:getState())
		panelContextMenu.show(false)
  end
  function toggleButtonTape:onChange()
      untoggle_all_except(self)
	  untoggleButtons(self)
    if self:getState() then
          base.selected_mode_button = self
        MapWindow.setState(MapWindow.getTapeState())
      else
        MapWindow.removeTapeObjects()
        MapWindow.setState(MapWindow.getPanState())
    end
	panelContextMenu.show(false)
	coords_info.show(false)
	flightPlans.show(false)
  end

  function toggleButtonUnitList:onChange()
    untoggle_all_except(self)
	untoggleButtons(self)
    if self:getState() then
        panel_units_list.show(true)
      else
        panel_units_list.show(false)
    end
	
	panelContextMenu.show(false)
  end
  
	function toggleButtonDraw:onChange()
		untoggle_all_except(self)
		untoggleButtons(self)

		if self:getState() then
			panel_draw.show(true)
			MapWindow.setState(MapWindow.getDrawState())
		else
			panel_draw.show(false)
			MapWindow.setState(MapWindow.getPanState())		
		end
	end

	setupKeyboard()
end

function setPlannerMission(planner_mission)
	if (planner_mission == true) then
		toggleButtonNew:setVisible(false)
		toggleButtonOpen:setVisible(false)
		toggleButtonSave:setVisible(false)
		buttonDelete:setVisible(false)
		buttonRun:setVisible(false)
		--toggleButtonBriefing:setVisible(false)
		toggleButtonWeather:setVisible(false)
		toggleButtonAirplane:setVisible(false)
		toggleButtonHelicopter:setVisible(false)
		toggleButtonShip:setVisible(false)
		toggleButtonVehicle:setVisible(false)
		toggleButtonStatic:setVisible(false)
       -- b_warehouse:setVisible(false)
		toggleButtonGoal:setVisible(false)
		toggleButtonZone:setVisible(false)
		toggleButtonTemplate:setVisible(false)
	   -- b_exit:setVisible(false)
		--toggleButtonMap:setVisible(false)
		toggleButtonTrigZonesList:setVisible(false)
		toggleButtonUnitList:setVisible(false)
		--toggleButtonTape:setVisible(false)
		toggleButtonTemplate:setVisible(false)
		toggleButtonTrigRules:setVisible(false)
		toggleButtonMissionOptions:setVisible(false)
		if toggleButtonRoles then toggleButtonRoles:setVisible(false) end
		toggleButtonBullsEye:setVisible(false)
		toggleButtonNavPoint:setVisible(false)
		staticMission:setVisible(false)
		staticObjects:setVisible(false)
        b_exit:setTooltipText(cdata.exitPlannerTooltip)
		toggleButtonChangingCoalitions:setVisible(false)
		toggleButtonDraw:setVisible(false)
	else
		toggleButtonNew:setVisible(true)
		toggleButtonOpen:setVisible(true)
		toggleButtonSave:setVisible(true)
		buttonDelete:setVisible(true)
		buttonRun:setVisible(true)
		--toggleButtonBriefing:setVisible(true)
		toggleButtonWeather:setVisible(true)
		toggleButtonAirplane:setVisible(true)
		toggleButtonHelicopter:setVisible(true)
		toggleButtonShip:setVisible(true)
		toggleButtonVehicle:setVisible(true)
		toggleButtonStatic:setVisible(true)
      --  b_warehouse:setVisible(true)
		toggleButtonGoal:setVisible(true)
		toggleButtonZone:setVisible(true)
		toggleButtonTemplate:setVisible(true)
	   -- b_exit:setVisible(true)
		--toggleButtonMap:setVisible(true)
		toggleButtonTrigZonesList:setVisible(true)
		toggleButtonUnitList:setVisible(true)
		--toggleButtonTape:setVisible(true)
		toggleButtonTemplate:setVisible(true)
		toggleButtonTrigRules:setVisible(true)
		toggleButtonMissionOptions:setVisible(true)
		if toggleButtonRoles then toggleButtonRoles:setVisible(true) end
		toggleButtonBullsEye:setVisible(true)
		toggleButtonNavPoint:setVisible(true)
		staticObjects:setVisible(true)
        b_exit:setTooltipText(cdata.exitTooltip)
		toggleButtonChangingCoalitions:setVisible(base.__PRODUCT_ID__ ~= 2)		
		toggleButtonDraw:setVisible(true)
	end
end

function show(b)
	
	updateEnabledButtons()

	setPlannerMission(base.isPlannerMission())
	window:setVisible(b)
    updateEnabledButtons()
end

function updateEnabledButtons()
	if MapWindow.isEmptyME() == true then	
		pMap:setEnabled(false)
		toggleButtonNew:setEnabled(false)
		toggleButtonOpen:setEnabled(false)
		toggleButtonSave:setEnabled(false)
		buttonDelete:setEnabled(false)
		buttonRun:setEnabled(false)
		toggleButtonBriefing:setEnabled(false)
		toggleButtonWeather:setEnabled(false)
		toggleButtonAirplane:setEnabled(false)
		toggleButtonHelicopter:setEnabled(false)
		toggleButtonShip:setEnabled(false)
		toggleButtonVehicle:setEnabled(false)
		toggleButtonStatic:setEnabled(false)
		toggleButtonGoal:setEnabled(false)
		toggleButtonZone:setEnabled(false)
		toggleButtonTemplate:setEnabled(false)
		toggleButtonMap:setEnabled(false)
		toggleButtonDraw:setEnabled(false)
		toggleButtonTrigZonesList:setEnabled(false)
		toggleButtonUnitList:setEnabled(false)
		toggleButtonTape:setEnabled(false)
		toggleButtonTemplate:setEnabled(false)
		toggleButtonTrigRules:setEnabled(false)
		toggleButtonMissionOptions:setEnabled(false)
		if toggleButtonRoles then toggleButtonRoles:setEnabled(false) end
		toggleButtonBullsEye:setEnabled(false)
		toggleButtonNavPoint:setEnabled(false)
		staticMission:setEnabled(false)
		staticObjects:setEnabled(false)
		toggleButtonChangingCoalitions:setEnabled(false)
	else
		toggleButtonNew:setEnabled(true)
		toggleButtonOpen:setEnabled(true)
		pMap:setEnabled(true)
		toggleButtonSave:setEnabled(enabledSave)
		buttonDelete:setEnabled(true)
		buttonRun:setEnabled(true)
		toggleButtonBriefing:setEnabled(true)
		toggleButtonWeather:setEnabled(true)
		toggleButtonAirplane:setEnabled(true)
		toggleButtonHelicopter:setEnabled(true)
		toggleButtonShip:setEnabled(true)
		toggleButtonVehicle:setEnabled(true)
		toggleButtonStatic:setEnabled(true)
		toggleButtonGoal:setEnabled(true)
		toggleButtonZone:setEnabled(true)
		toggleButtonTemplate:setEnabled(true)
		toggleButtonMap:setEnabled(true)
		toggleButtonDraw:setEnabled(true)
		toggleButtonTrigZonesList:setEnabled(true)
		toggleButtonUnitList:setEnabled(true)
		toggleButtonTape:setEnabled(true)
		toggleButtonTemplate:setEnabled(true)
		toggleButtonTrigRules:setEnabled(true)
		toggleButtonMissionOptions:setEnabled(true)
		if toggleButtonRoles then toggleButtonRoles:setEnabled(true) end
		toggleButtonBullsEye:setEnabled(true)
		toggleButtonNavPoint:setEnabled(true)
		staticMission:setEnabled(true)
		staticObjects:setEnabled(true)
		toggleButtonChangingCoalitions:setEnabled(true)
	end	
end

function untoggle_tape()
    toggleButtonTape:setState(false)
	MapWindow.removeTapeObjects() 
end

function untoggle_all_except(buttonToExcept)
	if MapWindow.isEmptyME() == true then
		return
	end
	
    MapWindow.setState(MapWindow.getPanState())
    
    -- определяем имя кнопки, которую нужно оставить нажатой
    local name = ''
    for k, v in pairs(_M) do
        if v == buttonToExcept then 
            name = k
            break
        end
    end
    
    for button_name, button_panels in pairs(panels) do
        --проходим по всем кнопкам и дергаем соответсвующие функции
		local button = _M[button_name]
		
        if ((nil == button) or (buttonToExcept ~= button)) and (button ~= toggleButtonTape) then
            if button and button.setState then
                button:setState(false)
            end
            -- дергаем все функции, связанные с кнопкой
            -- второй параметр нужен только панели со списком юнитов
            for i = 1, #button_panels do 
                button_panels[i](false, button)
            end
        end
    end
    
	
    NodesManager.show(false)
    TemplatesManager.show(false)
	AirdromeController.hideWarehousePanel()

    panel_manager_resource.show(false)
	panelBeaconsInfo.show(false)
    panel_record_avi.hide()
end


function handleUnitList(b, button)
    if (button == toggleButtonAirplane) or
			(button == toggleButtonHelicopter) or	
            (button == toggleButtonShip) or
            (button == toggleButtonVehicle) or
            (button == toggleButtonStatic) then
            panel_units_list.show(true)
    else
        panel_units_list.show(false)
        panel_summary.show(false)
        panel_paramFM.show(false) 
		panel_dataCartridge.show(false)				
		panel_radio.show(false)
		panel_triggered_actions.show(false)
        panel_targeting.show(false)
        panel_route.show(false)
        panel_suppliers.show(false)
        panel_wpt_properties.show(false)
        panel_loadout.show(false)
        panel_wagons.show(false)
        panel_payload.show(false)
        pPayload_vehicles.show(false)
        panel_aircraft.show(false)
		panel_bullseye.show(false)

        panel_ship.show(false)
        panel_aircraft.show(false)
        panel_static.show(false)
        panel_vehicle.show(false)
        panel_weather.show(false)
      
    end
    panel_units_list.show(b)
end

function setButtonsEnabled(currentButton, state)
    local name = ''
    for k,v in pairs(_M) do
        if v == currentButton then 
            name = k
            break
        end
    end
    
    for button_name,button_panels in pairs(panels) do
        --проходим по всем кнопкам и дергаем соответсвующие функции
        if _M[button_name] and (name ~= button_name) then
            _M[button_name]:setEnabled(state)
        end
    end
end

function setupKeyboard()
    function toolbarCallback(button)
		if MapWindow.isEmptyME() ~= true and not base.isPlannerMission() 
			and MapWindow.isMouseDown() == false
			and panel_ChangingCoalitions.isVisible() ~= true 
			and CoalitionPanel.isVisible() ~= true then
			button:setState(true)
			button:onChange()   
		end
    end 
    
    function escCallback()
		if MapWindow.isMouseDown() == false then
			MapWindow.hideGroupPanels()
			panel_units_list.show(false)
			untoggle_all_except()
			untoggleButtons()
		end
    end 
    
    window:addHotKeyCallback( 'a'		, function() toolbarCallback(toggleButtonAirplane) 		end)
	window:addHotKeyCallback( 'h'		, function() toolbarCallback(toggleButtonHelicopter) 	end)
    window:addHotKeyCallback( 's'		, function() toolbarCallback(toggleButtonShip) 			end)
    window:addHotKeyCallback( 'u'		, function() toolbarCallback(toggleButtonVehicle) 		end)
    window:addHotKeyCallback( 'o'		, function() toolbarCallback(toggleButtonStatic) 		end)
    window:addHotKeyCallback( 'escape'	, escCallback)
	window:addHotKeyCallback('[\\+]', MapWindow.onChange_Plus)
	window:addHotKeyCallback('[-]', MapWindow.onChange_Minus)
	window:addHotKeyCallback('Alt+y', MapWindow.onChange_CoordsSys)
	
	window:addHotKeyCallback("up", MapWindow.onChange_Up)
	window:addHotKeyCallback("down", MapWindow.onChange_Down)
	window:addHotKeyCallback("right", MapWindow.onChange_Right)
	window:addHotKeyCallback("left", MapWindow.onChange_Left)
	
	for k,modul in base.pairs(managerModulesME.modulesME) do
		if modul.addHotKeyOnMap ~= nil then
			for kk, vv in base.pairs(modul.addHotKeyOnMap) do 
				base.print("--addHotKeyOnMap--",modul.id, vv.key, vv.fun)
				window:addHotKeyCallback(vv.key, modul[vv.fun])
			end
		end
	end
	

end 

function getTriggerZoneState()
	return toggleButtonZone:getState()
end

function resetTriggerZoneState()
	toggleButtonZone:setState(false)
end

function getTriggerZoneListState()
	return toggleButtonTrigZonesList:getState()
end

function resetTriggerZoneListState()
	return toggleButtonTrigZonesList:setState(false)
end

function getNavigationPointState()
	return toggleButtonNavPoint:getState()
end

function resetNavigationPointState()
	toggleButtonNavPoint:setState(false)
end

function setMissionOptionsState(state)
	if state then
		untoggleButtons(toggleButtonMissionOptions)
	end
	
	toggleButtonMissionOptions:setState(state)
end

function setMapOptionsState(state)
	if state then
		untoggleButtons(toggleButtonMap)
	end
	
	toggleButtonMap:setState(state)
end

function getWidth()
	return width
end