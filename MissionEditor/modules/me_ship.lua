local base = _G

module('me_ship')

local require   = base.require
local ipairs    = base.ipairs
local next      = base.next

-- Модули LuaGUI
local DialogLoader = base.require('DialogLoader')

-- Модуль сериализации таблицы
local S 		= base.require('Serializer')

-- Модули Black Shark
local U 					= require('me_utilities')	-- Утилиты создания типовых виджетов
local UC				    = require('utils_common')
local MapWindow 			= require('me_map_window')
local crutches 				= require('me_crutches')  -- temporary crutches
local mod_tabs				= require('me_tabs')
local Mission 				= require('me_mission')
local i18n 					= require('i18n')
local GroupVariant			= require('GroupVariant')
local OptionsData			= require('Options.Data')
local CoalitionController	= require('Mission.CoalitionController')
local panel_showId			= require('me_showId')
local DB					= require('me_db_api')
local panel_aircraft	    = require('me_aircraft')
local panel_static			= require('me_static')
local panel_vehicle			= require('me_vehicle')
local ListBoxItem			= require('ListBoxItem')
local pPayload_vehicles		= require('me_payload_vehicles')
local UC				  	= require('utils_common')
local CoalitionData			= require('Mission.CoalitionData')
local MeSettings      		= require('MeSettings')
local MsgWindow				= require('MsgWindow')
local Skin              	= require('Skin')
local editorManager       	= require('me_editorManager')
local TheatreOfWarData  	= require('Mission.TheatreOfWarData')
local module_mission 		= require('me_mission')
local ProductType 			= require('me_ProductType') 
local textutil				= require('textutil')
local TriggerZoneController	= require('Mission.TriggerZoneController')
local setCoordPanel 		= require('me_setCoordPanel')

i18n.setup(_M)

vdata = { }

local country_ship_list
local cat_by_country = {}

cat = {}
cat['All'] 					= _('ALL_CAT', 'All')
cat['Carrier'] 				= _('CARRIER_CAT', 'Carrier')
cat['Battleship'] 			= _('BATTLESHIP_CAT', 'Battleship')
cat['Battlecruiser']		= _('BATTLECRUISER_CAT', 'Battlecruiser')
cat['Cruiser']				= _('CRUISER_CAT', 'Cruiser')
cat['Destroyer'] 			= _('DESTROYER_CAT', 'Destroyer')
cat['Frigate'] 				= _('FRIGATE_CAT', 'Frigate')
cat['Corvette and Patrol']	= _('CORVETTE AND PATROL_CAT', 'Corvette and patrol')
cat['Fast Attack Craft'] 	= _('FAST ATTACK CRAFT_CAT', 'Fast attack craft')
cat['Submarine'] 			= _('SUBMARINE_CAT', 'Submarine')
cat['Support'] 				= _('SUPPORT_CAT', 'Support')
cat['Civilian'] 			= _('CIVILIAN_CAT', 'Civilian')
cat['Amphibious Assault']	= _('AMPHIBIOUS ASSAULT_CAT', 'Amphibious assault')

tagsByCat = {}
tagsByCat['Carrier'] 				= {'Carrier'}
tagsByCat['Battleship'] 			= {'Battleship'}
tagsByCat['Battlecruiser'] 			= {'Battlecruiser'}
tagsByCat['Cruiser'] 				= {'Cruiser'}
tagsByCat['Destroyer']  			= {'Destroyer'}
tagsByCat['Frigate'] 	 			= {'Frigate'}
tagsByCat['Corvette and Patrol'] 	= {'Corvette and Patrol'}
tagsByCat['Fast Attack Craft'] 		= {'Fast Attack Craft'}
tagsByCat['Submarine'] 		 		= {'Submarine'}
tagsByCat['Support'] 			 	= {'Support'}
tagsByCat['Civilian'] 				= {'Civilian'}
tagsByCat['Amphibious Assault']		= {'Amphibious Assault'}
	
-------------------------------------------------------------------------------
--инициализация модуля
function initModule()
    -- Неизменные локализуемые данные (при необходимости, их можно будет вынести в отдельный файл,
    -- но IMHO удобнее видеть их прямо здесь, чтобы представлять себе структуру панели)
    cdata = 
    {
        title 				= _('NAVY GROUP'),
		condition 			= _('CONDITION'),
		probability 		= _('%'),		
        country 			= _('COUNTRY'), 
        name 				= _('NAME'),
        hidden 				= _('HIDDEN ON MAP'),
        lateActivation 		= _('LATE ACTIVATION'),
		hiddenOnPlanner 	= _('HIDDEN ON PLANNER'),
		hiddenOnMFD 		= _('HIDDEN ON MFD'),
        visibleBeforeStart 	= _('VISIBLE bef. ACTIVATION'),
        unit 				= _('UNIT'), 
        unit_of 			= _('OF'), 
        type 				= _('TYPE'), 
        unitName 			= _('UNIT NAME'),
        skill 				= _('SKILL'),
        skillList 			= crutches.getSkillsNames(false),
        heading 			= _('HEADING'),
        placeUnitOnSea 		= _('You are trying to place new ship on the land.\
Please move ship group to allow new ship to be created on water'),
        unit1 = _('Unit #001'),
		uncontrollable 		= _('GAME MASTER ONLY'),
		frequency 			= _('FREQUENCY'),
		modulation			= _('MODULATION'),
		MHz					= _('MHz'),
		all		 			= _("ALL"),
		combat	 			= _("COMBAT"),
		category 			= _('CATEGORY'),
		warning				= _('WARNING'), 
		Insufficient		= _('Insufficient depth for the ship. Move to an appropriate depth?'),
		yes					= _('YES'),
		cancel				= _('CANCEL'),
    }
	
	if base.__PRODUCT_ID__ == 2 then
        cdata.uncontrollable   = _("SUPERVISOR ONLY")
    end
    
    if ProductType.getType() == "LOFAC" then
        cdata.unit1     = _("Unit #1-LOFAC")
        cdata.unitName  = _('UNIT NAME-LOFAC')
        cdata.unit      = _("UNIT-LOFAC")
    end

    -- Переменные загружаемые/сохраняемые данные (путь к файлу - cdata.vdata_file)
