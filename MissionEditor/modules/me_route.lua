local base = _G

module('me_route') -- right toolbar mode panel

local require = base.require
local print = base.print
local math = base.math
local pairs = base.pairs
local ipairs = base.ipairs
local tostring = base.tostring
local table = base.table
local string = base.string
local error = base.error
local next = base.next
local tonumber = base.tonumber

local DialogLoader          = require('DialogLoader')
local ListBoxItem           = require('ListBoxItem')
local U                     = require('me_utilities')
local MapWindow             = require('me_map_window')
local actionDB              = require('me_action_db')
local ActionsListBox        = require('me_actions_listbox')
local MsgWindow             = require('MsgWindow')
local crutches              = require('me_crutches')
local TEMPL                 = require('me_template')
local mod_me_aircraft       = require('me_aircraft')
local module_mission        = require('me_mission')
local mod_parking           = require('me_parking')
local panel_summary         = require('me_summary')
local SpinWPT               = require('me_spin_wpt')
local DB                    = require('me_db_api')
local panel_wpt_properties  = require('me_wpt_properties')
local OptionsData           = require('Options.Data')
local panel_vehicle         = require('me_vehicle')
local panel_aircraft        = require('me_aircraft')
local panel_triggered_actions = require('me_triggered_actions')
local CoalitionController	= require('Mission.CoalitionController')
local AirdromeController	= require('Mission.AirdromeController')
local actionMapObjects		= require('me_action_map_objects')
local dllWeather            = require('Weather')
local panelActionCondition	= require('me_action_condition')
local Terrain				= require('terrain')
local NavigationPointController	= require('Mission.NavigationPointController')
local ProductType 			= require('me_ProductType') 


require('i18n').setup(_M)

local max_alt = 40000 -- m
local max_speed = 8000 -- km/h
local max_flags = 199
local templatesActions = {}

-- list of available actions
actions = {
  turningPoint   = { name=_('Turning point'),        type='Turning Point',  action='Turning Point' },
  flyOverPoint   = { name=_('Fly over point'),       type='Turning Point',  action='Fly Over Point' },
  finPoint       = { name=_('Fin point (N/A)'),      type='Fin Point',      action='Fin Point' },
  takeoffRunway  	= { name=_('Takeoff from runway')		, type='TakeOff',        action='From Runway' },
  takeoffParking	= { name=_('Takeoff from parking')		, type='TakeOffParking', action='From Parking Area' },
  takeoffParkingHot = { name=_('Takeoff from parking hot')	, type='TakeOffParkingHot', action='From Parking Area Hot' },
  LandingReFuAr 	= { name=_('LandingReFuAr')				, type='LandingReFuAr', action='LandingReFuAr' },
  
  takeoffGround	    = { name=_('Takeoff from ground')		, type='TakeOffGround', action='From Ground Area' },
  takeoffGroundHot  = { name=_('Takeoff from ground hot')	, type='TakeOffGroundHot', action='From Ground Area Hot' },
  
  landing 		 = { name=_('Landing'),              type='Land',           action='Landing' },
  offRoad 		 = { name=_('Offroad'),              type='Turning Point',  action='Off Road' },
  onRoad 		 = { name=_('On road'),              type='Turning Point',  action='On Road' },
  rank 			 = { name=_('Rank'),                 type='Turning Point',  action='Rank' },
  cone 			 = { name=_('Cone'),                 type='Turning Point',  action='Cone' },
  vee 			 = { name=_('Vee'),                  type='Turning Point',  action='Vee' },
  diamond 		 = { name=_('Diamond'),              type='Turning Point',  action='Diamond' },
  echelonL 		 = { name=_('Echelon Left'),         type='Turning Point',  action='EchelonL' },
  echelonR 		 = { name=_('Echelon Right'),        type='Turning Point',  action='EchelonR' },
  customForm 	 = { name=_('Custom'),               type='Turning Point',  action='Custom' },
  onRailroads 	 = { name=_('On railroads'),         type='On Railroads',  action='On Railroads' },
}


function isRailroads(type)
    return type.type == actions.onRailroads.type 
end

-- returns true if waypoint assigned to airfiel
function isTakeOffParking(type)
    return  type.type == actions.takeoffParking.type or 
			type.type == actions.takeoffParkingHot.type 
end

function isTakeOffGround(type)
    return  type.type == actions.takeoffGround.type or 
			type.type == actions.takeoffGroundHot.type 
end

function isTakeOff(type)
    return  isTakeOffParking(type) or
			type.type == actions.takeoffRunway.type
end

function isTakeOffRunway(type)
    return type.type == actions.takeoffRunway.type
end

function isLandingReFuAr(type)
    return  type.type == actions.LandingReFuAr.type 
end

function isAirfieldWaypoint(type) 
    return  isTakeOff(type) or
			type.type == actions.landing.type or
			type.type == actions.LandingReFuAr.type 
end

function isLanding(type) 
    return  type.type == actions.landing.type 
end

function isAircraftOnShip(a_group)
	if a_group and (a_group.type == 'plane' or a_group.type == 'helicopters') then
		if a_group.route and a_group.route.points[1].linkUnit then
			if a_group.route.points[1].linkUnit.boss.type == 'ship'then
				return true
			end
		end
	end
	return false
end

alt_types_all = {
	BARO = 	{ name = _('MSL       Above Mean Sea Level'), 	type = 'BARO' },
	RADIO = { name = _('AGL       Above Ground Level'), 	type = 'RADIO' },	
}

alt_types_by_type = {
	['BARO'] = alt_types_all.BARO,
	['RADIO'] = alt_types_all.RADIO
}

alt_types = {
	alt_types_all.BARO,
	alt_types_all.RADIO
}

-- Структуры БД
local wpt_type =
{
    plane = {
		actions.LandingReFuAr,
		actions.turningPoint,
		actions.flyOverPoint,
    },
    plane_one_point = {
		actions.turningPoint, 
		actions.flyOverPoint,
		actions.takeoffRunway, 
		actions.takeoffParking,
		actions.takeoffParkingHot, 
		actions.landing, 
    },
	plane_one_point_userOnly = {
		actions.turningPoint, 
		actions.flyOverPoint,
		actions.takeoffRunway, 
		actions.takeoffParking,
		actions.takeoffParkingHot, 
		actions.landing, 
		actions.takeoffGround, 
		actions.takeoffGroundHot, 
    },
    plane_first_point = {
		actions.turningPoint,
		actions.flyOverPoint,
		actions.takeoffRunway, 
		actions.takeoffParking, 
		actions.takeoffParkingHot, 
    },
	plane_first_point_userOnly = {
		actions.turningPoint,
		actions.flyOverPoint,
		actions.takeoffRunway, 
		actions.takeoffParking, 
		actions.takeoffParkingHot, 
		actions.takeoffGround, 
		actions.takeoffGroundHot, 
    },
    plane_last_point = {
		actions.LandingReFuAr,
		actions.turningPoint,
		actions.flyOverPoint,
		actions.landing, 
    },

    helicopter = {
		actions.LandingReFuAr,
		actions.turningPoint,
		actions.flyOverPoint,
    },
    helicopter_one_point = {
		actions.turningPoint,
		actions.flyOverPoint,
		actions.takeoffRunway, 
		actions.takeoffParking, 
		actions.takeoffParkingHot, 
		actions.landing,    
		actions.takeoffGround, 
		actions.takeoffGroundHot, 
    },
    helicopter_first_point = {
		actions.turningPoint,
		actions.flyOverPoint,
		actions.takeoffRunway, 
		actions.takeoffParking, 
		actions.takeoffParkingHot, 
		actions.takeoffGround, 
		actions.takeoffGroundHot, 
      },
    helicopter_last_point = {
		actions.LandingReFuAr,	
		actions.turningPoint,
		actions.flyOverPoint,
		actions.landing, 
    },

    ship = { actions.turningPoint },
    ship_one_point = { actions.turningPoint },
    ship_first_point = { actions.turningPoint },
    ship_last_point = { actions.turningPoint },

    vehicle = { 
      actions.offRoad, 
      actions.onRoad, 
      actions.rank, 
      actions.cone, 
      actions.vee, 
      actions.diamond, 
      actions.echelonL, 
      actions.echelonR,
      actions.customForm,
    },
    vehicle_one_point = { 
      actions.offRoad, 
      actions.onRoad, 
      actions.rank, 
      actions.cone,
      actions.vee, 
      actions.diamond, 
      actions.echelonL, 
      actions.echelonR,	  
      actions.customForm,
    },
    vehicle_first_point = { 
      actions.offRoad, 
      actions.onRoad, 
      actions.rank, 
      actions.cone,
      actions.vee, 
      actions.diamond, 
      actions.echelonL, 
      actions.echelonR,
      actions.customForm,	  
    },
    vehicle_last_point = { 
      actions.offRoad, 
      actions.onRoad, 
      actions.rank, 
      actions.cone,
      actions.vee, 
      actions.diamond, 
      actions.echelonL, 
      actions.echelonR,
      actions.customForm,
    },
    
    train = { actions.onRailroads },
    train_one_point = { actions.onRailroads },
    train_first_point = { actions.onRailroads },
    train_last_point = { actions.onRailroads },

}

-------------------------------------------------------------------------------
--
local function createWaypoint(index, x, y, alt, alt_type, speed, speed_locked, ETA, ETA_locked, formation_template)
return {
  index = index, 
  x = x, 
  y = y, 
  alt = alt, 
  depth = 0,
  alt_type = alt_type, 
  speed = speed, 
  speed_locked = speed_locked, 
  ETA = ETA, 
  ETA_locked = ETA_locked, 
  formation_template = formation_template
  }
end
 
 -------------------------------------------------------------------------------
--
local function init_vdata()
  local index = 1
  local x = 0
  local y = 0
  local alt = 800
  local depth = 0
  local alt_type = 'BARO'
  local speed = 400/3.6 -- хрен знает, что это за скорость
  local speed_locked = true
  local ETA = 0
  local ETA_locked = false
  local formation_template = ''
  
  return createWaypoint(index, x, y, alt, alt_type, speed, speed_locked, ETA, ETA_locked, formation_template)
end
 
vdata = {
  -- group = ..., присваивается снаружи. Там же устанавливается и умалчиваемая текущая точка маршрута
  wpt = init_vdata()
}

local function updateUnitSystem()
	local unitSystem = OptionsData.getUnits()
	
	altUnitSpinBox:setUnitSystem(unitSystem)
	depthUnitSpinBox:setUnitSystem(unitSystem)
	speedUnitSpinBox:setUnitSystem(unitSystem)
	speedUnitEditBox:setUnitSystem(unitSystem)
end

-------------------------------------------------------------------------------
--
local function updateActionsList(wpt)
	local landWpt = vdata.wpt ~= nil and vdata.wpt.type ~= nil and vdata.wpt.type.type == actions.landing.type	
	if landWpt then
		actionsShowButton:setState(false)
		actionsListBox:show(false)
	end
	actionsShowButton:setEnabled(not landWpt)
end

