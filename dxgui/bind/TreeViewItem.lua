local base = _G

module('TreeViewItem')
mtab = { __index = _M }

local CheckListBoxItem	= base.require('CheckListBoxItem')
local Factory			= base.require('Factory')
local gui				= base.require('dxgui')

Factory.setBaseClass(_M, CheckListBoxItem)

function new(text)
  return Factory.create(_M, text)
end

function construct(self, text)
	CheckListBoxItem.construct(self, text)
end