--  vdata.country 		= 'Russia'
--  vdata.countries 	= {'Russia', 'UK', 'Ukraine', 'USA',}
    vdata.name 			= _('Naval_g', 'Naval').."-1"
    vdata.unit 			= {number = 1, cur = 1}
    -- Далее для каждого юнита в группе
    vdata.types 		= {'Neustrashimy 11540 FFG (NEUSTRASHIMY Class Frigate)',}	-- Типы  должны соответствовать стране и задаче
    vdata.skills 		= { _('Average'), }
    vdata.lastHeading 	= 0
	
	SafeMode_ = true
end

initModule()

function fill_combo(combo, t)
    combo:clear()  

    for i, type in ipairs(t) do
        local DisplayName = DB.getDisplayNameByName(type)
        local item = ListBoxItem.new(DisplayName)
        item.type = type
        item.DisplayName = DisplayName
        item.index = i
        combo:insertItem(item)    
    end
end

local function verifyWarehouse(a_shipNew)
	if module_mission.isWarehouse(vdata.group.units[vdata.unit.cur].unitId) and (DB.isCarrier(a_shipNew) == false) then
		-- удаление склада
		module_mission.delWarehouse(vdata.group.units[vdata.unit.cur].unitId)  			
		--l_suppliers:clear()    
		MapWindow.setState(MapWindow.getPanState())
		base.panel_targeting.b_add:setState(false)
		if _tabs:getSelectedTab() == 'suppliers' then
			_tabs:selectTab('route')	
		end
	end
end

local function verifyWarehousesInGroup()
	for k,unit in base.pairs(vdata.group.units) do
		local shipNew = DB.ship_by_type[unit.type]
		if module_mission.isWarehouse(unit.unitId) and (DB.isCarrier(shipNew) == false) then
			-- удаление склада
			module_mission.delWarehouse(unit.unitId)  			 
		end
	end
end
			
function setTypeItem(a_type)   
    local counter = c_type:getItemCount() - 1
		
    for i = 0, counter do
        local item = c_type:getItem(i)
        if item.type == a_type then
            c_type:selectItem(item)	
			vdata.types[vdata.unit.cur] = item.type
			if vdata.group then
				local shipNew = DB.ship_by_type[item.type]				
				verifyWarehouse(shipNew)
			end
            break
        end
    end
end

