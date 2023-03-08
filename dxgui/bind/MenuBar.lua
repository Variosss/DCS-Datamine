local base = _G

module('MenuBar')
mtab = { __index = _M}

local require			= base.require
local print				= base.print

local Factory			= require('Factory')
local Widget			= require('Widget')
local LayoutFactory		= require('LayoutFactory')
local gui				= require('dxgui')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
end

function newWidget(self)
	return gui.NewMenuBar()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.MenuBarClone(self.widget, Factory.registerWidget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local count = self:getItemCount()
	
	for i = 1, count do
		local itemPtr = gui.MenuBarGetItem(self.widget, i - 1)
		local typeName = gui.WidgetGetTypeName(itemPtr)
		
		Factory.registerWidget(typeName, itemPtr)
	end
end

function insertItem(self, item, index)
	gui.MenuBarInsertItem(self.widget, item.widget, index)
end

function getItem(self, index)
	return widgets[gui.MenuBarGetItem(self.widget, index)]
end

function removeItem(self, item) 
	gui.MenuBarRemoveItem(self.widget, item.widget)
end

function clear(self)
	self:removeAllItems()
end

function removeAllItems(self)
	gui.MenuBarRemoveAllItems(self.widget)
end

function clear(self)
	gui.MenuBarClear(self.widget)
end

function getItemCount(self)
	return gui.MenuBarGetItemCount(self.widget)
end

function setLayout(self, layout)
	if layout then
		layout = layout.layout
	end
	
	gui.MenuBarSetLayout(self.widget, layout)
end

function getLayout(self)
	return LayoutFactory.bindLayout(gui.MenuBarGetLayout(self.widget))
end