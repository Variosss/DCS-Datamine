local base = _G

module('ComboBox')
mtab = { __index = _M }

local Factory		= base.require('Factory')
local Widget		= base.require('Widget')
local ListBoxItem	= base.require('ListBoxItem')
local gui			= base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	
	self:addFocusCallback(function()
		self:onFocus(self:getFocused())
	end)
	
	self:addKeyDownCallback(function(self, keyName, unicode)
		self:onKeyDown(keyName, unicode)
	end)
	
	self:addChangeListBoxCallback(function()
		self:onChangeListBox()
	end)
	
	self:addChangeEditBoxCallback(function()
		self:onChangeEditBox()
	end)
end

function newWidget(self)
	return gui.NewComboBox()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.ComboBoxClone(self.widget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local count = self:getItemCount()
	
	for i = 1, count do
		local itemPtr = gui.ComboBoxGetItem(self.widget, i - 1)
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
	gui.ComboBoxInsertItem(self.widget, item.widget, index)
end

function getItem(self, index)
	return widgets[gui.ComboBoxGetItem(self.widget, index)]
end

function removeItem(self, item)
	gui.ComboBoxRemoveItem(self.widget, item.widget)	
end

function clear(self)
	self:removeAllItems()
end

function removeAllItems(self)
	gui.ComboBoxRemoveAllItems(self.widget)
end

function getItemIndex(self, item)
	return gui.ComboBoxGetItemIndex(self.widget, item.widget)
end

function getItemCount(self)
	return gui.ComboBoxGetItemCount(self.widget)
end

function getSelectedItem(self)
	return widgets[gui.ComboBoxGetSelectedItem(self.widget)]
end

-- если item = nil, 
-- то сбрасывается текущее выделение
function selectItem(self, item)
	if item then
		gui.ComboBoxSelectItem(self.widget, item.widget)
	else
		gui.ComboBoxSelectItem(self.widget)		
	end
end

function setReadOnly(self, readonly)
	gui.ComboBoxSetReadonly(self.widget, readonly)
end

function getReadOnly(self)
	return gui.ComboBoxGetReadonly(self.widget)
end

function setWindowVisible(self, visible)
	gui.ComboBoxSetWindowVisible(self.widget, visible)
end

function getWindowVisible(self)
	return gui.ComboBoxGetWindowVisible(self.widget)
end

function setSelection(self, index, count)
	-- -1 для индексов за концом строки
	local indexBegin = index
	local indexEnd

	if 0 <= count then
		indexEnd = index + count
	else
		indexEnd = -1
	end
	
	gui.ComboBoxSetSelection(self.widget, indexBegin, indexEnd)
end

function getSelection(self)
	local indexBegin, indexEnd = gui.ComboBoxGetSelection(self.widget)
	local index = 0
	local count = 0
	
	if lineBegin == lineEnd then
		index = indexBegin
		count = indexEnd - indexBegin
	end

	return index, count
end

-- пользователь выбрал значение из списка
function addChangeListBoxCallback(self, callback)
	self:addCallback('combo box list change', callback)
end

-- пользователь изменил значение в поле ввода
function addChangeEditBoxCallback(self, callback)
	self:addCallback('combo box edit change', callback)
end

function onChangeListBox(self)
	self:onChange(self:getSelectedItem())
end

function onChangeEditBox(self)
	self:onChange()
end

-- для совместимости со старым GUI
function onChange(self, item)
	local text
	
	if item then
		text = item:getText()
	else
		text = self:getText()
	end
	--print('Lua callback: combo box text changed!', text)
end