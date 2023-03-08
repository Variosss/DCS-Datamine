local Factory = require('Factory')

local function staticName()
	return 'Widget'
end

local function checkboxName()
	return 'Checkbox'
end

local function radioName()
	return 'RadioButton'
end

local function sliderName()
	return 'Slider'
end

local function comboName()
	return 'ComboList'
end

local function editboxName()
	return 'EditBox'
end

local function labelName()
	return 'Label'
end

local function widgetName()
	return 'Widget'
end
-- использование:
-- combo({	Item('Name 1'):Value(0),
--			Item('Name 2'):Value(1):OnlyArch64(),
--			...			
--})

local function OnlyArch64(self)
	self.onlyArch64 = true
		
	return self
end

local function Item(name)
	return {
		name = name,
		
		Value = function(self, value)
			self.value = value
		
			return self
		end,
		
		OnlyArch64 = OnlyArch64,
	}
end

-- использование:
-- slider(Range(-30, 0):Mute(-100):OnlyArch64())
--})
local function Range(min, max)
	return {
		min = min,
		max = max,
		
		Mute = function(self, mute)
			self.mute = mute
		
			return self
		end,
		
		OnlyArch64 = OnlyArch64,	
	}
end

local function construct(self, value)
	self.value = value
end

local function setValue(self, value)
	self.value = value
	return self
end


local function enabledSim(self)
	self.enabledSim = true
	return self
end

local function setRelations(self, tbl)
	self.relations = tbl
	return self
end

local function setEnforceable(self)
	self.enforceable = true
	
	return self
end

local function checkbox(self, values)
	self.values = values or {Item():Value(false), Item():Value(true)}
	self.control = checkboxName()
	
	return self
end

local function radio(self, values)
	self.values = values
	self.control = radioName()
	
	return self
end

-- FIXME: mute - значение для ползунков в настройке звука
-- должно находиться в me_sound.
local function slider(self, range)
	self.values = {range}
	self.control = sliderName()
	
	return self	
end

local function combo(self, values)
	self.values = values
	self.control = comboName()
	
	return self
end

local function editbox(self, values)
	self.values = values
	self.control = editboxName()
	
	return self
end

local function low(self, lowValue)
	self.lowValue = lowValue
	
	return self
end

local function medium(self, mediumValue)
	self.mediumValue = mediumValue
	
	return self
end

local function high(self, highValue)
	self.highValue = highValue
	
	return self
end

local function VR(self, VRValue)
	self.VRValue = VRValue
	
	return self
end

local function callback(self, callback)
	-- функция вида 
	
	-- function fun(value)
		-- ...
	-- end
	
	-- вызывается при взаимодействии пользователя с виджетом
	self.callback = callback
	
	return self	
end

return Factory.createClass({
	construct		= construct,
	setValue		= setValue,
	setEnforceable	= setEnforceable,
	enabledSim		= enabledSim,
	setRelations	= setRelations,
	setValues		= setValues,
	checkbox		= checkbox,
	radio			= radio,
	slider			= slider,
	combo			= combo,
	editbox			= editbox,
	low				= low,
	medium			= medium,
	high			= high,
	VR				= VR,
	callback		= callback,
	staticName		= staticName,
	checkboxName	= checkboxName,
	radioName		= radioName,
	sliderName		= sliderName,
	comboName		= comboName,
	editboxName		= editboxName,
	labelName		= labelName,
	widgetName		= widgetName,
	Item			= Item,
	Range			= Range,
})
