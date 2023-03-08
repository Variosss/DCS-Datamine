local NavigationPointData	= require('Mission.NavigationPointData')
local NavigationPointPanel	= require('Mission.NavigationPointPanel')
local CoalitionController	= require('Mission.CoalitionController')

local mapView_

local function setMapView(view)
	mapView_ = view
end

local function shiftNavigationPoint(navigationPointId, deltaX, deltaY)
	local x, y = NavigationPointData.getNavigationPointPosition(navigationPointId)
	
	NavigationPointData.setNavigationPointPosition(navigationPointId, x + deltaX, y + deltaY)
end

local function navigationPointPositionChanged(navigationPointId)
	if mapView_ then
		mapView_.navigationPointPositionChanged(navigationPointId)
	end
end

local function navigationPointNameChanged(navigationPointId)
	if mapView_ then
		mapView_.navigationPointNameChanged(navigationPointId)
	end
	
	NavigationPointPanel.navigationPointNameChanged(navigationPointId)
end

local function navigationPointCallsignChanged(navigationPointId)
end

local function navigationPointDescriptionChanged(navigationPointId)
	if mapView_ then
		mapView_.navigationPointDescriptionChanged(navigationPointId)
	end
	
	NavigationPointPanel.navigationPointDescriptionChanged(navigationPointId)
end

local function navigationPointTypeChanged(navigationPointId)
	if mapView_ then
		mapView_.navigationPointTypeChanged(navigationPointId)
	end
end

local function navigationPointScaleChanged(navigationPointId)
	NavigationPointPanel.navigationPointScaleChanged(navigationPointId)
end

local function navigationPointSteerChanged(navigationPointId)
	NavigationPointPanel.navigationPointSteerChanged(navigationPointId)
end

local function navigationPointVnavChanged(navigationPointId)
	NavigationPointPanel.navigationPointVnavChanged(navigationPointId)
end

local function navigationPointVangleChanged(navigationPointId)
	NavigationPointPanel.navigationPointVangleChanged(navigationPointId)
end

local function navigationPointAngleChanged(navigationPointId)
	NavigationPointPanel.navigationPointAngleChanged(navigationPointId)
end

local function navigationPointCoalitionChanged(navigationPointId)	
	if mapView_ then
		mapView_.navigationPointCoalitionChanged(navigationPointId)
	end
	
	NavigationPointPanel.navigationPointCoalitionChanged(navigationPointId)
end

local function navigationPointPropertiesChanged(navigationPointId)	
	NavigationPointPanel.navigationPointPropertiesChanged(navigationPointId)
end

local function navigationPointAdded(navigationPointId)
	if mapView_ then
		mapView_.addNavigationPoint(navigationPointId)
	end
end

local function navigationPointRemoved(navigationPointId)
	if mapView_ then
		mapView_.removeNavigationPoint(navigationPointId)
	end
end

return {
	setDataSource				= setDataSource,
	setMapView					= setMapView,
	
	getCallsigns				= NavigationPointData.getCallsigns,
	getNavigationPointIds		= NavigationPointData.getNavigationPointIds,
	getNavigationPoint			= NavigationPointData.getNavigationPoint,
	
	addNavigationPoint			= NavigationPointData.addNavigationPoint,
	removeNavigationPoint		= NavigationPointData.removeNavigationPoint,
	
	navigationPointAdded		= navigationPointAdded,
	navigationPointRemoved		= navigationPointRemoved,
		
	setNavigationPointPosition			= NavigationPointData.setNavigationPointPosition,
	getNavigationPointPosition			= NavigationPointData.getNavigationPointPosition,
	shiftNavigationPoint				= shiftNavigationPoint,
	navigationPointPositionChanged		= navigationPointPositionChanged,		
		
	setNavigationPointName				= NavigationPointData.setNavigationPointName,
	getNavigationPointName				= NavigationPointData.getNavigationPointName,
	navigationPointNameChanged			= navigationPointNameChanged,
	
	setNavigationPointCallsign			= NavigationPointData.setNavigationPointCallsign,
	getNavigationPointCallsign			= NavigationPointData.getNavigationPointCallsign,
	navigationPointCallsignChanged		= navigationPointCallsignChanged,

	setNavigationPointDescription		= NavigationPointData.setNavigationPointDescription,
	getNavigationPointDescription		= NavigationPointData.getNavigationPointDescription,
	navigationPointDescriptionChanged	= navigationPointDescriptionChanged,	
	
	setNavigationPointScale				= NavigationPointData.setNavigationPointScale,
	getNavigationPointScale				= NavigationPointData.getNavigationPointScale,
	navigationPointScaleChanged			= navigationPointScaleChanged,
			
	setNavigationPointSteer				= NavigationPointData.setNavigationPointSteer,
	getNavigationPointSteer				= NavigationPointData.getNavigationPointSteer,
	navigationPointSteerChanged			= navigationPointSteerChanged,
			
	setNavigationPointVnav				= NavigationPointData.setNavigationPointVnav,
	getNavigationPointVnav				= NavigationPointData.getNavigationPointVnav,
	navigationPointVnavChanged			= navigationPointVnavChanged,	
	
	setNavigationPointVangle			= NavigationPointData.setNavigationPointVangle,
	getNavigationPointVangle			= NavigationPointData.getNavigationPointVangle,
	navigationPointVangleChanged		= navigationPointVangleChanged,	
	
	setNavigationPointAngle				= NavigationPointData.setNavigationPointAngle,
	getNavigationPointAngle				= NavigationPointData.getNavigationPointAngle,
	navigationPointAngleChanged			= navigationPointAngleChanged,	

	setNavigationPointCoalition			= NavigationPointData.setNavigationPointCoalition,
	getNavigationPointCoalition			= NavigationPointData.getNavigationPointCoalition,
	navigationPointCoalitionChanged		= navigationPointCoalitionChanged,
	
	setNavigationPointPropertiesCustom	= NavigationPointData.setNavigationPointPropertiesCustom,
	getNavigationPointPropertiesCustom	= NavigationPointData.getNavigationPointPropertiesCustom,
	navigationPointPropertiesChanged	= navigationPointPropertiesChanged,
	
	selectNavigationPoint				= NavigationPointPanel.setNavigationPointId,
	getSelectedNavigationPointId		= NavigationPointPanel.getNavigationPointId,
	
	setNavigationPointType				= NavigationPointData.setNavigationPointType,
	getNavigationPointType				= NavigationPointData.getNavigationPointType,
	navigationPointTypeChanged			= navigationPointTypeChanged,
			
	showPanel							= NavigationPointPanel.show,
	hidePanel							= NavigationPointPanel.hide,
	
	loadCoalition						= NavigationPointData.loadCoalition,	
	saveCoalition						= NavigationPointData.saveCoalition,
}