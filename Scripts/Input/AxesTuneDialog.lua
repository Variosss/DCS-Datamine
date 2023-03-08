local Input 			= require('Input'			)
local InputData 		= require('Input.Data'		)
local InputUtils		= require('Input.Utils'		)
local DialogLoader		= require('DialogLoader'	)
local AxesTuneWidget	= require('AxesTuneWidget'	)
local ListBoxItem		= require('ListBoxItem'		)
local U 				= require('me_utilities'	)
local UpdateManager		= require('UpdateManager'	)
local Gui				= require('dxgui'			)
local Factory			= require('Factory'			)
local i18n				= require('i18n'			)

local userCurvatureSize = 11
local inputLayerName = 'InputOptionsAxesTune'

local function fillComboListAxes_(self, filterInfos, deviceName)
	self.comboListAxes_:clear()
	
	for i, filterInfo in ipairs(filterInfos) do
		local axis = filterInfo.axis
		local localizedAxisName = InputUtils.getLocalizedInputEventName(axis, deviceName)
		local item = ListBoxItem.new(localizedAxisName)

		item.axis = axis
		self.comboListAxes_:insertItem(item)
	end
end

local function createFilterData(filter)
	filter = filter or {}
	
	local result = InputData.createAxisFilter(filter)

	-- для редактирования нужно хранить как значения curvature(1 число),
	-- так и значения для контрольных точек(userCurvatureSize чисел)
	-- в filter curvature хранится в виде таблицы с одним или userCurvatureSize количеством чисел
	local userCurvature = U.copyTable(nil, filter.curvature or {0})
	local isUserCurve = (#userCurvature == userCurvatureSize)
	
	result.userCurve = isUserCurve
	result.userCurvature = userCurvature
	result.singleCurvature = userCurvature[1]

	return result
end

local function createFilterInfos_(self, combos, deviceName)
	local filterInfos = {}
	
	if combos then
		for i, combo in ipairs(combos) do
			if combo.key then
				table.insert(filterInfos, {axis = combo.key, filterData = createFilterData(combo.filter)})
			end
		end
	end

	return filterInfos
end

local function getAxisFilterData_(self, axis)
	for i, filterInfo in ipairs(self.filterInfos_) do
		if filterInfo.axis == axis then
			return filterInfo.filterData
		end
	end
end

local function selectComboListAxesItem_(self, axis)
	local count = self.comboListAxes_:getItemCount()
	
	for i = 1, count do
		local item = self.comboListAxes_:getItem(i - 1)
		
		if item.axis == axis then
			self.comboListAxes_:selectItem(item)
			
			break
		end
	end
end

local function setFilterDeadzone_(self, value)
	self.currentFilterData_.deadzone = value

	self.axesTuneWidget_	:setDeadZone(value)
	self.sliderDeadzone_	:setValue(value)
	self.editBoxDeadZone_	:setText(value * 100)
end

local function setFilterSaturationX_(self, value)
	self.currentFilterData_.saturationX = value

	self.axesTuneWidget_	:setSaturationX(value)
	self.sliderSaturationX_	:setValue(value)
	self.editBoxSaturationX_:setText(value * 100)
end

local function setFilterSaturationY_(self, value)
	self.currentFilterData_.saturationY = value

	self.axesTuneWidget_	:setSaturationY(value)
	self.sliderSaturationY_	:setValue(value)
	self.editBoxSaturationY_:setText(value * 100)
end

local function setFilterSlider_(self, isSlider)
	self.currentFilterData_.slider = isSlider

	self.axesTuneWidget_	:setSlider(isSlider)
	self.checkBoxSlider_	:setState(isSlider)
end

-- FIXME: invert -> inverted
local function setFilterInvert_(self, isInvert)
	self.currentFilterData_.invert = isInvert

	self.axesTuneWidget_	:setInvert(isInvert)
	self.checkBoxInvert_	:setState(isInvert)
	
end

local function setFilterUserCurve_(self, isUserCurve)
	self.currentFilterData_.userCurve = isUserCurve

	self.checkBoxUserCurve_		:setState(isUserCurve)
	self.containerSliders_		:setVisible(isUserCurve)
	self.containerSliderStatics_:setVisible(isUserCurve)
	self.axesTuneWidget_		:setUserCurve(isUserCurve)

	if isUserCurve then
		local userCurvature = self.currentFilterData_.userCurvature

		for i = 1, userCurvatureSize do
			self.axesTuneWidget_:setCurvature(i - 1, userCurvature[i])
		end
	else
		self.axesTuneWidget_:setCurvature(0, self.currentFilterData_.singleCurvature)
	end

	self.sliderCurvature_	:setEnabled(not isUserCurve)
	self.editBoxCurvature_	:setEnabled(not isUserCurve)
end

local function setFilterHardwareABDetent(self, isHardwareABDetent, hardwareDetentMax, hardwareDetentAB)
	self.currentFilterData_.hardwareDetent		= isHardwareABDetent
	self.currentFilterData_.hardwareDetentMax	= hardwareDetentMax
	self.currentFilterData_.hardwareDetentAB	= hardwareDetentAB

	self.checkBoxHardwareABDetent_	:setState	(isHardwareABDetent)
	self.panelHardwareABDetent_		:setVisible	(isHardwareABDetent)
	
	if isHardwareABDetent then
		self.panelHardwareABDetent_.spinBoxMax	:setValue(hardwareDetentMax	)
		self.panelHardwareABDetent_.spinBoxAB	:setValue(hardwareDetentAB	)
	end
end

local function setFilterSingleCurvature_(self, value)
	self.currentFilterData_.singleCurvature = value

	self.axesTuneWidget_	:setCurvature(0, value)
	self.sliderCurvature_	:setValue(value)
	self.editBoxCurvature_	:setText(value * 100)
end

local function getUserCurvatureValue_(self, index)
	return self.currentFilterData_.userCurvature[index] or (index - 1) / (userCurvatureSize - 1)
end

local function setUserCurveSliderValue_(self, index, value)
	local curveWidgets	= self.curveWidgets_[index]
	local slider		= curveWidgets.slider
	local editBox		= curveWidgets.editBox
	local min, max		= slider:getRange()

	slider:setValue(max - min - value)
	editBox:setText(value * 100)
end

local function setUserCurvatureValue_(self, index, value)
	value = value or getUserCurvatureValue_(self, index)

	self.currentFilterData_.userCurvature[index] = value

	self.axesTuneWidget_:setCurvature(index - 1, value)

	setUserCurveSliderValue_(self, index, value)
end

local function setFilterUserCurvature_(self, curvature)
	self.currentFilterData_.userCurvature = curvature

	for i = 1, userCurvatureSize do
		setUserCurvatureValue_(self, i, curvature[i])
	end
end

local function setFilterData_(self, filterData)
	setFilterDeadzone_				(self, filterData.deadzone				)
	setFilterSaturationX_			(self, filterData.saturationX			)
	setFilterSaturationY_			(self, filterData.saturationY			)
	setFilterSingleCurvature_		(self, filterData.singleCurvature		)
	setFilterSlider_				(self, filterData.slider				)
	setFilterInvert_				(self, filterData.invert				)
	setFilterUserCurve_				(self, filterData.userCurve				)
	setFilterUserCurvature_			(self, filterData.userCurvature			)
	setFilterHardwareABDetent		(self, filterData.hardwareDetent, filterData.hardwareDetentMax, filterData.hardwareDetentAB)
end

local function createInputLayer_(self, layerName, axis)
	Input.deleteLayer(layerName)
	Input.createLayer(layerName)

	local event 	= InputUtils.getInputEvent(axis)
	local deviceId	= Input.getDeviceId(self.deviceName_)
	local reformers	= nil

	Input.addAxisCombo(layerName, event, deviceId, reformers, event)

	Input.setTopLayer(layerName)
end

local function selectFilter_(self, axis)
	self.currentFilterData_ = getAxisFilterData_(self, axis)
	selectComboListAxesItem_(self, axis)
	setFilterData_(self, self.currentFilterData_)
	createInputLayer_(self, inputLayerName, axis)
end

local function initializeCurveWidgets_(self, containerSliders, containerSliderStatics)
	self.curveWidgets_ = {}
	
	for i = 1, userCurvatureSize do 
		local suffix		= tostring(i - 1) .. '0'
		local sliderName	= 'vslider_' .. suffix
		local editBoxName	= 'userCurveEditBox_' .. suffix
		local slider		= containerSliders[sliderName]
		local editBox		= containerSliderStatics[editBoxName]

		local min, max = slider:getRange()
		local range =  max - min
		
		slider:addChangeCallback(function()		
			local value = range - slider:getValue()

			setUserCurvatureValue_(self, i, value)
		end)

		local getEditBoxValue = function()
			local text = editBox:getText()
			local value = min
			
			if text ~= '' then
				value = (tonumber(text) or min) / 100
				value = math.max(min, value)
				value = math.min(max, value)
			end
			
			return value
		end
		
		local prevValue
		
		editBox:addKeyDownCallback(function(widget, keyName, unicode)
			if 'return' == keyName then
				setUserCurvatureValue_(self, i, getEditBoxValue())
				editBox:setSelection(0, -1)
			elseif 'escape' == keyName then
				if prevValue then
					setUserCurvatureValue_(self, i, prevValue)
					editBox:setSelection(0, -1)
				end
			end
		end)

		editBox:addFocusCallback(function()
			if editBox:getFocused() then
				prevValue = range - slider:getValue()
			else
				setUserCurvatureValue_(self, i, getEditBoxValue())
			end
		end)

		self.curveWidgets_[i] = {
			slider = slider,
			editBox = editBox,
		}
	end
end

local function createResult_(self)
	local result = {}
	
	for i, filterInfo in ipairs(self.filterInfos_) do
		local filterData = filterInfo.filterData
		
		if filterData.userCurve then
			filterData.curvature = filterData.userCurvature
		else
			filterData.curvature = {filterData.singleCurvature}
		end
		
		result[filterInfo.axis] = filterData
	end
	
	return result
end

local function construct(self)
	local _ = i18n.ptranslate
	local localization = {
		axisTunePanel		= _('AXIS TUNE PANEL'				),
		ok					= _('OK'							),
		cancel				= _('CANCEL'						),
		reset				= _('RESET'							),
		hardwareABDetent	= _('Hardware AB Detent'			),
		showAdditionalAxis	= _('Show Additional Axis'			),
		userCurve			= _('User Curve'					),
		invert				= _('Invert'						),
		slider				= _('Slider'						),
		curvature			= _('Curvature'						),
		deadZone			= _('Deadzone'						),
		saturationX			= _('Saturation X'					),
		saturationY			= _('Saturation Y'					),
		editBoxHint			= _('Enter value between 0 and 100'	),
		valueIn				= _('In:'							),
		valueOut			= _('Out:'							),
		Max					= _('Max:'							),
		AB					= _('AB:'							),
	}
	
	local window = DialogLoader.spawnDialogFromFile('./Scripts/Input/AxesTuneDialog.dlg', localization)	
	
	self.window_ = window
    local pDown = window.containerMain.pDown
	self.axesTuneWidget_ = AxesTuneWidget.new()
	self.axesTuneWidget_:setSkin(Skin.axisTuneWidgetSkin())
	self.axesTuneWidget_:setInRange(1)
	self.axesTuneWidget_:setOutRange(1)
	
	local container = window.containerMain
    
    local w, h = Gui.GetWindowSize()  
    local wC, hC = container:getSize()   
    window:setBounds(0, 0, w, h)
    container:setBounds((w-wC)/2, (h-hC)/2, wC, hC)
	
	self.axesTuneWidget_:setBounds(container.staticAxisTuneWidgetPlaceholder:getBounds())
	container:insertWidget(self.axesTuneWidget_)
	
	self.editBoxIn_		= container.editBoxIn
	self.editBoxOut_	= container.editBoxOut
	
	self.comboListAxes_ = container.comboListAxes
	
	self.comboListAxes_:addChangeCallback(function()
		local item = self.comboListAxes_:getSelectedItem()
		
		selectFilter_(self, item.axis)
	end)
	
	local bindSliderAndEditBox = function(slider, editBox, filterFunc)
		
		slider:addChangeCallback(function()
			filterFunc(self, slider:getValue())
		end)
		
		local min, max = slider:getRange()

		local getEditBoxValue = function()
			local text = editBox:getText()

			local value = min
			
			if text ~= '' then
				value = (tonumber(text) or min) / 100
				value = math.max(min, value)
				value = math.min(max, value)
			end
			
			return value
		end
		
		local prevValue
		
		editBox:addKeyDownCallback(function(widget, keyName, unicode)
			if 'return' == keyName then
				prevValue = getEditBoxValue()
				filterFunc(self, prevValue)
				editBox:setSelection(0, -1)
			elseif 'escape' == keyName then
				if prevValue then
					filterFunc(self, prevValue)
					editBox:setSelection(0, -1)
				end
			end
		end)

		-- editBox:addChangeCallback(function()
		-- end)

		editBox:addFocusCallback(function()
			if editBox:getFocused() then
				prevValue = slider:getValue()
			else
				filterFunc(self, getEditBoxValue())
				prevValue = nil
			end
		end)
	end
	
	self.sliderDeadzone_ = container.hsliderDeadzone
	self.editBoxDeadZone_ = container.editBoxDeadZone	
	bindSliderAndEditBox(self.sliderDeadzone_, self.editBoxDeadZone_, setFilterDeadzone_)

	self.sliderSaturationX_ = container.hsliderSaturationX
	self.editBoxSaturationX_ = container.editBoxSaturationX
	bindSliderAndEditBox(self.sliderSaturationX_, self.editBoxSaturationX_, setFilterSaturationX_)
		
	self.sliderSaturationY_ = container.hsliderSaturationY
	self.editBoxSaturationY_ = container.editBoxSaturationY
	bindSliderAndEditBox(self.sliderSaturationY_, self.editBoxSaturationY_, setFilterSaturationY_)

	self.sliderCurvature_ = container.hsliderCurvature
	self.editBoxCurvature_ = container.editBoxCurvature
	bindSliderAndEditBox(self.sliderCurvature_, self.editBoxCurvature_, setFilterSingleCurvature_)

	
	self.checkBoxSlider_ = container.checkBoxSlider

	self.checkBoxSlider_:addChangeCallback(function()
		setFilterSlider_(self, self.checkBoxSlider_:getState())
	end)
	
	self.checkBoxInvert_ = container.checkBoxInvert

	self.checkBoxInvert_:addChangeCallback(function()
		setFilterInvert_(self, self.checkBoxInvert_:getState())
	end)

	self.checkBoxUserCurve_ = container.checkBoxUserCurve

	self.checkBoxUserCurve_:addChangeCallback(function()
		setFilterUserCurve_(self, self.checkBoxUserCurve_:getState())
	end)
	
	self.checkBoxHardwareABDetent_	= container.checkBoxHardwareABDetent
	self.panelHardwareABDetent_		= container.panelHardwareABDetent
	
	self.panelHardwareABDetent_.spinBoxMax:addChangeCallback(function()
		self.currentFilterData_.hardwareDetentMax = self.panelHardwareABDetent_.spinBoxMax:getValue()
	end)
	
	self.panelHardwareABDetent_.spinBoxAB:addChangeCallback(function()
		self.currentFilterData_.hardwareDetentAB = self.panelHardwareABDetent_.spinBoxAB:getValue()
	end)
	
	self.checkBoxHardwareABDetent_:addChangeCallback(function()			
		setFilterHardwareABDetent(self, self.checkBoxHardwareABDetent_:getState(), self.currentFilterData_.hardwareDetentMax, self.currentFilterData_.hardwareDetentAB)
	end)	
	
	self.containerSliders_ = container.containerSliders
	self.containerSliderStatics_ = container.containerSliderWidgets
	
	initializeCurveWidgets_(self, self.containerSliders_, self.containerSliderStatics_)

	pDown.buttonReset:addChangeCallback(function()
		setFilterData_(self, createFilterData())
	end)

	pDown.buttonCancel:addChangeCallback(function()
		self.window_:close()
	end)

	pDown.buttonOk:addChangeCallback(function()
		self.result_ = createResult_(self)
		
		self.window_:close()
	end)
end

local function onProcessInput_(self)
	local inputActions	= Input.getInputActions()
	local inputAction	= inputActions[#inputActions]
	
	if inputAction then
		local valueIn = inputAction.value
		
		--if self.currentFilterData_.invert then
		--	valueIn = -valueIn
		--end
		
		local valueOut = self.axesTuneWidget_:getFilterValue(valueIn)
		
		self.axesTuneWidget_:drawPrimaryPointer(valueIn)
		
		if self.currentFilterData_.invert then
			valueIn = -valueIn
		end
		
		if self.currentFilterData_.slider then			
			
			if not self.currentFilterData_.invert then 				
				self.editBoxIn_	:setText(math.floor((valueIn  * 100 + 100)/2))
				self.editBoxOut_:setText(math.floor((valueOut * 100 + 100)/2))				
			else				
				self.editBoxIn_	:setText(math.floor((-valueIn  * 100 + 100)/2))
				self.editBoxOut_:setText(math.floor((-valueOut * 100 + 100)/-2 + 0.1)) -- 0.1 - при floor не даёт индицироваться -0 (минус ноль)
			end
		
		else
			self.editBoxIn_	:setText(math.floor(valueIn  * 100))
			self.editBoxOut_:setText(math.floor(valueOut * 100))
		end
	end
end

local function show(self, combos, deviceName)	
	self.deviceName_	= deviceName
	self.filterInfos_	= createFilterInfos_(self, combos, deviceName)
	
	fillComboListAxes_(self, self.filterInfos_, deviceName)
	
	local axis = self.filterInfos_[1].axis
	
	selectFilter_(self, axis)
	
	local onProcessInput = function()
		onProcessInput_(self)
	end
	
	UpdateManager.add(onProcessInput)
	
	self.result_ = nil
	
	self.window_:setVisible(true)
	
	UpdateManager.delete(onProcessInput)
	Input.deleteLayer(inputLayerName)
	
	return self.result_
end

local function kill(self)
	self.window_:kill()
	self.window_ = nil
end

return Factory.createClass({
	construct	= construct,
	show		= show,
	kill		= kill,
})