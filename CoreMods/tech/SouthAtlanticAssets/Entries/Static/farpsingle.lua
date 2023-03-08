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
				name  = f.ShapeName,
				file  = f.ShapeNameDestr,	
			}
		end
		
		
		f.mapclasskey = "P0091000022";
		f.attribute = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
		
		add_surface_unit(f)
		GT = nil;
	else
		error("Can't add structure")
	end;
end

add_structure({
    Name 		 =  "FARP_SINGLE_01",
    DisplayName  = _("PAD Single"),
    ShapeName	 =   "FARP_SINGLE_01",
    Life		 =  2500,
    Rate		 =  100,
    category     =  'Heliport',
    SeaObject    = 	true,
    isPutToWater =  true,
    positioning  = 	"YES",
    classname    =  "lOilPlatform",
    -- classname    =  "lHeliport",
    numParking   =  1,
    })
    