package.path = package.path	..	';./Scripts/DemoScenes/?.lua;'

local sceneEnvironment = require('demosceneEnvironment')

map =
{
	scene = {}, -- сюда кладем все созданные объекты
}

function loadScene(scenePtr)
	local sceneAPI = sceneEnvironment.getInterface(scenePtr)
	sceneAPI:setSky(false)
	sceneAPI:setSun(math.rad(25), math.rad(0))
	sceneAPI:setTerrainMode('mapAlt')

	map.scene.cam = sceneAPI:addCamera(0, 0, 0)
	map.scene.cam:setNearClip(0.1)
	map.scene.cam:setFarClip(120000)

	camPosX = -110000
	camPosY = 6000
	camPosZ = 285000

	mapRectMinX = -586111.11760139465
	mapRectMaxX = 1156111.1176013947
	mapRectMinZ = -600000.00000000000
	mapRectMaxZ = 380000.00000000000

	--test map
	map.scene.cam:setProjection('o')
	map.scene.cam:setBoundingBox(
		mapRectMinX - camPosZ, mapRectMaxX - camPosZ,
		mapRectMinZ - camPosX, mapRectMaxZ - camPosX,
		0.1, 6000.0 * 1.2
		)
	
	map.scene.cam.transform:setPosition(camPosX, camPosY, camPosZ)
	map.scene.cam.transform:lookAtPointUp(camPosX, 0, camPosZ, 1, 0, 0)
	
end