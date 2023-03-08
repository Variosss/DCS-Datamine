local gettext = require("i_18n")
_ = gettext.translate
dofile(LockOn_Options.script_path.."command_defs.lua")

--device_timer_dt		= 0.01

BATT_FAIL = 1
TRN_FAIL = 2
TRS_FAIL = 3
ENG_ALT_1_FAIL = 4
ENG_ALT_2_FAIL = 5
HYD_ALT_1_FAIL = 6
HYD_ALT_2_FAIL = 7

Damage = {	
	{Failure = BATT_FAIL,      Failure_name = "BATT_FAIL",      Failure_editor_name = _("Battery Fail"),                Element = 66, Integrity_Treshold = 0.90, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TRN_FAIL,       Failure_name = "TRN_FAIL",       Failure_editor_name = _("Converter 1 Fail"),            Element = 67, Integrity_Treshold = 0.90, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TRS_FAIL,       Failure_name = "TRS_FAIL",       Failure_editor_name = _("Converter 2 Fail"),            Element = 68, Integrity_Treshold = 0.90, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = ENG_ALT_1_FAIL, Failure_name = "ENG_ALT_1_FAIL", Failure_editor_name = _("Engine Alternator 1 Fail"),    Element = 69, Integrity_Treshold = 0.90, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = ENG_ALT_2_FAIL, Failure_name = "ENG_ALT_2_FAIL", Failure_editor_name = _("Engine Alternator 2 Fail"),    Element = 70, Integrity_Treshold = 0.90, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = HYD_ALT_1_FAIL, Failure_name = "HYD_ALT_1_FAIL", Failure_editor_name = _("Hydraulic Alternator 1 Fail"), Element = 71, Integrity_Treshold = 0.90, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = HYD_ALT_2_FAIL, Failure_name = "HYD_ALT_2_FAIL", Failure_editor_name = _("Hydraulic Alternator 2 Fail"), Element = 72, Integrity_Treshold = 0.90, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

Events	= {"GroundPowerOn", "GroundPowerOff", "Repair"}

need_to_be_closed = true
