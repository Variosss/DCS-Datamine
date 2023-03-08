local sceneEnvironment = require('demosceneEnvironment')
enc =
{
    scene = {}, -- сюда кладем все созданные объекты

    objectHeight = 30, --высота объекта, вокруг которого крутим камеру

    cameraSpeed  = 0.25,
    cameraFov	 = 60,
    cameraAngVDefault = math.rad(25),
    cameraDistance = 50,
    cameraDistMult = 0,

    cameraAngH	 = 0,
    cameraAngV	 = 0,
    cameraRadius = 0,
    cameraHeight = 0,
	cameraShiftX = 10,
	cameraShiwtY = 0,
    camAng = 0,
    camDist = 0,
    camTime = 0,
    mouseSensitivity = 0.0034, -- скорость вращения камеры
    wheelSensitivity = 0.02, -- скорость удаления/приближения камеры
}

local sceneAPI

enc.updateCamera = function()
	enc.camAng 			= enc.cameraSpeed*enc.camTime + enc.cameraAngH;
	enc.camDist 		= enc.cameraDistance*math.exp(enc.cameraDistMult)
	enc.cameraHeight 	= math.sin(enc.cameraAngV)*enc.camDist
	enc.cameraRadius 	= math.cos(enc.cameraAngV)*enc.camDist
	enc.scene.cam.transform:setPosition(math.sin(enc.camAng)*enc.cameraRadius, enc.objectHeight + enc.cameraHeight, math.cos(enc.camAng)*enc.cameraRadius)
	enc.scene.cam.transform:lookAtPoint(0, enc.objectHeight, 0)
end

enc.encyclopediaSceneUpdate = function(t, dt)
	enc.camTime = enc.camTime + dt
	enc.updateCamera()
end

enc.encyclopediaSceneUpdateNoRotate = function(t, dt)
	enc.updateCamera()
end

local function clearFloor()
	if  enc.floor then 
		sceneAPI.remove(enc.floor)
		enc.floor = nil
	end
end

enc.makeFloor = function(sz,pos)
	do
	  return
    end

	if sz == nil then
		clearFloor()
		return
	end
	if  not enc.floor  then 
		enc.floor 	   =  sceneAPI:addModel("1x1",0,enc.objectHeight,0)
	end
	enc.floor.transform:setOrient(0,0,90);
	enc.floor.transform:setPosition(0,0,0)
	enc.floor.transform:scale(sz,sz,sz);
	enc.floor.transform:setPosition(0,pos,0)
end

enc.onChangeModel = function(model,category)

	if  not model or not model.valid or
		category == nil or 
		category == 'Helicopter' or
		category == 'Plane' or
		category == 'Weapon' then
		enc.makeFloor(nil)
	else
		local x,y,z = model.transform:getPositionWorld()
		if category == 'Ship' then
			enc.makeFloor(400,y)
		else
			enc.makeFloor(100,y)
		end
	end
end

function loadScene(scenePtr)
    sceneAPI = sceneEnvironment.getInterface(scenePtr)
    sceneAPI:setSky(true)
	sceneAPI:setEnvironmentMap("Nevada01")
    enc.scene.cam = sceneAPI:addCamera(0, 0, 0)
    enc.scene.cam:setNearClip(0.05)
    enc.scene.cam:setFarClip(10000)
end

