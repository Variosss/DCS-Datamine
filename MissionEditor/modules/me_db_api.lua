local base = _G

module('me_db_api')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local table = base.table

local Serializer 	= require('Serializer')
local U 			= require('me_utilities')  -- Утилиты создания типовых виджетов
local Tools			= require('tools')
local Terrain 		= require('terrain')
local textutil		= require('textutil')
local log      		= require('log')

require('i18n').setup(_M)

local cdata = {
    farp = _('FARP'),
    GrassAirfield = _("Grass Airfield"),
}

local initialized = false

function isInitialized()
	return initialized
end

function isFARP(type_)
	return heliport_by_type[type_] ~= nil
end  

-- load class keys and maps IDS to display names
function createClassKeys_()
    local ids = Tools.safeDoFile("MissionEditor/data/scripts/unitsclasses.lua")
    local res = { }
    for i,v in pairs(ids.unitClassKey) do
        res[i] = v
    end
    return res
end

function getClassKey(unitDisplayName)
	if unit_by_name[unitDisplayName] and unit_by_name[unitDisplayName].mapclasskey then 
		return unit_by_name[unitDisplayName].mapclasskey;
	else
		return unitClassKey_[getNameByDisplayName(unitDisplayName)]
	end
end

function getClassKeyByType(unitType)
	if unit_by_type[unitType] and unit_by_type[unitType].mapclasskey then 
		return unit_by_type[unitType].mapclasskey;
	else
		return unitClassKey_[unitType]
	end
end

-- returns distance between two points
function getDist(x1, y1, x2, y2)
  local dx = x2 - x1
  local dy = y2 - y1
  
  return base.math.sqrt(dx * dx + dy * dy)
end

-- returns hash of suitable carriers categories CLSID's
-- waypoint type can be either 'takeoff' or 'land'
-- unitType is type of unit, e.g. S-3B
function getLandCategories(waypointType, unitType)
    local unit = unit_by_type[unitType]
    local cats
    if 'takeoff' == waypointType then
        cats = "TakeOffRWCategories"
    else
        cats = "LandRWCategories"
    end
    local unitCats = unit[cats]

    local res = { }
    if unitCats then
        for _tmp, v in pairs(unitCats) do
            res[v.Name] = 1
        end
    end

    return res
end

function getMissiles()
	return base.wstype_missiles
end

function getBombs()
	return base.wstype_bombs
end

-- checks is ship units is suitable for landing or takeoff
-- unit ship unit
-- categories hash of allowed ships categories CLSID's
function isShipSuitable(unit, categories)
    local ship = ship_by_type[unit.type]
    if not ship.Categories then
        return false
    end
    for _tmp, v in pairs(ship.Categories) do
        if 1 == categories[v.name] then
            return true
        end
    end
    return false
end


-- returns most suitable unit for landing or nil if landing is prohibited
function getUnitForLanding(category, group, allowedCats, helicopter, x, y)

    if (helicopter and ("static" == category) and 
					   isFARP(group.units[1].type)) 
    then
        return group.units[1]
    end
    
    if (("static" == category) and 
                (group.units[1].type == cdata.GrassAirfield)) 
    then
        return group.units[1]
    end

    local suitableUnit;
    local dist = base.math.huge;
    if "ship" == category then
        for _tmp, u in pairs(group.units) do
            if isShipSuitable(u, allowedCats) then
                local d = getDist(x, y, u.x, u.y)
                if d < dist then
                    dist = d;
                    suitableUnit = u;
                end;
            end
        end
    end
    
    return suitableUnit
end

-------------------------------------------------------------------------------
--возвращает список всех аэродромов отсортированный по удаленности
-- от ближайшего к дальнему
function getNearestAirdromes(x, y)
    local airdromes = {}
    local sx, sy, ID, roadnet
	--base.print("Airdromes=")
    for airdromeID, airdrome in pairs(Terrain.GetTerrainConfig("Airdromes")) do
        if airdrome.abandoned ~= true then
            local d = getDist(x, y, airdrome.reference_point.x, airdrome.reference_point.y)
            --base.print("  d=", d)
            
            local air_item =
            {
                dist    = d,
                sx 		= airdrome.reference_point.x,
                sy 		= airdrome.reference_point.y,
                ID 		= airdromeID,
                roadnet = airdrome.roadnet,
            }
            
            table.insert(airdromes,air_item)
        end
    end
	
	local function compDist(tab1, tab2)
		if (tab1.dist < tab2.dist) then
			return true
		end
		return false
	end
	
	table.sort(airdromes, compDist)
    
    return airdromes
