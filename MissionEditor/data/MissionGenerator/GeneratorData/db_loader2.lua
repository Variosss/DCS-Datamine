
local base = _G
dofile(db_path.."db_years.lua");
dofile(db_path.."db_attributes.lua");


-------------------------------------------------------------------
-- Fill DB
-------------------------------------------------------------------
-- replays name with display name
function hackNames(unitsList)
    for i,v in pairs(unitsList) do
        displayNameByName[v.Name] = v.DisplayName
        nameByDisplayName[v.DisplayName] = v.Name
        v.type = v.Name
        v.Name = v.DisplayName
    end
end

unit_by_name = {}
unit_by_type = {}
  
displayNameByName = {}
nameByDisplayName = {}
  
seaPlane = {}
seaHelicopter = {}


plane_by_type = {}
--base.print('seaPlanes:')
--hackNames(db.Units.Planes.Plane)
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
--hackNames(db.Units.Helicopters.Helicopter)
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
  
--hackNames(db.Units.Ships.Ship)
ship_by_type = {}
for i,v in pairs(db.Units.Ships.Ship) do
	ship_by_type[v.type] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
 
--hackNames(db.Units.Cars.Car)
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

--hackNames(db.Units.GroundObjects.GroundObject)
ground_object_by_name = {}
for i,v in pairs(db.Units.GroundObjects.GroundObject) do
	ground_object_by_name[v.Name] = v
end

--hackNames(db.Units.Fortifications.Fortification)
fortification_by_name = {}
for i,v in pairs(db.Units.Fortifications.Fortification) do
	fortification_by_name[v.Name] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end

--hackNames(db.Units.Heliports.Heliport)
heliport_by_type = {}
for i,v in pairs(db.Units.Heliports.Heliport) do
	heliport_by_type[v.type] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
  
--hackNames(db.Units.GrassAirfields.GrassAirfield)
grassairfield_by_name = {}
for i,v in pairs(db.Units.GrassAirfields.GrassAirfield) do
	grassairfield_by_name[v.Name] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
  
--hackNames(db.Units.Warehouses.Warehouse)
warehouse_by_name = {}
for i,v in pairs(db.Units.Warehouses.Warehouse) do
	warehouse_by_name[v.Name] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
  
--hackNames(db.Units.Cargos.Cargo)
cargo_by_name = {}
for i,v in pairs(db.Units.Cargos.Cargo) do
	cargo_by_name[v.Name] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
  
--hackNames(db.Units.Effects.Effect)
for i,v in pairs(db.Units.Effects.Effect) do
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
  
--hackNames(db.Units.LTAvehicles.LTAvehicle)
LTAvehicle_by_name = {}
for i,v in pairs(db.Units.LTAvehicles.LTAvehicle) do
	LTAvehicle_by_name[v.Name] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
  
--hackNames(db.Units.Animals.Animal)
Animal_by_name = {}
for i,v in pairs(db.Units.Animals.Animal) do
	Animal_by_name[v.Name] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
  
--hackNames(db.Units.Personnel.Personnel)
Personnel_by_name = {}
for i,v in pairs(db.Units.Personnel.Personnel) do
	Personnel_by_name[v.Name] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
  
--hackNames(db.Units.ADEquipments.ADEquipment)
ADEquipment_by_name = {}
for i,v in pairs(db.Units.ADEquipments.ADEquipment) do
	ADEquipment_by_name[v.Name] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
  
--hackNames(db.Units.WWIIstructures.WWIIstructure)
WWIIstructure_by_name = {}
for i,v in pairs(db.Units.WWIIstructures.WWIIstructure) do
	WWIIstructure_by_name[v.Name] = v
	unit_by_name[v.Name] = v
	unit_by_type[v.type] = v
end
-------------------------------------------------------------------

function checkUnitInArray(type)
	if unit_by_type[type] ~= nil then
		return true
	end
	return false
end
