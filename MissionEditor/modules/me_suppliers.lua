local base = _G

module('me_suppliers')

local require = base.require
local pairs = base.pairs
local table = base.table

-- Модули LuaGUI
local DialogLoader				= require('DialogLoader')
local ListBoxItem				= require('ListBoxItem')
local MapWindow					= require('me_map_window')	-- Окно карты
local Mission					= require('me_mission')
local U							= require('me_utilities')	-- Утилиты создания типовых виджетов
local i18n						= require('i18n')
local panel_manager_resource	= require('me_manager_resource')
local ModulesMediator			= require('Mission.ModulesMediator')

i18n.setup(_M)


cdata = 
{
    fullInfo    = _('FULL INFO'),
    suppliers   = _('SUPPLIERS'),
    add 		= _('ADD'),
    del 		= _('DEL'),
}

-- Переменные загружаемые/сохраняемые данные 
vdata =
{
    group = nil,
    unit = nil,
}

-- Создание и размещение виджетов
-- Префиксы названий виджетов: t - text, b - button, c - combo, sp - spin, sl - slider, e - edit, d - dial 
function create(x, y, w, h)
	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_suppliers_panel.dlg", cdata)
    window:setBounds(x, y, w, h)
       
	box = window.box
 
    tb_FullInfo = box.tb_FullInfo

    function tb_FullInfo:onChange()
        local bVisible = panel_manager_resource:isVisible()
        if bVisible == false then
            panel_manager_resource.setCurId(vdata.unit.unitId, false)
        end
        panel_manager_resource.show(not bVisible)
    end
    
    l_suppliers = box.l_suppliers
    function l_suppliers:onChange() 
        local item = l_suppliers:getSelectedItem()
        if item then
            ModulesMediator.getSupplierController().setSelectedWarehouseSupplier(vdata.unit.unitId, Mission.getSupplierInfo(item.Id, item.type, i18n.getLocale()))
        end
    end

    b_Add = box.b_Add

    function b_Add:onChange()
		local supplierController = ModulesMediator.getSupplierController()
		
        if self:getState() then
			supplierController.startAddWarehouseSupplier(getUnitId())
        else
			supplierController.finishAddSupplier()
        end
    end
    
    b_Del = box.b_Del
    
	function b_Del:onChange()
		local item = l_suppliers:getSelectedItem()
		
		if item then
			local unitId = vdata.unit.unitId
			
			Mission.removeWarehouseSupplier(unitId, item.Id, item.type)
			
			l_suppliers:removeItem(item)
		end
		
	end
end

function getUnitId()
	return vdata.unit.unitId
end

-- Открытие/закрытие панели
function show(b)    
    if b then
		b_Add:setState(false)
		tb_FullInfo:setState(false)
        updateSuppliers()
	else
		panel_manager_resource.show(false)
    end

    window:setVisible(b)
end

-------------------------------------------------------------------------------
--
function selectSupplier(supplierId, supplierType)
	Mission.addWarehouseSupplier(getUnitId(), supplierId, supplierType)
    
    updateSuppliers()
end

-------------------------------------------------------------------------------
--
function updateSuppliers()
    if vdata.group== nil
        or vdata.group.units == nil 
		or vdata.unit == nil 
        or Mission.mission.AirportsEquipment.warehouses[vdata.unit.unitId] == nil then
		
        return
    end
    
    local suppliers = Mission.mission.AirportsEquipment.warehouses[vdata.unit.unitId].suppliers
    local locale = i18n.getLocale()	
    l_suppliers:clear()
	
    for i,v in pairs(suppliers) do
        local displayName = ""
        if (v.type == 'airports') then
            if MapWindow.listAirdromes[v.Id].display_name then
                displayName = _(MapWindow.listAirdromes[v.Id].display_name) 
            else
                displayName = MapWindow.listAirdromes[v.Id].names[locale] or MapWindow.listAirdromes[v.Id].names['en']
            end 
        else
            displayName = Mission.unit_by_id[v.Id].boss.name
        end
        local item = ListBoxItem.new(displayName)
        item.Id     = v.Id
        item.type   = v.type
        l_suppliers:insertItem(item)
    end
end

-------------------------------------------------------------------------------
--
function setGroup(group, unit)
	vdata.group = group
	vdata.unit	= unit
end

-------------------------------------------------------------------------------
--
function resetFullInfo()
	tb_FullInfo:setState(false)
	panel_manager_resource.show(false)
end


-------------------------------------------------------------------------------
--
function isVisible()
    return window:isVisible()
end 