-------------------------------------------------------------------------------
-- Создание и размещение виджетов
-- Префиксы названий виджетов: t - text, b - button, c - combo, sp - spin, sl - slider, e - edit, d - dial 
function create(x, y, w, h)
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_ship_group.dlg', cdata)
    window:setBounds(x, y, w, h)
	c_category = window.c_category
	c_category.onChange = onChangeCategory
	
	w_ = w
 
    btnShowId = DialogLoader.findWidgetByName(window, "btnShowId")
    btnShowId.onChange = onChange_ShowId
    
    function window:onClose()
		pPayload_vehicles.show(false)
        base.panel_paramFM.show(false)
        base.panel_radio.show(false)
        base.panel_route.show(false)
		base.panel_suppliers.show(false)
        base.panel_wpt_properties.show(false)
        base.panel_targeting.show(false)
        base.panel_summary.show(false)
        base.panel_triggered_actions.show(false)
        MapWindow.setState(MapWindow.getPanState())
        show(false)
        base.toolbar.setShipButtonState(false)
        base.panel_units_list.show(false)
        MapWindow.unselectAll()
		MapWindow.expand()		
    end
    
    -- Country
    c_country = window.c_country
    
    function c_country:onChange()
        -- Если у страны нет кораблей, то нельзя на нее переключаться
        local country = self:getText()
        if #vdata.countries == 0 then
            self:setText(vdata.country)
            return
        end

        changeCountry(country)
        if vdata.group then
            local unit =  vdata.group.units[vdata.unit.cur]
            module_mission.relinkChildren(unit)
        end
		validateWayPoints(vdata.group)
    end
        
    -- Name
    e_name = window.e_name
    e_name:setText(vdata.name)

    function e_name:onChange()
        vdata.name = module_mission.check_group_name(self:getText())
		if module_mission.isGroupFreeName(self:getText()) ~= true then
			self:setSkin(eNameRedSkin)
		else
			self:setSkin(eNameWhiteSkin)
		end		
        if vdata.group then
            module_mission.renameGroup(vdata.group, vdata.name)
			base.panel_units_list.updateGroup(vdata.group)
        end
    end

    sp_unit = window.sp_unit
    sp_unit:setRange(1,vdata.unit.number)
    sp_unit:setValue(vdata.unit.cur)

    function sp_unit:onChange()
        vdata.unit.cur = self:getValue()
        if vdata.group then
            for i=1,vdata.unit.number do
                vdata.group.mapObjects.units[i].currColor = vdata.group.boss.boss.selectGroupColor
            end
            vdata.group.mapObjects.units[vdata.unit.cur].currColor = vdata.group.boss.boss.selectUnitColor
            if vdata.unit.cur == 1 then
                vdata.group.mapObjects.route.points[1].currColor = vdata.group.boss.boss.selectUnitColor
            else
                vdata.group.mapObjects.route.points[1].currColor = vdata.group.boss.boss.selectGroupColor
            end;
            module_mission.update_group_map_objects(vdata.group)
            e_unit_name:setText(vdata.group.units[vdata.unit.cur].name)
            module_mission.updateHeading(vdata.group, vdata.unit.cur)
            base.panel_route.vdata.unit = vdata.group.units[vdata.unit.cur]
            base.panel_route.update()
			
			pPayload_vehicles.setUnit(vdata.group.units[vdata.unit.cur])
        end
        setTypeItem(vdata.types[vdata.unit.cur]) 
        c_skill:setText(vdata.skills[vdata.unit.cur]) 
		update()
		base.panel_suppliers.setGroup(vdata.group, vdata.group.units[vdata.unit.cur])
		base.panel_suppliers.resetFullInfo()
    end
        
    
    local maxUnitCount = 99
    sp_of = window.sp_of
    sp_of:setRange(1, maxUnitCount)
    sp_of:setValue(vdata.unit.number)

    function sp_of:onChange()
        local n = self:getValue()
        if n < vdata.unit.number then
            for i = vdata.unit.number, n+1, -1 do
                base.table.remove(vdata.types, i)
                base.table.remove(vdata.skills, i)
                if vdata.group then
                    -- Нужно также удалить соответствующие юниты из миссии
                    module_mission.remove_unit(vdata.group.units[i])
					_tabs:selectTab('route')
                end
            end
        elseif n > vdata.unit.number then
            for i=vdata.unit.number+1,n do
                if vdata.group then
                
                    -- TODO: исправить неведомые смещения
                    -- пусть будут 800 метров
                    local offset = 800
                    local x = vdata.group.x - offset * (i - 1)
                    local y = vdata.group.y + offset * (i - 1)
                    warningCallback = function ()
                        MapWindow.showWarningWindow(cdata.placeUnitOnSea)
                    end; 
                    local res = MapWindow.checkSurface(vdata.group, x, y, true, warningCallback);
                    if res == false then
                        local _n = n-1
                        if _n >= 1 then
                            self:setValue(_n)
                        end
                        return
                    end;                       
                    base.table.insert(vdata.types, vdata.types[vdata.unit.cur])
                    base.table.insert(vdata.skills, vdata.skills[vdata.unit.cur])
                    -- Нужно также добавить соответствующие юниты в миссию
					local name = module_mission.getUnitName(vdata.group.name)
                    module_mission.insert_unit(vdata.group, 
                            vdata.types[vdata.unit.cur], vdata.skills[vdata.unit.cur], i, name, 
                            x, y, 
                            vdata.group.units[vdata.unit.cur].heading)		
                end
            end
        end
        vdata.unit.number = n
        vdata.unit.cur = vdata.unit.number
        setTypeItem(vdata.types[vdata.unit.cur])
        if vdata.group then
            for i=1,vdata.unit.number do
                vdata.group.mapObjects.units[i].currColor = vdata.group.boss.boss.selectGroupColor
            end
            vdata.group.mapObjects.route.points[1].currColor = vdata.group.boss.boss.selectGroupColor
            vdata.group.mapObjects.units[vdata.unit.cur].currColor = vdata.group.boss.boss.selectUnitColor
            module_mission.update_group_map_objects(vdata.group)
                        e_unit_name:setText(vdata.group.units[vdata.unit.cur].name)
        end
        sp_unit:setRange(1, vdata.unit.number)
        sp_unit:setValue(vdata.unit.cur)
        
        c_skill:setText(vdata.skills[vdata.unit.cur]) 
        base.panel_route.vdata.unit = vdata.group.units[vdata.unit.cur]
        base.panel_route.update()
        base.panel_units_list.updateRow(vdata.group, vdata.group.units[vdata.unit.cur]);
		update()
		base.panel_suppliers.setGroup(vdata.group, vdata.group.units[vdata.unit.cur])
		base.panel_suppliers.resetFullInfo()
    end
        
    c_type = window.c_type
    c_type.onChange = onChangeType
	
	function validateWayPoints(a_group)
		local function isEnableSurfTypes(a_st, a_surfTypesGR)
			for k,v in base.pairs(a_surfTypesGR) do
				if a_st == v then
					return true
				end
			end
			return false
		end
	
		if a_group and a_group.route and a_group.route.points then	
			local surfTypes = {'sea', 'lake'}
			local minDepth = 0

			for k, unit in base.pairs(a_group.units) do
				local unitDef = DB.unit_by_type[unit.type]	
				if (unitDef.riverCraft ~= true) and surfTypes[2] ~= nil	then
					surfTypes[2] = nil
				end
				if unitDef.draft and ( minDepth < unitDef.draft) then
					minDepth = unitDef.draft
				end
			end
			
			for wptIndex, wpt in base.pairs(a_group.route.points) do
				if wptIndex == 1 then
					local result = true

					for k, unit in base.pairs(a_group.units) do
						result = result and MapWindow.checkSurfaceUnit(unit, unit.x, unit.y)
					end
					
					if MapWindow.isValidDepthGroup(a_group, wpt.x, wpt.y) == false then 
						result = false
					end

					if not result then
						local x, y = MapWindow.findValidStrikePoint(wpt.x, wpt.y, surfTypes, nil, minDepth) 	
						if x ~= nil and y ~= nil then
							local dx = x - a_group.units[1].x
							local dy = y - a_group.units[1].y
							MapWindow.move_waypoint(a_group, wptIndex, x, y, nil, nil, nil, true)
							for k,unit in base.pairs(a_group.units) do
								if k > 1 then
									local x, y = MapWindow.findValidStrikePoint(unit.x + dx, unit.y + dy, surfTypes, nil, minDepth) 
									MapWindow.move_unit(a_group, unit, x, y)
								end
							end
						end
					end
				else
					local surfaceType = MapWindow.getSurfaceType_(wpt.x, wpt.y)		
					if not isEnableSurfTypes(surfaceType, surfTypes) 
						or not MapWindow.isValidDepthGroup(a_group, wpt.x, wpt.y) then
						local x, y = MapWindow.findValidStrikePoint(wpt.x, wpt.y, surfTypes, nil, minDepth) 				
						MapWindow.move_waypoint(a_group, wptIndex, x, y, nil, nil, nil, true)
					end
				end
			end
		
		end
	end
        
    -- Unit name
    e_unit_name = window.e_unit_name
    function e_unit_name:onChange()
		if module_mission.isUnitFreeName(self:getText()) ~= true then
			self:setSkin(eNameRedSkin)
		else
			self:setSkin(eNameWhiteSkin)
		end
	
	
        local name = self:getText()
        local group = vdata.group
        if group then
            local unit = group.units[vdata.unit.cur]
			if unit then
				name = module_mission.check_unit_name(name)
				module_mission.renameUnit(unit, name) 
			end
        else
           -- vdata.names[1] = name
        end
    end
        
    -- Skill
    c_skill = window.c_skill
    U.fill_combo(c_skill, cdata.skillList)
    c_skill:setText(vdata.skills[vdata.unit.cur]) 
    
    function c_skill:onChange()
        vdata.skills[vdata.unit.cur] = self:getText()
        if vdata.group then
            vdata.group.units[vdata.unit.cur].skill = self:getText()
        end
    end

    -- Heading --------------------------------------------------------------
    t_heading = window.t_heading
    
    sp_heading = window.sp_heading
    
    function sp_heading:onChange()
		local value = self:getValue()
		
		if value == -1 then
			value = 359
			self:setValue(value)
		elseif value == 360 then
			value = 0
			self:setValue(value)
		end
      
	    setHeadingUnit(vdata.group.units[vdata.unit.cur], U.toRadians(value))
        vdata.lastHeading = U.toRadians(value)
        d_heading:setValue(value)
        updateHeading(vdata.group)
    end
    
    d_heading = window.d_heading

    function d_heading:onChange()
	    setHeadingUnit(vdata.group.units[vdata.unit.cur], U.toRadians(self:getValue()))
        vdata.lastHeading = U.toRadians(self:getValue())
        sp_heading:setValue(base.math.floor(self:getValue()))
        updateHeading(vdata.group)
    end
        
    hiddenCheckbox = window.hiddenCheckbox
    hiddenCheckbox.onChange = MapWindow.OnHiddenCheckboxChange
	
	cbHiddenOnPlanner = window.cbHiddenOnPlanner
	cbHiddenOnPlanner.onChange 		= onChange_cbHiddenOnPlanner
	
	cbHiddenOnMFD = window.cbHiddenOnMFD
	cbHiddenOnMFD.onChange 		= onChange_cbHiddenOnMFD
	
    lateActivationCheckbox = window.lateActivationCheckbox
    function lateActivationCheckbox:onChange()
		if vdata.group then
			vdata.group.lateActivation = self:getState()
			vdata.group.route.routeRelativeTOT = self:getState()
			base.panel_route.onLateActivationChanged()
			base.panel_summary.updateStartTime()
			e_group_condition:setEnabled(not vdata.group.lateActivation)
			sp_probability:setEnabled(not vdata.group.lateActivation)
		end
    end	

    visibleCheckbox = window.visibleCheckbox

    function visibleCheckbox:onChange()
        if vdata.group then
            vdata.group.visible = self:getState()
        else
            self:setState(false)
        end
    end

	e_group_condition = window.e_group_condition	
	function e_group_condition:onChange()
		if vdata.group then
			vdata.group.condition = self:getText()
		end
	end
	
    sp_probability = window.sp_probability
    function sp_probability:onChange()
		if vdata.group then
			vdata.group.probability = self:getValue() / 100
		end
    end
	
	cbUncontrollable = window.cbUncontrollable
	
	function cbUncontrollable:onChange()
		if vdata.group then
			vdata.group.uncontrollable = self:getState()
		end
	end
	
	groupVariant = GroupVariant.new(window)
        
    local cx, cy, cw, ch = window:getClientRect()
    
    _tabs = mod_tabs.createUnitTabs('ship', window, 0, ch - U.widget_h -9)
	
	sp_frequency = window.sp_frequency
	sp_frequency.onChange = function(self)
		if vdata.group then
			vdata.group.units[vdata.unit.cur].frequency = 1000000 * self:getValue()
		end
	end
	
	c_modulation = window.c_modulation
	
	local modulationTypeTable = {
		{name = _('AM'),	value = 0},
		{name = _('FM'),	value = 1}
	}

	U.fillComboList(c_modulation, modulationTypeTable)
	
	c_modulation.onChange = function(self, item)
		if vdata.group then
			vdata.group.units[vdata.unit.cur].modulation = item.itemId.value
		end
	end
	
	tbFilter = window.tbFilter
	tbFilter:setText(cdata.combat)	
	
	function tbFilter:onChange()
		if (self:getState() == true) then
			self:setText(cdata.all)
		else
			self:setText(cdata.combat)
		end
		updateCountries()
		update()
	end	
	
	panelSkins		= window.panelSkins
	eNameWhiteSkin	= panelSkins.eNameWhite:getSkin()
	eNameRedSkin 	= panelSkins.eNameRed:getSkin()
	
	tbSetPos = window.tbSetPos
	tbSetPos.onChange = onChange_tbSetPos
	
	if base.__PRODUCT_ID__ ~= 2 then
		tbSetPos:setVisible(false)
	end
