local gettext = require("i_18n")
_ = gettext.translate

INCAPACITATED	= 0

Damage = {
    {Failure = INCAPACITATED, Failure_name = "JESTER", Failure_editor_name = _('Jester: Incapacitated'), Element = 91, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*350}
}

need_to_be_closed = true
