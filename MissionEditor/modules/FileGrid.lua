local base = _G

module('FileGrid')
mtab = { __index = _M }

local require = base.require
local table = base.table
local ipairs = base.ipairs
local print = base.print
local string = base.string
local tostring = base.tostring

local Static            = require('Static')
local textutil          = require('textutil')
local Factory           = require('Factory')
local i18n              = require('i18n')
local lfs               = require('lfs')
local minizip           = require('minizip')
local UC				= require('utils_common')
local GridHeaderCell    = require('GridHeaderCell')
local TheatreOfWarData	= require('Mission.TheatreOfWarData')

i18n.setup(_M)

local cdata = {
	file = _('File'),
	date = _('Date Modified'),  
    map  = _('Map_fileGrid', 'Map'),   
}

local months = {
	_('Jan'),
	_('Feb'),
	_('Mar'),
	_('Apr'),
	_('May'),
	_('Jun'),
	_('Jul'),
	_('Aug'),
	_('Sep'),
	_('Oct'),
	_('Nov'),
	_('Dec'),
}

--type  "miz" "other"
function new(a_grid, a_nameColumnFile, a_nameColumnData, a_nameColumnMap, bOldStyle)
    if (a_nameColumnFile) then
        nameColumnFile = a_nameColumnFile
    else
        nameColumnFile = cdata.file
    end
    
    if (a_nameColumnData) then
        nameColumnData = a_nameColumnData
    else
        nameColumnData = cdata.date
    end
    
    if (a_nameColumnMap) then
        nameColumnMap = a_nameColumnMap
    else
        nameColumnMap = cdata.map
    end

	return Factory.create(_M, a_grid, nameColumnFile, nameColumnData, nameColumnMap, bOldStyle)
end

function construct(self, grid, nameColumnFile, nameColumnData, nameColumnMap, bOldStyle)
	-- grid должен содержать две колонки
	self.grid = grid
	
	self.Data = {}
    
	self:setMouseCallback()
	self:setKeyboardCallback()
	self.sortColumn = 0
	self.sortReverse = false
	self.selectFoldersOnly = false
	self.firstLetterRowIndices = {}
    
    self.rowLastMove = -1
    self.rowLast = -1

    self.hideExtension = false
    self.nameColumnFile = nameColumnFile
    self.nameColumnateDate = nameColumnData
    self.nameColumnMap = nameColumnMap
    self.funVerify = nil
    self.bHideMissions = false
    self.bEnableFilterTheatre = false
    
    self.bOldStyle = bOldStyle
end

function setBounds(self, a_x, a_y, a_w, a_h)
	self.grid:setBounds(a_x, a_y, a_w, a_h)
end

function clearSelectRow(self)
    unSelectRow(self, self.grid, self.rowLast)
    self.rowLast = -1
end

function isHideMissions(self)
    return self.bHideMissions
end

function setHideExtension(self,a_hideExtension)
    self.hideExtension = a_hideExtension
end

function setColumnText(self, index, text)
	local gridColumnHeader = self.grid:getColumnHeader(index)
	
	if gridColumnHeader then
		gridColumnHeader:setText(text)
	end
end

function setFileColumnText(self, text)
	self:setColumnText(self.fileColumnIndex, text)
end

function setDateColumnText(self, text)
	self:setColumnText(self.dateColumnIndex, text)
end

function setFileColumnWidth(self, width)
	self.grid:setColumnWidth(self.fileColumnIndex, width)
end

function setDateColumnWidth(self, width)
	self.grid:setColumnWidth(self.dateColumnIndex, width)
end

function normalizeColumnsWidth(self)
	local w, h = self.grid:getSize()
	
	local col_1 = self.grid:getColumnWidth(0)
	local col_2 = self.grid:getColumnWidth(1)
	local col_3 = self.grid:getColumnWidth(2)
	local sum = col_1+col_2+col_3
	
	self.grid:setColumnWidth(0, base.math.max(col_1/sum*(w-4),50))
	self.grid:setColumnWidth(1, base.math.max(col_2/sum*(w-4),50))
	self.grid:setColumnWidth(2, base.math.max(col_3/sum*(w-4),50))	
end


function setSelectFoldersOnly(self, selectFoldersOnly)
	self.selectFoldersOnly = selectFoldersOnly
end

