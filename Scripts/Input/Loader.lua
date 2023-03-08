local InputData 			= require('Input.Data')
local ProfileDatabase 		= require('Input.ProfileDatabase')
local InputUtils 			= require('Input.Utils')
local Input 				= require('Input')

local layerProfileInfos_ = {}

local function setLayerProfileInfo(layerName, profileInfo)
	layerProfileInfos_[layerName] = profileInfo
end

local function getLayerProfileInfo(layerName)
	return layerProfileInfos_[layerName]
end

local function getComboReformers(comboReformerNames, modifiers)
	local reformers
	
	if comboReformerNames then
		reformers = {}
		
		for i, comboReformerName in ipairs(comboReformerNames) do
			local modifier = modifiers[comboReformerName]
			
			if modifier then
				table.insert(reformers, {key = modifier.event, deviceId = modifier.deviceId})
			end	
		end
	end
	
	return reformers
end

local function addKeyCommand(command, layerName, modifiers)
	for deviceName, deviceCombos in pairs(command.combos) do
		local deviceId = Input.getDeviceId(deviceName)
		
		for j, combo in ipairs(deviceCombos) do
			if combo.valid then
				local keyEvent	= InputUtils.getInputEvent(combo.key)
				local reformers	= getComboReformers(combo.reformers, modifiers)
				
				Input.addKeyCombo(	layerName,
									keyEvent,
									deviceId,
									reformers,
									command.down,
									command.pressed, 
									command.up, 
									command.cockpit_device_id,
									command.value_down, 
									command.value_pressed,
									command.value_up)
			end
		end
	end
end

local function addKeyCommands(profileName, layerName, modifiers)
	local keyCommands = InputData.getProfileKeyCommands(profileName)
	
	for i, command in ipairs(keyCommands) do
		addKeyCommand(command, layerName, modifiers)
	end
end

local function addAxisCommands(profileName, layerName, modifiers)
	local axisCommands = InputData.getProfileAxisCommands(profileName)
	
	for i, command in ipairs(axisCommands) do
		for deviceName, deviceCombos in pairs(command.combos) do
			local deviceId = Input.getDeviceId(deviceName)
			
			for i, combo in ipairs(deviceCombos) do
				if combo.valid then
					local axis = combo.key
					local axisEvent = InputUtils.getInputEvent(axis)
					local reformers = getComboReformers(combo.reformers, modifiers)
					
					Input.addAxisCombo(	layerName, 
										axisEvent, 
										deviceId,
										reformers, 
										command.action,
										combo.filter,
										command.cockpit_device_id)
				end
			end
		end
	end
end

local function addModifiers(layerName, modifiers)
	for name, modifier in pairs(modifiers) do
		Input.addReformer(layerName, modifier.event, modifier.deviceId, modifier.switch)
	end	
end

local function addForceFeedback(profileName, layerName)
	local deviceNames = InputUtils.getDevices()
	
	for i, deviceName in ipairs(deviceNames) do
		local ffSettings = InputData.getProfileForceFeedbackSettings(profileName, deviceName)
		
		if ffSettings then
			Input.setForceFeedback(	layerName, 
									deviceName,
									ffSettings.trimmer, 
									ffSettings.shake,
									ffSettings.swapAxes,
									ffSettings.invertX,
									ffSettings.invertY,
									ffSettings.ignore)
		end
	end	
end

local function createInputLayer(profileInfo)
	local profileName = profileInfo.name
	local layerName = profileInfo.layerName
	
	Input.deleteLayer(layerName)
	Input.createLayer(layerName)
	
	local modifiers = InputData.getProfileModifiers(profileName)
	
	addModifiers(layerName, modifiers)
	addKeyCommands(profileName, layerName, modifiers)
	addAxisCommands(profileName, layerName, modifiers)
	addForceFeedback(profileName, layerName)
	
	setLayerProfileInfo(layerName, profileInfo)
end

local function createUnitLayer(unitName, pluginPath)
	-- вызывается из симулятора
	local profileInfo = ProfileDatabase.createUnitProfileInfo(unitName, pluginPath or '')
	
	InputData.createProfile(profileInfo)
	createInputLayer(profileInfo)
end

local function loadProfiles(profileInfos)
	for i, profileInfo in ipairs(profileInfos) do
		InputData.createProfile(profileInfo)
		createInputLayer(profileInfo)
	end
end 

