dofile('./Scripts/UI/initGUI.lua')
dofile('./Config/World/World.lua') -- for default date

local base = _G

module('autobriefingutils')

local type        = base.type
local require = base.require
local print = base.print
local assert = base.assert
local tostring = base.tostring
local pairs = base.pairs
local ipairs = base.ipairs
local tonumber = base.tonumber
local table = base.table
local math = base.math
local string = base.string

local Tools 					= require('tools')
local Static 					= require('Static')
local i18n 						= require('i18n')
local Grid                      = require('Grid')
local GridHeaderCell            = require('GridHeaderCell')
local Skin                      = require('Skin')
local EditBox			        = require('EditBox')
local dllWeather                = require('Weather')

i18n.setup(_M)

staticSectionItemSkin       = Skin.staticSkinSectionItem()
staticSectionDataItemSkin   = Skin.staticSkinSectionDataItem()
editBoxSectionDataItemSkin  = Skin.editBoxSkinSectionDataItem()
staticTitleItemSkin         = Skin.staticSkinTitleItem()
staticGridCellSkin          = Skin.staticSkinGridCellBriefing()
staticGridCellMiddleSkin	= Skin.staticSkinGridCellBriefing()
gridSkin                    = Skin.gridSkin_briefing()
gridHeaderSkin              = Skin.grid_header_cell_Briefing()
gridHeaderMiddleSkin	= Skin.grid_header_cell_Briefing()


function setStaticSectionItemSkin(a_skin)
    staticSectionItemSkin = a_skin
end

function setStaticSectionDataItemSkin(a_skin)
    staticSectionDataItemSkin = a_skin
end

function setEditBoxSectionDataItemSkin(a_skin)
    editBoxSectionDataItemSkin = a_skin
end

function setStaticTitleItemSkin(a_skin)
    staticTitleItemSkin = a_skin
end

function setStaticGridCellSkin(a_skin)
    staticGridCellSkin = a_skin
end

function setStaticGridCellMiddleSkin(a_skin)
    staticGridCellMiddleSkin = a_skin
end

function setGridSkin(a_skin)
    gridSkin = a_skin
end

function setGridHeaderSkin(a_skin)
    gridHeaderSkin = a_skin
end

function setGridHeaderMiddleSkin(a_skin)
    gridHeaderMiddleSkin = a_skin
end

local cdata =
{
    NA = _('N/A'),
	mmHg = _('mmHg'),
	pa = _('hPa'),
	inHg = _('inHg'),
}

function setData(a_autoBriefing)
    autoBriefing = a_autoBriefing
end 

function isLeapYear(year)
    local result = 0
    --Год является високосным, если он кратен 4 и при этом не кратен 100,
    --либо кратен 400. Год не является високосным, если он не кратен 4, 
    --либо кратен 100 и не кратен 400.
    if (((year%4) == 0) and (((year%100) ~= 0) or ((year%400) == 0))) then
        result = 1
    end
    
    return result;
end

local function createSectionItem_(scrollPane, itemText, x, y, w, h)
    local item = Static.new(itemText)

    item:setSkin(staticSectionItemSkin)    
    item:setBounds(x, y, w, h)
    scrollPane:insertWidget(item)
end

local function createSectionDataItem_(scrollPane, itemText, x, y, wrapWidth)
    local item = EditBox.new(itemText)
    local wrapHeight = 5
    item:setBounds(0, 0, wrapWidth, wrapHeight)
    item:setTextWrapping(true)  
	item:setMultiline(true)
    item:setReadOnly(true)
    
    item:setSkin(editBoxSectionDataItemSkin)

    local w, h = item:calcSize()
    local result
    
    if h <= 1 then 
        w = 100
        h = 20
        result = h
    else
      local sectionDataGap = 6
      
      result = h + sectionDataGap
    end
                  
    item:setBounds(x, y, w, h)

    scrollPane:insertWidget(item)
    
    return result
end

local function createTitleItem_(scrollPane, itemText, x, y, h)
    local item = Static.new(itemText)
    
    item:setSkin(staticTitleItemSkin)
    item:setBounds(x-5, y, 150, h)
    
    local w = item:calcSize()
   
    item:setBounds(x-5, y, w, h)
    scrollPane:insertWidget(item)
end

