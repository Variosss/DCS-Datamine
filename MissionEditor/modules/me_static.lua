local base = _G

module('me_static')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local table = base.table
local print = base.print
local math = base.math
local next = base.next
local io = base.io

local DialogLoader              = require('DialogLoader')
local ListBoxItem               = require('ListBoxItem')
local U                         = require('me_utilities')	-- Утилиты создания типовых виджетов
local UC				        = require('utils_common')
local MapWindow                 = require('me_map_window')	-- Окно карты
local loadLiveries              = require('loadLiveries')
local Mission                   = require('me_mission')
local i18n                      = require('i18n')
local DB 				        = require('me_db_api')
local module_mission            = require('me_mission')
local panel_manager_resource    = require('me_manager_resource')
local panel_units_list          = require('me_units_list')
local toolbar                   = require('me_toolbar')
local panel_targeting           = require('me_targeting')
local OptionsData               = require('Options.Data')
local CoalitionController	    = require('Mission.CoalitionController')
local ModulesMediator	        = require('Mission.ModulesMediator')
local panel_showId		        = require('me_showId')
local panel_aircraft	        = require('me_aircraft')
local panel_ship	            = require('me_ship')
local panel_vehicle			    = require('me_vehicle')
local DemoSceneWidget 	        = require('DemoSceneWidget')
local TheatreOfWarData  		= require('Mission.TheatreOfWarData')
local Terrain           		= require('terrain')
local ComboList					= require('ComboList')
local SpinBox					= require('SpinBox')
local Dial						= require('Dial')
local ListBoxItem 				= require('ListBoxItem')
local Static					= require('Static')
local textutil 					= require('textutil')
local CoalitionData				= require('Mission.CoalitionData')
local Skin              		= require('Skin')
local MeSettings      			= require('MeSettings')
local editorManager          	= require('me_editorManager')
local MsgWindow					= require('MsgWindow')
local TriggerZoneController		= require('Mission.TriggerZoneController')
local ProductType 				= require('me_ProductType') 
local setCoordPanel 			= require('me_setCoordPanel')


local helipadDefaultFrequency = 127.500000
local helipadDefaultModulation = DB.MODULATION_AM

local grassairfieldsDefaultFrequency = 127.500000
local grassairfieldsDefaultModulation = DB.MODULATION_AM

local DSWidget
local lastPreviewType

i18n.setup(_M)

    function initModule()
    -- Неизменные локализуемые данные (при необходимости, их можно будет вынести в отдельный файл,
    -- но IMHO удобнее видеть их прямо здесь, чтобы представлять себе структуру панели)
    cdata = 
    {
        title = _('STATIC OBJECT'),
        name = _('NAME'),
        country = _('COUNTRY'),
        category = _('CATEGORY'),
        type = _('TYPE'), 
        goto = _('GOTO'),
        heading = _('HEADING'),
        hidden = _('HIDDEN'),
		hiddenOnPlanner = _('HIDDEN ON PLANNER'),
		hiddenOnMFD = _('HIDDEN ON MFD'),
        dead = _('DEAD'),

        heliport  = _("CALLSIGN"),
        frequency = _("FREQUENCY"),
        modulationName		= {
            [DB.MODULATION_AM] = _('AM'),
            [DB.MODULATION_FM] = _('FM')
        },		
        _heliport  = _("Heliport"),
        lenght = _("LENGTH"),
        lenghtRope = _("ROPE LENGTH"),
        LinkUnit    = _("LINK UNIT"),
		LinkOffset		= _("OFFSET FIXATION"),

        heliports = _('Heliports'),
        GrassAirfields = _("Grass Airfields"),
        GrassAirfield = _("Grass Airfield"),
        warehouses   = _('Warehouses'),
        planes       = _('Planes'),
        helicopters  = _('Helicopters'),
		vehicles	 = _('Ground vehicles'),
        LTAvehicles  = _('LTAvehicles'),
		Animals  	 = _('Animals'),
		Personnel	 = _('Personnel'),
		structures   = _('Structures'),
		effects  	= _('Effects'),
        WWIIstructures= _('WWIIstructures'),
        color_scheme = _('PAINT SCHEME'),
        standard = _('Standard'),
        
		unitName 	= _('UNIT NAME'),
        fullInfo    = _('FULL INFO'),
        suppliers   = _('SUPPLIERS'),
        add 		= _('ADD'),
        del 		= _('DEL'),
        mass        = _('MASS'),
        canbecargo  = _('CAN BE CARGO'), 
		nameGroup  	= _('New Static Object'),
		
		effect			= _('EFFECT'),
		preset			= _('PRESET'),
		Course			= _('COURSE'),
		lenghtLine		= _('LINE LENGTH'),
		transparency	= _('DENSITY'),
		radius			= _('RADIUS'),
		
		m 			= _("m"),
		all		 	= _("ALL"),
		combat	 	= _("COMBAT"),
		
		unit 		= _('UNIT'), 
		unit_of 	= _('OF'),
		cargo		= _('CARGO'),
    }

    -- Переменные загружаемые/сохраняемые данные 
    vdata =
    {
        name = _('New Static Object'),
		defaultName = _('Static_g', 'Static'),
        countries = {},
        country = nil,
        categories = {},
        category = nil,
        types = {},
        type = nil,
        heading = 0, 
		unitCur	= 1,
    }
	
	
	SEASONS = { "summer", "winter", "spring", "autumn" }
end    

local function isValidType(a_unitsNames, a_category)
    if(categoryName == _('Structures')) then               
        for i,v in pairs(a_unitsNames) do
            if  DB.unit_by_type[v].category == "Fortification" then 
                return true
            end
        end
    end;
    
    for i,v in pairs(a_unitsNames) do
        if( not(a_category == _('Ground vehicles') and DB.unit_by_type[v].category == "Fortification")) then 
            return true
        end
    end
    return false
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
-- add category of statics
function addCategory(categories, countriesTmp, units, country, categoryName, tableName, subCategory, mainCategory)
    local t 
	local Year = (Mission.mission and Mission.mission.date.Year) or 2018
	
	if (MeSettings.getShowEras() == true) then
		window:setText(cdata.title.." - "..Year)
	else
		window:setText(cdata.title)
	end
	
	local unitInGroup 
	if vdata.group then
		unitInGroup = {}
		for k,v in base.pairs(vdata.group.units) do
			unitInGroup[v.type] = v.type
		end
	end
	
	local tmpCat 
	if tableName == 'Personnel' then
		tmpCat = 'Personnel'
	else
		tmpCat = tableName .. 's'
	end
	
    if country.Units[tmpCat] then
		t = {}
		for nameCat,cat in base.pairs(country.Units[tmpCat]) do
			for j,unit in base.pairs(cat) do
				local tmp_in, tmp_out = DB.db.getYearsLocal(unit.Name, country.OldID)
				
				if not DB.unit_by_type[unit.Name] then 
					--base.print("check unit ", unit.Name) 
				else
					if (MeSettings.getShowEras() ~= true)
								or ((unitInGroup and unitInGroup[unit.Name] ~= nil)
									or tableName == 'Fortification'
									or tableName == 'Heliport'
									or tableName == 'Warehouse'
									or tableName == 'Cargo'
									or tableName == 'LTAvehicle'
									or tableName == 'WWIIstructure'
									or tableName == 'Effect'
									or tableName == 'Animal'
									or tableName == 'Personnel'
									or tableName == 'ADEquipment'									
									or (MeSettings.getShowEras() == true and tmp_in <= Year and Year <= tmp_out)) then
						t[nameCat] = t[nameCat] or {}			
						base.table.insert(t[nameCat], unit.Name)				
						countriesTmp[country.OldID] = country.Name	
					end	
				end
			end
		end
    end
	if subCategory == nil then 
		tblCategoryName[tableName] = categoryName
	else
		tblCategoryName[subCategory] = mainCategory
		tblSubCategoryName[subCategory] = categoryName
	end
    if t then
        local u = t[tableName] 
		units[categoryName] = {}
		if u then
			for k,unitName in base.pairs(u) do
				local unitDef = DB.unit_by_type[unitName]  
				if unitDef ~= nil and unitDef.subCategory == subCategory then	
					table.insert(units[categoryName],unitName)
				end	
			end
		end

        if isValidType(units[categoryName], categoryName) == true then
            table.insert(categories, categoryName)
        end;
    else
        units[categoryName] = {}
    end
end

function getCategoryName(a_categoryUnit)
    return tblCategoryName[a_categoryUnit]
end

function delLinkCargoGroup(a_groupId)
    for _tmp, group in pairs(module_mission.group_by_id) do
        if group.route and group.route.points then            
            for kk, wp in ipairs(group.route.points) do         
                if wp.task and wp.task.params and wp.task.params.tasks then   
                    for k,task in ipairs(wp.task.params.tasks) do
                        if task.id == "CargoTransportation" and task.params and task.params.groupId == a_groupId then
                            task.params = {}
                            local toRemove = {}
                            if wp.targets then
                                for k,target in ipairs(wp.targets) do
                                    if target.task and target.task.id == "CargoTransportation" then
                                        table.insert(toRemove, target)
                                    end
                                end
                                for i = #toRemove, 1, -1 do
                                    module_mission.remove_target(toRemove[i])
                                end
                            end
                        end
                    end                    
                end 
            end
        end    
    end
end

local function compareUnitByName(left, right)
    return left.name < right.name
end
    
