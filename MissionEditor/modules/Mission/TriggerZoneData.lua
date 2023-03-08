local TriggerZone	= require('Mission.TriggerZone')
local module_mission = require('me_mission')
local TableUtils		= require('TableUtils')
local U 			= require('me_utilities')

local controller_
local missionData_
local triggerZones_
local triggerZoneNameCounter_


local function setController(controller)
	controller_ = controller
end

local function createCirclePoints(x, y, radius)
	local points = {}
	local sides = 32
	local da = 2 * math.pi / sides
	local sin = math.sin
	local cos = math.cos

	for i = 0, sides - 1 do
		table.insert(points, MapWindow.createPoint(	x + radius * sin(da * i), 
													y + radius * cos(da * i)))
	end	

	return points
end

local function setMissionData(missionData)
	missionData_ = missionData
end

local function onNewMission()
	triggerZones_	= {}
	triggerZoneNameCounter_ = 1
end

local function getTriggerZoneNameUnique(name, a_triggerZoneId)
	for i, triggerZone in ipairs(triggerZones_) do
		if triggerZone:getName() == name and a_triggerZoneId ~= triggerZone.id then
			return false
		end
	end
	
	return true
end

local function makeTriggerZoneNameUnique(a_name, a_triggerZoneId)
	local uniqueName = a_name
	local num = 0
	local baseName = uniqueName
  
	local dotIdx = string.find(string.reverse(uniqueName), '-')
	if dotIdx then
		baseName = string.sub(uniqueName, 0,-dotIdx-1)
	end
	
	triggerZoneNameCounter_ = 0
	while not getTriggerZoneNameUnique(uniqueName, a_triggerZoneId) do
		triggerZoneNameCounter_ = triggerZoneNameCounter_ + 1
		uniqueName = baseName ..'-' .. triggerZoneNameCounter_	
	end
	
	return uniqueName
end

local function createTriggerZone(a_name, a_x, a_y, a_radius, a_id, a_properties, a_type, a_points)
	local triggerZone = TriggerZone.new(makeTriggerZoneNameUnique(a_name), a_x, a_y, a_radius, a_id, a_properties, a_type, a_points)
	local triggerZoneId = triggerZone:getId()
	
	table.insert(triggerZones_, triggerZone)
	
	missionData_.registerTriggerZone(triggerZoneId)
	
	return triggerZone
end

local function addTriggerZone(name, x, y, radius, properties, color, a_type, a_points)
	local triggerZone = createTriggerZone(name, x, y, radius, id, properties, a_type, a_points)
	local triggerZoneId = triggerZone:getId()

	if color then
		triggerZone:setColor(color[1] , color[2], color[3], color[4])
	end
	
	if controller_ then
		controller_.triggerZoneAdded(triggerZoneId)
	end
	
	return triggerZoneId
end

local function removeTriggerZone(triggerZoneId)
	for i, triggerZone in ipairs(triggerZones_) do
		if triggerZone:getId() == triggerZoneId then
			module_mission.unlinkTriggerZone(triggerZoneId)
			table.remove(triggerZones_, i)
			
			missionData_.unregisterTriggerZone(triggerZoneId)
			
			if controller_ then
				controller_.triggerZoneRemoved(triggerZoneId)
			end
			
			break
		end
	end
end

local function getTriggerZone(triggerZoneId)
	for i, triggerZone in ipairs(triggerZones_) do
		if triggerZone:getId() == triggerZoneId then	
			return triggerZone
		end
	end
end