local function createDataItem_(scrollPane, itemText, x, y, h, w)
    local item = EditBox.new(itemText)
    item:setBounds(0, 0, w, h)
    item:setTextWrapping(true)  
	item:setMultiline(true)
    item:setReadOnly(true)
    
    item:setSkin(editBoxSectionDataItemSkin)
    
    local _tmp, h1 = item:calcSize()
    
    h1 = math.max(h, h1)
    
    item:setBounds(x, y, w, h1)
    scrollPane:insertWidget(item)
    
    return h1
end

local function createSectionGrid_(a_scrollPane, a_data, a_x, a_y, a_w) 
    grid = Grid.new()
    grid:setSkin(gridSkin)    
    
    local w1 = base.math.floor(106*a_w/390)
    local w2 = base.math.floor(116*a_w/390)
    local w3 = base.math.floor(85*a_w/390)
    local w4 = base.math.floor(80*a_w/390)

    grid:insertColumn(w1)
    local headerCell = GridHeaderCell.new(_('Group name'))
    headerCell:setSkin(gridHeaderMiddleSkin)
    headerCell:setBounds(1, 0, w1, 20)
    grid:setColumnHeader(0, headerCell)
    
    grid:insertColumn(w2)
    headerCell = GridHeaderCell.new(_('AB/FARP'))
    headerCell:setSkin(gridHeaderMiddleSkin)
    headerCell:setBounds(1, 0, w2, 20)
    grid:setColumnHeader(1, headerCell)
    
    grid:insertColumn(w3)
    headerCell = GridHeaderCell.new(_('Frequency'))
    headerCell:setSkin(gridHeaderMiddleSkin)
    headerCell:setBounds(1, 0, w3, 20)
    grid:setColumnHeader(2, headerCell)
    
    grid:insertColumn(w4)
    headerCell = GridHeaderCell.new(_('QFE_brief','QFE'))
    headerCell:setSkin(gridHeaderMiddleSkin)
    headerCell:setBounds(1, 0, w4, 20)
    grid:setColumnHeader(3, headerCell)
    

    local hGrid = 23    
    local rowIndex = 0
    local rowHeight = 20
        
    for k, v in pairs(a_data) do 
        
        local _tmp, h1, h2, h3
        
        local cellGroupName
        cellGroupName = Static.new()
        cellGroupName:setSkin(staticGridCellSkin)  
        cellGroupName:setText(v.name)   
        cellGroupName:setBounds(0, 0, w1, 20)
        _tmp, h1 = cellGroupName:calcSize()         
                
        local cellAirdrom
        cellAirdrom = Static.new()
        cellAirdrom:setSkin(staticGridCellSkin)
        cellAirdrom:setText(v.airdromeName)
        cellAirdrom:setBounds(0, 0, w2, 20)
        _tmp, h2 = cellAirdrom:calcSize()   
                
        local cellFreq
        cellFreq = Static.new()
        cellFreq:setSkin(staticGridCellMiddleSkin)
        cellFreq:setWrapping(true)
        cellFreq:setText(v.frequency) 
        cellFreq:setBounds(0, 0, w3, 20)
        _tmp, h3 = cellFreq:calcSize()  

        local cellQFE
        cellQFE = Static.new()
        cellQFE:setSkin(staticGridCellSkin)
		cellQFE:setWrapping(true)
        local   temp,pressure =  dllWeather.getTemperatureAndPressureAtPoint({position = v.position})
		local pressureHPA = pressure/100
        local pressureMM = pressure * 0.007500637554192
        local pressureIN = pressure * 0.000295300586467  
		
        cellQFE:setText(string.format('%.2f %-5s\n%.2f %-5s\n%.2f %-5s' ,pressureHPA,cdata.pa,pressureMM,cdata.mmHg,pressureIN,cdata.inHg))
        cellQFE:setBounds(0, 0, w4, 20)
        _tmp, h4 = cellQFE:calcSize()         
 
        rowHeight = base.math.max(base.math.max(h1,h4), base.math.max(h2,h3))
        
        grid:insertRow(rowHeight) 
        grid:setCell(0, rowIndex, cellGroupName)
        grid:setCell(1, rowIndex, cellAirdrom)
        grid:setCell(2, rowIndex, cellFreq)
        grid:setCell(3, rowIndex, cellQFE)

        rowIndex = rowIndex + 1
        hGrid = hGrid + rowHeight+1
    end
        
    grid:setBounds(a_x, a_y, a_w-3, hGrid)
    a_scrollPane:insertWidget(grid)
    
    return hGrid
end