function fillComboListLinkUnit()
    cListLinkUnit:clear()
    local units = {}
    for k, unit in base.pairs(base.module_mission.unit_by_id) do
        local udb = DB.unit_by_type[unit.type]   
        if (unit.boss.type ~= 'helicopter' and unit.boss.type ~= 'plane'
            and vdata.group and vdata.group.units[1] ~= unit and udb.category ~= 'LTAvehicle' and c_category:getText() == cdata.LTAvehicles)
			or (unit.boss.type == 'ship') then
           -- base.U.traverseTable(v,2)
		    if unit.boss.boss.boss.name == vdata.group.boss.boss.name  then
				local unitInfo = {}
				unitInfo.name = unit.name
				unitInfo.id = unit.unitId
				base.table.insert(units,unitInfo)
			end
        end
    end

    base.table.sort(units, compareUnitByName)
    
    -- вставляем первым очистку линковки  
    local unitInfo = {}
    unitInfo.name = _("None")
    unitInfo.id = nil
    base.table.insert(units, 1, unitInfo)
    
      
    for i, unit in base.ipairs(units) do
        local item = ListBoxItem.new(unit.name)
        item.id = unit.id
        cListLinkUnit:insertItem(item)
    end
    
    if vdata.group and vdata.group.route and vdata.group.route.points[1] and vdata.group.route.points[1].linkUnit then
        cListLinkUnit:setText(vdata.group.route.points[1].linkUnit.name)
    else
        cListLinkUnit:selectItem(cListLinkUnit:getItem(0))
    end
end


function updatePanelData()

    -- В БД в категории 'Buildings' сейчас странноватый наборчик 'Building', 'Bridge', 'Transport', 'Train',
    -- а все наземные сооружения почему-то залетели в категорию 'Fortifications'. 
    -- Надо бы это исправить в БД, чтобы различать боевые и мирные сооружения. 
 --   vdata.countries = CoalitionController.getActiveCountries()
	local c = CoalitionController.getActiveCountries()
	vdata.countries = {}
	local countriesTmp = {}	
  --  vdata.country = vdata.countries[1]
	
    country_categories = {}
    country_category_units = {}
    tblCategoryName = {}
	tblSubCategoryName = {}
    
    for i,country in pairs(DB.db.Countries) do
		local units = {}
		local categories = {}
		country_category_units[country.Name] = units
		country_categories[country.Name] = categories
		
		addCategory(categories, countriesTmp, units, country, _('Planes'), 'Plane')
		addCategory(categories, countriesTmp, units, country, _('Helicopters'), 'Helicopter')
		addCategory(categories, countriesTmp, units, country, _('Ships'), 'Ship')
		addCategory(categories, countriesTmp, units, country, _('Ground vehicles'), 'Car')
		addCategory(categories, countriesTmp, units, country, _('Structures'), 'Fortification')
		addCategory(categories, countriesTmp, units, country, cdata.heliports, 'Heliport')
	 --   addCategory(categories, countriesTmp, units, country, cdata.GrassAirfields, 'GrassAirfield')        
		addCategory(categories, countriesTmp, units, country, _('Warehouses'), 'Warehouse')
		addCategory(categories, countriesTmp, units, country, _('Cargos'), 'Cargo')
		addCategory(categories, countriesTmp, units, country, _('LTAvehicles'), 'LTAvehicle')
		addCategory(categories, countriesTmp, units, country, _('WWIIstructures'), 'WWIIstructure')
		addCategory(categories, countriesTmp, units, country, cdata.effects, 'Effect')
		addCategory(categories, countriesTmp, units, country, cdata.Animals, 'Animal')
		addCategory(categories, countriesTmp, units, country, cdata.Personnel, 'Personnel')			
		addCategory(categories, countriesTmp, units, country, _('Airfield and deck equipment'),'ADEquipment')
		
		addCategory(categories, countriesTmp, units, country, _('Sea Shelf Objects'), 'Heliport', 'SeaShelfObject', cdata.heliports)
		
		table.sort(categories)   	
    end	
    
    tblCategoryName['Air Defence']	= _('Ground vehicles')
    tblCategoryName['Armor'] 		= _('Ground vehicles')
    tblCategoryName['Artillery'] 	= _('Ground vehicles')
    tblCategoryName['Civilians'] 	= _('Ground vehicles')
    tblCategoryName['Infantry'] 	= _('Ground vehicles')
    tblCategoryName['Unarmed'] 		= _('Ground vehicles')
	tblCategoryName['Locomotive'] 	= _('Ground vehicles')
	tblCategoryName['Carriage'] 	= _('Ground vehicles')
	tblCategoryName['MissilesSS'] 	= _('Ground vehicles')	
	
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

function fill_combo(combo, t)
    combo:clear()  
    if not t then
        combo:setText("")
        return
    end 

    for i, type in ipairs(t) do
        local DisplayName = DB.getDisplayNameByName(type)
        local item = ListBoxItem.new(DisplayName)
        item.type = type
        item.DisplayName = DisplayName
        item.index = i
        combo:insertItem(item)
    end
    
end

local function compTypes(value1, value2)
	return textutil.Utf8Compare(DB.getDisplayNameByName(value1), DB.getDisplayNameByName(value2))    
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
	
-------------------------------------------------------------------------------
-- Создание и размещение виджетов
-- Префиксы названий виджетов: t - text, b - button, c - combo, sp - spin, sl - slider, e - edit, d - dial 
function create(x, y, w, h)
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_static_panel.dlg", cdata)
    window:setBounds(x, y, w, h)
    window.box:setBounds(0, 0, w, h-30)
	
	w_ = w
    
	box						= window.box
    pLTAvehicle 			= box.pLTAvehicle
	pLinkUnit				= box.pLinkUnit
    pPreview 				= box.pPreview   
    pSetMass 				= box.pSetMass
	pProp 					= box.pProp 		
    cont_W 					= box.cont_W
    pColorScheme 			= box.pColorScheme	 
	pEffects				= box.pEffects
	pPreset 				= pEffects.pPreset
	pCourse					= pEffects.pCourse
	pLenghtLine				= pEffects.pLenghtLine
	pTransparency			= pEffects.pTransparency
	pRadius					= pEffects.pRadius
	hiddenEffectCheckbox 	= pEffects.hiddenCheckbox  
	
	
	clPreset				= pPreset.clPreset
	spCourse				= pCourse.spCourse
	dCourse					= pCourse.dCourse
	spLenghtLine			= pLenghtLine.spLenghtLine	
	spTransparency			= pTransparency.spTransparency
	spRadius				= pRadius.spRadius
	btnShowId 				= box.btnShowId
    e_name 					= box.e_name   
	e_unit_name				= box.e_unit_name
    c_country 				= box.c_country
    c_category 				= box.c_category
    c_type 					= box.c_type
	eMass 					= pSetMass.eMass
    sUnit 					= pSetMass.sUnit
    hsMass 					= pSetMass.hsMass
    cbCanCargo 				= pSetMass.cbCanCargo
    sLenght 				= pProp.sLenght
    spLenght 				= pProp.spLenght    
    sUnitLenght 			= pProp.sUnitLenght
    spLenghtRope 			= pLTAvehicle.spLenghtRope
    sUnitLenghtRope 		= pLTAvehicle.sUnitLenghtRope
    cListLinkUnit 			= pLinkUnit.cListLinkUnit
    e_heading 				= pProp.e_heading    
    d_heading 				= pProp.d_heading
    hiddenCheckbox 			= pProp.hiddenCheckbox  	
	cbHiddenOnPlanner 		= pProp.cbHiddenOnPlanner
	cbHiddenOnMFD			= pProp.cbHiddenOnMFD
    deadCheckbox 			= pProp.deadCheckbox
    t_heliport 				= pProp.t_heliport -- Helipad
    c_heliport 				= pProp.c_heliport
    ft_heliport 			= pProp.ft_heliport
	f_heliport 				= pProp.f_heliport
    mt_heliport 			= pProp.mt_heliport
    t_color_scheme 			= pColorScheme.t_color_scheme
    c_color_scheme 			= pColorScheme.c_color_scheme
    tb_FullInfo 			= cont_W.tb_FullInfo --кнопка заполнения склада
    l_suppliers 			= cont_W.l_suppliers
    b_Add 					= cont_W.b_Add --кнопка добавить поставщика
    b_Del 					= cont_W.b_Del --кнопка удалить поставщика
	sp_unit					= box.sp_unit
	sp_of					= box.sp_of
	pCargo					= pProp.pCargo
	spCargo					= pCargo.spCargo
	tbSetPos 				= box.tbSetPos
	
	tbSetPos.onChange 		= onChange_tbSetPos	
	sp_unit.onChange 		= onSpinUnit
	sp_of.onChange 			= onSpinUnitOf
	e_unit_name.onChange	= onChange_e_unit_name
	
	spCargo.onChange		= onChange_spCargo

	eMassUnit = U.createUnitSpinBox(sUnit, eMass, U.weightUnits, 100, 10000)   
    spLenghtUnit = U.createUnitSpinBox(sUnitLenght, spLenght, U.distanceUnits, 100, 10000)
    spLenghtRopeUnit = U.createUnitSpinBox(sUnitLenghtRope, spLenghtRope, U.altitudeUnits, 10, 10000, 0.1) 
	spLenghtRopeUnit:setStep(0.1)
	
	panelSkins		= window.box.panelSkins
	eNameWhiteSkin	= panelSkins.eNameWhite:getSkin()
	eNameRedSkin 	= panelSkins.eNameRed:getSkin()
	
	hiddenCheckbox.panel = _M
	hiddenEffectCheckbox.panel = _M
	e_heading:setValue(0)
	pLTAvehicle:setPosition(16, 246)
	pLinkUnit:setPosition(16, 246)
	sp_of:setRange(1, 99)
	
	local xM, yM, wM, hM = pSetMass:getBounds()
    pSetMass:setBounds(xM, 250, wM, hM)
	
	pEffects:setPosition(0, 156)
	
	tbFilter = box.tbFilter
	tbFilter:setText(cdata.combat)
	
	f_heliport:setText(helipadDefaultFrequency)
	
	if base.__PRODUCT_ID__ ~= 2 then
		tbSetPos:setVisible(false)
	end
	
	updateUnitSystem()
	setupCallbacks()
