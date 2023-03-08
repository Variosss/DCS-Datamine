MPCD_NAME	= "MPCDL"

dofile(LockOn_Options.script_path.."MPCD/device/MPCD_Device.lua")

local gettext = require("i_18n")
_ = gettext.translate

MPCDL_FAILURE = 0

Damage = {	
	{
		Failure = MPCDL_FAILURE, 
		Failure_name = "MPCD_LEFT_FAILURE", 
		Failure_editor_name = _("MPCD Left"),  
		Element = 4, 
		Integrity_Treshold = 0.8, 
		work_time_to_fail_probability = 0.5, 
		work_time_to_fail = 3600*300
	}
}

need_to_be_closed = true