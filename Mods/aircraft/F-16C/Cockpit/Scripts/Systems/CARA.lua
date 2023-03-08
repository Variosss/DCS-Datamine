-- Radar Altimeter
need_to_be_closed = true -- lua_state  will be closed in post_initialize()

local gettext = require("i_18n")
_ = gettext.translate

device_pos = {4.6, -0.33, 0.0}

distance_lim			= 50000			-- [ft]
distance_lim_precise	= 65000			-- [ft]

antenna_limits = {
	pitch_min = math.rad(-45.0),
	pitch_max = math.rad(45.0),
	roll_min = math.rad(-45.0),
	roll_max = math.rad(45.0)
}

WarmUpTime = 30.0		-- [sec]

-- Failures
CARA_FAILURE_TOTAL		= 0
CARA_FAILURE_RT			= 1
CARA_FAILURE_SDC		= 2
CARA_FAILURE_ANTENNA	= 3
--TODO добавить номер элемента для повреждения
Damage =
{
	{Failure = CARA_FAILURE_TOTAL,		Failure_name = "CARA_FAILURE_TOTAL",	Failure_editor_name = _("Radar altimeter total failure"),			Element = 1, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = CARA_FAILURE_RT,			Failure_name = "CARA_FAILURE_RT",		Failure_editor_name = _("Radar altimeter receiver-transmitter"),	Element = 1, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = CARA_FAILURE_SDC,		Failure_name = "CARA_FAILURE_SDC",		Failure_editor_name = _("Radar altimeter SDC"),						Element = 1, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = CARA_FAILURE_ANTENNA,	Failure_name = "CARA_FAILURE_ANTENNA",	Failure_editor_name = _("Radar altimeter antenna pair"),			Element = 1, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}