local NavigationPoint	= require('Mission.NavigationPoint')
local me_db_api			= require('me_db_api')
local U             	= require('me_utilities')

local controller_
local missionData_
local navigationPoints_
local callsigns_
local navPointTypesById_ = me_db_api.getTypesNavPointsById()
	

local function setController(controller)
	controller_ = controller
end

local function setMissionData(missionData)
	missionData_ = missionData
end

local function getCallsigns()
	return me_db_api.getNavigationPointCallsigns()
end

local function getCallsign(name)
	if not callsigns_ then
		callsigns_ = getCallsigns()
	end
	
	return callsigns_[name]
end

local function onNewMission()
	navigationPoints_ = {}
end

local function getNavigationPointIds()
	local navigationPointIds = {}
	
	for i, navigationPoint in ipairs(navigationPoints_) do
		table.insert(navigationPointIds, navigationPoint:getId())
	end
	
	return navigationPointIds
end

local function getNavigationPoint(navigationPointId)
	for i, navigationPoint in ipairs(navigationPoints_) do
		if navigationPoint:getId() == navigationPointId then	
			return navigationPoint
		end
	end
end

local function getNavigationPointClone(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	if navigationPoint then
		return navigationPoint:clone()
	end
end

local function createNavigationPoint(name, coalitionName, x, y, id, a_type)
	local navigationPoint = NavigationPoint.new(name, coalitionName, x, y, id, a_type)
	local navigationPointId = navigationPoint:getId()

	navigationPoint:setCallsign(getCallsign(name))
	
	if a_type == nil then
		a_type = "Default"
	end
	
	if navPointTypesById_[a_type].properties ~= nil then
		navigationPoint:setScale(navPointTypesById_[a_type].properties.scale)
		navigationPoint:setSteer(navPointTypesById_[a_type].properties.steer)
		navigationPoint:setVnav(navPointTypesById_[a_type].properties.vnav)
		navigationPoint:setVangle(navPointTypesById_[a_type].properties.vangle)
		navigationPoint:setAngle(navPointTypesById_[a_type].properties.angle)
	end

	table.insert(navigationPoints_, navigationPoint)
	
	if missionData_ then
		missionData_.registerNavigationPoint(navigationPointId)
	end
	
	if navPointTypesById_[a_type].propertiesCustom ~= nil then
		setNavigationPointType(navigationPointId, a_type)
	end
	
	return navigationPoint
end

local function addNavigationPoint(name, coalitionName, x, y, id, a_type)
	local navigationPoint = createNavigationPoint(name, coalitionName, x, y, id, a_type or "Default")	
	local navigationPointId = navigationPoint:getId()
	
	if controller_ then
		controller_.navigationPointAdded(navigationPointId)
	end
	
	return navigationPointId
end

local function removeNavigationPoint(navigationPointId)
	for i, navigationPoint in ipairs(navigationPoints_) do
		if navigationPoint:getId() == navigationPointId then	
			table.remove(navigationPoints_, i)
		
			if missionData_ then
				missionData_.unregisterNavigationPoint(navigationPointId)
			end	
			
			if controller_ then
				controller_.navigationPointRemoved(navigationPointId)
			end
			
			break
		end
	end
end

local function setNavigationPointPosition(navigationPointId, x, y)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	navigationPoint:setPosition(x, y)

	if navigationPoint.linkChildrenSnap then
		for k, wpt in pairs(navigationPoint.linkChildrenSnap) do
			if wpt.boss.type == 'FlightPlan' then
				MapWindow.move_fp_waypoint(wpt, x, y) 
			else
				MapWindow.move_waypoint(wpt.boss, wpt.index, x, y, true) 
			end
		end
	end

	if controller_ then
		controller_.navigationPointPositionChanged(navigationPointId)
	end
end

local function getNavigationPointPosition(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	return navigationPoint:getPosition()
end

local function setNavigationPointCallsign(navigationPointId, callsign)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	navigationPoint:setCallsign(callsign)

	if controller_ then
		controller_.navigationPointCallsignChanged(navigationPointId)
	end
end

local function getNavigationPointCallsign(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	return navigationPoint:getCallsign()
end

local function setNavigationPointName(navigationPointId, name)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	navigationPoint:setName(name)
	
	if controller_ then
		controller_.navigationPointNameChanged(navigationPointId)
	end			
	
	setNavigationPointCallsign(navigationPointId, getCallsign(name))
end

local function getNavigationPointName(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	if navigationPoint then
		return navigationPoint:getName()
	end	
end

local function setNavigationPointDescription(navigationPointId, description)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	navigationPoint:setDescription(description)

	if controller_ then
		controller_.navigationPointDescriptionChanged(navigationPointId)
	end
end

local function getNavigationPointDescription(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	return navigationPoint:getDescription()
end

local function setNavigationPointScale(navigationPointId, scale)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	navigationPoint:setScale(scale)
	
	if controller_ then
		controller_.navigationPointScaleChanged(navigationPointId)
	end
end

local function getNavigationPointScale(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	return navigationPoint:getScale()
end	

local function setNavigationPointSteer(navigationPointId, steer)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	navigationPoint:setSteer(steer)
	
	if controller_ then
		controller_.navigationPointSteerChanged(navigationPointId)
	end
end

local function getNavigationPointSteer(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	return navigationPoint:getSteer()
end	

local function setNavigationPointVnav(navigationPointId, vnav)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	navigationPoint:setVnav(vnav)
	
	if controller_ then
		controller_.navigationPointVnavChanged(navigationPointId)
	end
end

local function getNavigationPointVnav(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	return navigationPoint:getVnav()
end

local function setNavigationPointVangle(navigationPointId, vangle)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	navigationPoint:setVangle(vangle)
	
	if 0 == vangle then
		navigationPoint:setAngle(0)
	end
	
	if controller_ then
		controller_.navigationPointVangleChanged(navigationPointId)
	end
end

local function getNavigationPointVangle(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	return navigationPoint:getVangle()
end

local function setNavigationPointAngle(navigationPointId, angle)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	navigationPoint:setAngle(angle)
	
	if controller_ then
		controller_.navigationPointAngleChanged(navigationPointId)
	end
end

local function getNavigationPointAngle(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	return navigationPoint:getAngle()
end

local function setNavigationPointCoalition(navigationPointId, coalitionName)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	navigationPoint:setCoalitionName(coalitionName)
	
	if controller_ then
		controller_.navigationPointCoalitionChanged(navigationPointId)
	end
end

local function getNavigationPointCoalition(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	
	return navigationPoint:getCoalitionName()
end

local function getNavigationPointPropertiesCustom(navigationPointId)
	local navPoint = getNavigationPoint(navigationPointId)
	local properties = navPoint:getPropertiesCustom()
	
	return properties
end

local function setNavigationPointPropertiesCustom(navigationPointId, a_properties)
	local navPoint = getNavigationPoint(navigationPointId)
	navPoint:setPropertiesCustom(a_properties)
end


function setNavigationPointType(a_navigationPointId, a_type)
	local navigationPoint = getNavigationPoint(a_navigationPointId)
	navigationPoint:setType(a_type)
	
	local properties = properties or {}
	
	if a_type == "Default" or a_type == nil  then
		navigationPoint:setScale(properties.scale 	or navPointTypesById_[a_type].properties.scale)
		navigationPoint:setSteer(properties.steer 	or navPointTypesById_[a_type].properties.steer)
		navigationPoint:setVnav(properties.vnav 	or navPointTypesById_[a_type].properties.vnav)
		navigationPoint:setVangle(properties.vangle	or navPointTypesById_[a_type].properties.vangle)
		navigationPoint:setAngle(properties.angle 	or navPointTypesById_[a_type].properties.angle)
		navigationPoint:setPropertiesCustom(nil)
	else
		navigationPoint:setScale(nil)
		navigationPoint:setSteer(nil)
		navigationPoint:setVnav(nil)
		navigationPoint:setVangle(nil)
		navigationPoint:setAngle(nil)
		navigationPoint:setPropertiesCustom(navPointTypesById_[a_type].propertiesCustom or {})		
	end
	
end

local function getNavigationPointType(a_navigationPointId, a_type)
	local navPoint = getNavigationPoint(a_navigationPointId)
	local Type = navPoint:getType()
	
	return Type
end

local function loadCoalition(coalitionName, navigationPointsTable)
	if navigationPointsTable then
		for i, navigationPointTable in ipairs(navigationPointsTable) do
			if navigationPointTable.type == nil then
				navigationPointTable.type = "Default"
			end
			
			local navigationPoint = createNavigationPoint(	navigationPointTable.callsignStr, 
															coalitionName,
															navigationPointTable.x, 
															navigationPointTable.y,
															navigationPointTable.id,
															navigationPointTable.type)

			navigationPoint:setCallsign(navigationPointTable.callsign)
			navigationPoint:setDescription(navigationPointTable.comment)
			
			if navigationPointTable.propertiesCustom then
				navigationPoint:setPropertiesCustom(navigationPointTable.propertiesCustom)
			end
			
			if navigationPointTable.properties then
				navigationPoint:setScale(navigationPointTable.properties.scale)
				navigationPoint:setSteer(navigationPointTable.properties.steer)
				navigationPoint:setVnav(navigationPointTable.properties.vnav)
				navigationPoint:setVangle(navigationPointTable.properties.vangle)
				navigationPoint:setAngle(navigationPointTable.properties.angle)
			end
			
			if controller_ then
				controller_.navigationPointAdded(navigationPoint:getId())
			end
		end
	end
end

local function saveCoalition(coalitionName)
	local navigationPointsTable = {}
	
	for i, navigationPoint in ipairs(navigationPoints_) do
		if navigationPoint:getCoalitionName() == coalitionName then
			local x, y = navigationPoint:getPosition()
			
			table.insert(navigationPointsTable, {
				id			= navigationPoint:getId(),
				callsignStr	= navigationPoint:getName(),
				comment		= navigationPoint:getDescription(),				
				callsign	= navigationPoint:getCallsign(),
				x			= x,
				y			= y,				
				properties	= {
					scale   	= navigationPoint:getScale(),
					steer   	= navigationPoint:getSteer(),
					vnav    	= navigationPoint:getVnav(),
					vangle  	= navigationPoint:getVangle(),
					angle   	= navigationPoint:getAngle(),	
				},
				propertiesCustom 	= navigationPoint:getPropertiesCustom(),
				type 		= navigationPoint:getType(),
			})
		end	
	end
	
	return navigationPointsTable
end

return {
	setController			= setController,
	setMissionData			= setMissionData,
	onNewMission			= onNewMission,
	
	getCallsigns			= getCallsigns,
	getNavigationPointIds	= getNavigationPointIds,
	getNavigationPoint		= getNavigationPoint,
	
	addNavigationPoint		= addNavigationPoint,
	removeNavigationPoint	= removeNavigationPoint,
	
	setNavigationPointPosition	= setNavigationPointPosition,
	getNavigationPointPosition	= getNavigationPointPosition,	
	
	setNavigationPointName	= setNavigationPointName,
	getNavigationPointName	= getNavigationPointName,

	setNavigationPointCallsign	= setNavigationPointCallsign,
	getNavigationPointCallsign	= getNavigationPointCallsign,

	setNavigationPointDescription	= setNavigationPointDescription,
	getNavigationPointDescription	= getNavigationPointDescription,
	
	setNavigationPointScale	= setNavigationPointScale,
	getNavigationPointScale	= getNavigationPointScale,	
	
	setNavigationPointSteer	= setNavigationPointSteer,
	getNavigationPointSteer	= getNavigationPointSteer,
	
	setNavigationPointVnav	= setNavigationPointVnav,
	getNavigationPointVnav	= getNavigationPointVnav,
	
	setNavigationPointVangle	= setNavigationPointVangle,
	getNavigationPointVangle	= getNavigationPointVangle,	
	
	setNavigationPointAngle	= setNavigationPointAngle,
	getNavigationPointAngle	= getNavigationPointAngle,	
	
	setNavigationPointCoalition	= setNavigationPointCoalition,
	getNavigationPointCoalition	= getNavigationPointCoalition,	

	setNavigationPointPropertiesCustom	= setNavigationPointPropertiesCustom,
	getNavigationPointPropertiesCustom	= getNavigationPointPropertiesCustom,	
	
	setNavigationPointType	= setNavigationPointType,
	getNavigationPointType	= getNavigationPointType,
	
	loadCoalition				= loadCoalition,
	saveCoalition				= saveCoalition,
}