local ED_demosceneAPI = require('ED_demosceneAPI')

local function setUpdateFunction(self, func)
	ED_demosceneAPI.setUpdateFunc(self.scenePtr, func)
end

local function setEnvironmentMap(self, IBLFile, mipfactor, skyBoxFile)
	skyBoxFile = skyBoxFile or ""
	ED_demosceneAPI.setEnvironmentMap(self.scenePtr, IBLFile, mipfactor, skyBoxFile)
end

local function setColorGradingLUT(self, file)
	ED_demosceneAPI.setColorGradingLUT(self.scenePtr, file)
end

--mode: off, finalShading, map, mapAlt, mapTAD, mapSatellite
local setTerrainMode = function(self, mode)
	ED_demosceneAPI.setTerrainMode(self.scenePtr, mode)
end

-- msaa:
-- 0 - off
-- 1 - 2x
-- 2 - 4x
-- 3 - 8x
local setMSAA = function(self, msaa)
	ED_demosceneAPI.setMSAA(self.scenePtr, msaa)
end

local setLensEffects = function(self, enable)
	ED_demosceneAPI.setLensEffects(self.scenePtr, enable)
end

local setDOFEffect = function(self, targetDistance)
	ED_demosceneAPI.setDOFEffect(self.scenePtr, targetDistance)
end

local setCirrus = function(self, enable)
	ED_demosceneAPI.setCirrus(self.scenePtr, enable)
end

local setSun = function(self, elevation, azimuth)
	ED_demosceneAPI.setSunDirection(self.scenePtr, elevation, azimuth)
end

local setSky = function(self, enable)
	ED_demosceneAPI.setSky(self.scenePtr, enable)
end

local setCloudsDensity = function(self, dens)
	ED_demosceneAPI.setClouds(self.scenePtr, dens, -1, -1)
end

local setCloudsLowHigh = function(self, low, high)
	ED_demosceneAPI.setClouds(self.scenePtr, -1, low, high)
end

local remove = function(self)
	ED_demosceneAPI.remove(self.scenePtr, self.obj)
end

local clear = function(self)
	ED_demosceneAPI.clear(self.scenePtr)
end

local setEnable = function(self, enable)
	ED_demosceneAPI.setEnable(self.scenePtr, enable)
end

local move = function(self, x, y, z)
	ED_demosceneAPI.move(self.obj, x, y, z)
end

local rotate = function(self, x, y, z)
	ED_demosceneAPI.rotate(self.obj, x, y, z)
end

local scale = function(self, x, y, z)
	ED_demosceneAPI.scale(self.obj, x, y, z)
end

local attachTo = function(self, parent, name)
	ED_demosceneAPI.attach(self.obj, parent.obj, name)
end

local detach = function(self)
	ED_demosceneAPI.detach(self.obj)
end 

local setTransformPosition = function(self, x, y, z)
	ED_demosceneAPI.setPosition(self.obj, x, y, z)
end 

local getTransformPositionWorld = function(self)
	return ED_demosceneAPI.getPositionWorld(self.obj)
end 

local setOrient = function(self, x, y, z)
	ED_demosceneAPI.setOrient(self.obj, x, y, z)
end 

local setArgument = function(self, arg, value)
	ED_demosceneAPI.setArgument(self.obj, arg, value)
end 


local setAircraftBoardNumber = function(self, boardnumber)
	ED_demosceneAPI.setAircraftBoardNumber(self.obj, boardnumber)
end 

local setLivery = function(self, livery , livery_folder)
	return ED_demosceneAPI.setLivery(self.obj, livery , livery_folder)
end 

local getModelRadius = function(self)
	return ED_demosceneAPI.getModelRadius(self.obj)
end 

local getModelActiveCollider = function(self)
	return ED_demosceneAPI.getModelActiveCollider(self.obj)
end

local getModelInteractionPoint = function(self)
	return ED_demosceneAPI.getModelInteractionPoint(self.obj)
end

local setMouseMovementMode = function(self, mode)
	ED_demosceneAPI.setMouseMovementMode(self.scenePtr, mode)
end

local getMouseMovementMode = function(self)
	return ED_demosceneAPI.getMouseMovementMode(self.scenePtr)
end

local getArgument = function(self, arg)
	return ED_demosceneAPI.getArgument(self.obj, arg)
end 

local getModelBBox = function(self)
	return ED_demosceneAPI.getModelBBox(self.obj)
end 

local drawToEnvironment = function(self, enabled)
	ED_demosceneAPI.drawToEnvironment(self.scenePtr, self.obj, enabled)
end

local addMouseInteraction = function(self, callbackType, callback)
	ED_demosceneAPI.addMouseInteraction(self.obj, callbackType, callback)
end


local setLightAmount = function(self, amount)
	ED_demosceneAPI.setLightAmount(self.obj, amount)
end 

local lookAtObject = function(self, object)
	ED_demosceneAPI.lookAt(self.obj, object.obj, 0, 1, 0)
end 

