MPCD_NAME	= "MPCDR"

dofile(LockOn_Options.script_path.."MPCD/device/MPCD_Device.lua")

local gettext = require("i_18n")
_ = gettext.translate

MPCDR_FAILURE = 0

Damage = {	
	{
		Failure = MPCDR_FAILURE, 
		Failure_name = "MPCD_RIGHT_FAILURE", 
		Failure_editor_name = _("MPCD Right"),  
		Element = 4, 
		Integrity_Treshold = 0.8, 
		work_time_to_fail_probability = 0.5, 
		work_time_to_fail = 3600*300
	}
}

need_to_be_closed = true