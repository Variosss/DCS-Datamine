local base = _G

module('me_vehicle')

local require   = base.require
local ipairs    = base.ipairs
local next      = base.next

-- Модули LuaGUI
local DialogLoader = base.require('DialogLoader')

-- Модуль сериализации таблицы
local S = base.require('Serializer')

-- Модули Black Shark
local U						= require('me_utilities')  -- Утилиты создания типовых виджетов
local UC				    = require('utils_common')
local MapWindow				= require('me_map_window')
local crutches				= require('me_crutches')  -- temporary crutches
local tabs					= require('me_tabs')
local textutil				= require('textutil')
local GroupVariant			= require('GroupVariant')
local toolbar				= require('me_toolbar')
local MsgWindow				= require('MsgWindow')
local actionDB				= require('me_action_db')
local actionMapObjects		= require('me_action_map_objects')
local actionEditPanel		= require('me_action_edit_panel')
local triggeredActions		= require('me_triggered_actions')
local OptionsData			= require('Options.Data')
local CoalitionController	= require('Mission.CoalitionController')
local panel_showId			= require('me_showId')
local me_db_api				= require('me_db_api')
local panel_aircraft	    = require('me_aircraft')
local panel_static			= require('me_static')
local panel_ship	        = require('me_ship')
local ListBoxItem			= require('ListBoxItem')
local pLoadout_vehicles		= require('me_loadout_vehicles')
local pPayload_vehicles		= require('me_payload_vehicles')
local panel_paramFM         = require('me_paramFM')
local panel_wagons          = require('me_wagons')
local loadoututilsV     	= require('me_loadoututilsVehicles')
local Terrain				= require('terrain')
local mod_mission      		= require('me_mission')
local MeSettings			= require('MeSettings')
local CoalitionData			= require('Mission.CoalitionData')
local Skin          		= require('Skin')
local editorManager         = require('me_editorManager')
local requiredUnits         = require('me_requiredUnits')
local module_mission 		= require('me_mission')
local ProductType			= require('me_ProductType') 
local TriggerZoneController	= require('Mission.TriggerZoneController')
local setCoordPanel 		= require('me_setCoordPanel')

require('i18n').setup(_M)

vdata = { }

-------------------------------------------------------------------------------
--
function initModule()
    -- Неизменные локализуемые данные (при необходимости, их можно будет вынести в отдельный файл,
    -- но IMHO удобнее видеть их прямо здесь, чтобы представлять себе структуру панели)
    cdata = 
    {
		title 					= _('VEHICLE GROUP'),
		condition 				= _('CONDITION'),
		probability 			= _('%'),	  
		country 				= _('COUNTRY'), 
		name 					= _('NAME'),
		hidden 					= _('HIDDEN ON MAP'),
		hiddenOnPlanner 		= _('HIDDEN ON PLANNER'),
		hiddenOnMFD	 			= _('HIDDEN ON MFD'),
		lateActivation 			= _('LATE ACTIVATION'),
		visibleBeforeStart 		= _('VISIBLE bef. ACTIVATION'),
		playerCanDrive 			= _('PLAYER CAN DRIVE'),
		unit 					= _('UNIT'), 
		unit_of 				= _('OF'),
		type 					= _('TYPE'), 
		unitName 				= _('UNIT NAME'),
		skill 					= _('SKILL'),
		skillList 				= crutches.getSkillsNames(false),
		static_object 			= 'Static Object',
		category 				= _("CATEGORY"),
		heading 				= _('HEADING'),
		manualHeading 			= _('INITIAL\nHEADING'),
		new_group_name 			= _('New Vehicle Group'),
		new_group_task 			= _('Ground Nothing'),
		placeUnitOnLand 		= _('You are trying to place new vehicle on the water.\nPlease move group to allow new vehicle to be created on land.'),
		toLargeGroup 			= _('Too large a group for loading, reduce?'),
		yes						= _('YES'),
		no						= _('NO'),
		ok						= _('OK'),
		warning				    = _('WARNING'),
		deleteAllTasks 			= _('Transportation is not available. Delete all tasks of transportation?'),
		allTasksWillDeleted		= _('All task will deleted'),
        unit1                   = _('Unit #001'),
		uncontrollable 			= _('GAME MASTER ONLY'),
		all						= _("ALL"),
		combat	 				= _("COMBAT"),
		RequiredUnits			= _("Required Units"),
		subCategory				= _("SUB. CAT."),
		ColdAtStart				= _("COLD AT START"),
	}
    
    if ProductType.getType() == "LOFAC" then
        cdata.unit1         = _("Unit #1-LOFAC")
        cdata.unitName 		= _('UNIT NAME-LOFAC')
        cdata.unit          = _("UNIT-LOFAC")
    end
	
	if base.__PRODUCT_ID__ == 2 then
        cdata.uncontrollable   = _("SUPERVISOR ONLY")
    end
	
	cat = {}
	cat['Air Defence'] 		= _('AIR DEFENCE_CAT', 'Air Defence')
	cat['Armor'] 			= _('ARMOR_CAT', 'Armor')
	cat['Artillery'] 		= _('ARTILLERY_CAT', 'Artillery')	
	cat['Fortification'] 	= _('FORTIFICATION_CAT', 'Fortification')	
	cat['Infantry'] 		= _('INFANTRY_CAT', 'Infantry')	
	cat['Unarmed'] 			= _('UNARMED_CAT', 'Unarmed')
    cat['Train'] 			= _('TRAIN_CAT', 'Train')
	cat['MissilesSS'] 		= _('MISSILESSS_CAT', 'MissilesSS')
	
	catsAll = {}
	catsAll['Air Defence'] 	= {'Air Defence'}
	catsAll['Armor']		= {'Armor'}
	catsAll['Artillery']	= {'Artillery'}
	catsAll['Fortification']= {'Fortification'}
	catsAll['Infantry']		= {'Infantry'}
	catsAll['Unarmed']		= {'Unarmed'}
	catsAll['Train']		= {'Train'}
	catsAll['MissilesSS']	= {'MissilesSS'}

	
	subCat = {}
	--Air Defence
	subCat['AAA'] 					= _('AAA_SUBCAT', 'AAA')
	subCat['SP AAA'] 				= _('Self-propelled AAA_SUBCAT', 'Self-propelled AAA')
	subCat['EW Radar'] 				= _('EW Radar_SUBCAT', 'EW Radar')
	subCat['Optical Tracker'] 		= _('Optical Tracker_SUBCAT', 'Optical Tracker')
	subCat['Search & Track Radar'] 	= _('Search & Track Radar_SUBCAT', 'Search & Track Radar')	
	subCat['Launcher'] 				= _('Launcher_SUBCAT', 'Launcher')
	subCat['Search Radar'] 			= _('Search Radar_SUBCAT', 'Search Radar')
	subCat['Tracking Radar'] 		= _('Tracking Radar_SUBCAT', 'Tracking Radar')	
	subCat['Generator'] 			= _('Generator_SUBCAT', 'Generator')
	subCat['SAM SHORAD'] 			= _('SAM SHORAD_SUBCAT', 'SAM SHORAD')
	subCat['CommandControl'] 		= _('Command & Control_SUBCAT', 'Command & Control')
	subCat['SAM TEL'] 				= _('SAM TEL_SUBCAT', 'SAM TEL')
	subCat['MANPADS'] 				= _('MANPADS_SUBCAT', 'MANPADS')
	subCat['Player Drivable'] 		= _('Player Drivable_SUBCAT', 'Player Drivable')
	
	--Armor
	subCat['ArmouredPC'] 			= _('Armoured Personel Carrier_SUBCAT', 'Armoured Personel Carrier')
	subCat['InfantryFV'] 			= _('Infantry Fighting Vehicle_SUBCAT', 'Infantry Fighting Vehicle')
	subCat['Tank'] 					= _('Tank_SUBCAT', 'Tank')
	subCat['MBT'] 					= _('Main Battle Tank_SUBCAT', 'Main Battle Tank')
	subCat['ScoutRecon'] 		    = _('Scout & Recon_SUBCAT', 'Scout & Recon')
	subCat['SP ATGM']				= _('Self-propelled ATGM_SUBCAT', 'Self-propelled ATGM')
	subCat['SP Gun']				= _('Self-Propelled Gun_SUBCAT', 'Self-Propelled Gun')
	subCat['CommandControl'] 		= _('Command & Control_SUBCAT', 'Command & Control')
	subCat['Player Drivable'] 		= _('Player Drivable_SUBCAT', 'Player Drivable')
	
	--Unarmed
	subCat['SupportLogistics'] 		= _('Support & Logistics_SUBCAT', 'Support & Logistics')
	subCat['ScoutReconU'] 			= _('Scout & Recon_SUBCAT', 'Scout & Recon')
	subCat['Civilian'] 				= _('Civilian Vehicle_SUBCAT', 'Civilian Vehicle')
	subCat['Animals'] 				= _('Animals_SUBCAT', 'Animals')
	subCat['CommandControlU'] 		= _('Command & Control_SUBCAT', 'Command & Control')
	subCat['Player Drivable'] 		= _('Player Drivable_SUBCAT', 'Player Drivable')
	

	--MissilesSS
	subCat['SSM'] 					= _('SSM_SUBCAT', 'SSM')
	subCat['RadarSSM'] 				= _('RadarSSM_SUBCAT', 'Radar SSM')
	subCat['Player Drivable'] 		= _('Player Drivable_SUBCAT', 'Player Drivable')
	
	--Artillery
	subCat['SPA'] 					= _('Self-propelled artillery_SUBCAT', 'Self-propelled artillery')
	subCat['Mortar'] 				= _('Mortar_SUBCAT', 'Mortar')	
	subCat['MRL'] 					= _('Multiple Rocket Launcher_SUBCAT', 'Multiple Rocket Launcher')
	subCat['SP GunA']				= _('Self-Propelled Gun_SUBCAT', 'Self-Propelled Gun')
	subCat['CommandControlA'] 		= _('Command & Control_SUBCAT', 'Command & Control')
	subCat['Player Drivable'] 		= _('Player Drivable_SUBCAT', 'Player Drivable')
	subCat['Howitzer'] 				= _('Howitzer_SUBCAT', 'Howitzer')
	
	
	--FORTIFICATION
	subCat['Buildings'] 			= _('Buildings_SUBCAT', 'Buildings')
	subCat['Pillbox'] 				= _('Pillbox_SUBCAT', 'Pillbox')
	subCat['Player Drivable'] 		= _('Player Drivable_SUBCAT', 'Player Drivable')

	subCatByCat = {}
	subCatByCat["Air Defence"] 	= {'AAA', 'SP AAA', 'EW Radar', 'Optical Tracker', 
								'Search & Track Radar', 'Search Radar', 'Tracking Radar',
								'Launcher', 'Generator', 'SAM SHORAD',
									'CommandControl', 'SAM TEL', 'MANPADS', 'Player Drivable'}
									
	subCatByCat["Armor"] 		= {'ArmouredPC', 'InfantryFV', 'Tank', 'MBT', 'ScoutRecon',
								'SP ATGM', 'CommandControl', 'SP Gun', 'Player Drivable'}
	subCatByCat["Unarmed"] 		= {'SupportLogistics', 'ScoutReconU', 'Civilian','Animals', 'CommandControlU', 'Player Drivable'}
	subCatByCat["MissilesSS"] 	= {'SSM', 'RadarSSM', 'Player Drivable'}
	subCatByCat["Artillery"] 	= {'SPA', 'Mortar', 'SP GunA', 'MRL', 'CommandControlA', 'Player Drivable', 'Howitzer'}
	subCatByCat["Fortification"]= {'Buildings', 'Pillbox', 'Player Drivable'}
								
	tagsBySubCat = {}
	--Air Defence
	tagsBySubCat['AAA'] 				= {'AAA'}
	tagsBySubCat['SP AAA'] 				= {'SP AAA'}
	tagsBySubCat['EW Radar'] 			= {'EW Radar'}
	tagsBySubCat['Optical Tracker'] 	= {'Optical Tracker'}
	tagsBySubCat['Search & Track Radar']= {'Search & Track Radar'}	
	tagsBySubCat['Launcher'] 			= {'Launcher'}
	tagsBySubCat['Search Radar'] 		= {'Search Radar'}
	tagsBySubCat['Tracking Radar'] 		= {'Tracking Radar'}	
	tagsBySubCat['Generator'] 			= {'Generator'}
	tagsBySubCat['SAM SHORAD'] 			= {'SAM SHORAD'}
	tagsBySubCat['CommandControl']		= {'Command & Control'}
	tagsBySubCat['SAM TEL'] 			= {'SAM TEL'}
	tagsBySubCat['MANPADS'] 			= {'MANPADS'}
	
	--Armor
	tagsBySubCat['ArmouredPC'] 			= {'APC'}
	tagsBySubCat['InfantryFV'] 			= {'IFV'}
	tagsBySubCat['Tank'] 				= {'Tank'}
	tagsBySubCat['MBT'] 				= {'MBT'}
	tagsBySubCat['ScoutRecon'] 			= {'Scout/Recon'}
	tagsBySubCat['SP ATGM'] 			= {'SP ATGM'}
	tagsBySubCat['SP Gun'] 				= {'SPG'}
	
	--Unarmed
	tagsBySubCat['SupportLogistics']    = {'Support & Logistics'}
	tagsBySubCat['ScoutReconU'] 		= {'Scout/Recon'}
	tagsBySubCat['Civilian'] 			= {'Civilian'}
	tagsBySubCat['Animals'] 			= {'Animals'}
	tagsBySubCat['CommandControlU'] 	= {'Command & Control'}
	
	--MissilesSS
	tagsBySubCat['SSM'] 				= {'SSM'}
	tagsBySubCat['RadarSSM'] 			= {'RadarSSM'}
	
	--Artillery
	tagsBySubCat['SPA'] 				= {'SPA'}
	tagsBySubCat['Mortar'] 				= {'Mortar'}
	tagsBySubCat['SP GunA'] 			= {'SPG'}
	tagsBySubCat['MRL'] 				= {'MRL'}
	tagsBySubCat['CommandControlA'] 	= {'Command & Control'}
	tagsBySubCat['Howitzer'] 			= {'Howitzer'}
	
	
	--FORTIFICATION
	tagsBySubCat['Buildings'] 			= {'Buildings'}
	tagsBySubCat['Pillbox'] 			= {'Pillbox'}
	
	tagsBySubCat['Player Drivable'] 	= {'Player Drivable'}

    -- Переменные загружаемые/сохраняемые данные (путь к файлу - cdata.vdata_file)
    vdata.country = 'Russia'
    vdata.countries = {'Russia', 'UK', 'Ukraine', 'USA',}
    vdata.name = _('Ground_g', 'Ground').."-1"
    vdata.unit = {number = 1, cur = 1}
    -- Далее для каждого юнита в группе
    vdata.types = {'T-80U',} -- Типы должны соответствовать стране и задаче
    vdata.skills = { _('Average'),}
    vdata.lastHeading = 0
    SafeMode_ = true
