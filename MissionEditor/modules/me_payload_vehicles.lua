local base = _G

module('me_payload_vehicles')

local require = base.require
local tostring = base.tostring
local math = base.math
local pairs = base.pairs
local tonumber = base.tonumber

-- Модули LuaGUI
local DialogLoader			= require('DialogLoader')
local ListBoxItem			= require('ListBoxItem')
local S						= require('Serializer')
local U						= require('me_utilities')	
local loadLiveries			= require('loadLiveries')
local pLoadout_vehicles		= require('me_loadout_vehicles')
local DB					= require('me_db_api')
local panel_paramFM			= require('me_paramFM')
local actionParamPanels 	= require('me_action_param_panels')
local OptionsData			= require('Options.Data')
local DemoSceneWidget 	    = require('DemoSceneWidget')


require('i18n').setup(_M)

local DSWidget

-- Неизменные локализуемые данные (при необходимости, их можно будет вынести в отдельный файл,
-- но IMHO удобнее видеть их прямо здесь, чтобы представлять себе структуру панели)
cdata = 
{
    color_schemes = {'Standard', 'European1',},
    color_scheme = _('PAINT SCHEME'),
}

-- Переменные загружаемые/сохраняемые данные (путь к файлу - cdata.vdata_file)
vdata =
{
    livery_id = 0,
}


-- Создание и размещение виджетов
-- Префиксы названий виджетов: t - text, b - button, c - combo, sp - spin, sl - slider, e - edit, d - dial 
function create(x, y, w, h)
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_payload_vehicles.dlg", cdata)
    window:setBounds(x, y, w, h)

    box = window.box
    box:setBounds(0, 0, w, h)
    
    c_color_scheme = box.c_color_scheme
    function c_color_scheme:onChange(item)
        vdata.unit.livery_id = item.itemId
        vdata.livery_id = item.itemId
        updateLiveries()
    end

    -- Присвоение виджетам актуальных значений из таблицы vdata
    update()
end

-------------------------------------------------------------------------------
-- build liveries list
function updateLiveries()
    c_color_scheme:clear()

    if not vdata.unit then
        return
    end

    local group = vdata.unit.boss
    local country = DB.country_by_id[group.boss.id]

	local selectedItem, firstItem
    
    -- добавляем дефолтный, который в livery_id пишет nil
    local item = ListBoxItem.new(_("Default"))		
    item.itemId = nil
    c_color_scheme:insertItem(item) 

    local schemes = loadLiveries.loadSchemes(DB.liveryEntryPoint(vdata.unit.type),country.ShortName)
 
    for k, scheme in pairs(schemes) do
        local item = ListBoxItem.new(scheme.name)
		
        item.itemId = scheme.itemId
        c_color_scheme:insertItem(item) 
    end
    
    local itemCount = c_color_scheme:getItemCount()
	local itemCounter = itemCount - 1
	
    if itemCount > 0 then			
        firstItem = c_color_scheme:getItem(0)
    end

    if vdata.unit then
        for i = 0, itemCounter do
			local item = c_color_scheme:getItem(i)
			           
            if vdata.unit.livery_id == item.itemId then
                selectedItem = item
				
				break
            end
        end
    end
    
    if not firstItem then
        c_color_scheme:setText(cdata.standard)
        vdata.color_scheme = cdata.standard
        vdata.livery_id = nil
    elseif not selectedItem then
        c_color_scheme:selectItem(firstItem)
        vdata.livery_id = firstItem.itemId
    else
        c_color_scheme:selectItem(selectedItem)
        vdata.livery_id = selectedItem.itemId
    end

    pLoadout_vehicles.updatePreview(vdata.unit.livery_id)
      
end



-- Открытие/закрытие панели
function show(b)
    window:setVisible(b)
    if b then
        update()        
    end
    pLoadout_vehicles.show(b)
end

-- find and set default livery
function setDefaultLivery(unit)
    unit.livery_id = nil
end

function setUnit(a_unit)
    vdata.unit = a_unit
    pLoadout_vehicles.setUnit(a_unit)
    update()
end



function update()
    updateLiveries()
end


