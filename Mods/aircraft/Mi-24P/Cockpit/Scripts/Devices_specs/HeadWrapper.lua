local gettext = require("i_18n")
_ = gettext.translate


VR_X_Displacement_L = 0.15
VR_X_Displacement_R = 0.09

---- Damages
PILOT_KILLED_FAILURE		= 0
COPILOT_KILLED_FAILURE		= 1
L_GUNNER_KILLED_FAILURE		= 2
R_GUNNER_KILLED_FAILURE		= 3

Damage = {	
{Failure = PILOT_KILLED_FAILURE, Failure_name = "PILOT_KILLED_FAILURE", Failure_editor_name = _("First Pilot Killed"), Element = 90, Integrity_Treshold = 0.0, Slope_param = 10.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = COPILOT_KILLED_FAILURE, Failure_name = "COPILOT_KILLED_FAILURE", Failure_editor_name = _("Second Pilot Killed"), Element = 91, Integrity_Treshold = 0.0, Slope_param = 10.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = L_GUNNER_KILLED_FAILURE, Failure_name = "L_GUNNER_KILLED_FAILURE", Failure_editor_name = _("Left Gunner Killed"), Element = 93, Integrity_Treshold = 0.0, Slope_param = 10.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = R_GUNNER_KILLED_FAILURE, Failure_name = "R_GUNNER_KILLED_FAILURE", Failure_editor_name = _("Right Gunner Killed"), Element = 92, Integrity_Treshold = 0.0, Slope_param = 10.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
