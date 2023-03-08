local base = _G

local require			= base.require
local pairs				= base.pairs
local ipairs			= base.ipairs
local print				= base.print
local table				= base.table
local string			= base.string
local tonumber			= base.tonumber
local tostring			= base.tostring
local assert			= base.assert
local math				= base.math

local MissionData		= require('Mission.Data')
local AirdromeData		= require('Mission.AirdromeData')
local BeaconData		= require('Mission.BeaconData')
local MapWindow			= require('me_map_window')
local MapColor			= require('MapColor')
local U					= require('me_utilities')
local UC				= require('utils_common')
local UpdateManager		= require('UpdateManager')
local TableUtils 		= require('TableUtils')
local DB 				= require('me_db_api')

local triggerZoneController_
local navigationPointController_
local airdromeController_
local triggerZoneMapObjects_		= {}
local navigationPointMapObjects_	= {}
local airdromeMapObjects_			= {}
local unitWarehousesMapObjects_		= {}
local unitFueldepotsMapObjects_		= {}
local beaconMapObjects_				= {}
local pickMapObjects_				= {}
local supplierArrows_				= {}
local pickWarehouses_				= {}
local selectionMapObjects_			= {}
local navPointTypesById_ 			= DB.getTypesNavPointsById()

-- FIXME: id объектов карты не должны перекрываться с уже существующими(созданными в me_mission)
local mapIdCounter_ = 10000000 

local beaconTextOffsetX	= 15
local beaconTextOffsetY	= -10

local function resetMapIdCounter()
	mapIdCounter_ = 10000000
end

local function getNextMapId()
	mapIdCounter_ = mapIdCounter_ + 1
	
	return mapIdCounter_
end

local function setTriggerZoneController(controller)
	triggerZoneController_ = controller
end

local function setNavigationPointController(controller)
	navigationPointController_ = controller
end

local function setAirdromeController(controller)
	airdromeController_ = controller
end

local function pickObjects(x, y, radius, lastObjectId)
	local objectIds = {}
	local mapIds = MapWindow.findUserObjects(x, y, radius)
	
	-- начинаем с объектов, лежащих ближе всего к наблюдателю
	for i = #mapIds, 1, -1 do
		local mapId = mapIds[i]
		local objectId = pickMapObjects_[mapId]
		
		if #mapIds == 1 or lastObjectId ~= objectId then
			table.insert(objectIds, objectId)
		end
	end
	
	return objectIds
end

local function pickWarehouse(x, y, radius)
	local mapIds = MapWindow.findUserObjects(x, y, radius)
	
	-- начинаем с объектов, лежащих ближе всего к наблюдателю
	for i = #mapIds, 1, -1 do
		local mapId = mapIds[i]
		local unitId = pickWarehouses_[mapId]
		
		if unitId then
			return unitId
		end
	end
end

local function createCaption(classKey, x, y, text, offsetX, offsetY, color, angle, lineHeight, align)
	return MapWindow.createTIT(classKey, getNextMapId(), x, y, text, color, angle, lineHeight, align, offsetX, offsetY)
end

local function createIcon(classKey, x, y, angle, color)
	return MapWindow.createDOT(classKey, getNextMapId(), x, y, angle, color)
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

-- FIXME: передавать в виджет центр и радиус
local function createCircle(classKey, x, y, radius, color, stencil)
	local points = createCirclePoints(x, y, radius)

	return MapWindow.createSQR(classKey, getNextMapId(), points, color, stencil)
end

local function createTriggerZoneIcon(triggerZone, color)
	local x, y = triggerZone:getPosition()
	local icon = createIcon('TriggerZoneIcon', x, y, 0, MapColor.copyNoAlpha(color))
	
	return icon
end

local function setMapObjectPosition(object, x, y)
	object.data.x = x
	object.data.y = y	
end

local function updateMapObject(object)
	MapWindow.updateUserObject2(object.id, object.data)	
end

local function setIconPosition(icon, x, y)
	icon.x = x
	icon.y = y
end

local function setIconColor(icon, color)
	icon.color = color
end

local function createTriggerZoneCaption(triggerZone, color)
	local x, y			= triggerZone:getPosition()
	local text			= triggerZone:getName()
	local offsetX		= 10
	local offsetY		= -10
	local caption		= createCaption('TriggerZoneCaption', x, y, text, offsetX, offsetY, MapColor.copyNoAlpha(color))
	
	caption.shadowColor	= MapColor.new(0, 0, 0, 180/255)
	
	return caption
end

local function setCaptionPosition(caption, x, y)
	caption.x	= x
	caption.y	= y	
end

local function setCaptionColor(caption, color, blurColor)
	caption.color		= color
	caption.blurColor	= blurColor
end

local function setCaptionText(caption, text)
	caption.title = text
end

local function createTriggerZonePlane(triggerZone)
	local stencil = 3
	local x, y = triggerZone:getPosition()
	local color = MapColor.new(triggerZone:getColor())
	local points 
	local plane
	
	if triggerZone:getType() == 0 then
		points = createCirclePoints(0, 0, triggerZone:getRadius())
		plane = MapWindow.createSQR('TriggerZone', getNextMapId(), points, color, stencil)
	else
		points = triggerZone:getPoints()
		plane = MapWindow.createSQR('TriggerZone', getNextMapId(), points, color, stencil)
	end

	plane.x = x
	plane.y = y
	
	plane.zOrder = -100 -- должен рисоваться первым
	
	return plane
end

local function createCircleLinePoints(x, y, radius)
	local points = createCirclePoints(x, y, radius)
	
	table.insert(points, points[1])
	
	return points
end

local function createTriggerZonePolyline(triggerZone)
	local x, y = triggerZone:getPosition()
	local points
	local plane
	
	local color =  MapColor.new(triggerZone:getColor())	
	color[4] = color[4] * 2

	if color[4] > 1 then
		color[4] = 1
	end

	if triggerZone:getType() == 0 then
		points			= createCircleLinePoints(0, 0, triggerZone:getRadius())
		plane = MapWindow.createPLN('TriggerZoneSelectionPolyline', getNextMapId(), points, MapColor.copy(color))
	else
		points = triggerZone:getPoints()
		local pointsTmp = {}
		TableUtils.copyTable(pointsTmp, points)
		table.insert(pointsTmp,points[1])
		plane = MapWindow.createPLN('TriggerZoneSelectionPolyline', getNextMapId(), pointsTmp, MapColor.copy(color))
	end
	
	plane.x = x
	plane.y = y
	
	return plane
end

local function createTriggerZoneSelectionPlane(triggerZone)
	local x, y = triggerZone:getPosition()
	local points 
	local plane
	
	if triggerZone:getType() == 0 then
		points = createCirclePoints(0, 0, triggerZone:getRadius())
		plane = MapWindow.createSQR('TriggerZoneSelected', getNextMapId(), points)
	else
		points = triggerZone:getPoints()
		plane = MapWindow.createSQR('TriggerZoneSelected', getNextMapId(), points)
	end
	
	plane.x = x
	plane.y = y
	
	plane.zOrder = -100 -- должен рисоваться первым
	
	return plane
end


local function createTriggerZoneSelectionPolyline(triggerZone)
	local x, y = triggerZone:getPosition()
	local points
	local plane
	
	if triggerZone:getType() == 0 then
		points			= createCircleLinePoints(0, 0, triggerZone:getRadius())
		plane = MapWindow.createPLN('TriggerZoneSelectionPolyline', getNextMapId(), points)
	else
		points = triggerZone:getPoints()
		local pointsTmp = {}
		TableUtils.copyTable(pointsTmp, points)
		table.insert(pointsTmp,points[1])
		plane = MapWindow.createPLN('TriggerZoneSelectionPolyline', getNextMapId(), pointsTmp)
	end
	
	plane.x = x
	plane.y = y
	
	return plane
