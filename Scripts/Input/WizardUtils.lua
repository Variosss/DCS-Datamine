local InputUtils = require('Input.Utils')
local i18n = require('i18n')

local _ = i18n.ptranslate

local combos_		= {}
local axisValues_	= {}
local cdata 		= {
	clickToStart	= _('CLICK TO START'),			
	pressKey		= _('PRESS KEY...'	),
	moveAxis		= _('MOVE AXIS...'	),
	comboIsEmpty	= _('Combo for command %s is empty!'),
	comboIsEqualTo	= _('Combo command for %s is already in use for %s command!'),
}

local function makeKeyCombo()
	return {
		reformer1		= nil	,
		reformer2		= nil	,
		reformer3		= nil	,
		key				= nil	,
		deviceId		= nil	,
		reformerCounter	= 0		,
	}
end

local function cloneCombo(combo)
	return {
		reformer1		= combo.reformer1	,
		reformer2		= combo.reformer2	,
		reformer3		= combo.reformer3	,
		key				= combo.key			,
		deviceId		= combo.deviceId	,
		reformerCounter = 0					,
	}
end

local function getComboString(combo)
	local result
	
	if combo.reformer1 then
		result = combo.reformer1
	end
	
	if combo.reformer2 then
		result = result .. '+' .. combo.reformer2
	end	
	
	if combo.reformer3 then
		result = result .. '+' .. combo.reformer3
	end	
	
	if combo.key then
		if result then
			result = result .. '+' .. combo.key
		else
			result = combo.key
		end
	end
	
	return result
end

local function getComboReformers(combo)
	local result
	
	if 	combo.reformer1 then
		result = {}
		table.insert(result, combo.reformer1)
	end
	
	if 	combo.reformer2 then
		result = result or {}
		table.insert(result, combo.reformer2)
	end
	
	if 	combo.reformer3 then
		result = result or {}
		table.insert(result, combo.reformer3)
	end
	
	return result
end

local function getComboString(combo)
	local result
	
	if combo.reformer1 then
		result = combo.reformer1
	end
	
	if combo.reformer2 then
		result = result .. '+' .. combo.reformer2
	end	
	
	if combo.reformer3 then
		result = result .. '+' .. combo.reformer3
	end	
	
	if combo.key then
		if result then
			result = result .. '+' .. combo.key
		else
			result = combo.key
		end
	end
	
	return result
end

local function getComboEmpty(combo)
	return not (combo.reformer1	or
				combo.reformer2	or
				combo.reformer3	or
				combo.key)
end

local function getCombosAreEqual(combo1, combo2)
	return	combo1.reformer1	== combo2.reformer1 and
			combo1.reformer2	== combo2.reformer2 and
			combo1.reformer3	== combo2.reformer3 and
			combo1.key      	== combo2.key
end

local function setComboReformerName(combo, name)
	if 	name ~= combo.reformer1 and 
		name ~= combo.reformer2 and 
		name ~= combo.reformer3 then 
		
		combo['reformer' .. (combo.reformerCounter % 3) + 1] = name
		combo.reformerCounter = combo.reformerCounter + 1
	end
end

local function resetCombo(combo)
	combo.reformer1			= nil
	combo.reformer2			= nil
	combo.reformer3			= nil
	combo.key				= nil
	combo.reformerCounter	= 0
end

local function resetCombos()
	combos_ = {}	
end

local function printCombo(combo)
	print('key ' .. tostring(combo.key) .. '\nR1 ' .. tostring(combo.reformer1) .. '\nR2 ' .. tostring(combo.reformer2) .. '\nR3 ' .. tostring(combo.reformer3))
end

local function assignCombos(combos)
	local result = true
	local messages = {}
	
	for newName, newCombo in pairs(combos) do
		combos_[newName] = nil -- удаляем предыдущий биндинг
	end
	
	for newName, newCombo in pairs(combos) do
		if getComboEmpty(newCombo) then
			result	= false
			table.insert(messages, string.format(cdata.comboIsEmpty, newName))
		else
			for name, combo in pairs(combos_) do				
				if getCombosAreEqual(combo, newCombo) then
					result	= false
					table.insert(messages, string.format(cdata.comboIsEqualTo, newName, name))
				end
			end
			
			if result then
				combos_[newName] = cloneCombo(newCombo)
			end
		end
	end
	
	return result, messages
