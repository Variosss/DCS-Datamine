local base = _G

module('AutoScrollText')
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
end

function newWidget(self)
	return gui.NewAutoScrollText()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.AutoScrollTextClone(self.widget)
end

function addText(self, text, duration)
	gui.AutoScrollTextAddText(self.widget, text, duration)
end

function clear(self)
	gui.AutoScrollTextClear(self.widget)
end