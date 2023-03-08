local base = _G

module('CheckListBox')
mtab = { __index = _M }

local Factory			= base.require('Factory'			)
local Widget			= base.require('Widget'				)
local CheckListBoxItem	= base.require('CheckListBoxItem'	)
local gui				= base.require('dxgui'				)

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	
	self:addItemMouseDownCallback(function()
		self:onItemMouseDown()
	end)

	self:addItemMouseDoubleDownCallback(function()
		self:onItemMouseDoubleClick()
	end)

	self:addItemMouseUpCallback(function()
		self:onItemMouseUp()
	end)
	
	self:addItemChangeCallback(function()
		self:onItemChange()
	end)
	
	self:addSelectionChangeCallback(function()
		self:onSelectionChange()
	end)	
end

function newWidget(self)
	return gui.NewCheckListBox()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.CheckListBoxClone(self.widget, Factory.registerWidget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local count = self:getItemCount()
	
	for i = 1, count do
		local itemPtr = gui.CheckListBoxGetItem(self.widget, i - 1)
		local typeName = gui.WidgetGetTypeName(itemPtr)
		
		Factory.registerWidget(typeName, itemPtr)
	end
end

function newItem(self, text, index)
	local item = CheckListBoxItem.new(text)
	
	self:insertItem(item, index)
	
	return item
end

-- index - опционально
-- если index = -1 или index = nil то item добавляется в конец списка
function insertItem(self, item, index)
	gui.CheckListBoxInsertItem(self.widget, item.widget, index)
end

function getItem(self, index)
	return widgets[gui.CheckListBoxGetItem(self.widget, index)]
end

function removeItem(self, item)
	gui.CheckListBoxRemoveItem(self.widget, item.widget)	
end

function clear(self)
	self:removeAllItems()
end

function removeAllItems(self)
	gui.CheckListBoxRemoveAllItems(self.widget)
end

function getItemIndex(self, item)
	return gui.CheckListBoxGetItemIndex(self.widget, item.widget)
end

function getItemCount(self)
	return gui.CheckListBoxGetItemCount(self.widget)
end

function getSelectedItem(self)
	return widgets[gui.CheckListBoxGetSelectedItem(self.widget)]
end

-- если item = nil, 
-- то сбрасывается текущее выделение
function selectItem(self, item)
	if item then
		gui.CheckListBoxSelectItem(self.widget, item.widget)
	else
		gui.CheckListBoxSelectItem(self.widget)		
	end
end

function setItemVisible(self, item)
	if item then
		gui.CheckListBoxSetItemVisible(self.widget, item.widget)	
	end
end

function getScrollPosition(self)
	return gui.CheckListBoxGetScrollPosition(self.widget)
end

function setScrollPosition(self, value)
	gui.CheckListBoxSetScrollPosition(self.widget, value)
end

function getSelectedItemTextAndCheck(self)
	local text, checked
	local item = self:getSelectedItem()
	
	if item then
		text = item:getText()
		checked = item:getChecked()
	else
		text = 'NIL'
		checked = 'NIL'
	end	
	
	return text, checked
end

function addItemMouseMoveCallback(self, callback)
	self:addCallback('list box item mouse move', callback)
end

function addItemMouseDownCallback(self, callback)
	self:addCallback('list box item mouse down', callback)
end

function addItemMouseDoubleDownCallback(self, callback)
	self:addCallback('list box item mouse double down', callback)
end

function addItemMouseUpCallback(self, callback)
	self:addCallback('list box item mouse up', callback)
end

-- у элемента списка изменилось состояние (checked/unchecked)
function addItemChangeCallback(self, callback)
	self:addCallback('list box item change', callback)
end

function addSelectionChangeCallback(self, callback)
	self:addCallback('list box selection change', callback)
end

function onItemMouseDown(self)
 --print('Lua callback: check list box item mouse down!', self:getSelectedItemTextAndCheck())
end

function onItemMouseDoubleClick(self)
	--print('Lua callback: check list box item mouse double click!', self:getSelectedItemTextAndCheck())
end

function onItemMouseUp(self)
	--print('Lua callback: check list box item mouse up!', self:getSelectedItemTextAndCheck())
end

function onItemChange(self)
	--print('Lua callback: check list box item changed!', self:getSelectedItemTextAndCheck())
end

function onSelectionChange(self)
	--print('Lua callback: check list box selection changed!', self:getSelectedItemTextAndCheck())
end