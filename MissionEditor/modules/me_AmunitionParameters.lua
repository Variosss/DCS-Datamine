local base = _G

module('me_AmunitionParameters')

local require 	= base.require
local table 	= base.table
local string 	= base.string
local pairs 	= base.pairs
local math 		= base.math
local tonumber 	= base.tonumber


local DialogLoader	= require('DialogLoader')
local Static 		= require('Static')
local CheckBox 		= require('CheckBox')
local ComboList 	= require('ComboList')
local Slider 		= require('HorzSlider')
local SpinBox 		= require('SpinBox')
local EditBox 		= require('EditBox')
local ListBoxItem 	= require('ListBoxItem')
local i18n       	= require('i18n')
local TableUtils	= require('TableUtils')


i18n.setup(_M)


local settingsDef 	= nil
local rowHeight 	= 25
local txtHeight 	= 20
local tblOffsetsX 	= {}
local curSettings 	= nil
local ctrlsById 	= {}
local visibleById 	= {}
local epsilon 		= 0.0000001
local container 	= nil -- ячейка в таблице подвески

local cdata = 
{
	AmunitionParameters = _("Amunition parameters"),
	Ok 					= _("OK"),
	Cancel				= _("CANCEL"),
}

function create()
	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_AmunitionParameters.dlg", cdata)
  --  window:setBounds(x, y, w, h)
	window:centerWindow()
	
	scrollPane = window.scrollPane
	btnOk = window.btnOk
	btnCancel = window.btnCancel
	sAddHeader = window.sAddHeader
	
	skinStatic 		= window.pNoVisible.static:getSkin()
    skinCheckBox 	= window.pNoVisible.checkBox:getSkin()
    skinComboList 	= window.pNoVisible.comboList:getSkin()
    skinSpinBox 	= window.pNoVisible.spinBox:getSkin()
    skinSlider 		= window.pNoVisible.slider:getSkin()
    skinESlider 	= window.pNoVisible.eSlider:getSkin()
    skinDimension 	= window.pNoVisible.sDimension:getSkin()
	
	btnOk.onChange = onChange_btnOk
	btnCancel.onChange = onChange_btnCancel
end


function show(a_b, a_tmpSettings, a_settingsDef, a_tblDisplayName, a_namePayload,a_pylonNumber, a_callbackSettingsOk, a_container)
	if not window then
		create()
	end

	if a_b == true then
		pylonNumber = a_pylonNumber
		callbackSettingsOk = a_callbackSettingsOk
		
		curSettings = {}

		TableUtils.recursiveCopyTable(curSettings, a_tmpSettings)	
		settingsDef = a_settingsDef
		
		window:setText(_("Pylon")..": "..a_tblDisplayName.pylon)
		sAddHeader:setText(_("Payload")..": "..a_tblDisplayName.payload.."\n".._("Loadout")..": "..a_namePayload)

		namePayload = a_namePayload
		container = a_container
		update()
	end
	
	window:setVisible(a_b)
end

function equal(a_value1, a_value2)
	return base.math.abs(a_value1-a_value2) < epsilon
end

function getKoeff(a_dimension)
	local koeff = 1
	if a_dimension then
		if a_dimension == 'ms' then
			koeff = 1000
		elseif a_dimension == 'min' then
			koeff = 1/60
		elseif a_dimension == 'h' then
			koeff = 1/3600
		elseif a_dimension == 'km/s' or a_dimension == 'kHz' then
			koeff = 0.001
		elseif a_dimension == 'MHz' then
			koeff = 0.000001
		elseif a_dimension == 'GHz' then
			koeff = 0.000000001
		end		
	end
	return koeff
end
	