-------------------------------------------------------------------------------
--
function initModule()
    cdata = {
      waypoint 				= _('WAYPOINT'),
      of 					= _('OF'),
      name 					= _('NAME'),
      type 					= _('TYPE'),
      action 				= _('ACTION'),
	  advanced 				= _('ADVANCED (WAYPOINT ACTIONS)'),
      alt 					= _('ALTITUDE'),
	  depth					= _('DEPTH'),
      form_templ 			= _('TEMPLATE_route','TEMPLATE'),
      speed 				= _('SPEED'),
      start 				= _('START'),
	  eta 					= _('ETA'),
      add 					= _('ADD'),
	  insert 				= _('INS'),
      edit 					= _('EDIT'),
      del 					= _('DEL'),
	  up 					= _('UP'),
	  down 					= _('DOWN'),
      time_hold 			= _('TIME HOLD'),
      land 					= _('Land'),
      pvi_nav_point 		= _('PVI NAVPOINT'),      
	  speed_lock 			= '', -- Empty msgid forbidden It is reserved by GNU gettext: gettext("") returns the header entry with meta information, not the empty string.
	  ETA_lock 				= '', -- Empty msgid forbidden It is reserved by GNU gettext: gettext("") returns the header entry with meta information, not the empty string.	  
	  parking				= _('PRK'),	  
	  auto					= _('auto'),
      GS                    = _('GS'),   -- Ground Speed -- путевая скорость
	  time					= _('Time:'),
	  min					= _('min'),
	  Fixtime				= _('Fix time'),
	  MachSpeed				= _('MACH'),
	  advancedAutoFill		= _('ADVANCED WP AUTO FILL'),
	  
	  --tool tips
	  waypointCountToolTip  = _('Number of waypoints'),
	  waypointNameToolTip	= _('Waypoint name in the Mission Editor / Mission Planner'),
	  waypointTypeToolTip	= _('Waypoint type'),
	  parkingRampIndexToolTip = _('Index of parking ramp on the airdrome'),
	  wptAltitudeToolTip	= _('Required altitude on the way TO the waypoint'),
	  wptAltTypeToolTip		= _('Required altitude type: MSL, AGL'),
	  wptReqSpeedToolTip	= _('Required speed on the way TO the waypoint'),
	  wptEstSpeedToolTip	= _('Estimated speed on the way TO the waypoint'),
	  lockSpeedToolTip		= _('Lock the required speed on the way TO the waypoint'),
	  timeOnTargetToolTip	= _('Required time of arrival TO the waypoint'),
	  lockTimeOnTargetToolTip= _('Lock the required time of arrival TO the waypoint'),
	  addWaypointToolTip	= _('Add waypoint after the current waypoint'),
	  editWaypointToolTip	= _('Edit current waypoint'),
	  deleteWaypointToolTip	= _('Delete current waypoint'),
	  wapointActions		= _('Show list of waypoint actions: tasks, commands and behavior options')
    };


    local index = 1
    local x = 0 
    local y = 0
    local alt = 800
	local depth = 0
    local alt_type = 'BARO'
    local speed = 400/3.6
    local speed_locked = true
    local ETA = 0
    local ETA_locked = false
    local formation_template = ''
    
    vdata.wpt = createWaypoint(index, x, y, alt, alt_type, speed, speed_locked, ETA, ETA_locked, formation_template)
    vdata.group = nil; 
	
    --[[ Структура точки маршрута в миссии:
      boss = group,
      index = index,
      name = name,
      lat = 0.75,
      long = 0.71,
      alt = 2000,
      speed = 500,  -- Скорость в миссии в м/с, а в БД и в диалогах - в км/ч.
      type = actions.turningPoint,
      eta = 0,  -- В миссии не используется?
    --]]
	
	--updateUnitSystem()
end;

-------------------------------------------------------------------------------
-- returns default speed and altitude for waypoint
function getDefaultFlightParams(wpt)
    local speed
    local refAlt
    if 'helicopter' == wpt.boss.type then
        speed = 200/3.6
        refAlt = 500
    else
        speed = 500/3.6
        refAlt = 2000
    end
    
    local alt = math.max(U.getAltitude(wpt.x, wpt.y), refAlt)
	
	local lockETA = wpt.index == 1 and true or false
    
    return speed, 0.0, alt, alt_types_all.BARO.type, true, lockETA, ''
end

local function setETA(group, wptETA)
	local ETA = (not group.lateActivation) and (module_mission.mission.start_time + wptETA) or (wptETA - group.start_time)
	ETA_panel:setTime(ETA)
end

-------------------------------------------------------------------------------
-- set speed and altitude at waypoint
function setFlightParams(a_group, wpt, wpt_type, speed, ETA, altitude, alt_type, speed_locked, ETA_locked, formation_template)
    wpt.alt = altitude
	wpt.depth = 0
	altUnitSpinBox:setValue(altitude)
	depthUnitSpinBox:setValue(0)
	wpt.alt_type = alt_type
	local isAirGroup = a_group.type == 'plane' or a_group.type == 'helicopter'
	c_alt_type:setVisible(wpt_type.type ~= actions.takeoffRunway.type and wpt_type.type ~= actions.landing.type and isAirGroup)
	c_alt_type:setText(alt_types_by_type[wpt.alt_type].name)
    wpt.speed = speed
	s_speed:setVisible(speed_locked)
	e_speed:setVisible(not speed_locked)
    wpt.speed_locked = speed_locked
	cb_speed_locked:setState(speed_locked)	
	wpt.ETA = ETA
	setETA(a_group, ETA)
	if isNeedDisable() then
		cb_speed_locked:setEnabled(false)
		ETA_panel:setEnabled(false)
	else
		cb_speed_locked:setEnabled(wpt.index ~= 1)
		ETA_panel:setEnabled(ETA_locked)
	end
	wpt.ETA_locked = ETA_locked	
	cb_ETA_locked:setState(ETA_locked)
	wpt.formation_template = formation_template
--	c_form_templ:setText(formation_template)
    teml_setItem(formation_template)
end

-------------------------------------------------------------------------------
function teml_setItem(a_name)
    local count = c_form_templ:getItemCount()
				
	for i = 0, count-1 do
        local item = c_form_templ:getItem(i)
        if item.name == a_name then
            c_form_templ:selectItem(item)
            return    
        end  
    end   
    c_form_templ:selectItem(nil)
end



-------------------------------------------------------------------------------
-- move waypoint to closest airdrome
function attractToAirfield(wpt, group) 
	module_mission.unlinkSnap(wpt)
	module_mission.unlinkWaypoint(wpt)
	local speed = 0;
	local roadnet, x, y, apt, groupForLanding, unitForLanding
	local res
	
	if (isTakeOffParking(wpt.type)) then  
		res, apt = mod_parking.setAirGroupOnAirport(group, wpt.x, wpt.y) 
		if res == false then	
			return false
		end
	elseif isTakeOff(wpt.type) then
		res, apt = mod_parking.setAirGroupOnAirportRunway(group, wpt.x, wpt.y) 
		if res == false then	
			return false
		end
	else	
		local unitType = group.units[1].type
		x, y, apt, groupForLanding, unitForLanding = DB.getNearestAirdromePoint(wpt.x, 
			wpt.y, group.boss.boss, getWptType(wpt.type), unitType)
		MapWindow.move_waypoint(group, wpt.index, x, y, true)
		
        if not isLanding(wpt.type) then
            for k = 2, #group.units do
                local staticOffset = 40
                group.units[k].x = group.x - staticOffset * (k - 1)
                group.units[k].y = group.y + staticOffset * (k - 1)
            end
        end
        
		MapWindow.move_waypoint(group, wpt.index, x, y, true) -- для правильного отображения
		if groupForLanding then
            if DB.isFARP(unitForLanding.type) then
                module_mission.linkWaypoint(wpt, groupForLanding, unitForLanding)
                wpt.helipadId = unitForLanding.unitId
                wpt.airdromeId = nil 
                wpt.grassAirfieldId = nil  
            elseif (unitForLanding.type == "GrassAirfield") then
                module_mission.linkWaypoint(wpt, groupForLanding, unitForLanding)
                wpt.helipadId = nil
                wpt.airdromeId = nil 
                wpt.grassAirfieldId = unitForLanding.unitId
            elseif (DB.ship_by_type[unitForLanding.type]) then
                module_mission.linkWaypoint(wpt, groupForLanding, unitForLanding)
                wpt.helipadId = unitForLanding.unitId				
                wpt.airdromeId 			= nil 
                wpt.grassAirfieldId 	= nil  
            end    
		else
			wpt.airdromeId      = apt
			wpt.helipadId       = nil
            wpt.grassAirfieldId = nil
            
            changeAirdromeCoalition(apt, group.boss.boss.name)
		end
	end

	if 'helicopter' == wpt.boss.type then
		speed = 150/3.6
	elseif 'plane' == wpt.boss.type then
		speed = 500/3.6
	end

    setFlightParams(group, wpt, wpt.type, speed, wpt.ETA, U.getAltitude(wpt.x, wpt.y), alt_types_all.BARO.type, wpt.speed_locked, wpt.ETA_locked, '')   
	return true
end

function changeAirdromeCoalition(airdromeNumber, coalitionName)
	local airdromeId = AirdromeController.getAirdromeId(airdromeNumber)
	local airdrome = AirdromeController.getAirdrome(airdromeId)
	
    if	airdrome and airdrome:getCoalitionName() == CoalitionController.neutralCoalitionName() then
        
        --base.panel_warehouse.changeCoalition(a_airdromId, a_group.boss.boss.name)
		AirdromeController.setAirdromeCoalition(airdromeId, coalitionName)
    end 
end    

function snapToNavPoint(a_wpt, a_group)
	local nearestNavPoint = nil
	local dist = 100000000
	local newX, newY
	for k,id in pairs(NavigationPointController.getNavigationPointIds()) do
		local navPoint = NavigationPointController.getNavigationPoint(id)
		local navX, navY = navPoint:getPosition()
		local navDist = DB.getDist(a_wpt.x, a_wpt.y, navX, navY)
		if (navDist/MapWindow.getScale()*3500) <= 40 and navDist < dist then
			dist = navDist
			nearestNavPoint = navPoint
			newX = navX
			newY = navY
		end
	end
	
	
	if nearestNavPoint then
		MapWindow.move_waypoint(a_group, a_wpt.index, newX, newY, true) 
		module_mission.linkToSnap(a_wpt, nearestNavPoint:getId(), "navPoint")
	else
		module_mission.unlinkSnap(a_wpt)
	end
end

-------------------------------------------------------------------------------
-- returns type of waypoint
function getWptType(type)
    if (actions.takeoffRunway.type == type.type) 
        or (actions.takeoffParking.type == type.type)
        or (actions.takeoffParkingHot.type == type.type)
		or (actions.LandingReFuAr.type == type.type) then
        return 'takeoff'
    else
        return 'land'
    end
end


-------------------------------------------------------------------------------
-- обновление позиции и ориентации при установке на дороге (смене ППМ)
function UpdateGroupOnRoad(group)                   
    local hdx 
    local hdy
    local heading = 0
    
    if (group.route.spans) and (group.route.spans[1]) and (group.route.spans[1][2]) then
        hdx = group.units[1].x - group.route.spans[1][2].x
        hdy = group.units[1].y - group.route.spans[1][2].y
        heading = math.atan2(hdx,hdy)
        group.units[1].heading = heading
    elseif (group.units[2]) then
        hdx = group.units[2].x - group.units[1].x
        hdy = group.units[2].y - group.units[1].y
        heading = math.atan2(hdx,hdy)
    end                        
    
   
    for i = 2, #group.units do  
        local j = 0
        local distance = 0
        local dx = 0
        local dy = 0
        repeat       
          
        local x = group.units[i-1].x + 30*math.sin(heading)
        local y = group.units[i-1].y + 30*math.cos(heading)

        x = x + dx
        y = y + dy
        
        MapWindow.move_unit(group.units[i].boss, group.units[i], x, y)
        if isRailroads(vdata.wpt.type) then
            module_mission.move_unit_to_road(group.units[i], 'railroads');
        else
            module_mission.move_unit_to_road(group.units[i], 'roads');
        end
        j = j+1
        dx = group.units[i].x - group.units[i-1].x
        dy = group.units[i].y - group.units[i-1].y
        distance = math.floor(math.sqrt(dx * dx + dy * dy))                            

        until (j>10) or (distance > 10)                           
        
        hdx = group.units[i].x - group.units[i-1].x
        hdy = group.units[i].y - group.units[i-1].y
        heading = math.atan2(hdx,hdy)
    end;
    
    panel_vehicle.updateHeading()
end

