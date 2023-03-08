local base = _G

module('ColorTextStatic')
mtab = { __index = _M}

local Factory = base.require('Factory')
local gui = base.require('dxgui')
local Widget = base.require('Widget')

Factory.setBaseClass(_M, Widget)

function new(text)
	return Factory.create(_M, text)
end

function construct(self, text)
	Widget.construct(self, text)
end

function newWidget(self)
	return gui.NewColorTextStatic()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.ColorTextStaticClone(self.widget)
end

function setFonts(self, fonts)
	gui.ColorTextStaticSetFonts(self.widget, fonts)	
end

function getFonts(self)
	return gui.ColorTextStaticGetFonts(self.widget)	
end
