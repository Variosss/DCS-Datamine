local base = _G

module('TextureView')
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
	return gui.NewTextureView()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.StaticClone(self.widget)
end

function setTexture(self, static)
	gui.TextureViewSetTexture(self.widget, static.widget)
end

function setImageInfo(self, imageInfo)
	gui.TextureViewSetImageInfo(self.widget, imageInfo)
end

function getImageInfo(self)
	return gui.TextureViewGetImageInfo(self.widget)
end

function setAngle(self, degrees)
	gui.TextureViewSetAngle(self.widget, degrees)
end

function getAngle(self)
	return gui.TextureViewGetAngle(self.widget)
end

function setPivotPoint(self, x, y)
	gui.TextureViewSetPivotPoint(self.widget, x, y)
end

function getPivotPoint(self)
	local x, y = gui.TextureViewGetPivotPoint(self.widget)
	
	return x, y
end
