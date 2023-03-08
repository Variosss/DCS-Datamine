local base = _G

module('VertLayout')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Layout = base.require('Layout')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Layout)

function getType()
  return 'vert'
end

function new(gap, layoutPtr)
    return Factory.create(_M, gap, layoutPtr)
end

function construct(self, gap, layoutPtr)
    Layout.construct(self, layoutPtr)
    self:setGap(gap or 0)
end

function newLayout(self)
    return gui.NewVertLayout()
end

function setGap(self, gap)
    gui.VertLayoutSetGap(self.layout, gap)
end

function getGap(self)
    return gui.VertLayoutGetGap(self.layout)
end

function setHorzAlign(self, align)
    gui.VertLayoutSetHorzAlign(self.layout, align)
end

function getHorzAlign(self)
    return gui.VertLayoutGetHorzAlign(self.layout)
end

function setVertAlign(self, align)
    gui.VertLayoutSetVertAlign(self.layout, align)
end

function getVertAlign(self)
    return gui.VertLayoutGetVertAlign(self.layout)
end

function load(self, data)
	self:setGap(data.gap)
	self:setHorzAlign(data.horzAlign)
	self:setVertAlign(data.vertAlign)
end

function unload(self)
	return {
		gap = self:getGap(),
		horzAlign = self:getHorzAlign(),
		vertAlign = self:getVertAlign(),
	}
end