local base = _G

module('me_payload')

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
local panel_loadout			= require('me_loadout')
local DB					= require('me_db_api')
local panel_paramFM			= require('me_paramFM')
local actionParamPanels 	= require('me_action_param_panels')
local OptionsData			= require('Options.Data')
local loadLiveries			= require('loadLiveries')
local UpdateManager			= require('UpdateManager')

require('i18n').setup(_M)

-- Неизменные локализуемые данные (при необходимости, их можно будет вынести в отдельный файл,
-- но IMHO удобнее видеть их прямо здесь, чтобы представлять себе структуру панели)
cdata = 
{
    fuelTitle = _('INTERNAL FUEL'), 
    percents = '%',
    fuel_weight = _('FUEL WEIGHT'), 
    kg = _('kg'),
    empty = _('EQUIPPED EMPTY WEIGHT'),
    weapons = _('WEAPONS'),
    max = _('MAX'), 
    total = _('TOTAL'),
    chaff = _('CHAFF'),
    flare = _('FLARE'),
    gun = _('GUN'),
    ammo_type = _('AMMO_TYPE'),   
    civil = _('CIVIL PLANE'),
    bd = _('EXTERNAL HARDPOINTS'),    
    m           = _('m'),
    ropelength  = _('ROPE LENGTH'),
}

-- Переменные загружаемые/сохраняемые данные (путь к файлу - cdata.vdata_file)
vdata =
{
    balance = 50,
    fuel = 50,
    fuel_weight = 2500,
    fuel_weight_max = 5000,
    ammo_weight_max = 0,
    empty = 18000,
	weightDependent = 0,
    weapons = 0,
    max = 33000,
    total = 20500,
    -- Добавить
    chaff = 150,
    flare = 120,
    gun = 100,
    livery_id = 0,
}

local range = {5, 10, 15, 20, 25, 30}

function getAmmoWeight()
    if nil == vdata.ammo_weight_max then
        vdata.ammo_weight_max = 0
    end
    return vdata.ammo_weight_max * (vdata.gun / 100.0)
end

function updateTotalWeight()
    vdata.total = vdata.empty+vdata.fuel_weight + vdata.weapons + vdata.weightDependent + getAmmoWeight()
	
    total_unitEditBox:setValue(math.floor(0.5 + vdata.total))
    sl_total:setValue(math.min(math.floor(0.5 + 100 * vdata.total / 
                vdata.max), 100))
    e_total_prec:setText(tostring(math.floor(
                0.5 + 100 * vdata.total / vdata.max)))
end

