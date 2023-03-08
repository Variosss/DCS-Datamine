local base = _G

module('RangeIndicator')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function construct(self)
	Widget.construct(self)
end

function setRange(self, min, max)
	gui.RangeIndicatorSetRange(self.widget, min, max)
end

function getRange(self)
	local min, max = gui.RangeIndicatorGetRange(self.widget)
	
	return min, max
end

function setValueRange(self, valueMin, valueMax)
	gui.RangeIndicatorSetValueRange(self.widget, valueMin, valueMax)
end

function getValueRange(self)
	local valueMin, valueMax = gui.RangeIndicatorGetValueRange(self.widget)
	
	return valueMin, valueMax
end
