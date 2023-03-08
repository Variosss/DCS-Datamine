local base = _G

module('HorzLayout')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Layout = base.require('Layout')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Layout)

function getType()
  return 'horz'
end

function new(gap, layoutPtr)
    return Factory.create(_M, gap, layoutPtr)
end

function construct(self, gap, layoutPtr)
    Layout.construct(self, layoutPtr)
    self:setGap(gap or 0)
end

function newLayout(self)
    return gui.NewHorzLayout()
end

function setGap(self, gap)
    gui.HorzLayoutSetGap(self.layout, gap)
end

function getGap(self)
    return gui.HorzLayoutGetGap(self.layout)
end

function setHorzAlign(self, align)
    gui.HorzLayoutSetHorzAlign(self.layout, align)
end

function getHorzAlign(self)
    return gui.HorzLayoutGetHorzAlign(self.layout)
end

function setVertAlign(self, align)
    gui.HorzLayoutSetVertAlign(self.layout, align)
end

function getVertAlign(self)
    return gui.HorzLayoutGetVertAlign(self.layout)
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