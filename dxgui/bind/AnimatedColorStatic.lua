local base = _G

module('AnimatedColorStatic')
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
	return gui.NewAnimatedColorStatic()
end

-- color is hex string like "0xff0000ff"
function setTextColor(self, color)
	gui.AnimatedColorStaticSetTextColor(self.widget, color)
end

-- color is hex string like "0xff0000ff"
function setImageColor(self, color)
	gui.AnimatedColorStaticSetImageColor(self.widget, color)
end