end

function getRoadnetAirdrome(a_airdromeID)
    for airdromeID, airdrome in pairs(Terrain.GetTerrainConfig("Airdromes")) do
        if airdrome.abandoned ~= true then
            if a_airdromeID == airdromeID then
                return airdrome.roadnet
            end  
        end   
    end
end

--find nearest airdrome
function getNearestAirdrome(x, y)
    local result = nil
    local sx, sy, ID, roadnet
    for airdromeID, airdrome in pairs(Terrain.GetTerrainConfig("Airdromes")) do
        if airdrome.abandoned ~= true then
            local d = getDist(x, y, airdrome.reference_point.x, airdrome.reference_point.y)
            
            local air_item =
            {
                dist    = d,
                sx 		= airdrome.reference_point.x,
                sy 		= airdrome.reference_point.y,
                ID 		= airdromeID,
                roadnet = airdrome.roadnet,
            }
            
            if 	result == nil or
                d < dMin then
                result = air_item
                dMin = d
            end		
        end
    end
	return result
end

-- finds nearest airbase
function getNearestAirdromePoint(x, y, coalition, waypointType, unitType)
    local cats = getLandCategories(waypointType, unitType)

    local dmin2 = 1000000000000000
    local sx, sy, ID
    for airdromeID, airdrome in pairs(Terrain.GetTerrainConfig("Airdromes")) do
        if airdrome.abandoned ~= true then
            local d = getDist(x, y, airdrome.reference_point.x, airdrome.reference_point.y)
            if d < dmin2 then
                dmin2 = d
                sx 		= airdrome.reference_point.x
                sy 		= airdrome.reference_point.y
                ID 		= airdromeID
            end
        end
    end

    local helicopter = false
    if helicopter_by_type[unitType] then
        helicopter = true
    end

    local categories = {"ship"}
    table.insert(categories, "static")

    local groupForLanding = nil
    local unitForLanding = nil
    for _tmp, category in pairs(categories) do
        for _tmp, country in pairs(coalition.country) do    
            for _tmp, group in pairs(country[category].group) do
                local u = getUnitForLanding(category, group, cats, helicopter, x, y)
                if u then
                    local d = getDist(x, y, u.x, u.y)
                    if d < dmin2 then
                        dmin2 = d
                        sx = u.x
                        sy = u.y
                        ID = u.name
                        base.print('name', u.name)
                        groupForLanding = group
                        unitForLanding = u;
                    end
                end
            end
        end;
    end -- for
    return  sx, sy, ID, groupForLanding, unitForLanding
end

seaPlane = 
{
  
}

seaHelicopter = 
{

}

local availableCountriesByAircraft = 
{
}

function getAvailableCountriesList(aircraftType)
	return availableCountriesByAircraft[aircraftType]
end

local function fillAvailableCountries()
	local unitTypes = {'Plane', 'Helicopter'}
	for i,v in pairs(db.Countries) do
		for j, unitType in ipairs(unitTypes) do
			for k, aircraft in pairs(v.Units[unitType..'s'][unitType]) do
				if availableCountriesByAircraft[aircraft.Name] == nil then
					availableCountriesByAircraft[aircraft.Name] = {}
				end
				table.insert(availableCountriesByAircraft[aircraft.Name], v)
			end
		end
	end
	
	for i, countries in pairs(availableCountriesByAircraft) do
		U.sortCountries(countries, 'Name')
	end
end

-- replays name with display name
function hackNames(unitsList)
    for i,v in pairs(unitsList) do
        displayNameByName[v.Name] = v.DisplayName
        nameByDisplayName[v.DisplayName] = v.Name
        v.type = v.Name
        v.Name = v.DisplayName
		v.swapped_names = true
    end
end

