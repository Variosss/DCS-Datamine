-- message box window
-- see HOWTO at the end of file
local base = _G

module('MsgWindow')

local ipairs	= base.ipairs
local pairs		= base.pairs
local require	= base.require
local table		= base.table
local unpack	= base.unpack
local tostring	= base.tostring
local math		= base.math
local print		= base.print

local DialogLoader = require('DialogLoader')
local dxgui = require('dxgui')

warningIcon		= 'warning'
errorIcon		= 'error'
questionIcon	= 'question'
infoIcon		= 'info'
userIcon		= 'user'

local windowPools_ = {}
local maxButtonCount_ = 4

local function getWidget_(window, widgetName)
	local widget = window[widgetName]
	
	if not widget then
		widget = DialogLoader.findWidgetByName(window, widgetName)
		
		if widget then	
			window[widgetName] = widget
		end
	end
	
	return widget
end

local function setIcon_(window, iconType, ...)
	local args = {...}
	local staticIcon = getWidget_(window, "staticIcon")
	local iconSkin
	
	if iconType == warningIcon then
		iconSkin = getWidget_(window, "staticWarning"):getSkin()
	elseif iconType == errorIcon then
		iconSkin = getWidget_(window, "staticError"):getSkin()
	elseif iconType == questionIcon then
		iconSkin = getWidget_(window, "staticQuestion"):getSkin()
	elseif iconType == infoIcon then
		iconSkin = getWidget_(window, "staticInfo"):getSkin()
	elseif iconType == userIcon then
		local pictureIndex = 1
		
		iconSkin = getWidget_(window, "staticEmptyIcon"):getSkin()
		iconSkin.skinData.states.released[1].picture = args[pictureIndex]
		
		table.remove(args, pictureIndex)
	else
		iconSkin = getWidget_(window, "staticEmptyIcon"):getSkin()
	end
	
	staticIcon:setSkin(iconSkin)
	
	return args
end

local function findWindowPool_(windowToFind)
	for filename, windowPool in pairs(windowPools_) do
		for i, window in ipairs(windowPool) do
			if windowToFind == window then
				return windowPool
			end
		end
	end
end

local function getButtonName_(index)
	return 'button' .. tostring(index)
end

local function getPanelButtons(window)
	return getWidget_(window, "panelButtons")
end

local function hideWindow(window)
	window:setVisible(false)
	dxgui.SetTaskbarOverlayIcon()
end

local function createButtonCallback(window, handler)
	return function(button)
		local result = false
		
		if handler.onChange then
			result = handler:onChange(button:getText())
		end
		
		if not result then
			hideWindow(window)
		end
	end
end

local function placeWindow_(windowToMove)
	local w, h = windowToMove:calcSize()

	windowToMove:setSize(w, h)
	
	local layout = windowToMove:getLayout()
	
	layout:updateSize()
	
	windowToMove:centerWindow()
	
	local x, y = windowToMove:getPosition()
	local offset = 20
	
	local windowPool = findWindowPool_(windowToMove)
	
	for i, window in ipairs(windowPool) do
		if window == windowToMove then  
			break
		end
		
		x = x + offset
		y = y + offset
	end
	
	windowToMove:setPosition(x, y)
end

function createHandler_(window, iconType)
	local handler	= {
		window 		= window, 
		iconType	= iconType,
	}
	
	function handler:show()
		if iconType == warningIcon then
			dxgui.SetTaskbarOverlayIcon("./dxgui/skins/skinME/images/Icons/32x32/warning.ico")
		elseif iconType == errorIcon then
			dxgui.SetTaskbarOverlayIcon("./dxgui/skins/skinME/images/Icons/32x32/error.ico")
		elseif iconType == questionIcon then
			dxgui.SetTaskbarOverlayIcon("./dxgui/skins/skinME/images/Icons/32x32/question.ico")
		elseif iconType == infoIcon then
			dxgui.SetTaskbarOverlayIcon("./dxgui/skins/skinME/images/Icons/32x32/info.ico")
		end
		
		window:setVisible(true)
	end
    
    function handler:hide()
		hideWindow(window)
	end
	
	function handler:close()
		window:close()
	end
	
	function handler:onClose()
		-- return true if yor do not want to close window
		return false
	end	
	
	function handler:setDefaultButton(buttonText)
		local panelButtons	= getPanelButtons(window)
		local count			= panelButtons:getWidgetCount()
		
		for i = 1, count do
			local button = panelButtons:getWidget(i - 1)
			
			if button:getText() == buttonText then
				button:setFocused(true)
				
				break
			end
		end
	end
	
	function handler:addWidget(widget)
		local panelCenter = getWidget_(window, "panelCenter")
		
		panelCenter:insertWidget(widget)
		
		-- обновим размер окна
		placeWindow_(window)
	end
	
	function handler:setShaderEffect(name, params)
		window.shaderEffect = {
			name	= name,
			params	= params,
		}
	end
	
	function handler:removeWidget(widget)
		local panelCenter = getWidget_(window, "panelCenter")
		
		panelCenter:removeWidget(widget)
		
		-- обновим размер окна
		placeWindow_(window)
	end	
	
	if window.escapeCallback then
		window:removeHotKeyCallback('escape', window.escapeCallback)
	end
	
	window.escapeCallback = function()
		-- симулируем нажатие последней кнопки		
		local panelButtons	= getPanelButtons(window)
		local lastButton	= panelButtons:getWidget(panelButtons:getWidgetCount() - 1)
		local callback		= createButtonCallback(window, handler)
		
		callback(lastButton)
	end
	
	window:addHotKeyCallback('escape', window.escapeCallback)
	
	function window:onClose()
		local result = handler:onClose()
		
		if result then
			self:setVisible(true)
		else
			dxgui.SetTaskbarOverlayIcon()
		end
	end
	
	for i = 1, maxButtonCount_ do
		local buttonName = getButtonName_(i)
		local button = window[buttonName]
		
		if button.changeCallback then
			button:removeChangeCallback(button.changeCallback)
		end
		
		local callback = createButtonCallback(window, handler)
		
		button:addChangeCallback(callback)
		button.changeCallback = callback
		
		if 1 == i then
			button:setFocused(true)
		end
	end
	
	return handler
