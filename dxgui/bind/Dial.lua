local base = _G

module('Dial')
mtab = { __index = _M}

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	
	self:addChangeCallback(function()
		self:onChange()
	end)
end

function newWidget(self)
	return gui.NewDial()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.DialClone(self.widget)
end

function setValue(self, value)
	gui.DialSetValue(self.widget, value)
end

function getValue(self)
	return gui.DialGetValue(self.widget)
end

function setStep(self, step)
	gui.DialSetStep(self.widget, step)
end

function getStep(self)
	return gui.DialGetStep(self.widget)
end

function setPageStep(self, step)
	gui.DialSetPageStep(self.widget, step)
end

function getPageStep(self)
	return gui.DialGetPageStep(self.widget)
end

function setRange(self, min, max)
	if min and max then
		gui.DialSetRange(self.widget, min, max)
	else
		base.print('Invalid range value!')
	end
end

function getRange(self)
	return gui.DialGetRange(self.widget)
end

function getCyclic(self)
	return gui.DialGetCyclic(self.widget)
end

function setCyclic(self, cyclic)
	gui.DialSetCyclic(self.widget, cyclic)
end
