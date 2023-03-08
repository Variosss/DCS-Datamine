local function add_windturbine(f)
	f.shape_table_data = 
	{
		{
			file  	    = f.ShapeName,
			life		= 100,
			username    = f.Name,
			desrt       = "self",
			classname 	= "SATM::WindGenerator",
			positioning =  "NO" -- "ADD_HEIGTH"
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
	ShapeName 		= "offshore_windturbine",
	Name	  		= "offshore WindTurbine",
	DisplayName   	= "Offshore Wind Turbine",
	Rate 				= 3,
	Life 				= 3,
	classname		= "OffshoreTurbine",

})
add_windturbine({
	ShapeName 		= "offshore_windturbine2",
	Name	  			= "offshore WindTurbine2",
	DisplayName   = "Offshore Wind Turbine 2",
	Rate 					= 3,
	Life 					= 3,
	classname 		= "OffshoreTurbine",
})




