local base = _G

module('me_aircraft')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local print = base.print
local table = base.table
local string = base.string
local tonumber = base.tonumber
local tostring = base.tostring
local assert = base.assert
local math = base.math

-- Модули LuaGUI
local ListBoxItem				= require('ListBoxItem')
local MsgWindow					= require('MsgWindow')
local DialogLoader				= require('DialogLoader')
local CoalitionController		= require('Mission.CoalitionController')
local MeSettings      			= require('MeSettings')

-- Модуль сериализации таблицы
local S 						= require('Serializer')

-- Модули Black Shark
local U 						= require('me_utilities')	-- Утилиты создания типовых виджетов
local crutches 					= require('me_crutches')  -- temporary crutches
local MapWindow 				= require('me_map_window')
local i18n 						= require('i18n')
local tabs 						= require('me_tabs')
local DB 						= require('me_db_api')
local GroupVariant 				= require('GroupVariant')
local module_mission 			= require('me_mission')
local panel_route 				= require('me_route')
local panel_failures 			= require('me_failures')
local panel_payload 			= require('me_payload')
local panel_suppliers 			= require('me_suppliers')
local panel_triggered_actions 	= require('me_triggered_actions')
local panel_targeting 			= require('me_targeting')
local panel_summary 			= require('me_summary')
local panel_radio 				= require('me_panelRadio')
local panel_paramFM           	= require('me_paramFM')
local panel_dataCartridge 	  	= require('me_dataCartridge')
local panel_wpt_properties 		= require('me_wpt_properties')
local panel_loadout 			= require('me_loadout')
local toolbar 					= require('me_toolbar')
local panel_units_list			= require('me_units_list')
local panel_nav_target_fix_points = require('me_nav_target_fix_points')
local OptionsData				= require('Options.Data')
local panel_showId				= require('me_showId')
local panel_ship                = require('me_ship')
local panel_static			    = require('me_static')
local panel_vehicle			    = require('me_vehicle')
local mod_parking               = require('me_parking')
local UC				        = require('utils_common')
local CoalitionData				= require('Mission.CoalitionData')
local Skin              		= require('Skin')
local editorManager          	= require('me_editorManager')
local ProductType 				= require('me_ProductType') 
local TriggerZoneController		= require('Mission.TriggerZoneController')
local net               		= require('net')
local setCoordPanel 			= require('me_setCoordPanel')

local taskItemSkin
local defaultTaskItemSkin
local humanAircraftItemSkin
local playerItemSkin
local validFrequencyEditBoxSkin
local invalidFrequencyEditBoxSkin

i18n.setup(_M)


vdatas = { }

__views__ = {'helicopter', 'plane'}
__view__  = __views__[1]


	cdata = 
	{
		title = {
			[ __views__[1] ] = _('HELICOPTER GROUP'),
			[ __views__[2] ] = _('AIRPLANE GROUP'),
			},
		condition 			= _('CONDITION'),
		probability 		= _('%'),
		country 			= _('COUNTRY'), 
		name 				= _('NAME'),
		task 				= _('TASK'),
		nothing 			= _('Nothing'),
		unit 				= _('UNIT'), 
		unit_of 			= _('OF'),     
		type 				= _('TYPE'), 
		hidden 				= _('HIDDEN ON MAP'),
		hiddenOnPlanner 	= _('HIDDEN ON PLANNER'),
		uncontrolled 		= _('UNCONTROLLED'),
		hiddenOnMFD 		= _('HIDDEN ON MFD'),
		Password			= _('PASSWORD'),
		lateActivation 		= _('LATE ACTIVATION'),
		pilot 				= _('PILOT'),
		skill 				= _('SKILL'),
		onboard_num 		= _('ONBOARD'),
		callsign 			= _('CALLSIGN'),
        HEADING 			= _('HEADING'),
		Enable 				= _('Enable'),
		radio 				= _('RADIO'),
		FREQUENCY 			= _('FREQUENCY'),
		MHz 				= _('MHz'),
		invalidFreq 		= _('Invalid frequency'),
		error				= _('ERROR'),
		continue_question 	= _('Continue?'),
		ok					= _('OK'),
		cancel 				= _('CANCEL'),
		all		 			= _("ALL"),
		combat	 			= _("COMBAT"),
		uncontrollable 		= _('GAME MASTER ONLY'),
		msgEmbarking 		= _('Coalition change will alter the existing Embarking/Disembarking tasks.\nPlease check and fix them if Yes button is pressed.'),
		warning				= _('WARNING'), 
		yes					= _('YES'),
		no					= _('NO'),
		
		
		modulationName		= {
			[DB.MODULATION_AM] 			= _('AM'),
			[DB.MODULATION_FM]			= _('FM'),
		--	[DB.MODULATION_AM_AND_FM ] 	= _('AM/FM')
		},		
	}
    
    if ProductType.getType() == "LOFAC" then
        cdata.unit   = _("UNIT-LOFAC")
    end
	
	if base.__PRODUCT_ID__ == 2 then
        cdata.uncontrollable   = _("SUPERVISOR ONLY")
    end

	aiSkills 		= crutches.getSkillsNamesAir(false)
	local defaultAiSkill = aiSkills[3]
	humanSkills 	= crutches.getSkillsNamesAir(true)
	clientSkills 	= crutches.getSkillsNamesAir(false, true)   --(false, true) --включение в список Client
	defaultSkill 	= crutches.getDefaultSkillAir()

	countries = {}

	vdatas[ __views__[1] ] = {
		name 		= _('Rotary_g', 'Rotary').."-1",
		unit 		= {number = 1, cur = 1,},
		skills 		= {}, -- формируется из Units.Skills
		onboard_num	= '050',
		callsign 	= '501',
		communication = true,
		frequency	= 127.5,
		modulation 	= 1,
		radioSet = false
		}
	vdatas[__views__[2] ] = {
		name 		= _('Aerial_g', 'Aerial').."-1",
		unit 		= {number = 1, cur = 1,},
		skills 		= {}, -- формируется из Units.Skills
		onboard_num = '010',
		callsign 	= '100',
		communication = true,
		frequency	= 127.5,
		modulation 	= 1,
		radioSet = false
		}

	vdata 					= {}
	last_data				= {}
	last_data[__views__[1]] = {}
	last_data[__views__[2]] = {}
	skills					= {}
	--vdata = vdatas[__view__]

	selectionColor = {255/255, 240/255, 0/255, 1}

	curHumanControlledAircrafts = {} --список типов летательных аппаратов доступных для выбора в текушей панели
	
	local default_tasks = {} --задачи по умолчанию для каждого типа ЛА
	
-------------------------------------------------------------------------------
-- Создание и размещение виджетов
function create(x, y, w, h)
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_aircraft_group.dlg', cdata)
	window:setBounds(x, y, w, h)
	
	w_ = w

	local panelSkins = window.panelSkins
	
	taskItemSkin 				= window.c_task:getSkin().skinData.skins.listBox.skinData.skins.item
	defaultTaskItemSkin 		= panelSkins.listBoxItemDefaultTask:getSkin()
	humanAircraftItemSkin 		= panelSkins.listBoxItemHumanAircraft:getSkin()
	playerItemSkin 				= panelSkins.listBoxItemPlayerAircraft:getSkin()
	validFrequencyEditBoxSkin 	= window.e_frequency:getSkin()
	invalidFrequencyEditBoxSkin = panelSkins.editBoxInvalidFrequency:getSkin()	
	eNameWhiteSkin 				= panelSkins.eNameWhite:getSkin()
	eNameRedSkin 				= panelSkins.eNameRed:getSkin()

    -- Формирование данных по всем странам и задачам.
	createCountryTasksTable()

	setData(vdatas[__view__])

	createControls()

	local cx, cy, cw, ch = window:getClientRect()
  
	_tabs = tabs.createUnitTabs('aircraft', window, 0, ch - U.widget_h - 9)
	
	humanControlledAircrafts = DB.getHumanControlledAircrafts()

	clientControlledAircrafts = DB.getClientControlledAircrafts()
        
end

-------------------------------------------------------------------------------
-- Создание контролов панели
function createControls()
	-- Заголовок
	window:setText(cdata.title[__view__])
    
    btnShowId = DialogLoader.findWidgetByName(window, "btnShowId")
    
	function window:onClose()
		MapWindow.expand()
		onButtonClose()		
	end

    t_heading = window.t_heading
    sp_heading = window.sp_heading
    d_heading = window.d_heading
    
    t_heading:setVisible(false)
    sp_heading:setVisible(false)
    d_heading:setVisible(false)
    
    function sp_heading:onChange()
		local value = self:getValue()
		
		if value == -1 then
			value = 359
			self:setValue(value)
		elseif value == 360 then
			value = 0
			self:setValue(value)
		end
		
		vdata.group.units[vdata.unit.cur].heading = U.toRadians(value)
		vdata.lastHeading = U.toRadians(value)
		d_heading:setValue(value)
		updateHeading()
    end

    function d_heading:onChange()
		vdata.group.units[vdata.unit.cur].heading = U.toRadians(self:getValue())
		vdata.lastHeading = U.toRadians(self:getValue())
		sp_heading:setValue(base.math.floor(self:getValue()))
		updateHeading()
    end
    
	-- комбобокс со странами
	c_country = window.c_country
	
	-- поле редактирования Имени
	e_name = window.e_name

	--комбобокс Задач
	c_task = window.c_task
		   
	-- Spin текущего юнита
	sp_unit = window.sp_unit
	sp_unit:setRange(1, vdata.unit.number)
	sp_unit:setValue(vdata.unit.cur)

	-- Spin общего количества юнитов
	maxUnitCount = 4

	sp_of = window.sp_of
	sp_of:setRange(1, maxUnitCount)
	sp_of:setValue(vdata.unit.number)	  

	-- комбобокс Типов 
	c_type = window.c_type
	  
	-- поле редактирования Пилота
	e_pilot = window.e_pilot

	-- комбобокс Скилов
	c_skill = window.c_skill
	U.fill_combo(c_skill, humanSkills)
	c_skill:setText(defaultAiSkill)

	-- Поле редактирования бортового номера
	e_onboard_num = window.e_onboard_num

	-- надпись Callsign
	t_callsign = window.t_callsign

	-- поле редактирования позывного
	e_callsign = window.e_callsign
	c_callsign = window.c_callsign
	e_callsignGroupNum = window.e_callsignGroupNum
	e_callsignUnitNum = window.e_callsignUnitNum

	--чекбокс Comm
	commCheckBox = window.commCheckBox

	--поле редактирования частоты
	e_frequency = window.e_frequency
	e_frequency:setText(vdata.frequency)

	--modulation 
	clModulation = window.clModulation

	-- чекбокс "Скрыт на карте"
	hiddenCheckbox = window.hiddenCheckbox
	
	cbHiddenOnPlanner = window.cbHiddenOnPlanner
	
	-- чекбокс "hiddenOnMFD"
	cbHiddenOnMFD = window.cbHiddenOnMFD

	-- чекбокс "Неуправляем"
	uncontrolledCheckBox = window.uncontrolledCheckBox

	-- чекбокс "Поздняя активация"
	lateActivationCheckBox = window.lateActivationCheckBox

	-- условие появления 
	e_group_condition = window.e_group_condition

	-- вероятность появления 
	sp_probability = window.sp_probability
	
	cbPassword = window.cbPassword
	ePassword = window.ePassword

	groupVariant = GroupVariant.new(window)
	
	tbFilter = window.tbFilter
	tbFilter:setText(cdata.combat)
	
	cbUncontrollable = window.cbUncontrollable

	tbSetPos = window.tbSetPos
	
	if base.__PRODUCT_ID__ ~= 2 then
		tbSetPos:setVisible(false)
	end
	
	bindControls()
end


-------------------------------------------------------------------------------
--назначаем обработчики контролам
function bindControls()
	c_country.onChange 				= onComboCountry
	e_name.onChange 				= onEditName
	c_task.onChange 				= onComboTask
	sp_unit.onChange 				= onSpinUnit
	sp_of.onChange 					= onSpinUnitOf
	c_type.onChange 				= onComboType
	e_pilot.onChange 				= onEditPilot
	c_skill.onChange 				= onComboSkill
	e_onboard_num.onChange 			= onEditOnboardNumber
	e_callsign.onChange 			= onEditCallsign
	c_callsign.onChange 			= onComboCallsign
	e_callsignGroupNum.onChange 	= onComboGroupNumCallsign
	e_frequency.onChange 			= onEditFrequency
	commCheckBox.onChange 			= onCheckComm
	hiddenCheckbox.onChange 		= MapWindow.OnHiddenCheckboxChange
	cbHiddenOnPlanner.onChange 		= onChange_cbHiddenOnPlanner
	cbHiddenOnMFD.onChange 			= onChange_cbHiddenOnMFD
	uncontrolledCheckBox.onChange	= onUncontrolled
	lateActivationCheckBox.onChange = onLateActivation
	e_group_condition.onChange		= onCondition
	sp_probability.onChange			= onProbability
    btnShowId.onChange              = onChange_ShowId
	clModulation.onChange           = onChange_clModulation
	tbFilter.onChange           	= onChange_tbFilter
	cbUncontrollable.onChange 		= onChange_cbUncontrollable
	cbPassword.onChange 			= onChange_cbPassword
	ePassword.onChange 				= onChange_ePassword
	tbSetPos.onChange 				= onChange_tbSetPos
