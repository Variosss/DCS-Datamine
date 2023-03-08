local base = _G

module('Menu')
mtab = { __index = _M }

local require			= base.require
local Factory			= require('Factory'				)
local Widget			= require('Widget'				)
local gui				= require('dxgui'				)
local MenuItem			= require('MenuItem'			)
local MenuRadioItem		= require('MenuRadioItem'		)
local MenuCheckItem		= require('MenuCheckItem'		)
local MenuSeparatorItem	= require('MenuSeparatorItem'	)
local MenuSubItem		= require('MenuSubItem'			)

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	
	self:addChangeCallback(function()
		self:onChange(self:getSelectedItem())
	end)
	
	local hotKey = base.require('Window').parseHotKey('escape')
	
	gui.WindowAddHotKeyCallback(self.widget, hotKey, function()
		self:setVisible(false)
	end)
end

function newWidget(self)
	return gui.NewMenu()
end

function kill(self)
	gui.WindowKill(self.widget)	
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.MenuClone(self.widget, Factory.registerWidget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local count = self:getItemCount()
	
	for i = 1, count do
		local itemPtr = gui.MenuGetItem(self.widget, i - 1)
		local typeName = gui.WidgetGetTypeName(itemPtr)
		
		Factory.registerWidget(typeName, itemPtr)
	end
end

-- index - опционально
-- если index = -1 или index = nil то item добавляется в конец списка
function insertItem(self, item, index)
	gui.MenuInsertItem(self.widget, item.widget, index)
end

function getItem(self, index)
	return widgets[gui.MenuGetItem(self.widget, index)]
end

function removeItem(self, item)
	gui.MenuRemoveItem(self.widget, item.widget)	
end

function removeAllItems(self)
	gui.MenuRemoveAllItems(self.widget)
end

function clear(self)
	gui.MenuClear(self.widget)
end

function getItemIndex(self, item)
	return gui.MenuGetItemIndex(self.widget, item.widget)
end

function getItemCount(self)
	return gui.MenuGetItemCount(self.widget)
end

function newItem(self, text, index)
	local item = MenuItem.new(text)
	
	self:insertItem(item, index)
	
	return item
end

function newRadioItem(self, text, index)
	local item = MenuRadioItem.new(text)
	
	self:insertItem(item, index)
	
	return item
end

function newCheckItem(self, text, index)
	local item = MenuCheckItem.new(text)
	
	self:insertItem(item, index)
	
	return item
end

function newSeparatorItem(self, index)
	local item = MenuSeparatorItem.new()
	
	self:insertItem(item, index)
	
	return item
end

function newSubItem(self, text, index)
	local item = MenuSubItem.new(text)
	
	self:insertItem(item, index)
	
	return item
end

-- получить выбранный пользователем итем в onChange
function getSelectedItem(self)
	return widgets[gui.MenuGetSelectedItem(self.widget)]
end

-- получить активный итем в калбеке addItemMouseInCallback
function getMouseInsideItem(self)
	return widgets[gui.MenuGetMouseInsideItem(self.widget)]
end

function setAsWidget(self, asWidget)
	gui.WindowSetAsWidget(self.widget, asWidget)
end

function getAsWidget(self)
	return gui.WindowGetAsWidget(self.widget)
end

function addItemMouseInCallback(self, callback)
	self:addCallback('menu item mouse in', callback)
end

function addItemMouseOutCallback(self, callback)
	self:addCallback('menu item mouse out', callback)
end

function setSurfaceId(self, id)
	-- id получен из функции gui.CreateSurface()
	gui.WindowSetSurfaceId(self.widget, id)
end

function getSurfaceId(self)
	-- 0 для окон, которые рисуются на экране
	return gui.WindowGetSurfaceId(self.widget)
end