end
	
function createCountryTable()
	vdata.countries = {}
    country_ship_list = {}
	cat_by_country = {}
	local countriesTmp = {}	
	
	local unitInGroup 
	if vdata.group then
		unitInGroup = {}
		for k,v in base.pairs(vdata.group.units) do
			unitInGroup[v.type] = v.type
		end
	end
	
	local Year = (Mission.mission and Mission.mission.date.Year) or 2018
	if (MeSettings.getShowEras() == true) then
		window:setText(cdata.title.." - "..Year)
	else
		window:setText(cdata.title)
	end
	
	local function compTable(type1, type2)
		local s1 = DB.getDisplayNameByName(type1)
		local s2 = DB.getDisplayNameByName(type2)
		if (base.type(s1) == 'string') and (base.type(s2) == 'string') then
			return textutil.Utf8Compare(s1, s2)
		end;
		return s1 < s2;       
	end
	local function compTableCats(idCat1, idCat2)
		if idCat1 == "All" then
			return true
		end
		if idCat2 == "All" then
			return false
		end
		return textutil.Utf8Compare(cat[idCat1], cat[idCat2])   
	end

    for i,country in base.pairs(DB.db.Countries) do	
		local w = {}
					
		country_ship_list[country.Name] = w			

		for j,unit in base.pairs(country.Units.Ships.Ship) do
			local tmp_in, tmp_out = DB.db.getYearsLocal(unit.Name, country.OldID)
			
			if not DB.unit_by_type[unit.Name] then 
				base.print("check unit ", unit.Name) 
			else
				if (MeSettings.getShowEras() ~= true)
							or ((unitInGroup and unitInGroup[unit.Name] ~= nil) 
								or (MeSettings.getShowEras() == true and tmp_in <= Year and Year <= tmp_out)) then
					local ship = DB.unit_by_type[unit.Name]	
					-- проверяем на неваду (террейн без моря)	
					if TheatreOfWarData.getName() ~= 'Nevada' or ship.riverCraft == true then
						local categories 
						
						if ship.tags then
							categories = DB.hasTags(ship.tags, tagsByCat)
						else
							base.print("--notags--",ship.type)
						end	
													
						--base.print("--categories--",ship.type,categories)
						if w['All'] == nil then
							w['All'] = {}	
							cat_by_country[country.Name] = cat_by_country[country.Name] or {}	
							base.table.insert(cat_by_country[country.Name],'All')
						end
						
						if categories then
							for k, category in base.ipairs(categories) do
								if w[category] == nil then
									w[category] = {}	
									base.table.insert(cat_by_country[country.Name],category)
								end
								base.table.insert(w[category], ship.type)								
							end
						end
						base.table.insert(w['All'], ship.type)
						countriesTmp[country.OldID] = country.Name	
					end
				end	
			end
		end

		for k,categories in base.pairs(cat_by_country) do
			base.table.sort(categories, compTableCats)
		end
		
		for k, listTypes in base.pairs(w) do
			base.table.sort(listTypes, compTable)
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
					base.table.insert(vdata.countries, v)
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
					base.table.insert(vdata.countries, v)
				end
			end
		end
		
		base.table.sort(vdata.countries)
		
		if third then
			base.table.insert(vdata.countries, 1, third)
		end	
		if second then
			base.table.insert(vdata.countries, 1, second)
		end	
		if first then
			base.table.insert(vdata.countries, 1, first)
		end
	end
	
	
