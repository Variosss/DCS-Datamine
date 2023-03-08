local base = _G

module('ScrollBar')
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
	gui.ScrollBarSetValue(self.widget, value)
end

function getValue(self)
	return gui.ScrollBarGetValue(self.widget)
end

function setStep(self, step)
	gui.ScrollBarSetStep(self.widget, step)
end

function getStep(self)
	return gui.ScrollBarGetStep(self.widget)
end

function setPageStep(self, step)
	gui.ScrollBarSetPageStep(self.widget, step)
end

function getPageStep(self)
	return gui.ScrollBarGetPageStep(self.widget)
end

function setRange(self, min, max)
	if min and max then
		gui.ScrollBarSetRange(self.widget, min, max)
	else
		base.print('Invalid range value!')
	end
end

function getRange(self)
	return gui.ScrollBarGetRange(self.widget)
end

function setThumbValue(self, value)
	gui.ScrollBarSetThumbValue(self.widget, value)
end

function getThumbValue(self)
	return gui.ScrollBarGetThumbValue(self.widget)
end

-- пользователь нажал на ползунок
function addThumbPressedCallback(self, callback)
	self:addCallback('thumb pressed', callback)
end

-- пользователь отпустил ползунок
function addThumbReleasedCallback(self, callback)
	self:addCallback('thumb released', callback)
end