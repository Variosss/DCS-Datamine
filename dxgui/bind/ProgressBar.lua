local base = _G

module('ProgressBar')
mtab = { __index = _M }

local Factory	= base.require('Factory')
local Widget	= base.require('Widget')
local gui		= base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function construct(self)
	Widget.construct(self)
end

function setRange(self, min, max)
	if min and max then
		gui.ProgressBarSetRange(self.widget, min, max)
	else
		base.print('Invalid range value!')
	end
end

function getRange(self)
	return gui.ProgressBarGetRange(self.widget)
end

function setValue(self, value)
	gui.ProgressBarSetValue(self.widget, value)
end

function getValue(self)
	return gui.ProgressBarGetValue(self.widget)
end

function setStep(self, step)
	self.step = step
	
	return gui.ProgressBarSetStep(self.widget, step)	
end

function getStep(self)
	return gui.ProgressBarGetStep(self.widget)
end

function makeStep(self)
	return gui.ProgressBarMakeStep(self.widget)
end
