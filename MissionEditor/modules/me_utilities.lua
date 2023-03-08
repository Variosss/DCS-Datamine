-- Данный файл представлен в кодировке UTF-8, чтобы правильно отображались символы градусов
local base = _G

module('me_utilities')

local require = base.require
local loadstring = base.loadstring
local loadfile = base.loadfile
local pairs = base.pairs
local ipairs = base.ipairs
local next = base.next
local table = base.table
local tonumber = base.tonumber
local tostring = base.tostring
local math = base.math
local string = base.string
local print = base.print
local type = base.type
local io = base.io
local os = base.os
local assert = base.assert
local debug = base.debug

local DialogLoader      = require('DialogLoader')
local ListBoxItem       = require('ListBoxItem')
local CheckListBox      = require('CheckListBox')
local CheckListBoxItem  = require('CheckListBoxItem')
local SpinBox           = require('SpinBox')
local Static            = require('Static')
local i18n              = require('i18n')
local S                 = require('Serializer')
local TextUtil          = require('textutil')
local Skin              = require('Skin')
local Terrain           = require('terrain')
local MsgWindow         = require('MsgWindow')
local TableUtils        = require('TableUtils')
local UC				= require('utils_common')
local log      			= require('log')

i18n.setup(_M)

copyTable	= TableUtils.copyTable
mergeTables	= TableUtils.mergeTables

-- В данном модуле содержатся утилиты создания стандартных виджетов Редактора миссий

-- Стандартные размеры и отступы
dist_w = 6          -- расстояние между виджетами по горизонтали
dist_h = 4          -- расстояние между виджетами по вертикали
widget_h = 20       -- высота виджета
time_w = 30         -- ширина окон часов, минут, секунд, дней
grad_w = 30         -- ширина окон градусов, минут, секунд, полушария
grad_short_w = 20     -- то же самое для readonly
percent_w = 40        -- ширина окна процентов  
text_w = 70         -- ширина основной подписи слева от виджета
text_long_w = 100     -- ширина более длинной подписи
text_very_long_w = 150 
text_short_w = 50     -- ширина короткой подписи
button_w = 75       -- ширина кнопки
button_h = 25       -- высота кнопки
slider_w = 160        -- ширина слайдера
combo_w = 180       -- ширина комбобокса
spin_w = 80         -- ширина спинедита
spin_long_w = 100     
edit_w = 50         -- ширина edit-бокса
edit_short_w = 30     -- ширина короткого edit-бокса
coords_w = 160        -- ширина блока широты/долготы
offset_w = 8        -- смещение рамки группы по горизонтали
offset_h = 6        -- смещение рамки группы по вертикали
panel_w = 390       -- ширина стандартной панели
panel_wide_w = 390      -- ширина широкой панели
top_toolbar_h = 40      -- высота верхнего тулбара ME    
top_toolbar2_h = 27      -- высота верхнего тулбара ME с кнопками        
left_toolbar_w = 50     -- ширина левого тулбара ME           
bottom_toolbar_h = 29   -- высота нижнего тулбара ME      
right_toolbar_h = 465   -- высота верхней части панели планирования группы
right_toolbar_width = panel_w -- ширина панели планирования группы
actions_toolbar_w = panel_w --ширина панели действий для точки пути группы

months =
{
    [1]  = { name = _("January"),   days = 31 },
    [2]  = { name = _("February"),  days = 28 },
    [3]  = { name = _("March"),     days = 31 },
    [4]  = { name = _("April"),     days = 30 },
    [5]  = { name = _("May"),       days = 31 },
    [6]  = { name = _("June"),      days = 30 },
    [7]  = { name = _("July"),      days = 31 },
    [8]  = { name = _("August"),    days = 31 },
    [9]  = { name = _("September"), days = 30 },
    [10] = { name = _("October"),   days = 31 },
    [11] = { name = _("November"),  days = 30 },
    [12] = { name = _("December"),  days = 31 },
}

local russia 		= _('Russia')
local ukraine		= _('Ukraine')
local belarus 		= _('Belarus')
local insurgents 	= _('Insurgents')
local abkhazia 		= _('Abkhazia')
local south_osetia  = _('South Ossetia')
local china 		= _('China')
local USSR  		= _('USSR')
local china 		= _('China')
local yugoslavia  	= _('Yugoslavia')
local GDR			= _("GDR")	

function makeComboboxItem(name, value)
	return { name = _(name), value = value or name }
end

function makeComboboxItems(names)
	local result = {}
	for i, v in pairs(names) do
		table.insert(result, makeComboboxItem(v))
	end
	return result
end

function fillComboMonths(combo)
    combo:clear()  
    if not months then
        combo:setText("")
        return
    end 
    for i, v in ipairs(months) do
      local item = ListBoxItem.new(v.name)
      
      item.index = i
      combo:insertItem(item)
    end
    if next(months) then
        combo:setText(months[next(months)].name)
    else
        combo:setText('')
    end
end

-- fill combo box by values from table t
-- set combo text to value of first item
function fill_combo(combo, t)
    combo:clear()  
    if not t then
        combo:setText("")
        return
    end 
    for i, v in ipairs(t) do
      local item = ListBoxItem.new(v)
      
      item.index = i
      combo:insertItem(item)
    end
    if next(t) then
        combo:setText(t[next(t)])
    else
        combo:setText('')
    end
end

function fill_listIDs(list, t)
    list:clear()  
    if not t then
        return list
    end
    for i, v in ipairs(t) do
        local item = ListBoxItem.new(v.name, true)
        item.index = i
        if v.id then
            item.itemId = v.id
        end
        list:insertItem(item)
    end
    list:selectItem(list:getItem(0))
    return list
end

function fill_combo_list(comboList, t)
    comboList:clear()  
	
    for i, v in ipairs(t) do
      local item = ListBoxItem.new(v)
      item.index = i
      comboList:insertItem(item)
    end
    
    comboList:selectItem(comboList:getItem(0))
end

function fill_comboListIDs(combo, t)
  combo:clear()
  
  if t then
      for i, v in ipairs(t) do
          local item = ListBoxItem.new(v.name)

          item.index = i
      
          if v.id then
              item.itemId = v.id
          end
          
          combo:insertItem(item)
      end
      
      combo:selectItem(combo:getItem(0))
  end
end

function fill_list(list, t)
  list:clear()
  local tt = {}
  for i,v in pairs(t) do
    table.insert(tt, v)
  end
  table.sort(tt)
  for i,v in ipairs(tt) do 
    local item = ListBoxItem.new(v)

    item.num = i
    list:insertItem(item)
  end  
