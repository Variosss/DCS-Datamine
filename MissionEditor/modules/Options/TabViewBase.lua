-- базовый "класс" для всех tab view
local DbOption			= require('Options.DbOption')
local WidgetUtils		= require('Options.WidgetUtils')
local U                 = require('me_utilities')
local Gui				= require('dxgui')

local function loadFromResource(self)
	error('This function must be defined in inherited classes!')
end

local function bindControls(self)
	error('This function must be defined in inherited classes!')
end

local function construct(self, controller, w, h)
	self.controller_ = controller
	self.updateFunctions_ = {}
	self.restoreFunctions_ = {}
	self.container_ = self:loadFromResource()	
	self:bindControls(nil, w, h)
end

local function getContainer(self)
	return self.container_
end

local function setUpdateFunction(self, optionName, func)
	self.updateFunctions_[optionName] = func
end

local function getUpdateFunction(self, optionName)
	return self.updateFunctions_[optionName]
end

local function onOptionsRestored(self)
	--print("---onOptionsRestored-BASE---")
end

local function bindCheckBox(self, checkBox, optionName, getFunc, setFunc, getDbValuesFunc, relationsFunc)
	local dbValues = getDbValuesFunc(optionName)
	
	WidgetUtils.enableCheckBoxArch64(checkBox, dbValues)
	WidgetUtils.setCheckBoxInputHandler(checkBox, optionName, setFunc, dbValues, getFunc, relationsFunc)
	
	self:setUpdateFunction(optionName, function()
		local value = getFunc(optionName)
		checkBox:setState(dbValues[2].value == (value ~= 0 and value ~= false))
        
        if checkBox.callbackUpdate then
            checkBox:callbackUpdate()
        end
	end)
end

local function bindRadioButton(self, radioButton, optionName, dbValue, getFunc, setFunc)
	WidgetUtils.enableRadioButtonArch64(radioButton, dbValue)
	WidgetUtils.setRadioButtonInputHandler(radioButton, optionName, setFunc, dbValue)
	
	self:setUpdateFunction(optionName .. tostring(dbValue.value), function()
		radioButton:setState(getFunc(optionName) == dbValue.value)
	end)
end

local function bindComboList(self, comboList, optionName, getFunc, setFunc, getDbValuesFunc, relationsFunc, getEnabledFunc, setEnabledFunc)
	local dbValues = getDbValuesFunc(optionName)
	
	local limitation = nil
	
	if optionName == 'SSAA' then
		local w, h = Gui.GetWindowSize()
		local ssaaValues = {1, 1.5, 2.0};
		
		limitation = function(a_index)
			if a_index == 1 then
				return false
			end
			return (w*h*ssaaValues[a_index]*ssaaValues[a_index]) > 4096 * 4096
		end
	end
	
	WidgetUtils.fillComboList(comboList, dbValues, limitation)    
	WidgetUtils.setComboListInputHandler(comboList, optionName, getFunc, setFunc, relationsFunc, self.container_, getEnabledFunc, setEnabledFunc)
	
	self:setUpdateFunction(optionName, function()
		local value = getFunc(optionName)
		if  type(value) == "boolean" then
			if value == true then
				value = 1
			elseif value == false then
				value = 0	
			end
		end
		local counter = comboList:getItemCount() - 1
		local item = nil
		
		for i = 0, counter do
			local currItem = comboList:getItem(i)
			
			if currItem.value == value then
				item = currItem
				break
			end
		end
        if item then
            comboList:selectItem(item)
        else
            local firstItem = comboList:getItem(0)
            if firstItem then
                comboList:selectItem(firstItem)
                setFunc(optionName,firstItem.value)
            end    
        end
		
		if getEnabledFunc then
			comboList:setEnabled(getEnabledFunc(optionName))
		end

		if comboList.callbackUpdate then
			comboList:callbackUpdate()
		end
	end)
end

local function bindSlider(self, slider, static, optionName, getFunc, setFunc, getDbValuesFunc, getEnabledFunc)
	local dbValues = getDbValuesFunc(optionName)
	
	WidgetUtils.fillSlider(slider, dbValues)
	WidgetUtils.setSliderInputHandler( slider, static, optionName, setFunc)
	
	self:setUpdateFunction(optionName, function()
		local value = getFunc(optionName)
		
		slider:setValue(value)
		
		if static then
			static:setText(value)
		end	
		
		if getEnabledFunc then
			slider:setEnabled(getEnabledFunc(optionName))
		end	
	end)
end

local function bindEditBox(self, editbox, optionName, getFunc, setFunc, getDbValuesFunc)
	WidgetUtils.setEditBoxInputHandler(editbox, optionName, setFunc)
    
	self:setUpdateFunction(optionName, function()
		local value = getFunc(optionName)
		
		editbox:setText(value)	
        local lastLine = editbox:getLineCount() - 1
        editbox:setSelectionNew(lastLine, editbox:getLineTextLength(lastLine), lastLine, editbox:getLineTextLength(lastLine))
		
		 if editbox.callbackUpdate then
            editbox:callbackUpdate()
        end
	end)
