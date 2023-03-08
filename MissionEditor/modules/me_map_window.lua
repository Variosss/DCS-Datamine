local base = _G

module('me_map_window')

local require	= base.require
local math		= base.math
local pairs		= base.pairs
local ipairs	= base.ipairs
local table		= base.table
local print		= base.print

local gui 						= require('dxgui')
local Window					= require('Window')
local NewMapView				= require('NewMapView')
local NewMapState				= require('NewMapState')
local MsgWindow					= require('MsgWindow')
local U							= require('me_utilities')
local UC				        = require('utils_common')
local Terrain					= require('terrain')
local DB						= require('me_db_api')
local crutches					= require('me_crutches')  -- temporary crutches
local NodesManager				= require('me_nodes_manager')
local NodesMapView				= require('me_nodes_map_view')
local mod_bullseye				= require('me_bullseye')
local mod_weather				= require('me_weather')
local actionDB					= require('me_action_db')
local panel_route				= require('me_route')
local module_mission			= require('me_mission')
local panel_targeting			= require('me_targeting')
local toolbar					= require('me_toolbar')
local statusbar					= require('me_statusbar')
local panel_aircraft			= require('me_aircraft')
local panel_static				= require('me_static')
local panel_summary				= require('me_summary')
local panel_payload				= require('me_payload')
local panel_ship				= require('me_ship')
local panel_vehicle				= require('me_vehicle')
local panel_suppliers			= require('me_suppliers')
local panel_triggered_actions	= require('me_triggered_actions')
local panel_nav_target_fix_points = require('me_nav_target_fix_points')
local panel_briefing			= require('me_briefing')
local panel_units_list			= require('me_units_list')
local panel_bullseye			= require('me_bullseye')
local panel_paramFM				= require('me_paramFM')
local panel_radio				= require('me_panelRadio')
local panel_wpt_properties		= require('me_wpt_properties')
local actionEditPanel			= require('me_action_edit_panel')
local panel_template			= require('me_template')
local OptionsData				= require('Options.Data')
local MapController				= require('Mission.MapController')
local MapLayerController		= require('Mission.MapLayerController')
local TheatreOfWarData			= require('Mission.TheatreOfWarData')
local ModulesMediator			= require('Mission.ModulesMediator')
local TriggerZonePanel			= require('Mission.TriggerZonePanel')
local i18n						= require('i18n')
-- local waitScreen               = require('me_wait_screen')
local Skin				        = require('Skin')
local Static                    = require('Static')
local mapInfoPanel              = require('me_mapInfoPanel')
local mod_parking               = require('me_parking')
local AirdromeData				= require('Mission.AirdromeData')
local pPayload_vehicles		    = require('me_payload_vehicles')
local panelSelectUnit			= require('me_selectUnit')
local MissionData				= require('Mission.Data')
local panel_startEditor 		= require('me_startEditor')
local Analytics					= require("Analytics")
local panel_dataCartridge 	  	= require('me_dataCartridge')
local panelActionCondition		= require('me_action_condition')
local panelContextMenu			= require('me_contextMenu')
local CoalitionController		= require('Mission.CoalitionController')
local RtsMapView				= require('me_rts_map_view')
local panel_draw				= require('me_draw_panel')
local panel_backup				= require('me_backup')
local TriggerZoneController		= require('Mission.TriggerZoneController')
local ProductType 				= require('me_ProductType')
local optionsEditor				= require('optionsEditor')
local map_classifier 			= require('me_map_classifier')
local MeSettings	 			= require('MeSettings')


i18n.setup(_M)

cdata = {
    farp				= _('FARP'),
    GrassAirfield		= _('Grass Airfield'),
    placeInside			= _('Please place objects into map'),
    warehouses          = _('Warehouses'),
    heliports           = _('Heliports'),
}

initialAltitude = {
    helicopter = 500,
    plane = 2000,
}

initialVelocity = {
    helicopter = 200/3.6,
    plane = 500/3.6,
}

xPrev = 0
yPrev = 0
moving = false
MOUSE_POS = {}
txCollapse = 0
tyCollapse = 0
bCollapse = false
bCreatedUnit = false

local selectedGroups = {}
local selectedGroupsPoint = {} 
MOUSE_STATE = {x=0,y=0}
local bShowHidden = false
local bShowRed = false
local bShowBlue = false
local bShowNeutrals = false
local bHideRed = false
local bHideBlue = false
local bHideNeutrals = false

needReinitTerrain = false
-------------------------------------------------------------------------------
--
function initModule()
    waypointDragged  = false;
end;

local x_
local y_
local w_
local h_

function create(x, y, w, h)
    x_ = x
    y_ = y
    w_ = w
    h_ = h
end

-- объявление переменных
-- имена всех локальных переменных и функций оканчиваются на '_'

local newMapView_
local panState_
local emptyState_
local creatingPlaneState_
local creatingHelicopterState_
local creatingShipState_
local creatingVehicleState_
local creatingStaticState_
local selectSupplierState_
local addingWaypointState_
local addingTargetState_
local creatingTemplateState_
local creatingINUFixPointState_
local creatingNavTargetPointState_
local creatingDataCartridgePointState_
local nodesState_
local RtsState_
local editTriggerZoneState_
local tapeState_
local drawState_
local pipetteState_
local ruler_
local bMouseDown = false
local pointsTriggerZone = {}
local pointsTriggerZoneMapObjects = {}
local selectedPointTrigger

-------------------------------------------------------------------------------
-- публичный интерфейс
-- установить новый объект состояния карты
function setState(state)
    if isEmptyME() == true or newMapView_ == nil then
        return
    end
	local supplierController = ModulesMediator.getSupplierController()
	
	supplierController.onChangeMapState(state)
	
	if base.setCoordPanel.isStateSetPosUnit() and state ~= getPipetteState() then
		base.setCoordPanel.hide()
	end
	
	if state == getAddingWaypointState() then
		panel_route.setStateAddEdit(true, false)
	end
	
	if state == getPanState() then
		panel_route.setStateAddEdit(false, true)
	end
	
	if state == getPipetteState() then
		panel_route.setStateAddEdit(false, false)
	else
		panel_aircraft.tbSetPos:setState(false)
		panel_vehicle.tbSetPos:setState(false)
		panel_static.tbSetPos:setState(false)
		panel_ship.tbSetPos:setState(false)
	end
	
	
    newMapView_:setState(state)
    
    statusbar.updateState()  
    mapInfoPanel.update()
end

-------------------------------------------------------------------------------
-- получить текущий объект состояния карты
function getState()
  return newMapView_:getState()
end

-------------------------------------------------------------------------------
-- текущее состояние создания группы?
function isCreatingGroupState()
    local state = getState()
    return state == creatingHelicopterState_ 
        or state == creatingShipState_ 
        or state == creatingVehicleState_ 
        or state == creatingStaticState_ 
        or state == creatingPlaneState_ 
end

function getPanState()							return panState_						end
function getCreatingPlaneState()				return creatingPlaneState_				end
function getCreatingHelicopterState()			return creatingHelicopterState_ 		end
function getCreatingShipState()					return creatingShipState_				end
function getCreatingVehicleState()				return creatingVehicleState_			end
function getCreatingStaticState()				return creatingStaticState_				end
function getSelectSupplierState()				return selectSupplierState_				end
function getAddingWaypointState()				return addingWaypointState_				end
function getAddingTargetState()					return addingTargetState_				end
function getCreatingTemplateState()				return creatingTemplateState_			end
function getCreatingINUFixPointState()			return creatingINUFixPointState_		end
function getCreatingNavTargetPointState()		return creatingNavTargetPointState_		end
function getCreatingDataCartridgePointState()	return creatingDataCartridgePointState_	end
function getNodesState()						return nodesState_						end
function getTapeState()							return tapeState_						end
function getRtsState()							return RtsState_						end
function getEditTriggerZoneState()				return editTriggerZoneState_			end
function getDrawState()							return drawState_						end
function getPipetteState()						return pipetteState_					end

-------------------------------------------------------------------------------
--
function getScales()
  return newMapView_:getScales()
end

-------------------------------------------------------------------------------
--
function getScale()
	if newMapView_ then
		return newMapView_:getScale()
	else
		return nil
	end	
end

-------------------------------------------------------------------------------
--
function setScale(s)
	if (newMapView_) then
		newMapView_:setScale(s)
        mapInfoPanel.update()
        MapLayerController.updateLayerVisible()
		if getState() == getRtsState() then
			 RtsMapView.onChangeZoom(getScale())
		end
	end
end

-------------------------------------------------------------------------------
--
function getLayers()
  return newMapView_:getLayers()
end

-------------------------------------------------------------------------------
--
function showLayer(layerName, show)
    if layerName == 'PARKINGS' then
        local scale = getScale()
        if show == true and scale and scale < 6000 then
            newMapView_:showLayer(layerName, true)
        else
            newMapView_:showLayer(layerName, false)
        end
    else   
        newMapView_:showLayer(layerName, show)
    end
end

-------------------------------------------------------------------------------
--
function getCamera()
	if (newMapView_) then	
		return newMapView_:getCamera()
	else
		return nil, nil
	end
end

-------------------------------------------------------------------------------
--
function setCamera(x, y)
	newMapView_:setCamera(x, y)
	local mapX, mapY = getCamera()
	module_mission.mission.map.centerX = mapX
	module_mission.mission.map.centerY = mapY
end

-------------------------------------------------------------------------------
-- возвращает точку на карте
-- x, y - оконные координаты
function getMapPoint(x, y) 
  return newMapView_:getMapPoint(x, y)
end

-------------------------------------------------------------------------------
-- возвращает размер в метрах для размера в пикселях
function getMapSize(px, py, sign) 
	local x, y, w, h	= newMapView_:getBounds()
	local mx1, my1		= getMapPoint(w / 2, h / 2)
	local mx2, my2		= getMapPoint(w / 2 + px, h / 2 + py)  

	if sign then
		return mx2 - mx1, my2 - my1
	else
		return math.abs(mx2 - mx1), math.abs(my2 - my1)
	end
end

-------------------------------------------------------------------------------
-- проверяет нахождение точки внутри карты
function getPointInMap(x, y)
  -- TODO: эту проверка должна выполняться в edTerrain
  local result = newMapView_:getPointInMap(x, y)

  return result  
end

-------------------------------------------------------------------------------
--
function getCenterMap(offsetX, offsetY)    
    local x, y, w, h = newMapView_:getBounds()
    local rx, ry = getMapPoint((w-offsetX) / 2, (h-offsetY) / 2)
    return rx,ry
end

-------------------------------------------------------------------------------
--
function getPointMapRelative(offsetXRel, offsetYRel)  --offsetXRel, offsetYRel  от 0 до 1
    local x, y, w, h = newMapView_:getBounds()
    local rx, ry = getMapPoint((w*offsetXRel), (h*offsetYRel))
    return rx,ry
end


-------------------------------------------------------------------------------
-- создает точку, которая должна быть помещена в массив points
-- points передаются в качестве параметра 
-- при создании линейных и площадных объектов
function createPoint(x, y)
  return {x = x, y = y}
end

-------------------------------------------------------------------------------
-- возвращает расстояние между двумя точками на карте
function getDistance(point1, point2)
  local dx = point2.x - point1.x
  local dy = point2.y - point1.y
  
  return math.sqrt(dx * dx + dy * dy)
end

-------------------------------------------------------------------------------
-- возвращает угол наклона отрезка на карте в радианах
function getAngle(point1, point2)
  local dx = point2.x - point1.x
  local dy = point2.y - point1.y  
  local angle = math.atan2(dy, dx)
  
  return angle
end

-- перевод heading объекта в угол поворота объекта карты(точечного или подписи)
-- возвращает угол в градусах
function headingToAngle(headingInRadians)
  return UC.toDegrees(headingInRadians)
end

-------------------------------------------------------------------------------
-- создание объектов карты
function createDOT(classKey, id, x, y, angle, color, zOrder)
  	return {
		classKey	= classKey,		
		id			= id,
		x			= x,
		y			= y,
		angle		= angle,
		color		= color,
		zOrder		= zOrder,
	}
end

-------------------------------------------------------------------------------
-- points - массив точек
-- каждые две точки определяют отрезок
-- каждая точка это таблица с полями {x = число, y = число}
-- points = {{x = число, y = число}, {x = число, y = число}, ...}
function createLIN(classKey, id, points, color, zOrder)
	return {
		classKey	= classKey,
		id			= id,
		points		= points,
		color		= color,
		zOrder		= zOrder,
	}
end

-------------------------------------------------------------------------------
-- points - массив точек
-- каждые две точки определяют отрезок
-- каждая точка это таблица с полями {x = число, y = число}
-- points = {{x = число, y = число}, {x = число, y = число}, ...}
function createPLN(classKey, id, points, color, zOrder)
	return {
		classKey	= classKey,		
		id			= id,
		points		= points,
		color		= color,
		zOrder		= zOrder,
	}
end

-------------------------------------------------------------------------------
--
function createSQR(classKey, id, points, color, stencil)
	return {
		classKey	= classKey,		
		id			= id,
		points		= points,
		color		= color,		
		stencil		= stencil,
	}
end

-- lineHeight - вертикальное расстояние между строками для многострочных подписей
-- если не задано или 0, то берется из шрифта
-- align выравнивание многострочных подписей
-- допустимые значения "min", "left", "middle", "center", "max", "right"
-- если не задано, то "min"
-- offsetX и offsetY - смещение текста относительно точки x, y в пикселях
-- если не задано, то 0
function createTIT(classKey, id, x, y, title, color, angle, lineHeight, align, offsetX, offsetY)
    	return {
		classKey	= classKey,		
		id			= id,
		x			= x,
		y			= y,
		title		= title,
		color		= color,
		angle		= angle,
		lineHeight	= lineHeight, 
		align		= align,
		offsetX		= offsetX,
		offsetY		= offsetY,
	}
end

-------------------------------------------------------------------------------
--
function getObjectType(object)
  return newMapView_:getObjectType(object)
end

-------------------------------------------------------------------------------
--
function getClassifierObject(classKey)
  return newMapView_:getClassifierObject(classKey)
end

-------------------------------------------------------------------------------
-- objects - таблица объектов
function addUserObjects(objects)
    local newObjects = {}
    for k, v in pairs(objects) do	
        if not((v.classKey == 'RouteLine') and (table.maxn(v.points) == 0)) then
            table.insert(newObjects, v) 
        end
    end

    newMapView_:addUserObjects(newObjects) 
end

-------------------------------------------------------------------------------
-- objects - таблица объектов
function removeUserObjects(objects)	
    newMapView_:removeUserObjects(objects)
end

-------------------------------------------------------------------------------
-- удалить все пользовательские объекты
function clearUserObjects()
	--module_mission.removeMapObjectsModels()
    newMapView_:clearUserObjects()
end

-------------------------------------------------------------------------------
-- поиск пользовательских объектов
-- возвращает таблицу вида {id, id, ...}
-- x, y - точка на карте, 
-- radius - в метрах
function findUserObjects(x, y, radius)
  return newMapView_:findUserObjects(x, y, radius) 
end

-------------------------------------------------------------------------------
-- поиск объектов на слое для рисования возвращает их id
-- возвращает таблицу вида {id, id, ...}
-- x, y - точка на карте, 
-- radius - в метрах
function findDrawObjects(x, y, radius)
  return newMapView_:findDrawObjects(x, y, radius) 
end

-------------------------------------------------------------------------------
-- создает объект карты и возвращает его id
-- data - таблица данных для объекта
function createUserObject2(object)
	local id = newMapView_:createUserObject2(object) 
	
	return id
end

-- добавить объект на карту (показать)
-- если объект изменился и его нужно перерисовать, то needRedraw = true
function addUserObject2(id, needRedraw)
	-- id который вернула функция createUserObject2
	newMapView_:addUserObject2(id, needRedraw) 
end

-- изменить объект карты с id 
function updateUserObject2(id, data)
	-- id который вернула функция createUserObject2
	newMapView_:updateUserObject2(id, data) 
end

-- убрать объект с карты (спрятать)
function removeUserObject2(id)
	-- id который вернула функция createUserObject2
	newMapView_:removeUserObject2(id) 
end

-- убрать объект с карты и освободить память
function deleteUserObject2(id)
	-- id который вернула функция createUserObject2
	newMapView_:deleteUserObject2(id)
end


-------------------------------------------------------------------------------
-- создает объект на слое для рисования и возвращает его id
-- data - таблица данных для объекта
function createDrawObject(object)
	local id = newMapView_:createDrawObject(object) 
	
	return id
end

-- добавить объект на слой для рисования (показать)
-- если объект изменился и его нужно перерисовать, то needRedraw = true
function addDrawObject(id, needRedraw)
	-- id который вернула функция createDrawObject
	newMapView_:addDrawObject(id, needRedraw) 
end

-- изменить объект на слое для рисования с id 
function updateDrawObject(id, data)
	-- id который вернула функция createDrawObject
	newMapView_:updateDrawObject(id, data) 
end

-- убрать объект на слое для рисования (спрятать)
function removeDrawObject(id)
	-- id который вернула функция createDrawObject
	newMapView_:removeDrawObject(id) 
end

-- убрать все объекты на слое для рисования (спрятать)
function removeAllDrawObjects()
	newMapView_:removeAllDrawObjects() 
end

-- убрать объект со слоя для рисования и освободить память
function deleteDrawObject(id)
	-- id который вернула функция createDrawObject
	newMapView_:deleteDrawObject(id)
end

-- удаляет все объекты на слое для рисования и освобождает память
function clearDrawObjects()
	newMapView_:clearDrawObjects()
end

-------------------------------------------------------------------------------
-- переводит метры в градусы
-- возвращает lat, lon (в градусах)
function convertMetersToLatLon(x, y)
  return newMapView_:convertMetersToLatLon(x, y)
end

-------------------------------------------------------------------------------
-- переводит градусы в метры
-- lat, lon в градусах
-- возвращает x, y в метрах
function convertLatLonToMeters(lat, lon)
  return newMapView_:convertLatLonToMeters(lat, lon)
end

-------------------------------------------------------------------------------
--
function close()
  newMapView_:close()
end

-------------------------------------------------------------------------------
--
local function createNewMapState_(mouseDownCb, mouseUpCb, mouseDragCb, mouseMoveCb, mouseWheelCb) 
	local result = NewMapState.new(newMapView_)
  
	if mouseUpCb then
		result.onMouseUp = mouseUpCb
	end

	if mouseDownCb then
		result.onMouseDown = mouseDownCb		
	end

	if mouseDragCb then
		result.onMouseDrag = mouseDragCb
	end
  
	if mouseMoveCb then
		result.onMouseMove = mouseMoveCb
	end  
  
	if mouseWheelCb then
		result.onMouseWheel = mouseWheelCb
	end
  
	return result
end