end


function update_list(list, t)
  list:clear()
  fill_list(list, t)
end

function fill_list_slots(list, t, skinItem)
  list:clear()
  local tt = {}
  for i,v in pairs(t) do
    table.insert(tt,  base.string.format("%-15s%s",v.unit_type,v.player or ""))
  end
  table.sort(tt)
  for i,v in ipairs(tt) do 
    local item = ListBoxItem.new(v)
    if skinItem then
        item:setSkin(skinItem)
    end    
    list:insertItem(item)
  end  
end

function create_spin(min, max, step, val)
    local s = SpinBox.new()
    s:setRange(min, max)
    s:setStep(step)
    s:setValue(val)
    return s
end

function create_time_panel()
    local dialog = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_time_panel.dlg", cdata)
    local timePanel = dialog.panelTime
    
    dialog:removeWidget(timePanel)
    dialog:kill()
    
    local hh = timePanel.hh
    local mm = timePanel.mm
    local ss = timePanel.ss
    local dd = timePanel.dd

	function timePanel:setTime(t)		
		setTime(hh, mm, ss, dd, t)		
	end
    
	function timePanel:getTime()
		return getTime(hh, mm, ss, dd)
	end
    
	function hh:onChange()
		if (self:getText() == '') then self:setText('0')  end
		if (tonumber(self:getText()) > 24)  then self:setText('24') end
		timePanel:onChange()
	end
	
    function mm:onChange()
		if (self:getText() == '') then self:setText('0') end
		if (tonumber(self:getText()) > 60)  then self:setText('60') end
		timePanel:onChange()
	end
	
    function ss:onChange()
		if (self:getText() == '') then self:setText('0') end
		if (tonumber(self:getText()) > 60)  then self:setText('60') end
		timePanel:onChange()
	end
	
    function dd:onChange() 
		if (self:getText() == '') then self:setText('0') end
		if (tonumber(self:getText()) >  999)  then self:setText('999') end
		timePanel:onChange()
	end
    
    function timePanel:onChange()
    end
    
	return timePanel
end

function toRadians(angles)
  return angles * math.pi / 180
end

function degreesToLongitude(a_degree)
    local d
  
	if a_degree < 0 then
		d = 'W'
		a_degree = -a_degree
	else
		d = 'E'
	end
  
	local g = math.floor(a_degree)
	local m = math.floor(a_degree * 60 - g * 60)
	local s = (math.floor((a_degree * 3600 - g * 3600 - m * 60)*1000))/1000
  
  return g, m, s, d
end

function degreesToLatitude(a_degree)
    local d
  
	if a_degree < 0 then
		d = 'S'
		a_degree = -a_degree
	else
    d = 'N'
	end
  
	local g = math.floor(a_degree)
	local m = math.floor(a_degree * 60 - g * 60)
	local s = (math.floor((a_degree * 3600 - g * 3600 - m * 60)*1000))/1000
  
    return g, m, s, d
end

function radian2longitude(radians)
  local d
  
	if radians < 0 then
		d = 'W'
		radians = -radians
	else
		d = 'E'
	end
  
	local c = UC.toDegrees(radians, true)
	local g = math.floor(c)
	local m = math.floor(c * 60 - g * 60)
	local s = c * 3600 - g * 3600 - m * 60
  
  return d, g, m, s
end

function radian2latitude(radians)
  local d
  
	if radians < 0 then
		d = 'S'
		radians = -radians
	else
    d = 'N'
	end
  
	local c = UC.toDegrees(radians, true)
	local g = math.floor(c)
	local m = math.floor(c * 60 - g * 60)
	local s = c * 3600 - g * 3600 - m * 60
  
  return d, g, m, s
end

local latLongFormatString = '%s %2d°%2d\'%2d"'

------------
function text_coords_LatLong(type, v)
    local g, m, s, d
	
    if type == 'long' then
        d, g, m, s = radian2longitude(v)
    else
        d, g, m, s = radian2latitude(v)
    end
    s = math.floor(s)
    
    return(string.format(latLongFormatString, d, g, m, s))
end

function update_coords_LatLong(type, v, widget)
    widget:setText(text_coords_LatLong(type, v))
end

--------
function text_coords_LatLongD(type, v)
    local g, m, s, d
	
    if type == 'long' then
        d, g, m, s = radian2longitude(v)
    else
        d, g, m, s = radian2latitude(v)
    end

    s = math.floor(s/60*1000)
    return(string.format('%s %2d°%2d.%3.3d\'', d, g, m, s))
end

function update_coords_LatLongD(type, v, widget)
    widget:setText(text_coords_LatLongD(type, v))
end

---------
function text_coords_LatLongHornet(type, v)
    local g, m, s, d
	
    if type == 'long' then
        d, g, m, s = radian2longitude(v)
    else
        d, g, m, s = radian2latitude(v)
    end
    s = math.floor(s*100)/100
    
    return (string.format('%s %2d°%.2d\'%2.2f"', d, g, m, s))
end

function update_coords_LatLongHornet(type, v, widget)
    widget:setText(text_coords_LatLongHornet(type, v))
end

function text_coords_Metric(x, y)
--------
	local ix = math.floor(x + 0.5)
	local iz = math.floor(y + 0.5)
	return(string.format("X%+09d Z%+09d",ix,iz))
end


function getLongitudeString(radians)
    return string.format(latLongFormatString, radian2longitude(radians))
end

function getLatitudeString(radians)
    return string.format(latLongFormatString, radian2latitude(radians))
end

-- Вспомогательная функция поиска индекса заданного элемента в таблице
function find(tbl, val)
  for i,v in pairs(tbl) do
    if v == val then
      return i
    end 
  end
  return nil
end

function isEnableTask(a_tbl, a_idTask) --a_tbl = group.route.points
	for k,v in base.pairs(a_tbl) do
		if base.type(v) == 'table' 
			and (k == 'task' or k == 'params' or k == 'tasks' or  base.type(k) == "number") then
			if isEnableTask(v, a_idTask) == true then
				return true
			end
		elseif k == 'id' and v == a_idTask then
			return true
		end		
	end

	return false
end

function getTasks(a_tbl, a_idTask) --a_tbl = group.route.points
	local result 
	for k,v in base.pairs(a_tbl) do
		if base.type(v) == 'table' 
			and (k == 'task' or k == 'params' or k == 'tasks' or  base.type(k) == "number") then
			if isEnableTask(v, a_idTask) ~= nil then
				return result
			end
		elseif k == 'id' and v == a_idTask then
			base.table.insert(result,v)
		end		
	end

	return result

