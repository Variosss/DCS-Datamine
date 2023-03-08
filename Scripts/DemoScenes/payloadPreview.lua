local sceneEnvironment = require('demosceneEnvironment')

local hfov_default   = math.rad(45)
local default_aspect = 590 / 393 --аспект для вычисления вертикального fov
local vfov_default   = 2 * math.atan(math.tan(hfov_default/2)/default_aspect)

preview =
{
    scene 			= {}, -- сюда кладем все созданные объекты
    aspect       	= default_aspect,
    cameraDistance 	= 50,
    cameraDistMult 	= 0,

    cameraAngH	 	= 0,
    cameraAngV	 	= 0,

    mouseSensitivity = 0.0034, -- скорость вращения камеры
    wheelSensitivity = 0.02, -- скорость удаления/приближения камеры
	
}

preview.payloadSceneUpdate  = function(t,dt)
	local camAng 	 		= preview.cameraAngH;
	local camDist	 		= preview.cameraDistance*math.exp(preview.cameraDistMult)
	local cameraHeight 		= math.sin(preview.cameraAngV)* camDist
	local cameraRadius 		= math.cos(preview.cameraAngV)* camDist

	preview.scene.cam.transform:setPosition(math.sin(camAng)* 		  cameraRadius,
											cameraHeight, 
											math.cos(camAng)* 		  cameraRadius)
	
	preview.scene.center.transform:setOrient(0,t,0)
	preview.scene.cam.transform:lookAtPoint (0,0,0)
	
	--[[

	local cubemaps = 
	{
	"Caucasus01",
	"Nevada01",
	"Nevada02",
	"Nevada03",
	"Nevada04",
	"Nevada05",
	"Normandy01",
	"Normandy02",
	"Normandy03",
	"Normandy04",
	}
	if  preview.envChangeTime == nil then
		preview.envChangeTime = t
	end 
	if  t - preview.envChangeTime > 3 then
		if 	preview.envIdx == nil then
			preview.envIdx = 1
		else
			preview.envIdx = preview.envIdx + 1
		end
		if 	preview.envIdx > #cubemaps then
			preview.envIdx = 1
		end
		preview.scene.ptr:setEnvironmentMap(cubemaps[preview.envIdx])
		preview.envChangeTime = t
	end	
	--]]
end
    
function loadScene(scenePtr)
    local sceneAPI = sceneEnvironment.getInterface(scenePtr)	
    sceneAPI:setSky(true)
	sceneAPI:setEnvironmentMap("nevada02")
	preview.scene.cam = sceneAPI:addCamera(0, 0, 0)
    preview.scene.cam:setNearClip(0.2)
    preview.scene.cam:setFarClip(10000)
	preview.scene.ptr = sceneAPI
	
	preview.scene.center = preview.scene.ptr:addDummy(0, 0, 0)
	preview.scene.cam:attachTo(preview.scene.center)
	
	sceneAPI:setUpdateFunc('preview.payloadSceneUpdate')
end

preview.setFOV_by_VFOV = function(vfov)
	local fov =  math.deg(2 * math.atan(math.tan(vfov/2) * preview.aspect )) 
	preview.scene.cam:setFov(fov)
end

preview.onChangeSize = function(w,h)
	preview.aspect      = w/h
	preview.setFOV_by_VFOV(vfov_default);
end

preview.centerCamera = function()	
	preview.cameraDistMult  = 0
	preview.cameraAngV 		= math.rad(-1.5)
	preview.cameraAngH		= math.rad(90)
end

preview.getCurParams = function()	
	local tbl = {}
	tbl.cameraDistMult 	= preview.cameraDistMult
	tbl.cameraAngV 		= preview.cameraAngV 	
	tbl.cameraAngH		= preview.cameraAngH		

	return tbl
end

preview.setCurParams = function(tbl)	
	preview.cameraDistMult  = tbl.cameraDistMult
	preview.cameraAngV 		= tbl.cameraAngV 	
	preview.cameraAngH		= tbl.cameraAngH
end

preview.newModel = function(shape)
	local modelObj			= preview.scene.ptr:addModel(shape, 0, 0, 0)
	--------------------------------------------------------------------------------
	if  modelObj and modelObj.valid == true then
	
		modelObj:attachTo(preview.scene.center)
		
		local x0,y0,z0,x1,y1,z1 = modelObj:getBBox()
		
		local y_size =  y1 - y0
		local x_size =  x1 - x0
		local z_size =  z1 - z0
		
		local c_x 	 =  (x0+x1)*0.5
		local c_y    =  (y0+y1)*0.5
		local c_z    =  (z0+z1)*0.5
			
		--print(string.format("BOX{%f,%f,%f}",x_size,y_size,z_size))
		--print(string.format("CTR{%f,%f,%f}",c_x   ,c_y	 ,c_z))

		modelObj.transform:setPosition(-c_x,-c_y,-c_z)
												
		preview.cameraDistance = 1.5 * x_size + 10
		preview.setFOV_by_VFOV(2 * math.atan(0.5 * (y_size + 2) / preview.cameraDistance))
	end
	--------------------------------------------------------------------------------
	preview.centerCamera()
	--------------------------------------------------------------------------------
	return modelObj
end

