shape_name		   = "ns430"

-- attachment point in parent shape
attachment_point_connector = "G430_placement";

--parse_shape_to_render = false

-- in case of missed connector 
-- float yaw	 = config.get("yaw", 0.0f);
-- float pitch	 = config.get("pitch", 0.0f);
-- float roll	 = config.get("roll", 0.0f);

-- init_pos.RotateY(yaw);
-- init_pos.RotateZ(pitch);
-- init_pos.RotateX(roll);

-- init_pos.p.x = config.get("x", 0.0f);
-- init_pos.p.y = config.get("y", 0.0f);
-- init_pos.p.z = config.get("z", 0.0f);


local  aircraft = get_aircraft_type()

restricted_to = {}
restricted_to.viewport = false

local function check_3D_raw(option_entry)
		local opt_value =  get_plugin_option_value("NS430",option_entry,"track")

		if  opt_value == nil then
			opt_value =  get_plugin_option_value("NS430",option_entry,"local")
		end

		if not opt_value then 
			restricted_to.viewport = true;
		end
end

local function check_3D(unit,option_entry)
	if aircraft == unit then
		check_3D_raw(option_entry)
	end
end

check_3D("Mi-8MT" ,"mi8_3D_enabled");
check_3D("C-101CC","c101cc_3D_enabled");
check_3D("C-101EB","c101eb_3D_enabled");
check_3D("Christen Eagle II","CEII_3D_enabled");

if 	string.find(aircraft,"SA342") ~= nil then
	check_3D_raw("sa342_3D_enabled")
end 

if aircraft == "L-39C" then

	ASP_disabled =  get_aircraft_property("DismountGunSight") > 0
	if ASP_disabled then 
		check_3D("L-39C" ,"l39c_3D_enabled")
	else
		restricted_to.viewport = true;
	end
end

if  aircraft == "L-39C" or 
    aircraft == "L-39ZA" then
	attachment_position 	   =
	{
		yaw   = 0;
		pitch = 0;
		roll  = 0;
		x =  -0.775561;
		y =   0;
		z =   0;
	}
else
	attachment_position 	   =
	{
		yaw   = 0;
		pitch = math.rad(30);
		roll  = 0;
		x =   0.57; -- forward 0.57 meters
		y =  -0.59; -- down 0.59
		z =   0;
	}
end  

local controllers = LoRegisterPanelControls()
	
glow                    = CreateGauge()
glow.arg_number         = 70
glow.input              = {0,1}
glow.output             = {0,1}
glow.controller         = controllers.glow

----
-- DONE
----
need_to_be_closed  = true -- close lua state after initialization