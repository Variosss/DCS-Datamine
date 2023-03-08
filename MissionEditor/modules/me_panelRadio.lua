local base = _G

module('me_panelRadio')

local require = base.require

-- Модули LuaGUI
local DialogLoader = require('DialogLoader')
local DB = require('me_db_api')
local U = require('me_utilities')	-- Утилиты создания типовых виджетов
local panel_aircraft = require('me_aircraft')
local Static = base.require('Static')
local SpinBox			= require('SpinBox')
local multyRangeSpinBox = require('multyRangeSpinBox')
local Skin					= require('Skin')
local ComboList			= require('ComboList')
local ListBoxItem		= require('ListBoxItem')

require('i18n').setup(_M)

cdata = 
{
  --  scr_522 = _('SCR-522 RADIO CHANNELS'),
    ButtonA = _('Button A'),
    ButtonB = _('Button B'),
    ButtonC = _('Button C'),
    ButtonD = _('Button D'),
    MHz     = _('MHz'),
    kHz     = _('kHz'),
	
	modulationName		= {
			[DB.MODULATION_AM] 			= _('AM'),
			[DB.MODULATION_FM]			= _('FM'),
			[DB.MODULATION_AM_AND_FM ] 	= _('AM/FM')
		}
}

-- Переменные загружаемые/сохраняемые данные 
vdata =
{
    ButtonA = 100,
    ButtonB = 100,
    ButtonC = 100,
    ButtonD = 100,
}

curUnit = nil
curType = nil
listSpinBoxs = {}
listModulationBoxs = {}

function create(x, y, w, h)
	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_panelRadio.dlg", cdata)
    window:setBounds(x, y, w, h)
    
	local box_w = w - U.offset_w * 2
	local box_h = h - U.offset_h
    
	box = window.box
    box:setBounds(0, 0, w, h)
    
    skinCaption = box.tmplRadio:getSkin()
    skinChannel = box.tmplChannel:getSkin()
    skinSpinBox = box.tmplSpinBox:getSkin()
    skinModulation = box.tmplModulation:getSkin()
	skinClModulation = box.clModulation:getSkin()
    
    update()
end   

local function fillModulationList(a_comboList, a_type)
	a_comboList:clear()
	if a_type == DB.MODULATION_AM_AND_FM then
		local item = ListBoxItem.new(cdata.modulationName[DB.MODULATION_AM])
		item.modulation = DB.MODULATION_AM
		a_comboList:insertItem(item)
		
		local item = ListBoxItem.new(cdata.modulationName[DB.MODULATION_FM])
		item.modulation = DB.MODULATION_FM
		a_comboList:insertItem(item)
		a_comboList:setEnabled(true)
	else
		local item = ListBoxItem.new(cdata.modulationName[a_type])
		item.modulation = a_type
		a_comboList:insertItem(item)
		a_comboList:setEnabled(false)
	end
	a_comboList:selectItem(a_comboList:getItem(0))
end

local function getModulationOfRange(a_range, a_frequency)
	if a_range then
		if a_range[1] then
			for k,v in base.pairs(a_range) do
				if v.modulation then
					if a_frequency >= v.min and a_frequency <= v.max then
						return v.modulation
					end
				elseif curUnit then
					return curUnit.boss.modulation
				end	
			end
		else	
			return curUnit.boss.modulation
		end
	end	
	return false
end

local function setModulationInComboList(a_comboList, a_modulation)
	for i=0, a_comboList:getItemCount()-1 do
		local item = a_comboList:getItem(i)
        if item and item.modulation == a_modulation then
			a_comboList:selectItem(item)
			return
        end
	end
end

local function updateModulation(a_comboList, a_range, a_frequency)
	if a_range and a_range[1] then
		for k,v in base.pairs(a_range) do
			if v.modulation then
				if a_frequency >= v.min and a_frequency <= v.max then
					fillModulationList(a_comboList, v.modulation)
					setModulationInComboList(a_comboList, v.modulation)
					return
				end
			else
				fillModulationList(a_comboList, DB.MODULATION_AM)
				setModulationInComboList(a_comboList, DB.MODULATION_AM)
				return
			end	
		end
	end
end	 

function update()
    if (panel_aircraft.vdata.group == nil) then
        return
    end    

    curUnit = panel_aircraft.getCurUnit()
    
    if curUnit.Radio == nil then
        createRadioForUnit(curUnit)
    end
     
    if curUnit.type == curType and curUnit.Radio then
        updateData()
    else      
        curType = curUnit.type
        createRadio()
    end