function create()
  base.print("me_db_api creation started")
  base.db_path = "Scripts/Database/";
  base.dofile(base.db_path.."db_main.lua");
  db = base.db
  findAttribute 	= base.findAttribute
  hasAttribute 		= base.hasAttribute
  hasAttributes 	= base.hasAttributes
  getDefaultRadioFor = base.getDefaultRadioFor
  MODULATION_AM = base.MODULATION_AM
  MODULATION_FM = base.MODULATION_FM
  MODULATION_AM_AND_FM = base.MODULATION_AM_AND_FM
  
  country_names = {}
  country_by_name = {}
  country_by_id = {}
  country_by_OldID = {}
  country_category_units = {}
  for i,v in pairs(db.Countries) do
    country_by_name[v.Name] = v
    country_by_id[v.WorldID] = v
	country_by_OldID[v.OldID] = v
    table.insert(country_names, v.Name)
  end
  
  weapon_by_CLSID = db.Weapons.ByCLSID
  
  
  category_by_weapon_CLSID = {}
  for i,v in pairs(db.Weapons.Categories) do
    for j,u in pairs(v.Launchers) do
      category_by_weapon_CLSID[u.CLSID] = v
    end
  end
  
  unit_by_name = {}
  unit_by_type = {}
  
  displayNameByName = {}
  nameByDisplayName = {}
  
  plane_by_type = {}
  --base.print('seaPlanes:')
  hackNames(db.Units.Planes.Plane)
  for i,v in pairs(db.Units.Planes.Plane) do
    plane_by_type[v.type] = v
    unit_by_name[v.Name] = v    
    unit_by_type[v.type] = v
  local rwc = v.TakeOffRWCategories or v.LandRWCategories
  if rwc then
    for j,u in pairs(rwc) do
      if u.Name == 'AircraftCarrier' or u.Name == 'AircraftCarrier With Catapult' or u.Name == 'AircraftCarrier With Tramplin' then
        seaPlane[v.Name] = true
        break
      end
    end
  end
  end
  
  helicopter_by_type = {}
  hackNames(db.Units.Helicopters.Helicopter)
  for i,v in pairs(db.Units.Helicopters.Helicopter) do
    helicopter_by_type[v.type] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  local rwc = v.TakeOffRWCategories or v.LandRWCategories
  if rwc then
    for j,u in pairs(rwc) do
      if u.Name == 'Carrier' or u.Name == 'HelicopterCarrier' then
        seaHelicopter[v.Name] = true
        break
      end
    end
  end
  end
  
  hackNames(db.Units.Ships.Ship)
  ship_by_type = {}
  for i,v in pairs(db.Units.Ships.Ship) do
    ship_by_type[v.type] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end
 
  hackNames(db.Units.Cars.Car)
  car_by_name = {}
  local isNeedAddTrain = false
  for i,v in pairs(db.Units.Cars.Car) do
    car_by_name[v.Name] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
	if v.category == 'Locomotive' or v.category == 'Carriage' then
		isNeedAddTrain = true
	end
  end
  
  if isNeedAddTrain == true then
    local unit = {}
	unit.category = "Train"	
	unit.DisplayName = "Train_loc"
	unit.Name = unit.DisplayName
	unit.type = "Train"
	unit.mapclasskey = "P91000108";
	db.Units.Cars.Train = unit
	unit_by_name[unit.Name] = unit
    unit_by_type[unit.type] = unit
  end

  hackNames(db.Units.GroundObjects.GroundObject)
  ground_object_by_name = {}
  for i,v in pairs(db.Units.GroundObjects.GroundObject) do
    ground_object_by_name[v.Name] = v
  end

  hackNames(db.Units.Fortifications.Fortification)
  fortification_by_name = {}
  for i,v in pairs(db.Units.Fortifications.Fortification) do
    fortification_by_name[v.Name] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end

  hackNames(db.Units.Heliports.Heliport)
  heliport_by_type = {}
  for i,v in pairs(db.Units.Heliports.Heliport) do
    heliport_by_type[v.type] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end
  
  hackNames(db.Units.GrassAirfields.GrassAirfield)
  grassairfield_by_name = {}
  for i,v in pairs(db.Units.GrassAirfields.GrassAirfield) do
    grassairfield_by_name[v.Name] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end
  
  hackNames(db.Units.Warehouses.Warehouse)
  warehouse_by_name = {}
  for i,v in pairs(db.Units.Warehouses.Warehouse) do
    warehouse_by_name[v.Name] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end
  
  hackNames(db.Units.Cargos.Cargo)
  cargo_by_name = {}
  for i,v in pairs(db.Units.Cargos.Cargo) do
    cargo_by_name[v.Name] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end
  
  hackNames(db.Units.Effects.Effect)
  for i,v in pairs(db.Units.Effects.Effect) do
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end
  
  hackNames(db.Units.LTAvehicles.LTAvehicle)
  LTAvehicle_by_name = {}
  for i,v in pairs(db.Units.LTAvehicles.LTAvehicle) do
    LTAvehicle_by_name[v.Name] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end
  
  hackNames(db.Units.Animals.Animal)
  Animal_by_name = {}
  for i,v in pairs(db.Units.Animals.Animal) do
    Animal_by_name[v.Name] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end
  
  hackNames(db.Units.Personnel.Personnel)
  Personnel_by_name = {}
  for i,v in pairs(db.Units.Personnel.Personnel) do
    Personnel_by_name[v.Name] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end
  
  hackNames(db.Units.ADEquipments.ADEquipment)
  ADEquipment_by_name = {}
  for i,v in pairs(db.Units.ADEquipments.ADEquipment) do
    ADEquipment_by_name[v.Name] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end
  
  hackNames(db.Units.WWIIstructures.WWIIstructure)
  WWIIstructure_by_name = {}
  for i,v in pairs(db.Units.WWIIstructures.WWIIstructure) do
    WWIIstructure_by_name[v.Name] = v
    unit_by_name[v.Name] = v
    unit_by_type[v.type] = v
  end

  unitClassKey_ = createClassKeys_() -- unitClassKey_ now private, use getClassKey(unitDisplayName) to get a classkey
  initialized = true
  
  navPointTypesById_ = {}
  for k, v in pairs(db.typesNavPoints) do
	navPointTypesById_[v.id] = v
  end	
  
  fillAvailableCountries()
  base.print("me_db_api creation complete")
