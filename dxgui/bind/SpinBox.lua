local base = _G

module('SpinBox')
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
	
	self:addChangeCallback(function(self)
		self:onChange()
	end)
end

function newWidget(self)
	return gui.NewSpinBox()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.SpinBoxClone(self.widget)
end

function setValue(self, value)
	gui.SpinBoxSetValue(self.widget, value)
end

function getValue(self)
	return gui.SpinBoxGetValue(self.widget)
end

function setStep(self, step)
	gui.SpinBoxSetStep(self.widget, step)
end

function getStep(self)
	return gui.SpinBoxGetStep(self.widget)
end

function setPageStep(self, step)
	gui.SpinBoxSetPageStep(self.widget, step)
end

function getPageStep(self)
	return gui.SpinBoxGetPageStep(self.widget)
end

function setRange(self, min, max)
	if min and max then
		gui.SpinBoxSetRange(self.widget, min, max)
	else
		base.print('Invalid range value!')
	end
end

function getRange(self)
	return gui.SpinBoxGetRange(self.widget)
end

function setCheckRange(self, checkRange)
	gui.SpinBoxSetCheckRange(self.widget, checkRange)
end

function getCheckRange(self)
	return gui.SpinBoxGetCheckRange(self.widget)
end

function setAcceptDecimalPoint(self, accept)
	gui.SpinBoxSetAcceptDecimalPoint(self.widget, accept)
end

function getAcceptDecimalPoint(self)
	return gui.SpinBoxGetAcceptDecimalPoint(self.widget)
end

-- для целых использовать  "%05g" 
function setFormatString(self, formatString)
	gui.SpinBoxSetFormatString(self.widget, formatString)
end

function getFormatString(self)
	return gui.SpinBoxGetFormatString(self.widget)
end

function setButtonsVisible(self, visible)
	gui.SpinBoxSetButtonsVisible(self.widget, visible)
end

function getButtonsVisible(self)
	return gui.SpinBoxGetButtonsVisible(self.widget)
end

function selectAll(self)
	return gui.SpinBoxSelectAll(self.widget)
end

