local gettext = require("i_18n")
_ = gettext.translate

---- Damages
PILOT_KILLED_FAILURE		= 0
COPILOT_KILLED_FAILURE		= 1
RIGHT_GUNNER_KILLED_FAILURE	= 2
LEFT_GUNNER_KILLED_FAILURE	= 3
PILOT_KILLED_FAILURE_1 		= 4
COPILOT_KILLED_FAILURE_1 	= 5

Damage = {	
{Failure = PILOT_KILLED_FAILURE, Failure_name = "PILOT_KILLED_FAILURE", Failure_editor_name = _("First Pilot Killed"), Element = 22, Integrity_Treshold = 0.0, Slope_param = 10.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = COPILOT_KILLED_FAILURE, Failure_name = "COPILOT_KILLED_FAILURE", Failure_editor_name = _("Second Pilot Killed"), Element = 21, Integrity_Treshold = 0.0, Slope_param = 10.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = RIGHT_GUNNER_KILLED_FAILURE, Failure_name = "RIGHT_GUNNER_KILLED_FAILURE", Failure_editor_name = _("Right Gunner Killed"), Element = 24, Integrity_Treshold = 0.2, Slope_param = 10.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = LEFT_GUNNER_KILLED_FAILURE, Failure_name = "LEFT_GUNNER_KILLED_FAILURE", Failure_editor_name = _("Left Gunner Killed"), Element = 23, Integrity_Treshold = 0.2, Slope_param = 10.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