end

function getTypesNavPoints()
	local types = {}
	U.recursiveCopyTable(types, db.typesNavPoints)
	return types
end

function getTypesNavPointsById()	
	local typesById = {}
	U.recursiveCopyTable(typesById, navPointTypesById_)
	return typesById
end

function save(fName,tname, vdata)
	local f, err = base.io.open(fName, 'w')
	if f then
		local s = Serializer.new(f)
		s:serialize_simple2(tname, vdata)
		f:close()
	else
		log.error('ERROR: save failed: '..err)	
	end
end

function isCarrier(a_ship)
	if (a_ship.Categories) then
		for k,v in pairs(a_ship.Categories) do
			if v.name == "AircraftCarrier" or 
				v.name == "HelicopterCarrier" then
				return true
			end
		end
	end
	return false
end	
			
function getCountryPlanesTasks(country_name)
  local c = country_by_name[country_name]
  local ps = c.Units.Planes.Plane
  local tasks = {'Nothing',}
  for i,v in pairs(ps) do
    local unit = plane_by_type[v.type]
    for j,u in pairs(unit.Tasks) do
      local bFound = false
      for k,w in pairs(tasks) do
        if u.Name == w then
          bFound = true
          break
        end
      end
      if not bFound then
        table.insert(tasks, u.Name)
      end
    end
  end 
  return tasks 
end

function getPlaneTasks(type)
  local tasks = {'Nothing',}
  local unit = plane_by_type[type]
  for j,u in pairs(unit.Tasks) do
    local bFound = false
    for k,w in pairs(tasks) do
      if u.Name == w then
        bFound = true
        break
      end
    end
    if not bFound then
      table.insert(tasks, u.Name)
    end
  end 
  return tasks 
end

function getCountryTaskPlanes(country_name, task_name)
  local c = country_by_name[country_name]
  local ps = c.Units.Planes.Plane
  local planes = {}
  for i,v in pairs(ps) do
    local unit = plane_by_type[v.type]
    for j,u in pairs(unit.Tasks) do
      if u.Name == task_name then
        local bFound = false
        for k,w in pairs(planes) do
          if v.Name == w then
            bFound = true
            break
          end
        end
        if not bFound then
          table.insert(planes, v.Name)
        end
      end
    end
  end 
  return planes 
end

function getCountryHelicoptersTasks(country_name)
  local c = country_by_name[country_name]
  local ps = c.Units.Helicopters.Helicopter
  local tasks = {'Nothing',}
  for i,v in pairs(ps) do
    local unit = helicopter_by_type[v.type]
    for j,u in pairs(unit.Tasks) do
      local bFound = false
      for k,w in pairs(tasks) do
        if u.Name == w then
          bFound = true
          break
        end
      end
      if not bFound then
        table.insert(tasks, u.Name)
      end
    end
  end 
  return tasks 
end


