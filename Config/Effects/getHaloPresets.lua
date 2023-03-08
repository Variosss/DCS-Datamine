local function loadHaloPresets()
	local out    	= {}
	local tmpIceCfg 	= {}
	local tmpCrystalsCfg 	= {}
	local func, err = loadfile('./Config/Effects/icehalo.lua')
	
	if func then
		local env = {	type 		 = type,
						next 		 = next, 
						setmetatable = setmetatable,
						getmetatable = getmetatable,
						_ = _,
		}
		setfenv(func, env)
		func()
		tmpIceCfg = env.icehalo and env.icehalo.presets
		tmpCrystalsCfg = env.icehalo and env.icehalo.crystalsPresets
		
	else
		print(err)
	end
	
	out.presets = {}
	for id,v in pairs(tmpIceCfg) do
		if v.visibleInGUI == true then
			out.presets[id] = v
			v.id = id
			local order, tooltip = string.match(v.readableName, '(.+)##(.+)')
			v.order 	 = order   or v.readableName
			v.tooltip 	 = tooltip or v.readableName			
		end
	end
	
	out.crystalsPresets = {}
	for id,v in pairs(tmpCrystalsCfg) do
		if v.visibleInGUI == true then
			out.crystalsPresets[id] = v
			v.id = id
			local order, tooltip = string.match(v.readableName, '(.+)##(.+)')
			v.order 	 = order   or v.readableName
			v.tooltip 	 = tooltip or v.readableName			
		end
	end
	
	return out
end

return loadHaloPresets()