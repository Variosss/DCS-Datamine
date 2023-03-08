local base = _G

module('NewMapView')
mtab = { __index = _M }

local require 		= base.require

local Factory		= require('Factory'		)
local Widget		= require('Widget'		)
local NewMapState	= require('NewMapState'	)
local NewMap		= require('gui_map'		)
local Terrain		= require('terrain'		)

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end
	
function construct(self)
	NewMap.Create()
	Widget.construct(self)
	self.state = NewMapState.new(self)

	self:addMouseMoveCallback(onMouseMove)
	self:addMouseDownCallback(onMouseDown)
	self:addMouseDoubleDownCallback(onMouseDoubleClick)
	self:addMouseUpCallback(onMouseUp)
	self:addMouseWheelCallback(function(self, x, y, clicks)
		self:onMouseWheel(x, y, clicks)

		return true
	end)
	self:addMouseReleasedCallback(onMouseReleased)
end	

function newWidget(self)
	return NewMap.GetWidgetPointer()
end

function close(self)
	NewMap.Exit_edterraingraphics()
	NewMap.Close()
end

--MODEL
function addSceneObjectWithModel(self, name, x,y,z)
	local obj, valid = NewMap.AddSceneObjWithModel(name, x,y,z)
	if valid == false then
		return nil
	end	
	local t = {}
	t.obj = obj
	t.valid = valid
	t.setPosition			   = function(self, x, y, z)				NewMap.SetSceneObjPosition(self.obj, x, y, z)					end
	t.setOrientationEuler	   = function(self, heading, pitch, roll)	NewMap.SetSceneObjOrientEuler(self.obj, heading, pitch, roll)	end
	t.setArgument			   = function(self, arg, value)				NewMap.SetSceneObjArgument(self.obj, arg, value)				end
	t.setLivery				   = function(self, livery , liv_folder)	return NewMap.SetSceneObjLivery(self.obj, livery , liv_folder)	end
	t.setAircraftBoardNumber   = function(self, boardnumber)			NewMap.SetSceneObjBoardNumber(self.obj, boardnumber)			end
	t.setVisibility			   = function(self, visible)				NewMap.SetSceneObjVisibility(self.obj, visible)					end
	return t
end

function removeSceneObject(self, sceneObj)
	NewMap.RemoveSceneObj(sceneObj.obj)
end

--CAMERA
function setSceneCameraPosition(self, x,y,z) -- xyz - camera world position
	NewMap.SetSceneCameraPosition(x,y,z)
end

function setSceneCameraOrientationEuler(self, heading, pitch, roll)
	NewMap.SetSceneCameraOrientEuler(heading,pitch,roll)
end

function setSceneCameraFovH(self, fovH) --set camera horizontal FOV in degrees, default 60
	NewMap.SetSceneCameraFovH(fovH)
end

function setState(self, state)
	self.state = state
end

function getState(self)
	return self.state
end

-- путь к файлу "../LockOnExe/Config/edterraingraphics.conf"
function initEDTerrainGraphics(path)
	NewMap.Init_edterraingraphics(path)
end

--	
function resetEDTerrainGraphics()
	NewMap.Reset_edterraingraphics()
end

-- загрузить проекцию из файла
-- для перевода метров в радианы и обратно
function loadProjection(self, filename)
	local f = base.loadfile(filename)
	
	if f then
		local env = {}
		
		base.setfenv(f, env)
		f()

		NewMap.LoadProjection(env)
	else
		base.error('Cannot load ' .. filename)
	end
end

function loadClassifier(self, classifier)	
	self.classifier = classifier
	
	NewMap.LoadClassifier(classifier)
end

function setMapBounds(self, xMin, yMin, xMax, yMax)
	NewMap.SetMapBounds(xMin, yMin, xMax, yMax)
end

function setScale(self, scale)
	NewMap.SetScale(scale)
end

function getScale(self)
	return NewMap.GetScale()
end

function getResolution(self)
	return NewMap.GetResolution()
end

local function compareLayers(layer1, layer2)
	return layer1.order > layer2.order
end

function getLayers(self)
	local layers = {}
	
	for index, layer in base.pairs(self.classifier.layers) do
		base.table.insert(layers, layer)
	end
	
	base.table.sort(layers, compareLayers)
	
	return layers
end

function setCamera(self, x, y)
	NewMap.SetCamera(x, y)
end

function getCamera(self)
	local x, y = NewMap.GetCamera()
	
	return x, y
end

function showLayer(self, layer, show)
	NewMap.ShowLayer(layer, show or false)
end

-- color в старом формате, т.е. таблица {r, g, b}
function setBkgColor(self, color)
	NewMap.SetBkgColor(color)
end

-- возвращает точку на карте
function getMapPoint(self, x, y) 
	local widgetX, widgetY = self:windowToWidget(x, y)
	local mapX, mapY = NewMap.GetMapPoint(widgetX, widgetY)
		
	return mapX, mapY
end

-- проверяет нахождение точки внутри карты
function getPointInMap(self, x, y)
	local bool = NewMap.GetPointInMap(x,y) 
	
	return bool
end

function getClassifierObject(self, classKey)
	local result
	
	if self.classifier then
		result = self.classifier.objects[classKey]
	end
	
	return result
end

function getObjectType(self, object)
	local result
	local classifierObject = getClassifierObject(self, object.classKey)
	
	if classifierObject then
		result = classifierObject.type
	else
		base.print("Unknown map object type!", object.classKey)
	end
	
	return result
