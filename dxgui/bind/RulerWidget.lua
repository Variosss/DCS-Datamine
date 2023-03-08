local base = _G

module('RulerWidget')
mtab = { __index = _M }

local Factory 		= base.require('Factory')
local Widget 		= base.require('Widget')
local gui_ruler 	= base.require('gui_ruler')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	self.mousePressed = false
	
	self:addMouseMoveCallback(function(self, x, y)
		if self.mousePressed then
			self:onMouseDrag(x, y)
		end
	end)
	
	self:addMouseDownCallback(function(self, x, y, button)
		self:captureMouse()
		self.mousePressed = true
		self:onMouseDown(x, y, button)
	end)
	
	self:addMouseUpCallback(function(self, x, y, button)		
		self:releaseMouse()
		self.mousePressed = false
		self:onMouseUp(x, y, button)
	end)
end

function setOffsetInPixel(self, offset)
	gui_ruler.RulerWidgetSetOffsetInPixel(self.widget, offset)
end 

function getOffsetInPixel(self)
	return gui_ruler.RulerWidgetGetOffsetInPixel(self.widget)
end

function setScale(self, scale)
	gui_ruler.RulerWidgetSetScale(self.widget, scale)
end 

function getScale(self)
	return gui_ruler.RulerWidgetGetScale(self.widget)
end

function onMouseDrag(self, x, y)
end