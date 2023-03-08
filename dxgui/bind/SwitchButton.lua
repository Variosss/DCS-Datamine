local base = _G

module('SwitchButton')
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

function newWidget()
	return gui.NewSwitchButton()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.SwitchButtonClone(self.widget)
end

function setState(self, state)
	if state then
		state = 1
	else
		state = 0
	end
	
	gui.SwitchButtonSetState(self.widget, state)
end

function getState(self)
	return 0 < gui.SwitchButtonGetState(self.widget)
end