end

function updateData()
	local unitTypeDesc = DB.unit_by_type[curUnit.type]
    for k, radio in base.ipairs(curUnit.Radio) do
        if radio.channels then
            for kk, frequency in base.ipairs(radio.channels) do
                if listSpinBoxs[k] and listSpinBoxs[k][kk] then
                    listSpinBoxs[k][kk]:setValue(frequency*listSpinBoxs[k][kk].koef)
					local panelRadio = unitTypeDesc.panelRadio[k]
					if panelRadio.range and panelRadio.range[1] and panelRadio.range[1].min then
						updateModulation(listModulationBoxs[k][kk], panelRadio.range, frequency)
						if radio.modulations ~= nil and radio.modulations[kk] ~= nil  then
							setModulationInComboList(listModulationBoxs[k][kk], radio.modulations[kk])
						else						
							if panelRadio.range and panelRadio.range[1] and panelRadio.range[1].modulation then
								curUnit.Radio[k].modulations = curUnit.Radio[k].modulations or {}
								local frModulation = getModulationOfRange(panelRadio.range, frequency)
								
								if frModulation == 2 then
									curUnit.Radio[k].modulations[kk] = curUnit.boss.modulation
								else
									curUnit.Radio[k].modulations[kk] = frModulation
								end
							end	
						end
					end
                end
            end
        end
    end    
end

function createRadioForUnit(a_unit)    
    local unitTypeDesc = DB.unit_by_type[a_unit.type]
    
    a_unit.Radio = nil
    
    if (unitTypeDesc.panelRadio ~= nil) then
		a_unit.Radio = {}
        for k, radio in base.ipairs(unitTypeDesc.panelRadio) do
            a_unit.Radio[k] = {}
            a_unit.Radio[k].channels = {}
			a_unit.Radio[k].modulations = {}
            if radio.channels then
                for kk, channel in base.ipairs(radio.channels) do
                    a_unit.Radio[k].channels[kk] = channel.default

					if radio.range and radio.range[1] and radio.range[1].min then
						local frModulation = getModulationOfRange(radio.range, channel.default)
						
						if frModulation == 2 then
							a_unit.Radio[k].modulations[kk] = a_unit.boss.modulation							
						else
							a_unit.Radio[k].modulations[kk] = frModulation							
						end
					end
                end
            end
			
        end
    end    
end

function createRadio()
    local unitTypeDesc = DB.unit_by_type[curUnit.type]
    listSpinBoxs = {}
	listModulationBoxs = {}
    local tabOrder = 1
    box:clear()
    if (unitTypeDesc.panelRadio ~= nil) then
        local posY = 6    
        for k, radio in base.ipairs(unitTypeDesc.panelRadio) do
            local frMin 		= radio.range.min
            local frMax 		= radio.range.max

            listSpinBoxs[k] = {}
			listModulationBoxs[k] = {}
         
            local sName = Static.new(radio.name) 
            sName:setBounds(0, posY, 300, 40)
            sName:setSkin(skinCaption)
            box:insertWidget(sName)
            posY = posY + 30
            if radio.channels then
                for kk, channel in base.ipairs(radio.channels) do
                    local sNameCh = Static.new(channel.name) 
                    sNameCh:setBounds(10, posY, 200, 20)
                    sNameCh:setSkin(skinChannel)
                    box:insertWidget(sNameCh)
                    
                    local koef = 1
                    local Hz = cdata.MHz
                    if radio.displayUnits == "kHz" then
                        koef = 1000
                        Hz = cdata.kHz
                    end
                    
                    local spFrequency
                    if radio.range.min then
                        spFrequency = SpinBox.new()
                        spFrequency:setRange(frMin*koef, frMax*koef)    
                    else
                        spFrequency = multyRangeSpinBox.new()
                        spFrequency:setRange(radio.range)  
                    end
                    
                    spFrequency:setTabOrder(tabOrder) 
                    tabOrder = tabOrder + 1
                    spFrequency.koef = koef
                    spFrequency:setStep(0.1)
                    spFrequency:setAcceptDecimalPoint(true)
                    spFrequency:setValue(channel.default*koef)
                    spFrequency:setBounds(220, posY, 70, 20)
                    spFrequency:setSkin(skinSpinBox)
                    spFrequency.keyR = k
                    spFrequency.keyC = kk
                    spFrequency.connect = channel.connect
                    spFrequency.onChange = onChangeFrequency
                    box:insertWidget(spFrequency)
                    listSpinBoxs[k][kk] = spFrequency
                    
                    
                    local sUnits = Static.new(Hz) 
                    sUnits:setBounds(295, posY, 30, 20)
                    sUnits:setSkin(skinChannel)
                    box:insertWidget(sUnits)
                    
					if radio.range and radio.range[1] and radio.range[1].min then
						local frModulation = getModulationOfRange(radio.range, channel.default*koef)
						if frModulation ~= false then
							local clMod = ComboList.new() 
							clMod:setBounds(330, posY, 40, 20)
							box:insertWidget(clMod)
							clMod:setSkin(skinClModulation)
							
							fillModulationList(clMod, frModulation)

							listModulationBoxs[k][kk] = clMod
						else	
							local sMod = Static.new(channel.modulation) 
							sMod:setBounds(335, posY, 35, 20)
							box:insertWidget(sMod)
							sMod:setSkin(skinModulation)
						end
					else
						local sMod = Static.new(channel.modulation) 
						sMod:setBounds(335, posY, 35, 20)
						box:insertWidget(sMod)
						sMod:setSkin(skinModulation)
					end
					
                    
                    posY = posY + 20
                end
            end
            posY = posY + 20
        end
        
        -- только для отступа снизу
        local tmp = Static.new("") 
        tmp:setBounds(10, posY, 200, 20)
        box:insertWidget(tmp)
    end
