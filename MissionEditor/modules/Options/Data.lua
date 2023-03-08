local TableUtils	= require('TableUtils')
local ConfigHelper	= require('ConfigHelper')
local Serializer	= require('Serializer')
local PluginsInfo	= require('Options.PluginsInfo')
local i18n			= require('i18n')
local log      		= require('log')
local lfs 			= require('lfs')
local ProductType 	= require('me_ProductType') 
local U             = require('me_utilities')

local optionsDatabase_
local pluginsDb_
local savedOptions_ = {}
local options_ = {}
local difficulty_ = {}
local graphics_ = {}
local viewsCockpit_ = {}
local sound_ = {}
local miscellaneous_ = {}
local plugins_ = {}
local forced_ = {}
local VR_ = {}
local graphicsEnabled_ = {}
local customPresets_ = {}
local oldLang = nil
local newLang = nil

local controller_

local function setController(controller)
	controller_ = controller
end

local function isController()
	return controller_ ~= nil
end

local function loadOptionsFromFile(filename, noError)
	local options
	local func, err = loadfile(filename)
    
	if func then
		local env = {}
		setfenv(func, env)
		local ok, res = pcall(func)
		if not ok then
			log.error('ERROR: loadOptionsFromFile() failed to pcall "'..filename..'": '..res)
			return
		end
		
		options = env.options
	else
		if noError ~= true then
			print(err)
		end
	end
	
	return options
end

local function createOptionsFromDb(dbOptions)
	local options = {}
	
	for name, dbValue in pairs(dbOptions) do
		options[name] = dbValue.value
	end

	return options
end

local function getDbOptions()
	return {
		format = 1,
		difficulty = createOptionsFromDb(optionsDatabase_.difficulty),
		graphics = createOptionsFromDb(optionsDatabase_.graphics),
		views = {cockpit = createOptionsFromDb(optionsDatabase_.views.cockpit)},
		sound = createOptionsFromDb(optionsDatabase_.sound),
		miscellaneous = createOptionsFromDb(optionsDatabase_.miscellaneous),
        VR = createOptionsFromDb(optionsDatabase_.VR),
	}
end


local function loadUserOptions()
	options_ = getDbOptions()

	local userOptionsAttr = lfs.attributes(lfs.writedir() .. 'Config/options.lua')
	local defaultOptions = loadOptionsFromFile( './MissionEditor/data/scripts/options.lua')
	
	local userOptions = loadOptionsFromFile(ConfigHelper.getConfigReadPath('options.lua'))	
		
	if userOptions then
		local pluginsCopy_ = TableUtils.copyTable(nil, userOptions.plugins)
		
		options_ = TableUtils.mergeTablesOptions(options_, defaultOptions, true)
		
		if not userOptions.format then
			userOptions.sound = {} -- reset old sound options
		end

		options_ = TableUtils.mergeTablesOptions(options_, userOptions)
		options_.plugins = pluginsCopy_			
	end
	
	local product_options = loadOptionsFromFile('./Config/product_options.lua', true)	
	if product_options and lfs.attributes(ConfigHelper.getConfigWritePath('options.lua')) == nil then
		options_ = TableUtils.mergeTablesOptions(options_, product_options)
	end	

	
	local w
	local h
	if  Gui and  Gui.GetPrimaryMonitorSize  then 
		w,h = Gui.GetPrimaryMonitorSize()
	end
	if userOptionsAttr == nil then
		options_.graphics.width  = w  or 1280
		options_.graphics.height = h  or 768
		options_.graphics.aspect = options_.graphics.width / options_.graphics.height
	end		
    
	savedOptions_ = TableUtils.copyTable(nil, options_)
	
	difficulty_			= options_.difficulty
	graphics_			= options_.graphics
	viewsCockpit_		= options_.views.cockpit
	sound_				= options_.sound
	miscellaneous_		= options_.miscellaneous

	options_.plugins	= options_.plugins or {}
	options_.VR 		= options_.VR or {}
	plugins_			= options_.plugins
	VR_					= options_.VR
end