end

local function getTriggerZoneVisible(triggerZone)	
	return not triggerZone:getHidden()
end

local function getTriggerZone(triggerZoneId)
	return triggerZoneController_.getTriggerZone(triggerZoneId)
end

local function addTriggerZone(triggerZoneId)
	local triggerZone	= getTriggerZone(triggerZoneId)
	local color			= MapColor.new(triggerZone:getColor())			
	local icon			= createTriggerZoneIcon(triggerZone, color)
	local caption		= createTriggerZoneCaption(triggerZone, color)
	local plane 		= createTriggerZonePlane(triggerZone)
	local polyline 		= createTriggerZonePolyline(triggerZone)
	
	local mapObjects	= {
		plane 	= {id = MapWindow.createUserObject2(plane	), data = plane		},
		icon	= {id = MapWindow.createUserObject2(icon	), data = icon		},
		caption	= {id = MapWindow.createUserObject2(caption	), data = caption	},
		polyline= {id = MapWindow.createUserObject2(polyline), data = polyline	},
	}
	
	triggerZoneMapObjects_[triggerZoneId] = mapObjects
	
	if getTriggerZoneVisible(triggerZone) then
		
		MapWindow.addUserObject2(mapObjects.plane	.id)
		MapWindow.addUserObject2(mapObjects.icon	.id)
		MapWindow.addUserObject2(mapObjects.caption	.id)
		MapWindow.addUserObject2(mapObjects.polyline.id)
		
		pickMapObjects_[mapObjects.icon.id] = triggerZoneId
	end	
end

local function removeTriggerZone(triggerZoneId)
	local triggerZone	= getTriggerZone(triggerZoneId)
	local mapObjects 	= triggerZoneMapObjects_[triggerZoneId]
	
	for name, mapObject in pairs(mapObjects) do
		MapWindow.deleteUserObject2(mapObject.id)
	end
	
	pickMapObjects_[mapObjects.icon.id]	= nil
	triggerZoneMapObjects_[triggerZoneId]	= nil
end

local function selectTriggerZone(triggerZoneId)
	local triggerZone	= getTriggerZone(triggerZoneId)
	local mapObjects	= triggerZoneMapObjects_[triggerZoneId]
	local visible		= getTriggerZoneVisible(triggerZone)
	
	local fillingData = createTriggerZoneSelectionPlane(triggerZone)

	if selectionMapObjects_.filling then
		selectionMapObjects_.filling.data = fillingData
	else
		selectionMapObjects_.filling = {
			id		=  MapWindow.createUserObject2(fillingData),
			data	= fillingData,
		}
	end
	
	local polylineData = createTriggerZoneSelectionPolyline(triggerZone)
	
	if selectionMapObjects_.polyline then
		selectionMapObjects_.polyline.data = polylineData
	else
		selectionMapObjects_.polyline = {
			id		=  MapWindow.createUserObject2(polylineData),
			data	= polylineData,
		}
	end

	if visible then
		updateMapObject(selectionMapObjects_.filling)
		updateMapObject(selectionMapObjects_.polyline)
		
		local needRedraw = true
		
		MapWindow.addUserObject2(selectionMapObjects_.filling	.id, needRedraw)			
		MapWindow.addUserObject2(selectionMapObjects_.polyline	.id, needRedraw)

		MapWindow.removeUserObject2(mapObjects.plane.id)
	else	
		updateMapObject(selectionMapObjects_.filling)
		updateMapObject(selectionMapObjects_.polyline)
	end
		
	selectionMapObjects_.triggerZoneId = triggerZoneId
end

local function deselectTriggerZone(triggerZoneId)
	if selectionMapObjects_.triggerZoneId == triggerZoneId then
		local triggerZone	= getTriggerZone(triggerZoneId)
		local mapObjects	= triggerZoneMapObjects_[triggerZoneId]
		local visible		= getTriggerZoneVisible(triggerZone)
		
		if visible then
			MapWindow.removeUserObject2(selectionMapObjects_.filling	.id)
			MapWindow.removeUserObject2(selectionMapObjects_.polyline	.id)
			
			MapWindow.addUserObject2(mapObjects.plane.id)					
		end
	end
end

local function getNavigationPoint(navigationPointId)
	return navigationPointController_.getNavigationPoint(navigationPointId)
end

local function selectNavigationPoint(navigationPointId)
	local mapObjects = navigationPointMapObjects_[navigationPointId]
	
	MapWindow.removeUserObjects(mapObjects)	
	
	local icon = mapObjects[1]
	
	icon.color = MapColor.new(1, 1, 0)
	
	MapWindow.addUserObjects(mapObjects)
end

local function selectAirdrome(objectId)
	local mapObjects = airdromeMapObjects_[objectId]
	
	MapWindow.removeUserObjects(mapObjects)	
	
	local icon = mapObjects[2]
	
	icon.color = MapColor.new(1, 1, 0.5)
	
	MapWindow.addUserObjects(mapObjects)
end

local function selectObject(objectId)
	local objectType = MissionData.getObjectType(objectId)
	
	if MissionData.triggerZoneType() == objectType then
		selectTriggerZone(objectId)
	elseif MissionData.navigationPointType() == objectType then
		selectNavigationPoint(objectId)
	elseif	MissionData.airdromeType() == objectType then
		selectAirdrome(objectId)
	end
end

local function getCoalitionColor(coalitionName)
	if MissionData.redCoalitionName() == coalitionName then
		return MapColor.new(1, 0, 0)
	elseif MissionData.blueCoalitionName() == coalitionName then
		return MapColor.new(0, 0, 1)
	elseif  MissionData.neutralCoalitionName() == coalitionName then
		return MapColor.new(0.91, 0.91, 0.91)	
	else
		return MapColor.new(1, 1, 1)
	end
end

