local function loadCloudsPresets()
	local out    	= {}
	local tmpCfg 	= {}
	local func, err = loadfile('./Config/Effects/clouds.lua')
	
	if func then
		local env = {	type 		 = type,
						next 		 = next, 
						setmetatable = setmetatable,
						getmetatable = getmetatable,
						_ = _,
		}
		setfenv(func, env)
		func()
		tmpCfg = env.clouds and env.clouds.presets
	else
		print(err)
	end

	for id,v in pairs(tmpCfg) do
		if v.visibleInGUI == true then
			out[id] = v
			v.id = id
			local order, tooltip = string.match(v.readableName, '(.+)##(.+)')
			v.order 	 = order   or v.readableName
			v.tooltip 	 = tooltip or v.readableName			
		end
	end
	return out
end

return loadCloudsPresets()