function update()
	if settingsDef == nil or #settingsDef < 1 then
        return
    end
   
    scrollPane:clear()
	tblOffsetsX = {}

    
    local rowIndex = 1  
    local xLbl 
    local wLbl
    local xCtrl
    local wCtrl
    local xTxt
    local wTxt
    local xDim
    local wDim
    
    function setDimension(a_parameter, scrollPane)
        local sDim = Static.new()
        sDim:setSkin(skinDimension)
        sDim:setText(a_parameter.dimension)
        sDim:setBounds(xDim, rowIndex*rowHeight, wDim, rowHeight)
        scrollPane:insertWidget(sDim)
		ctrlsById[a_parameter.id].dim = sDim
    end

    function createWidgets(a_parameter, tabOrder) 	
		rowIndex = a_parameter.stringIndex or rowIndex
		tblOffsetsX[rowIndex] = tblOffsetsX[rowIndex] or 10	
		ctrlsById[a_parameter.id] = {}	
			
		-- округляем погрешности внесенные симулятором
		if curSettings[a_parameter.id] then
			curSettings[a_parameter.id] = base.math.floor(curSettings[a_parameter.id]*1000000+0.5)/1000000
		end
		
        wCtrl = a_parameter.wCtrl or 60        
        wTxt  = a_parameter.wTxt or 60
        xDim  = a_parameter.xDim or 260
        wDim  = a_parameter.wDim or 30  
		
		local koeff = getKoeff(a_parameter.dimension)		
		
		local offsetX = a_parameter.xLbl or tblOffsetsX[rowIndex]
		local nw,nh
		
        local Label = Static.new()
        Label:setSkin(skinStatic)
        Label:setText(a_parameter.label)
		nw,nh = Label:calcSize()
		wLbl = a_parameter.wLbl or nw
        Label:setBounds(offsetX , rowIndex*rowHeight, wLbl, txtHeight)
		if a_parameter.xLbl then
			tblOffsetsX[rowIndex] = a_parameter.xLbl
		end
        scrollPane:insertWidget(Label)
		ctrlsById[a_parameter.id].Label = Label
		offsetX = offsetX+wLbl+10

        local ctrl		
		xCtrl = a_parameter.xCtrl or offsetX
        if a_parameter.control == 'spinbox' then
            ctrl = SpinBox.new()
            ctrl:setTabOrder(tabOrder) 
            ctrl:setSkin(skinSpinBox)
			if a_parameter.step then 				
				if base.math.floor(a_parameter.step) ~= a_parameter.step then
					ctrl:setAcceptDecimalPoint(true)
				end
				ctrl:setStep(a_parameter.step)
			end
			if a_parameter.readOnly	then
				ctrl:setEnabled(false)
			end
            ctrl:setRange(a_parameter.min or 0, a_parameter.max or 100)
            ctrl:setValue((curSettings[a_parameter.id] or a_parameter.defValue) * koeff) 
            curSettings[a_parameter.id] = ctrl:getValue() / koeff
            ctrl:setBounds(xCtrl , rowIndex*rowHeight, wCtrl, txtHeight)
            ctrl.id = a_parameter.id
            ctrl.onChange = function(self)
				curSettings[self.id] = ctrl:getValue() / koeff
				verifyVisibility()
            end 
			offsetX = xCtrl+wCtrl+10

            if a_parameter.dimension then  
                xDim = a_parameter.xDim or (xCtrl+wCtrl+10)   
                setDimension(a_parameter, scrollPane)
				offsetX = xDim+wDim+10
            end 
        end
        
        if a_parameter.control == 'checkbox' then
            ctrl = CheckBox.new()
            ctrl:setTabOrder(tabOrder) 
            ctrl:setSkin(skinCheckBox)
            if curSettings[a_parameter.id] ~= nil then
                ctrl:setState(curSettings[a_parameter.id]) 
            else
                ctrl:setState(a_parameter.defValue) 
            end
			if a_parameter.readOnly	then
				ctrl:setEnabled(false)
			end
            curSettings[a_parameter.id] = ctrl:getState()
            ctrl:setBounds(xCtrl, rowIndex*rowHeight, wCtrl, txtHeight)
            ctrl.id = a_parameter.id
            ctrl.onChange = function(self)
                curSettings[self.id] = ctrl:getState()
				verifyVisibility()
            end
			offsetX = xCtrl+wCtrl+10
        end
        
        if a_parameter.control == 'slider' then
            ctrl = Slider.new()
            ctrl:setSkin(skinSlider)    
            ctrl:setRange(a_parameter.min or 0, a_parameter.max or 100)    
            ctrl:setValue((curSettings[a_parameter.id] or a_parameter.defValue) * koeff)  
            curSettings[a_parameter.id] = ctrl:getValue() / koeff           
            ctrl:setBounds(xCtrl, rowIndex*rowHeight, wCtrl, txtHeight) 
			if a_parameter.readOnly	then
				ctrl:setEnabled(false)
			end	
            
			xTxt  = a_parameter.xTxt or xCtrl+wCtrl+10
            local eSl = EditBox.new()
            eSl:setTabOrder(tabOrder) 
            eSl:setSkin(skinESlider)
            eSl:setNumeric(true)
            eSl:setText(ctrl:getValue())            
            eSl:setBounds(xTxt, rowIndex*rowHeight, wTxt, txtHeight)
			if a_parameter.readOnly	then
				eSl:setEnabled(false)
			end
            scrollPane:insertWidget(eSl)
			ctrlsById[a_parameter.id].eSl = eSl			
            ctrl.id = a_parameter.id 
            eSl.id = a_parameter.id             
            
            ctrl.onChange = function(self)
                eSl:setText(ctrl:getValue())
                curSettings[self.id] = ctrl:getValue() / koeff
				verifyVisibility()
            end  
            eSl.onChange = function(self)
                ctrl:setValue(base.tonumber(eSl:getText()))
                curSettings[self.id] = ctrl:getValue() / koeff
				verifyVisibility()
            end  
			offsetX = xTxt+wTxt+20
            
            if a_parameter.dimension then   
				xDim = a_parameter.xDim or (xTxt+wTxt+10)   
                setDimension(a_parameter, scrollPane)
				offsetX = xDim+wDim+20
            end     
        end
        
        if a_parameter.control == 'comboList' then
            ctrl = ComboList.new()
            ctrl:setSkin(skinComboList)
            ctrl:setBounds(xCtrl, rowIndex*rowHeight, wCtrl, txtHeight)
			if a_parameter.readOnly	then
				ctrl:setEnabled(false)
			end	
			local firstItem
            
            for i, value in base.ipairs(a_parameter.values)  do
                local item = ListBoxItem.new(value.dispName)
                
                item.id = value.id
                ctrl:insertItem(item)
				if firstItem == nil then
					firstItem = item
				end
                
                if equal(curSettings[a_parameter.id] or a_parameter.defValue, value.id) then
                    ctrl:selectItem(item)     
                end        
            end
			
			if ctrl:getSelectedItem() == nil and firstItem ~= nil then 
				ctrl:selectItem(firstItem)
			end
            offsetX = xCtrl+wCtrl+20
			
            if a_parameter.dimension then 
                xDim = a_parameter.xDim or (xCtrl+wCtrl+10) 
                setDimension(a_parameter, scrollPane)
				offsetX = xDim+wDim+20
            end    
            
            curSettings[a_parameter.id] = ctrl:getSelectedItem().id
            ctrl.id = a_parameter.id
            
            ctrl.onChange = function(self, item)
               curSettings[self.id] = item.id
			   verifyVisibility()
            end
                        
        end
          
        if ctrl then
            scrollPane:insertWidget(ctrl)
			ctrlsById[a_parameter.id].ctrl = ctrl		
        end
        
		tblOffsetsX[rowIndex] = offsetX
        rowIndex = rowIndex + 1 
    end
 
    
    local tabOrder = 1
	ctrlsById = {}
    for k, parameter in base.pairs(settingsDef) do  
        createWidgets(parameter, tabOrder)
        tabOrder = tabOrder + 1
    end 
	
	verifyVisibility()
