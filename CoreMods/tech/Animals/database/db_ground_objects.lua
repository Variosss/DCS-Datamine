local function add_animal(f)
	if (f) then
		f.shape_table_data = 
		{
			{
				file  	    = f.ShapeName,
				life		= f.Life,
				username    = f.Name,
				desrt       = f.ShapeNameDestr,
			    classname 	= "lAnimal",
				positioning = f.positioning or "BYNORMAL",	--available: {"BYNORMAL", "ONLYHEIGTH", "BY_XZ", "ADD_HEIGTH"}
                fire  = { 60, 2},
			},
			{
				name  = f.ShapeNameDestr,
				file  = f.ShapeNameDestr,
                life  = 0,
                fire  = { 0, 2},
			},
		}
		f.mapclasskey = f.mapclasskey;
		f.attribute = {wsType_Static, wsType_Standing, wsType_Civil} -- if 'attribute' == nil then insertion will be aborted
		
		add_surface_unit(f)
		GT = nil;
	else
		print("Can't add animal")
	end;
end;

local function animal( name, displayName, shape, shapeDstr, life, rate, countries_, seaObject, positioning_)
    local res = {};
    res.Name = name;
    res.DisplayName = displayName;
    res.ShapeName = shape;
	res.ShapeNameDestr = shapeDstr;
	res.Life = life;
    res.Rate = rate;
    res.category = 'Animal'    
	res.mapclasskey = "P_COW";
    res.SeaObject = seaObject; -- allows object to be placed only on water
    res.canExplode = false;
    res.positioning = positioning_;
    res.sound = 'Animals/Cow';
    res.sound_interval = {30, 200};
    add_animal(res); 
end

animal( "Cow", _("Cow"), "Cow", "Cow_d", 0.05, 2) 
