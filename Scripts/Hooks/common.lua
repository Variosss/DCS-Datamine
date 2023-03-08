local net               = require('net')

function onNetMissionEnd() 
	if DCS.isServer() == true then
		net.load_next_mission() 
	end
end 

local hooks = {}
hooks.onNetMissionEnd = onNetMissionEnd
DCS.setUserCallbacks(hooks)