-- Создание и размещение виджетов
-- Префиксы названий виджетов: t - text, b - button, c - combo, sp - spin, sl - slider, e - edit, d - dial 
function create(x, y, w, h)
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_payload_panel.dlg", cdata)
    window:setBounds(x, y, w, h)
    
    box = window.box
    box:setBounds(0, 0, w, h)

	cb_civil = box.cb_civil
	cb_civil.onChange = function(self)
		if self:getState() then
			vdata.unit.civil_plane = true
			panel_loadout.selectPayload(0)
		else
			vdata.unit.civil_plane = nil
		end
		vdata.unit.payload.gun = 0
		update()
		panel_loadout.show(true)
	end
    
    cb_bd = box.cb_bd
    cb_bd.onChange = function(self)
        if self:getState() then
            vdata.unit.hardpoint_racks = true
        else
            vdata.unit.hardpoint_racks = false 
            panel_loadout.selectPayload(0)
        end    
		panel_loadout.updateArguments()
        update()    
	end
  
    -- Fuel ----------------------------------------------    
    sl_fuel = box.sl_fuel
    sl_fuel:setValue(vdata.fuel)
    
    function updateFuelWeight()
        vdata.fuel_weight = math.floor(0.5 + vdata.fuel_weight_max * vdata.fuel /100) + panel_loadout.vdata.fuel
        fuel_weightEditBox:setValue(vdata.fuel_weight)
        vdata.unit.payload.fuel = vdata.fuel_weight - panel_loadout.vdata.fuel
        updateData()
		--base.print("---updateFuelWeight---",vdata.weightDependent)
        fuel_weightEditBox:setValue(vdata.fuel_weight + vdata.weightDependent)
        empty_unitEditBox:setValue(vdata.empty)
        weapons_unitEditBox:setValue(math.floor(0.5 + vdata.weapons + getAmmoWeight()))
        maxEditBox:setValue(vdata.max)
    end
    
    function sl_fuel:onChange()
        vdata.fuel = math.floor(self:getValue())
        local s = tostring(vdata.fuel)
        if s ~= e_fuel:getText() then
            e_fuel:setText(tostring(vdata.fuel))
        end
        updateFuelWeight()
    end
    
    e_fuel = box.e_fuel
    e_fuel:setText(tostring(vdata.fuel))

    function e_fuel:onChange()
        local i = U.editBoxNumericRestriction(self, 0, 100)
        sl_fuel:setValue(i)
        
        vdata.fuel = i
        updateFuelWeight()
    end
    
    -- Fuel weight ---------------------------------------
    local t_fuel_weight_unit = box.t_fuel_weight_unit
    
    e_fuel_weight = box.e_fuel_weight
    e_fuel_weight:setText(tostring(vdata.fuel_weight))
    
    fuel_weightEditBox = U.createUnitEditBox(t_fuel_weight_unit, e_fuel_weight, U.weightUnits, 1)
    function e_fuel_weight:onChange(text)
        vdata.fuel_weight = U.unitEditBoxRestriction(fuel_weightEditBox, panel_loadout.vdata.fuel, vdata.fuel_weight_max+ panel_loadout.vdata.fuel)
        vdata.unit.payload.fuel = vdata.fuel_weight - panel_loadout.vdata.fuel
        
        vdata.fuel = math.floor(0.5 + 100 * (vdata.fuel_weight - panel_loadout.vdata.fuel) / vdata.fuel_weight_max)
        sl_fuel:setValue(vdata.fuel)
        e_fuel:setText(tostring(vdata.fuel))
        updateTotalWeight()
    end    

    -- Empty ---------------------------------------------
    e_empty = box.e_empty
    e_empty:setText(tostring(vdata.empty))
  
    local t_empty_unit = box.t_empty_unit
    empty_unitEditBox = U.createUnitEditBox(t_empty_unit, e_empty, U.weightUnits, 1)

    -- Weapons -------------------------------------------
    vdata.weapons = panel_loadout.vdata.weight
    e_weapons = box.e_weapons
    e_weapons:setText(tostring(vdata.weapons))
   
    local t_weapons_unit = box.t_weapons_unit

    weapons_unitEditBox = U.createUnitEditBox(t_weapons_unit, e_weapons, U.weightUnits, 1)
	
    -- Max-Total -----------------------------------------
    e_max = box.e_max
    e_max:setText(tostring(vdata.max),2)
    
    maxEditBox = U.createUnitEditBox(nil, e_max, U.weightUnits, 1)

    e_total = box.e_total
    e_total:setText(tostring(vdata.total))

    local t_total_unit = box.t_total_unit
    
    total_unitEditBox = U.createUnitEditBox(t_total_unit, e_total, U.weightUnits, 1)

    sl_total = box.sl_total
    sl_total:setValue(math.min(math.floor(0.5 + 100 * vdata.total / vdata.max), 100))
            
    e_total_prec = box.e_total_prec
    e_total_prec_skin = e_total_prec:getSkin()
    e_total_prec_skin_text = e_total_prec_skin.skinData.states.released[2].text
    e_total_prec_skin_text_color_default = e_total_prec_skin_text.color
    e_total_prec:setText(tostring(math.floor(0.5 + 100 * vdata.total / vdata.max)))
  
    local colorRed = '0xff0000ff'
    
	old_et_setText = e_total_prec.setText    
    
	function e_total_prec:setText(a_text)       	
		if (tonumber(a_text) > 100) then
            e_total_prec_skin_text.color = colorRed
		else
			e_total_prec_skin_text.color = e_total_prec_skin_text_color_default
		end
        
		e_total_prec:setSkin(e_total_prec_skin)
        old_et_setText(e_total_prec,a_text)
    end

    -- Данные должны соответствовать типу юнита, но в БД таких данных нет.
    sp_chaff = box.sp_chaff
    function sp_chaff:onChange()
        local unitDef = DB.unit_by_type[vdata.unit.type]
        local chaff = self:getValue()
        vdata.unit.payload.chaff = chaff

		if unitDef.passivCounterm ~= nil then
			local chaffSlots = chaff * unitDef.passivCounterm.chaff.chargeSz
			local flareSlots = vdata.unit.payload.flare * unitDef.passivCounterm.flare.chargeSz
			if unitDef.passivCounterm.SingleChargeTotal < chaffSlots + flareSlots then
				local flare = math.floor((unitDef.passivCounterm.SingleChargeTotal - chaffSlots) / 
					unitDef.passivCounterm.flare.chargeSz)
                flare = math.floor(flare/unitDef.passivCounterm.flare.increment)*unitDef.passivCounterm.flare.increment    
				sp_flare:setValue(flare)
				vdata.unit.payload.flare = flare
			end
		end
    end
    
    function sp_chaff_onFocus(self, focused, prevFocusedWidget)
        if not focused then
            local unitDef = DB.unit_by_type[vdata.unit.type]
            if unitDef.passivCounterm ~= nil then
                local chaff = self:getValue()
                chaff = math.floor(chaff/unitDef.passivCounterm.chaff.increment)*unitDef.passivCounterm.chaff.increment
                vdata.unit.payload.chaff = chaff
                self:setValue(chaff)
            end
        end
    end    
    sp_chaff:addFocusCallback(sp_chaff_onFocus)
	
    -- Данные должны соответствовать типу юнита, но в БД таких данных нет.
    sp_flare = box.sp_flare
    function sp_flare:onChange()
        local unitDef = DB.unit_by_type[vdata.unit.type]
        local flare = self:getValue()
        vdata.unit.payload.flare = flare
		
		if unitDef.passivCounterm ~= nil then
			local flareSlots = flare * unitDef.passivCounterm.flare.chargeSz
			local chaffSlots = vdata.unit.payload.chaff * unitDef.passivCounterm.chaff.chargeSz
			if unitDef.passivCounterm.SingleChargeTotal < chaffSlots + flareSlots then
				local chaff = math.floor((unitDef.passivCounterm.SingleChargeTotal - flareSlots) / 
					unitDef.passivCounterm.chaff.chargeSz)
                chaff = math.floor(chaff/unitDef.passivCounterm.chaff.increment)*unitDef.passivCounterm.chaff.increment    
				sp_chaff:setValue(chaff)
				vdata.unit.payload.chaff = chaff
			end
		end
    end
    
    function sp_flare_onFocus(self, focused, prevFocusedWidget)
        if not focused then
            local unitDef = DB.unit_by_type[vdata.unit.type]
            if unitDef.passivCounterm ~= nil then
                local flare = self:getValue()
                flare = math.floor(flare/unitDef.passivCounterm.flare.increment)*unitDef.passivCounterm.flare.increment
                vdata.unit.payload.flare = flare
                self:setValue(flare)
            end
        end
    end    
    sp_flare:addFocusCallback(sp_flare_onFocus)
    
    t_gun = box.t_gun
    
    -- Данные должны соответствовать типу юнита, но в БД таких данных нет.
    sp_gun = box.sp_gun
    function sp_gun:onChange()
        vdata.gun = self:getValue()
        vdata.unit.payload.gun = vdata.gun
        updateTotalWeight()
        weapons_unitEditBox:setValue(math.floor(0.5 + vdata.weapons + getAmmoWeight()))
    end
    
    t_gun_perc = box.t_gun_perc
	
	t_ammo_type = box.t_ammo_type
	
	c_ammo_type = box.c_ammo_type
    
    function c_ammo_type:onChange(self)
		vdata.unit.payload.ammo_type = getIndexAmmoType(self:getText())
    end
    

    pSetRope = box.pSetRope	 
    eRopeLength = pSetRope.eRopeLength
    sUnitRopeLength = pSetRope.sUnitRopeLength
    hsRopeLength = pSetRope.hsRopeLength
    
    eRopeLengthUnit = U.createUnitEditBox(sUnitRopeLength, eRopeLength, U.altitudeUnits, 0.1)

    -- Присвоение виджетам актуальных значений из таблицы vdata
    update()