end

function onChange_cbHiddenOnPlanner(self)
	if vdata.group then
		vdata.group.hiddenOnPlanner = self:getState()
	end
end

function onChange_cbHiddenOnMFD(self)
	if vdata.group then
		vdata.group.hiddenOnMFD = self:getState()
	end
end

function onChange_ShowId()
    panel_showId.setGroup(vdata.group)
    panel_showId.show(true)
end

-------------------------------------------------------------------------------
function setPlannerMission(planner_mission)
	if (planner_mission == true) then
		c_country:setEnabled(false)
		e_name:setEnabled(false)
		sp_of:setEnabled(false)
		c_type:setEnabled(false)
		e_unit_name:setEnabled(false)
		c_skill:setEnabled(false)
		sp_heading:setEnabled(false)
		d_heading:setEnabled(false)
		hiddenCheckbox:setVisible(false)
		lateActivationCheckbox:setVisible(false)
		cbHiddenOnPlanner:setVisible(false)
		cbHiddenOnMFD:setVisible(false)
		visibleCheckbox:setVisible(false)
		e_group_condition:setVisible(false)
		sp_probability:setVisible(false)
		cbUncontrollable:setEnabled(false)
	else
		c_country:setEnabled(true)
		e_name:setEnabled(true)
		c_type:setEnabled(true)
		e_unit_name:setEnabled(true)
		c_skill:setEnabled(true)		
		hiddenCheckbox:setVisible(true)
		lateActivationCheckbox:setVisible(true)
		cbHiddenOnPlanner:setVisible(true)
		cbHiddenOnMFD:setVisible(true)
		visibleCheckbox:setVisible(true)
		if (SafeMode_ == false) then
			sp_heading:setEnabled(true)
			d_heading:setEnabled(true)
		else
			sp_heading:setEnabled(false)
			d_heading:setEnabled(false)
		end
		e_group_condition:setVisible(true)
		sp_probability:setVisible(true)
		cbUncontrollable:setEnabled(true)
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
	window:setVisible(b)
	window:setFocused(false)
	
	if b then
		if updateCountries() then	
			MapWindow.collapse(w_, 0)
			groupVariant:initialize(vdata.group and vdata.group.variantProbability, 1)
		
			update() 				
		else
			window:close()
		end
	else
		MapWindow.expand()
		vdata.group = nil
	end  
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
--смена страны
function changeCountry(c)
	base.panel_route.changeCountryGroup(vdata.group, DB.country_by_name[vdata.country].WorldID, DB.country_by_name[c].WorldID)
	
    vdata.country = c
	fillCategory()
    updateType()
	local isGroupCountryChange = false
	local isGroupCoalitionChange = false
    if vdata.group then
		isGroupCountryChange = vdata.group.boss.name ~= vdata.country		
		if isGroupCountryChange then
			local coalitionOld = CoalitionData.getCoalitionByContryId(DB.country_by_name[vdata.group.boss.name].WorldID)
			local coalitionNew = CoalitionData.getCoalitionByContryId(DB.country_by_name[vdata.country].WorldID)
			isGroupCoalitionChange = coalitionOld ~= coalitionNew
			-- Удаляем группу из старой страны. 
			local tbl = vdata.group.boss.ship.group
			if tbl then
				for i,v in base.pairs(tbl) do
					if v == vdata.group then
						base.table.remove(tbl, i)
						break
					end
				end
			end
			module_mission.remove_group_map_objects(vdata.group)
			-- Помещаем группу в новую страну.
			local c = module_mission.missionCountry[vdata.country]
			base.table.insert(c.ship.group, vdata.group)
			vdata.group.boss = c
			-- Изменяем цвет объектов карты
			vdata.group.color = c.boss.color
			local category = c_category:getSelectedItem().itemId
			fill_combo(c_type, country_ship_list[vdata.country][category])
			-- В связи со сменой страны нужно также оставить в группе только умалчиваемые юниты страны.
			-- Если изменилась коалиция, то нужно отменить цели на маршруте.
			vdata.types = {}
			for i=1,#vdata.group.units do
				local unit = vdata.group.units[i]
				unit.type = country_ship_list[vdata.country][category][1]
				base.table.insert(vdata.types, unit.type)
			end

			setTypeItem(country_ship_list[vdata.country][category][1])
			
			verifyWarehousesInGroup()
			base.panel_route.vdata.unit = vdata.group.units[vdata.unit.cur]
			base.panel_route.update()
			base.panel_targeting.update()
			MapWindow.updateSelectedGroup(vdata.group)
			base.panel_units_list.updateRow(vdata.group, vdata.group.units[vdata.unit.cur])
			base.panel_route.onGroupCountryChange(isGroupCoalitionChange)
		end	
    end
	
	update()
	MapWindow.updateHiddenSelectedGroup()