end

--функция считающая кол-во элементов в таблице
function getTableSize(tbl)
	local size=0
	
	if base.type(tbl) == 'table' then
		for k,v in base.pairs(tbl) do
			size = size + 1
		end
	end
	
	return size
end

function getShape(a_unitDef)
	local shape = a_unitDef.ShapeName or a_unitDef.Shape
	
	if a_unitDef.visual and a_unitDef.visual.shape and a_unitDef.visual.shape ~= "" then
        shape = a_unitDef.visual.shape
	end	
	
	if a_unitDef.shape_table_data then
		if a_unitDef.shape_table_data[1] then
			if a_unitDef.shape_table_data[1].file then
				shape = a_unitDef.shape_table_data[1].file
			end
		end
	end   
	
	return shape
end


--функция проверяющая содержится ли переменная в древовидной таблице
function chekForContent(tbl, content, searchStory)
	if base.type(searchStory) ~= 'table' then searchStory={} end
	if tbl==content then return true end
	if searchStory[tbl] or base.type(tbl) ~= 'table'  then return false end
	searchStory[tbl]=1
	
	for k,v in base.pairs(tbl) do
		if chekForContent(v, content, searchStory) then return true end
	end
	
	return false
end


-- Находит в list ключ первого элемента, отсутствующего в tbl 
function find_diff(list, tbl)
  local bFind = false
  for i,v in pairs(list) do
    bFind = false
    for j,u in pairs(tbl) do
      if u == v then
        bFind = true
        break
      end
    end
    if not bFind then
      return i
    end
  end
  return nil
end


-- add item to combo box or list box
-- each item may have optional theme and itemId
-- itemId will be assign to itemId field of item widget
-- returns created item.
function addBoxItem(box, item, itemId)
    if itemId then
        item.itemId = itemId
    end
    
    box:insertItem(item)
end

-- Creates new listbox item and adds it to list box
-- each item may have optional theme and itemId
-- itemId will be assign to itemId field of item widget
-- returns created item.
function addListBoxItem(listBox, caption, itemId)
    local item = ListBoxItem.new(caption)
    addBoxItem(listBox, item, itemId)
    return item
end

-- Creates new combobox item and adds it to combo box
-- each item may have optional theme and itemId
-- itemId will be assign to itemId field of item widget
-- returns created item.
function addComboBoxItem(comboBox, caption, itemId)
    local item = ListBoxItem.new(caption)
    addBoxItem(comboBox, item, itemId)
    return item
end

function fillComboBoxFromTable(comboBox, datatable, captionField, idField)
    for i, v in ipairs(datatable) do
        addComboBoxItem(comboBox, v[captionField], v[idField])
    end
end

function setComboboxValueById(combobox, id)
	local itemCount = combobox:getItemCount()
	local itemCounter = itemCount - 1
	
    
    for i = 0, itemCounter do
		local item = combobox:getItem(i)
		
        if item.itemId == id then
			combobox:selectItem(item)
			
            return item
        end
    end
	
	if itemCount > 0 then
		combobox:selectItem(combobox:getItem(0))
	else
		combobox:selectItem()
	end
	
	return nil
end

function setComboboxValueByField(combobox, id, field)
	local itemCount = combobox:getItemCount()
	local itemCounter = itemCount - 1
	
    
    for i = 0, itemCounter do
		local item = combobox:getItem(i)
		
        if item[field] == id then
			combobox:selectItem(item)
			
            return item
        end
    end
	
	if itemCount > 0 then
		combobox:selectItem(combobox:getItem(0))
	else
		combobox:selectItem()
	end
	
	return nil
end

function timeToMDHMS(value, MissionDate)
	if not value then
		return 0,0,0,0
	end

	local dd = math.floor(value / 86400)
	value = value - dd * 60*60*24
	local hh = math.floor(value / 3600)
	value = value - hh * 60*60
	local mm = math.floor(value / 60)
	local ss = math.floor(value - mm * 60)
    
    local day	= MissionDate.Day --1
	local month	= MissionDate.Month  --6
	local year 	= MissionDate.Year--2010
    
    local tmpMonth = month
    local tmpDay = day
    local daysToEndMonth = 0
    
    repeat
        if tmpMonth > 12 then
            tmpMonth = 1
            year = year + 1
        end
        
        dd = dd - daysToEndMonth
        daysToEndMonth = months[tmpMonth].days - tmpDay + 1
        
        if (tmpMonth == 2) then
            daysToEndMonth = daysToEndMonth + isLeapYear(year)
        end
        
        tmpDay = 1
        tmpMonth = tmpMonth + 1   
    until (daysToEndMonth > dd)    
    
    local mon = tmpMonth - 1
    dd = dd + 1 --следующий за полными
    
	return mon, dd, hh, mm, ss
end

function secToString(a_value)
	if a_value == nil then
		return "--:--:--"
	end
	
	local dd = math.floor(a_value / 86400)
	a_value = a_value - dd * 60*60*24
	local hh = math.floor(a_value / 3600)
	a_value = a_value - hh * 60*60
	local mm = math.floor(a_value / 60)
	local ss = math.floor(a_value - mm * 60)
	
	return base.string.format("%i:%02i:%02i",hh,mm,ss)
end

function timeToDHMS(value)
	if not value then
		return 0,0,0,0
	end
	
	local dd = math.floor(value / 86400)
	value = value - dd * 60*60*24
	local hh = math.floor(value / 3600)
	value = value - hh * 60*60
	local mm = math.floor(value / 60)
	local ss = math.floor(value - mm * 60)
	return dd, hh, mm, ss
end

function DHMStoTime(dd, hh, mm, ss)
	return (dd or 0) * 86400 + (hh or 0) * 3600 + (mm or 0) * 60 + (ss or 0)
end

function MDHMStoTime(a_month, dd, hh, mm, ss, MissionDate)
    local day	= MissionDate.Day --1
	local month	= MissionDate.Month  --6
	local year 	= MissionDate.Year--2010
    
    local selectMonth = a_month
    local tmpMonth = month
    local daysToEndMonth = months[month].days - day
    
    if ((tmpMonth == selectMonth) and (day <= dd)) then
        dd = dd - day
    else 
        repeat
            dd = dd + daysToEndMonth
            tmpMonth = tmpMonth + 1 
            if tmpMonth > 12 then
                tmpMonth = 1
                year = year + 1
            end
            daysToEndMonth = getDaysInMonth(tmpMonth, year)
        until (tmpMonth == selectMonth)
    end
    
	return (dd or 0) * 86400 + (hh or 0) * 3600 + (mm or 0) * 60 + (ss or 0)
