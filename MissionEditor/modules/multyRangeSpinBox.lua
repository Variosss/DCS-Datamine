-- онтрол 

local base = _G

module('multyRangeSpinBox')
mtab = { __index = _M}

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui = base.require('dxgui')
local SpinBox			= base.require('SpinBox')

Factory.setBaseClass(_M, SpinBox)

local oldValue

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	
	self:addChangeCallback(onChange_Multy)
end

function onChange_Multy(self)
    local newValue = self:getValue()
    
    for k,v in base.pairs(self.tblRanges) do
        if newValue > v.max and (self.tblRanges[k+1] and newValue < self.tblRanges[k+1].min) then
            if oldValue and oldValue <= v.max then
                newValue = self.tblRanges[k+1].min
            else
                newValue = v.max
            end
        end       
    end
    self:setValue(newValue)
    
    self:onChange()
    oldValue = self:getValue()
end

local function inRange(a_value, min, max)
    return (a_value >= min and a_value <= max) 
end

function setRange(self, tblRanges) -- диапазоны должны идти по возрастанию
    self.tblRanges = tblRanges
	if tblRanges[1] and tblRanges[1].min
       and tblRanges[#tblRanges] and tblRanges[#tblRanges].max then
        gui.SpinBoxSetRange(self.widget, tblRanges[1].min, tblRanges[#tblRanges].max)
	else
        base.print('Invalid range value in setRange multyRangeSpinBox!')
	end
end

function getRange()
	return self.tblRanges
end

function isRange(self,a_value)		
	for k,v in base.pairs(self.tblRanges) do
        if a_value >= v.min and a_value <= v.max then
			return true	
        end       
    end
	
	return false
end