-------------------------------------------------------------------------------
--
function WPT_onchange(num)
    setWaypoint(vdata.group.route.points[num])
    if vdata.wpt then
        MapWindow.set_waypoints_color(vdata.group, vdata.group.boss.boss.selectGroupColor)
        MapWindow.set_waypoint_color(vdata.group.route.points[vdata.wpt.index], vdata.group.boss.boss.selectWaypointColor)
        for i,unit in ipairs(vdata.group.mapObjects.units) do 
            unit.currColor = vdata.group.boss.boss.selectGroupColor;
        end
        
        module_mission.update_group_map_objects(vdata.group)

        updateWaypointTypeCombo();
        altUnitSpinBox:setValue(math.floor(vdata.wpt.alt + 0.5))
		depthUnitSpinBox:setValue(math.floor((vdata.wpt.depth or 0) + 0.5))
        local isAirGroup = vdata.group.type == 'plane' or vdata.group.type == 'helicopter'
        c_alt_type:setVisible(vdata.wpt.type.type ~= actions.takeoffRunway.type and vdata.wpt.type.type ~= actions.landing.type and isAirGroup)
        c_alt_type:setText(alt_types_by_type[vdata.wpt.alt_type].name)
        if vdata.wpt.speed_locked then
            speedUnitSpinBox:setValue(vdata.wpt.speed)
        else
            speedUnitSpinBox:setValue(vdata.wpt.speed)
        end
		updateValueMachSpeed()	
        s_speed:setVisible(vdata.wpt.speed_locked)
        e_speed:setVisible(not vdata.wpt.speed_locked)
        cb_speed_locked:setState(vdata.wpt.speed_locked)
        
		setETA(vdata.group, vdata.wpt.ETA)
        
        if isNeedDisable() then
            cb_speed_locked:setEnabled(false)
            ETA_panel:setEnabled(false)
        else
            cb_speed_locked:setEnabled(vdata.wpt.index ~= 1)
            ETA_panel:setEnabled(vdata.wpt.ETA_locked)
        end
        cb_ETA_locked:setState(vdata.wpt.ETA_locked)
        if vdata.wpt.name then
            e_name:setText(vdata.wpt.name)
        else
            e_name:setText('')
        end
        
        updateTimeAndSpeed()
        updateParking()
    end
   -- e_pviNavPoint:setText(update_PVI_NAVPOINT());
    setPlannerMission(base.isPlannerMission())
end


local function createComboType()
    c_type = scrollP.c_type
    U.fill_combo_list(c_type, wpt_type.plane)    
    
    local c_typeDefaultWidth, c_typeHeight = c_type:getSize()
    local c_typeShortWidth = 100
    
	function c_type:switchWidth(a_type)
		if a_type == 'plane' or a_type == 'helicopter' then
			self:setSize(c_typeDefaultWidth, c_typeHeight)
		else
			self:setSize(c_typeShortWidth, c_typeHeight)
		end
	end
    
    function setWPTppmDefault(a_wpt)
        if a_wpt.linkUnit then
            module_mission.unlinkWaypoint(a_wpt)            
        end
        
        a_wpt.airdromeId        = nil
        a_wpt.helipadId         = nil
        a_wpt.grassAirfieldId   = nil
            
        local speed, ETA, alt, alt_type, speed_locked, ETA_locked, formation_template = getDefaultFlightParams(a_wpt)
		setFlightParams(vdata.group, a_wpt, actions.turningPoint, speed, ETA, alt, alt_type, speed_locked, ETA_locked, formation_template)        
        
        a_wpt.type = actions.turningPoint
    end

    function c_type:onChange(item)
		function setWPTtype(item)
      		if (not isAirfieldWaypoint(item.itemId)) and 
					isAirfieldWaypoint(vdata.wpt.type)
			then 
                if vdata.wpt.linkUnit then
                    module_mission.unlinkWaypoint(vdata.wpt)                    
                end
				vdata.wpt.airdromeId        = nil
				vdata.wpt.helipadId         = nil
				vdata.wpt.grassAirfieldId   = nil		
				local speed, ETA, alt, alt_type, speed_locked, ETA_locked, formation_template = getDefaultFlightParams(vdata.wpt)
				setFlightParams(vdata.group, vdata.wpt, item.itemId, speed, ETA, alt, alt_type, speed_locked, ETA_locked, formation_template)
			end
			
			if (not isLandingReFuAr(item.itemId)) and 
					isLandingReFuAr(vdata.wpt.type) then
				vdata.wpt.timeReFuAr = nil
			end	
					
			
            local oldWptType = vdata.wpt.type
			vdata.wpt.type = item.itemId
			updateActionsList()
			
			if isLandingReFuAr(vdata.wpt.type) then
				vdata.wpt.timeReFuAr = 10
				spTimeReFuAr:setValue(vdata.wpt.timeReFuAr)
			end
			
			if vdata.group then
                if not(isTakeOffParking(vdata.wpt.type) == true and isTakeOffParking(oldWptType) == true) then                      
                    if 1 == vdata.wpt.index then
                        vdata.group.route.points[1].airdromeId = nil
                        for numU, unit in pairs(vdata.group.units) do	
                            unit.parking = nil
                            unit.parking_id = nil
                        end
                    end
                
                    if isAirfieldWaypoint(vdata.wpt.type) then
                        local res = attractToAirfield(vdata.wpt, vdata.group)	
                        if res == false then
                            MsgWindow.error(_('Error set to airfield.\n No free airport.'),  _('ERROR'), 'OK'):show()
                            
                            return false
                        end
                    end
                end
                               
                if item.itemId.action == 'From Ground Area' or item.itemId.action == 'From Ground Area Hot'  then
					module_mission.unlinkSnap(vdata.group.route.points[1])
                    if MapWindow.checkSurface(vdata.group, vdata.group.x, vdata.group.y, true) == false then
                        return false
                    end                    
                end
                if mod_me_aircraft.isVisible() then
                    mod_me_aircraft.updateHeadingWidgets()
                    mod_me_aircraft.updateHeading()
                end
                
				--e_pviNavPoint:setText(update_PVI_NAVPOINT());
				if item.itemId.action == 'On Road' then
					module_mission.move_waypoint_to_road(vdata.wpt, 'roads')
                    if 1 == vdata.wpt.index then
                        local group = vdata.wpt.boss;  
                        UpdateGroupOnRoad(group)
                    end
				elseif item.itemId.action == 'On Railroads' then
					module_mission.move_waypoint_to_road(vdata.wpt, 'railroads')
                    if 1 == vdata.wpt.index then
                        local group = vdata.wpt.boss;  
                        UpdateGroupOnRoad(group)
                    end
                else    
					module_mission.make_waypoint_offroad(vdata.wpt)
				end
                
                if item.itemId.action ~= 'Custom' then
                    vdata.wpt.formation_template = ""
                end
                
                vdata.group.uncontrolled = false
				if  vdata.group.route.points[1].type.type == actions.takeoffParking.type then					
                    mod_me_aircraft.uncontrolledCheckBox:setState(false)						
				end
				mod_me_aircraft.updateVisibleUncontrolled()
			end
			return true
		end
				
		if vdata.wpt then
			local res = setWPTtype(item)
			if res == false then
				local firstItem = c_type:getItem(0)
				                
				setWPTtype(firstItem)
				c_type:selectItem(firstItem)
			end                       
		end
	  
		local c_form_templ_active = vdata.wpt.type == actions.customForm
        text_form_templ:setEnabled(c_form_templ_active)
		c_form_templ:setEnabled(c_form_templ_active)
		if not c_form_templ_active then teml_setItem("") end
		updateParking()
		updateEnabled()
    end
end

function fillComboBoxAltType(comboBox, set)
    comboBox:clear()  
    if not set then
       comboBox:setText("")
       return
    end
    for i, v in ipairs(set) do
        local item = ListBoxItem.new(v.name)
		if v.skin ~= nil then
			item:setSkin(v.skin)
		end
        item.itemId = v.type
        comboBox:insertItem(item)
    end
    if next(set) then
        comboBox:setText(set[next(set)].name)
    else
        comboBox:setText('')
    end
end

local function createAltWidgets()
	pAlt  = scrollP.pAlt
    s_alt = scrollP.pAlt.s_alt
    
    function s_alt:onChange()		
        vdata.wpt.alt = altUnitSpinBox:getValue()
        module_mission.set_waypoint_map_object(vdata.wpt)	
        updateTimeAndSpeed()
        panel_summary.update()	
        actionsListBox:updateWaypoint()
		updateValueMachSpeed() 
    end

    text_alt = scrollP.pAlt.text_alt	
    altUnitSpinBox = U.createUnitSpinBox(text_alt, s_alt, U.altitudeUnits, s_alt:getRange())

    c_alt_type = scrollP.pAlt.c_alt_type
    fillComboBoxAltType(c_alt_type, alt_types)
  
    function c_alt_type:onChange(item)
        local oldAltType = vdata.wpt.alt_type
        vdata.wpt.alt_type = item.itemId
        module_mission.set_waypoint_map_object(vdata.wpt)	
        updateTimeAndSpeed()
        panel_summary.update()

        if 	oldAltType == alt_types_all.RADIO.type then		
            if vdata.wpt.alt_type == alt_types_all.BARO.type then
                local Hrel = U.getAltitude(vdata.wpt.x, vdata.wpt.y)
                vdata.wpt.alt = vdata.wpt.alt + Hrel
                local maxAlt = getMaxAlt(vdata.unit, -1)
                if -1 == maxAlt then
                    maxAlt = 10000
                end
                vdata.wpt.alt = math.max(Hrel + 30, math.min(vdata.wpt.alt, maxAlt))
                altUnitSpinBox:setRange(Hrel + 30, tonumber(maxAlt))
                altUnitSpinBox:setValue(vdata.wpt.alt)
            end
        else
            if vdata.wpt.alt_type == alt_types_all.RADIO.type then		
                local Hrel = U.getAltitude(vdata.wpt.x, vdata.wpt.y)
                
                vdata.wpt.alt = vdata.wpt.alt - Hrel
                vdata.wpt.alt = math.max(30, math.min(vdata.wpt.alt, 1200))
                altUnitSpinBox:setRange(30.0, 1200.0)
                altUnitSpinBox:setValue(vdata.wpt.alt)
            end
        end
		updateValueMachSpeed() 
    end
end

local function createDepthWidgets()
	pDepth  = scrollP.pDepth
    s_depth = scrollP.pDepth.s_depth
    
    function s_depth:onChange()		
        vdata.wpt.depth = depthUnitSpinBox:getValue()

    end

    text_depth = scrollP.pDepth.text_depth	
    depthUnitSpinBox = U.createUnitSpinBox(text_depth, s_depth, U.altitudeUnits, s_depth:getRange())

end

function setWidgetSkins(widget, invalidSkin)  
    local validSkin = widget:getSkin()
    
    function widget:setValidSkin(valid)
        if valid then
            self:setSkin(validSkin)
        else
            self:setSkin(invalidSkin)
        end
    end
end

function onChange_sbMachSpeed(self)
	local tmpAlt = vdata.wpt.alt
	if vdata.wpt.alt_type == 'RADIO' then
		tmpAlt = tmpAlt + U.getAltitude(vdata.wpt.x, vdata.wpt.y)
	end	
	local temp = dllWeather.getTemperatureAndPressureAtPoint({position = {x = vdata.wpt.x, y = tmpAlt, z = vdata.wpt.y}})	
	local soundVelocity = 20 * base.math.sqrt(temp + 273.15)

	vdata.wpt.speed = self:getValue()*soundVelocity	

	speedUnitSpinBox:setValue(vdata.wpt.speed)
	updateTimeAndSpeed()
end

