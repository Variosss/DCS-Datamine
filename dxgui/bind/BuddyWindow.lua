local base = _G

module('BuddyWindow')
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
	return gui.NewBuddyWindow()
end

function setBuddyWidget(self, buddyWidet)
	gui.BuddyWindowSetBuddyWidget(self.widget, buddyWidet.widget)
end

function setZOrder(self, zOrder)
end

function getZOrder(self)
end
