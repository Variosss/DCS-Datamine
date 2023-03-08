local base = _G

module('Window')
mtab = { __index = _M }

local require		= base.require
local print			= base.print
local ipairs		= base.ipairs
local pairs			= base.pairs
local table			= base.table

local Factory		= require('Factory')
local Widget		= require('Widget')
local LayoutFactory	= require('LayoutFactory')
local gui			= require('dxgui')

Factory.setBaseClass(_M, Widget)

function new(x, y, w, h, text)
	local window = Factory.create(_M, x, y, w, h, text) 

	return	window
end

function construct(self, x, y, w, h, text)
	Widget.construct(self, text)
	
	if h then
		self:setBounds(x, y, w, h)
	end

	self:addCloseCallback(function()
		self:onClose()
	end)
end

function newWidget(self)
	return gui.NewWindow()
end

function clone(self)
	local result = Factory.clone(_M, self)

	self:copyWidgetNames(result)
	
	return result
end

function copyWidgetNames(self, clone)
	local count = self:getWidgetCount()
	
	for i = 1, count do
		local index 		= i - 1
		local widget 		= self:getWidget(index)
		local cloneWidget 	= clone:getWidget(index)
		
		for name, param in base.pairs(self) do
			if param == widget then
				clone[name] = cloneWidget
				
				break
			end
		end
		
		widget:copyWidgetNames(cloneWidget)
	end
end

