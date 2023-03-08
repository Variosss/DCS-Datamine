local gettext = require("i_18n")
_ = gettext.translate

PITOT_HEAT_WIRING	   = 0
PITOT_HEAT_ELEMENT     = 1
BAT_SOLENOID_WIRING	   = 2
BAT_SOLENOID_DEFECTIVE = 3

Damage = {
	{Failure = PITOT_HEAT_WIRING, Failure_name = "PITOT_HEAT_WIRING", Failure_editor_name = _("Pitot. Break in the wiring"),  Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = PITOT_HEAT_ELEMENT, Failure_name = "PITOT_HEAT_ELEMENT", Failure_editor_name = _("Pitot. Heating element burned out"),  Element = 30 --[[wing center right ]], Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = BAT_SOLENOID_WIRING, Failure_name = "BAT_SOLENOID_WIRING", Failure_editor_name = _("Bat. solenoid wiring fault"),  Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = BAT_SOLENOID_DEFECTIVE, Failure_name = "BAT_SOLENOID_DEFECTIVE", Failure_editor_name = _("Bat. solenoid defective"),  Element = 3, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- close lua state after initialization 
