local base = _G

module('FormLayout')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Layout = base.require('Layout')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Layout)

function getType()
  return 'form'
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
    return gui.NewFormLayout()
end

function setHorzGap(self, gap)
    gui.FormLayoutSetHorzGap(self.layout, gap)
end

function getHorzGap(self)
    return gui.FormLayoutGetHorzGap(self.layout)
end

function setVertGap(self, gap)
    gui.FormLayoutSetVertGap(self.layout, gap)
end

function getVertGap(self)
    return gui.FormLayoutGetVertGap(self.layout)
end

function setCaptionsAlign(self, horzAlign, vertAlign)
    gui.FormLayoutSetCaptionsAlign(self.layout, horzAlign, vertAlign)
end

function getCaptionsAlign(self)
    local horzAlign, vertAlign = gui.FormLayoutGetCaptionsAlign(self.layout)
    
    return horzAlign, vertAlign
end

function setFieldsAlign(self, horzAlign, vertAlign)
    gui.FormLayoutSetFieldsAlign(self.layout, horzAlign, vertAlign)
end

function getFieldsAlign(self)
    local horzAlign, vertAlign = gui.FormLayoutGetFieldsAlign(self.layout)
    
    return horzAlign, vertAlign
end

function load(self, data)
	self:setHorzGap(data.horzGap or 0)
	self:setVertGap(data.vertGap or 0)
	self:setCaptionsAlign(data.captions.horzAlign, data.captions.vertAlign)
	self:setFieldsAlign(data.fields.horzAlign, data.fields.vertAlign)
end

function unload(self)
	local result = {
		horzGap = self:getHorzGap(),
		vertGap = self:getVertGap(),
		captions = {},
		fields = {},
	}
	
	result.captions.horzAlign, result.captions.vertAlign = self:getCaptionsAlign()
	result.fields.horzAlign, result.fields.vertAlign = self:getFieldsAlign()
	
	return result
end