local function add_windturbine(f)
	f.shape_table_data = 
	{
		{
			file  	    = f.ShapeName,
			life		= 100,
			username    = f.Name,
			desrt       = "self",
			classname 	= "SATM::WindGenerator",
			positioning =  "BYNORMAL" -- "ADD_HEIGTH"
		},
	}
	f.isPutToWater  = false;
	f.seaObject		= false;
	f.mapclasskey   = "P0091000076";
	f.attribute     = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
	f.category 		= 'Fortification';

	add_surface_unit(f)
	GT = nil;
end

add_windturbine({
	ShapeName 		= "Orca",
	Name	  			= "Orca",
	DisplayName   = "Orca Whale",
	Rate 					= 3,
	Life 					= 3,
	classname 		= "OffshoreTurbine",
})
add_windturbine({
	ShapeName 	= "WindTurbine_10",
	Name	  		= "WindTurbine",
	DisplayName = "Wind Turbine",
	Rate 				= 3,
	Life 				= 3,
	classname		= "WindGenerator",

})
add_windturbine({
	ShapeName 	= "WindTurbine_11",
	Name	  		= "WindTurbine_11",
	DisplayName = "Wind Turbine 2",
	Rate 				= 3,
	Life 				= 3,
	classname		= "WindGenerator",

})

add_windturbine({
	ShapeName 	= "billboard_motorized",
	Name	  		= "billboard_motorized",
	DisplayName = "Billboard Motorized",
	Rate 				= 3,
	Life 				= 3,
	classname		= "WindGenerator",

})