end;

local country_vehicle_list = {}

function updateUnitCur()
	if vdata.group then
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
		if vdata.group.units[vdata.unit.cur].name then 
			e_unit_name:setText(vdata.group.units[vdata.unit.cur].name)
		else
			e_unit_name:setText('')
		end
		base.panel_route.vdata.unit = vdata.group.units[vdata.unit.cur]
		base.panel_route.update()
		pPayload_vehicles.setUnit(vdata.group.units[vdata.unit.cur])
		module_mission.updateHeading(vdata.group, vdata.unit.cur);
	end
	updateCategory()
	fillSubCategory()
	updateSubCategory()
	setTypeItem(vdata.types[vdata.unit.cur]) 
	c_skill:setText(vdata.skills[vdata.unit.cur])
	playerCanDriveCheckbox:setState(vdata.group.units[vdata.unit.cur].playerCanDrive)
	coldAtStartCheckbox:setState(vdata.group.units[vdata.unit.cur].coldAtStart or false)
  
	local unitDef = me_db_api.unit_by_type[me_db_api.getDisplayNameByName(vdata.types[vdata.unit.cur])]
	checkPlayerCanDrive(unitDef)
	updateTabs()
end

function create(x, y, w, h)
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_vehicle_group.dlg', cdata)
	window:setBounds(x, y, w, h)
	
	w_ = w
	
	btnShowId = DialogLoader.findWidgetByName(window, "btnShowId")
	btnShowId.onChange = onChange_ShowId

	-- Здесь и далее callback-функции сразу привязываются к соответствующим виджетам, 
	-- чтобы вся логика их создания находилась в одном месте.
	function window:onClose()
		pPayload_vehicles.show(false)
		base.panel_paramFM.show(false)  
		base.panel_radio.show(false)
		base.panel_route.show(false)
		base.panel_targeting.show(false)
		base.panel_wagons.show(false)
		base.panel_summary.show(false)
		base.panel_triggered_actions.show(false)
		MapWindow.setState(MapWindow.getPanState())
		show(false)
		toolbar.setVehicleButtonState(false)
		base.panel_units_list.show(false);
		MapWindow.unselectAll();
		MapWindow.expand()
	end
	

	-- Country
	c_country = window.c_country

	function c_country:onChange()
		setOldTypesCategoryForTransport(nil,nil,true)
		changeCountry(self:getText())
		groupUnitsTransportCheck() 
	
		if vdata.group then
			update()
		end		
	end

	-- Name
	e_name = window.e_name
	e_name:setText(vdata.name)
	
	function e_name:onChange()
		if module_mission.isGroupFreeName(self:getText()) ~= true then
			self:setSkin(eNameRedSkin)
		else
			self:setSkin(eNameWhiteSkin)
		end	
		vdata.name = module_mission.check_group_name(self:getText())
		if vdata.group then
			module_mission.renameGroup(vdata.group, vdata.name)
			base.panel_units_list.updateGroup(vdata.group)
		end
	end

	-- Unit
	sp_unit = window.sp_unit
	sp_unit:setRange(1,vdata.unit.number)
	sp_unit:setValue(vdata.unit.cur)
	
	function sp_unit:onChange()
	   vdata.unit.cur = self:getValue()
	  -- base.print("---sp_unit:onChange()---", vdata.unit.cur)
	   updateUnitCur()	  
	end

	
	local maxUnitCount = 99
	sp_of = window.sp_of
	sp_of:setRange(1, maxUnitCount)
	sp_of:setValue(vdata.unit.number)

	function sp_of:onChange()
		changeUnitsCount(self:getValue())
		groupUnitsTransportCheck()
		updateTabs()
		updateRequiredUnits()
	end
	
	-- Category
	c_category = window.c_category
	c_category.onChange = onChangeCategory
	
	c_subCategory = window.c_subCategory
	c_subCategory.onChange = onChangeSubCategory

	-- Type
	c_type = window.c_type
	
	function c_type:onChange()
		setOldTypesCategoryForTransport(vdata.types[vdata.unit.cur],vdata.category);
		changeType(self:getSelectedItem().type )
		groupUnitsTransportCheck()
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
		if vdata.group then
			local group = vdata.group
			local unit = group.units[vdata.unit.cur]
			if unit then
				name = module_mission.check_unit_name(name)
				module_mission.renameUnit(unit, name) 
			end
		end
	end

	-- Skill    
	c_skill = window.c_skill
	
	function c_skill:onChange()
	  vdata.skills[vdata.unit.cur] = self:getText()
	  if vdata.group then
		vdata.group.units[vdata.unit.cur].skill = vdata.skills[vdata.unit.cur]
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
		
		vdata.group.units[vdata.unit.cur].heading = U.toRadians(value)
		vdata.lastHeading = U.toRadians(value)
		d_heading:setValue(value)   
		updateHeading()
	end
	
	d_heading = window.d_heading

	function d_heading:onChange()   
		vdata.group.units[vdata.unit.cur].heading = U.toRadians(self:getValue())
		vdata.lastHeading = U.toRadians(self:getValue())
		sp_heading:setValue(base.math.floor(self:getValue() + 0.5))
		updateHeading()
	end
	
	manualCheckbox = window.manualHeading
	function manualCheckbox:onChange()   
		if vdata.group then
			vdata.group.manualHeading = self:getState()  
			updateHeading()
		end
	end
	
	hiddenCheckbox = window.hiddenCheckbox
	hiddenCheckbox.onChange = MapWindow.OnHiddenCheckboxChange;
	
	lateActivationCheckbox = window.lateActivationCheckbox
	
	function lateActivationCheckbox:onChange()
	  if vdata.group then
		vdata.group.lateActivation = self:getState()
		vdata.group.route.routeRelativeTOT = self:getState()
		base.panel_route.onLateActivationChanged()
		base.panel_summary.updateStartTime()
		sp_probability:setEnabled(not vdata.group.lateActivation)

	  end
	end
	
	cbHiddenOnPlanner = window.cbHiddenOnPlanner
	cbHiddenOnPlanner.onChange 		= onChange_cbHiddenOnPlanner
	
	cbHiddenOnMFD = window.cbHiddenOnMFD
	cbHiddenOnMFD.onChange 		= onChange_cbHiddenOnMFD	
	
	playerCanDriveCheckbox = window.playerCanDriveCheckbox
	
	function playerCanDriveCheckbox:onChange()
		if vdata.group then
			vdata.group.units[vdata.unit.cur].playerCanDrive = self:getState()
		else
			self:setState(false)
		end
	end
	
	coldAtStartCheckbox = window.coldAtStartCheckbox
	function coldAtStartCheckbox:onChange()
		if vdata.group then
			vdata.group.units[vdata.unit.cur].coldAtStart = self:getState()
		else
			self:setState(false)
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
	
	probabilityLabel = window.probabilityLabel
	
	groupVariant = GroupVariant.new(window)
	
	local cx, cy, cw, ch = window:getClientRect()
	
	_tabs = tabs.createUnitTabs('vehicle', window, 0, ch - U.widget_h - 9)
	
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
	
	btnRequiredUnits = window.btnRequiredUnits
	btnRequiredUnits.onChange = onChange_btnRequiredUnits
	
	panelSkins		= window.panelSkins
	eNameWhiteSkin	= panelSkins.eNameWhite:getSkin()
	eNameRedSkin 	= panelSkins.eNameRed:getSkin()
	
	btnAdd			= window.btnAdd
	btnDel			= window.btnDel
	
	btnAdd.onChange = onChange_btnAdd
	btnDel.onChange = onChange_btnDel
	
	tbSetPos = window.tbSetPos
	tbSetPos.onChange = onChange_tbSetPos
	
	if base.__PRODUCT_ID__ ~= 2 then
		tbSetPos:setVisible(false)
	end
