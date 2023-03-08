-- Radar Altimeter
local gettext = require("i_18n")
_ = gettext.translate

device_pos = {-5.52, -0.742, -0.02}

alt_needle = {
valmin = 0.0, 
valmax = 0.98, 
T1 = 0.75, T2 = 0.316, wmax = 0, 
bias = {{valmin = 0.0, valmax = 0.98, bias = 0.001}}}

alt_needle_adapter = { 
native =  {0.0, 200.0, 1500.0, 2000.0},
animation = {0.0, 0.487, 0.747,  0.98 }}


off_flag = {valmin = 0, valmax = 1, dvalue = 11}

distance_lim = 5000
distance_lim_precise = 5010

ElecConsumerParamsWarningLight = {0.5, true}
ElecConsumerParamsDigitLight = {0.2, true}

antenna_limits = {
	pitch_min = math.rad(-30.0),
	pitch_max = math.rad(30.0),
	roll_min = math.rad(-45.0),
	roll_max = math.rad(45.0)
}

MaxTimeToWarm = 5.0

RALT_FAILURE_TOTAL			= 0
RALT_FAILURE_TRANSMITTER	= 1
RALT_FAILURE_RECEIVER		= 2

--TODO добавить номер элемента для повреждения
Damage = {	{Failure = RALT_FAILURE_TOTAL, Failure_name = "RALT_FAILURE_TOTAL", Failure_editor_name = _("Radar altimeter total failure"), Element = 1, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
			{Failure = RALT_FAILURE_TRANSMITTER, Failure_name = "RALT_FAILURE_TRANSMITTER", Failure_editor_name = _("Radar altimeter transmitter"), Element = 1, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
			{Failure = RALT_FAILURE_RECEIVER, Failure_name = "RALT_FAILURE_RECEIVER", Failure_editor_name = _("Radar altimeter receiver"), Element = 1, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}


need_to_be_closed = true -- lua_state  will be closed in post_initialize()