local function createSpeedWidgets()
    -- Скорость в симуляторе - в м/с, а здесь нужно отображать в км/ч
    s_speed = pSpeed.s_speed
	
    function s_speed:onChange()
        -- Скорость нужно перевести из км/ч в м/с.
        vdata.wpt.speed = speedUnitSpinBox:getValue()
        --После изменения скорости нужно пересчитать ETA и обновить панель Summary
        module_mission.set_waypoint_map_object(vdata.wpt)	
        updateTimeAndSpeed()	
		updateValueMachSpeed()
        panel_summary.update()
    end
  
    e_speed = pSpeed.e_speed
    setWidgetSkins(e_speed, editBoxInvalidSkin)
  
    speedUnitEditBox = U.createUnitEditBox(nil, e_speed, U.speedUnits)
    text_speed = pSpeed.text_speed
	speedUnitSpinBox = U.createUnitSpinBox(text_speed, s_speed, U.speedUnits, s_speed:getRange())
	
    cb_speed_locked = pSpeed.cb_speed_locked
    setWidgetSkins(cb_speed_locked, checkBoxInvalidSkin)
  
    function cb_speed_locked:onChange()
        local value = self:getState()
        
        vdata.wpt.speed_locked = value
        s_speed:setVisible(value)
        e_speed:setVisible(not value)
        
        if value then
            speedUnitSpinBox:setValue(speedUnitEditBox:getValue())
        end
        
        module_mission.set_waypoint_map_object(vdata.wpt)	
        updateTimeAndSpeed()
    end
end

function updateValueMachSpeed() 
	if vdata.group and vdata.wpt then
		local minSpeed, maxSpeed = getSpeedLimit()
		updateRangeMachSpeed(minSpeed, maxSpeed)
	
		local tmpAlt = vdata.wpt.alt
		if vdata.wpt.alt_type == 'RADIO' then
			tmpAlt = tmpAlt + U.getAltitude(vdata.wpt.x, vdata.wpt.y)
		end	

		local temp = dllWeather.getTemperatureAndPressureAtPoint({position = {x = vdata.wpt.x, y = tmpAlt, z = vdata.wpt.y}})	
		local soundVelocity = 20 * base.math.sqrt(temp + 273.15)
		sbMachSpeed:setValue(base.math.floor(1000*vdata.wpt.speed/soundVelocity)/1000)
	end
end

function updateRangeMachSpeed(a_minSpeed, a_maxSpeed)
	local tmpAlt = vdata.wpt.alt
	if vdata.wpt.alt_type == 'RADIO' then
		tmpAlt = tmpAlt + U.getAltitude(vdata.wpt.x, vdata.wpt.y)
	end	
	local temp = dllWeather.getTemperatureAndPressureAtPoint({position = {x = vdata.wpt.x, y = tmpAlt, z = vdata.wpt.y}})	
	local soundVelocity = 20 * base.math.sqrt(temp + 273.15)
		
	sbMachSpeed:setRange(base.math.floor(1000*a_minSpeed/soundVelocity)/1000,base.math.floor(1000*a_maxSpeed/soundVelocity)/1000)
end


local function createTimeWidgets()
    timeLabel = scrollP.pDown.timeLabel

	ETA_panel = U.create_time_panel()  
    
    setWidgetSkins(ETA_panel.dd, editBoxInvalidSkin)
    setWidgetSkins(ETA_panel.hh, editBoxInvalidSkin)
    setWidgetSkins(ETA_panel.mm, editBoxInvalidSkin)
    setWidgetSkins(ETA_panel.ss, editBoxInvalidSkin)
    
    function ETA_panel:setValidSkin(valid)
        self.dd:setValidSkin(valid)
        self.hh:setValidSkin(valid)
        self.mm:setValidSkin(valid)
        self.ss:setValidSkin(valid)
    end
    
    function ETA_panel:onChange()
		vdata.wpt.ETA = (not vdata.group.lateActivation) and (self:getTime() - module_mission.mission.start_time) or (vdata.group.start_time + self:getTime())
        
        local validSkin = ETA_valid(vdata.group.lateActivation, vdata.wpt)
        
        self:setValidSkin(validSkin)
        
		module_mission.set_waypoint_map_object(vdata.wpt)	
		updateTimeAndSpeed()
		panel_summary.update()
    end
    
    ETA_panel:setEnabled(false)
    ETA_panel:setBounds(scrollP.pDown.staticETA_PanelPlaceholder:getBounds())
	
    scrollP.pDown:insertWidget(ETA_panel)
    
    cb_ETA_locked = scrollP.pDown.cb_ETA_locked
    setWidgetSkins(cb_ETA_locked, checkBoxInvalidSkin)

    function cb_ETA_locked:onChange()
        local value = self:getState()
        vdata.wpt.ETA_locked = value

        if isNeedDisable() then
            ETA_panel:setEnabled(false)
        else
            ETA_panel:setEnabled(value)
        end

        module_mission.set_waypoint_map_object(vdata.wpt)	
        updateTimeAndSpeed()
    end
end

function create(x, y, w, h)
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_route_panel.dlg", cdata)
    window:setBounds(x, y, w, h)

	scrollP = window.scrollP
    checkBoxInvalidSkin = window.checkBoxInvalidSkinHolder:getSkin()
    editBoxInvalidSkin = window.editBoxInvalidSkinHolder:getSkin()	
	
	pMachSpeed 			= scrollP.pMachSpeed
	pDown 				= scrollP.pDown
	sbMachSpeed 		= pMachSpeed.sbMachSpeed	
	pSpeed				= scrollP.pSpeed
	text_speedType		= pSpeed.text_speedType
	tbAdvancedAutoFill 	= window.tbAdvancedAutoFill
	
	sbMachSpeed.onChange = onChange_sbMachSpeed
	scrollP:setBounds(1, 0, w-1, h-30)
	tbAdvancedAutoFill:setPosition((w-362)/2, h-25)
    
    sc_wpt = SpinWPT.new()
    
    local con_wpt = sc_wpt:create(scrollP.staticSpinWPTPlaceholder:getBounds())
    scrollP:insertWidget(con_wpt)
    
    function sc_wpt:onChange(self)
        local numWPT = self:getCurIndex()
		WPT_onchange(numWPT)
		updateEnabled()
    end

    e_wptof = scrollP.e_wptof
    e_name = scrollP.e_name
    
    function e_name:onChange()
		vdata.wpt.name = self:getText()
		module_mission.set_waypoint_map_object(vdata.wpt)
    end
    
	text_form_templ = scrollP.text_form_templ
    
	c_form_templ = scrollP.c_form_templ
	function c_form_templ:onChange(item)
		vdata.wpt.formation_template = item.itemId.name
	end
	
    createComboType()
    createAltWidgets()
	createDepthWidgets()
    createSpeedWidgets()
	createTimeWidgets()

    t_parking = scrollP.t_parking
	c_parking = scrollP.c_parking
    
	function c_parking:onChange(item)
		local parking = item.crossroad_index; 
        local parking_id = item.name
		
		if parking ~= nil then
			local group = vdata.wpt.boss; 
			local unitCur = mod_me_aircraft.vdata.unit.cur
            if isLanding(vdata.wpt.type) == true then
                group.units[unitCur].parking_landing = parking	
                group.units[unitCur].parking_landing_id = parking_id	
            else
                group.units[unitCur].parking = parking	
                group.units[unitCur].parking_id = parking_id	
                mod_parking.setAirUnitOnAirport(group.units[unitCur], unitCur)
            end 
		elseif item.numParking then
			local group = vdata.wpt.boss; 
			local unitCur = mod_me_aircraft.vdata.unit.cur
			group.units[unitCur].parking = item.numParking	
			group.units[unitCur].parking_id = parking_id
			local unitH = module_mission.unit_by_id[vdata.wpt.helipadId]
			if base.me_db.ship_by_type[unitH.type] ~= nil then
				mod_parking.setAirUnitOnShip(group.units[unitCur], unitCur, unitH)
			end   
        else
            local group = vdata.wpt.boss; 
			local unitCur = mod_me_aircraft.vdata.unit.cur
            if isLanding(vdata.wpt.type) == true then
                group.units[unitCur].parking_landing = nil 
                group.units[unitCur].parking_landing_id = nil  
            else
                group.units[unitCur].parking = nil                
                group.units[unitCur].parking_id = nil   
            end 
		end
	end
	
    b_add = scrollP.pDown.b_add
    
    function b_add:onChange()
        -- Добавление первой точки маршрута, если нет ни одной.
        -- Добавление точки маршрута после текущей.
        -- Изменение линии маршрута.
		
		if (self:getState() == true) then
			if vdata.group then
			  MapWindow.setState(MapWindow.getAddingWaypointState())			  
			else
			  MapWindow.setState(MapWindow.getPanState())
			end
			b_edit:setState(false)
		else
			MapWindow.setState(MapWindow.getPanState())
			MapWindow.group = vdata.group
			b_edit:setState(true)
		end
		
        MapWindow.group = vdata.group
    end
    
    b_edit = scrollP.pDown.b_edit
    
    function b_edit:onChange()
        -- Переход в режим редактирования текущей точки маршрута.
        -- В данном режиме текущая точка тащится за мышью при нажатой кнопке.
        -- За ней следует подпись и точка линии маршрута
		
		if (self:getState() == true) then
			MapWindow.setState(MapWindow.getPanState())
			MapWindow.group = vdata.group
			b_add:setState(false)
		else
			if vdata.group then
			    MapWindow.setState(MapWindow.getAddingWaypointState())			  
			else
			    MapWindow.setState(MapWindow.getPanState())
			end
			b_add:setState(true)
		end
    end
    
    b_del = scrollP.pDown.b_del

    function b_del:onChange()
        -- Удаление текущей точки маршрута,
        -- назначение предыдущей точки текущей,
        -- перенумерация последующих точек маршрута,
        -- перерисовка линии маршрута,
        -- проверка особых случаев.
        if vdata.wpt.index > 1 then
            if vdata.wpt.linkUnit then
                module_mission.unlinkWaypoint(vdata.wpt)
            end
			module_mission.unlinkSnap(vdata.wpt)
            
            MapWindow.group = vdata.group
			local indexForRemove = vdata.wpt.index
            module_mission.remove_waypoint(vdata.group, indexForRemove)
			panelActionCondition.correctWaypointsInActions(vdata.group, false, indexForRemove)
            
            for wpt_ind, wpt in pairs(vdata.group.route.points) do
                if 'On Road' == wpt.action then
                    module_mission.move_waypoint_to_road(wpt, 'roads');
                end;
                if 'On Railroads' == wpt.action then
                    module_mission.move_waypoint_to_road(wpt, 'railroads');
                end;
            end;
            setPlannerMission(base.isPlannerMission())
            update()			
        end		
    end
	
    t_pviNavPoint = scrollP.t_pviNavPoint
    e_pviNavPoint = scrollP.e_pviNavPoint
    t_pviNavPoint:setVisible(false);
    e_pviNavPoint:setVisible(false);

	actionsListBox = ActionsListBox.create()   
    
    pActionsListBox = actionsListBox.panel
    scrollP:insertWidget(pActionsListBox)

	actionsListBox:setHandlers( {
		onActionEditPanelShow = function()
			MapWindow.setState(MapWindow.getPanState())
		end,
		onActionEditPanelHide = function()
            if MapWindow.isCreated() and not MapWindow.isCreatingGroupState() then
                if b_add:getState() and vdata.group then
                    MapWindow.setState(MapWindow.getAddingWaypointState())
                elseif b_edit:getState() then
                    MapWindow.setState(MapWindow.getPanState())
                end
            end
		end
	} )
	
	actionsShowButton = scrollP.pDown.actionsShowButton
	function actionsShowButton:onChange()
		actionsListBox:show(self:getState())
		scrollP:updateWidgetsBounds()
	end
		
	scrollP:updateWidgetsBounds()
	scrollP_W,scrollP_H = scrollP:getSize()
    
    pReFuAr = scrollP.pReFuAr
	spTimeReFuAr = pReFuAr.spTimeReFuAr
	
	function spTimeReFuAr:onChange()
		vdata.wpt.timeReFuAr = spTimeReFuAr:getValue()	
	end

end


function setStateAddEdit(a_addState, a_editState) 
	b_add:setState(a_addState)
	b_edit:setState(a_editState) 
end

