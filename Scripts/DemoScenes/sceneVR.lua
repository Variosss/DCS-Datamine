package.path = package.path ..';./Scripts/DemoScenes/?.lua;'
local sceneEnvironment = require("demosceneEnvironment")

scene = {} -- сюда кладем все созданные объекты

function loadScene(scenePtr)
	sceneAPI = sceneEnvironment.getInterface(scenePtr)
	sceneAPI:setUpdateFunc('sceneVRUpdate')
	sceneAPI:setEnvironmentMap("Bazar/Graphics/VRMainScene.dds",0.9);
	sceneAPI:setSun(math.rad(-90), math.rad(0)) -- сажаем солнце за горизонт чтоб не светило

	scene.m			= sceneAPI:addModel("su-27", 0, 2.4, 0);
	scene.m:setArgument(0, 1);
	scene.m:setArgument(3, 1);
	scene.m:setArgument(5, 1);
	scene.m:setArgument(4, 0.25);
	scene.m:setArgument(6, 0.25);
	scene.m:setArgument(115, 1);
	scene.m:setArgument(116, 1);
	scene.m:setArgument(117, 1);

	local cam_level = 1.8

	scene.cam		= sceneAPI:addCamera(3, cam_level , 3)
	scene.cam:setFarClip(1000.0)
	scene.cam:setFov(90)
	scene.cam.transform:lookAtPoint(-10.0, cam_level, 0);


	scene.flr		= sceneAPI:addModel("shelter_floor", 0,0,0);
	scene.flr:drawToEnvironment(true);
	scene.flr.transform:scale(2,1.5,1.5);

	scene.sh		= sceneAPI:addModel("ukrytie", 0,0,0); 
	scene.sh:drawToEnvironment(true);
	scene.sh.transform:scale(2,2,2);

	scene.L1			= sceneAPI:addLightOmni(0, 25, 0,	1,0.8,0.5);
	scene.L1:setRadius(200);
	scene.L1:setAmount(1);

	scene.cam:setActive()

	preloadList = 
	{
		{"su-27", {}, {}},
		{"shelter_floor", {}, {}},
		{"ukrytie", 	  {}, {}},
	}
	sceneAPI:waitForModels(preloadList)	
end

--[0;1]
local function pingpong(length, t)
	local tt = (t%length)*2/length
	if tt>1 then tt = 2-tt end
	return tt
end


function sceneVRUpdate(t, dt)

end



