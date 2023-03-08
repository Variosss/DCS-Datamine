local Input			= require('Input')
local textutil		= require('textutil')
local gettext		= require('i_18n')
local i18n 			= require('i18n')

local joystickDeviceTypeName = Input.getJoystickDeviceTypeName()
local joystickThrottleDeviceTypeName = joystickDeviceTypeName .. 'Throttle'

local deviceTypeOrder_ = {
	[Input.getKeyboardDeviceTypeName	()	]	= 1,
	[joystickThrottleDeviceTypeName			]	= 2,
	[joystickDeviceTypeName					]	= 3,
	[Input.getTrackirDeviceTypeName		()	]	= 4,
	[Input.getHeadtrackerDeviceTypeName	()	]	= 5,
	[Input.getCustomDeviceTypeName		()	]	= 6,
	[Input.getMouseDeviceTypeName		()	]	= 7,
	[Input.getUnknownDeviceTypeName		()	]	= 8,
}

local deviceActions_ = {}
local deviceTypeNames_ = {}
local inputEvents_
local deviceSpecificInputEvents_
local backInputEvents_
local deviceIdToNames_ = {}

local function getDeviceTypeName(deviceName)
	local result = deviceTypeNames_[deviceName]

	if not result then
		result = Input.getDeviceTypeName(deviceName)
		
		if result == joystickDeviceTypeName then
			if string.find(result, 'Throttle') or string.find(result, 'throttle') then
				result = joystickThrottleDeviceTypeName
			end
		end
		
		deviceTypeNames_[deviceName] = result
	end

	return result
end

local function compareDeviceType(deviceName1, deviceName2)
	local deviceTypeName1 = getDeviceTypeName(deviceName1)
	local deviceTypeName2 = getDeviceTypeName(deviceName2)
		
	local order1 = deviceTypeOrder_[deviceTypeName1]
	local order2 = deviceTypeOrder_[deviceTypeName2]

	return order1 < order2
end

local function getDevices()
	local devices = Input.getDevices()
	
	table.sort(devices, compareDeviceType)

	return devices
end

local function getInputEnvTable()
	if not envTable_ then
		envTable_ = Input.getEnvTable()
	end

	return envTable_
end

local function getInputEvents()
	if not inputEvents_ then
		local f, err = loadfile('./Scripts/Input/InputEvents.lua') 

		if f then
			-- константы инпута зарегистрированы в таблице, 
			-- которую возвращает функция Input.getEnvTable()
			local env = getInputEnvTable().Events

			env.print = print
			setfenv(f, env)

			inputEvents_ = f()
		else
			print('Cannot load input events!', err)
		end
	end

	return inputEvents_
end

local function getDeviceSpecificInputEvents()
	if not deviceSpecificInputEvents_ then
		local f, err = loadfile('./Scripts/Input/DeviceSpecificInputEvents.lua') 

		if f then
			deviceSpecificInputEvents_ = f()
		else
			print('Cannot load device specific input events!', err)
		end
	end

	return deviceSpecificInputEvents_
end

local function getBackInputEvents()
	if not backInputEvents_ then
		backInputEvents_ = {}
		
		for name, event in pairs(getInputEvents()) do
			if backInputEvents_[event] then
				print('Input event[' .. name .. '] already registered with name [' .. backInputEvents_[event] .. ']')
			else
				backInputEvents_[event] = name
			end
		end
	end
	
	return backInputEvents_
end

local function getKeyNameValid(keyName)
	return nil ~= getInputEvents()[keyName]
end

local function getInputEvent(keyName)
	return getInputEvents()[keyName]
end

local function getDeviceEventName(event)
	local result = getBackInputEvents()[event]
	
	if not result then
		result = 'Unknown:' .. event
	end

	return result
end

local function getKeyBelongToDevice(keyName, deviceName)
	local event = getInputEvent(keyName)
	
	if event then
		return Input.getEventDeviceTypeName(event) == getDeviceTypeName(deviceName)
	end
	
	return false
end

local function getDeviceTemplateName(deviceName)
	-- убираем из имени джойстика CLSID
	return string.gsub(deviceName, '(.*)(%s{.*})', '%1')
end

