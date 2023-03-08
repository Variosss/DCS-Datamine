local function add_NoddingDonkey(f)
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

add_NoddingDonkey({
	ShapeName 		= "Nodding_Donkey",
	Name	  		= "Nodding_Donkey_Pump",
	DisplayName   	= "Nodding Donkey Pump",
	Rate 			= 3,
	Life 			= 100,
})