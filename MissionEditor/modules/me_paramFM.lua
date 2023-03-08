local base = _G

module('me_paramFM')

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
   
}

local AddProp = {}
local rowHeight = 25
local txtHeight = 20
local unit = nil
local weight = 0
local weightDependentOfFuel = 0
local lastItemWeightDependentOfFuel = {}
local lastItemWeightWhenOn = {}


-- Создание и размещение виджетов
-- Префиксы названий виджетов: t - text, b - button, c - combo, sp - spin, sl - slider, e - edit, d - dial 
function create(x, y, w, h)
	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_panelParamFM.dlg", cdata)
    window:setBounds(x, y, w, h)   
    
	box = window.box
    box:setBounds(0, 0, w, h)
    
    scrollPane = box.scrollPane
    scrollPane:setBounds(0, 0, w, h)
    
    skinStatic = box.pNoVisible.static:getSkin()
    skinCheckBox = box.pNoVisible.checkBox:getSkin()
    skinComboList = box.pNoVisible.comboList:getSkin()
    skinSpinBox = box.pNoVisible.spinBox:getSkin()
    skinSlider = box.pNoVisible.slider:getSkin()
    skinESlider = box.pNoVisible.eSlider:getSkin()
    skinDimension = box.pNoVisible.sDimension:getSkin()
	

    --update()
end

-- Открытие/закрытие панели
function show(b)
    if b then
        update()
		
		-- check and apply guiAction after update, but only when show() 
		for i = 0, scrollPane:getWidgetCount() - 1 do
		local widget = scrollPane:getWidget(i)
		
			if "ComboList" == widget:getTypeName() then
				local selected = widget:getSelectedItem()
				if selected and selected.guiAction then
					widget:onChange(selected)
				end
			end
			if "CheckBox" == widget:getTypeName() and widget.guiAction then
				widget:onChange()				
			end
		end
    end
    
    window:setVisible(b)
end

function enableWidget (widget, b)		
		local b = (nil == b) and true or b		
		widget:setEnabled(b)		
		
		if "ComboList" == widget:getTypeName() then
			if b then 
				widget:selectItem(widget.currentItem) 	-- восстанавливаем, исходное			
			else 
				widget:selectItem(nil) 					-- чистим для того, чтобы юзер не думал, что опция в списке зафорсена
			end
		end		
end

