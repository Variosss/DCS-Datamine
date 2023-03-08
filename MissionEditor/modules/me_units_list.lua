local base = _G

module('me_units_list')

local require = base.require
local table = base.table
local pairs = base.pairs
local ipairs = base.ipairs
local tostring = base.tostring
local next = base.next

local DialogLoader = require('DialogLoader')
local Static = require('Static')
local GridHeaderCell = require('GridHeaderCell')
local U = require('me_utilities')
local MapWindow = require('me_map_window')
local MissionModule = require('me_mission')
local toolbar = require('me_toolbar')
local panel_aircraft = require('me_aircraft')
local panel_ship = require('me_ship')
local panel_vehicle = require('me_vehicle')
local panel_static = require('me_static')
local panel_route = require('me_route')
local CoalitionController	= require('Mission.CoalitionController')
local DB = 	require('me_db_api')
local modulesInfo       = require('me_modulesInfo')
local textutil          = require('textutil')
local MeSettings	 	= require('MeSettings')
local crutches			= require('me_crutches')

local i18n = require('i18n')
i18n.setup(_M)

cdata = {
    title = _('UNIT LIST'),
    helicopters = _('Helicopters'),
    planes = _('Planes'),
    vehicles = _('Vehicles'),
    ships = _('Ships'),
    statics = _('Statics'),
    object = _('GROUP NAME'),
	unitName = _('UNIT NAME'),
    side = _('COUNTRY'),
	skill = _('SKILL'),
    status = _('STATUS'),
    quantity = _('QNTY'),
    hidden = _('HIDDEN'),
    allCountries = _('ALL'),
    red = _('RED'),
    blue = _('BLUE'), 
	neutrals = _('NEUTRAL'), 	
    Total = _('Total:'),    
    units = _('units'),  
	unitType = _('UNIT TYPE'),  
	unitId = _('UNIT ID'),  
	modul = _('MODULE'),  
	showHidden = _('Show Hidden Units'),  
}

local unitsNum = {}
unitsNum['helicopter']= 0
unitsNum['plane']= 0
unitsNum['vehicle']= 0
unitsNum['ship']= 0
unitsNum['static']= 0

local curKeySort = 'name'
local sortReverse = false
local lastCountryFilter = nil

local KeysSort = 
    {
        "name", 
		"unitName",
        "unitType",
        "unitId",
        "country",
		"skill",
        "status",
        "module",
    }

function applyFilter(group)
    if not group then
        return false
    end
    
    local coalitionName = group.boss.boss.name
    local countryName = group.boss.name
    
    if filters[group.type]:getState() then
        local comboText = countryFilter:getText()
        
        if comboText == cdata.allCountries then
            return true
        end
        if (comboText == cdata.red) and (coalitionName == CoalitionController.redCoalitionName()) then
            return true
        end
        if (comboText == cdata.blue) and (coalitionName == CoalitionController.blueCoalitionName()) then
            return true
        end
		if (comboText == cdata.neutrals) and (coalitionName == CoalitionController.neutralCoalitionName()) then
            return true
        end
        if (comboText == countryName) then
            return true
        end
        return false
    else
        return false
    end
end

function createColumnInfo(name, width)
  return {name = name, width = width}
end

function initColumnInfos()
    -- размеры колонок и надписи заголовка
    columnInfos = {
        createColumnInfo(cdata.object, 400),
		createColumnInfo(cdata.unitName, 400),
		createColumnInfo(cdata.unitType, 110),
		createColumnInfo(cdata.unitId, 90),
        createColumnInfo(cdata.side, 100),
		createColumnInfo(cdata.skill, 100),		 
        createColumnInfo(cdata.status, 100),
        createColumnInfo(cdata.modul, 170),
    }
end

function getColumnInfoCount()
  return #columnInfos
end

function getColumnInfo(index)
  return columnInfos[index]
end

function createGridHeader()
    initColumnInfos()
    
    local columnInfoCount = getColumnInfoCount()
    
    for i = 1, columnInfoCount do
        local columnInfo = getColumnInfo(i)
        local headerCell = GridHeaderCell.new(columnInfo.name)
		headerCell.KeySort = KeysSort[i]  
		local skin = getColumnHeaderSkin(headerCell.KeySort)
		headerCell:setSkin(skin)

        grid:insertColumn(columnInfo.width, headerCell)
		
		headerCell:addChangeCallback(function(self)        
            if curKeySort == self.KeySort then
                sortReverse = not sortReverse
            else
                sortReverse = false
            end
            curKeySort = self.KeySort
            --local tmpList = {}
            --base.U.recursiveCopyTable(tmpList,listServers)
            update()
        end	)
    end 
