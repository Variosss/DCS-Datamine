local DialogLoader			= require('DialogLoader')
local InputData				= require('Input.Data')
local InputUtils			= require('Input.Utils')
local ProfileDatabase		= require('Input.ProfileDatabase')
local AdjustControlsDialog	= require('AdjustControlsDialog')
local MeSettings			= require('MeSettings')
local DCS					= require('DCS')
local dxgui					= require('dxgui')
local gettext				= require('i_18n')

function _(text) 
    return gettext.translate(text) 
end

local text_
local window_
local panelLine_
local staticText_
local staticKey_
local staticAxis_
local buttonAssign_
local widgetPool_ = {
	line	= {},
	text	= {},
	key		= {},
	axis	= {},
	button	= {},
}
local panelLines_			= {}
local commandsByHash_
local devices_
local joystickCount_		= 0
local modifiers_
local adjustControlsFunc_
local unitName_
local hasUndefined_			= false
local logEnabled_			= true
local localization			= {
	unassigned		= _('UNASSIGNED'),
	disconnected	= _('DISCONNECTED'),
	warning			= _('Press button to adjust controls'),
}
local maxTextWidth_

local function log(...)
	if logEnabled_ then
		print('Training subtitles:', ...)
	end
end

local function getPanelLine()
	if #widgetPool_.line > 0 then
		return table.remove(widgetPool_.line)
	end

	local result = panelLine_:clone()
	
	function result:backToPool()
		table.insert(widgetPool_.line, result)
	end
	
	return result
end

local function getStaticText()
	if #widgetPool_.text > 0 then
		return table.remove(widgetPool_.text)
	end
	
	local result = staticText_:clone()
	
	function result:backToPool()
		table.insert(widgetPool_.text, result)
	end
	
	return result
end

local function getStaticKey()
	if #widgetPool_.key > 0 then
		return table.remove(widgetPool_.key)
	end
	
	local result = staticKey_:clone()
	
	function result:backToPool()
		table.insert(widgetPool_.key, result)
	end
	
	return result
end

local function getStaticAxis()
	if #widgetPool_.axis > 0 then
		return table.remove(widgetPool_.axis)
	end
	
	local result = staticAxis_:clone()
	
	function result:backToPool()
		table.insert(widgetPool_.axis, result)
	end
	
	return result
end

local function getButtonAssign()
	if #widgetPool_.button > 0 then
		return table.remove(widgetPool_.button)
	end
	
	local result = buttonAssign_:clone()
	
	function result:backToPool()
		if result.callback then
			result:removeChangeCallback(result.callback)
		end
		
		table.insert(widgetPool_.button, result)
	end
	
	return result
end

local function scaleWidgetFont(widget, scale)
	local skin = widget:getSkin()
	local text = skin.skinData.states.released[1].text

	text.fontSize = text.fontSize * scale
	widget:setSkin(skin)
end

local function create()
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/TrainingSubtitles.dlg')
	
	local screenWidth, screenHeight = dxgui.GetScreenSize()
	
	window_:setSize(screenWidth, screenHeight)
	maxTextWidth_ = screenWidth * 0.9
	
	panelLine_		= DialogLoader.findWidgetByName(window_, "panelLine"	)
	staticText_		= DialogLoader.findWidgetByName(window_, "staticText"	)
	staticKey_		= DialogLoader.findWidgetByName(window_, "staticKey"	)
	staticAxis_		= DialogLoader.findWidgetByName(window_, "staticAxis"	)
	buttonAssign_	= DialogLoader.findWidgetByName(window_, "buttonAssign"	)
	
	local fontScale =  DCS.getUserOptions().graphics.messagesFontScale	or 1
	
	if fontScale > 1 then
		scaleWidgetFont(staticText_	, fontScale)
		scaleWidgetFont(staticKey_	, fontScale)
		scaleWidgetFont(staticAxis_	, fontScale)
	end
	
	window_:removeWidget(panelLine_	)
	window_:removeWidget(staticText_)
	window_:removeWidget(staticKey_	)
	window_:removeWidget(staticAxis_)
	window_:removeWidget(buttonAssign_)
end

local function magiclines(s)
	-- from here: https://stackoverflow.com/a/19329565
	if s:sub(-1) ~= '\n' then 
		s = s .. '\n'
	end
        
	return s:gmatch('(.-)\n')
end