end

function verifyVisibility()
	visibleById = {}
	-- проверяем условия видимости
	for k, parameter in base.ipairs(settingsDef) do  
		if parameter.VisibilityCondition then
			local result =  parseCondition(parameter.VisibilityCondition, curSettings)

			if ctrlsById[parameter.id] then
				for k,widget in base.pairs(ctrlsById[parameter.id]) do
					widget:setVisible(result)
				end
				visibleById[parameter.id] = result
			end
		else
			visibleById[parameter.id] = true	
		end
	end
end

local function getLabelById(a_id, a_settingsDef)
	for k, v in base.pairs(a_settingsDef) do
		if v.id == a_id then
			return v.label
		end
	end
end

local function getDimensionById(a_id, a_settingsDef)
	for k, v in base.pairs(a_settingsDef) do
		if v.id == a_id and v.dimension then
			return v.dimension
		end
	end
end

local function getValueById(a_id, a_settings, a_settingsDef, a_koeff)
	for k, v in base.pairs(a_settingsDef) do
		if v.id == a_id then
			if v.control == 'comboList' then
				for kk, vv in base.pairs(v.values) do
					if vv.id and a_settings[a_id] and equal(vv.id, a_settings[a_id]) then
						return vv.dispName
					end
				end
			else
				if a_settings[a_id] then
					return  base.math.floor(a_settings[a_id] * a_koeff *1000000+0.5)/1000000
				else
					return nil
				end
			end
		end
	end