function setMouseCallback(self)
	local grid = self.grid
	local fileGrid = self

	function grid:onMouseDown(x, y, button)
		fileGrid:onGridMouseDown(x, y, button, false)
	end
	
	function grid:onMouseDoubleClick(x, y, button)
		fileGrid:onGridMouseDown(x, y, button, true)
	end
   
    function grid:onMouseMove(x, y)
        local col        
        if fileGrid.rowLastMove and fileGrid.rowLastMove ~= fileGrid.rowLast then
            unSelectRow(fileGrid, grid, fileGrid.rowLastMove)
        end
        
        local selectedRowIndex = grid:getSelectedRow()
        col, indexRow = grid:getMouseCursorColumnRow(x, y)
        
        if selectedRowIndex ~= indexRow then            
            if -1 < col and -1 < indexRow then
                selectRowMove(fileGrid, grid, indexRow)
            end
        end 
    end
	
	grid:addMouseLeaveCallback(function(grid, x, y)
		 if fileGrid.rowLastMove and fileGrid.rowLastMove ~= fileGrid.rowLast then
            unSelectRow(fileGrid, grid, fileGrid.rowLastMove)
        end  
	end)
end

function setKeyboardCallback(self)
	local grid = self.grid
	local fileGrid = self
	
	grid:addKeyDownCallback(function(grid, keyName, unicode)
		if keyName == 'backspace' then
			self:onFolderClick('..', true)
		else
			local letter = textutil.UnicodeCharToUtf8String(unicode)
			
			if '' ~= letter then
				fileGrid:selectRowByFirstLetter(letter)
			end
		end
	end)
	
	grid:addSelectRowCallback(function(grid, currSelectedRow, prevSelectedRow)
		self:onRowClick(currSelectedRow, false)
	end)
end

function unSelectRow(self, grid, rowIndex)
    if rowIndex > -1 then
        local nameCellLast = grid:getCell(self.fileColumnIndex, rowIndex)
        
        if nameCellLast then
            local skinName = self.fileCellSkin
            if nameCellLast.type == "folder" then
                skinName = self.folderCellSkin
            end
            
            nameCellLast:setSkin(skinName)
            
            if self.mapColumnIndex then
                local statusCell = grid:getCell(self.mapColumnIndex, rowIndex)
                statusCell:setSkin(self.mapCellSkin)
            end

            local statusCell = grid:getCell(self.dateColumnIndex, rowIndex)
            statusCell:setSkin(self.dateCellSkin)
        end
    end
end

function selectRowMove(self, grid, rowIndex)
    self.rowLastMove = rowIndex
    if self.fileSelectedCellSkin and self.dateSelectedCellSkin then
        setSkinRow(self, grid, rowIndex, self.fileHoverCellSkin or self.fileSelectedCellSkin, 
                                   self.dateHoverCellSkin or self.dateSelectedCellSkin,
                                   self.folderHoverCellSkin or self.folderSelectedCellSkin,
                                   self.mapHoverCellSkin or self.mapSelectedCellSkin)
    end
end 

function selectRowClick(self, grid, rowIndex)
    if rowIndex < 0 then
        self.rowLast = -1
        return
    end
    self.rowLast = rowIndex
    if self.fileSelectedCellSkin and self.dateSelectedCellSkin then
        setSkinRow(self, grid, rowIndex, self.fileSelectedCellSkin, self.dateSelectedCellSkin, self.folderSelectedCellSkin, self.mapSelectedCellSkin)
    end
end 

function setSkinRow(self, grid,rowIndex, a_fileSkin, a_dateSkin, a_folderSkin, a_mapSkin)
    local nameCell = grid:getCell(self.fileColumnIndex, rowIndex)    

    if nameCell then
        if nameCell.type == "folder" then
            nameCell:setSkin(a_folderSkin)
        else
            nameCell:setSkin(a_fileSkin)
        end
        
        if self.mapColumnIndex then
            local statusCell = grid:getCell(self.mapColumnIndex, rowIndex)
            statusCell:setSkin(a_mapSkin)
        end

        local statusCell = grid:getCell(self.dateColumnIndex, rowIndex)
        statusCell:setSkin(a_dateSkin)
    end
end

function getRowFileName(self, rowIndex)
    local cell = self.grid:getCell(self.fileColumnIndex, rowIndex)   

    if cell then
        return cell.file
    end
    
    return 
end

function getRowType(self, rowIndex)
    local cell = self.grid:getCell(self.fileColumnIndex, rowIndex)   

    if cell then
        return cell.type
    end
    
    return 
end

function selectRow(self, rowIndex)
	local grid = self.grid	
	grid:selectRow(rowIndex)
	grid:setRowVisible(rowIndex)
