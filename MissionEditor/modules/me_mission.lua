local base = _G

module('me_mission')

local require = base.require
local table = base.table
local math = base.math
local pairs = base.pairs
local ipairs = base.ipairs
local print = base.print
local tostring = base.tostring
local debug = base.debug

local S						= require('Serializer')
local MapColor				= require('MapColor')
local MapWindow				= require('me_map_window')
local MsgWindow				= require('MsgWindow')
local Terrain				= require('terrain')
local minizip				= require('minizip')
local Goal					= require('me_goal')
local Trigger				= require('me_trigrules')
local Gui					= require('dxgui')
local MenuBar				= require('me_menubar')
local MainMenu				= require('MainMenu')
local Window				= require('Window')
local Button				= require('Button')
local Debriefing			= require('me_debriefing')
local U						= require('me_utilities')
local T						= require('tools')
local crutches				= require('me_crutches')  -- temporary crutches
local lfs					= require('lfs')
local AutoBriefingModule	= require('me_autobriefing')
local i18n					= require('i18n')
local TEMPL					= require('me_template')
local actionDB				= require('me_action_db')
local me_db					= require('me_db_api')
local LogBook				= require('me_logbook')
local OptionsData			= require('Options.Data')
local MissionData			= require('Mission.Data')
local BeaconData			= require('Mission.BeaconData')
local TriggerZoneController = require('Mission.TriggerZoneController')
local NavigationPointController = require('Mission.NavigationPointController')
local CoalitionController	= require('Mission.CoalitionController')
local TheatreOfWarData		= require('Mission.TheatreOfWarData')
local AirdromeController	= require('Mission.AirdromeController')
local ModulesMediator		= require('Mission.ModulesMediator')
local LangController		= require('Mission.LangController')
local langPanel             = require('me_langPanel')
local MeSettings			= require('MeSettings')
local TableUtils 			= require('TableUtils')

local panel_aircraft		= require('me_aircraft')
local panel_ship			= require('me_ship')
local panel_vehicle			= require('me_vehicle')
local panel_route			= require('me_route')
local panel_suppliers		= require('me_suppliers')
local panel_payload			= require('me_payload')
local panel_targeting		= require('me_targeting')
local panel_summary			= require('me_summary')
local panel_static			= require('me_static')
local panel_briefing		= require('me_briefing')
local panel_failures		= require('me_failures')
local panel_roles			= require('me_roles')
local statusbar				= require('me_statusbar')
local panel_weather			= require('me_weather')
local toolbar               = require('me_toolbar')
local MapLayerController	= require('Mission.MapLayerController')
local mod_parking           = require('me_parking')
local autobriefingutils     = require('autobriefingutils')
local waitScreen			= require('me_wait_screen')
local Analytics				= require("Analytics")  
local mod_copy_paste 		= require('me_copy_paste')
local panel_dataCartridge	= require('me_dataCartridge')
local UC					= require('utils_common')
local mod_dictionary        = require('dictionary')
local editorManager         = require('me_editorManager')
local ProductType 			= require('me_ProductType') 
local me_draw_panel 		= require('me_draw_panel') 
local log      				= require('log')
local TriggerZoneController	= require('Mission.TriggerZoneController')
local managerModulesME 		= require('me_managerModulesME')
local loadoututilsV     	= require('me_loadoututilsVehicles')
local panel_triggered_actions = require('me_triggered_actions')

i18n.setup(_M)
local VERSION_MISSION = 22

-- maximum unit ID number
local maxUnitId = 0

-- maximum group ID number
local maxGroupId = 0

-- maximum zone ID number

local curDict = 'DEFAULT'

-- is random groups enabled
randomGroups = false


local fixUnitsByCountry =
{
    [17] = --	Insurgents
    {
        ["SA-18 Igla manpad"] = "Igla manpad INS",
        ["Stinger manpad GRG"] = "Stinger manpad",
        ["Soldier M4 GRG"] = "Soldier M4",
    },
    
    [16] = -- Georgia
    {
        ["Stinger manpad"] = "Stinger manpad GRG",
        ["Stinger manpad dsr"] = "Stinger manpad GRG",
        ["Soldier M4"] = "Soldier M4 GRG",
    },
    
    [15] = -- Israel
    {
        ["Stinger manpad"] = "Stinger manpad dsr",
        ["Stinger manpad GRG"] = "Stinger manpad dsr",
        ["Stinger comm"] = "Stinger comm dsr" ,
        ["Soldier M4 GRG"] = "Soldier M4",
    },
    
    [31] = -- Greece
    {
        ["Stinger manpad"] = "Stinger manpad dsr", 
        ["Stinger manpad GRG"] = "Stinger manpad dsr",
        ["Soldier M4 GRG"] = "Soldier M4",
    },
    
    ["Other"] = 
    {
        ["Stinger manpad dsr"] = "Stinger manpad", 
        ["Stinger manpad GRG"] = "Stinger manpad", 
        ["Stinger comm dsr"] = "Stinger comm", 
        ["Soldier M4 GRG"] = "Soldier M4",
    },
    
}

local tabelGroupId = {}

function check_alias(unit_table)
	if base.unit_aliases[unit_table.type] ~= nil then    
       -- base.print("-----check_alias=",unit_table.type,base.unit_aliases[unit_table.type])
       unit_table.type = base.unit_aliases[unit_table.type]
       return true
    end
    return false
end


local resourceFiles = {}

-- Структура объектов карты группы
--[[
  group.mapObjects = {
    -- Условные знаки юнитов.
    units = {
      [1] = {
        index = 1,
      },
    },
    -- Зоны обнаружения, досягаемости и т.п.
    zones = {
      [1] = {
      },
    },
    -- Маршрут
    route = {
      -- Линия, соединяющая точки маршрута, состоит из ломаных линий между этими точками.
      line = {
        [1] = {
          [1] = {x=..., y=...},
          ...
        },
        ...
      },
      -- Точки маршрута.
      points = {
        [1] = {
          index = 1,
        },
      },
      -- Подписи к точкам маршрута.
      numbers = {
        [1] = {
          index = 1,
        },
      },
      -- Цели, назначенные в точках маршрута.
      targets = {
        -- Внешние индексы соответствуют индексам точек маршрута.
        [1] = {
          [1] = {
            index = 1,
          },
        },
      },
      -- Номера целей, назначенных в точках маршрута.
      targetNumbers = {
        -- Внешние индексы соответствуют индексам точек маршрута.
        [1] = {
          [1] = {
            index = 1,
          },
        },
      },
      -- Зоны целей, назначенных в точках маршрута.
      targetZones = {
        -- Внешние индексы соответствуют индексам точек маршрута.
        [1] = {
          [1] = {
            index = 1,
          },
        },
      },
      -- Линии к целям от точек маршрута.
      targetLines = {
        -- Внешние индексы соответствуют индексам точек маршрута.
        [1] = {
          [1] = {
            index = 1,
          },
        },
      },
    },
  }
--]]

local mapElementsCreated_ = false

cdata =
{
  blue 						= 'BLUE',
  red 						= 'RED',
  newMission 				= _('New Mission.miz'),
  ok 						= _('OK'),
  mission_errors 			= _('Mission cannot be saved due to errors!'),
  save_mission 				= _('Save mission.'),
  save_mission_failed_msg 	= _('Can not write to file:'),
  warning_version 			= _('This mission is newer than this editor.\nPlease use a more recent editor version or continue at your own risk.'),
  need_modules 				= _('Need modules for load mission: '),
  need_modules_containing 	= _('The following module is required to install:'),  
  play_mission_failed_msg 	= _('Mission cannot be played due to errors! \nPlease edit mission.'),
  play_mission 				= _('Play mission.'),
  Mission_readonly 			= _('Mission readonly.'),
  FailActivation 			= _('This mission requires activation.'),
  ErrorLoading 				= _('Error loading mission "'),
  Unit001 					= _('Unit #001'),
  abort						= _("abort"),
  proceed					= _("proceed"),
}

if ProductType.getType() == "LOFAC" then
    cdata.need_modules = _('Need modules for load mission: -LOFAC')
    cdata.ErrorLoading = _('Error loading mission "-LOFAC')
end

coalitionColors =
{
  red = {
    color = MapColor.red_unselected,
    selectGroupColor 	= MapColor.red_group_selected,
    selectUnitColor 	= MapColor.red_unit_selected,
    selectWaypointColor = MapColor.red_waypoint_selected,
  },
  blue = {
    color = MapColor.blue_unselected,
    selectGroupColor 	= MapColor.blue_group_selected,
    selectUnitColor 	= MapColor.blue_unit_selected,
    selectWaypointColor = MapColor.blue_waypoint_selected,
  },
  neutrals = {
    color = MapColor.neutrals_unselected,
    selectGroupColor 	= MapColor.neutrals_group_selected,
    selectUnitColor 	= MapColor.neutrals_unit_selected,
    selectWaypointColor = MapColor.neutrals_waypoint_selected,
  },
}

group_types = {
  'plane',
  'helicopter',
  'ship',
  'vehicle',
  'static',
  'complex',
}

-------------------------------------------------------------------------------
-- Загруженная миссия в модуле всегда одна - текущая. 
-- Первоначально она пустая.
function create()
    if not created then    
        create_new_mission()
		MapWindow.setBullseye()
        created  = true;        
    end;  
end

function showErrorMessageBox(text, caption)
	MsgWindow.error(text, caption or _('ERROR'), 'OK'):show()
end

function showWarningMessageBox(text, caption)
	MsgWindow.warning(text, caption or _('WARNING'), 'OK'):show()
end

function showVersionMessageBox(text, caption)
	handler_ = MsgWindow.question(text, caption or _('QUESTION'), _('OK'), _('CANCEL'))
	local result = false
	
	function handler_:onChange(buttonText)
		result = (buttonText == _('OK'))
	end
	
	handler_:show()
	handler_ = nil

	return result
end

-------------------------------------------------------------------------------
--
function createCirclePoints(x, y, radius)
  local points = {}
  local sides = 32
  local da = 2 * math.pi / sides
  local sin = math.sin
  local cos = math.cos
	
  for i = 0, sides do
    local p = MapWindow.createPoint(x + radius * sin(da * i), 
                                    y + radius * cos(da * i))

    table.insert(points, p)
  end	
  
  return points
end

function createCircleLinePoints(x, y, radius)
	local points = createCirclePoints(x, y, radius)
	
	table.insert(points, points[1])
	
	return points
end

function createSectorPoints(a_x, a_y, a_radius, a_AuthoritySector, a_angle)
	local points = {}
	local sectorAngle = a_AuthoritySector[1] - a_AuthoritySector[2]
	if sectorAngle < 0 then
		sectorAngle = 2 * math.pi + sectorAngle
	end
	local sides = 32 / math.abs(math.floor((2 * math.pi / sectorAngle)+0.5))
	local da = (sectorAngle) / sides
	local sin = math.sin
	local cos = math.cos
	local angle	= -a_angle + math.pi / 2 -- для правильной ориентации на карте

	local firstP = MapWindow.createPoint(a_x, a_y)
	table.insert(points, firstP)
	
	for i = 0, sides do
		local p = MapWindow.createPoint(a_x + a_radius * sin(angle + a_AuthoritySector[1] - (da * i)), 
									a_y + a_radius * cos(angle + a_AuthoritySector[1] - (da * i)))

		table.insert(points, p)
	end	
	
	table.insert(points, points[1])

	return points
end
-------------------------------------------------------------------------------
--
function createILSPoints(x, y, angle, lenght)
    local points = {}
    local points2 = {}
    local lenght_side = 12900
    local offset_angle = math.pi / 36
    local sin = math.sin
    local cos = math.cos
    
    local centralPointX = x + lenght * sin(angle)
    local centralPointY = y + lenght * cos(angle)

    local p = MapWindow.createPoint(x, y )
    table.insert(points, p)
    
    p = MapWindow.createPoint(x + lenght_side * sin(angle + offset_angle), 
                                    y + lenght_side * cos(angle + offset_angle))
    table.insert(points, p)    

    p = MapWindow.createPoint(centralPointX, centralPointY)
    table.insert(points, p) 
    
    p = MapWindow.createPoint(x, y)
    table.insert(points2, p)    
              
    p = MapWindow.createPoint(centralPointX, centralPointY)
    table.insert(points2, p)  
    
    p = MapWindow.createPoint(x + lenght_side * sin(angle - offset_angle), 
                                    y + lenght_side * cos(angle - offset_angle))                                
    table.insert(points2, p)

    return points, points2
end

-------------------------------------------------------------------------------
--
local function createCircle(x, y, radius, classKey, id, color, stencil)
  local points = createCirclePoints(x, y, radius)
  
  return MapWindow.createSQR(classKey, id, points, color, stencil)
end

--[[ При загрузке из файла миссий, созданных в редакторе до добавления галки "PLAYER CAN DRIVE" 
нужно выставить в true эту опцию для всех наземных юнитов, которые присутствуют в мисии ]]
function fixVehicleSettings()
	for _tmp, group in pairs(group_by_id) do
		if group.type == 'vehicle' then
			for k,unit in pairs(group.units) do
				if(unit.playerCanDrive == nil) then
                    local unitDef = me_db.unit_by_type[unit.type]
					unit.playerCanDrive = unitDef.enablePlayerCanDrive or false -- если можно ставим true
				end
				
				if(unit.coldAtStart == nil) then
					unit.coldAtStart = false
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-- find and write countries names
function fixCountriesNames(countries)
    for _tmp,v in pairs(countries) do
        v.name = me_db.country_by_id[v.id].Name
    end
end

-------------------------------------------------------------------------------
-- 
function fixWeather(a_weather)
    if (a_weather.fog.visibility == nil) then
        local fogVisibility = 
        {
            [0] = 10000,
            [1] = 5120,
            [2] = 2560,
            [3] = 1280,
            [4] = 640,
            [5] = 320,
            [6] = 160,
            [7] = 80,
            [8] = 40,
            [9] = 20,
            [10] = 10,
        }
        if (a_weather.fog.density == 0) then
            a_weather.fog.thickness = 0
            a_weather.fog.visibility = 0
            a_weather.enable_fog =    false
        else
            a_weather.enable_fog =    true
            a_weather.fog.visibility = fogVisibility[a_weather.fog.density]
        end		
    end
	a_weather.fog.density = nil
	
	if a_weather.dust_density == nil then
		a_weather.enable_dust = false
		a_weather.dust_density = 0
	end
    
    if a_weather.season and a_weather.season.iseason then
        a_weather.season.iseason = nil
    end
	
	if a_weather.modifiedTime == nil then
        a_weather.modifiedTime = true
    end
	
	if a_weather.halo == nil then
		a_weather.halo = {preset = 'off', crystalsPreset = nil}
	end
end

-------------------------------------------------------------------------------
-- convert categories IDs to categories names
function fixStaticCategories(coalition)
    for _tmp, country in pairs(coalition.country) do
		country.static = country.static or {}
		country.static.group = country.static.group or {}
        for _tmp, group in pairs(country.static.group) do
            group.units[1].category = crutches.staticCategoryIdToName(
                group.units[1].category)
        end
    end
end

-------------------------------------------------------------------------------
--
function fixUnitsPos()
	for _tmp, v in pairs(unit_by_id) do
		if v.boss then
			if v.boss.route 
				and (not (v.boss.route.points[1].action == 'From Ground Area' 
				   or v.boss.route.points[1].action == 'From Ground Area Hot'
				   or v.boss.route.points[1].action == 'On Road')) then
				local p1 = v.boss.route.points[1]				
				if p1 then
					v.speed 	= p1.speed
					v.alt		= p1.alt
					v.alt_type 	= p1.alt_type
					local p2 	= v.boss.route.points[2]
					if p2 and v.boss.manualHeading ~= true then
						v.heading = math.atan2(p2.y - p1.y, p2.x - p1.x)
					end					
				end
			end
		end
	end
end

function fixNoValidUnitsPayload()
    for _tmp, group in pairs(group_by_id) do
        for k, unit in pairs(group.units) do  
            local unitDef = me_db.unit_by_type[unit.type]
            if unit.payload and unit.payload.pylons then                
                for k, pylon in base.pairs(unit.payload.pylons) do
                    if not unitDef.Pylons or unitDef.Pylons[k] == nil then
                        base.print("ERROR: Not valid pylon number =",k)
                        unit.payload.pylons[k] = nil                    
                    elseif me_db.weapon_by_CLSID[pylon.CLSID] == nil then
                        base.print("ERROR: Not valid pylon CLSID =",pylon.CLSID)
                        unit.payload.pylons[k] = nil
                    end
                end
            end
        end
	end	
end

function fixUh1HUnitsPayload()
	for _tmp, group in pairs(group_by_id) do
        if ("helicopter" == group.type) and (group.units) then
			for k, unit in pairs(group.units) do
				--print('UH1H found')  
                local pylon3CLSID = nil
                local pylon4CLSID = nil               
				if "UH-1H" == unit.type and unit.payload and unit.payload.pylons then
					if unit.payload.pylons[3] then
						pylon3CLSID = unit.payload.pylons[3].CLSID
					end
					
					if unit.payload.pylons[4] then
						pylon4CLSID = unit.payload.pylons[4].CLSID
					end	
					
					if ((pylon3CLSID and pylon3CLSID ~= "" and pylon3CLSID ~= "M134_SIDE_L" and pylon3CLSID ~= "M60_SIDE_L") or 
						(pylon4CLSID and pylon4CLSID ~= "" and pylon4CLSID ~= "M134_SIDE_R" and pylon4CLSID ~= "M60_SIDE_R"))  then
						--print('UH1H payload fixing')
						if pylon3CLSID then
							unit.payload.pylons[5] = {CLSID = unit.payload.pylons[3].CLSID}				
						end
						unit.payload.pylons[3] = {CLSID = "M60_SIDE_L"}
						
						if pylon4CLSID then
							unit.payload.pylons[6] = {CLSID = unit.payload.pylons[4].CLSID}
						end
						unit.payload.pylons[4] = {CLSID = "M60_SIDE_R"}
                    end
				end
			end
		end
	end	
end

-------------------------------------------------------------------------------
-- substitude skills IDs by skills names
function fixUnitsSkills()
    for _tmp, v in pairs(unit_by_id) do
        if v.skill then
			if v.boss.type == "helicopter" or v.boss.type == "plane" then	
				v.skill = crutches.idToSkillAir(v.skill)
			else
				v.skill = crutches.idToSkill(v.skill)
			end
        end
    end
end

-------------------------------------------------------------------------------
-- если у статик самолета/вертолета нет LiveryId - ставим дефолтный
function fixLiveryId()
    for _tmp, v in pairs(unit_by_id) do
        if me_db.plane_by_type[v.type] ~= nil or me_db.helicopter_by_type[v.type] ~= nil then
            if (not v.livery_id) then               
                base.panel_static.setDefaultLivery(v)
                --print('fixLiveryId',v.name,v.livery_id)
            end
        end
    end
end

function fixSCR522()
    for _tmp, unit in pairs(unit_by_id) do
        if unit.SCR522 then
            unit.Radio = {}
            unit.Radio[1] = {}
            local unitTypeDesc = me_db.unit_by_type[unit.type]
           
            if (unitTypeDesc.panelRadio ~= nil) then
                for k, radio in base.ipairs(unitTypeDesc.panelRadio) do
                    unit.Radio[k] = {}
                    unit.Radio[k].id = radio.id
                    unit.Radio[k].channels = {}
                    if radio.channels then
                        for kk, channel in base.ipairs(radio.channels) do             
                            unit.Radio[k].channels[kk] = channel.default    
                        end
                    end
                end
            end    
            if unit.Radio[1] then
                unit.Radio[1] = {}
                unit.Radio[1]["channels"] = {}
                local channels = unit.Radio[1]["channels"]
                channels[1] = unit.SCR522["ButtonA"]
                channels[2] = unit.SCR522["ButtonB"]
                channels[3] = unit.SCR522["ButtonC"]
                channels[4] = unit.SCR522["ButtonD"]
            end
            unit.SCR522 = nil
        end
    end
end
-------------------------------------------------------------------------------
-- 
function fixAirdromeId()
    for _tmp, v in pairs(group_by_id) do
        for _k, _point in pairs(v.route.points) do	
            if _point.airdromeId == 0  then
                _point.airdromeId = nil				
            end
        end
    end            
end