local function deselectNavigationPoint(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	local mapObjects = navigationPointMapObjects_[navigationPointId]
	
	MapWindow.removeUserObjects(mapObjects)
	
	local icon = mapObjects[1]
	
	if navigationPoint:getType() == 'Default' then
		icon.color = getCoalitionColor(navigationPoint:getCoalitionName())
	else	
		icon.color = MapColor.new(1, 1, 1)
	end

	MapWindow.addUserObjects(mapObjects)
end

local function deselectAirdrome(objectId)
	local mapObjects = airdromeMapObjects_[objectId]
	
	MapWindow.removeUserObjects(mapObjects)	
	
	local icon = mapObjects[2]
	
	icon.color = MapColor.new(1, 1, 1)
	
	MapWindow.addUserObjects(mapObjects)
end

local function deselectObject(objectId)
	local objectType = MissionData.getObjectType(objectId)
	
	if objectType then
		if MissionData.triggerZoneType() == objectType then
			deselectTriggerZone(objectId)
		elseif MissionData.navigationPointType() == objectType then
			deselectNavigationPoint(objectId)
		elseif MissionData.airdromeType() == objectType then
			deselectAirdrome(objectId)
		end
	end
end

local function createAirdromeWarehouseArea(airdrome)
	local bounds	= airdrome:getBounds()
	local classKey	= 'AirdromeWarehouse'
	
	if bounds then
		local points = {}
		
		for i, pointData in ipairs(bounds) do
			table.insert(points, MapWindow.createPoint(pointData[1], pointData[2]))
		end
		
		return MapWindow.createSQR(classKey, getNextMapId(), points)
	else
		local x, y		= airdrome:getPosition()
		local radius	= 2000

		return createCircle(classKey, x, y, radius)
	end
end

local function triggerZoneRadiusChanged(triggerZoneId)
	local triggerZone	= getTriggerZone(triggerZoneId)
	local mapObjects	= triggerZoneMapObjects_[triggerZoneId]
	local visible		= getTriggerZoneVisible(triggerZone)
	
	mapObjects.plane.data		= createTriggerZonePlane(triggerZone)
	mapObjects.polyline.data	= createTriggerZonePolyline(triggerZone)
	
	if visible then
		updateMapObject(mapObjects.plane)
		updateMapObject(mapObjects.polyline)
		
		if selectionMapObjects_.triggerZoneId == triggerZoneId then
			selectionMapObjects_.filling.data	= createTriggerZoneSelectionPlane	(triggerZone)
			selectionMapObjects_.polyline.data	= createTriggerZoneSelectionPolyline(triggerZone)
			
			updateMapObject(selectionMapObjects_.filling	)
			updateMapObject(selectionMapObjects_.polyline	)			
		end
	end	
end

local function triggerZoneNameChanged(triggerZoneId)
	local triggerZone	= getTriggerZone(triggerZoneId)
	local mapObjects	= triggerZoneMapObjects_[triggerZoneId]
	
	setCaptionText(mapObjects.caption.data, triggerZone:getName())
	
	if getTriggerZoneVisible(triggerZone) then
		updateMapObject(mapObjects.caption)
	end	
end

local function triggerZoneColorChanged(triggerZoneId)
	local triggerZone	= getTriggerZone(triggerZoneId)
	local mapObjects	= triggerZoneMapObjects_[triggerZoneId]
	local color			= MapColor.new(triggerZone:getColor())
	
	mapObjects.plane.data.color	= color
	
	local colorBorder			= MapColor.new(triggerZone:getColor())
	colorBorder[4] = colorBorder[4] * 2

	if colorBorder[4] > 1 then
		colorBorder[4] = 1
	end
	mapObjects.polyline.data.color	= colorBorder
	
	setIconColor	(mapObjects.icon.data	, MapColor.copyNoAlpha(color))
	setCaptionColor	(mapObjects.caption.data, MapColor.copyNoAlpha(color))
	
	if  getTriggerZoneVisible(triggerZone) then
		for name, mapObject in pairs(mapObjects) do
			updateMapObject(mapObject)
		end
	end	
end

local function triggerZoneHiddenChanged(triggerZoneId)
	local triggerZone	= getTriggerZone(triggerZoneId)
	local mapObjects	= triggerZoneMapObjects_[triggerZoneId]
	local visible		= getTriggerZoneVisible(triggerZone)
	
	for name, mapObject in pairs(mapObjects) do
		if visible then
			updateMapObject(mapObject)
			MapWindow.addUserObject2(mapObject.id)	
			pickMapObjects_[mapObjects.icon.id] = triggerZoneId
		else
			MapWindow.removeUserObject2	(mapObject.id)
		end
	end
	
	if visible then
		if selectionMapObjects_.triggerZoneId == triggerZoneId then
			MapWindow.addUserObject2(selectionMapObjects_.filling.id, true)			
			MapWindow.addUserObject2(selectionMapObjects_.polyline.id, true)
	
			setMapObjectPosition(selectionMapObjects_.filling, x, y)
			setMapObjectPosition(selectionMapObjects_.polyline, x, y)
			
			updateMapObject(selectionMapObjects_.filling)
			updateMapObject(selectionMapObjects_.polyline)
		end
	else
		if selectionMapObjects_.triggerZoneId == triggerZoneId then
			MapWindow.removeUserObject2(selectionMapObjects_.filling.id)
			MapWindow.removeUserObject2(selectionMapObjects_.polyline.id)
		end
	end
end

local function triggerZonePositionChanged(triggerZoneId)
	local triggerZone	= getTriggerZone(triggerZoneId)
	local mapObjects	= triggerZoneMapObjects_[triggerZoneId]
	local visible		= getTriggerZoneVisible(triggerZone)	
	local x, y			= triggerZone:getPosition()
	
	for name, mapObject in pairs(mapObjects) do
		setMapObjectPosition(mapObject, x, y)
		
		if visible then
			if selectionMapObjects_.triggerZoneId == triggerZoneId then
				setMapObjectPosition(selectionMapObjects_.filling	, x, y)
				setMapObjectPosition(selectionMapObjects_.polyline	, x, y)
				
				updateMapObject(selectionMapObjects_.filling	)
				updateMapObject(selectionMapObjects_.polyline	)
			end
			
			updateMapObject(mapObject)
		end
	end
end

local function triggerZoneTypeChanged(triggerZoneId)
	local triggerZone	= getTriggerZone(triggerZoneId)
	local mapObjects	= triggerZoneMapObjects_[triggerZoneId]
	
	mapObjects.plane.data 	= createTriggerZonePlane(triggerZone)
	mapObjects.polyline.data= createTriggerZonePolyline(triggerZone)
	
	if getTriggerZoneVisible(triggerZone) then
		updateMapObject(mapObjects.plane)
		updateMapObject(mapObjects.polyline)
		
		if selectionMapObjects_.triggerZoneId == triggerZoneId then
			selectionMapObjects_.filling	.data = createTriggerZoneSelectionPlane	(triggerZone)	
			selectionMapObjects_.polyline	.data = createTriggerZoneSelectionPolyline(triggerZone)
			
			updateMapObject(selectionMapObjects_.filling	)
			updateMapObject(selectionMapObjects_.polyline	)
		end
	end
end

local function updateTriggerZone(triggerZoneId)
	local triggerZone	= getTriggerZone(triggerZoneId)
	local mapObjects	= triggerZoneMapObjects_[triggerZoneId]
	local x, y			= triggerZone:getPosition()

	mapObjects.plane.data = createTriggerZonePlane(triggerZone)
	mapObjects.polyline.data= createTriggerZonePolyline(triggerZone)
	
	if selectionMapObjects_.triggerZoneId == triggerZoneId then
		selectionMapObjects_.filling.data	= createTriggerZoneSelectionPlane	(triggerZone)
		selectionMapObjects_.polyline.data	= createTriggerZoneSelectionPolyline(triggerZone)
		
		updateMapObject(selectionMapObjects_.filling	)
		updateMapObject(selectionMapObjects_.polyline	)			
	end
	
	for name, mapObject in pairs(mapObjects) do
		setMapObjectPosition(mapObject, x, y)
		updateMapObject(mapObject)		
	end
end

local function createNavigationPointIcon(navigationPoint, color, mapclasskey)
	local x, y = navigationPoint:getPosition()
	local icon = createIcon(mapclasskey, x, y, 0, color)
	
	return icon
end

local function createNavigationPointCaption(navigationPoint, color)
	local x, y		= navigationPoint:getPosition()
	local text		= navigationPoint:getName()
	local offsetX	= 20
	local offsetY	= -20
	local caption	= createCaption('NavigationPointCallsign', x, y, text, offsetX, offsetY, color)
	
	return caption	
end

local function createNavigationPointDescription(navigationPoint, color)
	local x, y		= navigationPoint:getPosition()
	local text		= navigationPoint:getDescription()
	local offsetX	= 10
	local offsetY	= 20
	local caption	= createCaption('NavigationPointDescription', x, y, text, offsetX, offsetY, color)
	
	return caption	
end

local function addNavigationPoint(navigationPointId)
	local navigationPoint	= getNavigationPoint(navigationPointId)
	local color	= getCoalitionColor(navigationPoint:getCoalitionName())
	local colorIcon
	if navigationPoint:getType() == 'Default' then
		colorIcon = getCoalitionColor(navigationPoint:getCoalitionName())
	else	
		colorIcon = MapColor.new(1, 1, 1)
	end
	
--	if navigationPoint:getType() ~= "Military" then
		local icon				= createNavigationPointIcon(navigationPoint, colorIcon, navPointTypesById_[navigationPoint:getType()].mapclasskey)
		local caption			= createNavigationPointCaption(navigationPoint, color)
		local description		= createNavigationPointDescription(navigationPoint, color)
		local mapObjects		= {icon, caption, description}
		
		navigationPointMapObjects_[navigationPointId] = mapObjects
		pickMapObjects_[icon.id] = navigationPointId
		
		MapWindow.addUserObjects(mapObjects)
--[[	else
		local icon				= createNavigationPointIcon(navigationPoint, colorIcon, "MilitaryWaypoint")
		local caption			= createNavigationPointCaption(navigationPoint, color)
		local description		= createNavigationPointDescription(navigationPoint, color)		
		local mapObjects		= {icon, caption, description}
		
		icon.layers =
		{
			{
				is_background             = true,-- в этом случае  объект будет использоваться как  маска для обрезки
				---------------------------------------------------------------------------------------------------
				file                      = "./CoreMods/services/MC/Classifier/common/MilitaryWaypoints/test1.png", 
			--	offset                    = {0,0} -- relative , optional
				color                     = MapColor.new(1, 1, 1),
			--	text_overlay            = "text", --optional
				text_color                = MapColor.new(1, 1, 1),
			--	font                    = "font name", --optional
			--	text_offset                = {0,0},
			--	clip_with_background         = true,-- в этом случае  объект будет клипаться 
			--	clip_text_with_background     = true,
			},
			{
				file                      = "./CoreMods/services/MC/Classifier/common/MilitaryWaypoints/test2.png", 
			--	offset                    = {0,0} -- relative , optional
				color                     = MapColor.new(1, 1, 1),
			--	text_overlay            = "text", --optional
			--	text_color                = MapColor.new(1, 1, 1),
			--	font                    = "font name", --optional
			--	text_offset                = {0,0},
			--	clip_with_background         = true,-- в этом случае  объект будет клипаться 
			--	clip_text_with_background     = true,
			},
			{
				file                      = "./CoreMods/services/MC/Classifier/common/MilitaryWaypoints/test3.png", 
			--	offset                    = {0,0} -- relative , optional
				color                     = MapColor.new(1, 1, 1),
			--	text_overlay            = "text", --optional
			--	text_color                = MapColor.new(1, 1, 1),
			--	font                    = "font name", --optional
			--	text_offset                = {0,0},
			--	clip_with_background         = true,-- в этом случае  объект будет клипаться 
			--	clip_text_with_background     = true,
			}
		}
		
		navigationPointMapObjects_[navigationPointId] = mapObjects
		pickMapObjects_[icon.id] = navigationPointId
		
		MapWindow.addUserObjects(mapObjects)
	end]]
end

local function removeNavigationPoint(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	local mapObjects = navigationPointMapObjects_[navigationPointId]
	
	for i, mapObject in ipairs(mapObjects) do
		pickMapObjects_[mapObject.id] = nil
	end
	
	navigationPointMapObjects_[navigationPointId] = nil
	
	MapWindow.removeUserObjects(mapObjects)
end

local function getAirdromeIconClassKey(airdrome)
	local class = airdrome:getClass()
	if '1' == class then	
		return 'AirdromeClass1'
	elseif '2' == class then
		return 'AirdromeClass2'
	elseif '3' == class then
		return 'AirdromeClass3'
	else
		return 'AirdromeClassNone'
	end
end

local function createAirdromeIcon(airdrome)
	local x, y = airdrome:getPosition()
	local classKey = getAirdromeIconClassKey(airdrome)
	local color = MapColor.new(1, 1, 1)
	local angle = airdrome:getAngle()
	
	local icon = createIcon(classKey, x, y, angle, color)
	
	return icon
end

local function createAirdromeSupplierIcon(airdrome, color)
	local x, y = airdrome:getPosition()
	local icon = createIcon('AirdromeSupplierIcon', x, y, 0, MapColor.new(0.91, 0.91, 0.91))
	
	return icon
end

local function isEnableIcon(a_coords, a_x, a_y, a_radius)
	for k,v in base.pairs(a_coords) do
		if math.abs(v.x - a_x) < a_radius and math.abs(v.y - a_y) < a_radius then
			return true
		end
	end
	return false
end

local function createUnitWarehouses(airdrome, color)
	local icons = {}
	local warehouses = airdrome:getWarehouses()	

	local coords = {}
	if warehouses then
		for k,v in base.pairs(warehouses) do
			if isEnableIcon(coords,v.x, v.y, 15) == false then
				local icon = createIcon('AirdromeWarehouseTerrain', v.x, v.y, 0, color)
				table.insert(icons,icon)
				table.insert(coords,{x = v.x, y = v.y})
			end

		end
		
		-- 1lvl 200 метров объединяем в одну иконку		
		local coords1 = {}
		for k,v in base.pairs(warehouses) do
			if isEnableIcon(coords1,v.x, v.y, 50) == false then
				local icon = createIcon('AirdromeWarehouseTerrainOneLvl', v.x, v.y, 0, color)
				table.insert(icons,icon)
				table.insert(coords1,{x = v.x, y = v.y})
			end
			

		end
		
		-- 2lvl
		local coords2 = {}
		for k,v in base.pairs(warehouses) do
			if isEnableIcon(coords2,v.x, v.y, 200) == false then
				local icon = createIcon('AirdromeWarehouseTerrainTwoLvl', v.x, v.y, 0, color)
				table.insert(icons,icon)
				table.insert(coords2,{x = v.x, y = v.y})
			end
		end
		
	end
	return icons
end

local function createUnitFueldepots(airdrome, color)
	local icons = {}
	local fueldepots = airdrome:getFueldepots()
	local xOne = 0
	local yOne = 0

	if fueldepots then
		
		local coords = {}
		for k,v in base.pairs(fueldepots) do
			if isEnableIcon(coords,v.x, v.y, 15) == false then
				local icon = createIcon('AirdromeFueldepotsTerrain', v.x, v.y, 0, color)
				table.insert(icons,icon)
				table.insert(coords,{x = v.x, y = v.y})
			end

		end
		
		-- 1lvl 200 метров объединяем в одну иконку		
		local coords1 = {}
		for k,v in base.pairs(fueldepots) do
			if isEnableIcon(coords1,v.x, v.y, 50) == false then
				local icon = createIcon('AirdromeFueldepotsTerrainOneLvl', v.x, v.y, 0, color)
				table.insert(icons,icon)
				table.insert(coords1,{x = v.x, y = v.y})
			end
			

		end
		
		-- 2lvl
		local coords2 = {}
		for k,v in base.pairs(fueldepots) do
			if isEnableIcon(coords2,v.x, v.y, 200) == false then
				local icon = createIcon('AirdromeFueldepotsTerrainTwoLvl', v.x, v.y, 0, color)
				table.insert(icons,icon)
				table.insert(coords2,{x = v.x, y = v.y})
			end
		end
	end
	
	

	return icons
end

local function createAirdromeCaption(airdrome, color, blurColor)
	local x, y		= airdrome:getPosition()
	local text		= airdrome:getName()
	local offsetX	= 20
	local offsetY	= -20
	local caption	= createCaption('AirdromeCaption', x, y, text, offsetX, offsetY, color)
	
	caption.blurColor = blurColor
	
	return caption	
end

local function getAirdromeCoalitionColor(airdrome)
	local coalitionName = airdrome:getCoalitionName()
	
	return getCoalitionColor(coalitionName)
end

local function getAirdromeCoalitionBlurColor(airdrome)
	local coalitionName = airdrome:getCoalitionName()
	
	if MissionData.redCoalitionName() == coalitionName then
		return MapColor.new(150 / 255, 150 / 255, 150 / 255)
	elseif MissionData.blueCoalitionName() == coalitionName then
		return MapColor.new(150 / 255, 150 / 255, 150 / 255)
	else
		return MapColor.new(0, 0, 0)
	end
end

local function createAirdromeCircleZone(airdrome)
	local x, y		= airdrome:getPosition()
	local radius	= 2000
	local points	= createCircleLinePoints(x, y, radius)

	return MapWindow.createLIN('AirdromeCircleZoneBorder', getNextMapId(), points)
end

local function addAirdrome(airdrome)
	local color				= getAirdromeCoalitionColor(airdrome)
	local blurColor			= getAirdromeCoalitionBlurColor(airdrome)
	local warehouse			= createAirdromeWarehouseArea(airdrome)
	local icon				= createAirdromeIcon(airdrome)
	local supplierIcon		= createAirdromeSupplierIcon(airdrome, color)
	local caption			= createAirdromeCaption(airdrome, color, blurColor)
	local circle			= createAirdromeCircleZone(airdrome)
	local mapObjects		= {warehouse, icon, supplierIcon, caption, circle}
	local id				= airdrome:getId()
	local unitWarehouses	= createUnitWarehouses(airdrome,color)		
	for k,v in base.pairs(unitWarehouses) do
		base.table.insert(mapObjects, v)
	end
	
	local unitFueldepots	= createUnitFueldepots(airdrome,color)	
	for k,v in base.pairs(unitFueldepots) do
		base.table.insert(mapObjects, v)
	end
	
	unitWarehousesMapObjects_[id]		= unitWarehouses
	unitFueldepotsMapObjects_[id]		= unitFueldepots
	airdromeMapObjects_[id]				= mapObjects
	pickMapObjects_[icon.id]			= id
	pickMapObjects_[supplierIcon.id]	= id
	pickMapObjects_[warehouse.id]		= id
	
	MapWindow.addUserObjects(mapObjects)
end

local function airdromeCoalitionChanged(airdromeId)
	local mapObjects	= airdromeMapObjects_[airdromeId]
	local mapObjectsWarehouses	= unitWarehousesMapObjects_[airdromeId]
	local mapObjectsFueldepots	= unitFueldepotsMapObjects_[airdromeId]
	
	if mapObjects then
		local airdrome		= airdromeController_.getAirdrome(airdromeId)
		local color			= getAirdromeCoalitionColor(airdrome)
		local blurColor		= getAirdromeCoalitionBlurColor(airdrome)
		local supplierIcon	= mapObjects[3]
		local caption		= mapObjects[4]
		
		MapWindow.removeUserObjects(mapObjects)
		
		setIconColor(supplierIcon, color)
		setCaptionColor(caption, color, blurColor)
		
		if mapObjectsWarehouses then
			for k,v in base.pairs(mapObjectsWarehouses) do
				setIconColor(v, color)
			end
		end
		
		if mapObjectsFueldepots then
			for k,v in base.pairs(mapObjectsFueldepots) do
				setIconColor(v, color)
			end
		end
		
		MapWindow.addUserObjects(mapObjects)
	end
end

local function getBeaconFrequencyText(frequency)
    if (frequency ~= nil) then            
        if frequency >= 1000000 then
            return string.format('%0.2f MHz', frequency / 1000000)
        else
            return string.format('%0.2f kHz', frequency / 1000)
        end
    else
        return "no data"
    end
end

local function getBeaconFrequencyTextILS(frequency)
    if (frequency ~= nil) then            
        if frequency >= 1000000 then
            return string.format('%0.2f MHz', frequency / 1000000)
        else
            return string.format('%0.2f kHz', frequency / 1000)
        end
    else
        return "no data"
    end
end

local function getBeaconFrequencyTextKHZ(frequency)
    if (frequency ~= nil) then            
        return string.format('%0.2f kHz', frequency / 1000)
    else
        return "no data"
    end
end

-- VOR, VOR/DME
local function getBeaconFormText(a_beacon)
    local name      = a_beacon:getName()
    local frequency = a_beacon:getFrequency()
    if frequency then
        frequency = getBeaconFrequencyText(frequency)     
    end
    local callsign  = a_beacon:getCallsign()
    local channel   = a_beacon:getChannel()
    
    return (name or "").."\n"..(frequency or "").." "..(callsign or "").." "..(channel or "")
end

-- beacon without marker, beacon homer
local function getBeaconForm2Text(a_beacon)
    local name      = a_beacon:getName()
    local frequency = a_beacon:getFrequency()
    if frequency then
        frequency = getBeaconFrequencyTextKHZ(frequency)  
    end
    local callsign  = a_beacon:getCallsign()
    
    return (name or "").."\n"..(frequency or "").." "..(callsign or "")
end

-- VORTAC, RSBN
local function getBeaconForm3Text(a_beacon)
    local name      = a_beacon:getName()
    local frequency = a_beacon:getFrequency()
    if frequency then
        frequency = getBeaconFrequencyText(frequency)          
    end
    local callsign  = a_beacon:getCallsign()
    local channel   = a_beacon:getChannel()
    
    return (name or "").."\n"..(frequency or "").." "..(callsign or "").."\nChan "..(channel or "")
end

-- beacon with marker
local function getBeaconForm4Text(a_beacon)
    local frequency = a_beacon:getFrequency()
    if frequency then
        frequency = getBeaconFrequencyTextKHZ(frequency)          
    end
    local callsign  = a_beacon:getCallsign()
    
    return (frequency or "").." "..(callsign or "")
end

-- TACAN
local function getBeaconForm5Text(a_beacon)
    local name      = a_beacon:getName()
    local callsign  = a_beacon:getCallsign()
    local channel   = a_beacon:getChannel()
    
    return (name or "").."\n"..(callsign or "").."\nChan "..(channel or "")
end

local function addBeaconWithoutMarker(beaconWithoutMarker)
	local x, y			= beaconWithoutMarker:getPosition()
	local angle			= 0
	local icon			= createIcon('BeaconWithoutMarker', x, y, angle)
	local text			= getBeaconForm2Text(beaconWithoutMarker)
	local offsetX		= beaconTextOffsetX
	local offsetY		= beaconTextOffsetY
	local caption		= createCaption('BeaconCaption', x, y, text, offsetX, offsetY)
	local mapObjects	= {icon, caption}
	
	MapWindow.addUserObjects(mapObjects)
end

local function addBeaconWithMarker(beaconWithMarker)
	local x, y			= beaconWithMarker:getPosition()
	local angle			= beaconWithMarker:getAngle() + math.pi / 2 -- для правильной ориентации на карте
	local icon			= createIcon('BeaconWithMarker', x, y, UC.toDegrees(angle))
	local text			= getBeaconForm4Text(beaconWithMarker)
	local offsetX		= beaconTextOffsetX
	local offsetY		= beaconTextOffsetY
	local caption		= createCaption('BeaconCaption', x, y, text, offsetX, offsetY)
	local mapObjects	= {icon, caption}
	
	MapWindow.addUserObjects(mapObjects)
end

local function addBeaconTacan(beaconTacan) --- BEACON_TYPE_TACAN = 4
	local x, y			= beaconTacan:getPosition()
	local angle			= 0
	local icon			= createIcon('BeaconTacan', x, y, angle)
	local text			= getBeaconForm5Text(beaconTacan)
	local offsetX		= beaconTextOffsetX
	local offsetY		= beaconTextOffsetY
	local caption		= createCaption('BeaconCaption', x, y, text, offsetX, offsetY)
	local mapObjects	= {icon, caption}
	
	MapWindow.addUserObjects(mapObjects)
end

local function addBeaconVor(beaconVor)   --- BEACON_TYPE_VOR = 1
	local x, y			= beaconVor:getPosition()
	local angle			= 0
	local icon			= createIcon('BeaconVor', x, y, angle)
	local text			= getBeaconFormText(beaconVor) 
	local offsetX		= beaconTextOffsetX
	local offsetY		= beaconTextOffsetY
	local caption		= createCaption('BeaconCaption', x, y, text, offsetX, offsetY)
	local mapObjects	= {icon, caption}
	
	MapWindow.addUserObjects(mapObjects)
end

local function addBeaconDME(beaconDME)  --- BEACON_TYPE_DME = 2
	local x, y			= beaconDME:getPosition()
	local angle			= 0
	local icon			= createIcon('BeaconDME', x, y, angle)
	local text			= getBeaconFrequencyText(beaconDME:getFrequency())
	local offsetX		= beaconTextOffsetX
	local offsetY		= beaconTextOffsetY
	local caption		= createCaption('BeaconCaption', x, y, text, offsetX, offsetY)
	local mapObjects	= {icon, caption}
	
	MapWindow.addUserObjects(mapObjects)
end

local function addBeaconVORDME(beaconVORDME) --- BEACON_TYPE_VOR_DME = 3
	local x, y			= beaconVORDME:getPosition()
	local angle			= 0
	local icon			= createIcon('beaconVORDME', x, y, angle)
	local text			= getBeaconFormText(beaconVORDME) 
	local offsetX		= beaconTextOffsetX
	local offsetY		= beaconTextOffsetY
	local caption		= createCaption('BeaconCaption', x, y, text, offsetX, offsetY)
	local mapObjects	= {icon, caption}
	
	MapWindow.addUserObjects(mapObjects)
end

local function addBeaconVORTAC(beaconVORTAC) --- BEACON_TYPE_VORTAC = 5
	local x, y			= beaconVORTAC:getPosition()
	local angle			= 0
	local icon			= createIcon('beaconVORTAC', x, y, angle)
	local text			= getBeaconForm3Text(beaconVORTAC) 
	local offsetX		= beaconTextOffsetX
	local offsetY		= beaconTextOffsetY
	local caption		= createCaption('BeaconCaption', x, y, text, offsetX, offsetY)
	local mapObjects	= {icon, caption}
	
	MapWindow.addUserObjects(mapObjects)
end

local function addBeaconRSBN(beaconRSBN) --- BEACON_TYPE_RSBN = 128
	local x, y			= beaconRSBN:getPosition()
	local angle			= 0
	local icon			= createIcon('beaconRSBN', x, y, angle)
	local text			= getBeaconForm3Text(beaconRSBN) 
	local offsetX		= beaconTextOffsetX
	local offsetY		= beaconTextOffsetY
	local caption		= createCaption('BeaconCaption', x, y, text, offsetX, offsetY)
	local mapObjects	= {icon, caption}
	
	MapWindow.addUserObjects(mapObjects)
end

local function addBeaconHOMER(beaconHOMER) --- BEACON_TYPE_HOMER = 8, BEACON_TYPE_AIRPORT_HOMER = 4104
	local x, y			= beaconHOMER:getPosition()
	local angle			= 0
	local icon			= createIcon('beaconHOMER', x, y, angle)
	local text			= getBeaconForm2Text(beaconHOMER) 
	local offsetX		= beaconTextOffsetX
	local offsetY		= beaconTextOffsetY
	local caption		= createCaption('BeaconCaption', x, y, text, offsetX, offsetY)
	local mapObjects	= {icon, caption}
	
	MapWindow.addUserObjects(mapObjects)
end

local function createILSPoints(x, y, angle, lenght)
	local points1			= {}
	local points2			= {}
	local sideLength		= 22500
	local halfCornerAngle	= math.pi / 36
	local sin				= math.sin
	local cos				= math.cos
	
	local centralPointX = x + lenght * sin(angle)
	local centralPointY = y + lenght * cos(angle)

	local p = MapWindow.createPoint(x, y)
	table.insert(points1, p)
	
	p = MapWindow.createPoint(	x + sideLength * sin(angle + halfCornerAngle), 
								y + sideLength * cos(angle + halfCornerAngle))
	table.insert(points1, p)

	p = MapWindow.createPoint(centralPointX, centralPointY)
	table.insert(points1, p) 
	
	p = MapWindow.createPoint(x, y)
	table.insert(points2, p)	
			  
	p = MapWindow.createPoint(centralPointX, centralPointY)
	table.insert(points2, p)  
	
	p = MapWindow.createPoint(	x + sideLength * sin(angle - halfCornerAngle), 
								y + sideLength * cos(angle - halfCornerAngle))								
	table.insert(points2, p)

	return points1, points2
end

local function getBeaconIlsCourseText(beaconIls)
	local degrees = 180 + beaconIls:getAngle() * 180 / math.pi
	
	degrees = math.floor(degrees + 0.5)	   
	degrees = degrees + 360
	degrees = degrees % 360
	
	return string.format('%0.0f°', degrees)
end

local function addBeaconIls(beaconIls)
	local x, y				= beaconIls:getPosition()    
	local angle				= -beaconIls:getAngle() + math.pi / 2 -- для правильной ориентации на карте
	local lenght			= 21000
	local points1, points2	= createILSPoints(x, y, angle, lenght)
	local triangle1			= MapWindow.createSQR('BeaconIls', getNextMapId(), points1)
	local triangle2			= MapWindow.createSQR('BeaconIls', getNextMapId(), points2)
	local channelText		= beaconIls:getChannel()
	local freqText          = getBeaconFrequencyTextILS(beaconIls:getFrequency())
	local textColor			= beaconIls:getTextColor() or MapColor.new(1, 1, 1)
		
	local textX				= x + lenght * math.sin(angle)
	local textY				= y + lenght * math.cos(angle)
	local offsetX			= -25
	local offsetY			= -20
	local courseText		= getBeaconIlsCourseText(beaconIls)
	local text
	
	if (not channelText) or (channelText == "") then
		text = string.format('%s\n%s', freqText, courseText)
	else
		text = string.format('%s (chan %s)\n%s', freqText, channelText, courseText)
	end
	
	local caption			= createCaption('BeaconIlsCaption', textX, textY, text, offsetX, offsetY, textColor)
	local mapObjects		= {triangle1, triangle2, caption}
	
	MapWindow.addUserObjects(mapObjects)
end

local function createBeacons()
	for i, beaconWithoutMarker in ipairs(BeaconData.getBeaconsWithoutMarker()) do
		addBeaconWithoutMarker(beaconWithoutMarker)
	end	
	
	for i, beaconWithMarker in ipairs(BeaconData.getBeaconsWithMarker()) do
		addBeaconWithMarker(beaconWithMarker)
	end
		
	for i, beaconTacan in ipairs(BeaconData.getBeaconsTacan()) do
		addBeaconTacan(beaconTacan)
	end		
	
	for i, beaconVor in ipairs(BeaconData.getBeaconsVor()) do
		addBeaconVor(beaconVor)
	end
    
    for i, beaconDME in ipairs(BeaconData.getBeaconsDME()) do
		addBeaconDME(beaconDME)
	end
    
    for i, beaconVORDME in ipairs(BeaconData.getBeaconsVORDME()) do
		addBeaconVORDME(beaconVORDME)
	end
	
    for i, beaconVORTAC in ipairs(BeaconData.getBeaconsVORTAC()) do
		addBeaconVORTAC(beaconVORTAC)
	end    
    
    for i, beaconRSBN in ipairs(BeaconData.getBeaconsRSBN()) do
		addBeaconRSBN(beaconRSBN)
	end  
    
    for i, beaconHOMER in ipairs(BeaconData.getBeaconsHOMER()) do
		addBeaconHOMER(beaconHOMER)
	end
    
	for i, beaconIls in ipairs(BeaconData.getBeaconsIls()) do
		addBeaconIls(beaconIls)
	end
end

local function createMapObjects()
	resetMapIdCounter()
	
	triggerZoneMapObjects_		= {}
	navigationPointMapObjects_	= {}
	airdromeMapObjects_			= {}
	unitWarehousesMapObjects_	= {}
	unitFueldepotsMapObjects_	= {}
	beaconMapObjects_			= {}
	supplierArrows_				= {}
	pickMapObjects_				= {}
	selectionMapObjects_		= {}
	
	for i, airdrome in ipairs(AirdromeData.getAirdromes()) do
		addAirdrome(airdrome)
	end
	
	createBeacons()
	
	for i, triggerZoneId in ipairs(triggerZoneController_.getTriggerZoneIds()) do
		addTriggerZone(triggerZoneId)
	end
	
	for i, navigationPointId in ipairs(navigationPointController_.getNavigationPointIds()) do
		addNavigationPoint(navigationPointId)
	end
end

local function navigationPointNameChanged(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	local mapObjects = navigationPointMapObjects_[navigationPointId]
	local x, y = navigationPoint:getPosition()
	
	MapWindow.removeUserObjects(mapObjects)
	
	local caption = mapObjects[2]
	
	setCaptionText(caption, navigationPoint:getName())
	
	MapWindow.addUserObjects(mapObjects)
end

local function navigationPointDescriptionChanged(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	local mapObjects = navigationPointMapObjects_[navigationPointId]
	local x, y = navigationPoint:getPosition()
	
	MapWindow.removeUserObjects(mapObjects)
	
	local caption = mapObjects[3]
	
	setCaptionText(caption, navigationPoint:getDescription())
	
	MapWindow.addUserObjects(mapObjects)
end

local function navigationPointTypeChanged(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	local mapObjects = navigationPointMapObjects_[navigationPointId]

	MapWindow.removeUserObjects(mapObjects)
	
	local iconOld = mapObjects[1]
	pickMapObjects_[iconOld.id] = nil
	
--	if navigationPoint:getType() ~= "Military" then		
		local icon	= createNavigationPointIcon(navigationPoint, iconOld.color, navPointTypesById_[navigationPoint:getType()].mapclasskey, offsetY)
		mapObjects[1] = icon
		pickMapObjects_[icon.id] = navigationPointId
--[[	else
		local icon	= createNavigationPointIcon(navigationPoint, MapColor.new(1, 1, 1), "MilitaryWaypoint")

		icon.layers =
		{
			{
				is_background             = true,-- в этом случае  объект будет использоваться как  маска для обрезки
				---------------------------------------------------------------------------------------------------
				file                      = "./CoreMods/services/MC/Classifier/common/MilitaryWaypoints/test1.png", 
			--	offset                    = {0,0} -- relative , optional
				color                     = MapColor.new(1, 1, 1),
			--	text_overlay            = "text", --optional
				text_color                = MapColor.new(1, 1, 1),
			--	font                    = "font name", --optional
			--	text_offset                = {0,0},
			--	clip_with_background         = true,-- в этом случае  объект будет клипаться 
			--	clip_text_with_background     = true,
			},
			{
				file                      = "./CoreMods/services/MC/Classifier/common/MilitaryWaypoints/test2.png", 
			--	offset                    = {0,0} -- relative , optional
				color                     = MapColor.new(1, 1, 1),
			--	text_overlay            = "text", --optional
			--	text_color                = MapColor.new(1, 1, 1),
			--	font                    = "font name", --optional
			--	text_offset                = {0,0},
				clip_with_background         = true,-- в этом случае  объект будет клипаться 
			--	clip_text_with_background     = true,
			},
			{
				file                      = "./CoreMods/services/MC/Classifier/common/MilitaryWaypoints/test3.png", 
			--	offset                    = {0,0} -- relative , optional
				color                     = MapColor.new(1, 1, 1),
			--	text_overlay            = "text", --optional
			--	text_color                = MapColor.new(1, 1, 1),
			--	font                    = "font name", --optional
			--	text_offset                = {0,0},
			--	clip_with_background         = true,-- в этом случае  объект будет клипаться 
			--	clip_text_with_background     = true,
			}
		}
	--	base.U.traverseTable(icon,4)
	--	U.saveInFile(icon, 'xxxx', 'G:\\testM.lua')
	--	base.print("----hhhhh----")
		mapObjects[1] = icon

		pickMapObjects_[icon.id] = navigationPointId
	end	
	]]
	MapWindow.addUserObjects(mapObjects)
end

local function navigationPointPositionChanged(navigationPointId)
	local navigationPoint = getNavigationPoint(navigationPointId)
	local mapObjects = navigationPointMapObjects_[navigationPointId]

	MapWindow.removeUserObjects(mapObjects)
	
--	if navigationPoint:getType() ~= "Military" then
		local icon			= mapObjects[1]
		local caption		= mapObjects[2]
		local description	= mapObjects[3]
		local selection		= mapObjects[4]
		local x, y			= navigationPoint:getPosition()
		
		setIconPosition(icon, x, y)
		setCaptionPosition(caption, x, y)
		setCaptionPosition(description, x, y)
		
		if selection then
			setIconPosition(selection, x, y)
		end
--[[	else
		local icon			= mapObjects[1]
		local caption		= mapObjects[2]
		local description	= mapObjects[3]

		local x, y			= navigationPoint:getPosition()
		
		setIconPosition(icon, x, y)
		setCaptionPosition(caption, x, y)
		setCaptionPosition(description, x, y)
		
	end]]
	
	MapWindow.addUserObjects(mapObjects)
end

local function navigationPointCoalitionChanged(navigationPointId)
	local navigationPoint	= getNavigationPoint(navigationPointId)
	local color				= getCoalitionColor(navigationPoint:getCoalitionName())
	local mapObjects		= navigationPointMapObjects_[navigationPointId]
	
	MapWindow.removeUserObjects(mapObjects)

	local icon			= mapObjects[1]
	local caption		= mapObjects[2]
	local description	= mapObjects[3]
	
	if navigationPoint:getType() == 'Default' then
		icon.color			= color
	else	
		icon.color = MapColor.new(1, 1, 1)
	end

	setCaptionColor(caption		, color)
	setCaptionColor(description	, color)
	
	MapWindow.addUserObjects(mapObjects)
	
	if navigationPointController_.getSelectedNavigationPointId() == navigationPointId then
		selectNavigationPoint(navigationPointId)
	end
end

local function createSupplierArrow(startPoint, finishPoint, color)
	-- отодвигаем точки startPoint, finishPoint на расстояние iconRadius от иконок
	-- направляющий вектор
	local vx 			= finishPoint.x - startPoint.x
	local vy			= finishPoint.y - startPoint.y
	local length		= MapWindow.getDistance(startPoint, finishPoint)
	
	vx 					= vx / length
	vy 					= vy / length	

	local iconSize 		= 8
	local iconRadius	= MapWindow.getMapSize(0, iconSize)

	length = length - iconRadius
	
	finishPoint.x = startPoint.x + vx * length
	finishPoint.y = startPoint.y + vy * length

	startPoint.x	= startPoint.x + vx * iconRadius
	startPoint.y	= startPoint.y + vy * iconRadius
	
	length = length - iconRadius
	
	if length > 0 then
		local angle			= MapWindow.getAngle(startPoint, finishPoint)
		local sinAngle		= math.sin(angle)
		local cosAngle		= math.cos(angle)
		local points 		= {}	
		local p				= MapWindow.createPoint(finishPoint.x, finishPoint.y)
		
		table.insert(points, p)
		
		local arrowHeadLength	= MapWindow.getMapSize(0, 20)
		local arrowHeadWidth	= MapWindow.getMapSize(0, 7)
		local arrowWidth		= MapWindow.getMapSize(0, 3)
		
		p = MapWindow.createPoint(	startPoint.x + ((length - arrowHeadLength) * cosAngle - arrowHeadWidth * sinAngle),
									startPoint.y + ((length - arrowHeadLength) * sinAngle + arrowHeadWidth * cosAngle))
		table.insert(points, p)
		
		p = MapWindow.createPoint(	startPoint.x + ((length - arrowHeadLength) * cosAngle - arrowWidth * sinAngle),
									startPoint.y + ((length - arrowHeadLength) * sinAngle + arrowWidth * cosAngle))
		table.insert(points, p)
		
		p = MapWindow.createPoint(	startPoint.x + (0 * cosAngle - arrowWidth * sinAngle),
									startPoint.y + (0 * sinAngle + arrowWidth * cosAngle))
		table.insert(points, p)
		
		p = MapWindow.createPoint(	startPoint.x + (0 * cosAngle + arrowWidth * sinAngle),
									startPoint.y + (0 * sinAngle - arrowWidth * cosAngle))
		table.insert(points, p)
		
		p = MapWindow.createPoint(	startPoint.x + (length - arrowHeadLength) * cosAngle + arrowWidth * sinAngle,
									startPoint.y + (length - arrowHeadLength) * sinAngle - arrowWidth * cosAngle)
		table.insert(points, p)
		
		p = MapWindow.createPoint(	startPoint.x + (length - arrowHeadLength) * cosAngle + arrowHeadWidth * sinAngle,
									startPoint.y + (length - arrowHeadLength) * sinAngle - arrowHeadWidth * cosAngle)
		table.insert(points, p)
		
		local stencil = 1

		return MapWindow.createSQR('SupplierArrow', getNextMapId(), points, color, stencil)
	end
end

local function addSupplierArrow(fromSupplierInfo, toSupplierInfo, color)
	local startPoint	= MapWindow.createPoint(fromSupplierInfo.x, fromSupplierInfo.y)
	local finishPoint	= MapWindow.createPoint(toSupplierInfo.x, toSupplierInfo.y)
	
	local supplierArrow		= createSupplierArrow(startPoint, finishPoint, color)
	local fromSupplierType	= fromSupplierInfo.supplierType
	local fromSupplierId	= fromSupplierInfo.supplierId
	
	supplierArrows_[fromSupplierType] = supplierArrows_[fromSupplierType] or {}
	supplierArrows_[fromSupplierType][fromSupplierId] = supplierArrows_[fromSupplierType][fromSupplierId] or {}
	
	table.insert(supplierArrows_[fromSupplierType][fromSupplierId], {
			supplierType	= toSupplierInfo.supplierType,
			supplierId		= toSupplierInfo.supplierId,
			supplierArrow	= supplierArrow})
   
	MapWindow.addUserObjects({supplierArrow})
end

local function removeSupplierArrow(fromSupplierInfo, supplierId, supplierType)
	local supplierTypeArrowInfos = supplierArrows_[supplierType]

	if supplierTypeArrowInfos then
		local supplierIdArrowInfos = supplierTypeArrowInfos[supplierId]
		if supplierIdArrowInfos then
			for i, supplierArrowInfo in ipairs(supplierIdArrowInfos) do                
				if fromSupplierInfo.supplierType == supplierArrowInfo.supplierType and fromSupplierInfo.supplierId == supplierArrowInfo.supplierId then
					MapWindow.removeUserObjects({supplierArrowInfo.supplierArrow})
                    table.remove(supplierIdArrowInfos,i)
                    if #supplierTypeArrowInfos then
                        supplierIdArrowInfos = nil
                    end
					break
				end	
			end			
		end
	end
end

local function removeSupplierArrows()
	for supplierType, supplierTypeArrowInfos in pairs(supplierArrows_) do
		for supplierId, supplierIdArrowInfos in pairs(supplierTypeArrowInfos) do
			for i, supplierArrowInfo in ipairs(supplierIdArrowInfos) do
				MapWindow.removeUserObjects({supplierArrowInfo.supplierArrow})
			end
		end
	end
	
	supplierArrows_ = {}
end

local function showWarehouseIcons(warehouseInfos)
	local classKey = 'WarehouseSupplierIcon'
	local mapObjects = {}
	
	for i, warehouseInfo in ipairs(warehouseInfos) do	
		local color = getCoalitionColor(warehouseInfo.coalitionName)
		local icon = createIcon(classKey, warehouseInfo.x, warehouseInfo.y, 0, color)
		
		table.insert(mapObjects, icon)
		pickWarehouses_[icon.id] = warehouseInfo.unitId
	end
	
	MapWindow.addUserObjects(mapObjects)
end

local function hideWarehouseIcons()
	local mapObjects = {}
	
	for mapId, unitId in pairs(pickWarehouses_) do
		table.insert(mapObjects, {id = mapId})
	end
	
	MapWindow.removeUserObjects(mapObjects)
	pickWarehouses_ = {}
end

local function setLayerVisible(layerTitle, visible)
	MapWindow.showLayer(layerTitle, visible)
end

local function isPickMapObjects(a_id)
	return pickMapObjects_[a_id] ~= nil
end

local function getPickMapObjects(a_id)
	return pickMapObjects_[a_id]
end

return {
	setTriggerZoneController			= setTriggerZoneController,
	setNavigationPointController		= setNavigationPointController,
	setAirdromeController				= setAirdromeController,
	
	createMapObjects					= createMapObjects,
	pickObjects							= pickObjects,
	pickWarehouse						= pickWarehouse,
	selectObject						= selectObject,
	deselectObject						= deselectObject,
			
	addTriggerZone						= addTriggerZone,
	removeTriggerZone					= removeTriggerZone,
	triggerZoneRadiusChanged			= triggerZoneRadiusChanged,
	triggerZoneNameChanged				= triggerZoneNameChanged,
	triggerZoneColorChanged				= triggerZoneColorChanged,
	triggerZoneHiddenChanged			= triggerZoneHiddenChanged,
	triggerZonePositionChanged			= triggerZonePositionChanged,
	triggerZoneTypeChanged				= triggerZoneTypeChanged,
	updateTriggerZone					= updateTriggerZone,
	
	addNavigationPoint					= addNavigationPoint,
	removeNavigationPoint				= removeNavigationPoint,
	navigationPointNameChanged			= navigationPointNameChanged,
	navigationPointDescriptionChanged	= navigationPointDescriptionChanged,
	navigationPointTypeChanged			= navigationPointTypeChanged,
	navigationPointPositionChanged		= navigationPointPositionChanged,
	navigationPointCoalitionChanged		= navigationPointCoalitionChanged,
	
	addAirdrome							= addAirdrome,
	airdromeCoalitionChanged			= airdromeCoalitionChanged,

	addSupplierArrow					= addSupplierArrow,
	removeSupplierArrow					= removeSupplierArrow,
	removeSupplierArrows				= removeSupplierArrows,
	showWarehouseIcons					= showWarehouseIcons,
	hideWarehouseIcons					= hideWarehouseIcons,

	setLayerVisible						= setLayerVisible,
	
	isPickMapObjects					= isPickMapObjects,
	getPickMapObjects					= getPickMapObjects,
}