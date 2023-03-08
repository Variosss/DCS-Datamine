local lfs			= require('lfs')
local TableUtils	= require('TableUtils')

local info_

local function getPluginOptionsInfo(plugin)
	if plugin.Options then		
		local pluginOptions = plugin.Options[1]
        local skinFolder    = nil
		if  plugin.Skins    and 
			plugin.Skins[1] then
			skinFolder = plugin.dirName .. '/' .. plugin.Skins[1].dir
		end
		
		return {name 				 = pluginOptions.name,
				id					 = pluginOptions.nameId,
				moduleLocation  	 = plugin.dirName, -- made plugin location explicitly avilable for options
				optionsFolder 		 = plugin.dirName .. '/' .. pluginOptions.dir,
                skinFolder      	 = skinFolder,
				icon				 = pluginOptions.icon,
				AircraftSettingsFile = pluginOptions.AircraftSettingsFile,
				allow_in_simulation  = pluginOptions.allow_in_simulation
		}
	end
end

local function getPluginSkinsInfo(plugin)
	if plugin.Skins then
		local skinsInfo = {}
		
		for i, skin in ipairs(plugin.Skins) do
			local dir = plugin.dirName .. "/" .. skin.dir
			local a = lfs.attributes(dir .. "/ME/")
			
			if a and a.mode == 'directory' then
				local info = {
					index	= i,
					name	= skin.name,
					dir		= dir,
				}
				
				table.insert(skinsInfo, info)
			end
		end
		
		return skinsInfo
	end
end

local function load()
	info_ = nil
	
	if plugins then
		info_ = {}
	
		for i, plugin in ipairs(plugins) do
			if plugin.applied then
				local info = {
					id					= plugin.id,
					dirRoot 			= plugin.dirName,
					version 			= plugin.version,
					state				= plugin.state,
					infoWaitScreen		= plugin.infoWaitScreen,
					options				= getPluginOptionsInfo(plugin),
					skins				= getPluginSkinsInfo(plugin),
				}

				table.insert(info_, info)
			end
		end
	end
end

local function getCount()
	if not info_ then
		load()
	end
	
	return #info
end

local function getInfo(index)
	if not info_ then
		load()
	end
	
	return TableUtils.copyTable(nil, info_[index])
end

local function getOptionsInfo()
	if not info_ then
		load()
	end
	
	local result = {}
	
	for i, info in ipairs(info_) do
		if info.options then
			table.insert(result, TableUtils.copyTable(nil, info.options))
		end
	end
	
	return result
end

local function getSkinsInfo()
	if not info_ then
		load()
	end
	
	local result = {}
	
	for i, info in ipairs(info_) do
		if info.skins then
			table.insert(result, {	id				= info.id,
									dirRoot			= info.dirRoot,
									infoWaitScreen	= info.infoWaitScreen,
									skins			= TableUtils.copyTable(nil, info.skins)
								})
		end
	end
	
	return result
end

return {
	getCount			= getCount,
	getInfo				= getInfo,
	getOptionsInfo		= getOptionsInfo,
	getSkinsInfo		= getSkinsInfo,
}