end

function getDaysInMonth(a_month, a_year)
    local result
    result = months[a_month].days
    if (a_month == 2) then
        result = result + isLeapYear(a_year)
    end
    return result
end


function setDataTime(year, month, hours, minutes, seconds, days, start_time, MissionDate)
    year:setText(tostring(MissionDate.Year))
    month:selectItem(month:getItem(MissionDate.Month-1))
    days:setText(tostring(MissionDate.Day))

	local h = math.floor(start_time / 3600)
	start_time = start_time - h * 60*60
	local m = math.floor(start_time / 60)
	local s = math.floor(start_time - m * 60)
    
    hours:setText(tostring(h))
    minutes:setText(tostring(m))
    seconds:setText(tostring(s))    
end

function getDataTime(cb_month, hh_edit, mm_edit, ss_edit, dd_edit, MissionDate)
	return MDHMStoTime(	cb_month:getSelectedItem().Index,
                        tonumber(dd_edit:getText()),
						tonumber(hh_edit:getText()),
						tonumber(mm_edit:getText()),
						tonumber(ss_edit:getText()),
						tonumber(ss_edit:getText()),
                        MissionDate)
end

-- set value of time in time boxes.  value is time in seconds
function setTime(hours, minutes, seconds, days, value)
	local d, h, m, s = timeToDHMS(value)
    days:setText(tostring(d))
    hours:setText(tostring(h))
    minutes:setText(tostring(m))
    seconds:setText(tostring(s))
end

function getTime(hh_edit, mm_edit, ss_edit, dd_edit)
	return DHMStoTime(	tonumber(dd_edit:getText()),
						tonumber(hh_edit:getText()),
						tonumber(mm_edit:getText()),
						tonumber(ss_edit:getText()),
						tonumber(ss_edit:getText()))
end


-- convert edit box value to number and make sure number is 
-- within specified range
local function getNumInRange(editBox, min, max)
    local v = tonumber(editBox:getText())
    if nil == v then
        v = 0
    end
    if v > max then 
        v = max
        editBox:setText(v)
    elseif v < min then 
        v = min 
        editBox:setText(v)
    end
    return v
end

-- setup callbacks to modify time value
function bindDataTimeCallback(a_year, a_month, a_hours, a_minutes, a_seconds, a_days, a_callback)

    function updateValue(typeChange)
        local h = getNumInRange(a_hours, 0, 23)
        local m = getNumInRange(a_minutes, 0, 59)
        local s = getNumInRange(a_seconds, 0, 59)
        
        local year = getNumInRange(a_year, 1900, 2100)
        local month = a_month:getItemIndex(a_month:getSelectedItem())+1
        local day = tonumber(a_days:getText())
        if nil == day then
            day = 1
        end
    
        local dayInMonth = months[month].days

        if (month == 2) then
            dayInMonth = dayInMonth + isLeapYear(year)            
        end

        local day = getNumInRange(a_days, 1, dayInMonth)
        
        local date = {Year = year , Month  = month , Day = day}

        a_callback((h or 0) * 3600 + (m or 0) * 60 + (s or 0), date, typeChange)        
    end

	function updateMonth(self)	
		updateValue("month")
	end
	
	function updateTime(self)	
		updateValue("time")
	end
	
	function updateDate(self)	
		updateValue("date")
	end
	
    a_year:addFocusCallback(updateDate)
    a_month.onChange = updateMonth
    a_hours.onChange = updateTime
    a_minutes.onChange = updateTime
    a_seconds.onChange = updateTime
    a_days.onChange = updateDate
end

-- setup callbacks to modify time value
function bindTimeCallback(hours, minutes, seconds, days, callback)

    function updateValue(this)
        local h = getNumInRange(hours, 0, 23)
        local m = getNumInRange(minutes, 0, 59)
        local s = getNumInRange(seconds, 0, 59)
        local d = getNumInRange(days, 0, 400)
        callback(s + (m * 60) + (h * 60 * 60) + (d * 60 * 60 * 24))
    end

    hours.onChange = updateValue
    minutes.onChange = updateValue
    seconds.onChange = updateValue
    days.onChange = updateValue
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

function calcSecondToStart(a_month, a_day, a_hours, a_minutes, a_seconds, a_MissionDate)
    return MDHMStoTime(a_month, a_day, a_hours, a_minutes, a_seconds, a_MissionDate);
end

-- setup callbacks to modify time value
function bindTime(hours, minutes, seconds, days, data, value)
    if not data then
        return
    end

    function updater(time)
        data[value] = time
    end

    bindTimeCallback(hours, minutes, seconds, days, updater)

    setTime(hours, minutes, seconds, days, data[value])
end

function trav(tableName)
    return traverseTable(tableName,1,'')
end 

-- отладочная функция для сериализации таблицы на экран
function traverseTable(_t, _numLevels, _tabString, filename, filter)
    local _tablesList = {}
    filter = filter or {}
    fun = print
    local out
    if ( filename and (filename ~= '') ) then
        out = io.open(filename, 'w')
        print('Opening', filename)
        fun = function (...)
            out:write(..., '\n')
        end
    end
    function _traverseTable(t, tabString, tablesList, numLevels, filter)
        if (numLevels <1) then 
            return
        end

      for k,v in pairs(t or {} ) do      
            if type(k) == "number" then
                k = '[' .. tostring(k) .. ']'
            else
                k = '["' .. tostring(k) .. '"]'
            end
        if type(v) == "table" then 
            local skip = false
            for i,ignoredField in ipairs(filter) do
                if ignoredField == k then
                    skip = true
                    break
                end
            end
            if skip == false then
                local str = string.gsub(tostring(v), 'table: ','')
                if not tablesList[v] then
                    tablesList[v] = tostring(k)
                    fun(tabString  .. tostring(k) .. "--[[" .. str .. "--]]  = {")
                    --numLevels = numLevels - 1
                    _traverseTable(v, tabString .. '    ', tablesList, numLevels - 1, filter)
                    fun(tabString .. "}")
                else 
                    fun(tabString .. k .. " = -> " .. (tostring(tablesList[v])  or '') .. "--[[" .. str .. "--]],")
                end
            end
        elseif type(v) == "function" then
          fun(tabString .. k .. " = " .. "function() {},")
        elseif type(v) == "string" then
          fun(tabString .. k .. " = '" .. v .. "'")
        else
          fun(tabString .. k .. " = " .. tostring(v) or '' .. ",")
        end
      end        
    end 

    if not _t then 
        fun('traverseTable(): nil value')
        return
    end
    
    if 'table' ~= type(_t) then 
        fun('traverseTable(): not a table', tostring(_t)  or '')
        return
    end
    fun('displaying table:', (tostring(_t) or ''), tostring(_numLevels) or '')
    
    if _numLevels == nil then 
        _numLevels  = math.huge
    end
    
    if (_numLevels <1) then 
        return
    end
    
    if _tabString == nil then
        _tabString = ""
    end
    
    if not _tablesList then 
        _tablesList = {}
    end 
    --fun('_numLevels',_numLevels)
    for k,v in ipairs(filter) do
        print(k,v)
    end
    _traverseTable(_t, _tabString, _tablesList, _numLevels, filter)
    if (out ~= nil) then
        out:close()
    end
   print('traverseTable done') 