end

function updateColumnHeaders()
	local columnInfoCount = getColumnInfoCount()
	
	for i = 0, columnInfoCount-1 do
		local gridHeaderCell = grid:getColumnHeader(i)
		
		if gridHeaderCell then
			local skin = getColumnHeaderSkin(gridHeaderCell.KeySort)
			
			if skin then
				gridHeaderCell:setSkin(skin)
			end
		end
	end
end

function createGrid()
   createGridHeader()  
   loadColumnsWidth()
  
    -- установим калбеки для грида
    function grid:onMouseDown(x, y, button)
        if 1 == button then
            local col, row = self:getMouseCursorColumnRow(x, y)

            if -1 < col and -1 < row then
				self:selectRow(row)
				
				local cell = self:getCell(col, row)
				
				if cell then
					onGridMouseDown(cell)
				end
            end
        end
    end    
    
    function grid:onMouseDoubleClick(x, y, button)
        if 1 == button then
            local col, row = self:getMouseCursorColumnRow(x, y)
      
            if -1 < col and -1 < row then
				self:selectRow(row)
				
				local cell = self:getCell(col, row)
				
				if cell then
					onMouseDoubleClick(cell)
				end
            end
        end        
    end   
	
	grid:addSelectRowCallback(function(grid, currSelectedRow, prevSelectedRow)
		if -1 < currSelectedRow then
			local cell = grid:getCell(0, currSelectedRow)
			
			if cell then
				onGridMouseDown(cell)
			end
		end
	end)
end

local function addFilter(filters, filterType, checkBox)
    checkBox.onChange = update
    filters[filterType] = checkBox
end

local function createFilters()
    filters = {}
    
    addFilter(filters, 'helicopter', window.checkBoxHelicopters)
    addFilter(filters, 'plane',  window.checkBoxPlanes)
    addFilter(filters, 'vehicle', window.checkBoxVehicles)
    addFilter(filters, 'ship', window.checkBoxShips)
    addFilter(filters, 'static', window.checkBoxStatics)
end

function create(x, y, w, h)
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_units_list_panel.dlg", cdata)
    window:setBounds(x, y, w, h)
    
    grid = window.grid
	pNoVisible = window.pNoVisible
	bSelectPlayer = window.bSelectPlayer
	cbShowHidden = window.cbShowHidden
    
	SkinsHeaders = 
    {
        [1] = {
            skinSortUp      = pNoVisible.gridHeaderCellSortUpPadding:getSkin(),
            skinSortDown    = pNoVisible.gridHeaderCellSortDownPadding:getSkin(),
            skinNoSort      = pNoVisible.gridHeaderCellNoSortPadding:getSkin(),
        }        
    }
	
    local cw, ch = window:getClientRectSize()
    local gridX, gridY = grid:getPosition()
    
    grid:setSize(cw - gridX, ch - gridY)
    
    cellSkin = window.staticCell:getSkin()
    
    countryFilter = window.countryFilter
    
    createFilters()
    
    updateCountriesCombo()
    countryFilter:setText(cdata.allCountries)
    countryFilter.onChange = update
	bSelectPlayer.onChange = onChange_bSelectPlayer
	cbShowHidden.onChange = onChange_cbShowHidden

    function window:onClose()
        show(false)
        toolbar.setUnitListButtonState(false)
    end
    
    createGrid()
    
    
    window:addHotKeyCallback("Up", onGridUp)
    window:addHotKeyCallback("Down", onGridDown)
end

function getColumnHeaderSkin(a_key)
	if curKeySort == a_key then
		if sortReverse then
			return SkinsHeaders[1].skinSortDown
		else
			return SkinsHeaders[1].skinSortUp
		end
	else
		return SkinsHeaders[1].skinNoSort
	end
end

function onGridUp()
    local index = grid:getSelectedRow()
    if index > 0 then
        grid:selectRow(index-1)
        
        local cell = grid:getCell(0, index-1)
        
        if cell then
            onGridMouseDown(cell)
        end    
    end    
