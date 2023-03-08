local base = _G

module('ComboList')
mtab = { __index = _M }

local Factory		= base.require('Factory'	)
local Widget		= base.require('Widget'		)
local ListBoxItem	= base.require('ListBoxItem')
local gui			= base.require('dxgui'		)

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	
	self:addChangeCallback(function()
		self:onChange(self:getSelectedItem())
	end)
end

function newWidget(self)
	return gui.NewComboList()
end

function clone(self)
	local w = Factory.clone(_M, self)

	w:addChangeCallback(function()
		w:onChange(w:getSelectedItem())
	end)
	
	return w 
end

function createClone(self)
	return gui.ComboListClone(self.widget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local count = self:getItemCount()
	
	for i = 1, count do
		local itemPtr = gui.ComboListGetItem(self.widget, i - 1)
		local typeName = gui.WidgetGetTypeName(itemPtr)
		
		Factory.registerWidget(typeName, itemPtr)
	end
end

function newItem(self, text, index)
	local item = ListBoxItem.new(text)
	
	self:insertItem(item, index)
	
	return item
end

function setText(self, text)
	local item
	local counter = self:getItemCount() - 1
	
	for i = 0, counter do
		local currItem = self:getItem(i)
		
		if currItem:getText() == text then
			item = currItem
			break
		end
	end
	
	self:selectItem(item)
end

function getText(self)
	local result 
	local item = self:getSelectedItem()
	
	if item then
		result = item:getText()
	end
	
	return result
end

-- index - опционально
-- если index = -1 или index = nil то item добавляется в конец списка
function insertItem(self, item, index)
	gui.ComboListInsertItem(self.widget, item.widget, index)
end

function getItem(self, index)
	return widgets[gui.ComboListGetItem(self.widget, index)]
end

function removeItem(self, item)
	gui.ComboListRemoveItem(self.widget, item.widget)	
end

function clear(self)
	self:removeAllItems()
end

function removeAllItems(self)
	gui.ComboListRemoveAllItems(self.widget)
end

function getItemIndex(self, item)
	return gui.ComboListGetItemIndex(self.widget, item.widget)
end

function getItemCount(self)
	return gui.ComboListGetItemCount(self.widget)
end

function getSelectedItem(self)
	return widgets[gui.ComboListGetSelectedItem(self.widget)]
end

-- если item = nil, 
-- то сбрасывается текущее выделение
function selectItem(self, item)
	if item then
		gui.ComboListSelectItem(self.widget, item.widget)
	else
		gui.ComboListSelectItem(self.widget)		
	end
end

function setWindowVisible(self, visible)
	gui.ComboListSetWindowVisible(self.widget, visible)
end

function getWindowVisible(self)
	return gui.ComboListGetWindowVisible(self.widget)
end

function onChange(self, item)
	local itemText
	
	if item then
		itemText = item:getText()
	else
		itemText = 'NIL'
	end
	--print('Lua callback: combo list item selected!', itemText)
end
