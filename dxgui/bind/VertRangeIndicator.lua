local base = _G

module('VertRangeIndicator')
mtab = { __index = _M }

local Factory			= base.require('Factory')
local RangeIndicator	= base.require('RangeIndicator')
local gui				= base.require('dxgui')

Factory.setBaseClass(_M, RangeIndicator)

function new()
  return Factory.create(_M)
end

function newWidget()
  return gui.NewVertRangeIndicator()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.VertRangeIndicatorClone(self.widget)
end
