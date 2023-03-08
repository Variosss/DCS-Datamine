local base = _G

module('Grid')
mtab = { __index = _M}

local Factory = base.require('Factory')
local gui = base.require('dxgui')
local Widget = base.require('Widget')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

local rowCallbacks = {}

function construct(self)
	Widget.construct(self)
	
	self:addMouseMoveCallback(function(self, x, y)
		self:onMouseMove(x, y)
	end)
	
	self:addMouseDownCallback(function(self, x, y, button)
		self:onMouseDown(x, y, button)
	end)
	
	self:addMouseDoubleDownCallback(function(self, x, y, button)
		self:onMouseDoubleClick(x, y, button)
	end)
	
	-- self:addSelectRowCallback(function(self, currSelectedRow, prevSelectedRow)
		-- base.print('~~~addSelectRowCallback', currSelectedRow, prevSelectedRow)
	-- end)
	
	-- self:addHoverRowCallback(function(self, currHoveredRow, prevHoveredRow)
		-- base.print('~~~addHoverRowCallback', currHoveredRow, prevHoveredRow)
	-- end)
	
	-- self:addMouseUpCallback(function(self, x, y, button)
		-- self:onMouseUp(x, y, button)
	-- end)	
	
	-- self:addMouseWheelCallback(function(self, x, y, button)
		-- self:onMouseWheel(x, y, button)
	-- end)
	
	
end