end

function onChangeFrequency(self)
    local frequency = self:getValue()/self.koef
    curUnit.Radio[self.keyR].channels[self.keyC] = frequency
	local unitTypeDesc = DB.unit_by_type[curUnit.type]
	local panelRadio = unitTypeDesc.panelRadio
	local modulation = curUnit.boss.modulation
	if panelRadio and panelRadio[1] and panelRadio[1].range and panelRadio[1].range[1] and panelRadio[1].range[1].min then
		updateModulation(listModulationBoxs[self.keyR][self.keyC],	panelRadio[self.keyR].range, frequency)
		local frModulation = getModulationOfRange(panelRadio[self.keyR].range, frequency)
		if modulation ~= frModulation and frModulation ~= 2	then
			modulation = frModulation
		end	
		
		if curUnit.Radio[self.keyR].modulations then
			curUnit.Radio[self.keyR].modulations[self.keyC] = modulation	
		end
	end	
	    
    if self.connect then
        panel_aircraft.setFrequency(frequency, modulation)
        panel_aircraft.update()
        for k, radio in base.ipairs(panelRadio) do
            for kk, channel in base.ipairs(radio.channels) do               
                if channel.connect == true and not(k == self.keyR and kk == self.keyC) then
					local frModulation = getModulationOfRange(radio.range, frequency)						
					if frModulation ~= false and  
					  (modulation == frModulation or frModulation == DB.MODULATION_AM_AND_FM) then 
						listSpinBoxs[k][kk]:setValue(frequency*self.koef)
						curUnit.Radio[k].channels[kk] = frequency 

						if listModulationBoxs[k][kk] then
							updateModulation(listModulationBoxs[k][kk],	radio.range, frequency)
							setModulationInComboList(listModulationBoxs[k][kk], modulation)
						end
						curUnit.Radio[k].modulations[kk] = modulation		
					end	
                end				
            end
        end    
    end
end

function setConnectFrequency(a_frequency, a_modulation)
    local unitTypeDesc = DB.unit_by_type[curUnit.type]
	
    for k, radio in base.ipairs(unitTypeDesc.panelRadio) do
        if radio.channels then
            for kk, channel in base.ipairs(radio.channels) do
                if channel.connect == true then
					local frModulation = getModulationOfRange(radio.range, a_frequency)	
					if frModulation ~= false and 
					  (a_modulation == frModulation or frModulation == DB.MODULATION_AM_AND_FM) then
						listSpinBoxs[k][kk]:setValue(a_frequency*listSpinBoxs[k][kk].koef)
						curUnit.Radio[k].channels[kk] = a_frequency 

						if listModulationBoxs[k] and listModulationBoxs[k][kk] then
							updateModulation(listModulationBoxs[k][kk],	radio.range, a_frequency)
							setModulationInComboList(listModulationBoxs[k][kk], a_modulation)
							if curUnit.Radio[k].modulations then
								curUnit.Radio[k].modulations[kk] = a_modulation	
							end
						end
					end
                end
            end
        end
    end 
end

-- Открытие/закрытие панели
function show(b)
--    window:setVisible(false)
    if b == true then
        update()
    end
    
    window:setVisible(b)
end






