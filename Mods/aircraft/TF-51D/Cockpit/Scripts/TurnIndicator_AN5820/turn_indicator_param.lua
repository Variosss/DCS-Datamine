local gettext = require("i_18n")
_ = gettext.translate

-- Timer update time
device_timer_dt = 0.04

valmax = math.rad(3)
valmin = -valmax
turnNeedle = {valmin = valmin, valmax = valmax, isLagElement = true, T1 = 0.4, wmax = 0,
	bias = {{valmin = valmin, valmax = valmax, bias = 0.001}}}

slipBall = {dt = 0.015, tubeLen = 0.0582, tubeSector = math.rad(30)}
	
TURNIND_POINTER_FAILS_NO_VACUUM	= 0
TURNIND_POINTER_FAILS_DEFECTIVE	= 1
TURNIND_INCORRECT_SENS_DEFECTIVE= 2
TURNIND_INCORRECT_SENS_VAC_HIGH	= 3
TURNIND_INCORRECT_SENS_VAC_LOW	= 4
TURNIND_POINTER_NOT_SET_ZERO	= 5
TURNIND_POINTER_VIBRATES		= 6

Damage = {	
	{Failure = TURNIND_POINTER_FAILS_NO_VACUUM, Failure_name = "TURNIND_POINTER_FAILS_NO_VACUUM", Failure_editor_name = _("Turn ind. No vacuum to instrument"),  Element = 3, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TURNIND_POINTER_FAILS_DEFECTIVE, Failure_name = "TURNIND_POINTER_FAILS_DEFECTIVE", Failure_editor_name = _("Turn ind. Defective instrument"),  Element = 3, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TURNIND_INCORRECT_SENS_DEFECTIVE, Failure_name = "TURNIND_INCORRECT_SENS_DEFECTIVE", Failure_editor_name = _("Turn ind. Defective instrument"),  Element = 3, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TURNIND_INCORRECT_SENS_VAC_HIGH, Failure_name = "TURNIND_INCORRECT_SENS_VAC_HIGH", Failure_editor_name = _("Turn ind. Vacuum high"),  Element = 3, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TURNIND_INCORRECT_SENS_VAC_LOW, Failure_name = "TURNIND_INCORRECT_SENS_VAC_LOW", Failure_editor_name = _("Turn ind. Vacuum low"),  Element = 3, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TURNIND_POINTER_NOT_SET_ZERO, Failure_name = "TURNIND_POINTER_NOT_SET_ZERO", Failure_editor_name = _("Turn ind. Defective instrument"),  Element = 3, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TURNIND_POINTER_VIBRATES, Failure_name = "TURNIND_POINTER_VIBRATES", Failure_editor_name = _("Turn ind. Excessive vibration"),  Element = 3, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
