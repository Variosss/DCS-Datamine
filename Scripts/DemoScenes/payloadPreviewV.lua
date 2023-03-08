local sceneEnvironment = require('demosceneEnvironment')

local hfov_default   = math.rad(45)
local default_aspect = 590 / 393 --аспект для вычисления вертикального fov
local vfov_default   = 2 * math.atan(math.tan(hfov_default/2)/default_aspect)

previewV =
{
    scene 			= {}, -- сюда кладем все созданные объекты
    aspect       	= default_aspect,
    cameraDistance 	= 50,
    cameraDistMult 	= 0,

    cameraAngH	 	= math.rad(135),
    cameraAngV	 	= 0,
	cameraSpeed  	= 0.02,
	autoRotation	 = true,

    mouseSensitivity = 0.0034, -- скорость вращения камеры
    wheelSensitivity = 0.02, -- скорость удаления/приближения камеры
}

previewV.payloadSceneUpdate  = function(t,dt)
	if previewV.autoRotation == true then
		previewV.cameraAngH = previewV.cameraSpeed*dt + previewV.cameraAngH
	end
	
	if previewV.cameraAngH > 2*math.pi then
		previewV.cameraAngH = previewV.cameraAngH - 2*math.pi
	end

	local camDist	 		= previewV.cameraDistance*math.exp(previewV.cameraDistMult)
	if camDist > 540 then
		camDist = 540
		previewV.cameraDistMult = math.log(540/previewV.cameraDistance)
	end
	
	local cameraHeight 		= math.sin(previewV.cameraAngV)* camDist
	local cameraRadius 		= math.cos(previewV.cameraAngV)* camDist

	previewV.scene.cam.transform:setPosition(math.sin(previewV.cameraAngH) * cameraRadius,
											cameraHeight, 
											math.cos(previewV.cameraAngH) * cameraRadius)
	
	if previewV.autoRotation == true then
		previewV.scene.center.transform:setOrient(0,t,0)
	end	
	previewV.scene.cam.transform:lookAtPoint (0,0,0)	
end
 
function loadScene(scenePtr)
    local sceneAPI = sceneEnvironment.getInterface(scenePtr)	
    sceneAPI:setSky(true)
	sceneAPI:setEnvironmentMap("normandy03")
		
    previewV.scene.cam = sceneAPI:addCamera(0, 0, 0)
    previewV.scene.cam:setNearClip(0.2)
    previewV.scene.cam:setFarClip(10000)
	previewV.scene.ptr = sceneAPI
	
	previewV.scene.center = previewV.scene.ptr:addDummy(0, 0, 0)
	previewV.scene.cam:attachTo(previewV.scene.center)
	
	sceneAPI:setUpdateFunc('previewV.payloadSceneUpdate') 
end

previewV.setFOV_by_VFOV = function(vfov)
	local fov =  math.deg(2 * math.atan(math.tan(vfov/2) * previewV.aspect )) 
	previewV.scene.cam:setFov(fov)
end

previewV.onChangeSize = function(w,h)
	previewV.aspect      = w/h
	previewV.setFOV_by_VFOV(vfov_default);
end

previewV.centerCamera = function()	
	previewV.cameraDistMult  = 0
	previewV.cameraAngV 	= math.rad(30)
	previewV.cameraAngH		= math.rad(135)
	previewV.autoRotation	= true
end

previewV.newModel = function(shape)
	local modelObj			= previewV.scene.ptr:addModel(shape, 0, 0, 0)
	--------------------------------------------------------------------------------
	if  modelObj and modelObj.valid == true then
	
		modelObj:attachTo(previewV.scene.center)
		
		local x0,y0,z0,x1,y1,z1 = modelObj:getBBox()
		
		local y_size =  y1 - y0
		local x_size =  x1 - x0
		local z_size =  z1 - z0
		
		local c_x 	 =  (x0+x1)*0.5
		local c_y    =  (y0+y1)*0.5
		local c_z    =  (z0+z1)*0.5
			
		--print("shape=",shape)	
		--print(string.format("BOX{%f,%f,%f}",x_size,y_size,z_size))
		--print(string.format("CTR{%f,%f,%f}",c_x   ,c_y	 ,c_z))

		modelObj.transform:setPosition(-c_x,-c_y,-c_z)
												
		previewV.cameraDistance = 1.5 * x_size + 10
		previewV.setFOV_by_VFOV(3 * math.atan(0.5 * (x_size + 2) / previewV.cameraDistance))
	end
	--------------------------------------------------------------------------------
	previewV.centerCamera()
	--------------------------------------------------------------------------------
	return modelObj
end