function getHelicopterTasks(helicopter_name)
  local tasks = {'Nothing',}
  local unit = helicopter_by_type[helicopter_name]
  for j,u in pairs(unit.Tasks) do
    local bFound = false
    for k,w in pairs(tasks) do
      if u.Name == w then
        bFound = true
        break
      end
    end
    if not bFound then
      table.insert(tasks, u.Name)
    end
  end 
  return tasks 
end

function getCountryTaskHelicopters(country_name, task_name)
  local c = country_by_name[country_name]
  local ps = c.Units.Helicopters.Helicopter
  local helicopters = {}
  for i,v in pairs(ps) do
    for j,u in pairs(v.Tasks) do
      if u.Name == task_name then
        local bFound = false
        for k,w in pairs(helicopters) do
          if v.Name == w then
            bFound = true
            break
          end
        end
        if not bFound then
          table.insert(helicopters, v.Name)
        end
      end
    end
  end 
  return helicopters 
end

function getCountryPlanes(country_name)
  local planes = {}
  local c = country_by_name[country_name]
  local ps = c.Units.Planes.Plane
  for i,v in pairs(ps) do
    table.insert(planes, v.type)
  end
  return planes
end

function getCountryHelicopters(country_name)
  local helicopters = {}
  local c = country_by_name[country_name]
  local ps = c.Units.Helicopters.Helicopter
  for i,v in pairs(ps) do
    table.insert(helicopters, helicopter_by_type[v.type].Name)
  end
  return helicopters
end

function getCountryShips(country_name)
  local ships = {}
  local c = country_by_name[country_name]
  local ps = c.Units.Ships.Ship
  for i,v in pairs(ps) do
    table.insert(ships, ship_by_type[v.type].Name)
  end
  return ships
end


function getCountryCars(country_name)
  local cars = {}
  local c = country_by_name[country_name]
  local ps = c.Units.Cars.Car
  for i,v in pairs(ps) do
    table.insert(cars, car_by_name[v.type].Name)
  end
  return cars
end


-- Finds country by old ID (oldId actually is non-localized name)
-- it is very inefficient and present here temporary for transition
-- to new format
-- TODO: remove this function
function getCountryByOldID(oldId)
    for _tmp,v in pairs(db.Countries) do
        if v.OldID == oldId then
            return v
        end
    end
end


-- Converts name to display name
function getNameByDisplayName(displayName)
    local v = nameByDisplayName[displayName]
    if not v then
        return displayName
    else
        return v
    end
end

-- Converts display name to name
function getDisplayNameByName(name)
    local v = displayNameByName[name]
    if not v then
        return name
    else
        return v
    end
end

-- Возвращает true если большой самолет 
function Get_BigAC(type) 
	local attr = unit_by_type[type].attribute
	local res = attr[3] --(attr[3] - attr[2]) / 256
    --base.U.traverseTable(attr)
    --base.print("Get_BigAC.res=",res,base.wsType_F_Bomber,base.wsType_Intruder,base.wsType_Cruiser)
	if (res == base.wsType_F_Bomber)
		or (res == base.wsType_Intruder)
		or (res == base.wsType_Cruiser) then
		return true
	end
	
	return false
end

-------------------------------------------------------------------------------	
--возвращает список самолетов доступных игроку
function getHumanControlledAircrafts()
    local aircrafts  = {};
    local units;
	
    units = plane_by_type;	
	for k,unit in pairs(units) do
        if unit.HumanCockpit  then
            aircrafts[unit.type] = unit;
        end;
    end;
	
    units = helicopter_by_type;		
    for k,unit in pairs(units) do
        if unit.HumanCockpit  then
            aircrafts[unit.type] = unit;
        end;
    end;    
	
    return aircrafts;
end;

-------------------------------------------------------------------------------
--возвращает список самолетов доступных клиенту
function getClientControlledAircrafts()
    local aircrafts  = {};
    local units;
 
	units = plane_by_type	
    for k,unit in pairs(units) do
        if unit.HumanRadio  then
            aircrafts[unit.type] = unit;
        end;
    end;  

	units = helicopter_by_type;		
    for k,unit in pairs(units) do
        if unit.HumanRadio  then
            aircrafts[unit.type] = unit;
        end;
    end;	
	
    return aircrafts;
end;

function getNavigationPointCallsigns()
	local callsigns = {}
	
	for k, refPoint in pairs(db.getCallnamesRefPoints()) do
		callsigns[refPoint.Name] = refPoint.WorldID
	end
	
	return callsigns