local function getLocalizedInputEventName(key, deviceName)
	local deviceTemplateName	= getDeviceTemplateName(deviceName)
	local deviceSpecificEvents	= getDeviceSpecificInputEvents()[deviceTemplateName]
	
	if deviceSpecificEvents then
		local deviceSpecificKeyName = deviceSpecificEvents[key]
		
		if deviceSpecificKeyName then
			key = deviceSpecificKeyName
		end
	end
	
	return i18n.ptranslate('key-' .. key, key)
end

local function createComboString(combo, deviceName)
	local result 

	if combo.reformers then
		for i, reformer in ipairs(combo.reformers) do
			if result then
				result = string.format('%s + %s', result, reformer)
			else
				result = reformer
			end
		end
	end

	local localizedKeyName = getLocalizedInputEventName(combo.key, deviceName)

	if result then
		result = string.format('%s + %s', result, localizedKeyName)
	else
		result = localizedKeyName
	end

	return result
end

local function makeDeviceActions(events, deviceName)
	local result = {}

	for i, event in pairs(events) do 
		local name = getDeviceEventName(event, deviceName)
		localizedName = getLocalizedInputEventName(name, deviceName)

		table.insert(result, {event = event, name = name, localizedName = localizedName})
	end

	local compareLocalizedKeyNames = function(key1, key2)
		return textutil.Utf8Compare(key1.localizedName, key2.localizedName)
	end

	table.sort(result, compareLocalizedKeyNames)

	return result
end

local function getDeviceActions(deviceName)
	local result = deviceActions_[deviceName]

	if not result then
		local keys	= Input.getDeviceKeys(deviceName) -- кнопки устройства
		local axes	= Input.getDeviceAxes(deviceName) -- оси устройства

		result = {	keys = makeDeviceActions(keys, deviceName), 
					axes = makeDeviceActions(axes, deviceName)}

		deviceActions_[deviceName] = result
	end

	return result
end

local function getDeviceKeys(deviceName)
	return getDeviceActions(deviceName).keys
end

local function getDeviceAxes(deviceName)
	return getDeviceActions(deviceName).axes
end

local function getModifiersKeyTable(deviceName, profileModifiers)
	local result = {}

	for modifierName, modifier in pairs(profileModifiers) do
		if modifier.deviceName == deviceName then
			result[modifier.key] = true
		end
	end

	return result
end

local function getDeviceKeysNoModifiers(deviceName, profileModifiers)
	local result = {}
	local deviceKeys = getDeviceKeys(deviceName)
	local modifiersToSkip = getModifiersKeyTable(deviceName, profileModifiers)

	for i, deviceKey in ipairs(deviceKeys) do 
		if not modifiersToSkip[deviceKey.name] then
			table.insert(result, deviceKey)
		end
	end

	return result
end

