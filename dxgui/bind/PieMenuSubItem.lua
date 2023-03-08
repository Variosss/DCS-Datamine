local base = _G

module('PieMenuSubItem')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function new(text)
  return Factory.create(_M, text)
end

function construct(self, text)
  Widget.construct(self, text)
end

function newWidget(self)
  return gui.NewPieMenuSubItem()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.PieMenuSubItemClone(self.widget)
end

function setSubmenu(self, submenu)
	if submenu then
		submenu = submenu.widget
	end
	
	gui.PieMenuSubItemSetSubmenu(self.widget, submenu)
end

function getSubmenu(self)
	return widgets[gui.PieMenuSubItemGetSubmenu(self.widget)]
end

function setMenuName(self, menuName)
	self.menuName = menuName
end

function getMenuName(self)
	return self.menuName
end