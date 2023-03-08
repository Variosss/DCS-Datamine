local base = _G

module('ListBox')
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

	self:addItemMouseDownCallback(function()
		self:onItemMouseDown()
	end)

	self:addItemMouseDoubleDownCallback(function()
		self:onItemMouseDoubleClick()
	end)

	self:addItemMouseUpCallback(function()
		self:onItemMouseUp()
	end)

	self:addSelectionChangeCallback(function()
		self:onSelectionChange()
	end)	
end

function newWidget(self)
	return gui.NewListBox()
end

function clone(self)
	local result = Factory.clone(_M, self)

	return result
end

function createClone(self)
	return gui.ListBoxClone(self.widget, Factory.registerWidget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local count = self:getItemCount()
	
	for i = 1, count do
		local itemPtr = gui.ListBoxGetItem(self.widget, i - 1)
		local typeName = gui.WidgetGetTypeName(itemPtr)
		
		Factory.registerWidget(typeName, itemPtr)
	end
end

function newItem(self, text, index)
	local item = ListBoxItem.new(text)
	
	self:insertItem(item, index)
	
	return item
end

-- index - опционально
-- если index = -1 или index = nil то item добавляется в конец списка
function insertItem(self, item, index)
	gui.ListBoxInsertItem(self.widget, item.widget, index)
end

function getItem(self, index)
	return widgets[gui.ListBoxGetItem(self.widget, index)]
end

function removeItem(self, item)
	gui.ListBoxRemoveItem(self.widget, item.widget)	
end

function clear(self)
	self:removeAllItems()
end

function removeAllItems(self)
	gui.ListBoxRemoveAllItems(self.widget)
end

function getItemIndex(self, item)
	return gui.ListBoxGetItemIndex(self.widget, item.widget)
end

function getItemCount(self)
	return gui.ListBoxGetItemCount(self.widget)
end

function getSelectedItem(self)
	return widgets[gui.ListBoxGetSelectedItem(self.widget)]
end

-- если item = nil, 
-- то сбрасывается текущее выделение
function selectItem(self, item)
	if item then
		gui.ListBoxSelectItem(self.widget, item.widget)
	else
		gui.ListBoxSelectItem(self.widget)		
	end
end

function setItemVisible(self, item)
	if item then
		gui.ListBoxSetItemVisible(self.widget, item.widget)	
	end
end

function getScrollPosition(self)
	return gui.ListBoxGetScrollPosition(self.widget)
end

function setScrollPosition(self, value)
	gui.ListBoxSetScrollPosition(self.widget, value)
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

function addSelectionChangeCallback(self, callback)
	self:addCallback('list box selection change', callback)
end

function onItemMouseDown(self)
	self.doubleClicked_ = false
end

function onItemMouseDoubleClick(self)
	local item = self:getSelectedItem()
	self.doubleClicked_ = true
	self:onChangeNew(item, true)
end

function onItemMouseUp(self)
	local item = self:getSelectedItem()
	
	if not self.doubleClicked_ then
		self:onChangeNew(item, false)
	end
	
	self.doubleClicked_ = false	
end

function onSelectionChange(self)
	local item = self:getSelectedItem()
	
	self:onChangeNew(item, false)
end

-- item может быть nil, это значит, что 
-- пользователь не выбрал ни один элемент списка
--(пользователь нажал кнопку мыши над элемент списка, 
-- затем вывел курсор мыши за пределы виджета и отпустил кнопку мыши)
-- FIXME: удалить
function onChangeNew(self, item, dblClick)
	if item then
		self:onChange(item, dblClick)
	end
end

-- обработчик сторого GUI
-- FIXME: удалить
function onChange(self, item, dblClick)
	if item then
		if dblClick then
			-- base.print('list box item dblClicked!', item:getText())
		else
			-- base.print('list box item Clicked!', item:getText())
		end
	end
end
