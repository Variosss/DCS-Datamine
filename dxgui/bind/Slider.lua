local base = _G

module('Slider')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function construct(self)
	Widget.construct(self)
	
	self:addChangeCallback(function()
		self:onChange()
	end)
end

function setValue(self, value)
	gui.SliderSetValue(self.widget, value)
end

function getValue(self)
	return gui.SliderGetValue(self.widget)
end

function setStep(self, step)
	gui.SliderSetStep(self.widget, step)
end

function getStep(self)
	return gui.SliderGetStep(self.widget)
end

function setPageStep(self, step)
	gui.SliderSetPageStep(self.widget, step)
end

function getPageStep(self)
	return gui.SliderGetPageStep(self.widget)
end

function setRange(self, min, max)
	if min and max then
		gui.SliderSetRange(self.widget, min, max)
	else
		base.print('Invalid range value!')
	end
end

function getRange(self)
	return gui.SliderGetRange(self.widget)
end

-- пользователь нажал на ползунок
function addThumbPressedCallback(self, callback)
	self:addCallback('thumb pressed', callback)
end

-- пользователь отпустил ползунок
function addThumbReleasedCallback(self, callback)
	self:addCallback('thumb released', callback)
end
