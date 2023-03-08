local base = _G

module('Static')
mtab = { __index = _M}

local Factory = base.require('Factory')
local gui = base.require('dxgui')
local Widget = base.require('Widget')

Factory.setBaseClass(_M, Widget)

function new(text)
	return Factory.create(_M, text)
end

function construct(self, text)
	Widget.construct(self, text)
end

function newWidget(self)
	return gui.NewStatic()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.StaticClone(self.widget)
end

function setAngle(self, degrees)
	gui.StaticSetAngle(self.widget, degrees)
end

function getAngle(self)
	return gui.StaticGetAngle(self.widget)
end

function setPivotPoint(self, x, y)
	gui.StaticSetPivotPoint(self.widget, x, y)
end

function getPivotPoint(self)
	local x, y = gui.StaticGetPivotPoint(self.widget)
	
	return x, y
end

function getTextLinesCount(self)
	return gui.StaticGetTextLinesCount(self.widget)
end

function getTextLines(self)
	return gui.StaticGetTextLines(self.widget)
end