end

local function bindOptionEditBox(self, container, optionName, getFunc, setFunc, getDbValuesFunc)
    local widgetName = optionName .. DbOption.editboxName()

    if container[widgetName] then
		self:bindEditBox(container[widgetName], optionName, getFunc, setFunc, getDbValuesFunc)
	end	
end

local function bindOptionCheckBox(self, container, optionName, getFunc, setFunc, getDbValuesFunc, relationsFunc)
	local widgetName = optionName .. DbOption.checkboxName()
	
	if container[widgetName] then
		self:bindCheckBox(container[widgetName], optionName, getFunc, setFunc, getDbValuesFunc, relationsFunc)
	end	
end

local function bindOptionRadioButtons(self, container, optionName, getFunc, setFunc, getDbValuesFunc)
	for i, dbValue in ipairs(getDbValuesFunc(optionName)) do	
		local radioButtonName = dbValue.name .. DbOption.radioName()
		
		if container[radioButtonName] then
			self:bindRadioButton(container[radioButtonName], optionName, dbValue, getFunc, setFunc)
		end	
	end
end

local function bindOptionSlider(self, container, optionName, getFunc, setFunc, getDbValuesFunc)
	local widgetName = optionName .. DbOption.sliderName()
	
	if container[widgetName] then
		local staticName = optionName .. DbOption.staticName()
		
		self:bindSlider(container[widgetName], container[staticName], optionName, getFunc, setFunc, getDbValuesFunc, getEnabledFunc)
	end	
end

local function bindOptionComboList(self, container, optionName, getFunc, setFunc, getDbValuesFunc, relationsFunc, getEnabledFunc, setEnabledFunc)
	local widgetName = optionName .. DbOption.comboName()
	
	if container[widgetName] then	
	
		self:bindComboList(container[widgetName], optionName, getFunc, setFunc, getDbValuesFunc, relationsFunc, getEnabledFunc, setEnabledFunc)
	end	
end



local function updateEditable(self, isSim, optionsDb)
	local container = self:getContainer()
	local setEnabledFunc = self.controller_['setEnabledGraphics']
	
	for widgetName, widget in pairs(container)do
		
		local indexW = string.find(widgetName, DbOption.checkboxName()) or	
						string.find(widgetName, DbOption.radioName()) or	
						string.find(widgetName, DbOption.sliderName()) or	
						string.find(widgetName, DbOption.comboName()) or	
						string.find(widgetName, DbOption.editboxName()) or
						string.find(widgetName, DbOption.labelName()) or
						string.find(widgetName, DbOption.widgetName()) or
						string.find(widgetName, "Btn") or
						string.find(widgetName, "Combo")

		if indexW then
			local name = string.sub(widgetName, 1, indexW-1)
			
			if isSim ~= true or (getOptionsDbFunc()[name] and getOptionsDbFunc()[name].enabledSim == true) then
				container[widgetName]:setEnabled(true)
				setEnabledFunc(name,true)
			else
				container[widgetName]:setEnabled(false)
				setEnabledFunc(name,false)
			end
		end
	end
	
	for widgetName, widget in pairs(container)do
		local indexW = string.find(widgetName, DbOption.checkboxName()) or	
						string.find(widgetName, DbOption.radioName()) or	
						string.find(widgetName, DbOption.sliderName()) or	
						string.find(widgetName, DbOption.comboName()) or	
						string.find(widgetName, DbOption.editboxName()) or
						string.find(widgetName, DbOption.labelName()) or
						string.find(widgetName, DbOption.widgetName()) or
						string.find(widgetName, "Btn") or
						string.find(widgetName, "Combo")

		if indexW then
			if container[widgetName].updateReations then
				container[widgetName]:updateReations(isSim)
			end
		end
	end
	
end

local function updateRelations(self, optionsName)
	local relationsFunc = self.controller_['relations'..optionsName]
	local container = self:getContainer()
	local setFunc = self.controller_['set'..optionsName]
	local getFunc = self.controller_['get'..optionsName]
	local setEnabledFunc = self.controller_['setEnabled'..optionsName]
	local getOptionsDbFunc = self.controller_['get' .. optionsName .. 'Db']
	
	for name, dbOption in pairs(getOptionsDbFunc()) do	
		if relationsFunc then
			relations = relationsFunc(name)
			if relations then
				relation = relations[getFunc(name)]

				for k,v in pairs(relation.enabled) do
					if container[k.."ComboList"] then
						container[k.."ComboList"]:setEnabled(v)
						setEnabledFunc(k,v)					
					elseif container[k.."Slider"] then
						container[k.."Slider"]:setEnabled(v)
						setEnabledFunc(k,v)	
					end
				end	
				
				for k,v in pairs(relation.action) do
					setFunc(k, v)
					self:getUpdateFunction(k)()
				end
			end	
		end
	end