end


function setHardpointRacks(a_flag)
    cb_bd:setState(a_flag)
    vdata.unit.hardpoint_racks = a_flag
	panel_loadout.updateArguments()
    update()
end

local function updateUnitSystem()
	local unitSystem = OptionsData.getUnits()
	
	fuel_weightEditBox:setUnitSystem(unitSystem)
    empty_unitEditBox:setUnitSystem(unitSystem)
    weapons_unitEditBox:setUnitSystem(unitSystem)
    total_unitEditBox:setUnitSystem(unitSystem)
    maxEditBox:setUnitSystem(unitSystem)
    eRopeLengthUnit:setUnitSystem(unitSystem)
end

-- Открытие/закрытие панели
function show(b)			
	window:setVisible(b)
		
    if b then        
        updateUnitSystem()
        update()        
    end
	
	UpdateManager.add(function()	
		panel_loadout.show(b)
	-- удаляем себя из UpdateManager
		return true
	end)
end

-- Сохранение данных в файле
function save(fName)
    local f = base.io.open(fName, 'w')
    if f then
        local s = S.new(f)
        s:serialize_simple('vdata', vdata)
        f:close()
    end
end

-- find and set default livery
function setDefaultLivery(unit)
    local oldLivery = unit.livery_id

    local group   = unit.boss
    local country = DB.country_by_id[group.boss.id]
	local schemes = loadLiveries.loadSchemes(DB.liveryEntryPoint(unit.type),country.ShortName)
    if not schemes then
        return
    end
    
    if #schemes > 0 then
        unit.livery_id = schemes[1].itemId
    else
        unit.livery_id = nil
    end

