local MapLayerController	= require('Mission.MapLayerController')
local ModulesMediator		= require('Mission.ModulesMediator')
local U = require('me_utilities')

local mapView_
local started_ = false
local supplierLayerTitle_ = 'SUPPLIERS OBJECTS' -- определено в LockOnExe\MissionEditor\data\NewMap\classifier.lua
local selectedAirdromeSupplier = nil
local selectedWarehouseSupplier = nil

local function setMapView(mapView)
	mapView_ = mapView
end

local function showWarehouseIcons()
	if mapView_ then
		local mission = ModulesMediator.getMission()
		
		mapView_.showWarehouseIcons(mission.getWarehouseInfos())
	end
end

local function hideWarehouseIcons()
	if mapView_ then
		mapView_.hideWarehouseIcons()
	end
end

local function startAddSupplier()
	local mapWindow = ModulesMediator.getMapWindow()
	
	mapWindow.setState(mapWindow.getSelectSupplierState())
	
	MapLayerController.setLayerVisible(supplierLayerTitle_, true)
	showWarehouseIcons()
	
	started_ = true
end

local function showAirdromeSupplierArrows(airdromeNumber)
	if mapView_ then
		local mission				= ModulesMediator.getMission()
		local toSupplierInfo		= mission.getAirdromeSupplierInfo(airdromeNumber)
		
		mapView_.removeSupplierArrows()
		
		for i, supplierInfo in ipairs(mission.getAirdromeSuppliersInfo(airdromeNumber)) do
			mapView_.addSupplierArrow(supplierInfo, toSupplierInfo)
		end
	end
end

local function startAddAirdromeSupplier(airdromeNumber)
	startAddSupplier()
	showAirdromeSupplierArrows(airdromeNumber)
end

local function showWarehouseSupplierArrows(unitId)
	if mapView_ then
		local mission				= ModulesMediator.getMission()
		local toSupplierInfo		= mission.getWarehouseSupplierInfo(unitId)
		
		mapView_.removeSupplierArrows()
		
		for i, supplierInfo in ipairs(mission.getWarehouseSuppliersInfo(unitId)) do
			mapView_.addSupplierArrow(supplierInfo, toSupplierInfo)
		end
	end
end

local function startAddWarehouseSupplier(unitId)
	startAddSupplier()
	showWarehouseSupplierArrows(unitId)
end

local function finishAddSupplier()
	started_ = false
	MapLayerController.setLayerVisible(supplierLayerTitle_, false)
	hideWarehouseIcons()
	
	local mapWindow = ModulesMediator.getMapWindow()
	
	mapWindow.setState(mapWindow.getPanState())
	
	if mapView_ then
		mapView_.removeSupplierArrows()
	end
end

local function onChangeMapState(mapState)	
	if started_ then
		local mapWindow = ModulesMediator.getMapWindow()
		
		if mapWindow.getSelectSupplierState() ~= mapState then
			started_ = false
            selectedWarehouseSupplier = nil
            hideWarehouseIcons()
			MapLayerController.setLayerVisible(supplierLayerTitle_, false)
		end
	end
end

local function onMapScaleChange()
	if started_ then
		if mapView_ then
			mapView_.removeSupplierArrows()
			
			local airdromeController	= ModulesMediator.getAirdromeController()
			local airdromeNumber		= airdromeController.getSelectedAirdromeNumber()
			
			if airdromeNumber then
				showAirdromeSupplierArrows(airdromeNumber)
			else
				local suppliersPanel = ModulesMediator.getSuppliersPanel()
				local unitId
				
				if	suppliersPanel.isVisible() then
					unitId = suppliersPanel.getUnitId()
				else
					local staticPanel = ModulesMediator.getStaticPanel()
					
					unitId = staticPanel.getUnitId()
				end
				
				showWarehouseSupplierArrows(unitId)
			end	
		end
	end	
end

local function onSelectSupplier(mapX, mapY)
	local mapController = ModulesMediator.getMapController()
	local supplierId	= mapController.pickStaticWarehouse(mapX, mapY)
	local supplierType	= 'warehouses'
	
	if not supplierId then
		supplierId		= mapController.pickAirdromeWarehouse(mapX, mapY)
		supplierType	= 'airports'
	end
	
	if supplierId and supplierType then
		local airdromeController	= ModulesMediator.getAirdromeController()

		if airdromeController.getWarehousePanelVisible() then
			airdromeController.addAirdromeSupplier(supplierId, supplierType)			
		else
			local suppliersPanel = ModulesMediator.getSuppliersPanel()
			
			if	suppliersPanel.isVisible() then
				suppliersPanel.selectSupplier(supplierId, supplierType)
			else
				local staticPanel = ModulesMediator.getStaticPanel()
				
				staticPanel.selectSupplier(supplierId, supplierType)
			end	 
		end
	end
end