-------------------------------------------------------------------------------
--
function fixSpans()
    for _tmp1, v in pairs(group_by_id) do
        if v.route and v.route.spans ~= nil and (#v.route.spans == 0 or not v.route.spans[1][1].x) then
            generateSpans(v.route)
        end
    end
end

-------------------------------------------------------------------------------
--
function isOnRoad(point)
    return point.type == panel_route.actions.onRoad;
end

-------------------------------------------------------------------------------
--
function isOnRailroad(point)
    return point.type == panel_route.actions.onRailroad;
end

-------------------------------------------------------------------------------
--
function generateSpans(route)
    if #route.points < 2 then return end
    
    local p1, p2
    local spans = {}
    for i = 2, #route.points do
        p1 = route.points[i-1]
        p2 = route.points[i]
        if (not isOnRoad(p1) or not isOnRoad(p2)) then
            spans[i-1] = {{y = p1.y, x = p1.x}, {y = p2.y, x = p2.x}}   
        else
            local typeRoad = 'roads'
            if isOnRailroad(p1) or isOnRailroad(p2) then
                typeRoad = 'railroads'
            end
            local path = FindOptimalPath(typeRoad, p1.x, p1.y, p2.x, p2.y)
            
            if path and #path > 0 then
                local s = {}
                for i=1, #path do
                    table.insert(s, {x=path[i].x, y=path[i].y})
                end
                spans[i-1] = s
            end
        end
    end
    
    p1 = route.points[#route.points]
    spans[#route.points] = {{y = p1.y, x = p1.x}, {y = p1.y, x = p1.x}};
    
    route.spans = spans;
end

-------------------------------------------------------------------------------
-- substitute tasks names with task IDs
function fixTasks()
    for _tmp, group in pairs(group_by_id) do
        if group.task then
            group.task = crutches.idToTask(group.task)	
            local unitType = group.units[1].type    
			if not group.taskSelected then				
				--print('unitType = '..unitType)
				local defaultTask = me_db.unit_by_type[unitType].DefaultTask
				if defaultTask ~= nil then
					if group.task ~= defaultTask.Name then
						print('The default task for '..unitType..' is '..defaultTask.Name..' not matched')
						group.taskSelected = true
					end
				else
					print('No default task for '..unitType)
					group.taskSelected = true					
				end			
			end
            
            if me_db.unit_by_type[unitType].Tasks then
                local enable = false
                for k,v in base.pairs(me_db.unit_by_type[unitType].Tasks) do
                    if (group.task == v.Name) then
                        enable = true
                    end
                end
                if (enable == false) and (group.task ~= me_db.getDefaultTaskName()) then
                    local defaultTask = me_db.unit_by_type[unitType].DefaultTask
                    if defaultTask ~= nil then
                        group.task = defaultTask.Name
                    end
                end
            end
        end
    end
end

local function fixWptTasks()
	for _tmp1, group in pairs(group_by_id) do
		if group.route and pairs(group.route.points) then
			for wi, wpt in ipairs(group.route.points) do

				if wpt.task and wpt.task.params and wpt.task.params.tasks then				
					local maxIndex = #wpt.task.params.tasks
					if maxIndex > 0 then
						for i = maxIndex, 1, -1 do
							local task = wpt.task.params.tasks[i]
							if task.id == "Follow" and task.params then
								if task.params.lastWptIndexFlagChangedManually == nil 
									and task.params.lastWptIndexFlag == nil
									and task.params.lastWptIndex == 0 then
									
									for index = i+1, #wpt.task.params.tasks do
										wpt.task.params.tasks[index].number = wpt.task.params.tasks[index].number - 1
									end
									--MsgWindow.warning("del task "..wpt.boss.name, _('Warning'), 'OK'):show()	
									base.table.remove(wpt.task.params.tasks,i)																
								end
							end
							
							if mission.version < 16 and task.id == "Embarking" then
								if task.params and task.params.groupsForEmbarking then
									-- делаем из таблицы с индексами = groupId массив
									local newTable = {}
									for _index, _groupId in base.pairs(task.params.groupsForEmbarking) do
										base.table.insert(newTable, _groupId)
									end
									task.params.groupsForEmbarking = newTable
								end
								
								if task.params and task.params.distribution then
									local newTableDist = {}
									for _keyDist, _EmbTbl in base.pairs(task.params.distribution) do
										local newTable = {}
										for _index, _groupId in base.pairs(_EmbTbl) do
											base.table.insert(newTable, _groupId)
										end	
										newTableDist[_keyDist] = newTable
									end
									task.params.distribution = newTableDist
								end
							end
							if task.id == "WrappedAction" and task.params and task.params.action 
								and task.params.action.id == "Option"  and task.params.action.params.name == 8 
								and base.type(task.params.action.params.value) == "boolean" then  --DISPERSE_ON_ATTACK

								if task.params.action.params.value == false then
									task.params.action.params.value = nil
								else
									task.params.action.params.value = 600
								end								
							end							
						end
					end
										
					if mission.version < 15 then
						maxIndex = #wpt.task.params.tasks
						if maxIndex > 0 then
							for i = maxIndex, 1, -1 do
								local task = wpt.task.params.tasks[i]
								if task and task.params and task.params.action and task.params.action.id == "ActivateBeacon" then
									if task.params.action.params and task.params.action.params.unitId == nil then
										task.params.action.params.unitId = group.units[1].unitId
									end
								end
							end
						end	
					end				
				end

				if group.type ~= 'static' then				
					-- если посадка посреди маршрута
					if wpt.type.type == 'Land' and wpt.type.action == 'Landing' and wi < #group.route.points then					
						base.print("fix Landing, groupId, numPoint, allPoints:",group.groupId,wi,#group.route.points)
						wpt.type = panel_route.waypointActionToType("Turning Point", "Turning Point", group.type)
						wpt.airdromeId = nil
						wpt.helipadId = nil
					end
					
					-- если action = 'Off Road' не у машинки
					if wpt.type.action == 'Off Road' and group.type ~= 'vehicle' then
						base.print("fix Off Road, groupId, group.type, numPoint, allPoints:",group.groupId,group.type,wi,#group.route.points)
						wpt.type = panel_route.waypointActionToType("Turning Point", "Turning Point", group.type)
					end
				end
			end
		end	
	end
end			
	
-------------------------------------------------------------------------------
--
local function fixAction(action, number)
	action.auto = action.auto or false
	action.valid = action.valid
	action.number = action.number or number
	action.name = action.name or ''
end

-------------------------------------------------------------------------------
--
local function actionToTask(action)
	local actionType = action.actionType
	action.actionType = nil
	action.id = action.action
	action.action = nil
	if actionType == 'Action' then
		local wrappedAction = {}
		U.recursiveCopyTable(wrappedAction, action)
		wrappedAction.id = 'WrappedAction'
		wrappedAction.number = action.number
		wrappedAction.name = action.name
		wrappedAction.valid = action.valid
		wrappedAction.params = {
			action = action
		}
		return wrappedAction
	else
		return action
	end
end

-------------------------------------------------------------------------------
--
local function convertActionsToComboTask(actions)
	local taskList = {}    
	for actionIndex, action in pairs(actions) do	
		fixAction(action, actionIndex)
		taskList[actionIndex] = actionToTask(action)
	end
	return {
		id = 'ComboTask',
		params = {
			tasks = taskList
		}
	}
end

-------------------------------------------------------------------------------
-- fix task valid
local function resetTaskValid(task)
	task.valid = nil
	for i, v in base.pairs(task) do
		if base.type(v) == 'table' then
			resetTaskValid(v)
		end
	end
end

function fixWaypointForGroup(group)
	if group.route and pairs(group.route.points) then
		local targetZoneFormat = false
		local targetZoneQty = 0
		local lastETA = 0

		for wi, w in ipairs(group.route.points) do
			w.type = panel_route.waypointActionToType(w.type, w.action, group.type)
			w.action = nil
			w.alt_type = w.alt_type or panel_route.alt_types_all.BARO.type
			w.delay = w.delay or 0
			if w.actions then
				w.task = convertActionsToComboTask(w.actions)
				w.actions = nil
			end
			if w.speed_locked == nil then
				w.speed_locked = true
			end
			if w.ETA_locked == nil then
				w.ETA_locked = (wi == 1)
			end
			
			if w.ETA == nil then                    
				if wi > 1 then
					local speed = group.route.points[wi].speed
					if (w.type == panel_route.actions.landing) then
						speed = group.route.points[wi-1].speed
					end    
					if (speed < 1) then
						speed = 1
					end
					local dx = (w.x - group.route.points[wi - 1].x)
					local dy = (w.y - group.route.points[wi - 1].y)
					local legLength = math.sqrt(dx * dx + dy * dy)     
					w.ETA = lastETA + legLength / speed
				else
					if group.start_time ~= nil then
						w.ETA = group.start_time
					else
						w.ETA = 0.0
					end
				end
			end
			lastETA = w.ETA
			if w.targets ~= nil then
				targetZoneFormat = true
				targetZoneQty = targetZoneQty + #w.targets
			end
			if w.task ~= nil then
				resetTaskValid(w.task)
			end
			
			if w.task and w.task.params and w.task.params.tasks then   
				for _tmp, task in pairs(w.task.params.tasks) do 
					if (task.id == "FireAtPoint") then
						local actionData = actionDB.getActionDataByTask(task)
						task.params.expendQtyEnabled    = task.params.expendQtyEnabled or actionData.task.params.expendQtyEnabled
						task.params.expendQty           = task.params.expendQty or actionData.task.params.expendQty
						task.params.templateId          = task.params.templateId or actionData.task.params.templateId
						task.params.zoneRadius          = task.params.zoneRadius or actionData.task.params.zoneRadius
						task.params.weaponType          = task.params.weaponType or MAXUINT
					end
				end
				
				if mission.version < 22 then
					for _tmp, task in pairs(w.task.params.tasks) do 
						if task.params and task.params.action and task.params.action.params and task.params.action.params.targetTypes
							and task.params.action.params.noTargetTypes and task.params.action.params.value then
							local enablePlanes = false	
							for k, v in pairs(task.params.action.params.targetTypes) do
								if v == "Planes" then
									enablePlanes = true
								end	
							end
							
							if enablePlanes then
								base.table.insert(task.params.action.params.targetTypes, "UAVs")
								task.params.action.params.value = task.params.action.params.value.."UAVs;"
							else
								base.table.insert(task.params.action.params.noTargetTypes, "UAVs")								
							end	
						end	
					end				
				end
			end
		end
		
		local groupTask = crutches.taskToId(group.task) or 'Default'
		if targetZoneFormat then
			if targetZoneQty == 0 then
				local firstWpt = group.route.points[1]
				if firstWpt.task == nil then
					firstWpt.task = {
						id = 'ComboTask',
						params = {
							tasks = {}
						}
					}				
					--auto tasks
					local autoTasks = actionDB.createAutoActions(group, groupTask)
					if autoTasks ~= nil then
						for autoTasksIndex, autoTask in pairs(autoTasks) do
							table.insert(firstWpt.task.params.tasks, autoTasksIndex, autoTask)
						end
					end
				end
			else
				for wi, w in pairs(group.route.points) do
					if w.task == nil then
						w.task = {
							id = 'ComboTask',
							params = {
								tasks = {}
							}
						}							
						if w.targets then
							--target zones to tasks
							for targetIndex, target in pairs(w.targets) do
								local targetTypes = nil
								if 	group.type == 'plane' or
									group.type == 'helicopter' then												
									for categoryIndex, category in pairs(target.categories) do
										local taskNumber = #w.task.params.tasks + 1
										if category == 'Point' then
											local bombing = {
												number = taskNumber,
												enabled = true,
												auto = false,										
												id = 'Bombing',
												params = {
													x = target.x,
													y = target.y,
													weaponType = MAXUINT,
													expend = 'All',
													attackQty = 1
												}
											}
											table.insert(w.task.params.tasks, taskNumber, bombing)
											bombing.valid = actionDB.isActionValid(bombing, group, w, groupTask)
										elseif category == 'Airfields' then
											local nearestAirdrome = me_db.getNearestAirdrome(target.x, target.y)
											local bombingRunway = {
												number = taskNumber,
												enabled = true,
												auto = false,										
												id = 'BombingRunway',
												params = {
													runwayId = nearestAirdrome and nearestAirdrome.ID or 0,
													weaponType = MAXUINT,
													expend = 'All',
													attackQty = 1,
													groupAttack = true
												}
											}
											table.insert(w.task.params.tasks, taskNumber, bombingRunway)
											bombingRunway.valid = actionDB.isActionValid(bombingRunway, group, w, groupTask)
										else
											targetTypes = targetTypes or {}
											if category == 'Vehicles' then
												category = 'Ground Units'
											end
											table.insert(targetTypes, category)																			
										end
									end
									if targetTypes ~= nil then
										local taskNumber = #w.task.params.tasks + 1
										local engageTargetsInZone = {
											number = taskNumber,
											enabled = true,
											auto = false,
											id = 'EngageTargetsInZone',
											params = {
												x = target.x,
												y = target.y,
												zoneRadius = target.radius,
												targetTypes = targetTypes,										
											},
											priority = 0
										}
										table.insert(w.task.params.tasks, taskNumber, engageTargetsInZone)
										engageTargetsInZone.valid = actionDB.isActionValid(engageTargetsInZone, group, w, groupTask)
									end							
								else
									local taskNumber = #w.task.params.tasks + 1
									local fireAtPoint = {
										number = taskNumber,
										enabled = true,
										auto = false,										
										id = 'FireAtPoint',
										params = {
											x = target.x,
											y = target.y,
											zoneRadius = target.radius,
										}
									}
									table.insert(w.task.params.tasks, taskNumber, fireAtPoint)
									fireAtPoint.valid = actionDB.isActionValid(fireAtPoint, group, w, groupTask)		
								end
							end
						end
					end
				end
			end
		else
			for wi, w in pairs(group.route.points) do
				if w.task then
					local tasks = w.task.params.tasks						
					local number = 1
					while number <= #tasks do
						if  mission.version < 8 then
							if tasks[number].params 
								and tasks[number].params.action
								and tasks[number].params.action.params 
								and tasks[number].params.action.params.file then
								if tasks[number].params.action.params.file ~= "" then
									local resId = mod_dictionary.getNewResourceId("advancedFile") 
									local file = tasks[number].params.action.params.file    
									local filename = "l10n/DEFAULT/"..file
									mod_dictionary.fixValueToResource(resId, file, filename)
									tasks[number].params.action.params.file = resId 
								else
									tasks[number].params.action.params.file = nil    
								end
							end            
						end
						
						if actionDB.isActionValid(tasks[number], group, w, groupTask) ~= nil then
							for i = number + 1, #tasks do
								tasks[i].number = tasks[i].number - 1
								tasks[i - 1] = tasks[i]
							end
							table.remove(tasks, #tasks)
							base.print("Removed tasks for the group:",group.name)
						end
						number = number + 1
					end
				end
			end
		end
		for wi, w in pairs(group.route.points) do
			w.targets = nil
		end
	end
end

-------------------------------------------------------------------------------
-- fix waypoints
function fixWaypoints()
    local MAXUINT = 4294967296 - 1
    for _tmp1, group in pairs(group_by_id) do
		fixWaypointForGroup(group)	
    end
end

-------------------------------------------------------------------------------

local function onWptTasksRemove(group, wpt)
	if wpt.task then
		for taskIndex, task in pairs(wpt.task.params.tasks) do
			actionDB.onTaskRemove(group, wpt, task)
		end
	end
end

local function onGroupTasksRemove(group)
	if group.route then
		for wptIndex, wpt in pairs(group.route.points) do
			onWptTasksRemove(group, wpt)
		end
	end
    if (group.tasks) then
        for triggeredTaskIndex, triggeredTask in pairs(group.tasks) do
            actionDB.onTaskRemove(group, nil, triggeredTask)
        end	
    end  	
end

function onTasksRemoveFromOtherGroupsForWpt(a_group, a_wpt)
	local bEnable = false

	if a_wpt and a_wpt.task and a_wpt.task.params and a_wpt.task.params.tasks then
		for kkk, wptTask in base.ipairs(a_wpt.task.params.tasks) do
			if wptTask.id == 'EmbarkToTransport' then
				bEnable = true
			end
		end
	end

	if bEnable == false then
		return
	end
	
	removeGroupsFromTasks(a_group)
end

function removeGroupsFromTasks(a_group)
	local function removeGroupFromTasks(a_group, a_tasks, a_groupTask)
		for kkk, wptTask in base.ipairs(a_tasks) do
			--base.U.traverseTable(wptTask)
			if wptTask.id == "Embarking" or wptTask.id == "Disembarking" then
				for i, v in base.pairs(wptTask.params.groupsForEmbarking) do
					if v == a_group.groupId then
						base.table.remove(wptTask.params.groupsForEmbarking,i)
						break
					end
				end
				
				if wptTask.params.distribution then
					for i, distr in base.pairs(wptTask.params.distribution) do
						for ii, vv in base.pairs(distr) do
							if vv == a_group.groupId then
								wptTask.params.distribution[i][ii] = nil
								break
							end
						end
					end
				end
			end
			
			if wptTask.id == "AttachTrailer" then				
				if a_groupTask.groupId == a_group.groupId then
					wptTask.params.unitIdTrailer = nil	
				else
					for i, unit in base.pairs(a_group.units) do
						if unit.unitId == wptTask.params.unitIdTrailer then
							wptTask.params.unitIdTrailer = nil
						end
					end
				end
			end
			
			if wptTask.id == "RecoveryTanker" then				
				if wptTask.params and wptTask.params.groupId == a_group.groupId then
					wptTask.params.groupId = nil	
				end
			end
		end	
	end
	
	for groupIndex, group in pairs(group_by_id) do	
		-- advanced actions
		if group.route and group.route.points then		
			for wptIndex, wpt in pairs(group.route.points) do
				if wpt and wpt.task and wpt.task.params and wpt.task.params.tasks then
					removeGroupFromTasks(a_group, wpt.task.params.tasks, group)
				end		
			end
		end	
		--trigger actions
		if group.tasks then
			removeGroupFromTasks(a_group, group.tasks, group)
		end
	end	
	
	local groupsCopied = mod_copy_paste.getGroupsCopied()
	if groupsCopied then
		for groupIndex, group in pairs(groupsCopied) do	
			-- advanced actions
			if group.route and group.route.points then		
				for wptIndex, wpt in pairs(group.route.points) do
					if wpt and wpt.task and wpt.task.params and wpt.task.params.tasks then
						removeGroupFromTasks(a_group, wpt.task.params.tasks)
					end		
				end
			end	
			--trigger actions
			if group.tasks then
				removeGroupFromTasks(a_group, group.tasks)
			end
		end
	end
end

function onTasksRemoveFromOtherGroups(a_group)
	-- local bEnable = false
	-- if a_group.route and a_group.route.points then
		-- for i,wpt in base.pairs(a_group.route.points) do
			-- if wpt and wpt.task and wpt.task.params and wpt.task.params.tasks then
				-- for kkk, wptTask in base.ipairs(wpt.task.params.tasks) do
					-- if wptTask.id == 'EmbarkToTransport' then
						-- bEnable = true
					-- end
				-- end
			-- end
		-- end	
	-- end

	-- if bEnable == false then
		-- return
	-- end
	
	removeGroupsFromTasks(a_group)
end

function checkEmbarkingTasks(a_group)
	-- advanced actions
	if a_group.route and a_group.route.points then		
		for wptIndex, wpt in pairs(a_group.route.points) do
			if wpt and wpt.task and wpt.task.params and wpt.task.params.tasks then
				for kkk, wptTask in base.ipairs(wpt.task.params.tasks) do	
					if wptTask.id == "Embarking" or wptTask.id == "Disembarking" then
						if wptTask.params and wptTask.params.groupsForEmbarking and #wptTask.params.groupsForEmbarking >0 then
							return true
						end
					end
				end
			end
		end
	end

	--trigger actions
	if a_group.tasks then
		for kkk, wptTask in base.ipairs(a_group.tasks) do
			if wptTask.id == "Embarking" or wptTask.id == "Disembarking" then
				if wptTask.params and wptTask.params.groupsForEmbarking and #wptTask.params.groupsForEmbarking >0 then
					return true
				end
			end
		end	
	end
	
	return false
end

-- группа сменила коалицию
-- надо почистить все задачи ее и других груп где она использовалась
function onGroupChangeCoalition(a_group)
	onTasksRemoveFromOtherGroups(a_group)

	-- advanced actions
	if a_group.route and a_group.route.points then		
		for wptIndex, wpt in pairs(a_group.route.points) do
			if wpt and wpt.task and wpt.task.params and wpt.task.params.tasks then
				for kkk, wptTask in base.ipairs(wpt.task.params.tasks) do
					if wptTask.id == "Embarking" then
						wptTask.params.groupsForEmbarking = {}
						wptTask.params.distribution = {}
					end

					if wptTask.id == "Disembarking" then
						wptTask.params.groupsForEmbarking = {}
					end
					
					if wptTask.id == "RecoveryTanker" then
						wptTask.params.groupId = nil
					end
				end
			end		
		end
	end	
	
	--trigger actions
	if a_group.tasks then
		for kkk, wptTask in base.ipairs(a_group.tasks) do
			if wptTask.id == "Embarking" then
				wptTask.params.groupsForEmbarking = {}
				wptTask.params.distribution = {}
			end

			if wptTask.id == "Disembarking" then
				wptTask.params.groupsForEmbarking = {}
			end
			
			if wptTask.id == "RecoveryTanker" then
				wptTask.params.groupId = nil
			end
		end	
		panel_triggered_actions.updateActionsListBox()
	end
end


-------------------------------------------------------------------------------
-- add EPLRS
function addEPLRS()
	for groupIndex, group in pairs(group_by_id) do
	
		for wptIndex, wpt in pairs(group.route.points) do
			if wpt.task then
				local tasks = wpt.task.params.tasks
				for taskIndex, task in pairs(tasks) do
					if task.id == 'WrappedAction' then
						local action = task.params.action
						if action.id == 'EPLRS' then
							for i = taskIndex + 1, #tasks do
								tasks[i].number = tasks[i].number - 1
								tasks[i - 1] = tasks[i]
							end
							table.remove(tasks, #tasks)
						end
					end
				end
			end
		end	
	
		local firstWpt = group.route.points[1]
		local autoTaskEPLRS = actionDB.createAutoTaskFor(group, firstWpt, actionDB.ActionId.EPLRS, 1)
		if autoTaskEPLRS then			
			if firstWpt.task == nil then
				firstWpt.task = {
					id = 'ComboTask',
					params = {
						tasks = {}
					}
				}
			end
			for subTaskIndex, subTask in pairs(firstWpt.task.params.tasks) do
				subTask.number = subTask.number + 1
			end
			table.insert(firstWpt.task.params.tasks, 1, autoTaskEPLRS)			
		end
	end
end
-------------------------------------------------------------------------------
function fixVariants()
	for groupIndex, group in pairs(group_by_id) do
		group.variantProbability =	group.variantProbability or 
									{
										{ value = 100, changed = false }
									}		
	end
end

-------------------------------------------------------------------------------
local possibleToChangeModulationInPanel = false

-- fix radio
function fixRadio()
	for groupIndex, group in pairs(group_by_id) do
		if group.type == 'plane' or group.type == 'helicopter' then
            if group.communication == nil then
                group.communication = true
            end
			if group.frequency == nil or group.modulation == nil or not group.radioSet then
				group.frequency, group.modulation = panel_aircraft.getDefaultRadioFor(group)
			elseif not possibleToChangeModulationInPanel then
				local defaultFrequency, defaultModulation = panel_aircraft.getDefaultRadioFor(group)
				group.modulation = defaultModulation
			end
			group.radioSet = group.radioSet or false
            
            for k,unit in base.pairs(group.units) do
                if unit.Radio then
                    local unitTypeDesc = me_db.unit_by_type[unit.type]
                    if (unitTypeDesc.panelRadio ~= nil) then
                        for k, radio in base.ipairs(unitTypeDesc.panelRadio) do
                            unit.Radio[k] = unit.Radio[k] or {}
                            unit.Radio[k].channels = unit.Radio[k].channels or {}
                            if radio.channels then
                                for kk, channel in base.ipairs(radio.channels) do
                                    unit.Radio[k].channels[kk] = unit.Radio[k].channels[kk] or channel.default
                                end
                            end
                        end
                    end  
                end
            end
            
		end
	end
end

-------------------------------------------------------------------------------
-- добавляем дефолтные данные в AddPropAircraft если их нет в миссии
function fixAddPropAircraft()  
    for groupIndex, group in pairs(group_by_id) do
		if group.type == 'plane' or group.type == 'helicopter' then
            for k,unit in base.pairs(group.units) do
                local unitTypeDesc = me_db.unit_by_type[unit.type]
                if (unitTypeDesc.AddPropAircraft ~= nil) then
                    if unit.AddPropAircraft == nil then
                        unit.AddPropAircraft = {} 
                    end    
                    for kk, vv in base.pairs(unitTypeDesc.AddPropAircraft) do
                        if (unit.AddPropAircraft[vv.id] == nil)                            
                            and ((vv.playerOnly ~= true) 
                                or (unit.skill == crutches.getPlayerSkill())
                                or (unit.skill == crutches.getClientSkill())) then                            
                            unit.AddPropAircraft[vv.id] = vv.defValue
                        end  
                    end
                end                
            end
        end
    end           
end


-------------------------------------------------------------------------------
-- fix types of waypoints
function fixWaypointsTypes()
    for _tmp1, v in pairs(group_by_id) do
        if v.route and pairs(v.route.points) then
            for _tmp, w in pairs(v.route.points) do
                w.type = panel_route.waypointActionToType(w.type, w.action, v.type)
                w.action = nil
            end
        end
    end
end

-------------------------------------------------------------------------------
-- fix waypoint linkage
function fixWaypointsLinks()
    for _tmp, v in pairs(group_by_id) do
        if ("plane" == v.type) or ("helicopter" == v.type) then
            if v.route and pairs(v.route.points) then
                for _tmp, w in pairs(v.route.points) do
                    if w.linkParent then -- для совместимости со старыми миссиями
                        local groupNum = w.linkParent
                        w.linkParent = nil
                        -- цепляем к 1-му юниту
                        local unitInd, unit = base.next(unit_by_id)
                        linkWaypoint(w, group_by_id[groupNum], unit)
                    else
                        if w.linkUnit then -- новая редакция
                            local unitNum = w.linkUnit
                            w.linkParent = nil
                            w.linkUnit = nil
                            local unit = unit_by_id[unitNum]
							if unit ~= nil then
								linkWaypoint(w, unit.boss, unit)
							else
								w.helipadId = nil	
							end
                        end
                    end
					
					if w.linkSnap then
						linkToSnap(w, w.linkSnap.id, w.linkSnap.type)					
					end
                end
            end
        end
        if ("static" == v.type) then
            if v.route and pairs(v.route.points) then
                for _tmp, w in pairs(v.route.points) do
                    if w.linkUnit then                        
                        local unit = unit_by_id[w.linkUnit];
                        w.linkUnit = nil;
                        local group = unit.boss;
                        linkWaypoint(w, group, unit);
                    end
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
--
function isNumber(n)
    if nil ~= base.tonumber(n) then
        return true
    else
        return false
    end
end

-- добавляет helipadId если его нет, для посадки на корабль
function fixHelipadId()
    for _tmp, v in pairs(group_by_id) do
        if ("plane" == v.type) or ("helicopter" == v.type) then
            if v.route and pairs(v.route.points) then
                for _tmp, w in pairs(v.route.points) do
                    if w.type.type == 'Land' and w.linkUnit ~= nil and w.linkUnit.unitId ~= nil 
                        and w.helipadId == nil then
                        w.helipadId = w.linkUnit.unitId
                    end
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- convert airdromes from early versions
function fixAirdromes()
    for _tmp, v in pairs(group_by_id) do
        if ("plane" == v.type) or ("helicopter" == v.type) then
            if v.route and pairs(v.route.points) then
                for _tmp, w in pairs(v.route.points) do
                    if w.airdrome then
                        if w.linkUnit then 
                            w.helipadId = w.linkUnit.units[1].unitId
                        else
                            if isNumber(w.airdrome) then
                                w.airdromeId = w.airdrome
                            else
                                w.helipadId = group_by_name[w.airdrome].units[1].unitId
                            end
                        end
                        w.airdrome = nil
                    end
                end
            end
        end
    end
end

function fixParking()
     for _tmp, group in pairs(group_by_id) do
        if ("helicopter" == group.type) or ("plane" == group.type) then
            for kk,unit in pairs(group.units) do
                if unit.parking and unit.parking_id == nil then
                    if group.route.points[1].airdromeId then
                        local res = mod_parking.fixParking(unit, group.route.points[1].airdromeId,"parking") 
                        --base.print("---setAirGroupOnAirport---",res)  
                    end
                end
                if unit.parking_landing and unit.parking_landing_id == nil then
                    if group.route.points[#group.route.points].airdromeId then
                        local res = mod_parking.fixParking(unit, group.route.points[1].airdromeId,"parking_landing") 
                       -- base.print("---setAirGroupOnAirport---",res)  
                    end
                end
            end
        end
    end

end

function fixNotValidLinkHelipad()
    for _tmp, v in pairs(group_by_id) do
        if ("helicopter" == v.type) then
            if v.route and pairs(v.route.points) then
                for _tmp, w in pairs(v.route.points) do

                    if w.helipadId then                        
                        local unit = unit_by_id[w.helipadId]     
                        if unit ~= nil then
                            local unitTypeDesc = me_db.unit_by_type[unit.type]                          
                            local ship = me_db.ship_by_type[unit.type]
                            if  not me_db.isFARP(unitTypeDesc.type) and (ship ~= nil and me_db.isCarrier(ship) == false) then
                                base.print("ERROR invalid helipadId, unit no FARP",w.helipadId, unitTypeDesc.type)  
                                w.type = {
                                type = 'Turning Point',
                                name = 'Turning point',
                                action = 'Turning Point',}
                                w.helipadId = nil
                            end                    
                        else
                            base.print("ERROR invalid helipadId, no unit",w.helipadId)  
                            w.type = {
                                type = 'Turning Point',
                                name = 'Turning point',
                                action = 'Turning Point',}
                            w.helipadId = nil
                        end
                    end
                end
            end
        end
    end
end

-------------------------------------------------------------------------------
-- возвращает миссию без распаковки ресурсов и загрузки ее в редактор
function extractMission(fName)
    local zipFile, err = minizip.unzOpen(fName, 'rb')
    if zipFile == nil then
        base.Gui.MessageBox("Can not read file " .. fName .. '\n' .. (err or ''), 'Error');
        return;
    end;
    local misStr
    if zipFile:unzLocateFile("mission") then misStr = zipFile:unzReadAllCurrentFile(false) end
    zipFile:unzClose()

    local fun, errStr = base.loadstring(misStr)
    if not fun then
        print("error loading mission", errStr)
		
		showErrorMessageBox(cdata.ErrorLoading .. fName .. '": ' .. errStr)

        return
    end

    local env = { }
    base.setfenv(fun, env)
    fun()
    local mission = env.mission

    base.mission = nil
    return mission;
end;

local function importCustomFormations(customFormations)
    if not customFormations then return end
    for i,v in ipairs(customFormations) do
        TEMPL.addCFTemplate(v)
    end
end

local function countPicture(file)
	local count = 0
	for index, curFile in pairs(mission.pictureFileNameR) do
		if curFile == file then
			count = count + 1
		end
	end
	for index, curFile in pairs(mission.pictureFileNameB) do
		if curFile == file then
			count = count + 1
		end
	end
	return count
end

-------------------------------------------------------------------------------
-- 
function load(fName, bLight)	
	mapElementsCreated_ = false

--print('load(fName)',fName)
    -- нужно чтобы показалось окно карты, если не сделать, то окно не покажется 
    local zipFile, err = minizip.unzOpen(fName, 'rb') 
    if zipFile == nil then 
        base.Gui.MessageBox("Can not read file " .. fName .. '\n' .. (err or ''), 'Error');
		if base.isInitTerrain() == true then
			create_new_mission()
		end
        return false
    end
 
    local extOptions
    if zipFile:unzLocateFile('options') then
        local optStr = zipFile:unzReadAllCurrentFile(false)
        local fun, errStr = base.loadstring(optStr)
        if not fun then
            print("error loading mission options", errStr)
			
			showErrorMessageBox(cdata.ErrorLoading .. fName .. 
                '" options: ' .. errStr)
			if base.isInitTerrain() == true then
				create_new_mission()
			end
            return false
        end
        local env = { }
        base.setfenv(fun, env)
        fun()
        extOptions = env.options
    end

    local misStr
    if zipFile:unzLocateFile('mission') then
        misStr = zipFile:unzReadAllCurrentFile(false)
    end
    
    local misAE
    if zipFile:unzLocateFile('warehouses') then
        misAE = zipFile:unzReadAllCurrentFile(false)
    end
    
    local fun, errStr = base.loadstring(misStr)
    if not fun then
        print("error loading mission", errStr)

		showErrorMessageBox(cdata.ErrorLoading .. fName .. '": ' .. errStr)
		if base.isInitTerrain() == true then
			create_new_mission()
		end
        return false
    end
	
    local env = { }
    base.setfenv(fun, env)
    fun()
    if env.mission.theatre == nil then -- для очень старых миссий
        env.mission.theatre = 'Caucasus'
    end
	
	if env.mission.theatre == "StraitOfDover" then
		env.mission.theatre = "TheChannel"
	end
	
	if (VERSION_MISSION < env.mission.version) then
		if showVersionMessageBox(cdata.warning_version) == false then
			zipFile:unzClose()
			if base.isInitTerrain() == true then
				create_new_mission()
			end
			return false
		end
		log.write('Warning version', log.INFO, "mission:"..fName..", mission version:"..env.mission.version..", ME version:"..VERSION_MISSION)
	end
    
    if TheatreOfWarData.verifyTheatreOfWar(env.mission.theatre) == false then
        zipFile:unzClose()
		if base.isInitTerrain() == true then
			create_new_mission()
		end
        return false, "no terrain", env.mission.theatre
    end
    
    TheatreOfWarData.selectTheatreOfWar(env.mission.theatre)
	
	--проверяем необходимые Threats
	local threatsById_ = {}	
	if managerModulesME.callBack_getThreatsById ~= nil then
		threatsById_ = managerModulesME.callBack_getThreatsById() or {}
	end
	
	local listMissingThreats = nil
	for k, coal in base.pairs(env.mission.coalition) do
		for i, navigationPointTable in ipairs(coal.nav_points) do
			if navigationPointTable.propertiesCustom then
				for kk, vv in base.pairs(navigationPointTable.propertiesCustom) do
					if vv.key == 'Threat' then
						if threatsById_[vv.value] == nil then
							listMissingThreats = listMissingThreats or {}	
							listMissingThreats[vv.value] = true
						end	
					end
				end
			end
		end
	end	
	
	if listMissingThreats ~= nil then
		local errMessage = "Need threats for load this mission: "
		local first = true
		for k, v in base.pairs(listMissingThreats) do
			if first then
				errMessage = errMessage..k
			else
				errMessage = errMessage..", "..k
			end
			first = false
		end
		return false, "no threats", errMessage
	end

	---

	if bLight == true then
		if MapWindow.initTerrainLight(false, false, "beforeMissionRun", env.mission.date) == false then
			zipFile:unzClose()
			if base.isInitTerrain() == true then
				create_new_mission()
			end
			return false, _("error initialization terrain"), env.mission.theatre
		end
	else
		if MapWindow.initTerrain(false, false, "beforeMissionRun", env.mission.date) == false then
			zipFile:unzClose()
			if base.isInitTerrain() == true then
				create_new_mission()
			end
			return false, _("error initialization terrain"), env.mission.theatre
		end
	end
    
	local bEnabledSave = true
    if env.mission.ext_loader  then
        --MsgWindow.warning(cdata.Mission_readonly, _('Warning'), 'OK'):show()
        local activ = base.CheckActivation(env.mission.ext_loader)
        if activ == false then
            MsgWindow.warning(cdata.FailActivation, _('Warning'), 'OK'):show()
            zipFile:unzClose()
			if base.isInitTerrain() == true then
				create_new_mission()
			end
            return false
        end

		bEnabledSave = false
    end 
	
    -- проверяем технику в миссии на наличие в игре
	if veryfyUnitsPlugins(env.mission) == false then
        zipFile:unzClose()
		if base.isInitTerrain() == true then
			create_new_mission()
		end
        return false
    end
    
	missionCreated = true	
    mission = env.mission
    
    maxUnitId = 0
    maxGroupId = 0

    clearTempFolder()
    mod_dictionary.resetDictionary()
    resourceFiles = mod_dictionary.unpackFiles(zipFile);

	if bEnabledSave == false or isSignedMission() == true then
		toolbar.setEnabledSave(false)
		MenuBar.setEnabledSave(false)
	else
		toolbar.setEnabledSave(true)
		MenuBar.setEnabledSave(true)
	end
    
    DictL, curDict = mod_dictionary.loadDictionary(zipFile, LangController.getCurLangForLoad())
    LangController.setCurLang(curDict)
    statusbar.updateLang()
    zipFile:unzClose()

    -- При загрузке миссии из файла предполагается, что загруженная ранее миссия уже не нужна.
    mapObjects = {}
    
    panel_aircraft.vdata.group = nil
    --base.panel_helicopter.vdata.group = nil
    panel_ship.vdata.group = nil
    panel_vehicle.vdata.group = nil
    panel_route.setGroup(nil)
	panel_suppliers.setGroup(nil)
    panel_payload.vdata.group = nil
    panel_targeting.vdata.group = nil
    panel_summary.vdata.group = nil
    clearGroups()
    waypointNameIndex = 0
    target_by_name = {}
    targetNameIndex = 0
    zoneNameIndex = 0
    
	MissionData.openMission(fName)
    
    mod_dictionary.setMaxDictId(mission.maxDictId or 0)
    
    mission.dictionary = DictL
    	
    mission.trigrules = mission.trigrules or {}
    fixTriggers()
     
    if misAE then
        local fun, errStr = base.loadstring(misAE)
        if not fun then
            print("error loading mission", errStr)

			showErrorMessageBox(cdata.ErrorLoading .. fName .. '": ' .. errStr)
			if base.isInitTerrain() == true then
				create_new_mission()
			end
            return false
        end
        
        local env = { }
        base.setfenv(fun, env)
        fun()
        
        mission.AirportsEquipment = env.warehouses
        fixOperatingLevel(env.warehouses)
		fixAirportCoalition(env.warehouses)
    else
        mission.AirportsEquipment = {}
    end         

  
    base.mission = nil
	
	fixCoalitions(mission.coalitions)
		
	CoalitionController.loadCoalitions(mission.coalitions)
	
	if mission.date == nil then
        fixMissionDate()  
    end
	
    currentKey = mission.currentKey+10
    fixBriefingPictures()  
    fixInitScriptFile()
        
    mission.start_time = math.fmod(mission.start_time,86400)
    
    -- Обновление данных о погоде в панели погоды
    -- Обновление данных о неисправностях
    if mission.failures then
        U.copyTable(panel_failures.vdata, mission.failures)
        panel_failures.update()
    end
    
    -- Очистка карты
    -- Нанесение объектов на карту 
    -- Обработка триггеров
    mission.goals = Goal.loadGoals(mission.goals)
    mission.trigrules = Trigger.loadTriggers(mission.trigrules)
	
	if resourceFiles ~= nil then
		for file, fullPath in pairs(resourceFiles) do
			if mod_dictionary.getResourceCounter(file) == nil then
				local refCount = Trigger.countTriggerFileRef(mission.trigrules, file) + countPicture(file)
				refCount = math.max(refCount, 1)
                mod_dictionary.setResourceCounter(file, refCount)
			end
		end
	end
    
	panel_roles.update(mission.groundControl)
	
	missionCountry = {}
    countryCoalition = {}
	mission.bullseye = {}    
  
	playerUnit = nil    
	
	local coalitionNames = {
		CoalitionController.redCoalitionName(),
		CoalitionController.blueCoalitionName(),
	}

	if mission.coalition[CoalitionController.neutralCoalitionName()] == nil then
		createCoalition(CoalitionController.neutralCoalitionName())
	end
	base.table.insert(coalitionNames, CoalitionController.neutralCoalitionName())

    for i, coalitionName in ipairs(coalitionNames) do
        local coalition = mission.coalition[coalitionName]
		if coalition then
			coalition.name = coalitionName
			for k, v in pairs(coalitionColors[coalitionName]) do
				coalition[k] = v
			end
	 
			fixCountriesNames(coalition.country)
			
			for j,v in pairs(coalition.country) do
				missionCountry[v.name] = v
				countryCoalition[v.name] = coalition
			end
			
			-- добавляем пустые страны потому что при сохранении их не пишем в миссию
			local coalitionCountryIds = CoalitionController.getCoalitions()
			for i, countryId in pairs(coalitionCountryIds[coalitionName]) do
				local countryName = CoalitionController.getCountryNameById(countryId)
				if missionCountry[countryName] == nil then
					addCountryToCoalition(coalition, countryId)	
				end
			end
								
			mission.bullseye[coalitionName] = {}
			mission.bullseye[coalitionName].mapObjects = {}
			if (mission.coalition[coalitionName].bullseye) then
				mission.bullseye[coalitionName].x = mission.coalition[coalitionName].bullseye.x
				mission.bullseye[coalitionName].y = mission.coalition[coalitionName].bullseye.y
			else
				mission.bullseye[coalitionName].x = 100
				mission.bullseye[coalitionName].y = 100
			end

			fixStaticCategories(coalition)

			createCoalitionObjects(coalition)		
			
			coalition.nav_points = coalition.nav_points or {}
			NavigationPointController.loadCoalition(coalitionName, coalition.nav_points)	
		end	
    end

	fixUnitsPos()
    fixUnitsSkills()
    fixTasks()    
    fixWaypoints()
	fixWptTasks()
	if (not mission.version) or (4 > mission.version) then
		addEPLRS()
	end	
        
    fixWaypointsLinks()
	fixVariants()
	fixRadio()
    fixAddPropAircraft()   
    fixLiveryId()  
    fixSCR522()
    fixAirdromeId()
    fixWeather(mission.weather)
	fixVehicleSettings()
    fixUh1HUnitsPayload()
    fixNoValidUnitsPayload()
    importCustomFormations(mission.customFormations)
	
	for id,unit in pairs(unit_by_id) do
        local group = unit.boss;
        if ( group.type == 'plane' ) or ( group.type == 'helicopter' ) then
            if (unit.callsign == nil) then
                unit.callsign = panel_aircraft.getNewCallsign(unit)
            else          
                unit.callsign = convertCallsign(unit.callsign)	
            end
           
            if (base.tonumber(unit.callsign) ~= nil) 
                and U.isWesternCountry(base.me_db.country_by_id[group.boss.id].Name)  then 
                unit.callsign = panel_aircraft.getNewCallsign(unit)
            end
			
			if (base.tonumber(unit.callsign) == nil) 
				and not U.isWesternCountry(base.me_db.country_by_id[group.boss.id].Name)  then 
                unit.callsign = panel_aircraft.getNewCallsign(unit)
            end
            
            if (unit.skill == crutches.getPlayerSkill()) then
				-- Обновление данных о неисправностях
				panel_failures.load_mission(unit.type)				
			end
        end
		
		if unit.dataCartridge and unit.dataCartridge.Points then
			for k,v in base.pairs(unit.dataCartridge.Points) do
				v.index = k
				v.unit = unit
				v.boss = unit.boss
			end
			
			local tmpGroupsPoints = {}
			for k,v in base.pairs(unit.dataCartridge.GroupsPoints) do	
				tmpGroupsPoints[k] = {}
				if k == "PP" then
					for kk,vv in base.pairs(v) do
						base.table.insert(tmpGroupsPoints[k], unit.dataCartridge.Points[vv.point])

						unit.dataCartridge.Points[vv.point].ppData = {}
						if vv.data then							
							unit.dataCartridge.Points[vv.point].ppData.bTerminal = true
							unit.dataCartridge.Points[vv.point].ppData.speed 	= vv.data.speed
							unit.dataCartridge.Points[vv.point].ppData.angle 	= vv.data.angle
							unit.dataCartridge.Points[vv.point].ppData.heading 	= vv.data.heading
						else
							unit.dataCartridge.Points[vv.point].ppData.bTerminal = false
						end
					end	
				else				
					for kk,vv in base.pairs(v) do
						base.table.insert(tmpGroupsPoints[k], unit.dataCartridge.Points[vv])
					end	
				end
			end
			unit.dataCartridge.GroupsPoints = tmpGroupsPoints
        end
    end
    
    if (not mission.version) or (2 > mission.version) then
        fixAirdromes()
    end
    
    fixHelipadId() 
    fixParking()
    fixNotValidLinkHelipad()

    print('Mission '..fName..' loaded')
  
    if mission.triggers then
        if mission.triggers.zones then
			TriggerZoneController.loadTriggerZones(mission.triggers.zones)
        end
    end

	mission.forcedOptions = mission.forcedOptions or {}
    OptionsData.setForcedOptions(mission.forcedOptions)

	-- is it actually used anywhere?
    mission.hasPlayer = isPlayerAvailable()
    
    mission.path = fName;
    full_current_mission_path = fName
        
    if getMissionPathIsSaved() ~= false then        
        MenuBar.setFileName(U.extractFileName(fName));
    end
    
    localizingStrings()
    
    originalMission = {};
    U.recursiveCopyTable(originalMission, mission);
    
    panel_weather.setData(mission.weather)
    panel_weather.updateSeason(mission.start_time, mission.date)
	
    return true;
end

-------------------------------------------------------------------------------
--удаляем страны которых нет в БД
function fixCoalitions(a_coalitions)
	local countries = me_db.getCountries()
	for k,coalition in base.pairs(a_coalitions) do
		local toRemove = {}
		for kk,id in base.ipairs(coalition) do	
			if countries[id] == nil then
				--base.print("--noCountry--",id, kk)
				base.table.insert(toRemove,kk)
			end
		end
		for i = #toRemove, 1, -1 do	
			base.table.remove(a_coalitions[k], toRemove[i])		
		end
	end
end

-------------------------------------------------------------------------------
--
function fixMissionDate()
    mission.date = convertStartTimeToDate(mission.start_time)
    
    local days = math.floor(mission.start_time/(60*60*24))

    mission.start_time = mission.start_time - days*60*60*24
end

-------------------------------------------------------------------------------
--
function localizingStrings()
    local func = mod_dictionary.textToME
    if mission.version < 8 then
        func = mod_dictionary.fixDict 
    end
    
    func(mission, 'descriptionText', mission.descriptionText,'descriptionText')
    func(mission, 'descriptionRedTask', mission.descriptionRedTask,'descriptionRedTask')
    func(mission, 'descriptionBlueTask', mission.descriptionBlueTask,'descriptionBlueTask')
	func(mission, 'descriptionNeutralsTask', mission.descriptionNeutralsTask,'descriptionNeutralsTask')
    func(mission, 'sortie', mission.sortie, 'sortie')
    
    for _tmp, group in pairs(group_by_id) do   
        for _tmp, wpt in pairs(group.route.points) do  
			if mission.version < 19 then	
				local tmpKey = wpt.name
				wpt.name = mod_dictionary.getValueDictDEFAULT(tmpKey)
				mod_dictionary.clearDict(tmpKey)
			end
 --           func(wpt, 'name', wpt.name, "WptName") 
            if base.MapWindow.isShowHidden(group) == true then
                set_waypoint_map_object(wpt)
            end
        end     
    end 
    
    -- мультиязычная локализация задач
    func = mod_dictionary.textToME
    if mission.version < 11 then
        func = mod_dictionary.fixDict 
    end
    
    for _tmp, group in pairs(group_by_id) do   
        for _tmp, wpt in pairs(group.route.points) do  
            if wpt.task and wpt.task.params and wpt.task.params.tasks then
                for k,task in base.pairs(wpt.task.params.tasks) do
                    if task.params and task.params.action and task.params.action.params then
                        local params = task.params.action.params
                        if params.subtitle then
                            func(params, 'subtitle', params.subtitle, "subtitle")                     
                        end
                    end        
                end    
            end
        end  
        if group.tasks then
            for k,task in base.pairs(group.tasks) do
                if task.params and task.params.action and task.params.action.params then
                    local params = task.params.action.params
                    if params.subtitle then
                        func(params, 'subtitle', params.subtitle, "subtitle")                     
                    end
                end        
            end    
        end    
    end
    --[[
    for k,id in pairs(NavigationPointController.getNavigationPointIds()) do
        local np = NavigationPointController.getNavigationPoint(id)
        base.print("-----np----",np.comment)
        func(np, 'comment', np.comment,'NavpointComment') 
        NavigationPointController.setNavigationPointDescription(id, np.comment)
    end;]]
    
    localizing_triggered_actions()
    
end

-------------------------------------------------------------------------------
--
function createMapElements()
	if mapElementsCreated_ then
--		return
	end
	
    fixSpans()
    MapWindow.clearUserObjects()
    MapWindow.selectedGroup = nil

    if mission.map then
        if (mission.map.centerXRect and mission.map.centerYRect) then
            mission.map.centerX, mission.map.centerY = mission.map.centerXRect, mission.map.centerYRect
        end
        
        MapWindow.setScale(mission.map.zoom)		
        MapWindow.setCamera(mission.map.centerX, mission.map.centerY)
	else
		mission.map = {}
		local mapX, mapY = MapWindow.getCamera()
		mission.map.centerX = mapX
		mission.map.centerY = mapY
		mission.map.zoom = MapWindow.getScale()	
    end
    
    createAirportEquipment()
    for id,group in pairs(group_by_id) do
        create_group_map_objects(group, true)
    end
	
	if mission.flightPlans then
		for k,fp in pairs(mission.flightPlans) do
			create_flightPlans_objects(fp)
			for kk,vv in base.pairs(fp.points) do
				if vv.linkSnap then
					linkToSnap(vv, vv.linkSnap.id, vv.linkSnap.type)					
				end
			end	
		end
	end

	for id,group in pairs(group_by_id) do
        updateHeading(group)
    end
	
	createBullseye()	
	update_bullseye_map_objects()
	
	panel_dataCartridge.createLinesForMap()
	
	originalMission = {};
	U.recursiveCopyTable(originalMission, mission);
    --U.traverseTable(mission);
	BeaconData.load()
	MapWindow.createMapObjects()
	
	me_draw_panel.loadFromMission(mission.drawings)

	mapElementsCreated_ = true
end

-------------------------------------------------------------------------------
-- создание значка циклона и его зоны
function createCyclone(cyclone)
    -- циклон
    currentKey = currentKey + 1;
    
    local classKey

    if (cyclone.pressure_excess < 0) then
        classKey = me_db.getClassKey("cyclone")
    else
        classKey = me_db.getClassKey("anticyclone")
    end
    
    local id = currentKey
    local x = cyclone.centerX
    local y = cyclone.centerZ
    local object = MapWindow.createDOT(classKey, id, x, y)
    
    object.currColor = {1,1,1}
    object.subclass = 'cyclone'
    set_mapObjects(object.id, object) 
    object.userObject = cyclone
    
    -- зона
    currentKey = currentKey + 1
    local radius = cyclone.pressure_spread
    local classKey = 'S0000000528'
    local id = currentKey
    local color = {0.3,0.3,0.3,0.5}
    local stencil = 5
    local mapZone = createCircle(x, y, radius, classKey, id, color, stencil)

    mapZone.currColor = {0.3,0.3,0.3,0.5}
    mapZone.radius = radius
    set_mapObjects(mapZone.id, mapZone)
    
    object.zone = mapZone
		
    update_map_object({object})
    update_map_object({mapZone})
    
    return object.id
end

-------------------------------------------------------------------------------
-- создание значка ветра
function createWind(Wind, a_id)
    local id
    if (a_id ~= nil) then
        id = a_id
    else
        currentKey = currentKey + 1
        id = currentKey
    end
    
    local classKey = "P000WIND000"

    local windV = Wind.v/0.5144444 
    local str_wind = base.string.format("%0.3d",math.floor(windV/5 + 0.5) * 5)
    
    if (windV <= 140) then
        local str = "P000WIND"
        classKey = str..str_wind   
    else
        classKey = "P000WIND145"
    end
    
	local x = Wind.x1
	local y = Wind.y1
	local object = MapWindow.createDOT(classKey, id, x, y, Wind.angle * 180/3.14,  nil)
    
    object.currColor = {1,1,1}
    object.subclass = 'wind'
    set_mapObjects(object.id, object) 
    
    update_map_object({object})

    return object.id
end

-------------------------------------------------------------------------------
--
function setCyclonesVisible(cyclones, bVisible)
    if (cyclones == nil)or (MapWindow.isEmptyME()) then
        return
    end
 
    for k,v in pairs(cyclones) do        
        deleteCyclone(v.groupId)
        v.groupId = nil
    end
    
    if (bVisible == true) then
        for k,v in pairs(cyclones) do
            v.groupId = createCyclone(v)
        end
    end

end


-------------------------------------------------------------------------------
--
function setWindsVisible(Winds, bVisible)
    if (Winds == nil) or (MapWindow.isEmptyME()) then
        return
    end
    
    for k,v in pairs(Winds) do        
        deleteWind(v.groupId)
    end

    if (bVisible == true) then
        for k,v in pairs(Winds) do
            v.groupId = createWind(v, v.groupId)
        end
    end

end

-------------------------------------------------------------------------------
-- обновление значков циклонов
function updateCyclone(cyclone)
    if (cyclone.groupId) then
        local obj = MapWindow.getObjectById(cyclone.groupId)         

        obj.x = cyclone.centerX
        obj.y = cyclone.centerZ
        if (obj.zone) then
            obj.zone.x      = cyclone.centerX
            obj.zone.y      = cyclone.centerZ
            obj.zone.radius = cyclone.pressure_spread
            obj.zone.points = createCirclePoints(0, 0, obj.zone.radius)
            update_map_object({obj.zone})
        end
        update_map_object({obj})
    end   
end

-------------------------------------------------------------------------------
-- удаление значков циклонов
function deleteCyclone(id)
    local obj = MapWindow.getObjectById(id) 
    
    if  obj == nil then
        return
    end
    
    if (obj.zone) then
        set_mapObjects(obj.zone.id, nil); 
        MapWindow.removeUserObjects({obj.zone}) 
         
        obj.zone = nil
    end
    set_mapObjects(obj.id, nil);
    MapWindow.removeUserObjects({obj}) 
        
end

-------------------------------------------------------------------------------
-- удаление значков циклонов
function deleteWind(id)
    local obj = MapWindow.getObjectById(id) 
    if  obj == nil then
        return
    end
    
    MapWindow.removeUserObjects({obj}) 
    set_mapObjects(obj.id, nil);    
end

-------------------------------------------------------------------------------
-- 
function createBullseye()
	insert_bullseye('red', mission.bullseye.red.x,mission.bullseye.red.y)
	insert_bullseye('blue', mission.bullseye.blue.x,mission.bullseye.blue.y)

	if mission.bullseye.neutrals == nil then
		mission.bullseye.neutrals ={}
		mission.bullseye.neutrals.x = 0
		mission.bullseye.neutrals.y = 0
	end
	insert_bullseye('neutrals', mission.bullseye.neutrals.x,mission.bullseye.neutrals.y)
end

-------------------------------------------------------------------------------
-- Создаем объекты статического темплейта
function createStaticTemplateObjects(a_tmpl, a_oldToNew_GroupId, a_oldToNew_UnitId)	
	--local func = mod_dictionary.fixDictAll	
	local curDict = mod_dictionary.getCurDictionary()
	local locTbl = a_tmpl.localization
	local addGroup = {}
	local offsetUnitId = getMaxUnitId()
	local offsetGroupId = getMaxGroupId()

	for i,cltn in pairs(a_tmpl.coalition) do		
		for i,v in pairs(cltn.country) do			
			local country = missionCountry[v.name]
			--base.print("---country---",country)
			if country then
				local coalition = mission.coalition[country.boss.name]
				local color = coalition.color	
				v.boss = coalition
				for k,w in pairs(group_types) do
					--print('creating category ---->',k,w);
					v[w] = v[w] or {}
					v[w].group = v[w].group or {}
					local removeTab = {}
					for j,u in ipairs(v[w].group) do
						--print('creating group',u.name);

						if (not u.units) or (0 >= #u.units) then
							print('BIG FAT WARNING: empty group detected', u.name)
							table.insert(removeTab, j)
						else
							if locTbl and locTbl['DEFAULT'] and locTbl['DEFAULT'][u.name] then
								u.name = locTbl['DEFAULT'][u.name]
							end

							local nm = check_group_name(u.name)
							
							if u.route and u.route.points then
								for i_point, v_point in base.ipairs(u.route.points) do
									if v_point.linkUnit then
										v_point.linkUnit = a_oldToNew_UnitId[v_point.linkUnit] + offsetUnitId									
									end
									if v_point.helipadId then
										v_point.helipadId = a_oldToNew_UnitId[v_point.helipadId] + offsetUnitId
									end
									
									v_point.depth = -v_point.alt or 0
									
									if v_point.task and v_point.task.params and v_point.task.params.tasks then									
										for k,task in base.pairs(v_point.task.params.tasks) do
											if task.params and task.params.groupId then
												task.params.groupId = a_oldToNew_GroupId[task.params.groupId] + offsetGroupId
											end
											
											if task.params and task.params.distribution then
												for kk,distributions in base.ipairs(task.params.distribution) do
													for kkk,vvv in base.ipairs(distributions) do
														task.params.distribution[kk][kkk] = a_oldToNew_GroupId[task.params.distribution[kk][kkk]] + offsetGroupId
													end	
												end
											end
											
											if task.params and task.params.groupsForEmbarking then
												for kk,vv in base.ipairs(task.params.groupsForEmbarking) do
													task.params.groupsForEmbarking[kk] = a_oldToNew_GroupId[task.params.groupsForEmbarking[kk]] + offsetGroupId
												end												
											end
										end
									end
								end
							end
							
							group_by_name[nm] = u              
							u.groupId = u.groupId + offsetGroupId  -- в groupId уже новый id  
							if (maxGroupId < u.groupId) then
								maxGroupId = u.groupId		
							end			
							u.name = nm			
							u.boss = country
							u.type = w
							
							base.table.insert(country[w].group, u)
							u.color = color
							--base.print("-----------------------w=",w)
						  --  base.print("---mission.version=",mission.version)
							local unitsNum = #u.units
							for reverseUnitIter = unitsNum,1,-1 do
								local unit = u.units[reverseUnitIter]
								if locTbl and locTbl['DEFAULT'] and locTbl['DEFAULT'][unit.name] then
									unit.name = locTbl['DEFAULT'][unit.name]
								end			                 
								
								if (not me_db.unit_by_type[unit.type])
									and (check_alias(unit) == false) then
									
									if w == 'plane' then
										unit.type = "A-10C" -- заменяем неизвестный на A-10C
									else
										print("can't load [".. unit.type .."]! skipping...")
										table.remove(u.units, reverseUnitIter)
									end
								end
							end
							
							local namesUnits ={}
							for s,r in ipairs(u.units) do
								if me_db.unit_by_type[r.type] then
									r.unitId = r.unitId + offsetUnitId -- в unitId уже новый id  
									if maxUnitId < r.unitId then
										maxUnitId = r.unitId
									end

									unit_by_id[r.unitId] = r
									if not r.name then
										unitNameIndex = unitNameIndex+1
										r.name = getUnitName(u.name, namesUnits)
									end
									
									local un = getUnitName(u.name, namesUnits)
									r.name = un
									namesUnits[r.name] = true
									local skill = r.skill or '';

									if _(skill) == crutches.getPlayerSkill() then
										r.skill = crutches.getClientSkill() -- превращаем игроков в клиентов       
									end  
									r.callsign = convertCallsign(r.callsign)		
								end
							end
							
							fixWaypointForGroup(u)							 	
						  
							if #u.units > 0 then
								group_by_id[u.groupId] = u
							end
							if u.INUFixPoints then 
								for i = 1,#u.INUFixPoints do
									u.INUFixPoints[i].boss = u;
								end
							end;
							if u.NavTargetPoints then 
								for i = 1,#u.NavTargetPoints do
									u.NavTargetPoints[i].boss = u;
								end
							end;
						  
							if #u.units > 0 then
								create_group_objects(u);
								for _tmp, wpt in pairs(u.route.points) do  
									if locTbl and locTbl['DEFAULT'] and locTbl['DEFAULT'][wpt.name] then
										wpt.name = locTbl['DEFAULT'][wpt.name]
									end
									if base.MapWindow.isShowHidden(u) == true then
										set_waypoint_map_object(wpt)
									end
								end

								create_group_map_objects(u)
								update_group_map_objects(u)
								base.panel_units_list.update()
								table.insert(addGroup, u)	
							else
								print('SMALL FAT WARNING: empty group detected', u.name)
								table.insert(removeTab, j)	
							end
							--base.U.traverseTable(u)
							--base.print("--------------fff----")
						end
					end
					
					for i = #removeTab, 1, -1 do   
						--print("!!!!REMOVE GROUP ", i, removeTab[i], v[w].group[removeTab[i]].name)
						group_by_name[v[w].group[removeTab[i]].name] = nil
						table.remove(v[w].group, removeTab[i])            
					end
				end
			end	
		end
	end	  

	for _tmp, v in pairs(addGroup) do
        if ("plane" == v.type) or ("helicopter" == v.type) then
            if v.route and pairs(v.route.points) then
                for _tmp, w in pairs(v.route.points) do
					if w.linkUnit then 
						local unitNum = w.linkUnit
						w.linkParent = nil
						w.linkUnit = nil;
						local unit = unit_by_id[unitNum];
						local group = unit.boss;
						linkWaypoint(w, group, unit);
					end
                end
            end
        end
        if ("static" == v.type) then
            if v.route and pairs(v.route.points) then
                for _tmp, w in pairs(v.route.points) do
                    if w.linkUnit then                        
                        local unit = unit_by_id[w.linkUnit];
                        w.linkUnit = nil;
                        local group = unit.boss;
                        linkWaypoint(w, group, unit);
                    end
                end
            end
        end
    end
	
	fixUnitsPos()
	fixUnitsSkills()
	
	for k, unit in base.pairs(unit_by_id) do
		updateTopdownViewArguments(unit)
	end
end

-------------------------------------------------------------------------------
-- Вызывается после чтения файла миссии для создания объектов карты.
function createCoalitionObjects(cltn)
    --print('creating coalition',cltn);
    local func = mod_dictionary.textToME
    if mission.version < 8 then
        func = mod_dictionary.fixDict 
    end
    
  local color = cltn.color
  for i,v in pairs(cltn.country) do
    v.boss = cltn
    for k,w in pairs(group_types) do
        --print('creating category ---->',k,w);
        v[w] = v[w] or {}
	    v[w].group = v[w].group or {}
        local removeTab = {}
        for j,u in ipairs(v[w].group) do
            --print('creating group',u.name);
            if (not u.units) or (0 >= #u.units) then
                print('BIG FAT WARNING: empty group detected', u.name)
                table.insert(removeTab, j)
            else
				if mission.version < 19 then
					local tmpKey = u.name
					u.name = mod_dictionary.getValueDictDEFAULT(tmpKey)
					mod_dictionary.clearDict(tmpKey)
				end
            --    func(u, 'name', u.name, "GroupName") 
                local nm = check_group_name(u.name)
                
                group_by_name[nm] = u              
                u.groupId = getNewGroupId(u.groupId)                          
                u.name = nm
                u.boss = v
                u.type = w
                u.color = color
                --base.print("-----------------------w=",w)
              --  base.print("---mission.version=",mission.version)
                local unitsNum = #u.units
			    for reverseUnitIter = unitsNum,1,-1 do
                    local unit = u.units[reverseUnitIter]
					if mission.version < 19 then
						local tmpKey = unit.name
						unit.name = mod_dictionary.getValueDictDEFAULT(tmpKey)
						mod_dictionary.clearDict(tmpKey)
					end	
                   -- func(unit, 'name', unit.name, "UnitName") 
                    
                    if mission.version < 12 then
                      --  base.print("---fixUnitsByCountry=",v.id, v.name, fixUnitsByCountry[v.id],fixUnitsByCountry["Other"][unit.type])
                        if fixUnitsByCountry[v.id] then
                            if fixUnitsByCountry[v.id][unit.type] then 
                                --base.print("--fix-c-",v.name,unit.type,"to",fixUnitsByCountry[v.id][unit.type])
                                unit.type = fixUnitsByCountry[v.id][unit.type]                                
                            end
                        else
                            if fixUnitsByCountry["Other"][unit.type] then  
                                --base.print("--fix-o-",v.name,unit.type,"to",fixUnitsByCountry["Other"][unit.type])
                                unit.type = fixUnitsByCountry["Other"][unit.type]                                
                            end
                        end
                    end                   
                    
				    if (not me_db.unit_by_type[unit.type])
                        and (check_alias(unit) == false) then
                        
                        if w == 'plane' then
                            unit.type = "A-10C" -- заменяем неизвестный на A-10C
                        else
                            print("can't load [".. unit.type .."]! skipping...")
                            table.remove(u.units, reverseUnitIter)
                        end
                    end
                end

                for s,r in pairs(u.units) do
                    --fix old mission unit types
                    --check_alias(r) перенесено пятью строками выше
                    ----------------------------
                    if me_db.unit_by_type[r.type] then
                        if r.unitId then
                            if maxUnitId < r.unitId then
                                maxUnitId = r.unitId
                            end
                        else
                            --print("MAX UNITID!!!!!!___",r.name or 1, r.type or 1)
                            -- mission in old format
                            maxUnitId = maxUnitId + 1
                            r.unitId = maxUnitId
                        end
                       -- r.type = me_db.getDisplayNameByName(r.type)
                        unit_by_id[r.unitId] = r
                        if not r.name then
                            unitNameIndex = unitNameIndex+1
                            r.name = getUnitName(u.name)
                        end
                        local un = check_unit_name(r.name)
                        r.name = un
                        local skill = r.skill or '';
                        --[[if     _(skill) == base.panel_helicopter.cdata.skill.human[2] then
                            playerUnit = r;
                        elseif _(skill) == panel_aircraft.cdata.skill.human[2] then]]
                        if _(skill) == crutches.getPlayerSkill() then
                            playerUnit = r;         
                        end                        
                    end
                end
			  
                if #u.units > 0 then
                    group_by_id[u.groupId] = u
                end
                if u.INUFixPoints then 
                    for i = 1,#u.INUFixPoints do
                        u.INUFixPoints[i].boss = u;
                    end
                end;
                if u.NavTargetPoints then 
                    for i = 1,#u.NavTargetPoints do
                        u.NavTargetPoints[i].boss = u;
                    end
                end;
			  
                if #u.units > 0 then
                    create_group_objects(u);
                else
                    print('SMALL FAT WARNING: empty group detected', u.name)
                    table.insert(removeTab, j)	
                end
				
				for k, v in base.pairs(u.route.points) do
					if u.type == 'ship' then
						v.depth = -v.alt or 0
						v.alt = 0					
					end
				end
            end
            
        end
        
        for i = #removeTab, 1, -1 do   
            --print("!!!!REMOVE GROUP ", i, removeTab[i], v[w].group[removeTab[i]].name)
            group_by_name[v[w].group[removeTab[i]].name] = nil
            table.remove(v[w].group, removeTab[i])            
        end
    end
  end
end

function addCountryToCoalition(coalition, countryId)	
	local countryName = CoalitionController.getCountryNameById(countryId)
	
	local country = {
		id = countryId,
		boss = coalition, 
		name = countryName,
		plane = {group = {},},
		helicopter = {group = {},},
		ship = {group = {},},
		vehicle = {group = {},},
		static = {group = {},},
	}
	
	table.insert(coalition.country, country)
	missionCountry[countryName] = country
	countryCoalition[countryName] = coalition
end

function moveCountryToCoalition(a_country, a_coalition)

	--удаляем из старой коалиции
	for k,country in base.pairs(a_country.boss.country) do
		if country.id == a_country.id then
			base.table.remove(a_country.boss.country, k)
		end
	end
		
	--добавляем страну в новую копалицию
	base.table.insert(a_coalition.country, a_country)
	
	a_country.boss = a_coalition
	countryCoalition[a_country.name] = a_coalition
end

function createCoalition(coalitionName)
	local coalition = { 
		airports	    = {},
		heliports	    = {},
		GrassAirfields  = {},
		country		    = {},	
	}
	
	mission.coalition[coalitionName] = coalition
	coalition.name = coalitionName

	for k, v in pairs(coalitionColors[coalitionName]) do
		coalition[k] = v
	end
  
	local coalitionCountryIds = CoalitionController.getCoalitions()

	for i, countryId in pairs(coalitionCountryIds[coalitionName]) do
		addCountryToCoalition(coalition, countryId)
	end
end
	
function removeMission()
	missionCreated = false
	mapElementsCreated_ = false
	MissionData.newMission()
	
	clearTempFolder()
	mapObjects = {}
	if MapWindow.isCreated() then
		MapWindow.selectedGroup = nil;
	end;
	
	panel_aircraft.vdata.group = nil
	panel_ship.vdata.group = nil
	panel_vehicle.vdata.group = nil
	panel_route.setGroup(nil)
	panel_suppliers.setGroup(nil)
	panel_payload.vdata.group = nil
	panel_targeting.vdata.group = nil
	panel_summary.vdata.group = nil
	panel_roles.update()  
	
	mission = {}
	currentKey = 6  --0 и 1 - зарезервированы под линейку  2по5 под точки триггерной зоны
	mapObjects = {}
	clearGroups()
	waypointNameIndex = 0
	target_by_name = {}
	targetNameIndex = 0
	zoneNameIndex = 0
	
	mission.bullseye = {}
    mission.bullseye.red ={}
    mission.bullseye.blue ={}
    mission.bullseye.red.x = 0
    mission.bullseye.red.y = 0
    mission.bullseye.blue.x = 0
    mission.bullseye.blue.y = 0
    mission.bullseye.red.mapObjects = {}
    mission.bullseye.blue.mapObjects = {}
	
end	

function removeMapObjectsModels()
	if group_by_id then
		for k, group in base.pairs(group_by_id) do
			if group.mapObjects and group.mapObjects.units then
				for kk, unitObj in base.pairs(group.mapObjects.units) do
					if unitObj.picModel then
						unitObj.picModel = MapWindow.removeSceneObject(unitObj.picModel)
					end
				end
			end
		end
	end
end

function clearGroups()
	group_by_name = {}
    group_by_id = {}
    groupNameIndex = 1000
    unit_by_name = {}
    unit_by_id = {}
    unitNameIndex = 0
end
	

function getDefaultDate()
	return { Year = base.MissionDate.Year, Month = base.MissionDate.Month, Day = base.MissionDate.Day }
end
	
-------------------------------------------------------------------------------
-- Создает пустую миссию заново.
function create_new_mission(doNotCreateDefaultCoalitions)
	mapElementsCreated_ = false
	MissionData.newMission()
	editorManager.setNewGroupCountryName(nil)
	mod_copy_paste.clear()

	maxUnitId = 0
	maxGroupId = 0

	curDict = 'DEFAULT'
	LangController.setSelectLang(nil)
	LangController.setCurLang(curDict)
	langPanel.updateCurLang()
	statusbar.updateLang()

	mod_dictionary.setMaxDictId(0)

	playerUnit = nil

	clearTempFolder()
	mapObjects = {}
	if MapWindow.isCreated() then
		MapWindow.selectedGroup = nil
	end
	panel_aircraft.vdata.group = nil
	panel_ship.vdata.group = nil
	panel_vehicle.vdata.group = nil
	panel_route.setGroup(nil)
	panel_suppliers.setGroup(nil)
	panel_payload.vdata.group = nil
	panel_targeting.vdata.group = nil
	panel_summary.vdata.group = nil
	panel_roles.update()  

	toolbar.setEnabledSave(true)
	MenuBar.setEnabledSave(true)

	for name, module in pairs(base.package.loaded) do
		if 'table' == base.type(module) then
			local fun = module.initModule;
			if fun and ('function' == base.type(fun)) then
				fun()
			end;
		end
	end

	mission = {}
	currentKey = 6  --0 и 1 - зарезервированы под линейку  2по5 под точки триггерной зоны
	mapObjects = {}
	clearGroups()
	waypointNameIndex = 0
	target_by_name = {}
	targetNameIndex = 0
	zoneNameIndex = 0

	if base.__PRODUCT_ID__ == 2 then
		local timeTbl = base.os.date('*t')
		mission.date = { Year = timeTbl.year, Month = timeTbl.month, Day = timeTbl.day }
		mission.start_time = timeTbl.hour *  3600 + timeTbl.min * 60 + timeTbl.sec
	else	
		local defaultDateTime = Terrain.GetTerrainConfig("defaultDateTime") 
		if defaultDateTime == nil then
			mission.date = getDefaultDate()
			mission.start_time = 28800
		else
			mission.date = { Year = defaultDateTime.year, Month = defaultDateTime.month, Day = defaultDateTime.day }
			mission.start_time = defaultDateTime.hour *  3600 + defaultDateTime.minute * 60
		end
	end 

	panel_weather.resetModifiedTime()
	panel_weather.start_time = mission.start_time
	panel_weather.loadDefaultWeather()
	panel_weather.updateSeason(mission.start_time, mission.date)
	-- mission.weather = U.copyTable(nil, panel_weather.vdata)
	mission.weather = panel_weather.vdata
	--mission.options = base.panel_options.vdata

	mod_dictionary.resetDictionary()

	mod_dictionary.textToME(mission, 'descriptionText', mod_dictionary.getNewDictId('descriptionText'))
	-- base.print("----KeyDict_descriptionText1=",mission.KeyDict_descriptionText)
	mod_dictionary.textToME(mission, 'descriptionRedTask', mod_dictionary.getNewDictId('descriptionRedTask'))
	mod_dictionary.textToME(mission, 'descriptionBlueTask', mod_dictionary.getNewDictId('descriptionBlueTask'))
	mod_dictionary.textToME(mission, 'descriptionNeutralsTask', mod_dictionary.getNewDictId('descriptionNeutralsTask'))  
	mod_dictionary.textToME(mission, 'sortie', mod_dictionary.getNewDictId('sortie'))


	panel_failures.clear()
	mission.failures = {}
	U.copyTable(mission.failures, panel_failures.vdata)

	mission.groundControl = panel_roles.getGroundControlData()		

	mission.triggers = {}

	if (doNotCreateDefaultCoalitions ~= true) then
		CoalitionController.setDefaultCoalitions()
	end

	mission.goals = { }
	mission.pictureFileNameR = {}
	mission.pictureFileNameB = {}

	mission.pictureFileNameN = {}

	mission.coalition = { }

	missionCountry = {}
	countryCoalition = {}

	createCoalition(CoalitionController.redCoalitionName())
	createCoalition(CoalitionController.blueCoalitionName())
	
	createCoalition(CoalitionController.neutralCoalitionName())
	
	mission.forcedOptions = {}
	OptionsData.setForcedOptions(mission.forcedOptions);

	MenuBar.setFileName(cdata.newMission)
	
    mission.version = VERSION_MISSION
    
	if base.isInitTerrain() == true then
		MapWindow.setBullseye()
		createAirportEquipment()
	end
		
    resourceFiles = {}
    
    originalMission = {};
    U.recursiveCopyTable(originalMission, mission); 

	missionCreated = true	
end

function getCoordsBullseye(a_coalition)
	return mission.bullseye[a_coalition].x, mission.bullseye[a_coalition].y
end

-------------------------------------------------------------------------------
--
function setBullseye(bs)	
	mission.bullseye = {}
    mission.bullseye.red ={}
    mission.bullseye.blue ={}
    mission.bullseye.red.x = bs.red.x
    mission.bullseye.red.y = bs.red.y
    mission.bullseye.blue.x = bs.blue.x
    mission.bullseye.blue.y = bs.blue.y
    mission.bullseye.red.mapObjects = {}
    mission.bullseye.blue.mapObjects = {}
	
	mission.bullseye.neutrals ={}
	mission.bullseye.neutrals.x = bs.neutrals.x
	mission.bullseye.neutrals.y = bs.neutrals.y
	mission.bullseye.neutrals.mapObjects = {}
    
	originalMission = originalMission or {}
    originalMission.bullseye = {}
    originalMission.bullseye.red ={}
    originalMission.bullseye.blue ={}	
    originalMission.bullseye.red.mapObjects = {}
    originalMission.bullseye.blue.mapObjects = {}
	
	originalMission.bullseye.neutrals ={}
	originalMission.bullseye.neutrals.mapObjects = {}
	
    U.recursiveCopyTable(originalMission.bullseye, mission.bullseye);
end	
	
-------------------------------------------------------------------------------
--
local function setUnitStartParameters(unit)
	if unit.boss then
		local route = unit.boss.route
		if route then
			local p1 = route.points[1]
			if p1 then
                unit.speed 		= p1.speed
                unit.alt		= p1.alt
                unit.alt_type	= p1.alt_type
                if p1.type.action == 'From Ground Area'  or p1.type.action == 'From Ground Area Hot' then
                    unit.psi = -unit.heading
                else
                    local p2 = route.points[2]
                    if p2 then
                        unit.psi = math.atan2(-(p2.y - p1.y), p2.x - p1.x)
                    end
                end
			end			
		end
	end
end

function setRequiredModules(um, a_type)
	local unitDef = me_db.unit_by_type[a_type]
	if unitDef._origin and unitDef._origin ~= "TAVKR 1143 High Detail" and unitDef._origin ~= "WIP units" then
		if base.pluginsById[unitDef._origin].is_core ~= true then
			um.requiredModules[unitDef._origin] = unitDef._origin
		end
	end
end

function saveDataCartridge(um, a_data)
	um.dataCartridge = {}
	um.dataCartridge.Points = {}
	um.dataCartridge.GroupsPoints = {}
	
	for k,v in base.ipairs(a_data.Points) do
		um.dataCartridge.Points[k] = {}
		um.dataCartridge.Points[k].alt = v.alt
		um.dataCartridge.Points[k].name = v.name
		um.dataCartridge.Points[k].x = v.x
		um.dataCartridge.Points[k].y = v.y
	end
	
	for k,v in base.pairs(a_data.GroupsPoints) do
		um.dataCartridge.GroupsPoints[k] = {}
		if k == "PP" then
			for kk,vv in base.pairs(v) do
				local tmp = {}
				tmp.point = vv.index
				if vv.ppData and vv.ppData.bTerminal == true then
					tmp.data = {}
					tmp.data.speed 		= vv.ppData.speed
					tmp.data.angle 		= vv.ppData.angle
					tmp.data.heading 	= vv.ppData.heading
				end

				base.table.insert(um.dataCartridge.GroupsPoints[k], tmp)
			end
		else
			for kk,vv in base.pairs(v) do
				base.table.insert(um.dataCartridge.GroupsPoints[k], vv.index)
			end	
		end
	end
end

function unload_flightPlans(um)
	um.flightPlans = {}
	
	for i,fp in base.ipairs(mission.flightPlans) do
		um.flightPlans[i] 			= {}
		um.flightPlans[i].points 	= {}
		um.flightPlans[i].name 		= fp.name
		um.flightPlans[i].dateStr	= fp.dateStr
		um.flightPlans[i].color		= fp.color
		um.flightPlans[i].type		= fp.type
		um.flightPlans[i].hidden	= fp.hidden	
		
		for k,v in base.ipairs(fp.points) do
			um.flightPlans[i].points[k] 			= {}
			um.flightPlans[i].points[k].pointId 	= v.pointId
			um.flightPlans[i].points[k].x 			= v.x
			um.flightPlans[i].points[k].y 			= v.y
			um.flightPlans[i].points[k].linkSnap 	= v.linkSnap
			um.flightPlans[i].points[k].alt			= v.alt
			um.flightPlans[i].points[k].speed		= v.speed
		end	
	end	
end

-------------------------------------------------------------------------------
-- Создает таблицы авиационной группы для сериализации.
function unload_air_groups(u, type, cant, um)
  cant[type] = {group = {}}
  for k,w in pairs(u[type].group) do
    local gr = 
	{
        groupId 		= w.groupId, 
        name 			= w.name, 		
        start_time 		= w.start_time, 
		lateActivation	= w.lateActivation,
		hiddenOnPlanner = w.hiddenOnPlanner,
		hiddenOnMFD		= w.hiddenOnMFD,
		condition		= w.condition,
		probability		= w.probability,
        task 			= crutches.taskToId(w.task),
		taskSelected 	= w.taskSelected,
		callname 		= w.callname,
		communication 	= w.communication,
		frequency 		= w.frequency,
		modulation		= w.modulation,
		radioSet 		= w.radioSet,
        units 			= {}, 
        route 			= {points = {}}, 
        hidden 			= w.hidden,
		uncontrolled	= w.uncontrolled,
		uncontrollable  = w.uncontrollable,
		x				= w.x,
		y				= w.y,
		password		= w.password
	}
	
	if w.tasks then
		gr.tasks = {}
		U.recursiveCopyTable(gr.tasks, w.tasks)
	end
	  
    -- мультилокализация задач группы
    if gr.tasks then
        for k,task in base.pairs(gr.tasks) do
            if task.params and task.params.action and task.params.action.params then
                local params = task.params.action.params
                if params.subtitle then      
                    mod_dictionary.textToMis(params, 'subtitle', params.subtitle, params.KeyDict_subtitle)
                    params.KeyDict_subtitle = nil
                end
            end        
        end    
    end
	
    cant[type].group[k] = gr
    for l=1,#w.units do
      local s = w.units[l]
      
      if (nil == s.x) and (nil == s.y) then
          s.x = w.x
          s.y = w.y
      end
      
      setUnitStartParameters(s)	  	

      local un = {
              AddPropAircraft = s.AddPropAircraft,  				
              unitId = s.unitId,
              name = s.name, 
			  type = me_db.getNameByDisplayName(s.type),
              skill = crutches.skillToIdAir(s.skill), 			  
              onboard_num = s.onboard_num,			  
			  ropeLength = s.ropeLength,
              callsign = unloadCallsign(s.callsign, s.type, s.boss.boss),
			  parking = s.parking,
              parking_landing = s.parking_landing,   
              parking_id = s.parking_id,
              parking_landing_id = s.parking_landing_id,   
              heading = s.heading or 0,
              speed = s.speed or 0,              
              alt = s.alt or 0,
              alt_type = s.alt_type or 0,
              psi = s.psi or 0,
              x = s.x,
              y = s.y,
              payload = {
                  fuel = s.payload.fuel,
                  chaff = s.payload.chaff,
                  flare = s.payload.flare,
                  gun = s.payload.gun,
                  pylons = {},
                  ammo_type = s.payload.ammo_type,
				  restricted = s.payload.restricted,
              },			  
			  civil_plane = s.civil_plane,
              hardpoint_racks = s.hardpoint_racks
          }

		if s.dataCartridge and s.dataCartridge.Points then
			saveDataCartridge(un, s.dataCartridge)
		end
		
		setRequiredModules(um, s.type)
	   
		local unitTypeDesc = me_db.unit_by_type[s.type]
        if ((unitTypeDesc.panelRadio ~= nil) and (s.skill == crutches.getPlayerSkill()
										or s.skill == crutches.getClientSkill())) then
			un.Radio = s.Radio
		end
		
      if s.livery_id then
          un.livery_id = s.livery_id
      end
      gr.units[l] = un
      for m, t in pairs(s.payload.pylons) do
        local pyl = {name = t.name, CLSID = t.CLSID, settings = t.settings}
        		
		un.payload.pylons[m] = pyl
      end
    end
    
    for l=1,#w.route.points do
      local s = w.route.points[l]
      local pt = {
          name = s.name,
          alt = s.alt,
          alt_type = s.alt_type,
          type = s.type.type,
          action = s.type.action,
          speed = s.speed,
          speed_locked = s.speed_locked,
          ETA = s.ETA,
          ETA_locked = s.ETA_locked,
          x = s.x,
          y = s.y,
          helipadId = s.helipadId,
          airdromeId = s.airdromeId,
          grassAirfieldId = s.grassAirfieldId,
		  timeReFuAr	= s.timeReFuAr,
		 -- roadnet = s.roadnet,
          task = nil,
          formation_template = s.formation_template,
          properties = s.properties,
      }	  
	  
	  if s.task then
		pt.task = {}
		U.recursiveCopyTable(pt.task, s.task)
		resetTaskValid(pt.task)
	  end
      
      -- мультилокализация задач
      if pt.task and pt.task.params and pt.task.params.tasks then
        for k,task in base.pairs(pt.task.params.tasks) do
            if task.params and task.params.action and task.params.action.params then
                local params = task.params.action.params
                if params.subtitle then                 
                    mod_dictionary.textToMis(params, 'subtitle', params.subtitle, params.KeyDict_subtitle)
                    params.KeyDict_subtitle = nil
                end
            end        
        end    
      end
      
      if s.linkUnit then
          pt.linkUnit = s.linkUnit.unitId
      end
	  
	  if s.linkSnap then
          pt.linkSnap = s.linkSnap
      end
	  
	  gr.route.points[l] = pt
    end
    gr.route.routeRelativeTOT = w.route.routeRelativeTOT
	if w.INUFixPoints then
        gr.INUFixPoints = {};
        for i = 1, #w.INUFixPoints do
              local INUFixPoint = {
                index = w.INUFixPoints[i].index,
                x = w.INUFixPoints[i].x,
                y = w.INUFixPoints[i].y,
              }
            table.insert(gr.INUFixPoints, INUFixPoint)
        end;        
    end;
    if w.NavTargetPoints then
        gr.NavTargetPoints = {};        
        for i = 1, #w.NavTargetPoints do
              local NavTargetPoint = {
                index = w.NavTargetPoints[i].index,
                x = w.NavTargetPoints[i].x,
                y = w.NavTargetPoints[i].y,
                text_comment = w.NavTargetPoints[i].text_comment
              }
            table.insert(gr.NavTargetPoints, NavTargetPoint)
        end;        
    end;
  end
--fix empry groups  
  if #cant[type].group == 0 then cant[type] = nil; end;
end

-------------------------------------------------------------------------------
-- Создает таблицы неавиационной подвижной группы для сериализации.
function unload_nonair_groups(u, type, cant, usedCustomForms, um)
  cant[type] = {group = {}}
  for k,w in pairs(u[type].group) do
    local gr = 
	{        
        groupId 		= w.groupId,
        name 			= w.name, 
        start_time 		= w.start_time, 
		lateActivation	= w.lateActivation,
		hiddenOnPlanner = w.hiddenOnPlanner,
		hiddenOnMFD		= w.hiddenOnMFD,
		condition		= w.condition,
		probability		= w.probability,
        task 			= crutches.taskToId(w.task),
        taskSelected 	= w.taskSelected,
        manualHeading   = w.manualHeading,
        units 			= {}, 
        route 			= {points = {}}, 
		tasks			= w.tasks,
        hidden 			= w.hidden,		
        visible 		= w.visible or false,
		x				= w.x,
		y				= w.y,
		uncontrollable  = w.uncontrollable,
    }    
    cant[type].group[k] = gr
    for l=1,#w.units do
		local s = w.units[l]
		local heading = s.heading
		if not heading then
			heading = 0
		end

		local un = {
			unitId = s.unitId,
            AddPropVehicle  = s.AddPropVehicle,  
			name = s.name, 
			type = me_db.getNameByDisplayName(s.type),
			skill = crutches.skillToId(s.skill),
			x = s.x,
			y = s.y,
            ammo = s.ammo and loadoututilsV.filterDefault(s.ammo, s.type), 
			heading = heading,
            livery_id = s.livery_id,
			playerCanDrive = s.playerCanDrive,
			coldAtStart = s.coldAtStart,
            wagons = s.wagons,
			modulation = s.modulation,
			frequency = s.frequency,
			linksSources = s.linksSources,
			linksConsumers = s.linksConsumers,
		}
		
		setRequiredModules(um, s.type)
		
		if s.wagons then
			for k,v in base.pairs(s.wagons) do
				setRequiredModules(um, v)			
			end
		end     
		
		gr.units[l] = un
    end
    
    -- мультилокализация задач группы
    if gr.tasks then
        for k,task in base.pairs(gr.tasks) do
            if task.params and task.params.action and task.params.action.params then
                local params = task.params.action.params
                if params.subtitle then
                    mod_dictionary.textToMis(params, 'subtitle', params.subtitle, params.KeyDict_subtitle)
                    params.KeyDict_subtitle = nil
                end
            end        
        end    
    end
    
    for l=1,#w.route.points do
		local s = w.route.points[l]
		local pt = {
			name = s.name,
			alt = s.alt,
			alt_type = s.alt_type,
			speed = s.speed,
			speed_locked = s.speed_locked,
			ETA = s.ETA,
			ETA_locked = s.ETA_locked,
			type = s.type.type,
			action = s.type.action,
			x = s.x,
			y = s.y,
			task = nil,
			formation_template = s.formation_template,
		}
	  
		if w.type == 'ship' then
			pt.alt = -s.depth
		end
		
		if (not (s.formation_template == '') and U.find(usedCustomForms, s.formation_template) == nil) then
			table.insert(usedCustomForms, s.formation_template)
		end
      
      if s.linkUnit then
          pt.linkUnit = s.linkUnit.unitId
      end
    
	  if s.task then
        for a = 1, #s.task.params.tasks do
		  local actionData = actionDB.getActionDataByTask(s.task.params.tasks[a])
		  local actionParams = actionDB.getActionParams(s.task.params.tasks[a])
          if (actionData.task.id == "Hold" or actionData.task.id == "FireAtPoint") 
              and not (actionParams.templateId == '')
              and U.find(usedCustomForms, actionParams.templateId) == nil 
              then
                  table.insert(usedCustomForms, actionParams.templateId)
          end
        end

		pt.task = {}
		U.recursiveCopyTable(pt.task, s.task)
	  end
      
        -- мультилокализация задач
        if pt.task and pt.task.params and pt.task.params.tasks then
            for k,task in base.pairs(pt.task.params.tasks) do
                if task.params and task.params.action and task.params.action.params then
                    local params = task.params.action.params
                    if params.subtitle then
                        mod_dictionary.textToMis(params, 'subtitle', params.subtitle, params.KeyDict_subtitle)
                        params.KeyDict_subtitle = nil
                    end
                end        
            end    
        end
	  
      gr.route.points[l] = pt
    end
    
    
      
    gr.route.routeRelativeTOT = w.route.routeRelativeTOT
	if w.route.spans then
      gr.route.spans = w.route.spans
    end
  end
--fix empry groups  
  if #cant[type].group == 0 then cant[type] = nil; end;
end

-------------------------------------------------------------------------------
-- Создает таблицы статической группы для сериализации.
function unload_static_groups(u, type, cant, um)
  cant[type] = {group = {}}
  for k,w in pairs(u[type].group) do
    local categoryUnit = crutches.getStaticCategoryByUnitcategory(me_db.getCategoryByType(w.units[1].type))
	
    local gr = 
    {
		groupId = w.groupId,
		name = w.name, 
		heading = w.heading or 0,
		hidden = w.hidden,
		hiddenOnPlanner = w.hiddenOnPlanner,
		hiddenOnMFD		= w.hiddenOnMFD,
		dead = w.dead,	
		linkOffset = w.linkOffset,
		route = {points = {}}, 
		x				= w.x,
		y				= w.y,  
		units 			= {}, 	  
    }
	
	for unitIndex = 1, #w.units do
		local s = w.units[unitIndex]
		
		local un = {
			unitId = s.unitId,
			name = s.name,
			type = me_db.getNameByDisplayName(s.type),
			category = categoryUnit, 
			shape_name = s.shape_name,
			cargo = s.cargo,
			mass = s.mass,          
			canCargo = s.canCargo,
			lenght = s.lenght,
			rate = s.rate,
			heading = s.heading or 0,
			livery_id = s.livery_id,
			lenghtRope = s.lenghtRope,
			effectPreset = s.effectPreset,
			effectCourse = s.effectCourse,
			effectLenghtLine = s.effectLenghtLine,
			effectTransparency = s.effectTransparency,
			effectRadius = s.effectRadius,
			x = s.x,
			y = s.y,
			-- airdromeId = w.units[1].airdromeId,
			heliport_callsign_id = (categoryUnit == "Heliports") and s.heliport_callsign_id or nil,
			heliport_frequency = (categoryUnit == "Heliports") and s.heliport_frequency or nil,
			heliport_modulation = (categoryUnit == "Heliports") and s.heliport_modulation or nil,


			grassairfield_callsign_id = (categoryUnit == "GrassAirfields") and s.grassairfield_callsign_id or nil,
			grassairfield_frequency = (categoryUnit == "GrassAirfields") and s.grassairfield_frequency or nil,
			grassairfield_modulation = (categoryUnit == "GrassAirfields") and s.grassairfield_modulation or nil,   
		}
		gr.units[unitIndex] = un
	end	
	        
		---------------------------
	setRequiredModules(um, w.units[1].type)
    
    local pt = {
      name = '',
      alt = 0,
      type = '',
      action = '',
      speed = 0,
	  formation_template = '',
      x = gr.units[1].x,
      y = gr.units[1].y,      
    }
    if w.route.points[1].linkUnit then
        pt.linkUnit = w.route.points[1].linkUnit.unitId
		
		if w.linkOffset then -- записываем таблицу смещения и поворотов относительно родителя повернутого в 0
			local unitP = unit_by_id[pt.linkUnit]
			gr.units[1].offsets = {}
			gr.units[1].offsets.angle = gr.units[1].heading - unitP.heading
			if gr.units[1].offsets.angle < 0 then
				gr.units[1].offsets.angle = 2 * base.math.pi + gr.units[1].offsets.angle
			end
			
			local dx =  pt.x - unitP.x
			local dy =  pt.y - unitP.y 
			local sinHdg = base.math.sin(-unitP.heading)
			local cosHdg = base.math.cos(-unitP.heading)
			
			gr.units[1].offsets.x = dx*cosHdg - dy*sinHdg
			gr.units[1].offsets.y = dy*cosHdg + dx*sinHdg			
		end
    end
    table.insert(gr.route.points, pt);
    cant[type].group[k] = gr
  end
--fix empry groups  
  if #cant[type].group == 0 then cant[type] = nil; end;
end

--Включает в миссию шаблоны используемые в качестве формаций
function getCustomFormations(usedTemplatesFormations)
    if #usedTemplatesFormations == 0 then return nil end
    
    local customForms = {}
    for i, templName in ipairs(usedTemplatesFormations) do
        local templ = TEMPL.templates[templName]
        if templ then
            local customForm = {name = templName, positions = {}}
            for k, unit in ipairs(templ.units) do
                local unitPlace = {x = unit.dx, y = unit.dy, heading = unit.heading}
                table.insert(customForm.positions, unitPlace)
            end
            table.insert(customForms, customForm)
        end
    end
    return customForms
end


local function checkCustomFormsInTriggers(trigrules, usedCustomForms)
	for i, v in ipairs(trigrules) do
		for j, act in ipairs(v.actions) do
			if act.predicate == "a_fall_in_template" 
				and not (act.template == nil)
				and not (act.template == "") 
				and U.find(usedCustomForms, act.template) == nil then
				table.insert(usedCustomForms, act.template)
			end
		end
	end
end

-------------------------------------------------------------------------------
local passthrough_mission_tables = {
  'ext_loader'
}

function convertStartTimeToDate(start_time)
	local days = math.floor(start_time/(60*60*24))
   
	
    local NumDayInMounts = UC.getNumDayInMounts()

	local MissionDate =  base.MissionDate
 
	--считаем что начало 1 июня 2011
	local day	= MissionDate.Day --1
	local month	= MissionDate.Month  --6
	local year 	= MissionDate.Year--2011
	
	local tmpData = 0
	
	while true do
		local tmp = tmpData + NumDayInMounts[month] 
		if (month == 2) then
			tmp = tmp + autobriefingutils.isLeapYear(year)
		end
		
		if (days >= tmp) then
			tmpData = tmp
		else
			day = day + days - tmpData
			break
		end

		if (month == 12) then		
			month = 1
			year = year + 1
			day = 1
		else
			month = month + 1
			day = 1
		end 
	end

    return {Year = year , Month  = month , Day = day}
end


-------------------------------------------------------------------------------
-- Подготавливает таблицы текущей миссии для сериализации.
function unload()
	if mission and mission.map then			
		mapX, mapY = mission.map.centerX or 0, mission.map.centerY or 0
	else
		mapX, mapY = 0, 0
	end

	if mission and mission.map then
		mapZoom = mission.map.zoom or 100000
	else
		mapZoom = 100000
	end

	Trigger.fixTriggers(mission.trigrules)
	Goal.fixGoals(mission.goals)
	mission.failures = {}
	U.copyTable(mission.failures, panel_failures.vdata)
	
	local um = {	
		version = VERSION_MISSION,
		maxDictId = mod_dictionary.getMaxDictId(),	
		requiredModules = {},
		theatre  = TheatreOfWarData.getName(),
		currentKey = currentKey,
		start_time = mission.start_time,
		date = mission.date,
		weather = mission.weather, 
		failures = unloadFailures(),
		generatorParams = mission.generatorParams,
		triggers = {},
		coalitions = CoalitionController.saveCoalitions(),
		coalition = {},

		goals = Goal.saveGoals(mission.goals),
		initScriptFile = mission.initScriptFile,
		initScript = mission.initScript,
		trigrules = Trigger.saveTriggers(mission.trigrules),
		
		pictureFileNameR = mission.pictureFileNameR or {},
		pictureFileNameB = mission.pictureFileNameB or {},	
		pictureFileNameN = mission.pictureFileNameN or {},
		descriptionText = mission.descriptionText, 
		descriptionRedTask = mission.descriptionRedTask,
		descriptionBlueTask = mission.descriptionBlueTask,  
		descriptionTbl = mission.descriptionTbl, 
		descriptionNeutralsTask = mission.descriptionNeutralsTask,  
		sortie = mission.sortie,    
		map = {
			centerX = mapX,
			centerY = mapY,
			zoom = mapZoom,
		},
		sounds = mission.sounds;
		forcedOptions = OptionsData.getForcedOptions(),
		customFormations = mission.customFormations,
		flightPlans = mission.flightPlans
	}
	
	if mission.flightPlans then
		unload_flightPlans(um)
	end

  mod_dictionary.textToMis(um, 'descriptionText', mission.descriptionText, mission.KeyDict_descriptionText)
  mod_dictionary.textToMis(um, 'descriptionRedTask', mission.descriptionRedTask, mission.KeyDict_descriptionRedTask)
  mod_dictionary.textToMis(um, 'descriptionBlueTask', mission.descriptionBlueTask, mission.KeyDict_descriptionBlueTask)
  mod_dictionary.textToMis(um, 'descriptionNeutralsTask', mission.descriptionNeutralsTask, mission.KeyDict_descriptionNeutralsTask)
  mod_dictionary.textToMis(um, 'sortie', mission.sortie, mission.KeyDict_sortie)
  
 -- um.usedModules = base.enableModules
  

  um.groundControl = {}
  U.recursiveCopyTable(um.groundControl, panel_roles.getGroundControlData()) 

	
 -- print('theatre=',um.theatre)
  
  um.result = um.result or {}
  um.result.total = #mission.goals
  um.result.offline = um.result.offline or {}
  um.result.offline.conditions = Goal.generateGoalConditions(mission.goals, 'OFFLINE') 
  um.result.offline.actions = Goal.generateGoalActions(mission.goals, 'OFFLINE') 
  um.result.offline.func = Goal.generateGoalFunc2(mission.goals, 'OFFLINE', 'mission.result.offline') 
  um.result.blue = um.result.blue or {}
  um.result.blue.conditions = Goal.generateGoalConditions(mission.goals, 'BLUE') 
  um.result.blue.actions = Goal.generateGoalActions(mission.goals, 'BLUE') 
  um.result.blue.func = Goal.generateGoalFunc2(mission.goals, 'BLUE', 'mission.result.blue')
  um.result.red = um.result.red or {}
  um.result.red.conditions = Goal.generateGoalConditions(mission.goals, 'RED') 
  um.result.red.actions = Goal.generateGoalActions(mission.goals, 'RED') 
  um.result.red.func = Goal.generateGoalFunc2(mission.goals, 'RED', 'mission.result.red')

  um.trig = um.trig or {}
  um.trig.flag = um.trig.flag or {}
  
  um.trig.custom = mission.trig and mission.trig.custom or {}
  
  obsolete_triggers = "for i,t in pairs(mission.result.red.conditions) do mission.result.red.conditions[i]=loadstring(t) end"

  if mission.trig and mission.trig.customStartup then
  	um.trig.customStartup = ((#mission.trig.customStartup==8) and (mission.trig.customStartup[1]==obsolete_triggers)) and {} or mission.trig.customStartup
  else
	um.trig.customStartup = {}
  end

	
  um.trig.conditions = Trigger.generateTriggerConditions(mission.trigrules)
  um.trig.actions = Trigger.generateTriggerActions(mission.trigrules) 
  um.trig.func = Trigger.generateTriggerFunc2(mission.trigrules, false)
  um.trig.events = Trigger.generateEvents(mission.trigrules)
  
  
  um.trig.funcStartup = Trigger.generateTriggerFunc2(mission.trigrules, true)

  for i=1,#um.trig.func do um.trig.flag[i] = true; end; -- Dmut: obsolete, to be removed in A-10
  for i=1, mission.trigrules and #mission.trigrules or 0 do um.trig.flag[i] = true; end;

  --print(mission.descriptionText)
  um.triggers.zones = TriggerZoneController.saveTriggerZones()

  -- В группы коалиций были добавлены вспомогательные объекты, поэтому их нельзя просто сериализовать.
  -- Будем выгружать их специальными утилитами.
  local usedCustomForms = {}

    for i,v in pairs(mission.coalition) do
		local coal = 
		{
			name = v.name, 
			country = {},
			bullseye = unload_bullseye(i),
			nav_points = NavigationPointController.saveCoalition(i),
		}

		um.coalition[i] = coal
		for j,u in pairs(v.country) do
			local cant = {id = u.id, name = me_db.country_by_id[u.id].OldID }
			
			if u.plane then
				unload_air_groups(u, 'plane', cant, um)
			end
			if u.helicopter then
				unload_air_groups(u, 'helicopter', cant, um)
			end
			if u.ship then
				unload_nonair_groups(u, 'ship', cant, usedCustomForms,um)
			end
			if u.vehicle then
				unload_nonair_groups(u, 'vehicle', cant, usedCustomForms,um)
			end
			if u.static then
				unload_static_groups(u, 'static', cant,um)
			end
			if u.complex then
				unload_static_groups(u, 'complex', cant,um)
			end

			if (cant.helicopter ~= nil)
					or (cant.plane ~= nil)
					or (cant.ship ~= nil)
					or (cant.vehicle ~= nil)
					or (cant.static ~= nil) then					
				base.table.insert(coal.country, cant)
			end	
		end
    end
  
	checkCustomFormsInTriggers(um.trigrules, usedCustomForms)
	um.customFormations = getCustomFormations(usedCustomForms)

  for i,v in ipairs(passthrough_mission_tables) do
    if mission[v] then
      um[v] = mission[v]
    end
  end
  
	um.drawings = mission.drawings

  return um
end

function unloadFailures()
    local res = {}
    base.U.recursiveCopyTable(res,mission.failures)    
    for k,v in base.pairs(res) do
        v.label = nil
    end
    return res
end

-------------------------------------------------------------------------------
-- Подготавливает таблицы менеджера ресурсов для сериализации.
function unloadAirportsEquipment()
    local um = {}
    U.recursiveCopyTable(um, mission.AirportsEquipment)

    for k,v in pairs(um) do
        for kk,vv in pairs(v) do    
            if vv.unlimitedAircrafts == true then
                vv.aircrafts = {}
            end
            
            if vv.unlimitedMunitions == true then
                vv.weapons = {}
            end
        end
    end
	
	if um.airports then	
		local coalitionNames = {
			[CoalitionController.redCoalitionName()] = 'RED',
			[CoalitionController.blueCoalitionName()] = 'BLUE',
			[CoalitionController.neutralCoalitionName()] = 'NEUTRAL',
		}
		
		for airdromeNumber, airport in pairs(um.airports) do
			local airdromeId = AirdromeController.getAirdromeId(airdromeNumber)
			local airdrome = AirdromeController.getAirdrome(airdromeId)
			
            if airdrome then
                airport.coalition = coalitionNames[airdrome:getCoalitionName()]
            else
                base.print("ERROR: invalid airdrome ID:",airdromeId)
            end    
		end
	end
	
    
    return um
end

-------------------------------------------------------------------------------
-- Подготавливает таблицы менеджера ресурсов для сериализации.
function unloadDictionary()
    local um = {}
    U.recursiveCopyTable(um, mod_dictionary.getDictionary()) 
    return um
end

-------------------------------------------------------------------------------
-- Подготавливает таблицы менеджера ресурсов для сериализации.
function unloadMapResource()
    local um = {}
    U.recursiveCopyTable(um, mod_dictionary.getMapResource()) 
    return um
end
 

-------------------------------------------------------------------------------
-- Поиск ошибок в миссии
function check_mission(showError)
	local verifySummResult = nil
	for i, v in pairs(mission.coalition) do
		for j, u in pairs(v.country) do
			for k, t in pairs(u) do
				if 	base.type(t) == 'table' and
					base.type(t.group) == 'table' then
					for l, w in pairs(t.group) do
						w.start_time = w.route.points[1].ETA
						local verifyRouteResult = panel_route.verify(w.route, w.lateActivation)
						local verifyGroupResult = false	
                        if k == 'plane' or k == 'helicopter' then
							if (w.units[1].skill == crutches.getPlayerSkill() or w.units[1].skill == crutches.getClientSkill()) then
								verifyGroupResult = panel_aircraft.verify(w)
							end		
                        end                        
						local verifyResult = (verifyRouteResult or verifyGroupResult) and ((verifyRouteResult and verifyRouteResult..'\n' or '')..(verifyGroupResult or ''))
                        if verifyResult then
							verifySummResult = verifySummResult or ''
							verifySummResult = verifySummResult..w.name..':'
							verifySummResult = verifySummResult..'\n'..verifyResult
						end
                    end
				end
			end
		end
    end
    if verifySummResult then
		local linesMaxQty = 30
		local linesQty = 0
		local crPos = 0
		while linesQty < linesMaxQty and crPos ~= nil do
			crPos = base.string.find(verifySummResult, '\n', crPos + 1)
			linesQty = linesQty + 1
		end
		if linesQty >= linesMaxQty then
			verifySummResult = base.string.sub(verifySummResult, 1, crPos)..'\n...'
		end
        
        if (showError == true) then
			showErrorMessageBox(verifySummResult, cdata.mission_errors)
        end
		
		return false
	else
		return true
	end
end

-------------------------------------------------------------------------------
-- Подготовка и сериализация текущей миссии в заданном файле.
function save_mission(fName, showError, noLoad)
	--проверяем доступность файла
	local f, err = base.io.open(fName, 'w')
	if f then
		f:close()
	else
		if showError then
			showErrorMessageBox(cdata.save_mission_failed_msg.." "..fName, cdata.save_mission)	
		end
		return false		
	end
  
	AutoBriefingModule.missionFileName = fName
	local mis = unload()
	local misAE = unloadAirportsEquipment()
    local dictionary = unloadDictionary()
    local mapResource = unloadMapResource()    
	local saved = save(fName, mis, misAE, dictionary, mapResource, false, noLoad)
	if not saved and showError then
		showErrorMessageBox(cdata.save_mission_failed_msg.." "..fName, cdata.save_mission)	
	end    
	
	return saved
end

-------------------------------------------------------------------------------
-- Подготовка и сериализация текущей миссии в заданном файле с проверкой ошибок пользователя
function save_mission_safe(fName, showError, noLoad)
	if check_mission(showError) then
		return save_mission(fName, showError, noLoad)
	else
		print("ERROR IN MISSION!")
		return false
	end
end

-------------------------------------------------------------------------------
--
function saveUnpackedMission(fName, mis, misAE)
    U.saveTable(fName, 'mission', mis)
    
end

local function addOptionsToZip(miz)
	local options = OptionsData.getOptionsForMission()
	
	options["playerName"] = LogBook.currentPlayer.player.callsign
	U.addTableToZip(miz, "options", options)
end


local function addTheatreToZip(miz, theatre)
	local tempFileName = base.tempDataDir .. "temp.theatre" 
	local f = base.io.open(tempFileName, 'w')
	f:write(theatre)
	f:close()
   
    miz:zipAddFile('theatre', tempFileName)
end

-------------------------------------------------------------------------------
-- Сохранение данных в файле.
function save(fName, mis, misAE, dictionary, mapResource, unpacked, noLoad)
    --mis.path = fName;
   -- print("save(fName, mis, misAE, unpacked)",fName, mis, misAE, dictionary, mapResource, unpacked)
    base.assert(not unpacked)

    local tempFileName = base.tempDataDir .. "temp.mis"

    saveUnpackedMission(tempFileName, mis, misAE)    
    miz = minizip.zipCreate(fName)
    
    if miz == nil then
		base.print("---miz == nil---",fName)
        return false
    end
    
    if not miz:zipAddFile("mission", tempFileName) then 
        miz:zipClose()
        return false 
    end
    
    -- saveDictionary
        for k,v in base.pairs(dictionary) do   
            --base.print("---saveDictionary=",k)
            U.addTableToZip2(miz,'dictionary', 'l10n/'..k..'/dictionary', v)  
        end
    ---
    -- saveResource
        for k,v in base.pairs(mapResource) do   
            --base.print("---savemapResource=",k)
            U.addTableToZip2(miz,'mapResource', 'l10n/'..k..'/mapResource', v)  
        end
    ---
    
    U.addTableToZip(miz, 'warehouses', misAE)  
	addOptionsToZip(miz)
    base.os.remove(tempFileName)
    packMissionResources(miz)
	addTheatreToZip(miz, mis.theatre)
    miz:zipClose()	

    if noLoad ~= true then
        load(fName)
    end
    originalMission = {};
    U.recursiveCopyTable(originalMission, mission);
    

    print(fName, 'saved');
	return true
end


------------------------------------------
--
function getUnitName(a_groupName, a_forbiddenNames)
	local gName = a_groupName.."-1"
	
	return check_unit_name(gName, a_forbiddenNames)
end

function isGroupFreeName(a_name)
	return group_by_name[a_name] == nil
end

function isUnitFreeName(a_name)
	return unit_by_name[a_name] == nil
end

function check_group_name(a_name)
	local nm = a_name
	local num = 0
	local baseName = nm
	
	local dotIdx = base.string.find(nm, '%-%d+$')

	if dotIdx then
		baseName = base.string.sub(nm, 0, dotIdx-1)
	end

	while group_by_name[nm] do
		num = num + 1
		nm = baseName.."-"..num		
	end
	return nm
end

function check_unit_name(a_name, a_forbiddenNames)
	local nm = a_name
	local num = 0
	local baseName = nm
  
	local dotIdx = base.string.find(base.string.reverse(nm), '-')
	if dotIdx then
		baseName = base.string.sub(nm, 0,-dotIdx-1)
	end
	
	while unit_by_name[nm] or (a_forbiddenNames and a_forbiddenNames[nm]) do
		num = num + 1
		nm = baseName.."-"..num		
	end
  return nm
end



-------------------------------------------------------------------------------
-- Проверка имени цели на уникальность и формирование уникального имени.
function check_target_name(name)
  local nm = name
  if not nm or nm == '' then
    return nil
  end
  if target_by_name[nm] then
    targetNameIndex = targetNameIndex+1
    nm = nm..' #'..targetNameIndex
  end
  return nm
end

-------------------------------------------------------------------------------
-- Функция создает группу в текущей миссии на основе заданных параметров и
-- координат на карте.
-- Группа - это контейнер для юнитов и маршрута.
-- Для отображения группы на карте контейнер включает соответствующие объекты карты,
-- которые изменяются синхронно с объектами миссии.
-- Параметр type задает имя таблицы в составе страны - plane, helicopter, ship, vehicle, static.
-- Параметр name задает имя группы, присвоенное пользователем при ее создании.
-- Параметр name задает имя группы, присвоенное пользователем при ее создании.
-- Параметр start_time задает время начала функционирования группы в секундах
-- относительно времени начала миссии.
-- Параметры x, y используются для расстановки объектов круппы на карте.
function create_group(country_name, type, name, callname_, communication_, frequency_, start_time, x, y, unitType)
    --print('create_group',type,name);
  -- Таблица country_name формируется на основе таблиц коалиций миссии.
  local country = missionCountry[country_name]
  if not country[type] then
    country[type] = {group = {}}
  end
  local groupId = getNewGroupId()
  editorManager.setNewGroupCountryName(country_name)
  
  local coalition = countryCoalition[country_name]
  local color = coalition.color
  local nm = check_group_name(name)  
  local group = 
  {
    groupId = groupId,
    boss = country,
    color = color,  -- Это базовый цвет объектов группы на карте  
    type = type,     
	callname = callname_,
	communication = communication_,
	frequency = frequency_,
    start_time = 0,
    x = x,
    y = y,
    units = {},
    -- В состав mapObjects входят знак собственно группы, знаки юнитов, линия маршрута,
    -- точки маршрута и номера точек маршрута.
    -- Некоторые элементы могут отсутствовать у групп некоторых типов. Например, у статических
    -- групп нет маршрута.
    -- При изменениях в группе обновляется вид всех объектов mapObjects.
    mapObjects = {units = {}, zones = {},},
    hidden = false,
	uncontrolled = false,
    variantProbability = {
		{ value = 100, changed = false }
	}
	
  }
  
	group.name = nm
  
	if type == 'static' then
		group.dead = false;	    
	end;
	-- Нужно не забыть при удалении группы чистить соответствующее поле в group_by_name
	group_by_name[group.name] = group
	group_by_id[group.groupId] = group

    group.route = {boss = group, points = {},}
    group.mapObjects.route = {line = {}, points = {}, numbers = {}, targets = {}, targetNumbers = {}, targetLines = {}, targetZones = {}}    
    if group.type == 'vehicle' then
		-- Для машинок создается дополнительная таблица перегонов между точками маршрута,
		-- чтобы хранить промежуточные точки маршрута по дорожной сети.
		group.route.spans = {}		
    end
	
	if group.type == 'vehicle' or group.type == 'ship' then
		group.uncontrollable = false
	end

    group.heading = 0

	table.insert(country[type].group, group)  
	MapWindow.setSelectedUnit(nil)
	base.panel_units_list.update()
	base.panel_units_list.selectRow(group)
	return group
end

-------------------------------------------------------------------------------
-- Удаляет объекты группы с карты и из текущей миссии.
function remove_group(group)
    MapWindow.removeSelectedGroups(group)  
    MapWindow.selectedGroup = nil
    MapWindow.setSelectedUnit(nil)
    panel_targeting.vdata.group = nil

	if (group.units) then	
		for k,v in pairs(group.units) do
			delWarehouse(v.unitId) 
		end
	end
	
	
    --remove linked children objects
	if (group.units) then
        remove_INUFixPoint_All(group)
        remove_NavTargetPoint_All(group)
		for i,unit in ipairs(group.units) do 
			if unit.linkChildren then
				local toUnlink = { }
				for _tmp, v in pairs(unit.linkChildren) do
					table.insert(toUnlink, v)
					v.type = panel_route.actions.turningPoint
				end
				for _tmp, v in pairs(toUnlink) do
					unlinkWaypoint(v)
				end                
			end 
			unlinkAllRequiredUnits(unit)	
			
			if unit.linkChildrenTZone then
				for i = #unit.linkChildrenTZone, 1,-1 do
					local zoneId = unit.linkChildrenTZone[i]
					unlinkTriggerZone(zoneId) 	
				end			            
			end 
		end
	end
	
	onGroupTasksRemove(group)
	onTasksRemoveFromOtherGroups(group)

    if group.route then	
        -- unlink each waypoint from ths group
        for _tmp, v in pairs(group.route.points) do
            if v.linkUnit then
                unlinkWaypoint(v)
            end
			unlinkSnap(v)	
        end
    end
	
	remove_group_map_objects(group)

  -- Сначала нужно пробежаться по группе и почистить присвоенные имена юнитов, точек маршрута и целей.
  -- Удаляем группу из миссии
  --base.U.traverseTable(group.units,3)
  if (group.boss) then
	  for i,v in pairs(group.boss[group.type].group) do
		if v == group then
		--print('removing group', group.boss[group.type].group, group.boss[group.type].group[i].name)
		  table.remove(group.boss[group.type].group, i)
		  --U.traverseTable(group_by_name[group.name])
		  for uk,unit in pairs(group.units) do
			--print('removing unit ',uk ,unit, unit.name);
			unit_by_name[unit.name] = nil;
			unit_by_id[unit.unitId] = nil;
			--print("---remive unit1=",unit.name, unit.unitId)
		  end;
		  group_by_name[group.name] = nil
		  group_by_id[group.groupId] = nil
		  base.panel_units_list.update();          
		  return
		end 
	  end
  end  
  --print('group not found', group, group.name); -- только для юнитов
  base.panel_units_list.update();
end

-------------------------------------------------------------------------------
--
function updateUnitZones(unit)
    local x = unit.x
    local y = unit.y	
    if unit.zones then
		local zones = {}
        for k,zone in base.pairs(unit.zones) do
			if zone.type == "AuthoritySector" then
				zone.points = createSectorPoints(x, y, zone.radius, zone.AuthoritySector, unit.heading)
			else
                zone.points = createCirclePoints(x, y, zone.radius)                
			end	

			if MapWindow.selectedGroup == unit.boss then
				base.table.insert(zones, zone)
			elseif  MeSettings.getShowDetAreas() == true and zone.classKey == 'DetectionRangeBorder' then	
				base.table.insert(zones, zone)
			elseif MeSettings.getShowEngAreas() == true 
					and (zone.classKey == 'ThreatRangeBorder' or zone.classKey == 'ThreatRangeMinBorder') then	
				base.table.insert(zones, zone)
			end			
        end
		
		MapWindow.removeUserObjects(unit.zones)
        MapWindow.addUserObjects(zones)
    else
        createUnitZones(unit)
    end
end 

-------------------------------------------------------------------------------
--
function removeUnitZones(unit)
    local toRemove = {};
    local group = unit.boss;
	
    local unitZones = unit.zones or {};
    for tmp,unitZone in pairs(unitZones) do -- по зонам юнита
        set_mapObjects(unitZone.id, nil); -- удаляем с карты 
        table.insert(toRemove, unitZone);
    end
    unit.zones = nil;
    MapWindow.removeUserObjects(toRemove)   
end; 


-------------------------------------------------------------------------------
--
function createUnitZones(unit)
	local udb = me_db.unit_by_type[unit.type]
    base.assert(udb, unit.type .. "!unit_by_type[]")

	local enableInSelected = MapWindow.isUnitInSelectedGroups(unit)
	
	if (udb.category ~= 'Air Defence') and (udb.warehouse ~= true) and (not enableInSelected)  then
		return
	end

    local group = unit.boss
    local zoneDescr
	
	if udb.warehouse == true then
		zoneDescr = {
			{
				classKey = 'WarehouseRangeBorder',
				radius = 200,
			},
		}
	else
		zoneDescr = {
			{
				name = "DetectionRange",
				classKey = 'DetectionRangeBorder',
			},
			{
				name = "ThreatRange",
				classKey = 'ThreatRangeBorder',
			},
			{
				name = "ThreatRangeMin",
				classKey = 'ThreatRangeMinBorder',
			},
	    }		
	end	
	
	for tmp, descr in ipairs(zoneDescr) do    
		local name = descr.name
		local radius = 0
		
		if descr.radius then
			radius = descr.radius
		elseif udb[name] then
			radius = udb[name]
		end
	  
		if radius > 0 then
			currentKey = currentKey + 1
			
			local id = currentKey
			local x = unit.x
			local y = unit.y
			local points 
			if udb.AuthoritySector then
				points = createSectorPoints(x, y, radius, udb.AuthoritySector, unit.heading)				
			else
				points = createCircleLinePoints(x, y, radius)
			end
			
			local zone = MapWindow.createLIN(descr.classKey, id, points)
			
			if udb.AuthoritySector then
				zone.AuthoritySector = TableUtils.copyTable(nil, udb.AuthoritySector)
				zone.type = "AuthoritySector"
			end
			
			zone.radius = radius
			zone.userObject = unit
			unit.zones = unit.zones or {}
			table.insert(unit.zones, zone)
			set_mapObjects(zone.id, zone)
		end
	end
		
    if unit.zones and (not group.hidden) then
        MapWindow.addUserObjects(unit.zones)
    end
end 

-------------------------------------------------------------------------------
-- Функция для создания на карте круглой площадной зоны цели.
-- Радиус задается в метрах.
function create_target_zone(target)
  local stencil = 3
  
  local radius = target.radius
  local x = target.x
  local y = target.y
  local classKey = 'S0000000530'
  currentKey = currentKey+1
  local id = currentKey
  local color = nil
  local zone = createCircle(x, y, radius, classKey, id, nil, stencil)
  local c = target.boss.boss.boss.boss.selectGroupColor
  
  zone.currColor = MapColor.new(c[1], c[2], c[3], 0.15)
  zone.userObject = target
  
  set_mapObjects(zone.id, zone)
  table.insert(target.boss.boss.mapObjects.route.targetZones[target.boss.index], target.index, zone)
end

-------------------------------------------------------------------------------
-- Вызывается при изменении радиуса зоны цели.
function update_target_zone(target)
	if target.boss.boss ~= MapWindow.selectedGroup then
        return
    end	
	
	local radius = target.radius
	local x = target.x
	local y = target.y
	local zone = target.boss.boss.mapObjects.route.targetZones[target.boss.index][target.index]
	if not zone then
		create_target_zone(target)
		zone = target.boss.boss.mapObjects.route.targetZones[target.boss.index][target.index]
	else
		zone.points = createCirclePoints(x, y, radius)
	end
  
	if base.MapWindow.isShowHidden(target.boss.boss) == true then
		MapWindow.removeUserObjects({zone})
		MapWindow.addUserObjects({zone})
	end
end

-------------------------------------------------------------------------------
-- reset chaff and flares to default values
function setDefaultChaffFlare(group)
    for _k, unit in pairs(group.units) do
        local unitDef = me_db.unit_by_type[unit.type]
		if unitDef.passivCounterm ~= nil then
			unit.payload.chaff = unitDef.passivCounterm.chaff.default
			unit.payload.flare = unitDef.passivCounterm.flare.default
		else
			unit.payload.chaff = 0
			unit.payload.flare = 0
		end
    end
end

-------------------------------------------------------------------------------
-- Вставляет юнит заданного типа в заданную группу.
-- Параметр index задает порядковое расположение в составе группы. 
function insert_unit(group, type, skill, index, name_, x, y, heading_, a_category, a_livery_id)
	--print("group, type, skill, index, name_, lat_, long_, heading_=", group, type, skill, index, name_, lat_, long_, heading_)
  unitNameIndex = unitNameIndex+1
  maxUnitId = maxUnitId + 1
  --print("---maxUnitId=",maxUnitId)  
  local unit = 
  {
    unitId = maxUnitId,
    boss = group,    
    type = type,
    skill = skill,
    index = index,
    x = x or group.x,
    y = y or group.y,
    heading = heading_ or 0,	
  }

 local unitDef = me_db.unit_by_type[type]  
  unit.name = check_unit_name(name_)
  
  if(group.type == 'vehicle') then
	unit.playerCanDrive = unitDef.enablePlayerCanDrive or false -- если можно ставим true
	unit.coldAtStart = false
  end
  
  if(group.type == 'ship') then
	unit.frequency = unitDef.frequency or 127500000
	unit.modulation = 0
  end
  
	
  -- TODO: что это за смещения???
  -- сколько это в метрах ???
  -- предположим, что это примерно 40 метров
  local staticOffset = 40
  
  --print("x=",x)
  --print("group.x=",group.x)
  unit.x = x or (group.x - staticOffset * (index - 1))
    unit.y = y or (group.y + staticOffset * (index - 1))
	
	if group.type == 'vehicle' then
		if a_livery_id then
			unit.livery_id = a_livery_id
		end	
	elseif group.type ~= 'static' then
		unit.livery_id = group.livery_id 	
	else	
		unit.mass = unitDef.mass
		unit.ropeLength = 15
    if unitDef.mass then
        unit.canCargo = true
    else
        unit.canCargo = nil
    end
    unit.lenght = unitDef.lenght
    if me_db.isFARP(type) then
        unit.heliport_callsign_id   = base.panel_static.c_heliport.id or 1;
		unit.heliport_frequency     = base.panel_static.f_heliport:getText() or 127.5;
        unit.heliport_modulation    = me_db.MODULATION_AM
    end;

    if 'Grass Airfield' == type then
        unit.grassairfield_callsign_id   = base.panel_static.c_heliport.id or 1;
		unit.grassairfield_frequency     = base.panel_static.f_heliport:getText() or 127.5;
        unit.grassairfield_modulation    = me_db.MODULATION_AM
    end;
	
	unit.rate = unitDef.Rate
  end

  -- У самолетов и вертолетов нужно инициализировать подвески.
  if group.type == 'plane' or group.type == 'helicopter' then    	
  
	local ChaffDefault = 0
	local FlareDefault = 0
	
	if unitDef.passivCounterm ~= nil then
		ChaffDefault = unitDef.passivCounterm.chaff.default
		FlareDefault = unitDef.passivCounterm.flare.default
	end
  
    unit.payload = {
      fuel = unitDef.MaxFuelWeight,
      chaff = ChaffDefault,
      flare = FlareDefault,
      gun = 100,
      pylons = {
      },
    }

	--по просьбе авиаторов не доливаем P-51
	if (unitDef.defFuelRatio) then
		unit.payload.fuel = unitDef.defFuelRatio*unitDef.MaxFuelWeight
	end
	
    panel_payload.setDefaultLivery(unit)
    -- Наверное, умалчиваемый бортовой номер нужно формировать из номера группы и индекса юнита
    local vd = panel_aircraft.vdata;
	unit.onboard_num = panel_aircraft.getNewOnboard_num(unit)
   -- unit.onboard_num = vd.onboard_num;
    unit.callsign = panel_aircraft.getNewCallsign(unit);--vd.callsign;
  end
  
  table.insert(group.units, index, unit)
  unit_by_name[unit.name] = unit
  unit_by_id[unit.unitId] = unit
  
  insert_unit_symbol(unit)
  
  if(group.type == 'vehicle') then
	loadoututilsV.setDefaultAmmoToUnit(unit, index)
  end
  
  -- Заново создается зона обнаружения/досягаемости. 
  base.panel_units_list.update();  
  return unit
end

-------------------------------------------------------------------------------
-- change name of unit
-- if unit with new name already exists, returns false and doesn't 
-- change anything
function renameUnit(unit, newName)
    if unit_by_name[newName] then
        return false
    else
        if unit.name then
            unit_by_name[unit.name] = nil
        end
        unit.name = newName
        unit_by_name[newName] = unit
        return true
    end
end


-------------------------------------------------------------------------------
-- change name of group
-- returns false if rename is not possible (group with such name already exists)
function renameGroup(group, newName)
    if group_by_name[newName] then
        return false
    else
        group_by_name[group.name] = nil
        group.name = newName
        group_by_name[newName] = group
        return true
    end
end

-------------------------------------------------------------------------------
--
local function getMapObjectAngle(classKey, heading)  
  local rotation = 0;  
  local classInfo = MapWindow.getClassifierObject(classKey);

  if classInfo and classInfo.rotatable and 
      (OptionsData.getDifficulty('iconsTheme') == 'russian') then 
    
    rotation = MapWindow.headingToAngle(heading or 0)
  end;
  
  return rotation
end

-------------------------------------------------------------------------------
--
function insert_bullseye(a_coal, a_x, a_y)
	--print("insert_bullseye", a_coal, a_x, a_y)
	if ((not mission.bullseye[a_coal].mapObjects) or (not mission.bullseye[a_coal].mapObjects[1])) then
		local cls = me_db.getClassKey("Bullseye")
		currentKey = currentKey + 1;
		local classKey = cls
		local id = currentKey
		local x = a_x
		local y = a_y
		local object = MapWindow.createDOT(classKey, id, x, y, angle, color)
				
		object.currColor = coalitionColors[a_coal].color  ---mission.coalition[a_coal].color
		object.subclass = 'bullseye'
		object.userObject = mission.bullseye[a_coal]
		object.userObject.selectGroupColor = coalitionColors[a_coal].selectGroupColor
		object.userObject.color = coalitionColors[a_coal].color
		object.userObject.coalition = a_coal

		set_mapObjects(object.id, object) 

		--U.traverseTable(mission.bullseye)
		table.insert(mission.bullseye[a_coal].mapObjects, object)
	end
end

local function setAircraftArgs(picModel,unitDef,folded)
	if not picModel then 
		return
	end
	local t = unitDef.attribute
	if	t and t[1] == base.wsType_Air then 
		if t[2] == base.wsType_Helicopter then
			--rotor args update 
			picModel:setArgument(36,-1)
			picModel:setArgument(40,-1)
			picModel:setArgument(41,-1)

			for i =326,331 do
				picModel:setArgument(i,-1)
			end
		end
		
		if unitDef.mechanimations and unitDef.mechanimations.FoldableWings
			and unitDef.mechanimations.FoldableWings
			and unitDef.mechanimations.FoldableWings[1]
			and unitDef.mechanimations.FoldableWings[1].Sequence 
			and unitDef.mechanimations.FoldableWings[1].Sequence[1] 
			and unitDef.mechanimations.FoldableWings[1].Sequence[1].C then
			
			for k,v in base.pairs(unitDef.mechanimations.FoldableWings[1].Sequence[1].C) do
				picModel:setArgument(v[2], folded) 
			end			
		else
			picModel:setArgument(8, folded)  -- FOLDED_WING			
		end
	end
end

function updateTopdownViewArguments(a_unit)
	local unitDef = me_db.unit_by_type[a_unit.type]
	local folded = 0
	if a_unit.boss.route and a_unit.boss.route.points and a_unit.boss.route.points[1] 
		and a_unit.boss.route.points[1].linkUnit and 'table' == base.type(a_unit.boss.route.points[1].linkUnit) then
		local linkUnit = unit_by_id[a_unit.boss.route.points[1].linkUnit.unitId]	
		if linkUnit and linkUnit.boss.type == 'ship' then 
			folded = 1
		end	
	end	
	setAircraftArgs(a_unit.boss.mapObjects.units[a_unit.index].picModel,unitDef,folded)
end

function addPicModel(group, unit, object, unitDef)
	if unitDef.topdown_view_model ~= false and (base.MapWindow.isShowHidden(group) == true) and object.picModel == nil and MeSettings.getShowModels() == true then
		local shape = U.getShape(unitDef)			
		if base.test_topdown_view_models == true and shape then
			local x = 0
			local y = 0

			x = unit.x
			y = unit.y
	
			object.picModel = MapWindow.addSceneObjectWithModel(shape, x, 0, y, group)
			if object.picModel then
				object.picModel:setOrientationEuler(MapWindow.headingToAngle(unit.heading or 0), 0, 0)	
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Вставляет условный знак юнита на карту.
function insert_unit_symbol(unit)
	--print('insert_unit_symbol')
	local group = unit.boss  
	local unitDef = me_db.unit_by_type[unit.type]
	base.assert(unitDef,unit.type.."!unit_by_type[]")
	local cls = me_db.getClassKeyByType(unit.type)
	if not cls then
		print('No class key for "'..unitDef.Name..'"')
		-- значек здания
		cls = "P0091000076"
	end 
	currentKey = currentKey + 1;
  
	local classKey = cls
	local id = currentKey
	local x
	local y
  
	if not group.x then
		group.x = group.route.points[1].x
		group.y = group.route.points[1].y 
	end  
  
	x = unit.x
	y = unit.y

	local angle = getMapObjectAngle(classKey, unit.heading)
	local color = nil
	
	local object = MapWindow.createDOT(classKey, id, x, y, angle, color)
	object.currColor = group.color
	object.heading = 0
	object.userObject = unit -- Обратная связь с прикладным объектом для восстановления цвета
	object.subclass = 'unit'
  
	mapObjects[object.id] = object
  
	addPicModel(group, unit, object, unitDef)

	table.insert(group.mapObjects.units, unit.index, object)
  
	updateTopdownViewArguments(unit)	

	if group.type == 'ship' or group.type == 'vehicle' then
		createUnitZones(unit);
	end
 
	-- У последующих символов юнитов нужно пересчитать координаты
	for i = unit.index + 1, #group.units do
		group.units[i].index = i
	end
  
	-- После создании миссии символы юнитов еще не все созданы,
	-- поэтому для них - отдельный цикл.
	for i = unit.index, #group.mapObjects.units do
        group.mapObjects.units[i].x = group.units[i].x
        group.mapObjects.units[i].y = group.units[i].y
	end
  
    if 'Heliport' == unitDef.category or 'Warehouse'== unitDef.category or ('GrassAirfield' == unitDef.category) then
        addWarehouse(group.units[1].unitId, group.boss.boss.name) 
    end
	
	if group.type == 'ship' then 
		local ship = me_db.ship_by_type[unit.type]
		if me_db.isCarrier(ship) then
			addWarehouse(unit.unitId, group.boss.boss.name)
		end		
	end
end

-------------------------------------------------------------------------------
-- Удаляет юнит из группы и с карты.
function remove_unit(unit)
	local group = unit.boss;
	remove_unit_symbol(unit)
	delWarehouse(unit.unitId)
  
	if unit.linkChildren then
		local toUnlink = { }
		for _tmp, v in pairs(unit.linkChildren) do
			table.insert(toUnlink, v)
			v.type = panel_route.actions.turningPoint
		end
		for _tmp, v in pairs(toUnlink) do
			unlinkWaypoint(v)
		end                
	end 	

	unlinkAllRequiredUnits(unit)
	
	if unit.linkChildrenTZone then
		for i = #unit.linkChildrenTZone,1 , -1 do
			local zoneId = unit.linkChildrenTZone[i]
			unlinkTriggerZone(zoneId) 	
		end			            
	end 
	
	table.remove(group.units, unit.index)
	unit_by_name[unit.name] = nil 
	unit_by_id[unit.unitId] = nil 
	-- У последующих юнитов и символов нужно пересчитать индексы, координаты,
	-- а также зоны обнаружения/досягаемости.

	for i=unit.index,#group.units do
		group.units[i].index = i
	end
	
	base.panel_units_list.update()
end

-------------------------------------------------------------------------------
-- Удаляет условный знак юнита с карты.
function remove_unit_symbol(unit)
	local mapObjects = unit.boss.mapObjects
	mapObjects.units[unit.index].picModel = MapWindow.removeSceneObject(mapObjects.units[unit.index].picModel)
	set_mapObjects(mapObjects.units[unit.index].id, nil)
	local t = {};
	table.insert(t, table.remove(mapObjects.units, unit.index));
	removeUnitZones(unit)
	MapWindow.removeUserObjects(t);
end

-------------------------------------------------------------------------------
-- Удаляет все юниты из группы и с карты.
function remove_all_units(group)
  local toRemove = {}
  for i=1,#group.units do
    local unit = remove_unit_symbol(group.units[i])
    table.insert(toRemove, unit)
    unit_by_name[unit.name] = nil
  end
  group.units = {}
  MapWindow.removeUserObjects(toRemove) 
end

-------------------------------------------------------------------------------
-- Вставляет новую точку маршрута в группу и на карту.
-- Параметр index задает порядковый номер вставляемой точки в массиве маршрута.
function insert_waypoint(group, index, type, x, y, alt, speed, name, a_formation_template)
	local height = U.getAltitude(x, y)
	if group.type == 'plane' or group.type == 'helicopter' then
		height = math.max(height, alt) 
    end
  
    local depth
    if group.type == 'ship' then
		if panel_route.isSubmarineInGroup(group) and group.route.points[index - 1] then
			depth = group.route.points[index - 1].depth
			local  h_surface , depth_in_point = Terrain.GetSurfaceHeightWithSeabed(x,y) 
			if depth > depth_in_point then
				depth = depth_in_point
			end
		else
			depth = 0
		end
    end
  
	local alt_type = panel_route.alt_types_all.BARO.type
	if group.route.points[index - 1] then
		alt_type = group.route.points[index - 1].alt_type
    
		if (alt_type == panel_route.alt_types_all.RADIO.type) then
			height = group.route.points[index - 1].alt
		end
	end
	local speed_locked = false
	local ETA_locked = false
	if index == 1 then
		speed_locked = true
		ETA = 0.0
		ETA_locked = true
	else
		speed_locked = true
	end  
	local wpt =
	{
		boss = group,
		index = index,
		type = type,
		x = x,
		y = y,
		depth = depth,
		alt = height,
		alt_type = alt_type,
		speed = speed,
		speed_locked = speed_locked,
		ETA = ETA,
		ETA_locked = ETA_locked,
		targets = {},
		formation_template = '',
	}
  
	wpt.name = name

	if (a_formation_template) then
		wpt.formation_template = a_formation_template    
	end

	table.insert(group.route.points, index, wpt)
  
	if group.type == 'vehicle' then
		local pp = group.route.points[index-1]
		if pp then
			local s = {{x=pp.x,y=pp.y},{x=wpt.x,y=wpt.y}}
			table.insert(group.route.spans, index-1, s)
			if index < #group.route.points then
				local np = group.route.points[index+1]
				local ns = {{x=wpt.x,y=wpt.y},{x=np.x,y=np.y}}
				group.route.spans[index] = ns
			else
				-- Последний перегон - вырожденный.
				local ns = {{x=wpt.x,y=wpt.y},{x=wpt.x,y=wpt.y}}
				group.route.spans[index] = ns
			end
		end
	end

	local symbol = create_waypoint_symbol(wpt)
	table.insert(group.mapObjects.route.points, wpt.index, symbol)
	local text = create_waypoint_text(wpt)
	table.insert(group.mapObjects.route.numbers, wpt.index, text)
	if wpt.index == 1 and group.type ~= 'static' then
		local textFirst = create_waypoint_textFirst(wpt)
		group.mapObjects.route.numberFirst = textFirst
	end
	--  целевые зоны 
	table.insert(group.mapObjects.route.targets, wpt.index, {})
	table.insert(group.mapObjects.route.targetLines, wpt.index, {})
	table.insert(group.mapObjects.route.targetNumbers, wpt.index, {})
	table.insert(group.mapObjects.route.targetZones, wpt.index, {})
  
	-- У последующих точек маршрута индексы пересчитываются.
	for i=wpt.index+1,#group.route.points do
		local wpnt = group.route.points[i];
		wpnt.index = i
		-- for j,target in ipairs(wpnt.targets or {}) do 
			-- target.index = i;
		-- end    
	end
  
  --build_route_line(group)
  
	for i=wpt.index+1,#group.mapObjects.route.numbers do
		local name = base.tostring(i-1)
		name = reNameWaypoints(name, i, #group.route.points, group.boss.name)
		if group.route.points[i].name then
		  name = name..':'..group.route.points[i].name
		end
		group.mapObjects.route.numbers[i].title = name
	end 
  
	panel_summary.update()
	updateHeading(group)

	return wpt
end

-------------------------------------------------------------------------------
--
function insert_INUFixPoint(group, x, y, color)
  group.INUFixPoints = group.INUFixPoints or {};
  local INUFixPoint =
  {
    boss = group,
    x = x,
    y = y,
    index = index,
    color = color,
  }
  table.insert(group.INUFixPoints, INUFixPoint)
  local symbol = create_INUFixPoint_symbol(INUFixPoint)
  symbol.currColor = group.boss.boss.selectWaypointColor;
  group.mapObjects.INUFixPoints = group.mapObjects.INUFixPoints or {};
  for i,object in ipairs(group.mapObjects.INUFixPoints) do 
    object.currColor = group.boss.boss.selectGroupColor;
  end
  table.insert(group.mapObjects.INUFixPoints, symbol)
  INUFixPoint.symbol = symbol;

  group.mapObjects.INUFixPoints_numbers = group.mapObjects.INUFixPoints_numbers or {}; 
  INUFixPoint.index = #group.INUFixPoints or 1;
  local text = create_INUFixPoint_text(INUFixPoint)
  text.currColor = group.boss.boss.selectWaypointColor;
  for i,object in ipairs(group.mapObjects.INUFixPoints_numbers) do 
    object.currColor = group.boss.boss.selectGroupColor;
  end
  table.insert(group.mapObjects.INUFixPoints_numbers, text)
  INUFixPoint.text = text;
  return INUFixPoint
end

-------------------------------------------------------------------------------
--
function insert_NavTargetPoint(group, x, y, color, a_comment)
  group.NavTargetPoints = group.NavTargetPoints or {};
  local NavTargetPoint =
  {
    boss = group,
    x = x,
    y = y,
    index = index,
    color = color,
    text_comment = a_comment,
  }
  table.insert(group.NavTargetPoints, NavTargetPoint)
  local symbol = create_NavTargetPoint_symbol(NavTargetPoint)
  symbol.currColor = group.boss.boss.color;
  group.mapObjects.NavTargetPoints = group.mapObjects.NavTargetPoints or {};
  for i,object in ipairs(group.mapObjects.NavTargetPoints) do 
    object.currColor = group.boss.boss.color;
  end
  table.insert(group.mapObjects.NavTargetPoints, symbol)
  NavTargetPoint.symbol = symbol;

  group.mapObjects.NavTargetPoints_numbers = group.mapObjects.NavTargetPoints_numbers or {}; 
  NavTargetPoint.index = #group.NavTargetPoints or 1;
  local text = create_NavTargetPoint_text(NavTargetPoint)
  text.currColor = group.boss.boss.selectWaypointColor;
  for i,object in ipairs(group.mapObjects.NavTargetPoints_numbers) do 
    object.currColor = group.boss.boss.color;
  end
  table.insert(group.mapObjects.NavTargetPoints_numbers, text)
  NavTargetPoint.text = text;
  
    group.mapObjects.NavTargetPoints_comments = group.mapObjects.NavTargetPoints_comments or {}; 
    local comment = create_NavTargetPoint_Comment(NavTargetPoint)
    NavTargetPoint.comment = comment
    table.insert(group.mapObjects.NavTargetPoints_comments, comment)
        
  return NavTargetPoint
end

-------------------------------------------------------------------------------
--
function insert_DataCartridgePoint(unit, x, y)
	local dataCartridgePoint = panel_dataCartridge.insertPoint(unit, x, y)
	local symbol = create_DataCartridgePoint_symbol(dataCartridgePoint)
  
	dataCartridgePoint.symbol = symbol
	panel_dataCartridge.updatePointsSymbols()
        
	return dataCartridgePoint
end


-------------------------------------------------------------------------------
--Устанавливает свойства для графической точки маршрута
function set_waypoint_map_object(wpt)
	local group = wpt.boss
	if group.mapObjects == nil then
		return
	end
	local obj = group.mapObjects.route.numbers[wpt.index]
	local title = base.tostring(wpt.index-1)
	title = reNameWaypoints(title, wpt.index, #group.route.points, group.boss.name)

	if wpt.name and wpt.name ~= "" then
		title = title..':'..wpt.name
	end  
	local showSpeedAndTime = false
	if showSpeedAndTime then
		title = title..', V'
		if not wpt.speed_locked then
			title = title..'est'
		end
		title = title..'='..math.floor(wpt.speed * 3.6 + 0.5)
		title = title..', ETA'
		if not wpt.ETA_locked then
			title = title..'est'
		end
		local dd, hh, mm, ss = U.timeToDHMS(wpt.ETA - mission.start_time)	
		title = title..'='..hh..':'..mm..':'..ss..'/'..dd
	end  
	obj.title = title
  
    for i=1,#group.route.points do
        group.route.points[i].index = i
        local name = base.tostring(i-1)
        name = reNameWaypoints(name, i, #group.route.points, group.boss.name)
        if group.route.points[i].name and group.route.points[i].name ~= "" then
            name = name..':'..group.route.points[i].name
        end
        group.mapObjects.route.numbers[i].title = name
    end
   
    if base.MapWindow.isShowHidden(group) == true then
		MapWindow.removeUserObjects({obj})
		MapWindow.addUserObjects({obj})
	end
end

--[[
-- Присваивает имя точке маршрута. 
function set_waypoint_name(wpt, name)
  local group = wpt.boss
  local nm = name
  wpt.name = nm
  local obj = group.mapObjects.route.numbers[wpt.index]
  local title = base.tostring(wpt.index)
  if nm then
    title = title..':'..nm
  end 
  obj.title = title
  for j,u in pairs(obj.semantics) do
    if u.code == 9 then
      u.value = title
      break
    end
  end
  MapWindow.getView():removeUserObjects({obj})
  MapWindow.getView():addUserObjects({obj})
  MapWindow.getView():updateUserList(true)
end
--]]

-------------------------------------------------------------------------------
-- Присваивает имя цели.
function set_target_name(target, name)
	if target.name then
		target_by_name[target.name] = nil
	end
	local wpt = target.boss
	local group = wpt.boss
	local nm = check_target_name(name)
	target.name = nm
	local obj = group.mapObjects.route.targetNumbers[wpt.index][target.index]
	obj.title = nm or ''
	if base.MapWindow.isShowHidden(target.boss.boss) == true then
		MapWindow.removeUserObjects({obj})
		MapWindow.addUserObjects({obj})
	end 
end

-------------------------------------------------------------------------------
--Поиск пути между двумя точками
function FindOptimalPath(a_typeRoad, x1, y1, x2, y2)
    if (x1 == nil) or (y1 == nil) or (x2 == nil) or (y2 == nil) then
		--showWarningMessageBox(_('Optimal path not found.'))
        base.print("ME WARNING: Not valid coordinats in FindOptimalPath ",x1, y1, x2, y2)
        return
	end

    local path
    if Terrain.findPathOnRoads then
        path = Terrain.findPathOnRoads(a_typeRoad, x1, y1, x2, y2)
    elseif a_typeRoad == "roads" then
        path = Terrain.FindOptimalPath(x1, y1, x2, y2)
    end

	if (path == nil) then
		--showWarningMessageBox(_('Optimal path not found.'))
        base.print("ME WARNING: Optimal path not found. ",a_typeRoad, x1, y1, x2, y2)
	end
  
	return path
end

-------------------------------------------------------------------------------
-- Ставит заданную точку маршрута на ближайшую дорогу.
function move_waypoint_to_road(wpt, a_typeRoad)
	-- print('----------------------------------------')
	--print('move_waypoint_to_road')
	--print('Terrain.getClosestPointOnRoads. wpt.x, wpt.y:', a_typeRoad, wpt.x, wpt.y)
	local x, y 
	if Terrain.getClosestPointOnRoads then
		x, y = Terrain.getClosestPointOnRoads(a_typeRoad, wpt.x, wpt.y)
	elseif a_typeRoad == "roads" then
		x, y = Terrain.FindNearestPoint(wpt.x, wpt.y, 40000.0)
	end
	--print(' ---x,y--:', x, y)

	if x then
		MapWindow.move_waypoint(wpt.boss, wpt.index, x, y)
	end
  
	local points = wpt.boss.route.points
	if wpt.index > 1 and points[wpt.index-1].type.action == 'On Road' then
		local path = FindOptimalPath('roads', points[wpt.index-1].x, points[wpt.index-1].y, x, y)
		if path and #path > 0 then
			wpt.boss.mapObjects.route.line.points[wpt.index-1] = path
			local s = {}
			for i=1,#path do
				table.insert(s, {x=path[i].x, y=path[i].y})
			end
			wpt.boss.route.spans[wpt.index-1] = s
		end
	end
  
	if wpt.index < #points and points[wpt.index+1].type.action == 'On Road' then
		local path = FindOptimalPath('roads', x, y, points[wpt.index+1].x, points[wpt.index+1].y)
		if path and #path > 0 then
			wpt.boss.mapObjects.route.line.points[wpt.index] = path
			local s = {}
			for i=1,#path do
				table.insert(s, {x=path[i].x, y=path[i].y})
			end
			wpt.boss.route.spans[wpt.index] = s
		end
	end
  
	if wpt.index > 1 and points[wpt.index-1].type.action == 'On Railroads' then
		local path = FindOptimalPath('railroads', points[wpt.index-1].x, points[wpt.index-1].y, x, y)
		if path and #path > 0 then
			wpt.boss.mapObjects.route.line.points[wpt.index-1] = path
			local s = {}
			for i=1,#path do
				table.insert(s, {x=path[i].x, y=path[i].y})
			end
			wpt.boss.route.spans[wpt.index-1] = s
		end
	end
  
	if wpt.index < #points and points[wpt.index+1].type.action == 'On Railroads' then
		local path = FindOptimalPath('railroads', x, y, points[wpt.index+1].x, points[wpt.index+1].y)
		if path and #path > 0 then
			wpt.boss.mapObjects.route.line.points[wpt.index] = path
			local s = {}
			for i=1,#path do
				table.insert(s, {x=path[i].x, y=path[i].y})
			end
			wpt.boss.route.spans[wpt.index] = s
		end
	end
  
	build_route_line(wpt.boss)
	if (base.MapWindow.isShowHidden(wpt.boss) == true) then
		MapWindow.removeUserObjects({wpt.boss.mapObjects.route.line})
		MapWindow.addUserObjects({wpt.boss.mapObjects.route.line})
	end
   
	updateHeading(wpt.boss)
	panel_summary.update()
end

-------------------------------------------------------------------------------
--
function move_unit_to_road(unit, a_typeRoad)
  --print('Terrain.FindNearestPoint. unit.x, unit.y:', unit.x, unit.y)
  local x, y 
  if Terrain.getClosestPointOnRoads then
    x, y = Terrain.getClosestPointOnRoads(a_typeRoad, unit.x, unit.y)
  elseif a_typeRoad == "roads" then
    x, y = Terrain.FindNearestPoint(unit.x, unit.y, 40000.0)
  end
 -- print('Result.  x, y:',  x, y)
--  base.collectgarbage('collect')
  if x then
    MapWindow.move_unit(unit.boss, unit, x, y)
  end
end

-------------------------------------------------------------------------------
-- Делает заданную точку маршрута внедорожной.
function make_waypoint_offroad(wpt)
    if wpt.boss.type == 'vehicle' then
	    -- Нужно спрямить линию маршрута к соседним точкам
	    local points = wpt.boss.route.points
      
	    if wpt.index > 1 then
			local p = points[wpt.index-1]
			wpt.boss.route.spans[wpt.index-1] = {{x=p.x, y=p.y}, {x=wpt.x, y=wpt.y}}
			
			build_route_line(wpt.boss)  
			
			-- wpt.boss.mapObjects.route.line.points[wpt.index-1] = {{x=p.x, y=p.y}, {x=wpt.x, y=wpt.y}}
			if (base.MapWindow.isShowHidden(wpt.boss) == true) then
				MapWindow.removeUserObjects({wpt.boss.mapObjects.route.line})
				MapWindow.addUserObjects({wpt.boss.mapObjects.route.line})	
			end
	    end
      
	    if wpt.index < #points then
			local p = points[wpt.index+1]
			wpt.boss.route.spans[wpt.index] = {{x=wpt.x, y=wpt.y}, {x=p.x, y=p.y}}
			
			build_route_line(wpt.boss)  
			
			--wpt.boss.mapObjects.route.line.points[wpt.index] = {{x=wpt.x, y=wpt.y}, {x=p.x, y=p.y}}
			if (base.MapWindow.isShowHidden(wpt.boss) == true) then
				MapWindow.removeUserObjects({wpt.boss.mapObjects.route.line})
				MapWindow.addUserObjects({wpt.boss.mapObjects.route.line})
			end	
	    end
	end
  
	calc_route_length(wpt.boss)
	panel_summary.update()
end


-------------------------------------------------------------------------------
-- rebuild road route
function updateRoadRouteSegment(group, index)
    local wpt = group.route.points[index]
    if ('On Road' == wpt.type.action) then
        move_waypoint_to_road(wpt,'roads');
    end
    if ('On Railroads' == wpt.type.action) then
        move_waypoint_to_road(wpt,'railroads');
    end
end

-------------------------------------------------------------------------------
-- Удаляет заданную точку маршрута.
function remove_waypoint(group, index)
  local wpt = group.route.points[index]
  if wpt.linkUnit then
    unlinkWaypoint(wpt)
  end
  unlinkSnap(wpt)
  local toRemove = {}
  table.insert(toRemove, group.mapObjects.route.line)
  if wpt.targets then
      while wpt.targets and (0 < #wpt.targets) do
          remove_target(wpt.targets[1], true)
      end
  end
   
  onWptTasksRemove(group, wpt)
  onTasksRemoveFromOtherGroupsForWpt(group, wpt)

  local ws = remove_waypoint_symbol(wpt)
  table.insert(toRemove, ws)
  local wt = remove_waypoint_text(wpt)
  table.insert(toRemove, wt)
  if group.route.spans then
    local spans = group.route.spans
    if index < #spans then
        local spanBefore = spans[index - 1]
        local pointBefore = spanBefore[#spanBefore]
        local pointAfter = spans[index + 1][1]
        pointBefore.x = pointAfter.x
        pointBefore.y = pointAfter.y
    end
    table.remove(spans, index)
  end

  table.remove(group.route.points, index)
  table.remove(group.mapObjects.route.targets, index)
  table.remove(group.mapObjects.route.targetLines, index)
  table.remove(group.mapObjects.route.targetNumbers, index)
  table.remove(group.mapObjects.route.targetZones, index)
  
  -- У всех точек маршрута индексы пересчитываются.
  --    group.mapObjects.route.targets[wptIdx]
  
  for i=1,#group.route.points do
    group.route.points[i].index = i
    local name = base.tostring(i-1)
    name = reNameWaypoints(name, i, #group.route.points, group.boss.name)
    if group.route.points[i].name then
        name = name..':'..group.route.points[i].name
    end
    group.mapObjects.route.numbers[i].title = name
  end
  
  build_route_line(group)

    if (index < 0) or (index > #group.route.points) then
        index = #group.route.points;
    end;
	
    panel_route.setWaypoint(group.route.points[index])        
    group.mapObjects.route.points[index].currColor = group.boss.boss.selectWaypointColor
    group.mapObjects.route.numbers[index].currColor = group.boss.boss.selectWaypointColor
    group.mapObjects.route.line.currColor = group.boss.boss.selectGroupColor
  
  MapWindow.removeUserObjects(toRemove) 
  update_group_map_objects(group)

  if 1 < index then
      updateRoadRouteSegment(group, index - 1)
  end
  if #group.route.points >= index then
      updateRoadRouteSegment(group, index)
  end

  calc_route_length(group)
  panel_summary.update()
  updateHeading(group)
  panel_vehicle.groupUnitsTransportCheck(true)
end

-------------------------------------------------------------------------------
--
function remove_INUFixPoint_All(group)
    if (group.INUFixPoints) then
        local tmpIndex = {}
        for k,v in pairs(group.INUFixPoints) do
            table.insert(tmpIndex,v.index)
        end
        
        for i = #tmpIndex, 1, -1 do  
            remove_INUFixPoint(group, i)
        end
    end
end

-------------------------------------------------------------------------------
--
function remove_INUFixPoint(group, index)
  local pt = group.INUFixPoints[index];
  local toRemove = {}
  local ws = remove_INUFixPoint_symbol(pt)
  table.insert(toRemove, ws)
  local wt = remove_INUFixPoint_text(pt)
  table.insert(toRemove, wt)
  table.remove(group.INUFixPoints, index)
  -- У всех точек маршрута индексы пересчитываются.
  for i=1,#group.INUFixPoints do
    group.INUFixPoints[i].index = i
   --- local name = base.tostring(i-1)
   -- name = reNameWaypoints(name, index, #group.route.points, group.boss.name)
   -- group.mapObjects.INUFixPoints_numbers[i].title = name
    group.mapObjects.INUFixPoints_numbers[i].title = base.tostring(i)
  end

  base.panel_nav_target_fix_points.vdata.selectedPointIFP = nil
  base.panel_nav_target_fix_points.update()
  MapWindow.removeUserObjects(toRemove) 
  update_group_map_objects(group)

end


-------------------------------------------------------------------------------
--
function remove_NavTargetPoint_All(group)
    if (group.NavTargetPoints) then
        local tmpIndex = {}
        for k,v in pairs(group.NavTargetPoints) do
            table.insert(tmpIndex,v.index)
        end
        
        for i = #tmpIndex, 1, -1 do  
            remove_NavTargetPoint(group, i)
        end
    end
end

-------------------------------------------------------------------------------
--
function remove_NavTargetPoint(group, index)
	local pt = group.NavTargetPoints[index];
  	
	local toRemove = {}
	if (pt.boss.mapObjects ~= nil) then
		local ws = remove_NavTargetPoint_symbol(pt)
		table.insert(toRemove, ws)
		local wt = remove_NavTargetPoint_text(pt)
		table.insert(toRemove, wt)
		local wc = remove_NavTargetPoint_comment(pt)
		table.insert(toRemove, wc)
	end
  
	table.remove(group.NavTargetPoints, index)
	-- У всех точек маршрута индексы пересчитываются.
	for i=1,#group.NavTargetPoints do
		group.NavTargetPoints[i].index = i
		group.mapObjects.NavTargetPoints_numbers[i].title = base.tostring(i)
	end

	base.panel_nav_target_fix_points.vdata.selectedPointNTP = nil
	base.panel_nav_target_fix_points.update()
	MapWindow.removeUserObjects(toRemove) 
	update_group_map_objects(group)
end

-------------------------------------------------------------------------------
-- Удяляет соответствующий точке маршрута перегон в линии маршрута на карте.
-- Параметр wpt - это уже созданная точка маршрута в текущей миссии.
function remove_route_line_point(wpt)
  local points = wpt.boss.mapObjects.route.line.points
  if wpt.index == #points then
    -- Если точка последняя, то предыдущий сегмент делается вырожденным.
    local x = points[wpt.index-1][1].x
    local y = points[wpt.index-1][1].y
    points[wpt.index-1] = {{x=x,y=y},{x=x,y=y}}
  else
    -- Начальная точка предыдущего сегмента связывается с начальной точкой последующего.
    local x1 = points[wpt.index-1][1].x
    local y1 = points[wpt.index-1][1].y
    local x2 = points[wpt.index+1][1].x
    local y2 = points[wpt.index+1][1].y
    points[wpt.index-1] = {{x=x1,y=y1},{x=x2,y=y2}}
  end
  -- Удаляется текущий сегмент
  table.remove(points, wpt.index)
end

-------------------------------------------------------------------------------
-- Создает условный знак точки маршрута на карте.
-- Параметр wpt - это уже созданная точка маршрута в текущей миссии.
function create_waypoint_symbol(wpt)
  local group = wpt.boss
  
  currentKey = currentKey + 1
 
  local id = currentKey
  local classKey
  local angle = 0
  
  if 1 == wpt.index then
      local u = me_db.unit_by_type[group.units[1].type]
      base.assert(u, group.units[1].type.."!unit_by_type[]")
      classKey = me_db.getClassKeyByType(group.units[1].type)  -- первая точка маршрута      
      angle = getMapObjectAngle(classKey, group.units[1].heading)
  else
      classKey = "P0091000041"  -- Промежуточная точка маршрута
  end
  
  local color = nil
  local object = MapWindow.createDOT(classKey, id, wpt.x, wpt.y, angle, color)
  
  object.waypoint = true
  object.currColor = group.color
  object.userObject = wpt
  
  set_mapObjects(object.id, object)
  
  return object 
end

function create_flightPoint_symbol(wpt)
  currentKey = currentKey + 1

  local id = currentKey
  local classKey = "FlightPointIcon"  
  local angle = 0
  local r, g, b, a = UC.parseColorString(wpt.boss.color)
  local color = {r, g, b, a}
  local object = MapWindow.createDOT(classKey, id, wpt.x, wpt.y, angle, color)
  
  object.userObject = wpt
  
  set_mapObjects(object.id, object)
  
  return object 
end

-------------------------------------------------------------------------------
--
function create_INUFixPoint_symbol(pt)
  local group = pt.boss
  currentKey = currentKey+1
  
  local id = currentKey
  local classKey = "P0091000206"
  local angle = nil
  local color = nil
  --print('INUpoint', currentKey, pt.lat, pt.long)
  local object = MapWindow.createDOT(classKey, id, pt.x, pt.y, angle, color)
  
  object.objectcurrColor = group.color
  object.userObject = pt
  object.currColor = group.color

  set_mapObjects(object.id, object)
  
  return object 
end

-------------------------------------------------------------------------------
--
function create_NavTargetPoint_symbol(pt)
  local group = pt.boss
  currentKey = currentKey+1
  
  local id = currentKey
  local classKey = "P0091001206"
  local angle = nil
  local color = nil
  --print('INUpoint', currentKey, pt.lat, pt.long)
  local object = MapWindow.createDOT(classKey, id, pt.x, pt.y, angle, color)
  
  object.objectcurrColor = group.color
  object.userObject = pt
  object.currColor = group.color

  set_mapObjects(object.id, object)
  
  return object 
end

function create_DataCartridgeLines()
	local object = {}
	
	 --линии для трех Sequence
   -- "Sequence 1 Blue"
	currentKey = currentKey + 1
    
    local classKey = "RouteLine"
    local id = currentKey
    local color = nil
    local points = {}
    local mapLine = MapWindow.createLIN(classKey, id, points, color)
	object.Sequence1 = {}

    -- копируем все поля из mapLine в line
    for k, v in pairs(mapLine) do
      object.Sequence1[k] = v
    end
  --  object.Sequence1.currColor = group.color    
    set_mapObjects(object.Sequence1.id, object.Sequence1)
  
  -- "Sequence 2 Red"
  currentKey = currentKey + 1
    
    local classKey = "RouteLine"
    local id = currentKey
    local color = nil
    local points = {}
    local mapLine = MapWindow.createLIN(classKey, id, points, color)
	object.Sequence2 = {}

    -- копируем все поля из mapLine в line
    for k, v in pairs(mapLine) do
      object.Sequence2[k] = v
    end
 --   object.Sequence2.currColor = group.color    
    set_mapObjects(object.Sequence2.id, object.Sequence2)
	
  --"Sequence 3 Yellow"
  currentKey = currentKey + 1
    
    local classKey = "RouteLine"
    local id = currentKey
    local color = nil
    local points = {}
    local mapLine = MapWindow.createLIN(classKey, id, points, color)
	object.Sequence3 = {}

    -- копируем все поля из mapLine в line
    for k, v in pairs(mapLine) do
      object.Sequence3[k] = v
    end
--    object.Sequence3.currColor = group.color    
    set_mapObjects(object.Sequence3.id, object.Sequence3)
	
	return object
end
-------------------------------------------------------------------------------
--
function create_DataCartridgePoint_symbol(pt)
  local group = pt.boss
  currentKey = currentKey+1
  
  local id = currentKey
  local classKey = "POINTDATACARTRIDGE_ROUND"
  local angle = nil
  local color =	nil

  local object = {}
  object.iconObj = MapWindow.createDOT(classKey, id, pt.x, pt.y, angle, color)
  object.iconObj.userObject = pt
  
  object.objectcurrColor = group.color
  object.userObject = pt
  object.currColor = group.color

  set_mapObjects(object.iconObj.id, object.iconObj)
  
  -- имя точки
  currentKey = currentKey+1
  local tx, ty = MapWindow.getMapSize(10, 10)
  local classKey = "T0000000524"
  local id = currentKey
  local x = pt.x - 2*tx
  local y = pt.y + ty
  local title = pt.name
  local color =	 {1, 1, 1, 1}
  local angle = 0
  
  object.textObj = MapWindow.createTIT(classKey, id, x, y, title, color, angle)
  object.textObj.userObject = pt

  set_mapObjects(object.textObj.id, object.textObj)
  
  -- номер точки
  currentKey = currentKey+1
  local tx, ty = MapWindow.getMapSize(10, 10)
  local classKey = "T0000000524"
  local id = currentKey
  local x = pt.x + tx
  local y = pt.y + ty
  local title = pt.index
  local color =	 {1, 1, 1, 1}
  local angle = 0
  
  object.numberObj = MapWindow.createTIT(classKey, id, x, y, title, color, angle)
  object.numberObj.userObject = pt

  set_mapObjects(object.numberObj.id, object.numberObj)
  
  return object 
end

-------------------------------------------------------------------------------
-- Удаляет условный знак заданной точки маршрута с карты.
function remove_waypoint_symbol(wpt)
  set_mapObjects(wpt.boss.mapObjects.route.points[wpt.index].id, nil)
  return table.remove(wpt.boss.mapObjects.route.points, wpt.index)
end

-------------------------------------------------------------------------------
--
function remove_INUFixPoint_symbol(pt)
  set_mapObjects(pt.boss.mapObjects.INUFixPoints[pt.index].id, nil)
  return table.remove(pt.boss.mapObjects.INUFixPoints, pt.index)
end

-------------------------------------------------------------------------------
--
function remove_NavTargetPoint_symbol(pt)
  set_mapObjects(pt.boss.mapObjects.NavTargetPoints[pt.index].id, nil)
  return table.remove(pt.boss.mapObjects.NavTargetPoints, pt.index)
end


-------------------------------------------------------------------------------
-- Удаляет условный знак заданной цели с карты.
function remove_target_symbol(target)
    local wpt = target.boss;
    local targets = target.boss.boss.mapObjects.route.targets[wpt.index]
    local o = targets[target.index]
    if o then
        set_mapObjects(o.id, nil)
    end
    return table.remove(targets, target.index)
end

-------------------------------------------------------------------------------
-- Удаляет линию к заданной цели с карты.
function remove_target_line(target)
    local wpt = target.boss;
    local lines = target.boss.boss.mapObjects.route.targetLines[wpt.index]
    local line = lines[target.index];
    if line then
        set_mapObjects(line.id, nil)
        return table.remove(lines, target.index)
    end
    return nil
end

-------------------------------------------------------------------------------
-- Удаляет подпись к заданной цели с карты.
function remove_target_text(target)
    local wpt = target.boss;
    local targetNumbers = target.boss.boss.mapObjects.route.targetNumbers[wpt.index];
    local targetNumber = targetNumbers[target.index]; 
    if targetNumber then    
        set_mapObjects(targetNumber.id, nil)
        return table.remove(targetNumbers, target.index)
    end
    return nil
end

-------------------------------------------------------------------------------
-- Удаляет зону вокруг заданной цели с карты.
function remove_target_zone(target)
    local wpt = target.boss;
    local zones = target.boss.boss.mapObjects.route.targetZones[wpt.index];
    local zone = zones[target.index];
	if zone then
		set_mapObjects(zone.id, nil);
		base.table.remove(zones,target.index)
		return zone
	end
    return nil
end

-------------------------------------------------------------------------------
-- Создает подпись к заданной точке маршрута на карте.
-- Параметр wpt - это уже созданная точка маршрута в текущей миссии.
function create_waypoint_text(wpt)
  local scale = MapWindow.getScale()
  local coeff = scale/100000
  local group = wpt.boss
  local name = base.tostring(wpt.index-1)
  
  name = reNameWaypoints(name, wpt.index, #group.route.points, group.boss.name)
  
  if wpt.name and wpt.name ~= "" then
    name = name..':'..wpt.name
  end
  
  currentKey = currentKey+1

  local tx, ty = MapWindow.getMapSize(10, -10)
  local classKey = "T0000000524"
  local id = currentKey
  local x = wpt.x + tx
  local y = wpt.y + ty
  local title = name
  local color = nil
  local angle = 0
  
  local text = MapWindow.createTIT(classKey, id, x, y, title, color, angle)
  
  text.currColor = group.color
  text.userObject = wpt  -- Обратная связь с прикладным объектом для восстановления цвета  
  
  mapObjects[text.id] = text
  
  return text
end

-------------------------------------------------------------------------------
--
function create_waypoint_textFirst(wpt)
	local scale = MapWindow.getScale()
	local coeff = scale/100000
	local group = wpt.boss
	local name = "1"

	currentKey = currentKey+1

	local tx, ty = MapWindow.getMapSize(25, 5)
	local classKey = "T0000000524"
	local id = currentKey
	local x = wpt.x - tx
	local y = wpt.y - ty
	local title = name
	local color = nil
	local angle = 0

	local text = MapWindow.createTIT(classKey, id, x, y, title, color, angle)

	text.currColor = {1,1,1}

	mapObjects[text.id] = text

	return text
end

-------------------------------------------------------------------------------
--
function create_INUFixPoint_text(pt)
  local group = pt.boss
  local name = base.tostring(pt.index)
  if pt.name then
    name = name..':'..pt.name
  end
  
  currentKey = currentKey+1  
  
  if (pt.x == nil) and (pt.y == nil) and (pt.lat ~= nil) and (pt.long ~=nil) then
    pt.x, pt.y = MapWindow.convertLatLonToMeters(pt.lat, pt.long)
  end
  
  local tx, ty = MapWindow.getMapSize(10, -10)
  local classKey = "T0000000524"
  local id = currentKey
  local x = pt.x + tx
  local y = pt.y + ty
  local title = name
  local color = nil
  local angle = 0
  
  local text = MapWindow.createTIT(classKey, id, x, y, title, color, angle)
  
  text.currColor = group.color
  text.userObject = pt  -- Обратная связь с прикладным объектом для восстановления цвета  

  set_mapObjects(text.id, text)
  
  return text
end

-------------------------------------------------------------------------------
--
function create_NavTargetPoint_text(pt)
  local group = pt.boss
  local name = base.tostring(pt.index)
  if pt.name then
    name = name..':'..pt.name
  end
  
  currentKey = currentKey+1  
  
  if (pt.x == nil) and (pt.y == nil) and (pt.lat ~= nil) and (pt.long ~=nil) then
    pt.x, pt.y = MapWindow.convertLatLonToMeters(pt.lat, pt.long)
  end
  
  local tx, ty = MapWindow.getMapSize(10, -10)
  local classKey = "T0000000524"
  local id = currentKey
  local x = pt.x + tx
  local y = pt.y + ty
  local title = name
  local color = nil
  local angle = 0
  
  local text = MapWindow.createTIT(classKey, id, x, y, title, color, angle)
  
  text.currColor = group.color
  text.userObject = pt  -- Обратная связь с прикладным объектом для восстановления цвета  

  set_mapObjects(text.id, text)
  
  return text
end

-------------------------------------------------------------------------------
--
function create_NavTargetPoint_Comment(pt)

  local group = pt.boss
  
  currentKey = currentKey+1  
  
  if (pt.x == nil) and (pt.y == nil) and (pt.lat ~= nil) and (pt.long ~=nil) then
    pt.x, pt.y = MapWindow.convertLatLonToMeters(pt.lat, pt.long)
  end

  local tx, ty = MapWindow.getMapSize(10, 20)
  tx = -tx
  local classKey = "T0000000524"
  local id = currentKey
  local x = pt.x + tx
  local y = pt.y + ty
  local title = pt.text_comment
  local color = nil
  local angle = 0
  
  local text = MapWindow.createTIT(classKey, id, x, y, title, color, angle)
  
  text.currColor = group.color
  text.userObject = pt  -- Обратная связь с прикладным объектом для восстановления цвета  

  set_mapObjects(text.id, text)
  pt.mapObjects={}
  pt.mapObjects.comment = text
  
  return text
end

-------------------------------------------------------------------------------
-- Удаляет подпись к заданной точке маршрута с карты.
function remove_waypoint_text(wpt)
  set_mapObjects(wpt.boss.mapObjects.route.numbers[wpt.index].id, nil)
  return table.remove(wpt.boss.mapObjects.route.numbers, wpt.index)
end

-------------------------------------------------------------------------------
--
function remove_INUFixPoint_text(pt)
  set_mapObjects(pt.boss.mapObjects.INUFixPoints_numbers[pt.index].id, nil)
  return table.remove(pt.boss.mapObjects.INUFixPoints_numbers, pt.index)
end

-------------------------------------------------------------------------------
--
function remove_NavTargetPoint_text(pt)
  set_mapObjects(pt.boss.mapObjects.NavTargetPoints_numbers[pt.index].id, nil)
  return table.remove(pt.boss.mapObjects.NavTargetPoints_numbers, pt.index)
end

-------------------------------------------------------------------------------
--
function remove_NavTargetPoint_comment(pt)
  set_mapObjects(pt.boss.mapObjects.NavTargetPoints_comments[pt.index].id, nil)
  return table.remove(pt.boss.mapObjects.NavTargetPoints_comments, pt.index)
end

-------------------------------------------------------------------------------
-- Вставляет новую цель в маршруте группы и на карте.
function insert_target(wpt, index, x, y, radius, name)
  local group = wpt.boss
  local target = {
    boss = wpt,
    index = index,
    name = name,
    x = x,
    y = y,
    radius = radius,    -- радиус зоны воздействия в метрах
    categories = {},  -- список категорий объектов поражения
  }
  wpt.targets = wpt.targets or {}
  table.insert(wpt.targets, index, target)
  if not group.mapObjects.route.targets then
    group.mapObjects.route.targets = {}
  end 
  if not group.mapObjects.route.targets[wpt.index] then
    group.mapObjects.route.targets[wpt.index] = {}
    group.mapObjects.route.targetLines[wpt.index] = {}
    group.mapObjects.route.targetNumbers[wpt.index] = {}
    group.mapObjects.route.targetZones[wpt.index] = {}
  end
  create_target_zone(target)
  local line = create_target_line(target)
  table.insert(group.mapObjects.route.targetLines[wpt.index], target.index, line)
  local symbol = create_target_symbol(target)
  table.insert(group.mapObjects.route.targets[wpt.index], target.index, symbol)
  local text = create_target_text(target)
  table.insert(group.mapObjects.route.targetNumbers[wpt.index], target.index, text)
  -- У последующих целей индексы пересчитываются. 
  for i=target.index+1,#wpt.targets do
    wpt.targets[i].index = i
  end
  return target
end

-------------------------------------------------------------------------------
-- Удаляет заданную цель из группы и с карты.
function remove_target(target, doNotUpdateMap)
	-- Удаляются точка, номер, линия и зона цели с карты.
	if target.name then
		target_by_name[target.name] = nil
	end
	local toRemove = {}
	local ts = remove_target_symbol(target)
	if ts then
		table.insert(toRemove, ts)
	end
	local tt = remove_target_text(target)
	if tt then
		table.insert(toRemove, tt)
	end  
	local tz = remove_target_zone(target)
	if tz then
		table.insert(toRemove, tz)
	end
	local tl = remove_target_line(target)
	if tl then
		table.insert(toRemove, tl)
	end
	MapWindow.removeUserObjects(toRemove)
	-- Цель удаляется из списка целей точки маршрута.
	table.remove(target.boss.targets, target.index)
	
	-- Корректируются индексы оставшихся целей.
	for i=target.index,#target.boss.targets do
		target.boss.targets[i].index = i  
	end
    
    -- local route = group.mapObjects.route;
    -- route.targets[wptIdx][target.index].currColor = waypointColor
    -- route.targetLines[wptIdx][target.index].currColor = waypointColor
    -- route.targetNumbers[wptIdx][target.index].currColor = waypointColor

	-- Обновляются на карте объекты оставшихся целей.
	local numbers = target.boss.boss.mapObjects.route.targetNumbers[target.boss.index]
	if numbers then
		for i=target.index,#numbers do
			numbers[i].title = base.tostring(i) 
		end
	end
	if not doNotUpdateMap and (base.MapWindow.isShowHidden(target.boss.boss) == true) then
		MapWindow.removeUserObjects(numbers)
		MapWindow.addUserObjects(numbers)
	end
end

-------------------------------------------------------------------------------
-- Создает на карте линию 
function create_line(a_startPoint, a_endPoint, color)
  currentKey = currentKey + 1
  
  local classKey = 'L0091000301'
  local id = currentKey
  local points = {a_startPoint, a_endPoint}
  local object = MapWindow.createLIN(classKey, id, points, color)
  
  object.currColor = color

  set_mapObjects(object.id, object)
  
  return object
end

-------------------------------------------------------------------------------
-- Создает на карте линию от точки маршрута к цели.
function create_target_line(target)

  local wpt = target.boss
  local group = wpt.boss
  currentKey = currentKey + 1
  
  local classKey = 'L0091000301'
  local id = currentKey
  local points = {MapWindow.createPoint(wpt.x, wpt.y), MapWindow.createPoint(target.x, target.y)}
  local color = nil
  local object = MapWindow.createLIN(classKey, id, points, color)
  
  object.currColor = group.color
  object.userObject = target

  set_mapObjects(object.id, object)
  
  return object
end

function createMapBounds(x1,y1,x2,y2)
	local classKey = 'RouteLine'
	
	currentKey = currentKey + 1
	
  local points = {MapWindow.createPoint(x1, y1), MapWindow.createPoint(x1, y2), MapWindow.createPoint(x2, y2), MapWindow.createPoint(x2, y1), MapWindow.createPoint(x1, y1),
		MapWindow.createPoint(x2, y2), MapWindow.createPoint(x1, y2), MapWindow.createPoint(x2, y1)}
  local color = {1,0,1,1}
  local object = MapWindow.createLIN(classKey, currentKey, points, color)
  object.currColor = {1,0,1,1}
  set_mapObjects(object.id, object)
  MapWindow.addUserObjects({object})
end

-------------------------------------------------------------------------------
-- Создает условный знак цели на карте.
function create_target_symbol(target)
  local wpt = target.boss
  local group = wpt.boss
  
  currentKey = currentKey+1
  
  local classKey = "P0091000044"  -- Цель основная
  local id = currentKey
  local x
  local y
  
  if target.linkObject then
    x = target.linkObject.x
    y = target.linkObject.y
  else
    x = target.x
    y = target.y
  end
  
  local angle = 0
  local color = nil
  
  
  local object = MapWindow.createDOT(classKey, id, x, y, angle, color)
  
  object.currColor = group.color 
  object.userObject = target 
  
  set_mapObjects(object.id, object)
  
  return object 
end

-------------------------------------------------------------------------------
-- Создает подпись к цели на карте.
function create_target_text(target)
  local scale = MapWindow.getScale()
  local coeff = scale/100000
  local wpt = target.boss
  local group = wpt.boss
  
  currentKey = currentKey+1  
  
  local classKey = "T0000000524"
  local id = currentKey
  
  -- TODO: приделать смещение текста
  local tx, ty = MapWindow.getMapSize(10, -10)
  local x = target.x + tx
  local y = target.y + ty
  
  local title = target.name or ''
 
  local color = nil
  local angle = 0
  local text = MapWindow.createTIT(classKey, id, x, y, title, color, angle)
 
  text.currColor = group.color
  text.userObject = target -- Обратная связь с прикладным объектом для восстановления цвета  

  set_mapObjects(text.id, text)
  
  return text
end

-------------------------------------------------------------------------------
-- Создает линию маршрута на карте.
function build_route_line(group)
	if (group.mapObjects == nil) or (group.mapObjects.route == nil) then
		return
	end
  
  local line = group.mapObjects.route.line  
  
  -- если линия еще не добавлялась в карту
  if not line.addedToMap then   
    currentKey = currentKey + 1
    
    local classKey = "RouteLine"
    local id = currentKey
    local color = nil
    local points = {}
    local mapLine = MapWindow.createLIN(classKey, id, points, color)

    -- копируем все поля из mapLine в line
    for k, v in pairs(mapLine) do
      line[k] = v
    end
    
    line.addedToMap = true

    line["currColor"] = group.color 
    line["userObject"] = group.route  -- Обратная связь с прикладным объектом для восстановления цвета
        
    set_mapObjects(line.id, line)
  end
  
  -- каждые две точки описывают отрезок
  line.points = {} 
  
  -- TODO: проверить правильность рисования пути
  if group.route.spans and #group.route.spans > 0 then
    for i = 1, #group.route.spans - 1 do
      local span = group.route.spans[i]

      if span then
        for j = 1,#span - 1 do
          local p1 = span[j]
          local p2 = span[j + 1]

          table.insert(line.points, p1)
          table.insert(line.points, p2)
        end 
      end
    end
  else  
    for i = 1, #group.route.points - 1 do
      local wpt = group.route.points[i]
      local wptn = group.route.points[i + 1]
      
      table.insert(line.points, wpt)
      table.insert(line.points, wptn)
    end
  end
  
  calc_route_length(group)
end

-------------------------------------------------------------------------------
--
function calc_route_length(group)
  local dist = 0
  local len = {}
  if group.route.spans and #group.route.spans > 0 and group.route.spans[1][1].x then
    for i=1,#group.route.spans do
		len[i] = 0
		local span = group.route.spans[i]
		if (span ~= nil) then
		    for j=1,#span do
		    	if j < #span then
			    local d = MapWindow.getDistance(span[j], span[j+1])			  
			    len[i] = len[i] + d
			    dist = dist + d
			  end
		    end 
		end
    end
  else  
    for i=1,#group.route.points do
      len[i] = 0
      local wpt = group.route.points[i]
      if i < #group.route.points then
        local wptn = group.route.points[i+1]
        local d = MapWindow.getDistance(wpt, wptn)
        len[i] = d
        dist = dist + d
      end
    end
  end
  
  group.route.dist = dist
  group.route.len = len
  calc_route_range(group)
  
  if panel_summary.group == group then
    panel_summary.update()
  end
end

-------------------------------------------------------------------------------
--
function calc_route_range(group)
	if group and group.route and group.route.points then
		local p1 = group.route.points[1]
		local p2 = group.route.points[#group.route.points]
		local range = (p2.x-p1.x)*(p2.x-p1.x)+(p2.y-p1.y)*(p2.y-p1.y)

		group.route.range = math.sqrt(range)
	end
end

-------------------------------------------------------------------------------
-- Данная функция вызывается для каждой группы после чтения файла миссии,
-- чтобы добавить картографические объекты и служебные поля.
function create_group_objects(group)
--print("!!!!!!!!!!!create_group_objects(group)",group)
    if group.route then
        group.route.boss = group
        if group.route.points and #group.route.points and group.route.points[1] then
            for i=1,#group.route.points do
                local wpt = group.route.points[i]
                wpt.boss = group
                wpt.index = i
                --      insert_route_line_point(wpt)
                if wpt.targets then
                    local targets = wpt.targets
                    for j=1,#targets do
                        local target = targets[j]
                        if target.name then
                            target_by_name[target.name] = target
                        end
                        target.boss = wpt
                        target.index = j
                    end
					--[[
					if #targets > 0 then
						wpt.actions = {}
						for j=1,#targets do
							local target = targets[j]
							local attackTargetsInZone = {
								actionType = 'EnrouteTask',
								action = 'AttackTargetsInZone',
								params = {
									lat = target.lat,
									long = target.long,
									radius = target.radius
									targetTypeFlags = {
										
									}
								}
							}
							
						end
					end
					--]]
                end     
            end
            panel_summary.update()
        end
        for i=1,#group.units do
            local unit = group.units[i]
            if unit.name then
                unit_by_name[unit.name] = unit
            end
            unit.boss = group
            unit.index = i
        end
    else
        local unit = group.units[1]
        if unit.name then
            unit_by_name[unit.name] = unit
        end
        unit.boss = group
        unit.index = 1
    end
end

function create_flightPlans_objects(fp)
	fp.mapObjects 			= fp.mapObjects or {}
	fp.mapObjects.points 	= fp.mapObjects.points or {}
	fp.mapObjects.line 		= fp.mapObjects.line or {}
	
	for k,v in base.pairs(fp.points) do
		v.boss = fp
		local symbol = create_flightPoint_symbol(v)		
		base.table.insert(fp.mapObjects.points, symbol)		
	end
	build_fp_route_line(fp)
	update_flightPlan_map_objects(fp)
end

-------------------------------------------------------------------------------
--
function create_group_map_objects(group, noUpdateHeading)
	-- print('create_group_map_objects',group.name, group.route);
	group.mapObjects = {units = {}, zones = {},}

	if group.route then
		group.mapObjects.route = {line = {}, points = {}, numbers = {}, targets = {}, targetLines = {}, targetNumbers = {}, targetZones = {},}
		if group.route.points and #group.route.points and group.route.points[1] then
		  for i=1,#group.route.points do
			local wpt = group.route.points[i]
			local symbol = create_waypoint_symbol(wpt)
			table.insert(group.mapObjects.route.points, wpt.index, symbol)
			local text = create_waypoint_text(wpt)
			table.insert(group.mapObjects.route.numbers, wpt.index, text)
			if wpt.index == 1 and group.type ~= 'static' then			
				local textFirst = create_waypoint_textFirst(wpt)
				group.mapObjects.route.numberFirst = textFirst
			end
			if wpt.targets and (#wpt.targets > 0) then
			  local targets = wpt.targets
			  for j=1,#targets do
				local target = targets[j]
				if not group.mapObjects.route.targets[i] then
				  group.mapObjects.route.targets[i] = {}
				  group.mapObjects.route.targetLines[i] = {}
				  group.mapObjects.route.targetNumbers[i] = {}
				  group.mapObjects.route.targetZones[i] = {}
				end

				create_target_zone(target)

				local line = create_target_line(target)
				table.insert(group.mapObjects.route.targetLines[i], target.index, line)
				local symbol = create_target_symbol(target)
				table.insert(group.mapObjects.route.targets[i], target.index, symbol)
				local text = create_target_text(target)
				table.insert(group.mapObjects.route.targetNumbers[i], target.index, text)
			  end
			else
			  group.mapObjects.route.targets[wpt.index] = {}
			  group.mapObjects.route.targetLines[wpt.index] = {}
			  group.mapObjects.route.targetNumbers[wpt.index] = {}
			  group.mapObjects.route.targetZones[wpt.index] = {}        
			end
		  end
		  build_route_line(group)
		  panel_summary.update()
		end
		for i=1,#group.units do
		  local unit = group.units[i]
		  insert_unit_symbol(unit)
		end
    else 
		local unit = group.units[1]
		insert_unit_symbol(unit) 		
    end
  
	if group.INUFixPoints then
		group.mapObjects.INUFixPoints = {};
		for i = 1, #group.INUFixPoints do
			local INUFixPoint = group.INUFixPoints[i];
			local symbol = create_INUFixPoint_symbol(INUFixPoint)        
			INUFixPoint.symbol = symbol;
			table.insert(group.mapObjects.INUFixPoints, symbol)

			group.mapObjects.INUFixPoints_numbers = group.mapObjects.INUFixPoints_numbers or {}; 
			INUFixPoint.index = i;
			local text = create_INUFixPoint_text(INUFixPoint)
			INUFixPoint.text = text;
			table.insert(group.mapObjects.INUFixPoints_numbers, text)
		end
	end
  
	if group.NavTargetPoints then
		group.mapObjects.NavTargetPoints = {}
		for i = 1, #group.NavTargetPoints do
			local NavTargetPoint = group.NavTargetPoints[i]
			local symbol = create_NavTargetPoint_symbol(NavTargetPoint)        
			NavTargetPoint.symbol = symbol
			table.insert(group.mapObjects.NavTargetPoints, symbol)

			group.mapObjects.NavTargetPoints_numbers = group.mapObjects.NavTargetPoints_numbers or {}
			NavTargetPoint.index = i
			local text = create_NavTargetPoint_text(NavTargetPoint)
			NavTargetPoint.text = text
			table.insert(group.mapObjects.NavTargetPoints_numbers, text)
			
			group.mapObjects.NavTargetPoints_comments = group.mapObjects.NavTargetPoints_comments or {}
			local comment = create_NavTargetPoint_Comment(NavTargetPoint)
			NavTargetPoint.comment = comment
			table.insert(group.mapObjects.NavTargetPoints_comments, comment)
		end
	end
	
	for k,v in base.pairs(group.units) do
		if v.dataCartridge and v.dataCartridge.Points then
			for kk, vv in base.pairs(v.dataCartridge.Points) do
				vv.symbol = create_DataCartridgePoint_symbol(vv)
			end
		end
	end
	

	if noUpdateHeading ~= true then
		updateHeading(group)
	end 	
	update_group_map_objects(group)        
end


-------------------------------------------------------------------------------
-- Функция вызывается при смене масштаба карты, чтобы сохранить
-- расположение условных знаков - юнитов и подписей - относительно точек маршрута.
function scale_mission_map_objects(scale)
  local objects = {}
  for i,v in pairs(mission.coalition) do
    for j,u in pairs(v.country) do
      if u.plane then
        for k,w in pairs(u.plane.group) do
          scale_group_map_objects(w, scale, objects)
        end
      end
      if u.helicopter then
        for k,w in pairs(u.helicopter.group) do
          scale_group_map_objects(w, scale, objects)
        end
      end
      if u.ship then
        for k,w in pairs(u.ship.group) do
          scale_group_map_objects(w, scale, objects)
        end
      end
      if u.vehicle then
        for k,w in pairs(u.vehicle.group) do
          scale_group_map_objects(w, scale, objects)
        end
      end
    end
  end
    
	MapWindow.removeUserObjects(objects)
	MapWindow.addUserObjects(objects) 
end

-------------------------------------------------------------------------------
-- Функция масштабирует взаимное расположение связанных объектов карты в группе -
-- юнитов и подписей к точкам маршрута и целям.
function scale_group_map_objects(group, scale, objects)
	--[[if base.isPlannerMission() then
		local unit = getPlayerUnit()
		local groupPlayer = nil
		if unit then		
			groupPlayer = unit.boss
		end
		
		if groupPlayer == nil or groupPlayer ~= group then -- в планировщике только группа игрока
			return
		end
	end]]
	
	if (base.MapWindow.isShowHidden(group) == false) or (group.hiddenOnPlanner == true and  base.isPlannerMission() == true) then
		return
	end

  local units = group.mapObjects.units
  
  -- Юниты в первой точке маршрута
  for i=2,#units do -- просматриваем все юниты начиная со второго,т.к. первый - точка маршрута со значком юнита
 --  local r = false; -- признак наличия зоны
 --   local unit = group.units[i];
 --  local udb = me_db.unit_by_type[unit.type]
 --   base.assert(udb, unit.type .. "!unit_by_type[]")
 --   if (udb.DetectionRange and (udb.DetectionRange > 0)) 
 --     or (udb.ThreatRange and (udb.ThreatRange > 0))
 --     or (udb.ThreatRangeMin and (udb.ThreatRangeMin > 0))
 --	  then
 --     r = true;  -- какая-то зона есть
 --   end
    
      table.insert(objects, units[i])
  end
  
  if group.mapObjects.route then
    local nums = group.mapObjects.route.numbers
    
    for i=1,#nums do
      local num = nums[i]
      local wpt = group.route.points[i]
      local tx, ty = MapWindow.getMapSize(10, -10)      
      
      -- Подпись к точке маршрута
      -- TODO: приделать смещение к тексту
      num.x = wpt.x + tx
      num.y = wpt.y + ty

      table.insert(objects, num)
      
      local targets = wpt.targets
      
      if targets and (group == MapWindow.selectedGroup)then
        local tnums = group.mapObjects.route.targetNumbers[i]
        
        if tnums then
          for j=1,#tnums do
            local tnum = tnums[j]
            local target = targets[j]
            local tx, ty = MapWindow.getMapSize(10, -10)
            
            -- Подпись к цели
            -- TODO: приделать смещение к тексту
            tnum.x = target.x + tx
            tnum.y = target.y + ty
            
            table.insert(objects, tnum)
          end
        end
      end
    end
	
	if group.mapObjects.route.numberFirst then
		local tx, ty = MapWindow.getMapSize(25, 5)
		group.mapObjects.route.numberFirst.x = group.route.points[1].x - tx
		group.mapObjects.route.numberFirst.y = group.route.points[1].y - ty
		table.insert(objects, group.mapObjects.route.numberFirst)
	end
  end
  
  if group.mapObjects.INUFixPoints_numbers and (group == MapWindow.selectedGroup) then
    local nums = group.mapObjects.INUFixPoints_numbers
    for i=1,#nums do
      local num = nums[i]
      local pt = num.userObject;
      local tx, ty = MapWindow.getMapSize(10, -10)
      -- Подпись к точке маршрута
      -- TODO: приделать смещение к тексту
      num.x = pt.x + tx
      num.y = pt.y + ty
      table.insert(objects, num)
    end
  end
  
  if group.mapObjects.NavTargetPoints_numbers and (group == MapWindow.selectedGroup) then
    local nums = group.mapObjects.NavTargetPoints_numbers
    for i=1,#nums do
      local num = nums[i]
      local pt = num.userObject;
      local tx, ty = MapWindow.getMapSize(10, -10)
      -- Подпись к точке маршрута
      -- TODO: приделать смещение к тексту
      num.x = pt.x + tx
      num.y = pt.y + ty
      table.insert(objects, num)
    end
  end
  
  if group.mapObjects.NavTargetPoints_comments and (group == MapWindow.selectedGroup) then
    local nums = group.mapObjects.NavTargetPoints_comments
    for i=1,#nums do
      local num = nums[i]
      local pt = num.userObject;
      local tx, ty = MapWindow.getMapSize(10, 20)
      tx = -tx
      -- Подпись к точке маршрута
      -- TODO: приделать смещение к тексту
      num.x = pt.x + tx
      num.y = pt.y + ty
      table.insert(objects, num)
    end
  end
  
	if (group == MapWindow.selectedGroup) then
		for k,unit in base.pairs(group.units) do
			if unit.dataCartridge and unit.dataCartridge.Points then 
				for k,pt in base.pairs(unit.dataCartridge.Points) do
					local tx, ty = MapWindow.getMapSize(10, 10)
					pt.symbol.textObj.x = pt.x - 2*tx
					pt.symbol.textObj.y = pt.y + ty
					table.insert(objects, pt.symbol.textObj)
					
					pt.symbol.numberObj.x = pt.x + tx
					pt.symbol.numberObj.y = pt.y + ty
					table.insert(objects, pt.symbol.numberObj)
				end
			end	
		end
	 end
end


function remove_dataCartridge_map_objects(group)
	local toRemove = {}
	if 'plane' == group.type then
		for k,unit in base.pairs(group.units) do
			if unit.dataCartridge and unit.dataCartridge.Points then 
				local pointsSymbolsIcons = {}
				local pointsSymbolsText = {}
				local pointsSymbolsNumbers = {}
				for k,point in base.pairs(unit.dataCartridge.Points) do
					if point.symbol then
						table.insert(pointsSymbolsIcons,point.symbol.iconObj)
						table.insert(pointsSymbolsText,point.symbol.textObj)
						table.insert(pointsSymbolsNumbers,point.symbol.numberObj)
					end
				end	
				addAll(toRemove, pointsSymbolsIcons)
				addAll(toRemove, pointsSymbolsText)
				addAll(toRemove, pointsSymbolsNumbers)
			end	
		end
	end
	MapWindow.removeUserObjects(toRemove)
end


-------------------------------------------------------------------------------
-- Данная функция должна вызываться перед удалением группы из миссии,
-- чтобы объекты группы исчезли с карты.
function remove_group_map_objects(group)
  -- Сначала удаляем объекты группы с карты.
	local objects = {}
	for i,v in pairs(group.mapObjects.units) do
		--print('removing from map',v.userObject.name)
		table.insert(objects, v)

		if group.mapObjects.units[i].picModel then
			group.mapObjects.units[i].picModel = MapWindow.removeSceneObject(group.mapObjects.units[i].picModel)
		end
	end
	
	remove_dataCartridge_map_objects(group)

  if (group.mapObjects.callsign) then
    table.insert(objects, group.mapObjects.callsign[1])
  end
  
  if (group.mapObjects.comment) then
    table.insert(objects, group.mapObjects.comment[1])
  end
	
  -- удаляем группы только с карты, не удаляем их из миссии
  --group.mapObjects.units = {}
  if group.mapObjects.route then
    table.insert(objects, group.mapObjects.route.line)
    for i,v in pairs(group.mapObjects.route.points) do
      table.insert(objects, v)
    end
    for i,v in pairs(group.mapObjects.route.numbers) do
      table.insert(objects, v)
    end
	
	table.insert(objects, group.mapObjects.route.numberFirst)
	
    for i,v in pairs(group.mapObjects.route.targets) do
      for j,u in pairs(v) do
--        print(u.key)
        table.insert(objects, u)
      end
    end
    for i,v in pairs(group.mapObjects.route.targetLines) do
      for j,u in pairs(v) do
--        print(u.key)
        table.insert(objects, u)
      end
    end
    for i,v in pairs(group.mapObjects.route.targetNumbers) do
      for j,u in pairs(v) do
--        print(u.key)
        table.insert(objects, u)
      end
    end
    for i,v in pairs(group.mapObjects.route.targetZones) do
      for j,u in pairs(v) do
--        print(u.key)
        table.insert(objects, u)
      end
    end
  -- удаляем группы только с карты, не удаляем их из миссии
    --group.mapObjects.route = {line = {}, points = {}, numbers = {}, targets = {}, targetLines = {}, targetNumbers = {}, targetZones = {},}
  end
	if (group.units) then
		for i,unit in pairs(group.units) do
		  removeUnitZones(unit);
		end
	end
  if group.mapObjects.INUFixPoints then
    for i,v in pairs(group.mapObjects.INUFixPoints) do
        table.insert(objects, v)
    end;
  end;
  if group.mapObjects.INUFixPoints_numbers then
    for i,v in pairs(group.mapObjects.INUFixPoints_numbers) do
        table.insert(objects, v)
    end;
  end;
  if group.mapObjects.NavTargetPoints then
    for i,v in pairs(group.mapObjects.NavTargetPoints) do
        table.insert(objects, v)
    end;
  end;
  if group.mapObjects.NavTargetPoints_numbers then
    for i,v in pairs(group.mapObjects.NavTargetPoints_numbers) do
        table.insert(objects, v)
    end;
  end;
  if group.mapObjects.NavTargetPoints_comments then
    for i,v in pairs(group.mapObjects.NavTargetPoints_comments) do
        table.insert(objects, v)
    end;
  end;
  MapWindow.removeUserObjects(objects)
end


-------------------------------------------------------------------------------
-- append all objects from objects array to target array
function addAll(target, objects, skipFirst)
    if objects then
        for _tmp,v in pairs(objects) do
            if not skipFirst then
                table.insert(target, v)
            else
                skipFirst = false
            end
        end
    end
end

-------------------------------------------------------------------------------
-- append all objects from arrays in objects array to target array
function addAll2(target, objects)
    if objects then
        for _tmp,v in pairs(objects) do
            addAll(target, v)
        end
    end
end

-------------------------------------------------------------------------------
--
function update_bullseye_map_objects()
	local toRemove = {}
    local toCreate = {};
	
	addAll(toRemove, mission.bullseye.red.mapObjects)
    addAll(toCreate, mission.bullseye.red.mapObjects)
		
	addAll(toRemove, mission.bullseye.blue.mapObjects)
    addAll(toCreate, mission.bullseye.blue.mapObjects)
	
	addAll(toRemove, mission.bullseye.neutrals.mapObjects)
	addAll(toCreate, mission.bullseye.neutrals.mapObjects)
	
	MapWindow.removeUserObjects(toRemove)
    MapWindow.addUserObjects(toCreate)
end

-------------------------------------------------------------------------------
--
function update_map_object(a_obj)
	local toRemove = {}
    local toCreate = {};

	addAll(toRemove, a_obj)
    addAll(toCreate, a_obj)

	MapWindow.removeUserObjects(toRemove)
    MapWindow.addUserObjects(toCreate)
end


-------------------------------------------------------------------------------
-- Данная функция должна вызываться после изменений состава, структуры, расположения или вида 
-- картографических объектов группы, чтобы эти изменения отобразились на карте.
function update_group_map_objects(group) 
    -- группа скрыта, нечего обновлять
	if group and group.boss then
		if (base.MapWindow.isShowHidden(group) == false) or group_by_id[group.groupId] == nil  then 
			return
		end
	end
	
    local scale = MapWindow.getScale()
    local toRemove = {}
    local toCreate = {}
	
    if group.mapObjects and group.mapObjects.route and ('static' ~= group.type) then
        if group.mapObjects.route.line then
            table.insert(toRemove, group.mapObjects.route.line)
            table.insert(toCreate, group.mapObjects.route.line)
        end
        addAll(toRemove, group.mapObjects.route.points)
        addAll(toRemove, group.mapObjects.route.numbers)
		addAll(toRemove, {group.mapObjects.route.numberFirst})		
        addAll(toCreate, group.mapObjects.route.points)
        addAll(toCreate, group.mapObjects.route.numbers)	
		addAll(toCreate, {group.mapObjects.route.numberFirst})			
		
        if group.mapObjects.INUFixPoints then
            addAll(toRemove, group.mapObjects.INUFixPoints)
            addAll(toRemove, group.mapObjects.INUFixPoints_numbers)
            if group == MapWindow.selectedGroup then
                addAll(toCreate, group.mapObjects.INUFixPoints)
                addAll(toCreate, group.mapObjects.INUFixPoints_numbers)
            end;
        end;
        if group.mapObjects.NavTargetPoints then
            addAll(toRemove, group.mapObjects.NavTargetPoints)
            addAll(toRemove, group.mapObjects.NavTargetPoints_numbers)
            addAll(toRemove, group.mapObjects.NavTargetPoints_comments)
            if group == MapWindow.selectedGroup then
                addAll(toCreate, group.mapObjects.NavTargetPoints)
                addAll(toCreate, group.mapObjects.NavTargetPoints_numbers)
                addAll(toCreate, group.mapObjects.NavTargetPoints_comments)
            end;
        end;
		
		if 'plane' == group.type then
			for k,unit in base.pairs(group.units) do
				if unit.dataCartridge and unit.dataCartridge.Points then 
					local pointsSymbolsIcons = {}
					local pointsSymbolsText = {}
					local pointsSymbolsNumbers = {}
					for k,point in base.pairs(unit.dataCartridge.Points) do
						if point.symbol then
							table.insert(pointsSymbolsIcons,point.symbol.iconObj)
							table.insert(pointsSymbolsText,point.symbol.textObj)
							table.insert(pointsSymbolsNumbers,point.symbol.numberObj)
						end
					end	
					addAll(toRemove, pointsSymbolsIcons)
					addAll(toRemove, pointsSymbolsText)
					addAll(toRemove, pointsSymbolsNumbers)
					if panel_aircraft.window:isVisible() then
						local unitCur = panel_aircraft.getCurUnit()	
						if unit == unitCur then
							addAll(toCreate, pointsSymbolsIcons)
							addAll(toCreate, pointsSymbolsText)
							addAll(toCreate, pointsSymbolsNumbers)
						end
					end
					
				end	
			end
		end
		
        addAll(toRemove, group.mapObjects.zones)
        addAll(toCreate, group.mapObjects.zones)

        addAll2(toRemove, group.mapObjects.route.targetZones)
        addAll2(toRemove, group.mapObjects.route.targetLines)
        addAll2(toRemove, group.mapObjects.route.targets)
        addAll2(toRemove, group.mapObjects.route.targetNumbers)
        if group == MapWindow.selectedGroup then
            addAll2(toCreate, group.mapObjects.route.targetZones)
            addAll2(toCreate, group.mapObjects.route.targetLines)
            addAll2(toCreate, group.mapObjects.route.targets)
            addAll2(toCreate, group.mapObjects.route.targetNumbers)            
        end;
    end
    if 'static' == group.type then
        addAll(toRemove, group.mapObjects.units)
        addAll(toCreate, group.mapObjects.units)
        addAll(toRemove, group.mapObjects.route.points)
        addAll(toCreate, group.mapObjects.route.points)
	elseif 	'navpoint' == group.type then
		addAll(toRemove, group.mapObjects.units)
        addAll(toCreate, group.mapObjects.units)
		addAll(toRemove, group.mapObjects.callsign)
        addAll(toCreate, group.mapObjects.callsign)
		addAll(toRemove, group.mapObjects.comment)
        addAll(toCreate, group.mapObjects.comment)
    elseif 	'cyclone' == group.type then

    else
		if group.mapObjects and (group.mapObjects.units) then		
			for i = 2, #group.mapObjects.units do -- начинаем со второго юнита т.к. вместо первого        
												  --рисуем первую точку траектории со значком юнита               
				local unitSymbol = group.mapObjects.units[i] -- юнит
				table.insert(toRemove, unitSymbol); 
			--	local hasZone = false; -- есть ли у юнита зона (ПВО, радар)
			--	local unit = unitSymbol.userObject; 
			--	local udb = me_db.unit_by_type[unit.type] -- юнит из базы данных
			--	base.assert(udb, unit.type .. "!unit_by_type[]")
			--	if (udb.DetectionRange and (udb.DetectionRange > 0)) 
			--		or (udb.ThreatRange and (udb.ThreatRange > 0)) then
			--		hasZone = true; -- у юнита есть какая-то зона
			--	end
			--	if hasZone or 'ship' == group.type  then -- если есть зона или корабль, рисуем юнит всегда на любом масштабе
					table.insert(toCreate, unitSymbol);
			--	else -- зоны нет, рисуем в зав-ти от масштаба карты
			--		if UNITS_SCALE >= scale then
			--			table.insert(toCreate, unitSymbol);
						-- addAll(toRemove, group.mapObjects.units, true)
						-- addAll(toCreate, group.mapObjects.units, true)
			--		end;
			--	end;
			end
			if group.type ~= 'static' then
				for i,unit in ipairs(group.units) do 
					updateUnitZones(unit);
				end
			end
		end
    end
	
    build_route_line(group)

    MapWindow.removeUserObjects(toRemove)
    MapWindow.addUserObjects(toCreate)
end

function build_fp_route_line(a_flightPlan)
	if (a_flightPlan.mapObjects == nil) then
		return
	end
  
	local line = a_flightPlan.mapObjects.line  
  
	-- если линия еще не добавлялась в карту
	if not line.addedToMap then   
		currentKey = currentKey + 1

		local classKey = "RouteLine"
		local id = currentKey
		local r, g, b, a = UC.parseColorString(a_flightPlan.color)
		local color = {r, g, b, a}
		local points = {}
		local mapLine = MapWindow.createLIN(classKey, id, points, color)
			
		-- копируем все поля из mapLine в line
		for k, v in pairs(mapLine) do
		  line[k] = v
		end	
		
		line.addedToMap = true

		set_mapObjects(line.id, line)
	end
	
	line.points = {} 
	
	for i = 1, #a_flightPlan.points - 1 do
		local wpt = a_flightPlan.points[i]
		local wptn = a_flightPlan.points[i + 1]
	  
		table.insert(line.points, wpt)
		table.insert(line.points, wptn)
	end
end  
  
function update_flightPlan_map_objects(a_flightPlan) 
	local toRemove = {}
    local toCreate = {}
	
	if a_flightPlan.mapObjects and a_flightPlan.mapObjects.points then
        if a_flightPlan.mapObjects.line then
            table.insert(toRemove, a_flightPlan.mapObjects.line)
            table.insert(toCreate, a_flightPlan.mapObjects.line)
        end
        addAll(toRemove, a_flightPlan.mapObjects.points)
        addAll(toCreate, a_flightPlan.mapObjects.points)
	end
	
	MapWindow.removeUserObjects(toRemove)
	if a_flightPlan.hidden ~= true then
		MapWindow.addUserObjects(toCreate)
	end
end

function update_groups_colors() 
	for k,group in base.pairs(group_by_id) do
		group.color = group.boss.boss.color		
		update_group_map_objects(group)
	end
end


-------------------------------------------------------------------------------
-- run mission
function runMission(params, returnScreen) 
    local trackFile =  base.tempDataDir .. base.trackFileName;   

    if (params.command ~= '--prepare') then
		base.START_PARAMS.trackPath = trackFile
    end
	
	if (params.command == '--mission') or (params.command == '--training') then
		Analytics.report_mission_name(U.getAnalyticsMissionName(params.realMissionPath))
	end 
	
	base.START_PARAMS.DCM = base.isDCM
	base.START_PARAMS.missionPath = '"' .. params.file .. '"';
	base.START_PARAMS.returnScreen = returnScreen;
	base.START_PARAMS.realMissionPath = params.realMissionPath;
	base.START_PARAMS.command = params.command
--base.START_PARAMS.command = '--restart' --TEST
base.print("---base.START_PARAMS.DCM --",base.START_PARAMS.DCM )
   
   if params.mission ~= nil then
    base.START_PARAMS.realMissionPath = params.mission;
    --print('mission ->',params.mission);
   end;
  
   base.MISSION_PATH = file;
   
   base.print("---command=",base.START_PARAMS.command)
   base.print("---missionPath=",base.START_PARAMS.missionPath)
   base.print("---returnScreen=",base.START_PARAMS.returnScreen)
   base.print("---realMissionPath=",base.START_PARAMS.realMissionPath)
   base.print("---trackPath=",base.START_PARAMS.trackPath)
   
   Gui.doQuit();
end

-------------------------------------------------------------------------------
--
function copyMission(dest, source)
    --print('copying ' .. source .. ' to ' .. dest);
    if dest == source then
        return
    end
       
   local mission = base.assert(base.io.open(source, 'rb'))
    local data  = mission:read('*a')
   
    local file,err = base.io.open(dest, 'wb')
    if file then        
        file:write(data)
        file:close()
	else
		log.error('ERROR: copy mission failed: '..err)		
    end
    mission:close()
end;

function getTempMissionPath()
	return base.tempDataDir .. base.tempMissionName
end

function getMissionPathIsSaved()
	local missionPath = mission.path
	
	return missionPath and '' ~= missionPath and getTempMissionPath() ~= missionPath
end

-------------------------------------------------------------------------------
-- Run mission
-- zipFile - path to mission zip file
-- if backToMain equals to true main menu will be activated after debreifing
-- else mission editor will be opened
-- if return callback is not null, it will be called after debreifing exit
-- backToMain argument is ignored in such case
function play(params, returnScreen, a_missionPath, doNotApplyOptions, doSave, doApplyOnlyName)
--print("play params, returnScreen, a_missionPath, doNotApplyOptions, doSave",params.file, returnScreen, a_missionPath, doNotApplyOptions, doSave)
--print("---play---",isSignedMission(),isMissionModified())
    Debriefing.setReturnScreen(returnScreen)
    
    local destPath = getTempMissionPath()
    local missionPath = a_missionPath
    if returnScreen == 'training' then
        missionPath = params.file
    end;
    if (missionPath == '') or (missionPath == nil) then
        print('missionPath == nil or ""', params.file, returnScreen, destPath, mission.path);
    end;

    if (doSave == true) and ((isSignedMission() ~= true) or (isSignedMission() == true and isMissionModified() == true)) then
		print('save_mission')
		if save_mission_safe(destPath, true, true) == false then
			--showErrorMessageBox(cdata.play_mission_failed_msg, cdata.play_mission)

            return false
        end
	else
		print('copyMission')
		copyMission(destPath, missionPath);
	end
 
    if doNotApplyOptions ~= true or isSignedMission() == true then
        applyOptionsAndPlayerName(destPath)
    end;
    
    if doApplyOnlyName == true then
        applyPlayerName(destPath)
    end
	
	if returnScreen == 'training' or isSignedMission() == true then
		applySetGlobalFalse(destPath)
	end

    params.file = destPath;
    params.realMissionPath = missionPath;
    
    base.menubar.show(false)
    base.toolbar.show(false)
    base.statusbar.show(false)
    base.mapInfoPanel.show(false)
	base.setCoordPanel.show(false)
    base.panel_route.show(false)
            
    runMission(params, returnScreen)    
end


-------------------------------------------------------------------------------
--
function packMissionResources(miz)
    mod_dictionary.packMissionResources(miz)
end

-------------------------------------------------------------------------------
--
function clearTempFolder()
    local function eraseFolder(folder)
        for file in lfs.dir(folder) do
            local a = base.assert(lfs.attributes(folder .. file))
			local isFolderLink = (file == '.') or (file == '..')
			
            if (a.mode == 'directory') and  not isFolderLink then
                --print('erasing folder', folder .. file .. '/')
                eraseFolder(folder .. file .. '/')
			end
			
			if not isFolderLink then
				--print('erasing file', folder .. file)
				base.os.remove(folder .. file)
			end
        end
    end;
    
    eraseFolder(base.tempMissionPath)
	lfs.mkdir(base.tempMissionPath)
	
	local a, err =  lfs.attributes(base.tempDataDir .. "rts.txt")
	if a then
		base.os.remove(base.tempDataDir .. "rts.txt")
	end
end;

-------------------------------------------------------------------------------
--
function copyFileInMission(fileName)
    mod_dictionary.copyFileInMission(fileName)
end

-------------------------------------------------------------------------------
--соединение юнитов с WS.requiredUnits
function linkRequiredUnits(a_Consumer, a_Source)
	a_Consumer.linksSources = a_Consumer.linksSources or {}
	a_Source.linksConsumers = a_Source.linksConsumers or {}
	base.table.insert(a_Consumer.linksSources, a_Source.unitId)
	base.table.insert(a_Source.linksConsumers, a_Consumer.unitId)
end


-------------------------------------------------------------------------------
--разъединение всех юнитов с WS.requiredUnits
function unlinkAllRequiredUnits(a_unit)
	if a_unit.linksSources then
		for k, sourceId in base.pairs(a_unit.linksSources) do
			local source = unit_by_id[sourceId]
			unlinkRequiredUnits(a_unit, source)
		end
	end
	
	if a_unit.linksConsumers then
		for k, consumerId in base.pairs(a_unit.linksConsumers) do
			local consumer = unit_by_id[consumerId]
			unlinkRequiredUnits(consumer, a_unit)
		end
	end
end

-------------------------------------------------------------------------------
--разъединение юнитов с WS.requiredUnits
function unlinkRequiredUnits(a_Consumer, a_Source)
	for k,v in base.pairs(a_Consumer.linksSources) do
		if v == a_Source.unitId then
			base.table.remove(a_Consumer.linksSources, k)
			break
		end
	end
	
	for k,v in base.pairs(a_Source.linksConsumers) do
		if v == a_Consumer.unitId then
			base.table.remove(a_Source.linksConsumers, k)
			break
		end
	end
end

function unlinkSnap(waypoint)	
	if waypoint.linkSnap then
		if waypoint.linkSnap.type == "navPoint" then
			local parentNavPoint = NavigationPointController.getNavigationPoint(waypoint.linkSnap.id)
			if parentNavPoint then
				if parentNavPoint.linkChildrenSnap then			
					removeElement(parentNavPoint.linkChildrenSnap, waypoint)
				end
			end			
		end
		waypoint.linkSnap = nil
	end
end

-------------------------------------------------------------------------------
function linkToSnap(a_waypoint, a_parentSnapId, a_type)
	if a_waypoint.linkSnap then
        unlinkSnap(a_waypoint)
    end	
	NavigationPointController.getNavigationPoint(a_parentSnapId)
	
	if a_type == "navPoint" then
		a_waypoint.linkSnap = {
			type = a_type,
			id = NavigationPointController.getNavigationPoint(a_parentSnapId):getId()	
		}
	end	
	
	local snapTbl = NavigationPointController.getNavigationPoint(a_parentSnapId):getSnapTbl()
	if not snapTbl then
        snapTbl = { }
    end
	table.insert(snapTbl, a_waypoint)
	NavigationPointController.getNavigationPoint(a_parentSnapId):setSnapTbl(snapTbl)
end

-------------------------------------------------------------------------------
-- Link waypoint to parent group
function linkWaypoint(waypoint, parentGroup, unit)
    if waypoint.linkUnit then
        unlinkWaypoint(waypoint)
    end

    waypoint.linkUnit = unit;
    if not unit.linkChildren then
        unit.linkChildren = { }
    end
    table.insert(unit.linkChildren, waypoint)
end

function linkTriggerZone(triggerZoneId, unitId)
	TriggerZoneController.linkToUnit(triggerZoneId, unitId)
	local unit = unit_by_id[unitId]
	if not unit.linkChildrenTZone then
        unit.linkChildrenTZone = { }
    end
	table.insert(unit.linkChildrenTZone, triggerZoneId)
end

-------------------------------------------------------------------------------
-- remove element from table
function removeElement(a_table, element)
    local cnt = #a_table
    for i = 1, cnt do
        if a_table[i] == element then
            table.remove(a_table, i)
            return
        end
    end
end


-------------------------------------------------------------------------------
-- Remove link from this waypoint to parent
function unlinkWaypoint(waypoint)
	if waypoint.boss.linkOffset then
		waypoint.boss.linkOffset = false
	end
			
    if waypoint and waypoint.linkUnit then		
		if waypoint.linkUnit.linkChildren then			
			removeElement(waypoint.linkUnit.linkChildren, waypoint)
		end
		if waypoint.linkUnit.linkChildrenWithOffset then
			removeElement(waypoint.linkUnit.linkChildrenWithOffset, waypoint)
		end
        waypoint.linkUnit = nil
        waypoint.helipadId = nil 
        waypoint.airdromeId = nil 
        waypoint.grassAirfieldId = nil  
		
		for k,unit in base.pairs(waypoint.boss.units) do
			updateTopdownViewArguments(unit)
		end
    end
end

function unlinkTriggerZone(triggerZoneId)
	if triggerZoneId then		
		local linkUnitId = TriggerZoneController.getLinkUnitId(triggerZoneId)
		if linkUnitId then
			local unit = unit_by_id[linkUnitId]
			if unit.linkChildrenTZone then			
				removeElement(unit.linkChildrenTZone, triggerZoneId)
			end
			
			TriggerZoneController.unlinkToUnit(triggerZoneId)
		end
    end
end

-------------------------------------------------------------------------------
-- find unit with skill player
function isPlayerAvailable()
    local playerName = crutches.getPlayerSkill()
    for _tmp, u in pairs(unit_by_name) do
        if playerName == u.skill then
            return true
        end
    end
    return false
end

-------------------------------------------------------------------------------
-- find unit with skill player
function getPlayerUnit()
    local playerName = crutches.getPlayerSkill()
    for _tmp, u in pairs(unit_by_name) do
        if playerName == u.skill then
            return u
        end
    end
    return nil
end

-------------------------------------------------------------------------------
--
function saveTrack(fileName, a_type)
    local trackPath =  base.tempDataDir .. base.trackFileName;
	if a_type == 'training' then
		trackPath =  lfs.writedir()..'Tracks/tempMission.miz.trk'
	end
    print('trackPath', trackPath);
    local file = base.io.open(trackPath, 'rb')
    local data;
    if file then
        data = file:read('*a');
        file:close();
    else
		showWarningMessageBox(_('Can not open file for reading ')..trackPath)

        return false
    end;
    file = base.io.open(fileName, 'wb')
    if file then
        print('saving '.. fileName)
        file:write(data)
        file:close();        
    else
		showWarningMessageBox(cdata.save_mission_failed_msg.." " .. trackPath)
        
        return false
    end    

	return true
end; 

-------------------------------------------------------------------------------
-- relink children units
function relinkChildren(unit, a_group)
    if (not unit) or (not unit.linkChildren) then
        return
    end

    local children = { }
    for k, v in pairs(unit.linkChildren) do
		if a_group then
			if a_group.groupId == v.boss.groupId then
				table.insert(children, v)
			end
		else
			table.insert(children, v)
		end	
    end
    
    for _tmp, v in pairs(children) do
        unlinkWaypoint(v)
		if v.boss.type ~= 'static' then
			panel_route.attractToAirfield(v, v.boss, v.type)
		end
    end
end

-------------------------------------------------------------------------------
--
function fixTriggers()
--fix bugs triggers (id = value  to value_text)
    for _tmp, trigger in base.pairs(mission.trigrules) do
        if (trigger.rules) then
            for _tmp, rule in base.pairs(trigger.rules) do
                if (rule.predicate == "c_cockpit_param_equal_to") 
                    and (rule.value_text == nil) then
                    rule.value_text = rule.value
                    rule.value = nil
                end
                if ((rule.predicate == "c_unit_speed_lower") or (rule.predicate == "c_unit_speed_higher"))
                    and (rule.speedU == nil) then
                    rule.speedU = rule.speed
                    rule.speed = nil
                end
				
				if ((rule.predicate == "c_all_of_coalition_in_zone") or (rule.predicate == "c_all_of_coalition_out_zone"))
					and (rule.unitType == nil) then
					rule.unitType = "ALL"	
				end	
            end
        end
    end
    
    if  mission.version < 8 then
        for _tmp, trigger in base.pairs(mission.trigrules) do
            if (trigger.actions) then
                for k,v in base.pairs(trigger.actions) do
                    if v.file and v.file ~= "" and v.predicate ~= "a_load_mission" then
                        local resId = mod_dictionary.getNewResourceId("Action")                     
                        local filename = "l10n/DEFAULT/"..v.file
                        mod_dictionary.fixValueToResource(resId, v.file, filename)
                        v.file = resId
                    end
                    
                end
            end
        end    
    end
end
    
-------------------------------------------------------------------------------
--
function fixOperatingLevel(a_warehouses)
    for k, typeTable in pairs(a_warehouses) do
        for _tmp, warehouse in pairs(typeTable) do
            if (warehouse.OperatingLevel) then
                warehouse.OperatingLevel_Eqp  = warehouse.OperatingLevel_Eqp or warehouse.OperatingLevel
                warehouse.OperatingLevel_Air  = warehouse.OperatingLevel_Air or warehouse.OperatingLevel
                warehouse.OperatingLevel_Fuel = warehouse.OperatingLevel_Fuel or warehouse.OperatingLevel
            end
        end
    end
end



function fixAirportCoalition(warehouses)
	if warehouses.airports then
		local coalitionNames = {
			RED = CoalitionController.redCoalitionName(),
			BLUE = CoalitionController.blueCoalitionName(),
			NEUTRAL = CoalitionController.neutralCoalitionName(),
		}
		
        local removeTab = {}
		for airdromeNumber, airport in pairs(warehouses.airports) do
			local coalitionName = coalitionNames[airport.coalition]
			
			airport.coalition = coalitionName
            if AirdromeController.getAirdromeId(airdromeNumber) == nil then
                table.insert(removeTab, airdromeNumber)
            else
                AirdromeController.setAirdromeCoalition(AirdromeController.getAirdromeId(airdromeNumber), coalitionName)
            end                       
		end
        
        for i = #removeTab, 1, -1 do   
            table.remove(warehouses.airports, removeTab[i])            
        end
	end
end

-------------------------------------------------------------------------------
--
function fixBriefingPictures()
    mission.pictureFileNameR = mission.pictureFileNameR or {};
    if 'string' == base.type(mission.pictureFileNameR) then
        local name = mission.pictureFileNameR;
        mission.pictureFileNameR = {};
        if name ~= '' then
            table.insert(mission.pictureFileNameR, name);
        end;
    end;
    mission.pictureFileNameB = mission.pictureFileNameB or {};
    if 'string' == base.type(mission.pictureFileNameB) then
        local name = mission.pictureFileNameB;
        mission.pictureFileNameB = {};
        if name ~= '' then
            table.insert(mission.pictureFileNameB, name);
        end;
    end;
    
    if  mission.version < 8 then
        for i = 1, #mission.pictureFileNameR do
            local curId = mod_dictionary.getNewResourceId("ImageBriefing")     
            local filename = "l10n/DEFAULT/"..mission.pictureFileNameR[i]
            --base.print("-------curId, v, filename=",curId,mission.pictureFileNameR[i], filename)
            mod_dictionary.fixValueToResource(curId, mission.pictureFileNameR[i], filename)
            mission.pictureFileNameR[i] = curId
        end
        
        for i = 1, #mission.pictureFileNameB do
            local curId = mod_dictionary.getNewResourceId("ImageBriefing")     
            local filename = "l10n/DEFAULT/"..mission.pictureFileNameB[i]
            --base.print("----d---curId, v, filename=",curId,mission.pictureFileNameB[i], filename)
            mod_dictionary.fixValueToResource(curId, mission.pictureFileNameB[i], filename)
            mission.pictureFileNameB[i] = curId
        end
        
        
    end
end

function fixInitScriptFile()
    if mission.initScriptFile == "" then
        mission.initScriptFile = nil    
    end    
    if  mission.version < 19 then        
        if mission.initScriptFile then
			mod_dictionary.clearResourceExceptDEFAULT(mission.initScriptFile)
        end
    end    
end

function localizing_triggered_actions()
    if  mission.version < 8 then
        for _tmp, group in pairs(group_by_id) do  
            if group.tasks then    
                for _tmp, t in pairs(group.tasks) do  
                    if t.params and t.params.action and t.params.action.params and t.params.action.params.file and t.params.action.params.file ~= "" then                
                        local curId = mod_dictionary.getNewResourceId("TriggeredActions") 
                        local filename = "l10n/DEFAULT/"..t.params.action.params.file
                        mod_dictionary.fixValueToResource(curId, t.params.action.params.file, filename)
                        t.params.action.params.file = curId
                    end
                end 
            end    
        end 
    end
end


function applyPlayerName(fName)
    fName = fName or mission.path;
    local zipFile = base.assert(minizip.unzOpen(fName, 'rb'))
    
    unpackMissionFilesForAddOptions(zipFile)
    
    local extOptions
    if zipFile:unzLocateFile('options') then
        local optStr = zipFile:unzReadAllCurrentFile(false)
        local fun, errStr = base.loadstring(optStr)
        if not fun then
            print("error applyPlayerName", errStr)		
            return false
        end
        local env = { }
        base.setfenv(fun, env)
        fun()
        extOptions = env.options
    end      
    zipFile:unzClose()
    
    if extOptions then
        miz = minizip.zipCreate(fName)
        extOptions["playerName"] = LogBook.currentPlayer.player.callsign
        U.addTableToZip(miz, "options", extOptions)
        packMissionFilesForAddOptions(miz)        
        miz:zipClose()
    end
end

function applySetGlobalFalse(fName)
    fName = fName or mission.path;
    local zipFile = base.assert(minizip.unzOpen(fName, 'rb'))
    
    unpackMissionFilesForAddOptions(zipFile)
    
    local extOptions
    if zipFile:unzLocateFile('options') then
        local optStr = zipFile:unzReadAllCurrentFile(false)
        local fun, errStr = base.loadstring(optStr)
        if not fun then
            print("error applySetGlobalFalse", errStr)		
            return false
        end
        local env = { }
        base.setfenv(fun, env)
        fun()
        extOptions = env.options
    end      
    zipFile:unzClose()
    
    if extOptions and extOptions.difficulty and extOptions.difficulty.setGlobal
		and extOptions.difficulty.setGlobal == true then
        miz = minizip.zipCreate(fName)
        extOptions.difficulty.setGlobal = false
        U.addTableToZip(miz, "options", extOptions)
        packMissionFilesForAddOptions(miz)        
        miz:zipClose()
    end
end

-------------------------------------------------------------------------------
--
function applyOptionsAndPlayerName(fName)
    --base.print("---applyOptionsAndPlayerName---", fName)
    fName = fName or mission.path;
    local zipFile = base.assert(minizip.unzOpen(fName, 'rb'))
    
    unpackMissionFilesForAddOptions(zipFile)
    zipFile:unzClose()
    
    miz = minizip.zipCreate(fName)
    addOptionsToZip(miz)
    packMissionFilesForAddOptions(miz)
    
    miz:zipClose()
end; 

-------------------------------------------------------------------------------
--
function packMissionFilesForAddOptions(miz)
    for file, fullPath in base.pairs(resourceFilesForAdd) do
        miz:zipAddFile(file, fullPath)
        --base.print("----packMissionFilesForAddOptions---",file, fullPath)
    end
end

-------------------------------------------------------------------------------
-- распаковка ресурсов миссии
function unpackMissionFilesForAddOptions(zipFile)
	resourceFilesForAdd = {}	
    zipFile:unzGoToFirstFile()
    while true do        
        local filename = zipFile:unzGetCurrentFileName()
		filename = base.string.gsub(filename, "%s+/", "/")
		
        local lastSymbol = base.string.sub(filename, -1)
              
        if (filename ~= 'options') and lastSymbol ~= '/' then                     
            local dirName = base.tempMissionPath;

            for w in base.string.gmatch(filename, '[^><|?*:/\\]+/') do 
                dirName = dirName .. w;
                local a = lfs.attributes(dirName,'mode')
                if not a then
                    lfs.mkdir(dirName);
                end;
            end;
            
            local fullPath = base.tempMissionPath .. filename;

            resourceFilesForAdd[filename] = fullPath
            --base.print("----unpackMissionFilesForAddOptions---",filename, fullPath)
            base.assert(zipFile:unzUnpackCurrentFile(fullPath))           
        end;
        if not zipFile:unzGoToNextFile() then
			break
		end
    end
end;


-------------------------------------------------------------------------------
--
function isMissionModified()
    if mission.ext_loader then
        return false
    end
	
    local ignoredFields = {
        'path',
        'dist', 
        'len',
        'range',
        'mapObjects',
        'zones',
        'groupId',
        }
    
    mission.forcedOptions = OptionsData.getForcedOptions()    
    
	local identical = true

	if originalMission then
		identical = U.compareTables(originalMission, mission, ignoredFields)
		
		if identical and originalMission.groundControl then 
			identical = U.compareTables(originalMission.groundControl, panel_roles.getGroundControlData())
		end
	end
	
   --  U.traverseTable(originalMission);
   --  U.traverseTable(mission);
    return not identical
end 

-------------------------------------------------------------------------------
--
function isTrack(filePath)
    local zipFile = minizip.unzOpen(filePath, 'rb')
    if zipFile ~= nil then
        zipFile:unzGoToFirstFile()
        while true do
            if base.string.find(zipFile:unzGetCurrentFileName(), 'track_data') ~= nil then
                --print('TRACK !!!');
                zipFile:unzClose();
                return true;
            end;
            if not zipFile:unzGoToNextFile() then break end
        end
        zipFile:unzClose();
        return false;
    else
        return nil;
    end;
end; 

-------------------------------------------------------------------------------
-- true - миссия защищена цифровой подписью
function isSignedMission()
	return mod_dictionary.isSignedMission()
end

-------------------------------------------------------------------------------
--
function checkMissionIntroduction(filePath)
    local filePath = filePath or mission.path;
    print('checking introduction',filePath);
    if filePath == nil then
        return false
    end
    local zipFile = minizip.unzOpen(filePath, 'rb')
    if not zipFile then
        print("can't open mission file")
        return false
    end
    zipFile:unzGoToFirstFile()
    while true do
        local filename = zipFile:unzGetCurrentFileName()
        if (filename ~= 'mission') and (filename ~= 'options')  and (filename ~= 'warehouses') 
            and (filename ~= 'path') and ('/' ~= base.string.sub(filename, -1, -1)) then
            --print('filename', filename);
            if ( base.string.find(filename, 'continue_track') ~= nil) then
                print('introduction found');
                zipFile:unzClose()
                return true
            end;
        end;
        if not zipFile:unzGoToNextFile() then break end
    end
    zipFile:unzClose()
    print('introduction NOT found');
    return false
end; 

function updateHeading(group)
	if 'vehicle' == group.type then 
		panel_vehicle.updateHeading()
	elseif 'ship' == group.type then
		panel_ship.updateHeading(group)
	elseif 'plane' == group.type or 'helicopter' == group.type then
		panel_aircraft.updateHeading()
	elseif 'static' == group.type then
		panel_static.updateHeading()
	end;
end

-------------------------------------------------------------------------------
--проверяет наличие ЛА в миссии
function isEnableAircraft()
	for i,v in pairs(mission.coalition) do
		local coal = {name = v.Name, country = {}}
		for j,u in pairs(v.country) do
			---local cant = {id = u.id, name = me_db.country_by_id[u.id].OldID }
			--coal.country[j] = cant
			
			if u.plane then
				if (u.plane.group) then 
					if (u.plane.group[1]) then
						return true
					end
				end
			end
			if u.helicopter then
				if (u.helicopter.group) then 
					if (u.helicopter.group[1]) then
						return true
					end
				end
			end
		 
		end
	end
	return false
end

-------------------------------------------------------------------------------
--
function unloadCallsign(callsign, type, boss)
    local res = {
        name = callsign;
    };
    local num = base.tonumber(callsign);
    if num then 
		return num;
    else
        local str = base.string.match(callsign, '%a+');	
		local Callnames = me_db.db.getCallnames(boss.id, type) or		
				me_db.db.getUnitCallnames(boss.id, me_db.unit_by_type[type].attribute)
		local unitDesc = me_db.unit_by_type[type]
		--print("type=",type)
		--U.traverseTable(Callnames)
		local i;
		
		for k, v in pairs(Callnames) do
			if v.Name == str then
				i = v.WorldID
				break;
			end
		end
        
        res[1] = i;
        res[2] = base.tonumber(base.string.match(callsign, '%d'))
        res[3] = base.tonumber(base.string.match(callsign, '%d$'))  
    end;
    --print('unloading callsign', res.name);
    return res;
end;

-------------------------------------------------------------------------------
--
function unload_bullseye(key)
	local bullseye = 
	{
		x = mission.bullseye[key].x,
		y = mission.bullseye[key].y,
	}
	return bullseye
end

-------------------------------------------------------------------------------
--
function convertCallsign(callsign)
    if base.type(callsign) == 'table' then
        return callsign.name;
    elseif base.type(callsign) == 'number' then 
        return base.tostring(callsign);
    elseif base.type(callsign) == 'string' then
        return callsign;
    end;
end;

-------------------------------------------------------------------------------
--Переименовываем первый и последний Waypoint
function reNameWaypoints(a_name, a_index, a_maxIndex, a_country)
    --print("!!!!a_name, index, a_maxIndex=",a_name, a_index, a_maxIndex)
    if (a_maxIndex <= 1) then
        return ''    
    end
    
    if not U.isWesternCountry(a_country) then
        if (a_index == 1) then
            a_name = _('SP')
        end

        if (a_maxIndex > 1) and (a_index == a_maxIndex) then
            a_name = _('DP')
        end
    else
        a_name = base.tostring(a_index-1)
    end
    return a_name
end

--Переименовываем первый и последний Waypoint
function reNameWaypointsAction(a_name, a_index, a_maxIndex, a_country)
    --print("!!!!a_name, index, a_maxIndex=",a_name, a_index, a_maxIndex)
    if (a_maxIndex <= 1) then
        return ''    
    end
    
    if not U.isWesternCountry(a_country) then
        if (a_index == 1) then
            a_name = _('SP')
        elseif (a_maxIndex > 1) then            
            if (a_index == a_maxIndex) then
                a_name = _('DP')
            else
                a_name = base.tostring(a_index-1)
            end
        end
    else
        a_name = base.tostring(a_index-1)
    end
    return a_name
end
-------------------------------------------------------------------------------
--Обновляем надписи Waypoints
function updateTitleWaypoints(group)
    if (group == nil or (base.MapWindow.isShowHidden(group) == false)) then 
        return
    end
    local objects = {}
    
    for i=1,#group.route.points do
        local obj = group.mapObjects.route.numbers[i]
        table.insert(objects, obj)
        group.route.points[i].index = i
        local name = base.tostring(i-1)
        name = reNameWaypoints(name, i, #group.route.points, group.boss.name)
        if group.route.points[i].name then
            name = name..':'..group.route.points[i].name
        end
        group.mapObjects.route.numbers[i].title = name
    end
    
    MapWindow.removeUserObjects(objects)
    MapWindow.addUserObjects(objects)
end

-------------------------------------------------------------------------------
--
function createAirportEquipment()
--print("createAirportEquipment()")
    -- заполнение дефолтного склада----------------------
    function fillWarehouse()
        local AEDefault = T.safeDoFile("Config/AirportsEquipment.lua").AirportsEquipmentDefault
        local tmpAirportEquipment = {}
        tmpAirportEquipment.aircrafts = {}
        tmpAirportEquipment.aircrafts.planes = {}
        tmpAirportEquipment.aircrafts.helicopters = {}
        tmpAirportEquipment.weapons = {}
        tmpAirportEquipment.jet_fuel = {}   
        tmpAirportEquipment.gasoline = {}    
        tmpAirportEquipment.methanol_mixture = {}    
        tmpAirportEquipment.diesel = {}            
                 
        tmpAirportEquipment.unlimitedAircrafts     = true
        tmpAirportEquipment.unlimitedFuel          = true
        tmpAirportEquipment.unlimitedMunitions     = true
        
        tmpAirportEquipment.speed                  = 16.666666
        tmpAirportEquipment.periodicity            = 30
        tmpAirportEquipment.size                   = 100
        
        tmpAirportEquipment.jet_fuel.InitFuel          = 100    
        tmpAirportEquipment.gasoline.InitFuel          = 100   
        tmpAirportEquipment.methanol_mixture.InitFuel  = 100   
        tmpAirportEquipment.diesel.InitFuel            = 100   
 
        tmpAirportEquipment.OperatingLevel_Eqp       = 10 
        tmpAirportEquipment.OperatingLevel_Air       = 10 
        tmpAirportEquipment.OperatingLevel_Fuel      = 10  
        
	    for k,v in pairs(base.db.Units.Planes.Plane) do
            tmpAirportEquipment.aircrafts.planes[v.type] = {initialAmount    = AEDefault.LA.initialAmount,	wsType	= v.attribute}	end
        for k,v in pairs(base.db.Units.Helicopters.Helicopter) do    
            tmpAirportEquipment.aircrafts.helicopters[v.type] = {initialAmount    = AEDefault.LA.initialAmount,	wsType	= v.attribute}	end
        
		
		local available_resources = base.collect_available_weapon_resources()
		for i,o in ipairs(available_resources) do
			local weapon_type_  = base.wsTypeFromString(o)
            table.insert(tmpAirportEquipment.weapons,{wsType 		   = weapon_type_,
														   initialAmount   = AEDefault.weapon.initialAmount})
		end
        return tmpAirportEquipment
    end

    local AirportsEquipment = {}
    AirportsEquipment.airports = {}
    AirportsEquipment.warehouses ={}
    if (mission.AirportsEquipment == nil) then   
        mission.AirportsEquipment = {}
    end  
    if (mission.AirportsEquipment.airports == nil) then   
        mission.AirportsEquipment.airports = {}
    end   
    if (mission.AirportsEquipment.warehouses == nil) then   
        mission.AirportsEquipment.warehouses = {}
    end     
    
    AirportEquipment = fillWarehouse()
    
    for key,airport in pairs(MapWindow.listAirdromes) do               
        AirportsEquipment.airports[key] = {}
        U.recursiveCopyTable(AirportsEquipment.airports[key], AirportEquipment)
        AirportsEquipment.airports[key].coalition = CoalitionController.neutralCoalitionName()
        if (mission.AirportsEquipment.airports[key]) then
            AirportsEquipment.airports[key].suppliers = mission.AirportsEquipment.airports[key].suppliers
        else
            AirportsEquipment.airports[key].suppliers = {}
        end
    end   
    local tmpTable = {}
    base.U.mergeTablesToTable(mission.AirportsEquipment.airports, AirportsEquipment.airports, tmpTable)
    AirportsEquipment.airports = tmpTable
 
 -- проверяем/дополняем записанные в миссии склады
    for key,warehouse in pairs(mission.AirportsEquipment.warehouses) do    
        AirportsEquipment.warehouses[key] = {}
        U.recursiveCopyTable(AirportsEquipment.warehouses[key], AirportEquipment)
        AirportsEquipment.warehouses[key].coalition = mission.coalition.blue.name
        if (mission.AirportsEquipment.warehouses[key]) then
            AirportsEquipment.warehouses[key].suppliers = mission.AirportsEquipment.warehouses[key].suppliers
        else
            AirportsEquipment.warehouses[key].suppliers = {}
        end
    end
 --base.U.traverseTable(mission.AirportsEquipment.airports[22], 3)   
    local tmpTable = {}
    base.U.mergeTablesToTable(mission.AirportsEquipment.warehouses, AirportsEquipment.warehouses, tmpTable)
    AirportsEquipment.warehouses = tmpTable
    mission.AirportsEquipment = AirportsEquipment
   -- base.U.traverseTable(mission.AirportsEquipment.warehouses, 3)
    
    base.panel_manager_resource.vdata.AirportsEquipment = {}
    base.panel_manager_resource.vdata.AirportsEquipment = AirportsEquipment
    base.panel_manager_resource.init()
end

-------------------------------------------------------------------------------
--
function addWarehouse(a_unitId, a_coal)  
    if (mission.AirportsEquipment.warehouses[a_unitId] == nil) then
        mission.AirportsEquipment.warehouses[a_unitId] = {}
    else
        return -- если группа есть значит загружена миссия и создаются объекты 
    end
    if (mission.AirportsEquipment.warehouses[a_unitId].suppliers == nil) then
        mission.AirportsEquipment.warehouses[a_unitId].suppliers = {}
    end
    local suppliers = mission.AirportsEquipment.warehouses[a_unitId].suppliers

    U.recursiveCopyTable(mission.AirportsEquipment.warehouses[a_unitId], AirportEquipment)    
    mission.AirportsEquipment.warehouses[a_unitId].suppliers = suppliers  
    mission.AirportsEquipment.warehouses[a_unitId].coalition = a_coal
end


-------------------------------------------------------------------------------
--
function set_mapObjects(a_key, a_value)
	mapObjects[a_key] = a_value
end

-------------------------------------------------------------------------------
--проверка наличия склада у юнита
function isWarehouse(a_unitId)
	return mission.AirportsEquipment.warehouses[a_unitId] ~= nil 
end

-------------------------------------------------------------------------------
--
function delWarehouse(a_unitId) 
--print("---delWarehouse",a_unitId,  mission.AirportsEquipment.warehouses[a_unitId])
    mission.AirportsEquipment.warehouses[a_unitId] = nil    	
    --удаляем группу из поставщиков
    for k,v in pairs(mission.AirportsEquipment) do
        for kk,vv in pairs(v) do
            for key,supplier in pairs(vv.suppliers) do
                if (supplier.type == 'warehouses') and (supplier.Id == a_unitId) then
                    vv.suppliers[key] = nil         
                end
            end
        end
    end
	
	local supplierController = ModulesMediator.getSupplierController()
	supplierController.clearSelected()
end       

-------------------------------------------------------------------------------
--
function getGroup(a_groupId)
    return group_by_id[a_groupId]
end

-------------------------------------------------------------------------------
--
function getNewGroupId(a_oldId)
    local newId = a_oldId
    if a_oldId then
        if (maxGroupId < a_oldId) then
            maxGroupId = a_oldId
            newId = maxGroupId
        end
    else    
        maxGroupId = maxGroupId + 1
        newId = maxGroupId
    end
    
    while (group_by_id[newId] ~= nil) do
        newId = newId + 1;
        --print('incrementing group Id to',newId);
    end;
    
	return newId
end

function getMaxGroupId()
	return maxGroupId
end

function getMaxUnitId()
	return maxUnitId
end

-------------------------------------------------------------------------------
--
function getNewUnitId()
	-- # units in map at any given time
	maxUnitId = maxUnitId + 1
	return maxUnitId
end

-------------------------------------------------------------------------------
--
function veryfyUnitsPlugins(a_mission)
    local function getPlayerUnitType()
        for _k, color in pairs({'red', 'blue'}) do
			local coalition = a_mission.coalition[color]	
			--print("----Coalition=",color);		
			for i,v in pairs(coalition.country) do	
				--print("----country=",v.name);	
				for k,w in pairs(group_types) do			
					v[w] = v[w] or {}
					v[w].group = v[w].group or {}				
					for j,u in pairs(v[w].group) do
						for jj, unit in pairs(u.units) do
                            if unit.skill == crutches.getPlayerSkillId() then
                                return unit.type
                            end	
						end
					end
				end
			end
        end
        return
    end
    
	local playerUnitType = getPlayerUnitType()   
    local txtMsg = ""
    if a_mission.requiredModules and base.next(a_mission.requiredModules) then
        txtMsg = cdata.need_modules
        local enable = false
        for k,v in pairs(a_mission.requiredModules) do   
            if (base.enableModules[v] ~= true) 
				or (base.pluginsById[v] == nil or base.pluginsById[v].applied ~= true or base.pluginsById[v].state ~= "installed")  then 
                txtMsg = txtMsg .." ".. v .. "\n"
                enable = true
            end
        end  
        if enable then
			if (base.__FINAL_VERSION__) then
				showWarningMessageBox(txtMsg)
				return false
			else
				local result = false
				local msgWindowHandler = MsgWindow.warning(txtMsg, _('WARNING'), cdata.abort, cdata.proceed)
				
				function msgWindowHandler:onChange(buttonText)
					result = (buttonText == cdata.proceed)
				end

				msgWindowHandler:show()
				if result ~= true then
					return false
				end	
			end          
        end
    end
    
    if playerUnitType and base.aircraftFlyableInPlugins[playerUnitType] == nil then
        txtMsg = cdata.need_modules_containing .." ".. playerUnitType .."."
        showWarningMessageBox(txtMsg)
    end  

    return true
end

function getSupplierInfo(supplierId, supplierType, locale)
	local displayName
	local x
	local y
	
	if supplierType == 'airports' then
		local airdrome	= MapWindow.listAirdromes[supplierId]

        if airdrome.display_name then
            displayName = _(airdrome.display_name) 
        else
            displayName = airdrome.names[locale] or airdrome.names['en']
        end 
		x			= airdrome.reference_point.x
		y			= airdrome.reference_point.y
	else
		local unit	= unit_by_id[supplierId]
		
		displayName = unit.name
		x			= unit.x
		y			= unit.y
	end
	
	return {
		displayName		= displayName, 
		supplierId		= supplierId, 
		supplierType	= supplierType,
		x				= x,
		y				= y,
	}
end

function getAirdromeSupplierInfo(airdromeNumber)
	return getSupplierInfo(airdromeNumber, 'airports', i18n.getLocale())
end

function getWarehouseSupplierInfo(unitId)
	return getSupplierInfo(unitId, 'warehouses', i18n.getLocale())
end

function getAirdromeSuppliersInfo(airdromeNumber)
    local locale		= i18n.getLocale()
    local suppliersInfo	= {}
    
    for i, supplier in pairs(mission.AirportsEquipment.airports[airdromeNumber].suppliers) do
		table.insert(suppliersInfo, getSupplierInfo(supplier.Id, supplier.type, locale))
    end
	
	return suppliersInfo	
end

function getWarehouseSuppliersInfo(unitId)
    local locale		= i18n.getLocale()
    local suppliersInfo	= {}
    
    for i, supplier in pairs(mission.AirportsEquipment.warehouses[unitId].suppliers) do
		table.insert(suppliersInfo, getSupplierInfo(supplier.Id, supplier.type, locale))
    end
	
	return suppliersInfo	
end

local function getSupplierPresented(suppliers, supplierId, supplierType)
	for i, supplier in pairs(suppliers) do
		if 	supplier.Id == supplierId and 
			supplier.type == supplierType then
			
			return true
		end
	end
	
	return false
end

local function addSupplier(warehouseId, warehouseType, supplierId, supplierType)
	local suppliers = mission.AirportsEquipment[warehouseType][warehouseId].suppliers
	
	if 	warehouseType == supplierType and
		warehouseId == supplierId then
		
		return false
	end
	
	if getSupplierPresented(suppliers, supplierId, supplierType) then
		return false
	end
	
	table.insert(suppliers, {Id = supplierId, type = supplierType})
	
	return true
end

local function removeSupplier(warehouseId, warehouseType, supplierId, supplierType)
	local suppliers = mission.AirportsEquipment[warehouseType][warehouseId].suppliers
        
	for i, supplier in pairs(suppliers) do	
		if supplierType == supplier.type and supplier.Id == supplierId then
			suppliers[i] = nil
			
			return true
		end
	end 
	
	return false
end

function addAirdromeSupplier(airdromeNumber, supplierId, supplierType)
	if addSupplier(airdromeNumber, 'airports', supplierId, supplierType) then
		AirdromeController.airdromeSupplierAdded(airdromeNumber, getSupplierInfo(supplierId, supplierType, i18n.getLocale()))
	end	
end

function removeAirdromeSupplier(airdromeNumber, supplierId, supplierType)
	if removeSupplier(airdromeNumber, 'airports', supplierId, supplierType) then
		AirdromeController.airdromeSupplierRemoved(airdromeNumber, supplierId, supplierType)
	end
end

function addWarehouseSupplier(unitId, supplierId, supplierType)
	if addSupplier(unitId, 'warehouses', supplierId, supplierType) then
		ModulesMediator.getSupplierController().warehouseSupplierAdded(unitId, getSupplierInfo(supplierId, supplierType, i18n.getLocale()))
	end
end

function removeWarehouseSupplier(unitId, supplierId, supplierType)
	if removeSupplier(unitId, 'warehouses', supplierId, supplierType) then
		ModulesMediator.getSupplierController().warehouseSupplierRemoved(unitId, supplierId, supplierType)
	end
end

function getWarehouseInfos()
	local positions = {}
	
	for unitId, warehouse in pairs(mission.AirportsEquipment.warehouses) do
		local unit = unit_by_id[unitId]
		local coalitionName = unit.boss.boss.boss.name
		
		table.insert(positions, {	unitId			= unitId,
									x				= unit.x, 
									y				= unit.y, 
									coalitionName	= coalitionName})
	end
	
	return positions
end


clearTempFolder()