end

function getCountries()
	local countries = {}
	
	for i, country in ipairs(db.Countries) do
		countries[country.WorldID] = {
			name 		= country.Name, 
			flag 		= country.flag,
			flag_small  = country.flag_small,
            InternationalName = country.InternationalName,
			hide		= country.hide
		}
	end
	
	return countries
end

function getCountryTroops(countryWorldId)
	local troops = {}
	
	for i, country in ipairs(db.Countries) do
		if country.WorldID == countryWorldId then
			for j, troop in ipairs(country.Troops) do
				table.insert(troops, {
					name			= troop.name,
					localizedName	= troop.nativeName,
					picture			= troop.picture,
				})
			end
		end
	end	
	
	return troops
end

function getCountryRanks(countryWorldId)
	local ranks = {}
	
	for i, country in ipairs(db.Countries) do
		if country.WorldID == countryWorldId then
			for j, rank in ipairs(country.Ranks) do
				table.insert(ranks, {
					name			= rank.name,
					localizedName	= rank.nativeName,
					threshold		= rank.threshold,
					pictureRect		= rank.pictureRect,
				})
			end
		end
	end	
	
	return ranks	
end

function getCountryAwards(countryWorldId)
	local awards = {}
	
	for i, country in ipairs(db.Countries) do
		if country.WorldID == countryWorldId then
			for j, award in ipairs(country.Awards) do
				table.insert(awards, {
					name			= award.name,
					localizedName	= award.nativeName,
					threshold		= award.threshold,
					picture			= award.picture,
				})
			end
		end
	end	
	
	return awards	
end

local unitCategoriesInfos = {
	{name = _('Planes'),			unitType = 'Plane',				unitsFieldName = 'Planes'},
	{name = _('Helicopters'),		unitType = 'Helicopter',		unitsFieldName = 'Helicopters'},    
	{name = _('Ships'),				unitType = 'Ship',				unitsFieldName = 'Ships'},
	{name = _('Ground vehicles'),	unitType = 'Car',				unitsFieldName = 'Cars'},
	{name = _('Structures'),		unitType = 'Fortification',		unitsFieldName = 'Fortifications'},     
	{name = _('Heliports'),			unitType = 'Heliport',			unitsFieldName = 'Heliports'},  
    {name = _('Grass Airfields'),	unitType = 'GrassAirfield',		unitsFieldName = 'GrassAirfields'},      
	{name = _('Warehouses'),		unitType = 'Warehouse',			unitsFieldName = 'Warehouses'},     
	{name = _('Cargos'),			unitType = 'Cargo',				unitsFieldName = 'Cargos'},
	{name = _('Effects'),			unitType = 'Effect',				unitsFieldName = 'Effects'},
}

function getCountriesUnitCategories()
	local countries = {}
	
	for i, country in ipairs(db.Countries) do
		local categories = {}
		
		for j, unitCategoriesInfo in ipairs(unitCategoriesInfos) do
			if country.Units[unitCategoriesInfo.unitsFieldName] then
				table.insert(categories, unitCategoriesInfo.name)
			end
		end
		
		countries[country.Name] = categories
	end
	
	return countries
end

function getCountriesUnitCategoriesTypes()
	local countries = {}
	local insert = table.insert
	
	for i, country in ipairs(db.Countries) do
		local categories = {}
		
		for j, unitCategoriesInfo in ipairs(unitCategoriesInfos) do
			local units = country.Units[unitCategoriesInfo.unitsFieldName]
			if units then
				local unitsByType = units[unitCategoriesInfo.unitType]
				local count = #unitsByType
				
				if count > 0 then
					local count = #unitsByType
					
					if count > 0 then
						local typeNames = {}
						
						for i = 1, count do
							insert(typeNames, unitsByType[i].Name)
						end
						
						categories[unitCategoriesInfo.name] = typeNames
					end
				end
			end
		end
		
		countries[country.Name] = categories
	end
	
	return countries
end


function liveryEntryPoint(unit)
	local data = unit_by_type[unit]
	if data then
		return data.livery_entry or unit
	end	
	return unit
end