end

-- objects - таблица объектов
function addUserObjects(self, objects)
	NewMap.AddUserObjects(objects)
end

-- objects - таблица объектов
function removeUserObjects(self, objects)
	NewMap.RemoveUserObjects(objects)
end

function clearUserObjects(self)
	NewMap.RemoveUserObjects() -- RemoveUserObjects без парметров удалит все пользовательские объекты
end

-- поиск пользовательских объектов
function findUserObjects(self, x, y, radius)
	-- возвращает таблицу вида {id, id, ...}
	-- x, y - точка на карте, radius - в метрах
	return NewMap.FindUserObjects(x, y, radius) 
end

-- создает объект карты и возвращает его id
-- data - таблица данных для объекта
function createUserObject2(self, data)
	local id = NewMap.CreateUserObject2(data)
	
	return id
end

-- добавить объект на карту (показать)
-- если объект изменился и его нужно перерисовать, то needRedraw = true
function addUserObject2(self, id, needRedraw)
	NewMap.AddUserObject2(id, needRedraw)
end

-- изменить объект карты с id 
function updateUserObject2(self, id, data)
	NewMap.UpdateUserObject2(id, data)
end

-- убрать объект с карты (спрятать)
function removeUserObject2(self, id)
	NewMap.RemoveUserObject2(id)
end

-- убрать объект с карты и освободить память
function deleteUserObject2(self, id)
	NewMap.DeleteUserObject2(id)
end

-- удаляет все объекты и слои карты и освобождает память
function clearUserObjects2(self)
	NewMap.ClearUserObjects2()
end

-- создает объект на слое для рисования и возвращает его id
-- data - таблица данных для объекта
function createDrawObject(self, data)
	local id = NewMap.CreateDrawObject(data)
	
	return id
end

-- добавить объект на слой для рисования (показать)
-- если объект изменился и его нужно перерисовать, то needRedraw = true
function addDrawObject(self, id, needRedraw)
	NewMap.AddDrawObject(id, needRedraw)
end

-- изменить объект на слое для рисования с id 
function updateDrawObject(self, id, data)
	NewMap.UpdateDrawObject(id, data)
end

-- убрать объект на слое для рисования (спрятать)
function removeDrawObject(self, id)
	NewMap.RemoveDrawObject(id)
end

-- убрать все объекты на слое для рисования (спрятать)
function removeAllDrawObjects(self)
	NewMap.RemoveAllDrawObjects()	
end

-- убрать объект со слоя для рисования и освободить память
function deleteDrawObject(self, id)
	NewMap.DeleteDrawObject(id)
end

-- удаляет все объекты на слое для рисования и освобождает память
function clearDrawObjects(self)
	NewMap.ClearDrawObjects()
end

-- поиск объектов на слое для рисования возвращает их id
function findDrawObjects(self, x, y, radius)
	-- возвращает таблицу вида {id, id, ...}
	-- x, y - точка на карте, radius - в метрах
	return NewMap.FindDrawObjects(x, y, radius) 
end

-- переводит метры в градусы
-- возвращает lat, lon (в градусах)
function convertMetersToLatLon(self, x, y)
	return Terrain.convertMetersToLatLon(x, y)
end

-- переводит градусы в метры
-- lat, lon в градусах
-- возвращает x, y
function convertLatLonToMeters(self, lat, lon)
	local x, y = Terrain.convertLatLonToMeters(lat, lon)
	
	return x, y
end

-- допустимые значения mapMode: "scene", "map", "altitude", "satellite"
function setMapMode(self, mapMode)
	NewMap.SetMapMode(mapMode)
end

-- возвращает строку: "scene", "map", "altitude", "satellite"
function getMapMode(self)
	return NewMap.GetMapMode()
end

local mouseButtons = {}
local mouseDownPoint = {x = 0, y = 0}

function onMouseMove(self, x, y)
	if #mouseButtons > 0 then
		local dx = x - mouseDownPoint.x
		local dy = y - mouseDownPoint.y	
		
		for k, v in base.ipairs(mouseButtons) do
			self:onMouseDrag(dx, dy, v, x, y)
		end
		
		mouseDownPoint.x = x
		mouseDownPoint.y = y
	else
		self.state:onMouseMove(x, y)		
	end
end

function onMouseDown(self, x, y, button)	
	self:captureMouse()
	base.table.insert(mouseButtons, button)
	mouseDownPoint.x = x
	mouseDownPoint.y = y	
	
	self.state:onMouseDown(x, y, button)
end

function onMouseDoubleClick(self, x, y, button) 
	self:captureMouse()
	base.table.insert(mouseButtons, button)
	mouseDownPoint.x = x
	mouseDownPoint.y = y
	
	self.state:onMouseDoubleClick(x, y, button)
end

function onMouseUp(self, x, y, button)
	for k, v in base.ipairs(mouseButtons) do
		if v == button then
			base.table.remove(mouseButtons, k)
			
			break
		end
	end
	
	if #mouseButtons == 0 then
		self:releaseMouse()
	end
	
	self.state:onMouseUp(x, y, button)	
end

function onMouseDrag(self, dx, dy, button, x, y)
	self.state:onMouseDrag(dx, dy, button, x, y)
end

function onMouseWheel(self, x, y, clicks)
	self.state:onMouseWheel(x, y, clicks)
end

function onMouseReleased(self)
	mouseButtons = {}
end

function onIconsThemeChange(self, theme)
	NewMap.OnIconsThemeChange(theme)
end