end

function onChange_cbUncontrollable(self)
	if vdata.group then
		vdata.group.uncontrollable = self:getState()
	end
end

function onChange_tbFilter(self)
	if (self:getState() == true) then
		self:setText(cdata.all)
	else
		self:setText(cdata.combat)
	end
	updateCountries()
	update()
end	
	
function onChange_clModulation()
	vdata.group.modulation = clModulation:getSelectedItem().modulation
	panel_radio.update()
	
	local frequency = tonumber(e_frequency:getText())
    panel_radio.setConnectFrequency(frequency, vdata.group.modulation)
end	

function onChange_ShowId()
    panel_showId.setGroup(vdata.group)
    panel_showId.show(true)
end
    
-------------------------------------------------------------------------------
--частота по умолчанию для разных типов ЛА

function getDefaultRadioFor(group)
	local firstUnit = group.units[1]
	local unitTypeDesc = DB.unit_by_type[firstUnit.type]
	local player = firstUnit.skill == crutches.getPlayerSkill() or firstUnit.skill == crutches.getClientSkill()
	return DB.getDefaultRadioFor(unitTypeDesc, player)
end

local function getDefaultRadio()
	if group ~= nil then
		return getDefaultRadioFor(vdata.group)
	else	
		local unitTypeDesc = DB.unit_by_type[vdata.type]
		local firstUnitSkill = vdata.skills[1]	
		local player = firstUnitSkill == crutches.getPlayerSkill() or firstUnitSkill == crutches.getClientSkill()
		return DB.getDefaultRadioFor(unitTypeDesc, player)
	end
end

-------------------------------------------------------------------------------
--словесные позывные для разных типов ЛА
local function getCallnames(a_id, a_type)
        return DB.db.getCallnames(a_id, a_type) or	
				DB.db.getUnitCallnames(a_id, DB.unit_by_type[a_type].attribute)
end

-------------------------------------------------------------------------------
--проверка соответствия позывных
function verifyCallnames(callname)
    local callnames
    if (vdata.group ~= nil) then
        callnames = getCallnames(vdata.group.boss.id, vdata.type)    
        for k, v in pairs(callnames) do
            if callname == v.Name then
                return true
            end
        end
    end
	return false
end

local function isEnableOnboardNum(a_country, a_onboard_num)	
	for _tmp1, type in ipairs({'plane', 'helicopter'}) do
		for _tmp2, group in ipairs(a_country[type].group) do
			for _tmp3, unit in ipairs(group.units) do	
				if (a_onboard_num == unit.onboard_num) then
					return true
				end
			end
		end
	end
	return false
end

-------------------------------------------------------------------------------
--получение нового бортового номера
function getNewOnboard_num(a_unit)
	local maxOnboard_num = 10	
	local group = a_unit.boss
	local curIndex = a_unit.index
	local newOnboard = nil
	local country = group.boss
	
	if curIndex > 1 then	
		local preUnit = group.units[curIndex-1]	
		if tonumber(preUnit.onboard_num) ~= nil then
			local tmpOnboard = tonumber(preUnit.onboard_num) + 1
			while(isEnableOnboardNum(country, string.format("%03d",tmpOnboard)) == true) do
				tmpOnboard = tmpOnboard + 1		
			end
			
			newOnboard = string.format("%03d",tmpOnboard)
		end
	end	
	
	if newOnboard == nil then

		while(isEnableOnboardNum(country, string.format("%03d",maxOnboard_num)) == true) do
			maxOnboard_num = maxOnboard_num + 1		
		end

		newOnboard = string.format("%03d",maxOnboard_num)
	end	

	return newOnboard
end

-------------------------------------------------------------------------------
-- Изменение позывного
function changeCallsign()
    local callsign, onboardNum = '', ''
    local countryName = c_country:getText() --vdata.group.boss
    local westernCountry = U.isWesternCountry(countryName)
    if vdata.group then
        callsign = vdata.group.units[vdata.unit.cur].callsign
        if westernCountry then -- новая страна западная
            if not isWesternCallsign(callsign) then -- старый позывной не западный, надо поменять на западный
                for i, unit in ipairs(vdata.group.units) do
                    local callsignName, groupId, unitId
                    callsign, callsignName, groupId, unitId = getNewCallsign(unit)
                    print('changing callsign from ' .. unit.callsign .. ' to ' .. callsign, vdata.unit.cur)
                    unit.callsign = callsign
                    if unit == vdata.group.units[vdata.unit.cur] then
                        c_callsign:setText(callsignName)
						e_callsignGroupNum:setText(groupId)
						e_callsignUnitNum:setText(unitId)
                    end
                end
			else
				local str = string.match(callsign, '%D+') or callsign
				if (verifyCallnames(str) == false) then
					callsign = getNewCallsign(vdata.group.units[1])
					str = string.match(callsign, '%D+') or callsign
							
					for i, unit in ipairs(vdata.group.units) do
						local callsignName, groupId, unitId
						callsign, callsignName, groupId, unitId = getNewCallsign(unit)
						unit.callsign = callsign
						if unit == vdata.group.units[vdata.unit.cur] then
							c_callsign:setText(callsignName)
							e_callsignGroupNum:setText(groupId)
							e_callsignUnitNum:setText(unitId)
						end
					end
				end
            end
        else -- новая страна восточная
            for i, unit in ipairs(vdata.group.units) do
                local callsignName, groupId, unitId
                callsign, callsignName, groupId, unitId = getNewCallsign(unit)
                unit.callsign = callsign
                if unit == vdata.group.units[vdata.unit.cur] then
                    e_callsign:setText(callsign)
                end
            end
        end
        c_callsign:setVisible(westernCountry)
        e_callsignGroupNum:setVisible(westernCountry)
        e_callsignUnitNum:setVisible(westernCountry)
        e_callsign:setVisible(not westernCountry)
    end
end

-------------------------------------------------------------------------------
--возвращает название текущего вида helicopter/plane
function getView()
    return __view__
end

-------------------------------------------------------------------------------
--установка вида helicopter/plane
function setView(view)
    if (view ~= 'helicopter') and (view ~= 'plane') then
        print('setView error: "' .. tostring(view or '') ..  '" only "helicopter" or "plane" allowed')
        assert(0)
    else
		vdata = {}
        vdata.country = editorManager.getNewGroupCountryName()
		setData(vdatas[view])
		_tabs:selectTab('route')
		vdata.unit.number = 1
		vdata.unit.cur = 1
	
		panel_route.setGroup(nil)
		panel_suppliers.setGroup(nil)
		panel_triggered_actions.setGroup(nil)
		panel_payload.vdata.group = nil
		panel_targeting.vdata.group = nil
		panel_summary.vdata.group = nil
		panel_route.show(true)
		setSafeMode(true)
		panel_route.setSafeMode(true)

        if __view__ ~= view then
            switchView(view)
        end
        
        if vdata.type and (vdata.skills[vdata.unit.cur] == crutches.getPlayerSkill()
             or vdata.skills[vdata.unit.cur] == crutches.getClientSkill()) then 
             
            local unitTypeDesc = DB.unit_by_type[vdata.type]            

			
			if (unitTypeDesc.Navpoint_Panel == true) or (unitTypeDesc.Fixpoint_Panel == true) then
				_tabs:showTab('navFixPoint')
			else
				_tabs:hideTab('navFixPoint')
			end

			if (isDataCartridge(unitTypeDesc)) then
				_tabs:showTab('dataCartridge')
			else
				_tabs:hideTab('dataCartridge')               
			end
        else
			_tabs:hideTab('navFixPoint')
			_tabs:hideTab('dataCartridge')  
        end

    end
end

-------------------------------------------------------------------------------
--смена вида helicopter/plane
function switchView(view)
    __view__ = view
    window:setText(cdata.title[__view__])

	vdata.type = nil

	createCountryTasksTable()
    fillCountries(true)
end

-------------------------------------------------------------------------------
-- append one array to another
function appendTable(res, new)
    for i, v in ipairs(new) do
        table.insert(res, v)
    end
end

-------------------------------------------------------------------------------
-- returns table which consists of all elements from both tables
function combineTables(t1, t2)
    local t = { }
    appendTable(t, t1)
    appendTable(t, t2)
    return t
end

-------------------------------------------------------------------------------
-- enabling / disabling frequency edit box
local function updateEnableFrequencyEditBox()
	if 	vdata.group and
		vdata.group.communication then
		local firstUnit = vdata.group.units[1]
		local unitType = firstUnit.type
		local unitTypeDesc = DB.unit_by_type[unitType]
		if firstUnit.skill == crutches.getPlayerSkill() or firstUnit.skill == crutches.getClientSkill() then
			assert(unitTypeDesc.HumanRadio ~= nil)
			if unitTypeDesc.HumanRadio.editable then
				e_frequency:setEnabled(true)
			else
				e_frequency:setEnabled(false)
			end
		else
			e_frequency:setEnabled(true)
		end
	else
		e_frequency:setEnabled(false)
	end
end


local function conditionInspectionFrequency(firstUnit, unitType)
    if  module_mission.mission.version < 10 then
        return (firstUnit.skill == crutches.getPlayerSkill() or firstUnit.skill == crutches.getClientSkill()) 
    else
        return true
    end
end

-------------------------------------
--проверка введенной частоты по диапазону допустимых значений для юнита данного типа
local function isFrequencyValid(group)
	if (group == nil) or (group.units == nil) or (group.units[1] == nil) then
		return true
	end
	local firstUnit = group.units[1]
	local unitType = firstUnit.type
	local unitTypeDesc = DB.unit_by_type[unitType]
    -- проверка частот для ботов отключена
 --   if conditionInspectionFrequency(firstUnit, unitType) then
 --   if (firstUnit.skill == crutches.getPlayerSkill() or firstUnit.skill == crutches.getClientSkill()) then
--		assert(unitTypeDesc.HumanRadio ~= nil)
		if unitTypeDesc.HumanRadio and unitTypeDesc.HumanRadio.editable then
            if (group.frequency) then
                if unitTypeDesc.HumanRadio.rangeFrequency then
                    local result = false
                    for k,v in base.pairs(unitTypeDesc.HumanRadio.rangeFrequency) do
                        if group.frequency >= v.min and group.frequency <= v.max then
                            result = true
                        end
                    end
                    return result
                else
                    return 	(unitTypeDesc.HumanRadio.minFrequency == nil or group.frequency >= unitTypeDesc.HumanRadio.minFrequency)
                            and
                            (unitTypeDesc.HumanRadio.maxFrequency == nil or group.frequency <= unitTypeDesc.HumanRadio.maxFrequency)
                end            
            else
                return false
            end
		else
			return true
		end
--	else
--		return true
--	end
end

local function fillModulationList(a_type)
	clModulation:clear()
	if a_type == DB.MODULATION_AM_AND_FM then
		local item = ListBoxItem.new(cdata.modulationName[DB.MODULATION_AM])
		item.modulation = DB.MODULATION_AM
		clModulation:insertItem(item)
		
		local item = ListBoxItem.new(cdata.modulationName[DB.MODULATION_FM])
		item.modulation = DB.MODULATION_FM
		clModulation:insertItem(item)
		clModulation:setEnabled(true)
	else
		local item = ListBoxItem.new(cdata.modulationName[a_type])
		item.modulation = a_type
		clModulation:insertItem(item)
		clModulation:setEnabled(false)
	end
	clModulation:selectItem(clModulation:getItem(0))
	if vdata.group then
		vdata.group.modulation = clModulation:getItem(0).modulation
	end
end

local function setModulationInComboList(a_modulation)
	if a_modulation ~= nil then
		for i=0, clModulation:getItemCount()-1 do
			local item = clModulation:getItem(i)
			if item and item.modulation == a_modulation then
				clModulation:selectItem(item)
				return true
			end
		end
	end
	return false
