range_scale 		  = 60000.0
TDC_range_carret_size = 2000.0


perfomance = 
{
	tracking_azimuth   = { -math.rad(30),math.rad(30)},
	tracking_elevation = { -math.rad(30),math.rad(30)},
	
	scan_volume_azimuth 	= math.rad(60),
	scan_volume_elevation	= math.rad(20),
	scan_beam				= math.rad(20)/3.0,-- three lines of scan
	scan_speed				= math.rad(150),
	max_available_distance  = 60000.0,
	dead_zone 				= 300.0,
	
	ground_clutter =
	{-- spot RCS = A + B * random + C * random 
		sea		   	   = {0 ,0,0},
		land 	   	   = {0 ,3,3},		
		artificial 	   = {1 ,5,5},
		max_distance   = 30000.0
	}
}

function SetCommand(command,value)

end

local gettext = require("i_18n")
_ = gettext.translate

-- RADARASS = 22
-- RADARDISPL = 23

-- Damage =
-- {
	-- {
		-- Failure = RADARASS,
		-- Failure_name = "RADARASS",
		-- Failure_editor_name = _("RADARASS"),
		-- Element = 0,
		-- Integrity_Treshold = 0.0,
		-- Slope_param = 10.0,
		-- work_time_to_fail_probability = 0.5,
		-- work_time_to_fail = 3600*300
	-- },	
	-- {
		-- Failure = RADARDISPL,
		-- Failure_name = "RADARDISPL",
		-- Failure_editor_name = _("RADARDISPL"),
		-- Element = 0,
		-- Integrity_Treshold = 0.0,
		-- Slope_param = 10.0,
		-- work_time_to_fail_probability = 0.5,
		-- work_time_to_fail = 3600*300
	-- },	
	
-- }

need_to_be_closed = true