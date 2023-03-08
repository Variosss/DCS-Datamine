local base = _G

module('MenuBarItem')
mtab = { __index = _M}

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function new(text, menu)
	return Factory.create(_M, text, menu)
end

function construct(self, text, menu)
	Widget.construct(self, text)
	self:setMenu(menu)
	self.menuName = ''
end

function newWidget(self)
	return gui.NewMenuBarItem()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.MenuBarItemClone(self.widget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local menuPtr = gui.MenuBarItemGetMenu(widgetPtr)
	local typeName = gui.WidgetGetTypeName(menuPtr)
	
	Factory.registerWidget(typeName, menuPtr)
end

function setMenu(self, menu)
	if menu then
		menu = menu.widget
	end
	
	gui.MenuBarItemSetMenu(self.widget, menu)
end

function getMenu(self)
	return widgets[gui.MenuBarItemGetMenu(self.widget)]
end

function setMenuName(self, menuName)
	self.menuName = menuName
end

function getMenuName(self)
	return self.menuName
end