local lookAtPoint = function(self, x,y,z)
	ED_demosceneAPI.lookAt(self.obj, x,y,z, 0, 1, 0)
end

-- XYZ - target, upXYZ - up vector
local lookAtPointUp = function(self, x,y,z, upX, upY, upZ)
	ED_demosceneAPI.lookAt(self.obj, x,y,z, upX, upY, upZ)
end 

local setFov = function(self, fov)
	ED_demosceneAPI.setCameraFov(self.obj, fov)
end 

local setNearClip = function(self, near)
	ED_demosceneAPI.setCameraNearClip(self.obj, near)
end 

local setFarClip = function(self, far)
	ED_demosceneAPI.setCameraFarClip(self.obj, far)
end 

local setCameraActive = function(self)
	ED_demosceneAPI.setCameraActive(self.scenePtr, self.obj)
end 

-- proj = 'p' - perspective, 'o' - orthogonal
local setCameraProjection = function(self, proj)
	ED_demosceneAPI.setCameraProjection(self.obj, proj)
end

local setCameraBoundingBox = function(self, x, X, y, Y, z, Z)
	ED_demosceneAPI.setCameraBoundingBox(self.obj, x, X, y, Y, z, Z)
end

local setLightAngles = function(self, phi, theta)
	ED_demosceneAPI.setLightAngles(self.obj, phi, theta)
end 

local setLightPhi = function(self, phi)
	ED_demosceneAPI.setLightAngles(self.obj, phi, -1)
end 

local setLightTheta = function(self, theta)
	ED_demosceneAPI.setLightAngles(self.obj, -1, theta)
end

local setLightRadius = function(self, radius)
	ED_demosceneAPI.setLightRadius(self.obj, radius)
end

local setFlightSpeed = function(self, speed)
	ED_demosceneAPI.setFlightSpeed(self.obj, speed)
end

local addFlightKnot = function(self, x, y, z)
	ED_demosceneAPI.addFlightKnot(self.obj, x, y, z)
end

local getFlightKnot = function(self, id)
	return ED_demosceneAPI.getFlightKnot(self.obj, id)
end

local setFlightTargetOffset = function(self, dist)
	ED_demosceneAPI.setFlightTargetOffset(self.obj, dist)
end

local addWeaponStationToAircraft = function(self, parent, unit_type,station,weapon_clsid)
	local weapon_station = ED_demosceneAPI.addWeaponStationToAircraft(self.scenePtr, parent.obj, unit_type,station,weapon_clsid)
	local t   = { scenePtr = self.scenePtr}
	t.obj     = weapon_station
	t.destroy = remove
	return t
end

local startFly = function(self)
	ED_demosceneAPI.startFly(self.obj)
end

local addWayPoint = function(self, x, y, z)
	ED_demosceneAPI.addWayPoint(self.obj, x, y, z)
end

local addTargetPoint = function(self, x, y, z)
	ED_demosceneAPI.addTargetPoint(self.obj, x, y, z)
end

local getIsInFlight = function(self)
	return  ED_demosceneAPI.getIsInFlight(self.obj)
end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

local function addTransformComponent(parent)
	parent.attachTo = attachTo
	parent.detach = detach
	parent.transform = {obj = parent.obj}
	parent.transform.move = move
	parent.transform.rotate = rotate
	parent.transform.scale = scale 
	parent.transform.setPosition 	  = setTransformPosition
	parent.transform.getPositionWorld = getTransformPositionWorld
	
	parent.transform.setOrient = setOrient
	parent.transform.lookAtObject = lookAtObject
	parent.transform.lookAtPoint = lookAtPoint
	parent.transform.lookAtPointUp = lookAtPointUp
end

local function addFlightComponent(parent)
	parent.controller = {obj = parent.obj}
	parent.controller.setSpeed = setFlightSpeed
	parent.controller.addKnot = addFlightKnot
	parent.controller.getKnot = getFlightKnot
	parent.controller.setTargetOffset = setFlightTargetOffset
	parent.controller.setPosition = setFlightPosition
end

local function addFlightController(self, parent)
	ED_demosceneAPI.add_component(parent.obj, 'flightComponent')
	--добавляем новые методы
	addFlightComponent(parent)
end

-- 
local function addRotationComponent(parent)
	parent.RotationController = {obj = parent.obj}
	parent.RotationController.startFly = startFly
	parent.RotationController.addWayPoint 	 = addWayPoint
	parent.RotationController.addTargetPoint = addTargetPoint
	parent.RotationController.getIsInFlight = getIsInFlight
	
end

local function addCameraRotationController(self, parent)
	ED_demosceneAPI.add_component(parent.obj, 'cameraRotationComponent')	
	addRotationComponent(parent)
end

