local base = _G

module('me_tabs')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local table = base.table
local print = base.print

local Skin 						= require('Skin')
local DialogLoader 				= require('DialogLoader')
local ToggleButton 				= require('ToggleButton')
local MapWindow 				= require('me_map_window')
local panel_route 				= require('me_route')
local panel_triggered_actions 	= require('me_triggered_actions')
local panel_summary 			= require('me_summary')
local panel_payload 			= require('me_payload')
local panel_payload_vehicles 	= require('me_payload_vehicles')
local panel_suppliers 			= require('me_suppliers')
local panel_nav_target_fix_points = require('me_nav_target_fix_points')
local panel_failures 			= require('me_failures')
local panel_wpt_properties 		= require('me_wpt_properties')
local panel_radio 				= require('me_panelRadio')
local panel_paramFM 			= require('me_paramFM')
local panel_wagons 				= require('me_wagons')
local panel_dataCartridge 		= require('me_dataCartridge')

require('i18n').setup(_M)

local cdata = {
	route 					= _('ROUTE'), 
	payload 				= _('PAYLOAD'), 
	triggeredActions 		= _('TRIGGERED ACTIONS'), 
	summary 				= _('SUMMARY'), 
	navFixPoint 			= _('NAVIGATION TARGET FIX POINTS'),
	failures 				= _('FAILURES'), 
	waypointsProperties 	= _('WAYPOINT PROPERTIES'), 
	Radio 					= _('RADIO PRESETS'),
	suppliers 				= _('SUPPLIERS'),
    paramFM 				= _('Additional properties for aircraft'),
    payload_vehicles 		= _('PAYLOAD_VEHICLES'),
    ammo 					= _('AMMO_btn', 'AMMO'),
    wagons 					= _('WAGONS_btn', 'WAGONS'),
	dataCartridge 			= _('DATA CARTRIDGE'),
}

-- enable or disable toolbar and associated panels
function enableTabs(tabs, enable)
	local tabsInfo = tabs.tabsInfo
	
	for i, tabInfo in ipairs(tabsInfo) do
		tabInfo.tab:setEnabled(enable) 
		
		local setSafeMode = tabInfo.panel.setSafeMode
		
		if setSafeMode then
			setSafeMode(not enable)
		end
	end
end

function selectTab(tabs, name)
	local tabsInfo = tabs.tabsInfo

	for i, tabInfo in ipairs(tabsInfo) do
        local tab = tabInfo.tab
		if tabInfo.name == name then
			tab:setState(true)
			tab:onShow()			
		else
			tab:setState(false)
            tab:onHide()
		end
	end
end

function getSelectedTab(tabs)
	local name
	
	local tabsInfo = tabs.tabsInfo
	
	for i, tabInfo in ipairs(tabsInfo) do
		local tab = tabInfo.tab
		
		if tab:getState() then
			name = tabInfo.name
			
			break
		end
	end
	
	return name
end

function setTabVisible(tabs, name, visible)
	local tabsInfo = tabs.tabsInfo
	local panelTabs = tabs.panelTabs
	
	panelTabs:removeAllWidgets()
	
	for i, tabInfo in ipairs(tabsInfo) do
		local tab = tabInfo.tab
				
		if tabInfo.name == name then	
			tab:setVisible(visible)
		end
		
		if tab:getVisible() then
			panelTabs:insertWidget(tab)
		end
	end
end

function showTab(tabs, name)
	if name == 'dataCartridge' and base.test_DataCartridge ~= true then
		return
	end
	setTabVisible(tabs, name, true)
end

function hideTab(tabs, name)
	setTabVisible(tabs, name, false)
end

-- create tabs in unit dialogs
function createUnitTabs(a_type, parent, offsetX, offsetY)
	local window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_tabs.dlg', cdata)
	
	-- panelTabs содержит HorzLayout, который управляет положением и размером закладок
	local panelTabs = window.panelTabs
	
	window:removeWidget(panelTabs)
	window:kill()
	
	local tabNames = {
		route = 			panelTabs.tabRoute,
		payload = 			panelTabs.tabPayload,
		triggeredActions = 	panelTabs.tabTriggeredActions,
		summary = 			panelTabs.tabSummary,
		navFixPoint =		panelTabs.tabNavigationTargetFixPoints,
		failures = 			panelTabs.tabFailures,
		waypoints = 		panelTabs.tabWaypointsProperties,
		Radio = 			panelTabs.tabRadio,
		suppliers = 		panelTabs.tabSuppliers,
        paramFM =           panelTabs.tabParamFM,
        ammo =              panelTabs.tabAmmo,
        wagons =            panelTabs.tabWagons,
		dataCartridge = 	panelTabs.tabDataCartridge,	 
	}
	
	local createTabInfo = function(name, panel)		
		return {name = name, tab = tabNames[name], panel = panel}
	end
	
	local tabsInfo
	
    if (a_type == 'vehicle') then
		tabsInfo = {
			createTabInfo('route', panel_route),
            createTabInfo('ammo', panel_payload_vehicles),
			createTabInfo('triggeredActions', panel_triggered_actions),
			createTabInfo('summary', panel_summary),
            createTabInfo('paramFM', panel_paramFM), 
            createTabInfo('wagons', panel_wagons), 
		}
	elseif (a_type == 'ship') then	
		tabsInfo = {
			createTabInfo('route', panel_route),
			createTabInfo('ammo', panel_payload_vehicles),
			createTabInfo('triggeredActions', panel_triggered_actions),
			createTabInfo('summary', panel_summary),
			createTabInfo('suppliers', panel_suppliers),		
		}
	elseif (a_type == 'aircraft') then
		tabsInfo = {
			createTabInfo('route', panel_route),
			createTabInfo('payload', panel_payload),            
			createTabInfo('triggeredActions', panel_triggered_actions),
			createTabInfo('summary', panel_summary),
			createTabInfo('navFixPoint', panel_nav_target_fix_points),
			createTabInfo('failures', panel_failures),
			createTabInfo('waypoints', panel_wpt_properties),
			createTabInfo('Radio', panel_radio),
            createTabInfo('paramFM', panel_paramFM),
			createTabInfo('dataCartridge', panel_dataCartridge),           
		}
	end 

	panelTabs:removeAllWidgets()
	
	for i, tabInfo in ipairs(tabsInfo) do
		local tab = tabInfo.tab
		local panel = tabInfo.panel
		
		function tab:onShow() 
            MapWindow.setState(MapWindow.getPanState())
            if MapWindow.getVisible() then			
                panel.show(true)
            end
		end
		
		function tab:onHide()    
			panel.show(false)
		end 
		
		panelTabs:insertWidget(tab)
	end
	
	panelTabs:setPosition(offsetX, offsetY)
	parent:insertWidget(panelTabs)	
	
	local tabs = {		
		tabsInfo = tabsInfo,
		panelTabs = panelTabs,
		setEnabled = enableTabs,
		selectTab = selectTab,
		showTab = showTab,
		hideTab = hideTab,
		getSelectedTab = getSelectedTab,
	}
	
	return tabs
end
