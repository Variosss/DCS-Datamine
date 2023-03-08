local base = _G

module('me_wagons')

local require = base.require

-- Модули LuaGUI
local DialogLoader = require('DialogLoader')
local DB = require('me_db_api')
local U = require('me_utilities')	-- Утилиты создания типовых виджетов
local panel_aircraft = require('me_aircraft')
local Static = require('Static')
local CheckBox = require('CheckBox')
local ComboList = require('ComboList')
local Slider = require('HorzSlider')
local SpinBox = require('SpinBox')
local EditBox = require('EditBox')
local ListBoxItem = require('ListBoxItem')
local crutches = require('me_crutches')  
local panel_loadout			= require('me_loadout')

require('i18n').setup(_M)

cdata = 
{
   add = _("ADD"),
   del = _("DEL"),
}

local unit


function create(x, y, w, h)
	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_wagons.dlg", cdata)
    window:setBounds(x, y, w, h)   
    
	box = window.box
    box:setBounds(0, 0, w, h)
    
    lbWagons = box.lbWagons
    btnUp = box.btnUp
    btnDown = box.btnDown
    
    clLocomotives = box.clLocomotives
    clWagons = box.clWagons
    
    btnDel = box.btnDel
    btnAddLoc = box.btnAddLoc
    btnAddWag = box.btnAddWag
    
    btnDown.onChange = onChange_btnDown
    btnUp.onChange = onChange_btnUp
    btnAddLoc.onChange = onChange_btnAddLoc
    btnAddWag.onChange = onChange_btnAddWag
    btnDel.onChange = onChange_btnDel
    
    fillComboboxs()
end

function fillComboboxs()
    clLocomotives:clear()
    clWagons:clear()
    
    for k,v in base.pairs(DB.car_by_name) do
        if v.category == "Locomotive" then
            local item = ListBoxItem.new(v.DisplayName)
            item.DisplayName = v.DisplayName
            item.type = v.type
            clLocomotives:insertItem(item)
        elseif v.category == "Carriage" then
            local item = ListBoxItem.new(v.DisplayName)
            item.DisplayName = v.DisplayName
            item.type = v.type
            clWagons:insertItem(item)
        end
    end
    
    if clLocomotives:getItemCount() > 0 then
        clLocomotives:selectItem(clLocomotives:getItem(0))
    end
    
    if clWagons:getItemCount() > 0 then
        clWagons:selectItem(clWagons:getItem(0))
    end
end

function onChange_btnDel()
    local item = lbWagons:getSelectedItem()
    
    if item then
        local index = lbWagons:getItemIndex(item)        
        lbWagons:removeItem(item)
        local nextItem = lbWagons:getItem(index)
        if nextItem then
            lbWagons:selectItem(nextItem)
        end
        base.table.remove(unit.wagons,index + 1)
  --[[      if index == 0 then
            btnAddLoc:setEnabled(true)
        end]]
    end
end

function addWagoninList(a_DisplayName, a_type)
    local item = ListBoxItem.new(a_DisplayName)
    item.type = a_type
    item.DisplayName = a_DisplayName

    local selectedItem = lbWagons:getSelectedItem()
    local selectedItemIndex 
    if selectedItem then
        selectedItemIndex = lbWagons:getItemIndex(selectedItem)
    end
    lbWagons:insertItem(item, selectedItemIndex)  
    return selectedItemIndex or (lbWagons:getItemCount()-1)
end

function addWagon(a_DisplayName, a_type)
    local index = addWagoninList(a_DisplayName, a_type)    
    base.table.insert(unit.wagons, index+1, a_type)
end

function onChange_btnAddLoc()
    local item = clLocomotives:getSelectedItem()
    if item then        
        addWagon(item.DisplayName, item.type)
        --btnAddLoc:setEnabled(false)
    end
end

function onChange_btnAddWag()
    local item = clWagons:getSelectedItem()
    if item then        
        addWagon(item.DisplayName, item.type)    
    end
end

local function copyItem(item)
    local newItem = ListBoxItem.new(item.DisplayName)
    newItem.type = item.type
    newItem.isLocomotive = item.isLocomotive
    newItem.DisplayName = item.DisplayName

    return newItem
end

function onChange_btnDown()
    local item = lbWagons:getSelectedItem()
    if item then
        local index = lbWagons:getItemIndex(item)
        if ((index + 1) < lbWagons:getItemCount())--[[ and (item.isLocomotive ~= true)]] then
            local newItem = copyItem(item)
            lbWagons:insertItem(newItem,index+2)
            lbWagons:removeItem(item)  
            lbWagons:selectItem(newItem)   
            local typeUnit = base.table.remove(unit.wagons,index + 1)
            base.table.insert(unit.wagons, index + 2, typeUnit)  
        end        
    end
end

function onChange_btnUp()
    local item = lbWagons:getSelectedItem()
    if item then
        local index = lbWagons:getItemIndex(item)
        if index > 0 then
           --[[ if index == 1 then
                local item0 = lbWagons:getItem(0)
                if not (item0 and item0.isLocomotive ~= true) then
                    return
                end 
            end    ]]
            local newItem = copyItem(item)
            lbWagons:insertItem(newItem,index-1)
            lbWagons:removeItem(item) 
            lbWagons:selectItem(newItem) 
            local typeUnit = base.table.remove(unit.wagons,index+1)
            base.table.insert(unit.wagons, index, typeUnit)   
        end
    end
end

function show(b)
    if b then
        update()
    end
    
    window:setVisible(b)
end



function update()
    lbWagons:clear()
	for k, unitType in base.ipairs(unit.wagons) do
        local unitTypeDesc = DB.unit_by_type[unitType]
        if unitTypeDesc then
            addWagoninList(unitTypeDesc.DisplayName, unitTypeDesc.type)  
        end    
    end
end

function setData(a_unit)
    unit = a_unit
    unit.wagons = unit.wagons or {}
    update()
end


