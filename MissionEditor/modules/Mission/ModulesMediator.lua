-- module to avoid modules cyclic references
local supplierController_
local airdromeController_
local mapController_
local mapWindow_
local mission_
local staticPanel_
local suppliersPanel_
local panelContextMenu_

local function getSupplierController()
	if not supplierController_ then
		supplierController_ = require('Mission.SupplierController')
	end
	
	return supplierController_
end

local function getAirdromeController()
	if not airdromeController_ then
		airdromeController_ = require('Mission.AirdromeController')
	end
	
	return airdromeController_
end

local function getMapController()
	if not mapController_ then
		mapController_ = require('Mission.MapController')
	end
	
	return mapController_
end

local function getMapWindow()
	if not mapWindow_ then
		mapWindow_ = require('me_map_window')
	end
	
	return mapWindow_
end

local function getMission()
	if not mission_ then
		mission_ = require('me_mission')
	end
	
	return mission_
end

local function getStaticPanel()
	if not staticPanel_ then
		staticPanel_ = require('me_static')
	end
	
	return staticPanel_
end

local function getSuppliersPanel()
	if not suppliersPanel_ then
		suppliersPanel_ = require('me_suppliers')
	end
	
	return suppliersPanel_
end

local function getPanelContextMenu()
	if not panelContextMenu_ then
		panelContextMenu_			= require('me_contextMenu')
	end
	
	return panelContextMenu_
end


return {
	getSupplierController	= getSupplierController,
	getAirdromeController	= getAirdromeController,
	getMapController		= getMapController,
	getMapWindow			= getMapWindow,
	getMission				= getMission,
	getStaticPanel			= getStaticPanel,
	getSuppliersPanel		= getSuppliersPanel,
	getPanelContextMenu		= getPanelContextMenu,
}