local function loadPluginsDb()
	pluginsDb_ = {}
    local tblPluginsOptions = {}
	for i, pluginInfo in ipairs(PluginsInfo.getOptionsInfo()) do
		--made plugin location explicitly avilable for options
		modulelocation = pluginInfo.moduleLocation
		local filename = pluginInfo.optionsFolder .. '/' .. 'optionsDb.lua'
		local func, err = loadfile(filename)
		
		if func then
			local ok, res = pcall(func)
			if not ok then
				log.error('ERROR: loadPluginsDb() failed to pcall "'..filename..'": '..res)
			else
				pluginsDb_[pluginInfo.id] = res
			end		
		else
			print('````````````', err)
		end
        
        tblPluginsOptions[pluginInfo.id] = {}
		if pluginsDb_[pluginInfo.id] then
			for k,v in pairs(pluginsDb_[pluginInfo.id]) do
				if 	type(v) == 'table' then
					tblPluginsOptions[pluginInfo.id][k] = v.value
				end
			end
		end
	end

    if options_.plugins and next(options_.plugins) then
        options_.plugins = TableUtils.mergeTablesOptions(tblPluginsOptions, options_.plugins)
    else
        options_.plugins = tblPluginsOptions
    end   
       
    plugins_ = options_.plugins
end

local function loadOptionsDb(videoModes)
	local func, err = loadfile('./MissionEditor/modules/Options/optionsDb.lua')
	
	if func then
		return func(videoModes or {})
	else
		print(err)
	end
end

local function load(videoModes)
	optionsDatabase_ = loadOptionsDb(videoModes)
	
	loadUserOptions()
end

local function saveChanges()
	if options_ then
		local file, err = io.open(ConfigHelper.getConfigWritePath('options.lua'), 'w')
		if file then
			local s = Serializer.new(file)

			s:serialize_sorted('options', options_)
			
			file:close()
		else
			print(err)
		end
		
		if controller_ then
			controller_.optionsSaved()
		end	
		
		savedOptions_ = TableUtils.copyTable(nil, options_)
	end
	
	-- сохраняем выбранный язык в файл 
	if newLang then
		local file = io.open(lfs.writedir().."Config/lang.cfg", "w")
		if file then
			curLang = file:write(newLang)
			file:close()
		end
	end	
end

local function undoChanges()
	if options_ then	
		local tmpOptionsVR = options_.VR or {}		
		loadUserOptions()
		options_.VR = tmpOptionsVR
		VR_			= tmpOptionsVR

		if controller_ then
			controller_.optionsRestored()
		end	
	end
end

local function getDifficulty(name)
	local result = difficulty_[name]
	
	if nil == result then
		result = optionsDatabase_.difficulty[name].value
	end
	
	return result
end

local function setDifficulty(name, value)
	difficulty_[name] = value
	
	if controller_ then
		controller_.difficultyChanged(name)
	end	
end

local function getDifficultyValues(name)
	return TableUtils.copyTable(nil, optionsDatabase_.difficulty[name].values)
end

local function getDifficultyChanged(name)
	return difficulty_[name] ~= savedOptions_.difficulty[name]
end

local function getDifficultyDb()
	return TableUtils.copyTable(nil, optionsDatabase_.difficulty)
end

local function setPreset(setFunc, dbTable, presetName)
	local valueName = presetName .. 'Value'
	for name, dbValue in pairs(dbTable) do
		if nil ~= dbValue[valueName] then
			setFunc(name, dbValue[valueName])					
		end	
	end
	
	if controller_ then
		controller_.updateRelationsGraphics()
	end
end

local function setDifficultyLow()
	setPreset(setDifficulty, optionsDatabase_.difficulty, 'low')
end
	
local function setDifficultyMedium()
	setPreset(setDifficulty, optionsDatabase_.difficulty, 'medium')
end
	
local function setDifficultyHigh()
	setPreset(setDifficulty, optionsDatabase_.difficulty, 'high')
end

local function setDifficultyVR()
	setPreset(setDifficulty, optionsDatabase_.difficulty, 'VR')
end

local function getUnits()
	return getDifficulty('units')
end

local function setUnits(a_value)
	return setDifficulty('units', a_value)
end

local function getIconsTheme()
	return getDifficulty('iconsTheme')
end

local function getGraphics(name)
	local result = graphics_[name]
	if nil == result then
		result = optionsDatabase_.graphics[name].value
	end
	
	return result
end

local function relationsGraphics(name)
	if optionsDatabase_.graphics[name] then
		return optionsDatabase_.graphics[name].relations
	end
	return nil
end

local function setGraphics(name, value)
	graphics_[name] = value
	
	if controller_ then
		controller_.graphicsChanged(name)
	end	
end

local function setEnabledGraphics(name,value)
	graphicsEnabled_[name] = value
end

local function getGraphicsValues(name)
	return TableUtils.copyTable(nil, optionsDatabase_.graphics[name].values)
end