-------------------------------------------------------------------------------
--
function update_PVI_NAVPOINT()
    if not vdata.group then return; end;
    if not vdata.group.route then return; end;
    if not vdata.group.route.points then return; end;
    if 'helicopter' == vdata.group.type then
        if panel_aircraft:isPlayableUnit() then
            t_pviNavPoint:setVisible(true);
            e_pviNavPoint:setVisible(true);
        else
            t_pviNavPoint:setVisible(false);
            e_pviNavPoint:setVisible(false);
            return;
        end;
    else
        t_pviNavPoint:setVisible(false);
        e_pviNavPoint:setVisible(false);
        return;
    end;
    local waypoint          = vdata.group.route.points[vdata.wpt.index];
    local firstWaypoint     = vdata.group.route.points[1];
    local numberOfPoints    = #vdata.group.route.points
    local navPointName;
    local correction = 0;
    if isTakeOff(firstWaypoint.type) then
        correction = 1;
    end;
    
    if 1 == waypoint.index then
        -- выбрана первая точка
        if numberOfPoints > 1 then
            -- точка НЕ ОДНА в маршруте
            if  isTakeOff(waypoint.type) then
                -- точка обозначена как взлет
                 navPointName = _('airfield') .. ' 1';
                 return navPointName;
            else
                -- точка НЕ обозначена как взлет
                navPointName = _('waypoint') .. ' ' .. tostring(waypoint.index);
                return navPointName;
            end;
        else
            -- точка ОДНА в маршруте (она же последняя)
				if  isAirfieldWaypoint(waypoint.type) then-- точка обозначена как взлет
                 navPointName = _('airfield') .. ' 1';
                 return navPointName;
            else                
                navPointName = _('waypoint') .. ' ' .. tostring(waypoint.index);
                return navPointName;
            end;
        end;
    elseif waypoint.index == numberOfPoints then
        -- выбрана последняя точка (в маршруте несколько точек)
        if (actions.landing == waypoint.type) then
            -- последняя точка - точка посадки
            if (firstWaypoint.x == waypoint.x) and (firstWaypoint.y == waypoint.y) then
                -- она совпадает с точкой взлета
                navPointName = _('airfield') .. '1';
                return navPointName;
            else -- она не совпадает с точкой взлета
                if correction == 1 then
                    navPointName = _('airfield') .. ' 2';
                else
                    navPointName = _('airfield') .. '1';
                end;
                return navPointName;            
            end
        else -- последняя точка НЕ точка посадки        
            local waypointIndex = waypoint.index - correction;
            if (waypointIndex < 7) then
                navPointName = _('waypoint') .. ' ' .. tostring(waypointIndex);
                return navPointName;
            else
                navPointName = _('NONE');
                return navPointName;
            end;
        end;
    else
        --выбрана не первая и не последняя точка
        local waypointIndex = waypoint.index - correction;
        if (waypointIndex < 7) then
            navPointName = _('waypoint') .. ' ' .. tostring(waypointIndex);
            return navPointName;
        else
            navPointName = _('NONE');
            return navPointName;
        end;
    end;
    

end;

-------------------------------------------------------------------------------
--
local function getWptWithFlags(route, start_index, finish_index, speed_locked, ETA_locked)	
	start_index = start_index or 1
	finish_index = finish_index or #route.points	
	local step
	if start_index < finish_index then
		step = 1
	else
		step = -1
	end
	
	for i = start_index, finish_index, step do
		local cur_wpt = route.points[i]
		if cur_wpt then			
			if 	(speed_locked == nil or cur_wpt.speed_locked == speed_locked) and
				(ETA_locked == nil or cur_wpt.ETA_locked == ETA_locked) then
				return cur_wpt
			end
		end		
	end
	return nil
end

-------------------------------------------------------------------------------
--
local function verifyRouteSeg_(route, from, to, lateActivation)
	if lateActivation then
		if 	from.index == 1 and
			not from.ETA_locked then
			return _('Late activation is in effect, but first waypoint has no locked time!')
		end
	end
	if from.ETA_locked and to.ETA_locked then					
		if not getWptWithFlags(route, from.index + 1, to.index, false, nil) then			
			return _('All waypoints')..' ('..tostring(from.index + 1)..'-'..to.index..') '.._('have locked speed and surrounded by waypoints ')..from.index.._(' and ')..to.index.._(' with locked time!')
		end	
	elseif not from.ETA_locked and not to.ETA_locked then
		return _('Route has no waypoints with locked time!')
	else
		local error_points = {}
		for i = from.index + 1, to.index do
			local wpt = route.points[i]
			if not wpt.speed_locked then
				table.insert(error_points, wpt.index)
			end
		end
		local error_points_qty = table.getn(error_points)
		if error_points_qty > 0 then
			local errorStr = ''
			if error_points_qty == 1 then
				errorStr = errorStr.._('Waypoint ')..error_points[1]
			else
				errorStr = errorStr.._('Waypoints ')
				for epi = 1, error_points_qty do
					errorStr = errorStr..error_points[epi]
					if epi ~= error_points_qty then
						errorStr = errorStr..'\n'
					end
				end
			end
			if error_points_qty > 1 then
				errorStr = errorStr.._(' has')
			else
				errorStr = errorStr.._(' have')
			end
			errorStr = errorStr.._(' both ulocked speed and time and not surrounded by waypoints with locked time!')
			return errorStr
		end
	end
	return nil
end

