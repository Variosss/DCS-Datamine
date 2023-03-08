local ListBoxItem = require('ListBoxItem')

local function getArchIs64()
	if START_PARAMS then
		return START_PARAMS.ARCH == '64'
	end
	
	return true
end

local function enableCheckBoxArch64(checkBox, dbValues)
	if dbValues[1].onlyArch64 and not getArchIs64() then
		checkBox:setState(true)
		checkBox:setEnabled(false)
	end
	
	if dbValues[2].onlyArch64 and (not getArchIs64()) then
		checkBox:setState(false)
		checkBox:setEnabled(false)
	end
end

local function enableRadioButtonArch64(radioButton, dbValue)
	if dbValue.onlyArch64 and not getArchIs64() then
		radioButton:setEnabled(false)
	end
end

local function fillComboList(comboList, dbValues, limitation)
	for i, dbValue in ipairs(dbValues) do		
		if not dbValue.onlyArch64 or (dbValue.onlyArch64 and getArchIs64()) then
			if limitation == nil or limitation(i) == false then
				local item = ListBoxItem.new(dbValue.name)
				
				item.value = dbValue.value
				
				comboList:insertItem(item)
			end
		end
	end
end

local function fillSlider(slider, dbValues)
	local range = dbValues[1]
	
	if range.onlyArch64 and not getArchIs64() then
		slider:setEnabled(false)
	end
	
	slider:setRange(range.min, range.max)
end

local function setCheckBoxInputHandler(checkBox, optionName, setFunc, dbValues, getFunc, relationsFunc)
	local function setRelations(a_optionName, a_setFunc, a_relationsFunc, a_value)		
		if a_relationsFunc then			
			relations = a_relationsFunc(a_optionName)
			
			if relations then
				relation = relations[a_value]							
				if relation then
					for k,v in pairs(relation.action) do
						a_setFunc(k, v)
					end
				end
			end	
		end
	end
	
	checkBox.updateReations = function(self)
		if relationsFunc and relationsFunc(optionName) then
			setRelations(optionName, setFunc, relationsFunc, getFunc(optionName))
		end
	end
	
	function checkBox:onChange()
		if self:getState() then
			setFunc(optionName, dbValues[2].value)
			setRelations(optionName, setFunc, relationsFunc, dbValues[2].value)
		else
			setFunc(optionName, dbValues[1].value)
			setRelations(optionName, setFunc, relationsFunc, dbValues[1].value)
		end		
	end
	
	if relationsFunc then
		setRelations(optionName, setFunc, relationsFunc, getFunc(optionName))
	end
end

local function setRadioButtonInputHandler(radioButton, optionName, setFunc, dbValue)
	function radioButton:onChange()
		setFunc(optionName, dbValue.value)
	end	
end

local function setComboListInputHandler(comboList, optionName, getFunc, setFunc, relationsFunc, container, getEnabledFunc, setEnabledFunc)
	local function setRelations(a_optionName, a_setFunc, a_relationsFunc, a_container, a_value, a_isSim)
		if a_relationsFunc then
			relations = a_relationsFunc(a_optionName)
			if relations then
				relation = relations[a_value]
				
				for k,v in pairs(relation.enabled) do
					if a_container[k.."ComboList"] then
						if a_isSim ~= true or (a_isSim == true and v == false) then
							a_container[k.."ComboList"]:setEnabled(v)
							setEnabledFunc(k,v)
						end
					elseif a_container[k.."Slider"] then
						if a_isSim ~= true or (a_isSim == true and v == false) then
							a_container[k.."Slider"]:setEnabled(v)
							setEnabledFunc(k,v)
						end
					end
				end	
				
				for k,v in pairs(relation.action) do
					a_setFunc(k, v)
				end
			end	
		end
	end
	
	comboList.updateReations = function(self, isSim)
		if relationsFunc and relationsFunc(optionName) then
			local item = self:getSelectedItem()
			setRelations(optionName, setFunc, relationsFunc, container, getFunc(optionName), isSim)
		end
	end
	
	function comboList:onChange(item)
		setFunc(optionName, item.value)
		
		setRelations(optionName, setFunc, relationsFunc, container, item.value)
	end
	
	if relationsFunc then
		setRelations(optionName, setFunc, relationsFunc, container, getFunc(optionName))
	end
end

local function setSliderInputHandler(slider, static, optionName, setFunc)
	function slider:onChange()
		local value = self:getValue()
		
		setFunc(optionName, value)
		
		if static then
			static:setText(value)
		end
	end
end

local function setEditBoxInputHandler(editbox, optionName, setFunc)
	function editbox:onChange()
		local value = self:getText()
		setFunc(optionName, value)		
	end
end

return {
	enableCheckBoxArch64		= enableCheckBoxArch64,
	enableRadioButtonArch64		= enableRadioButtonArch64,
	fillComboList				= fillComboList,
	fillSlider					= fillSlider,
	setCheckBoxInputHandler		= setCheckBoxInputHandler,
	setRadioButtonInputHandler	= setRadioButtonInputHandler,
	setComboListInputHandler	= setComboListInputHandler,
	setSliderInputHandler		= setSliderInputHandler,
    setEditBoxInputHandler      = setEditBoxInputHandler,
}