end

function onGridDown()
    local index = grid:getSelectedRow()
    if index < (grid:getRowCount()-1) then
        grid:selectRow(index-1)
        
        local cell = grid:getCell(0, index+1)
        
        if cell then
            onGridMouseDown(cell)
        end    
    end 
end


function show(b)
    if b then
		cbShowHidden:setState(MapWindow.isShowHidden())
        updateCountriesCombo()
        update()

        if MapWindow.selectedGroup then
            selectGroup(MapWindow.selectedGroup, MapWindow.getSelectedUnit())
        else 
            -- никто не выделен
            -- получаем первую группу из списка групп
            -- и выделяем эту группу
            local k = next(MissionModule.group_by_name)
            
            if k then 
                local group = MissionModule.group_by_name[k]
                
                if group and (not group.hidden) then 
                    selectGroup(group)
                    selectRow(group, 1)
                end
            else
                window:setVisible(false)
                toolbar.setUnitListButtonState(false)
                
                return
            end
			updateBtnPlayerUnit()
        end		
    else
        toolbar.setUnitListButtonState(false)
		saveColumnsWidth()
    end
    
    window:setVisible(b)
end

function loadColumnsWidth()
	local columnsWidth = MeSettings.getUnitsListColumnsWidth()
	if columnsWidth then
		for column = 0, grid:getColumnCount() - 1 do
			if columnsWidth[column] then
				grid:setColumnWidth(column, columnsWidth[column])
			end
		end
	end
end

function saveColumnsWidth()
	local columnsWidth = {}
	for column = 0, grid:getColumnCount() - 1 do
		columnsWidth[column] = grid:getColumnWidth(column)
	end
	MeSettings.setUnitsListColumnsWidth(columnsWidth)
end

function updateBtnPlayerUnit()
	local playerUnit = MissionModule.getPlayerUnit()
	if playerUnit then
		bSelectPlayer:setVisible(true)
	else
		bSelectPlayer:setVisible(false)
	end	
end

function onChange_bSelectPlayer()
	MapWindow.focusPlayer()
end

function onChange_cbShowHidden(self)
	base.print("--onChange_cbShowHidden--",self:getState())
	base.MapWindow.setShowHidden(self:getState())	
end

function updateStatistic()
    window.s_helicopters:setText(unitsNum['helicopter'])
    window.s_planes:setText(unitsNum['plane'])
    window.s_vehicles:setText(unitsNum['vehicle'])
    window.s_ships:setText(unitsNum['ship'])
    window.s_statics:setText(unitsNum['static'])
    window.s_total:setText(unitsNum['helicopter']+unitsNum['plane']+unitsNum['vehicle']+unitsNum['ship']+unitsNum['static'])
end

local function createGroupByNameTable()
    local group_by_name = {}
    unitsNum['helicopter']= 0
    unitsNum['plane']= 0
    unitsNum['vehicle']= 0
    unitsNum['ship']= 0
    unitsNum['static']= 0
    
    for r,group in pairs(MissionModule.group_by_name) do
        if group then 
            table.insert(group_by_name,group)             
            unitsNum[group.type] = unitsNum[group.type] + #group.units
        end
    end
    
    updateStatistic()    
    local sortGroupByName = function(group1, group2)
        return group1.name < group2.name
    end
    
    table.sort(group_by_name, sortGroupByName)
    
    return group_by_name
end

local function getHiddenString(group)
  local result = ''
            
  if group.hidden then 
      result = cdata.hidden
  end
  
  return result
end

local function fillGridRow(group, unit, text)
    -- FIXME: высота строки задается в скине
    local rowHeight = 20
    
    grid:insertRow(rowHeight)
    
    local rowIndex = grid:getRowCount() - 1
	      
    local columnInfoCount = getColumnInfoCount()
    
    for columnIndex = 0, columnInfoCount - 1 do
        local cell = Static.new(text[KeysSort[columnIndex + 1]])
		
        cell:setTooltipText(cell:getText())		
        cell:setSkin(cellSkin)
        cell.data = {group = group, unit = unit, r = rowIndex, c = columnIndex}

        grid:setCell(columnIndex, rowIndex, cell)
    end
end

