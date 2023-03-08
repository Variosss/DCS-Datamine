local Input 			= require('Input'				)
local InputData 		= require('Input.Data'			)
local InputUtils 		= require('Input.Utils'			)
local WizardUtils 		= require('Input.WizardUtils'	)
local DialogLoader 		= require('DialogLoader'		)
local AxesTuneWidget 	= require('AxesTuneWidget'		)
local UpdateManager 	= require('UpdateManager'		)
local Serializer 		= require('Serializer'			)
local lfs 				= require('lfs'					)
local i18n				= require('i18n'				)

local _ = i18n.ptranslate

local window_
local staticWarning_
local progressBar_
local profileName_
local modifiers_
local layerStack_
local layerName_ = 'Wizard'
local cdata = {
	controlsWizard	= _('Controls Wizard'	),
	ok				= _('OK'				),
	cancel			= _('CANCEL'			),
}

local pages_ = {
	require('Input.WizardWelcomePage'	),
	require('Input.WizardPitchPage'		),
	require('Input.WizardRollPage'		),
	require('Input.WizardYawPage'		),
	require('Input.WizardThrustPage'	),
	require('Input.WizardKeysPage'		),
	require('Input.WizardFinishPage'	),
}

local currPageIndex_ = 1
local handleKeyFunc_
local handleAxisFunc_

local function selectPage(pageIndex)
	-- удаляем предыдущую страницу
	local currPanelMain = window_.panelMain:getWidget(0)
	
	if currPanelMain then
		window_.panelMain:removeWidget(currPanelMain)
	end
	
	-- добавляем новую страницу
	local page = pages_[pageIndex]

	window_.panelMain:insertWidget(page.getPanelMain())		
	
	page.resetCombos()
	
	handleKeyFunc_	= page.handleKey
	handleAxisFunc_	= page.handleAxis
	currPageIndex_	= pageIndex
end

local function hide()
	if window_ then
		Input.removeLayerFromStack(layerName_)
		window_:setVisible(false)
	end
end

local function assignCombos()
	local result, messages = WizardUtils.assignCombos(pages_[currPageIndex_].getCombos())
	
	if result then
		staticWarning_:setVisible(false)
	else
		staticWarning_:setVisible(true)	
		staticWarning_:setText(table.concat(messages, '\n'))
	end
	
	--return true to allow skip  current  step , not always interesting about some particular  assignments 
	return true
end

local function save()
	local result = {}
	
	for i, page in ipairs(pages_) do
		for name, combo in pairs(page.getCombosToSave()) do
			if combo.deviceId  ~= nil and combo.key ~= nil then
				local deviceName = InputUtils.getDeviceTemplateName(InputUtils.getDeviceNameById(combo.deviceId))
				
				result[deviceName] = result[deviceName] or {}
				result[deviceName][name] = { 
						key			= combo.key, 
						reformers	= WizardUtils.getComboReformers(combo),
					}						
			end
		end
	end
	
	local filename	= lfs.writedir() .. 'Config/Input/wizard.lua'
	local file, err	= io.open(filename, 'w')
	
	if file then
		local s = Serializer.new(file)
		s:serialize_sorted('local result', result)
		file:write('return result')
		file:close()
	else
		print(string.format('Cannot save wizard results into file[%s]! Error %s', filename, err))
	end
end

local function create()
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/Input/Wizard.dlg', cdata)
	
	window_:centerWindow()
	
	staticWarning_	= window_.staticWarning
	progressBar_	= window_.progressBar
	
	function window_.buttonOk:onChange()
		local currPage	= pages_[currPageIndex_]
		local handled	= currPage.onOk and currPage.onOk()
		
		if not handled then -- если страница не обработала нажатие на кнопку Ok
			if currPageIndex_ < #pages_ then
				if assignCombos() then
					currPage.changeProgress()
					selectPage(currPageIndex_ + 1)
				end
			else
				save()
				hide()
			end
		end
	end
	
	function window_.buttonCancel:onChange()
		local handled = pages_[currPageIndex_].onCancel and pages_[currPageIndex_].onCancel()
		
		if not handled then
			hide()
		end	
	end
	
	local comboCount = 0
	
	for i, page in ipairs(pages_) do
		comboCount = comboCount + WizardUtils.getComboCount(page.getCombosToSave())
	end
	
	progressBar_:setRange(0, comboCount)