end

	
function setupCallbacks()
	b_Del.onChange = onChange_b_Del
	cbCanCargo.onChange = onChange_cbCanCargo
	spLenght.onChange = onChange_spLenght
	spLenghtRope.onChange = onChange_spLenghtRope
	b_Add.onChange = onChange_b_Add
	l_suppliers.onChange = onChange_l_suppliers
	tb_FullInfo.onChange = onChange_tb_FullInfo
	c_color_scheme.onChange = onChange_c_color_scheme
	f_heliport.onChange = onChange_f_heliport
	c_heliport.onChange = onChange_c_heliport
	d_heading.onChange = onChange_d_heading
	e_heading.onChange = onChange_e_heading
	c_type.onChange = onChange_c_type
	c_category.onChange = onChange_c_category
	c_country.onChange = onChange_c_country
	e_name.onChange = onChange_e_name
	window.onClose = onClose_window
	cListLinkUnit.onChange = onChange_cListLinkUnit
	deadCheckbox.onChange = onChange_deadCheckbox 
	hiddenCheckbox.onChange = MapWindow.OnHiddenCheckboxChange
	cbHiddenOnPlanner.onChange 		= onChange_cbHiddenOnPlanner
	cbHiddenOnMFD.onChange 		= onChange_cbHiddenOnMFD
	btnShowId.onChange = onChange_ShowId
	hiddenEffectCheckbox.onChange = MapWindow.OnHiddenCheckboxChange 
	
	clPreset.onChange = onChange_clPreset
	spCourse.onChange = onChange_spCourse
	dCourse.onChange = onChange_dCourse
	spLenghtLine.onChange = onChange_spLenghtLine
	spTransparency.onChange = onChange_spTransparency
	spRadius.onChange = onChange_spRadius
	tbFilter.onChange = onChange_tbFilter
end

-------------------------------------------------------------------------------
function onChange_tbFilter(self)
	if (self:getState() == true) then
		self:setText(cdata.all)
	else
		self:setText(cdata.combat)
	end
	updateCountries()
	update()
end	

-------------------------------------------------------------------------------
function onChange_cbHiddenOnPlanner(self)
	if vdata.group then
		vdata.group.hiddenOnPlanner = self:getState()
	end
end

-------------------------------------------------------------------------------
function onChange_cbHiddenOnMFD(self)
	if vdata.group then
		vdata.group.hiddenOnMFD = self:getState()
	end
end

function onClose_window()
	MapWindow.setState(MapWindow.getPanState())
	show(false)
	vdata.group = nil
	toolbar.setStaticButtonState(false)
	panel_units_list.show(false);
	MapWindow.unselectAll();
	MapWindow.expand()
end
	
function onChange_e_name(self)
	if module_mission.isGroupFreeName(self:getText()) ~= true then
		self:setSkin(eNameRedSkin)
	else
		self:setSkin(eNameWhiteSkin)
	end
	vdata.name = module_mission.check_group_name(self:getText())
	if vdata.group then
		module_mission.renameGroup(vdata.group, vdata.name)
		module_mission.renameUnit(vdata.group.units[1], vdata.group.name)
		panel_units_list.updateRow(vdata.group, vdata.group.units[1]);
	end
end

function onChange_e_unit_name(self)
	if module_mission.isUnitFreeName(self:getText()) ~= true then
		self:setSkin(eNameRedSkin)
	else
		self:setSkin(eNameWhiteSkin)
	end
	
	local name = self:getText()
	local group = vdata.group
	if group then
		local unit = group.units[vdata.unitCur]
		if unit then
			name = module_mission.check_unit_name(name)
			module_mission.renameUnit(unit, name) 
		end
	end
end

function onChange_spCargo(self)
	if vdata.group then
		vdata.group.units[vdata.unitCur].cargo = self:getValue()
	end
end
	
function onChange_c_country(self)
	base.panel_route.changeCountryGroup(vdata.group, DB.country_by_name[vdata.country].WorldID, DB.country_by_name[self:getText()].WorldID)

	vdata.country = self:getText()
	changeCountry(vdata.country)
	MapWindow.updateHiddenSelectedGroup()
end
	
function onChange_c_category(self)
	local old_vcategory = vdata.category
	local old_type = vdata.type
	vdata.category = self:getText()
	
	updateTypes()
	
	if vdata.group then
		local unit = vdata.group.units[1]                        
		unit.type = vdata.type
		local udb = DB.unit_by_type[unit.type]            
		
		if c_category:getText() ~= cdata.LTAvehicles then
			Mission.unlinkWaypoint(vdata.group.route.points[1])
		end
		
		local x  = vdata.group.x
		local y  = vdata.group.y
		local udbOld = DB.unit_by_type[old_type] 
		
		if not MapWindow.checkSurface(vdata.group, x, y, true) then
			self:setText(old_vcategory);
			setTypeItem(old_type);
			vdata.category = old_vcategory;
			unit.type = old_type
			updateTypes()
			
			return;
		else
			if udbOld.category == 'Cargo' and udb.category ~= 'Cargo' then
				delLinkCargoGroup(vdata.group.groupId)  
			end 
		end;

		-- удаление склада
		if ('Heliport' == udbOld.category or 'Warehouse' == udbOld.category or 'GrassAirfield' == udbOld.category) then					
			module_mission.delWarehouse(vdata.group.units[1].unitId)  			
			l_suppliers:clear()    
			MapWindow.setState(MapWindow.getPanState())
			panel_targeting.b_add:setState(false)
		end 
		
		if ('Heliport' == udbOld.category) then
			for i = #vdata.group.units, 2, -1 do
				module_mission.remove_unit(vdata.group.units[i])
			end
			vdata.unitCur = 1
		end
	
		local udb = DB.unit_by_type[vdata.type]
		
		unit.rate = udb.Rate
		unit.shape_name = udb.ShapeName
		-- Поскольку изменился тип, то нужно проверить, можно ли его здесь поставить.
		-- Если нельзя, то нужно найти ближайшее место, где можно.
		MapWindow.move_group(vdata.group, vdata.group.x, vdata.group.y)				
		local classKey = DB.getClassKeyByType(vdata.type)
		if classKey then
			local unitMo = vdata.group.mapObjects.units[1]
			unitMo.classKey = classKey
			
			updateHeading()        

			if base.MapWindow.isShowHidden(vdata.group) == true then
				module_mission.remove_group_map_objects(vdata.group)
				module_mission.create_group_map_objects(vdata.group)
			end
		end
		module_mission.relinkChildren(unit)	

		-- добавление склада
		if ('Heliport' == udb.category or 'Warehouse' == udb.category or 'GrassAirfield' == udb.category) then			
			module_mission.addWarehouse(vdata.group.units[1].unitId, vdata.group.boss.boss.name)  
		end
		
		vdata.group.units[1].mass = nil --сбрасываем чтобы взять дефолтную
	end
	
	sLenght:setVisible(false)
	spLenght:setVisible(false)
	sUnitLenght:setVisible(false)
		
	if self:getText() ~= cdata.heliports and self:getText() ~= cdata.GrassAirfields then
		t_heliport:setVisible(false)
		c_heliport:setVisible(false)
		ft_heliport:setVisible(false)
		f_heliport:setVisible(false)
		mt_heliport:setVisible(false)	
	else      
		if vdata.group and vdata.group.units then
			t_heliport:setVisible(true)
			c_heliport:setVisible(true)
			ft_heliport:setVisible(true)
			f_heliport:setVisible(true)
			mt_heliport:setVisible(true) 				
			if self:getText() == cdata.GrassAirfields then
				sLenght:setVisible(true)
				spLenght:setVisible(true)
				sUnitLenght:setVisible(true)
			end                
		
			local udb = DB.unit_by_type[vdata.group.units[1].type]
			--base.U.traverseTable(udb,2)

			fillComboCallnames()
			local id 
					
			if self:getText() == cdata.heliports then
				vdata.group.units[1].heliport_callsign_id = vdata.group.units[1].heliport_callsign_id or 1
				id = vdata.group.units[1].heliport_callsign_id
				local freq = vdata.group.units[1].heliport_frequency or helipadDefaultFrequency;
				vdata.group.units[1].heliport_frequency = freq
				f_heliport:setText(freq)
				local modulation = vdata.group.units[1].heliport_modulation or helipadDefaultModulation
				vdata.group.units[1].heliport_modulation = modulation
				mt_heliport:setText(cdata.modulationName[modulation])	
				local text = DB.db.getCallnames(vdata.group.boss.id, 'Helipad')[id].Name
				c_heliport:setText(text)
			elseif self:getText() == cdata.GrassAirfields then
				vdata.group.units[1].grassairfield_callsign_id = vdata.group.units[1].grassairfield_callsign_id or 1
				id = vdata.group.units[1].grassairfield_callsign_id
				local freq = vdata.group.units[1].grassairfield_frequency or grassairfieldsDefaultFrequency
				vdata.group.units[1].grassairfield_frequency = freq
				f_heliport:setText(freq)
				local modulation = vdata.group.units[1].grassairfield_modulation or grassairfieldsDefaultModulation
				vdata.group.units[1].grassairfield_modulation = modulation
				mt_heliport:setText(cdata.modulationName[modulation])	
				local text = DB.db.getCallnames(vdata.group.boss.id, 'GrassAirfield')[id].Name 
				c_heliport:setText(text)
			end					
		end
	end   

	if vdata.category == cdata.Personnel
	   or vdata.category == cdata.structures 
	   or vdata.category == cdata.helicopters 
	   or vdata.category == cdata.planes 
	   or vdata.category == cdata.Animals 
	   or vdata.category == cdata.vehicles then 
		pColorScheme:setVisible(true)   
	else
		pColorScheme:setVisible(false)
	end
	
	if (vdata.group) and (vdata.group.units) and (vdata.group.units[1]) then
		vdata.group.units[1].livery_id = nil
	end
	
	updatePanelEffects()	
	
	updateLiveries()
	
	updateWarehouses()
	updateLTAvehiclePanel()
	updateLinkUnitPanel() 
	updateVisibleMass()
	updateLenght()
	updatePositionPreview()	
	updateNumUnits()
	updateCargo()  
