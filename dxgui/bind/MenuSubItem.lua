local base = _G

module('MenuSubItem')
mtab = { __index = _M }

local Factory = base.require('Factory')
local MenuItem = base.require('MenuItem')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, MenuItem)

function new(text, menu)
	return Factory.create(_M, text, menu)
end
	
function construct(self, text, menu)
	MenuItem.construct(self, text)
	self:setSubmenu(menu)
	self.menuName = ''
end

function newWidget(self)
	return gui.NewMenuSubItem()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.MenuSubItemClone(self.widget)
end

function setSubmenu(self, submenu)
	if submenu then
		submenu = submenu.widget
	end
	
	gui.MenuSubItemSetSubmenu(self.widget, submenu)
end

function getSubmenu(self)
	return widgets[gui.MenuSubItemGetSubmenu(self.widget)]
end

function setMenuName(self, menuName)
	self.menuName = menuName
end

function getMenuName(self)
	return self.menuName
end