end

function onRowClick(self, rowIndex, dblClick)
	if -1 ~= rowIndex then 
        self:unSelectRow(self.grid, self.rowLast)        
		self:selectRow(rowIndex)
        self:selectRowClick(self.grid, rowIndex)
        
        local cell = self.grid:getCell(self.fileColumnIndex, rowIndex)
		local fileName = cell.file
		
		if cell.type == "folder" then
			self:onFolderClick(fileName, dblClick)
		else
			self:onFileClick(fileName, dblClick)
		end
	end
end

function onGridMouseDown(self, x, y, button, dblClick)
	if 1 == button then
		local columnIndex, rowIndex = self.grid:getMouseCursorColumnRow(x, y)		
		self:onRowClick(rowIndex, dblClick)
	end
end

function setCellSkins(self, folderCellSkin, fileCellSkin, dateCellSkin, mapCellSkin)
	self.folderCellSkin = folderCellSkin
	self.fileCellSkin = fileCellSkin
	self.dateCellSkin = dateCellSkin
    self.mapCellSkin = mapCellSkin
end

function setColumnHeaderSkins(self, skinNoSort, skinSortUp, skinSortDown)
	self.skinNoSort = skinNoSort
	self.skinSortUp = skinSortUp
	self.skinSortDown = skinSortDown
end

function setSelectedCellSkins(self, fileSelectedCellSkin, dateSelectedCellSkin, folderSelectedCellSkin, mapSelectedCellSkin)
	self.fileSelectedCellSkin = fileSelectedCellSkin
	self.dateSelectedCellSkin = dateSelectedCellSkin
    self.folderSelectedCellSkin = folderSelectedCellSkin
    self.mapSelectedCellSkin = mapSelectedCellSkin
end

function setHoverCellSkins(self, fileHoverCellSkin, dateHoverCellSkin, folderHoverCellSkin, mapHoverCellSkin)
	self.fileHoverCellSkin = fileHoverCellSkin
	self.dateHoverCellSkin = dateHoverCellSkin
    self.folderHoverCellSkin = folderHoverCellSkin
    self.mapHoverCellSkin = mapHoverCellSkin
end

function initColumns(self, a_style)
	local fileGrid = self
	local grid = self.grid
    grid:clear()
    local columnIndex = 0
    local width, h = grid:getSize()
	
    local gridHeaderFile = GridHeaderCell.new() 
    gridHeaderFile:setSkin(self:getColumnHeaderSkin(columnIndex))    
    grid:insertColumn(200, gridHeaderFile, columnIndex)
	local fileHeaderCell = grid:getColumnHeader(columnIndex)
    self.fileColumnIndex = columnIndex
    columnIndex = columnIndex + 1
	
	fileHeaderCell:setText(self.nameColumnFile)

	fileHeaderCell:addChangeCallback(function()
		fileGrid:onFileColumn()
	end)

    if a_style == "addMap" then
        local gridHeaderMap = GridHeaderCell.new()
        gridHeaderMap:setSkin(self:getColumnHeaderSkin(columnIndex))   
        grid:insertColumn(200, gridHeaderMap, columnIndex)
        local mapHeaderCell = grid:getColumnHeader(columnIndex)
        self.mapColumnIndex = columnIndex
        columnIndex = columnIndex + 1
        
        mapHeaderCell:setText(self.nameColumnMap)
        
        mapHeaderCell:addChangeCallback(function()
            fileGrid:onMapColumn()
        end) 
        if self.bOldStyle then
            self.grid:setColumnWidth(self.fileColumnIndex, width - 117 - 137 -17)
        else
            self.grid:setColumnWidth(self.fileColumnIndex, width - 117 - 137 -5)
        end        
        self.grid:setColumnWidth(self.mapColumnIndex, 117)
    else 
        self.mapColumnIndex = nil
        if self.bOldStyle then
            self.grid:setColumnWidth(self.fileColumnIndex, width - 137 - 25)
        else
            self.grid:setColumnWidth(self.fileColumnIndex, width - 137 - 11 )
        end
        if self.sortColumn == 2 then
            self.sortColumn = 1
            --self.sortReverse = false
        end
    end
    
    local gridHeaderDate = GridHeaderCell.new()
    gridHeaderDate:setSkin(self:getColumnHeaderSkin(columnIndex))  
    grid:insertColumn(200, gridHeaderDate, columnIndex)
	local dateHeaderCell = grid:getColumnHeader(columnIndex)
    self.dateColumnIndex = columnIndex
	
	dateHeaderCell:setText(self.nameColumnData)
    self.grid:setColumnWidth(self.dateColumnIndex, 137)
	
	dateHeaderCell:addChangeCallback(function()
		fileGrid:onDateColumn()
	end)
    
    updateColumnHeaders(self)
