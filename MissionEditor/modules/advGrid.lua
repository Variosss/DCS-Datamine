-- онтрол 

local base = _G

module('advGrid')
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
    self.tblSkins = nil
    self.selectRowIndex = nil
    self.rowLast = -1
    self.rowLastMove = -1
    

    self:setMouseCallback()

	grid:addFocusCallback(function()

	end)


end

-------------------------------------------------------------------------------
--
function create(self, a_x, a_y, a_w, a_h)
    self.Grid:setBounds(self, a_x, a_y, a_w, a_h)
    
    return self.Grid;
end

-------------------------------------------------------------------------------
-- a_tblSkins = {   all = { normal = ..., select = ..., hover = ...,},
--                  individual = { func = ..., normal = ..., select = ..., hover = ...,},
--                }
-- all - скин дл€ €чейки столбца у которой не задан индивидуальный
-- individual - скин дл€ €чейки столбца соответствующего ключу таблицы
-- func(cell, typeSkin) функци€ установки скина, параметр €чейка таблицы, typeSkin - требуемый тип скина
function setSkins(self, a_tblSkins)
    self.tblSkins = a_tblSkins
end 

-------------------------------------------------------------------------------
--
function setMouseCallback(self)
	local grid = self.Grid
    local this = self
   
    function grid:onMouseMove(x, y)
        local col
        
        col, indexRow = grid:getMouseCursorColumnRow(x, y)        
        
        if this.rowLastMove and this.rowLastMove ~= this.rowLast then
            unSelectRow(this, grid, this.rowLastMove)
        end
        
        local selectedRowIndex = grid:getSelectedRow()
        
        if selectedRowIndex ~= indexRow then            
            if -1 < col and -1 < indexRow then
                selectRowMove(this, grid, indexRow)
            end
        end 
    end
	
	grid:addMouseLeaveCallback(function(grid, x, y)
		if this.rowLastMove and this.rowLastMove ~= this.rowLast then
            unSelectRow(this, grid, this.rowLastMove)
            this.rowLastMove = -1
        end  
	end)
    
    function grid:onMouseDown(x, y, button)
        local col, row = grid:getMouseCursorColumnRow(x, y)

        if -1 < row then
            selectRow(this, row)
        end
    end
end

function unSelectRow(self, grid, rowIndex)
    if rowIndex and rowIndex >= 0 then
        setSkinRow(self, grid, rowIndex, 'normal')
    end
end


function selectRowMove(self, grid, rowIndex)
    if rowIndex < 0 or self.hoverEnable == false then
        self.rowLastMove = -1
        return
    end
    
    self.rowLastMove = rowIndex
        
	setSkinRow(self, grid, rowIndex, 'hover')
end 

function setSkinRow(self, grid, rowIndex, a_typeSkin)
    local columnCount = grid:getColumnCount()
	for i = 0, columnCount - 1 do
        local cell = grid:getCell(i, rowIndex)   
		
		if cell then
            if self.tblSkins['individual'] and self.tblSkins['individual'][i] and self.tblSkins['individual'][i].func then
                cell:setSkin(self.tblSkins['individual'][i].func(cell, a_typeSkin))
            elseif self.tblSkins['individual'] and self.tblSkins['individual'][i] and self.tblSkins['individual'][i][a_typeSkin]then
                cell:setSkin(self.tblSkins['individual'][i][a_typeSkin])
			else
                if self.tblSkins['all'].func then
                    cell:setSkin(self.tblSkins['all'].func(cell, a_typeSkin))    
                else
                    cell:setSkin(self.tblSkins['all'][a_typeSkin])
                end
            end
		end
	end
end

function selectRow(self, rowIndex)
    if self.rowLast >= 0 then
        unSelectRow(self, self.Grid, self.rowLast)
    end 
    
    if rowIndex < 0 then
        self.rowLast = -1
        return
    end
    
    if rowIndex == self.rowLastMove then
        self.rowLastMove = -1
    end

    self.rowLast = rowIndex    
    
    setSkinRow(self, self.Grid, rowIndex, 'select')
    self.Grid:selectRow(rowIndex)
end

function unSelectGrid(self)
	if self.rowLast >= 0 then
        unSelectRow(self, self.Grid, self.rowLast)
		self.Grid:selectRow(-1)
    end 
	self.rowLast = -1
end

function updateSkins(self)
    local rowCount = self.Grid:getRowCount()
	for rowIndex = 0, rowCount - 1 do
        setSkinRow(self, self.Grid, rowIndex, 'normal')
    end
end

function setHoverEnable(self, a_enable)
    self.hoverEnable = a_enable
end

