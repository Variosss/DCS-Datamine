local base = _G

module('OverlayWindow')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Window = base.require('Window')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Window)

function new(x, y, w, h, text)
	return Factory.create(_M, x, y, w, h, text) 
end

function construct(self, x, y, w, h, text)
	Window.construct(self, x, y, w, h, text)
end

function newWidget(self)
	return gui.NewOverlayWindow()
end

function clone(self)
	local result = Factory.clone(_M, self)

	self:copyWidgetNames(result)
	
	return result
end

function createClone(self)
	return gui.OverlayWindowClone(self.widget)
end

function setZOrder(self, zOrder)
	gui.OverlayWindowSetZOrder(self.widget, zOrder)
end

function getZOrder(self)
	return gui.OverlayWindowGetZOrder(self.widget)
end