function newWidget(self)
	return gui.NewGrid()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.GridClone(self.widget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local rowCount 		= self:getRowCount()
	local columnCount 	= self:getColumnCount()
	
	for i = 1, columnCount do
		local itemPtr = gui.GridGetColumnHeader(self.widget, i - 1)
		
		if itemPtr then
			local typeName = gui.WidgetGetTypeName(itemPtr)
		
			Factory.registerWidget(typeName, itemPtr)
		end
		
		for j = 1, rowCount do
			local cellPtr = gui.GridGetCell(self.widget, i - 1, j - 1)
			
			if cellPtr then
				local typeName = gui.WidgetGetTypeName(cellPtr)
		
				Factory.registerWidget(typeName, cellPtr)
			end
		end
	end
	
	local col
end

function setFixedColumnCount(self, count)
	gui.GridSetFixedColumnCount(self.widget, count)
end

function getFixedColumnCount(self)
	return gui.GridGetFixedColumnCount(self.widget)
end

function insertColumn(self, width, widget, index)
	if widget then
		widget = widget.widget
	end

	gui.GridInsertColumn(self.widget, width, widget, index)
end

function setColumnWidth(self, index, width)
	gui.GridSetColumnWidth(self.widget, index, width)
end

function getColumnWidth(self, index)
	return gui.GridGetColumnWidth(self.widget, index)
end

-- если колонками занято не все место по ширине,
-- то у колонок с индексами columnIndices увеличивает ширину,
-- чтобы заполнить свободное место
function stretchColumns(self, columnIndices)
	gui.GridStretchColumns(self.widget, columnIndices)
end

function setColumnHeader(self, index, widget)
	if widget then
		widget = widget.widget
	end

	gui.GridSetColumnHeader(self.widget, index, widget)
end

function getColumnHeader(self, index)
	return widgets[gui.GridGetColumnHeader(self.widget, index)]
end

function removeColumn(self, index)
	gui.GridRemoveColumn(self.widget, index)
end

function clearColumn(self, index)
	gui.GridClearColumn(self.widget, index)
end

function getColumnCount(self)
	return gui.GridGetColumnCount(self.widget)
end

function insertHeaderCell(self, headerCell)
	local w, h = headerCell:getSize()
	self:insertColumn(w, headerCell, headerCell:getZIndex())
end

function setMouseColumnResizing(self, enable)
	gui.GridSetMouseColumnResizing(self.widget, enable)
end

function getMouseColumnResizing(self)
	return gui.GridGetMouseColumnResizing(self.widget)
end

-- если height = nil, то высота строки берется из скина
-- если index = nil, то строка добавляется в конец
function insertRow(self, height, index)
	gui.GridInsertRow(self.widget, height, index)
end

function setRowHeight(self, index, height)
	gui.GridSetRowHeight(self.widget, index, height)
end

function getRowHeight(self, index)
	return gui.GridGetRowHeight(self.widget, index)
end

function removeRow(self, index)
	gui.GridRemoveRow(self.widget, index)
end

function clearRow(self, index)
	gui.GridClearRow(self.widget, index)
end

function removeAllRows(self)
	gui.GridRemoveAllRows(self.widget)
end

function clearRows(self)
	gui.GridClearRows(self.widget)
end

function setRowCount(self, count)
	local currRowCount = self:getRowCount()
	
	count = count or 0
	self:clearRows()
	
	local skin = self:getSkin()
	local rowHeight = skin.skinData.params.rowHeight
	
	for i = 1, count do
		self:insertRow(rowHeight)
	end
end

function getRowCount(self)
	return gui.GridGetRowCount(self.widget)
end

-- установить виджет в ячейку
-- существующй виджет будет удален
function setCell(self, column, row, widget)
	if widget then
		widget = widget.widget
	end

	gui.GridSetCell(self.widget, column, row, widget)
end

function getCell(self, column, row)
	return widgets[gui.GridGetCell(self.widget, column, row)]
end

-- очистить ячейку
-- возвращает виджет, хранившийся в ячейке
function removeCell(self, column, row)
	return widgets[gui.GridRemoveCell(self.widget, column, row)]
end

function removeAll(self)
	gui.GridRemoveAll(self.widget) 
end

function clear(self)
	gui.GridClear(self.widget) 
end

-- index - индекс строки, -1 или nil если снять выделение
function selectRow(self, index)
	gui.GridSelectRow(self.widget, index)
end

-- возвращает индекс выделенной строки, 
-- или -1, если нет выделенной строки
function getSelectedRow(self)
	return gui.GridGetSelectedRow(self.widget)
end

-- x, y, в оконных координатах 
-- так, как эти координаты приходят в сообщения от мыши
function getMouseCursorColumnRow(self, x, y)
	local column, row = gui.GridGetMouseCursorColumnRow(self.widget, x, y)
	return column, row
end

function setRowVisible(self, row)
	return gui.GridSetRowVisible(self.widget, row)
end

function setVertScrollPosition(self, position)
	gui.GridSetVertScrollPosition(self.widget, position)
end

function getVertScrollPosition(self)
	return gui.GridGetVertScrollPosition(self.widget)
end

function setHorzScrollPosition(self, position)
	gui.GridSetHorzScrollPosition(self.widget, position)
end

function getHorzScrollPosition(self)
	return gui.GridGetHorzScrollPosition(self.widget)
end

function setScrollPosition(self, vert, horz)
	self:setVertScrollPosition(vert)
	self:setHorzScrollPosition(horz)
end

function getScrollPosition(self)
	local vert = self:getVertScrollPosition()
	local horz = self:getHorzScrollPosition()

	return vert, horz
end

function setVertScrollBarStep(self, step)
	gui.GridSetVertScrollBarStep(self.widget, step)
end

function getVertScrollBarStep(self)
	return gui.GridGetVertScrollBarStep(self.widget)
end

function setVertScrollBarPageStep(self, step)
	gui.GridSetVertScrollBarPageStep(self.widget, step)
end

function getVertScrollBarPageStep(self)
	return gui.GridGetVertScrollBarPageStep(self.widget)
end

function setHorzScrollBarStep(self, step)
	gui.GridSetHorzScrollBarStep(self.widget, step)
end

function getHorzScrollBarStep(self)
	return gui.GridGetHorzScrollBarStep(self.widget)
end

function setHorzScrollBarPageStep(self, step)
	gui.GridSetHorzScrollBarPageStep(self.widget, step)
end

function getHorzScrollBarPageStep(self)
	return gui.GridGetHorzScrollBarPageStep(self.widget)
end

function addSelectRowCallback(self, callback)
	-- callback arise when user change selected row using keyboard
	local func = function(currSelectedRow, prevSelectedRow)
		callback(self, currSelectedRow, prevSelectedRow)
	end
	
	rowCallbacks[callback] = func
	
	gui.GridAddRowCallback(self.widget,'grid row selected', func)
end

function removeSelectRowCallback(self, callback)
	gui.GridRemoveRowCallback(self.widget,'grid row selected', rowCallbacks[callback])
	rowCallbacks[callback] = nil
end

function addHoverRowCallback(self, callback)
	-- callback arise when user change hovered row
	local func = function(currHoveredRow, prevHoveredRow)
		callback(self, currHoveredRow, prevHoveredRow)
	end
	
	rowCallbacks[callback] = func
	
	gui.GridAddRowCallback(self.widget,'grid row hovered', func)
end

function removeHoverRowCallback(self, callback)
	gui.GridRemoveRowCallback(self.widget,'grid row hovered', rowCallbacks[callback])
	rowCallbacks[callback] = nil
end