-------------------------------------------------------------------------------
--возвращает имя задачи по ID
function getTaskName(taskWorldID)
	if not taskWorldIDs__ then
		-- создадим таблицу для быстрого поиска
		taskWorldIDs__ = {}
		for _tmp, task in pairs(db.Units.Planes.Tasks) do
			taskWorldIDs__[task.WorldID] = task.Name
		end
	end

	if not taskWorldIDs__[taskWorldID] then
		print('Task with WorldID ' .. taskWorldID .. ' is not presented in db.Units.Planes.Tasks table!')
		return
	end

	return taskWorldIDs__[taskWorldID]  
end

-------------------------------------------------------------------------------
-- возвращает имя дефолтной задачи
function getDefaultTaskName()
  local defaultWorldID = db.Units.Planes.DefaultTask.WorldID
 
  return getTaskName(defaultWorldID)
end

function getTasksByCountryAndPlane()
	-- список задач для страны tasksByCountryAndPlane[country.OldID][unit.type] = {taskName, taskName, ...}
	local tasksByCountryAndPlane = {}
  
	local defaultTaskName = getDefaultTaskName()
	base.assert(defaultTaskName)
	
	for _tmp, country in pairs(db.Countries) do
		tasksByCountryAndPlane[country.OldID] = {}

		for k,v in base.pairs({country.Units.Helicopters.Helicopter, country.Units.Planes.Plane}) do
			for _tmp, plane in pairs(v) do
				local unit = unit_by_type[plane.Name]
			  
				-- по всем задачам самолета
				if not unit then
					base.print("check unit ",plane.CLSID,country.OldID,plane.Name)
				else
					if not unit.DefaultTask  then
						base.error(unit.type..' has no default task!')
					end
					
					tasksByCountryAndPlane[country.OldID][unit.type] = {}

					for _tmp, task in base.pairs(unit.Tasks) do 
						base.table.insert(tasksByCountryAndPlane[country.OldID][unit.type], task.Name)							
					end
					
					base.table.sort(tasksByCountryAndPlane[country.OldID][unit.type])
					
					base.table.insert(tasksByCountryAndPlane[country.OldID][unit.type], 1, defaultTaskName)	
				end
			end
		end	
	end

	return tasksByCountryAndPlane
end

function hasTags(a_tagsU, a_Tags, a_enablePlayerCanDrive)
	local result = {}
	--base.print("--hasTags--")
	local enableTbl = {}
	for name,tagsIN in base.pairs(a_Tags) do
	--	base.print("--name--",name)
		for k, tagIN in base.pairs(tagsIN) do
	--		base.print("--tagIN--",tagIN)
			for kk,tagBD in base.pairs(a_tagsU) do
	--			base.print("--tagBD--",tagBD, tagIN == tagBD)
				if tagIN == tagBD and enableTbl[name] == nil then
					enableTbl[name] = name
					base.table.insert(result, name)
				end
			end
		end			
	end
	
	if a_enablePlayerCanDrive then
		base.table.insert(result, 'Player Drivable')
	end
	
	return result
end


-------------------------------------------------------------------------------
--возвращает ID задачи по имени
function getTaskWorldID(taskName)
  if not taskNames__ then
    -- создадим таблицу для быстрого поиска
    taskNames__ = {}
    for _tmp, task in pairs(db.Units.Planes.Tasks) do
      taskNames__[task.Name] = task.WorldID
    end
  end
  
  if not taskNames__[taskName] then
    print('Task ' .. taskName .. ' is not presented in db.Units.Planes.Tasks table!')
  end
  
  return taskNames__[taskName]
end

-------------------------------------------------------------------------------
--возвращает OldID задачи по имени
function getTaskOldID(taskName)
  if not taskOldIDbyNames__ then
    -- создадим таблицу для быстрого поиска
    taskOldIDbyNames__ = {}
    for _tmp, task in pairs(db.Units.Planes.Tasks) do
      taskOldIDbyNames__[task.Name] = task.OldID
    end
  end
  
  if not taskOldIDbyNames__[taskName] then
    print('Task ' .. taskName .. ' is not presented in db.Units.Planes.Tasks table!')
  end
  
  return taskOldIDbyNames__[taskName]
end

function getCategoryByType(a_unitType)
	if plane_by_type[a_unitType] then
		return "Plane"
	end
	if helicopter_by_type[a_unitType] then
		return "Helicopter"
	end
	
	if ship_by_type[a_unitType] then
		return "Ship"
	end
	
	if unit_by_type[a_unitType] and unit_by_type[a_unitType].category then 
		return unit_by_type[a_unitType].category
	end
end