local function compTable(tab1, tab2)
	if curKeySort == "skill" then
		
		local skill1 = crutches.nameToIndex(tab1.text[curKeySort]) or 9
		local skill2 = crutches.nameToIndex(tab2.text[curKeySort]) or 9

		if skill1 == skill2 then  
			return (tab1.text['unitId'] < tab2.text['unitId'])
		end
		if sortReverse then
			return skill1 > skill2
		end
		return skill1 < skill2
	else
		if base.type(tab1.text[curKeySort]) == "string" then
			if (base.tostring(tab1.text[curKeySort]) == base.tostring(tab2.text[curKeySort])) then            
				--return textutil.Utf8Compare(tab1.text['name'], tab2.text['name'])
				return (tab1.text['unitId'] < tab2.text['unitId'])
			end
			if sortReverse then
				return textutil.Utf8Compare(tab2.text[curKeySort], tab1.text[curKeySort])
			end
			return textutil.Utf8Compare(tab1.text[curKeySort], tab2.text[curKeySort])
		elseif base.type(tab1.text[curKeySort]) == "boolean" then
			if (base.tostring(tab1.text[curKeySort]) == base.tostring(tab2.text[curKeySort])) then            
				--return textutil.Utf8Compare(tab1.text['name'], tab2.text['name'])
				return (tab1.text['unitId'] < tab2.text['unitId'])
			end
			if sortReverse then
				return (base.tostring(tab1.text[curKeySort]) < base.tostring(tab2.text[curKeySort]))
			end
			return (base.tostring(tab1.text[curKeySort]) > base.tostring(tab2.text[curKeySort]))
		else
			if (base.tostring(tab1.text[curKeySort]) == base.tostring(tab2.text[curKeySort])) then            
				--return textutil.Utf8Compare(tab1.text['name'], tab2.text['name'])
				return (tab1.text['unitId'] < tab2.text['unitId'])
			end
			if sortReverse then
				return (tab1.text[curKeySort] > tab2.text[curKeySort])
			end
			return (tab1.text[curKeySort] < tab2.text[curKeySort])
		end 
	end	
end

function update()   
	lastCountryFilter = countryFilter:getText()
    -- очищаем грид
    grid:clearRows()

    local group_by_name = createGroupByNameTable()
    
	local tmpListUnits = {}
    for r, group in pairs(group_by_name) do
        if group and applyFilter(group) then 
			for k, unit in base.ipairs(group.units) do
				local text = {	name 		= group.name, 
					unitName 	= unit.name,
					unitType 	= DB.getDisplayNameByName(unit.type), 
					unitId 		= unit.unitId,
					country		= group.boss.name, 
					status		= getHiddenString(group),
					skill		= unit.skill or "",
					module		= getModulName(unit)}  
				table.insert(tmpListUnits,{group = group, unit = unit, text = text})				
			end
        end
    end
	
	table.sort(tmpListUnits, compTable)
	
	for k,v in base.ipairs(tmpListUnits) do
		fillGridRow(v.group, v.unit, v.text)
    end
	
    -- выделяем
    if MapWindow.selectedGroup and MapWindow.selectedGroup.boss then 
        selectRowByUnit(MapWindow.selectedGroup, MapWindow.getSelectedUnit())
    end
	
	updateColumnHeaders()
end

-------------------------------------------------------------------------------
--
function onMouseDoubleClick(self)
    self.data.group.hidden = not self.data.group.hidden
    
    -- обновить инфо группы
	updateGroup(self.data.group)
	MapWindow.changeHiddenGroup(self.data.group)
    onGridMouseDown(self)
end

-- обработчик кликов на строках грида
function onGridMouseDown(self, x, y, button)
    if not applyFilter(self.data.group) then 
        return
    end

    selectGroup(self.data.group, self.data.unit)
    selectRow(self.data.group, self.data.r)
end