end

function onChange_clPreset(self)
	vdata.group.units[1].effectPreset = self:getSelectedItem().id
end

function onChange_spCourse(self)
	vdata.group.units[1].effectCourse = self:getValue()
	dCourse:setValue(self:getValue())
end

function onChange_dCourse(self)
	vdata.group.units[1].effectCourse = self:getValue()
	spCourse:setValue(self:getValue())
end

function onChange_spLenghtLine(self)
	vdata.group.units[1].effectLenghtLine = self:getValue()
end
	
function onChange_spTransparency(self)
	vdata.group.units[1].effectTransparency = self:getValue()
end

function onChange_spRadius(self)
	vdata.group.units[1].effectRadius = self:getValue()
end

	

function updatePanelEffects()
	if vdata.category == cdata.effects then 		
		pProp:setVisible(false)  
		pEffects:setVisible(true)
			
		pPreset:setVisible(false)
		pCourse:setVisible(false)
		pLenghtLine:setVisible(false)
		pTransparency:setVisible(false)
		pRadius:setVisible(false)
		
		local udb = DB.unit_by_type[vdata.type] 

		local offsetY = 42
				
		if udb then
			if udb.tblPresets ~= nil then
				pPreset:setVisible(true)
				offsetY = offsetY + 35
				fill_clPreset(udb.tblPresets)
			end
			
			if udb.bCourse then
				pCourse:setVisible(true)
				pCourse:setPosition(0,offsetY)
				offsetY = offsetY + 63				
			end
			
			if udb.bLenghtLine then
				pLenghtLine:setVisible(true)
				pLenghtLine:setPosition(0,offsetY)
				offsetY = offsetY + 35				
			end
			
			if udb.bTransparency then
				pTransparency:setVisible(true)
				pTransparency:setPosition(0,offsetY)
				offsetY = offsetY + 35				
			end
			
			if udb.bRadius then
				pRadius:setVisible(true)
				pRadius:setPosition(0,offsetY)
				offsetY = offsetY + 35				
			end
		
		end	
			
		if vdata.group then			
			pEffects:setEnabled(true)
			
			if udb.tblPresets ~= nil then
				local effectPreset = vdata.group.units[1].effectPreset or udb.tblPresets.defaultId
				vdata.group.units[1].effectPreset = effectPreset
				
				for i=0,clPreset:getItemCount()-1 do
					local item = clPreset:getItem(i)
					if item.id == effectPreset then
						clPreset:selectItem(item)
					end
				end	
		    else
				vdata.group.units[1].effectPreset = nil
			end
			
			if udb.bCourse then
				local effectCourse = vdata.group.units[1].effectCourse or 0
				vdata.group.units[1].effectCourse = effectCourse
				spCourse:setValue(effectCourse) 
				dCourse:setValue(effectCourse) 
			else
				vdata.group.units[1].effectCourse = nil
			end
			
			if udb.bLenghtLine then
				local effectLenghtLine = vdata.group.units[1].effectLenghtLine or 0
				vdata.group.units[1].effectLenghtLine = effectLenghtLine
				spLenghtLine:setValue(effectLenghtLine) 
			else
				vdata.group.units[1].effectLenghtLine = nil			
			end
			
			if udb.bTransparency then
				local effectTransparency	 = vdata.group.units[1].effectTransparency	 or 1
				vdata.group.units[1].effectTransparency	 = effectTransparency	
				spTransparency:setValue(effectTransparency) 
			else
				vdata.group.units[1].effectTransparency	 = nil					
			end
			
			if udb.bRadius then
				local effectRadius = vdata.group.units[1].effectRadius or 0
				vdata.group.units[1].effectRadius = effectRadius
				spRadius:setValue(effectRadius) 
			else
				vdata.group.units[1].effectRadius = nil					
			end

	
		else
			pEffects:setEnabled(false)
		end	
	else
		pProp:setVisible(true)
		pEffects:setVisible(false)	
	end
	
	
end

function fill_clPreset(tblPresets, selectPresetId)
	clPreset:clear()  
    for k,v in ipairs(tblPresets.values) do
        local item = ListBoxItem.new(v.name)
        item.id = v.id
        clPreset:insertItem(item)
    end
end
	
function ChangeNameforUnit()	
	local udb = DB.unit_by_type[vdata.type]  
--	if udb.category and udb.category == 'Cargo' then
		vdata.name = module_mission.check_group_name(vdata.defaultName.." "..udb.DisplayName.."-1")
		e_name:setText(vdata.name)
		if vdata.group then
			module_mission.renameGroup(vdata.group, vdata.name)
			module_mission.renameUnit(vdata.group.units[1], vdata.group.name)
		end
--	end
end
	
function onChange_c_type()
	vdata.type = c_type:getSelectedItem().type  
	if vdata.group then 
		vdata.group.units[1].mass = nil --сбрасываем чтобы взять дефолтную
	end   
	
	ChangeNameforUnit()

	updateLTAvehiclePanel()
	updateLinkUnitPanel() 
	updateVisibleMass()
	updateCargo() 
	updateNumUnits()
	updateLenght()
	updatePositionPreview()
	updatePanelEffects()
	if vdata.group then
		local unit = vdata.group.units[1];
		local old_type = unit.type;
		unit.type = vdata.type
		local x  = vdata.group.x;
		local y  = vdata.group.y;
		if not MapWindow.checkSurface(vdata.group, x, y, true) then
			unit.type = old_type;
			setTypeItem(old_type)
			vdata.type = old_type;
			print('checkSurface failed');
			return;
		end; 
		
		local udb = DB.unit_by_type[vdata.type]             
		unit.rate = udb.Rate
		unit.shape_name = udb.ShapeName
		-- Поскольку изменился тип, то нужно проверить, можно ли его здесь поставить.
		-- Если нельзя, то нужно найти ближайшее место, где можно.
		MapWindow.move_group(vdata.group, vdata.group.x, vdata.group.y)
		if base.MapWindow.isShowHidden(vdata.group) == true then
			module_mission.remove_group_map_objects(vdata.group)
			module_mission.create_group_map_objects(vdata.group)
		end
		module_mission.relinkChildren(unit)		             
	end
	sLenght:setVisible(false)
	spLenght:setVisible(false)
	sUnitLenght:setVisible(false)
	if vdata.category ~= cdata.heliports or vdata.category ~= cdata.GrassAirfields then
		t_heliport:setVisible(false)
		c_heliport:setVisible(false)
		ft_heliport:setVisible(false)
		f_heliport:setVisible(false)
		mt_heliport:setVisible(false)		
	else            
		if vdata.group and vdata.group.units then
			t_heliport:setVisible(true)
			c_heliport:setVisible(true)
			ft_heliport:setVisible(true)
			f_heliport:setVisible(true)
			mt_heliport:setVisible(true)
			if vdata.category == cdata.GrassAirfields then
				sLenght:setVisible(true)
				spLenght:setVisible(true)
				sUnitLenght:setVisible(true)
			end
		
			fillComboCallnames()
			if vdata.group.units[1].heliport_callsign_id then
				local id = vdata.group.units[1].heliport_callsign_id or 1;
				vdata.group.units[1].heliport_callsign_id = id
				local text = DB.db.getCallnames(vdata.group.boss.id, 'Helipad')[id].Name --cdata.callsigns[id];
				c_heliport:setText(text);
				local freq = vdata.group.units[1].heliport_frequency or helipadDefaultFrequency;
				vdata.group.units[1].heliport_frequency = freq
				f_heliport:setText(freq)
				local modulation = vdata.group.units[1].heliport_modulation or helipadDefaultModulation
				vdata.group.units[1].heliport_modulation = modulation
				mt_heliport:setText(cdata.modulationName[modulation])
			else
				local id = vdata.group.units[1].grassairfield_callsign_id or 1;
				vdata.group.units[1].grassairfield_callsign_id = id
				local text = DB.db.getCallnames(vdata.group.boss.id, 'Helipad')[id].Name --cdata.callsigns[id];
				c_heliport:setText(text);
				local freq = vdata.group.units[1].heliport_frequency or grassairfieldsDefaultFrequency;
				vdata.group.units[1].grassairfield_frequency = freq
				f_heliport:setText(freq)
				local modulation = vdata.group.units[1].heliport_modulation or grassairfieldsDefaultModulation
				vdata.group.units[1].grassairfield_modulation = modulation
				mt_heliport:setText(cdata.modulationName[modulation])

			end        
		end;
	end;
	
	if (vdata.group) and (vdata.group.units) and (vdata.group.units[1]) then
		vdata.group.units[1].livery_id = nil
		
		if vdata.category == cdata.heliports then
			for k,unit in base.pairs(vdata.group.units) do
				if k > 1 then
					unit.type = vdata.group.units[1].type
					local udb = DB.unit_by_type[unit.type]
					unit.rate = udb.Rate
					unit.shape_name = udb.ShapeName
					-- Поскольку изменился тип, то нужно проверить, можно ли его здесь поставить.
					-- Если нельзя, то нужно найти ближайшее место, где можно.
					--MapWindow.move_group(vdata.group, vdata.group.x, vdata.group.y)
					if base.MapWindow.isShowHidden(vdata.group) == true then
						module_mission.remove_group_map_objects(vdata.group)
						module_mission.create_group_map_objects(vdata.group)
					end
				end
			end
		end
	end
	updateLiveries()
