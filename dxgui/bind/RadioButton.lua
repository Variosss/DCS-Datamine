local base = _G

module('RadioButton')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function new(text)
	return Factory.create(_M, text)
end

function construct(self, text)
	Widget.construct(self, text)
	
	self:addChangeCallback(function()
		self:onChange()
	end)
end

function newWidget(self)
	return gui.NewRadioButton()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.RadioButtonClone(self.widget)
end

function setState(self, state)
	if state then
		state = 1
	else
		state = 0
	end
	
	gui.RadioButtonSetState(self.widget, state)
end

function getState(self)
	return 0 < gui.RadioButtonGetState(self.widget)
end