--MODEL
local addModel = function(self, name, x,y,z)
	local obj, valid = ED_demosceneAPI.add_model(self.scenePtr, name, x,y,z)
	local t = { scenePtr = self.scenePtr}
	t.obj = obj
	t.valid = valid
	t.setArgument 			   = setArgument
	t.setLivery   			   = setLivery
	t.setAircraftBoardNumber   = setAircraftBoardNumber
	t.drawToEnvironment 	   = drawToEnvironment
	t.getRadius = getModelRadius
	t.getBBox = getModelBBox -- возвращает Xmin, Ymin, Zmin, Xmax, Ymax, Zmax
	addTransformComponent(t)
	return t
end

local addInteractiveModel = function(self, name, x,y,z)
	local obj, valid = ED_demosceneAPI.add_interactive_model(self.scenePtr, name, x,y,z)
	local t = { scenePtr = self.scenePtr}
	t.obj = obj
	t.valid = valid
	t.setArgument 			   = setArgument
	t.setLivery   			   = setLivery
	t.setAircraftBoardNumber   = setAircraftBoardNumber
	t.drawToEnvironment 	   = drawToEnvironment
	t.getRadius = getModelRadius
	t.getBBox = getModelBBox -- возвращает Xmin, Ymin, Zmin, Xmax, Ymax, Zmax
		
	t.addMouseInteraction = addMouseInteraction
	t.getActiveCollider = getModelActiveCollider
	t.getArgument 			   = getArgument
	t.getInteractionPoint = getModelInteractionPoint
	addTransformComponent(t)
	return t
end


local preloadModel = function(self, name)
	 ED_demosceneAPI.preload_model(self.scenePtr, name)
end



local waitForModels = function(self, res)
	ED_demosceneAPI.waitForModels(self.scenePtr, res)
end

--DUMMY
local addDummy = function(self, x,y,z)
	local t = { scenePtr = self.scenePtr}
	t.obj = ED_demosceneAPI.add_dummy(self.scenePtr, x,y,z)
	addTransformComponent(t)
	return t
end

--LIGHTS
local addLightOmni = function(self, x,y,z, r,g,b)
	local t =
	{
		scenePtr = self.scenePtr,
		obj = ED_demosceneAPI.add_light(self.scenePtr, "OmniLight", x,y,z, r,g,b)
	} 
	t.setAmount = setLightAmount
	t.setRadius = setLightRadius
	t.setAngles = setLightAngles
	t.setCone	= setLightTheta
	t.setFalloff= setLightPhi
	addTransformComponent(t)
	return t
end
local addLightSpot = function(self, x,y,z, r,g,b)
	local t = 
	{
		scenePtr = self.scenePtr,
		obj = ED_demosceneAPI.add_light(self.scenePtr, "ProjLight", x,y,z, r,g,b)
	} 
	t.setAmount = setLightAmount
	t.setRadius = setLightRadius
	t.setAngles = setLightAngles
	t.setCone	= setLightTheta
	t.setFalloff= setLightPhi
	addTransformComponent(t)
	return t
end 

--CAMERA
local addCamera = function(self, x,y,z)
	local t = 
	{
		scenePtr = self.scenePtr,
		obj = ED_demosceneAPI.add_camera(self.scenePtr, x,y,z)
	}
	t.setFov = setFov
	t.setNearClip = setNearClip
	t.setFarClip = setFarClip
	t.setActive = setCameraActive
	t.setProjection = setCameraProjection
	t.setBoundingBox = setCameraBoundingBox
	addTransformComponent(t)
	return t
end


--INTERFACE
local function getInterface(scenePtr)
	local t = {scenePtr = scenePtr}
	
	t.setUpdateFunc = setUpdateFunction
	t.setEnvironmentMap = setEnvironmentMap
	t.setColorGradingLUT = setColorGradingLUT
	t.preloadModel		= preloadModel
	t.waitForModels		= waitForModels
	t.addModel			= addModel
	t.addInteractiveModel = addInteractiveModel
	t.addCameraRotationController = addCameraRotationController
	
	t.addLightOmni 		= addLightOmni
	t.addLightSpot 		= addLightSpot
	t.addCamera	= addCamera
	t.addDummy = addDummy
	t.addFlightController = addFlightController
	
	t.setEnable = setEnable
	t.remove	= remove
	t.clear		= clear
	
	t.setCloudsDensity = setCloudsDensity
	t.setCloudsLowHigh = setCloudsLowHigh
	t.setCirrus = setCirrus
	t.setSky = setSky
	t.setSun = setSun
	t.setLensEffects = setLensEffects
	t.setDOFEffect = setDOFEffect
	t.setMSAA = setMSAA
	t.setTerrainMode = setTerrainMode
	t.setMouseMovementMode = setMouseMovementMode
	t.getMouseMovementMode = getMouseMovementMode
	t.addWeaponStationToAircraft = addWeaponStationToAircraft
	return t
end

local function createInstance()
	return getInterface(ED_demosceneAPI.create_instance())
end

local function loadScript(scenePtr, filename)
	ED_demosceneAPI.loadScript(scenePtr, filename)
end

return 
{
	createInstance	= createInstance, -- если сцену хотим родить в виджете
	getInterface	= getInterface, --для случая когда у нас есть указатель на сцену
	loadScript		= loadScript
}