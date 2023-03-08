local base = _G

module('Widget')
mtab = { __index = _M}

local type				= base.type
local require			= base.require
local unpack			= base.unpack
local print				= base.print
local debug				= base.debug
		
local Factory			= require('Factory')
local gui				= require('dxgui')

local soundCallback		= nil

function new()
	base.error('Widget is abstract class for widgets and cannot be created immediately! Use Static instead!')
end

widgets = {} -- таблица соответсвия между объектами Lua и С
callbacks = {} -- таблица соответсвия калбеков

function construct(self, text)
	self.widget = self:newWidget()
	widgets[self.widget] = self
	self:setText(text)

	self.zIndex = 0
end

function register(self, widgetPtr)
	self.widget = widgetPtr
	widgets[self.widget] = self	
end

function destroy(self)
	gui.WidgetDestroy(self.widget)
	widgets[self.widget] = nil
	self.widget = nil
end

function getTypeName(self)
	return gui.WidgetGetTypeName(self.widget)
end

-- контейнеры должны переопределять эту функцию,
-- чтобы в клонах была возможность обращаться к виджетам по имени
function copyWidgetNames(self, clone)
end

function getZIndex(self)
	return self.zIndex
end

function setZIndex(self, idx)
	self.zIndex = idx or 0
end

function setText(self, text)
	gui.WidgetSetText(self.widget, text)
end

function getText(self)
	return gui.WidgetGetText(self.widget)
end

function setVisible(self, visible)
	gui.WidgetSetVisible(self.widget, visible)
end

function getVisible(self, checkParentVisibility)
	return gui.WidgetGetVisible(self.widget, checkParentVisibility)
end

function isVisible(self)
	return self:getVisible()
end

function setEnabled(self, enabled)
	gui.WidgetSetEnabled(self.widget, enabled)
end

function getEnabled(self)
	return gui.WidgetGetEnabled(self.widget)
end

function setFocused(self, focus)
	onFocus(self, focus);
	gui.WidgetSetFocused(self.widget, focus)
end

function getFocused(self)
	return gui.WidgetGetFocused(self.widget)
end

function setBounds(self, x, y, w, h)
	self:setPosition(x, y)
	self:setSize(w, h)
end

function getBounds(self)
	local x, y = self:getPosition()
	local w, h = self:getSize()

	return x, y, w, h
end

function setPosition(self, x, y)
	gui.WidgetSetPosition(self.widget, x, y)
end

function getPosition(self)
	local x, y = gui.WidgetGetPosition(self.widget)
	return x, y
end

-- установить размер виджета
function setSize(self, width, height, no_cb)
	gui.WidgetSetSize(self.widget, width, height)
end

function getSize(self)
	local w, h = gui.WidgetGetSize(self.widget)
	return w, h
end

function getClientRect(self)
	local x, y, w, h = gui.WidgetGetClientRect(self.widget)

	return x, y, w, h
end

function getClientRectSize(self)
	local x, y, w, h = gui.WidgetGetClientRect(self.widget)

	return w, h
end

-- возвращает width, height
function calcSize(self)
	local width, height = gui.WidgetCalcSize(self.widget)

	return width, height
end

function updateSize(self)
	gui.WidgetUpdateSize(self.widget)
end

function setSkin(self, skin)
	gui.WidgetSetSkin(self.widget, skin)
end

function getSkin(self)
	local skin = gui.WidgetGetSkin(self.widget)

	return skin
end

-- возвращает x, y
function windowToWidget(self, x, y)
	return gui.ScreenToWidget(self.widget, x, y)
end

-- возвращает x, y
function widgetToWindow(self, x, y)
	return gui.WidgetToScreen(self.widget, x, y)
end

function setTooltipText(self, text)
	gui.WidgetSetTooltipText(self.widget, text)
end

function getTooltipText(self)
	return gui.WidgetGetTooltipText(self.widget)
end