end

local function getComboCount(combos)
	local result = 0
	
	for name, combo in pairs(combos) do
		result = result + 1
	end
	
	return result
end

local function toggleButtonHandleKey(toggleButton, combo, keyName, deviceId, isModifier)
	if toggleButton:getState() then
		if isModifier then
			setComboReformerName(combo, keyName)
		else
			combo.key		= keyName
			combo.deviceId	= deviceId
		end
		
		toggleButton:setText(getComboString(combo))
		
		if not isModifier then
			toggleButton:setTooltipText(InputUtils.getDeviceTemplateName(InputUtils.getDeviceNameById(deviceId)))
		end	
	end
end

local function toggleButtonHandleAxis(toggleButton, combo, axisName, deviceId, value)
	if toggleButton:getState() then
		local axisValues = axisValues_[axisName] or {min = 0, max = 0}
		
		if value < 0 then
			axisValues.min = math.min(value, axisValues.min)
		else
			axisValues.max = math.max(value, axisValues.max)
		end
		
		if 	axisValues.min < -0.9 and
			axisValues.max >  0.9 then
			
			combo.key		= axisName
			combo.deviceId	= deviceId			
			
			toggleButton:setText(getComboString(combo))
			toggleButton:setTooltipText(InputUtils.getDeviceTemplateName(InputUtils.getDeviceNameById(deviceId)))
			
			axisValues_ = {}
		else
			axisValues_[axisName] = axisValues
		end
	end
end

local function pressToggleButton(toggleButton, combo, text)
	resetCombo(combo)
	
	toggleButton:setText(text)
	toggleButton:setTooltipText()
end

local function releaseToggleButton(toggleButton, combo)
	toggleButton:setState(false)
	
	if getComboEmpty(combo) then
		toggleButton:setText(cdata.clickToStart)		
	else
		toggleButton:setText(getComboString(combo))	
	end
end

local function toggleButtonsSetCallback(toggleButtonKey1, toggleButtonKey2, toggleButtonAxis, comboKey1, comboKey2, comboAxis)
	function toggleButtonKey1:onChange()
		if toggleButtonKey1:getState() then
			pressToggleButton(toggleButtonKey1, comboKey1, cdata.pressKey)	
			releaseToggleButton(toggleButtonKey2, comboKey2)
			releaseToggleButton(toggleButtonAxis, comboAxis)
		else
			releaseToggleButton(toggleButtonKey1, comboKey1)
			axisValues_ = {}
		end
	end
		
	function toggleButtonKey2:onChange()
		if toggleButtonKey2:getState() then
			pressToggleButton(toggleButtonKey2, comboKey2, cdata.pressKey)	
			releaseToggleButton(toggleButtonKey1, comboKey1)
			releaseToggleButton(toggleButtonAxis, comboAxis)
		else
			releaseToggleButton(toggleButtonKey2, comboKey2)
			axisValues_ = {}
		end			
	end
	
	function toggleButtonAxis:onChange()
		if toggleButtonAxis:getState() then
			pressToggleButton(toggleButtonAxis, comboAxis, cdata.moveAxis)	
			releaseToggleButton(toggleButtonKey1, comboKey1)
			releaseToggleButton(toggleButtonKey2, comboKey2)
		else
			releaseToggleButton(toggleButtonAxis, comboAxis)
		end
	end
end

local function toggleButtonReset(toggleButton, combo)
	toggleButton:setText(cdata.clickToStart)
	toggleButton:setTooltipText()
	resetCombo(combo)	
	axisValues_ = {}
end

return {
	makeKeyCombo				= makeKeyCombo				,
	getComboString				= getComboString			,
	getComboReformers			= getComboReformers			,
	getComboEmpty				= getComboEmpty				,
	setComboReformerName 		= setComboReformerName		,
	resetCombo					= resetCombo				,
	resetCombos					= resetCombos				,
	assignCombos				= assignCombos				,
	getComboCount				= getComboCount				,
	toggleButtonHandleKey		= toggleButtonHandleKey		,
	toggleButtonHandleAxis		= toggleButtonHandleAxis	,
	toggleButtonsSetCallback	= toggleButtonsSetCallback	,
	toggleButtonReset			= toggleButtonReset			,
}