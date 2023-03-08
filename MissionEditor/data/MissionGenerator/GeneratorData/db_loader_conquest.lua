
local base = _G
dofile(db_path.."db_attributes.lua");

unit_by_type = {}
  
-- replays name with display name
function hackNames(unitsList)
    for i,v in pairs(unitsList) do
        v.type = v.Name
    end
end

hackNames(db.Units.Planes.Plane)
for i,v in pairs(db.Units.Planes.Plane) do
	if v.type ~= nil then
		unit_by_type[v.type] = v
		base.print("Planes : ",unit_by_type[v.type].DisplayName)
	end
end

hackNames(db.Units.Helicopters.Helicopter)
for i,v in pairs(db.Units.Helicopters.Helicopter) do
	if v.type ~= nil then
		unit_by_type[v.type] = v
	end
end
  
hackNames(db.Units.Ships.Ship)
for i,v in pairs(db.Units.Ships.Ship) do
	if v.type ~= nil then
		unit_by_type[v.type] = v
	end
end

hackNames(db.Units.Cars.Car) 
local isNeedAddTrain = false
for i,v in pairs(db.Units.Cars.Car) do
	if v.type ~= nil then
		unit_by_type[v.type] = v
	end
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
	unit_by_type[unit.type] = unit
end
-------------------------------------------------------------------