-- выделяем группу на карте
function selectGroup(group, a_unit)
    if (not group) or (not group.boss) or (not group.boss.boss) or (not applyFilter(group)) then 
        return
    end
    
    if not (MapWindow.isShowHidden(group) == true) then
        MapWindow.unselectAll()
        MapWindow.selectedGroup = group
        setCheckBox(group.type, true)
        local selectedUnit = a_unit or group.units[1]
		
        local mapObject = group.mapObjects.units[1]
        MapWindow.setSelectedUnit(selectedUnit)
        MapWindow.respondToSelectedUnit(mapObject, group, selectedUnit)
        return
    end
    
    local mapObject
    
    local selectedUnit = a_unit or group.units[1]
	
    if group.mapObjects.route then
        mapObject = group.mapObjects.route.points[1]
    else
        mapObject = group.mapObjects.units[1].userObject
        mapObject.userObject = group.mapObjects.units[1].userObject
    end
	
	if a_unit and a_unit.index ~= 1 then
		mapObject = group.mapObjects.units[a_unit.index]
	end
	
    setCheckBox(group.type, false)

    if not mapObject then 
        return
    end
    
    local unit = group.mapObjects.units[selectedUnit.index].userObject
    
    MapWindow.unselectAll()
    
	
		
    MapWindow.respondToSelectedUnit(mapObject, group, selectedUnit)
	if a_unit == nil or a_unit.index == 1 then
		MapWindow.updateSelectedGroup(group)
    end
    panel_route.update()
    
    if window:isVisible() then
        -- установить камеру на группу
        -- в момент установки снизу и сбоку окна карты болтаются другие окна,
        -- поэтому нужно получить точку в середине обрезанного треугольника
        MapWindow.setCamera(group.x, group.y)
        
        local mx,my,mw,mh = MapWindow.window:getBounds()
        local _x,_y = MapWindow.window:widgetToWindow((mw - U.right_toolbar_width)/2,(mh - 300)/2)
        local x, y =  MapWindow.getMapPoint(_x,_y)
        
        MapWindow.setCamera(2*group.x - x, 2*group.y - y)        
    end
    
end

function getGroupRowIndex(group, unit)
  local result
  
  for rowIndex = 0, grid:getRowCount() - 1 do 
      local widget = grid:getCell(0, rowIndex)
      
      if widget.data.group == group and (unit == nil or widget.data.unit == unit) then 
          result = rowIndex
          
          break
      end
  end
  return result
end

function selectRowByUnit(group, unit)
	local rowIndex = getGroupRowIndex(group, unit)
	selectRow(group, rowIndex)
end

-- выделяем строку в гриде
function selectRow(group, rowIndex)
    if not applyFilter(group) then 
        grid:selectRow(-1)        
        return
    end
    
    if not rowIndex then 
        rowIndex = getGroupRowIndex(group)
        
        if rowIndex then
            grid:selectRow(rowIndex)
            selection = rowIndex          
        end
    else
        grid:selectRow(rowIndex)
    end
end

function updateGroup(group)
	if not applyFilter(group) then 
        return
    end
	
	if window:getVisible() == false then
		return
	end
	
	local rowCount = grid:getRowCount()
	for rowIndex = 0, rowCount - 1 do
		local widget = grid:getCell(0, rowIndex)
        
        if widget.data.group == group then 
            widget:setText(group.name)

			widget = grid:getCell(1, rowIndex)
            widget:setText(widget.data.unit.name)
			widget:setTooltipText(widget:getText())	
			
			widget = grid:getCell(2, rowIndex)
            widget:setText(DB.getDisplayNameByName(widget.data.unit.type))
			widget:setTooltipText(widget:getText())	

			widget = grid:getCell(3, rowIndex)
            widget:setText(widget.data.unit.unitId)
			widget:setTooltipText(widget:getText())	
			
            widget = grid:getCell(4, rowIndex)
            widget:setText(group.boss.name)
			widget:setTooltipText(widget:getText())	

			widget = grid:getCell(5, rowIndex)
			widget:setText(widget.data.unit.skill)
			widget:setTooltipText(widget:getText())	
            
            widget = grid:getCell(6, rowIndex)
            
            local hiddenStr = ''
            
            if group.hidden then 
                hiddenStr = cdata.hidden 
            end
            
            widget:setText(hiddenStr)
			widget:setTooltipText(widget:getText())	
			
            widget = grid:getCell(7, rowIndex)
            widget:setText(getModulName(widget.data.unit))
        end
	end
	
end

