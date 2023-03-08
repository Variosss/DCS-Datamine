local MapLayerPanel		= require('Mission.MapLayerPanel')
local U					= require('me_utilities')
local MeSettings		= require('MeSettings')

local layers_
local mapView_
local supplierLayerTitle_ = 'SUPPLIERS OBJECTS' -- определено в LockOnExe\MissionEditor\data\NewMap\classifier.lua

local function setMapView(view)
	mapView_ = view
end

local function setClassifierLayers(layers)
	layers_ = {}
	for i, layer in pairs(layers) do
		layers_[layer.title] = {
			localizedTitle	= layer.localizedTitle,
			switchable		= layer.switchable,
			visible			= layer.visible,
		}
	end
end

local function getLayers()
	local layers = {}
	for title, layer in pairs(layers_) do
		table.insert(layers, {
			title			= title, 
			localizedTitle	= layer.localizedTitle,
			visible			= layer.visible and not MeSettings.getMapLayerHidden(title),
		})
	end
	
	return layers
end

local function getSwitchableLayers()
	local layers = {}
	for title, layer in pairs(layers_) do
		if layer.switchable then
			table.insert(layers, {                
				title			= title, 
				localizedTitle	= layer.localizedTitle,
				visible			= layer.visible and not MeSettings.getMapLayerHidden(title),
			})
		end
	end
	return layers
end

local function updateLayerVisible()
    for title, layer in pairs(layers_) do
        layer.visible = layer.visible and not MeSettings.getMapLayerHidden(title)
        if mapView_ then
            mapView_.setLayerVisible(title, layer.visible)
        end
    end
end

local function setLayerVisible(layerTitle, visible)
	local layer = layers_[layerTitle]
	
	layer.visible = visible
	
	if layer.switchable then
        MeSettings.setMapLayerHidden(layerTitle, not visible)
		MapLayerPanel.mapLayerVisibleChanged(layerTitle)
	end
	
	if mapView_ then
		mapView_.setLayerVisible(layerTitle, visible)
	end
end

local function getLayerVisible(layerTitle)
	return layers_[layerTitle].visible
end

local function showSupplierLayer()
	setLayerVisible(supplierLayerTitle_, true)
end

local function hideSupplierLayer()
	setLayerVisible(supplierLayerTitle_, false)
end

local function onMapLayerPanelShow()
end

local function onMapLayerPanelHide()
end

return {
	setMapView				= setMapView,
	setClassifierLayers		= setClassifierLayers,
	
	getLayers				= getLayers,
	getSwitchableLayers		= getSwitchableLayers,
	
	setLayerVisible			= setLayerVisible,
	getLayerVisible			= getLayerVisible,
	
	showSupplierLayer		= showSupplierLayer,
	hideSupplierLayer		= hideSupplierLayer,
		
	onMapLayerShow			= onMapLayerShow,

	showMapLayerPanel		= MapLayerPanel.show,
	hideMapLayerPanel		= MapLayerPanel.hide,
	onMapLayerPanelShow		= onMapLayerPanelShow,
	onMapLayerPanelHide		= onMapLayerPanelHide,
    
    updateLayerVisible      = updateLayerVisible,
}