end


function updateData()
    vdata.weapons = panel_loadout.vdata.weight

    if vdata.unit then

		cb_civil:setVisible(true)						
		
		if (vdata.unit.civil_plane == true) then
			cb_civil:setState(true)
		else
			cb_civil:setState(false)
			vdata.unit.civil_plane = nil			
		end		
        
        local unitDef = DB.unit_by_type[vdata.unit.type]
        
        if unitDef.HardpointRacks_Edit == true then
            cb_bd:setVisible(true)
        else
            cb_bd:setVisible(false)
        end
        
        if unitDef.HardpointRacks_Edit == true then
            if vdata.unit.hardpoint_racks == nil then
                vdata.unit.hardpoint_racks = true
                cb_bd:setState(true)
            else
                cb_bd:setState(vdata.unit.hardpoint_racks)
            end                
        end
        
		local fuelWeight = panel_loadout.vdata.fuel
		
        vdata.fuel_weight = vdata.unit.payload.fuel + fuelWeight        
        vdata.fuel_weight_max = tonumber(unitDef.MaxFuelWeight)
        vdata.ammo_weight_max = tonumber(unitDef.AmmoWeight)
        
        t_gun:setVisible((not cb_civil:getState()) and (unitDef.Guns ~= nil))
		sp_gun:setVisible((not cb_civil:getState()) and (unitDef.Guns ~= nil))
		t_gun_perc:setVisible((not cb_civil:getState()) and (unitDef.Guns ~= nil))
        
        if nil == vdata.ammo_weight_max then
            vdata.ammo_weight_max = 0
        end
        
        vdata.max = unitDef.MaxTakeOffWeight
        if (vdata.fuel_weight - fuelWeight) > vdata.fuel_weight_max then
            vdata.fuel_weight = vdata.fuel_weight_max + fuelWeight
            vdata.unit.payload.fuel = math.floor(0.5 + vdata.fuel_weight_max * vdata.fuel /100)
        end
        vdata.fuel = math.floor(0.5 + 100 * (vdata.fuel_weight - fuelWeight) / vdata.fuel_weight_max)
        
        local weightDependent = panel_paramFM.getWeightDependentOfFuel(vdata.unit)  
        vdata.weightDependent = weightDependent * base.math.min(1.0, 0.1 + (vdata.fuel/100))  
        vdata.empty = unitDef.EmptyWeight + panel_paramFM.getWeight()
        
        if vdata.unit.hardpoint_racks == false then
            vdata.empty = vdata.empty - (unitDef.HardpointRacksWeight or 0)
        end
        
		if (vdata.unit.civil_plane == true) then  
			vdata.empty = unitDef.EmptyWeight - (unitDef.WeightLossForCivil or 0)
		end
        	
		sp_gun:setValue(vdata.unit.payload.gun)
        vdata.livery_id = vdata.unit.livery_id
        vdata.gun = vdata.unit.payload.gun
		
		if vdata.unit.civil_plane == true then
			vdata.unit.payload.chaff = 0
		end
		
        sp_chaff:setValue(vdata.unit.payload.chaff)
        sp_flare:setValue(vdata.unit.payload.flare)
		
		local chaffFlareEnabled = false
		local ChaffEnabled = true
		if unitDef.passivCounterm ~= nil then
			chaffFlareEnabled = unitDef.passivCounterm.CMDS_Edit == true 
			sp_chaff:setStep(unitDef.passivCounterm.chaff.increment)
			sp_flare:setStep(unitDef.passivCounterm.flare.increment)
			
			local maxChaff = unitDef.passivCounterm.SingleChargeTotal / unitDef.passivCounterm.chaff.chargeSz
			if unitDef.passivCounterm.chaff.maxCharges ~= nil and unitDef.passivCounterm.chaff.maxCharges < maxChaff then
				maxChaff = math.floor(unitDef.passivCounterm.chaff.maxCharges / unitDef.passivCounterm.chaff.increment) * unitDef.passivCounterm.chaff.increment
			end
			sp_chaff:setRange(0, maxChaff)
			local maxFlare = unitDef.passivCounterm.SingleChargeTotal / unitDef.passivCounterm.flare.chargeSz
			if unitDef.passivCounterm.flare.maxCharges ~= nil and unitDef.passivCounterm.flare.maxCharges < maxFlare then
				maxFlare = math.floor(unitDef.passivCounterm.flare.maxCharges / unitDef.passivCounterm.flare.increment) * unitDef.passivCounterm.flare.increment
			end
			sp_flare:setRange(0, maxFlare)
			
			if unitDef.passivCounterm.ChaffNoEdit ~= nil then
				ChaffEnabled = not (unitDef.passivCounterm.ChaffNoEdit == true)
			end
		end
		
        sp_flare:setEnabled(chaffFlareEnabled)
        sp_chaff:setEnabled(chaffFlareEnabled and ChaffEnabled and vdata.unit.civil_plane ~= true)

		local unit = DB.unit_by_type[vdata.unit.type]
		if (unit.ammo_type ~= nil) then
			vdata.ammo_type = unit.ammo_type
			U.fill_combo(c_ammo_type, unit.ammo_type)
			
			if (vdata.unit.payload.ammo_type ~= nil) then				
				c_ammo_type:setText(unit.ammo_type[vdata.unit.payload.ammo_type])
			else
				c_ammo_type:setText(unit.ammo_type[1])
				vdata.unit.payload.ammo_type = unit.ammo_type_default or 1
			end
			
			if vdata.unit.civil_plane ~= true then
				c_ammo_type:setVisible(true)
				t_ammo_type:setVisible(true)
			else
				c_ammo_type:setVisible(false)
				t_ammo_type:setVisible(false)
			end
		else
			vdata.unit.payload.ammo_type = nil
			c_ammo_type:setVisible(false)
			t_ammo_type:setVisible(false)
		end
    else
        sp_flare:setEnabled(false)
        sp_chaff:setEnabled(false)
    end
    if nil == vdata.gun then
        vdata.gun = 0
    end
    updateTotalWeight()
