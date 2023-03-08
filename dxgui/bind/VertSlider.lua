local base = _G

module('VertSlider')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Slider = base.require('Slider')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Slider)

function new()
  return Factory.create(_M)
end

function newWidget(self)
  return gui.NewVertSlider()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.VertSliderClone(self.widget)
end