local base = _G

module('HBox')
mtab = { __index = _M}

local Factory = base.require('Factory')
local Box = base.require('Box')

Factory.setBaseClass(_M, Box)

function new()
  return Factory.create(_M)
end

function getBoxSize(self)
    local w, h = self:getSize()
    return w
end

function onResize(self, w, h)
    --print("HBox.onResize("..w..', '..h..')')
    local x = 0
    Box.reshape(self, w)
    Box.foreach(self, function(c)
            local widget = c[1]
            local w = c[4]
	    --print("HBox.onResize: x = "..x..' w = '..w)
            widget:setPosition(x, 0)
            widget:setSize(w, h)
            x = x + w + self.spacing
        end)
    Box.onResize(self, w, h)
end
