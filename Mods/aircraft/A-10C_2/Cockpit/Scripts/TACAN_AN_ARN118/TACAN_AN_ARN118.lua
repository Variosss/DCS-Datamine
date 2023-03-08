local gettext = require("i_18n")
_ = gettext.translate

warmupDelay 			= 85.0	-- sec
cooldownDelay 			= 180.0	-- sec

bearingMemoryDuration	= 3.0	-- sec
rangeMemoryDuration		= 15.0	-- sec

bearingAcqDuration		= 0.5	-- sec
rangeAcqDuration		= 0.5	-- sec

TACAN_FAILURE_TOTAL			= 0
TACAN_FAILURE_TRANSMITTER	= 1
TACAN_FAILURE_RECEIVER		= 2

Damage = {	{Failure = TACAN_FAILURE_TOTAL, Failure_name = "TACAN_FAILURE_TOTAL", Failure_editor_name = _("TACAN total failure"),  Element = 55, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = TACAN_FAILURE_TRANSMITTER, Failure_name = "TACAN_FAILURE_TRANSMITTER", Failure_editor_name = _("TACAN transmitter"),  Element = 1000, Integrity_Treshold = 0.8, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = TACAN_FAILURE_RECEIVER, Failure_name = "TACAN_FAILURE_RECEIVER", Failure_editor_name = _("TACAN receiver"),  Element = 1000, Integrity_Treshold = 0.9, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

need_to_be_closed = true
