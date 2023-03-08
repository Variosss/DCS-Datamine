local gettext = require("i_18n")
_ = gettext.translate
GUI = {
	interphone = {
		interphone = true,
		displayName = _("ICS")
	}
}

ICS_FAILURE_AMPLIFIER_PILOT_NORM = 0
ICS_FAILURE_AMPLIFIER_PILOT_BU = 1
ICS_FAILURE_AMPLIFIER_RIO_NORM = 2
ICS_FAILURE_AMPLIFIER_RIO_BU = 3
KY_28_FAILURE_TOTAL = 4

Damage = { {Failure = ICS_FAILURE_AMPLIFIER_PILOT_NORM, Failure_name = "ICS_FAILURE_AMPLIFIER_PILOT_NORM", Failure_editor_name = _("ICS: Amplifier Pilot"), Element = "AVX_WALL_LEFT_FRONT", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*150},
   {Failure = ICS_FAILURE_AMPLIFIER_PILOT_BU, Failure_name ="ICS_FAILURE_AMPLIFIER_PILOT_BU", Failure_editor_name = _("ICS: Amplifier Pilot Backup"), Element = "AVX_WALL_LEFT_FRONT", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*150},
   {Failure = ICS_FAILURE_AMPLIFIER_RIO_NORM, Failure_name = "ICS_FAILURE_AMPLIFIER_RIO_NORM", Failure_editor_name = _("ICS: Amplifier RIO"), Element = "AVX_WALL_RIGHT_REAR", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*150},
   {Failure = ICS_FAILURE_AMPLIFIER_RIO_BU, Failure_name = "ICS_FAILURE_AMPLIFIER_RIO_BU", Failure_editor_name = _("ICS: Amplifier RIO Backup"), Element = "AVX_WALL_RIGHT_REAR", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*150},
}

need_to_be_closed = true