end

function addFirstLetterRowIndices(self, fileData, rowIndex)
	local firstLetterRowIndices = self.firstLetterRowIndices
	local position = 0
	local length = 1
	
    local firstLetter = textutil.Utf8ToLowerCase(textutil.Utf8GetSubString(fileData.text, position, length))
    firstLetterRowIndices[firstLetter] = firstLetterRowIndices[firstLetter] or {}
    table.insert(firstLetterRowIndices[firstLetter], rowIndex)

end

function sortGrid(self)	
	local compareFunction = self:getCompareFunction()

    table.sort(self.Data, compareFunction)
	
	self:fillGrid()
	
	self:updateColumnHeaders()
end

function getColumnHeaderSkin(self, columnIndex)
	if self.sortColumn == columnIndex then
		if self.sortReverse then
			return self.skinSortDown
		else
			return self.skinSortUp
		end
	else
		return self.skinNoSort
	end
end

function updateColumnHeaders(self)
	local grid = self.grid 
	local count = grid:getColumnCount()
	
	for i = 0, count - 1 do
		local gridHeaderCell = grid:getColumnHeader(i)
		
		if gridHeaderCell then
			local skin = self:getColumnHeaderSkin(i)
			
			if skin then
				gridHeaderCell:setSkin(skin)
			end
		end
	end
end

function getCompareFunction(self)
	local compareFunction
	local reverse = self.sortReverse
	
	if self.sortColumn == self.dateColumnIndex then
		compareFunction = function(data1, data2)
            if data1.isFolder == true and data2.isFolder == false then
                return true
            end
            if data1.isFolder == false and data2.isFolder == true then
                return false
            end
			if reverse then
				return data1.date > data2.date
			else
				return data1.date < data2.date
			end
		end	
	elseif self.sortColumn == self.mapColumnIndex then
		compareFunction = function(data1, data2)
            if data1.isFolder == true and data2.isFolder == false then
                return true
            end
            if data1.isFolder == false and data2.isFolder == true then
                return false
            end

            if reverse then
				return textutil.Utf8Compare(data2.mapText, data1.mapText)
			else
				return textutil.Utf8Compare(data1.mapText, data2.mapText)
			end
		end	
    else    
        compareFunction = function(data1, data2)
            if data1.isFolder == true and data2.isFolder == false then
                return true
            end
            if data1.isFolder == false and data2.isFolder == true then
                return false
            end
			if reverse then
				return not textutil.Utf8CompareNoCase(data1.text, data2.text)
			else
				return textutil.Utf8CompareNoCase(data1.text, data2.text)
			end
		end
	end
	
	return compareFunction
end

function sortGridOnColumn(self)
	local selectedFilename = self:getSelectedRowText()
	
	self:sortGrid()
	
	if selectedFilename then
		self:selectRowText(selectedFilename)
	end	
end

function onFileColumn(self)
	if self.sortColumn == self.fileColumnIndex then
		self.sortReverse = not self.sortReverse
	else
		self.sortColumn = self.fileColumnIndex
		self.sortReverse = false
	end
	
	sortGridOnColumn(self)
end

function onMapColumn(self)
	if self.sortColumn == self.mapColumnIndex then
		self.sortReverse = not self.sortReverse
	else
		self.sortColumn = self.mapColumnIndex
		self.sortReverse = false
	end
	
	sortGridOnColumn(self)
end

function onDateColumn(self)
	if self.sortColumn == self.dateColumnIndex then
		self.sortReverse = not self.sortReverse
	else
		self.sortColumn = self.dateColumnIndex
		self.sortReverse = false
	end
	
	sortGridOnColumn(self)
end

function getDateString(date)
	if date then
		--local t = base.os.date('*t', date)
		
		--if t then
			--return string.format('%.2d-%s-%d %.2d:%.2d', t.day, months[t.month ], t.year, t.hour, t.min)
			-- return base.os.date('%d-%b-%Y %H:%M', date) -- должно быть так, но c русской локалью не работает
		--end	
        return base.os.date('%d.%m.%Y %H:%M', date) 
	end	
end