end

function onChange_btnRequiredUnits()
	local units = vdata.group.units
    if units[vdata.unit.cur] then
		local unitDef = me_db_api.unit_by_type[units[vdata.unit.cur].type]


		if unitDef.WS.requiredUnits then
			requiredUnits.show(true, 'Consumer', units[vdata.unit.cur])
		elseif units[vdata.unit.cur].linksConsumers then
			requiredUnits.show(true, 'Source', units[vdata.unit.cur])
		end	

	end
end

-- cv_list[countryName][category][subCategory][type, in_service, out_of_service]
function getCountryVehicleListEras() 
	if cv_list == nil then
		cv_list = {}
		--local test = {}
		for i,v in base.pairs(me_db_api.db.Countries) do
			cv_list[v.Name] = {}

			for j,u in base.pairs(v.Units.Cars.Car) do
				local car = me_db_api.unit_by_type[u.Name]
				if not car then 
				--	base.print("check unit ",u.Name,v.Name)
				else
					local categories 
					if car.tags then
						categories = me_db_api.hasTags(car.tags, catsAll)
					else
						categories = {car.category}
						base.print("unit no tags ",u.Name,v.Name)
					end	
					
					for k, category in base.ipairs(categories) do
						if category ~= 'Train' then
							cv_list[v.Name][category] = cv_list[v.Name][category] or {}	
							cv_list[v.Name][category]["All"] = cv_list[v.Name][category]["All"] or {}							
							local tmp_in, tmp_out = me_db_api.db.getYearsLocal(car.type, v.OldID)	
							local unitInfo = {type = car.type, tags = car.tags, in_service = tmp_in or 0, out_of_service = tmp_out or 40000}
							base.table.insert(cv_list[v.Name][category]["All"], unitInfo)
						--	test[car.type] = test[car.type] or {}
							--test[car.type]["All"] = test[car.type]["All"] or {}
						--	base.table.insert(test[car.type]["All"],v.Name)
							
							if subCatByCat[category] and car.tags then
								local subCatTags = {}
								for k,v in base.pairs(subCatByCat[category]) do
									subCatTags[v] = tagsBySubCat[v]
								end
								local subCategories = me_db_api.hasTags(car.tags, subCatTags, car.enablePlayerCanDrive)
								for k, subCategory in base.ipairs(subCategories) do
									cv_list[v.Name][category][subCategory] = cv_list[v.Name][category][subCategory] or {}
									base.table.insert(cv_list[v.Name][category][subCategory], unitInfo)
								end
							end
						end	
					end
				end
			end
			
			if me_db_api.db.Units.Cars.Train then
				local car = me_db_api.unit_by_type[me_db_api.db.Units.Cars.Train.type]
				cv_list[v.Name]["Train"] = cv_list[v.Name]["Train"] or {}
				cv_list[v.Name]["Train"]["All"] = cv_list[v.Name]["Train"]["All"] or {}
				--base.print("----train---",car.type)	
				local tmp_in, tmp_out = me_db_api.db.getYearsLocal(car.type, v.OldID)				
				base.table.insert(cv_list[v.Name]["Train"]["All"], {type = car.type, tags = car.tags, in_service = tmp_in or 0, out_of_service = tmp_out or 40000})
			end	
			
			function compTableType(a_tbl1, a_tbl2)
				local unitDef1 = me_db_api.unit_by_type[a_tbl1.type]
				local unitDef2 = me_db_api.unit_by_type[a_tbl2.type]
				
				local s1 = unitDef1.DisplayName
				local s2 = unitDef2.DisplayName
				if (base.type(s1) == 'string') and (base.type(s2) == 'string') then
					return textutil.Utf8Compare(s1, s2)
				end;
				return s1 < s2;       
			end
			
			for cat, subCat in base.pairs(cv_list[v.Name]) do
			--	base.print("--subCat--")
				for subCatName, icat in base.pairs(subCat) do
			--		base.print("--sort--",v.Name,cat,subCatName)
					base.table.sort(cv_list[v.Name][cat][subCatName], compTableType)
				end
			end
		end
		--[[
		function saveInFile(a_table, a_nameTable, a_path)
			local S 				= require('Serializer')
			local f = base.assert(base.io.open(a_path, 'w'))
			if f then
				local sr = S.new(f) 
				sr:serialize_simple2(a_nameTable, a_table)
				f:close()
			end
		end
		saveInFile(test,"Car","e:\\Car.lua")
		]]
	end
	
--	base.U.traverseTable(cv_list)
--	base.print("---gggg---")
	return cv_list
end

