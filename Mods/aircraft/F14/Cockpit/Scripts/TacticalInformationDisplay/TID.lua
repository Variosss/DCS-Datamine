local gettext = require("i_18n")
_ = gettext.translate

TID_FAILURE_TOTAL	= 0

Damage = {
    {Failure = TID_FAILURE_TOTAL, Failure_name = "TID_FAILURE_TOTAL", Failure_editor_name = _("TID total failure"), Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*350},
}

need_to_be_closed = true