function createClone(self)
	return gui.WindowClone(self.widget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local count = self:getWidgetCount()
	
	for i = 1, count do
		local itemPtr = gui.WindowGetWidget(self.widget, i - 1)
		local typeName = gui.WidgetGetTypeName(itemPtr)
		
		Factory.registerWidget(typeName, itemPtr)
	end
end

function close(self)
	gui.WindowClose(self.widget)
end

function kill(self)
	gui.WindowKill(self.widget)	
end

-- добавить виджет в окно 
-- index - индекс виджета
-- если index = -1 или nil, то добавляется в конец списка виджетов
-- от index зависит порядок рисования виджетов
-- виджеты, добавленные последними будут рисоваться последними
-- порядок рисования виджетов важен, если виджеты накладываются один поверх другого
function insertWidget(self, widget, index)
	gui.WindowInsertWidget(self.widget, widget.widget, index)
end

-- удалить виджет из окна
function removeWidget(self, widget)
	gui.WindowRemoveWidget(self.widget, widget.widget)
end

function removeAllWidgets(self)
	gui.WindowRemoveAllWidgets(self.widget)
end

function getWidgetCount(self)
	return gui.WindowGetWidgetCount(self.widget)
end

function getWidget(self, index)
	return widgets[gui.WindowGetWidget(self.widget, index)]
end

function clear(self)
	gui.WindowClear(self.widget)
end

-- оверлейные виджеты - они рисуются поверх всех виджетов 
-- и не реагируют на пользовательский ввод
function insertOverlayWidget(self, widget, index)
	gui.WindowInsertOverlayWidget(self.widget, widget.widget, index)
end

function removeOverlayWidget(self, widget)
	gui.WindowRemoveOverlayWidget(self.widget, widget.widget)
end

function getOverlayWidgetCount(self)
	return gui.WindowGetOverlayWidgetCount(self.widget)
end

function getOverlayWidget(self, index)
	return widgets[gui.WindowGetOverlayWidget(self.widget, index)]
end

function centerWindow(self)
	gui.WindowCenterWindow(self.widget)
end

function setHasCursor(self, hasCursor)
	gui.WindowSetHasCursor(self.widget, hasCursor)
end

function getHasCursor(self)
	return gui.WindowGetHasCursor(self.widget)
end

function pushMouseCursor(self, cursor)
	gui.WindowPushMouseCursor(self.widget, cursor)
end

function popMouseCursor(self)
	gui.WindowPopMouseCursor(self.widget)
end

function getMouseCursor(self)
	return gui.WindowGetMouseCursor(self.widget)
end

function setDraggable(self, draggable)
	gui.WindowSetDraggable(self.widget, draggable)
end

function getDraggable(self)
	return gui.WindowGetDraggable(self.widget)
end

function setResizable(self, resizable)
	gui.WindowSetResizable(self.widget, resizable)
end

function getResizable(self)
	return gui.WindowGetResizable(self.widget)
end

function setClipResizeCursor(self, clip)
	gui.WindowSetClipResizeCursor(self.widget, clip)
end

function getClipResizeCursor(self)
	return gui.WindowGetClipResizeCursor(self.widget)
end

function setActive(self, active)
	gui.WindowSetActive(self.widget, active)
end

function getActive(self)
	return gui.WindowGetActive(self.widget)
end

function setZOrder(self, zOrder)
	gui.WindowSetZOrder(self.widget, zOrder)
end

function getZOrder(self)
	return gui.WindowGetZOrder(self.widget)
end

function onClose(self)
	self:setVisible(false)
end

function addCloseCallback(self, callback)
	self:addCallback('window close', callback)
end

function setTitleHeight(self, height)
	local skin = self:getSkin()
	
	skin.skinData.params.headerHeight = height
	self:setSkin(skin)
end

function setLayout(self, layout)
	if layout then
		layout = layout.layout
	end
	
	gui.WindowSetLayout(self.widget, layout)
end

function getLayout(self)
	return LayoutFactory.bindLayout(gui.WindowGetLayout(self.widget))
end

function parseHotKey(hotKeyString)
	local hotKey = {
		button			= nil,
		altPressed		= false,
		ctrlPressed		= false,
		shiftPressed	= false,	
	}
	
	hotKeyString = base.string.lower(hotKeyString)
	
	-- заменяем экранированный + на слово plus
	hotKeyString = base.string.gsub(hotKeyString, '\\%+', 'plus')
	
	-- разбиваем строку на блоки разделенные символом + и удаляем лишние пробелы
	for w in base.string.gmatch(hotKeyString, '([^%+%s]+)') do 
		if 		'alt' == w then
			hotKey.altPressed = true
		elseif	'ctrl' == w then
			hotKey.ctrlPressed = true
		elseif	'shift' == w then
			hotKey.shiftPressed = true
		else
			hotKey.button = base.string.gsub(w, 'plus', '+') -- заменяем обратно слово plus на символ +
		end
	end
	
	return hotKey
end

-- hot key задается строкой вида: [modifier1+][modifier2+][modifier3+]buttonName
-- в квадратных скобках опциональные значения
-- порядок модификаторов неважен и регистр букв неважен
-- допустимые значения модификаторов: Ctrl, Alt, Shift
-- имя кнопки берется из файла KeyNames.txt
-- в качестве горячих кнопок могут быть использованы не все кнопки,
-- а только те, символы с которых вводятся без зажатой клавиши shift
-- например, кнопки '*' и '8' находятся на одной клавише
-- для хоткея нужно использовать имя '8'
-- например: "Ctrl+S", "s + Ctrl", "escape", "return", "Ctrl+Alt+N"
-- чтобы задать хоткей на кнопку + на нумпаде (в KeyNames.txt это [+]) 
-- нужно значек + экранировать символами \\
-- например хоткей на alt + [+] должен быть записан как "alt+[\\+]"
-- если написать "alt+[+]" то это будет воспринято как комбинация 3-х кнопок - alt, [ и ]
function addHotKeyCallback(self, hotKeyString, callback)
	gui.WindowAddHotKeyCallback(self.widget, parseHotKey(hotKeyString), callback)
end

function removeHotKeyCallback(self, hotKeyString, callback)
	gui.WindowRemoveHotKeyCallback(self.widget, parseHotKey(hotKeyString), callback)
end

function setAsWidget(self, asWidget)
	gui.WindowSetAsWidget(self.widget, asWidget)
end

function getAsWidget(self)
	return gui.WindowGetAsWidget(self.widget)
end

function setNextWidgetFocused(self)
	gui.SetNextWidgetFocused(self.widget)
end

function getViewBounds(self)
	local x, y, w, h = gui.WindowGetViewBounds(self.widget)
	
	return x, y, w, h
end

function setTransparentForUserInput(self, transparent)
	gui.WindowSetTransparentForUserInput(self.widget, transparent)
end

function getTransparentForUserInput(self)
	return gui.WindowGetTransparentForUserInput(self.widget)
end

function setSurfaceId(self, id)
	-- id получен из функции gui.CreateSurface()
	gui.WindowSetSurfaceId(self.widget, id)
end

function getSurfaceId(self)
	-- 0 для окон, которые рисуются на экране
	return gui.WindowGetSurfaceId(self.widget)
end