end

-- Обновление значений виджетов после изменения таблицы vdata
function update()
    updateData()
    
    sl_fuel:setValue(vdata.fuel)
    e_fuel:setText(tostring(vdata.fuel))
    
    fuel_weightEditBox:setValue(vdata.fuel_weight + vdata.weightDependent)
    empty_unitEditBox:setValue(vdata.empty)
    weapons_unitEditBox:setValue(math.floor(0.5 + vdata.weapons + getAmmoWeight()))
    maxEditBox:setValue(vdata.max)
	
	updateVisibleRope()   
    setPositionWidgets()
end

function setPositionWidgets()
    local offsetY = 329    
    if not vdata.unit then
        return
    end
    local unitDef = DB.unit_by_type[vdata.unit.type]
    
    if unitDef.Guns ~= nil then
        -- показываем пушку
        offsetY = 354     
    end
    
    if (unitDef.ammo_type ~= nil) then
        -- показываем тип патронов
        offsetY = 379  
    end

    if (vdata.group and vdata.group.type == 'helicopter') then
        -- показываем трос
        pSetRope:setPosition(10,offsetY)
    end
end

function updateVisibleRope()           
    if not (vdata.group and vdata.group.type == 'helicopter') then --проверку на вертолет
		pSetRope:setVisible(false)
		return
	end
	
	local unitDef = DB.unit_by_type[vdata.unit.type]
	if unitDef.helicopter_hook_pos then
		updateUnitSystem()

		function hsRopeLength:onChange()
			local ropeLength = self:getValue()            
			eRopeLengthUnit:setValue(range[ropeLength] or 5)
			vdata.unit.ropeLength = range[ropeLength]
		end
		
		pSetRope:setVisible(true)
		local ropeLength = vdata.unit.ropeLength or 15
		vdata.unit.ropeLength = ropeLength
		eRopeLengthUnit:setValue(ropeLength)
		hsRopeLength:setRange(1, 6, 1)

		hsRopeLength:setValue(1)
		for k,v in base.ipairs(range) do
			if v == ropeLength then
				hsRopeLength:setValue(k)
			end
		end
    else
        pSetRope:setVisible(false)
		vdata.unit.ropeLength = nil
    end

end

-- возвращает юнит по его имени
function getUnitByName(unitName)
  local result = nil
  -- сначала ищем в самолетах
  for _tmp, unit in pairs(DB.db.Units.Planes.Plane) do
    if unitName == unit.Name then
      result = unit
      break
    end
  end
  
  if not result then
    -- если не нашли в самолетах, ищем в вертолетах
    for _tmp, unit in pairs(DB.db.Units.Helicopters.Helicopter) do
      if unitName == unit.Name then
        result = unit
        break
      end
    end    
  end
  
  return result
end

function getIndexAmmoType(type)
	if (vdata.ammo_type == nil) then
		base.print("ASSERT vdata.ammo_type == nil")
		return
	end
	for k, v in pairs(vdata.ammo_type) do
		if (type == v) then		
			return k
		end
	end
	return 1
end



