--db.Units.Fortifications = {};
--------------------------------------------------------------------------
-- Fortifications
--------------------------------------------------------------------------
local function support_unit(name, displayName, shapeName, shapeNameDestr, life, rate, countries_, isPutToWater, positioning)
	local u = {}
	u.shape_table_data = 
	{
		{
			file  	    = shapeName,
			life		= life,
			username    = name,
			desrt       = shapeNameDestr,
			classname 	= "lLandVehicle",
			positioning = positioning or "BYNORMAL"	--available: {"BYNORMAL", "ONLYHEIGTH", "BY_XZ", "ADD_HEIGTH"}
		},
		{
			name  = shapeName,
			file  = shapeNameDestr,
		},
	}
	u.Name = name;
	u.DisplayName = displayName;
	u.Life = life;
	u.Rate = rate;
	u.category = 'ADEquipment';
	u.Countries = countries_;
	u.isPutToWater = isPutToWater; -- allows object to be placed only on water
	
	u.mapclasskey = "P0091000076";
	u.attribute = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
	
	add_surface_unit(u)
	GT = nil;
end

--- BEGIN Fortifications
support_unit("AS32-p25", _("AS32-P25"), "AS32-p25", "", 3, 1, {"USA"}, false);
support_unit("AS32-31A", _("AS32-31A"), "AS32-31A", "", 3, 1, {"USA"}, false);
support_unit("AS32-32A", _("AS32-32A"), "AS32-32A", "", 3, 1, {"USA"}, false);
support_unit("AS32-36A", _("AS32-36A"), "AS32-36A", "", 3, 1, {"USA"}, false);

local function add_fortification(f)
	if(f) then
		f.shape_table_data = 
		{
			{
				file  	    = f.ShapeName,
				life		= f.Life,
				username    = f.Name,
				desrt       = f.ShapeNameDestr,
			    classname 	= "lLandVehicle",
				positioning = f.positioning or "BYNORMAL"	--available: {"BYNORMAL", "ONLYHEIGTH", "BY_XZ", "ADD_HEIGTH"}
			},
			{
				name  = f.ShapeName,
				file  = f.ShapeNameDestr,
			},
		}
		f.mapclasskey = "P0091000076";
		f.attribute = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
		
		add_surface_unit(f)
		GT = nil;
	else
		error("Can't add fortification")
	end;
end

local function fortification( name, displayName, shape, shape_destr, life, rate, countries_, isPutToWater, positioning_)
    local res = {};
    
    res.Name = name;
    res.DisplayName = displayName;
    res.ShapeName = shape;
	res.ShapeNameDestr = shape_dstr;
	res.Life = life;
    res.Rate = rate;
    res.category = 'Fortification';
	res.Countries = countries_;
	res.isPutToWater = isPutToWater; -- allows object to be placed only on water
	res.positioning = positioning_;
	
	add_fortification(res)
end

local function add_personnel(f)
	if(f) then
		f.shape_table_data = 
		{
			{
				file  	    = f.ShapeName,
				life		= f.Life,
				username    = f.Name,
				desrt       = f.ShapeNameDestr,
			    classname 	= "lHuman",
				positioning = f.positioning or "BYNORMAL"	--available: {"BYNORMAL", "ONLYHEIGTH", "BY_XZ", "ADD_HEIGTH"}
			},
			{
				name  = f.ShapeName,
				file  = f.ShapeNameDestr,
			},
		}
		f.mapclasskey = "P0091000201";
		f.attribute = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
		
		add_surface_unit(f)
		GT = nil;
	else
		error("Can't add personnel")
	end;
end

local function personnel( name, displayName, shape, shape_destr, life, rate, countries_, isPutToWater, positioning_)
    local res = {};
    
    res.Name = name;
    res.DisplayName = displayName;
    res.ShapeName = shape;
	res.ShapeNameDestr = shape_dstr;
	res.Life = life;
    res.Rate = rate;
    res.category = 'Personnel';
	res.Countries = countries_;
	res.isPutToWater = isPutToWater; -- allows object to be placed only on water
	res.positioning = positioning_;
	
	add_personnel(res)
end

personnel("us carrier shooter",     _("Carrier Shooter"),    "carrier_shooter",      "", 250, 20, {"USA"});
personnel("us carrier tech",        _("Carrier Technician"),   "carrier_tech_USA",     "", 250, 20, {"USA"});
personnel("Carrier Seaman",         _("Carrier Seaman"),        "carrier_seaman_USA",   "", 250, 20, {"USA"});
personnel("Carrier Airboss",        _("Carrier Airboss"),       "carrier_airboss_USA",  "", 250, 20, {"USA"});
personnel("Carrier LSO Personell",  _("Carrier LSO 1"), "carrier_lso_usa",      "", 250, 20, {"USA"});
personnel("Carrier LSO Personell 1",  _("Carrier LSO 2"), "carrier_lso1_usa",      "", 250, 20, {"USA"});
personnel("Carrier LSO Personell 2",  _("Carrier LSO 3"), "carrier_lso2_usa",      "", 250, 20, {"USA"});
personnel("Carrier LSO Personell 3",  _("Carrier LSO 4"), "carrier_lso3_usa",      "", 250, 20, {"USA"});
personnel("Carrier LSO Personell 4",  _("Carrier LSO 5"), "carrier_lso4_usa",      "", 250, 20, {"USA"});
personnel("Carrier LSO Personell 5",  _("Carrier LSO 6"), "carrier_lso5_usa",      "", 250, 20, {"USA"});
