package.path = package.path ..';./Scripts/DemoScenes/?.lua;'
local sceneEnvironment = require("demosceneEnvironment")

scene = {} -- сюда кладем все созданные объекты

function addGUIBillboard(x,y,z, rotY)
	model = sceneAPI:addModel("gui_billboard", 0,0,0)
	model:setLivery("default")
	model.transform:setPosition(x, y, z)
	model.transform:setOrient(0, rotY, 0)
	model.transform:scale(1,1,1.33333)
	return model
end

function loadScene(scenePtr)
	sceneAPI = sceneEnvironment.getInterface(scenePtr)
	sceneAPI:setUpdateFunc('testSceneUpdate')
	
	scene.m			= sceneAPI:addModel("su-27", 0, 2.4, 0);
	scene.m:setArgument(0, 1);
	scene.m:setArgument(3, 1);
	scene.m:setArgument(5, 1);
	scene.m:setArgument(115, 1);
	scene.m:setArgument(116, 1);
	scene.m:setArgument(117, 1);

	scene.cam		= sceneAPI:addCamera(-10, 1.8, 0)
	scene.camFps	= sceneAPI:addCamera(0,0,0)
	
	scene.gui = addGUIBillboard(-9, 1.8, 0,	0)
	
	scene.audi		= sceneAPI:addModel("btr-80", 0,0,0);
	scene.audi2 	= sceneAPI:addModel("btr-80", 0,0,0);
	scene.flr		= sceneAPI:addModel("shelter_floor", 0,0,0);
	
	scene.flr:drawToEnvironment(true);
	scene.flr.transform:scale(2,1.5,1.5);

	scene.sh		= sceneAPI:addModel("ukrytie", 0,0,0); 
	scene.sh:drawToEnvironment(true);
	scene.sh.transform:scale(2,2,2);

	scene.L1		= sceneAPI:addLightOmni(8,5,0,	1,0.3,0.2);
	scene.L2		= sceneAPI:addLightOmni(-8,5,0,	0,0.6,0.8); 
	scene.spot		= sceneAPI:addLightSpot(2,0.7,1, 1,1,0.8); 
	scene.spot:setCone(40)
	scene.spot:setFalloff(75)
	scene.spot:setRadius(50)
	scene.spot:setAmount(2)
	scene.spot:attachTo(scene.audi, "DRIVER_POINT");

	scene.L1:attachTo(scene.audi2, "POINT_GUN"); --------------------
	scene.L1.transform:setPosition(0,0,0); ------------------------
	-- scene.L1.transform:move(0,-5,0);
	-- scene.L1.transform:move(0,0,1);

	-- scene.audi:attachTo(scene.m, "Pylon1");
	scene.audi.transform:setPosition(0,5,0);
	-- scene.audi:attachTo(scene.audi2, "wheel01");
	-- scene.audi.transform:move(0,0, 5);

	-- scene.audi2:attachTo(scene.m, "Pylon10");

	-- scene.cam:attachTo(scene.audi, "wheel01");
	-- scene.cam.transform:setPosition(15,10,10);
	-- scene.cam.transform:setPosition(3,3,10);
	-- scene.cam.transform:setPosition(-10, 1.8, 0);
	-- scene.cam.transform:lookAtObject(scene.audi)
	scene.cam.transform:lookAtPoint(0,0,0);
	
	-- scene.gui.transform:lookAtObject(scene.cam)

	scene.cam:setFov(90)

	scene.camFps:attachTo(scene.audi2, "POINT_SIGHT")
	-- scene.camFps.transform:rotate(90, 10, 0)
	-- scene.camFps.transform:move(-3, 0.7, 1.5)
	scene.camFps:setFov(90)
	-- scene.camFps:setActive()
	scene.cam:setActive()
end

--[0;1]
local function pingpong(length, t)
	local tt = (t%length)*2/length
	if tt>1 then tt = 2-tt end
	return tt
end


function testSceneUpdate(t, dt)
	-- if t>2 and t<10 then scene.camFps:setActive()
	-- else scene.cam:setActive() end
	
	scene.audi:setArgument(0, -1 + 2*(t%4)/4.0);--башня крутится
	scene.audi:setArgument(8, t%1);--колеса крутятся----------------------
	scene.audi2:setArgument(0, -0.1 + 0.2*pingpong(3,t));--башня крутится
	scene.audi2:setArgument(8, t%1);----------------------
	-- scene.audi:setArgument(9, pingpong(2,t)*2-1);	--поворот
	-- scene.audi2:setArgument(9, pingpong(2,t)*2-1);
	-- scene.audi2:setArgument(21, pingpong(2,t+0.5)*2-1);
	-- scene.audi2:setArgument(22, pingpong(3,t+1)*2-1);
	-- scene.audi2:setArgument(23, pingpong(2,t)*2-1);	
	
	scene.m:setArgument(0, pingpong(3.5,t));
	scene.m:setArgument(3, pingpong(3,t));
	scene.m:setArgument(5, pingpong(3,t));
	-- scene.m.transform:setOrient(0,math.sin(t)*45,0);
	
	tt = t*2;
	radius = 10;
	scene.audi2.transform:setOrient(0, tt*100, 0)
	scene.audi2.transform:setPosition(radius*math.sin(tt), 0, radius*math.cos(tt));
	
	scene.audi.transform:setPosition(radius*math.sin(t)*0.8, 5, radius*math.cos(t)*0.8);
	
	-- scene.gui.transform:setOrient(0, tt*100, 0)
	-- scene.L1.transform:setPosition(0,10+0.5*math.sin(t*2)*20,0);
	-- scene.L1.transform:setPosition(0,5, 5+0.5*math.sin(t*2)*10);
	
	-- scene.audi.transform:setPosition(0, 0, t*1);
	-- scene.L1.transform:setPosition(0, 0, t*1);
	
	-- scene.audi.transform:move(0, math.sin(t*3)*0.15, 0);
	-- scene.audi.transform:move(0.01,0,0)
	-- scene.L1.transform:move(0.01,0,0)
	-- scene.L1.transform:move(math.sin(t*3)*0.15, 0, 0);
	scene.L2:setRadius(10+pingpong(2,t)*40);------------------------
	
	-- scene.L1:setAmount(0.5+0.5*math.sin(t*4));
	scene.L2:setAmount(0.75+0.25*math.sin(t*3));------------------------
	
	-- scene.L1.transform:setPosition(radius*math.sin(tt), 5, radius*math.cos(tt));
	
	scene.audi.transform:lookAtObject(scene.audi2)
	-- scene.spot.transform:lookAtObject(scene.audi)
	
	-- scene.cam.transform:setPosition(15*math.sin(t), 5, 15*math.cos(t))
	-- scene.cam.transform:lookAtObject(scene.L1)	------------------------
	-- scene.cam:setFov(60+20*math.cos(t))	
end



