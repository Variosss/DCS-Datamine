-- Box layout
-- http://users.encs.concordia.ca/~haarslev/publications/jvlc92/node5.html
-- http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.37.8634

local base = _G

module('Box')
mtab = { __index = _M}

local Factory = base.require('Factory')
local Panel = base.require('Panel')

Factory.setBaseClass(_M, Panel)

function new()
    return Factory.create(_M)
end

function construct(self)
    Panel.construct(self)
    self.children = {}
    self.size = 0
    self.spacing = 0
    --print("Box.construct()")
end

local
function box_foreach(children, func)
    local i,v
    for i,v in base.ipairs(children) do
        if func(v) then break end
    end
end

local
function box_reshape(children, size)
    --print("box_reshape("..size..") from "..debug.traceback())
    local left = size
    local num = 0

    -- set up minimum sizes
    box_foreach(children, function(c)
            local min = c[2]
            local max = c[3]
            left = left - min
            c[4] = min
            if not max or min < max then num = num + 1 end
        end)
    --print ("num = "..num..", left = "..left)

    -- spread leftovers
    while left > 0 and num > 0 do
        local avg = left / num
        --print("avg = "..avg)
        box_foreach(children, function(c)
                local sz = c[4]
                local max = c[3]
                if max and sz >= max then return end
                local new_sz = sz + avg
                if max and new_sz > max then
                    new_sz = max
                    num = num - 1
                end
                c[4] = new_sz
                left = left - (new_sz - sz)
                if left < 1 then left = 0 end
            end)
    end

    -- return actual size
    return size - left
end

local
function box_add(children, ctl, min, max)
    if not min or min < 1 then min = 1 end
    if max and max < min then max = min end
    --print("box_add(min = "..min..", max = "..(max or "nil")..")")
    base.table.insert(children, {ctl, min, max, min})
    --local sz = box_reshape(children, size)
    --print("size = "..sz)
    --return sz
end

function getTotalSpacing(self)
    --local nc = table.getn(self.children)
    local nc = #self.children
    if nc > 1 then
        --print("nc = "..nc)
        return (nc  - 1) * self.spacing
    end
    return 0
end

function getAvailableSize(self, size)
    if not size then size = self:getBoxSize() end
    return size - getTotalSpacing(self)
end

function setSpacing(self, spc)
    self.spacing = spc
    self:reshape()
end

function getSpacing(self)
    return self.spacing
end

function reshape(self, size)
    local size = getAvailableSize(self, size)
    local spc = getTotalSpacing(self) 
    --print("reshape("..self:getBoxSize()..' '..size..' '..spc..' '..#self.children..")")
    self.size = box_reshape(self.children, size) + spc
end

function fillWindow(self, window)
    self:setPosition(0, 0)
    self:setSize(window:getClientRectSize())
    window:insertWidget(self)
end

function appendWidget(self, widget, min, max)
    --print("appendWidget: "..widget:getText())
    box_add(self.children, widget, min, max)
    Panel.insertWidget(self, widget)
    self:onResize(self:getSize())
end

function foreach(self, func)
    box_foreach(self.children, func)
end

function removeWidget(self, widget)
    local idx = 1
    self:foreach(function(c)
            if c[1] == widget then return true else idx = idx + 1 end
        end)
    if idx < self.children.n then
        base.table.remove(self.children, idx)
        self:reshape()
        self:onResize(self:getSize())
    end
end