local function getEnabledGraphics(name)
	if graphicsEnabled_[name] ~= nil then
		return graphicsEnabled_[name]
	end
	return true
end

local function getGraphicsChanged(name)
	return graphics_[name] ~= savedOptions_.graphics[name]
end

local function getGraphicsDb()
	return TableUtils.copyTable(nil, optionsDatabase_.graphics)
end

local function setGraphicsLow()
	setPreset(setGraphics, optionsDatabase_.graphics, 'low')
end
	
local function setGraphicsMedium()
	setPreset(setGraphics, optionsDatabase_.graphics, 'medium')
end
	
local function setGraphicsHigh()
	setPreset(setGraphics, optionsDatabase_.graphics, 'high')
end	

local function setGraphicsVR()
    setPreset(setGraphics, optionsDatabase_.graphics, 'VR')
end

local function setViewsCockpit(name, value)
	viewsCockpit_[name] = value
	if controller_ then
		controller_.viewsCockpitChanged(name)
	end	
end

local function getViewsCockpitValues(name)
	return TableUtils.copyTable(nil, optionsDatabase_.views.cockpit[name].values)
end

local function getViewsCockpitChanged(name)
	return viewsCockpit_[name] ~= savedOptions_.views.cockpit[name]
end

local function savePreset(a_name)
	if options_ then
		local file, err = io.open(lfs.writedir().."Config\\OptionsPresets\\"..a_name, 'w')
		if file then
			local s = Serializer.new(file)

			s:serialize_sorted('preset', { graphics = options_.graphics, views={cockpit = {avionics = options_.views.cockpit.avionics}}})
			
			file:close()
		else
			print(err)
		end
	end
end

local function loadPreset(a_name)
	if options_ and options_.graphics then
		local func, err = loadfile(lfs.writedir().."Config\\OptionsPresets\\"..a_name)

		if func then
			local env = {}
			setfenv(func, env)	
			local ok, err2 = pcall(func)
			if ok then
				for name,value in pairs(options_.graphics) do
					if env.preset and env.preset.graphics[name] ~= nil then
						setGraphics(name, env.preset.graphics[name])					
					end
				end
				
				if controller_ then
					controller_.updateRelationsGraphics()
				end
				
				if env.preset and env.preset.views and env.preset.views.cockpit then
					setViewsCockpit("avionics", env.preset.views.cockpit.avionics)
				end
			else
				print("ERROR pcall: ", err2, a_name)
			end
		else
			print(err)
		end
	end
end

function isCustomPreset(a_name)
	local a = lfs.attributes(lfs.writedir().."Config\\OptionsPresets\\"..a_name)
	return a ~= nil
end

local function isGraphicsCustom1()
	return isCustomPreset("Custom1.lua")
end

local function isGraphicsCustom2()
	return isCustomPreset("Custom2.lua")
end

local function isGraphicsCustom3()
	return isCustomPreset("Custom3.lua")
end

local function setGraphicsCustom1()
	loadPreset("Custom1.lua")
end

local function setGraphicsCustom2()
	loadPreset("Custom2.lua")
end

local function setGraphicsCustom3()
	loadPreset("Custom3.lua")
end

local function saveGraphicsCustom1()
	savePreset("Custom1.lua")
end

local function saveGraphicsCustom2()
	savePreset("Custom2.lua")
end

local function saveGraphicsCustom3()
	savePreset("Custom3.lua")
end

local function getViewsCockpit(name)
	local result = viewsCockpit_[name]
	
	if nil == result then
		result = optionsDatabase_.views.cockpit[name].value
	end
	
	return result
end

local function setViewsCockpitLow()
	setPreset(setViewsCockpit, optionsDatabase_.views.cockpit, 'low')
end
	
local function setViewsCockpitMedium()
	setPreset(setViewsCockpit, optionsDatabase_.views.cockpit, 'medium')
end
	
local function setViewsCockpitHigh()
	setPreset(setViewsCockpit, optionsDatabase_.views.cockpit, 'high')
end	

local function setViewsCockpitVR()
    setPreset(setViewsCockpit, optionsDatabase_.views.cockpit, 'VR')
end

local function getViewsCockpitDb()
	return TableUtils.copyTable(nil, optionsDatabase_.views.cockpit)
end

local function getSound(name)
	local result = sound_[name]
	
	if nil == result then
		result = optionsDatabase_.sound[name].value
	end
	
	return result
end

local function setSound(name, value)
	local tmpOldValue = sound_[name]
	sound_[name] = value

	if controller_ and tmpOldValue ~= value then
		controller_.soundChanged(name)
	end	