-------------------------------------------------------------------------------
-- обновление текста автобрифинга 
function updateScrollPane(scrollPane, a_width)
    local rowPos = 0
    local rowHeight = 20
    local tabPos = 13
    local columnPos = 170
    local sectionX = 13
    local sectionWidth = a_width
    local sectionHeight = rowHeight + 13
    local sectionOffset = 28
    
    scrollPane:clear()
    
    for i = 1, #autoBriefing do
        local rec = autoBriefing[i]     
        
        if rec.section then -- запись - название секции. должна быть синей 
            if i > 1 then
                rowPos = rowPos + sectionOffset  
            end
            createSectionItem_(scrollPane, rec.section, sectionX, rowPos, sectionWidth, sectionHeight)
            rowPos = rowPos + sectionHeight
            
            if rec.data then -- если в секции есть данные
                local itemHeight = createSectionDataItem_(scrollPane, rec.data, tabPos, rowPos, sectionWidth)
                
                rowPos = rowPos + itemHeight
            end
        elseif (not rec.section) and rec.title then -- запись не секция и есть название 
            createTitleItem_(scrollPane, rec.title, tabPos, rowPos, rowHeight)
            
            if rec.data then
                local data = {}
                
                if base.type(rec.data) == 'table' then
                    data = rec.data
                else 
                    data[1] = rec.data
                end
                
                for i =1, #data do
                    local itemHeight = createDataItem_(scrollPane, data[i], columnPos, rowPos, rowHeight, sectionWidth-130)
                    
                    rowPos = rowPos + itemHeight
                end
                if #data < 1 then
                    rowPos = rowPos + rowHeight
                end
            else
                rowPos = rowPos + rowHeight
            end 
        elseif rec.needGrid == true then
            local itemHeight = createSectionGrid_(scrollPane, rec.data, tabPos, rowPos, sectionWidth) 
            rowPos = rowPos + itemHeight    
        end
        
    end
    
    local item = Static.new("")
    item:setPosition(0, rowPos+15)
    scrollPane:insertWidget(item) 

    scrollPane:updateWidgetsBounds()    
end

-- текст брифинга в планшете брифинг рума

------------------------------------------

------------------------------------------
function updateScrollPaneBriefingRoom(scrollPane, a_width)	-- BriefingRoom  briefing(on tablet pc)
	local rowPos = 0
    local rowHeight = 45
    local tabPos = 13
    local columnPos = 500
    local sectionX = 50						-- title offset
    local sectionWidth = a_width
    local sectionHeight = rowHeight + 50
    local sectionOffset = 20				-- vertical between sections

    scrollPane:clear()
    
    for i = 1, #autoBriefing do
        local rec = autoBriefing[i]     
        
        if rec.section then -- запись - название секции. должна быть синей 
            if i > 1 then
                rowPos = rowPos + sectionOffset  
            end
            createSectionItem_(scrollPane, rec.section, sectionX, rowPos, sectionWidth, sectionHeight)
            rowPos = rowPos + sectionHeight
            
            if rec.data then -- если в секции есть данные
                local itemHeight = createSectionDataItem_(scrollPane, rec.data, tabPos, rowPos, sectionWidth)
                
                rowPos = rowPos + itemHeight
            end
        elseif (not rec.section) and rec.title then -- запись не секция и есть название 
            createTitleItem_(scrollPane, rec.title, tabPos, rowPos, rowHeight)
            
            if rec.data then
                local data = {}
                
                if base.type(rec.data) == 'table' then
                    data = rec.data
                else 
                    data[1] = rec.data
                end
                
                for i =1, #data do
					  local itemHeight = createDataItem_(scrollPane, data[i], columnPos, rowPos, rowHeight, sectionWidth - 300)
                    rowPos = rowPos + itemHeight
                end
                if #data < 1 then
                    rowPos = rowPos + rowHeight
                end
            else
                rowPos = rowPos + rowHeight
            end 
        elseif rec.needGrid == true then
            local itemHeight = createSectionGrid_(scrollPane, rec.data, tabPos, rowPos, sectionWidth) 
            rowPos = rowPos + itemHeight    
        end
        
    end
    
    scrollPane:updateWidgetsBounds()    
end

