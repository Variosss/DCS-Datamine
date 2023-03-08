local Unit			= require('Mission.Unit')

local objectTypes_
local triggerZoneData_
local navigationPointData_
local coalitionData_
local airdromeData_
local supplierData_

local function setTriggerZoneData(triggerZoneData)
	triggerZoneData_ = triggerZoneData
end

local function setNavigationPointData(navigationPointData)
	navigationPointData_ = navigationPointData
end

local function setCoalitionData(coalitionData)
	coalitionData_ = coalitionData
end

local function setAirdromeData(airdromeData)
	airdromeData_ = airdromeData
end

local function setSupplierData(supplierData)
	supplierData_ = supplierData
end

local function triggerZoneType()
	return 'triggerZone'
end

local function navigationPointType()
	return 'navigationPoint'
end

local function airdromeType()
	return 'airdrome'
end

local function newMission()
	Unit.resetIdCounter()
	objectTypes_	= {}
	
	if triggerZoneData_ then
		triggerZoneData_.onNewMission()
	end
		
	if navigationPointData_ then
		navigationPointData_.onNewMission()
	end
	
	if airdromeData_ then
		airdromeData_.onNewMission()
	end
	
	if supplierData_ then
		supplierData_.onNewMission()
	end
end

local function openMission(filename)
	newMission()
end

local function getObjectType(objectId)
	return objectTypes_[objectId]
end

local function checkObjectIdIsUnique(id)
	if objectTypes_[id] then
		print(string.format('Error: Object with id[%d] already has type[%s]', id, objectTypes_[id]))
	end
end

local function registerTriggerZone(id)
	checkObjectIdIsUnique(id)
	objectTypes_[id] = triggerZoneType()
end

local function unregisterTriggerZone(id)
	objectTypes_[id] = nil
end

local function registerNavigationPoint(id)
	checkObjectIdIsUnique(id)
	objectTypes_[id] = navigationPointType()
end

local function unregisterNavigationPoint(id)
	objectTypes_[id] = nil
end

local function registerAirdrome(id)
	checkObjectIdIsUnique(id)
	objectTypes_[id] = airdromeType()
end

local function unregisterAirdrome(id)
	objectTypes_[id] = nil
end

local function redCoalitionName()
	return coalitionData_.redCoalitionName()
end

local function blueCoalitionName()
	return coalitionData_.blueCoalitionName()
end

local function neutralCoalitionName()
	return coalitionData_.neutralCoalitionName()
end

return {
	setTriggerZoneData		= setTriggerZoneData,
	setNavigationPointData	= setNavigationPointData,
	setCoalitionData		= setCoalitionData,
	setAirdromeData			= setAirdromeData,
	setSupplierData			= setSupplierData,
		
	newMission				= newMission,
	openMission				= openMission,
	getObjectType			= getObjectType,
	
	triggerZoneType			= triggerZoneType,
	registerTriggerZone		= registerTriggerZone,
	unregisterTriggerZone	= unregisterTriggerZone,

	navigationPointType			= navigationPointType,
	registerNavigationPoint		= registerNavigationPoint,
	unregisterNavigationPoint	= unregisterNavigationPoint,
	
	airdromeType			= airdromeType,
	registerAirdrome		= registerAirdrome,
	unregisterAirdrome		= unregisterAirdrome,	
	
	redCoalitionName		= redCoalitionName,
	blueCoalitionName		= blueCoalitionName,
	neutralCoalitionName	= neutralCoalitionName,
}