local TriggerZoneData	= require('Mission.TriggerZoneData')
local TriggerZonePanel	= require('Mission.TriggerZonePanel')
local TriggerZoneList	= require('Mission.TriggerZoneList')

local mapView_

local function setMapView(view)
	mapView_ = view
end

local function triggerZoneAdded(triggerZoneId)
	if mapView_ then
		mapView_.addTriggerZone(triggerZoneId)
	end	
	
	TriggerZoneList.triggerZoneAdded(triggerZoneId)
end

local function triggerZoneRemoved(triggerZoneId)
	if mapView_ then
		mapView_.removeTriggerZone(triggerZoneId)
	end
	
	TriggerZoneList.triggerZoneRemoved(triggerZoneId)
end

local function shiftTriggerZone(triggerZoneId, deltaX, deltaY)
	local x, y = TriggerZoneData.getTriggerZonePosition(triggerZoneId)	
	TriggerZoneData.setTriggerZonePosition(triggerZoneId, x + deltaX, y + deltaY)
	TriggerZoneData.updateLocalCoords(triggerZoneId)
end

local function triggerZonePositionChanged(triggerZoneId)
	if mapView_ then
		mapView_.triggerZonePositionChanged(triggerZoneId)
	end
end

local function triggerZoneRadiusChanged(triggerZoneId)
	if mapView_ then
		mapView_.triggerZoneRadiusChanged(triggerZoneId)
	end
	
	TriggerZonePanel.triggerZoneRadiusChanged(triggerZoneId)
	TriggerZoneList.triggerZoneRadiusChanged(triggerZoneId)
end

local function setTriggerZonePoints(triggerZoneId, points)
	TriggerZoneData.setTriggerZonePoints(triggerZoneId, points)
	
	if mapView_ then
		mapView_.triggerZoneRadiusChanged(triggerZoneId)
	end
end

local function triggerZonePositionUpdated(triggerZoneId)
	if mapView_ then
		mapView_.updateTriggerZone(triggerZoneId)
	end	
end

local function triggerZoneTypeChanged(triggerZoneId)	
	if mapView_ then
		mapView_.triggerZoneTypeChanged(triggerZoneId)
	end
	
	TriggerZonePanel.triggerZoneTypeChanged()
end

local function triggerZoneNameChanged(triggerZoneId)
	if mapView_ then
		mapView_.triggerZoneNameChanged(triggerZoneId)
	end
	
	TriggerZonePanel.triggerZoneNameChanged(triggerZoneId)
	TriggerZoneList.triggerZoneNameChanged(triggerZoneId)
end

local function triggerZoneColorChanged(triggerZoneId)
	if mapView_ then
		mapView_.triggerZoneColorChanged(triggerZoneId)
	end
	
	TriggerZonePanel.triggerZoneColorChanged(triggerZoneId)
end

local function triggerZonePropertiesChanged(triggerZoneId)	
	TriggerZonePanel.triggerZonePropertiesChanged(triggerZoneId)
end

local function triggerZoneHiddenChanged(triggerZoneId)
	if mapView_ then
		mapView_.triggerZoneHiddenChanged(triggerZoneId)
	end
	
	TriggerZonePanel.triggerZoneHiddenChanged(triggerZoneId)
	TriggerZoneList.triggerZoneHiddenChanged(triggerZoneId)
end

local function selectTriggerZone(triggerZoneId)
	TriggerZonePanel.setTriggerZoneId(triggerZoneId)
	TriggerZoneList.selectTriggerZone(triggerZoneId)
end

local function onTriggerZonePanelShow()
end

local function onTriggerZonePanelHide()
end

local function onTriggerZoneListShow()
end

local function onTriggerZoneListHide()
end

local function onTriggerZoneSelected(triggerZoneId)
end

local function setTriggerZoneType(a_type)

end

