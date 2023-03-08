 
local DbOption			= require('Options.DbOption')
local log 				= require("log")
 
local Name = DbOption.Item

local function loadMonitorProfiles(folder, values)
	for fileName in lfs.dir(folder) do
		if '.lua' == string.sub(fileName, -4) then
			local func, err = loadfile(folder .. '/' .. fileName)
			
			if func then
				local env = {screen = {width = 1, height = 1, aspect = 1}, math = math }
		
				setfenv(func, env)
				local ok, err = pcall(func)
				if ok then
					local name = i18n.ptranslate(env.name)
					local value = string.lower(string.sub(fileName, 1, -5))
					table.insert(values, Name(name):Value(value))
				else
					log.error(err)
				end	
			else
				log.error(err)
			end
		end	
	end
end

local function getMultiMonitorSetupValues()
	local values = {}
		
	loadMonitorProfiles('Config/MonitorSetup/', values)
	loadMonitorProfiles(lfs.writedir() .. 'Config/MonitorSetup/', values)
	
	return values
end

return {
	getMultiMonitorSetupValues	= getMultiMonitorSetupValues,
}