end

-------------------------------------------------------------------------------
-- disable editing of unsafe elements
function setSafeMode(enable)
	SafeMode_ = enable
    local e = not enable

    sp_unit:setEnabled(e)
    sp_of:setEnabled(e)
    _tabs:setEnabled(e)
    sp_heading:setEnabled(e)
    d_heading:setEnabled(e)
end

-------------------------------------------------------------------------------
--обновление окна
function update()
	e_name:setSkin(eNameWhiteSkin)
	e_unit_name:setSkin(eNameWhiteSkin)

    c_country:setText(vdata.country)
    e_name:setText(vdata.name) 
    sp_unit:setValue(vdata.unit.cur)
    sp_unit:setRange(1,vdata.unit.number) 
    sp_of:setValue(vdata.unit.number)

    if vdata.group then
		if vdata.group then
			e_name:setText(vdata.group.name) 
		end
		
        if vdata.group.units[vdata.unit.cur].name then 
            e_unit_name:setText(vdata.group.units[vdata.unit.cur].name)
        else
            e_unit_name:setText('')
        end
        vdata.types = {}
        for i = 1, #vdata.group.units do
            base.table.insert(vdata.types, vdata.group.units[i].type)
        end
		cbUncontrollable:setState(vdata.group.uncontrollable or false)	
        hiddenCheckbox:setState(vdata.group.hidden)
		lateActivationCheckbox:setState(vdata.group.lateActivation)
		cbHiddenOnPlanner:setState(vdata.group.hiddenOnPlanner)	
		cbHiddenOnMFD:setState(vdata.group.hiddenOnMFD)	
		visibleCheckbox:setState(vdata.group.visible)
		e_group_condition:setEnabled(not vdata.group.lateActivation)
		e_group_condition:setText(vdata.group.condition)
		sp_probability:setEnabled(not vdata.group.lateActivation)
		sp_probability:setValue((vdata.group.probability or 1.0) * 100)
		if vdata.group.units[vdata.unit.cur].frequency == nil then
			local unitDef = DB.unit_by_type[vdata.group.units[vdata.unit.cur].type]  
			vdata.group.units[vdata.unit.cur].frequency = unitDef.frequency or 127500000
		end
		sp_frequency:setValue((vdata.group.units[vdata.unit.cur].frequency or 127500000)/1000000)
		if vdata.group.units[vdata.unit.cur].modulation == nil then
			vdata.group.units[vdata.unit.cur].modulation = 0
		end
		U.setComboBoxValue(c_modulation, vdata.group.units[vdata.unit.cur].modulation or 0)
        base.panel_route.vdata.unit = vdata.group.units[vdata.unit.cur]
		base.panel_route.updateAltSpeed()
        base.panel_route.update()
		updateHeading(vdata.group)
		
		pPayload_vehicles.setUnit(vdata.group.units[vdata.unit.cur])
	else
		e_name:setText(module_mission.check_group_name(vdata.name)) 
		e_unit_name:setText(module_mission.getUnitName(e_name:getText()))
    end
	
	local ship = DB.ship_by_type[vdata.types[vdata.unit.cur]]
	if ship and (DB.isCarrier(ship)) then
		_tabs:showTab('suppliers')
	else
		if _tabs:getSelectedTab() == 'suppliers' then
			_tabs:selectTab('route')
		end
		_tabs:hideTab('suppliers')
	end

    c_skill:setText(vdata.skills[vdata.unit.cur])