end

function getTooltipSettings(a_settings, a_settingsDef)
	local vis = verifyVisibilityExternal(a_settings, a_settingsDef)
	local result = nil
	
	for k, v in base.ipairs(vis) do
		if v.value == true then
			result = (result or "").."\n"
			
			local dimension = getDimensionById(v.id, a_settingsDef)	
			local koeff = getKoeff(dimension)
			result = result..getLabelById(v.id, a_settingsDef)..": "..(getValueById(v.id, a_settings, a_settingsDef, koeff) or "xxx").." " .. (dimension or "")
		end
	end
	
	return result or ""
end

function verifyVisibilityExternal(a_settings, a_settingsDef)
	local result = {}
	local curSettingsTmp = {}
	TableUtils.recursiveCopyTable(curSettingsTmp, a_settings)
	
	-- проверяем условия видимости
	for k, parameter in base.ipairs(a_settingsDef) do  
		if parameter.VisibilityCondition then
			table.insert(result, {id = parameter.id, value = parseCondition(parameter.VisibilityCondition, curSettingsTmp)})
		else
			table.insert(result, {id = parameter.id, value = true})
		end
	end
	return result
end

-- {id = "xx", value = 123, bNot = true/false}
function conditionCheck(a_condition, a_curSettings)
	local result = false
	if a_curSettings[a_condition.id] == a_condition.value then
		result = true
	end
	
	if a_condition.bNot == true then
		result = not result
	end
	
	return result
end

function applicationOper(a_operation, a_value1, a_value2) 
	local result
	if a_operation == nil then
		result = a_value2
	elseif a_operation == "and" then	
		result = a_value1 and a_value2
	elseif a_operation == "or" then	
		result = a_value1 or a_value2
	end	
	return result
end

-- {	
	-- {условие 1},
	-- "or/and",	
	-- {
		-- {условие 2},
		-- "or/and",
		-- {условие 3},
	-- },
-- },
function parseCondition(a_conditions, a_curSettings)
	local result = false
	local nextOperation = nil
	local parity = false
	for k,v in base.ipairs(a_conditions) do
		if parity == false then
			if base.type(v) == "table" then
				if v.id then
					local tmpRes = conditionCheck(v, a_curSettings)
					result = applicationOper(nextOperation, result, tmpRes) 
				else
					local tmpRes = parseCondition(v, a_curSettings)
					result = applicationOper(nextOperation, result, tmpRes) 
				end
			else
				base.print("Error in condition")
				return false
			end
		else
			if base.type(v) == "string" then
				nextOperation = v
			else
				base.print("Error in condition")
				return false
			end
		end
		parity = not parity
	end
	return result
end

function onChange_btnOk()
	window:setVisible(false)
	
	local tmpSettings = {}

	for id,v in base.pairs(curSettings) do
		if visibleById[id] == true then
			tmpSettings[id]	= v
		end
	end
	
	local tooltip = getTooltipSettings(curSettings, settingsDef)
	
	callbackSettingsOk(namePayload, pylonNumber, tmpSettings, container, tooltip)	
end

function onChange_btnCancel()
	window:setVisible(false)
end