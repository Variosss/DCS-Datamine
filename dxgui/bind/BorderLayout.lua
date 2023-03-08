local base = _G

module('BorderLayout')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Layout = base.require('Layout')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Layout)

function getType()
	return 'border'
end

function new(horzGap, vertGap, layoutPtr)
	return Factory.create(_M, horzGap, vertGap, layoutPtr)
end

function construct(self, horzGap, vertGap, layoutPtr)
	Layout.construct(self, layoutPtr)
	self:setHorzGap(horzGap or 0)
	self:setVertGap(vertGap or 0)
end

function newLayout(self)
	return gui.NewBorderLayout()
end

function setHorzGap(self, gap)
	gui.BorderLayoutSetHorzGap(self.layout, gap)
end

function getHorzGap(self)
	return gui.BorderLayoutGetHorzGap(self.layout)
end

function setVertGap(self, gap)
	gui.BorderLayoutSetVertGap(self.layout, gap)
end

function getVertGap(self)
	return gui.BorderLayoutGetVertGap(self.layout)
end

function load(self, data)
	self:setHorzGap(data.horzGap)
	self:setVertGap(data.vertGap)
end

function unload(self)
	return {
		horzGap = self:getHorzGap(),
		vertGap = self:getVertGap(),
	}
end