end

function changeEras()
	if updateCountries() == false then
		return false
	end	

	return true
end 

-------------------------------------------------------------------------------
--обновление окна
function updateCountries()
	function isCountry(a_country)
		for k, v in base.pairs(vdata.countries) do
			if (v == a_country) then
				return true
			end
		end
		return false
	end
	
	local function fill_combo_countries(combo, t)    
        combo:clear()  
		if not t then
			combo:setText("")
			return
		end 
		for i, v in ipairs(t) do
			if DB.country_by_name[v].hide ~= true then
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
    end
	
	local function getCountryForCoalition(a_coalition)
		for k,v in base.pairs(vdata.countries) do
			if a_coalition == CoalitionData.getCoalitionByContryId(DB.country_by_name[v].WorldID) then
				return vdata.countries[k]
			end
		end
	end
	
	if vdata.group == nil then
		vdata.country, vdata.coalition = editorManager.getNewGroupCountryName()
	end
	createCountryTable()
	vdata.category = nil
	
	if #vdata.countries > 0 then 
		fill_combo_countries(c_country, vdata.countries)
		if (vdata.country) then
			if (isCountry(vdata.country)) then					
			else
				if vdata.coalition then
					vdata.country = getCountryForCoalition(vdata.coalition)	or vdata.countries[1] 
				else
					vdata.country = vdata.countries[1] 
				end
			end
		else
			vdata.country = vdata.countries[1] 
		end
		fillCategory()
		updateType() 
	else
		vdata.country = nil
		base.panel_route.show(false)
		
		MsgWindow.warning(_("There are no units available for this criteria.\n              You are using historical mode."),  _('WARNING'), 'OK'):show()
		return false
	end
	return true
end