end


function getExtension(fileName)
    local ext = nil
	local ext2 = nil
	local dotIdx = string.find(string.reverse(fileName), '%.')
	local dotIdx2
	
	if dotIdx then
		ext = string.sub(fileName, -dotIdx+1, -1)       
	end
	
	if ext == "lua" then
		dotIdx2 = string.find(string.reverse(fileName), '%.',dotIdx+1)
		if dotIdx2 then
			ext2 = string.sub(fileName, -dotIdx2+1, -1)       
		end
		if ext2 == "diff.lua" then
			return ext2
		end
	end

    return ext
end

function extractFileName(filePath)
    if not filePath then
        return nil
    end
    
    local lFilePath =  filePath   
    local revPath = string.reverse(lFilePath)
    local lastSlash = string.find(revPath, '[/\\]')
	if lastSlash then 
		lFilePath = string.sub(lFilePath, string.len(lFilePath) - lastSlash + 2)
    end
	return lFilePath
end

function extractDirName(filePath)
	local fileName = extractFileName(filePath)
	if fileName == nil then
		return filePath
	end
    
	local dirName = string.sub(filePath, 1, string.len(filePath) - string.len(fileName))
    
	return dirName
end

function extractDirNameLevelUp(a_path, a_level)
    local ind
    local path2 = string.gsub(a_path, '\\', '/') 
   -- base.print("-------",a_path, a_level)
    for i=0, a_level do
        --base.print("-------",path2)
        local ind = string.find(string.reverse(path2), '/');
        if ind ~= nil then
            path2 = string.sub(path2, 0, string.len(path2)-ind);        
            --base.print("---------path2=",path2)
        else
            return nil    
        end
    end
    
    return path2
end

function extractFirstDir(filePath)
    if filePath == nil then
		return nil
	end
    
    local firstSlash = string.find(filePath, '[/\\]')
	if firstSlash then 
		filePath = string.sub(filePath, 0, firstSlash-1)
    end
	return filePath
end
function extractSecondDir(filePath)
    if filePath == nil then
		return nil
	end
    
    local firstSlash = string.find(filePath, '[/\\]')
	if firstSlash then 
		filePath = string.sub(filePath, firstSlash+1)
    end

    local firstSlash = string.find(filePath, '[/\\]')
	if firstSlash then 
		filePath = string.sub(filePath, 1, firstSlash-1)
    end

	return filePath
end

-- compare two tables with name field
function namedTableComparator(v1, v2)
    if not v1 then
        return true
    end
    
    if not v2 then
        return false
    end

    return TextUtil.Utf8Compare(v1.name, v2.name) 
end

function fixSlash(path)
    path = string.gsub(path, [[\]], '/')
    path = string.gsub(path, [[\\]], '/')
    path = string.gsub(path, '//', '/')
    return path
end

