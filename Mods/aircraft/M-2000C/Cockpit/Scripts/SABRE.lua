dofile(LockOn_Options.script_path.."dmgzones.lua")

local gettext = require("i_18n")
_ = gettext.translate


SABRE_NO_FAIL			= 0
SABRE_FAILURE_TOTAL		= 1
SABRE_FAILURE_ANTENNA_F	= 2
SABRE_FAILURE_ANTENNA_B	= 3

Damage = {	
	{Failure = SABRE_FAILURE_TOTAL,		Failure_name = "SABRE_FAILURE_TOTAL",      Failure_editor_name = _("Sabre total failure"),   		Element = dmgz["CABIN_LEFT_SIDE"], Integrity_Treshold = 0.95, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = SABRE_FAILURE_TOTAL,		Failure_name = "SABRE_FAILURE_ANTENNA_F",  Failure_editor_name = _("Sabre front antenna failure"),  Element = dmgz["FIN_L_TOP"], Integrity_Treshold = 0.80, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = SABRE_FAILURE_TOTAL,		Failure_name = "SABRE_FAILURE_ANTENNA_B",  Failure_editor_name = _("Sabre back antenna failure"),	Element = dmgz["PYLON3"], Integrity_Treshold = 0.80, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true