function setTooltipSkin(self, skin)
	gui.WidgetSetTooltipSkin(self.widget, skin)
end

function getTooltipSkin(self)
	return gui.WidgetGetTooltipSkin(self.widget)
end

function setResourceString(self, text)
	gui.WidgetSetResourceString(self.widget, text)
end

function getResourceString(self)
	return gui.WidgetGetResourceString(self.widget)
end

function setZoom(self, zoom)
	gui.WidgetSetZoom(self.widget, zoom)
end

function getZoom(self)
	return gui.WidgetGetZoom(self.widget)
end

function setOpacity(self, opacity)
	gui.WidgetSetOpacity(self.widget, opacity)
end

function getOpacity(self)
	return gui.WidgetGetOpacity(self.widget)
end

function setDrawToTarget(self, needDrawToTarget)
	gui.WidgetSetDrawToTarget(self.widget, needDrawToTarget)
end

function getDrawToTarget(self, needDrawToTarget)
	return gui.WidgetGetDrawToTarget(self.widget)
end

function captureMouse(self)
	gui.WidgetCaptureMouse(self.widget)
end

function releaseMouse(self)
	gui.WidgetReleaseMouse(self.widget)
end


-- FIXME: remove it
function setWrapping(self, wrapping)
	local skin = self:getSkin()

	skin.skinData.params.textWrapping = wrapping
	self:setSkin(skin)
end

function setUpdateFunction(self, func)
	if func then
		local startTime = gui.WidgetSetUpdateFunction(self.widget, function(widget, elapsedTime) func(widgets[widget], elapsedTime) end)

		return startTime
	end

	gui.WidgetSetUpdateFunction(self.widget, nil)
end

function onPlaySound(self)
	if soundCallback then
		local sound = self:getSound()
		
		if sound then
			soundCallback(sound)
		end
	end
end

function setSoundCallback(callback)
	soundCallback = callback
end

function setSound(self, filename)
	self.sound = filename
end

function getSound(self)
	return self.sound
end

-- допустимые типы калбеков: "down", "up"
-- callback это функция вида function(self, keyName, unicode) ... end
-- список keyName находится в файле KeyNames.txt
function addKeyboardCallback(self, callbackType, callback)
	local func = function(keyName, unicode)
		return callback(self, keyName, unicode)
	end
	
	callbacks[callback] = func
	
	gui.WidgetAddKeyboardCallback(self.widget, callbackType, func)
end

function addKeyDownCallback(self, callback)
	self:addKeyboardCallback('down', callback)
end

function addKeyUpCallback(self, callback)
	self:addKeyboardCallback('up', callback)
end

-- допустимые типы калбеков: "down", "up"
function removeKeyboardCallback(self, callbackType, callback)
	gui.WidgetRemoveKeyboardCallback(self.widget, callbackType, callbacks[callback])
	callbacks[callback] = nil
end

-- допустимые типы калбеков: "move", "down", "double down", "up", "wheel", "released", "enter", "leave"
-- callback это функция вида function(self, x, y, button) ... end
function addMouseCallback(self, callbackType, callback)
	local func = function(x, y, button)
		callback(self, x, y, button)
	end
	
	callbacks[callback] = func
	
	gui.WidgetAddMouseCallback(self.widget, callbackType, func)
end

function addMouseMoveCallback(self, callback)
	self:addMouseCallback('move', callback)
end

function addMouseDownCallback(self, callback)
	self:addMouseCallback('down', callback)
end

function addMouseDoubleDownCallback(self, callback)
	self:addMouseCallback('double down', callback)
end

function addMouseUpCallback(self, callback)
	self:addMouseCallback('up', callback)
end

function addMouseReleasedCallback(self, callback)
	self:addMouseCallback('released', callback)
end

function addMouseEnterCallback(self, callback)
	self:addMouseCallback('enter', callback)
end

function addMouseLeaveCallback(self, callback)
	self:addMouseCallback('leave', callback)