local joystickOffButtons = {
	[getInputEvent('JOY_BTN1_OFF')] = true,
	[getInputEvent('JOY_BTN2_OFF')] = true,
	[getInputEvent('JOY_BTN3_OFF')] = true,
	[getInputEvent('JOY_BTN4_OFF')] = true,
	[getInputEvent('JOY_BTN5_OFF')] = true,
	[getInputEvent('JOY_BTN6_OFF')] = true,
	[getInputEvent('JOY_BTN7_OFF')] = true,
	[getInputEvent('JOY_BTN8_OFF')] = true,
	[getInputEvent('JOY_BTN9_OFF')] = true,
	[getInputEvent('JOY_BTN10_OFF')] = true,
	[getInputEvent('JOY_BTN11_OFF')] = true,
	[getInputEvent('JOY_BTN12_OFF')] = true,
	[getInputEvent('JOY_BTN13_OFF')] = true,
	[getInputEvent('JOY_BTN14_OFF')] = true,
	[getInputEvent('JOY_BTN15_OFF')] = true,
	[getInputEvent('JOY_BTN16_OFF')] = true,
	[getInputEvent('JOY_BTN17_OFF')] = true,
	[getInputEvent('JOY_BTN18_OFF')] = true,
	[getInputEvent('JOY_BTN19_OFF')] = true,
	[getInputEvent('JOY_BTN20_OFF')] = true,
	[getInputEvent('JOY_BTN21_OFF')] = true,
	[getInputEvent('JOY_BTN22_OFF')] = true,
	[getInputEvent('JOY_BTN23_OFF')] = true,
	[getInputEvent('JOY_BTN24_OFF')] = true,
	[getInputEvent('JOY_BTN25_OFF')] = true,
	[getInputEvent('JOY_BTN26_OFF')] = true,
	[getInputEvent('JOY_BTN27_OFF')] = true,
	[getInputEvent('JOY_BTN28_OFF')] = true,
	[getInputEvent('JOY_BTN29_OFF')] = true,
	[getInputEvent('JOY_BTN30_OFF')] = true,
	[getInputEvent('JOY_BTN31_OFF')] = true,
	[getInputEvent('JOY_BTN32_OFF')] = true,
	[getInputEvent('JOY_BTN33_OFF')] = true,
	[getInputEvent('JOY_BTN34_OFF')] = true,
	[getInputEvent('JOY_BTN35_OFF')] = true,
	[getInputEvent('JOY_BTN36_OFF')] = true,
	[getInputEvent('JOY_BTN37_OFF')] = true,
	[getInputEvent('JOY_BTN38_OFF')] = true,
	[getInputEvent('JOY_BTN39_OFF')] = true,
	[getInputEvent('JOY_BTN40_OFF')] = true,
	[getInputEvent('JOY_BTN41_OFF')] = true,
	[getInputEvent('JOY_BTN42_OFF')] = true,
	[getInputEvent('JOY_BTN43_OFF')] = true,
	[getInputEvent('JOY_BTN44_OFF')] = true,
	[getInputEvent('JOY_BTN45_OFF')] = true,
	[getInputEvent('JOY_BTN46_OFF')] = true,
	[getInputEvent('JOY_BTN47_OFF')] = true,
	[getInputEvent('JOY_BTN48_OFF')] = true,
	[getInputEvent('JOY_BTN49_OFF')] = true,
	[getInputEvent('JOY_BTN50_OFF')] = true,
	[getInputEvent('JOY_BTN51_OFF')] = true,
	[getInputEvent('JOY_BTN52_OFF')] = true,
	[getInputEvent('JOY_BTN53_OFF')] = true,
	[getInputEvent('JOY_BTN54_OFF')] = true,
	[getInputEvent('JOY_BTN55_OFF')] = true,
	[getInputEvent('JOY_BTN56_OFF')] = true,
	[getInputEvent('JOY_BTN57_OFF')] = true,
	[getInputEvent('JOY_BTN58_OFF')] = true,
	[getInputEvent('JOY_BTN59_OFF')] = true,
	[getInputEvent('JOY_BTN60_OFF')] = true,
	[getInputEvent('JOY_BTN61_OFF')] = true,
	[getInputEvent('JOY_BTN62_OFF')] = true,
	[getInputEvent('JOY_BTN63_OFF')] = true,
	[getInputEvent('JOY_BTN64_OFF')] = true,
	[getInputEvent('JOY_BTN65_OFF')] = true,
	[getInputEvent('JOY_BTN66_OFF')] = true,
	[getInputEvent('JOY_BTN67_OFF')] = true,
	[getInputEvent('JOY_BTN68_OFF')] = true,
	[getInputEvent('JOY_BTN69_OFF')] = true,
	[getInputEvent('JOY_BTN70_OFF')] = true,
	[getInputEvent('JOY_BTN71_OFF')] = true,
	[getInputEvent('JOY_BTN72_OFF')] = true,
	[getInputEvent('JOY_BTN73_OFF')] = true,
	[getInputEvent('JOY_BTN74_OFF')] = true,
	[getInputEvent('JOY_BTN75_OFF')] = true,
	[getInputEvent('JOY_BTN76_OFF')] = true,
	[getInputEvent('JOY_BTN77_OFF')] = true,
	[getInputEvent('JOY_BTN78_OFF')] = true,
	[getInputEvent('JOY_BTN79_OFF')] = true,
	[getInputEvent('JOY_BTN80_OFF')] = true,
	[getInputEvent('JOY_BTN81_OFF')] = true,
	[getInputEvent('JOY_BTN82_OFF')] = true,
	[getInputEvent('JOY_BTN83_OFF')] = true,
	[getInputEvent('JOY_BTN84_OFF')] = true,
	[getInputEvent('JOY_BTN85_OFF')] = true,
	[getInputEvent('JOY_BTN86_OFF')] = true,
	[getInputEvent('JOY_BTN87_OFF')] = true,
	[getInputEvent('JOY_BTN88_OFF')] = true,
	[getInputEvent('JOY_BTN89_OFF')] = true,
	[getInputEvent('JOY_BTN90_OFF')] = true,
	[getInputEvent('JOY_BTN91_OFF')] = true,
	[getInputEvent('JOY_BTN92_OFF')] = true,
	[getInputEvent('JOY_BTN93_OFF')] = true,
	[getInputEvent('JOY_BTN94_OFF')] = true,
	[getInputEvent('JOY_BTN95_OFF')] = true,
	[getInputEvent('JOY_BTN96_OFF')] = true,
	[getInputEvent('JOY_BTN97_OFF')] = true,
	[getInputEvent('JOY_BTN98_OFF')] = true,
	[getInputEvent('JOY_BTN99_OFF')] = true,
	[getInputEvent('JOY_BTN100_OFF')] = true,
	[getInputEvent('JOY_BTN101_OFF')] = true,
	[getInputEvent('JOY_BTN102_OFF')] = true,
	[getInputEvent('JOY_BTN103_OFF')] = true,
	[getInputEvent('JOY_BTN104_OFF')] = true,
	[getInputEvent('JOY_BTN105_OFF')] = true,
	[getInputEvent('JOY_BTN106_OFF')] = true,
	[getInputEvent('JOY_BTN107_OFF')] = true,
	[getInputEvent('JOY_BTN108_OFF')] = true,
	[getInputEvent('JOY_BTN109_OFF')] = true,
	[getInputEvent('JOY_BTN110_OFF')] = true,
	[getInputEvent('JOY_BTN111_OFF')] = true,
	[getInputEvent('JOY_BTN112_OFF')] = true,
	[getInputEvent('JOY_BTN113_OFF')] = true,
	[getInputEvent('JOY_BTN114_OFF')] = true,
	[getInputEvent('JOY_BTN115_OFF')] = true,
	[getInputEvent('JOY_BTN116_OFF')] = true,
	[getInputEvent('JOY_BTN117_OFF')] = true,
	[getInputEvent('JOY_BTN118_OFF')] = true,
	[getInputEvent('JOY_BTN119_OFF')] = true,
	[getInputEvent('JOY_BTN120_OFF')] = true,
	[getInputEvent('JOY_BTN121_OFF')] = true,
	[getInputEvent('JOY_BTN122_OFF')] = true,
	[getInputEvent('JOY_BTN123_OFF')] = true,
	[getInputEvent('JOY_BTN124_OFF')] = true,
	[getInputEvent('JOY_BTN125_OFF')] = true,
	[getInputEvent('JOY_BTN126_OFF')] = true,
	[getInputEvent('JOY_BTN127_OFF')] = true,
	[getInputEvent('JOY_BTN128_OFF')] = true,
}