end
	
function onChange_e_heading(self)	
	local value = self:getValue()
		
	if value == -1 then
		value = 359
		self:setValue(value)
	elseif value == 360 then
		value = 0
		self:setValue(value)
	end
	
	vdata.group.heading = U.toRadians(value)
	d_heading:setValue(value)
	vdata.group.units[vdata.unitCur].heading = vdata.group.heading 
	updateHeading()
end
	
function onChange_d_heading(self)
	vdata.group.heading = U.toRadians(self:getValue())
	e_heading:setValue(math.floor(self:getValue()))
	vdata.group.units[vdata.unitCur].heading = vdata.group.heading
	updateHeading()
end
	
function onChange_c_heliport(self)
	local callsign = self:getText()
	local udb = DB.unit_by_type[vdata.group.units[1].type]
	local category_callsign
	if udb.category == 'Heliport' then
		category_callsign = 'Helipad'
	else
		category_callsign = 'GrassAirfield'
	end
	for k,v in pairs(DB.db.getCallnames(vdata.group.boss.id, category_callsign)) do
		if v.Name == callsign then
			if vdata.group then
				if category_callsign == 'Helipad' then
					for kk,unit in base.pairs(vdata.group.units) do 
						unit.heliport_callsign_id = k
					end	
				else
					for kk,unit in base.pairs(vdata.group.units) do 
						unit.grassairfield_callsign_id = k
					end	
				end
			end;
			c_heliport.id = k;
			return;
		end;
	end;		
	print('error: callsign not found ', callsign);
end
	
function onChange_f_heliport(self)
	if vdata.group then
		local frequency = self:getText()
		for k,unit in base.pairs(vdata.group.units) do 
			unit.heliport_frequency = frequency
		end	
	end
end
	
function onChange_c_color_scheme(self,item)
	vdata.livery_id = item.itemId
	if (vdata.group) and (vdata.group.units) then
		vdata.group.units[1].livery_id = vdata.livery_id;
	end
	if vdata.type then
		local country = DB.country_by_name[vdata.country]
		setPreviewType(vdata.type, country.WorldID)
	end
end 
	
function onChange_tb_FullInfo()
	local bVisible = panel_manager_resource:isVisible()
	if bVisible == false then
		panel_manager_resource.setCurId(vdata.group.units[1].unitId, false)
	end
	panel_manager_resource.show(not bVisible)
end
	
function onChange_l_suppliers() 
	local item = l_suppliers:getSelectedItem()
	if item then
		ModulesMediator.getSupplierController().setSelectedWarehouseSupplier(vdata.group.units[1].unitId, Mission.getSupplierInfo(item.Id, item.type, i18n.getLocale()))
	end
end
	
function onChange_b_Add(self)
	local supplierController = ModulesMediator.getSupplierController()
	
	if self:getState() then
		supplierController.startAddWarehouseSupplier(getUnitId())
	else
		supplierController.finishAddSupplier()
	end
end

function onChange_b_Del()
	local item = l_suppliers:getSelectedItem()
	
	if item then
		local unitId = vdata.group.units[1].unitId
		
		Mission.removeWarehouseSupplier(unitId, item.Id, item.type)
		
		l_suppliers:removeItem(item)
	end
end
	
function onChange_cbCanCargo(self)
	vdata.group.units[1].canCargo = self:getState()
end
    
function onChange_spLenght()        
	vdata.group.units[1].lenght = spLenghtUnit:getValue()
	
	if not MapWindow.isValidSurface(100, vdata.group.units[1].lenght, vdata.group.units[1].x, vdata.group.units[1].y) then
		base.print("----error----not Valid Surface")
	end
end

function onChange_spLenghtRope()        
	vdata.group.units[1].lenghtRope = spLenghtRopeUnit:getValue()        
end
	
-------------------------------------------------------------------------------
function setPlannerMission(planner_mission)
	if (planner_mission == true) then
		c_country:setEnabled(false)
		e_name:setEnabled(false)
		c_category:setEnabled(false)
		c_type:setEnabled(false)
		e_unit_name:setEnabled(false)
		e_heading:setEnabled(false)
		d_heading:setEnabled(false)
		hiddenCheckbox:setEnabled(false)
		cbHiddenOnPlanner:setVisible(false)
		cbHiddenOnMFD:setVisible(false)
		deadCheckbox:setEnabled(false)
		c_heliport:setEnabled(false)
		f_heliport:setEnabled(false)
		b_Add:setEnabled(false)
		b_Del:setEnabled(false)
        pSetMass:setEnabled(false)
	else
		c_country:setEnabled(true)
		e_name:setEnabled(true)
		c_category:setEnabled(true)
		c_type:setEnabled(true)
		e_unit_name:setEnabled(true)
		e_heading:setEnabled(true)
		d_heading:setEnabled(true)
		hiddenCheckbox:setEnabled(true)
		cbHiddenOnPlanner:setVisible(true)
		cbHiddenOnMFD:setVisible(true)
		deadCheckbox:setEnabled(true)
		c_heliport:setEnabled(true)
		f_heliport:setEnabled(true)
		b_Add:setEnabled(true)
		b_Del:setEnabled(true)
        pSetMass:setEnabled(true)
	end
	
end

function onChange_ShowId()
    panel_showId.setGroup(vdata.group)
    panel_showId.show(true)
end

-------------------------------------------------------------------------------
--
function selectSupplier(supplierId, supplierType)
	local unitId = vdata.group.units[1].unitId
	
	Mission.addWarehouseSupplier(unitId, supplierId, supplierType)
    
    updateSuppliers()
end


-------------------------------------------------------------------------------
--
function updateSuppliers()
    if vdata.group== nil
        or vdata.group.units == nil 
		or vdata.group.units[1] == nil 
        or Mission.mission.AirportsEquipment.warehouses[vdata.group.units[1].unitId] == nil then
        return
    end
    
    local suppliers = Mission.mission.AirportsEquipment.warehouses[vdata.group.units[1].unitId].suppliers
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
-- Открытие/закрытие панели
function show(b)
	--base.print("--show--",	b,	window:isVisible())
    if b == window:isVisible() then
        return
    end
    
    if DSWidget == nil then
        initLiveryPreview()
    end
    window:setVisible(b)
	window:setFocused(false)	
	
    if not b then
		vdata.group = nil
		MapWindow.expand()
	else    		
        tb_FullInfo:setState(false)
        b_Add:setState(false)
		setPlannerMission(base.isPlannerMission())
		MapWindow.collapse(w_, 0)
		if vdata.group then
			if vdata.unitCur > #vdata.group.units then
				vdata.unitCur = 1
			end
		else
			vdata.unitCur = 1
		end
		update()		
	end 
end

function updateLTAvehiclePanel()  
    if c_category:getText() == cdata.LTAvehicles and vdata.group then
        pLTAvehicle:setVisible(true)        

        local udb = base.me_db.unit_by_type[vdata.type]  
        
        if udb and udb.lenghtRope then            
            local lenghtRope = vdata.group.units[1].lenghtRope or udb.lenghtRope                 
            vdata.group.units[1].lenghtRope = lenghtRope
            spLenghtRope:setValue(lenghtRope) 
        else
            pLTAvehicle:setVisible(false) 
            if vdata.group then
                vdata.group.units[1].lenghtRope = nil
            end
        end
    else
        pLTAvehicle:setVisible(false) 
        if vdata.group then
            vdata.group.units[1].lenghtRope = nil
        end
    end 
end

function updateLinkUnitPanel()  
    if (c_category:getText() ~= cdata.GrassAirfields and vdata.group) then
		fillComboListLinkUnit()
		pLinkUnit:setVisible(true)
	else
		pLinkUnit:setVisible(false)
	end		
end	
            
function getUnitId()
	return vdata.group.units[1].unitId
end

function getCategory(a_type)
    local category
	local subCategory
    local udb = base.me_db.unit_by_type[a_type]  

    category = tblCategoryName[udb.category] 
	if udb.subCategory then
		subCategory	= tblSubCategoryName[udb.subCategory] 	
	end

    if category == nil then
        if base.me_db.ship_by_type[a_type] ~= nil then
            category = _('Ships')
        elseif base.me_db.plane_by_type[a_type] ~= nil then
            category = _('Planes')
        elseif base.me_db.helicopter_by_type[a_type] ~= nil then
            category = _('Helicopters')
        end
    end 
    return category, subCategory   
end
-------------------------------------------------------------------------------
--
function update()
	e_name:setSkin(eNameWhiteSkin)
	e_unit_name:setSkin(eNameWhiteSkin)
	updateCountries()
	updatePanel()
end