end

local function updateModulation(a_frequency)
	if vdata.group then
		local unitDef = DB.unit_by_type[vdata.type]
		if unitDef.HumanRadio and unitDef.HumanRadio.rangeFrequency then
			for k,v in base.pairs(unitDef.HumanRadio.rangeFrequency) do
				if v.modulation then
					if a_frequency >= v.min and a_frequency <= v.max then
						fillModulationList(v.modulation)	
					end
				else
					fillModulationList(DB.MODULATION_AM)	
				end
			end
		else
			fillModulationList(vdata.group.modulation)
		end
		setModulationInComboList(vdata.group.modulation)	
	end
end

-------------------------------------------------------------------------------
-- setting the default frequency for group
function setDefaultRadio(a_allDefault)
	if not vdata.radioSet or a_allDefault == true then
		local defaultFrequency, defaultModulation = getDefaultRadio()
		assert(defaultFrequency ~= nil)
		assert(defaultModulation ~= nil)
		vdata.frequency = defaultFrequency
		vdata.modulation = defaultModulation
		if vdata.group then
			vdata.group.frequency = defaultFrequency
			vdata.group.modulation = defaultModulation
		end	
		e_frequency:setText(vdata.frequency)
		--t_modulation:setText(cdata.modulationName[vdata.modulation])
		updateModulation(vdata.frequency)
	end
    
    if vdata.group then
        if isFrequencyValid(vdata.group) then
            e_frequency:setSkin(validFrequencyEditBoxSkin)
        else
            e_frequency:setSkin(invalidFrequencyEditBoxSkin)    
        end
	else
		e_frequency:setSkin(validFrequencyEditBoxSkin)
    end    
	updateEnableFrequencyEditBox()
end

-------------------------------------------------------------------------------
-- change type of all units
function changeType(type)
    vdata.type = type
	if updateAutoTask() then
		panel_route.onGroupTaskChange()
	end
    local unitDef = DB.unit_by_type[type]
    local maxFuel = unitDef.MaxFuelWeight

	if (vdata.group) then
        local oldType = vdata.group.units[1].type
		for i = 1, vdata.unit.number do
			local unit = vdata.group.units[i]
			unit.type = type
            
            if (humanControlledAircrafts[unit.type] == nil) and  (vdata.skills[i] == crutches.getPlayerSkill()) then
                vdata.skills[vdata.unit.cur] = defaultAiSkill
                unit.skill = vdata.skills[vdata.unit.cur]
            end                      
            
			-- Разгружаем пилоны
			unit.payload.pylons = {}
			unit.payload.fuel = maxFuel
			unit.payload.ammo_type = nil
			
            if oldType ~= type then
                local unitTypeDesc = DB.unit_by_type[type]
                if (unitTypeDesc.AddPropAircraft ~= nil) then
                    unit.AddPropAircraft = {}         
                    panel_loadout.update()    
                    panel_paramFM.setData(unitTypeDesc.AddPropAircraft, unit)
                else
                    unit.AddPropAircraft = nil 
                end 

				if (unitTypeDesc.dataCartridge ~= nil) then 
					unit.dataCartridge = {}  
                    panel_dataCartridge.setData(unit)
                else
                    unit.dataCartridge = nil 
                end			
            end
            
			--по просьбе авиаторов не доливаем P-51
			if (unitDef.defFuelRatio) then
                unit.payload.fuel = unitDef.defFuelRatio * maxFuel
			end
			panel_payload.setDefaultLivery(unit)
			
			panel_radio.createRadioForUnit(unit)
		end

		for k,v in pairs(vdata.group.units) do
			if (v.skill == crutches.getPlayerSkill()) then
				panel_failures.change_player_plane(false, type)
				if (panel_failures.isVisible() == true) then
					panel_failures.show(true)
				end
			end
		end
	
		module_mission.setDefaultChaffFlare(vdata.group)
		panel_route.applyTypeRestrictions(vdata.group)
		panel_route.vdata.unit = vdata.group.units[vdata.unit.cur]
	
		local wpt = panel_route.vdata.wpt
		if wpt.linkUnit then
			module_mission.relinkChildren(wpt.linkUnit, vdata.group)
		end
		
		-- переставляем ла при смене типа
		local wpt1 = vdata.group.route.points[1]
		if panel_route.isAirfieldWaypoint(wpt1.type) then
			panel_route.attractToAirfield(wpt1, vdata.group)
		end  

        panel_route.updateAltSpeed()
		panel_route.update()
		MapWindow.updateSelectedGroup(vdata.group)	  

        local unit = vdata.group.units[vdata.unit.cur]    
        if unit.Radio then
            if oldType ~= type then
                unit.Radio = nil
            end    
            
            if (unit.skill == crutches.getPlayerSkill() or unit.skill == crutches.getClientSkill()) then
                panel_radio.update()
            end
        end     
	end
	
	-- пилоны должны быть разгружены ДО вызова panel_loadout.update()
	verifySingleInFlight(type)
	
	panel_route.onUnitTypeChange()
    updateSkill()
	setDefaultRadio(true)
	updateCallsignControls()
end


-------------------------------------------------------------------------------
--Формирование данных по всем странам и задачам.
function createCountryTasksTable()
  -- Формирование данных по всем странам и задачам.
  -- список задач для страны с разбивкой по самолетам 
  -- country_task_aircraft_list[__view__][CountyName] = {taskName = {planeName, planeName, ...},
  --                                        taskName = {planeName, planeName, ...}}  
    country_task_aircraft_list = {} 
  
  -- список задач для страны country_tasks[CountyName] = {taskName, taskName, ...}
    country_tasks = {} 	
	countries = {}
	local countriesTmp = {}	
  
  -- по всем странам
	local defaultTaskName = DB.getDefaultTaskName()
	local Year = (module_mission.mission and module_mission.mission.date.Year) or 2018
	
	if (MeSettings.getShowEras() == true) then
		window:setText(cdata.title[__view__].." - "..Year)
	else
		window:setText(cdata.title[__view__])
	end

	for _tmp, country in pairs(DB.db.Countries) do	
		if country.hide ~= true then
			local countryTasks = {}
			local taskAircraftsList = {}
			
			-- по всем самолетам страны 
			local aircrafts
			if __view__ == 'helicopter' then 
				aircrafts = country.Units.Helicopters.Helicopter
			else
				aircrafts = country.Units.Planes.Plane
			end
		
			for _tmp, plane in pairs(aircrafts) do
			  local unit = DB.unit_by_type[plane.Name]
			  
			  -- по всем задачам самолета
			  if not unit then
				--print("check unit ",plane.CLSID,plane.Name)
			  else
					if not unit.DefaultTask  then
						base.error(unit.type..' has no default task!')
					end
				 
					default_tasks[unit.type] = unit.DefaultTask.Name
					
					local tmp_in, tmp_out = DB.db.getYearsLocal(unit.type, country.OldID)
					for _tmp, task in pairs(unit.Tasks) do 
						if ((MeSettings.getShowEras() ~= true))
							or ((vdata.group and vdata.group.units[1].type == unit.type) 
								or (MeSettings.getShowEras() == true and tmp_in<= Year and Year <= tmp_out)) then
							-- проверяем, существует ли уже такая задача в countryTasks
							if not U.findTableItemByName(countryTasks, task) then
							  table.insert(countryTasks, task.Name)
							end
										
							-- добавляем самолет в список задачи
							taskAircraftsList[task.Name] = taskAircraftsList[task.Name] or {}
							table.insert(taskAircraftsList[task.Name], {type = unit.type,in_service = tmp_in or 0, out_of_service = tmp_out or 40000})							
						end		
					end
					
					if ((MeSettings.getShowEras() ~= true))
							or ((vdata.group and vdata.group.units[1].type == unit.type) 
								or (MeSettings.getShowEras() == true and tmp_in<= Year and Year <= tmp_out)) then
						-- добавляем самолет в список дефолтной задачи	
						taskAircraftsList[defaultTaskName] = taskAircraftsList[defaultTaskName] or {}	
						if not U.findTableItemByName(taskAircraftsList[defaultTaskName], unit) then
						  table.insert(taskAircraftsList[defaultTaskName], {type = unit.type,in_service = tmp_in or 0, out_of_service = tmp_out or 40000})
						end
					end	
			  end
			end
			
			local function compTable(tab1, tab2)
				return tab1.type < tab2.type 
			end
			-- сортируем самолеты по именам
			for _tmp, u in pairs(taskAircraftsList) do
				base.table.sort(u,compTable)
			end
			
			if taskAircraftsList[defaultTaskName] ~= nil then
				countriesTmp[country.OldID] = country.Name					
				-- сортируем задачи по именам
				table.sort(countryTasks)
				-- добавляем дефолтную задачу на первое место
				table.insert(countryTasks, 1, defaultTaskName)
						
				country_tasks[__view__] = country_tasks[__view__] or {}
				country_task_aircraft_list[__view__] = country_task_aircraft_list[__view__] or {}
				country_tasks[__view__][country.Name] = countryTasks
				country_task_aircraft_list[__view__][country.Name] = taskAircraftsList
			end
		end	
	end
	
	if countriesTmp then
		local first, second, third 
		if base.__PRODUCT_ID__ ~= 2 then
			for k,v in base.pairs(countriesTmp) do
				if k == "Russia" then
					second = v
				elseif k == "USA" then
					first = v					
				else
					base.table.insert(countries, v)
				end
			end
		else
			for k,v in base.pairs(countriesTmp) do
				if k == "CJTF Red" then
					second = v
				elseif k == "CJTF Blue" then
					first = v
				elseif k == "UN" then
					third = v
				else
					base.table.insert(countries, v)
				end
			end
		end
		base.table.sort(countries)
		
		if third then
			base.table.insert(countries, 1, third)
		end	
		
		if second then
			base.table.insert(countries, 1, second)
		end	
		if first then		
			if ProductType.getType() ~= "LOFAC" then
				base.table.insert(countries, 1, first)
			else
				base.table.insert(countries, 2, first)
			end
		end
	end

end

-------------------------------------------------------------------------------
--закрытие окна
function close()
    panel_paramFM.show(false)
	panel_radio.show(false)
	panel_failures.show(false)
	panel_route.show(false)
    panel_wpt_properties.show(false)
	panel_loadout.show(false)
	panel_payload.show(false)
	panel_targeting.show(false)
	panel_summary.show(false)
	panel_triggered_actions.show(false)
	panel_nav_target_fix_points.show(false)
	panel_dataCartridge.show(false)
	MapWindow.setState(MapWindow.getPanState())
	show(false)
	toolbar.setAirplaneButtonState(false)
	panel_units_list.show(false)
	MapWindow.unselectAll()
end

-------------------------------------------------------------------------------
function setPlannerMission(planner_mission)
	if (planner_mission == true) then
		c_country:setEnabled(false)
		e_name:setEnabled(false)
		c_task:setEnabled(false)
		sp_of:setEnabled(false)
		c_type:setEnabled(false)
		c_skill:setEnabled(false)
		e_onboard_num:setEnabled(false)
		e_callsign:setEnabled(false)
		e_pilot:setEnabled(false)
		c_callsign:setEnabled(false)
		e_callsignGroupNum:setEnabled(false)
		e_callsignUnitNum:setEnabled(false)  
		hiddenCheckbox:setVisible(false)		
		lateActivationCheckBox:setVisible(false)
		cbHiddenOnPlanner:setVisible(false)
		cbHiddenOnMFD:setVisible(false)
		e_group_condition:setVisible(false)
		sp_probability:setVisible(false)
		cbPassword:setVisible(false)
		ePassword:setVisible(false)
	else
		c_country:setEnabled(true)
		e_name:setEnabled(true)
		c_task:setEnabled(true)
		c_type:setEnabled(true)
		c_skill:setEnabled(true)
		e_onboard_num:setEnabled(true)
		e_callsign:setEnabled(true)
		e_pilot:setEnabled(true)
		c_callsign:setEnabled(true)
		e_callsignGroupNum:setEnabled(true)
		e_callsignUnitNum:setEnabled(true)  
		hiddenCheckbox:setVisible(true)		
		cbHiddenOnMFD:setVisible(true)		
		lateActivationCheckBox:setVisible(true)
		cbHiddenOnPlanner:setVisible(true)
		e_group_condition:setVisible(true)
		sp_probability:setVisible(true)
		cbPassword:setVisible(true)
		ePassword:setVisible(true)
	end
	updateVisibleUncontrolled()
	updateVisibleUncontrollable()
end