local deviceEventsToSkip_ = {
	[Input.getMouseDeviceTypeName()] = {
		[getInputEvent('MOUSE_BTN1')]	= true,
		[getInputEvent('MOUSE_BTN2')]	= true,
		[getInputEvent('MOUSE_X')]		= true,
		[getInputEvent('MOUSE_Y')]		= true,
	},
	
	[Input.getKeyboardDeviceTypeName()] = {
		[getInputEvent('SysRQ')] = true,
	},
	
	[Input.getJoystickDeviceTypeName()] = joystickOffButtons,	
}

local function getDeviceEventsToSkip(deviceName)
	local deviceTypeName = getDeviceTypeName(deviceName)
	local result = deviceEventsToSkip_[deviceTypeName]
	
	if not result then
		result = {}
		deviceEventsToSkip_[deviceTypeName] = result
	end

	return result
end

local function getSkipDeviceEvent(keyName, deviceName)
	if 'mouse' == getDeviceTypeName(deviceName) then
		return 	'MOUSE_BTN1'	== keyName or
				'MOUSE_BTN2'	== keyName or
				'MOUSE_X'		== keyName or
				'MOUSE_Y'		== keyName
	end
end

local function getDeviceKeyIsOff(keyName)
	return joystickOffButtons[getInputEvent(keyName)]
end

local function getInputAction(actionName)
	return getInputEnvTable().Actions[actionName]
end

local function getInputActionName(action)
	local actions = getInputEnvTable().Actions

	if not backActions_ then
		backActions_ = {}

		for actionName, actionValue in pairs(actions) do
			if backActions_[actionValue] then
				print('Warning: input action[' .. actionName .. ']=[' .. actionValue .. '] already has name[' .. backActions_[actionValue] .. ']')
			else
				backActions_[actionValue] = actionName
			end
		end
	end

	return backActions_[action]
