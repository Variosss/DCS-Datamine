local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.2

-- meters per second!!!
IAS_pointer = {valmin = 18, valmax = 283, T1 = 0.267, T2 = 0.258}

error_k	= 1.021

maximum_IAS_needle = { 
	arg_number	= 50,
	input		= {  0,    50,   100,   150,   200,   250,   300,   350,   400,   450,   500, 550},
	output		= {0.0, 0.053, 0.146, 0.234, 0.322, 0.412, 0.517, 0.620, 0.719, 0.811, 0.906, 1.0}
}

AIRSPEED_INDICATOR_FAILURE	= 0
Damage = {	{Failure = AIRSPEED_INDICATOR_FAILURE, Failure_name = "AIRSPEED_INDICATOR_FAILURE", Failure_editor_name = _("Airspeed Indicator"),  Element = 4, Integrity_Treshold = 0.9, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}


need_to_be_closed = true -- close lua state after initialization 