function updateBaseBriefingScrollPane(scrollPane, a_width)	-- BriefingRoom simple briefing(on TV)
    local rowPos = 0
    local rowHeight = 40
    local tabPos = 13
    local columnPos = 500
    local sectionX = 25
    local sectionWidth = a_width
    local sectionHeight = rowHeight + 13
    local sectionOffset = 50
    
    scrollPane:clear()
    
    for i = 1, #autoBriefing do
        local rec = autoBriefing[i]     
        
        if rec.section then -- запись - название секции. должна быть синей 
            if i > 1 then
                rowPos = rowPos + sectionOffset  
            end
            createSectionItem_(scrollPane, rec.section, sectionX, rowPos, sectionWidth, sectionHeight)
            rowPos = rowPos + sectionHeight
            
            if rec.data then -- если в секции есть данные
                local itemHeight = createSectionDataItem_(scrollPane, rec.data, tabPos, rowPos, sectionWidth)
                
                rowPos = rowPos + itemHeight
            end
        elseif (not rec.section) and rec.title then -- запись не секция и есть название 
            createTitleItem_(scrollPane, rec.title, tabPos, rowPos, rowHeight)
            
            if rec.data then
                local data = {}
                
                if base.type(rec.data) == 'table' then
                    data = rec.data
                else 
                    data[1] = rec.data
                end
                
                for i =1, #data do
                    local itemHeight = createDataItem_(scrollPane, data[i], columnPos, rowPos, rowHeight, sectionWidth-130)
                    
                    rowPos = rowPos + itemHeight
                end
                if #data < 1 then
                    rowPos = rowPos + rowHeight
                end
            else
                rowPos = rowPos + rowHeight
            end 
        elseif rec.needGrid == true then
            local itemHeight = createSectionGrid_(scrollPane, rec.data, tabPos, rowPos, sectionWidth) 
            rowPos = rowPos + itemHeight    
        end
        
    end
    
    local item = Static.new("")
    item:setPosition(0, rowPos+15)
    scrollPane:insertWidget(item) 

    scrollPane:updateWidgetsBounds()    
end

-------------------------------------------------------------------------------
-- формирование строки из списка
-- на входе таблица с ключами, соответствующими названиям элементов списка, и значениями,
-- соответствующими количеству элементов
-- входной список записывается в строку
-- через знак multiplier указывается кол-во элементв
function composeString(list, multiplier)
    multiplier = multiplier or ' '
    local str = {}
    if base.next(list) then
        for k,v in pairs(list) do
            table.insert(str, "'" ..tostring(k) .."'" .. multiplier .. tostring(v))
        end
        return str
    else
        return cdata.NA
    end
end

-------------------------------------------------------------------------------
-- формирование строки даты\времени в формате hh:mm:ss
-- если задан параметр include_date, то формат изменяется на ddd/hh:mm:ss
function composeDateString(start_time, include_date, MissionDate)
	local data = convertDaysToData(math.floor(start_time/(60*60*24)), MissionDate)
    -- вывод даты и времени
    local d = math.floor(start_time / (60*60*24))
    start_time = start_time - d * 60*60*24
    local h = math.floor(start_time / (60*60))
    start_time = start_time - h * 60*60
    local m = math.floor(start_time / 60)
    local s = math.floor(start_time - m * 60)
    local res = ''
    if include_date then
        res = data..'  '--string.format('%03d', d) .. '/'
    end
    return res .. num2s2(h) .. ':' .. num2s2(m) .. ':' .. num2s2(s)
end

-------------------------------------------------------------------------------
-- convert number to string using %02d format string
function num2s2(num)
    return string.format('%02d', num)
end

function convertDaysToData(a_days, MissionDate)

	local NumDayInMounts =
	{
		31, --Январь
		28, --Февраль
		31,	--Март
		30,	--Апрель
		31,	--Май
		30,	--Июнь
		31,	--Июль
		31,	--Август
		30,	--Сентябрь
		31,	--Октябрь
		30,	--Ноябрь
		31	--Декабрь
	}
    
    if MissionDate == nil then
        MissionDate = { Year = base.MissionDate.Year, Month = base.MissionDate.Month, Day = base.MissionDate.Day }
    end
	
	-- начальную дату берем из миссии
	local day	= MissionDate.Day 
	local month	= MissionDate.Month  
	local year 	= MissionDate.Year
	
	local tmpData = 0
	
	while true do
		local tmp = tmpData + NumDayInMounts[month] 
		if (month == 2) then
			tmp = tmp + isLeapYear(year)
		end
		
		if (a_days >= tmp) then
			tmpData = tmp
		else
			day = day + a_days - tmpData
			break
		end

		if (month == 12) then		
			month = 1
			year = year + 1
			day = 1
		else
			month = month + 1
			day = 1
		end 
	end
	
	local result = tostring(day)..'/'..tostring(month)..'/'..tostring(year)
	return result
end
