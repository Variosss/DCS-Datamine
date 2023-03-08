local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.2

A11_CLOCK_FAILURE		= 0

Damage = {	
{Failure = A11_CLOCK_FAILURE, 	  Failure_name = "A11_CLOCK_FAILURE", Failure_editor_name = _("Clock failure"),  Element = 0, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- close lua state after initialization 