function updateVisibleUncontrollable()
	if base.isPlannerMission() == true or vdata.group == nil then
		cbUncontrollable:setVisible(false) 
	else
		local bNotPlayer = true
		for k,v in base.pairs(vdata.group.units) do
			if v.skill == crutches.getPlayerSkill() or v.skill == crutches.getClientSkill() then
				bNotPlayer = false
			end
		end

		cbUncontrollable:setVisible(bNotPlayer) 
		if vdata.group and bNotPlayer == false then
			vdata.group.uncontrollable = false
		end
	end
end

function updateVisibleUncontrolled()
	if base.isPlannerMission() == true or vdata.group == nil then
		uncontrolledCheckBox:setVisible(false) 
	else
		local bBotUnits = false
		for k,v in base.pairs(vdata.group.units) do
			if v.skill ~= crutches.getPlayerSkill() and v.skill ~= crutches.getClientSkill() then
				bBotUnits = true
			end
		end
		local bVisible = (bBotUnits == true 
			and (vdata.group.route.points[1].type.type == panel_route.actions.takeoffParking.type)
				or vdata.group.route.points[1].type.type == panel_route.actions.takeoffGround.type)
		uncontrolledCheckBox:setVisible(bVisible)
		if vdata.group and bVisible == false then
			vdata.group.uncontrolled = false
		end
	end
end

-------------------------------------------------------------------------------
function setGroup(group)
	vdata.group = group
	groupVariant:initialize(vdata.group and vdata.group.variantProbability, 1)
end

-------------------------------------------------------------------------------
-- Открытие/закрытие панели
function show(b)
	setPlannerMission(base.isPlannerMission())

    if b == window:isVisible() then
        return
    end
		
	vdata.unit.cur = 1

	if b then	
		MapWindow.collapse(w_, 0)
		--setPlannerMission(base.isPlannerMission())
		updateCountries()	

		if vdata.group == nil then
			setDefaultAircraft()
		else		
			local selectedUnit_ = MapWindow.getSelectedUnit()
			if selectedUnit_ then
				for k,unit in base.pairs(vdata.group.units) do
					if unit.unitId == selectedUnit_.unitId then
						vdata.unit.cur = k
					end
				end
			end
		end
	
		groupVariant:initialize(vdata.group and vdata.group.variantProbability, 1)
		update()
		
		if not(vdata.group) then
			setDefaultRadio()
			commCheckBox:setState(vdata.communication)
			e_frequency:setEnabled(commCheckBox:getState())
		end
	else
		MapWindow.expand()
		local oldGroup = vdata.group	
		vdata.group = nil	-- Во избежание нежелательной связи с группой при следующем открытии.		
		if oldGroup then
			module_mission.remove_dataCartridge_map_objects(oldGroup) -- для очистки с карты точек dataCartridge
		end	
		panel_dataCartridge.setData(nil)
		panel_dataCartridge.show(false)
		panel_paramFM.show(false)
		panel_radio.show(false)
		panel_route.show(false)
		panel_wpt_properties.show(false)
		panel_loadout.show(false)
		panel_payload.show(false)
		panel_targeting.show(false)
		panel_summary.show(false)
		panel_triggered_actions.show(false)
		panel_nav_target_fix_points.show(false)
	end
	window:setVisible(b)
	window:setFocused(false)
end

-------------------------------------------------------------------------------
-- Загрузка данных из файла
function load(fName)
    base.dofile(fName)
    vdata = base.vdata
end

-------------------------------------------------------------------------------
-- Сохранение данных в файле
function save(fName)
    local f = base.io.open(fName, 'w')
    if f then
        local s = S.new(f)
        s:serialize_simple('vdata', vdata)
        f:close()
    end
end

-------------------------------------------------------------------------------
function getUnitType()
  return vdata.type
end

-------------------------------------------------------------------------------
function getUnitTaskName()
  return vdata.task
end

-------------------------------------------------------------------------------
function getUnitNumber()
  return vdata.unit.cur
end

-------------------------------------------------------------------------------
-- возвращает таблицу [номер пилона] = {CLSID = launcherCLSID}
function getUnitPylons()
  local pylons = {}
  
  if vdata.group then
    local unit = vdata.group.units[getUnitNumber()]
    if unit and unit.payload and unit.payload.pylons then
      pylons = unit.payload.pylons
    end
  end
  
  return pylons
end

-------------------------------------------------------------------------------
-- устанавливает подвеску на вертолете
-- таблица [pylonNumber] = launcherCLSID
function setUnitPayload(pylons, payloadName)
	if vdata.group then
		local unit = vdata.group.units[getUnitNumber()]
		
		local forcedPylons 
		local unit = base.panel_route.vdata.unit
		if unit.AddPropAircraft then
			local unitDef = DB.unit_by_type[unit.type]
			if unitDef.AddPropAircraft then
				for k,v in base.pairs(unitDef.AddPropAircraft) do 				
					for kk, vv in base.pairs(unit.AddPropAircraft) do
						if v.id == kk then
							if v.forcedPylons and v.forcedPylons[vv] then
								for kkk, vvv in base.pairs(v.forcedPylons[vv]) do
									forcedPylons = forcedPylons or {}
									forcedPylons[kkk] = vvv
								end
							end
						end
					end	
				end
			end		
		end
		
		unit.payload = unit.payload or {}
		unit.payload.name = payloadName
		unit.payload.pylons = {}
		for pylonNumber, v in pairs(pylons) do			
			unit.payload.pylons[pylonNumber] = {CLSID = v.CLSID, settings = v.settings}
		end
		
		if forcedPylons then
			for pylonNumber, v in base.pairs(forcedPylons) do
				unit.payload.pylons[pylonNumber] = {CLSID = v}
			end
		end
	end
end

function setForcedPylons(a_forcedPylons)
	if vdata.group then
		local unit = vdata.group.units[getUnitNumber()]
		unit.payload = unit.payload or {}
		unit.payload.pylons = unit.payload.pylons or {}
		for pylonNumber, v in pairs(a_forcedPylons) do
			unit.payload.pylons[pylonNumber] = {CLSID = v}
		end
	end
end

function fill_combo_types()
	c_type:clear()  

    for i, v in ipairs(country_task_aircraft_list[__view__][vdata.country][vdata.task]) do
        local item = ListBoxItem.new(v.type)
      
        item.index = i
        c_type:insertItem(item)
    end
end

-------------------------------------------------------------------------------
--смена страны
function changeCountry(c)
    vdata.country = c	
    fillTasksCombo(country_tasks[__view__][vdata.country])
    setTask()

	local isGroupCountryChange = false
	local isGroupCoalitionChange = false
    if vdata.group then
		isGroupCountryChange = vdata.group.boss.name ~= vdata.country
		local coalitionOld = CoalitionData.getCoalitionByContryId(DB.country_by_name[vdata.group.boss.name].WorldID)
		local coalitionNew = CoalitionData.getCoalitionByContryId(DB.country_by_name[vdata.country].WorldID)
		isGroupCoalitionChange = coalitionOld ~= coalitionNew
	
		if isGroupCountryChange then
			-- В связи со сменой страны нужно также поменять типы юнитов и цвет группы.
			-- В связи со сменой страны нужно также оставить в группе только умалчиваемые юниты страны.
			-- Исключаем группу из старой страны.
			for i,v in pairs(vdata.group.boss[__view__].group) do
				if v == vdata.group then
					table.remove(vdata.group.boss[__view__].group, i)
					break
				end
			end
			-- Включаем группу в новую страну.		
			for i,v in pairs(module_mission.mission.coalition) do
				local boss = vdata.group.boss
				for j,u in pairs(v.country) do
					if u.name == vdata.country then
						vdata.group.boss = u
						table.insert(u[__view__].group, vdata.group)
						-- Изменяем цвета объектов карты в группе
						vdata.group.color = u.boss.color
						break
					end
				end
				if vdata.group.boss ~= boss then
					break
				end
			end

			for i = 1, vdata.unit.number do
				local unit = vdata.group.units[i]
				panel_payload.setDefaultLivery(unit)
			end
			
			-- если у группы первой точкой стоит взлет с полосы или стоянки, 
			-- то надо проверить на аэродроме чьей коалиции она находится
			local wpt = vdata.group.route.points[1]
			if panel_route.isAirfieldWaypoint(wpt.type) then
				panel_route.attractToAirfield(wpt, vdata.group)
			end  
		end 
    end
	fillAircraftsCombo()
	setType()
    if vdata.group == nil then
		setDefaultAircraft()
	end
    
    panel_payload.update()
	updateTask()
	updateType()
    fillSkillsList()
	fillComboCallsigns()
	updateCallsignControls()
    
    module_mission.updateTitleWaypoints(vdata.group)

	if isGroupCountryChange then
		panel_route.onGroupCountryChange(isGroupCoalitionChange)
	end
    verifyTabs()
	if vdata.group then
		panel_loadout.updateType()
	end
	
	if panel_loadout.getVisible() == true then		
		panel_loadout.update()
	end
end

-------------------------------------------------------------------------------
-- disable editing of unsafe elements
function setSafeMode(enable)
    local e = not enable

    sp_unit:setEnabled(e)
    sp_of:setEnabled(e)
    _tabs:setEnabled(e)
end

-------------------------------------------------------------------------------
--установка задачи
function setTask()
	for k,v in pairs(country_tasks[__view__][vdata.country]) do
		if (v == vdata.task) then
			return
		end
	end

	vdata.task = country_tasks[__view__][vdata.country][1]
    if vdata.group then
        if vdata.group.task ~= vdata.task then
            vdata.group.task = vdata.task
        end
    end
	return
end

-------------------------------------------------------------------------------
--установка типа ЛА
function setType()
	for k,v in pairs(country_task_aircraft_list[__view__][vdata.country][vdata.task]) do
		if last_data[__view__].type then
			if (v.type == last_data[__view__].type) then
				vdata.type = last_data[__view__].type
				return
			end	
		end
		if (v.type == vdata.type) then
			return
		end
	end

	changeType(country_task_aircraft_list[__view__][vdata.country][vdata.task][1].type)
	-- Разгружаем пилоны
	if vdata.group then
		for i,unit in pairs(vdata.group.units) do
			unit.payload.pylons = {}
		end
		panel_route.setWaypoint(vdata.group.route.points[1])
		panel_loadout.update()
        panel_targeting.update()
        panel_payload.update()
		panel_units_list.updateRow(vdata.group)
	end

	return
end

-------------------------------------------------------------------------------
-- check if unit can be played by human
function isPlayableUnit()
    if not vdata.group then
        return true
    else
        return (1 == vdata.unit.cur)
    end
end

-------------------------------------------------------------------------------
-- returns true if value exists in list
function isValueInList(list, value)
    for _tmp, v in ipairs(list) do
        if v == value then
            return true
        end
    end
    return false
end

-------------------------------------------------------------------------------
function isEnableSkill(skill)
	local res = false
	for k, v in pairs(skills) do
		if (v == skill) then
			res = true
		end
	end
	return res
end

-------------------------------------------------------------------------------
function isWesternCallsign(text)
	if base.type(text) == 'number' then 
		return false
	end
	return true
end