-------------------------------------------------------------------------------
--
function updateHeading(a_group)
    local heading = 0;
	
	sp_heading:setVisible(true);
	d_heading:setVisible(true);
	t_heading:setVisible(true);
	
    if a_group then
		if (#a_group.route.points > 1) then
			sp_heading:setVisible(false);
			d_heading:setVisible(false);
			t_heading:setVisible(false);
			local p1 = a_group.route.points[1];
			local p2 = a_group.route.points[2];

			if (p1.x == p2.x) and (p1.y == p2.y) then
				base.print('Waypoints equal!', p1.index, p2.index);
				heading = 0
			else
				heading = MapWindow.getAngle(p1, p2) 	
				if (heading < 0) then
					heading = heading + 2 * base.math.pi
				end
			end;
			
			for k, unit in base.pairs(a_group.units) do				
				setHeadingUnit(unit, heading)					
			end
		end
		
		if (window:getVisible() == true and vdata.unit.cur and a_group and a_group.units and a_group.units[vdata.unit.cur]) then
			sp_heading:setValue(UC.toDegrees(a_group.units[vdata.unit.cur].heading));
			d_heading:setValue(UC.toDegrees(a_group.units[vdata.unit.cur].heading));
		end
    end;
	
	if a_group then
		for k,unitObj in base.pairs(a_group.mapObjects.units) do
			local unitMapObject = a_group.mapObjects.units[k]
			local classInfo = MapWindow.getClassifierObject(unitMapObject.classKey)
	
			if classInfo and classInfo.rotatable and OptionsData.getIconsTheme() == 'russian' then	
				unitObj.angle = MapWindow.headingToAngle(a_group.units[k].heading) -- в объектах карты храним все в градусах
	  
				if k == 1 then
					a_group.mapObjects.route.points[1].angle = MapWindow.headingToAngle(a_group.units[1].heading)
				end
			end	
			
			if unitObj.picModel then
				unitObj.picModel:setOrientationEuler(MapWindow.headingToAngle(a_group.units[k].heading), 0, 0)
			end
			
			module_mission.update_group_map_objects(a_group) 
		end
	end
end

function setHeadingUnit(a_unit, a_heading)
	local dHeading = a_heading - a_unit.heading	
	a_unit.heading = a_heading
	if a_unit.linkChildren then
		for i,linkWpt in ipairs(a_unit.linkChildren) do	
			if linkWpt.boss.linkOffset == true or base.panel_route.isAircraftOnShip(linkWpt.boss) then	
				if linkWpt.boss.type == "static" then
					local sinHdg = base.math.sin(dHeading)
					local cosHdg = base.math.cos(dHeading)					
					for k,unit in base.pairs(linkWpt.boss.units) do
						local dx =  unit.x - a_unit.x
						local dy =  unit.y - a_unit.y 
						
						local offsetX, offsetY = 0, 0	
						
						offsetX = dx*cosHdg - dy*sinHdg
						offsetY = dy*cosHdg + dx*sinHdg	
					
						if k == 1 then
							if MapWindow.checkSurface(linkWpt.boss, a_unit.x+offsetX, a_unit.y+offsetY, nil, nil, 1) then 
								MapWindow.move_group(linkWpt.boss, a_unit.x+offsetX, a_unit.y+offsetY)
								MapWindow.move_waypoint(linkWpt.boss, 1, a_unit.x+offsetX, a_unit.y+offsetY, nil, true)
							end
						else
							if MapWindow.checkSurface(linkWpt.boss, unit.x+offsetX, unit.y+offsetY, nil, nil, 1) then 
								MapWindow.move_unit(linkWpt.boss, unit, a_unit.x+offsetX, a_unit.y+offsetY)	
							end
						end
					end
				else
					local sinHdg = base.math.sin(dHeading)
					local cosHdg = base.math.cos(dHeading)
					for k,unit in base.pairs(linkWpt.boss.units) do
						local offsetX, offsetY = 0, 0	
						local dx =  unit.x - a_unit.x
						local dy =  unit.y - a_unit.y
						offsetX = dx*cosHdg - dy*sinHdg
						offsetY = dy*cosHdg + dx*sinHdg	
					
						if k == 1 then
							MapWindow.move_group(linkWpt.boss, a_unit.x+offsetX, a_unit.y+offsetY)
							MapWindow.move_waypoint(linkWpt.boss, 1, a_unit.x+offsetX, a_unit.y+offsetY, nil, true)
						else
							MapWindow.move_unit(linkWpt.boss, unit, a_unit.x+offsetX, a_unit.y+offsetY)	
						end
										
					end
				end
				
				for k,unit in base.pairs(linkWpt.boss.units) do
					unit.heading = (unit.heading or 0) + dHeading
					panel_static.updateHeadingUnit(unit)
				end
			end
		end
	end
	
	if a_unit.linkChildrenTZone then
		for i,zoneId in ipairs(a_unit.linkChildrenTZone) do	
			TriggerZoneController.updateHeading(zoneId)		
		end
	end	
end

function isVisible()
    return window:isVisible()
end   

-------------------------------------------------------------------------------
-- 
function fillCategory()
	if (cat_by_country[vdata.country]) then		
		c_category:clear()  	

		for i, idCat in ipairs(cat_by_country[vdata.country]) do
			local item = ListBoxItem.new(cat[idCat], true)
			item.itemId = idCat
			c_category:insertItem(item)
		end

		local armItem = nil
		local curItem = nil
		local firstItem = nil

		for i=0, c_category:getItemCount()-1 do
			local wid = c_category:getItem(i)
			if wid.itemId == vdata.category then
				curItem = wid
			end
			if i == 0 then
				firstItem = wid
			end
		end

		if curItem then
			c_category:selectItem(curItem)
		else
			c_category:selectItem(firstItem)
		end	

        vdata.category = c_category:getSelectedItem().itemId
	end	
end

function onChangeType()
	local bIsNeedChange = true

	if vdata.group then
		local wpt = vdata.group.route.points[1]
		if MapWindow.isValidDepth(c_type:getSelectedItem().type, wpt.x, wpt.y) == false then
			local msgWindowHandler = MsgWindow.warning(cdata.Insufficient, cdata.warning, cdata.yes, cdata.cancel)

			function msgWindowHandler:onChange(buttonText)
				if (buttonText == cdata.yes) then
					bIsNeedChange = true
				else
					bIsNeedChange = false
					setTypeItem(vdata.types[vdata.unit.cur])
				end
			end

			msgWindowHandler:show()
			msgWindowHandler = nil
		end
		
	end

	if bIsNeedChange ~= false then
		vdata.types[vdata.unit.cur] = c_type:getSelectedItem().type	
		updateForNewType()
		update()
	end				
end		

-------------------------------------------------------------------------------
function onChangeCategory(self, item)	
	local oldCategory = vdata.category
	vdata.category = item.itemId
	if oldCategory ~= vdata.category then
		updateType()  		
	end
	
	update()
end

function updateType() 
	local category = c_category:getSelectedItem().itemId 
	vdata.types = {}
	local oldType

	if vdata.group then		
        for i=1,#vdata.group.units do
            base.table.insert(vdata.types, vdata.group.units[i].type);
        end
		if vdata.unit.cur == nil or vdata.unit.cur > #vdata.group.units then
			vdata.unit.cur = #vdata.group.units
		end
		oldType = vdata.types[vdata.unit.cur]
	else
		if c_type:getSelectedItem() then
			oldType = c_type:getSelectedItem().type	
			vdata.types[1] = oldType
			vdata.unit.cur = 1
		else
			vdata.types[1] = country_ship_list[vdata.country][category][1]
			vdata.unit.cur = 1
		end
	end
	
	fill_combo(c_type, country_ship_list[vdata.country][category]) 

	local newType = country_ship_list[vdata.country][category][1]
	for k,v in base.pairs(country_ship_list[vdata.country][category]) do
		if v == oldType then
			newType = oldType
		end
	end
	
	setTypeItem(newType) 
	if newType ~= oldType then
		updateForNewType()
	end
end    

function updateForNewType()
	if vdata.group then
		verifyWarehouse(vdata.types[vdata.unit.cur])

		base.panel_route.vdata.unit = vdata.group.units[vdata.unit.cur]			
		base.panel_route.update()
		-- Тип нужно изменить также в юните группы и соответственно перерисовать объект карты.
		local unit =  vdata.group.units[vdata.unit.cur];
		unit.type = vdata.types[vdata.unit.cur]
		MapWindow.updateSelectedGroup(vdata.group)
		module_mission.relinkChildren(unit)
		
		pPayload_vehicles.setUnit(vdata.group.units[vdata.unit.cur])
	end
	
	validateWayPoints(vdata.group)
end

function closeSetPosUnit()
	if vdata.group then
		MapWindow.setState(MapWindow.getPanState())
	else
		MapWindow.setState(MapWindow.getCreatingShipState())
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

		MapWindow.createShip(a_x, a_y)
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