function updatePanel()
	if vdata.group then
        local unit1 = vdata.group.units[1]
        
		local subCategory
        vdata.category, subCategory =  getCategory(unit1.type)
		
		if subCategory then
			vdata.category = subCategory
		end
		
		vdata.name = vdata.group.name
        vdata.country = vdata.group.boss.name
        vdata.type = vdata.group.units[1].type
        hiddenCheckbox:setState(vdata.group.hidden)
		cbHiddenOnPlanner:setState(vdata.group.hiddenOnPlanner)	
		cbHiddenOnMFD:setState(vdata.group.hiddenOnMFD)	
		hiddenEffectCheckbox:setState(vdata.group.hidden)
        deadCheckbox:setState(vdata.group.dead)
				
		if vdata.group.units[vdata.unitCur].name then 
			e_unit_name:setText(vdata.group.units[vdata.unitCur].name)
		else
			e_unit_name:setText('')
		end
	end	

	updateCategories()
	updateTypes()
	
	local category,subCategory = getCategory(vdata.type)
	if subCategory then
		category = subCategory
	end
	
    t_heliport:setVisible(false)
    ft_heliport:setVisible(false)
    c_heliport:setVisible(false)
    f_heliport:setVisible(false)
    mt_heliport:setVisible(false)
    sLenght:setVisible(false)
    spLenght:setVisible(false)
    sUnitLenght:setVisible(false)

    if vdata.group then
        local _type = vdata.type
        updateTypes()
        vdata.type = _type
        setTypeItem(vdata.type)
        
		sLenght:setVisible(false)
        spLenght:setVisible(false)
		sUnitLenght:setVisible(false)
        if vdata.category == cdata.heliports or vdata.category == cdata.GrassAirfields then 
            t_heliport:setVisible(true)
			ft_heliport:setVisible(true)
            c_heliport:setVisible(true)
			f_heliport:setVisible(true)
            mt_heliport:setVisible(true)
            if vdata.category == cdata.GrassAirfields then
                sLenght:setVisible(true)
                spLenght:setVisible(true)
                sUnitLenght:setVisible(true)
            end
            fillComboCallnames()            
            if vdata.group.units[1].heliport_callsign_id then
                c_heliport:setText(DB.db.getCallnames(vdata.group.boss.id, 'Helipad')[vdata.group.units[1].heliport_callsign_id].Name);
                f_heliport:setText(vdata.group.units[1].heliport_frequency)
                mt_heliport:setText(cdata.modulationName[vdata.group.units[1].heliport_modulation])
            elseif vdata.group.units[1].grassairfield_callsign_id  then                
                c_heliport:setText(DB.db.getCallnames(vdata.group.boss.id, 'GrassAirfield')[vdata.group.units[1].grassairfield_callsign_id].Name);
                f_heliport:setText(vdata.group.units[1].grassairfield_frequency)
                mt_heliport:setText(cdata.modulationName[vdata.group.units[1].grassairfield_modulation])
            else
                c_heliport:setText('')
                f_heliport:setText('')
                mt_heliport:setText('')
            end;
			
        else
            t_heliport:setVisible(false)
			ft_heliport:setVisible(false)
            c_heliport:setVisible(false)
			f_heliport:setVisible(false)
            mt_heliport:setVisible(false)                      
        end

		if (base.isPlannerMission() == false) then
			e_heading:setEnabled(true)
			d_heading:setEnabled(true)
		end	
		
		if vdata.category == cdata.Personnel
			or vdata.category == cdata.structures 	
			or vdata.category == cdata.helicopters 
			or vdata.category == cdata.planes 
			or vdata.category == cdata.Animals 
			or vdata.category == cdata.vehicles then
			pColorScheme:setVisible(true)  
		else
			pColorScheme:setVisible(false)
		end
		e_name:setText(vdata.group.name) 
		
		updateHeading()
	else
		e_heading:setEnabled(false)
		d_heading:setEnabled(false)		
		
		if vdata.category == cdata.Personnel
			or vdata.category == cdata.structures 	
			or category == cdata.helicopters 
			or category == cdata.planes 
			or vdata.category == cdata.Animals 
			or category == cdata.vehicles then
			pColorScheme:setVisible(true)  
		else
			pColorScheme:setVisible(false)
		end

		ChangeNameforUnit()
    end
     	
	updateCategories()
	updateTypes()
       
    updateLiveries()
	
    updateSuppliers() 
    updateLTAvehiclePanel()
	updateLinkUnitPanel() 
	updatePanelEffects()
    updateVisibleMass()
	updateCargo() 
    updateLenght()
	updateWarehouses()
    updatePositionPreview()
	updateNumUnits()
end	

function hideFullInfo()
	panel_manager_resource.show(false)
	tb_FullInfo:setState(false)
end

-------------------------------------------------------------------------------
--
function updateWarehouses()
    if vdata.group and
        (vdata.category == _("Warehouses") or vdata.category == _("Heliports")
        or vdata.category == _("Grass Airfields") or vdata.category == _('Sea Shelf Objects')) then
        cont_W:setVisible(true)
    else
        cont_W:setVisible(false)
        panel_manager_resource.show(false)
        tb_FullInfo:setState(false)
    end
end
  
function changeEras()
	if updateCountries() == false then
		return false
	end	
	
	updatePanel()
	return true
end  
-------------------------------------------------------------------------------
--
function updateCountries()
	if vdata.group == nil then
		vdata.country = editorManager.getNewGroupCountryName()
	end
	updatePanelData()

	function isCountry(a_country)
		for k, v in base.pairs(vdata.countries) do
			if (v == a_country) then
				return true
			end
		end
		return false
	end
	
	local function getCountryForCoalition(a_coalition)
		for k,v in base.pairs(vdata.countries) do
			if a_coalition == CoalitionData.getCoalitionByContryId(DB.country_by_name[v].WorldID) then
				return vdata.countries[k]
			end
		end
	end

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
		c_country:setText(vdata.country) 
    else
        vdata.country = nil
		
		MsgWindow.warning(_("There are no units available for this criteria.\n              You are using historical mode."),  _('WARNING'), 'OK'):show()
		return false
    end
	
	return true
end

-------------------------------------------------------------------------------
--
function changeCountry(c)	
    local oldCategory = vdata.category;
    
    vdata.country = c
    updateCategories();
 --   updateTypes();
    -- Если страна изменилась, то группа должна быть исключена из старой страны
    -- и заново включена в новую. Соответственно, должны быть обновлены и объекты карты.
    if vdata.group then
        local tbl = vdata.group.boss.static.group
        if tbl then
            for i,v in pairs(tbl) do
                if v == vdata.group then
                    table.remove(tbl, i)
                    break
                end
            end
        end

        -- Помещаем группу в новую страну.
        local c = module_mission.missionCountry[vdata.country]
        table.insert(c.static.group, vdata.group)
        vdata.group.boss = c
        local unit = vdata.group.units[1]
        unit.type = country_category_units[vdata.country][vdata.category][1]

        local udb = DB.unit_by_type[unit.type]
        unit.type = udb.type;
        unit.rate = udb.Rate
        unit.shape_name = udb.ShapeName
        -- Изменяем цвет объектов карты
        vdata.group.color = c.boss.color
		
		if base.MapWindow.isShowHidden(vdata.group) == true then
			module_mission.remove_group_map_objects(vdata.group)
			module_mission.create_group_map_objects(vdata.group)
		end
        panel_units_list.updateRow(vdata.group, vdata.group.units[1]);
        module_mission.relinkChildren(unit)
        
        if (vdata.group) and (vdata.group.units) and (vdata.group.units[1]) then
            vdata.group.units[1].livery_id = nil
        end

    end
    
    c_category:onChange()
end

function onChange_cListLinkUnit(self, a_item)  
    if a_item.id then
        local unit = Mission.unit_by_id[a_item.id]
        
        Mission.unlinkWaypoint(vdata.group.route.points[1])
        Mission.linkWaypoint(vdata.group.route.points[1], nil, unit)
        
		vdata.group.linkOffset = true
--		if vdata.group.linkOffset ~= true then
--			MapWindow.move_group(vdata.group, unit.x, unit.y)
--			MapWindow.move_waypoint(vdata.group, 1, unit.x, unit.y, nil, true);
--		end
		
        module_mission.remove_group_map_objects(vdata.group)
        module_mission.create_group_map_objects(vdata.group) 
    else
        Mission.unlinkWaypoint(vdata.group.route.points[1])
    end  
	
end
    	
-------------------------------------------------------------------------------
--
function updateCategories()
    U.fill_combo(c_category, country_categories[vdata.country])
	
	function isCategory(a_category)
		for k, v in base.pairs(country_categories[vdata.country]) do
			if (v == a_category) then
				return true
			end
		end
		return false
	end
	
    if isCategory(vdata.category) then
        c_category:setText(vdata.category)
    else
        vdata.category = country_categories[vdata.country][1]
    end
end

function fillTypes()
	local country_units = country_category_units[vdata.country][vdata.category] 
    vdata.types = {}
    
	if(vdata.category == _('Structures')) then
		local country_ground_vehicles = country_category_units[vdata.country][_('Ground vehicles')];
		for i,v in pairs(country_ground_vehicles) do
            if  DB.unit_by_type[v].category == "Fortification" then 			
                table.insert(vdata.types, v);
            end
		end
	end;
	 
	for i,v in pairs(country_units) do
		--base.print("--country_units---",vdata.category,DB.unit_by_type[v].category, v)
		if( not(vdata.category == _('Ground vehicles') and DB.unit_by_type[v].category == "Fortification") ) then 
			table.insert(vdata.types, v);
		end
	end

    table.sort(vdata.types, compTypes)
    fill_combo(c_type, vdata.types)  
end

-------------------------------------------------------------------------------
-- update types combo
function updateTypes()
    fillTypes()
    
    local bLast = false
    for k, v in pairs(vdata.types) do
        if (v == vdata.type) then
            bLast = true            
        end
    end
    
    if (bLast == true) then
        setTypeItem(vdata.type)
    else
        vdata.type = vdata.types[next(vdata.types)]
        setTypeItem(vdata.type)
        ChangeNameforUnit()
    end
end