-------------------------------------------------------------------------------
function getNewCallsign(unit)
    local group = unit.boss
    local country = group.boss
    local callsigns = getUsedCountryCallsigns(country)

    local callsignBase = 100
    local westernCountry = U.isWesternCountry(country.name)
    if westernCountry then
        local groupId = 1
        local unitId
        for i,_unit in ipairs(group.units) do 
            if unit == _unit then 
                unitId = i
            end
        end
        if unitId == nil then 
            --print('error, can not determine unit number')
            unitId = #group.units + 1 -- юнит в процессе создания, он еще не включен в группу
        end
        if unitId == 1 then
            while true do
                for k,v in pairs(getCallnames(group.boss.id, unit.type)) do
                    local callsign = v.Name .. tostring(groupId) .. tostring(unitId)				
                    if callsigns[callsign] == nil then
                        --print('choosing new callsign "' .. callsign .. '"')
                        return callsign, v.Name, groupId, unitId
                    else
                        --print('callsign "' .. callsignName .. '" already present, skipping')                
                    end
                end
                groupId = groupId + 1
                if groupId > 9 then
                    print('error, can not create new callsign, groupId > 9')
                end
            end
        else
            local unitsCount = #group.units
            local callsignName
            if (base.type(group.units[1].callsign) ~= 'table') then
                callsignName = string.match(group.units[1].callsign, '%D+') or group.units[1].callsign
                groupId =  string.match(group.units[1].callsign, '%d') or ''
            else
                callsignName    = group.units[1].callsign.name
                groupId         = group.units[1].callsign[1]
            end    
            
            local callsign =  callsignName .. groupId .. tostring(unitId)
            return callsign, callsignName, groupId, unitId
        end
        print('error, can not create new callsign')        
    else
        table.sort(callsigns)
        
        if #callsigns > 1 then
            for i, callsign in ipairs(callsigns) do
                if callsign >= callsignBase then -- фильтруем неправильные позывные
                    if math.abs( (callsigns[i+1] or callsign) - callsign) > 1 then -- нашли дырку в номерах позывных
                        return callsign + 1
                    end
                end
            end
            return callsigns[#callsigns] +1
        else
            if #callsigns == 0 then -- позывных нет
                return callsignBase -- возвращаем первый возможный позывной
            else -- ровно один позывной
                return callsigns[1] + 1 -- возвращаем следующий номер
            end
        end
    end
end

-------------------------------------------------------------------------------
--при смене типа ЛА устанавливает задачу по умолчанию для нового типа ЛА, если она не менялась вручную
function updateAutoTask()
	if 	(vdata.group and not vdata.group.taskSelected)
		or (vdata.group == nil) then	
		vdata.task = default_tasks[vdata.type]    
		c_task:setText(vdata.task)
		if vdata.group then
			if vdata.group.task ~= vdata.task then
				vdata.group.task = vdata.task
				return true
			end
		end
	end
	return false
end

-------------------------------------------------------------------------------
--возвращает позывной соответствующий переданной стране
function getUsedCountryCallsigns(country)
    local callsigns = {}
    local westernCountry = U.isWesternCountry(country.name)
    if westernCountry then
        for _tmp1, type in ipairs({'plane', 'helicopter'}) do
			for _tmp2, group in ipairs(country[type].group) do
				for _tmp3, unit in ipairs(group.units) do
					if(unit.callsign) then
						callsigns[unit.callsign] = ( callsigns[unit.callsign] or 1) + 1
					end
				end
			end
        end
    else
        for _tmp1, type in ipairs(__views__) do
            for _tmp2, group in ipairs(country[type].group) do
                for _tmp3, unit in ipairs(group.units) do
                    local n = tonumber(unit.callsign)
				
                    if n then 
                        table.insert(callsigns, n)
                    end
                end
            end
        end
    end
    return callsigns
end

function isPlayerSkill(a_unit)
    return ((a_unit.skill == crutches.getPlayerSkill()) or (a_unit.skill == crutches.getClientSkill())) 
end

function isAddPropAircraft(unitTypeDesc)
    if (unitTypeDesc.AddPropAircraft ~= nil) then
        for k,v in base.pairs(unitTypeDesc.AddPropAircraft) do
            if v.playerOnly == nil or v.playerOnly ~= true then
                return true
            else
                if (isPlayerSkill(vdata.group.units[vdata.unit.cur])) then
                    return true
                end
            end   
        end
    end    
    return false
end

function isDataCartridge(unitTypeDesc)
    if (unitTypeDesc.dataCartridge ~= nil) then

                    return true

    end    
    return false
end

-------------------------------------------------------------------------------
--для самолета игрока отображаем кнопку вызывающую панель отказов
function verifyTabs()
    local selectedItem = c_type:getSelectedItem()
    if selectedItem == nil then
        return
    end
	local type = selectedItem.type 
	_tabs:hideTab('Radio')     
    
    if (vdata.group ~= nil) then
        local unitTypeDesc = DB.unit_by_type[vdata.group.units[vdata.unit.cur].type]
        if (isAddPropAircraft(unitTypeDesc)) then
            _tabs:showTab('paramFM')
            
            panel_loadout.update()
            panel_paramFM.setData(unitTypeDesc.AddPropAircraft, vdata.group.units[vdata.unit.cur])
        else
            if _tabs:getSelectedTab() == 'paramFM' then
                _tabs:selectTab('route')
            end
            _tabs:hideTab('paramFM')               
        end

		if (vdata.skills[vdata.unit.cur] == crutches.getPlayerSkill()
					or vdata.skills[vdata.unit.cur] == crutches.getClientSkill()) 
			and (isDataCartridge(unitTypeDesc)) then
			
            _tabs:showTab('dataCartridge')         
            panel_dataCartridge.setData(vdata.group.units[vdata.unit.cur])
        else
            if _tabs:getSelectedTab() == 'dataCartridge' then
                _tabs:selectTab('route')
            end
            _tabs:hideTab('dataCartridge')               
        end
    else
        _tabs:hideTab('paramFM')
    end        

	if (vdata.skills[vdata.unit.cur] == crutches.getPlayerSkill()
          or vdata.skills[vdata.unit.cur] == crutches.getClientSkill()) then
		   
		_tabs:showTab('failures')
	
		local unitTypeDesc
		if (vdata.group ~= nil) then
			unitTypeDesc = DB.unit_by_type[vdata.group.units[vdata.unit.cur].type]
			
			if (unitTypeDesc.Navpoint_Panel == true) or (unitTypeDesc.Fixpoint_Panel == true) then
				_tabs:showTab('navFixPoint')
			else
				_tabs:hideTab('navFixPoint')
			end

			if unitTypeDesc.Waypoint_Panel ~= nil and unitTypeDesc.Waypoint_Panel == true
				or unitTypeDesc.Waypoint_Custom_Panel == true then
				_tabs:showTab('waypoints')
			else
				_tabs:hideTab('waypoints')
				if  _tabs:getSelectedTab() == 'waypoints' then
					_tabs:selectTab('route')
				end
			end

			if _tabs:getSelectedTab() == 'waypoints' then
                panel_wpt_properties.update()   
            end  
            
            if (unitTypeDesc.panelRadio ~= nil)	then
                _tabs:showTab('Radio')
                panel_radio.update()
				
                -- синхронизируем частоту
                local frequency = tonumber(e_frequency:getText())
                
                if not frequency then
                    setDefaultRadio(true)
                    frequency = tonumber(e_frequency:getText())
                end	
                
                panel_radio.update()
				panel_radio.setConnectFrequency(frequency, vdata.group.modulation)
            else                    
                if _tabs:getSelectedTab() == 'Radio' then
                    _tabs:selectTab('route')
                end     
            end
        end    
		panel_failures.update()
	else		
		local selectedTab = _tabs:getSelectedTab()
	
		if 	selectedTab == 'failures' or 
			selectedTab == 'waypoints' or 
			selectedTab == 'Radio' then
		
			_tabs:selectTab('route')
		end
	
		_tabs:hideTab('failures')
        _tabs:hideTab('waypoints')
		_tabs:hideTab('navFixPoint')				
	end
	
	if (vdata.group ~= nil) then
		local needINUFixPoint = false
		local needNavTargetPoint = false
		local needPassword = false
		for k,unit in base.pairs(vdata.group.units) do			
			if (unit.skill == crutches.getPlayerSkill()
				or unit.skill == crutches.getClientSkill()) then
				local unitTypeDesc = DB.unit_by_type[unit.type]
				if (unitTypeDesc.Fixpoint_Panel == true) then
					needINUFixPoint = true
				end
				if (unitTypeDesc.Navpoint_Panel == true) then
					needNavTargetPoint = true
				end
				
				needPassword = true
			end	
		end
		
		if needPassword == true then
			cbPassword:setVisible(true)
			ePassword:setVisible(true)
		else
			vdata.group.password = nil 
			cbPassword:setState(false)
			ePassword:setText("")
			cbPassword:setVisible(false)
			ePassword:setVisible(false)
		end
		
		if needINUFixPoint ~= true then
			module_mission.remove_INUFixPoint_All(vdata.group)
			if  _tabs:getSelectedTab() == 'fixPoint' then
				_tabs:selectTab('route')
			end
		end	
		
		if needNavTargetPoint ~= true then
			module_mission.remove_NavTargetPoint_All(vdata.group)
			if  _tabs:getSelectedTab() == 'navFixPoint' then
				_tabs:selectTab('route')
			end
		end	
	else
		cbPassword:setVisible(false)
		ePassword:setVisible(false)
	end		
end



-------------------------------------------------------------------------------
--Установка самолета по умолчанию
function setDefaultAircraft()
	if (module_mission.isEnableAircraft()) then
		return
	end

	if (curHumanControlledAircrafts[1]) then
        vdata.type = curHumanControlledAircrafts[1]

        if updateAutoTask() then
            panel_route.onGroupTaskChange()
        end	
    else
      vdata.type = nil
	end
end

-------------------------------------------------------------------------------
--установка значений панели
function setData(a_data)
	U.copyTable(vdata, a_data)
end

-------------------------------------------------------------------------------
--			Заполнение контролов									         ---------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--Заполнение контрола позывных
function fillComboCallsigns()
	local callsigns ={}
    local tmp_cal
    if vdata.group then
        tmp_cal = getCallnames(vdata.group.boss.id, vdata.type)
    end
	if (tmp_cal ~= nil) then
		for k, v in pairs(tmp_cal) do
			table.insert(callsigns, v.Name)
		end
	
		U.fill_combo(c_callsign, callsigns)
        c_callsign:setText(callsigns[1])
	end
end

function changeEras()
	if updateCountries() == false then
		return false
	end	
	
	update()
	return true
end 

function updateCountries()
	if vdata.group == nil then
		vdata.country, vdata.coalition = editorManager.getNewGroupCountryName()
	end
	createCountryTasksTable()

	if #countries == 0 then
		panel_route.show(false)
		MsgWindow.warning(_("There are no units available for this criteria.\n              You are using historical mode."),  _('WARNING'), 'OK'):show()
		return false
	end
	
    fillCountries()

	updateCountry()
	updateSkill()

	return true
end

local function getNoNeutralsCountry()
	for k,v in base.pairs(countries) do
		if 'neutrals' ~= CoalitionData.getCoalitionByContryId(DB.country_by_name[v].WorldID) then
			return countries[k]
		end
	end
end

-------------------------------------------------------------------------------
--заполнение списка стран
function fillCountries(notChange)
	function getIndexCountry(countries, country)
		
		local index = 0
		for k, v in ipairs(countries) do
			if (v == country) then
				index = k
			end
		end
		return index
	end


	local function fill_combo_countries(combo, t)    
        combo:clear()  

		if not t then
			combo:setText("")
			return
		end 
		for i, v in ipairs(t) do
		    local item = ListBoxItem.new(v)
			
			local coalition = CoalitionData.getCoalitionByContryId(DB.country_by_name[v].WorldID)
			if  coalition == "red" then
				item:setSkin(Skin.listBoxItemCoalRedSkin())
				item.index = i
				combo:insertItem(item)
			elseif coalition == "blue" then
				item:setSkin(Skin.listBoxItemCoalBlueSkin())
				item.index = i
				combo:insertItem(item)
			elseif tbFilter:getState() == true 
				or (vdata.group and vdata.group.boss.name == v) then
				if base.__PRODUCT_ID__ ~= 2 then
					item:setSkin(Skin.listBoxItemCoalNeutralSkin())
				else
					item:setSkin(Skin.listBoxItemCoalGreenSkin())
				end	
				item.index = i
				combo:insertItem(item)
			end
		end
    end
	
	local function getCountryForCoalition(a_coalition)
		for k,v in base.pairs(countries) do
			if a_coalition == CoalitionData.getCoalitionByContryId(DB.country_by_name[v].WorldID) then
				return countries[k]
			end
		end
	end
	
	local needChangeCountry = false
	if #countries > 0 then
		fill_combo_countries(c_country, countries)
		if (vdata.country) then
			if (getIndexCountry(countries, vdata.country) > 0) then					
			else
				if vdata.coalition then
					vdata.country = getCountryForCoalition(vdata.coalition)	or getNoNeutralsCountry()
				else					
					vdata.country = getNoNeutralsCountry()
				end
				needChangeCountry = true
			end
		else
			vdata.country = getNoNeutralsCountry()
			needChangeCountry = true
		end
	else
		vdata.country = nil		
	end   
    
	if needChangeCountry and (not notChange) then
		changeCountry(vdata.country)
	end
end

-------------------------------------------------------------------------------
--заполнение списка задач
function fillTasksCombo(tasks)
	c_task:clear()
	
	if tasks then
		for _tmp, taskName in ipairs(tasks) do
			local item = ListBoxItem.new(taskName)
			item.WorldID = DB.getTaskWorldID(taskName)   
			c_task:insertItem(item)
		end
	end
end

-------------------------------------------------------------------------------
--заполнение списка самолетов
function fillAircraftsCombo()
	function fill_combo(combo, t)  
        combo:clear()  
        curHumanControlledAircrafts = {}
        
        if not t then
            combo:setText("")
            return
        end

        local num = 1
        
        for i, tbl in ipairs(t) do
            local DisplayName = DB.getDisplayNameByName(tbl.type)
            local item = ListBoxItem.new(DisplayName)
            item.type = tbl.type
            item.DisplayName = DisplayName
            item.index = i
            combo:insertItem(item)
          
            if humanControlledAircrafts[tbl.type] ~= nil then
                item:setSkin(humanAircraftItemSkin)
                curHumanControlledAircrafts[num] = tbl.type
                num = num + 1
            end
        end
    end

	if vdata.group and vdata.group.taskSelected then
		fill_combo(c_type, country_task_aircraft_list[__view__][vdata.country][vdata.task])
	else
		fill_combo(c_type, country_task_aircraft_list[__view__][vdata.country][DB.getDefaultTaskName()])
	end
end

-------------------------------------------------------------------------------
-- setup skills checkbox value
function fillSkillsList()
	function fill_combo(combo, t)    
        combo:clear()  
        if not t then
            combo:setText("")
            return
        end
        
        for i, text in ipairs(t) do
            local item = ListBoxItem.new(text)
            item.index = i
            combo:insertItem(item)
            
            if text == crutches.getPlayerSkill() then
              item:setSkin(playerItemSkin)
            end
        end
    end

	skills = {}

	if (1 == vdata.unit.cur) and (nil ~= humanControlledAircrafts[vdata.type]) then
		if (vdata.group ~= nil) then
			U.copyTable(skills, humanSkills)
		else
			U.copyTable(skills, clientSkills)
		end
	elseif (nil ~= clientControlledAircrafts[vdata.type]) then
		U.copyTable(skills, clientSkills)			
    else
        U.copyTable(skills, aiSkills)
    end	

    fill_combo(c_skill, skills)   
end

--обновление окна
function update()
	e_name:setSkin(eNameWhiteSkin)
	e_pilot:setSkin(eNameWhiteSkin)
	updateMisc() --обновление имени, пилота, пределов для номера самолета в звене 	
	updateCountry()

	local group = vdata.group

    if group then
        vdata.task = group.task
        hiddenCheckbox:setState(group.hidden)
		uncontrolledCheckBox:setState(group.uncontrolled)
		cbHiddenOnPlanner:setState(group.hiddenOnPlanner)	
		cbHiddenOnMFD:setState(group.hiddenOnMFD)	
		lateActivationCheckBox:setState(group.lateActivation)		
		e_group_condition:setEnabled(not group.lateActivation)
		sp_probability:setEnabled(not group.lateActivation)
		if not group.lateActivation then
			e_group_condition:setText(group.condition)
			sp_probability:setValue((group.probability or 1) * 100)
		end
		
		cbUncontrollable:setState(vdata.group.uncontrollable or false)
		
		if vdata.group.password ~= nil then
			cbPassword:setState(true)
			ePassword:setEnabled(true)	
			ePassword:setText("*****")	
		else
			cbPassword:setState(false)
			ePassword:setEnabled(false)	
			ePassword:setText("")
		end		
	
        vdata.radioSet = group.radioSet
		vdata.frequency = group.frequency or vdata.frequency
		vdata.modulation = group.modulation or vdata.modulation
                
        verifySingleInFlight(group.units[1].type)

        updatePlayerSkill(vdata.skills[vdata.unit.cur])
        panel_route.vdata.unit = group.units[vdata.unit.cur]
        panel_route.update()
		panel_loadout.updateType()
		
		updateModulation(vdata.frequency)
		
		if isFrequencyValid(vdata.group) and setModulationInComboList(vdata.group.modulation) == true then
			e_frequency:setSkin(validFrequencyEditBoxSkin)
		else
			e_frequency:setSkin(invalidFrequencyEditBoxSkin)    
		end
    end

	fillTasksCombo(country_tasks[__view__][vdata.country]) -- заполняем контрол задач
	updateTask()	-- обновляем контрол задач

	fillAircraftsCombo() -- заполняем контрол типов ЛА
	updateType()		-- обновляем контрол типов ЛА
	
	updateSkill()	    -- обновляем контрол скилов
	updatePilot()

	fillComboCallsigns()
	updateCallsignControls() -- обновляем контролы позывных
	panel_nav_target_fix_points.update()

	updateTaskComboBoxTheme()
	updateAutoTask()
	
	updateVisibleUncontrollable()

    updateHeadingWidgets()
    updateHeading()
	verifyTabs()		
end

function verifySingleInFlight(a_type)
    local unitDef = DB.unit_by_type[a_type]           
    if (unitDef.singleInFlight == true) then
        sp_of:setRange(1, 1) 
        sp_of:setValue(1)         
        onSpinUnitOf(sp_of)
    else
        sp_of:setRange(1, maxUnitCount) 
    end
    sp_of:setValue(vdata.unit.number)
end    
        
-------------------------------------------------------------------------------
--обновление цвета текста в списке задач: если задача ставится автоматом по типу ЛА - серый, если была выставлена вручную - черный
function updateTaskComboBoxTheme()
	local selectedItem = c_task:getSelectedItem()

	if vdata.group and vdata.group.taskSelected then
		selectedItem:setSkin(taskItemSkin)
	else
		selectedItem:setSkin(defaultTaskItemSkin)    
	end

	c_task:selectItem(selectedItem)
end

-------------------------------------------------------------------------------
--обновление имени, пилота, пределов для номера самолета в звене
function updateMisc()
	if vdata.group then
		e_name:setText(vdata.group.name) 
	else
		e_name:setText(module_mission.check_group_name(vdata.name)) 
	end
	sp_unit:setValue(vdata.unit.cur)
	sp_unit:setRange(1, vdata.unit.number)
	sp_of:setValue(vdata.unit.number) 		
end

-------------------------------------------------------------------------------
--обновление имени, пилота, пределов для номера самолета в звене
function updatePilot()
	if vdata.group then
		e_pilot:setText(vdata.group.units[vdata.unit.cur].name) 
	else
		e_pilot:setText(module_mission.getUnitName(e_name:getText())) 
	end
end

-------------------------------------------------------------------------------
--обновление типов ЛА
function updateType()
    local isEnable = false
    local isEnableLast = false
	if (vdata.skills[1] == crutches.getPlayerSkill()) then
		isEnable = true
	else
		for k, v in pairs(country_task_aircraft_list[__view__][vdata.country][vdata.task]) do
			if (v.type == vdata.type) then
				isEnable = true
			end   
            
            if (v.type == last_data[__view__].type) then
				isEnableLast = true
			end     
		end
	end
	
    if isEnable == false then
        vdata.type = nil
    end

	if (vdata.type == nil) then
		if (last_data[__view__].type ~= nil) and (isEnableLast == true) then
			vdata.type = last_data[__view__].type
		else
			vdata.type = country_task_aircraft_list[__view__][vdata.country][vdata.task][1].type
		end
	end    

    setTypeItem(vdata.type)
	last_data[__view__].type	 	= vdata.type
end

function setTypeItem(a_type)    
    local counter = c_type:getItemCount() - 1

    for i = 0, counter do
        local item = c_type:getItem(i)        
        if item.type == a_type then
            c_type:selectItem(item)
            break
        end
    end
end

-------------------------------------------------------------------------------
--обновление задач
function updateTask()
    if country_task_aircraft_list[__view__][vdata.country][vdata.task] == nil then
        vdata.task = nil
    end

	if (vdata.task == nil) then
		if (last_data[__view__].task ~= nil) and (country_task_aircraft_list[__view__][vdata.country][vdata.task] ~= nil) then
			vdata.task = last_data[__view__].task
		else
			vdata.task = country_tasks[getView()][vdata.country][1]
		end
	end

	c_task:setText(vdata.task)
	last_data[__view__].task	 	= vdata.task
end

-------------------------------------------------------------------------------
--обновление скила
function updateSkill()
	fillSkillsList()
	if (vdata.skills ~= nil) then
		if (vdata.skills[vdata.unit.cur] == nil) then
			if ((last_data[__view__].skill ~= nil) and (isEnableSkill(last_data.skill))) then 
				if ( last_data[__view__].skill ~= crutches.getPlayerSkill()) then
					vdata.skills[vdata.unit.cur] = last_data[__view__].skill 
				else
					vdata.skills[vdata.unit.cur] = defaultAiSkill
				end
			else
				vdata.skills[vdata.unit.cur] = defaultAiSkill
			end
		else
			if not(isEnableSkill(vdata.skills[vdata.unit.cur])) then
				vdata.skills[vdata.unit.cur] = defaultAiSkill
			end
		end
	end
  
    if vdata.group then
        vdata.group.units[vdata.unit.cur].skill = vdata.skills[vdata.unit.cur]
    end
    
	c_skill:setText(vdata.skills[vdata.unit.cur])
	last_data[__view__].skill = vdata.skills[vdata.unit.cur] 
	
	panel_units_list.updateBtnPlayerUnit()
end

-------------------------------------------------------------------------------
--обновление страны
function updateCountry()
    if (vdata.country == nil) then
        vdata.country = getNoNeutralsCountry()
    else
        local enableC = false
        for k,v in pairs(countries) do
            if (v == vdata.country) then
                enableC = true
            end
        end 
        if (enableC == false) then
            vdata.country = getNoNeutralsCountry()
        end
	end
	c_country:setText(vdata.country)
end

-------------------------------------------------------------------------------
--обновление позывных
function updateCallsignControls()
	local callsign, onboardNum = '', ''
    local countryName = vdata.country --vdata.group.boss
    local westernCountry = U.isWesternCountry(countryName)
    if vdata.group then
		local firstUnit = vdata.group.units[1]
		local numericPart = DB.db.doesCallsignHasNumericPart(vdata.group.boss.id, DB.unit_by_type[firstUnit.type].attribute)
	
		e_onboard_num:setText(vdata.group.units[vdata.unit.cur].onboard_num)
        panel_loadout.updateOnboardNumber(vdata.group.units[vdata.unit.cur].onboard_num)
		commCheckBox:setState(vdata.communication)
		commCheckBox:onChange()
		e_frequency:setText(vdata.frequency)
		--t_modulation:setText(cdata.modulationName[vdata.modulation])
		updateModulation(vdata.frequency)
	
        callsign = vdata.group.units[vdata.unit.cur].callsign
	
        if westernCountry then -- новая страна западная 
            local str = string.match(callsign, '%D+') or callsign          
            c_callsign:setText(str)
            e_callsignGroupNum:setText(string.match(callsign, '%d'))
            e_callsignUnitNum:setText(string.match(callsign, '%d$'))
        else -- новая страна восточная
            e_callsign:setText(callsign)
        end
	
		t_callsign:setVisible(true)
        c_callsign:setVisible(westernCountry)
        e_callsignGroupNum:setVisible(westernCountry and numericPart)
        e_callsignUnitNum:setVisible(westernCountry and numericPart)
        e_callsign:setVisible(not westernCountry)
	else
		t_callsign:setVisible(false)
		c_callsign:setVisible(false)
        e_callsignGroupNum:setVisible(false)
        e_callsignUnitNum:setVisible(false)
        e_callsign:setVisible(false)
    end
end

-------------------------------------------------------------------------------
--обновление при изменении самолета игрока
function updatePlayerSkill(skill)
    if vdata.group then
        if skill == crutches.getPlayerSkill() then 
            -- уже есть юнит со скилом игрока, надо сбросить скил этого юнита и поставить скил игрока новому юниту
            if module_mission.playerUnit then
                module_mission.playerUnit.skill = humanSkills[1]
                
                if (module_mission.playerUnit ~= vdata.group.units[vdata.unit.cur]) then
                    -- сбрасываем точки
                    module_mission.remove_INUFixPoint_All(module_mission.playerUnit.boss)
                    module_mission.remove_NavTargetPoint_All(module_mission.playerUnit.boss)
                end
            end
            module_mission.playerUnit = vdata.group.units[vdata.unit.cur]
        end
        vdata.group.units[vdata.unit.cur].skill = vdata.skills[vdata.unit.cur]
    end
end

function updateHeadingWidgets()
    if vdata.group and (vdata.group.route.points[1].type.action == 'From Ground Area'  or vdata.group.route.points[1].type.action == 'From Ground Area Hot') then
        t_heading:setVisible(true)
        sp_heading:setVisible(true)
        d_heading:setVisible(true)
    else
        t_heading:setVisible(false)
        sp_heading:setVisible(false)
        d_heading:setVisible(false)
    end
end


-------------------------------------------------------------------------------
--Обновление поворота юнита
function updateHeading()
    local heading = 0
    if vdata.group then
        if not (vdata.group.route.points[1].type.action == 'From Ground Area'  or vdata.group.route.points[1].type.action == 'From Ground Area Hot') then
            if (#vdata.group.route.points > 1) 
                and (vdata.group.route.points[1].airdromeId == nil)then
            
                local p1 = vdata.group.route.points[1]
                local p2 = vdata.group.route.points[2]
            
                if (p1.x == p2.x) and (p1.y == p2.y) then
                    heading = 0
                else
                    heading = MapWindow.getAngle(p1, p2) 			
                end
        
                for k,v in pairs(vdata.group.units) do
                    v.heading = heading
                end
            else
                for k,v in pairs(vdata.group.units) do
                    v.heading = v.heading or 0
                end
            end
        else
            local degrees = UC.toDegrees(vdata.group.units[vdata.unit.cur].heading)   
            sp_heading:setValue(degrees);
            d_heading:setValue(degrees);
        end
        
		for k,unitObj in pairs(vdata.group.mapObjects.units) do
			if OptionsData.getIconsTheme() == 'russian' then	
				local unitMapObject = vdata.group.mapObjects.units[vdata.unit.cur]
				local classInfo = MapWindow.getClassifierObject(unitMapObject.classKey)
			
				if classInfo and classInfo.rotatable then					
					unitObj.angle = MapWindow.headingToAngle(vdata.group.units[k].heading) -- в объектах карты храним все в градусах
				
					if k == 1 then
						vdata.group.mapObjects.route.points[1].angle = MapWindow.headingToAngle(vdata.group.units[1].heading)												
					end									
				end
			end
			
			if unitObj.picModel then
				unitObj.picModel:setOrientationEuler(MapWindow.headingToAngle(vdata.group.units[k].heading), 0, 0)
			end
			
			if vdata.group.units[k].linkChildrenTZone then
				for i,zoneId in ipairs(vdata.group.units[k].linkChildrenTZone) do	
					TriggerZoneController.updateHeading(zoneId)		
				end
			end	
		end

		module_mission.update_group_map_objects(vdata.group)
	end
end



-------------------------------------------------------------------------------
--			Обработка действий контролов									 ---------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--увеличение числа самолетов в группе
function onSpinUnitOf(self)
	local n = self:getValue()
	if n < vdata.unit.number then
		for i = vdata.unit.number, n + 1, -1 do
			table.remove(vdata.skills, i)
			if vdata.group then
				-- Нужно также удалить соответствующие юниты из миссии
				module_mission.remove_unit(vdata.group.units[i])
			end
		end
	elseif n > vdata.unit.number then
		local numAddAircrafts = n - vdata.unit.number
		local roadnet = nil
		local bAddUnit = true
		if (vdata.group.route.points[1].airdromeId) then
			roadnet = MapWindow.listAirdromes[vdata.group.route.points[1].airdromeId].roadnet		
			bAddUnit = (numAddAircrafts <= mod_parking.getFreeParkingForAircraft(vdata.group, roadnet))
		end
		
		if (vdata.group.route.points[1].helipadId) then	
			bAddUnit = true --(numAddAircrafts <= mod_parking.getFreeParkingOnHelipad(vdata.group, vdata.group.route.points[1].helipadId))
		end
		
		if bAddUnit then
			for i=vdata.unit.number+1,n do				
				vdata.skills[i] = getSkillNewUnit(vdata.skills[vdata.unit.cur])
				if vdata.group then
					-- Нужно также добавить соответствующие юниты в миссию
					local name = module_mission.getUnitName(vdata.group.name)
					local unit = module_mission.insert_unit(
							vdata.group, vdata.type, 
							vdata.skills[i], i, name)
					U.copyTable(unit.payload, vdata.group.units[vdata.unit.cur].payload)
					
					unit.livery_id = vdata.group.units[vdata.unit.cur].livery_id
					
					if vdata.group.units[vdata.unit.cur].Radio then
						setDataRadio(unit, vdata.group.units[vdata.unit.cur])
					else
						setDataRadio(unit, getClientParamsforCopy(i))						
					end
					
					if vdata.group.units[vdata.unit.cur].AddPropAircraft then
						setDataAddProp(unit, vdata.group.units[vdata.unit.cur])
					else
						setDataAddProp(unit, getClientParamsforCopy(i))
					end
					
					if vdata.group.units[vdata.unit.cur].dataCartridge then
						--setDataAddDataCartridge(unit, vdata.group.units[vdata.unit.cur])
					else
						--setDataAddDataCartridge(unit, getClientParamsforCopy(i))
					end
					
					if (panel_route.isTakeOffRunway(panel_route.vdata.group.route.points[1].type))
						or ((panel_route.isTakeOffParking(panel_route.vdata.group.route.points[1].type))
							and panel_route.vdata.group.route.points[1].helipadId) then					
						MapWindow.move_unit(vdata.group, unit, vdata.group.units[1].x, vdata.group.units[1].y)
					end
				end
			end
			if (panel_route.isTakeOffParking(panel_route.vdata.group.route.points[1].type))
				and panel_route.vdata.group.route.points[1].airdromeId then
			
				mod_parking.addUnitsInGroupOnAirport(vdata.group, roadnet, numAddAircrafts)
			end			
		else
			MsgWindow.warning(_('No parking for this aircraft.'),  _('WARNING'), 'OK'):show()
		
			n = vdata.unit.number
			self:setValue(n)
		end
	
	end

	vdata.unit.number = n
	vdata.unit.cur = vdata.unit.number
	sp_unit:setRange(1, vdata.unit.number)
	sp_unit:setValue(vdata.unit.cur)

	updateSkill()	    -- обновляем контрол скилов
	updatePilot()	
	updateCallsignControls() -- обновляем контролы позывных

    if vdata.group then
        local unit = vdata.group.units[vdata.unit.cur]
        panel_payload.vdata.unit = unit
        panel_route.vdata.unit = unit
    end

	panel_targeting.update()
	panel_loadout.update()
	panel_payload.update()
	panel_route.update()

	if vdata.group then
		panel_units_list.updateRow(vdata.group, vdata.group.units[vdata.unit.cur])
		for i=1,vdata.unit.number do
			vdata.group.mapObjects.units[i].currColor = vdata.group.boss.boss.selectGroupColor
		end
		vdata.group.mapObjects.route.points[1].currColor = vdata.group.boss.boss.selectGroupColor
		vdata.group.mapObjects.units[vdata.unit.cur].currColor = vdata.group.boss.boss.selectUnitColor
		module_mission.update_group_map_objects(vdata.group)
		updateCallsignControls()
	end

	verifyTabs()
	updateVisibleUncontrolled()
	updateVisibleUncontrollable()
end

-------------------------------------------------------------------------------
--переключение текущего самолета в группе
function onSpinUnit(self)
	vdata.unit.cur = self:getValue()
    local unit = vdata.group.units[vdata.unit.cur]

    if vdata.group then
        -- При переключении юнита нужно переключать и подсветку соответствующего объекта на карте
        for i=1,vdata.unit.number do
            vdata.group.mapObjects.units[i].currColor = vdata.group.boss.boss.selectGroupColor
        end
        vdata.group.mapObjects.units[vdata.unit.cur].currColor = vdata.group.boss.boss.selectUnitColor
        if vdata.unit.cur == 1 then
            vdata.group.mapObjects.route.points[1].currColor = vdata.group.boss.boss.selectUnitColor
        else
            vdata.group.mapObjects.route.points[1].currColor = vdata.group.boss.boss.selectGroupColor
        end
        module_mission.update_group_map_objects(vdata.group)
        local unit = vdata.group.units[vdata.unit.cur]
        panel_payload.vdata.unit = unit
        panel_route.vdata.unit = unit
        panel_route.update()
        panel_payload.update()
        updateCallsignControls()-- обновляем контролы позывных
		panel_units_list.updateRow(vdata.group, vdata.group.units[vdata.unit.cur])
    end
	
	panel_loadout.update() 
	updateSkill()	    -- обновляем контрол скилов
	updatePilot()	
    updateHeading()

    verifyTabs()
end

-------------------------------------------------------------------------------
--изменение имени
function onEditName(self)
    if vdata.group then
		if module_mission.isGroupFreeName(self:getText()) ~= true then
			self:setSkin(eNameRedSkin)
		else
			self:setSkin(eNameWhiteSkin)
		end
		vdata.name = module_mission.check_group_name(self:getText())
		module_mission.renameGroup(vdata.group, vdata.name)
		panel_units_list.updateGroup(vdata.group)
	else
		vdata.name = self:getText()
	end
end

-------------------------------------------------------------------------------
--изменение страны
function onComboCountry(self)
	if vdata.group then
		local coalitionOld = CoalitionData.getCoalitionByContryId(DB.country_by_name[vdata.group.boss.name].WorldID)
		local coalitionNew = CoalitionData.getCoalitionByContryId(DB.country_by_name[self:getText()].WorldID)

		if coalitionOld ~= coalitionNew and module_mission.checkEmbarkingTasks(vdata.group) then			
			msgWindowHandler_ = MsgWindow.warning(cdata.msgEmbarking, cdata.warning, cdata.yes, cdata.no)
			
			local resultMsg = false
			function msgWindowHandler_:onChange(buttonText)
				if (buttonText == cdata.yes) then				
					resultMsg = true
				end
			end

			msgWindowHandler_:show()
			
			if resultMsg == false then
				self:setText(vdata.country)
				return
			end
		end
	end

	panel_route.changeCountryGroup(vdata.group,DB.country_by_name[vdata.country].WorldID, DB.country_by_name[self:getText()].WorldID)
	vdata.country = self:getText()
	changeCountry(vdata.country)
	e_onboard_num:onChange()
	changeCallsign()
	updateCountry() 
	updateSkill()
    panel_route.update()
	MapWindow.updateHiddenSelectedGroup() 
end

-------------------------------------------------------------------------------
--изменение типа
function onComboType(self, item)
	if vdata.type == self:getSelectedItem().type  then
		return
	end
	vdata.type = self:getSelectedItem().type
    updateAutoTask()

	if vdata.group then
        for k,v in base.pairs(vdata.group.units) do
            v.payload.pylons = {}
        end
		changeType(vdata.type)
		changeCallsign()
		-- Пересоздаем объекты карты, поскольку изменились условные знаки.
		panel_payload.update()
		panel_loadout.update()       
	end
    
	update()
	if vdata.group then
		panel_units_list.updateRow(vdata.group)
	end
end

-------------------------------------------------------------------------------
--изменение бортового номера
function onEditOnboardNumber(self)
	local nm = self:getText()
	if vdata.group then
		vdata.group.units[vdata.unit.cur].onboard_num = nm
        panel_loadout.updateOnboardNumber(nm)
	end
end

function getCurOnboardNumber()
    if vdata.group then
        return vdata.group.units[vdata.unit.cur].onboard_num
    else
        return "0"
    end
end

function verify(group)
	return not isFrequencyValid(group) and _(cdata.invalidFreq)..' '..(group.frequency or "")..' '..cdata.MHz.."\n"
end

-------------------------------------------------------------------------------
--попытка закрыть окно
function onCloseAttempt(onCloseFunc)
	if 	panel_route.window:isVisible() and vdata.group ~= nil then		
		panel_route.onCloseAttempt()
		local routeVerifyResult = panel_route.verify(vdata.group.route, vdata.group.lateActivation)
		local groupVerifyResult = verify(vdata.group)
		local bBotUnits = false
		for k,v in base.pairs(vdata.group.units) do
			if v.skill ~= crutches.getPlayerSkill() and v.skill ~= crutches.getClientSkill() then
				bBotUnits = true
			end
		end
		
		local verifyResult = (bBotUnits == false) and (routeVerifyResult or groupVerifyResult) and (routeVerifyResult and routeVerifyResult..'\n' or '')..(groupVerifyResult or '')

		if verifyResult then
			local handler = MsgWindow.error(verifyResult..'\n'..cdata.continue_question, cdata.error, cdata.ok, cdata.cancel)
			local result = false
            function handler:onChange(buttonText)
                -- если не нажата кнопка OK, то окно me_aircraft не закроется
                if buttonText == cdata.ok then
                    onCloseFunc()
				else
					window:setVisible(true)
				end
				result = true
            end
            
			handler:show() 

			if not result then
				window:setVisible(true)
			end
			return false
		end
	end

	onCloseFunc()

	return true
end

-------------------------------------------------------------------------------
--закрытие окна
function onButtonClose(self)
	onCloseAttempt(function()
						close()
					end)
end

-------------------------------------------------------------------------------
--изменение задачи
function onComboTask(self)
	if vdata.group then
		vdata.group.taskSelected = true
		vdata.task = self:getText()
	else
		self:setText(vdata.task)
		return
	end

	updateTaskComboBoxTheme()
	fillAircraftsCombo()
	
    if vdata.group then
        vdata.group.task = vdata.task
        local changed = false
        -- Если тип юнита не соответствует новой задаче, то нужно выбрать умалчиваемый.
        for i,unit in pairs(vdata.group.units) do
            local found = false
            for j,aircraft in pairs(country_task_aircraft_list[__view__][vdata.country][vdata.task]) do
                if aircraft.type == unit.type then
                    found = true
                    break
                end
            end
            if not found then
                unit.type = country_task_aircraft_list[__view__][vdata.country][vdata.task][1].type
                unit.CLSID = DB.unit_by_type[unit.type].CLSID
				vdata.type = unit.type
                unit.Radio = nil
                changed = true
            end
        end
        if changed then
            -- Разгружаем пилоны
            for i,unit in pairs(vdata.group.units) do
                unit.payload.pylons = {}
            end
            -- Пересоздаем объекты карты, поскольку изменились условные знаки
            changeType(vdata.type)
        end
        
        panel_loadout.update()
        panel_targeting.update()
		verifyTabs()
    else
        vdata.type = country_task_aircraft_list[__view__][vdata.country][vdata.task][1].type
		updateAutoTask()
        setTypeItem(vdata.type)
    end

    fillSkillsList()
	updateType()
    changeCallsign()
	update()
    panel_payload.update()
	panel_route.onGroupTaskChange()
end

-------------------------------------------------------------------------------
--изменение пилота
function onEditPilot(self)
	local name = self:getText()
	if module_mission.isUnitFreeName(self:getText()) ~= true then
		self:setSkin(eNameRedSkin)
	else
		self:setSkin(eNameWhiteSkin)
	end
	local group = vdata.group
	if group then
		local unit = group.units[vdata.unit.cur]
		if unit then
			local newName = module_mission.check_unit_name(name)
			module_mission.renameUnit(unit, newName)
			name = newName
			panel_units_list.updateRow(vdata.group, vdata.group.units[vdata.unit.cur])
		end
		vdata.group.units[vdata.unit.cur].name = name
	end
	
end

-------------------------------------------------------------------------------
--изменение скила
function onComboSkill(self)
	local skill = self:getText()

	if((vdata.skills[vdata.unit.cur] == crutches.getPlayerSkill()) 
		and (skill ~= crutches.getPlayerSkill())) then
		panel_failures.reset()			 -- сбрасываем неисправности
    end   
    
    if (((vdata.skills[vdata.unit.cur] == crutches.getPlayerSkill()) 
            or  (vdata.skills[vdata.unit.cur] == crutches.getClientSkill()))
		and ((skill ~= crutches.getPlayerSkill())
            and (skill ~= crutches.getClientSkill()))) then
            
        if vdata.group then  
            --сбрасываем точки
            module_mission.remove_INUFixPoint_All(vdata.group.units[vdata.unit.cur].boss)
            module_mission.remove_NavTargetPoint_All(vdata.group.units[vdata.unit.cur].boss)
        end
        _tabs:selectTab('route')
	end

	vdata.skills[vdata.unit.cur] = skill
	updatePlayerSkill(skill) 

    local type = c_type:getSelectedItem().type 
	if (humanControlledAircrafts[type] ~= nil) and (skill == crutches.getPlayerSkill()) then
		panel_failures.change_player_plane(false)
	end

    if vdata.group then
        local unit = vdata.group.units[vdata.unit.cur]
        if unit.Radio then
            if (skill ~= crutches.getPlayerSkill() and skill ~= crutches.getClientSkill()) then
                unit.Radio = nil
            end    
        end
		
		if (skill == crutches.getPlayerSkill() or skill == crutches.getClientSkill()) then
			panel_radio.update()
			setDataRadio(vdata.group.units[vdata.unit.cur], getClientParamsforCopy(vdata.unit.cur))
			setDataAddProp(vdata.group.units[vdata.unit.cur], getClientParamsforCopy(vdata.unit.cur))
			--setDataAddDataCartridge(vdata.group.units[vdata.unit.cur], getClientParamsforCopy(vdata.unit.cur))
		end

    end

    updateSkill()
	
	verifyTabs()

	setDefaultRadio()
	updateVisibleUncontrolled()
	updateVisibleUncontrollable()
	panel_route.update()
end

function setDataAddProp(a_targetUnit, a_sourceUnit)
	if a_sourceUnit == nil or a_sourceUnit.AddPropAircraft == nil
		or a_targetUnit == nil then
		return
	end

	a_targetUnit.AddPropAircraft = {}
	base.U.recursiveCopyTable(a_targetUnit.AddPropAircraft, a_sourceUnit.AddPropAircraft)
end
--[[
function setDataAddDataCartridge(a_targetUnit, a_sourceUnit)
	if a_sourceUnit == nil or a_sourceUnit.AddPropAircraft == nil
		or a_targetUnit == nil then
		return
	end

	a_targetUnit.dataCartridge = {}
	base.U.recursiveCopyTable(a_targetUnit.dataCartridge, a_sourceUnit.dataCartridge)
end]]

function setDataRadio(a_targetUnit, a_sourceUnit)
	if a_sourceUnit == nil or a_sourceUnit.Radio == nil
		or a_targetUnit == nil then
		return
	end

	a_targetUnit.Radio = {}
	base.U.recursiveCopyTable(a_targetUnit.Radio, a_sourceUnit.Radio)
end

function getClientParamsforCopy(a_targetUnitIndex)

	if vdata.unit.cur and vdata.unit.cur ~= a_targetUnitIndex 
		and vdata.group.units[vdata.unit.cur]
		and (vdata.group.units[vdata.unit.cur].skill == crutches.getPlayerSkill() 
			or vdata.group.units[vdata.unit.cur].skill == crutches.getClientSkill())	then
		
		return vdata.group.units[vdata.unit.cur]
	end	
	

	for k, unit in base.ipairs(vdata.group.units) do
		if k ~= a_targetUnitIndex then
			if (unit.skill == crutches.getPlayerSkill() or unit.skill == crutches.getClientSkill()) then
				return unit
			end	
		end
	end
	
	return nil
end


-------------------------------------------------------------------------------
--изменение позывного
function onEditCallsign(self)
	local nm  = self:getText()

	if (string.len(nm) > 3) then
		local str = string.sub(nm,1,3)
		nm = str
		self:setText(nm)
	end

	if vdata.group then
		vdata.group.units[vdata.unit.cur].callsign = nm
	end
end

-------------------------------------------------------------------------------
--изменение номера группы в западном позывном
function onComboGroupNumCallsign(self)
	local nm  = self:getText()

	if (string.len(nm) > 3) then
		local str = string.sub(nm,1,3)
		nm = str
		self:setText(nm)
	end

	for k, unit in ipairs(vdata.group.units) do
        local callsign = unit.callsign
		print("callsign=",callsign)
        local newCallsign = c_callsign:getText()
							..e_callsignGroupNum:getText()
							..k
		print("newCallsign=",newCallsign)
        unit.callsign = newCallsign
    end
end

-------------------------------------------------------------------------------
--изменение позывного (комбобокса)
function onComboCallsign(self)
	local firstUnit = vdata.group.units[1]
	local text = self:getText()
    for k, unit in ipairs(vdata.group.units) do
        local callsign = unit.callsign
        local newCallsign = string.gsub(callsign, '%D+', text)
        unit.callsign = newCallsign
        if unit == vdata.group.units[vdata.unit.cur] then
            e_callsignGroupNum:setText(string.match(newCallsign, '%d')) 
            e_callsignUnitNum:setText(k)
        end
    end
end

-------------------------------------------------------------------------------
function onCheckComm(self)
	if vdata.group then
		vdata.group.communication = self:getState()
	end
	vdata.communication = self:getState()
	updateEnableFrequencyEditBox()
end

-------------------------------------------------------------------------------
function onUncontrolled(self)
	if vdata.group then
		vdata.group.uncontrolled = self:getState()
	end
end

-------------------------------------------------------------------------------
function onLateActivation(self)
	if vdata.group then
		vdata.group.lateActivation = self:getState()
		vdata.group.route.routeRelativeTOT = self:getState()
		panel_route.onLateActivationChanged()
		panel_summary.updateStartTime()
	end
end

-------------------------------------------------------------------------------
function onChange_cbHiddenOnPlanner(self)
	if vdata.group then
		vdata.group.hiddenOnPlanner = self:getState()
	end
end

-------------------------------------------------------------------------------
function onChange_cbPassword(self)
	if vdata.group then
		if self:getState() then
			ePassword:setEnabled(true)	
			ePassword:setText("")			
		else
			ePassword:setEnabled(false)	
			ePassword:setText("")
			vdata.group.password = nil
		end	
	end
end

-------------------------------------------------------------------------------
function onChange_ePassword(self)
	if vdata.group then
		vdata.group.password = net.hash_password(self:getText())
	end
end

function closeSetPosUnit()
	if vdata.group then
		MapWindow.setState(MapWindow.getPanState())
	else
		if __view__ == 'plane' then
			MapWindow.setState(MapWindow.getCreatingPlaneState())
		else
			MapWindow.setState(MapWindow.getCreatingHelicopterState())
		end
	end
end

function callback_setPosUnit(a_x, a_y)
	if a_x == nil then
		tbSetPos:setState(false)
		
		closeSetPosUnit()
		return
	end
	if vdata.group then
		if vdata.unit.cur > 1 then
			MapWindow.move_unit(vdata.group, vdata.group.units[vdata.unit.cur], a_x, a_y)
		else
			MapWindow.move_waypoint(vdata.group, 1, a_x, a_y, nil, true, true, nil)
		end	
	else
		if __view__ == 'plane' then
			MapWindow.createAircraft('plane', a_x, a_y)
		else
			MapWindow.createAircraft('helicopter', a_x, a_y)
		end
		MapWindow.bCreatedUnit = false
	end
end

-------------------------------------------------------------------------------
function onChange_tbSetPos(self)
	if self:getState() == true then
		setCoordPanel.show(true, callback_setPosUnit )
		MapWindow.setState(MapWindow.getPipetteState())	
	else
		closeSetPosUnit()
		setCoordPanel.hide()
	end
end

-------------------------------------------------------------------------------
function onChange_cbHiddenOnMFD(self)
	if vdata.group then
		vdata.group.hiddenOnMFD = self:getState()
	end
end

-------------------------------------------------------------------------------
function onProbability(self)
	if vdata.group then
		vdata.group.probability = self:getValue() / 100
	end
end

-------------------------------------------------------------------------------
function onCondition(self)
	if vdata.group then
		vdata.group.condition = self:getText()
	end
end

------------------------------------------
--изменение частоты
function onEditFrequency(self)
	local text = self:getText()
	local textNew = string.gsub(text, "-", "")

	if (textNew ~= text) then
		text = textNew
		self:setText(text)
	end

	local frequency = tonumber(text) or 0
  
	setFrequency(frequency)					
  
	if (vdata.group and vdata.group.units and vdata.unit 
		and (DB.unit_by_type[vdata.group.units[vdata.unit.cur].type].panelRadio ~= nil))	then
		panel_radio.update()
		panel_radio.setConnectFrequency(frequency, vdata.group.modulation)
	end
end

function getCurUnit()
    if vdata.group then 
        return vdata.group.units[vdata.unit.cur]
    end
    return nil
end

------------------------------------------
--скил для нового юнита
function getSkillNewUnit(skill)
    if (skill == crutches.getPlayerSkill()) then
        return defaultAiSkill
    end
    return skill
end    

------------------------------------------
--
function GetGroupName(a_type)
    if a_type == 'plane' then
        return vdatas[ __views__[2] ].name
    else
        return vdatas[ __views__[1] ].name
    end    
end



------------------------------------------
--
function setFrequency(a_frequency, a_modulation)
	vdata.frequency = a_frequency
	vdata.radioSet = true
  
	if vdata.group then
		vdata.group.frequency = a_frequency
		vdata.group.radioSet = true
		updateModulation(a_frequency)
		
		if a_modulation == nil or a_modulation == false then
			a_modulation = vdata.group.modulation
		end
		if isFrequencyValid(vdata.group) and setModulationInComboList(a_modulation) == true then
			e_frequency:setSkin(validFrequencyEditBoxSkin)
		else
			e_frequency:setSkin(invalidFrequencyEditBoxSkin)    
		end
	end
end

function isVisible()
    return window:isVisible()
end   
    
