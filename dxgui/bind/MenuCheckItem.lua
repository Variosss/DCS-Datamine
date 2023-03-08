local base = _G

module('MenuCheckItem')
mtab = { __index = _M }

local Factory = base.require('Factory')
local MenuItem = base.require('MenuItem')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, MenuItem)

function new(text)
  return Factory.create(_M, text)
end

function construct(self, text)
  MenuItem.construct(self, text)
end

function newWidget(self)
  return gui.NewMenuCheckItem()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.MenuCheckItemClone(self.widget)
end

function setState(self, state)
  gui.MenuCheckItemSetState(self.widget, state)
end

function getState(self)
  return gui.MenuCheckItemGetState(self.widget)
end