local function airdromeSupplierAdded(airdromeNumber, supplierInfo, color)
	if mapView_ then		
		local mission				= ModulesMediator.getMission()
		local toSupplierInfo		= mission.getAirdromeSupplierInfo(airdromeNumber)
		
		mapView_.addSupplierArrow(supplierInfo, toSupplierInfo, color)
	end
end

local function airdromeSupplierRemoved_(airdromeNumber, supplierId, supplierType)
	if mapView_ then		
		local mission				= ModulesMediator.getMission()
		local fromSupplierInfo		= mission.getAirdromeSupplierInfo(airdromeNumber)
		
		mapView_.removeSupplierArrow(fromSupplierInfo, supplierId, supplierType)   
	end
end

local function airdromeSupplierRemoved(airdromeNumber, supplierId, supplierType)
	if mapView_ then		
		airdromeSupplierRemoved_(airdromeNumber, supplierId, supplierType)
        
        if selectedAirdromeSupplier and selectedAirdromeSupplier.airdromeNumber == airdromeNumber 
            and selectedAirdromeSupplier.supplierInfo.supplierId == supplierId then
            selectedAirdromeSupplier = nil   
        end    
	end
end

local function warehouseSupplierAdded(unitId, supplierInfo, color)
	if mapView_ then		
		local mission				= ModulesMediator.getMission()
		local toSupplierInfo		= mission.getWarehouseSupplierInfo(unitId)
		
		mapView_.addSupplierArrow(supplierInfo, toSupplierInfo, color)
	end
end

local function warehouseSupplierRemoved_(unitId, supplierId, supplierType)
	if mapView_ then		
		local mission				= ModulesMediator.getMission()
		local fromSupplierInfo		= mission.getWarehouseSupplierInfo(unitId)
		mapView_.removeSupplierArrow(fromSupplierInfo, supplierId, supplierType)                   
	end
end

local function warehouseSupplierRemoved(unitId, supplierId, supplierType)
	if mapView_ then		
		warehouseSupplierRemoved_(unitId, supplierId, supplierType)
        
        if selectedWarehouseSupplier and selectedWarehouseSupplier.unitId == unitId 
            and selectedWarehouseSupplier.supplierInfo.supplierId == supplierId then
            selectedWarehouseSupplier = nil   
        end              
	end
end

local function updateSupplier(fromSupplierInfo, supplierId, supplierType)

end

local function setSelectedWarehouseSupplier(unitId, supplierInfo)
    -- возвращаем цвет выделенного
    if selectedWarehouseSupplier then
        warehouseSupplierRemoved_(selectedWarehouseSupplier.unitId, selectedWarehouseSupplier.supplierInfo.supplierId, selectedWarehouseSupplier.supplierInfo.supplierType)
        warehouseSupplierAdded(selectedWarehouseSupplier.unitId, selectedWarehouseSupplier.supplierInfo)
    end
    
    -- выделяем новый
    warehouseSupplierRemoved_(unitId, supplierInfo.supplierId, supplierInfo.supplierType)
    warehouseSupplierAdded(unitId, supplierInfo, {0.92,0.84,0.14,0.8})
    
    selectedWarehouseSupplier = {unitId=unitId,supplierInfo=supplierInfo}
end

local function clearSelected()
	selectedWarehouseSupplier = nil
end

local function setSelectedAirdromeSupplier(airdromeNumber, supplierInfo)
    -- возвращаем цвет выделенного
    if selectedAirdromeSupplier then
        airdromeSupplierRemoved_(selectedAirdromeSupplier.airdromeNumber, selectedAirdromeSupplier.supplierInfo.supplierId, selectedAirdromeSupplier.supplierInfo.supplierType)
        airdromeSupplierAdded(selectedAirdromeSupplier.airdromeNumber, selectedAirdromeSupplier.supplierInfo)
    end
    
    -- выделяем новый
    airdromeSupplierRemoved_(airdromeNumber, supplierInfo.supplierId, supplierInfo.supplierType)
    airdromeSupplierAdded(airdromeNumber, supplierInfo, {0.92,0.84,0.14,0.8})
    
    selectedAirdromeSupplier = {airdromeNumber=airdromeNumber,supplierInfo=supplierInfo}
end

return {
	setMapView					= setMapView,
	startAddAirdromeSupplier	= startAddAirdromeSupplier,
	startAddWarehouseSupplier	= startAddWarehouseSupplier,
	finishAddSupplier			= finishAddSupplier,
	onSelectSupplier			= onSelectSupplier,
	onChangeMapState			= onChangeMapState,
	onMapScaleChange			= onMapScaleChange,
	airdromeSupplierAdded		= airdromeSupplierAdded,
	airdromeSupplierRemoved		= airdromeSupplierRemoved,
	warehouseSupplierAdded		= warehouseSupplierAdded,
	warehouseSupplierRemoved	= warehouseSupplierRemoved,
    setSelectedAirdromeSupplier = setSelectedAirdromeSupplier,
    setSelectedWarehouseSupplier= setSelectedWarehouseSupplier,
	clearSelected				= clearSelected,
}