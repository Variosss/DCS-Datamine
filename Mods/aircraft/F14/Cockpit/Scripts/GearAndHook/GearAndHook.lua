local gettext = require("i_18n")
_ = gettext.translate

EMERGENCY_GEAR_LEVER_PULLED = 0

Damage = { {Failure = EMERGENCY_GEAR_LEVER_PULLED, Failure_name = "EMERGENCY_GEAR_LEVER_PULLED", Failure_editor_name = _("Emergency Gear Handle: Pulled"), Element = "AVX_001", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.0, work_time_to_fail = 3600*250}
}

need_to_be_closed = true