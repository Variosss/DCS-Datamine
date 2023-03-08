local gettext = require("i_18n")
_ = gettext.translate

takeoffTrim = {-12.0, -4.0}

PaTrimMode = 1				-- 0 - old, 1 - slow old, 2 - new

need_to_be_closed = true

-- Failures
FAILURE_CHANNEL_1	= 0
FAILURE_CHANNEL_2	= 1
FAILURE_CHANNEL_3	= 2
FAILURE_CHANNEL_4	= 3

Damage = {	
	{Failure = FAILURE_CHANNEL_1,	Failure_name = "Failure_Ctrl_FCS_Ch1",	Failure_editor_name = _("FCS Channel 1 FAILURE"),	Element = 5,	Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = FAILURE_CHANNEL_2,	Failure_name = "Failure_Ctrl_FCS_Ch2",	Failure_editor_name = _("FCS Channel 2 FAILURE"),	Element = 5,	Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = FAILURE_CHANNEL_3,	Failure_name = "Failure_Ctrl_FCS_Ch3",	Failure_editor_name = _("FCS Channel 3 FAILURE"),	Element = 5,	Integrity_Treshold = 0.6, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = FAILURE_CHANNEL_4,	Failure_name = "Failure_Ctrl_FCS_Ch4",	Failure_editor_name = _("FCS Channel 4 FAILURE"),	Element = 5,	Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}