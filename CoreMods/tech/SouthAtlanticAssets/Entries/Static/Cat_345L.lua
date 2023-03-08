local function add_Static(f)
	f.shape_table_data = 
	{
		{
			file  	    = f.ShapeName,
			life		= 100,
			username    = f.Name,
			desrt       = "self",
			classname 	= "lWindmill",
			positioning = "BYNORMAL"
		},
	}
	f.isPutToWater  = false
	f.mapclasskey   = "P0091000076";
	f.attribute     = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
	f.category 		= 'Fortification';
--	
	add_surface_unit(f)
	GT = nil;
end

add_Static({
	ShapeName 		= "cat_345l",
	Name	  		= "345 Excavator",
	DisplayName   	= "Excavator",
	Rate 			= 3,
	Life 			= 3,
})
