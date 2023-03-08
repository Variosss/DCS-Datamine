local base = _G

module('VertScrollBar')
mtab = { __index = _M }

local Factory = base.require('Factory')
local ScrollBar = base.require('ScrollBar')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, ScrollBar)

function new()
  return Factory.create(_M)
end

function newWidget(self)
  return gui.NewVertScrollBar()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.VertScrollBarClone(self.widget)
end