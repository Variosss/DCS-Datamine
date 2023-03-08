local function add_structure(f)
	if(f) then
		f.shape_table_data = 
		{
			{
				file  	    = f.ShapeName,
				life		= f.Life,
				username    = f.Name,
				desrt       = f.ShapeNameDestr or "self",
			    classname 	= f.classname   or "lLandVehicle",
				positioning = f.positioning or "BYNORMAL"	--available: {"BYNORMAL", "ONLYHEIGTH", "BY_XZ", "ADD_HEIGTH"}
			}
		}
		if f.ShapeNameDestr then
			f.shape_table_data[#f.shape_table_data + 1] = 
			{
				file  = f.ShapeNameDestr,	
				iscrashmodel = true,
                fire         = {
                                f.fireTime or 0,
                                f.fireIntencity or 1,
                            },
                expMass        = f.explMass or 0,
			}
		end
		
		
		f.mapclasskey = "P0091000076";
		f.attribute = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
		
		add_surface_unit(f)
		GT = nil;
	else
		error("Can't add structure")
	end;
end



add_structure({
Name 		 =  "Oil rig",
DisplayName  = _("Oil rig"),
ShapeName	 =   "oil_platform",
Life		 =  2500,
Rate		 =  100,
category     =  'Heliport',
subCategory	 =  'SeaShelfObject', -- only for ME
SeaObject    = 	true,
isPutToWater =  true,
positioning  = 	"NO",
classname    =  "lOilPlatform",
numParking   =  1,
})


add_structure({
Name 		 =  "Gas platform",
DisplayName  = _("Gas platform"),
ShapeName	 =   "gas_platform",
Life		 =  2500,
Rate		 =  100,
category     =  'Heliport',
subCategory	 =  'SeaShelfObject', -- only for ME
SeaObject    = 	true,
isPutToWater =  true,
positioning  = 	"NO",
classname    =  "lGasPlatform",
numParking   =  1,
})

add_structure({
Name 		 =  "container_40ft",
DisplayName  = _("Container 40ft"),
ShapeName	 =   "container_40ft",
ShapeNameDestr = "container_40ft_p_1",
Life		 =  5,
Rate		 =  1,
category     =  'Fortification',
})

add_structure({
Name 		 =  "container_20ft",
DisplayName  = _("Container 20ft"),
ShapeName	 =   "container_20ft",
ShapeNameDestr = "container_20ft_p_1",
Life		 =  4,
Rate		 =  1,
category     =  'Fortification',
})