local function clearWindow()
	while next(panelLines_) do
		local panelLine = table.remove(panelLines_)
		
		while panelLine:getWidgetCount() > 0 do
			local widget = panelLine:getWidget(0)
			
			panelLine:removeWidget(widget)
			widget:backToPool()
		end
		
		window_:removeWidget(panelLine)
		panelLine:backToPool()
	end
end

local function getShortDeviceName(deviceName)
	if deviceName == 'Keyboard' then
		return ''
	else
		if joystickCount_ > 1 then
			local result = InputUtils.getDeviceTemplateName(deviceName) -- удаляем CLSID из имени джойстика
			local maxLen = 20
			
			if result:len() > maxLen then
				-- длинное название сокращаем до maxLen букв
				return ':' .. result:sub(1, maxLen) .. '…'
			end
			
			return ':' .. result
		else
			return '' -- если джойстик один то его название не нужно
		end
	end
end

local function getComboStrings(command)
	local result = {}
	
	if command.combos then
		for i, deviceName in pairs(devices_) do
			-- в комбинации берем последнее комбо
			local combos = command.combos[deviceName]
			
			if combos then
				local combo = combos[#combos]
				
				if combo then
					local text = combo.key
					
					if combo.reformers then
						local reformers = {}
						
						for i, reformer in ipairs(combo.reformers) do
							local modifier = modifiers_[reformer]
							
							table.insert(reformers, modifier.key .. getShortDeviceName(modifier.deviceName))
						end

						if #reformers > 0 then
							text = table.concat(reformers, '+') .. '+' .. text
						end	
					end			
					
					table.insert(result, text .. getShortDeviceName(deviceName))
				end
			end
		end
	end

	return result
end

local function fillCommands(commands)
	for i, command in pairs(commands) do
		local hash = command.hash
		
		if commandsByHash_[hash] then
			log('Training subtitles hash', hash, 'in command', command.name, 'already presented in command', commandsByHash_[hash].command.name)
		else
			commandsByHash_[hash] = command
		end
	end
end

local function setUnit(unitName)
	unitName_ = unitName
	
	local profileName = InputData.getProfileNameByUnitName(unitName_)

	modifiers_ = InputData.getProfileModifiers(profileName)
	
	commandsByHash_ = {}
	
	fillCommands(InputData.getProfileKeyCommands(profileName))
	fillCommands(InputData.getProfileAxisCommands(profileName))
end

local parseText -- определена ниже
local function adjustControls(commandHash, isAxis)
	local onOkCallback = function()
		unitName_ = nil -- для перезагрузки команд
		parseText(text_)
	end
	
	AdjustControlsDialog.show(unitName_, onOkCallback, commandHash, isAxis)
end

local function addPanelLine(panelLine)
	window_:insertWidget(panelLine)
	table.insert(panelLines_, panelLine)
end

local function addWidget(panelLine, widget)
	panelLine:insertWidget(widget)
			
	local w, h = panelLine:getLayout():getPrefSize()

	if w > maxTextWidth_ then
		addPanelLine(panelLine)
		
		-- начинаем новую строку
		if panelLine:getWidgetCount() > 1 then 
			panelLine:removeWidget(widget)
			panelLine = getPanelLine() 
			panelLine:insertWidget(widget)
		else
			panelLine = getPanelLine()
		end
	end
	
	return panelLine
end

local function addStaticKey(panelLine, text)
	local staticKey = getStaticKey()

	staticKey:setText(text)
	
	return addWidget(panelLine, staticKey)
end

local function addStaticAxis(panelLine, text)
	local staticAxis = getStaticAxis()

	staticAxis:setText(text)
	
	return addWidget(panelLine, staticAxis)
end

local function addStaticText(panelLine, text)
	local staticText = getStaticText()

	staticText:setText(text)
	
	return addWidget(panelLine, staticText)
end

local function addButtonAssign(panelLine, hash, isAxis)
	local buttonAssign = getButtonAssign()
			
	buttonAssign.callback = function()
		adjustControls(hash, isAxis)
		MeSettings.setShowTrainingSubtilesWarning(false)
	end
	
	buttonAssign:addChangeCallback(buttonAssign.callback)

	return addWidget(panelLine, buttonAssign)
end

local function parseKey(panelLine, hash)
	local command	= commandsByHash_[hash]
			
	if command then
		local comboStrings = getComboStrings(command)
		
		if #comboStrings == 0 then
			hasUndefined_ = true
			local textLine = panelLine
			
			panelLine = addStaticKey(panelLine, localization.unassigned)
			panelLine = addButtonAssign(panelLine, hash, false)
			
			local buttonLine = panelLine
			
			-- если подпись и кнопка на разных строках, то возвращаем кнопку на строку с подписью
			if buttonLine ~= textLine then
				textLine:insertWidget(buttonLine:getWidget(0))
			end
		else			
			for i, comboString in ipairs(comboStrings) do
				panelLine = addStaticKey(panelLine, comboString)
			end
		end
	else
		panelLine = addStaticKey(panelLine, localization.disconnected)
	end
	
	return panelLine
end

local function parseAxis(panelLine, hash)
	local command	= commandsByHash_[hash]
			
	if command then
		local comboStrings = getComboStrings(command)
		
		if #comboStrings == 0 then
			hasUndefined_ = true
			local textLine = panelLine
			
			panelLine = addStaticAxis(panelLine, localization.unassigned)
			
			panelLine = addButtonAssign(panelLine, hash, true)
			
			local buttonLine = panelLine
			
			-- если подпись и кнопка на разных строках, то возвращаем кнопку на строку с подписью
			if buttonLine ~= textLine then
				textLine:insertWidget(buttonLine:getWidget(0))
			end
		else			
			for i, comboString in ipairs(comboStrings) do
				panelLine = addStaticAxis(panelLine, comboString)
			end
		end
	else
		panelLine = addStaticAxis(panelLine, localization.disconnected)
	end
	
	return panelLine
end

local function parseLine(line)
	local panelLine = getPanelLine()
	local lastSpaces
	
	while true do
		local word, spaces = line:match('(%S+)(%s*)')
		
		if not word then 
			break 
		end
		
		local text = word .. spaces
		
		local keyHash	= word:match('key:(.*)%s*')
		local axisHash	= word:match('axis:(.*)%s*')
		
		if		keyHash then
			panelLine = parseKey(panelLine, keyHash)
			lastSpaces = spaces
		elseif	axisHash then
			panelLine = parseAxis(panelLine, axisHash)
			lastSpaces = spaces
		else
			if lastSpaces then
				panelLine = addStaticText(panelLine, lastSpaces .. text)
				lastSpaces = nil
			else
				panelLine = addStaticText(panelLine, text)
			end
		end
		
		line = line:sub(text:len() + 1)
	end
	
	addPanelLine(panelLine)
end

local function addWarningLine()
	local panelLine	= getPanelLine()	
	local buttonAssign	= getButtonAssign()
	
	buttonAssign.callback = function()
		adjustControls()
		MeSettings.setShowTrainingSubtilesWarning(false)
	end
	
	buttonAssign:addChangeCallback(buttonAssign.callback)
	
	panelLine:insertWidget(buttonAssign)
	
	local staticText = getStaticText()

	staticText:setText(localization.warning)
	panelLine:insertWidget(staticText)

	addPanelLine(panelLine)
end

-- объявлена выше
function parseText(text)
	clearWindow()
	
	joystickCount_	= 0
	devices_		= InputUtils.getDevices() -- sorted by device type (keyboard, joysticks, mouse, etc...)
	
	for i, deviceName in ipairs(devices_) do
		if InputUtils.getDeviceTypeName(deviceName) == 'joystick' then
			joystickCount_ = joystickCount_ + 1
		end
	end
	
	local unitName = DCS.getHumanUnitInputName()
	
	if unitName ~= unitName_ then
		setUnit(DCS.getHumanUnitInputName())
	end		

	hasUndefined_ = false
	
	for line in magiclines( text ) do
		parseLine(line)
	end
	
	if hasUndefined_ and MeSettings.getShowTrainingSubtilesWarning() then
		addWarningLine()
	end
	
	window_:getLayout():updateSize()	
end

local function show(text)
	if not window_ then
		create()
	end
	
	if text and text ~= '' then
		text_ = text
		parseText(text_)
		window_:setVisible(true)
	else
		window_:setVisible(false)
	end
end

local function enableLog(enable)
	logEnabled_ = enable
end

local function reset()
	if window_ then
		window_:kill()
		
		window_			= nil
		unitName_		= nil
		modifiers_		= nil
		commandsByHash_	= nil
		panelLines_		= {}
	end
end

return {
	enableLog				= enableLog,
	show					= show,
	reset					= reset,
}