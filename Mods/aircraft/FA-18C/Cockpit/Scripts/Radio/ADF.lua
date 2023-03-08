--
local gettext = require("i_18n")
_ = gettext.translate

--
device_timer_dt = 0.2

--
goniometer = {isLagElement = true, T1 = 0.3, bias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(0.2)}}}

--
FAILURE_ADF_ANT		= 0
FAILURE_ADF_TOTAL	= 1

Damage = {	
	{Failure = FAILURE_ADF_ANT,		Failure_name = "FAILURE_ADF_ANT",	Failure_editor_name = _("ADF Antenna FAILURE"),	Element = 1,	Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},	-- TODO: element
	{Failure = FAILURE_ADF_TOTAL,	Failure_name = "FAILURE_ADF_TOTAL",	Failure_editor_name = _("ADF Total FAILURE"),	Element = 82,	Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},	-- TODO: element
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()