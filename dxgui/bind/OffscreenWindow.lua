local base = _G

module('OffscreenWindow')
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
	return gui.NewOffscreenWindow()
end

function setZOrder(self, zOrder)
end

function getZOrder(self)
end

function mouseMove(self, x, y)
	gui.OffscreenWindowMouseMove(self.widget, x, y)
end

function mouseDown(self, x, y, button)
	gui.OffscreenWindowMouseDown(self.widget, x, y, button)
end

function mouseUp(self, x, y, button)
	gui.OffscreenWindowMouseUp(self.widget, x, y, button)
end