function updatePreviewLivery(a_type, a_country_id)
    if DSWidget and DSWidget.modelObj and DSWidget.modelObj.valid == true then
		local res = false
        local livery_id = vdata.livery_id
        if livery_id ~= nil then			
			res = DSWidget.modelObj:setLivery(livery_id,a_type)
		end
		if not res then
			local season = nil
            if Terrain.getTechSkinByDate then
                -- base.print("---getTechSkinByDate---",module_mission.mission.date.Month, module_mission.mission.date.Day,Terrain.getTechSkinByDate(module_mission.mission.date.Day, module_mission.mission.date.Month))   
                season = Terrain.getTechSkinByDate(module_mission.mission.date.Day, module_mission.mission.date.Month) --- getSeasonLiveryId()
            else
                season = getSeasonLiveryId()
            end
			
			local terrain = TheatreOfWarData.getName()
			--base.print("Terrain name: " .. terrain)

			local country = DB.country_by_id[a_country_id].ShortName
			
			res = setLiveryByCountrySeasonTerrain(a_type, country, season, terrain)
			if not res then
				res = setLiveryByCountrySeasonTerrain(a_type, country, season, nil)
			end
			if not res then
				for k,s in pairs(SEASONS) do
					if s ~= season then
						res = setLiveryByCountrySeasonTerrain(a_type, country, s, nil)
					end
					if res then
						break
					end
				end
			end
			if not res then
				res = setLiveryByCountrySeasonTerrain(a_type, country, nil, terrain)
			end
			if not res then
				res = setLiveryByCountrySeasonTerrain(a_type, nil, season, nil)
			end
			if not res then
				res = DSWidget.modelObj:setLivery("default",a_type) -- default
			end
		end
    end
end

-------------------------------------------------------------------------------
function setGroup(group)
	vdata.group 	= group 
	vdata.country 	= group.boss.name
end

-------------------------------------------------------------------------------
--
function onChange_deadCheckbox(self)
    if vdata.group then
        vdata.group.dead = self:getState()
    else
        self:setState(false)
    end
end

-------------------------------------------------------------------------------
-- disable editing of unsafe elements
function setSafeMode(enable)
	if (enable) then
		local e = not enable
		e_heading:setEnabled(e)
		d_heading:setEnabled(e)
	end
end

-------------------------------------------------------------------------------
--
function updateHeading()
	if vdata.group then
		for k,unit in base.pairs(vdata.group.units) do
			updateHeadingUnit(unit)  
		end
	end
end

function updateHeadingUnit(a_unit)
	local heading = a_unit.heading
	if a_unit.index == 1 then
		a_unit.boss.heading = heading
	end

	local unitMapObject = a_unit.boss.mapObjects.units[a_unit.index]
	local classInfo = MapWindow.getClassifierObject(unitMapObject.classKey)
	
	local angle = MapWindow.headingToAngle(heading)
	
	if OptionsData.getIconsTheme() == 'russian' then
		if classInfo and classInfo.rotatable ~= true then
			if a_unit.index == 1 then
				a_unit.boss.mapObjects.route.points[1].angle = 0
			end
			a_unit.boss.mapObjects.units[a_unit.index].angle = 0 -- в объектах карты храним все в градусах	
		else
			if a_unit.index == 1 then
				a_unit.boss.mapObjects.route.points[1].angle = angle
			end
			a_unit.boss.mapObjects.units[a_unit.index].angle = angle -- в объектах карты храним все в градусах	
		end
	end
	
	if a_unit.boss.mapObjects.units[a_unit.index].picModel then
		a_unit.boss.mapObjects.units[a_unit.index].picModel:setOrientationEuler(angle, 0, 0)
	end
 
	if a_unit.index == vdata.unitCur then
		e_heading:setValue(angle)
		d_heading:setValue(angle)
	end
	
	if a_unit.linkChildrenTZone then
		for i,zoneId in ipairs(a_unit.linkChildrenTZone) do	
			TriggerZoneController.updateHeading(zoneId)		
		end
	end	
	
	module_mission.update_group_map_objects(a_unit.boss) 
end

-------------------------------------------------------------------------------
-- build liveries list
function updateLiveries()
    c_color_scheme:clear()

    local country = DB.country_by_name[vdata.country]
    local selectedItem, firstItem
   
    if vdata.category == cdata.Personnel
		or vdata.category == cdata.structures 
	    or vdata.category == cdata.vehicles then
		   -- добавляем дефолтный, который в livery_id пишет nil
			local item = ListBoxItem.new(_("Default"))		
			item.itemId = nil
			c_color_scheme:insertItem(item) 
	end
	
    local schemes = loadLiveries.loadSchemes(DB.liveryEntryPoint(vdata.type),country.ShortName)
  
    for k, v in pairs(schemes) do
        local item = ListBoxItem.new(v.name)
        item.itemId = v.itemId
        c_color_scheme:insertItem(item) 
    end

	local itemCount = c_color_scheme:getItemCount()
    
	
    if itemCount > 0 then			
        firstItem = c_color_scheme:getItem(0)
    end
        
    if vdata.group and (vdata.group.units) then
		local itemCounter = itemCount - 1
		
        for i = 0, itemCounter do
			local item = c_color_scheme:getItem(i)
			
            if (vdata.group.units[1].livery_id == item.itemId) then
                selectedItem = item
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
    

    if (vdata.group) and (vdata.group.units) and (vdata.group.units[1]) and (vdata.group.units[1].livery_id == nil)  then
        vdata.group.units[1].livery_id = vdata.livery_id;
    end
        
    if vdata.type then
		local country = DB.country_by_name[vdata.country]
        if window and window:getVisible() == true
            and lastPreviewType ~= vdata.type then
            			
            setPreviewType(vdata.type, country.WorldID)
            lastPreviewType = vdata.type
        else
            updatePreviewLivery(vdata.type, country.WorldID)    
        end 
    end
end

function setDefaultLivery(unit)
    local group = unit.boss
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

function fillComboCallnames()
    c_heliport:clear() 
    local countryId = 1
    local category_callsign
    if Mission.missionCountry ~= nil then
        countryId = Mission.missionCountry[country_name]
    end    
    if (vdata.group) then
        countryId = vdata.group.boss.id
        local udb = DB.unit_by_type[vdata.group.units[1].type]
        if udb.category == 'Heliport' then
            category_callsign = 'Helipad'
        else
            category_callsign = 'GrassAirfield'
        end
    end
    local i = 1
    
    for k,v in pairs(DB.db.getCallnames(countryId, category_callsign)) do
        local item = ListBoxItem.new(v.Name)
        item.index = i;
        c_heliport:insertItem(item);
        i = i + 1
    end 

    c_heliport:setText(DB.db.getCallnames(vdata.group.boss.id, category_callsign)[1].Name)
end
function updateLenght()
    local udb = DB.unit_by_type[vdata.type]
    
    if vdata.group and udb.lenght then
        spLenghtUnit:setValue(vdata.group.units[1].lenght or udb.lenght)
    end
end