-------------------------------------------------------------------------------
-- создание объектов состояния карты
local function createNewMapStates_()
  panState_ 				    	= createNewMapState_(panState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  emptyState_						= createNewMapState_(emptyState_func, emptyState_func, emptyState_func, emptyState_func, emptyState_func)	
  creatingPlaneState_ 		    	= createNewMapState_(creatingPlaneState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  creatingHelicopterState_ 	    	= createNewMapState_(creatingHelicopterState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  creatingShipState_ 		    	= createNewMapState_(creatingShipState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  creatingVehicleState_ 	    	= createNewMapState_(creatingVehicleState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  creatingStaticState_ 		    	= createNewMapState_(creatingStaticState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  selectSupplierState_          	= createNewMapState_(selectSupplierState_onMouseDown, nil, nil, panState_onMouseMove, selectSupplierState_onMouseWheel)
  addingWaypointState_ 		    	= createNewMapState_(addingWaypointState_onMouseDown, addingWaypointState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  addingTargetState_ 		    	= createNewMapState_(addingTargetState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  creatingTemplateState_ 	    	= createNewMapState_(creatingTemplateState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  creatingINUFixPointState_     	= createNewMapState_(creatingINUFixPointState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  creatingNavTargetPointState_  	= createNewMapState_(creatingNavTargetPointState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  creatingDataCartridgePointState_  = createNewMapState_(creatingDataCartridgePointState_onMouseDown, panState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  nodesState_ 				    	= createNewMapState_(nodesState_onMouseDown, panState_onMouseUp, nodesState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)  
  tapeState_ 				    	= createNewMapState_(tapeState_onMouseDown, tapeState_onMouseUp, tapeState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
  RtsState_							= createNewMapState_(rtsState_onMouseDown, rtsState_onMouseUp, rtsState_onMouseDrag, rtsState_onMouseMove, panState_onMouseWheel)
  editTriggerZoneState_				= createNewMapState_(editTriggerZoneState_onMouseDown, editTriggerZoneState_onMouseUp, editTriggerZoneState_onMouseDrag, editTriggerZoneState_onMouseMove, panState_onMouseWheel)
  drawState_						= createNewMapState_(drawState_onMouseDown, drawState_onMouseUp, drawState_onMouseDrag, drawState_onMouseMove, panState_onMouseWheel)
  pipetteState_						= createNewMapState_(pipetteState_onMouseDown, pipetteState_onMouseUp, panState_onMouseDrag, panState_onMouseMove, panState_onMouseWheel)
end

function emptyState_func()

end

function closeNewMapView() 
	if newMapView_ ~= nil then
		module_mission.removeMission()	
		Terrain.Release()
		base.initTer = false
	end
end

-------------------------------------------------------------------------------
--
local function createNewMapView_(windowWidth, windowHeight) 
	if newMapView_ == nil then
		newMapView_ = NewMapView.new()
		newMapView_:setBounds(0, 0, windowWidth, windowHeight)
		window:insertWidget(newMapView_)
		MapController.initialize() 		
	  
		newMapView_:setBkgColor({107 / 255, 175 / 255, 248 / 255})
		-------------------------------------------------------------------------------
		local classifier      = map_classifier.get()
		newMapView_:loadClassifier(classifier)
		MapLayerController.setClassifierLayers(classifier.layers)
		-------------------------------------------------------------------------------
		createNewMapStates_()
		createPointsTriggerZone()
		onIconsThemeChange()
	end
end

-------------------------------------------------------------------------------
--
local function create_()
    window = Window.new(x_, y_, w_, h_)
    window:setTitleHeight(0)  
	createNewMapView_(w_, h_)
end



local function createMap()
	
	if needInitMapView then	
		setParamNewMapView()
		needInitMapView = false
	end
	
	newMapView_:setState(panState_)
	module_mission.createMapElements()
	if base.test_Visible_Map_Bounds == true then
		module_mission.createMapBounds(SW_bound_test[1]*1000, SW_bound_test[3]*1000, NE_bound_test[1]*1000, NE_bound_test[3]*1000) -- TEST!!!
	end
	NodesManager.initViews()
	NodesManager.resetViewsData(Terrain.GetTerrainConfig('id'))	
end

function initMapAfterSim()
	if Terrain.GetTerrainConfig('id') == nil then
		return
	end

	if Terrain.GetTerrainConfig('id') ~= TheatreOfWarData.getName() and Terrain.GetTerrainConfig('id') ~= nil then  
		if newMapView_ then
			newMapView_:resetEDTerrainGraphics()
		end	
          
		if newMapView_ then
			newMapView_.initEDTerrainGraphics('./')
		end	
		
		setParamNewMapView()
		
		TheatreOfWarData.selectTheatreOfWar(Terrain.GetTerrainConfig('id'))
	end	

end


function resetMapTerrain()
	--base.print("---resetMapTerrain---",newMapView_)
	if newMapView_ then
		newMapView_:resetEDTerrainGraphics()
	end
end


-------------------------------------------------------------------------------
--
function initTerrainLight(a_reason, a_date)
	base.print("--initTerrainLight--")
	local localeLang, localeCountry = i18n.getLocale()
	local result = Terrain.InitLight(TheatreOfWarData.getTerrainConfig(), a_reason, a_date)
	
	if result == true then
		listAirdromes = {}
		for airdromeNumber, airdromeInfo in pairs(Terrain.GetTerrainConfig('Airdromes')) do
			if (airdromeInfo.reference_point) and (airdromeInfo.abandoned ~= true)  then
				listAirdromes[airdromeNumber] = airdromeInfo
			end
		end
		local numAir=0
		for k,v in base.pairs(listAirdromes) do
			numAir = numAir + 1
		end
    end	
    
    return result
end


-------------------------------------------------------------------------------
--
function initTerrain(a_bChange, a_noInitTerrain, a_reason, a_date)
--base.U.stack()
--base.U.traverseTable(a_date)
base.print("---initTerrain---",a_bChange, a_noInitTerrain, a_reason)
	if not window then
        create_()
	else
		newMapView_:resetEDTerrainGraphics()
    end
	
	local result = true
	
	if a_noInitTerrain == true then
		if newMapView_ then
			newMapView_.initEDTerrainGraphics('./')
		end	
	else
	--base.print("--initTerrain---")

		if base.initTer ~= true then
			if (base.START_PARAMS.opt_testmap == nil) or (base.START_PARAMS.opt_testmap == '') then
				result = Terrain.Init(TheatreOfWarData.getTerrainConfig(), a_reason, a_date)
				if newMapView_ then			
					newMapView_.initEDTerrainGraphics('./')
				end	
			else
				result = Terrain.Init(base.START_PARAMS.opt_testmap, a_reason, a_date)
				if newMapView_ then
					newMapView_.initEDTerrainGraphics('./')
				end	
			end
			if  result == true then
				base.initTer = true  
			end
		else						
			Terrain.Release()
			
			result = Terrain.Init(TheatreOfWarData.getTerrainConfig(), a_reason, a_date)
			
			if newMapView_ then
				newMapView_.initEDTerrainGraphics('./')
			end	
			base.START_PARAMS.opt_testmap = nil -- на случай если запускалось через командную строку
		end
		
		if result == false and a_bChange == true and TheatreOfWarData.getName() ~= 'Caucasus' then
			TheatreOfWarData.selectTheatreOfWar('Caucasus')
			return initTerrain(false, false, a_reason, a_date)	
		end   
    end
	
	if result == true then
		listAirdromes = {}
		for airdromeNumber, airdromeInfo in pairs(Terrain.GetTerrainConfig('Airdromes')) do
			if (airdromeInfo.reference_point) and (airdromeInfo.abandoned ~= true)  then
				listAirdromes[airdromeNumber] = airdromeInfo
			end
		end
		local numAir=0
		for k,v in base.pairs(listAirdromes) do
			numAir = numAir + 1
		end
		needInitMapView = true
    end	
    
    return result
end

-------------------------------------------------------------------------------
--
function setParamNewMapView()
	if newMapView_ then
	   clearUserObjects()
	end
	
    local defaultcamera	= Terrain.GetTerrainConfig("defaultcamera")
    local SW_bound_tmp 		= Terrain.GetTerrainConfig("SW_bound")
    local NE_bound_tmp 		= Terrain.GetTerrainConfig("NE_bound")

	SW_bound_test 	        = SW_bound_tmp
	NE_bound_test			= NE_bound_tmp
	SW_bound 	        = {SW_bound_tmp[1], 0, SW_bound_tmp[3]}
	NE_bound 			= {NE_bound_tmp[1], 0, NE_bound_tmp[3]}
    
    mod_weather.setCenterWeather((SW_bound[1]*1000+NE_bound[1]*1000)/2, (SW_bound[3]*1000+NE_bound[3]*1000)/2)

    listWinds = {}
  
	if newMapView_ then
		newMapView_:setMapBounds(SW_bound[1]*1000, SW_bound[3]*1000, NE_bound[1]*1000, NE_bound[3]*1000)
		-- устанавливаем камеру и масштаб
		setScale(1000000)
		newMapView_:setCamera(defaultcamera[1]*1000, defaultcamera[3]*1000)
	end
	
	NodesManager.onReloadTerrain(Terrain.GetTerrainConfig('id'))
end

-------------------------------------------------------------------------------
--
function getMapBounds()
    local SW_bound 		= Terrain.GetTerrainConfig("SW_bound")
    local NE_bound 		= Terrain.GetTerrainConfig("NE_bound")
    return SW_bound, NE_bound
end


-------------------------------------------------------------------------------
--
function getRunwayHeading(roadnet)
	return Terrain.getRunwayHeading(roadnet)
end

-------------------------------------------------------------------------------
--
function setBullseye()
	local bs = Terrain.GetTerrainConfig("defaultBullseye") 
            or {blue = {x = -291014,y = 617414},red	 = {x = 11557, y = 371700}}  
	
	if  bs.neutrals == nil then 
		bs.neutrals = {x = 0, y = 0} 
	end
			
	module_mission.setBullseye(bs)
end

function onChange_Plus()
	setZoom(MOUSE_STATE.x, MOUSE_STATE.y, -0.1)
end	

function onChange_Minus()
	setZoom(MOUSE_STATE.x, MOUSE_STATE.y, 0.1)
end

function onChange_CoordsSys()
	local opt = OptionsData.getMiscellaneous('Coordinate_Display')
	local optDB = OptionsData.getMiscellaneousDb()['Coordinate_Display']

	local coordsSystems = {}
	local indexByValue = {}
	for k, v in base.pairs(optDB.values) do
		coordsSystems[k] = v.value
		indexByValue[v.value] = k
	end
	
	local index = indexByValue[opt] or 1
	local newOptIndex
	if index + 1 > #coordsSystems then
		newOptIndex = 1
	else
		newOptIndex = index + 1
	end

	optionsEditor.setOption("miscellaneous.Coordinate_Display", coordsSystems[newOptIndex])
	OptionsData.setMiscellaneous('Coordinate_Display', coordsSystems[newOptIndex])
		
	statusbar.updateOptions()
	local xr,yr = getMapPoint(MOUSE_STATE.x, MOUSE_STATE.y)
    statusbar.updateLatLong(xr, yr)	
end

function onChange_datum()
	local opt = OptionsData.getMiscellaneous('Datum')
	local optDB = OptionsData.getMiscellaneousDb()['Datum']

	local datums = {}
	local indexByValue = {}
	for k, v in base.pairs(optDB.values) do
		datums[k] = v.value
		indexByValue[v.value] = k
	end
	
	local index = indexByValue[opt] or 1
	local newOptIndex
	if index + 1 > #datums then
		newOptIndex = 1
	else
		newOptIndex = index + 1
	end
	
	optionsEditor.setOption("miscellaneous.Datum", datums[newOptIndex])
	OptionsData.setMiscellaneous('Datum', datums[newOptIndex])
	
	statusbar.updateOptions()
	local xr,yr = getMapPoint(MOUSE_STATE.x, MOUSE_STATE.y)
    statusbar.updateLatLong(xr, yr)	

	if mod_bullseye.isVisible() then
		mod_bullseye.update()
	end	

	panel_nav_target_fix_points.update()

	if mod_weather.isVisible() and mod_weather.isVisibleSun() then
		mod_weather.updateSunMoon()
	end
end

function onChange_headingUnit()
	local opt = OptionsData.getDifficulty('heading_units')
	local optDB = OptionsData.getDifficultyDb()['heading_units']

	local valuesOpt = {}
	local indexByValue = {}
	for k, v in base.pairs(optDB.values) do
		valuesOpt[k] = v.value
		indexByValue[v.value] = k
	end
	
	local index = indexByValue[opt] or 1
	local newOptIndex
	if index + 1 > #valuesOpt then
		newOptIndex = 1
	else
		newOptIndex = index + 1
	end
	
	optionsEditor.setOption("difficulty.heading_units", valuesOpt[newOptIndex])
	OptionsData.setDifficulty('heading_units', valuesOpt[newOptIndex])
	
	updateRulerText()	
	redrawRuler()
	statusbar.updateOptions()
end

function getCurPosition()
	return getMapPoint(MOUSE_STATE.x, MOUSE_STATE.y)
end

function updateMissionMapCenter()	
	local mapX, mapY = getCamera()
	module_mission.mission.map.centerX = mapX
	module_mission.mission.map.centerY = mapY
end

function onChange_Up()
	if newMapView_== nil or newMapView_:getVisible() ~= true then
		return
	end
	
	MOUSE_STATE.y = MOUSE_STATE.y + 10
    moveCursor(MOUSE_STATE.x, MOUSE_STATE.y)
	
	NewMapState.onMouseDrag(getPanState(), 0, 10, 3, MOUSE_STATE.x, MOUSE_STATE.y)
	MapController.onMapMouseMove(MOUSE_STATE.x, MOUSE_STATE.y)
	updateMissionMapCenter()
end

function onChange_Down()
	if newMapView_== nil or newMapView_:getVisible() ~= true then
		return
	end
	
	MOUSE_STATE.y = MOUSE_STATE.y - 10
    moveCursor(MOUSE_STATE.x, MOUSE_STATE.y)
	
	NewMapState.onMouseDrag(getPanState(), 0, -10, 3, MOUSE_STATE.x, MOUSE_STATE.y)
	MapController.onMapMouseMove(MOUSE_STATE.x, MOUSE_STATE.y)
	updateMissionMapCenter()
end

function onChange_Right()
	if newMapView_== nil or newMapView_:getVisible() ~= true then
		return
	end
	
	MOUSE_STATE.x = MOUSE_STATE.x - 10
    moveCursor(MOUSE_STATE.x, MOUSE_STATE.y)
	
	NewMapState.onMouseDrag(getPanState(), -10, 0, 3, MOUSE_STATE.x, MOUSE_STATE.y)
	MapController.onMapMouseMove(MOUSE_STATE.x, MOUSE_STATE.y)
	updateMissionMapCenter()
end

function onChange_Left()
	if newMapView_== nil or newMapView_:getVisible() ~= true then
		return
	end
	
	MOUSE_STATE.x = MOUSE_STATE.x + 10
    moveCursor(MOUSE_STATE.x, MOUSE_STATE.y)
	
	NewMapState.onMouseDrag(getPanState(), 10, 0, 3, MOUSE_STATE.x, MOUSE_STATE.y)
	MapController.onMapMouseMove(MOUSE_STATE.x, MOUSE_STATE.y)
	updateMissionMapCenter()
end
	
function isCreated()
	if window then
		return true
	end
	return false	
end

-------------------------------------------------------------------------------
--
function getObjectById(id)
    return module_mission.mapObjects[id]
end

-------------------------------------------------------------------------------
-- возвращает тип поверхности
-- lat, lon - координаты в радианах
-- radius - радиус в радианах
-- возвращает:
-- 'sea' - море
-- 'lake' - озеро
-- 'river' - река
-- 'land' - земля
function getSurfaceType_(mapX, mapY)
  return Terrain.GetSurfaceType(mapX, mapY)
end  


function findValidStrikePoint(a_mapX, a_mapY, a_surfTypes, a_offset, a_minDepth)
	if a_surfTypes == nil then
		a_surfTypes = {'land'}
	end
	
	local function isEnableSurfTypes(a_st, a_surfTypesGR)
		for k,v in base.pairs(a_surfTypesGR) do
			if a_st == v then
				return true
			end
		end
		return false
	end
	
    local offset = a_offset or 50;
    local new_pt = {}
    local pi = base.math.pi
    local sin = base.math.sin
    local cos = base.math.cos

    if getPointInMap(a_mapX, a_mapY) then
        local surfaceType = getSurfaceType_(a_mapX, a_mapY)
        if (isEnableSurfTypes(surfaceType, a_surfTypes)) then  
			if a_minDepth ~= nil then
				local  h_surface , depth_in_point = Terrain.GetSurfaceHeightWithSeabed(a_mapX, a_mapY) 
				if depth_in_point > a_minDepth then
					return a_mapX, a_mapY
				end
			else
				return a_mapX, a_mapY
			end           
        end
    end
    
    for i=1 , 200 do
        local pt_in_round 	= i * 8
        local dt_ang 		= 2 * pi / pt_in_round
        local len 			= offset * i * i		
        local ang 			= 0
                
        for n=1 , pt_in_round do
            new_pt 	= {}
            new_pt.x = a_mapX + len * sin(ang)
            new_pt.y = a_mapY + len * cos(ang)

            if getPointInMap(new_pt.x, new_pt.y) then
                local surfaceType = getSurfaceType_(new_pt.x, new_pt.y)
                if (isEnableSurfTypes(surfaceType, a_surfTypes)) then 
					if a_minDepth ~= nil then
						local  h_surface , depth_in_point = Terrain.GetSurfaceHeightWithSeabed(new_pt.x, new_pt.y) 
						if depth_in_point > a_minDepth then
							return new_pt.x, new_pt.y
						end
					else
						return new_pt.x, new_pt.y
					end
                end
            end                    
            ang = ang + dt_ang;
        end
        
    end
end



-------------------------------------------------------------------------------
--
function showWarningWindow(text)
	MsgWindow.warning(text, _('WARNING'), 'OK'):show()
end

-------------------------------------------------------------------------------
-- Фильтр задает список classKey выбираемых объектов в виде: {["classKey"]=true,...}.
-- Возвращает первый попавшийся пользовательский объект.
-- Возвращаются не только точечные, но и линейные объекты!
-- cx, cy в метрах
function pickUserObject(cx, cy, radius, selectNext)
    local objects = findUserObjects(cx, cy, radius) -- возвращает таблицу вида {id, id, ...}
    local enableDot = false
	-- удаляем из списка выделяемых объектов аэродромы и маяки, зоны досягаемости, подписи
	local k 
	
	for k = #objects, 1, -1 do		
		local object = module_mission.mapObjects[objects[k]]
		local object2 = MapController.isPickMapObjects(objects[k])
				
		if object2 == true then
		elseif  object == nil or 
			object.subclass == 'text' or 
			object.classKey == 'RouteLine' or
			object.classKey == 'ThreatRangeBorder' or
			object.classKey	== 'FlightPointIcon' or 
			object.userObject == nil or
			object.userObject.type == '' or
			object.classKey == 'L0091000301' or --линия таргета
			object.classKey == 'S0000000530' or
			getObjectType(getObjectById(objects[k])) == "TIT" or
			(panel_dataCartridge.isEditState() == true 
				and (object.classKey	~= 'POINTDATACARTRIDGE_ROUND'
				and object.classKey 	~= 'POINTDATACARTRIDGE_SQUARE'
				and object.classKey 	~= 'POINTDATACARTRIDGE_TRIANGLE')) then
			
			table.remove(objects, k)
        end
	end
	
	base.table.sort(objects)
  
    local index = 0 
    local firstObjId -- первый объект  списка
    local selectedObjectPresent = false
   
    for i = 1, #objects do
        local obj = getObjectById(objects[i])
		local obj2 = MapController.getPickMapObjects(objects[i])
		
        if obj then
			firstObjId = firstObjId or objects[i] -- инициализация первого объекта
			if obj.id  == selectedObject then
			  selectedObjectPresent = true
			  firstObjId = objects[i]
			end
		elseif obj2 then
			firstObjId = firstObjId or objects[i] -- инициализация первого объекта
			if obj2 == MapController.getSelectedObjectId() then
			  selectedObjectPresent = true
			  firstObjId = objects[i]
			end
		end	
    end
    
    if (selectNext == true) then
        for i = 1, #objects do
            local obj = getObjectById(objects[i]) 
			local obj2 = MapController.getPickMapObjects(objects[i])
            if obj and (obj.id  == selectedObject) then
                if i < #objects then
                    index = i+1
                else
                    index = 1
                end
            end
			
			if obj2 and obj2 == MapController.getSelectedObjectId() then
                if i < #objects then
                    index = i+1
                else
                    index = 1
                end
            end
        end       
    end
    
    if index > 0  then 
        return objects[index], true  -- хотим выделить следующий объект
    else 
        if selectedObjectPresent then-- если объектов несколько, то смотрим выделенный объект
            return firstObjId, false-- не хотим выделять объектов
        else    
            return firstObjId, true
        end    
    end		
end

function getPictObjects(mapX, mapY, radius)
	local objects = findUserObjects(mapX, mapY, radius) -- возвращает таблицу вида {id, id, ...}
	local enableDot = false
	-- удаляем из списка выделяемых объектов аэродромы, маяки, зоны досягаемости, подписи
	local k 
	for k = #objects, 1, -1 do
		local object = module_mission.mapObjects[objects[k]]
		local object2 = MapController.isPickMapObjects(objects[k])
		
		if object2 == true then
		elseif object == nil or 
			object.subclass			== 'text' or 
			object.classKey			== 'RouteLine' or
			object.classKey			== 'ThreatRangeBorder' or
			object.classKey			== 'FlightPointIcon' or 
			object.userObject		== nil or
			object.userObject.type	== '' or
			getObjectType(getObjectById(objects[k])) == "TIT" then
			
			table.remove(objects, k)
        end
	end
	
	return objects
end

function getListObj(mapX, mapY, radius)
	local objects = getPictObjects(mapX, mapY, radius)
	
	if objects == nil then
		return {}
	end
	local listObj = {}
	local item	

	local unitsList = {}

	for k,id in base.pairs(objects) do
		if MapController.isPickMapObjects(id) then
			
			base.table.insert(listObj, { type = "obj2", displayName = MapController.getObjectDisplayName(id), mapId = id })
		else
			local obj = getObjectById(id)
			
			if obj.classKey ~= 'L0091000301' then
				local unit
				if obj.subclass == 'unit' then
					unit = obj.userObject	
					item = { type = "unit", unit = unit, displayName = unit.name, mapId = id }		
				else
					local group = obj.userObject.boss

					if obj.classKey == 'P0091000044' or obj.classKey == 'S0000000530' then
					  group = group.boss
					end
					
					local wptName = nil
					if obj.classKey == 'P0091000041' then  --точка маршрута
						local name = base.tostring(obj.userObject.index-1)
						wptName = module_mission.reNameWaypoints(name, obj.userObject.index, #group.route.points, group.boss.name)
					end
					
					if group then
						unit = group.units[1]
						item = { type = "group", unit = unit, group = group, displayName = unit.name, mapId = id, wptName = wptName }
					end
				end
				
				
				if unit and unitsList[unit] ~= true then
					base.table.insert(listObj, item)
					unitsList[unit] = true
				end
			end	
		end	
	end
	return listObj
end

-------------------------------------------------------------------------------
-- remove selection
function unselectAll()
    for k,v in pairs(selectedGroups) do        
        if selectedGroup and selectedGroup.groupId == v then
            selectedGroup = nil;
        end
        revert_selection(module_mission.getGroup(v))
    end

	removeAllSelectedGroups()
    setSelectedObject(nil)
	MapController.resetSelection()
        
    if selectedGroup then
        local g = selectedGroup
        revert_selection(selectedGroup)               
        selectedGroup = nil
        if g and g.mapObjects then
            module_mission.update_group_map_objects(g)
        end
		panel_nav_target_fix_points.vdata.selectedPointNTP = nil
		panel_nav_target_fix_points.vdata.selectedPointIFP = nil
    end
	if panel_targeting.vdata.target ~= nil then
		panel_targeting.selectTarget(nil)
		panel_targeting.vdata.target = nil
	end
end


-------------------------------------------------------------------------------
-- Восстанавливаются умалчиваемые цвета объектов группы на карте.
function revert_selection(group)
    if not group or not group.mapObjects then
        return;
    end;
	if (group.mapObjects) and (group.mapObjects[1]) and (group.mapObjects[1].currColor) then
		group.mapObjects[1].currColor = group.color
		module_mission.update_bullseye_map_objects()
	end
	
	if (group.mapObjects.units) then
		for i,v in pairs(group.mapObjects.units) do
			v.currColor = group.color
		end
	end
	
  if group.mapObjects.route then
    for i,v in pairs(group.mapObjects.route.points) do
      v.currColor = group.color
    end
    for i,v in pairs(group.mapObjects.route.numbers) do
      v.currColor = group.color
    end
    group.mapObjects.route.line.currColor = group.color
    for i,v in pairs(group.mapObjects.route.targets) do
      for j,u in pairs(v) do
        u.currColor = group.color
      end
    end
    for i,v in pairs(group.mapObjects.route.targetNumbers) do
      for j,u in pairs(v) do
        u.currColor = group.color
      end
    end
    for i,v in pairs(group.mapObjects.route.targetLines) do
      for j,u in pairs(v) do
        u.currColor = group.color
      end
    end
  end
  
  if group.mapObjects.INUFixPoints then
    for i,v in pairs(group.mapObjects.INUFixPoints) do
        v.currColor = group.boss.boss.selectGroupColor;
    end;
  end;
  if group.mapObjects.INUFixPoints_numbers then
    for i,v in pairs(group.mapObjects.INUFixPoints_numbers) do
        v.currColor = group.boss.boss.selectGroupColor;
    end;
  end;
  
  if group.mapObjects.NavTargetPoints then
    for i,v in pairs(group.mapObjects.NavTargetPoints) do
        v.currColor = group.boss.boss.color --group.boss.boss.selectGroupColor;
    end;
  end;
  if group.mapObjects.NavTargetPoints_numbers then
    for i,v in pairs(group.mapObjects.NavTargetPoints_numbers) do
        v.currColor = group.boss.boss.color --group.boss.boss.selectGroupColor;
    end;
  end;
  if group.mapObjects.NavTargetPoints_comments then
    for i,v in pairs(group.mapObjects.NavTargetPoints_comments) do
        v.currColor = group.boss.boss.color --group.boss.boss.selectGroupColor;
    end;
  end;
  module_mission.update_group_map_objects(group)
end

-------------------------------------------------------------------------------
-- Устанавливается цвет объектов карты для выбранной группы.
function set_selected_group_color(group)
  local select_color = group.boss.boss.selectGroupColor;
  local mapObjects = group.mapObjects
  
  for i, v in pairs(mapObjects.units) do
    v.currColor = select_color
  end
  
  local route = mapObjects.route  
  
  if route then
    for i,v in pairs(route.points) do
      v.currColor = select_color
    end

    for i,v in pairs(route.numbers) do
      v.currColor = select_color
    end
    
    route.line.currColor = select_color  
    
    for i,v in pairs(route.targets) do
        for k,w in pairs(v) do
            w.currColor = select_color
        end;
    end
    for i,v in pairs(route.targetZones) do
        for k,w in pairs(v) do
            w.currColor[1] = select_color[1]
            w.currColor[2] = select_color[2]
            w.currColor[3] = select_color[3]
        end;
    end
    for i,v in pairs(route.targetNumbers) do
        for k,w in pairs(v) do
            w.currColor = select_color
        end;
    end
    for i,v in pairs(route.targetLines) do
        for k,w in pairs(v) do
            w.currColor = select_color
        end;
    end
  end;
    
  module_mission.update_group_map_objects(group)
end

-------------------------------------------------------------------------------
-- проверка того, что рулетка включена
local function getRulerStarted_()
  return ruler_ and ruler_.started
end

-------------------------------------------------------------------------------
-- обновить текст рулетки
function updateRulerText()
  if getRulerStarted_() then
	local opt = OptionsData.getDifficulty('heading_units')
    local distance = getDistance(ruler_.tape.points[1], ruler_.tape.points[2])
    local angleInRadians = getAngle(ruler_.tape.points[1], ruler_.tape.points[2])
    local angle = math.mod(360 + UC.toDegrees(angleInRadians), 360)
	
	local unitSys = OptionsData.getUnits()
	local sunit
	
	if (unitSys == "metric") then
		sunit = _('m')	
		distance = math.floor(distance)
        if (distance > 1000) then
            distance = distance /1000
            sunit = _('km')
        end
	else
		sunit = _('feet')
		distance = math.floor(distance/0.3048)
        if (distance > 6076.12) then
            distance = math.floor(distance/6.07612) / 1000
            sunit = _('nm')
        end
	end
	
	local text	
	if opt == 1 then
		text = distance ..' '..sunit..', '.. angle ..'°'
	else	
		local angleM = math.mod(360 + UC.toDegrees(angleInRadians, true), 360)
		text = base.string.format("%.3f %s, %d°°", distance, sunit, base.math.floor(angleM*17.777778 + 0.5))
	end
    
    ruler_.text.title = text
  end
end

-------------------------------------------------------------------------------
-- обновить вторую точку рулетки
local function updateRulerSecondPoint_(mapX, mapY)
  if getRulerStarted_() then
    local point = ruler_.tape.points[2]
    
    point.x = mapX
    point.y = mapY
    
    -- смещение текста рулетки относительно второй точки
    local tx, ty = getMapSize(15, -10)
    
    ruler_.text.x = mapX + tx
    ruler_.text.y = mapY + ty
  end
end

-------------------------------------------------------------------------------
-- обновить рулетку
local function updateRuler_(mapX, mapY)
  if getRulerStarted_() then
    updateRulerSecondPoint_(mapX, mapY)
    updateRulerText()
    
    removeUserObjects({ruler_.tape, ruler_.text})
    addUserObjects({ruler_.tape, ruler_.text})
  end  
end

function redrawRuler()
	if getRulerStarted_() then
		removeUserObjects({ruler_.tape, ruler_.text})
		addUserObjects({ruler_.tape, ruler_.text})
	end  
end

-------------------------------------------------------------------------------
-- функции для работы с рулеткой
-- создать рулетку
local function createRuler_(mapX, mapY)
  if not ruler_ then
    local points = {createPoint(mapX, mapY), createPoint(mapX, mapY)}     
    
    ruler_ = {}
    ruler_.tape = createLIN('L0000000525', 0, points)
    ruler_.text = createTIT('T0000000533', 1, mapX, mapY, "")
  else
    local point = ruler_.tape.points[1]
    
    point.x = mapX
    point.y = mapY
  end
  
  ruler_.started = true  
  updateRuler_(mapX, mapY)  
end

-------------------------------------------------------------------------------
-- удалить рулетку с карты
local function resetRuler_()
  if ruler_ then
    module_mission.set_mapObjects(ruler_.tape.id, nil)
    module_mission.set_mapObjects(ruler_.text.id, nil)
    removeUserObjects({ruler_.tape, ruler_.text})
    ruler_.started = false
  end
end

-------------------------------------------------------------------------------
-- start show ruler
function startRuler_(x, y)
    resetRuler_()
    createRuler_(getMapPoint(x, y))
end

-------------------------------------------------------------------------------
-- called on ruler extended
local function moveRuler_(x, y)
  updateRuler_(getMapPoint(x, y))
end

-------------------------------------------------------------------------------
-- Нужно четко разграничить состояния карты, чтобы при любом переключении диалогов
-- соответствующим образом переключались и состояния карты.
-- Например, состояние panState предназначено только для обзора карты и выборки объектов миссии.
-- В этом состоянии нельзя создавать и редактировать объекты миссии на карте.
-- Когда, например, нажимается одна из кнопок групп юнитов, карта переводится в режим
-- создания группы соответствующего типа (createPlaneGroupState, createShipGroupState и т.п.) до тех пор,
-- пока группа не будет создана.
-- После создания группы карта переводится в режим добавления точки маршрута addWaypointState.
-- В этом режиме также могут вводиться состояния редактирования точки маршрута editWaypointState,
-- добавления цели в точке маршрута addWaypointTarget и т.д.
-- Наконец, при закрытии диалога группы карта вновь переводится в умалчиваемое состояние panState.
-- Таким образом, у разработчика всегда имеется возможность при переключении диалогов сбросить
-- специфическое состояние карты и перевести его в умалчиваемое вызовом функции setState(panState).

function hideGroupPanels()
	panel_aircraft.show(false)
	panel_static.show(false)
	panel_bullseye.show(false)
	panel_ship.show(false)
	panel_vehicle.show(false)
    panel_paramFM.show(false)
	panel_radio.show(false)
	panel_route.show(false)
	panel_suppliers.show(false)
    panel_wpt_properties.show(false)
	panel_targeting.show(false)
	panel_payload.show(false)
    pPayload_vehicles.show(false)
	panel_summary.show(false)
	panel_triggered_actions.show(false)
	panel_dataCartridge.show(false)
	panel_nav_target_fix_points.show(false)
end

function isMouseDown()
	return bMouseDown
end

-------------------------------------------------------------------------------
-- Функции умалчиваемого режима карты PAN.
  function panState_onMouseUp(self, x, y, button) 
	bMouseDown = false
    MOUSE_POS = MOUSE_POS or {}
	if bCreatedUnit == true then
		setState(getAddingWaypointState())	
		bCreatedUnit = false
	end
    -- показывает таскали ли мы объект
    -- необходимо для того, чтобы предотвратить ситуацию, когда
    -- объект схватили, потаскали, а потом поставили в первоначальную точку    
    local drag = MOUSE_POS.drag
    MOUSE_POS.drag = false
    if 2 == button then
		toolbar.untoggle_tape()
		resetRuler_()
      return
    elseif (4 == button) or (5 == button) then
    elseif (3 == button) then
        if drag ~= true then
            unselectAll()
            hideGroupPanels()
            toolbar.untoggle_all_except()			
        end
    else			
        if MOUSE_POS.x and MOUSE_POS.y then
            if math.sqrt( (MOUSE_POS.x - x)^2 + (MOUSE_POS.y - y)^2 ) <= 2 then 
                -- позиции нажатия и отпускания совпали, надо выбрать следующий объект
                if true ~= drag and not gui.GetKeyboardButtonPressed("left alt") then
                    handleLeftMouseDown(MOUSE_POS.x, MOUSE_POS.y, true)
                    MOUSE_POS.handled = true                   
                end
            end
        end
        
        if waypointDragged then			
            local group = selectedGroup            
            local wpt = waypointDragged
            local alt = U.getAltitude(wpt.x, wpt.y)
			          
            if group ~= nil then					
				if (waypointDragged.airdromeId ~= nil) or (waypointDragged.helipadId ~= nil) then
					local listP ={}
					local airdrom = nil

					airdrom, listP = mod_parking.findAirport(group,wpt.x, wpt.y)
					
					if airdrom == nil and waypointDragged.airdromeId ~= nil 
						and panel_route.isTakeOffParking(waypointDragged.type) then --если все заняты оставляем где стоит/ для аэродромов только с парковками
						mod_parking.resetAirGroupOnParking(group, listAirdromes[waypointDragged.airdromeId].roadnet)
						waypointDragged = nil
						NewMapState.onMouseUp(self, x, y, button)
						return
					elseif airdrom == nil and  waypointDragged.helipadId ~= nil then	
						local unitHelipad = base.module_mission.unit_by_id[helipadId]
						if unitHelipad and unitHelipad.boss.type == "ship" then
							mod_parking.resetAirGroupOnShip(group, unitHelipad)
							waypointDragged = nil
							NewMapState.onMouseUp(self, x, y, button)
							return
						end							
					end
					
					if panel_route.isTakeOffParking(waypointDragged.type) then
						if (group.type == 'helicopter')then
							local listPf ={}
							local farp = nil
							farp,listPf = mod_parking.findFarp(group, wpt.x, wpt.y)
							local grassAirfield = mod_parking.findGrassAirfield(group, wpt.x, wpt.y)
							
							if (farp) and (farp.dist < airdrom.dist) and (not grassAirfield or (farp.dist < grassAirfield.dist)) then
								mod_parking.setAirGroupOnFarp(group, farp)
							else
								local ship, listPs = mod_parking.findShip(group, wpt.x, wpt.y)                               
								if (ship) and (ship.dist < airdrom.dist) and (not grassAirfield or (ship.dist < grassAirfield.dist)) then
									if (waypointDragged.helipadId == nil)
										or (ship.unitId ~= waypointDragged.helipadId) then
										mod_parking.setAirGroupOnShip(group, ship, listPs)
									else
										mod_parking.resetAirGroupOnShip(group, module_mission.unit_by_id[ship.unitId])
									end
								elseif (grassAirfield) and (grassAirfield.dist < airdrom.dist) then  
									--ставим на grassAirfield
									mod_parking.setAirGroupOnGrassAirfield(group, grassAirfield)    
								else 
									if (waypointDragged.airdromeId == nil) 
										or (airdrom.ID ~= waypointDragged.airdromeId) then
										mod_parking.setAirGroupOnParking(group, airdrom, listP, true)
									else
										mod_parking.resetAirGroupOnParking(group, listAirdromes[airdrom.ID].roadnet)
									end
								end
							end
						else
							local ship,listPs = mod_parking.findShip(group, wpt.x, wpt.y)
							local grassAirfield = mod_parking.findGrassAirfield(group, wpt.x, wpt.y)
							if (ship) and (ship.dist < airdrom.dist) and (not grassAirfield or (ship.dist < grassAirfield.dist)) then
								if (waypointDragged.helipadId == nil)
									or (ship.unitId ~= waypointDragged.helipadId) then
									mod_parking.setAirGroupOnShip(group, ship, listPs)
								else
									mod_parking.resetAirGroupOnShip(group, module_mission.unit_by_id[ship.unitId])
								end
							elseif (grassAirfield) and (grassAirfield.dist < airdrom.dist) then  
									--ставим на grassAirfield
								mod_parking.setAirGroupOnGrassAirfield(group, grassAirfield)
							else                            
								if (waypointDragged.airdromeId == nil) 
									or airdrom.ID ~= waypointDragged.airdromeId then
									mod_parking.setAirGroupOnParking(group, airdrom, listP, true)
								else
									mod_parking.resetAirGroupOnParking(group, listAirdromes[airdrom.ID].roadnet)
								end
							end    
						end
						
															
						module_mission.calc_route_length(group)
						panel_summary.update()
						panel_route.update()
						waypointDragged = nil
						NewMapState.onMouseUp(self, x, y, button)
						return
					end
					
					if panel_route.isTakeOffRunway(waypointDragged.type) then
						local ship,listPs = mod_parking.findShip(group, wpt.x, wpt.y)
						local grassAirfield = mod_parking.findGrassAirfield(group, wpt.x, wpt.y)
						if (ship) and (ship.dist < airdrom.dist) and (not grassAirfield or (ship.dist < grassAirfield.dist)) then
							if (waypointDragged.helipadId ~= nil)
								and (ship.unitId == waypointDragged.helipadId) then
								mod_parking.resetAirGroupOnShip(group, module_mission.unit_by_id[ship.unitId])
								
								module_mission.calc_route_length(group)
								panel_summary.update()
								panel_route.update()
								waypointDragged = nil
								NewMapState.onMouseUp(self, x, y, button)
								return
							end						
						end
					end
				else
						-------------------				        
					if (group.type == 'plane' or group.type == 'helicopter')
						and MeSettings.getSnap() == true then    
						if not(panel_route.isAirfieldWaypoint(waypointDragged.type) or panel_route.isTakeOffGround(waypointDragged.type)) then
							panel_route.snapToNavPoint(waypointDragged, group)
							
							NewMapState.onMouseUp(self, x, y, button)
							MapController.onMapMouseUp(x, y, button)
							
							return
						end
					else
						module_mission.unlinkSnap(waypointDragged)	
					end
				end
			
                if group.type == 'plane' or group.type == 'helicopter' then                    
                    alt = math.max(alt, wpt.alt)
                end  
				
            end
            
            if wpt.alt_type == panel_route.alt_types_all.BARO.type then
              wpt.alt = alt
            end
            
            panel_route.updateAltSpeed()

            if waypointDragged.type and panel_route.isAirfieldWaypoint(waypointDragged.type) then
                panel_route.attractToAirfield(waypointDragged,
                        selectedGroup)
            end
            
            local rvd = panel_route.vdata
            
            if rvd and rvd.wpt and rvd.wpt.type and ('On Road' == rvd.wpt.type.action) then
                module_mission.move_waypoint_to_road(rvd.wpt, 'roads')
                local group = rvd.wpt.boss
                
				if (rvd.wpt.index == 1) then
					for i = 2, #group.units do
						local unit = group.units[i]
						module_mission.move_unit_to_road(unit, 'roads')
					end
				end
                
                if (rvd.wpt.index < 3) then 
                    module_mission.updateHeading(group)
                end
            end
            
            if rvd and rvd.wpt and rvd.wpt.type and ('On Railroads' == rvd.wpt.type.action) then
                module_mission.move_waypoint_to_road(rvd.wpt, 'railroads')
                local group = rvd.wpt.boss
                
				if (rvd.wpt.index == 1) then
					for i = 2, #group.units do
						local unit = group.units[i]
						module_mission.move_unit_to_road(unit, 'railroads')
					end;
				end
                
                if (rvd.wpt.index < 3) then 
                    module_mission.updateHeading(group)
                end
            end
          
			if group then
				module_mission.calc_route_length(group)
				                       
				if (group.route.points[1].type.action == "On Road") then
					panel_route.UpdateGroupOnRoad(group)
				end
			end
    
            panel_summary.update()
            panel_route.update()
        end
                
        selectObj()
        
    end    
    waypointDragged = nil
    NewMapState.onMouseUp(self, x, y, button)
	
	MapController.onMapMouseUp(x, y, button)
  end

function selectObj()
	if selectedGroup and selectedGroup.route and selectedGroup.route.points then 
		if selectedUnit then
			if 'On Road' == selectedGroup.route.points[1].type.action then
				module_mission.move_unit_to_road(selectedUnit, 'roads')
			end
			if 'On Railroads' == selectedGroup.route.points[1].type.action then
				module_mission.move_unit_to_road(selectedUnit, 'railroads')
			end
		end
		
		if selectedGroup.type == "static" then
			if selectedGroup.route.points[1] and selectedGroup.route.points[1].linkUnit and selectedGroup.linkOffset ~= true then
				move_waypoint(selectedGroup, 1, selectedGroup.route.points[1].linkUnit.x, selectedGroup.route.points[1].linkUnit.y, nil, true)
				if (selectedGroup.type == 'static') then
				selectedGroup.x = selectedGroup.route.points[1].linkUnit.x
				selectedGroup.y = selectedGroup.route.points[1].linkUnit.y
				module_mission.update_group_map_objects(selectedGroup)
			end
				move_group(selectedGroup, selectedGroup.route.points[1].linkUnit.x, selectedGroup.route.points[1].linkUnit.y)  
			end
		end
	end
end

function setSelectedUnit(a_selectedUnit)
	selectedUnit = a_selectedUnit
end

function getSelectedUnit()
	return selectedUnit
end

-------------------------------------------------------------------------------
--
local function onGroupMouseDown_(mapX, mapY, obj)
	local unit = nil
  
	if obj.subclass == 'unit' then
		unit = obj.userObject			
	else
		local group = obj.userObject.boss

		if obj.classKey == 'P0091000044' then
		group = group.boss
		end
    
		if group then
			unit = group.units[1]
		end
	end		

	if unit and panel_route.onMapUnitSelected(unit) then
		return
	end

    multiselect = false
    if window~=nil then
        if gui.GetKeyboardButtonPressed("left shift") then
            multiselect = true   
        end
    end
	if not multiselect then unselectAll() end

	setSelectedObject(obj.id)
  
	local group = obj.userObject.boss
  
	if obj.classKey == 'P0091000044' then
		group = group.boss
	end
  
	local anchorType
  
	selectedUnit = nil
  
	if obj.waypoint then
        anchorType = 'waypoint'
	elseif 'unit' == obj.subclass then
        anchorType = 'unit'
        selectedUnit = obj.userObject        
	end

	local function selectGroupByMouse()
		respondToSelectedUnit(obj, group, selectedUnit)
		panel_units_list.updateRow(group, selectedUnit)  
	end

	local oldGroup = group
	if group == panel_aircraft.vdata.group and panel_dataCartridge.isEditState() ~= true then
		selectGroupByMouse()
	else
		panel_aircraft.onCloseAttempt(selectGroupByMouse)
	end  
	module_mission.update_group_map_objects(oldGroup) -- для удаления точек dataCartridge с карты 
 
    if group.groupId ~= nil then
        if selectedGroups[group.groupId] ~=nil then
            removeSelectedGroups(group)
            revert_selection(group)
            selectedGroup = nil
            panel_aircraft.show(false)
        else
            addSelectedGroup(group)
        end		
	end
end
  
  
-------------------------------------------------------------------------------
--
function selectBullseye(color)
    unselectAll()
	onBullseyeMouseDown_(module_mission.mission.bullseye[color].mapObjects[1])
end

-------------------------------------------------------------------------------
--
function onBullseyeMouseDown_(obj)	
	toolbar.untoggle_all_except()
	setSelectedObject(obj.id)
	selectedGroup = obj.userObject
	obj.currColor = obj.userObject.selectGroupColor
	mod_bullseye.vdata.coalition = obj.userObject.coalition
	mod_bullseye.show(true)
	module_mission.update_bullseye_map_objects()
end

-------------------------------------------------------------------------------
--
function onCyclonMouseDown_(obj)
	setSelectedObject(obj.id)
	selectedGroup = obj.userObject
	obj.currColor = obj.userObject.selectGroupColor
end

-------------------------------------------------------------------------------
--
function onDataCartridgePointMouseDown_(obj)	
	panel_dataCartridge.selectPoint(obj.userObject)	
end

-------------------------------------------------------------------------------
--
function onCycloneMouseDown_(obj)
	setSelectedObject(obj.id)
	selectedGroup = obj.userObject
	mod_weather.selectCyclon(obj.userObject)

	module_mission.update_map_object({obj})
end
  
-------------------------------------------------------------------------------
--
function move_bullseye(mapX, mapY)
	local obj = getObjectById(selectedObject)
	obj.userObject.x = mapX
	obj.userObject.y = mapY
	obj.x = mapX
	obj.y = mapY
	module_mission.update_bullseye_map_objects()
	mod_bullseye.update()
	panel_dataCartridge.moveBullseyeInAllUnits(mapX, mapY)
end

-------------------------------------------------------------------------------
--
function move_cyclon(mapX, mapY)
	local obj = getObjectById(selectedObject)
	obj.userObject.centerX = mapX
	obj.userObject.centerZ = mapY
	obj.x = mapX
	obj.y = mapY
	
	if obj.zone then
		obj.zone.x = mapX
        obj.zone.y = mapY
		obj.zone.points = module_mission.createCirclePoints(0, 0, obj.zone.radius)
		module_mission.update_map_object({obj.zone})
    end
	mod_weather.updateDataCyclonesValues()
    module_mission.update_map_object({obj})
end


-------------------------------------------------------------------------------
--
function handleLeftMouseDown(x, y, selectNext)
    if true == MOUSE_POS.handled then 
        return
    end
    
    local mapX, mapY = getMapPoint(x, y)
	
    -- Либо выбираем существующую группу, либо сбрасываем выбор.
    -- Сначала нужно восстановить родные цвета ранее выбранной группы.
    local iconSize = 10
    local radius = getMapSize(0, iconSize)
	
	local objId, allowSelection
	
	if gui.GetKeyboardButtonPressed("left alt") then
		local listObj = getListObj(mapX, mapY, radius)
		panelSelectUnit.show(true, listObj, callbackSelectUnit, x, y, mapX, mapY)
	else
		objId, allowSelection = pickUserObject(mapX, mapY, radius, selectNext)
		callbackSelectUnit(objId, allowSelection, false, mapX, mapY)
	end  
end

function callbackSelectUnit(objId, allowSelection, needSelect, mapX, mapY, bNoClick)
	local obj = module_mission.mapObjects[objId]
	
    if allowSelection   then -- объект один или никого нет, действуем по обычной процедуре
        MOUSE_POS.handled = true
    else --объектов несколько, действия производим в момент отпускания мыши
        MOUSE_POS.handled = false
		MapController.setMousePosition(mapX, mapY)
        return
    end
    
    waypointDragged = nil
    -- Радиус зоны выборки зависит от текущего масштаба.
    -- Здесь он подобран под размеры иконок юнитов и точек маршрута.
    -- радиус стоит сделать равным либо 1/2 размера иконок - радиус вписаной окружности,
    -- либо равным 1/2 размера иконок * 2^0.5 - радиус описанной окружности
    if obj then   
        if obj.classKey == 'P0091000347' then
            unselectAll()
			onBullseyeMouseDown_(obj)
		elseif panel_dataCartridge.isEditState() then
			
			if obj.classKey == 'POINTDATACARTRIDGE_ROUND' 
				or obj.classKey == 'POINTDATACARTRIDGE_SQUARE'
				or obj.classKey == 'POINTDATACARTRIDGE_TRIANGLE' then
				onDataCartridgePointMouseDown_(obj)
			end
		elseif obj.classKey == 'P0091000349' then
			unselectAll()
			onCyclonMouseDown_(obj)
        elseif obj.userObject and obj.userObject.boss and (getObjectType(obj) == 'DOT') then
            onGroupMouseDown_(mapX, mapY, obj)
        else
            unselectAll()
            hideGroupPanels()
            toolbar.untoggle_all_except()
        end
		
		MapController.resetSelection()		
    else        
		toolbar.untoggle_all_except()
		unselectAll()
		panel_aircraft.onCloseAttempt(function()
											hideGroupPanels()
											panel_units_list.show(false)
										end)
		MapController.onMapMouseDown(objId, mapX, mapY, 1, bNoClick)
    end 
	
	if needSelect then
		selectObj()
	end
end


-------------------------------------------------------------------------------
--
local function updateRulerTextOnZoom_()
  if getRulerStarted_() then
    local point = ruler_.tape.points[2]
    
    updateRuler_(point.x, point.y)
  end  
end

function panState_onMouseDown(self, x, y, button)
	bMouseDown = true
    local mapX, mapY = getMapPoint(x, y)
    -- Нажатие левой кнопки мыши на объекте группы вызывает его выбор без перемещения.
    MOUSE_POS = MOUSE_POS or {}
    MOUSE_POS.x = x
    MOUSE_POS.y = y
    MOUSE_POS.button = button
    MOUSE_POS.handled = false
	
    if 1 == button then
        handleLeftMouseDown(x,y,false)
    elseif 2 == button then		
        startRuler_(x, y)
	elseif 3 == button then
		panelContextMenu.show(true, x, y)
    end
end

-------------------------------------------------------------------------------
--
function panState_onMouseDrag(self, dx, dy, button, x, y)
    local mapX, mapY = getMapPoint(x, y)
    MOUSE_POS = MOUSE_POS or {}
    MOUSE_POS.drag = true;    
	moveCursor(x, y)
	
    if button == 2 then
      moveRuler_(x, y)
    elseif button == 1 then
		if actionEditPanel.isVisible() == true and panel_targeting.vdata.target ~= nil then            
			move_target(panel_targeting.vdata.target, mapX, mapY)
			local task = panel_targeting.vdata.target.task
			local actionParams = actionDB.getActionParams(task)
			actionParams.x = mapX
			actionParams.y = mapY
			panel_route.onTargetMoved(mapX, mapY) 
			return
		end
		
		if panel_dataCartridge.isEditState() then
			panel_dataCartridge.moveSelectedPoint(mapX, mapY)
			return
		end
        
        -- Выбранные точки маршрута можно двигать, но делать это нужно в специальном
      -- состоянии редактирования точки маршрута, когда открыта панель ROUTE и нажата кнопка EDIT.
        if panel_route.window:isVisible() and panel_route.window:getEnabled() == true and panel_route.b_edit:getState() then
            waypointDragged = panel_route.vdata.wpt	
        
        
            if (waypointDragged.airdromeId ~= nil) and  panel_route.isTakeOff(waypointDragged.type) then 
                if selectedGroup then
                    local wptIndex = base.panel_route.vdata.wpt.index;	                
                    move_waypoint(selectedGroup, wptIndex, mapX, mapY, nil, nil, true);
                    return
                end
            end		

            if selectedGroup then
              --base.print("selectedGroup", selectedGroup)
                -- Здесь тоже нужна проверка суша/море.
                -- Поскольку не везде объект можно поставить, то в onMouseUp() нужно проверять
                -- тип поверхности и отменять операцию перемещения, если тип не подходящий.
                local scale = getScale()
              
                local wptIndex = panel_route.vdata.wpt.index
                if (selectedGroup.route.points[wptIndex].type.type == panel_route.actions.takeoffRunway.type) then		
                    move_waypoint(selectedGroup, wptIndex, mapX, mapY, nil, true)
                    return
                end		
				

				if selectedUnit then
					if (selectedUnit.boss.type ~= "plane" and selectedUnit.boss.type ~= "helicopter")
						or (group.route.points[1].type.type == 'TakeOffGround' or group.route.points[1].type.type == 'TakeOffGroundHot') then
						move_unit(selectedGroup, selectedUnit, mapX, mapY)
					
					end						
				else				
					local dontMoveChild = false						
					if gui.GetKeyboardButtonPressed("left ctrl") 
						and ((selectedGroup.type ~= "plane" and selectedGroup.type ~= "helicopter")
							or (selectedGroup.route.points[1].type.type == 'TakeOffGround' or selectedGroup.route.points[1].type.type == 'TakeOffGroundHot')) then
						dontMoveChild = true	
					end
					
					move_waypoint(selectedGroup, wptIndex, mapX, mapY, nil, true, dontMoveChild, nil)
				end
                
                return
            end
        elseif panel_static.window:isVisible() then				
			if selectedGroup and selectedUnit and selectedUnit.index > 1 then
				move_unit(selectedGroup, selectedUnit, mapX, mapY)
				return
            elseif selectedGroup then
				local dontMoveChild = false						
				if gui.GetKeyboardButtonPressed("left ctrl") then 
					dontMoveChild = true	
				end
				
				move_waypoint(selectedGroup, 1, mapX, mapY, nil, true, dontMoveChild, nil)
				return
            end
        elseif panel_ship.window:isVisible()then	
              return
        elseif panel_targeting.window:isVisible() then
            if selectedGroup then					
              move_target(panel_targeting.vdata.target, mapX, mapY)
            end
		elseif panel_nav_target_fix_points.window:isVisible()then
			if selectedGroup and selectedGroup.INUFixPoints and panel_nav_target_fix_points.isEditIFP() then 
                for i,v in pairs(selectedGroup.INUFixPoints) do
                    local point = selectedGroup.INUFixPoints[i]
                    if point ==  panel_nav_target_fix_points.vdata.selectedPointIFP then
                        move_INU_Fix_Point(selectedGroup, i, mapX, mapY)
                        break
                    end
                end       
            end
			if selectedGroup and selectedGroup.NavTargetPoints and panel_nav_target_fix_points.isEditNTP() then 
                for i,v in pairs(selectedGroup.NavTargetPoints) do
                    local point = selectedGroup.NavTargetPoints[i]
                    if point ==  panel_nav_target_fix_points.vdata.selectedPointNTP then
                        move_Nav_Target_Point(selectedGroup, i, mapX, mapY)
                        break
                    end
                end           
            end
		elseif mod_weather:isVisible() then	
			if selectedObject then
				move_cyclon(mapX, mapY)
			end
		elseif panel_dataCartridge.isEditState() then
			if selectedGroup then
			
			
			end	
        elseif mod_bullseye.window:isVisible() then
                if selectedObject then
                    move_bullseye(mapX, mapY)
                end
        end
		
		MapController.onMapMouseDrag(x, y)
    end   

    NewMapState.onMouseDrag(self, dx, dy, button, x, y)
	
	updateMissionMapCenter()
end

-------------------------------------------------------------------------------
--
function panState_onMouseMove(self, x, y)
    MOUSE_STATE.x = x 
	MOUSE_STATE.y = y
    moveCursor(x, y)
	
	MapController.onMapMouseMove(x, y)
end

-------------------------------------------------------------------------------
--
function panState_onMouseWheel(self, x, y, clicks)
	setZoom(x, y, -clicks)
end

-------------------------------------------------------------------------------
--
function setZoom(x, y, dScale)
    local cx, cy = getCamera()
    local mx, my = getMapPoint(x, y)
    
    newMapView_:setScale(getScale() + dScale * (getScale() * 0.1))
    
    local nx, ny = getMapPoint(x, y)     
    
    local dx = nx - mx
    local dy = ny - my

    setCamera(cx - dx, cy - dy)    
     
    mapInfoPanel.update()
    module_mission.scale_mission_map_objects(getScale())
    updateRulerTextOnZoom_()
    MapLayerController.updateLayerVisible()
	
	module_mission.mission.map.zoom = getScale()
	
	if getState() == getRtsState() then
		RtsMapView.onChangeZoom(getScale())
	end
end

-------------------------------------------------------------------------------
--
function creatingPlaneState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then
		local mapX, mapY = getMapPoint(x, y)
		createAircraft('plane', mapX, mapY)
		setState(getPanState())	
		return
    end
    panState_onMouseDown(self, x, y, button)
end
  
-------------------------------------------------------------------------------
--
function creatingHelicopterState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then
		local mapX, mapY = getMapPoint(x, y)
		createAircraft('helicopter', mapX, mapY)
		setState(getPanState())	
		return
    end
    
    panState_onMouseDown(self, x, y, button)
end

function isValidWater(a_unitType, x, y)
	local unitDef = DB.unit_by_type[a_unitType]
	local surfaceType = getSurfaceType_(x, y)
	if ('sea' ~= surfaceType and surfaceType ~= 'lake') 
			or (surfaceType == 'lake' and unitDef.riverCraft ~= true) then
		return false				
	end		
	return true
end

function isValidDepth(a_unitType, x, y)
	local unitDef = DB.unit_by_type[a_unitType]

	local  h_surface , depth_in_point = Terrain.GetSurfaceHeightWithSeabed(x,y) 	
	if unitDef.draft and depth_in_point < unitDef.draft then
		return false
	end
	return true
end

function isValidDepthGroup(a_group, x, y)
	local  h_surface , depth_in_point = Terrain.GetSurfaceHeightWithSeabed(x,y) 
	
	for k,unit in base.pairs(a_group.units) do
		local unitDef = DB.unit_by_type[unit.type]
		
		if unitDef.draft and depth_in_point < unitDef.draft then
			return false
		end
	end	
	return true
end

function createShip(mapX, mapY)
	unselectAll()
	-- Создаем новый корабль на основании данных,
	-- заданных в соответствующей панели.
	if not getPointInMap(mapX, mapY) then
		showWarningWindow(cdata.placeInside)
		return
	end
	
	local vd = panel_ship.vdata
	
	if isValidWater(vd.types[1], mapX, mapY) == false then
		showWarningWindow(_('Settle ships on appropriate water, please.'))
		return
	end
	
	if isValidDepth(vd.types[1], mapX, mapY) == false then
		showWarningWindow(_('Insufficient depth.'))
		return
	end
  
	toolbar.setShipButtonState(false)
	panel_ship.setSafeMode(false)
	panel_route.setSafeMode(false)
	local rvd = panel_route.vdata
	local tvd = panel_targeting.vdata
	local svd = panel_summary.vdata
	-- При добавлении точек группа должна быть известна как здесь, так и в диалогах группы.
	local group = module_mission.create_group(vd.country, 'ship', vd.name, nil, nil, nil, mod_weather.start_time, mapX, mapY)		
	group.task = vd.task
	selectedGroup = group
	vd.group = group
	vd.name = group.name
	vd.unit.cur = 1
	vd.unit.number = 1
	vd.skills = { vd.skills[1] }
	vd.types = { vd.types[1] }
	panel_route.setGroup(group)
	panel_triggered_actions.setGroup(group)
	tvd.group = group
	tvd.target = nil
	svd.group = group
	local unit = module_mission.insert_unit(group, vd.types[1], 
		vd.skills[1], 1, module_mission.getUnitName(group.name), nil, nil, vd.lastHeading)
	local name = unit.name
	panel_route.setWaypoint(	module_mission.insert_waypoint(group, 1, 
								panel_route.actions.turningPoint, mapX, mapY, 0, 0) )								
	unit.alt = group.route.points[1].alt
	rvd.wpt.ETA = 0.0
	panel_suppliers.setGroup(group, unit)
	set_group_color(group, group.boss.boss.selectGroupColor)
	set_unit_color(unit, group.boss.boss.selectUnitColor)
	set_waypoint_color(rvd.wpt, group.boss.boss.selectWaypointColor)
	set_route_line_color(group, group.boss.boss.selectGroupColor)
	module_mission.update_group_map_objects(group)

	panel_ship.setGroup(group)
	addSelectedGroup(group)
	
	bCreatedUnit = true
	
	panel_ship.update()
	panel_targeting.update(false)	  
	panel_route.update()
	panel_route.onGroupTaskChange()
end

-------------------------------------------------------------------------------
--
function creatingShipState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then
		local mapX, mapY = getMapPoint(x, y)
		createShip(mapX, mapY)
		setState(getPanState())
		return
    end
    panState_onMouseDown(self, x, y, button)
end

-------------------------------------------------------------------------------
--
function getCanSwimUnit(a_unit)
	local result = true

	local unitDef =  DB.unit_by_type[a_unit.type]
	result = result and (unitDef.chassis and unitDef.chassis.canSwim)
	
	return result == true
end

-------------------------------------------------------------------------------
--
function getCanSwimGroup(a_group)
	local result = true

	for k, unit in base.pairs(a_group.units) do
		result = result and getCanSwimUnit(unit)
	end
		
	return result == true
end  
  
function createVehicle(mapX, mapY)
	unselectAll()
	toolbar.setVehicleButtonState(false)
	-- Создаем новую колонну машинок на основании данных,
	-- заданных в соответствующей панели.
	
	if not getPointInMap(mapX, mapY) then
		showWarningWindow(cdata.placeInside)
		return
	end

	local vd = panel_vehicle.vdata
	vd.types = { vd.types[1] }
	local unitDef = DB.unit_by_type[vd.types[1]]

	if 'land' ~= getSurfaceType_(mapX, mapY)  and (unitDef.chassis and unitDef.chassis.canSwim) ~= true then
		showWarningWindow(_('Place ground vehicles on the land, please'))
		return
	end 

	panel_vehicle.setSafeMode(false)
	panel_route.setSafeMode(false)

	vd.task = panel_vehicle.cdata.new_group_task;    -- Нужна умалчиваемая задача для данного типа группы

	local rvd = panel_route.vdata
	local tvd = panel_targeting.vdata
	local svd = panel_summary.vdata

	-- При добавлении точек группа должна быть известна
	local group = module_mission.create_group(vd.country, 'vehicle', vd.name, nil, nil, nil, mod_weather.start_time, mapX, mapY)
	group.task = vd.task
	selectedGroup = group
	vd.group = group
	vd.name = group.name
	vd.unit.cur = 1
	vd.unit.number = 1
	vd.skills = { vd.skills[1] }      
	panel_route.setGroup(group)
	panel_triggered_actions.setGroup(group)
	tvd.group = group
	tvd.target = nil
	svd.group = group

	local unit = module_mission.insert_unit(group, vd.types[1], 
		vd.skills[1], 1, module_mission.getUnitName(group.name), nil, nil, vd.lastHeading) 
	local name = unit.name
	local alt = U.getAltitude(mapX, mapY)
		  
	if unitDef.category == 'Train' then
		panel_route.setWaypoint(	module_mission.insert_waypoint(group, 1, 
								panel_route.actions.onRailroads, mapX, mapY, alt, 20/3.6) )
	else
		panel_route.setWaypoint(	module_mission.insert_waypoint(group, 1, 
								panel_route.actions.offRoad, mapX, mapY, alt, 0) )
	end        

	unit.alt = group.route.points[1].alt
	rvd.wpt.ETA = 0.0
	set_group_color(group, group.boss.boss.selectGroupColor)
	set_unit_color(unit, group.boss.boss.selectUnitColor)
	set_waypoint_color(rvd.wpt, group.boss.boss.selectWaypointColor)
	set_route_line_color(group, group.boss.boss.selectGroupColor)

	module_mission.update_group_map_objects(group)

	panel_vehicle.setGroup(group)

	addSelectedGroup(group)

	bCreatedUnit = true

	panel_vehicle.update()
	panel_targeting.update(false)
	panel_route.update()
	panel_route.onGroupTaskChange()
end
  
-------------------------------------------------------------------------------
--
function creatingVehicleState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then
		local mapX, mapY = getMapPoint(x, y)
		createVehicle(mapX, mapY)
		setState(getPanState())
		return
    end
    panState_onMouseDown(self, x, y, button)
  end

-------------------------------------------------------------------------------
--
  function addingWaypointState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then
		-- Добавляем новую точку маршрута после текущей точки в миссию.
		-- Панель маршрута для текущей группы предполагается открытой.
		local group = panel_route.vdata.group
		if not (base.MapWindow.isShowHidden(group) == true) then
			return
		end
	  
		selectedGroup = group
		local mapX, mapY = getMapPoint(x, y)
		if not getPointInMap(mapX, mapY) then
			showWarningWindow(cdata.placeInside)
			return
		end
		local surfaceType = getSurfaceType_(mapX, mapY)
	  
		local unitDef =  DB.unit_by_type[group.units[1].type]  
	  
		local canSwim = getCanSwimGroup(group)
      
		if 'ship' == group.type then
			if isValidWater(group.units[1].type, mapX, mapY) == false then
				showWarningWindow(_('Settle ships on appropriate water, please.'))     
				return
			end

			if isValidDepthGroup(group, mapX, mapY) == false then
				showWarningWindow(_('Insufficient depth.'))
				return
			end	
		elseif 'vehicle' == group.type and 'land' ~= surfaceType and canSwim ~= true then
			showWarningWindow(_('Place ground vehicles on the land, please'))
        
			return        
		end

		local rvd = panel_route.vdata
		local ind = rvd.wpt.index + 1
		local type = panel_route.actions.turningPoint
		if group.type == 'vehicle' then
            type = rvd.wpt.type
		end
      
		local speed = rvd.wpt.speed
		if group.type == 'ship' then
			if ind > 1 then
				speed = group.route.points[ind-1].speed
			end
			
			if ind == 2 then 
				if group.route.points[ind-1].speed == 0 then
					speed = 13.88888	
				end
			end
		end
		
		if group.type == 'vehicle' then
			if ind > 1 then
				speed = group.route.points[ind-1].speed
			end
			
			if ind == 2 then 
				if group.route.points[ind-1].speed == 0 then
					speed = 20/3.6
				end
			end
		end
		local height = U.getAltitude(mapX, mapY)
		local alt = rvd.wpt.alt
		if panel_route.isTakeOff(rvd.wpt.type) == true then
			alt = 2000
		end
      
		if group.type == 'plane' then
			alt = math.max(height, alt)
		elseif group.type == 'helicopter' then
			alt = math.max(height, alt)
		elseif group.type == 'ship' then
			alt = height
		elseif group.type == 'vehicle' then
			alt = height
		end
      
		local formation_template = ""
		if group.type == 'vehicle' then
			if type == panel_route.actions.customForm then
				formation_template = rvd.wpt.formation_template
			end    
		end
      
		panel_route.setWaypoint(module_mission.insert_waypoint(group, ind, type, mapX, mapY, alt, speed, nil ,formation_template))
		rvd.wpt.ETA = 0.0
		panel_route.update()
		panel_summary.update()
		-- Обновляем объекты карты.
		set_waypoints_color(group, group.boss.boss.selectGroupColor)
		set_waypoint_color(rvd.wpt, group.boss.boss.selectWaypointColor)
		module_mission.update_group_map_objects(group)  
		panelActionCondition.correctWaypointsInActions(group, true, ind)
		return
    end
    
    panState_onMouseDown(self, x, y, button)
  end

-------------------------------------------------------------------------------
--
  function addingWaypointState_onMouseUp(self, x, y, button)
    local rvd = panel_route.vdata;

    if rvd and rvd.wpt and ('On Road' == rvd.wpt.type.action) then
        module_mission.move_waypoint_to_road(rvd.wpt, 'roads');
    end;
    if rvd and rvd.wpt and ('On Railroads' == rvd.wpt.type.action) then
        module_mission.move_waypoint_to_road(rvd.wpt, 'railroads');
    end;
    
    panState_onMouseUp(self, x, y, button)
  end

-------------------------------------------------------------------------------
--
  function addingTargetState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then
      local mapX, mapY = getMapPoint(x, y)
      local tvd = panel_targeting.vdata
      local group = tvd.group

      selectedGroup = group
      local rvd = panel_route.vdata
      local wpt = rvd.wpt
      if not wpt.targets then
        wpt.targets = {}
      end
      local targets = wpt.targets
      local ind = #targets+1
      tvd.target = module_mission.insert_target(wpt, ind, mapX, mapY, tvd.radius)

      panel_targeting.selectTargetByIndex(0); -- сброс выделения
      set_target_color(tvd.target, group.boss.boss.selectWaypointColor)
      module_mission.update_group_map_objects(group)
      panel_targeting.setDefaultCategories()
      panel_targeting.update()
      return
    end
    
    panState_onMouseDown(self, x, y, button)
  end

-------------------------------------------------------------------------------
--
function creatingTemplateState_onMouseDown(self, x, y, button)
	bMouseDown = true
    function getNewXY(a_x, a_y, a_dx, a_dy, a_heading)
        local _new_x = a_x + a_dx*math.cos(a_heading) - a_dy*math.sin(a_heading)
        local _new_y = a_y + a_dx*math.sin(a_heading) + a_dy*math.cos(a_heading)
        return _new_x, _new_y 
    end
    
    if button == 1 then
	
		unselectAll()

		local mapX, mapY = getMapPoint(x, y)
		
		if not getPointInMap(mapX, mapY) then
			showWarningWindow(cdata.placeInside)
			
			return
		end

		local template = panel_template.getSelectedTemplate()
        local _heading = U.toRadians(panel_template.getHeading())
		
		if not template then return end
		
		local type = template.type
		local group_name = 'New Group'
		local unit_name = 'New Unit'
		
		if type == 'vehicle' then
			group_name = panel_vehicle.vdata.name
			unit_name  = module_mission.getUnitName(group_name)

            for k,v in base.pairs(template.units) do
                local mapXX, mapYY = getNewXY(mapX, mapY, v.dx, v.dy, _heading)
                if 'land' ~= getSurfaceType_(mapXX, mapYY) then
                    showWarningWindow(_('Place ground objects on the land, please'))                   
                    return
                end
            end
			
		elseif type == 'ship' then
			group_name = panel_ship.vdata.name
			unit_name  = module_mission.getUnitName(group_name)

            for k,v in base.pairs(template.units) do
                local mapXX, mapYY = getNewXY(mapX, mapY, v.dx, v.dy, _heading)
				if isValidWater(v.name, mapXX, mapYY) == false then
                    showWarningWindow(_('Settle ships on appropriate water, please.'))
                    return
                end
				
				if isValidDepth(v.name, mapXX, mapYY) == false then
					showWarningWindow(_('Insufficient depth.'))
					return
				end	
            end			
		elseif type == 'helicopter' or type == 'plane' then
			group_name = panel_aircraft.GetGroupName(type)
			unit_name  = module_mission.getUnitName(group_name)
		else
			if DB.ship_by_type[template.units[1].name] ~= nil then
				if isValidWater(template.units[1].name, mapX, mapY) == false then
					showWarningWindow(_('Settle ships on appropriate water, please.'))
					
					return
				end         
			else
				if 'land' ~= getSurfaceType_(mapX, mapY) then
					showWarningWindow(_('Place static objects on the land, please'))
					
					return
				end  
			end
			
			group_name = _('New Static Object')
			unit_name  = _('New Static Object') 
		end

		local group = module_mission.create_group(panel_template.getCountry(), type, group_name, nil, template.communication, template.frequency, mod_weather.start_time, mapX, mapY)
	  
		if not group then 
			return 
		end
		
		group.modulation = template.modulation
	  
		selectedGroup = group
		
		local alt = U.getAltitude(mapX, mapY)
	  
		for i,v in ipairs(template.units) do 
			v.skill = v.skill or "Good"
			v.heading = v.heading or 0
			local _heading = U.toRadians(panel_template.getHeading())
			local vehx_, vehy_ = x+v.dx, y+v.dy
			local _new_x = mapX + v.dx*math.cos(_heading) - v.dy*math.sin(_heading)
			local _new_y = mapY + v.dx*math.sin(_heading) + v.dy*math.cos(_heading)
			local skill = crutches.idToSkill(v.skill)

			if type == 'plane' or type == 'helicopter' then	
				skill = crutches.idToSkillAir(v.skill)
			end
			local unit = module_mission.insert_unit(group, v.name, skill, i, module_mission.getUnitName(group.name), _new_x, _new_y, math.mod(_heading + v.heading,2*math.pi))
			
			if v.payload then
				unit.payload = U.copyTable(nil, v.payload)
			end
			
			if type == 'static' then
				unit.shape_name = DB.unit_by_type[v.name].ShapeName
			end
		end

		local wpt = module_mission.insert_waypoint(group, 1, panel_route.actions.offRoad, mapX, mapY, alt, 20/3.6)
		
		local autoTasks = actionDB.createAutoActions(group, crutches.taskToId(group.task))
		if autoTasks then
			local firstWpt = group.route.points[1]
			if 	firstWpt.task and
				firstWpt.task.params.tasks then
				for taskIndex, task in pairs(firstWpt.task.params.tasks) do
					task.number = task.number + #autoTasks
				end
			end
			firstWpt.task = firstWpt.task or { id = 'ComboTask', params = { tasks = {} } }		
			for autoTasksIndex, autoTask in pairs(autoTasks) do
				table.insert(firstWpt.task.params.tasks, autoTasksIndex, autoTask)
			end
		end
		
		if group.type == 'ship' then
			panel_ship.validateWayPoints(group)
		end
	
		module_mission.update_group_map_objects(group)
		addSelectedGroup(group)        
		
		return
	end
	
	panState_onMouseDown(self, x, y, button)
end

-------------------------------------------------------------------------------
--
function tapeState_onMouseDown(self, x, y, button)
	bMouseDown = true
	if button == 1 then
		startRuler_(x, y)
		return
	elseif 3 == button then	
		setState(getPanState())
	end
  
	panState_onMouseDown(self, x, y, button)
end

-------------------------------------------------------------------------------
--
function tapeState_onMouseUp(self, x, y, button)
  if button == 1 then
    moveRuler_(x, y)
    return
  end
  
  panState_onMouseUp(self, x, y, button)
end

-------------------------------------------------------------------------------
--
function tapeState_onMouseDrag(self, dx, dy, button, x, y)
  if button == 1 then
      moveRuler_(x, y)
  end
  
  panState_onMouseDrag(self, dx, dy, button, x, y)
end

-------------------------------------------------------------------------------
--
function removeTapeObjects()
  resetRuler_()
end


function picModel_setPosition(model, x, alt, y, group)
	local alt = 200
	if group.type == 'ship' 
		or (group.type == 'static' and (DB.ship_by_type[group.units[1].type] ~= nil or DB.isFARP(group.units[1].type))) then
		alt = 0
	end
	model:setPosition(x, alt, y)
end

function addSceneObjectWithModel(name, x, alt, y, group)
	local alt = 200
	if group.type == 'ship' 
		or (group.type == 'static' and (DB.ship_by_type[group.units[1].type] ~= nil or DB.isFARP(group.units[1].type))) then
		alt = 0
	end
	return newMapView_:addSceneObjectWithModel(name, x, alt, y)
end

function removeSceneObject(sceneObj)
	if sceneObj then
		newMapView_:removeSceneObject(sceneObj)
	end
	return nil	
end

-------------------------------------------------------------------------------
--
function move_unit(group, unit, x, y, doNotRedraw)
	-- Нужно пересчитать координаты у самой точки, у точки линии маршрута, у номера точки,
	-- а также у юнитов, если точка маршрута - первая.
	if unit.index == 1 then 
		U.stack('Achtung!!! index == 1 move_unit');
		base.assert(0);
	end;

	if not checkSurfaceUnit(unit, x, y) then 
		return
	end;  
	
	if group.type == 'ship' then	
		if isValidDepth(unit.type, x, y) == false then
			return
		end
	end

	local dx = x - unit.x
	local dy = y - unit.y	
	
	unit.x = x
	unit.y = y

	local units = group.mapObjects.units

	units[unit.index].x = x
	units[unit.index].y = y
	
	if units[unit.index].picModel then
		picModel_setPosition(units[unit.index].picModel, x, 0, y, group)
	end

	if not doNotRedraw and (base.MapWindow.isShowHidden(group) == true)then
        local objects = {}
        table.insert(objects, units[unit.index])
		if group.type ~= 'static' then
			module_mission.updateUnitZones(unit);
		end	

		if unit.linkChildren then
			for i,wpt in ipairs(unit.linkChildren) do 
				if wpt.boss.linkOffset == true or panel_route.isAircraftOnShip(wpt.boss) then
					move_waypoint(wpt.boss, wpt.index, wpt.x + dx, wpt.y + dy,false,true)
				else			
					move_waypoint(wpt.boss, wpt.index, x, y, nil, true);
				end
			end
		end
		
		if unit.linkChildrenTZone then
			for i,zoneId in ipairs(unit.linkChildrenTZone) do 
				local tmpCoords = TriggerZoneController.getLocalCoords(zoneId)				
				TriggerZoneController.setTriggerZonePosition(zoneId,unit.x + tmpCoords.x,unit.y + tmpCoords.y)
			end
		end
      
		removeUserObjects(objects)
		addUserObjects(objects)
	end
end

-------------------------------------------------------------------------------
--
function move_INU_Fix_Point(group, index, x, y)
  -- Нужно пересчитать координаты у самой точки, у точки линии маршрута, у номера точки,
  -- а также у юнитов, если точка маршрута - первая.
  local objects = {}
  local pt = group.INUFixPoints[index]
  pt.x = x
  pt.y = y

  local symbol = group.mapObjects.INUFixPoints[index];
  
  symbol.x = x
  symbol.y = y
  table.insert(objects, symbol)

  -- TODO: добавить смещение текста
  local text = group.mapObjects.INUFixPoints_numbers[index];
  local tx, ty = getMapSize(10, -10)

  text.x = x + tx
  text.y = y + ty
  table.insert(objects, text)
  
  if base.MapWindow.isShowHidden(group) == true then
	  removeUserObjects(objects)
	  addUserObjects(objects)
  end

  panel_nav_target_fix_points.update()
end

-------------------------------------------------------------------------------
--
function move_Nav_Target_Point(group, index, x, y)
  -- Нужно пересчитать координаты у самой точки, у точки линии маршрута, у номера точки,
  -- а также у юнитов, если точка маршрута - первая.
  local objects = {}
  local pt = group.NavTargetPoints[index]
  pt.x = x
  pt.y = y

  local symbol = group.mapObjects.NavTargetPoints[index];
  
  symbol.x = x
  symbol.y = y
  table.insert(objects, symbol)

  -- TODO: добавить смещение текста
  local text = group.mapObjects.NavTargetPoints_numbers[index];
  local tx, ty = getMapSize(10, -10)

  text.x = x + tx
  text.y = y + ty
  table.insert(objects, text)
  
  -- TODO: добавить смещение текста
  local comment = group.mapObjects.NavTargetPoints_comments[index];
  local tx, ty = getMapSize(10, 20)
  tx = -tx  
  comment.x = x + tx
  comment.y = y + ty
  table.insert(objects, comment)
  
  if base.MapWindow.isShowHidden(group) == true then
	  removeUserObjects(objects)
	  addUserObjects(objects)
  end

  panel_nav_target_fix_points.update()
end


-------------------------------------------------------------------------------
--
function checkSurfaceUnit(unit, x, y)
	local index = a_index or 1
	local group = unit.boss
	if not getPointInMap(x, y) then
        return false
    end
	
	local surfaceType = getSurfaceType_(x, y)
	
	local unitDef =  DB.unit_by_type[unit.type]  
    if (unitDef.isPutToWater == true or 'static' == group.type or getCanSwimUnit(unit) == true) and unitDef.subCategory	~= 'SeaShelfObject' then
        return true
    end
	
	local bBotInGroup = crutches.getBotInGroup(group)
	
	local type
	if 'ship' == group.type then
        type = 'sea_object';
    elseif 'vehicle' == group.type then    
        type = 'land_object';
    elseif 'static' == group.type then        
        if nil ~= DB.ship_by_type[group.units[1].type] then
            type = 'sea_object';
        else            
            if (unitDef.SeaObject ~= nil) and (unitDef.SeaObject == true) then
                type = 'sea_object';
			else
                type = 'land_object';
            end;        
        end;
    elseif 'helicopter' == group.type or unitDef.takeoff_and_landing_type == "VTOL" or bBotInGroup == false then
        if group.route.points[index] and  
            (group.route.points[index].type.type == 'TakeOffGround' or group.route.points[index].type.type == 'TakeOffGroundHot')  then
            -- взлет вертолета с земли
            local unitDesc = DB.unit_by_type[group.units[1].type]  
        
            local WIDTH  = (unitDesc.wing_span or unitDesc.rotor_diameter)
            local LENGTH = unitDesc.length

            local result = isValidSurfacePro(5, base.math.max(WIDTH, LENGTH), x, y, 'land')

            return result
        end
    end

    local result = true
    if 'sea_object' == type then
      if isValidWater(unit.type, x, y) == false then    
        result = false
      end
    elseif 'land_object' == type then
      if 'land' ~= surfaceType then 
        result = false
      end
    end  
          
    return result;
end

-------------------------------------------------------------------------------
--
function checkSurface(group, x, y, showWarning, callback, a_index)
    local index = a_index or 1
    local displayMessage = callback or showWarningWindow;
    if not getPointInMap(x, y) then
        return false
    end
     
    local surfaceType = getSurfaceType_(x, y)
    local type = '';
    
    local unitDef =  DB.unit_by_type[group.units[1].type]  
    if (unitDef.isPutToWater == true or 'static' == group.type or getCanSwimGroup(group) == true)  and unitDef.subCategory	~= 'SeaShelfObject' then
        return true
    end  
	
	local bBotInGroup = crutches.getBotInGroup(group)
    
    if 'ship' == group.type then
        type = 'sea_object';
    elseif 'vehicle' == group.type then    
        type = 'land_object';
    elseif 'static' == group.type then        
        if nil ~= DB.ship_by_type[group.units[1].type] then
            type = 'sea_object';
        else            
            if (unitDef.SeaObject ~= nil) and (unitDef.SeaObject == true) then
                type = 'sea_object';
            else
                type = 'land_object';
            end;        
        end;
    elseif 'helicopter' == group.type or unitDef.takeoff_and_landing_type == "VTOL" or bBotInGroup == false then
        if group.route.points[index] and  
            (group.route.points[index].type.type == 'TakeOffGround' or group.route.points[index].type.type == 'TakeOffGroundHot')  then
            -- взлет вертолета с земли
            local unitDesc = DB.unit_by_type[group.units[1].type]  
        
            local WIDTH  = (unitDesc.wing_span or unitDesc.rotor_diameter)
            local LENGTH = unitDesc.length

            local result = isValidSurfacePro(5, base.math.max(WIDTH, LENGTH), x, y, 'land')
            if result == false and showWarning then
                displayMessage(_('Place ground objects on the smooth land, please'))
            end
			
            return result
        end
    end;

    local result = true
    
    if 'sea_object' == type then
      if isValidWater(group.units[1].type, x, y) == false then
        if showWarning then
			displayMessage(_('Settle ships on appropriate water, please.'))
        end
        
        result = false
      end
    elseif 'land_object' == type then
      if 'land' ~= surfaceType then
        if showWarning then
          displayMessage(_('Place ground objects on the land, please'))
        end
        
        result = false
      end
    end  
          
    return result;
end;

function move_fp_waypoint(wpt, x, y) 
	wpt.x = x
	wpt.y = y
	
	local index = 1
	for k,v in base.ipairs(wpt.boss.points) do
		if v == wpt then
			index = k
		end
	end
	
	wpt.boss.mapObjects.points[index].x = x
	wpt.boss.mapObjects.points[index].y = y
	module_mission.update_flightPlan_map_objects(wpt.boss)
	
	module_mission.build_fp_route_line(wpt.boss)
end

-------------------------------------------------------------------------------
--
function move_waypoint(group, index, x, y, dontMoveLinked, doNotUpdateRoute, dontMoveChild, dontRelativePos)
  -- Нужно пересчитать координаты у самой точки, у точки линии маршрута, у номера точки,
  -- а также у юнитов, если точка маршрута - первая.  
	local objects = {}

	if not group.route then
		return
	end
  
	local wpt = group.route.points[index] 

	if not wpt then
		return
	end

	if not checkSurface(group, x, y, nil, nil, index) then 
		return
	end 
	
	if DB.isFARP(group.units[1].type) then
		if not isValidSurface(20, 261, x, y) then
			return
		end
	end
	
	if group.type == 'ship' then	
		if isValidDepthGroup(group, x, y) == false then
			return
		end
	end
  
	if index == 1 then
		if dontRelativePos == true then
			
		else
			if (dontMoveChild == nil) or (dontMoveChild == false) then
				for i = 2, #group.units do
					local unit = group.units[i];
					local dx = x - group.x
					local dy = y - group.y  
					if not checkSurface(group, unit.x + dx, unit.y + dy) then 
						return
					end
				end
			end
		end
	end
  
	wpt.x = x
	wpt.y = y
	
	panel_route.updateDepth(wpt)

    -- Нужно скорректировать перегоны
    if group.route.spans and #group.route.spans > 0 then
        local spans = group.route.spans
        -- Если точка не первая, то модифицируется перегон с предыдущим индексом, который располагается перед данной точкой.
        if index > 1 then
          local p = group.route.points[index-1]
          spans[index-1] = {{x = p.x, y = p.y}, {x = x, y = y}}
        end
        -- Если точка не последняя, то модифицируется перегон с текущим индексом, который располагается после данной точки.
        if index < #group.route.points then
          local p = group.route.points[index+1]
          spans[index] = {{x = x, y = y}, {x = p.x, y = p.y}}
        end
    end
 
	module_mission.build_route_line(group)
	local scale = getScale()
	local route = group.mapObjects.route
	table.insert(objects, route.line)

	route.points[index].x = x
	route.points[index].y = y
	table.insert(objects, route.points[index])
  
	-- TODO: добавить смещения для текста
	local tx, ty = getMapSize(10, -10)
	route.numbers[index].x = x + tx
	route.numbers[index].y = y + ty
	table.insert(objects, route.numbers[index])
	
	if index == 1 and route.numberFirst then
		local tx, ty = getMapSize(25, 5)
		route.numberFirst.x = x - tx
		route.numberFirst.y = y - ty
		table.insert(objects, route.numberFirst)
	end
  
	local targetLines = route.targetLines[index]
  
	if targetLines then
		for i, targetLine in ipairs(targetLines) do
			local point = targetLine.points[1]			
			point.x = x
			point.y = y
			table.insert(objects, targetLine)
		end
	end
  
	if index == 1 then		
		local dx = x - group.x
		local dy = y - group.y	
		
		group.x = x
		group.y = y
		updateSelectedGroupsPoint(group)
 
        local units = group.mapObjects.units
        for i=1, #units do
            local unit = group.units[i]
            local udb = DB.unit_by_type[unit.type]
			base.assert(udb, unit.type .. "!unit_by_type[]")
        --    local hasZone = false;
		--	if (udb.DetectionRange and (udb.DetectionRange > 0)) 
		--		or (udb.ThreatRange and (udb.ThreatRange > 0)) then
		--		hasZone = true;
		--	end
			
            if (unit.index ~= 1 ) then				
				if ((dontMoveChild == nil) or (dontMoveChild == false)) then	
					local xNew = unit.x + dx
					local yNew = unit.y + dy
					if getCanSwimUnit(unit) ~= true and (not checkSurface(group, xNew, yNew)) then 
						xNew, yNew = findValidStrikePoint(xNew, yNew) 
					end
										
					move_unit(group, unit, xNew or (unit.x + dx), yNew or (unit.y + dy), false);
					table.insert(objects, units[i]) 
				end	
            else -- для первого юнита ничего не рисуем, вместо юнита рисуется первая точка маршрута со значком юнита
                unit.x = x
                unit.y = y
				if group.type ~= 'plane' and group.type ~= 'helicopter' then
					unit.alt = U.getAltitude(unit.x, unit.y)
				end
                group.mapObjects.units[1].x = x
                group.mapObjects.units[1].y = y  
				
				if group.mapObjects.units[1].picModel then
					picModel_setPosition(group.mapObjects.units[1].picModel, x, 0, y, group)
				end
                
                if (group.type == 'static') then
                    group.x = x
                    group.y = y
                    module_mission.update_group_map_objects(group)
                end
             
                if unit.linkChildren and ((dontMoveChild == nil) or (dontMoveChild == false)) then					
                    for i,wpt in ipairs(unit.linkChildren) do					
						local offsetX, offsetY = 0, 0	
						local hdg = unit.heading
						local sinHdg = base.math.sin(hdg)
						local cosHdg = base.math.cos(hdg)
						local updateHeading = false						
                        if wpt.task and wpt.task.params.tasks then
							for k,v in pairs(wpt.task.params.tasks) do
								if v.id == 'FollowBigFormation' then									
									offsetX = v.params.pos.x*cosHdg - v.params.pos.z*sinHdg
									offsetY = v.params.pos.z*cosHdg + v.params.pos.x*sinHdg									
									updateHeading = wpt.index == 1
									break
								end
							end
						end
												
						if wpt.boss.linkOffset == true or panel_route.isAircraftOnShip(wpt.boss) then
							move_waypoint(wpt.boss, wpt.index, wpt.x + dx, wpt.y + dy,false)
						else	
							move_waypoint(wpt.boss, wpt.index, x+offsetX, y+offsetY,false, false, false)
						end
						
						if updateHeading then
							for k,v in pairs(wpt.boss.units) do
								v.heading = hdg
								v.psi = -hdg
							end					
							module_mission.updateHeading(wpt.boss)
							module_mission.update_group_map_objects(wpt.boss)	
						end 
                    end
                end			
            end
			
			if unit.linkChildrenTZone then
				for i,zoneId in ipairs(unit.linkChildrenTZone) do 
					local tmpCoords = TriggerZoneController.getLocalCoords(zoneId)
					TriggerZoneController.setTriggerZonePosition(zoneId,unit.x + tmpCoords.x,unit.y + tmpCoords.y)
				end
			end
			
			if group.type ~= 'static' then
				module_mission.updateUnitZones(unit)
			end	
        end
	end
  
	if base.MapWindow.isShowHidden(group) == true then
		removeUserObjects(objects)
		addUserObjects(objects)
	end
 
	if (index < 3) then 
		module_mission.updateHeading(group);
	end
  
	if not doNotUpdateRoute then
		module_mission.calc_route_length(group)
		panel_summary.update()
		panel_route.update()
	end
end


local idsNeedOnLand = {'Embarking', 'EmbarkToTransport', 'Disembarking', "Land"}

local function isNeedOnLand(a_id)
    for k,v in base.pairs(idsNeedOnLand) do
        if a_id == v then
            return true
        end
    end
    return false
end

-------------------------------------------------------------------------------
--
function move_target(target, x, y)
    if target.task then
        if (isNeedOnLand(target.task.id)) 
            or (target.task.id == 'ControlledTask' and target.task.params and target.task.params.task
                and isNeedOnLand(target.task.params.task.id))then
            if getSurfaceType_(x, y) ~= 'land' then
                return
            end
        end            
    end

	if (base.isPlannerMission() == true) then		
		if ((selectedGroup.units[1]) 
			and (selectedGroup.units[1].skill ~= crutches.getPlayerSkill())) then
			return
		end
	end
	
	-- Изменяются координаты цели.
	target.x = x
	target.y = y
	local wpt = target.boss
	local group = wpt.boss
	local objects = {}
	local trg = group.mapObjects.route.targets[wpt.index][target.index]
  
	if trg then
		-- Изменяются координаты точки цели на карте.
		trg.x = x
		trg.y = y
		table.insert(objects, trg)

		-- Изменяются координаты номера цели на карте.
		local num = group.mapObjects.route.targetNumbers[wpt.index][target.index]

		num.x = x
		num.y = y
		table.insert(objects, num)

		-- Изменяются координаты конца линии цели на карте.
		local line = group.mapObjects.route.targetLines[wpt.index][target.index]
		p = line.points[2]
		p.x = x
		p.y = y
		table.insert(objects, line)
		-- Пересчитываются координаты точек зоны цели на карте.
		local zone = group.mapObjects.route.targetZones[wpt.index][target.index] 
		if zone then
			module_mission.update_target_zone(target)
			-- Зона обновляется на карте внутри функции.
		end

		if base.MapWindow.isShowHidden(group) == true then
			-- Обновляются соответствующие объекты карты.
			removeUserObjects(objects)
			addUserObjects(objects)
		end
	end
end

-------------------------------------------------------------------------------
-- returns true if sufrace is good 
function isValidSurface(a_delta, a_side, x, y)
    return a_delta >= U.getAltitudeDelta(x, y, a_side)
end

-------------------------------------------------------------------------------
-- returns true if sufrace is good 
function isValidSurfacePro(a_angle, a_side, x, y, a_typeLand)
    return U.isValidSurface(a_angle, x, y, a_side, a_typeLand)
end


-------------------------------------------------------------------------------
-- Перемещает статическую группу
function move_group(group, x, y)
    if not checkSurface(group, x, y) then 
        return
    end;

    if ('static' == group.type) then	
        if DB.isFARP(group.units[1].type) then
            if not isValidSurface(20, 261, x, y) then
                return
            end
        end
        
        if (cdata.GrassAirfield == group.units[1].type) then
            if not isValidSurface(100, group.units[1].lenght or 2000, x, y) then
                return
            end
        end
    end    
  
	if (base.isPlannerMission()) then
		return
	end

	group.x = x
	group.y = y
	group.units[1].x = x
	group.units[1].y = y
	if group.mapObjects then
		group.mapObjects.units[1].x = x
		group.mapObjects.units[1].y = y

		if group.mapObjects.units[1].picModel then
			picModel_setPosition(group.mapObjects.units[1].picModel, x, 0, y, group)
		end
		
		module_mission.update_group_map_objects(group)
	end
	
	if group.units[1].linkChildren then
		for _tmp, wpt in pairs(group.units[1].linkChildren) do
			move_waypoint(wpt.boss, wpt.index, x, y, true)
		end
	end
end

-------------------------------------------------------------------------------
--Поиск подходящей точки установки для объекта
function findPTforObject(a_mapX, a_mapY, a_isPossibleInWater)

	local offset = 50;
	local new_pt = {}
    local pi = math.pi
    local sin = math.sin
    local cos = math.cos
	

	for i=1 , 20 do
		local pt_in_round 	= i * 8
		local dt_ang 		= 2 * pi / pt_in_round
		local len 			= offset * i		
		local ang 			= 0
				
		for n=1 , pt_in_round do
			new_pt 	= {}
			new_pt.x = a_mapX + len * sin(ang)
			new_pt.y = a_mapY + len * cos(ang)
			
			if getPointInMap(new_pt.x, new_pt.y) then
				local surfaceType = getSurfaceType_(new_pt.x, new_pt.y)
				if ((a_isPossibleInWater == true) or ('land' == surfaceType)) and (isValidSurface(20, 261, new_pt.x, new_pt.y)) then
					return new_pt.x, new_pt.y
				end
			end
		
			ang = ang + dt_ang;
		end
		
	end
end

function createStatic(mapX, mapY)
	if not getPointInMap(mapX, mapY) then
        showWarningWindow(cdata.placeInside)
        return
    end
	
	local vd = panel_static.vdata
	local surfaceType = getSurfaceType_(mapX, mapY)
	local possibleInWater = true

	local unitDef =  DB.unit_by_type[vd.type]

	if unitDef.isPutToWater ~= true and possibleInWater ~= true and (unitDef.chassis and unitDef.chassis.canSwim) ~= true then
		if (vd.category == _('Ships')) or (unitDef.SeaObject == true)then -- юнит - корабль или водный статик
			if isValidWater(vd.type, mapX, mapY) == false then
				if (vd.category == _('Ships')) then 
					showWarningWindow(_('Settle ships on appropriate water, please.'))          
					return
				else
					showWarningWindow(_('Place sea objects in the sea, please'))          
					return          
				end
			end
		else -- юнит - НЕ корабль
			if ('land' ~= surfaceType)  then -- поверхность НЕ земля
				showWarningWindow(_('Place ground objects on the land, please'))          
				return            
			end
		end
	end

	if unitDef.subCategory == 'SeaShelfObject' then
		if isValidWater(vd.type, mapX, mapY) == false then
			showWarningWindow(_('Settle ships on appropriate water, please.'))          
			return 
		end
	end

	if DB.isFARP(vd.type) then
		if unitDef.isPutToWater == true or possibleInWater == true or (unitDef.chassis and unitDef.chassis.canSwim) == true or (not isValidSurface(20, 261, mapX, mapY)) then
			mapX, mapY = findPTforObject(mapX, mapY, unitDef.isPutToWater or possibleInWater or (unitDef.chassis and unitDef.chassis.canSwim) )
			if mapX == nil or mapY == nil then
				showWarningWindow(_('Too steep terrain'))
				return
			end
		end
	end

	panel_static.setSafeMode(false)
	vd.x = mapX
	vd.y = mapY
	vd.alt = 0
	local group = module_mission.create_group(vd.country, 'static', vd.name, nil, nil, nil, mod_weather.start_time, mapX, mapY, vd.type)
	group.heading = vd.heading;      

	vd.group = group
	group.hidden = vd.hidden
	selectedGroup = group
	local unit = module_mission.insert_unit(group, vd.type, vd.skill, 1, module_mission.getUnitName(group.name) ,nil,nil,nil,vd.category)
	unit.livery_id = vd.livery_id;
	unit.heading = group.heading
	unit.shape_name = DB.unit_by_type[vd.type].ShapeName

	set_group_color(group, group.boss.boss.selectGroupColor)
	set_unit_color(group.units[1], group.boss.boss.selectUnitColor)
	module_mission.insert_waypoint(group, 1, '', mapX, mapY, 0, 200/3.6)
	unit.alt = 0

	module_mission.update_group_map_objects(group)

	addSelectedGroup(group)
	base.panel_static.setGroup(group)   

	panel_static.update()
end

-------------------------------------------------------------------------------
--
function creatingStaticState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then
		if selectedGroup then
			revert_selection(selectedGroup)
			selectedGroup = nil
		end
		toolbar.setStaticButtonState(false)
		-- Создаем новый статический объект на основании данных,
		-- заданных в соответствующей панели.
		local mapX, mapY = getMapPoint(x, y)
		createStatic(mapX, mapY)
		setState(getPanState())
        return
    end
    
    panState_onMouseDown(self, x, y, button)
  end

function selectSupplierState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then     
		local supplierController = ModulesMediator.getSupplierController()
		
        supplierController.onSelectSupplier(getMapPoint(x, y))
    end
end

function selectSupplierState_onMouseWheel(self, x, y, clicks)
	panState_onMouseWheel(self, x, y, clicks)

	local supplierController = ModulesMediator.getSupplierController()

	supplierController.onMapScaleChange()
end

-------------------------------------------------------------------------------
--
function creatingINUFixPointState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then
			local mapX, mapY = getMapPoint(x, y)
			if not getPointInMap(mapX, mapY) then
				showWarningWindow(cdata.placeInside)
				return
			end
			local group
			if panel_aircraft.window:isVisible() then
				group = panel_aircraft.vdata.group
			else
				return
			end
			pt = module_mission.insert_INUFixPoint(group, mapX, mapY, group.boss.boss.selectGroupColor)
			module_mission.update_group_map_objects(group)
			panel_nav_target_fix_points.vdata.selectedPointIFP = pt
			panel_nav_target_fix_points.update()
      return
    else
        panState_onMouseDown(self, x, y, button)
    end;
end;

-------------------------------------------------------------------------------
--
function creatingNavTargetPointState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then
        local mapX, mapY = getMapPoint(x, y)
        if not getPointInMap(mapX, mapY) then
			showWarningWindow(cdata.placeInside)
			return
		end
        local group
        if panel_aircraft.window:isVisible() then
            group = panel_aircraft.vdata.group
        else
            return
        end
		pt = module_mission.insert_NavTargetPoint(group, mapX, mapY, 
			group.boss.boss.selectGroupColor,panel_nav_target_fix_points.vdata.comment)
		module_mission.update_group_map_objects(group)

		panel_nav_target_fix_points.vdata.selectedPointNTP = pt
		panel_nav_target_fix_points.update()
          
		return
    else
        panState_onMouseDown(self, x, y, button)
    end
end

-------------------------------------------------------------------------------
--
function creatingDataCartridgePointState_onMouseDown(self, x, y, button)
	bMouseDown = true
    if button == 1 then
        local mapX, mapY = getMapPoint(x, y)
        if not getPointInMap(mapX, mapY) then
            showWarningWindow(cdata.placeInside)
            return
        end
		local unit
        if panel_aircraft.window:isVisible() then
			unit = panel_aircraft.getCurUnit()
        else
            return
        end
			if unit then
				pt = module_mission.insert_DataCartridgePoint(unit, mapX, mapY)
				module_mission.update_group_map_objects(unit.boss)
			end
        return
    else
     --   panState_onMouseDown(self, x, y, button)
    end
end

-------------------------------------------------------------------------------
--
function nodesState_onMouseDown(self, x, y, button)
	bMouseDown = true
  if 1 == button then
    NodesMapView:onMouseDown(x, y, button)
  else
    panState_onMouseDown(self, x, y, button)  
  end
end

-------------------------------------------------------------------------------
--
function nodesState_onMouseDrag(self, dx, dy, button, x, y)
  if 1 == button then
    NodesMapView:onMouseDrag(dx, dy, button, x, y)
  else
    panState_onMouseDrag(self, dx, dy, button, x, y)  
  end
end

-------------------------------------------------------------------------------
--
function rtsState_onMouseDown(self, x, y, button)
	RtsMapView.onMouseDown(x, y, button)
end

-------------------------------------------------------------------------------
--
function rtsState_onMouseDrag(self, dx, dy, button, x, y)
	if RtsMapView.onMouseDrag(dx, dy, button, x, y) == 0 then 
		if 3 == button then
			panState_onMouseDrag(self, dx, dy, button, x, y)  
		end
	end
end

-------------------------------------------------------------------------------
--
function rtsState_onMouseMove(self, x, y)
	RtsMapView.onMouseMove(x, y)
end

-------------------------------------------------------------------------------
--
function rtsState_onMouseUp(self, x, y, button)
	RtsMapView.onMouseUp(x, y, button)
end


-------------------------------------------------------------------------------
--
function editTriggerZoneState_onMouseDown(self, x, y, button)
	bMouseDown = true
	selectedPointTrigger = nil

	if 1 == button then
		local mapX, mapY = getMapPoint(x, y)
		local radius = getMapSize(0, 10)
			
		local obj = pickUserObjectETZ(mapX, mapY, radius)
		if obj and obj.classKey == 'pointTriggerZone' then
			selectedPointTrigger = obj
		end	
			
	else
		panState_onMouseDown(self, x, y, button)  
	end		
end

-------------------------------------------------------------------------------
--
function editTriggerZoneState_onMouseDrag(self, dx, dy, button, x, y)
	if 1 == button then
		if selectedPointTrigger then
			local mapX, mapY = getMapPoint(x, y)
			selectedPointTrigger.x = mapX
			selectedPointTrigger.y = mapY
			module_mission.update_map_object({selectedPointTrigger})
			TriggerZonePanel.updateMapObjects(pointsTriggerZone)
		end
	else
		panState_onMouseDrag(self, dx, dy, button, x, y)  
	end
end

-------------------------------------------------------------------------------
--
function editTriggerZoneState_onMouseMove(self, x, y)

end

-------------------------------------------------------------------------------
--
function editTriggerZoneState_onMouseUp(self, x, y, button)

end

function drawState_onMouseDown(self, x, y, button)
	panel_draw.onMouseDown(x, y, button)	
end

function drawState_onMouseUp(self, x, y, button)
	panel_draw.onMouseUp(x, y, button)
end

function drawState_onMouseDrag(self, dx, dy, button, x, y)
	if 3 == button then
		panState_onMouseDrag(self, dx, dy, button, x, y)
	else	
		moveCursor(x, y)
		panel_draw.onMouseDrag(dx, dy, button, x, y)
	end
end

function drawState_onMouseMove(self, x, y)
	MOUSE_STATE.x = x 
	MOUSE_STATE.y = y
	moveCursor(x, y)
	panel_draw.onMouseMove(x, y) 
end

function pipetteState_onMouseDown(self, x, y, button)
	if 1 == button then	
		if base.setCoordPanel.isStateSetPosUnit() == true then
			local mapX, mapY = getMapPoint(x, y)
			base.setCoordPanel.setMapPoint(mapX, mapY)
		end
	end
end

function pipetteState_onMouseUp(self, x, y, button)
	
end

function pickUserObjectETZ(cx, cy, radius) --editTriggerZoneState
    local objects = findUserObjects(cx, cy, radius) -- возвращает таблицу вида {id, id, ...}

	local k 
	
	for k = #objects, 1, -1 do	
		if pointsTriggerZoneMapObjects[objects[k]] ~= nil then			
			return pointsTriggerZoneMapObjects[objects[k]]
		end
	end	
end		

-------------------------------------------------------------------------------
--
function moveCursor(x, y)
  local xr,yr = getMapPoint(x, y)
  statusbar.updateLatLong(xr, yr)
end

-------------------------------------------------------------------------------
--
function set_group_color(group, color)
    if group.mapObjects.units then
        local units = group.mapObjects.units
        
        for i, unit in ipairs(units) do
            unit.currColor = color
        end
    end
  
    local route = group.mapObjects.route
  
    if route then
        route.line.currColor = color
        
        for i, point in ipairs(route.points) do
            point.currColor = color
          
            local targets = point.targets
            
            if targets then
                local targetPoints = targets.points
                local targetNumbers = targets.numbers
                
                for j=1, #targets do
                    targetPoints[j].currColor = color
                    targetNumbers[j].currColor = color
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
--
function set_waypoint_color(wpt, color)
    if wpt then
        local group = wpt.boss
        local route = group.mapObjects.route
        local index = wpt.index

        route.points[index].currColor = color
        route.numbers[index].currColor = color
    end
end

-------------------------------------------------------------------------------
--
function set_waypoints_color(group, color)
  local points = group.mapObjects.route.points
  for i=1,#points do
    points[i].currColor = color
  end
  local numbers = group.mapObjects.route.numbers
  for i=1,#numbers do
    numbers[i].currColor = color
  end
end

-------------------------------------------------------------------------------
--
function set_route_line_color(group, color)
  group.mapObjects.route.line.currColor = color
end

-------------------------------------------------------------------------------
--
function set_unit_color(unit, color)
  local group = unit.boss
  group.mapObjects.units[unit.index].currColor = color
end

-------------------------------------------------------------------------------
--
function set_target_color(target, color)
  local group = target.boss.boss
  local route = group.mapObjects.route
  local targetBossIndex = target.boss.index
  local targetIndex = target.index
  
  route.targets[targetBossIndex][targetIndex].currColor = color
  route.targetLines[targetBossIndex][targetIndex].currColor = color
  route.targetNumbers[targetBossIndex][targetIndex].currColor = color
end

-------------------------------------------------------------------------------
--
function set_targets_color(wpt,  color)
  local targets = wpt.boss.mapObjects.route.targets[wpt.index]
  
  if not targets then
      return
  end
  
  for i,v in pairs(targets) do
    v.currColor = color
  end
  
  local targetLines = wpt.boss.mapObjects.route.targetLines[wpt.index]
  
  for i,v in pairs(targetLines) do
    v.currColor = color
  end
  
  local targetNumbers = wpt.boss.mapObjects.route.targetNumbers[wpt.index]
  
  for i,v in pairs(targetNumbers) do
    v.currColor = color
  end
end


function createMapObjects()
	MapController.createMapObjects()
	MapLayerController.hideSupplierLayer()
end



function isEmptyME()
	return not module_mission.missionCreated
end

function showEmpty()
	if not window then
        create_()
    end

	panel_startEditor.show(true)
	
	module_mission.removeMission()	

	updateEnabledButtons()

	newMapView_:setState(emptyState_)
	base.menubar.show(true)
	base.toolbar.show(true)
	base.statusbar.show(true)
	base.mapInfoPanel.show(true)
	base.setCoordPanel.show(false)
	base.collectgarbage('collect')
	
	if window then
        window:setVisible(true)
		newMapView_:setVisible(false)
    end
end

function updateEnabledButtons()
	statusbar.updateEnabledPanels()
	base.menubar.updateEnabledButtons()
	base.toolbar.updateEnabledButtons()
	
end


-------------------------------------------------------------------------------
--
function show(b)
    if not window then
        create_()
    end

    if window then
        window:setVisible(b)
        base.mod_copy_paste.setupKeyboard(window)
		newMapView_:setVisible(true)
    end
	
	panel_startEditor.show(false)
	
	if b then
		createMap()
		
		
	--	module_mission.createMapElements()
		MapLayerController.updateLayerVisible()
		module_mission.createBullseye()
		module_mission.update_bullseye_map_objects()	
		
		updateEnabledButtons()
		
		MapController.onShowMapWndow()
		
		
		if base.isPlannerMission() then
			focusPlayer()
		end	
		updateHiddenUnits()
		
		base.menubar.show(true)
		base.toolbar.show(true)
		base.statusbar.show(true)
		base.mapInfoPanel.show(true)
		base.setCoordPanel.show(false)
		base.toolbar.untoggle_all_except()
		base.collectgarbage('collect')
		setState(getPanState())
		Analytics.pageview(Analytics.MissionEditor)
		panel_backup.reset()
	end	
end

function updateHiddenUnits()
	if base.isPlannerMission() then
		--[[local unit = module_mission.getPlayerUnit()
		local groupPlayer = nil
		if unit then		
			groupPlayer = unit.boss
		end]]
		
		for _tmp, group in pairs(module_mission.group_by_id) do
			local unitDef =  DB.unit_by_type[group.units[1].type] 
			if unitDef.category == 'Effect' or group.hiddenOnPlanner == true then -- эффекты не показываем в планировщике, удаляем  группу с карты
				module_mission.remove_group_map_objects(group)
			end
			--[[if groupPlayer == nil or groupPlayer ~= group then -- в планировщике только группа игрока
				module_mission.remove_group_map_objects(group)
			end]]
		end	
	end
end

function getVisible()
	if window then
		return window:getVisible()
	end
end

-------------------------------------------------------------------------------
--
function focusPlayer()
	local unit = module_mission.getPlayerUnit()
	
	if unit then		
		local group = unit.boss
		local mapObject = group.mapObjects.route.points[1];
		respondToSelectedUnit(mapObject, group, unit)
		panel_route.update()
		setCamera(unit.x, unit.y)
	end
end

-------------------------------------------------------------------------------
--
function focusPointMap(x,y)
	setCamera(x,y)
end

-------------------------------------------------------------------------------
-- обновление  панелей 
function openPanels(group, vd, rvd, tvd, pvd, svd)
    local panel;
	panelContextMenu.show(false)
    if group.type == 'static' then
        panel = panel_static

        vd = panel.vdata
        vd.group = group
        vd.name = group.name
        vd.type = group.units[1].type
        vd.x = group.x
        vd.y = group.y
        vd.heading = U.toRadians(group.heading)
        vd.country = group.boss.name
		vd.category = nil
		
		if selectedUnit then
            vd.unitCur = selectedUnit.index
        else
            vd.unitCur = 1
        end
		
		panel_static.setSafeMode(false)
		panel_static.hideFullInfo()
    else
        if group.type == 'plane' or group.type == 'helicopter' then
            panel = panel_aircraft
			local oldGroup = panel.vdata.group			
			panel.setView(group.type)
			if oldGroup and base.module_mission.group_by_id[oldGroup.groupId] then
				module_mission.update_group_map_objects(oldGroup) -- для очистки с карты точек dataCartridge
			end			
        elseif group.type == 'ship' then
            panel = panel_ship
        elseif group.type == 'vehicle' then
            panel = panel_vehicle
        end

        if not (base.MapWindow.isShowHidden(group) == true) then 
			panel.setSafeMode(false)
        else
            panel.setSafeMode(false)
            panel_route.setSafeMode(false)
        end;

        vd = panel.vdata 
        vd.group = group
        vd.name = group.name
        vd.country = group.boss.name
        vd.task = group.task
        vd.type = group.units[1].type
        vd.unit.number = #group.units
        if selectedUnit then
            vd.unit.cur = selectedUnit.index
        else
            vd.unit.cur = 1
        end

		if group.callname then
			vd.callname_id = group.callname
		end
		if group.type == 'plane' or group.type == 'helicopter' then
			vd.communication = group.communication
			vd.frequency = group.frequency
			vd.modulation = group.modulation
			vd.radioSet = group.radioSet
		end
        
		for i=1,#group.units do
            local u = group.units[i]
            if group.type == 'plane' or group.type == 'helicopter' then
                vd.type 			= u.type
            else
                vd.types[i] = u.type
            end
            vd.skills[i] = u.skill
        end

        rvd = panel_route.vdata
        panel_route.setGroup(group)
		panel_suppliers.setGroup(group,selectedUnit or group.units[1])
		panel_triggered_actions.setGroup(group)
		panel_route.update()

        tvd = panel_targeting.vdata
        tvd.group = group

        svd = panel_summary.vdata
        svd.group = group
        svd.start_time = (not group.lateActivation) and (module_mission.mission.start_time + group.start_time) or 0.0

        panel_summary.update()

        if group.type == 'plane' or group.type == 'helicopter' then
            pvd = panel_payload.vdata
            pvd.group = group
            pvd.unit = group.units[vd.unit.cur]
        end
    end

    if not panel.window:isVisible() then
        toolbar.untoggle_all_except(toolbar.toggleButtonUnitList)
		toolbar.untoggleButtons()
	else
		panel.updateCountries()
    end

    if vd.unit then
        vd.unit.number = #group.units
    end
    
    return vd, rvd, tvd, pvd, svd, panel
end;

-------------------------------------------------------------------------------
-- реагирование на действия мышой
local function performActions_(obj, selectedUnit, group, vd, rvd, tvd, panel)
    local switched = false

    if (obj.waypoint) and
        group.route and
        group.route.points and
        group.route.points[1] and
        not selectedUnit 
    then
        -- waypoint or ...
        local wptA
        if selectedUnit then
            wptA = group.route.points[1]
        else
            wptA = obj.userObject
        end
        -- Точка маршрута
        if panel._tabs then
            panel._tabs:selectTab('route')	
            panel_route.show(true)
            panel_targeting.show(false)
            group.mapObjects.route.points[wptA.index].currColor = group.boss.boss.selectWaypointColor
            group.mapObjects.route.numbers[wptA.index].currColor = group.boss.boss.selectWaypointColor
            group.mapObjects.route.line.currColor = group.boss.boss.selectGroupColor
            
			panel_route.setWaypoint(wptA)
            panel_route.b_add:setState(false)
            panel_route.b_edit:setState(true)
            panel_route.update()

            switched = true
        end;
    elseif obj.classKey == 'P0091000044' then
        -- Цель
        panel_targeting.selectTarget(nil); -- сброс выделения целей для предыдущей точки маршрута

		local target = obj.userObject	
		if target.task then
			panel._tabs:selectTab('route')
		else
			panel._tabs:selectTab('payload')
		end        
        local wpt = target.boss
        panel_targeting.selectTarget(target)
		tvd.target = target;
		panel_route.setWaypoint(wpt)

		if target.task then
			panel_route.show(true)		
			panel_route.open(target.wptIndex, target.task)	
		else
			panel_targeting.show(true)
			panel_route.show(false)
		end
        
        group.mapObjects.route.points[wpt.index].currColor = group.boss.boss.selectWaypointColor
        group.mapObjects.route.numbers[wpt.index].currColor = group.boss.boss.selectWaypointColor
        group.mapObjects.route.line.currColor = group.boss.boss.selectGroupColor
        
        panel_targeting.b_add:setState(false)
        panel_targeting.b_edit:setState(true)
        panel_targeting.update(false)
        switched = true
    elseif obj.classKey == 'P0091000206' then -- INU Fix points
        panel._tabs:selectTab('navFixPoint')
        panel_paramFM.show(false)
		panel_radio.show(false)
        panel_route.show(false)
		panel_suppliers.show(false)
        panel_wpt_properties.show(false)
        panel_targeting.show(false)
        panel_payload.show(false)
        pPayload_vehicles.show(false)
        panel_summary.show(false)
		panel_triggered_actions.show(false)
        panel_nav_target_fix_points.show(true)
        obj.currColor = group.boss.boss.selectWaypointColor
        for k,v in pairs(group.mapObjects.INUFixPoints) do 
            if v == obj then
                group.mapObjects.INUFixPoints_numbers[k].currColor = group.boss.boss.selectWaypointColor
                panel_nav_target_fix_points.vdata.selectedPointIFP = group.INUFixPoints[k]
                panel_nav_target_fix_points.setModeNTFP("IFP")
                panel_nav_target_fix_points.update()
                break
            end
        end
        switched = true
        if panel_route.vdata.wpt ~= nil then			
            local wpt = panel_route.vdata.wpt
            
            group.mapObjects.route.points[wpt.index].currColor = group.boss.boss.selectWaypointColor;
            group.mapObjects.route.numbers[wpt.index].currColor = group.boss.boss.selectWaypointColor;
        end;
    elseif obj.classKey == 'P0091001206' then -- NAV TARGET POINT
        panel._tabs:selectTab('navFixPoint')
        panel_paramFM.show(false)
		panel_radio.show(false)
        panel_route.show(false)
		panel_suppliers.show(false)
        panel_wpt_properties.show(false)
        panel_targeting.show(false)
        panel_payload.show(false)
        pPayload_vehicles.show(false)
        panel_summary.show(false)
		panel_triggered_actions.show(false)
		panel_nav_target_fix_points.show(true)
        obj.currColor = group.boss.boss.selectWaypointColor
        for k,v in pairs(group.mapObjects.NavTargetPoints) do 
            if v == obj then
                group.mapObjects.NavTargetPoints_numbers[k].currColor = group.boss.boss.selectWaypointColor
                panel_nav_target_fix_points.vdata.selectedPointNTP = group.NavTargetPoints[k]
                panel_nav_target_fix_points.setModeNTFP("NTP")
                panel_nav_target_fix_points.update()
                break
            end
        end
        switched = true
        if panel_route.vdata.wpt ~= nil then			
            local wpt = panel_route.vdata.wpt
            
            group.mapObjects.route.points[wpt.index].currColor = group.boss.boss.selectWaypointColor;
            group.mapObjects.route.numbers[wpt.index].currColor = group.boss.boss.selectWaypointColor;
        end; 
	elseif panel_dataCartridge.isEditState() then 
		--base.print("----POINTDATACARTRIDGE_ROUND---")
		return
    end
	 
    -- Чтобы не путать с линиями, подписями и зонами.
    -- Юнит
    if selectedUnit and group.mapObjects.units[obj.userObject.index] then
        group.mapObjects.units[obj.userObject.index].currColor = group.boss.boss.selectUnitColor
        		
		if group.type ~= 'static' then
			group.mapObjects.route.numbers[1].currColor = group.boss.boss.selectWaypointColor
			panel_route.setWaypoint(group.route.points[1]);
			panel_route.update()	
		end	
    end
    if group.type ~= 'static' then
        if not switched and panel._tabs then
            panel._tabs:selectTab('route')
        end
        tvd.group = group
        -- Соответствующий номер юнита нужно установить в панели группы.
        if selectedUnit then
			vd.unit.cur = obj.userObject.index
        end
		
        setState(getPanState())
        if (obj.classKey ~= 'P0091000044') and (obj.classKey ~= 'P0091000206') and (obj.classKey ~= 'P0091001206') then
            panel_route.show(true)
        end
    else
		if selectedUnit then
			vd.unitCur = obj.userObject.index
			
			if vd.unitCur == 1 then
				group.mapObjects.route.points[1].currColor = group.boss.boss.selectWaypointColor
			end
        end
		
        panel_route.vdata.group = nil  
		setState(getPanState())	
    end
    panel_route.update() -- обновляем маршрут всегда
end

-------------------------------------------------------------------------------
-- реакция на выбор группы
function respondToSelectedUnit(obj, group, _selectedUnit)
    selectedGroup = group
    selectedUnit = _selectedUnit;
    setSelectedObject(obj.id)

	panel_nav_target_fix_points.vdata.selectedPointNTP = nil;
	panel_nav_target_fix_points.vdata.selectedPointIFP = nil;
    -- В зависимости от типа группы, нужно открыть соответствующие диалоги
    -- и проинициализировать в них таблицы и контролы.
    local vd, rvd, tvd, pvd, svd, panel = {},{},{},{},{},{}
	vd, rvd, tvd, pvd, svd, panel = openPanels(group, vd, rvd, tvd, pvd, svd);
	
    -- Затем нужно покрасить объекты группы в цвет выбора.
    set_selected_group_color(group)
    -- Затем нужно разобраться, что именно выбрали - юнит, точку маршрута или цель -
    -- и соответственно изменить цвет выбранного объекта.
	performActions_(obj, selectedUnit, group, vd, rvd, tvd, panel)

    panel.show(true)
	panel.update()
    -- Кроме того, если выбрана точка маршрута, то координаты нужно
    -- сохранить для возможного отката после перемещения, если тип
    -- поверхности не подойдет.
    -- Наконец, нужно не забыть сообщить карте об изменениях цветов.
	
	module_mission.update_group_map_objects(group)
end

function set_bShowRed(a_value)
	bShowRed = a_value
	updateHiddenAllGroups()
end

function set_bShowBlue(a_value)
	bShowBlue = a_value
	updateHiddenAllGroups()
end

function set_bShowNeutrals(a_value)
	bShowNeutrals = a_value
	updateHiddenAllGroups()
end

function set_bHideRed(a_value)
	bHideRed = a_value
	updateHiddenAllGroups()
end

function set_bHideBlue(a_value)
	bHideBlue = a_value
	updateHiddenAllGroups()
end

function set_bHideNeutrals(a_value)
	bHideNeutrals = a_value
	updateHiddenAllGroups()
end

function isShowHidden(a_group)
	if a_group == nil then
		return bShowHidden
	end
	
	if base.isPlannerMission() == true then
		return a_group.hidden ~= true
	end
	
	if (a_group.boss.boss.name == CoalitionController.redCoalitionName() and bHideRed == true)
		or (a_group.boss.boss.name == CoalitionController.blueCoalitionName() and bHideBlue == true)
		or (a_group.boss.boss.name == CoalitionController.neutralCoalitionName() and bHideNeutrals == true) then
		
		return false
	end
	
	if a_group.hidden ~= true then
		return true
	end
	
	if bShowHidden then
		return true
	end
	
	if (a_group.boss.boss.name == CoalitionController.redCoalitionName() and bShowRed == true)
		or (a_group.boss.boss.name == CoalitionController.blueCoalitionName() and bShowBlue == true)
		or (a_group.boss.boss.name == CoalitionController.neutralCoalitionName() and bShowNeutrals == true) then

		return true
	end

	return false
end	

function setShowHidden(b)
	bShowHidden = b
	
	updateHiddenAllGroups()
end	

function updateHiddenAllGroups()
	for k,group in base.pairs(module_mission.group_by_id) do
		if isShowHidden(group) == true then
			module_mission.remove_group_map_objects(group)
			module_mission.create_group_map_objects(group)	
		else
			module_mission.remove_group_map_objects(group)
		end
	end
end

function updateHiddenGroup(a_group)
	if isShowHidden(a_group) == true then
		module_mission.remove_group_map_objects(a_group)
		module_mission.create_group_map_objects(a_group)	
	else
		module_mission.remove_group_map_objects(a_group)
	end	
end

function changeHiddenGroup(a_group)
	updateHiddenGroup(a_group)

	panel_units_list.updateRow(a_group)
	panel_units_list.selectGroup(a_group)
	
	if a_group.hidden ~= true then
		if a_group.type ~= 'static' then
			panel_route.showActionEditPanelForCurItem()		
		end
	end
end

-------------------------------------------------------------------------------
-- обработчик чекбокса показа/скрытия юнита
function OnHiddenCheckboxChange(self)
    if selectedGroup then     -- нет выбранной группы
        selectedGroup.hidden = self:getState()
        -- обновить инфо группы
        changeHiddenGroup(selectedGroup)	
    else
        self:setState(false)
    end      
end

function updateHiddenSelectedGroup()
    if selectedGroup then     -- нет выбранной группы
        -- обновить инфо группы
        panel_units_list.updateRow(selectedGroup)
        updateHiddenGroup(selectedGroup)
		panel_units_list.updateGroup(selectedGroup)		
    end      
end

-------------------------------------------------------------------------------
-- 
function setSelectedObject(id)
    selectedObject = id
end

-------------------------------------------------------------------------------
-- recreate selected group objects
function updateSelectedGroup(group)
    module_mission.remove_group_map_objects(group)
    module_mission.create_group_map_objects(group)
    set_selected_group_color(group)
    set_waypoint_color(group.route.points[panel_route.vdata.wpt.index], 
        group.boss.boss.selectWaypointColor)
    module_mission.update_group_map_objects(group)
	panel_units_list.updateRow(group)
end

-------------------------------------------------------------------------------
--
function createAircraft(aircraftType, mapX, mapY)	
    unselectAll()
    panel_aircraft.setSafeMode(false)
    panel_route.setSafeMode(false)
    toolbar.setHelicopterButtonState(false)
    toolbar.setAirplaneButtonState(false)  
    
    if not getPointInMap(mapX, mapY) then
      showWarningWindow(cdata.placeInside)
      return
    end

    local vd = panel_aircraft.vdata
    local rvd = panel_route.vdata
    local tvd = panel_targeting.vdata
    local svd = panel_summary.vdata
    local pvd = panel_payload.vdata
    
    -- При добавлении точек группа должна быть известна
    local group = module_mission.create_group(vd.country, aircraftType, vd.name, nil, vd.communication, vd.frequency, mod_weather.start_time, mapX, mapY)
    group.modulation = vd.modulation
	
    group.task = vd.task
	group.defaultTask = vd.defaultTask
    selectedGroup = group
    vd.group = group
    vd.name = group.name
    vd.unit.cur = 1
    vd.unit.number = 1
    panel_route.setGroup(group)
	panel_triggered_actions.setGroup(group)
    tvd.group = group
    tvd.target = nil
    svd.group = group
    pvd.group = group

    local skill = vd.skills[1];
    if (skill == crutches.getPlayerSkill())
        and module_mission.playerUnit then -- если юнит играбельный и юнит с игроком уже есть, то
        -- надо проследить, чтобы не возникло двух юнитов со скилом игрока
        skill = panel_aircraft.aiSkills[1];
    end; 
    
    local unit = module_mission.insert_unit(group, vd.type, skill, 1, module_mission.getUnitName(group.name))--vd.pilots[1])
    
    local name = unit.name
    vd.skills = { skill}
    pvd.unit = unit
	  
    local height = U.getAltitude(mapX, mapY)
    local alt = math.max(height, initialAltitude[aircraftType])
	
	local cruiseSpeed = panel_route.getCruiseSpeed(unit)
	
    panel_route.setWaypoint(	module_mission.insert_waypoint(group, 1, 
									panel_route.actions.turningPoint, mapX, mapY, alt, cruiseSpeed or initialVelocity[aircraftType]) )			
	  if group.type == 'plane' or group.type == 'helicopter' then
		local wpt = group.route.points[1]
		local alt = wpt.alt
		local altType = wpt.alt_type
		if altType == panel_route.alt_types_all.BARO.type then
			unit.alt = alt
		else
			unit.alt = alt + U.getAltitude(unit.x, unit.y)
		end
	  elseif group.type == 'vehicle' or group.type == 'ship' then
		unit.alt = U.getAltitude(unit.x, unit.y)
	  end
	
    rvd.wpt.eta = mod_weather.start_time
    set_group_color(group, group.boss.boss.selectGroupColor)
    set_unit_color(unit, group.boss.boss.selectUnitColor)
    set_waypoint_color(rvd.wpt, group.boss.boss.selectWaypointColor)
    set_route_line_color(group, group.boss.boss.selectGroupColor)
    
    module_mission.update_group_map_objects(group)
    panel_aircraft.setGroup(group)

    addSelectedGroup(group)
    
	bCreatedUnit = true
    panel_aircraft.update()
    panel_targeting.update(false)
    panel_route.update()
    panel_route.onGroupTaskChange()
    panel_payload.update()
end;

-------------------------------------------------------------------------------
--
function getSelectedGroup()
	return selectedGroup
end

-------------------------------------------------------------------------------
--
function getSelectedGroups()
	return selectedGroups, selectedGroupsPoint.x,  selectedGroupsPoint.y
end

-------------------------------------------------------------------------------
--
function updateSelectedGroupsPoint(a_group)
	if a_group then
		selectedGroupsPoint.x = a_group.x
		selectedGroupsPoint.y = a_group.y
	else
		selectedGroupsPoint.x = nil
		selectedGroupsPoint.y = nil
	end
end

-------------------------------------------------------------------------------
--
function addSelectedGroup(a_group)
    if (table.maxn(selectedGroups) == 0) then
        selectedGroupsPoint.x = a_group.x
        selectedGroupsPoint.y = a_group.y
    end
	selectedGroups[a_group.groupId] = a_group.groupId
	
	for k,unit in pairs(a_group.units) do
		local udb = DB.unit_by_type[unit.type]
		if udb.category ~= 'Air Defence' and udb.warehouse ~= true and a_group.type ~= 'static' then
			module_mission.createUnitZones(unit)
		end
	end	
end

-------------------------------------------------------------------------------
--
function removeSelectedGroups(a_group)
	selectedGroups[a_group.groupId] = nil
	if (a_group.units) then
		for k,unit in pairs(a_group.units) do
			local udb = DB.unit_by_type[unit.type]
			if udb.category ~= 'Air Defence' and udb.warehouse ~= true then
				module_mission.removeUnitZones(unit)
			end
		end	
	end	
end


-------------------------------------------------------------------------------
--
function removeAllSelectedGroups()
	for k,id in pairs(selectedGroups) do
		local group = module_mission.group_by_id[id]
		for kk,unit in pairs(group.units) do
			local udb = DB.unit_by_type[unit.type]
			if udb.category ~= 'Air Defence' and udb.warehouse ~= true then
				module_mission.removeUnitZones(unit)
			end
		end
	end
	selectedGroups = {}
	selectedGroupsPoint.x = nil
	selectedGroupsPoint.y = nil
end
	
-------------------------------------------------------------------------------
--
function isUnitInSelectedGroups(a_unit)
	if selectedGroups then
		for k,groupId in pairs(selectedGroups) do
			if a_unit.boss.groupId == groupId then
				return true
			end		
		end
	end
	return false
end

function collapse(a_dx, a_dy)
	if bCollapse == false then
		newMapView_:setSize(w_ - a_dx, h_ - a_dy)
		
		local camX, camY = newMapView_:getCamera()
		txCollapse = a_dx
		tyCollapse = a_dy
		local tx, ty = getMapSize(txCollapse, tyCollapse)  
		newMapView_:setCamera(camX - tx/2, camY - ty/2)
		bCollapse = true
	end
end

function expand()
	if bCollapse == true then
		newMapView_:setSize(w_, h_)
		
		local camX, camY = newMapView_:getCamera()
		local tx, ty = getMapSize(txCollapse, tyCollapse)  
		newMapView_:setCamera(camX + tx/2, camY + ty/2)
		bCollapse = false
	end
end

function showMap(b)
	newMapView_:setVisible(b)
end

-- создаем точки для редактирования триггерной зоны
function createPointsTriggerZone()
	
	for i = 1, 4 do
		local classKey = 'pointTriggerZone'
		
		local id = 2+i
		local x = 0
		local y = 0
		pointsTriggerZone[i] = createDOT(classKey, id, x, y)
		pointsTriggerZone[i].index = i
		
		pointsTriggerZone[i].currColor = {1,1,0}
		pointsTriggerZoneMapObjects[id] = pointsTriggerZone[i]
	end
end

function showPointsTriggerZone(a_points)
	
	for k,v in base.pairs(a_points) do		
		pointsTriggerZone[k].x = v.x
		pointsTriggerZone[k].y = v.y
	end
	
	removeUserObjects(pointsTriggerZone)
    addUserObjects(pointsTriggerZone)
end

function hidePointsTriggerZone()
	removeUserObjects(pointsTriggerZone)
end

function onIconsThemeChange()
	if newMapView_ then
		newMapView_:onIconsThemeChange(OptionsData.getIconsTheme())
		panel_draw.onIconsThemeChange()
	end	
end