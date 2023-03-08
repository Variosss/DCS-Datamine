local gettext = require("i_18n")
_ = gettext.translate

RADAR_FAILURE_TOTAL	= 0
DDD_FAILURE_TOTAL = 1

Damage = {
    {Failure = RADAR_FAILURE_TOTAL, Failure_name = "RADAR_FAILURE_TOTAL", Failure_editor_name = _("Radar total failure"), Element = 0, Integrity_Treshold = 0.25, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*350},
    {Failure = DDD_FAILURE_TOTAL, Failure_name = "DDD_FAILURE_TOTAL", Failure_editor_name = _("DDD total failure"), Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*350},
}

need_to_be_closed = true
