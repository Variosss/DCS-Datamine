local base = _G

module('MenuItem')
mtab = { __index = _M }

local Factory	= base.require('Factory')
local Widget	= base.require('Widget'	)
local dxgui		= base.require('dxgui'	)

Factory.setBaseClass(_M, Widget)

function new(text)
	return Factory.create(_M, text)
end

function construct(self, text)
	Widget.construct(self, text)
end

function newWidget(self)
	return dxgui.NewMenuItem()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return dxgui.MenuItemClone(self.widget)
end

function setShortcut(self, shortcut)
	dxgui.MenuItemSetShortcut(self.widget, shortcut)
end

function getShortcut(self)
	return dxgui.MenuItemGetShortcut(self.widget)
end