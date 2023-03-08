local function add_lighthouse(f)
	f.shape_table_data = 
	{
		{
			file  	    = f.ShapeName,
			life		= 100,
			username    = f.Name,
			desrt       = "self",
			classname 	= "SATM::WindGenerator",
			positioning = "ADD_HEIGTH"
		},
	}
	f.isPutToWater  = true
	f.mapclasskey   = "P0091000076";
	f.attribute     = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
	f.category 		= 'Fortification';
--	
	add_surface_unit(f)
	GT = nil;
end

add_lighthouse({
	ShapeName 		= "Small_LightHouse",
	Name	  		= "Small_LightHouse",
	DisplayName   	= "Small_LightHouse",
	Rate 			= 3,
	Life 			= 3,
})