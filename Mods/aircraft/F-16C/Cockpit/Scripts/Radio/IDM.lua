--
local gettext = require("i_18n")
_ = gettext.translate

--
need_to_be_closed = true -- lua_state  will be closed in post_initialize()
device_timer_dt = 0.05



--[[
FAILURE_IDM_ANT		= 0
FAILURE_IDM_TOTAL	= 1

Damage = {	
	{Failure = FAILURE_IDM_ANT,		Failure_name = "FAILURE_IDM_ANT",	Failure_editor_name = _("IDM Antenna FAILURE"),	Element = 1,	Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},	-- TODO: element
	{Failure = FAILURE_IDM_TOTAL,	Failure_name = "FAILURE_IDM_TOTAL",	Failure_editor_name = _("IDM Total FAILURE"),	Element = 82,	Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},	-- TODO: element
}
--]]
