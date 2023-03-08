local function add_Static(f)
	f.shape_table_data = 
	{
		{
			file  	    = f.ShapeName,
			life		= 100,
			username    = f.Name,
			desrt       = "self",
			classname 	= "lLandVehicle",
			positioning = "BYNORMAL",
		},
	}
	f.isPutToWater  = false
	f.mapclasskey   = "P0091000076";
	f.attribute     = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
	f.category 		= 'ADEquipment';
--	
	add_surface_unit(f)
	GT = nil;
end

add_Static({
	ShapeName 		= "SkiRamp_01",
	Name	  		= "Ski Ramp",
	DisplayName   	= "Skiramp",
	category		= 'ADEquipment',
	Rate 			= 3,
	Life 			= 100,
})
add_Static({
	ShapeName 		= "SkiRamp_02",
	Name	  		= "SA Ski Ramp",
	DisplayName   	= "Skiramp02",
	category		= 'ADEquipment',
	Rate 			= 3,
	Life 			= 100,
})