function updateOneRow(rowIndex, group, unit)
	if rowIndex then
		local widget = grid:getCell(0, rowIndex)
		
		if widget.data.group == group and widget.data.unit == unit then 
			widget:setText(group.name)
			
			widget = grid:getCell(1, rowIndex)
			widget:setText(unit.name)
			widget:setTooltipText(widget:getText())	
			
			widget = grid:getCell(2, rowIndex)
			widget:setText(DB.getDisplayNameByName(unit.type))
			widget:setTooltipText(widget:getText())	
			
			widget = grid:getCell(3, rowIndex)
			widget:setText(unit.unitId)
			widget:setTooltipText(widget:getText())	
			
			widget = grid:getCell(4, rowIndex)
			widget:setText(group.boss.name)
			widget:setTooltipText(widget:getText())	
			
			widget = grid:getCell(5, rowIndex)
			widget:setText(unit.skill)
			widget:setTooltipText(widget:getText())	
			
			widget = grid:getCell(6, rowIndex)
		
			local hiddenStr = ''
			
			if group.hidden then 
				hiddenStr = cdata.hidden 
			end
			
			widget:setText(hiddenStr)
			widget:setTooltipText(widget:getText())	
			
			widget = grid:getCell(7, rowIndex)
			widget:setText(getModulName(unit))
		end
		
		selectRow(group, rowIndex)
	end
end

-- обновляем строку в гриде
function updateRow(group, unit)
    if not applyFilter(group) then 
        return
    end
	
	if window:getVisible() == false then
		return
	end
    
	if unit ~= nil then
		local rowIndex = getGroupRowIndex(group, unit)
		updateOneRow(rowIndex, group, unit)
	else --обновляем всю группу
		for i = #group.units, 1, -1 do
			local unit = group.units[i]
			local rowIndex = getGroupRowIndex(group, unit)			
			updateOneRow(rowIndex, group, unit)
		end
	end	
end

function getModulName(a_unit)
	if a_unit.type ~= 'Train' then
		local unitDef = DB.unit_by_type[a_unit.type]  
		
		if unitDef._origin and base.pluginsById[unitDef._origin].is_core ~= true then
			return modulesInfo.getModulDisplayNameByModulId(unitDef._origin)
		end	
	elseif a_unit.wagons then
		local needMods 
		for k, v in base.pairs(a_unit.wagons) do
			local unitDef = DB.unit_by_type[v] 

			if unitDef._origin and base.pluginsById[unitDef._origin].is_core ~= true then
				local dispName = modulesInfo.getModulDisplayNameByModulId(unitDef._origin)
				
				needMods = needMods or {}
				needMods[dispName] = dispName
			end	
		end
		
		local result
		if needMods then
			for k,v in base.pairs(needMods) do
				if result == nil then
					result = v
				else
					result = result..", "..v
				end
			end
		end
								
		if result then
			return result
		end
	end
	
	return ""
end

-- установка значения чекбокса на соответствующих панелях
function setCheckBox(type, b)
    if type == 'plane' or
       type == 'helicopter' then
        panel_aircraft.hiddenCheckbox:setState(b)
    elseif type == 'ship' then
        panel_ship.hiddenCheckbox:setState(b)
    elseif type == 'vehicle' then
        panel_vehicle.hiddenCheckbox:setState(b)
    elseif type == 'static' then
        panel_static.hiddenCheckbox:setState(b)
    end
end

function selectNextGroup()
    local rowCount = grid:getRowCount()

    if -1 ~= selection then
        if selection > rowCount - 1 then
            selection = rowCount - 1
        end
        
        if -1 ~= selection and (selection >= 0)then
            local w = grid:getCell(0, selection)
            local data = w.data
            
            selectGroup(data.group)
            selectRow(data.group, selection)
        else
            show(false)
            MapWindow.selectedGroup = nil
            toolbar.untoggle_all_except()        
        end
	else
		show(false)
		MapWindow.selectedGroup = nil
		toolbar.untoggle_all_except()        
    end   
end

function saveSelection()
    selection = grid:getSelectedRow()
end

function updateCountriesCombo()
    if MissionModule.mission == nil then
        return
    end
    
    countryFilter:clear()
	
	local countries = CoalitionController.getActiveCountries()
	
    table.insert(countries, 1, cdata.allCountries)
    table.insert(countries, 2, cdata.red)
    table.insert(countries, 3, cdata.blue)	
	table.insert(countries, 4, cdata.neutrals)	
	
    U.fill_combo(countryFilter, countries)
	
	if lastCountryFilter then
		for k,v in base.pairs(countries) do
			if lastCountryFilter == v then
				countryFilter:setText(v)
				return
			end
		end	
	end
end 
