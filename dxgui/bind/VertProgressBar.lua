local base = _G

module('VertProgressBar')
mtab = { __index = _M }

local Factory = base.require('Factory')
local ProgressBar = base.require('ProgressBar')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, ProgressBar)

function new()
  return Factory.create(_M)
end

function newWidget()
  return gui.NewVertProgressBar()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.VertProgressBarClone(self.widget)
end