function onChange_btnAdd()
	if vdata.group then
		local offset = -20  
		local heading = vdata.group.units[1].heading    
		local groupX = vdata.group.units[vdata.unit.cur].x - offset*(base.math.cos(heading))
		local groupY = vdata.group.units[vdata.unit.cur].y - offset*(base.math.sin(heading))

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
		base.table.insert(vdata.types, vdata.unit.cur, vdata.types[vdata.unit.cur])
		base.table.insert(vdata.skills, vdata.unit.cur, vdata.skills[vdata.unit.cur])
		-- Нужно также добавить соответствующие юниты в миссию
		local name = module_mission.getUnitName(vdata.group.name)
		local unit = module_mission.insert_unit(vdata.group, 
			vdata.types[vdata.unit.cur], vdata.skills[vdata.unit.cur], vdata.unit.cur,
			name, groupX, groupY, vdata.group.units[vdata.unit.cur].heading,nil, vdata.group.units[vdata.unit.cur].livery_id)	
		unit.heading = vdata.group.units[vdata.unit.cur].heading
		unit.playerCanDrive = vdata.group.units[vdata.unit.cur+1].playerCanDrive
		unit.coldAtStart = vdata.group.units[vdata.unit.cur+1].coldAtStart
		if 'On Road' == vdata.group.route.points[1].type.action then 
			base.panel_route.UpdateGroupOnRoad(vdata.group)
		end			

		if vdata.unit.cur == 1  then
			vdata.group.x = vdata.group.units[1].x
			vdata.group.y = vdata.group.units[1].y
			
			vdata.group.route.points[1].x = vdata.group.units[1].x
			vdata.group.route.points[1].y = vdata.group.units[1].y
		end
		
		module_mission.remove_group_map_objects(vdata.group)
		module_mission.create_group_map_objects(vdata.group)

		sp_of:setValue(#vdata.group.units)
		vdata.unit.number = #vdata.group.units
	--	vdata.unit.cur = vdata.unit.number
		setTypeItem(vdata.types[vdata.unit.cur])
		if vdata.group then
		for i=1,vdata.unit.number do
		  vdata.group.mapObjects.units[i].currColor = vdata.group.boss.boss.selectGroupColor
		end
		vdata.group.mapObjects.route.points[1].currColor = vdata.group.boss.boss.selectGroupColor
		vdata.group.mapObjects.units[vdata.unit.cur].currColor = vdata.group.boss.boss.selectUnitColor
		module_mission.updateHeading(vdata.group, vdata.unit.cur)
		module_mission.update_group_map_objects(vdata.group)
		e_unit_name:setText(vdata.group.units[vdata.unit.cur].name)
		local unit = vdata.group.units[vdata.unit.cur]
		base.panel_route.vdata.unit = unit	
		base.panel_route.update()
		pPayload_vehicles.setUnit(unit)
		if (vdata.unit.cur > 1) then
			MapWindow.setSelectedUnit(unit)
		else
			MapWindow.setSelectedUnit(nil)
		end

		end
		sp_unit:setRange(1, vdata.unit.number)
		sp_unit:setValue(vdata.unit.cur)
		updateCategory()
		fillSubCategory()
		updateSubCategory()
		c_skill:setText(vdata.skills[vdata.unit.cur]) 

		updateUnitCur()

		local unitDef = me_db_api.unit_by_type[vdata.types[vdata.unit.cur] ]
		checkPlayerCanDrive(unitDef)
	end
end

function onChange_btnDel()
	if vdata.group then
		if #vdata.group.units < 2 then
			return
		end
		base.table.remove(vdata.types, vdata.unit.cur)
		base.table.remove(vdata.skills, vdata.unit.cur)

		-- Нужно также удалить соответствующие юниты из миссии
		module_mission.remove_unit(vdata.group.units[vdata.unit.cur])

		if vdata.unit.cur == 1  then
			vdata.group.x = vdata.group.units[1].x
			vdata.group.y = vdata.group.units[1].y
			
			vdata.group.route.points[1].x = vdata.group.units[1].x
			vdata.group.route.points[1].y = vdata.group.units[1].y
		end
		
		base.panel_units_list.updateRow(vdata.group, vdata.group.units[vdata.unit.cur])

		sp_of:setValue(#vdata.group.units)
		vdata.unit.number = #vdata.group.units
		if vdata.unit.cur > vdata.unit.number then
			vdata.unit.cur = vdata.unit.number
		end
		
		setTypeItem(vdata.types[vdata.unit.cur])
		
		if vdata.group then
			for i=1,vdata.unit.number do
			  vdata.group.mapObjects.units[i].currColor = vdata.group.boss.boss.selectGroupColor
			end
			vdata.group.mapObjects.route.points[1].currColor = vdata.group.boss.boss.selectGroupColor
			vdata.group.mapObjects.units[vdata.unit.cur].currColor = vdata.group.boss.boss.selectUnitColor
			module_mission.updateHeading(vdata.group, vdata.unit.cur)
			module_mission.update_group_map_objects(vdata.group)
			e_unit_name:setText(vdata.group.units[vdata.unit.cur].name)
			local unit = vdata.group.units[vdata.unit.cur]
			base.panel_route.vdata.unit = unit	
			base.panel_route.update()
			pPayload_vehicles.setUnit(unit)
			if (vdata.unit.cur > 1) then
				MapWindow.setSelectedUnit(unit)
			else
				MapWindow.setSelectedUnit(nil)
			end
		end
		sp_unit:setRange(1, vdata.unit.number)
		sp_unit:setValue(vdata.unit.cur)
		updateCategory()
		fillSubCategory()
		updateSubCategory()
		c_skill:setText(vdata.skills[vdata.unit.cur]) 

		module_mission.remove_group_map_objects(vdata.group)
		module_mission.create_group_map_objects(vdata.group)
		
		
		updateUnitCur()
		
		local unitDef = me_db_api.unit_by_type[vdata.types[vdata.unit.cur] ]
		checkPlayerCanDrive(unitDef)
	end	
end

function changeEras()
	if updateCountries() == false then
		return false
	end	

	return true
end 
	
function closeSetPosUnit()
	if vdata.group then
		MapWindow.setState(MapWindow.getPanState())
	else
		MapWindow.setState(MapWindow.getCreatingVehicleState())
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

		MapWindow.createVehicle(a_x, a_y)
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
--заполняем список стран и получаем данные по их юнитам
function updateCountries()
	if vdata.group == nil then
		vdata.country, vdata.coalition = editorManager.getNewGroupCountryName()
	end
	local Countries = CoalitionController.getActiveCountries()
	-- Нужно проверить страны на наличие машинок и исключить лишние
	vdata.countries = {}
	country_vehicle_list = {}
	country_category_list = {}
	country_subCategory_list = {}
	
	local list = getCountryVehicleListEras()
	local Year = mod_mission.mission.date.Year
	local unitInGroup 
	if vdata.group then
		unitInGroup = {}
		for k,v in base.pairs(vdata.group.units) do
			unitInGroup[v.type] = v.type
		end
	end
	
	if (MeSettings.getShowEras() == true) then
		window:setText(cdata.title.." - "..Year)
	else
		window:setText(cdata.title)
	end

	local function checkCountry(a_country)
		local result = false
		local tmpCat = {}
		for category, subCats in base.pairs(list[a_country]) do
			for subCatName, subCat in base.pairs(subCats) do	
				for kkk, tbl in base.ipairs(subCat) do	
					if (MeSettings.getShowEras() ~= true)
						or ((unitInGroup and unitInGroup[tbl.type] ~= nil) 
							or (MeSettings.getShowEras() == true and tbl.in_service <= Year and Year <= tbl.out_of_service)) then
						country_vehicle_list[a_country] = country_vehicle_list[a_country] or {}
						country_vehicle_list[a_country][category] = country_vehicle_list[a_country][category] or {}
						country_vehicle_list[a_country][category][subCatName] = country_vehicle_list[a_country][category][subCatName] or {}					
						
						if not tmpCat[category] and category ~= "Locomotive" and category ~= "Carriage" then				
							tmpCat[category] = {}
							tmpCat[category].id = category	
							tmpCat[category].name = cat[category]	--DisplayName
							base.table.insert(country_category_list[a_country], tmpCat[category])	
						end	

						base.table.insert(country_vehicle_list[a_country][category][subCatName], tbl.type)

						
						--base.print("---checkCountry--",a_country, vdata.group and vdata.group.type, tbl.type, tbl.in_service, tbl.out_of_service)
						result = true	
					end
				end
			end	
		end
		return result
	end
	
	local function compTable(tab1, tab2)
		local s1 = tab1.name
		local s2 = tab2.name
		if (base.type(s1) == 'string') and (base.type(s2) == 'string') then
			return textutil.Utf8Compare(s1, s2)
		end;
		return s1 < s2;       
	end


	for i=1,#Countries do
		local tmpCat = {}
		country_category_list[Countries[i]] = {}
		if checkCountry(Countries[i], tmpCat) == true then			
			base.table.insert(vdata.countries,  Countries[i])
		end
		base.table.sort(country_category_list[Countries[i]], compTable)
	end	
			
	if #vdata.countries == 0 then
		base.panel_route.show(false)
		MsgWindow.warning(_("There are no units available for this criteria.\n              You are using historical mode."),  _('WARNING'), 'OK'):show()
		return false
	end

	fillPanel()
	return true
end

function fillPanel()
	local function fill_combo_countries(combo, t)    
        combo:clear()  
		if not t then
			combo:setText("")
			return
		end 
		for i, v in ipairs(t) do
			if me_db_api.country_by_name[v].hide ~= true then
				local item = ListBoxItem.new(v)
			  
				local coalition = CoalitionData.getCoalitionByContryId(me_db_api.country_by_name[v].WorldID)
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
					vdata.country = getCountryForCoalition(vdata.coalition)
					if vdata.country == nil then
						local item = c_country:getItem(0)
						if item then
							vdata.country = item:getText()
						end
					end
				else
					local item = c_country:getItem(0)
					if item then
						vdata.country = item:getText()
					end
				end
			end
		else
			local item = c_country:getItem(0)
			if item then
				vdata.country = item:getText()
			end
		end
		c_country:setText(vdata.country) 
		updateCountry()
	else
		vdata.country = nil
	end
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
		MapWindow.collapse(w_, 0)
		
		groupVariant:initialize(vdata.group and vdata.group.variantProbability, 1)	        
		updateCountries()	
		
		if vdata.group then			
			local selectedUnit_ = MapWindow.getSelectedUnit()
			if selectedUnit_ then
				for k,unit in base.pairs(vdata.group.units) do
					if unit.unitId == selectedUnit_.unitId then
						vdata.unit.cur = k
					end
				end
			end
		end
		
		groupUnitsTransportCheck(true)
		update()
	else
        vdata.group = nil
		MapWindow.expand()
    end
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
	
-------------------------------------------------------------------------------
function setPlannerMission(planner_mission)
    if (planner_mission == true) then
        c_country:setEnabled(false)
        e_name:setEnabled(false)
        sp_of:setEnabled(false)
        c_type:setEnabled(false)
        e_unit_name:setEnabled(false)
		c_category:setEnabled(false)
		c_subCategory:setEnabled(false)
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
        manualCheckbox:setEnabled(false)
		cbUncontrollable:setEnabled(false)
		btnAdd:setEnabled(false)
		btnDel:setEnabled(false)
    else
        c_country:setEnabled(true)
        e_name:setEnabled(true)
        c_type:setEnabled(true)
        e_unit_name:setEnabled(true)
		c_category:setEnabled(true)
		c_subCategory:setEnabled(true)
        c_skill:setEnabled(true)
        hiddenCheckbox:setVisible(true)
		lateActivationCheckbox:setVisible(true)
		cbHiddenOnPlanner:setVisible(true)
		cbHiddenOnMFD:setVisible(true)
        visibleCheckbox:setVisible(true)
        if (SafeMode_ == false) then
            sp_heading:setEnabled(true)
            d_heading:setEnabled(true)
			btnAdd:setEnabled(true)
			btnDel:setEnabled(true)
        else
            sp_heading:setEnabled(false)
            d_heading:setEnabled(false)
			btnAdd:setEnabled(false)
			btnDel:setEnabled(false)
        end
		e_group_condition:setVisible(true)
		sp_probability:setVisible(true)
        manualCheckbox:setEnabled(true)
		cbUncontrollable:setEnabled(true)		
    end    
end

function updateRequiredUnits()
	if vdata.group then
		local units = vdata.group.units
		local unitDef = me_db_api.unit_by_type[units[vdata.unit.cur].type]
		if base.test_requiredUnits == true
			and ((unitDef.WS and unitDef.WS.requiredUnits) 
				or (units[vdata.unit.cur].linksConsumers and #units[vdata.unit.cur].linksConsumers > 0)) then
			btnRequiredUnits:setVisible(true)	
		else	
			btnRequiredUnits:setVisible(false)
		end
	else
		btnRequiredUnits:setVisible(false)
	end
end

-------------------------------------------------------------------------------
--
function update()
	e_name:setSkin(eNameWhiteSkin)
	e_unit_name:setSkin(eNameWhiteSkin)
	
    c_country:setText(vdata.country) 
	if vdata.group then
		e_name:setText(vdata.group.name) 
	else
		e_name:setText(module_mission.check_group_name(vdata.name)) 
	end
    sp_unit:setRange(1,vdata.unit.number)
    sp_unit:setValue(vdata.unit.cur)
    sp_of:setValue(vdata.unit.number)

    if vdata.group then
        fillCategory()
		updateCategory()
		fillSubCategory()
		updateSubCategory()
               
        manualCheckbox:setState(vdata.group.manualHeading or false)  
		cbUncontrollable:setState(vdata.group.uncontrollable or false)

        local units = vdata.group.units
        
        if units[vdata.unit.cur].name then 
            e_unit_name:setText(units[vdata.unit.cur].name)
        else
            e_unit_name:setText('')     
        end
        vdata.types = {};
        for i = 1, #units do
            base.table.insert(vdata.types, units[i].type);
        end;
        hiddenCheckbox:setState(vdata.group.hidden);
        lateActivationCheckbox:setState(vdata.group.lateActivation)
		cbHiddenOnPlanner:setState(vdata.group.hiddenOnPlanner)	
		cbHiddenOnMFD:setState(vdata.group.hiddenOnMFD)	
        visibleCheckbox:setState(vdata.group.visible)	
        playerCanDriveCheckbox:setState(units[vdata.unit.cur].playerCanDrive)
		coldAtStartCheckbox:setState(units[vdata.unit.cur].coldAtStart or false)
        
        e_group_condition:setEnabled(not vdata.group.lateActivation)
        e_group_condition:setText(vdata.group.condition)
        
        sp_probability:setEnabled(not vdata.group.lateActivation)
        sp_probability:setValue((vdata.group.probability or 1) * 100)
      
        base.panel_route.vdata.unit = units[vdata.unit.cur]
        base.panel_route.update()
        pPayload_vehicles.setUnit(units[vdata.unit.cur])
        module_mission.updateHeading(vdata.group, vdata.unit.cur);
    else	
		fillCategory()
		fillSubCategory()
		if(vdata.category) and country_vehicle_list[vdata.country][vdata.category][vdata.subCategory] then
			fill_combo(c_type, country_vehicle_list[vdata.country][vdata.category][vdata.subCategory] )
		end	
		setTypeItem(vdata.types[vdata.unit.cur])
	
		e_unit_name:setText(module_mission.getUnitName(e_name:getText()))   
        manualCheckbox:setState(false)		
    end
	
	updateRequiredUnits()
    
    local unitDef = me_db_api.unit_by_type[vdata.types[vdata.unit.cur] ]
    checkPlayerCanDrive(unitDef)
        
    U.fill_combo(c_skill, cdata.skillList) 
    c_skill:setText(vdata.skills[vdata.unit.cur])
	
	groupUnitsTransportCheck(true)
    
    updateTabs() 
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
	btnAdd:setEnabled(e)
	btnDel:setEnabled(e)
end

-------------------------------------------------------------------------------
-- проверка на корректность задачи Погрузка
function groupUnitsTransportCheck(refresh,changeGroupFunction,changeActionFunction)
	
	--если группа еще не обрабатывалась создаю лимит
	if vdata.group == nil then return end
	if vdata.group.unitTransportLimiter == nil then vdata.group.unitTransportLimiter = {} end
	
	--сохраняемые данные
	if vdata.group.unitTransportLimiter.avalibleCountry == nil then vdata.group.unitTransportLimiter.avalibleCountry = '' end
	if vdata.group.unitTransportLimiter.maxMass == nil then vdata.group.unitTransportLimiter.maxMass = 0 end
	
	--данные по составу группы
	if vdata.group.unitTransportLimiter.avalibleTypes == nil then vdata.group.unitTransportLimiter.avalibleTypes = {} end
	
	--перепроверить задачи "погрузка"
	if refresh then
		local currentMaxSize=0
		vdata.group.unitTransportLimiter.tasks={}
		local isTask=false
		for k,point in base.pairs(vdata.group.route.points) do
			if point.task then
				local tasks = base.U.getTasks(point.task,'EmbarkToTransport')
				if tasks then
					for i,task in base.pairs(tasks) do
						vdata.group.unitTransportLimiter.tasks[i]=task
						isTask=true
					end
				end
			end
		end
		if isTask==false then vdata.group.unitTransportLimiter.tasks=nil end
		
		if vdata.group.unitTransportLimiter.tasks then
			for k,v in base.pairs(vdata.group.unitTransportLimiter.tasks) do
				local transportType = me_db_api.unit_by_type[v.params.selectedType]
				if transportType then
					local variantSize = transportType.InternalCargo.nominalCapacity
					if variantSize == nil then variantSize = 0 end
					if currentMaxSize == 0 or currentMaxSize>variantSize then currentMaxSize=variantSize end
				end
			end
		else
			return
		end

		vdata.group.unitTransportLimiter.maxMass=currentMaxSize
		vdata.group.unitTransportLimiter.avalibleCountry = vdata.country
		buildAvalibleTypesList()
	end
	
	if vdata.group.unitTransportLimiter.tasks == nil then return end -- нет ни одной задачи посадки, прекращаем проверять
	
	--установка прошлых типов и категорий
	local setOldTypes = function()
		for k,v in base.pairs(vdata.previousUnitsTypes) do
			if typeTransportableTest(me_db_api.unit_by_type[v],vdata.group.unitTransportLimiter.tasks) == true then
				vdata.group.units[k].category=vdata.previousUnitsCategorysId[k]
				vdata.group.units[k].type=v
				vdata.types[k]=v
			end
		end
		MapWindow.updateSelectedGroup(vdata.group)
		update()
	end
	
	--проверка на изменение страны
	local isTask=false
	for k,v in base.pairs(vdata.group.unitTransportLimiter.tasks) do
		--нашли хотябы одну задачу
		if vdata.group.unitTransportLimiter.avalibleCountry ~= vdata.country then
			-- ткущая страна не соответствует стране при постановке задачи
			local wrongCountry = MsgWindow.question(cdata.deleteAllTasks, cdata.warning, cdata.yes, cdata.no)
			function wrongCountry:onChange(button)
				if button == cdata.yes then
					vdata.previousUnitsTypes = nil 
					vdata.previousUnitsCategorysId = nil
					deleteAllTransportTasks()
				else
					--тут вернуть назад все параметры
					changeCountry(vdata.group.unitTransportLimiter.avalibleCountry)
					setOldTypes()
				end
			end
			wrongCountry:show()
			return
		end
		isTask=true
		break--нужно проверить только для одной задачи
	end
	
	if isTask == false then return end
	
	--расчет суммарной массы группы
	local summSize=0
	
	local isNonAvalible=false
	for k,v in base.pairs(vdata.group.units) do
		local unitDescription=me_db_api.unit_by_type[v.type]
		if typeTransportableTest(unitDescription,vdata.group.unitTransportLimiter.tasks) == true then --транспортабельный юнит
			
            local unit = me_db_api.unit_by_type[v.type]
            if unit then	
                summSize = summSize + unit.Transportable.size
            end

			---------------------------------------------------------
		else--не транспортабельный юнит
			if vdata.previousUnitsTypes ~= nil and 
				vdata.previousUnitsTypes[k] and 
				me_db_api.unit_by_type[vdata.previousUnitsTypes[k] ].Transportable~=nil then
				--игрок выбрал нетранспортабельный юнит после транспортабельного
				isNonAvalible=true
			else
				--был выбран нетранспортабельный юнит изначально
				local wrongType = MsgWindow.question(cdata.allTasksWillDeleted, cdata.warning, cdata.ok)
				function wrongType:onChange(button)
					deleteAllTransportTasks()
				end

				function wrongType:onClose() 
					deleteAllTransportTasks()
				end
				wrongType:show()
				return
			end
		end
	end
	
	--были восстанавливаемые нетранспортабельные юниты
	if isNonAvalible == true then
		local wrongType = MsgWindow.question(cdata.deleteAllTasks, cdata.warning, cdata.yes, cdata.no)
		function wrongType:onChange(button)
			if button == cdata.yes then
				deleteAllTransportTasks()
			else
				--тут вернуть назад все параметры
				-- setOldTypes()
			end
		end
		wrongType:show()
		return
	end
	
	--проверка на существование лимита.
	if vdata.group.unitTransportLimiter.maxMass == 0 then return end
	currentMaxSize = vdata.group.unitTransportLimiter.maxMass

	
	if summSize > currentMaxSize then
		--панель с вопросом об уменьшении группы
		local tooBigArmy = MsgWindow.question(cdata.toLargeGroup, cdata.warning, cdata.yes, cdata.no)
		
		function tooBigArmy:onChange(button)
			if button == cdata.yes then--уменьшаю группу
				while summSize > currentMaxSize do
					local i = base.table.maxn(vdata.group.units)
					if i ~= zero and me_db_api.unit_by_type[vdata.group.units[i].type].Transportable ~= nil 
					then 
                        local unit = me_db_api.unit_by_type[vdata.group.units[i].type]
                        if unit then	
                            summSize = summSize- unit.Transportable.size
                        end

						module_mission.remove_unit(vdata.group.units[i])
						vdata.unit.number = vdata.unit.number-1 
						if vdata.unit.cur > vdata.unit.number then vdata.unit.cur = vdata.unit.number end 
					end
				end
				update()
				if changeGroupFunction ~= nil then changeGroupFunction() end
			else--отменяю выделение группы
				vdata.group.unitTransportLimiter.maxMass=0
				
				for k,v in base.pairs(vdata.group.unitTransportLimiter.tasks) do
					local transportType = me_db_api.unit_by_type[v.params.selectedType]
					if transportType then
						local variantSize = transportType.InternalCargo.nominalCapacity
						if variantSize < summSize then
							v.params.selectedType=nil
							v.params.selectedUnit=nil
							v.params.concretteUnitChecked=false
						end
					end
				end
				if changeActionFunction ~= nil then changeActionFunction() end
				update()
			end
		end
		tooBigArmy:show()
	else
		if changeGroupFunction ~= nil then changeGroupFunction() end
	end
end

-------------------------------------------------------------------------------
--
function changeCountry(c)
	base.panel_route.changeCountryGroup(vdata.group,me_db_api.country_by_name[vdata.country].WorldID, me_db_api.country_by_name[c].WorldID)

	c_country:setText(c)
    vdata.country = c
	updateCountry() 
	
	local function verifyType(a_type)
		for k,v in base.pairs (country_vehicle_list[vdata.country][vdata.category]["All"]) do
			if v == a_type then
				return true
			end
		end
		return false
	end
    
    if vdata.group then
        -- Удаляем группу из старой страны. 
        local tbl = vdata.group.boss.vehicle.group
        if tbl then
            for i,v in base.pairs(tbl) do
                if v == vdata.group then
                    base.table.remove(tbl, i)
                    break
               end
            end
        end
        -- Помещаем группу в новую страну.
        local c = module_mission.missionCountry[vdata.country]
        base.table.insert(c.vehicle.group, vdata.group)
        vdata.group.boss = c
        -- Изменяем цвет объектов карты
        vdata.group.color = c.boss.color
				
        fill_combo(c_type, country_vehicle_list[vdata.country][vdata.category][vdata.subCategory])
        -- В связи со сменой страны нужно также оставить в группе только умалчиваемые юниты страны.
        -- Если изменилась коалиция, то нужно отменить цели на маршруте.
        vdata.types = {}
        for i=1,#vdata.group.units do
            local unit = vdata.group.units[i]
			if verifyType(unit.type) == false then
				unit.type = country_vehicle_list[vdata.country][vdata.category]["All"][1]
			end
            base.table.insert(vdata.types, unit.type)
            pPayload_vehicles.setDefaultLivery(unit)
        end
        setTypeItem(vdata.group.units[vdata.unit.cur].type)
        base.panel_route.vdata.unit = vdata.group.units[vdata.unit.cur]
        base.panel_route.update()
		loadoututilsV.setDefaultAmmoToUnit(vdata.group.units[vdata.unit.cur], vdata.unit.cur)
        pPayload_vehicles.setUnit(vdata.group.units[vdata.unit.cur])
        base.panel_targeting.update()
        MapWindow.updateSelectedGroup(vdata.group)
        base.panel_units_list.updateRow(vdata.group, vdata.group.units[vdata.unit.cur]);
				
    end
    
    local unitDef = me_db_api.unit_by_type[vdata.types[vdata.unit.cur] ]
    checkPlayerCanDrive(unitDef)
    
    updateTabs()
	MapWindow.updateHiddenSelectedGroup()	
end

function checkPlayerCanDrive(unitDef)
	if unitDef then
		local enabled = unitDef.enablePlayerCanDrive or false
		playerCanDriveCheckbox:setEnabled(enabled)
		if enabled == false then			
			playerCanDriveCheckbox:setState(false)
			
			if vdata.group then 
				vdata.group.units[vdata.unit.cur].playerCanDrive = false
			end
		end
	end
end

-------------------------------------------------------------------------------
--
function updateCountry()  
    fillCategory()
	fillSubCategory()

	if vdata.group then
		vdata.types = {}
        for i=1,#vdata.group.units do
            base.table.insert(vdata.types, vdata.group.units[i].type);
            --pPayload_vehicles.setDefaultLivery(unit)
        end
		vdata.unit.cur = 1 --#vdata.group.units
	else
		local tmpType = country_vehicle_list[vdata.country][vdata.category]["All"][1]
		if #vdata.types > 0 then
			for k,v in base.ipairs(country_vehicle_list[vdata.country][vdata.category]["All"]) do
				if v == vdata.types[#vdata.types] then
					tmpType = vdata.types[#vdata.types]
					break
				end
			end
		end
		vdata.types = {}
		vdata.types[1] = tmpType
		vdata.unit.cur = 1
	end
    fill_combo(c_type, country_vehicle_list[vdata.country][vdata.category]["All"]) 
	vdata.subCategory = "All"
    setTypeItem(vdata.types[vdata.unit.cur]) 
end

function updateTabs()
    if (vdata.group ~= nil) then
        local unitTypeDesc = me_db_api.unit_by_type[vdata.group.units[vdata.unit.cur].type]
        if (unitTypeDesc.AddPropVehicle) then
            _tabs:showTab('paramFM')

            panel_paramFM.setData(unitTypeDesc.AddPropVehicle, vdata.group.units[vdata.unit.cur], 'vehicle')
        else
            if _tabs:getSelectedTab() == 'paramFM' then
                _tabs:selectTab('route')
            end
            _tabs:hideTab('paramFM')               
        end
        
        if (unitTypeDesc.category == "Train") then
            _tabs:showTab('wagons')

            panel_wagons.setData(vdata.group.units[vdata.unit.cur])
        else
            if _tabs:getSelectedTab() == 'wagons' then
                _tabs:selectTab('route')
            end
            _tabs:hideTab('wagons')               
        end
    else
        _tabs:hideTab('paramFM')
    end 

    _tabs:showTab('ammo')
    pLoadout_vehicles.update()
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

function setOldTypesCategoryForTransport(oldType, oldCategory, newCountry)
	if vdata.group and vdata.group.unitTransportLimiter and vdata.group.unitTransportLimiter.tasks then
		for k,v in base.pairs(vdata.group.unitTransportLimiter.tasks) do
			if oldType then
				if vdata.previousUnitsTypes == nil then vdata.previousUnitsTypes={} end
				vdata.previousUnitsTypes[vdata.unit.cur] = oldType
			end
			if oldCategory then
				if vdata.previousUnitsCategorysId == nil then vdata.previousUnitsCategorysId={} end
				vdata.previousUnitsCategorysId[vdata.unit.cur] = oldCategory
			end
			if newCountry then
				vdata.previousUnitsTypes={}
				vdata.previousUnitsCategorysId={}
				if vdata.group ~= nil then
					for k,v in base.pairs(vdata.group.units) do
						local car = me_db_api.unit_by_type[v.type]
						for i=0, c_category:getItemCount()-1 do
							local wid = c_category:getItem(i)
							if wid.itemId == car.category then
								vdata.previousUnitsCategorysId[k] = wid.itemId
							end
						end
						vdata.previousUnitsTypes[k] = v.type
					end
				end
			end
			return
		end
	end
end

function changeType(newType)
	setTypeItem(newType)
	vdata.types[vdata.unit.cur] = c_type:getSelectedItem().type
	if vdata.group then		
		vdata.group.units[vdata.unit.cur].type = vdata.types[vdata.unit.cur]
		vdata.group.units[vdata.unit.cur].AddPropVehicle = nil
        base.panel_route.vdata.unit = vdata.group.units[vdata.unit.cur]
		base.panel_route.update()
		loadoututilsV.setDefaultAmmoToUnit(vdata.group.units[vdata.unit.cur], vdata.unit.cur)
        pPayload_vehicles.setUnit(vdata.group.units[vdata.unit.cur])		
		MapWindow.updateSelectedGroup(vdata.group)
		if vdata.unit.cur == 1 then
			base.panel_route.onUnitTypeChange()
		end
		
		updateUnitCur()
		
        pPayload_vehicles.setDefaultLivery(vdata.group.units[vdata.unit.cur])    
	end
	local unitDef = me_db_api.unit_by_type[vdata.types[vdata.unit.cur] ]
	checkPlayerCanDrive(unitDef)
    
    validateWayPoints()
    updateTabs() 
end

function validateWayPoints()
	if vdata.group and vdata.group.route and vdata.group.route.points then	
		for wptIndex, wpt in base.pairs(vdata.group.route.points) do
			if wptIndex == 1 then
				local result = true
				for k, unit in base.pairs(vdata.group.units) do
					result = result and MapWindow.checkSurfaceUnit(unit, unit.x, unit.y)
				end

				if not result then
					local x, y = MapWindow.findValidStrikePoint(wpt.x, wpt.y) 
					--	local x,y = Terrain.getClosestValidPoint("land", wpt.x, wpt.y) - работает не корректно					
					MapWindow.move_waypoint(vdata.group, wptIndex, x, y, nil, nil, nil, true)
				end
			else
				if not MapWindow.checkSurface(vdata.group, wpt.x, wpt.y, nil, nil, wptIndex) then
					if MapWindow.getCanSwimGroup(vdata.group) ~= true then
						local x, y = MapWindow.findValidStrikePoint(wpt.x, wpt.y) 
						--	local x,y = Terrain.getClosestValidPoint("land", wpt.x, wpt.y) - работает не корректно					
						MapWindow.move_waypoint(vdata.group, wptIndex, x, y, nil, nil, nil, true)
					end
				end
			end
		end
	
	end
	
	
end

function changeUnitsCount(n)
	sp_of:setValue(n)
	if n < vdata.unit.number then
	for i = vdata.unit.number, n+1, -1 do
	  base.table.remove(vdata.types, i)
	  base.table.remove(vdata.skills, i)
	  if vdata.group then
		-- Нужно также удалить соответствующие юниты из миссии
		module_mission.remove_unit(vdata.group.units[i])
	  end
	  base.panel_units_list.updateRow(vdata.group, vdata.group.units[vdata.unit.cur]);
	end
	elseif n > vdata.unit.number then
		if vdata.group then
			for i=vdata.unit.number+1,n do
				-- TODO: проверить смещение
				local offset = 40  
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
				base.table.insert(vdata.types, vdata.types[vdata.unit.cur])
				base.table.insert(vdata.skills, vdata.skills[vdata.unit.cur])
				-- Нужно также добавить соответствующие юниты в миссию
				local name = module_mission.getUnitName(vdata.group.name)
				local unit = module_mission.insert_unit(vdata.group, 
					vdata.types[vdata.unit.cur], vdata.skills[vdata.unit.cur], i,
					name, groupX, groupY, vdata.group.units[vdata.unit.cur].heading,
					nil, vdata.group.units[vdata.unit.cur].livery_id)	
				unit.heading = vdata.group.units[vdata.unit.cur].heading
				unit.playerCanDrive = vdata.group.units[vdata.unit.cur].playerCanDrive
				unit.coldAtStart = vdata.group.units[vdata.unit.cur].coldAtStart
				if 'On Road' == vdata.group.route.points[1].type.action then 
					base.panel_route.UpdateGroupOnRoad(vdata.group)
				end			
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
	module_mission.updateHeading(vdata.group, vdata.unit.cur)
	module_mission.update_group_map_objects(vdata.group)
	e_unit_name:setText(vdata.group.units[vdata.unit.cur].name)
	local unit = vdata.group.units[vdata.unit.cur]
	base.panel_route.vdata.unit = unit	
	base.panel_route.update()
    pPayload_vehicles.setUnit(unit)
	if (vdata.unit.cur > 1) then
		MapWindow.setSelectedUnit(unit)
	else
		MapWindow.setSelectedUnit(nil)
	end

	end
	sp_unit:setRange(1, vdata.unit.number)
	sp_unit:setValue(vdata.unit.cur)
	updateCategory()
	fillSubCategory()
	updateSubCategory()
	c_skill:setText(vdata.skills[vdata.unit.cur]) 

	local unitDef = me_db_api.unit_by_type[vdata.types[vdata.unit.cur] ]
    checkPlayerCanDrive(unitDef)
end

function onChange_ShowId()
    panel_showId.setGroup(vdata.group)
    panel_showId.show(true)
end

function fill_combo(combo, t)
    combo:clear()  
    if not t then
        combo:setText("")
        return
    end 
    for i, type in ipairs(t) do
        local DisplayName = me_db_api.getDisplayNameByName(type)
        local item = ListBoxItem.new(DisplayName)
        item.type = type
        item.DisplayName = DisplayName
        item.index = i
        combo:insertItem(item)
    end
end

local function compTableSubCats(idCat1, idCat2)
	return textutil.Utf8Compare(subCat[idCat1], subCat[idCat2])   
end
	
function fillSubCategory()
	c_subCategory:clear()
	local category = c_category:getSelectedItem().itemId
	local subCats = {}
	
	if subCatByCat[category] then
		for k,v in base.pairs(subCatByCat[category]) do
			base.table.insert(subCats, v)
		end
		base.table.sort(subCats, compTableSubCats)
	end
	
	local itemF = ListBoxItem.new(_("All"))
	itemF.itemId = "All"
	itemF.index = 1
	c_subCategory:insertItem(itemF)
	
	local needSelItem = itemF
		
	if subCats then
		for i, v in ipairs(subCats) do
			if country_vehicle_list[vdata.country][vdata.category][v] then
				local DisplayName = subCat[v]
				local item = ListBoxItem.new(DisplayName)
				item.itemId = v
				item.index = i+1
				c_subCategory:insertItem(item)
				if v == vdata.subCategory then
					needSelItem = item
				end
			end
		end
	end
	
	c_subCategory:selectItem(needSelItem)
	vdata.subCategory = needSelItem.itemId
end

function changeCategory(categoryId)
	vdata.category = categoryId
	
	if vdata.category ~= 'Train' and vdata.group then
		local unit = vdata.group.units[vdata.unit.cur]
		unit.wagons = nil
	end
	
	fillSubCategory()
	changeSubCategory()
end	
	
function changeSubCategory()
	local subCategory = c_subCategory:getSelectedItem().itemId
	vdata.subCategory = subCategory
	--base.print("--changeSubCategory--",vdata.country,vdata.category,subCategory,country_vehicle_list[vdata.country][vdata.category],
	--country_vehicle_list[vdata.country][vdata.category][subCategory])
	local types = country_vehicle_list[vdata.country][vdata.category][subCategory]

--	base.U.traverseTable(country_vehicle_list[vdata.country][vdata.category])
	--base.U.traverseTable(types)
--	base.print("--fff1---")
	
	local type = types[1]
	
	fill_combo(c_type, types)
	setTypeItem(type) 
	vdata.types[vdata.unit.cur] = type
   
	if vdata.group then
		local unit = vdata.group.units[vdata.unit.cur]
    
		base.panel_route.vdata.unit = unit
		base.panel_route.update()		
		unit.type = type
		
		loadoututilsV.setDefaultAmmoToUnit(unit, vdata.unit.cur)
        pPayload_vehicles.setUnit(unit)
		MapWindow.updateSelectedGroup(vdata.group)
		if vdata.unit.cur == 1 then
			base.panel_route.onUnitTypeChange()
		end
		mod_mission.onTasksRemoveFromOtherGroups(vdata.group) --для Embarking/Disembarking
	end
	update()
	validateWayPoints()
	if vdata.group then
		updateUnitCur()
	end
end

-------------------------------------------------------------------------------
function onChangeCategory(self, item)
	setOldTypesCategoryForTransport(vdata.types[vdata.unit.cur],vdata.category)
	changeCategory(item.itemId)
	groupUnitsTransportCheck()
end

-------------------------------------------------------------------------------
function onChangeSubCategory(self, item)
	--setOldTypesCategoryForTransport(vdata.types[vdata.unit.cur],vdata.category)
	changeSubCategory(item.itemId)
	groupUnitsTransportCheck()
end

-------------------------------------------------------------------------------
function setGroup(group)
	vdata.group = group
	groupVariant:initialize(vdata.group and vdata.group.variantProbability, 1)	
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

function getUnitType()
    local unitDef = me_db_api.unit_by_type[vdata.types[vdata.unit.cur] ]
    if unitDef then 
        return unitDef.type
    end
end

-------------------------------------------------------------------------------
--
function updateHeading()
    local heading = 0;
    
    local function getHeading(p1,p2)
        local heading = 0
        if (p1.x == p2.x) and (p1.y == p2.y) then
            heading = 0
        else
            heading = MapWindow.getAngle(p1, p2) 
            if (heading < 0) then
                heading = heading + 2 * base.math.pi
            end
        end; 
        return heading;
    end
    
    if (base.isPlannerMission() == false) then
        sp_heading:setEnabled(true);
        d_heading:setEnabled(true);
    end
        
    if vdata.group then
        if (#vdata.group.route.points > 1) and (vdata.group.manualHeading ~= true) then
            sp_heading:setEnabled(false);
            d_heading:setEnabled(false);
            local p1 = vdata.group.route.points[1];
            local p2 = vdata.group.route.points[2];
            
            heading = getHeading(p1,p2)

            if (vdata.group.route.points[1].type.action == "On Road") then              
                for k,v in base.pairs(vdata.group.units) do
                    if (k == 1) then
                        if (vdata.group.route.spans) and (vdata.group.route.spans[1]) and (vdata.group.route.spans[1][2]) then                           
                            heading = getHeading(vdata.group.units[1], vdata.group.route.spans[1][2])  
                        end    
                    else
                        heading = getHeading(vdata.group.units[k], vdata.group.units[k-1])
                    end
                    v.heading = heading 				
                end
            else               
                for k,v in base.pairs(vdata.group.units) do
                    v.heading = heading
                end
            end
        end
        local degrees = UC.toDegrees(vdata.group.units[vdata.unit.cur].heading)
    
        sp_heading:setValue(degrees);
        d_heading:setValue(degrees);
               
		for k,unitObj in base.pairs(vdata.group.mapObjects.units) do
			local classInfo = MapWindow.getClassifierObject(unitObj.classKey)
	
			if classInfo and classInfo.rotatable and OptionsData.getIconsTheme() == 'russian' then	
				unitObj.angle = MapWindow.headingToAngle(vdata.group.units[k].heading) -- в объектах карты храним все в градусах
	  
				if k == 1 then
					vdata.group.mapObjects.route.points[1].angle = MapWindow.headingToAngle(vdata.group.units[1].heading)
				end
			end	

			if unitObj.picModel then
				unitObj.picModel:setOrientationEuler(MapWindow.headingToAngle(vdata.group.units[k].heading), 0, 0)
			end
			
			module_mission.update_group_map_objects(vdata.group) 
		end
		
		for k,unit in base.pairs(vdata.group.units) do
			if unit.linkChildrenTZone then
				for i,zoneId in ipairs(unit.linkChildrenTZone) do	
					TriggerZoneController.updateHeading(zoneId)		
				end
			end
		end
	end
        
end

-------------------------------------------------------------------------------
-- 
function fillCategory()
	if (country_category_list[vdata.country]) then
		U.fill_listIDs(c_category, country_category_list[vdata.country])

		local armItem = nil
		local curItem = nil
		local firstItem = nil

		for i=0, c_category:getItemCount()-1 do
			local wid = c_category:getItem(i)
			if wid.itemId == 'Armor' then
				armItem = wid
			end
			if wid.itemId == vdata.category then
				curItem = wid
			end
			if i == 0 then
				firstItem = wid
			end
		end

		if curItem then
			c_category:selectItem(curItem)
		elseif armItem then
			c_category:selectItem(armItem)
		else
			c_category:selectItem(firstItem)
		end	

        vdata.category = c_category:getSelectedItem().itemId
	end	
end

-------------------------------------------------------------------------------
-- 
function updateCategory()
	local car = me_db_api.unit_by_type[vdata.group.units[vdata.unit.cur].type]
	if car.tags then
		local categories = me_db_api.hasTags(car.tags, catsAll)
		vdata.category = categories[1]
	else
		vdata.category = car.category
	end
	
	for i=0, c_category:getItemCount()-1 do
		local wid = c_category:getItem(i)
		if wid.itemId == vdata.category then
			c_category:selectItem(wid)
		end
	end
end

function updateSubCategory()
	local car = me_db_api.unit_by_type[vdata.types[vdata.unit.cur]]
	local validSubCategory = false
	local reSubCategories
		
	if subCatByCat[vdata.category] and car.tags and vdata.subCategory ~= "All" then
		local subCatTags = {}
		for k,v in base.pairs(subCatByCat[vdata.category]) do
			subCatTags[v] = tagsBySubCat[v]
		end
		local subCategories = me_db_api.hasTags(car.tags, subCatTags, car.enablePlayerCanDrive)
	
		for k,v in base.pairs(subCategories) do
			reSubCategories = v
			if v == vdata.subCategory then
				validSubCategory = true
			end
		end
	else
		vdata.subCategory = "All"
	end
								
	for i=0, c_subCategory:getItemCount()-1 do
		local wid = c_subCategory:getItem(i)
		if validSubCategory == true then 
			if wid.itemId == vdata.subCategory then
				c_subCategory:selectItem(wid)
			end
		else
			if wid.itemId == reSubCategories then
				c_subCategory:selectItem(wid)
				vdata.subCategory = reSubCategories
			end
		end	
	end
	--base.print("---updateSubCategory--",vdata.category,vdata.subCategory)
	fill_combo(c_type, country_vehicle_list[vdata.country][vdata.category][vdata.subCategory])
	setTypeItem(vdata.types[vdata.unit.cur])
end	

--функция удаления всех задач транспортировки у пасажиров
function deleteAllTransportTasks()
	
	local nameEmbarkToTransport='EmbarkToTransport'
	
	MapWindow.unselectAll()
	actionEditPanel.show(false)
	
	for i,p in base.pairs(vdata.group.route.points) do
		local forDelete={}
		local i=1
		for j,t in base.pairs(p.task.params.tasks) do
			if t.id == nameEmbarkToTransport then
				forDelete[j]=t
			else
				t.number=i
				actionMapObjects.onTaskNumberChange(t)
				i=i+1
			end
		end
		
		for k,v in base.pairs(forDelete) do 
			actionMapObjects.onTaskRemove(v)
			base.table.remove(p.task.params.tasks,k)
			actionDB.onTaskRemove(vdata.group, p, v)
		end
		
		actionEditPanel.setItemCount(i)
	end
	
	local forDelete={}
	
	for i,t in base.pairs(vdata.group.tasks) do
		if t.id == nameEmbarkToTransport then
			forDelete[i]=t
		end
	end
	
	for k,v in base.pairs(forDelete) do 
		triggeredActions:removeItemByTask(v)
	end	
	
	update()
	
	groupUnitsTransportCheck(true)
end



function typeTransportableTest(unitType,tasks)
	if unitType.Transportable == nil then return false end
	return true
end

function buildAvalibleTypesList()
	vdata.group.unitTransportLimiter.avalibleTypes={}
	for k,t in base.pairs(country_vehicle_list[vdata.country]["All"]) do
		for i,v in base.pairs(t) do
			local typesDescription=me_db_api.unit_by_type[v]
			if typesDescription.Transportable then
				vdata.group.unitTransportLimiter.avalibleTypes[v]=typesDescription
			end
		end
	end
end

function getCurUnitType()
    if vdata.group then
        return vdata.group.units[vdata.unit.cur].type
    end
    return nil
end

function isVisible()
    return window:isVisible()
end  

initModule()

