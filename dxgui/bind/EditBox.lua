local base = _G

module('EditBox')
mtab = { __index = _M}

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function new(text)
	return Factory.create(_M, text)
end

function construct(self, text)
	Widget.construct(self, text)
	
	self:addChangeCallback(function()
		self:onChange()
	end)
	
	self:addFocusCallback(function()
		self:onFocus(self:getFocused())
	end)
	
	self:addKeyDownCallback(function(self, keyName, unicode)
		self:onKeyDown(keyName, unicode)
	end)
end

function newWidget(self)
	return gui.NewEditBox()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.EditBoxClone(self.widget)
end

function setTextWrapping(self, wrapping)
	gui.EditBoxSetTextWrapping(self.widget, wrapping)
end

function getTextWrapping(self, wrapping)
	return gui.EditBoxGetTextWrapping(self.widget)
end

function setMultiline(self, multiline)
	gui.EditBoxSetMultiline(self.widget, multiline)
end

function getMultiline(self)
	return gui.EditBoxGetMultiline(self.widget)
end

function isMultiline(self)
	return self:getMultiline()
end

function setNumeric(self, numeric)
	gui.EditBoxSetNumeric(self.widget, numeric)
end

function getNumeric(self)
	return gui.EditBoxGetNumeric(self.widget)
end

-- FIXME: удалить 
function setNumber(self, numeric)
	self:setNumeric(numeric)
end

function isNumber(self)
	return self:getNumeric()
end

function setAcceptDecimalPoint(self, accept)
	gui.EditBoxSetAcceptDecimalPoint(self.widget, accept)
end

function getAcceptDecimalPoint(self)
	return gui.EditBoxGetAcceptDecimalPoint(self.widget)
end

function setPassword(self, password)
	gui.EditBoxSetPassword(self.widget, password)
end

function getPassword(self)
	return gui.EditBoxGetPassword(self.widget)
end

function isPassword(self)
	return self:getPassword()
end

function setReadOnly(self, readOnly)
	gui.EditBoxSetReadOnly(self.widget, readOnly)
end

function getReadOnly(self)
	return gui.EditBoxGetReadOnly(self.widget)
end

-- FIXME: удалить
function setSelection(self, index, count)
	-- в старом GUI выделение применялось только к однострочному едитбоксу
	-- -1 для индексов за концом строки
	local lineBegin = 0
	local indexBegin = index
	local lineEnd = 0
	local indexEnd

	if 0 <= count then
		indexEnd = index + count
	else
		indexEnd = -1
	end
	
	gui.EditBoxSetSelection(self.widget, lineBegin, indexBegin, lineEnd, indexEnd)
end

function getSelection(self)
	-- в старом GUI выделение применялось только к однострочному едитбоксу
	local lineBegin, indexBegin, lineEnd, indexEnd = gui.EditBoxGetSelection(self.widget)
	local index = 0
	local count = 0
	
	if lineBegin == lineEnd then
		index = indexBegin
		count = indexEnd - indexBegin
	end

	-- для старого GUI нужно вернуть index, count
	return index, count
end

function setSelectionNew(self, lineBegin, indexBegin, lineEnd, indexEnd)
	return gui.EditBoxSetSelection(self.widget, lineBegin, indexBegin, lineEnd, indexEnd)
end

function getSelectionNew(self)
	local lineBegin, indexBegin, lineEnd, indexEnd = gui.EditBoxGetSelection(self.widget)
	
	return lineBegin, indexBegin, lineEnd, indexEnd
end

function getLineCount(self)
	return gui.EditBoxGetLineCount(self.widget)
end

function getLineTextLength(self, lineIndex)
	return gui.EditBoxGetLineTextLength(self.widget, lineIndex)
end