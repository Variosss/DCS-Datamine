local gettext = require("i_18n")
_ = gettext.translate

VDI_FAILURE_TOTAL	= 0

Damage = {
    {Failure = VDI_FAILURE_TOTAL, Failure_name = "VDI_FAILURE_TOTAL", Failure_editor_name = _("VDI total failure"), Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*350},
}

need_to_be_closed = true
