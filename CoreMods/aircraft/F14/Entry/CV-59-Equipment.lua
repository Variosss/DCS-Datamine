
--------------------------------------------------------------------------
-- Support units
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
	
	u.mapclasskey = "P0091000079";
	u.attribute = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
	
	add_surface_unit(u)
	GT = nil;
end

support_unit("CV_59_H60", _("CV-59 Hyster 60"), "CV_59_H60", "", 3, 1, {"USA"}, false);
support_unit("CV_59_Large_Forklift", _("CV-59 Large Forklift"), "CV_59_Large_Forklift", "", 3, 1, {"USA"}, false);
support_unit("CV_59_MD3", _("CV-59 MD-3 Mule (Early)"), "CV_59_MD3", "", 3, 1, {"USA"}, false);
support_unit("CV_59_NS60", ("CV-59 NS-60 Tilly"), "CV_59_NS60", "", 3, 1, {"USA"}, false);

--support_unit("HB_NS60_Tilly", _("AS32-36A"), "AS32-36A", "", 3, 1, {"USA"}, false);
