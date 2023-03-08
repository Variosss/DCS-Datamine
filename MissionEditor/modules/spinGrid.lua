-- онтрол 

local base = _G

module('spinGrid')
mtab = { __index = _M }

local require = base.require
local pairs = base.pairs
local type = base.type
local table = base.table

local Factory           = require('Factory')
local Static            = require('Static')
local Grid              = require('Grid')
local Skin              = require('Skin')
local U                 = require('me_utilities')
local SpinBox           = require('SpinBox')
local textutil          = require('textutil')

-------------------------------------------------------------------------------
--
function new(grid)
  return Factory.create(_M, grid)
end

-------------------------------------------------------------------------------
--
function construct(self, grid)
    grid = grid or Grid.new()  
    self.Grid = grid

    self.editSpinBox                = SpinBox.new() 
    grid.editSpinBox                = self.editSpinBox 
    self.editSpinBox.onChange       = onChangeSpinBox
    self.editSpinBox.Grid           = grid

	grid:addFocusCallback(function()
		if(not grid:getFocused()) then
			onEndEditCell(grid)
		end
	end)
	
    grid.onMouseDown           = onMouseDown  
    grid.onChange              = onChange
    grid.setData               = setData
    grid.getData               = getData
    grid.clear                 = clear
    grid.callbackChangeData    = callbackChangeData
    grid.setSpinParam          = setSpinParam
    grid.resetCol              = resetCol
	grid.setEditable           = setEditable
    
    grid.data = nil
	grid.editable = true
    
    grid.editCell = 
    {
        widget  = nil,
        col     = nil,
        row     = nil,
    }
    
    grid.SpinParam = {}
    grid.SpinParam[2] = {min = 0, max = 1000, step = 1}
    grid.SpinParam[3] = {min = 0, max = 900, step = 1}
    grid.SpinParam[4] = {min = 0, max = 800, step = 1}

end

-------------------------------------------------------------------------------
--
function create(self, a_x, a_y, a_w, a_h)
    setBounds(self, a_x, a_y, a_w, a_h)
    
    return self.Grid;
end

-------------------------------------------------------------------------------
--
function setBounds(self, a_x, a_y, a_w, a_h)
    local x = a_x or 0
    local y = a_y or 0
    local w = a_w or 100
    local h = a_h or U.widget_h

    self.Grid:setBounds(x, y, w, h)
end

-------------------------------------------------------------------------------
--
function onChange(self)
end

-------------------------------------------------------------------------------
--
function onMouseDown(self, a_x, a_y, a_button)
    local col, row = self:getMouseCursorColumnRow(a_x, a_y)
    if col > 0 and row ~= -1 and 
       not(col == self.editCell.col and row == self.editCell.row) then
        local wid = self:getCell(col, row)
        if (self.editCell.widget) then
            onEndEditCell(self)
        end
        onStartEditCell(self, wid, col, row)
    end
end

-------------------------------------------------------------------------------
--
function onStartEditCell(a_grid,a_widgetCell,a_col, a_row) 
	if (a_grid.editable == false) then
		return;
	end
    a_grid.editCell.widget = a_widgetCell
    a_grid.editCell.col    = a_col
    a_grid.editCell.row    = a_row
    a_grid:removeCell(a_col, a_row)
    
    local spinParam = a_grid.SpinParam[a_col + 1]
    
    a_grid.editSpinBox:setRange(spinParam.min, spinParam.max)
    a_grid.editSpinBox:setStep(spinParam.step)
    a_grid.editSpinBox:setValue(a_widgetCell:getText())
    a_grid.editSpinBox:setSkin(Skin.spinBoxSkin_ME())
    a_grid:setCell(a_col, a_row, a_grid.editSpinBox)
    a_grid.editSpinBox:setFocused(true)
	a_grid.editSpinBox:selectAll()
end

-------------------------------------------------------------------------------
--
function onEndEditCell(a_grid)
    if a_grid.editCell.widget then    
        a_grid:removeCell(a_grid.editCell.col, a_grid.editCell.row)
        a_grid.editSpinBox:setFocused(false)
        
        local newValue = a_grid.editSpinBox:getValue()
        a_grid.data[a_grid.editCell.row+1][a_grid.editCell.col] = newValue
        a_grid.editCell.widget:setText(newValue)
        a_grid:setCell(a_grid.editCell.col, a_grid.editCell.row, a_grid.editCell.widget)
        a_grid.editCell = {}
    end
end

-------------------------------------------------------------------------------
--
function setData(self, a_data)
    onEndEditCell(self)
    self.data = a_data
    SortTable(self.data, 1)
    fillGrid(self, self.data)
end

-------------------------------------------------------------------------------
--
function getData(self)
    onEndEditCell(self)
    return self.data
end


-------------------------------------------------------------------------------
--
function SortTable(a_data, a_numCol) -- a_numCol - по какой колонке сортировать
    function compTable(tab1, tab2)
        local s1 = tab1[a_numCol]
        local s2 = tab2[a_numCol]
        if (type(s1) == 'string') and (type(s2) == 'string') then
            return textutil.Utf8Compare(s1, s2)
        end;
        return s1 < s2;       
    end
    
    table.sort(a_data, compTable)
end

-------------------------------------------------------------------------------
--
function fillGrid(a_grid, a_data)
    local i = 0
    local rowHeight = 20
    
    for k, v in pairs(a_data) do 
        a_grid:insertRow(rowHeight) 
        for j = 1, a_grid:getColumnCount() do
            local cell = Static.new(v[j])
            cell:setSkin(Skin.staticSpinGridCellSkin())      
            a_grid:setCell(j - 1, i, cell)
        end
        i = i + 1
    end
end

-------------------------------------------------------------------------------
--
function clear(self)
    onEndEditCell(self)
    self:clearRows()
end

-------------------------------------------------------------------------------
--
function callbackChangeData(a_table_row)
end

-------------------------------------------------------------------------------
--
function onChangeSpinBox(self)
    local newValue = self.Grid.editSpinBox:getValue()	
    self.Grid.data[self.Grid.editCell.row+1][self.Grid.editCell.col] = newValue
    self.Grid.editCell.widget:setText(newValue)
    
    local tmpTable = {}
    tmpTable.key   = self.Grid.data[self.Grid.editCell.row+1].key
    for j = 1, self.Grid:getColumnCount() do
        tmpTable[j] = self.Grid.data[self.Grid.editCell.row+1][j]
    end
    
    self.Grid.callbackChangeData(tmpTable)
end

-------------------------------------------------------------------------------
--
function setSpinParam(self, a_tableParam)
    for k,v in pairs(a_tableParam) do
        self.SpinParam[k].min = v.min
        self.SpinParam[k].max = v.max
        self.SpinParam[k].step = v.step
    end
end

-------------------------------------------------------------------------------
--
function resetCol(self, a_col, a_value)
	a_value = a_value or 0
    for k,v in pairs(self.data) do
        local tmpTable = {}
        local wid = self:getCell(a_col, k - 1)
        wid:setText(base.tostring(a_value))
        v[a_col] = a_value
        tmpTable.key = v.key
        for j = 1, self:getColumnCount() do
            tmpTable[j] = v[j]
        end
        
        self.callbackChangeData(tmpTable)
    end
end

-------------------------------------------------------------------------------
--
function setEditable(self, a_editable)
	self.editable = a_editable
end