local function getTriggerZoneClone(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	if triggerZone then
		return triggerZone:clone()
	end
end

local function setTriggerZoneRadius(triggerZoneId, radius)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	triggerZone:setRadius(radius)
	
	if controller_ then
		controller_.triggerZoneRadiusChanged(triggerZoneId)
	end
end

local function getTriggerZoneRadius(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	return triggerZone:getRadius()
end

local function setTriggerZonePoints(triggerZoneId, a_points)
	local triggerZone = getTriggerZone(triggerZoneId)	
	local points = {}
	for k,v in ipairs(a_points) do
		table.insert(points,{x = v.x ,y = v.y})
	end
	
	triggerZone:setPoints(points)
	
	if controller_ then
		controller_.triggerZoneRadiusChanged(triggerZoneId)
	end
end

local function getTriggerZonePoints(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	return triggerZone:getPoints()
end

local function setTriggerZoneType(triggerZoneId, a_type)
	local triggerZone = getTriggerZone(triggerZoneId)
	triggerZone:setType(a_type)
	
	local points = {}	
	if triggerZone:getType() == 0 then
		points = createCirclePoints(0, 0, triggerZone:getRadius())
	else
		local tmpR = triggerZone:getRadius()
		
		points = {	{x = -tmpR	, y = -tmpR	},
					{x = -tmpR	, y = tmpR	},
					{x = tmpR	, y = tmpR	},
					{x = tmpR	, y = -tmpR	},
		}
	end
	
	triggerZone:setPoints(points)
	
	if controller_ then
		controller_.triggerZoneTypeChanged(triggerZoneId)
	end
end

local function getTriggerZoneType(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	return triggerZone:getType()
end

local function setTriggerZoneName(triggerZoneId, name)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	if triggerZone:getName() ~= name then
		triggerZone:setName(makeTriggerZoneNameUnique(name, triggerZoneId))
	end
		
	if controller_ then
		controller_.triggerZoneNameChanged(triggerZoneId)
	end
end

local function getTriggerZoneName(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	if triggerZone then
		return triggerZone:getName()
	end	
end

local function setTriggerZoneColor(triggerZoneId, r, g, b, a)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	triggerZone:setColor(r, g, b, a)
	
	if controller_ then
		controller_.triggerZoneColorChanged(triggerZoneId)
	end
end

local function getTriggerZoneColor(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	local r, g, b, a = triggerZone:getColor()

	return r, g, b, a
end

local function getTriggerZoneProperties(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	local properties = triggerZone:getProperties()
	
	return properties
end

local function setTriggerZoneProperties(triggerZoneId, a_properties)
	local triggerZone = getTriggerZone(triggerZoneId)
	triggerZone:setProperties(a_properties)
end

local function setTriggerZoneHidden(triggerZoneId, hidden)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	triggerZone:setHidden(hidden)
	
	if controller_ then
		controller_.triggerZoneHiddenChanged(triggerZoneId)
	end
end

local function getTriggerZoneHidden(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	return triggerZone:getHidden()
end

local function setTriggerZonePosition(triggerZoneId, x, y)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	triggerZone:setPosition(x, y)
	
	if controller_ then
		controller_.triggerZonePositionChanged(triggerZoneId)
	end
end

local function getTriggerZonePosition(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	if triggerZone then
		return triggerZone:getPosition()
	end
	
	return nil
end

-- a - первый отрезок
-- b - второй отрезок
local function intersection(p1, p2, p3, p4)
	local ax1 = p1.x
	local ay1 = p1.y
	local ax2 = p2.x
	local ay2 = p2.y
	local bx1 = p3.x
	local by1 = p3.y
	local bx2 = p4.x
	local by2 = p4.y
	local v1 = (bx2 - bx1) * (ay1 - by1) - (by2 - by1) * (ax1 - bx1)
	local v2 = (bx2 - bx1) * (ay2 - by1) - (by2 - by1) * (ax2 - bx1)
	local v3 = (ax2 - ax1) * (by1 - ay1) - (ay2 - ay1) * (bx1 - ax1)
	local v4 = (ax2 - ax1) * (by2 - ay1) - (ay2 - ay1) * (bx2 - ax1)
	
	return (v1 * v2 < 0) and (v3 * v4 < 0)
end

-- отрезки в контуре points не должны пересекать друг-друга
local function getTriggerZonePointsAreValid(points)
	local segments = {}
	local pointCount = #points
	
	for i = 1, pointCount do
		if i < pointCount then
			table.insert(segments, {points[i], points[i + 1]})
		else
			table.insert(segments, {points[i], points[1]})
		end
	end
	
	local segmentCount = #segments
	
	for i, segment1 in ipairs(segments) do
		-- соседние сегменты проверять на пересечение не нужно
		local prevSegment = i - 1
		
		if prevSegment < 1 then
			prevSegment = segmentCount
		end
		
		local nextSegment = i + 1
		
		if nextSegment > segmentCount then
			nextSegment = nextSegment - segmentCount
		end
		
		for j, segment2 in ipairs(segments) do
			if 	j ~= i and
				j ~= prevSegment and 
				j ~= nextSegment then
				
				if intersection(segment1[1], segment1[2], segment2[1], segment2[2]) then
					-- отрезки пересекаются, контур невалидный
					
					return false
				end
			end
		end
	end

	return true
end

local function setTriggerZonePointsAbsolut(triggerZoneId, a_points)
	if getTriggerZonePointsAreValid(a_points) then
		local triggerZone = getTriggerZone(triggerZoneId)	
		local x, y = triggerZone:getPosition()
		local points = {}
		
		for k, v in ipairs(a_points) do
			table.insert(points,{x = v.x - x ,y = v.y - y})
		end
		
		triggerZone:setPoints(points)
		
		if controller_ then
			controller_.triggerZonePositionUpdated(triggerZoneId)
		end
	end
end

local function getTriggerZonePointsAbsolut(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	local x, y = triggerZone:getPosition()
	local pointsA = {}
	
	for k, v in ipairs(triggerZone:getPoints()) do
		table.insert(pointsA,{x = v.x + x ,y = v.y + y})
	end
	
	return pointsA
end

local function updateTriggerZonePosition(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)	
	if triggerZone:getType() == 0 then
		return
	end
	
	local x, y = triggerZone:getPosition()
	-- ищем новый центр
	local newX = 0 
	local newY = 0 
	local points = triggerZone:getPoints()
	
	if points == nil then
		return
	end

	for k, v in ipairs(points) do
		newX = newX + v.x + x
		newY = newY + v.y + y
	end
	
	newX = newX / #points
	newY = newY / #points
	
	local dx = newX - x
	local dy = newY - y
	
	local  pointsA = {}
	
	for k, v in ipairs(points) do
		table.insert(pointsA, {x = v.x - dx, y = v.y - dy})
	end
	
	triggerZone:setPosition(newX, newY)
	triggerZone:setPoints(pointsA)
	
	if controller_ then
		controller_.triggerZonePositionUpdated(triggerZoneId)
	end
end

local function getTriggerZoneIds()
	local triggerZoneIds = {}
	
	for i, triggerZone in ipairs(triggerZones_) do
		table.insert(triggerZoneIds, triggerZone:getId())
	end
	
	return triggerZoneIds
end

local function getTriggerZoneExists(triggerZoneId)
	return nil ~= getTriggerZone(triggerZoneId)
end

local function loadTriggerZones(triggerZonesTable)
	if triggerZonesTable then	
		for i, triggerZoneTable in ipairs(triggerZonesTable) do
			local triggerZone = createTriggerZone(	triggerZoneTable.name, 
													triggerZoneTable.x, 
													triggerZoneTable.y, 
													triggerZoneTable.radius, 
													triggerZoneTable.zoneId,
													triggerZoneTable.properties,
													triggerZoneTable.type,
													points)

			triggerZone:setColor(unpack(triggerZoneTable.color))
			triggerZone:setHidden(triggerZoneTable.hidden)	
			triggerZone:setLinkUnitId(triggerZoneTable.linkUnit)			
			
			if triggerZoneTable.type == 2 then				
				triggerZone:setPoints(triggerZoneTable.verticies)
			end	
				
			if controller_ then
				controller_.triggerZoneAdded(triggerZone:getId())
			end
			
			if triggerZoneTable.linkUnit ~= nil then
				local unit = module_mission.unit_by_id[triggerZoneTable.linkUnit]
				local absolutCoords = calcAbsolutCoords(unit, triggerZone)	
				triggerZone:setPosition(absolutCoords.x, absolutCoords.y)	
				if triggerZone:getType() == 2 then	
					triggerZone:setPoints(absolutCoords.verticies)	
				end
				module_mission.linkTriggerZone(triggerZone:getId(), triggerZoneTable.linkUnit)	
			else
				local points = {}
				if triggerZoneTable.type == 2 then
					for k,v in ipairs(triggerZoneTable.verticies) do
						table.insert(points,{x = v.x - triggerZoneTable.x ,y = v.y - triggerZoneTable.y})
					end
					triggerZone:setPoints(points)
				end						
			end
			triggerZone:setHeading(triggerZoneTable.heading)
		end
	end
end

function calcLocalCoords(unit, zone)
	local localCoords = {}
	
	local x, y = zone:getPosition()
	
	localCoords.x =  x - unit.x
	localCoords.y =  y - unit.y

	if zone:getType() == 2 then
		local points = TableUtils.copyTable(nil, zone:getPoints())   -- в зоне они относительно центра
		
		for k, v in pairs(points) do -- unit.heading
			v.x = localCoords.x + v.x 
			v.y = localCoords.y + v.y
		end
		
		localCoords.verticies = points
	else
	
	end

	return localCoords
end

function calcAbsolutCoords(unit, zone)
	local absolutCoords = {}
	
	local x, y = zone:getPosition()
	absolutCoords.x = unit.x + x
	absolutCoords.y = unit.y + y
	
	if zone:getType() == 2 then
		local points = TableUtils.copyTable(nil, zone:getPoints())   -- в зоне они относительно центра
		
		for k, v in pairs(points) do  -- в зоне они относительно центра
			v.x = -v.x + absolutCoords.x - unit.x
			v.y = -v.y + absolutCoords.y - unit.y 
		end
		
		absolutCoords.verticies = points
	else
	
	end
	
	return absolutCoords
end

local function removeAllZones()
	local toRemove = {}
	for i, triggerZone in ipairs(triggerZones_) do
		table.insert(toRemove, triggerZone:getId())
	end
	
	for k,v in ipairs(toRemove) do
		removeTriggerZone(v)
	end
end

local function updateLocalCoords(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	if triggerZone:getLinkUnitId() ~= nil then
		local unit = module_mission.unit_by_id[triggerZone:getLinkUnitId()]
		local localCoords = calcLocalCoords(unit, triggerZone)			
		triggerZone:setLocalCoords(localCoords)	
	end
end

local function saveTriggerZones()
	local triggerZonesTable = {}
	
	for i, triggerZone in ipairs(triggerZones_) do
		local x, y = triggerZone:getPosition()
		
		local tmp = {
			zoneId		= triggerZone:getId(),
			name		= triggerZone:getName(),
			radius		= triggerZone:getRadius(),
			color		= {triggerZone:getColor()},
			x			= x,
			y			= y,
			hidden		= triggerZone:getHidden(),
			properties  = triggerZone:getProperties(),
			type		= triggerZone:getType(),
			linkUnit	= triggerZone:getLinkUnitId(),
			heading		= triggerZone:getHeading()
		}
		
		if triggerZone:getLinkUnitId() ~= nil then
			local unit = module_mission.unit_by_id[triggerZone:getLinkUnitId()]
			local localCoords = calcLocalCoords(unit, triggerZone)			
			tmp.x = localCoords.x
			tmp.y = localCoords.y
			if tmp.type == 2 then
				tmp.verticies = localCoords.verticies		
			end
		else		
			if tmp.type == 2 then
				local points = {}
				for k,v in ipairs(triggerZone:getPoints()) do
					table.insert(points,{x = v.x + tmp.x ,y = v.y + tmp.y})
				end
				tmp.verticies = points		
			end	
		end
		
		table.insert(triggerZonesTable, tmp)
	end
	
	return triggerZonesTable
end

local function linkToUnit(triggerZoneId, unitId)
	local triggerZone = getTriggerZone(triggerZoneId)
	triggerZone:setLinkUnitId(unitId)
	
	local unit = module_mission.unit_by_id[unitId]
	local localCoords = calcLocalCoords(unit, triggerZone)			
	triggerZone:setLocalCoords(localCoords)	
	triggerZone:setHeading(unit.heading or 0)
end

local function unlinkToUnit(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	triggerZone:setLinkUnitId(nil)
	triggerZone:setLocalCoords(nil)
	triggerZone:setHeading(0)
end

local function getLinkUnitId(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	return triggerZone:getLinkUnitId()
end

local function updateHeading(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	
	if triggerZone:getLinkUnitId() then	
		local unit = module_mission.unit_by_id[triggerZone:getLinkUnitId()]
		
		local heading = unit.heading - triggerZone:getHeading()		
		triggerZone:setHeading(triggerZone:getHeading() + heading)
		local curX, curY = triggerZone:getPosition()
		
		curX = curX - unit.x
		curY = curY - unit.y
		
		local x = curX*math.cos(heading) - curY*math.sin(heading)
		local y = curX*math.sin(heading) + curY*math.cos(heading)
		
		x = x + unit.x
		y = y + unit.y
		triggerZone:setPosition(x, y)
		
		if triggerZone:getType() == 2 then
			local points = TableUtils.copyTable(nil, triggerZone:getPoints())   -- в зоне они относительно центра
			
			for k, v in pairs(points) do 
				local tmpX = v.x
				local tmpY = v.y
				v.x = tmpX*math.cos(heading) - tmpY*math.sin(heading)
				v.y = tmpX*math.sin(heading) + tmpY*math.cos(heading)	
			end
			
			setTriggerZonePoints(triggerZoneId, points)
		end	
		
		local localCoords = calcLocalCoords(unit, triggerZone)			
		triggerZone:setLocalCoords(localCoords)	
	else
		triggerZone:setHeading(0)
	end
	
	if controller_ then
		controller_.triggerZonePositionChanged(triggerZoneId)
	end
end

local function getLocalCoords(triggerZoneId)
	local triggerZone = getTriggerZone(triggerZoneId)
	return triggerZone:getLocalCoords()
end	

return {
	setController			= setController,
	setMissionData			= setMissionData,
		
	onNewMission			= onNewMission,
	
	addTriggerZone			= addTriggerZone,
	removeTriggerZone		= removeTriggerZone,
	
	setTriggerZoneRadius	= setTriggerZoneRadius,
	getTriggerZoneRadius	= getTriggerZoneRadius,
	
	setTriggerZonePoints 	= setTriggerZonePoints,
	getTriggerZonePoints	= getTriggerZonePoints,
	
	setTriggerZonePointsAbsolut = setTriggerZonePointsAbsolut,
	getTriggerZonePointsAbsolut	= getTriggerZonePointsAbsolut,
	updateTriggerZonePosition	= updateTriggerZonePosition,
	
	setTriggerZoneType		= setTriggerZoneType,
	getTriggerZoneType		= getTriggerZoneType,
	
	setTriggerZoneName		= setTriggerZoneName,
	getTriggerZoneName		= getTriggerZoneName,
	
	setTriggerZoneColor		= setTriggerZoneColor,
	getTriggerZoneColor		= getTriggerZoneColor,
	
	setTriggerZoneProperties	= setTriggerZoneProperties,
	getTriggerZoneProperties	= getTriggerZoneProperties,
	
	setTriggerZoneHidden	= setTriggerZoneHidden,
	getTriggerZoneHidden	= getTriggerZoneHidden,
	
	setTriggerZonePosition	= setTriggerZonePosition,
	getTriggerZonePosition	= getTriggerZonePosition,
	
	getTriggerZone			= getTriggerZoneClone,
	getTriggerZoneIds		= getTriggerZoneIds,
	getTriggerZoneExists	= getTriggerZoneExists,
	
	loadTriggerZones		= loadTriggerZones,
	saveTriggerZones		= saveTriggerZones,
	
	removeAllZones			= removeAllZones,
	linkToUnit				= linkToUnit,
	getLinkUnitId			= getLinkUnitId,
	unlinkToUnit			= unlinkToUnit,
	updateHeading			= updateHeading,
	getLocalCoords			= getLocalCoords,
	updateLocalCoords		= updateLocalCoords,
}