function createRowData(text, date, isFolder, theatre)
	local position = 0
	local length = 1
	local firstLetter = textutil.Utf8GetSubString(text, position, length)
	local firtsLetterLowerCase = textutil.Utf8ToLowerCase(firstLetter)
    local mapText = ""
    if theatre then
        mapText = TheatreOfWarData.getLocalizedName(theatre)
    end

	return {text = text, isFolder = isFolder or false, date = date, mapText = mapText, dateText = getDateString(date), firtsLetterLowerCase = firtsLetterLowerCase}
end

function addData(self, fileName, date, isFolder, theatre)
	table.insert(self.Data, createRowData(fileName, date, isFolder, theatre))
end

function findTextInDataTable(dataTable, text)
	for i, data in ipairs(dataTable) do
		if data.text == text then
			return i
		end
	end
end

function selectRowText(self, text)
	-- первая строка это '..'
	local grid = self.grid
	
	local rowIndex -- = findTextInDataTable(self.Data, text)
    
    for rIndex = 0, self.grid:getRowCount() - 1 do 
        local widget = grid:getCell(self.fileColumnIndex, rIndex)
      
        if widget.file == text then 
            rowIndex = rIndex          
            break
        end
    end
  	
	if not rowIndex then
		rowIndex = 0
	end
	
    self:selectRowClick(self.grid, rowIndex or -1)
	self:selectRow(rowIndex or -1)
end

function getSelectedRowText(self)
	return self:getRowFileName(self.grid:getSelectedRow())
end

function getFullName(self)
    if getRowType(self, self.grid:getSelectedRow()) == 'file' then
        return getPath(self).."/"..getSelectedRowText(self)
    end
    return nil    
end

-- extentions = это таблица с расширениями файлов {'exe', 'miz'} или nil
function setFilter(self, extentions)
	self.filter = nil
	
    local style = "normal"
    
	if extentions then
		self.filter = {}
		
		for i, extention in ipairs(extentions) do
			local pattern = string.format('%%.%s$', extention) -- получаем строку вида %.ext$
			table.insert(self.filter, pattern)
            if string.match(pattern, '.miz') ~= nil or string.match(pattern, '.trk') ~= nil then
                style = "addMap"
            end
		end
	end
	
    initColumns(self, style)
    
	if self.path then
		local selectedFilename = self:getSelectedRowText()
		
		self:setPath(self.path)
		
		if selectedFilename then
			self:selectRowText(selectedFilename)
		end
	end
end

function getPath(self)
	return self.path
end

function setPath(self, path)
	self.path = path
    self.Data = {}
    self.bHideMissions = false
	self.rowLast = -1
	--print("--setPath---",path)
	for fileName in lfs.dir(path) do
		local attributes = lfs.attributes(path .. '/' .. fileName)		
        
		if attributes then
			if attributes.mode == 'directory' then
				if fileName ~= '.' and fileName ~= '..' then
                    self:addData(fileName, attributes.modification, true)
				end
			elseif attributes.mode == 'file' then
				local filter = self.filter
				if filter then
					for i, pattern in ipairs(filter) do
                        --print("-----filter-----",pattern)
						if string.find(fileName, pattern) then  
                            local enable, theatre = self:verifyTheatre(path.."\\"..fileName)
                            if enable == true then
                                self:addData(fileName, attributes.modification, false, theatre)
                            else
                                self.bHideMissions = true    
                            end    
							break
						end
					end
				else
                    if self:verifyTheatre(path.."\\"..fileName) == true then
                        self:addData(fileName, attributes.modification, false)
                    else
                        self.bHideMissions = true 
                    end
				end
			end
		end
	end
	
	self:sortGrid()
    
   -- base.U.traverseTable(self.Data)
end

sumTime = 0
countT = 0

function verifyTheatre(self, a_fileName)
    local ext = UC.getExtension(a_fileName)
    if ext ~= "miz" and ext ~= "trk" then
        return true
    end
    
    local nameTheatre = UC.getNameTheatre(a_fileName)
	if nameTheatre == "StraitOfDover" then
		nameTheatre = "TheChannel"
	end
    if self.funVerify and self.funVerify(nameTheatre) == false then
        return false, nameTheatre    
    end
    return true, nameTheatre
end

function setVerifyTheatresFun(self, a_funVerify)
    self.funVerify = a_funVerify   -- funVerify(theatreName) return bool
end

