local gettext = require("i_18n")
_ = gettext.translate

INS_FAILURE_TOTAL = 0
INS_FAILURE_NAV_COMPUTER = 1

Damage = { {Failure = INS_FAILURE_TOTAL, Failure_name = "INS_FAILURE_TOTAL", Failure_editor_name = _("INS: Total"), Element = "AVX_002", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*1000},
   {Failure = INS_FAILURE_NAV_COMPUTER, Failure_name ="INS_FAILURE_NAV_COMPUTER", Failure_editor_name = _("INS: Nav Computer"), Element = "AVX_002", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*100},
}

need_to_be_closed = true