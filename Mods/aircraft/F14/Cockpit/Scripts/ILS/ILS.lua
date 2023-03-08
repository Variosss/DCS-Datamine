local gettext = require("i_18n")
_ = gettext.translate

ILS_FAILURE_TOTAL			= 0
ILS_FAILURE_DECODER			= 1
ILS_FAILURE_ANTENNA			= 2
	
Damage = {	{Failure = ILS_FAILURE_TOTAL, Failure_name = "ILS_FAILURE_TOTAL", Failure_editor_name = _("ILS: Total"),  Element = "AVX_WALL_LEFT_REAR", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
		{Failure = ILS_FAILURE_DECODER, Failure_name = "ILS_FAILURE_DECODER", Failure_editor_name = _("ILS: Decoder"),  Element = "AVX_WALL_LEFT_REAR", Integrity_Treshold = 0.25, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
		{Failure = ILS_FAILURE_ANTENNA, Failure_name = "ILS_FAILURE_ANTENNA", Failure_editor_name = _("ILS: Antenna"),  Element = "TCS", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250}}

need_to_be_closed = true