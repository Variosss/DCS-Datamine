dofile(LockOn_Options.script_path.."dmgzones.lua")
local gettext = require("i_18n")
_ = gettext.translate


-- Damages
RWR_FAILURE_SENSOR_TAIL		= 1
RWR_FAILURE_SENSOR_LEFT		= 2
RWR_FAILURE_SENSOR_RIGHT	= 3
RWR_FAILURE_TOTAL			= 4

Damage = {	
	{	Failure = RWR_FAILURE_SENSOR_TAIL,
		Failure_name = "RWR_FAILURE_SENSOR_TAIL",
		Failure_editor_name = _('SPIRALE Tail Sensor'),
		Element = dmgz["FIN_L_TOP"], 
		Integrity_Treshold = 0.90,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300,				
		},
		
	{	Failure = RWR_FAILURE_SENSOR_LEFT,  
		Failure_name = "RWR_FAILURE_SENSOR_LEFT",  
		Failure_editor_name = _('SPIRALE L Sensor'),
		Element = dmgz["WING_L_OUT"],
		Integrity_Treshold = 0.90,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300,
		},

	{
		Failure = RWR_FAILURE_SENSOR_RIGHT, 
		Failure_name = "RWR_FAILURE_SENSOR_RIGHT", 
		Failure_editor_name = _('SPIRALE R Sensor'),
		Element = dmgz["WING_R_OUT"],
		Integrity_Treshold = 0.90,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300,
		},
		
	{	
		Failure = RWR_FAILURE_TOTAL,
		Failure_name = "RWR_FAILURE_TOTAL",
		Failure_editor_name = _('SPIRALE Main'),
		Element = dmgz["CABIN_LEFT_SIDE"],
		Integrity_Treshold = 0.90,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300,
		},
}

need_to_be_closed = true