end

function getWindow_(filename)
	filename = filename or 'dxgui/skins/skinME/msg_window.dlg'

	local result
	local windowPool = windowPools_[filename]
	
	if not windowPool then
		windowPool = {}
		windowPools_[filename] = windowPool
	end
	
	for i, window in ipairs(windowPool) do
		if not window:isVisible() then
			result = window
			break
		end
	end
	
	if not result then
		result = DialogLoader.spawnDialogFromFile(filename)

		table.insert(windowPool, result)
	end
	
	return result
end

local function storeButtons_(window)
	for i = 1, maxButtonCount_ do
		local buttonName = getButtonName_(i)
		local button = getWidget_(window, buttonName)
		
		if button then
			window[buttonName] = button
		else
			break
		end
	end
end

local function placeButtons_(window, args)
	local panelButtons = getPanelButtons(window)
	
	storeButtons_(window)
	panelButtons:removeAllWidgets()
	
	local buttonCount = math.min(#args, maxButtonCount_)
	
	for i = 1, buttonCount do
		local buttonName = getButtonName_(i)
		local button = window[buttonName]
		
		button:setText(args[i])
		
		panelButtons:insertWidget(button)
	end
end

local function initWindow_(window, text, caption, iconType, ...)
	window:setText(caption)
	
	local panelCenter = getWidget_(window, "panelCenter")
	local count = panelCenter:getWidgetCount()
	
	-- удаляем все виджеты из panelCenter кроме editBoxMessage
	for i = count, 2, -1 do
		panelCenter:removeWidget(panelCenter:getWidget(i - 1))
	end
	
	local screenWidth, screenHeight = dxgui.GetScreenSize()
	local editBoxMessage = getWidget_(window, "editBoxMessage")
	
	-- сбрасываем размер panelCenter
	-- правильный размер panelCenter будет установлен лейаутом окна в функции placeWindow_()
	panelCenter:setSize(screenWidth * 0.75, 0)
	editBoxMessage:setText(text)
	
	local args = setIcon_(window, iconType, ...)

	placeButtons_(window, args)
	placeWindow_(window)	
	
	local handler = createHandler_(window, iconType)
	
	return handler
end

function new(text, caption, iconType, ...) -- ... - подписи для кнопок	 
	local window = getWindow_()
	
	local handler = initWindow_(window, text, caption, iconType, ...)
	
	handler:setShaderEffect('showMsg', {
			duration 	= 0.2	,
			alphaBegin 	= 0		,
			alphaEnd 	= 1		,
			easingAlpha	= 1		, -- linear
			easingSize 	= 12	, -- cubicOut
	})
	
	return handler
end 

function newFromResource(filename, text, caption, iconType, ...)
	local window = getWindow_(filename)
	
	local handler = initWindow_(window, text, caption, iconType, ...)
	
	return handler
end

function error(text, caption, ...)
	return new(text, caption, errorIcon, ...)
end

function warning(text, caption, ...)
	return new(text, caption, warningIcon, ...)
end

function question(text, caption, ...)
	return new(text, caption, questionIcon, ...)
end

function info(text, caption, ...)
	return new(text, caption, infoIcon, ...)
end

function user(text, caption, picture, ...)
	local args = {...}
	
	table.insert(args, 1, picture)
	
	return new(text, caption, userIcon, unpack(args))
end

function text(text, caption, ...)
	return new(text, caption, '', ...)
end

-- HOWTO:
-- local text = 'Text text text'
-- local caption = 'Warning!'
-- up to 4 buttons
-- local button1Text = 'OK'
-- local button2Text = 'Cancel'
-- local handler = MsgWindow.warning(text, caption, button1Text, button2Text)
-- or 
-- local handler = MsgWindow.error(text, caption, button1Text, button2Text)
-- or 
-- local handler = MsgWindow.question(text, caption, button1Text, button2Text)
-- or 
-- local handler = MsgWindow.info(text, caption, button1Text, button2Text)
-- or 
-- local picture = Picture.new('.../pic.png')
-- local handler = MsgWindow.user(text, caption, picture, button1Text, button2Text)
-- or 
-- local filename = '.../msg_wnd.dlg'
-- local iconType = MsgWindow.warningIcon
-- local handler = MsgWindow.newFromResource(filename, text, caption, iconType, button1Text, button2Text)

-- set handler functions

-- function handler:onClose()
	-- return true if you don't want to close window on close button
-- end

-- function handler:onChange(buttonText)
	-- if buttonText == ok then
	-- ...
	-- else 
	-- ...
	-- end
	
	-- return true if you don't want window to be closed
-- end

-- handler:show()
-- program continues executions at this point after window has been closed