end

-- допустимые типы калбеков: "move", "down", "double down", "up", "wheel", "released", "enter", "leave"
function removeMouseCallback(self, callbackType, callback)
	gui.WidgetRemoveMouseCallback(self.widget, callbackType, callbacks[callback])
	callbacks[callback] = nil
end

function addMouseWheelCallback(self, callback)
	local func = function(x, y, clicks)
		return callback(self, x, y, clicks)
	end
	
	callbacks[callback] = func
	
	gui.WidgetAddMouseWheelCallback(self.widget, func)
end

function removeMouseWheelCallback(self, callback)	
	gui.WidgetRemoveMouseWheelCallback(self.widget, callbacks[callback])
	callbacks[callback] = nil
end

local widgetChangeCallbackType		= 'widget change'
local widgetFocusCallbackType		= 'widget focus'
local widgetPositionCallbackType	= 'widget position'
local widgetSizeCallbackType		= 'widget size'

-- callback это функция вида function(self) ... end
function addCallback(self, callbackType, callback)
	local func = function()
		if widgetChangeCallbackType == callbackType then
			self:onPlaySound()
		end	
		
		callback(self)
	end
	
	callbacks[callback] = func
	
	gui.WidgetAddCallback(self.widget, callbackType, func)
end

function removeCallback(self, callbackType, callback)
	gui.WidgetRemoveCallback(self.widget, callbackType, callbacks[callback])
	callbacks[callback] = nil
end

function addChangeCallback(self, callback)
	self:addCallback(widgetChangeCallbackType, callback)
end

function removeChangeCallback(self, callback)
	self:removeCallback(widgetChangeCallbackType, callback)
end

function addFocusCallback(self, callback)
	self:addCallback(widgetFocusCallbackType, callback)
end

function removeFocusCallback(self, callback)
	self:removeCallback(widgetFocusCallbackType, callback)
end

function addPositionCallback(self, callback)
	self:addCallback(widgetPositionCallbackType, callback)
end

function removePositionCallback(self, callback)
	self:removeCallback(widgetPositionCallbackType, callback)
end

function addSizeCallback(self, callback)
	self:addCallback(widgetSizeCallbackType, callback)
end

function removeSizeCallback(self, callback)
	self:removeCallback(widgetSizeCallbackType, callback)
end

function setTabOrder(self, tabOrder)
	gui.WidgetSetTabOrder(self.widget, tabOrder)
end

function getTabOrder(self)
	return gui.WidgetGetTabOrder(self.widget)
end

function setName(self, name)
	gui.WidgetSetName(self.widget, name)
end

function getName(self)
	return gui.WidgetGetName(self.widget)
end

function findByName(self, name)
	local widget = gui.WidgetFindWidgetByName(self.widget, name)
	
	if widget then
		return widgets[widget]
	end	
end

function getRoot(self)
	local widget = gui.WidgetGetRoot(self.widget)
	
	if widget then
		return widgets[widget]
	end
end

function localize(self, localization)
	gui.WidgetLocalize(self.widget, localization)
end

function setShaderEffect(self, name, params)
	gui.WidgetSetShaderEffect(self.widget, name, params)
end

function getRootSurfaceId(self)
	return gui.WidgetGetRootSurfaceId(self.widget)
end

function redraw(self)
	gui.WidgetRedraw(self.widget)
end

function onMouseMove(self, x, y)
	
end

function onMouseDown(self, x, y, button)

end

function onMouseUp(self, x, y, button)

end

function onMouseDoubleClick(self, x, y, button)

end

-- возвращает true, если виджет обработал это событие
function onMouseWheel(self, x, y, clicks)
	return false
end

function onMouseReleased(self, x, y)

end

function onFocus(self, focused)

end

function onKeyDown(self, keyName, unicode)

end

function onKeyUp(self, keyName, unicode)

end

function onChange(self)
end