end

local function bindContainer(self, container, optionsDb, getFunc, setFunc, getDbValuesFunc, notVisibleEmpty, relationsFunc, getEnabledFunc, setEnabledFunc)
	for optionName, dbOption in pairs(optionsDb) do
		if optionName ~= "callbackOnShowDialog" then
			local widgetType = dbOption.control

			if DbOption.checkboxName() == widgetType then
				self:bindOptionCheckBox(container, optionName, getFunc, setFunc, getDbValuesFunc, relationsFunc)
			elseif DbOption.radioName() == widgetType then
				self:bindOptionRadioButtons(container, optionName, getFunc, setFunc, getDbValuesFunc)
			elseif DbOption.sliderName() == widgetType then
				self:bindOptionSlider(container, optionName, getFunc, setFunc, getDbValuesFunc)
			elseif DbOption.comboName() == widgetType then
				bindOptionComboList(self, container, optionName, getFunc, setFunc, getDbValuesFunc, relationsFunc, getEnabledFunc, setEnabledFunc)
			elseif DbOption.editboxName() == widgetType then
				self:bindOptionEditBox(container, optionName, getFunc, setFunc, getDbValuesFunc)
			end

			if dbOption.callback then
				local widgetName	= optionName .. widgetType
				local widget		= container[widgetName]
				
				if widget then
					widget:addChangeCallback(function()
						local value = getFunc(optionName)
						
						dbOption.callback(value)
					end)
				end	
			end
		end
	end
    
    if notVisibleEmpty == true then
        for widgetName,v in pairs(container)do
            local index = string.find(widgetName, DbOption.comboName())
            if index then
                local name = string.sub(widgetName, 1, index-1)
                local typeW = string.sub(widgetName, index)
                
                if optionsDb[name] == nil then
                    container[widgetName]:setVisible(false)
                    if container['CPLabelLabel'] then
                        container['CPLabelLabel']:setVisible(false)
                    end  
                    if container[name..'Label'] then
                        container[name..'Label']:setVisible(false)
                    end 
                end
            end
        end
    end
    
end

local function bindOptionsContainer(self, container, optionsName)
	local getFunc 			= self.controller_['get'		.. optionsName]
	local setFunc 			= self.controller_['set'		.. optionsName]
	local getDbValuesFunc 	= self.controller_['get'		.. optionsName .. 'Values'	]
	local getOptionsDbFunc 	= self.controller_['get'		.. optionsName .. 'Db'		]
	local relationsFunc 	= self.controller_['relations'	.. optionsName]
	local getEnabledFunc 	= self.controller_['getEnabled'	.. optionsName]
	local setEnabledFunc 	= self.controller_['setEnabled'	.. optionsName]
	local notVisibleEmpty 	= false
	
	self:bindContainer(container, getOptionsDbFunc(), getFunc, setFunc, getDbValuesFunc, notVisibleEmpty, relationsFunc, getEnabledFunc, setEnabledFunc)
end

local function updateOption(self, optionName)
	local updateFunction = self:getUpdateFunction(optionName)
	
	if updateFunction then
		updateFunction()
	end
end

local function getUpdateFunctions(self)
	return self.updateFunctions_
end

local function updateWidgets(self)
	local updateFunctions = self:getUpdateFunctions()
	
	if updateFunctions then
		for name, func in pairs(updateFunctions) do
			func()
		end
	end	
end

local function show(self)
	self:updateWidgets()
	self.container_:setVisible(true)
end

local function hide(self)
	self.container_:setVisible(false)
end

local function setStyle(self, a_style)

end

local function updateLists(self)

end

return Factory.createClass({
	construct				= construct,
	getContainer			= getContainer,
	
	bindSlider				= bindSlider,
	bindComboList			= bindComboList,
	bindCheckBox			= bindCheckBox,
	bindRadioButton			= bindRadioButton,
    bindEditBox             = bindEditBox,
	bindOptionSlider		= bindOptionSlider,
	bindOptionComboList		= bindOptionComboList,
	bindOptionCheckBox		= bindOptionCheckBox,
	bindOptionRadioButtons	= bindOptionRadioButtons,
    bindOptionEditBox	    = bindOptionEditBox,
	bindContainer			= bindContainer,
	bindOptionsContainer	= bindOptionsContainer,
	
	setUpdateFunction		= setUpdateFunction,
	getUpdateFunction		= getUpdateFunction,
	getUpdateFunctions		= getUpdateFunctions,
	updateOption			= updateOption,
	updateWidgets			= updateWidgets,
	updateEditable			= updateEditable,
	updateRelations			= updateRelations,
	show 					= show,
	hide 					= hide,
	setStyle				= setStyle,
	updateLists				= updateLists,
	onOptionsRestored		= onOptionsRestored,
})
