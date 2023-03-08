local base = _G

module('VertRulerWidget')
mtab = { __index = _M }

local Factory 		= base.require('Factory')
local RulerWidget 	= base.require('RulerWidget')
local gui_ruler 	= base.require('gui_ruler')

Factory.setBaseClass(_M, RulerWidget)

function new()
  return Factory.create(_M)
end

function newWidget(self)
  return gui_ruler.NewVertRulerWidget()
end