function getFileName(a_fileName)
    local fileName = a_fileName
    if a_fileName ~= ".." then
        local dotIdx = string.find(string.reverse(a_fileName), 'zim%.')
        if dotIdx then
            fileName = string.sub(a_fileName, 0,-dotIdx-4)
        else
            dotIdx = string.find(string.reverse(a_fileName), 'krt%.')
            if dotIdx then
                fileName = string.sub(a_fileName, 0,-dotIdx-4)
            end
        end
    end    
    return fileName
end

function addGridRow(self, data, fileCellSkin, dateCellSkin, mapCellSkin, a_type)
	local grid = self.grid
	local rowHeight = 20
	local rowIndex = grid:getRowCount()
	
	grid:insertRow(rowHeight)
    
    local displayText = data.text
    if self.hideExtension == true then
        displayText = getFileName(displayText)
    end
	
    -- fILE
	local fileCell = Static.new(displayText)
    fileCell.type = a_type
    fileCell.file = data.text
    
	fileCell:setTooltipText(displayText)
	
	if fileCellSkin then
		fileCell:setSkin(fileCellSkin)
	end
	
	grid:setCell(self.fileColumnIndex, rowIndex, fileCell)
    
	-- MAP
    if self.mapColumnIndex then
        local mapCell = Static.new(data.mapText)    
        
        if mapCellSkin then
            mapCell:setSkin(mapCellSkin)
        end
        
        grid:setCell(self.mapColumnIndex, rowIndex, mapCell)
    end
    
    -- DATE
	local dateCell = Static.new(data.dateText)    
	
	if dateCellSkin then
		dateCell:setSkin(dateCellSkin)
	end
	
	grid:setCell(self.dateColumnIndex, rowIndex, dateCell)

    return rowIndex
end

function fillGrid(self)
	self.grid:clearRows()
    self.firstLetterRowIndices = {}

	local folderCellSkin = self.folderCellSkin
	local fileCellSkin = self.fileCellSkin
	local dateCellSkin = self.dateCellSkin
    local mapCellSkin = self.mapCellSkin
    local rowIndex

    self:addGridRow(createRowData('..'), folderCellSkin, dateCellSkin, mapCellSkin, "folder")
    
    for i, fileData in ipairs(self.Data) do
        if self.selectFoldersOnly ~= true or fileData.isFolder == true then
            if fileData.isFolder == true then
				rowIndex = self:addGridRow(fileData, folderCellSkin, dateCellSkin, mapCellSkin, "folder")
            else                
				rowIndex = self:addGridRow(fileData, fileCellSkin, dateCellSkin, mapCellSkin, "file")
            end
        end  
        self:addFirstLetterRowIndices(fileData, rowIndex)    
    end
end

function selectRowByFirstLetter(self, letter)
	local letter = textutil.Utf8ToLowerCase(letter)
	local rowIndices = self.firstLetterRowIndices[letter]
	
	if rowIndices then
		local selectedRowIndex = self.grid:getSelectedRow()
		
		if -1 == selectedRowIndex then
			self:onRowClick(rowIndices[1], false)
		else
			if selectedRowIndex >= rowIndices[#rowIndices] then
				self:onRowClick(rowIndices[1], false)
			else
				for i, rowIndex in ipairs(rowIndices) do
					if rowIndex > selectedRowIndex then
						self:onRowClick(rowIndex, false)
						break
					end
				end
			end
		end
	end
end

function onFolderClick(self, folderName, dblClick)
end

function onFileClick(self, fileName, dblClick)
end

function getSortColumnReverse(self)
    return self.sortColumn, self.sortReverse
end

function setSortColumnReverse(self,a_sortColumn, a_sortReverse)
    if a_sortColumn == nil or a_sortReverse == nil then
        return
    end
	
    self.sortColumn = a_sortColumn
    self.sortReverse = a_sortReverse
end

function getFileNamesList(self)
	local result = {}
	
	for i, fileData in ipairs(self.Data) do
		table.insert(result, fileData.text)
    end
	
	return result
end

function getSelectedFile(self)
	local selectedRowIndex = self.grid:getSelectedRow()
	
	if -1 ~= selectedRowIndex then
		local cell = self.grid:getCell(self.fileColumnIndex, selectedRowIndex)
		
		if cell then
			return cell.file, cell.type == 'folder'
		end
	end
end

function setSelectedFileVisible(self)
	local selectedRowIndex = self.grid:getSelectedRow()
	if selectedRowIndex > -1 then
		self.grid:setRowVisible(selectedRowIndex)
	end	
end

function setFocused(self, focused)
	self.grid:setFocused(focused)
end