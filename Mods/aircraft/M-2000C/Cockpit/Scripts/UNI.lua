local gettext = require("i_18n")
_ = gettext.translate

INS_PART_FAIL  = 1
INS_GYROS_FAIL = 2
INS_TOTAL_FAIL = 3

Damage = {	
	{Failure = INS_PART_FAIL,  Failure_name = "INS_PART_FAIL",  Failure_editor_name = _("INS Partial Failure"),   Element = 87, Integrity_Treshold = 0.45, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = INS_GYROS_FAIL, Failure_name = "INS_GYROS_FAIL", Failure_editor_name = _("INS Gyroscope Failure"), Element = 87, Integrity_Treshold = 0.40, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = INS_TOTAL_FAIL, Failure_name = "INS_TOTAL_FAIL", Failure_editor_name = _("INS Total Failure"),     Element = 87, Integrity_Treshold = 0.35, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true
