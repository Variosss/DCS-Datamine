local base = _G

module('CheckListBoxItem')
mtab = { __index = _M }

local ListBoxItem	= base.require('ListBoxItem')
local Factory		= base.require('Factory'	)
local gui			= base.require('dxgui'		)

Factory.setBaseClass(_M, ListBoxItem)

function new(text)
	return Factory.create(_M, text)
end

function construct(self, text)
	ListBoxItem.construct(self, text)
end

function newWidget(self)
	return gui.NewCheckListBoxItem()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.CheckListBoxItemClone(self.widget)
end

function setChecked(self, checked)
	gui.CheckListBoxItemSetChecked(self.widget, checked)  
end

function getChecked(self)
	return gui.CheckListBoxItemGetChecked(self.widget)  
end

function setCheckVisible(self, visible)
	gui.CheckListBoxItemSetCheckVisible(self.widget, visible)  
end

function getCheckVisible(self)
	return gui.CheckListBoxItemGetCheckVisible(self.widget)  
end