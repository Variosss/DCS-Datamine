local AirdromeData				= require('Mission.AirdromeData')
local AirdromePanel				= require('Mission.AirdromePanel')
local ModulesMediator			= require('Mission.ModulesMediator')
local me_manager_resource    	= require('me_manager_resource')
local me_mission				= require('me_mission')
local i18n						= require('i18n')

local mapView_

local function setMapView(view)
	mapView_ = view
end

local function getAirdromeSuppliersInfo(airdromeNumber)
	return me_mission.getAirdromeSuppliersInfo(airdromeNumber)
end	

local function getAirdromeNumber()
	return AirdromeData.getAirdromeNumber(AirdromePanel.getAirdromeId())
end

local function addAirdromeSupplier(supplierId, supplierType)
	local airdromeNumber = getAirdromeNumber()
	
	if airdromeNumber then
		me_mission.addAirdromeSupplier(airdromeNumber, supplierId, supplierType)
	end
end

local function removeAirdromeSupplier(supplierId, supplierType)
	local airdromeNumber = getAirdromeNumber()
	
	if airdromeNumber then
		me_mission.removeAirdromeSupplier(airdromeNumber, supplierId, supplierType)
	end
end

local function airdromeSupplierAdded(airdromeNumber, supplierInfo)
	AirdromePanel.airdromeSupplierAdded(AirdromeData.getAirdromeId(airdromeNumber), supplierInfo)
	ModulesMediator.getSupplierController().airdromeSupplierAdded(airdromeNumber, supplierInfo)
end

local function airdromeSupplierRemoved(airdromeNumber, supplierId, supplierType)
	AirdromePanel.airdromeSupplierRemoved(AirdromeData.getAirdromeId(airdromeNumber), supplierId, supplierType)
	ModulesMediator.getSupplierController().airdromeSupplierRemoved(airdromeNumber, supplierId, supplierType)	
end

local function setSelectedAirdromeSupplier(airdromeId,supplierInfo)
    ModulesMediator.getSupplierController().setSelectedAirdromeSupplier(AirdromeData.getAirdromeNumber(airdromeId),supplierInfo)
end

local function airdromeCoalitionChanged(airdromeId)
	if mapView_ then
		mapView_.airdromeCoalitionChanged(airdromeId)
	end
	
	AirdromePanel.airdromeCoalitionChanged(airdromeId)
end

local function showResourceManagerPanel()
	me_manager_resource.setCurId(getAirdromeNumber(), true)
	me_manager_resource.show(true)
end

local function hideResourceManagerPanel()
	if me_manager_resource.isVisible() then
		me_manager_resource.show(false)
	end	
end

local function onBeginAddSupplier()	
	ModulesMediator.getSupplierController().startAddAirdromeSupplier(getAirdromeNumber())
end

local function onEndAddSupplier()
	ModulesMediator.getSupplierController().finishAddSupplier()
end

local function onWarehousePanelShow()
end

local function onWarehousePanelHide()
	hideResourceManagerPanel()
	
	if mapView_ then
		mapView_.deselectObject(AirdromePanel.getAirdromeId())
	end
	
	AirdromePanel.setAirdromeId(nil)
	onEndAddSupplier()
end

local function getWarehousePanelVisible()
	return AirdromePanel.getVisible()
end

local function onResourceManagerPanelShow()
	AirdromePanel.onResourceManagerPanelShow()
end

local function onResourceManagerPanelHide()
	AirdromePanel.onResourceManagerPanelHide()
end

return {
	setMapView						= setMapView,
	
	getAirdromes					= AirdromeData.getAirdromes,
	getAirdrome						= AirdromeData.getAirdrome,
	getAirdromeId					= AirdromeData.getAirdromeId,

	getAirdromeSuppliersInfo		= getAirdromeSuppliersInfo,
	addAirdromeSupplier				= addAirdromeSupplier,
	removeAirdromeSupplier			= removeAirdromeSupplier,
	airdromeSupplierAdded			= airdromeSupplierAdded,
	airdromeSupplierRemoved			= airdromeSupplierRemoved,
    setSelectedAirdromeSupplier     = setSelectedAirdromeSupplier,
	
	setAirdromeCoalition			= AirdromeData.setAirdromeCoalition,
	airdromeCoalitionChanged		= airdromeCoalitionChanged,
	
	selectAirdrome					= AirdromePanel.setAirdromeId,
	getSelectedAirdromeId			= AirdromePanel.getAirdromeId,
	getSelectedAirdromeNumber		= getAirdromeNumber,
	
	showWarehousePanel				= AirdromePanel.show,
	hideWarehousePanel				= AirdromePanel.hide,
	onWarehousePanelShow			= onWarehousePanelShow,
	onWarehousePanelHide			= onWarehousePanelHide,
	getWarehousePanelVisible		= getWarehousePanelVisible,
	
	showResourceManagerPanel		= showResourceManagerPanel,
	hideResourceManagerPanel		= hideResourceManagerPanel,
	onResourceManagerPanelShow		= onResourceManagerPanelShow,
	onResourceManagerPanelHide		= onResourceManagerPanelHide,
	
	onBeginAddSupplier				= onBeginAddSupplier,
	onEndAddSupplier				= onEndAddSupplier,
}
