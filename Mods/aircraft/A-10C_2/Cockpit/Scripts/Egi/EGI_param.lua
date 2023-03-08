local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt			= 0.04
coordinates_update_dt 	= 0.3

EGI_FAILURE_TOTAL	= 0

Damage = {	{Failure = EGI_FAILURE_TOTAL, Failure_name = "EGI_FAILURE_TOTAL", Failure_editor_name = _("EGI total failure"),  Element = 10, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*350},
}

need_to_be_closed = true -- close lua state after initialization 