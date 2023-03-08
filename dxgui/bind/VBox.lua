local base = _G

module('VBox')
mtab = { __index = _M}

local Factory = base.require('Factory')
local Box = base.require('Box')

Factory.setBaseClass(_M, Box)

function new()
    return Factory.create(_M)
end

function getBoxSize(self)
    local w, h = self:getSize()
    return h
end

function onResize(self, w, h)
    local y = 0
    Box.reshape(self, h)
    Box.foreach(self, function(c)
            local widget = c[1]
            local h = c[4]
            widget:setPosition(0, y)
            widget:setSize(w, h)
            y = y + h + self.spacing
        end)
    Box.onResize(self, w, h)
end
