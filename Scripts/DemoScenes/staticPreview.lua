local sceneEnvironment = require('demosceneEnvironment')
staticPreview =
{
    scene = {}, -- сюда кладем все созданные объекты

    objectHeight = 5000, --высота объекта, вокруг которого крутим камеру

    cameraSpeed  = 0.25,
    cameraFov	 = 60,
    cameraAngVDefault = math.rad(25),
    cameraDistance = 50,
    cameraDistMult = 0,

    cameraAngH	 = 0,
    cameraAngV	 = 0,
    cameraRadius = 0,
    cameraHeight = 0,
    camAng = 0,
    camDist = 0,
    camTime = 0,

    mouseSensitivity = 0.0034, -- скорость вращения камеры
    wheelSensitivity = 0.02, -- скорость удаления/приближения камеры

}

staticPreview.payloadPreviewUpdate = function(t, dt)
        staticPreview.camTime = staticPreview.camTime + dt
        staticPreview.camAng = staticPreview.cameraSpeed*staticPreview.camTime + staticPreview.cameraAngH;
        staticPreview.camDist = staticPreview.cameraDistance*math.exp(staticPreview.cameraDistMult)
        staticPreview.cameraHeight = math.sin(staticPreview.cameraAngV)*staticPreview.camDist
        staticPreview.cameraRadius = math.cos(staticPreview.cameraAngV)*staticPreview.camDist
        staticPreview.scene.cam.transform:setPosition(math.sin(staticPreview.camAng)*staticPreview.cameraRadius, staticPreview.objectHeight + staticPreview.cameraHeight, math.cos(staticPreview.camAng)*staticPreview.cameraRadius)
        staticPreview.scene.cam.transform:lookAtPoint(0, staticPreview.objectHeight, 0)
    end

staticPreview.payloadPreviewUpdateNoRotate = function(t,dt)
        staticPreview.camAng = staticPreview.cameraSpeed*staticPreview.camTime + staticPreview.cameraAngH;
        staticPreview.camDist = staticPreview.cameraDistance*math.exp(staticPreview.cameraDistMult)
        staticPreview.cameraHeight = math.sin(staticPreview.cameraAngV)*staticPreview.camDist
        staticPreview.cameraRadius = math.cos(staticPreview.cameraAngV)*staticPreview.camDist
        staticPreview.scene.cam.transform:setPosition(math.sin(staticPreview.camAng)*staticPreview.cameraRadius, staticPreview.objectHeight + staticPreview.cameraHeight, math.cos(staticPreview.camAng)*staticPreview.cameraRadius)
        staticPreview.scene.cam.transform:lookAtPoint(0, staticPreview.objectHeight, 0)
    end
    
function loadScene(scenePtr)
    local sceneAPI = sceneEnvironment.getInterface(scenePtr)	
    sceneAPI:setSky(true)	
    sceneAPI:setEnvironmentMap("nevada01")
	staticPreview.scene.cam = sceneAPI:addCamera(0, 0, 0)
    staticPreview.scene.cam:setNearClip(0.2)
    staticPreview.scene.cam:setFarClip(10000)
    
end