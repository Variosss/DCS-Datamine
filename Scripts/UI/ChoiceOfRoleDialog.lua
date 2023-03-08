dofile('./Scripts/UI/initGUI.lua')

local base = _G

module('ChoiceOfRoleDialog')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local print = base.print
local table = base.table
local string = base.string
local tonumber = base.tonumber
local tostring = base.tostring
local assert = base.assert
local type = base.type
local math = base.math

local Gui               = require('dxgui')
local GuiWin            = require('dxguiWin')
local DialogLoader      = require('DialogLoader')
local WidgetParams      = require('WidgetParams')
local gettext           = require('i_18n')
local DCS               = require('DCS')
local GameMenu          = require('GameMenu')
local Static            = require('Static')
local Skin              = require('Skin')
local Terrain 			= require('terrain')
local i18n              = require('i18n')
local textutil          = require('textutil')

local locale = i18n.getLocale()
local ChoiceOfCoalitionDialog = require('ChoiceOfCoalitionDialog')

base.setmetatable(base.dxgui, {__index = base.dxguiWin})

local function _(text) 
    if text == nil then
        return ""
    end
    return gettext.translate(text) 
end

tabTr = {
    artillery_commander     =   _("TACTICAL CMDR"),
    forward_observer        =   _("FORWARD OBSERVER"),  
    observer                =   _("OBSERVER"),
    instructor              =   _("GAME MASTER"),
    pilot                   =   _("Pilot"),  -- default role
    pilot2                  =   _("Pilot2"), -- was used with hardcoded roles names
}

if base.__PRODUCT_ID__ == 2 then
	tabTr.instructor = _("SUPERVISOR")
end

function create()
    local localization = {

		back            = _('BACK'),
        ChoiceOfRole    = _('Choice of role'),
        Role            = _('Role'),
        ok              = _('OK'),
        Unit            = _('Unit'),
        onBoard         = _('Onboard'),
        country         = _('Country'),
        task            = _('Task'),
        groupName       = _('Group name'),
        playerName      = _('Start Position'),
	}

    if base.LOFAC then
        localization.Unit   = _('Unit-LOFAC')
    end
    
	window = DialogLoader.spawnDialogFromFile('Scripts/UI/ChoiceOfRole.dlg', localization)
    local width, height = Gui.GetWindowSize()
    window:setBounds(0,0,width, height)
    window.containerMain:setBounds((width-977)/2, (height-570)/2, 977, 570)
    
    btnStart = window.containerMain.panelBottom.btnOk
    btnBack = window.containerMain.panelBottom.btnBack
    gridRoles = window.containerMain.gridRoles
    btnClose = window.containerMain.panelTop.btnClose
    
    SkinStatic = window.containerMain.StaticTempl:getSkin()
    
    btnStart.onChange = onChange_Start
    btnBack.onChange = onChange_Back
    btnClose.onChange = onChange_Back
    gridRoles.onMouseDown = onMouseDown_gridRoles
    gridRoles.onMouseDoubleClick = onMouseDoubleClickGrid
    
    Slots = {}
    returnScreen = nil
    CoalitionLast = nil
end

function onMouseDoubleClickGrid(self, x, y, button)
	local col, row = gridRoles:getMouseCursorColumnRow(x, y)
	local selectRow = gridRoles:getSelectedRow()

    if -1 < row and selectRow == row then
		onChange_Start()
    end   
end

function onMouseDown_gridRoles(self, x, y, button)
    if 1 ~= button then
        return
    end
        
    local col, row = gridRoles:getMouseCursorColumnRow(x, y)
    
    if -1 < row then
      selectRow(row)
    end
end

function selectRow(row)
	btnStart:setEnabled(true)
    gridRoles:selectRow(row)
end

function compareFunction(data1, data2)
    if data1.groupName == nil and data2.groupName == nil then
        return data1.unitId < data2.unitId 
    end
    
    if data1.groupName == nil and data2.groupName ~= nil then
        return false
    end
    
    if data1.groupName ~= nil and data2.groupName == nil then
        return true
    end
    
    if data1.groupName == data2.groupName then
        return data1.unitId < data2.unitId 
    else
        return textutil.Utf8CompareNoCase(data1.groupName, data2.groupName)
    end
end
  