function fixInvertSlash(path)
    path = string.gsub(path, [[/]], '\\')
    path = string.gsub(path, [[//]], '\\')
    return path
end

-- returns terrain altitude in point
function getAltitude(x, y)
    return math.floor(Terrain.GetHeight(x, y) + 0.5)
end

-- returns true if there is LOS
function isVisible(x1, alt1, y1, x2, alt2, y2)
	return Terrain.isVisible(x1, alt1, y1, x2, alt2, y2)
end

-- returns maximum difference between numbers in array
function getMaxDelta(nums)
    local len = #nums

    local min = nums[1]
    local max = min

    for i = 2, len do
        local v = nums[i]
        if min > v then
            min = v
        end
        if max < v then
            max = v
        end
    end

    return math.max(max - min)
end

-- возвращает угол наклона
function getTiltAngle(nums, a_side)
    return math.atan(getMaxDelta(nums)/a_side)*180.0/math.pi 
end

-- check terrain heigh at corners and center of quad and returns
-- greatest height difference
function getAltitudeDelta(x, y, side)
    local s = side / 2.0
    local res = { }
    table.insert(res, Terrain.GetHeight(x - s, y - s))
	table.insert(res, Terrain.GetHeight(x - s, y))
	table.insert(res, Terrain.GetHeight(x, y - s))
    table.insert(res, Terrain.GetHeight(x + s, y - s))
    table.insert(res, Terrain.GetHeight(x + s, y + s))
	table.insert(res, Terrain.GetHeight(x + s, y))
	table.insert(res, Terrain.GetHeight(x, y + s))
    table.insert(res, Terrain.GetHeight(x - s, y + s))
    table.insert(res, Terrain.GetHeight(x, y))
    return getMaxDelta(res)
end

function isValidSurface(a_angle, a_x, a_y, a_side, a_typeLand)
    local s = a_side / 2.0
    local res = { }
    table.insert(res, Terrain.GetHeight(a_x - s, a_y - s))
    table.insert(res, Terrain.GetHeight(a_x + s, a_y - s))
    table.insert(res, Terrain.GetHeight(a_x + s, a_y + s))
    table.insert(res, Terrain.GetHeight(a_x - s, a_y + s))
    table.insert(res, Terrain.GetHeight(a_x, a_y))
   
    local angle = getTiltAngle(res, a_side)
    
    if angle > a_angle then
        return false
    end
   
    local result = true
    result = result and (Terrain.GetSurfaceType(a_x - s, a_y - s) == a_typeLand)
    result = result and (Terrain.GetSurfaceType(a_x + s, a_y - s) == a_typeLand)
    result = result and (Terrain.GetSurfaceType(a_x + s, a_y + s) == a_typeLand)
    result = result and (Terrain.GetSurfaceType(a_x - s, a_y + s) == a_typeLand)
    result = result and (Terrain.GetSurfaceType(a_x, a_y) == a_typeLand)
    
    return result
end

function randomseed()
	local int, fr = math.modf(os.clock())
    fr = math.floor(fr*10000)
    math.randomseed(fr)
end

function random(m,n)
    local rnd
    if m then
        if n then -- [m .. n]
            rnd = math.random(m,n)-- * (n - m) + m -- [m .. n)
            return rnd
        else -- [1..m]
            rnd = math.random(m) --* (m - 1) + 1 -- [1..m)
            return rnd            
        end
    else -- [0 .. 1)
        rnd = math.random()
        return rnd    
    end
end


-- place elements from list at top of list
function listFirstComparator(list, fieldName)
    return function (v1, v2)
		local s1, s2
		
		if v2 == nil then
			return false
		end
		
		if fieldName == nil then
			s1 = v1
			s2 = v2
		else
			s1 = v1[fieldName]
			s2 = v2[fieldName]
		end
		
        if nil == s1 then
            return true
        end
        
        if nil == s2 then
            return false
        end

        for _k, v in pairs(list) do
            if v == s1 then
                return true
            elseif v == s2 then
                return false
            end
        end

        if (type(s1) == 'string') and (type(s2) == 'string') then
            return TextUtil.Utf8Compare(s1, s2)
        end
		
        return s1 < s2
    end
end

local firstCountries 


firstCountries = { _('USA'), _('Russia') }


-- sort list of countries and put russia and usa at top of the list
function sortCountries(countries, fieldName)
    table.sort(countries, listFirstComparator(firstCountries, fieldName))
end

-- add spinbox-like behiviour to editbox
function editBoxNumericRestriction(editBox, min, max)
    local s = editBox:getText()
    local v = tonumber(s) or 0
    if (v < min) or (v > max) then
        v = math.max(min, math.min(v, max))
        local pos, cnt = editBox:getSelection()
        s = tostring(v)
        editBox:setText(s)
        local len = string.len(s)
        if pos > len + 1 then
            pos = len + 1
        end
        editBox:setSelection(pos, cnt)
    end
    return v
end

function unitEditBoxRestriction(editBox, min, max)
    local s = editBox:getValue()
    local v = s or 0
    if (v < min) or (v > max) then
        v = math.max(min, math.min(v, max))
        local pos, cnt = editBox:getSelection()
        s = v
        editBox:setValue(s)
        local len = string.len(s)
        if pos > len + 1 then
            pos = len + 1
        end
        editBox:setSelection(pos, cnt)
    end
    return v
end

-- returns true if country is not russia and ukraine
function isWesternCountry(country)
    return not (
		 (russia 		== country) or 
		 (ukraine 		== country) or 
		 (insurgents 	== country) or 
		 (abkhazia 		== country) or 
		 (south_osetia 	== country) or 
		 (china 		== country) or 
		 (belarus 		== country) or
		 (USSR 			== country) or 
		 (yugoslavia	== country) or 
		 (GDR			== country) 
		 
	)
end

-- объединяет две таблицы в третью
function mergeTablesToTable(a_user, a_sys, a_resultT)
    for k, v in pairs(a_sys) do
        if type(v) == 'table' then
            if a_user[k] == nil then
                a_resultT[k] = v 
            else
                a_resultT[k] = {}
                mergeTablesToTable(a_user[k], v, a_resultT[k])
            end
        else
            if a_user[k] ~= nil then
                a_resultT[k] = a_user[k]
            else
                a_resultT[k] = v    
            end
        end
    end 
end
    
-- сравниваем таблицу source с таблицей dest 
function compareTables(dest, source, _ignoredFields)
    local EPS = 1e-10
    local tablesList = {}
    local ignoredFields = {}
    for k,v in ipairs(_ignoredFields or {}) do
        ignoredFields[v] = true
    end
    str = ''        
    function compare(dest, source, tablesList, ignoredFields, sourceKey)
        str = str .. '  '
        if (dest == nil) or (source == nil) then -- если какая-либо из таблиц пуста обрываем сравнение
            str = string.sub(str, 1, -3)
            return false 
        end
        for sourceKey, sourceValue in pairs(source) do -- идем по полям исходной таблицы
            if ignoredFields[sourceKey] == nil then -- поля нет в списке игнорируемых
                if type(sourceValue) == 'table' then -- поле - таблица
                    if tablesList[sourceValue] == nil then -- эта таблица попалась впервые
                        tablesList[sourceValue] = sourceKey
                        if not compare(dest[sourceKey], sourceValue, tablesList, ignoredFields, sourceKey) then
                            str = string.sub(str, 1, -3)
                            return false
                        end
                    end
                else -- поле - обычное значение
                    if dest[sourceKey] ~= sourceValue then
                        if ( (type(sourceValue) == 'number') 
                            and (type(dest[sourceKey]) == 'number') ) then
                            if math.abs(dest[sourceKey] - sourceValue) > EPS then
                                print(sourceKey, 'numbers differ', dest[sourceKey], sourceValue)
                                str = string.sub(str, 1, -3)
                                return false                            
                            end
                        else 
                            print(sourceKey, 'differs',dest[sourceKey], sourceValue)                        
                            str = string.sub(str, 1, -3)
                            return false
                        end
                    end
                end
            end
        end
        str = string.sub(str, 1, -3)
        return true
    end
    if (compare(dest, source, tablesList, ignoredFields)) then
        return compare(source, dest, tablesList, ignoredFields)
    else
        return false
    end
end

function recursiveCopyTable(dest, source)
    local _tablesList = {}
    
    function copy(dest, source, tablesList)
        
        for sourceKey, sourceValue in pairs(source) do
            if type(sourceValue) == 'table' then
                if tablesList[sourceValue] == nil then
                    dest[sourceKey] = dest[sourceKey] or {}
                    tablesList[sourceValue] = dest[sourceKey]
                    
                    copy(dest[sourceKey], sourceValue, tablesList)
                else
                    dest[sourceKey] = tablesList[sourceValue]
                end
            else
                dest[sourceKey] = sourceValue
            end
        end
    end
    
    copy(dest, source, _tablesList)
end

-- save table to file
function saveTable(fileName, name, table)
  local f = io.open(fileName, 'w')
  if f then
    local s = S.new(f)
    s:serialize_simple2(name, table)
    f:close()
  end
end

-- append file to zip
function addTableToZip(miz, name, table)
	local tempFilePath = base.tempDataDir .. 'temp.lua'
    saveTable(tempFilePath, name, table)
    miz:zipAddFile(name, tempFilePath)
    os.remove(tempFilePath)
end

function addTableToZip2(miz, nameTable, path, table)
	local tempFilePath = base.tempDataDir .. 'temp.lua'
    saveTable(tempFilePath, nameTable, table)
    miz:zipAddFile(path, tempFilePath)
    os.remove(tempFilePath)
end

function round(number, precision)
	if precision == nil then
		return math.floor(number + 0.5)
	else
		return precision * math.floor(number / precision + 0.5)
	end
end

function copyContainerMainWidgetsIntoModule(a_container, a_dist)
    local widgetCounter = a_container:getWidgetCount() - 1
    local widgets = {}
    
    for i = 0, widgetCounter do
        widgets[a_container:getWidget(i)] = true
    end
    
    for k, v in pairs(a_container) do
        if widgets[v] then 
            if a_dist[k] == nil then
                a_dist[k] = v
            else
                assert(false, "ERROR in dialog conflict names !!! "..k)
            end
        end
    end   
end

function fillComboBox(comboBox, set)
    comboBox:clear()  
    if not set then
       comboBox:setText("")
       return
    end
    for i, v in ipairs(set) do
        local item = ListBoxItem.new(v.name)
		if v.skin ~= nil then
			item:setSkin(v.skin)
		end
        item.itemId = v
        comboBox:insertItem(item)
    end
    if next(set) then
        comboBox:setText(set[next(set)].name)
    else
        comboBox:setText('')
    end
end

function nameComp (a, b) return a.name < b.name end

function fillTemplatesCombo(templatesTable, templatesCombo, isComboList)
	templateNames = {}
	for templName, templ in pairs(templatesTable) do
        table.insert(templateNames, {name = templName, displayName = _(templName)})
    end
    table.sort(templateNames, nameComp)
	table.insert(templateNames, {name = _('default'), displayName = _('default')})
	
	if isComboList then 
		fillComboList(templatesCombo, templateNames)
	else
		fillComboBox(templatesCombo, templateNames)
	end
end

function stack(msg)
    if (msg) then
        print('<=== ' .. msg .. ' ===>')
    end
    print(debug.traceback())
end

function makeSimpleItem(name)
	return { name = _(name), value = name }
end

function getItemByValue(items, value)
	for i, v in pairs(items) do
		if v.value == value then
			return v
		end
	end
	return nil
end

function fillComboList(comboList, set)
    comboList:clear()  
    if not set then
       comboList:setText("")
       return
    end
    for i, v in ipairs(set) do
        if v.displayName == nil then
            v.displayName = v.name
        end
        local item = ListBoxItem.new(v.displayName)
        item.name = v.name
		if v.toolTip then
			item:setTooltipText(v.toolTip)
		end
		if v.skin ~= nil then
			item:setSkin(v.skin)
		end
        item.itemId = v
        comboList:insertItem(item)
    end
    if next(set) then
        comboList:setText(set[next(set)].name)
    else
        comboList:setText('')
    end
	comboList.set = set
end

function fillComboList2(comboList, set)
    comboList:clear()  
    if not set then
       comboList:setText("")
       return
    end
    for i, v in ipairs(set) do
        if v.displayName == nil then
            v.displayName = v.name
        end
        local item = ListBoxItem.new(v.displayName)
        item.name = v.name
		if v.toolTip then
			item:setTooltipText(v.toolTip)
		end
		if v.skin ~= nil then
			item:setSkin(v.skin)
		end
        item.itemId = v.itemId
        comboList:insertItem(item)
    end
    if next(set) then
        comboList:setText(set[next(set)].name)
    else
        comboList:setText('')
    end
	comboList.set = set
end

function setComboBoxValue(comboBox, value)
	assert(comboBox.set ~= nil)
	local item = getItemByValue(comboBox.set, value)
	if item ~= nil then
		comboBox:setText(item.name)
		return true
	end
	return false
end

function fillCheckedList(selectedData, allData, listWidget)
    listWidget:clear()
    for i, v in ipairs(allData) do
        local newItem = CheckListBoxItem.new(v)		
        local ind = find(selectedData, v)
        newItem:setChecked(ind ~= nil)
        listWidget:insertItem(newItem)
    end
end

function fillCheckedListId(selectedData, allData, listWidget)
    listWidget:clear()
    for i, v in ipairs(allData) do
        local newItem = CheckListBoxItem.new(_(v))	
		newItem.itemId = v		
        local ind = find(selectedData, v)
        newItem:setChecked(ind ~= nil)
        listWidget:insertItem(newItem)
    end
end

function isFuel_Tank(a_attribute)
    return a_attribute and a_attribute[1] == 1 and a_attribute[2] == 3 and a_attribute[3] == 43
end

function saveUserData(filePath, dataTable, needSimpleSerialize)
	local f = io.open(filePath, 'w')
    if f then
		local s = S.new(f)
		if  needSimpleSerialize then
            for name, v in pairs(dataTable) do
               s:serialize_simple2(name, v)
            end
        else
		    for name, v in pairs(dataTable) do
               s:serialize_compact(name, v)
            end
        end
        f:close()
	end
end

function verifyLuaString(str)
	local f, errorMsg = loadstring(str)
	if f ~= nil then
		return nil
	else
		return errorMsg
	end
end

function verifyLuaFile(file)
	local f, errorMsg = loadfile(file)
	if f ~= nil then
		return nil
	else
		return errorMsg
	end
end
 
function saveInFile(a_table, a_nameTable, a_path)	 
    local f, err = io.open(a_path, 'w')
    if f then
        local sr = S.new(f) 
        sr:serialize_simple2(a_nameTable, a_table)
        f:close()
	else
		log.error('ERROR: saveInFile failed: '..err)		
    end
end

function fillScrollPaneCredits(file, scrollPane, a_funTranslate, a_staticSkin, a_staticMourningSkin_)
	local function createStatic(text, mourning)
		if '' ~= text then
			text = string.gsub(text, '\\n', '\n');		   
		end
		
		local static = Static.new(text)

		if mourning then
			static:setSkin(a_staticMourningSkin_)
		else
			static:setSkin(a_staticSkin)
		end

		return static
	end

	local file, err = io.open(file, 'r')	
	scrollPane:removeAllWidgets()

	if file then
		local line = file:read('*line')		
		while line do
			-- если строка заключена в квадратные скобки
			-- то удаляем их и устанавливаем траурный скин
			local text, matchCount = string.gsub(a_funTranslate(line), '%[(.*)%]$', '%1')
			-- заменяем значок # на номер версии
			text = string.gsub(text, '#', base.START_PARAMS.version);
			
			scrollPane:insertWidget(createStatic(text, matchCount > 0))
			
			line = file:read('*line')
		end
		
		file:close()
	else
		print(err)
	end	
end

function createUnitSpinBox(label, spinBox, measureUnits, minValue, maxValue, roundRrecision)
	return {
		setRange = function(self, minValue, maxValue)
			self.minValue = minValue
			self.maxValue = maxValue
			self.spinBox:setRange(round(minValue * self.coeff, self.roundRrecision), round(maxValue * self.coeff, self.roundRrecision))
		end,
		getRange = function(self)
			local minValueInd, maxValueInd = self.spinBox:getRange()
			return round(minValueInd / self.coeff, self.roundRrecision), round(maxValueInd / self.coeff, self.roundRrecision)
		end,
		setStep = function(self, a_step)
			self.step = a_step
			self.spinBox:setStep(round(self.step * self.coeff, self.roundRrecision))
			self.spinBox:setPageStep(round(self.step * self.coeff, self.roundRrecision))
		end,
		setValue = function(self, value)
			self.spinBox:setValue(round(value * self.coeff, self.roundRrecision))
		end,
		getValue = function(self)
			return self.spinBox:getValue() / self.coeff
		end,
		setUnitSystem = function(self, unitSystem)
			if self.label then
				self.label:setText(self.measureUnits[unitSystem].name)
			end
			local value = self:getValue()
			self.coeff = self.measureUnits[unitSystem].coeff
			self:setValue(value)
			self.spinBox:setRange(round(self.minValue * self.coeff, self.roundRrecision), round(self.maxValue * self.coeff, self.roundRrecision))
			self.spinBox:setStep(round(self.step * self.coeff, self.roundRrecision))
			self.spinBox:setPageStep(round(self.step * self.coeff, self.roundRrecision))
		end,
		setEnabled = function(self, value)
			self.label:setEnabled(value)
			self.spinBox:setEnabled(value)
		end,
		label = label,
		spinBox = spinBox,
		measureUnits = measureUnits,
		coeff = 1,
		step = step or spinBox:getStep(),
		minValue = minValue or 0,
		maxValue = maxValue or 0,
        roundRrecision = roundRrecision,
	}
end

do

local precision = 0.001

function createUnitEditBox(label, editBox, measureUnits, newPrecision)
    if (newPrecision == nil) then
        newPrecision = precision
    end
	return {
		setValue = function(self, value)
			self.editBox:setText(round(value * self.coeff, newPrecision))
		end,
		getValue = function(self)
            local value = tonumber(self.editBox:getText())
            if value == nil then
                value = 0
            end
			return round(value / self.coeff, newPrecision)
		end,
		setUnitSystem = function(self, unitSystem)
			if label then
				self.label:setText(self.measureUnits[unitSystem].name)
			end
			self.coeff = self.measureUnits[unitSystem].coeff
		end,
		label = label,
		editBox = editBox,
		measureUnits = measureUnits,
		coeff = 1,
        newPrecision = newPrecision,
        getSelection = function ()
                return editBox:getSelection(self)
            end, 
        setSelection = function (self, pos, cnt)  
                editBox:setSelection(pos, cnt)
            end,
	}
end

end

function createUnitEditBoxWriteOnly(editBox, measureUnits)
	return {
		setValue = function(self, a_value)			
            if (self.unitSystem) then            
                self.editBox:setText(math.floor(a_value * self.coeff + 0.5).. ' '..self.measureUnits[self.unitSystem].name)            
            else
                self.editBox:setText(math.floor(a_value * self.coeff + 0.5))
            end    
		end,

		setUnitSystem = function(self, unitSystem)
            self.unitSystem = unitSystem            
			self.coeff = self.measureUnits[unitSystem].coeff         
		end,
		editBox = editBox,
		measureUnits = measureUnits,
		coeff = 1
	}
end

function createUnitWidget(label, widget, measureUnits)
	return {
		setValue = function(self, value)
			self.widget:setText(math.floor(value * self.coeff + 0.5))
		end,
		getValue = function(self)
			return math.floor(tonumber(self.widget:getText()) / self.coeff + 0.5)
		end,
        setUnitSystem = function(self, unitSystem)
            if label then
				self.label:setText(self.measureUnits[unitSystem].name)
			end
			self.coeff = self.measureUnits[unitSystem].coeff
		end,
		label = label,
		widget = widget,
		measureUnits = measureUnits,
		coeff = 1
	}
end

timeUnits = {
	imperial = {
		name	= _('s'),
		coeff	= 1
	},
	metric = {
		name	= _('s'),
		coeff	= 1
	}
}

altitudeUnits = {
	imperial = {
		name	= _('feet'),
		coeff	= 1 / 0.3048
	},
	metric = {
		name	= _('m'),
		coeff	= 1
	}
}

distanceUnits = {
	imperial = {
		name	= _('nm'),
		coeff	= 1 / 1850
	},
	metric = {
		name	= _('km'),
		coeff	= 0.001
	}
}

speedUnitsWind = {
	imperial = {
		name	= _('kts'),
		coeff	= 1.0 / 0.5154
	},
	metric = {
		name	= _('m/s'),
		coeff	= 1.0
	}
}

speedUnits = {
	imperial = {
		name	= _('kts'),
		coeff	= 3.6 / 1.85
	},
	metric = {
		name	= _('kmh'),
		coeff	= 3.6
	}
}

speedUnitsAlt = {
	imperial = {
		name	= _('fps'),
		coeff	= 1.0 / 0.3048
	},
	metric = {
		name	= _('m/s'),
		coeff	= 1.0
	}
}

weightUnits = {
	imperial = {
		name	= _('lbs'),
		coeff	= 1 / 0.45359237
	},
	metric = {
		name	= _('kg'),
		coeff	= 1
	}
}

pressureUnits = {
	imperial = {
		name	= _('inHg'),
		coeff	= 1 / 25.4
	},
	metric = {
		name	= _('mmHg'),
		coeff	= 1
	}
}
        
		
function getAnalyticsMissionName(a_path)
	local path = base.string.gsub(a_path, '\\', '/')
	local pos = base.string.find(path, '/Mods/')
	
	if pos then
		return base.string.sub(path,pos+6)
	end
	return "user mission" 
end

-------------------------------------------------------------------------------
--поиск итема в таблице по имени
function findTableItemByName(table, item)
	for _tmp, v in pairs(table) do
		if v == item.Name then
		  return true
		end
	end

	return false
end

function compTableShortName(tbl1, tbl2)
	return TextUtil.Utf8Compare(_(tbl1.shortName), _(tbl2.shortName))    
end
		