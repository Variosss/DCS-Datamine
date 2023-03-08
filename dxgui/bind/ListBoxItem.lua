local base = _G

module('ListBoxItem')
mtab = { __index = _M }

local Factory	= base.require('Factory')
local Widget	= base.require('Widget'	)
local gui		= base.require('dxgui'	)

Factory.setBaseClass(_M, Widget)

function new(text)
	return Factory.create(_M, text)
end

function construct(self, text)
	Widget.construct(self, text)
end

function newWidget(self)
	return gui.NewListBoxItem()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.ListBoxItemClone(self.widget)
end

-- узнать, выделен элемент списка или нет
function getSelected(self)
	return gui.ListBoxItemGetSelected(self.widget)
end