function updateNumUnits()
	sp_unit:setEnabled(false)
	sp_of:setEnabled(false)
	
	if vdata.group and vdata.category == cdata.heliports and base.isPlannerMission() == false then
		sp_unit:setEnabled(true)
		sp_of:setEnabled(true)
	end
	
	if vdata.group  then		
		sp_unit:setRange(1, #vdata.group.units)
		sp_unit:setValue(vdata.unitCur)
        sp_of:setValue(#vdata.group.units)		
    end
end		

function updateVisibleMass()
    local udb = DB.unit_by_type[vdata.type]
        
    if (vdata.group and udb.minMass and udb.maxMass) then
        eMassUnit = U.createUnitSpinBox(sUnit, eMass, U.weightUnits, udb.minMass, udb.maxMass)
        if udb.minMass == udb.maxMass then
            eMass:setEnabled(false)
            hsMass:setEnabled(false)
        else
            eMass:setEnabled(true)
            hsMass:setEnabled(true)
        end
        updateUnitSystem()
        function eMass:onChange(text)        
            local mass = eMassUnit:getValue()
            hsMass:setValue(mass)
            vdata.group.units[1].mass = mass
        end
        
        function hsMass:onChange()
            local mass = self:getValue()
            eMassUnit:setValue(mass)
            vdata.group.units[1].mass = mass
        end
    
        pSetMass:setVisible(true)
        local mass = vdata.group.units[1].mass or udb.mass
        eMassUnit:setValue(mass)
        hsMass:setRange(udb.minMass, udb.maxMass, 1)
        hsMass:setValue(mass)
        vdata.group.units[1].mass = mass
        if vdata.group.units[1].canCargo == nil then
            vdata.group.units[1].canCargo = true
        end
        vdata.group.units[1].canCargo = vdata.group.units[1].canCargo       
        cbCanCargo:setState(vdata.group.units[1].canCargo)
        
    else
        if (vdata.group) then
            vdata.group.units[1].mass = nil
            vdata.group.units[1].canCargo = nil
        end
        pSetMass:setVisible(false)        
    end
end

function updateCargo() 
	local udb = DB.unit_by_type[vdata.type]
	if udb.deltaWaterline ~= nil then
		pCargo:setVisible(true)
		if (vdata.group) then
			local cargo = vdata.group.units[1].cargo or 100
			spCargo:setValue(cargo)
			vdata.group.units[1].cargo = cargo
		end
	else
		pCargo:setVisible(false)
		if (vdata.group) then
			vdata.group.units[1].cargo = nil
		end
	end	
end

function updatePositionPreview()
	
	local offset = 408
	
	if pEffects:getVisible() == true then
		pEffects:setPosition(0,156)
		offset = offset + 130
	end

	if f_heliport:getVisible() == false then
        offset = offset - 80
    end
	
	if pSetMass:getVisible() == true then
        pSetMass:setPosition(3, offset)
		offset = offset + 100
    end

	if pLTAvehicle:getVisible() == true then
        pLTAvehicle:setPosition(3, offset)
		offset = offset + 50
    end

	if pLinkUnit:getVisible() == true then
        pLinkUnit:setPosition(3, offset)
		offset = offset + 40
    end

    if cont_W:getVisible() == true then
		if c_category:getText() == cdata.GrassAirfields then
			offset = offset + 50 
		end
		cont_W:setPosition(3, offset)
		offset = offset + 230 
    end

    if pColorScheme:getVisible() == true then
        pColorScheme:setPosition(3, offset)
		offset = offset + 60
    end
	
	pPreview:setPosition(14, offset)
    window.box:updateWidgetsBounds()    
end

function updateUnitSystem()
	local unitSystem = OptionsData.getUnits()
	
	eMassUnit:setUnitSystem(unitSystem) 
    spLenghtUnit:setUnitSystem(unitSystem)   
    spLenghtRopeUnit:setUnitSystem(unitSystem)      
end

function initLiveryPreview()
	DSWidget = DemoSceneWidget.new()
	local x, y, w, h = window.box.pPreview.sLiveryPreview:getBounds()    
	window.box.pPreview:insertWidget(DSWidget)
    window.box.pPreview:setBounds(14, 500, w, h)
    DSWidget:setBounds(0, 0, w, h)
	DSWidget:loadScript('Scripts/DemoScenes/staticPreview.lua')
	DSWidget.aspect = w / h --аспект для вычисления вертикального fov
  
	DSWidget.updateClipDistances = function()
		local dist = base.staticPreview.cameraDistance*base.math.exp(base.staticPreview.cameraDistMult)
		--base.scene.cam:setNearClip(base.math.max(dist-DSWidget.modelRadius*1.1, 0.1))
		--base.scene.cam:setFarClip(base.math.max(dist+DSWidget.modelRadius*1.2,1))
	end
	
	DSWidget:addMouseDownCallback(function(self, x, y, button)
		DSWidget.bEncMouseDown = true
		DSWidget.mouseX = x
		DSWidget.mouseY = y
		DSWidget.cameraAngH = base.staticPreview.cameraAngH
		DSWidget.cameraAngV = base.staticPreview.cameraAngV
		local sceneAPI = DSWidget:getScene()
		sceneAPI:setUpdateFunc('staticPreview.payloadPreviewUpdateNoRotate')
		
		self:captureMouse()
	end)
	
	DSWidget:addMouseUpCallback(function(self, x, y, button)
		DSWidget.bEncMouseDown = false	
		self:releaseMouse()
	end)
	
  DSWidget:addMouseMoveCallback(function(self, x, y)
		if DSWidget.bEncMouseDown == true then
			base.staticPreview.cameraAngH = DSWidget.cameraAngH + (DSWidget.mouseX - x) * base.staticPreview.mouseSensitivity
			base.staticPreview.cameraAngV = DSWidget.cameraAngV - (DSWidget.mouseY - y) * base.staticPreview.mouseSensitivity
			
			if base.staticPreview.cameraAngV > base.math.pi * 0.48 then 
				base.staticPreview.cameraAngV = base.math.pi * 0.48
			elseif base.staticPreview.cameraAngV < -base.math.pi * 0.48 then 
				base.staticPreview.cameraAngV = -base.math.pi * 0.48 
			end
		end
	end)
	
	DSWidget:addMouseWheelCallback(function(self, x, y, clicks)
		base.staticPreview.cameraDistMult = base.staticPreview.cameraDistMult - clicks*base.staticPreview.wheelSensitivity
		local multMax = 2.3 - base.math.mod(2.3, base.staticPreview.wheelSensitivity)
		if base.staticPreview.cameraDistMult>multMax then base.staticPreview.cameraDistMult = multMax end
		DSWidget.updateClipDistances()
		
		return true
	end)
end

function uninitialize()
	if DSWidget ~= nil then
        window.box.pPreview:removeWidget(DSWidget)
        DSWidget:destroy()
        DSWidget = nil
        lastPreviewType = nil
	end
end

function setLiveryByCountrySeasonTerrain(a_type, country, season, terrain)
	local path = ""
	if country ~= nil then
		path = country
		--base.print("path country:"..path)
	end
	if season ~= nil then
		if path ~= "" then
			path = path .. "_" .. season
		else
			path = season
		end
		--base.print("path season:"..path)
	end
	if terrain ~= nil then
		if path ~= "" then
			path = path .. "_" .. terrain
		else
			path = terrain
		end
		--base.print("path terrain:"..path)
	end

	return DSWidget.modelObj:setLivery(path,a_type)
end

function setPreviewType(a_type, a_country_id)
    local unitDef = DB.unit_by_type[a_type]
    
    local sceneAPI = DSWidget:getScene()	
    if DSWidget.modelObj ~= nil and DSWidget.modelObj.obj ~= nil then
        sceneAPI.remove(DSWidget.modelObj)
        DSWidget.modelObj = nil
    end

    local shape = U.getShape(unitDef)
	
    if shape then     
		DSWidget.modelObj = sceneAPI:addModel(shape, 0, base.staticPreview.objectHeight, 0)
        
		updatePreviewLivery(a_type, a_country_id)		
               
        if DSWidget.modelObj.valid == true then
            window.box.pPreview:setVisible(true)
            DSWidget.modelObj:setAircraftBoardNumber(base.panel_aircraft.getCurOnboardNumber())
            DSWidget.modelRadius 	= DSWidget.modelObj:getRadius()
            local x0,y0,z0,x1,y1,z1 = DSWidget.modelObj:getBBox()
            DSWidget.modelObj.transform:setPosition(-(x0+x1)*0.5, base.staticPreview.objectHeight - (y0+y1)*0.5, -(z0+z1)*0.5) --выравниваем по центру баундинг бокса
            -- считаем тангенс половины вертиального fov
            -- local vFovTan = base.math.tan(base.math.rad(base.cameraFov*0.5)) / DSWidget.aspect
            -- base.cameraRadius = DSWidget.modelRadius / vFovTan  --base.math.tan(vFov)
            base.staticPreview.cameraDistMult = 0
            base.staticPreview.cameraAngV 	= base.staticPreview.cameraAngVDefault
            base.staticPreview.cameraDistance = DSWidget.modelRadius / base.math.tan(base.math.rad(base.staticPreview.cameraFov*0.5))
            DSWidget.updateClipDistances()
            sceneAPI:setUpdateFunc('staticPreview.payloadPreviewUpdate')
			
			if unitDef then
				if unitDef.encyclopediaAnimation and unitDef.encyclopediaAnimation.args then
					for arg, value in base.pairs(unitDef.encyclopediaAnimation.args) do
						DSWidget.modelObj:setArgument(arg, value)
					end
				end
			end
        else
            window.box.pPreview:setVisible(false)
        end
    else
        window.box.pPreview:setVisible(false)
    end
end

function closeSetPosUnit()
	if vdata.group then
		MapWindow.setState(MapWindow.getPanState())
	else
		MapWindow.setState(MapWindow.getCreatingStaticState())
	end
end

function callback_setPosUnit(a_x, a_y)
	if a_x == nil then
		tbSetPos:setState(false)
		
		closeSetPosUnit()
		return
	end
	if vdata.group then
		if vdata.unitCur > 1 then
			MapWindow.move_unit(vdata.group, vdata.group.units[vdata.unitCur], a_x, a_y)
		else
			MapWindow.move_waypoint(vdata.group, 1, a_x, a_y, nil, true, true, nil)
		end		
	else

		MapWindow.createStatic(a_x, a_y)
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
	

function onSpinUnit(self)
	vdata.unitCur = self:getValue()
	updateUnitCur()
end

function onSpinUnitOf(self)
	local n = self:getValue()
	
	if n < #vdata.group.units then
		for i = #vdata.group.units, n+1, -1 do
			module_mission.remove_unit(vdata.group.units[i])
			--base.panel_units_list.updateRow(vdata.group, vdata.group.units[vdata.unitCur]);
		end
	elseif n > #vdata.group.units then
		for i=#vdata.group.units+1,n do
			-- TODO: проверить смещение
			local offset = 200  
			local heading = vdata.group.units[1].heading    
			local groupX = vdata.group.x - offset * (i - 1)*(base.math.cos(heading))
			local groupY = vdata.group.y - offset * (i - 1)*(base.math.sin(heading))

			local res = MapWindow.checkSurface(vdata.group, groupX, groupY, false)
			if res == false then
				groupX, groupY = MapWindow.findValidStrikePoint(groupX, groupY, nil, 1) 
				if groupX == nil then
					local _n = n-1
					if _n >= 1 then
						sp_of:setValue(_n)
					end
					return
				end
			end;                       

			-- Нужно также добавить соответствующие юниты в миссию
			local name = module_mission.getUnitName(vdata.group.name)
			local unit = module_mission.insert_unit(vdata.group, 
				vdata.group.units[1].type, vdata.group.units[1].skill, i,
				name, groupX, groupY, vdata.group.units[vdata.unitCur].heading)	
			unit.heading = vdata.group.units[vdata.unitCur].heading	

			local udb = DB.unit_by_type[vdata.type]		
			unit.rate = udb.Rate
			unit.shape_name = udb.ShapeName
		end
	end
	vdata.unitCur = #vdata.group.units

	updateUnitCur()
	updateNumUnits()
end

function updateUnitCur()
	for i=1,#vdata.group.units do
	  vdata.group.mapObjects.units[i].currColor = vdata.group.boss.boss.selectGroupColor
	end
	if (vdata.unitCur >= 1) then		
		if vdata.unitCur == 1 then
			vdata.group.mapObjects.route.points[1].currColor = vdata.group.boss.boss.selectUnitColor
		else
			vdata.group.mapObjects.route.points[1].currColor = vdata.group.boss.boss.selectGroupColor			
		end
		
		vdata.group.mapObjects.units[vdata.unitCur].currColor = vdata.group.boss.boss.selectUnitColor
		module_mission.updateHeading(vdata.group, vdata.unitCur)
		module_mission.update_group_map_objects(vdata.group)
	
		local unit = vdata.group.units[vdata.unitCur]
		MapWindow.setSelectedUnit(unit)
		e_unit_name:setText(vdata.group.units[vdata.unitCur].name)
	else
		MapWindow.setSelectedUnit(nil)
		e_unit_name:setText("")
	end
end

function isVisible()
    return window:isVisible()
end  

initModule()