return {
	setDataSource				= setDataSource,
	setMapView					= setMapView,	
	
	getTriggerZoneIds			= TriggerZoneData.getTriggerZoneIds,
	getTriggerZone				= TriggerZoneData.getTriggerZone,
	getTriggerZoneExists		= TriggerZoneData.getTriggerZoneExists,	
	
	addTriggerZone				= TriggerZoneData.addTriggerZone,
	removeTriggerZone			= TriggerZoneData.removeTriggerZone,
	
	triggerZoneAdded			= triggerZoneAdded,
	triggerZoneRemoved			= triggerZoneRemoved,
	
	setTriggerZonePosition		= TriggerZoneData.setTriggerZonePosition,
	shiftTriggerZone			= shiftTriggerZone,
	getTriggerZonePosition		= TriggerZoneData.getTriggerZonePosition,
	triggerZonePositionChanged	= triggerZonePositionChanged,
	
	setTriggerZoneRadius		= TriggerZoneData.setTriggerZoneRadius,
	getTriggerZoneRadius		= TriggerZoneData.getTriggerZoneRadius,
	triggerZoneRadiusChanged	= triggerZoneRadiusChanged,
	
	setTriggerZonePoints 		= setTriggerZonePoints,
	getTriggerZonePoints		= TriggerZoneData.getTriggerZonePoints,
	
	setTriggerZonePointsAbsolut	= TriggerZoneData.setTriggerZonePointsAbsolut,
	getTriggerZonePointsAbsolut	= TriggerZoneData.getTriggerZonePointsAbsolut,
	updateTriggerZonePosition	= TriggerZoneData.updateTriggerZonePosition,
	triggerZonePositionUpdated	= triggerZonePositionUpdated,
	
	setTriggerZoneType			= TriggerZoneData.setTriggerZoneType,
	getTriggerZoneType			= TriggerZoneData.getTriggerZoneType,
	triggerZoneTypeChanged		= triggerZoneTypeChanged,
	
	setTriggerZoneName			= TriggerZoneData.setTriggerZoneName,
	getTriggerZoneName			= TriggerZoneData.getTriggerZoneName,
	triggerZoneNameChanged		= triggerZoneNameChanged,
	
	setTriggerZoneColor			= TriggerZoneData.setTriggerZoneColor,
	getTriggerZoneColor			= TriggerZoneData.getTriggerZoneColor,
	triggerZoneColorChanged		= triggerZoneColorChanged,
	
	setTriggerZoneProperties			= TriggerZoneData.setTriggerZoneProperties,
	getTriggerZoneProperties			= TriggerZoneData.getTriggerZoneProperties,
	triggerZonePropertiesChanged		= triggerZonePropertiesChanged,
	
	setTriggerZoneHidden		= TriggerZoneData.setTriggerZoneHidden,
	getTriggerZoneHidden		= TriggerZoneData.getTriggerZoneHidden,
	triggerZoneHiddenChanged	= triggerZoneHiddenChanged,

	selectTriggerZone			= selectTriggerZone,
	getSelectedTriggerZoneId	= TriggerZonePanel.getTriggerZoneId,
	
	showPanel					= TriggerZonePanel.show,
	hidePanel					= TriggerZonePanel.hide,
	getPanelVisible				= TriggerZonePanel.getVisible,
	getPanelWindowSize			= TriggerZonePanel.getWindowSize,
	onTriggerZonePanelShow		= onTriggerZonePanelShow,
	onTriggerZonePanelHide		= onTriggerZonePanelHide,
	
	showList					= TriggerZoneList.show,
	hideList					= TriggerZoneList.hide,
	getListWindowSize			= TriggerZoneList.getWindowSize,
	onTriggerZoneListShow		= onTriggerZoneListShow,
	onTriggerZoneListHide		= onTriggerZoneListHide,
	onTriggerZoneSelected		= onTriggerZoneSelected,
	
	loadTriggerZones			= TriggerZoneData.loadTriggerZones,
	saveTriggerZones			= TriggerZoneData.saveTriggerZones,
	
	removeAllZones				= TriggerZoneData.removeAllZones, --для динамических миссий
	
	linkToUnit					= TriggerZoneData.linkToUnit,
	getLinkUnitId				= TriggerZoneData.getLinkUnitId,
	unlinkToUnit				= TriggerZoneData.unlinkToUnit,
	updateHeading				= TriggerZoneData.updateHeading,
	getLocalCoords				= TriggerZoneData.getLocalCoords,
}