-------------------------------------------------------------------------------
--
local function verifyRouteFromTo_(route, startWptIndex, endWptIndex, lateActivation)
	if #route.points < 2 then
		return nil
	end
	startWptIndex = startWptIndex or 1
	endWptIndex = endWptIndex or #route.points
	local curWpt = route.points[startWptIndex]
	local nextWpt = nil
	repeat
		nextWpt = getWptWithFlags(route, curWpt.index + 1, nil, nil, true) or route.points[#route.points]
		local result = verifyRouteSeg_(route, curWpt, nextWpt, lateActivation)
		if result then
			return result
		end
		curWpt = nextWpt
	until nextWpt.index == #route.points
	return nil;
end

-------------------------------------------------------------------------------
--
function verifyRoute(route, lateActivation)
	return verifyRouteFromTo_(route, 1, #route.points, lateActivation)
end

-------------------------------------------------------------------------------
--

function verifyWptTasks(tasks)
	local result = nil
	for taskIndex, task in pairs(tasks) do
		if task.valid ~= nil then
			result = result or ''
			result = result..' '..task.number..'. '..actionDB.getActionDataByTask(task).displayName
			if task.name and string.len(task.name) > 0 then
				result = result..'(\"'..task.name.."\")"
			end
			result = result..": "..task.valid
			result = result..'\n'
		end
	end
	return result
end

-------------------------------------------------------------------------------
--
function verifyRouteTasks(route)
	local result = nil
	for wptIndex, wpt in pairs(route.points) do
		if wpt.task then
			local wptResult, wptQty = verifyWptTasks(wpt.task.params.tasks)
			if wptResult then
				result = result or _('Invalid actions:')..'\n'
				result = result.._('Waypoint ')..wpt.index..':\n'..wptResult
			end
		end
	end
	return result
end

-------------------------------------------------------------------------------
--
local function verifyRouteAroundWpt(route, wptIndex, lateActivation)
	local startWpt = getWptWithFlags(route, wptIndex - 1, 1, nil, true) or route.points[1]
	local endWpt = getWptWithFlags(route, wptIndex + 1, nil, nil, true) or route.points[#route.points]
	return verifyRouteFromTo_(route, startWpt.index, endWpt.index, lateActivation)
end


-------------------------------------------------------------------------------
--
function ETA_valid(lateActivation, wpt)
	local ETA = ETA_panel:getTime()
	if 	not lateActivation and
		ETA <  module_mission.mission.start_time then
		return false
	else
		local left = getWptWithFlags(vdata.group.route, wpt.index - 1, 1, nil, true)
		if left then
			return ETA > left.ETA
		else
			return true
		end
	end
end

function updateEnabled()
	if base.isPlannerMission() == false then
		s_alt:setEnabled(true)
		
		if isNeedDisable() then
			s_speed:setEnabled(false)
			e_speed:setEnabled(false)
			sbMachSpeed:setEnabled(false)
			ETA_panel:setEnabled(false)	
		else
			s_speed:setEnabled(verifyResult == nil)
			e_speed:setEnabled(verifyResult == nil)
			sbMachSpeed:setEnabled(verifyResult == nil)
			ETA_panel:setEnabled(verifyResult == nil)	
		end
		
		local isNoSpeedAndAlt = isTakeOffParking(vdata.wpt.type) or isTakeOff(vdata.wpt.type) 
						or isTakeOffRunway(vdata.wpt.type) or isLandingReFuAr(vdata.wpt.type)
						or isTakeOffGround(vdata.wpt.type)
		if isNoSpeedAndAlt then
			s_speed:setEnabled(false)
			e_speed:setEnabled(false)
			sbMachSpeed:setEnabled(false)			
		end    
		
		if isNoSpeedAndAlt or (vdata.group.type == 'ship') or (vdata.group.type == 'vehicle') then
			s_alt:setEnabled(false)
		end
	end
end

-------------------------------------------------------------------------------
--
local function updateTimeAndSpeedFor_(wpt)
	local verifyResult = verifyRouteAroundWpt(vdata.group.route, wpt.index, vdata.group.lateActivation)
	
    local validSkin = verifyResult == nil
    
	cb_speed_locked:setValidSkin(validSkin)
	cb_ETA_locked:setValidSkin(validSkin)
	
	updateEnabled()
	
	if verifyResult then		
		return
	end
	
	if #vdata.group.route.points < 2 then
		return
	end
	
	local left
	if wpt.index > 1 then
		left = getWptWithFlags(vdata.group.route, wpt.index - 1, 1, nil, true)
	end
	local right
	if wpt.ETA_locked then
		right = wpt
	else
		if wpt.index < #vdata.group.route.points then
			right = getWptWithFlags(vdata.group.route, wpt.index + 1, nil, nil, true)
		end
	end
	if left and right then	
		local ETE = 0.0
		local ETEBefore = 0.0
		local length = 0.0
		local lengthBefore = 0.0
		for i = left.index + 1, right.index do
			local curWpt = vdata.group.route.points[i]
			if curWpt.speed_locked then
				local curWpt_speed = curWpt.speed
                if (curWpt_speed == 0) then
                    curWpt_speed = 0.01
                end
				local segETE = vdata.group.route.len[i - 1] / curWpt_speed
				ETE = ETE + segETE
				if i <= wpt.index then
					ETEBefore = ETEBefore + segETE
				end
			else
				length = length + vdata.group.route.len[i - 1]
				if i <= wpt.index then
					lengthBefore = lengthBefore + vdata.group.route.len[i - 1]
				end
			end				
		end
		if length > 0.0 then
			local speed = length / (right.ETA - left.ETA - ETE)
			if not wpt.speed_locked then				
				wpt.speed = math.floor(speed + 0.5)			
			end
			wpt.ETA = left.ETA + ETEBefore + lengthBefore / speed
		else
			error('Error: all waypoints between '..left.index..' and '..right.index..' has locked speed!')
		end			
	elseif left then
		if wpt.speed_locked then
			local ETE = 0.0
			for i = left.index + 1, #vdata.group.route.points do					
				local curWpt = vdata.group.route.points[i]
				if curWpt.speed_locked then
					if i <= wpt.index then
						local curWpt_speed = curWpt.speed
                        if (curWpt_speed == 0) then
                            curWpt_speed = 0.01
                        end
						ETE = ETE + vdata.group.route.len[i - 1] / curWpt_speed
					end
				else
					error('Error: waypoint '..i..' with unlocked speed is not surrounded by waypoints with locked TOT!')
				end
			end
			wpt.ETA = left.ETA + ETE
		else
			error('Error: waypoint '..wpt.index..'with both unlocked speed and TOT is not surrounded by waypoints with locked TOT!')
		end						
	elseif right then
		if 	right.index > 1 and
			vdata.group.lateActivation then
			error('Error: late activation requires start waypoint has locked TOT')
		end
		if wpt.speed_locked then
			local ETE = 0.0
			for i = right.index, 2, -1 do
				local curWpt = vdata.group.route.points[i]
				if curWpt.speed_locked then
					if i > wpt.index then
						local curWpt_speed = curWpt.speed
                        if (curWpt_speed == 0) then
                            curWpt_speed = 0.01
                        end
						ETE = ETE + vdata.group.route.len[i - 1] / curWpt_speed
					end
				else
					error('Error: waypoint '..i..' with unlocked speed is not surrounded by waypoints with locked TOT!')
				end
			end
			wpt.ETA = right.ETA - ETE
		else
			error('Error: waypoint '..wpt.index..'with both unlocked speed and TOT is not surrounded by waypoints with locked TOT!')
		end
	else
		error('Error: no waypoints with locked TOT!')
	end	
end

-------------------------------------------------------------------------------
--
function updateTimeAndSpeed()
	updateTimeAndSpeedFor_(vdata.wpt)
	
    local speed_min, speed_max = speedUnitSpinBox:getRange()
    
	if not vdata.wpt.speed_locked then
		speedUnitEditBox:setValue(vdata.wpt.speed)	
		updateValueMachSpeed()	
		if 	vdata.wpt.speed < speed_min or
			vdata.wpt.speed > speed_max then
            e_speed:setValidSkin(false)
            
			if vdata.wpt.ETA_locked then
				ETA_panel:setValidSkin(false)
			end
		else
            e_speed:setValidSkin(true)
		end
	end
	if not vdata.wpt.ETA_locked then
		setETA(vdata.group, vdata.wpt.ETA)
	end
	
	local first_wpt = vdata.group.route.points[1]
	if 	first_wpt then
		if 	vdata.wpt.index ~= 1 and
			not first_wpt.ETA_locked then
			updateTimeAndSpeedFor_(first_wpt)
		end
		vdata.group.start_time = first_wpt.ETA;
	end

end

-------------------------------------------------------------------------------
--
function setGroup(group)	
	if vdata.group == group then
		return
	end
	


	if group then
		actionsListBox:setGroupAndWpt(group, group.route.points[1])
	end
	vdata.group = group
	
	if group then			
		if (vdata.group.route.points[1]) then
			setWaypoint(vdata.group.route.points[1])
		else
			vdata.wpt = vdata.group.route.points[1]
		end
	end
end

-------------------------------------------------------------------------------
--
function setWaypoint(wpt)		
    panel_wpt_properties.setWaypoint(wpt)  
	
	if vdata.wpt ~= wpt then		
		
		vdata.wpt = wpt		
		vdata.unit = wpt.boss.units[1]
		
		if wpt.index == 1 then
			timeLabel:setText(cdata.start)
		else
			timeLabel:setText(cdata.eta)
		end
		actionsListBox:setWaypoint(wpt)
		
		updateAltSpeed()
		updateActionsList()
		updateDepth(wpt)
	end	

	local unitTypeDesc = DB.unit_by_type[vdata.wpt.boss.units[1].type]
	panel_wpt_properties.applyWptProperties(unitTypeDesc, wpt)
end

function getSelectedWaypoint()
	return vdata.wpt
end

function getSpeedLimit()
    local minSpeed = 0
    if vdata.group and vdata.group.type == 'plane' then
		local unitTypeDesc = DB.unit_by_type[vdata.group.units[1].type]
		if unitTypeDesc.V_land then
			minSpeed = unitTypeDesc.V_land * 3.6
		else
			minSpeed = 250
		end	
    else		
        if wpt and wpt.index > 1 then
            minSpeed = 1
        else
            minSpeed = 0
        end
    end
	
	local maxSpeed = -1
	if vdata.group then
		maxSpeed = 10000
		for k,unit in base.pairs(vdata.group.units) do
			local maxSpeedTmp = getMaxSpeed(unit, -1)
			if maxSpeedTmp < maxSpeed then
				maxSpeed = maxSpeedTmp
			end
		end
	end
	
	if -1 == maxSpeed then
        maxSpeed = 1000
    end
	
	return minSpeed / 3.6, maxSpeed / 3.6
end

-------------------------------------------------------------------------------
--
function updateAltSpeed()
    local wpt = vdata.wpt
    --altitude limits
    if wpt.alt_type == alt_types_all.RADIO.type then
        altUnitSpinBox:setRange(30.0, 1200.0)
    else
        local maxAlt = vdata.unit ~= nil and getMaxAlt(vdata.unit, -1) or 20000
        if -1 == maxAlt then
            maxAlt = 10000
        end
        altUnitSpinBox:setRange(U.getAltitude(wpt.x, wpt.y), tonumber(maxAlt))
    end
    --speed limits
    local minSpeed, maxSpeed = getSpeedLimit()

    speedUnitSpinBox:setRange(minSpeed, maxSpeed)
	if vdata.wpt.speed > maxSpeed then
		vdata.wpt.speed  = maxSpeed
	end
	updateRangeMachSpeed(minSpeed, maxSpeed)
end

function updateDepth(a_wpt)
	local  h_surface , depth_in_point = Terrain.GetSurfaceHeightWithSeabed(a_wpt.x, a_wpt.y)
	if a_wpt.depth then
		if a_wpt.depth > depth_in_point then
			a_wpt.depth = depth_in_point
		end
		depthUnitSpinBox:setRange(0, depth_in_point)
	end
end

function isSubmarineInGroup(a_group)
	for k,v in base.pairs(a_group.units) do
		local unitDef = DB.unit_by_type[v.type]		
		
		if unitDef.attribute[3] == base.wsType_Submarine then						
			return true
		end
	end
	return false
end
				
-------------------------------------------------------------------------------
--
function update()
	pAlt:setVisible(true)
	pDepth:setVisible(false)
			
	if vdata.group then
		if not vdata.wpt then 
			return;
		end
		updatePosSpeeds()
		
		e_wptof:setText(#vdata.group.route.points)
		
		sc_wpt:setWPT(vdata.wpt.index, #vdata.group.route.points, vdata.group.boss.name)
			
		if vdata.wpt.name then
		  e_name:setText(vdata.wpt.name)
		else
		  e_name:setText('')
		end
		
		local isAirGroup = vdata.group.type == 'plane' or vdata.group.type == 'helicopter'
		
		altUnitSpinBox:setValue(vdata.wpt.alt)
		c_alt_type:setVisible(vdata.wpt.type.type ~= actions.takeoffRunway.type and vdata.wpt.type.type ~= actions.landing.type and isAirGroup)
		c_alt_type:setText(alt_types_by_type[vdata.wpt.alt_type].name)
		
		if vdata.group.type == 'ship' then
			pAlt:setVisible(false)
			pDepth:setVisible(true)
			
			s_depth:setEnabled(false)
			if base.isPlannerMission() ~= true then
				if isSubmarineInGroup(vdata.group) then
					s_depth:setEnabled(true)
				else
					vdata.wpt.depth = 0
				end
			end
		end
		
		depthUnitSpinBox:setValue(vdata.wpt.depth or 0)

		-- Скорость нужно переводить!
		if vdata.wpt.speed_locked then
			speedUnitSpinBox:setValue(vdata.wpt.speed)
		else
			speedUnitEditBox:setValue(vdata.wpt.speed)
		end
		updateValueMachSpeed() 
		s_speed:setVisible(vdata.wpt.speed_locked)
		e_speed:setVisible(not vdata.wpt.speed_locked)
		cb_speed_locked:setState(vdata.wpt.speed_locked)	
		setETA(vdata.group, vdata.wpt.ETA)
			
		if isNeedDisable() then
			cb_speed_locked:setEnabled(false)
			ETA_panel:setEnabled(false)
		else
			cb_speed_locked:setEnabled(vdata.wpt.index ~= 1)
			ETA_panel:setEnabled(vdata.wpt.ETA_locked)
		end
		cb_ETA_locked:setState(vdata.wpt.ETA_locked)
		
		local maxAlt = getMaxAlt(vdata.unit, -1)
		if -1 == maxAlt then
			maxAlt = 10000
		end
 
		updateWaypointTypeCombo();
	   
		c_type:switchWidth(vdata.group.type)
	  --  e_pviNavPoint:setText(update_PVI_NAVPOINT());

		updateTimeAndSpeed()
		if base.MapWindow.isShowHidden(vdata.group) == true  then
			module_mission.set_waypoint_map_object(vdata.wpt)
		end
		
		if vdata.wpt.index > 1 then
			for index = 1, vdata.wpt.index - 1 do                    
				local tmpWpt = vdata.group.route.points[index]
				if isLanding(tmpWpt.type) then
					setWPTppmDefault(tmpWpt)
				end
			end
		end
				
		updateParking()
	end
end

-------------------------------------------------------------------------------
--
function isNeedDisable()
	if (base.isPlannerMission() == false)  then
		return false
	else	
		if ((vdata.group) and (vdata.group.units[1].skill == crutches.getPlayerSkill())
            and (sc_wpt:getCurIndex() ~= 1)
			and (vdata.group) and (sc_wpt:getCurIndex() ~= #vdata.group.route.points))then
			return false;
		end
	end
	
	return true	
end

-------------------------------------------------------------------------------
--
function setTypeWpt(a_wpt)
    local item
    local counter = c_type:getItemCount() - 1
	
    for i = 0, counter do
        local currItem = c_type:getItem(i)		
        if currItem:getText() == a_wpt.type.name then
            item = currItem
            break
        end
    end
	
	if item == nil then
		c_type:onChange(c_type:getItem(0))
	end

    c_type:selectItem(item or c_type:getItem(0))
end

-------------------------------------------------------------------------------
--
function updateWaypointTypeCombo()
    local typeGroup = vdata.group.type  
    if typeGroup == 'vehicle' then
        
        local unitType = panel_vehicle.getCurUnitType()        
        if unitType then
        local unitDef = DB.unit_by_type[unitType]
            if unitDef.category == 'Train' then
                typeGroup = 'train'
            end        
        end
    end
	
	if typeGroup == "plane" then
		local unitDef = DB.unit_by_type[vdata.group.units[1].type]
		if unitDef.takeoff_and_landing_type == "VTOL" then
			typeGroup = "helicopter"
		end
	end
	
	local bBotInGroup = crutches.getBotInGroup(vdata.group)
	
    if (1 == vdata.wpt.index) and (#vdata.group.route.points > 1) then
        local t = typeGroup .. '_first_point' 
		if typeGroup == "plane" and bBotInGroup == false then
			t = t..'_userOnly'
		end
        U.fillComboBox(c_type, wpt_type[t])		
    elseif (#vdata.group.route.points == vdata.wpt.index) and (#vdata.group.route.points > 1) then
        local t = typeGroup .. '_last_point'
        U.fillComboBox(c_type, wpt_type[t])
    elseif (1 == vdata.wpt.index) and (#vdata.group.route.points == 1) then
		local t = typeGroup .. '_one_point' 
		if typeGroup == "plane" and bBotInGroup == false then
			t = t..'_userOnly'
		end
        U.fillComboBox(c_type, wpt_type[t])
    else
		if typeGroup == 'train' then
			U.fillComboBox(c_type, wpt_type[typeGroup])
		else
			local t = vdata.group.type;        
			U.fillComboBox(c_type, wpt_type[t])
		end
    end;
		
    setTypeWpt(vdata.wpt)
    
	local isAirGroup = vdata.group.type == 'plane' or vdata.group.type == 'helicopter'
    text_form_templ:setVisible(not isAirGroup)
	text_form_templ:setEnabled(vdata.wpt.type == actions.customForm)
    
    --TODO обновлять комбобокс только при изменении шаблонов 
    U.fillTemplatesCombo(TEMPL.templates, c_form_templ, true)
    --c_form_templ:setText(vdata.wpt.formation_template)
    teml_setItem(vdata.wpt.formation_template)
    
	c_form_templ:setVisible(not isAirGroup)	
    c_form_templ:setEnabled(vdata.wpt.type == actions.customForm)
end
	
function setPlannerMission(planner_mission)
	if (planner_mission == true) then				
		e_wptof:setEnabled(false)
		e_name:setEnabled(false)
		c_type:setEnabled(false)
		s_alt:setEnabled(false)
		s_depth:setEnabled(false)
		s_speed:setEnabled(false)
		sbMachSpeed:setEnabled(false)
		ETA_panel:setEnabled(false)
		b_add:setEnabled(false)
		b_edit:setEnabled(false)    
		b_del:setEnabled(false)     
		e_pviNavPoint:setEnabled(false) 
		b_edit:setState(false) 
		c_parking:setEnabled(false) 
		cb_ETA_locked:setEnabled(false) 
				

        if (vdata.group) and (vdata.group.units[1].skill == crutches.getPlayerSkill()) then
			updateActionsList()
			if (sc_wpt:getCurIndex() == 1)
				or  ((vdata.group) and (sc_wpt:getCurIndex() == #vdata.group.route.points)) then
				
			else				
				b_del:setEnabled(true)
				b_edit:setEnabled(true)
				e_name:setEnabled(true)
				c_type:setEnabled(true)
				s_alt:setEnabled(true)
				s_speed:setEnabled(true)
				sbMachSpeed:setEnabled(true)
				ETA_panel:setEnabled(true)
				e_pviNavPoint:setEnabled(true) 
				b_add:setState(false)
				b_edit:setState(true) 
				c_parking:setEnabled(true) 
				cb_ETA_locked:setEnabled(true) 
				b_edit:onChange()
			end
			
			if (vdata.group) and (sc_wpt:getCurIndex() == #vdata.group.route.points) then
				b_add:setEnabled(false)
			else
				b_add:setEnabled(true)
			end
		else
			actionsShowButton:setState(false)
			actionsShowButton:setEnabled(false)
			actionsListBox:show(false)
		end
	else
		updateActionsList()
		e_wptof:setEnabled(true)
		e_name:setEnabled(true)
		c_type:setEnabled(true)		
		s_speed:setEnabled(true)
		sbMachSpeed:setEnabled(true)
		ETA_panel:setEnabled(true)
		b_add:setEnabled(true)
		b_edit:setEnabled(true)    
		b_del:setEnabled(true)     
		e_pviNavPoint:setEnabled(true) 
		--b_task_add:setEnabled(true) 
		--b_task_insert:setEnabled(true) 
		--b_task_edit:setEnabled(true) 
		--b_task_del:setEnabled(true) 
		c_parking:setEnabled(true) 
		cb_ETA_locked:setEnabled(true) 
		
		if ((vdata.group ~= nil) and ('ship' ~= vdata.group.type) and ('vehicle' ~= vdata.group.type)) then
			s_alt:setEnabled(true)
		end
		
	end
end

-------------------------------------------------------------------------------
--
function show(b)
	if b == false and window:isVisible() == false then
		return
	end

    if not b then
		actionsListBox:show(false)

        b_edit:setState(true)
        b_edit:onChange()
        -- Вернуть умалчиваемую функциональность карты        
        MapWindow.setState(MapWindow.getPanState())
	else
        updateUnitSystem()
		setPlannerMission(base.isPlannerMission())
		if actionsShowButton:getState() then
			actionsListBox:show(true)
		end
		
        if b_add:getState() == true then
            MapWindow.setState(MapWindow.getAddingWaypointState())
        end
		setParkingWidgetsVisible(false)
		pReFuAr:setVisible(false)
		
		updatePosSpeeds()
    end
    window:setVisible(b)
end

function updatePosSpeeds()
	if vdata.group and vdata.group.type == 'plane' then		
		pSpeed:setPosition(0,102) -- +2
		pMachSpeed:setPosition(0,126) -- -2
		pMachSpeed:setVisible(true)
		pDown:setPosition(0,159) -- +7
		pActionsListBox:setPosition(14,235) -- +7		
	else
		pSpeed:setPosition(0,100)
		pMachSpeed:setPosition(0,128)		
		pMachSpeed:setVisible(false)
		pDown:setPosition(0,128)
		pActionsListBox:setPosition(14,204)
	end
end

-------------------------------------------------------------------------------
--
function open(wptIndex, task)
	vdata.wpt = vdata.group.route.points[wptIndex]	
	update()
	if ((base.isPlannerMission() == false) 
		or ((vdata.group.units) and (vdata.group.units[1])
			and (vdata.group.units[1].skill == crutches.getPlayerSkill())))	then
		if task then
			if (base.isPlannerMission() == false) then
				if actionsListBox:selectItemByTaskAndOpenPanel(task) == false then
					panel_triggered_actions.selectItemByTaskAndOpenPanel(task)
					panel_triggered_actions.updateActionsListBox()
				else
					actionsListBox:update(true)
				end
			end
		end
	end
	
	if vdata.group and vdata.wpt then
		updateEnabled()
	end
end

-------------------------------------------------------------------------------
--
function onMapUnitSelected(unit)
	if unit.boss ~= vdata.group then
		return actionsListBox:onMapUnitSelected(unit)
	end
	return false
end

function showActionEditPanelForCurItem()
	actionsListBox:showActionEditPanelForCurItem()
end	

-------------------------------------------------------------------------------
--
function onTargetMoved(x, y)
	return actionsListBox:onTargetMoved(x, y)
end

-------------------------------------------------------------------------------
--
local function updateAutoActions_(group)
	--remove old auto completed actions
	if tbAdvancedAutoFill:getState() == true then
		for wptIndex, wpt in pairs(group.route.points) do
			if wpt.task then
				for taskIndex = #wpt.task.params.tasks, 1, -1 do
					local task = wpt.task.params.tasks[taskIndex]
				
					if task.auto then
						for nextActionIndex = taskIndex + 1, #wpt.task.params.tasks do -- уменьшаем номер у всех после удаляемого
							wpt.task.params.tasks[nextActionIndex].number = wpt.task.params.tasks[nextActionIndex].number - 1
						end
						
						table.remove(wpt.task.params.tasks, taskIndex)
					end			
				end
			end
		end

		--add new auto completed actions
		local autoTasks = actionDB.createAutoActions(group, crutches.taskToId(group.task))
		if autoTasks then
			local firstWpt = group.route.points[1]
			if 	firstWpt.task and
				firstWpt.task.params.tasks then
				for taskIndex, task in pairs(firstWpt.task.params.tasks) do
					task.number = task.number + #autoTasks			
				end
			end
			firstWpt.task = firstWpt.task or { id = 'ComboTask', params = { tasks = {} } }		
			for autoTasksIndex, autoTask in pairs(autoTasks) do
				table.insert(firstWpt.task.params.tasks, autoTasksIndex, autoTask)
			end
		end
		
		--checking other actions validity by group task
		for wptIndex, wpt in pairs(group.route.points) do
			if wpt.task then
				for taskIndex, task in pairs(wpt.task.params.tasks) do
					task.valid = actionDB.isActionValid(task, group, wpt, crutches.taskToId(group.task))
				end
			end
		end
	else
		for wptIndex, wpt in pairs(group.route.points) do
			if wpt.task then
				for taskIndex = #wpt.task.params.tasks, 1, -1 do
					local task = wpt.task.params.tasks[taskIndex]
					
					--удаляем только невалидные автозадачи
					task.valid = actionDB.isActionValid(task, group, wpt, crutches.taskToId(group.task))
					if task.auto and task.valid ~= nil then
						for nextActionIndex = taskIndex + 1, #wpt.task.params.tasks do -- уменьшаем номер у всех после удаляемого
							wpt.task.params.tasks[nextActionIndex].number = wpt.task.params.tasks[nextActionIndex].number - 1
						end
						
						table.remove(wpt.task.params.tasks, taskIndex)
					end			
				end	
			end
		end	
	end
	
	
end

-------------------------------------------------------------------------------
--
function onUnitTypeChange()
	if not vdata.group then
		return
	end
	updateAutoActions_(vdata.group)
	actionsListBox:onUnitTypeChange()
end

-------------------------------------------------------------------------------
--
function onGroupCountryChange(a_isGroupCoalitionChange)
	if not vdata.group then
		return
	end
	
	if a_isGroupCoalitionChange == true then
		module_mission.removeGroupsFromTasks(vdata.group)
		module_mission.onGroupChangeCoalition(vdata.group)
	end
	
	updateAutoActions_(vdata.group)
	actionsListBox:onGroupTaskChange()
end

-------------------------------------------------------------------------------
--
function onGroupTaskChange()
	if not vdata.group then
		return
	end
	updateAutoActions_(vdata.group)
	actionsListBox:onGroupTaskChange()
end

-------------------------------------------------------------------------------
--

function onLateActivationChanged()
	if not vdata.group then
		return
	end
	setETA(vdata.group, vdata.wpt.ETA)
end

-------------------------------------------------------------------------------
--

function onCloseAttempt()
	actionsListBox:onCloseAttempt()
end

-------------------------------------------------------------------------------
--
function verify(route, lateActivation)
	local routeVerifyResult = verifyRoute(route, lateActivation)
	local taskVerifyResult = verifyRouteTasks(route)
	local verifyResult = (routeVerifyResult or taskVerifyResult or freqVerifyResult) and (routeVerifyResult and routeVerifyResult..'\n' or '')..(taskVerifyResult or '')
	return verifyResult
end

-------------------------------------------------------------------------------
-- disable controls
function setSafeMode(enable)
    scrollP:setEnabled(not enable)
end

-------------------------------------------------------------------------------
-- create waypoints type index mapped by waypoints types
function createWaypointsIndex(actions)
    local idx = { }
    for _tmp, v in pairs(actions) do
        local name = v.type .. ':' .. v.action
        idx[name] = v
    end
	return idx
end

-------------------------------------------------------------------------------
-- Convert type and action to waypoint type
function waypointActionToType(type, action, groupType)
    if not wptByType then
        wptByType = createWaypointsIndex(actions)
    end
    local t = wptByType[type .. ':' .. action]
	if not t then
		if groupType == 'plane' or groupType == 'helicopter' or groupType == 'ship' then
			t = actions.turningPoint
		else
			if 'On Road' == action then
				t = actions.onRoad
			else
				t = actions.offRoad
			end
		end
	end
    return t
end


-------------------------------------------------------------------------------
-- returns maximum allowed altitude of unit
-- oldMaxAlt is previous altitude restriction or -1 if not set
function getMaxAlt(unit, oldMaxAlt)
    local unitDef = DB.unit_by_type[unit.type]
    if not unitDef then
        print('WARINNG: unknown unit type', unit.type)
        return oldMaxAlt
    end
    local maxAlt = unitDef.MaxHeight

    if not maxAlt then
        maxAlt = 10000
    else
        maxAlt = tonumber(maxAlt)
    end

    if (-1 == oldMaxAlt) or (oldMaxAlt > maxAlt) then
        return maxAlt
    else
        return oldMaxAlt
    end
end

-------------------------------------------------------------------------------
--
function getMaxSpeed(unit, oldMaxSpeed)
    local unitDef = DB.unit_by_type[unit.type]
    if not unitDef then
        print('WARINNG: unknown unit type', unit.type)
        return oldMaxSpeed
    end

    local maxSpeed = unitDef.MaxSpeed or (unitDef.max_velocity and (unitDef.max_velocity * 3.6))

    if not maxSpeed then
        if ('ship' == unit.boss.type) then
            maxSpeed = 80
        else 
            maxSpeed = 120
        end
    else
        maxSpeed = tonumber(maxSpeed)
    end

    if (-1 == oldMaxSpeed) or (oldMaxSpeed > maxSpeed) then
        return maxSpeed
    else
        return oldMaxSpeed
    end
end

function roundSpeed(a_speed)
	local unitSystem = OptionsData.getUnits()

	if unitSystem == 'metric' then
		return (math.floor(a_speed * 3.6/10+0.5)*10)/3.6
	else
		return (math.floor(a_speed * (3.6/1.85)/10+0.5)*10)/(3.6/ 1.85)
	end
end

function getCruiseSpeed(unit) -- возвращает в м/с
	local defSpeed
	if unit.boss.type == 'helicopter' then
		defSpeed = 45
	else
		defSpeed = 240
	end
	
    local unitDef = DB.unit_by_type[unit.type]
    if not unitDef then
        print('WARINNG: unknown unit type', unit.type)
        return roundSpeed(defSpeed)
    end

	if unitDef.V_opt ~= nil then
	   return roundSpeed(unitDef.V_opt)
	elseif unitDef.V_max_h or unitDef.V_max then
	   return roundSpeed(math.min(defSpeed, 0.7 * (unitDef.V_max_h or unitDef.V_max)))
	else
		return roundSpeed(defSpeed)
	end
end

-------------------------------------------------------------------------------
-- make sure every turning point has resonable speed and altitude
function applyTypeRestrictions(group)
    local maxSpeed = -1
    local maxAlt = -1
    for _k, unit in pairs(group.units) do
        maxSpeed = getMaxSpeed(unit, maxSpeed)
        maxAlt = getMaxAlt(unit, maxAlt)
    end
	
    local maxSpeedMs = maxSpeed / 3.6
	local unitTypeDesc = DB.unit_by_type[group.units[1].type]
    for _k, wpt in pairs(group.route.points) do
		if wpt.speed < 1.0 then
			if vdata.group.type == 'helicopter' then
				if wpt.index > 1 then
					wpt.speed = 1
				end
			else
				wpt.speed = 300
			end
		elseif vdata.group.type == 'helicopter' or vdata.group.type == 'plane' then	
			wpt.speed = getCruiseSpeed(group.units[1])
        elseif (-1 ~= maxSpeed) and (maxSpeedMs < wpt.speed) then
			wpt.speed = maxSpeedMs
        end
		
        if (-1 ~= maxAlt) and (maxAlt < wpt.alt) then
            wpt.alt = maxAlt
        end
		
		-- изменение свойств ППМ
		if unitTypeDesc then
			panel_wpt_properties.applyWptProperties(unitTypeDesc, wpt)
		end
    end
end

function setParkingWidgetsVisible(visible)
    t_parking:setVisible(visible)
    c_parking:setVisible(visible)
end

-------------------------------------------------------------------------------
--Обновление поля номера стоянки
function updateParking()
	setParkingWidgetsVisible(false)
	pReFuAr:setVisible(false)
	
	function fill_combo(combo, t)    
        combo:clear()  

        if not t then
            combo:setText("")
            return
        end
		
		function compTable(tab1, tab2)			
			function compareDigits(dig1, dig2)
				local num1 = base.tonumber(dig1)	
				local num2 = base.tonumber(dig2)	
				if 	num1 ~= nil and num2 ~= nil then
					return num1<num2
				elseif num1 == nil and num2 ~= nil then
					return true
				elseif num1 ~= nil and num2 == nil then
					return false
				else
					return false
				end
			end
			
			local letters1 = string.match(tab1.name,"%a+")
			local digits1 = string.match(tab1.name,"%d+")
			
			local letters2 = string.match(tab2.name,"%a+")
			local digits2 = string.match(tab2.name,"%d+")
			
			if letters1 ~= nil and letters2 ~= nil then
				if letters1 ~= letters2 then
					return letters1 < letters2
				else
					return compareDigits(digits1, digits2)	
				end
			elseif letters1 == nil and letters2 ~= nil then
				return true
			elseif letters1 ~= nil and letters2 == nil then
				return false
			else
				return compareDigits(digits1,digits2)
			end
		end

		tmpList = {}
		for k, v in pairs(t) do
          table.insert(tmpList, v)
        end  
		table.sort(tmpList, compTable)
        
        if isLanding(vdata.wpt.type) or isLandingReFuAr(vdata.wpt.type) then
             base.table.insert(tmpList,1,{name = cdata.auto,
                x = MapWindow.listAirdromes[vdata.wpt.airdromeId].reference_point.x,
                y = MapWindow.listAirdromes[vdata.wpt.airdromeId].reference_point.y,
             })
        end
		
        for k, v in pairs(tmpList) do
          local item = ListBoxItem.new(v.name)
          item.index = k;
          item.crossroad_index = v.crossroad_index
		  item.numParking = v.numParking
          item.name = v.name
          combo:insertItem(item);			  
        end      
    end
	
	function fill_comboForUnit(combo, t)    
        combo:clear()  

        if not t then
            combo:setText("")
            return
        end
		
		function compTable(tab1, tab2)
            if (tab1.name < tab2.name) then
				return true
			end
				return false
		end

		tmpList = {}
		for k, v in pairs(t) do
          table.insert(tmpList, v)
        end  
		table.sort(tmpList, compTable)
        
        for k, v in pairs(tmpList) do
          local item = ListBoxItem.new(v.name)
          item.index = k;
          item.numParking = v.numParking
          item.name = v.name
          combo:insertItem(item);			  
        end      
    end
	
    local bLanding = isLanding(vdata.wpt.type)
	if (vdata.wpt) then
		if isLandingReFuAr(vdata.wpt.type) == true then
			pReFuAr:setVisible(true)
			spTimeReFuAr:setValue(vdata.wpt.timeReFuAr or 0)
		elseif isTakeOff(vdata.wpt.type) or bLanding then
			if (vdata.wpt.airdromeId) and (isTakeOffParking(vdata.wpt.type) or bLanding) then
				listP = {}
				listP = mod_parking.getStandList(MapWindow.listAirdromes[vdata.wpt.airdromeId].roadnet)
				
				local group = vdata.wpt.boss; 
				local unitCur = mod_me_aircraft.vdata.unit.cur
				local unit = group.units[unitCur]
							
				listP = mod_parking.getKeepParkingAirport(vdata.wpt.airdromeId, listP, unit, bLanding)	
				listP = mod_parking.getRightParkingAirport(listP, group)
			   -- base.U.traverseTable(MapWindow.listAirdromes[vdata.wpt.airdromeId])
				
				fill_combo(c_parking, listP) 
				
				local loc_parking
				if bLanding == true then
					loc_parking = listP[tonumber(group.units[unitCur].parking_landing)]                
				else
					loc_parking = listP[tonumber(group.units[unitCur].parking)]
				end

				if loc_parking == nil then
					if bLanding == true then
						loc_parking = {name = cdata.auto}                       
					else
						for k,v in pairs(listP) do
							loc_parking = v
							group.units[unitCur].parking = loc_parking.crossroad_index     
							group.units[unitCur].parking_id = loc_parking.name     
							group.units[unitCur].x = loc_parking.x
							group.units[unitCur].y = loc_parking.y
							break;                    
						end
					end
					if loc_parking == nil then
						vdata.wpt.type   = actions.turningPoint
						vdata.wpt.airdromeId = nil
						for numU, unit in pairs(vdata.group.units) do	
							unit.parking = nil
							unit.parking_landing = nil
							unit.parking_id = nil
							unit.parking_landing_id = nil
						end
						return
					end
				end
				
				c_parking:setText(loc_parking.name)
				
				if vdata.wpt.type.type == actions.takeoffRunway.type
					or not (isAircraftOnShip(vdata.group) and vdata.wpt.index == 1) then
					setParkingWidgetsVisible(true)
				else
					setParkingWidgetsVisible(false)
				end
			end
				
			if (vdata.wpt.helipadId ) then
				if bLanding == true then
					U.fill_combo(c_parking, {cdata.auto})
					for numU, unit in pairs(vdata.group.units) do	
						unit.parking = nil
						unit.parking_landing = nil
						unit.parking_id = nil
						unit.parking_landing_id = nil
					end
					c_parking:setText(cdata.auto)
				else
					local listP = {}
					listP = mod_parking.getStandListUnit(vdata.wpt.helipadId)
					
					fill_comboForUnit(c_parking, listP)
					
					local group = vdata.wpt.boss 
					local unitCur = mod_me_aircraft.vdata.unit.cur
					--base.print("---group.units[unitCur].parking---",group.units[unitCur].parking, listP[tonumber(group.units[unitCur].parking)])
					local loc_parking = listP[tonumber(group.units[unitCur].parking)]
					
					if loc_parking == nil then
						for k,v in pairs(listP) do
							loc_parking = v
							group.units[unitCur].parking = loc_parking.numParking     
							group.units[unitCur].parking_id = loc_parking.name     
							break;                    
						end

						if loc_parking == nil then
							vdata.wpt.type   = actions.turningPoint
							vdata.wpt.helipadId = nil
							for numU, unit in pairs(vdata.group.units) do	
								unit.parking = nil
								unit.parking_landing = nil
								unit.parking_id = nil
								unit.parking_landing_id = nil
							end
							return
						end
					end
					c_parking:setText(loc_parking.name)
					--base.print("---loc_parking.name---",loc_parking.name)
				end
			
				if vdata.wpt.type.type == actions.takeoffRunway.type 
					or not isAircraftOnShip(vdata.group) then
					setParkingWidgetsVisible(true)
				else
					setParkingWidgetsVisible(false)
				end
			end
		end
	end
end

-- вызывается при смене страны группы, для очистки от невалидных задач
function changeCountryGroup(a_group, a_oldCountry, a_newCountry)
	local oldCoal = CoalitionController.getCoalitionByCountryId(a_oldCountry)
	local newCoal = CoalitionController.getCoalitionByCountryId(a_newCountry)

	if a_group == nil or oldCoal == newCoal then
		return
	end

	-- удаляем задачи из группы юнита
	if a_group.route and a_group.route.points then
		for k,point in base.pairs(a_group.route.points) do
			if point.task and point.task.params and point.task.params.tasks then
				local toRemove = {}
				for kk, task in base.pairs(point.task.params.tasks) do
					if task.id == 'GroundEscort' 
						or task.id == 'EngageUnit'
						or task.id == 'AttackUnit' 
						or task.id == 'AttackGroup'	then
						toRemove[kk] = task
					end
				end
				
				for k,task in base.pairs(toRemove) do 
					actionsListBox:removeItemByTask(task)
				end	
			end
		end
	end
	
	module_mission.onTasksRemoveFromOtherGroups(a_group) --для Embarking/Disembarking
	
	-- проверяем все группы на наличие задачи с id переданной группы
	for k1,group in base.pairs(base.module_mission.group_by_id) do
		if group.route and group.route.points then
			for k,point in base.pairs(group.route.points) do				
				if point.task and point.task.params and point.task.params.tasks then
					local toRemove = {}
					for kk, task in base.pairs(point.task.params.tasks) do
						if (task.id == 'GroundEscort' or task.id == 'AttackGroup')  
							and task.params and task.params.groupId == a_group.groupId then
							base.table.insert(toRemove,kk)
						end

						if task.id == 'EngageUnit' 
							or task.id == 'AttackUnit' then
							for ind1, unit in base.pairs(a_group.units) do
								if task.params and task.params.unitId == unit.unitId then
									base.table.insert(toRemove,kk)
								end
							end
						end
					end
					
					for i = #toRemove, 1, -1 do								
						actionMapObjects.onTaskRemove(group.route.points[k].task.params.tasks[toRemove[i]])
						local tmp = group.route.points[k].task.params.tasks[toRemove[i]]
						base.table.remove(group.route.points[k].task.params.tasks, toRemove[i])
						actionDB.onTaskRemove(group, point, tmp)			
					end

					for kk, task in base.pairs(point.task.params.tasks) do
						task.number = kk
					end
				end
			end
		end	
	end
	
	if vdata.group then
		updateAutoActions_(vdata.group)
		actionsListBox:onGroupTaskChange()
		panel_triggered_actions.updateActionsListBox()
	end
	
end

initModule();