function show(a_coalition, a_needBack, returnScreen)
    if not window then
		 create()
	end
    
    btnBack:setVisible(a_needBack or false)
    CoalitionLast = a_coalition or CoalitionLast
    
    if CoalitionLast then
        Slots = DCS.getAvailableSlots(CoalitionLast)  
    end
    --traverseTable(Slots)
    base.table.sort(Slots, compareFunction)
    
    update()
    
	if window:getVisible() == false then
		window:setVisible(true)
		DCS.lockAllMouseInput()
		DCS.setPause(true)
	end
end

function isSelectCoalition()
    return CoalitionLast ~= nil
end

function update()
    airdromes = Terrain.GetTerrainConfig("Airdromes")
    
    rowIndex = 0 
    gridRoles:removeAllRows()
    if Slots ~= nil and Slots ~= 'nil' then
        for k,v in ipairs(Slots) do    
            insertRow(v)  
            rowIndex = rowIndex +1    
        end  
    end 

	btnStart:setEnabled(false)
end

function insertRow(v)
    gridRoles:insertRow(20)

    local cell

    cell = Static.new()
    cell:setSkin(SkinStatic)
    cell:setText(tabTr[v.role] or v.role) 
    cell.slotId = v.unitId
    gridRoles:setCell(0, rowIndex, cell)

    cell = Static.new()
    cell:setSkin(SkinStatic)
    local unitsTxt = DCS.getUnitTypeAttribute(v.type, "DisplayName")
    if v.groupSize and v.groupSize > 1 then
        unitsTxt = unitsTxt.."/"..v.groupSize
    end
    if v.type == v.role then
        unitsTxt = ""
    end
    cell:setText(unitsTxt) 
    gridRoles:setCell(1, rowIndex, cell)
    
    cell = Static.new()
    cell:setSkin(SkinStatic)
    cell:setText(v.onboard_num) 
    gridRoles:setCell(2, rowIndex, cell)
    
    cell = Static.new()
    cell:setSkin(SkinStatic)
    cell:setText(_(v.countryName)) 
    gridRoles:setCell(3, rowIndex, cell)
    
    cell = Static.new()
    cell:setSkin(SkinStatic)
    cell:setText(_(v.task)) 
    gridRoles:setCell(4, rowIndex, cell)
    
    cell = Static.new()
    cell:setSkin(SkinStatic)
    cell:setText(v.groupName) 
    gridRoles:setCell(5, rowIndex, cell)

    local airdromeName
    if v.airdromeId then
        if airdromes[v.airdromeId].display_name then
            airdromeName = _(airdromes[v.airdromeId].display_name) 
        else
            airdromeName = airdromes[v.airdromeId].names[locale] or airdromes[v.airdromeId].names['en']
        end   
		
		if v.airdromeId and v.parking_id then
			airdromeName = airdromeName.." - "..v.parking_id
		end
    end
    cell = Static.new()
    cell:setSkin(SkinStatic)
    if v.type == v.role then
        cell:setText("")
    elseif v.action then
        if v.action == 'From Ground Area' then
            cell:setText(_('Takeoff from ground'))
        end
        if v.action == 'From Ground Area Hot' then
            cell:setText(_('Takeoff from ground hot_Sim','Takeoff from ground hot')) 
        end
    else
        cell:setText(v.helipadName or airdromeName or _("Air")) 
    end
    
    gridRoles:setCell(6, rowIndex, cell)
    

end

function hide()
	if window and window:getVisible() == true then
		window:setVisible(false)
		DCS.unlockMouseInput()
		DCS.setPause(false)
	end
end

function getVisible()
    if window == nil then
        return false
    end
	return window:getVisible()
end

function setVisible(b)
    if window then
        window:setVisible(b)
    end
end

function onChange_Start()
    local selectRow = gridRoles:getSelectedRow()
    local widget = gridRoles:getCell(0, selectRow) 
    
    if widget then
        DCS.setPlayerUnit(widget.slotId)
        hide()
    end
end

function onChange_Back()
    DCS.setPlayerUnit("")
    hide()
    
    if returnScreen == 'Menu' then
        GameMenu.show()
    else        
        ChoiceOfCoalitionDialog.show()
    end
end

function kill()
	if window_ then
	   window_:setVisible(false)
	   window_:kill()
	   window_ = nil
	end
end


-- отладочная функция для сериализации таблицы на экран
function traverseTable(_t, _numLevels, _tabString, filename, filter)
    local _tablesList = {}
    filter = filter or {}
    fun = print
    if ( filename and (filename ~= '') ) then
        local out = io.open(filename, 'w')
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
    
end