end

local function addInputModifierKeys()
	for modifierName, modifier in pairs(modifiers_) do	
		local event = modifier.event

		if event then
			local deviceId			= modifier.deviceId
			local reformers			= nil
			local down				= event
			local pressed			= nil
			local up				= nil

			Input.addKeyCombo(layerName_, event, deviceId, reformers, down, pressed, up)
		end
	end
end

local function addInputDeviceKeys(deviceName)
	local deviceKeys	= InputUtils.getDeviceKeysNoModifiers(deviceName, modifiers_)
	local eventsToSkip	= InputUtils.getDeviceEventsToSkip(deviceName)
	local deviceId		= Input.getDeviceId(deviceName) 

	for i, deviceKey in ipairs(deviceKeys) do
		local event = deviceKey.event

		if not eventsToSkip[event] then
			local reformers	= nil
			local down		= event
			local pressed	= nil
			local up		= nil
			
			Input.addKeyCombo(layerName_, event, deviceId, reformers, down, pressed, up)
		end
	end
end

local function addInputDeviceAxes(deviceName)
	local deviceAxes	= InputUtils.getDeviceAxes(deviceName)
	local eventsToSkip	= InputUtils.getDeviceEventsToSkip(deviceName)
	local deviceId		= Input.getDeviceId(deviceName)

	for i, deviceAxis in ipairs(deviceAxes) do
		local event = deviceAxis.event

		if not eventsToSkip[event] then
			local reformers	= nil
			local action	= event
			local filter	= nil
			
			Input.addAxisCombo(layerName_, event, deviceId, reformers, action, filter)
		end
	end
end

local function createInputLayer()
	Input.createLayer(layerName_)
	
	local devices	= InputUtils.getDevices()
	modifiers_		= InputData.getProfileModifiers(profileName_)
	
	addInputModifierKeys()
	
	for i, deviceName in ipairs(Input.getDevices()) do
		addInputDeviceKeys(deviceName)
		addInputDeviceAxes(deviceName)
	end
end

local function process()
	for i, inputAction in ipairs(Input.getInputActions()) do
		if inputAction.hasValue then
			handleAxisFunc_(InputUtils.getDeviceEventName(inputAction.action), inputAction.deviceId, inputAction.value)
		else
			local isModifier = false
			
			for modifierName, modifier in pairs(modifiers_) do
				if modifier.event == inputAction.action then
					isModifier = true
					
					break
				end
			end
		
			handleKeyFunc_(InputUtils.getDeviceEventName(inputAction.action), inputAction.deviceId, isModifier)
		end
		
		-- inputAction.hasValue			false
		-- inputAction.action			57
		-- inputAction.value   			0
		-- inputAction.time				201820328
		-- inputAction.absolute			false
		-- inputAction.deviceId			1
	end
end

local function show(profileName)
	if not window_ then
		create()
	end
	
	profileName_	= profileName
	currPageIndex_	= 1
	
	WizardUtils.resetCombos()
	progressBar_:setValue(0)
	
	createInputLayer()
	layerStack_ = Input.getLayerStack()
	Input.clearLayerStack()
	Input.setTopLayer(layerName_)
	selectPage(currPageIndex_)
	
	UpdateManager.add(process)
	
	window_:setVisible(true)
end

local function hide()
	if window_ then
		Input.deleteLayer(layerName_)
		UpdateManager.remove(process)
		window_:setVisible(false)
	end
end

local function changeProgress(delta)
	progressBar_:setValue(progressBar_:getValue() + delta)
end

return {
	show			= show,
	hide			= hide,
	assignCombos	= assignCombos,
	changeProgress	= changeProgress,
}