local function addDebugCommands()
	-- these commands won't work in final version!!!
	-- iCommand* values not loaded yet here!
	local commands = {
		{combos = {{key = 'X', reformers = {'LShift', 'LCtrl'}}}, name = 'Explosion', down = 27, up = 27, value_down = 1.0, value_up = 0.0}, -- iCommandViewExplosion
		{combos = {{key = 'R', reformers = {'LShift', 'LCtrl'}}}, name = 'Reload Shaders' ,pressed = 1644}, -- iCommandReloadShaders
		{combos = {{key = 'H', reformers = {'LAlt', 'LShift'}}}, name = 'Hover' ,pressed = 959,value_pressed = 1.0},	-- iCommandPlaneLevitation
		{combos = {{key = 'X', reformers = {'LWin'}}}, name = 'Cycle Modal Autopilot' ,pressed = 1680}, -- iCommandModalAutopilotCycle
		{combos = {{key = 'S', reformers = {'LShift', 'LCtrl' , 'LAlt' }}}, name = 'Reload Database' ,down = 849}, -- iCommandReloadTables
		{combos = {{key = 'T', reformers = {'LCtrl' , 'LAlt' }}}, name = 'Teleport' ,down = 1683}, -- iCommandPlaneTeleport
	}
	
	if not commands or #commands < 1 then
		return
	end
	
	local layerName = 'Debug'
	
	Input.createLayer(layerName)
	Input.setTopLayer(layerName)
	
	local modifiers	= {
		['LShift']	= InputData.createModifier('LShift'	, 'Keyboard'),
		['RShift']	= InputData.createModifier('RShift'	, 'Keyboard'),
		['LAlt']	= InputData.createModifier('LAlt'	, 'Keyboard'),
		['RAlt']	= InputData.createModifier('RAlt'	, 'Keyboard'),
		['LCtrl']	= InputData.createModifier('LCtrl'	, 'Keyboard'),
		['RCtrl']	= InputData.createModifier('RCtrl'	, 'Keyboard'),
		['LWin']	= InputData.createModifier('LWin'	, 'Keyboard'),
		['RWin']	= InputData.createModifier('RWin'	, 'Keyboard'),
	}
	
	addModifiers(layerName, modifiers)
	
	local deviceId = Input.getDeviceId('Keyboard')
	
	for i, command in ipairs(commands) do	
		for j, combo in ipairs(command.combos) do
			local keyEvent 	= InputUtils.getInputEvent(combo.key)
			local reformers	= getComboReformers(combo.reformers, modifiers)

			Input.addKeyCombo(layerName,
							  keyEvent,
							  deviceId,
							  reformers,
							  command.down,
							  command.pressed, 
							  command.up, 
							  command.cockpit_device_id,
							  command.value_down, 
							  command.value_pressed,
							  command.value_up)
		end
	end
end

local function reload()
	-- слои для юнитов могли быть добавлены через функцию createUnitLayer()
	local layerStack = Input.getLayerStack()
	local loadedLayers = Input.getLoadedLayers()
	local profileInfos = {}
	
	for i, layerName in ipairs(loadedLayers) do
		local profileInfo = getLayerProfileInfo(layerName)
		
		if profileInfo then
			table.insert(profileInfos, profileInfo)
		end
	end
	
	loadProfiles(profileInfos)
	Input.setLayerStack(layerStack)
end

local function onDeviceChange(deviceName, plugged)
	-- слои для юнитов могли быть добавлены через функцию createUnitLayer()
	local layerStack = Input.getLayerStack()
	local loadedLayers = Input.getLoadedLayers()
	local profileInfos = {}
	
	for i, layerName in ipairs(loadedLayers) do
		local profileInfo = getLayerProfileInfo(layerName)
		
		if profileInfo then
			table.insert(profileInfos, profileInfo)
		end
	end
	
	for i, profileInfo in ipairs(profileInfos) do
		InputData.unloadProfile(profileInfo.name)
		InputData.createProfile(profileInfo)
		createInputLayer(profileInfo)
	end
	
	Input.setLayerStack(layerStack)
end

local function load(sysConfigPath)
	Input.addDeviceChangeCallback(onDeviceChange)

	local profileInfos 	= ProfileDatabase.createDefaultProfilesSet(sysConfigPath)
	
	loadProfiles(profileInfos)
	
	local top = profileInfos[1]

	Input.setDefaultLayer(top.layerName)
	Input.setDefaultLayerTop()	
	
	addDebugCommands()
end

local function loadUiLayer(sysConfigPath)
	local profileInfo = ProfileDatabase.createUiLayerProfileInfo(sysConfigPath)
	
	InputData.unloadProfile(profileInfo.name)
	InputData.createProfile(profileInfo)
	createInputLayer(profileInfo)
end

local function unload()
	Input.removeDeviceChangeCallback(onDeviceChange)
end

return {
	load			= load,
	reload			= reload,	
	unload			= unload,
	createUnitLayer	= createUnitLayer,
	loadUiLayer		= loadUiLayer,
}