end

local function localizeInputString(s)
	if s and s ~= '' then 		
		return gettext.dtranslate('input', s) 
	end
	
	return ''
end

local function initializeInput(hwnd)
	Input.initialize(hwnd)
	-- Input.addFakeJoystick("Throttle - HOTAS Warthog")
	-- Input.addFakeJoystick("Saitek Pro Flight Throttle Quadrant")
	-- Input.addFakeJoystick('T.16000M')
end

local function getCommandHash(command, commandActionHashInfos)
	local result = ''
	
	for i, commandActionHashInfo in ipairs(commandActionHashInfos) do
		result = result .. commandActionHashInfo.prefix .. tostring(command[commandActionHashInfo.name])
	end
	
	return	result
end

local keyCommandActionHashInfos_

local function getKeyCommandActionHashInfos()
	if not keyCommandActionHashInfos_ then
		keyCommandActionHashInfos_ = {
			{name = 'down',					prefix = 'd', 	namedAction = true},
			{name = 'pressed',				prefix = 'p', 	namedAction = true},
			{name = 'up',					prefix = 'u', 	namedAction = true},
			{name = 'cockpit_device_id',	prefix = 'cd', 	namedAction = false},
			{name = 'value_down',			prefix = 'vd', 	namedAction = false},
			{name = 'value_pressed',		prefix = 'vp', 	namedAction = false},
			{name = 'value_up',				prefix = 'vu', 	namedAction = false},
		}
	end
	
	return keyCommandActionHashInfos_
end

local function getKeyCommandHash(keyCommand)
	return getCommandHash(keyCommand, getKeyCommandActionHashInfos())
end

local axisCommandActionHashInfos_

local function getAxisCommandActionHashInfos()
	if not axisCommandActionHashInfos_ then
		axisCommandActionHashInfos_ = {
			{name = 'action',				prefix = 'a', 	namedAction = true},
			{name = 'cockpit_device_id',	prefix = 'cd', 	namedAction = false},
		}
	end
	
	return axisCommandActionHashInfos_
end

local function getAxisCommandHash(axisCommand)
	return getCommandHash(axisCommand, getAxisCommandActionHashInfos())
end

local function getComboHash(key, reformers)
	local comboHash
	
	if key then
		comboHash = key
		
		if reformers then
			table.sort(reformers, textutil.Utf8Compare)
			
			for i, reformer in ipairs(reformers) do
				comboHash = string.format('%s%s', comboHash, reformer)
			end
		end
	end
	
	return comboHash
end

local function getDeviceNameById(deviceId)
	local result = deviceIdToNames_[deviceId]
	
	if not result then
		for i, deviceName in ipairs(Input.getDevices()) do
			local id = Input.getDeviceId(deviceName)
			
			deviceIdToNames_[id] = deviceName
			
			if id == deviceId then
				result = deviceName
			end
		end
	end
	
	return result
end

return {
	getDeviceTypeName				= getDeviceTypeName,
	getDevices						= getDevices,
	getKeyNameValid					= getKeyNameValid,
	getInputEvent					= getInputEvent,
	getDeviceEventName				= getDeviceEventName,
	getKeyBelongToDevice			= getKeyBelongToDevice,
	getDeviceKeys					= getDeviceKeys,
	getDeviceAxes					= getDeviceAxes,
	getDeviceKeysNoModifiers		= getDeviceKeysNoModifiers,
	getDeviceEventsToSkip			= getDeviceEventsToSkip,
	getSkipDeviceEvent				= getSkipDeviceEvent,
	getDeviceKeyIsOff				= getDeviceKeyIsOff,
	getInputAction					= getInputAction,
	getInputActionName				= getInputActionName,
	getLocalizedInputEventName		= getLocalizedInputEventName,
	getDeviceTemplateName			= getDeviceTemplateName,
	localizeInputString				= localizeInputString,
	initializeInput					= initializeInput,
	getKeyCommandActionHashInfos	= getKeyCommandActionHashInfos,
	getKeyCommandHash				= getKeyCommandHash,
	getAxisCommandActionHashInfos	= getAxisCommandActionHashInfos,
	getAxisCommandHash				= getAxisCommandHash,
	getComboHash					= getComboHash,
	createComboString				= createComboString, -- used in \Utils\Input\validate_input.lua
	getDeviceNameById				= getDeviceNameById,
}