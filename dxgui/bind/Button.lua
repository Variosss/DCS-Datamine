local base = _G

module('Button')
mtab = { __index = _M }

local require = base.require

local Factory = 	require('Factory')
local Widget = 		require('Widget')
local gui = 		require('dxgui')

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
	return gui.NewButton()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.ButtonClone(self.widget)
end
