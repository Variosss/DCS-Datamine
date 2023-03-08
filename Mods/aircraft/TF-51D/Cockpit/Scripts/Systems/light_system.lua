local gettext = require("i_18n")
_ = gettext.translate

night_start_time = 19.0 -- in hours
night_end_time = 7.0

cockpit_instr_illumination_external = 69
cockpit_lights_illumination_external = 446

ElecConsumerParamsFluorLight       = {10, true}
ElecLampParamsFluorLight       	   = {brightnessMinVal = 0.3}

ElecConsumerParamsCptLight         = {15, true}
ElecLampParamsCptLight         	   = {brightnessMinVal = 0}

ElecConsumerParamsPositionLight    = {20, true}
ElecConsumerParamsRecognitionLight = {20, true}
ElecConsumerParamsLandingLight     = {200, true}

ELEC_NAVLIGHT_RED_FAILURE   = 0
ELEC_NAVLIGHT_GREEN_FAILURE = 1
ELEC_NAVLIGHT_WHITE_FAILURE = 2

Damage = {
	{Failure = ELEC_NAVLIGHT_RED_FAILURE,   Failure_name = "ELEC_NAVLIGHT_RED_FAILURE",   Failure_editor_name = _("LH nav. light failure"),  Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.05, work_time_to_fail = 3600*300},
	{Failure = ELEC_NAVLIGHT_GREEN_FAILURE, Failure_name = "ELEC_NAVLIGHT_GREEN_FAILURE", Failure_editor_name = _("RH nav. light failure"),  Element = 3, Integrity_Treshold = 0.1,  work_time_to_fail_probability = 0.05, work_time_to_fail = 3600*300},
	{Failure = ELEC_NAVLIGHT_WHITE_FAILURE, Failure_name = "ELEC_NAVLIGHT_WHITE_FAILURE", Failure_editor_name = _("Aft nav. light failure"), Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.05, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- close lua state after initialization