-- Обновление значений виджетов после изменения таблицы vdata
function update()
	if base.next(AddProp) == nil then
        return
    end
   
    scrollPane:clear()
    weight = 0
    weightDependentOfFuel = 0
    lastItemWeightDependentOfFuel = {}
    lastItemWeightWhenOn = {}
    
    local rowIndex = 1  
    local xLbl 
    local wLbl
    local xCtrl
    local wCtrl
    local xTxt
    local wTxt
    local xDim
    local wDim
    
    function setDimension(PropAircraft, scrollPane)
        local sDim = Static.new()
        sDim:setSkin(skinDimension)
        sDim:setText(PropAircraft.dimension)
        sDim:setBounds(xDim, rowIndex*rowHeight, wDim, rowHeight)
        scrollPane:insertWidget(sDim)
    end
	

    function createWidgets(PropAircraft, tabOrder)        
        if (PropAircraft.playerOnly == true) 
            and (unit.skill ~= crutches.getPlayerSkill())
            and (unit.skill ~= crutches.getClientSkill()) then        
            return 
        end

        xLbl  = PropAircraft.xLbl or 10
        wLbl  = PropAircraft.wLbl or 180
        xCtrl = PropAircraft.xCtrl or 200
        wCtrl = PropAircraft.wCtrl or 60 
        xTxt  = PropAircraft.xTxt or 270
        wTxt  = PropAircraft.wTxt or 60
        xDim  = PropAircraft.xDim or 340
        wDim  = PropAircraft.wDim or 30  

        local Label = Static.new()
        Label:setSkin(skinStatic)
        Label:setText(PropAircraft.label)
        Label:setBounds(xLbl, rowIndex*rowHeight, wLbl,txtHeight)
		Label:setName(PropAircraft.id .."#")
        scrollPane:insertWidget(Label)

        local ctrl

        if PropAircraft.control == 'spinbox' then
            ctrl = SpinBox.new()
            ctrl:setTabOrder(tabOrder) 
            ctrl:setSkin(skinSpinBox)
            ctrl:setRange(PropAircraft.min or 0, PropAircraft.max or 100)
            ctrl:setValue(unit[AddPropType][PropAircraft.id] or PropAircraft.defValue) 
            unit[AddPropType][PropAircraft.id] = ctrl:getValue()
            ctrl:setBounds(xCtrl , rowIndex*rowHeight, wCtrl, txtHeight)
            ctrl.id = PropAircraft.id
            ctrl.onChange = function(self)
                unit[AddPropType][self.id] = ctrl:getValue()
            end 

            if PropAircraft.dimension then  
                xDim = PropAircraft.xDim or 270    
                setDimension(PropAircraft, scrollPane)
            end 
        end
        
        if PropAircraft.control == 'checkbox' then
            ctrl = CheckBox.new()
            ctrl:setTabOrder(tabOrder) 
            ctrl:setSkin(skinCheckBox)
			
            if PropAircraft.onlyEmpty == true then
                base.table.insert(ctrlEmptyOnly,ctrl)
            end
            if unit[AddPropType][PropAircraft.id] ~= nil then
                ctrl:setState(unit[AddPropType][PropAircraft.id]) 
            else
                ctrl:setState(PropAircraft.defValue) 
            end
            unit[AddPropType][PropAircraft.id] = ctrl:getState()
            ctrl:setBounds(xCtrl , rowIndex*rowHeight, wCtrl, txtHeight)
            ctrl.id = PropAircraft.id
            ctrl.weight = PropAircraft.weight
            ctrl.weightWhenOn = PropAircraft.weightWhenOn
            ctrl.onlyEmpty = PropAircraft.onlyEmpty			
			ctrl.weaponRestricted = PropAircraft.weaponRestricted
			
			ctrl.guiAction = PropAircraft.guiAction -- -- аттачим свойство to enable/disable other controls . Реализация ниже, в onChange. 
			
            ctrl.onChange = function(self)
                unit[AddPropType][self.id] = ctrl:getState()
                if ctrl:getState() == false then
                    weight = weight - (self.weight or 0) - (self.weightWhenOn or 0)
                    if self.onlyEmpty == true and typePanel ~= 'vehicle' then
						panel_aircraft.setUnitPayload({}, panel_loadout.cdata.empty)
                    end					
                else
                    weight = weight + (self.weight or 0) + (self.weightWhenOn or 0) 					
                end
				if self.weaponRestricted ~= nil and typePanel ~= 'vehicle' then
					-- меняем запрет оружия
					panel_loadout.setWeaponRestricted(self.weaponRestricted, ctrl:getState())
				end
				
				-- apply guiAction – enable/disable other controls
				local findWidgetByName = DialogLoader.findWidgetByName
				local panel = scrollPane				
				if ctrl.guiAction then
					local onSelect = ctrl.guiAction.onSelect  
					local controls = ctrl.guiAction.controls
					local isChecked = ctrl:getState()
					for k,name in base.ipairs(controls) do						
						local widget = findWidgetByName(panel, name)						
						local widgetLabel = findWidgetByName(panel, name.."#")
						
						if onSelect == 'disable' then	
							enableWidget (widget, 		not isChecked)
							enableWidget (widgetLabel, 	not isChecked)
						else -- enable						
							enableWidget (widget, 		isChecked)
							enableWidget (widgetLabel, 	isChecked)
						end
					end						
				end	
            end
            
			if ctrl:getState() == false then
                weight = weight - (PropAircraft.weight or 0)				
            else
                weight = weight + (PropAircraft.weightWhenOn or 0)                
            end
			if ctrl.weaponRestricted ~= nil and typePanel ~= 'vehicle' then
				-- меняем запрет оружия
				panel_loadout.setWeaponRestricted(ctrl.weaponRestricted, ctrl:getState())
			end
        end
        
        if PropAircraft.control == 'slider' then
            ctrl = Slider.new()
            ctrl:setSkin(skinSlider)    
            ctrl:setRange(PropAircraft.min or 0, PropAircraft.max or 100)    
            ctrl:setValue(unit[AddPropType][PropAircraft.id] or PropAircraft.defValue)  
            unit[AddPropType][PropAircraft.id] = ctrl:getValue()            
            ctrl:setBounds(xCtrl , rowIndex*rowHeight-5, wCtrl, txtHeight)            
            
            local eSl = EditBox.new()
            eSl:setTabOrder(tabOrder) 
            eSl:setSkin(skinESlider)
            eSl:setNumeric(true)
            eSl:setText(ctrl:getValue())            
            eSl:setBounds(xTxt, rowIndex*rowHeight, wTxt, txtHeight)
            scrollPane:insertWidget(eSl) 
            ctrl.id = PropAircraft.id 
            eSl.id = PropAircraft.id             
            
            ctrl.onChange = function(self)
                eSl:setText(ctrl:getValue())
                unit[AddPropType][self.id] = ctrl:getValue()
            end  
            eSl.onChange = function(self)
                ctrl:setValue(base.tonumber(eSl:getText()))
                unit[AddPropType][self.id] = ctrl:getValue()
            end  
            
            if PropAircraft.dimension then   
                setDimension(PropAircraft, scrollPane)
            end     
        end
        
        if PropAircraft.control == 'comboList' then
            ctrl = ComboList.new()
            ctrl:setSkin(skinComboList)
            ctrl:setBounds(xCtrl , rowIndex*rowHeight, wCtrl, txtHeight)
			
			
			local firstItem
            
            for i, value in base.ipairs(PropAircraft.values)  do
                local item = ListBoxItem.new(value.dispName)
                
                item.id = value.id				
				item.guiAction = value.guiAction  -- аттачим свойство to enable/disable other controls . Реализация ниже, в onChange. Пример использования: Ка-50_3.lua в Coremods
                item.weightDependentOfFuel = value.weightDependentOfFuel
                item.weightWhenOn = value.weightWhenOn
                ctrl:insertItem(item)
				if firstItem == nil then
					firstItem = item
				end
                
                if (unit[AddPropType][PropAircraft.id] or PropAircraft.defValue) == value.id then
                    ctrl:selectItem(item)
					ctrl.currentItem = item
                    weightDependentOfFuel = weightDependentOfFuel + (item.weightDependentOfFuel or 0)
                    lastItemWeightDependentOfFuel[PropAircraft.id] = (item.weightDependentOfFuel or 0)  

                    weight = weight + (item.weightWhenOn or 0)
                    lastItemWeightWhenOn[PropAircraft.id] = (item.weightWhenOn or 0)         
                end        
            end
			
			if ctrl:getSelectedItem() == nil and firstItem ~= nil then 
				ctrl:selectItem(firstItem)
				ctrl.currentItem = firstItem
				weightDependentOfFuel = weightDependentOfFuel + (firstItem.weightDependentOfFuel or 0)
				lastItemWeightDependentOfFuel[PropAircraft.id] = (firstItem.weightDependentOfFuel or 0)  

				weight = weight + (firstItem.weightWhenOn or 0)
				lastItemWeightWhenOn[PropAircraft.id] = (firstItem.weightWhenOn or 0) 
			end
            
            if PropAircraft.dimension then 
                xDim = PropAircraft.xDim or 270    
                setDimension(PropAircraft, scrollPane)
            end    
            
            unit[AddPropType][PropAircraft.id] = ctrl:getSelectedItem().id
            ctrl.id = PropAircraft.id
			ctrl.forcedPylons = PropAircraft.forcedPylons
            
            ctrl.onChange = function(self, item)
                unit[AddPropType][self.id] = item.id
                local itemWeightDependentOfFuel = item.weightDependentOfFuel                
                weightDependentOfFuel = weightDependentOfFuel - (lastItemWeightDependentOfFuel[self.id] or 0) + (itemWeightDependentOfFuel or 0)    
                lastItemWeightDependentOfFuel[self.id] = (itemWeightDependentOfFuel or 0)   

                local itemweightWhenOn = item.weightWhenOn                
                weight = weight - (lastItemWeightWhenOn[self.id] or 0) + (itemweightWhenOn or 0)    
                lastItemWeightWhenOn[self.id] = (itemweightWhenOn or 0) 

				if self.forcedPylons and self.forcedPylons[item.id] then
					panel_aircraft.setForcedPylons(self.forcedPylons[item.id]) 
				end	
				
				-- apply guiAction – enable/disable other controls
				local findWidgetByName = DialogLoader.findWidgetByName
				local panel = scrollPane
				if item.guiAction then
					local onSelect = item.guiAction.onSelect  
					local controls = item.guiAction.controls
					for k,name in base.ipairs(controls) do						
						local widget = findWidgetByName(panel, name)
						local widgetLabel = findWidgetByName(panel, name.."#")					
						
						
						if onSelect == 'disable' then	
							enableWidget (widget, false)
							enableWidget (widgetLabel, false)
						else	-- enable					
							enableWidget (widget, true)
							enableWidget (widgetLabel, true)
						end
					end						
				end	
				
				
            end                        
        end
          
        if ctrl then
            ctrl:setName(PropAircraft.id)
			scrollPane:insertWidget(ctrl)			
        end
        
        rowIndex = rowIndex + 1 
    end
    
    unit[AddPropType] = unit[AddPropType] or {}
    
    ctrlEmptyOnly = {}
    local tabOrder = 1
    for k, PropAircraft in base.pairs(AddProp) do  
        createWidgets(PropAircraft, tabOrder)
        tabOrder = tabOrder + 1
    end 	
	
end

function updateCtrlEmptyOnly(a_bNoEmpty)
    if ctrlEmptyOnly and a_bNoEmpty == true then
        for k,ctrl in base.pairs(ctrlEmptyOnly) do
            if ctrl and ctrl:getState() == false then
                ctrl:setState(true) 
                ctrl:onChange()
            end
        end
    end
end

function setData(a_prop, a_unit, a_typePanel)
    AddProp={}
    ctrlEmptyOnly = {}
    base.U.recursiveCopyTable(AddProp,a_prop)
    unit = a_unit
    typePanel = a_typePanel
    if typePanel == 'vehicle' then
        AddPropType = 'AddPropVehicle'
    else
        AddPropType = 'AddPropAircraft'
    end
    update()
end

function getWeight()
    return weight
end

function getWeightDependentOfFuel(a_unit)
	--local unitTypeDesc = DB.unit_by_type[a_unit.type]
	if a_unit.AddPropAircraft then
		--base.U.traverseTable(a_unit[AddPropType])
		return weightDependentOfFuel
	else
		return 0
	end
end
