-- Radar Altimeter APN-209
local gettext = require("i_18n")
_ = gettext.translate

device_pos = {-2.1, -0.8, 0.0}

alt_needle = {
valmin = 0.0, 
valmax = 0.98, 
T1 = 0.75, T2 = 0.316, wmax = 0, 
bias = {{valmin = 0.0, valmax = 0.98, bias = 0.001}}}

alt_needle_adapter = { 
native =  {0.0, 200.0, 1500.0, 2000.0},
animation = {0.0, 0.487, 0.747,  0.98 }}


off_flag = {valmin = 0, valmax = 1, dvalue = 11}

distance_lim = 457.2
distance_lim_precise = 470

ElecConsumerParamsWarningLight = {0.5, true}
ElecConsumerParamsDigitLight = {0.2, true}

antenna_limits = {
	pitch_min = math.rad(-30.0),
	pitch_max = math.rad(30.0),
	roll_min = math.rad(-45.0),
	roll_max = math.rad(45.0)
}

TOTAL_FAILURE	= 0

Damage = {
{Failure = TOTAL_FAILURE, Failure_name = "RADAR_ALT_TOTAL_FAILURE", Failure_editor_name = _("Radar altimeter fail"),  Element = 1, Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}


need_to_be_closed = true -- lua_state  will be closed in post_initialize()