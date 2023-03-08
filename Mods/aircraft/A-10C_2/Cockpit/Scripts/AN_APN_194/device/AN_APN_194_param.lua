local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.2

RADAR_ALTIMETR_LEFT_ANT_FAILURE		= 0
RADAR_ALTIMETR_RIGHT_ANT_FAILURE	= 1
Damage = {	{Failure = RADAR_ALTIMETR_LEFT_ANT_FAILURE, Failure_name =  "RADAR_ALTIMETR_LEFT_ANT_FAILURE", Failure_editor_name = _("Radar Altim left antenna"),  Element = 39, Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = RADAR_ALTIMETR_RIGHT_ANT_FAILURE, Failure_name =  "RADAR_ALTIMETR_RIGHT_ANT_FAILURE", Failure_editor_name = _("Radar Altim right antenna"),  Element = 40, Integrity_Treshold = 0.3}}

need_to_be_closed = true -- close lua state after initialization 