end

local function setSoundValues(name, values)
	optionsDatabase_.sound[name].values = values
end

local function getSoundValues(name)
	return TableUtils.copyTable(nil, optionsDatabase_.sound[name].values)
end

local function getSoundChanged(name)
	return sound_[name] ~= savedOptions_.sound[name]
end

local function getSoundDb()
	return TableUtils.copyTable(nil, optionsDatabase_.sound)
end

local function getMiscellaneous(name)
	local result = miscellaneous_[name]
	
	if nil == result then
		result = optionsDatabase_.miscellaneous[name].value
	end
	
	return result
end

local function setMiscellaneous(name, value)
	miscellaneous_[name] = value
	
	if controller_ then
		controller_.miscellaneousChanged(name)
	end	
end

local function getMiscellaneousValues(name)
	return TableUtils.copyTable(nil, optionsDatabase_.miscellaneous[name].values)
end

local function getMiscellaneousChanged(name)
	return miscellaneous_[name] ~= savedOptions_.miscellaneous[name]
end

local function getMiscellaneousDb(name)
	return TableUtils.copyTable(nil, optionsDatabase_.miscellaneous)
end

local function setLanguage(a_lang)
	if oldLang == nil then
		oldLang = a_lang
		newLang = a_lang
	else
		newLang = a_lang
	end	
end

local function getLanguageChanged()
	return oldLang ~= newLang
end

local function getVR(name)
	local result = VR_[name]
	
	if nil == result then
		result = optionsDatabase_.VR[name].value
	end
	
	return result
end

local function setVR(name, value)
	VR_[name] = value
	
	if controller_ then
		controller_.VRChanged(name)
	end	
end

local function getVRValues(name)
	return TableUtils.copyTable(nil, optionsDatabase_.VR[name].values)
end

local function getVRChanged(name)
	return VR_[name] ~= savedOptions_.VR[name]
end

local function getVRDb(name)
	return TableUtils.copyTable(nil, optionsDatabase_.VR)
end

local function getPlugin(pluginId, name)
	local result
	local pluginData = plugins_[pluginId]
	
	if pluginData then
		result = pluginData[name]
	end
	
	if nil == result then
		local pluginDb = pluginsDb_[pluginId]
		
		if pluginDb then	
			result = pluginDb[name].value
		end
	end
	
	return result
end

local function setPlugin(pluginId, name, value)
	local pluginData = plugins_[pluginId]
	if not pluginData then
		pluginData = {}
		plugins_[pluginId] = pluginData
	end	
	
	pluginData[name] = value
	
	if controller_ then
		controller_.pluginChanged(pluginId, name)
	end	
end

local function getPluginValues(pluginId, name)
	return TableUtils.copyTable(nil, pluginsDb_[pluginId][name].values)
end

local function getPluginRelationsFunc(pluginId, name)
	if pluginsDb_[pluginId][name].relations then
		return TableUtils.copyTable(nil, pluginsDb_[pluginId][name].relations)
	else
		return nil
	end
end

local function getPluginChanged(pluginId, name)
	local pluginData = plugins_[pluginId]

	if pluginData then
		local savedValue
		
		if savedOptions_.plugins[pluginId] then
			savedValue = savedOptions_.plugins[pluginId][name]
		end
		
		return pluginData[name] ~= savedValue
	end
end

local function getPluginDb(pluginId)
	if pluginsDb_[pluginId] ~= nil then
		return TableUtils.copyTable(nil, pluginsDb_[pluginId])
	end
	return nil
end

local function setForced(name, value)
	forced_[name] = value

	if controller_ then
		controller_.forcedChanged(name)
	end	
end

local function getForced(name)
	return forced_[name]
end

local function setForcedOptions(options)
	forced_ = TableUtils.copyTable(nil, options)
	
	if controller_ then
		controller_.forcedChanged()
	end	
end

local function getForcedOptions()
	return TableUtils.copyTable(nil, forced_)
end

local function forceTable(optionsTable, dbOptionsTable)	
	for name, dbValue in pairs(dbOptionsTable) do		
		if dbValue.enforceable then
			if nil ~= getForced(name) then
				optionsTable[name] = getForced(name)
			end	
		end
	end
end

local function getOptionsForMission()
	local result = TableUtils.copyTable(nil, options_)
	
	if false == getDifficulty('setGlobal') then
		forceTable(result.difficulty,		optionsDatabase_.difficulty)
		forceTable(result.graphics,			optionsDatabase_.graphics)
		forceTable(result.miscellaneous,	optionsDatabase_.miscellaneous)
	end
	
	return result
