local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.2

CLOCK_FAILURE = 0
Damage = {	{Failure = CLOCK_FAILURE, Failure_name = "CLOCK_FAILURE", Failure_editor_name = _("Digital Clock"),  Element = 4, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

need_to_be_closed = true -- close lua state after initialization 
