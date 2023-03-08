local base = _G

module('MenuSeparatorItem')
mtab = { __index = _M }

local Factory = base.require('Factory')
local MenuItem = base.require('MenuItem')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, MenuItem)

function new()
  return Factory.create(_M)
end

function construct(self)
  MenuItem.construct(self)
end

function newWidget(self)
  return gui.NewMenuSeparatorItem()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.MenuSeparatorItemClone(self.widget)
end