end

local function readDifficultyFromFile()
	local userOptionsAttr = lfs.attributes(lfs.writedir() .. 'Config/options.lua')
	
	local defaultOptions = loadOptionsFromFile( './MissionEditor/data/scripts/options.lua')
	
	local userOptions = loadOptionsFromFile(ConfigHelper.getConfigReadPath('options.lua'))	
		
	if userOptions then
		return userOptions.difficulty
	else
		return defaultOptions.difficulty
	end
end

return {
	setController				= setController,
	isController				= isController,

	getLoaded					= getLoaded,
	load						= load,
	loadPluginsDb				= loadPluginsDb,
	saveChanges					= saveChanges,
	undoChanges					= undoChanges,
	
	readDifficultyFromFile		= readDifficultyFromFile,
	getDifficulty				= getDifficulty,
	setDifficulty				= setDifficulty,
	getDifficultyValues			= getDifficultyValues,
	getDifficultyChanged		= getDifficultyChanged,
	getDifficultyDb				= getDifficultyDb,
	setDifficultyLow			= setDifficultyLow,
	setDifficultyMedium			= setDifficultyMedium,
	setDifficultyHigh			= setDifficultyHigh,
	getUnits					= getUnits,
	getIconsTheme				= getIconsTheme,
	
	getGraphics					= getGraphics,
	setGraphics					= setGraphics,
	getGraphicsValues			= getGraphicsValues,
	setEnabledGraphics			= setEnabledGraphics,
	getEnabledGraphics			= getEnabledGraphics,
	getGraphicsChanged			= getGraphicsChanged,
	getGraphicsDb				= getGraphicsDb,
	relationsGraphics			= relationsGraphics,
	setGraphicsLow				= setGraphicsLow,
	setGraphicsMedium			= setGraphicsMedium,
	setGraphicsHigh				= setGraphicsHigh,	
    setGraphicsVR               = setGraphicsVR,
	setGraphicsCustom1          = setGraphicsCustom1,
	setGraphicsCustom2          = setGraphicsCustom2,
	setGraphicsCustom3          = setGraphicsCustom3,
	saveGraphicsCustom1			= saveGraphicsCustom1,
	saveGraphicsCustom2			= saveGraphicsCustom2,
	saveGraphicsCustom3			= saveGraphicsCustom3,
	isGraphicsCustom1			= isGraphicsCustom1,
	isGraphicsCustom2			= isGraphicsCustom2,
	isGraphicsCustom3			= isGraphicsCustom3,

	getViewsCockpit				= getViewsCockpit,
	setViewsCockpit				= setViewsCockpit,
	getViewsCockpitValues		= getViewsCockpitValues,
	getViewsCockpitChanged		= getViewsCockpitChanged,
	getViewsCockpitDb			= getViewsCockpitDb,
	setViewsCockpitLow			= setViewsCockpitLow,
	setViewsCockpitMedium		= setViewsCockpitMedium,
	setViewsCockpitHigh			= setViewsCockpitHigh,	
    setViewsCockpitVR           = setViewsCockpitVR,
	
	getSound					= getSound,
	setSound					= setSound,
	getSoundValues				= getSoundValues,
	setSoundValues				= setSoundValues,
	getSoundChanged				= getSoundChanged,
	getSoundDb					= getSoundDb,
	
	getMiscellaneous			= getMiscellaneous,
	setMiscellaneous			= setMiscellaneous,
	getMiscellaneousValues		= getMiscellaneousValues,
	getMiscellaneousChanged		= getMiscellaneousChanged,
	getMiscellaneousDb			= getMiscellaneousDb,
	
	setLanguage					= setLanguage,
	getLanguageChanged			= getLanguageChanged,
    
    getVR			            = getVR,
	setVR			            = setVR,
	getVRValues		            = getVRValues,
	getVRChanged		        = getVRChanged,
	getVRDb			            = getVRDb,
	
	getPlugin					= getPlugin,
	setPlugin					= setPlugin,
	getPluginValues				= getPluginValues,
	getPluginChanged			= getPluginChanged,
	getPluginDb					= getPluginDb,
	getPluginRelationsFunc		= getPluginRelationsFunc,
	
	setForced					= setForced,
	getForced					= getForced,
	setForcedOptions			= setForcedOptions,
	getForcedOptions			= getForcedOptions,
	
	getOptionsForMission		= getOptionsForMission,
}

