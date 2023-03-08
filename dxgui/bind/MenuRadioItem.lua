local base = _G

module('MenuRadioItem')
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
  return gui.NewMenuRadioItem()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.MenuRadioItemClone(self.widget)
end

function setGroupNumber(self, number)
  gui.MenuRadioItemSetGroupNumber(self.widget, number)
end

function getGroupNumber(self)
  return gui.MenuRadioItemGetGroupNumber(self.widget)
end

function setState(self, state)
  gui.MenuRadioItemSetState(self.widget, state)
end

function getState(self)
  return gui.MenuRadioItemGetState(self.widget)
end

